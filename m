Return-Path: <linux-kselftest+bounces-44132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B9C0FBCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFE064E2531
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6B03191D5;
	Mon, 27 Oct 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JttcTmr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FE3191C6;
	Mon, 27 Oct 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587108; cv=none; b=lPNfzuJM7zmj3CjlKpkTSnRIZk1fVmGhJsWnFWLIfQUGmnWc5cn1rkOAj2zxFWDMHH8GnnAwlGNqiKUZrsIe/1BABWMMhludjTxGAAKmfUGCOYmFLwfCmp8mUxYXx0dH5+N0hOrQ1Nz1etU0G5ArN/Vua67kyjw4qVveAB7khTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587108; c=relaxed/simple;
	bh=NWEXKXz2vEy8waTgkm17FAAos0fLHKsZSP4LsWRCesU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI59+Q87LL5PTs+dqi5BnpVVhRbx6wudspX9gW0CxuRaxjuNspKru0EMugykzcM5bMDFnPdG1yZay1i89YrVDRAedc/dvcDaHOHyH53PNOGMrk9o7X1Qmr/4r0XVVzVqnghSpAEtdPUF0WrvErX+FYwU6EnS76m/l+GEp/edfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JttcTmr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EEAC4CEF1;
	Mon, 27 Oct 2025 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587108;
	bh=NWEXKXz2vEy8waTgkm17FAAos0fLHKsZSP4LsWRCesU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JttcTmr3+oOdFn75ULd9fw8jo/LvERiDwJBnM2xxLnK0W3Zw/c6b4sT2lBA7ejZPm
	 H+aPlt9XAWSVJtvC4Mq0dW4Ho2PpMCg5vULPfnpRHQTn/R6e4B93Iy9fCs/uFVMGdJ
	 WZL0fMNXxw+cNICz+btSd6JJYE0x12m9hCMn0e/C78eHWAEZRH79cyXQVRMbFeG3Kf
	 WY0iLi3txVR6pU/xBUP5NzCB2ijCnnVtihASPdprfO8oK38nEIuC492oylH8seA8j8
	 sO3YqfL6/slyBFOO95k3R66VzIZHX3BtAFItQBwLXN0iJTv0PShb96a1zfKtMaKieY
	 3zcCzBWMQiJYQ==
Date: Mon, 27 Oct 2025 17:45:03 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 09/12] selftests/vsock: add BUILD=0 definition
Message-ID: <aP-vn8opteOTvlTh@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:13PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add the definition for BUILD and initialize it to zero. This avoids
> 'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
> set to 1 and is later checked for its value.
> 
> Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Hi Bobby,

I think that if this is a fix for the cited commit,
which is present in net, then this patch should
be targeted at net rather than net-next.

...

