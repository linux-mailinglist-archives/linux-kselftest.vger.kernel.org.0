Return-Path: <linux-kselftest+bounces-44330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481EC1C51B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5163D188B962
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41433B6E5;
	Wed, 29 Oct 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkVG195N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF382E92A3;
	Wed, 29 Oct 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757142; cv=none; b=P/+dyfd1upwwn+wrfni1CgX0E1gtp0BU6y3/WX5qHD0yq9vpif8tNu/ngi+UN2VaJo2EA6VoaT3jbpJRb/D8t9MUvbyUjRoUT+7Np4jOg8gJwxSSDZFv/wdE/lN5rEVpjzqsRwLGmqqZcS8rqGUCp85m8tg9BUyFHFvSTTd88n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757142; c=relaxed/simple;
	bh=u7JL73WEYd6ERmhJ3D+IDILnoF8DaZzfbL0v+3g5Bq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQztByYmnEosVMbyWTZH4G7kFYxsd23QHWwSzWY25ZeQajpxZ+rCfSBPlmySua/8V9iATmuKodvrX44H5hFq7ZZQeAR/u52uGXMSuYJkWmnmNzkhfcwQUl8LrF3iohy0o1tIba9Q3Lknd5fl3H+tHB1DjhyhOU6sGdCVPCRGjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkVG195N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C406EC4CEF7;
	Wed, 29 Oct 2025 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757140;
	bh=u7JL73WEYd6ERmhJ3D+IDILnoF8DaZzfbL0v+3g5Bq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkVG195Nbcnv1hIbCaCNw0APxUUbifnb35ndDLCkDA12Rl8N4G256v20Cij3pFy5K
	 9stQkqO8dXcHRAwSA/MwIj6SKbwzUvlobkW5Ae7Cw4edhiJDr1yJanPldUG/CEi77f
	 hy8Zveutja6gDYce/RAocR/nEvfbVytIeIGKCYK/4E6tgm0Q6yo4NVk+D9bgPg38EK
	 XK8KT1FNh69KnjmuKMeWwm3Ad06A7PYV6+5yGZEETCVbOsPlmzHWCyDXTn6kOQVb+t
	 zhmUHCynkTZRME8DrXDHvI62m42Pz1+bxEa9CPbmpG0f9NT2D1WmUIx5xD4nKng5JK
	 qLZUtjCLbcH4A==
Date: Wed, 29 Oct 2025 16:58:56 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Message-ID: <aQJH0D2BGGo6F_s_@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-5-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-5-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:09PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> If QEMU fails to boot, then set the returncode (via timeout) instead of
> unconditionally dying. This is in preparation for tests that expect QEMU
> to fail to boot. In that case, we just want to know if the boot failed
> or not so we can test the pass/fail criteria, and continue executing the
> next test.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


