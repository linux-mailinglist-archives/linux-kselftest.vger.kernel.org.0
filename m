Return-Path: <linux-kselftest+bounces-46741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C570C94A30
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 02:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97767346DFE
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 01:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C2620FAA4;
	Sun, 30 Nov 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8fDtxvC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EF36D508;
	Sun, 30 Nov 2025 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764466895; cv=none; b=uCxHFIEKOAM8QxXcXSMKAqbAnxudg4CvgboHOTZnqo0ag/VMDbciathNxQ3IUQEolyaycssbKWSVqMBbGOhuBKtadBis+gloYm7dD3dhuuGEDMFHt+JgktEqOhjyndHjUIJR/iUnYitsxMHOu33xYjfMbalxVhVr/yI3CCaaL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764466895; c=relaxed/simple;
	bh=9j57zVcaHg17tyaBJh/yVVESsg+3+MK5o+L7M9AdjdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtaoQP1YCuB9OiwBtLSBBA41U3YVfbFfXLeIL6aGDDPQ7/xd3Vsp3qSTmKDdTe1VxGfYdlBr7n/x9gWCSXNeeL4ZZus6IDvFcvZYR+HHQJWMjqzgU+eNKOy5o7PlnoQSOIR2W8rP2SBo7b3k69LukMuXONvhdlVMc1y1UlSsRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8fDtxvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64999C4CEF7;
	Sun, 30 Nov 2025 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764466894;
	bh=9j57zVcaHg17tyaBJh/yVVESsg+3+MK5o+L7M9AdjdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8fDtxvCGP+ZKgEn1KKUfItRs9zUAG6rZhS3hW8nIaJWkrvoA0gLTTZL70ijt2UFd
	 N9z11nGtKlvCFUxRtxZGgsBOyQkt2mJpMjrNuu17aJ1qsUgN9gdL+Ei94ZREbIjmla
	 85S3gDEfqLxDw1J5fHoDMmwjqt4nv0tPaKrORNepd9IySgS3lT4IOyPQIhJd75uvON
	 VLEetaYW8bG6fKjWeu5GTu+VfavjROx2MrRLiA7PZFWv0to2HiuC6FpARe7pR/nph3
	 dwnalMSHEZoRVwLJkOcUEaeYKfcVj2+U3RdmXtP9wJdK6z1dUeZV0zq2VjlBW8dwQW
	 oZd9g6vApv86w==
Date: Sat, 29 Nov 2025 17:41:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Message-ID: <20251129174133.0e369f80@kernel.org>
In-Reply-To: <632d57cf-becd-4d09-bb21-0e3db6776c49@kernel.org>
References: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
	<632d57cf-becd-4d09-bb21-0e3db6776c49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 19:13:08 +0100 Matthieu Baerts wrote:
> > +$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
> > +$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
> > +$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include  

I believe this is being added via MM or kselftest tree at level of the
main ksft makefile. Since this is a false positive, maybe let's defer
fixing the issue until after the merge window? When the -I.. flag
will be implicitly in place?

