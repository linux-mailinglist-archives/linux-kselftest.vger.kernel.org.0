Return-Path: <linux-kselftest+bounces-44329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472FC1C542
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3F94EE19B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D8C309F07;
	Wed, 29 Oct 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPRjma+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA6170A11;
	Wed, 29 Oct 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757090; cv=none; b=NPPUNuW7yGl3p4lpc3v262qyK0WPWXmD+apsxlOR3KQpZKqzPiS3fNW8D0qTIsL+tFJgYH/FxZfUztj3R/qBtkk/G/L+O6fpyBYumLPSUJf8Yn5pvNEOYHAxH7+SjE3GobzUZSfk7xSWsIPvXJIwS8RTGTV1GdnFzsJ6MRPLfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757090; c=relaxed/simple;
	bh=TWRhxQ6lLOpfdDuv/vN7QnMJztCMDUTiyAp9KaEX3MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+KNxlbgE8BvlbjBIdEG5A0IOP3wsCoTUm3dmv6DnyoKii3ZV6L0fZO+LCtMh54ZGBoYs8ipqkFpvbPkldEhBZVXPJylkU31PSLVOE7eyb1xlFuvJ4AfXHS9Lsp/qZ3yW892IiGFmwgCmVbbsCD0fftRpN7YM4JaG4f2TY+lOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPRjma+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCCC4CEF7;
	Wed, 29 Oct 2025 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757089;
	bh=TWRhxQ6lLOpfdDuv/vN7QnMJztCMDUTiyAp9KaEX3MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPRjma+GbaSR8xxoPG4M5GtfQYWCs9dVLJIGyaSTpNLs6caBPK/BOLahoKjgzrXP9
	 rSO44cmdo+YORxkEk8ynAp9OnBsxnRTH4RLvK8bwvpr9pZVyfIU0VnHSZFkSNLXlms
	 0lM/2smK3AtJhaBAR6+DbKNvn1NBqGPvR64LwdkUZMEZJlv0TjezC4vuRappIJhnPf
	 Z1SkG2jerGOlckV3zGLVD5Cy6tSwdM7M91RsgCsoghKkFIF/M5oMB+XzcbWACbceXp
	 /MKFl1L6TyRKjbwbmGno/Kf81wyPAnZwzz0QVOIbOj9XjL/u9cJXaM1jJXCNEQ0PpW
	 nzClTroBsH2Ew==
Date: Wed, 29 Oct 2025 16:58:05 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQJHnfsWll7Di-V0@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>

On Mon, Oct 27, 2025 at 12:08:48PM -0700, Bobby Eshleman wrote:
> On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > > such as waiting for the server to reach listening state and
> > > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > > from hiding failures.
> > > > 
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > 
> > > shellcheck has some (new) things to say about this patch too.
> > > Could you take a look over them?
> > > 
> > > ...
> > 
> 
> It looks like the errors are SC2317 and SC2119, but are false-positives.
> Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> being passed zero arguments (logging its stdin instead).

Sorry about that, I thought I saw something meaningful in there.
I guess I was mistaken.

> 
> I also see that SC2317 has many other false positives elsewhere in the
> file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
> unreachable. I wonder if we should add a patch to this series to disable
> this check at the file-level?
> 
> Best,
> Bobby
> 

