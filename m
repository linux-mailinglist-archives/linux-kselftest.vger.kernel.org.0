Return-Path: <linux-kselftest+bounces-19257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB632995725
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 20:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277A8B20C3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FD212D2E;
	Tue,  8 Oct 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo9UT/hS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD5212654;
	Tue,  8 Oct 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413490; cv=none; b=JzxVAdLTuLn9Lfi2RyhYWf8I3ERCcjLDrDzSNGu+294uAi1OEfJEW4mhxyPp9+DB3lD8CxxoIz2zZAs0ba73xM9hPbr5ZI/1f+1YjKvJSLDI75m6RSLUMJwj8Dt33ozy2xOOcja4F78L9yJCSLbE+cX0KRQtgOZQOuDTVDrVzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413490; c=relaxed/simple;
	bh=bvXd7/Ofy4U3reurmuusRZXfA3U3m3e6EuBmRjjCKCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaT2oNlQibzyb1fmqIM/wtFBmjnca+yUpjgQ1Ef+zxHoOgdhunu/VlyNSRVbJLrQR0Khi59LIL1c7uOR2Ryidjk4HB7/Qbf1S1475cQjjvUp73iR3Ha8h2ezNiFw1Da83/us+2cQIK4F6yAiOLtSxVMVfHnADBIV+N0pimugI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo9UT/hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EC7C4CEC7;
	Tue,  8 Oct 2024 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728413489;
	bh=bvXd7/Ofy4U3reurmuusRZXfA3U3m3e6EuBmRjjCKCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lo9UT/hSP5w9pBuppPXczkaUvjSl0eekGcfRTAGQXjk1j4dV1gScAsg/EEr5c+PHS
	 QuFBs1CsF5urGos1AMaVkDv3bD+qdPWG3+0VLRtzQWgOxpJspYO8hiNS3avZ37DSLv
	 XRknnggluneT+oqiDdEwv8gijmEwzM/bYfuV0JBJ/C2IkyU9IMjkCqJW6BADdJsafV
	 lzxWW2c5d/pATD2sf9qMrXgWbUvDcwXVkfXRDnRNkNvvogVV510aSXU8mjYOsCpqLX
	 1kLrFBKhrgz5scB2XO4ez/N+kFWyIe+XWkj+3V9/MlNO7GHK6dFalS5LZVzrTfq2cn
	 QLkIx24M5lXAw==
Date: Tue, 8 Oct 2024 08:51:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
	linux-kernel@vger.org, linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com, shuah@kernel.org
Subject: Re: [PATCH v4 0/2] Exposing nice CPU usage to userspace
Message-ID: <ZwV_MGCQZoAXYBiN@slm.duckdns.org>
References: <20241002184717.153302-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002184717.153302-1-joshua.hahnjy@gmail.com>

On Wed, Oct 02, 2024 at 11:47:15AM -0700, Joshua Hahn wrote:
> Changes in v4
> 	- Removed unnecessary forking from selftest.
> 	- Style changes in rstat.c (fallthrough & indents)
> 	- Fixed a selftest bug that raised false negatives, caused by
> 		cputime_adjust sometimes adjusting utime below ntime.
> 	- Reworded cover letter for clarity & motivation
> Changes in v3
> 	- Signed-off-by & renamed subject for clarity.
> Changes in v2
> 	- Edited commit messages for clarity.

Applied to cgroup/for-6.13. If there are issues, let's iterate in tree.

Thanks.

-- 
tejun

