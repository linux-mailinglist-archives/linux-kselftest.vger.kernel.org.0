Return-Path: <linux-kselftest+bounces-44332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBB4C1C533
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77710188EE9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCB33F39D;
	Wed, 29 Oct 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdEjO0k5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6E239573;
	Wed, 29 Oct 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757177; cv=none; b=vDFMhtvGnef7szen/ovhkyuUo2ojcDDap6W9SNN2S+JgYX6/gJXER7PsFf+4LX0UsGyCdz/qu+6OsOELiXUVNGepiJaCZVGz/Xzr/lsmUFel9A0R2RoiJoQBygawRZvXpM9d5z2G+DqMTMMR9YMc1mkAS2STQ2t9nMPDOOOv7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757177; c=relaxed/simple;
	bh=BVmq7Yd2iipXdJRjyhNkxYVkgci3lZcF/mIljGLYNR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNIkNhIaKDfxASuMNuVEvAK6yjOgueME5GK7o0ov5QwBOi+QJ5AegYJKP7ce+ruSRfsC+Wt9QGpZ+2ASzm2gLyX597YH0THyLv/5kykQHm2o5VYVPn7QrE8nfoe2845U18YP23oHjTvR7LVKijfeErM5jRegfNACmVJgCcEysL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdEjO0k5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C991C4CEFB;
	Wed, 29 Oct 2025 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761757176;
	bh=BVmq7Yd2iipXdJRjyhNkxYVkgci3lZcF/mIljGLYNR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdEjO0k5oHl3tit3RGI4KJOCyZaQ58He42FfyVRcdL1AQmWJijQ9vpqhQIQNxcTSY
	 H4dzh6DG1GYkQUFvogdmENPQsrTBdSBwcKzrBEntXDye7VqtAWwHXvf29yz/OGEo45
	 aravo/4cK+NhTWhTuzrVsg8s+bEChl3DrLj2/GHyGGhYYj6r+QRKhM/62AFsHQXaYP
	 nxPF1Uy27MgVXgbmDcxWp+qQ0kq/65qPunSgm8aD9CcD44xgZnqmeF7MNZbfXT1Y9C
	 1LBV5ABH/taaieegBKIfP5l3ctt6TRZOzqIKOLW1nR2UD6qRhPspsh1t+DFBD+8vLI
	 rxKa6mHK8880A==
Date: Wed, 29 Oct 2025 16:59:32 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Message-ID: <aQJH9GLfQLZZdavN@horms.kernel.org>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-7-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-7-edeb179d6463@meta.com>

On Wed, Oct 22, 2025 at 06:00:11PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add check_result() function to reuse logic for incrementing the
> pass/fail counters. This function will get used by different callers as
> we add different types of tests in future patches (namely, namespace and
> non-namespace tests will be called at different places, and re-use this
> function).
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Simon Horman <horms@kernel.org>


