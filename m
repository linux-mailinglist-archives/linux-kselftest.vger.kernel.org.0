Return-Path: <linux-kselftest+bounces-46408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8EFC83225
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E834B703
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DC19D092;
	Tue, 25 Nov 2025 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpSz7ncO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077431A295;
	Tue, 25 Nov 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038977; cv=none; b=eeuu+MPvYPOv2HACbMykDsC2ChL7+CH+1L5dXdDRmhYz1EHCXBP4Ia6VNFOVTClXawdW15s8Ezr6jMqs/YNblkXMPlxLsEaRu6z6MhVeT9BhtvEPeu8DoYY0TIOh2YzyGFQ8j+B1w0PIFhtCGWDcRcyzAQ9rBQc0Zf+y3n+thRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038977; c=relaxed/simple;
	bh=aQMq1HTfzbqqDNq85zDNzwztVfRbyKNQRIJr8AGkkYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkBHqBxa2dGcIqFzl9djV26W7/5cn+OHx2sa8BG4eGh8F33/ZBIalaaNCbroRolV1T5CEzUxJwbBGtlZk+BFxkLsGeiE3Dlaxy4kgkPdPtX5Icz0MuNFgP+1Bi19KqrhPXIfubPZ0TEjMZnCN6dOOP2dv+lFw726zfRlXGX5R5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpSz7ncO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF48C116C6;
	Tue, 25 Nov 2025 02:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764038976;
	bh=aQMq1HTfzbqqDNq85zDNzwztVfRbyKNQRIJr8AGkkYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZpSz7ncO52vz+IVE91r+VNKoc6DFG/YRn9jmavAN3OLZNgaohsoS/DndJ5GQS233y
	 QvH/Te3234VjcJaLZuYt5hc3t/4aOyKONrH/OHYYdFqT9FSuSmWvVQND9npgXvrs8C
	 okuZNIpPBP6miaKGU4CxLwqELT4jUBQP7/IopYu1AePiulcQRY/6kvaD6YgsaPNgQV
	 GZS2/lsEVP/OSn0HJFC01CWEYCOwSMPuwTwh0XWWiNc47RFmZqV4/BlwiDwh3HRBtt
	 HwTV2hAXbj6rQW+Tb+9UOBNPZZY5hmPvfQxgoXNlkVqAyCvf2v7crvkirlJFIPz6+g
	 0PL1nMYgVPTFA==
Date: Mon, 24 Nov 2025 18:49:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, petrm@nvidia.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] selftests: hw-net: auto-disable building
 the iouring C code
Message-ID: <20251124184935.6c4ceb3d@kernel.org>
In-Reply-To: <c8876216-c37d-4d7d-9301-b051273e69b0@davidwei.uk>
References: <20251121040259.3647749-1-kuba@kernel.org>
	<20251121040259.3647749-2-kuba@kernel.org>
	<c8876216-c37d-4d7d-9301-b051273e69b0@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 16:55:05 -0800 David Wei wrote:
> > +# Check if io_uring supports zero-copy receive
> > +HAS_IOURING_ZCRX := $(shell \
> > +	echo -e '#include <liburing.h>\n' \
> > +	     'void *func = (void *)io_uring_register_ifq;\n' \
> > +	     'int main() {return 0;}' | \
> > +	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
> > +
> > +ifeq ($(HAS_IOURING_ZCRX),y)
> > +COND_GEN_FILES += iou-zcrx
> > +else
> > +$(warning excluding iouring tests, liburing not installed or too old)  
> 
> Would you want to mention the min ver needed (2.10)?

I think people would update to latest upstream if they update?
I suspect we'll have to update this check if new dependencies
come up, the version will become stale..

