Return-Path: <linux-kselftest+bounces-3958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65632846450
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90AC1F240B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12147A7A;
	Thu,  1 Feb 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaZk5H0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCD45BE0;
	Thu,  1 Feb 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829114; cv=none; b=S/MjfnltNM2BydHeNjL8LaXLQrmVQIPWw2Ccdr8P4nNH+FxyR+RLaOzXwvKLbfZwrHCePlkRiVaMNgD6+VtsELMfdYy1Oqpnkzz+waHZQoRBkIaguQLwEkG9Xi3WRa0Fe+rJOLczKDtDQRzFlzgP2xTc2qLTcKcSGMoiFTQFs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829114; c=relaxed/simple;
	bh=bBckTHlnwRsnRIxBqMozm+cZDPwPFIOZVqpGpVOkEzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcBrmwg69kZqw/LqFzd058CIySY5MLZpc+cSi8AnW06gD+dwnlrF93taTwzQMZXkvtXHyx9QuLVMpnALITbYdBXHLDzndFFMg9H7O0wM0K/Ok9DhAip3La41JhNOODm+Op/ijcxT6FF5aZwhVLfucvc2kP6S/0GqGZMWBxWDf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaZk5H0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7286C433F1;
	Thu,  1 Feb 2024 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706829113;
	bh=bBckTHlnwRsnRIxBqMozm+cZDPwPFIOZVqpGpVOkEzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaZk5H0/y6XdJGc4OBWVBMIwflsWjW30D87R9aF2R5qDGHmZ/z2we5N4MzBIrJFgF
	 R5GBGDR7lW9s/UVvZTQHUc9QyeySw8JS0MWMOrhJ+bDJqL0JmCbZTjrvJtYd5aCjcd
	 LUgGf5meauGwQZQApm1WH74dN3nvnP6W7aRWRpiJhDPnDtiz2hSWL5OpiznHQ37nbD
	 wYSckxDrnb7zqrVkPiu0NQDmKVE4SX9JiW622OqGZo950/xIyea3UlNhRV3yV+IVys
	 dUsQEy9ROIZvqV2QYJDHIHr68kP9FTz4s5ngo9FPRnrWcTwu/zV4MPxWJuAMEqWaPK
	 DULEFWyzhXJgQ==
Date: Thu, 1 Feb 2024 15:11:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	sroettger@google.com, willy@infradead.org,
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
Message-ID: <20240201231151.GA41472@sol.localdomain>
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131175027.3287009-3-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131175027.3287009-3-jeffxu@chromium.org>

On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> [PATCH v8 2/4] mseal: add mseal syscall
[...]
> +/*
> + * The PROT_SEAL defines memory sealing in the prot argument of mmap().
> + */
> +#define PROT_SEAL	0x04000000	/* _BITUL(26) */
> +
>  /* 0x01 - 0x03 are defined in linux/mman.h */
>  #define MAP_TYPE	0x0f		/* Mask for type of mapping */
>  #define MAP_FIXED	0x10		/* Interpret addr exactly */
> @@ -33,6 +38,9 @@
>  #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
>  
> +/* map is sealable */
> +#define MAP_SEALABLE	0x8000000	/* _BITUL(27) */

IMO this patch is misleading, as it claims to just be adding a new syscall, but
it actually adds three new UAPIs, only one of which is the new syscall.  The
other two new UAPIs are new flags to the mmap syscall.

Based on recent discussions, it seems the usefulness of the new mmap flags has
not yet been established.  Note also that there are only a limited number of
mmap flags remaining, so we should be careful about allocating them.

Therefore, why not start by just adding the mseal syscall, without the new mmap
flags alongside it?

I'll also note that the existing PROT_* flags seem to be conventionally used for
the CPU page protections, as opposed to kernel-specific properties of the VMA
object.  As such, PROT_SEAL feels a bit out of place anyway.  If it's added at
all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure this aspect has
been properly discussed yet, seeing as the patchset is presented as just adding
sys_mseal().  Some reviewers may not have noticed or considered the new flags.

- Eric

