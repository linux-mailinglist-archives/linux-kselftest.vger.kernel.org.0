Return-Path: <linux-kselftest+bounces-44336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458ABC1C57E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629501894FA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C83451A6;
	Wed, 29 Oct 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu711m+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827D325487;
	Wed, 29 Oct 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757279; cv=none; b=JbnyLluT18lGdgCIGV53M005SrQycHhbNMlccVVt3/3wH7vcl9xqxVKrhXsO8wotYVT/JEEY9uDw5jailcgzpvTmy6J891KlfIxOnVW7fPWVEdijOxqGpVd7xL6wloOuAeUm4tYnqm05uvSqXzyoIt5l8/wlOrmSfFZrwYlhHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757279; c=relaxed/simple;
	bh=k3byeLcVOKPHdmvu7ueh69faz2jI7pjQAcxa1p62ckY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYscKOPLVZRVjOwfFqWV9kl/mRrhbE9uY6GYBXKWifYOFmB4W5wQ7wZZxTI0303pVXGXIoxvPpSUe79sVcVQPsz++8FdygBKNrJzOwPdV+dY6aLOq2frSf/Pfjf0/EDMQbv7iGsMzMDhY3XzVcbjSqjdT6tMOsBYI36k0UjORnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu711m+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F967C4CEF7;
	Wed, 29 Oct 2025 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757279;
	bh=k3byeLcVOKPHdmvu7ueh69faz2jI7pjQAcxa1p62ckY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zu711m+N+fJ2KQqcxeqOJBhzhogcWZmD4nMAZA+88M/KFM28pAQqKcu2AtrSy8BT+
	 jNJNmsB/B9Y26Hrgre1Mjnz49nNFeLd1VGEofroOCL/kqWnU+mCDWIX5IKBhlpe8Nu
	 ra0GlDEBBAVG8oP4OROkxuPsTtmgIPPdhCXSslS4u35Ja7vRPosno3YdcARqYs3LHg
	 hw3lMOLWyTjmvbQWW3qcIGyyPIIC8tEmCiSPRrrWdJQ4BEirpECcHtan18y8QIU4K/
	 eeixI3DeWwWRkSGldGIRPSDh5qs/SCRiIo+9xYfXQIRQmgPPI24+K3RtMsvVQiiAt8
	 m4UlkIMd/42EQ==
Date: Wed, 29 Oct 2025 17:01:15 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 11/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <aQJIW9ooMiAHZ6Np@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:15PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Testing with 1.37 shows all tests passing but emits the warning:
> 
> warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
> 	The following versions have been tested: 1.33 1.36
> 
> This patch adds 1.37 to the virtme-ng versions to get rid of the above
> warning.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


