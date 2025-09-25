Return-Path: <linux-kselftest+bounces-42363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB19BA0A33
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B97C620E5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97034306D26;
	Thu, 25 Sep 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TNNGcmYA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4A2DE710;
	Thu, 25 Sep 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818202; cv=none; b=CRyAZQbNMRZXvkECdAy5KhxoAEFBNkNxs2QAqrliWECjGlwQeW3FlS0bgvwAmWrbeDAV88fWz3hr6Odt2xCV21GmH8HzSpFV7qQ7cpuQ6OSgaXZ2uHlSsAQ+PjSekgz8waLoupl/37yi6okGwBEJtdJ+Wr+7O56+6TqR174H5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818202; c=relaxed/simple;
	bh=X4SLgLUDA6ZIyS057+iCcCJ7hLdHj/NTyAmnioiy+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttcM+ZK2RyOjk8rtME21kSkZXZgNk3o13ffu0P+ml0R4ep9XC1skOSdIPOJiXKpJ1YA8JgQvTiYiZ+5HGtiPBtOyx0xgEqH28CWjiF7OEgaUm4IBuxjKKXTvHtZ0ZwoX77e2BxN9WIc6CCkCeffcE3TA/Q+6N7Ecvg1xHSikyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TNNGcmYA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758818198;
	bh=X4SLgLUDA6ZIyS057+iCcCJ7hLdHj/NTyAmnioiy+M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNNGcmYApRO0f5DE3mdIWcAap4G5OZH5QAW1crAKc/89M+09k74DP/7CDM6RSBwTv
	 PE/Ry6Qty4WYk9+QabThhZldMiPwLrO8BNt56Fd5NDMhidm+tYiPQofMvQezTTKErT
	 ZN9hvBfiqOMZOS6/zGuvB2bFeAuR1sxNKULAQpyI=
Date: Thu, 25 Sep 2025 18:36:36 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 08/12] um: add infrastructure to build files using
 nolibc
Message-ID: <43a71f2c-2d3d-4b66-b755-d182eefc90d2@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-9-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924142059.527768-9-benjamin@sipsolutions.net>

On 2025-09-24 16:20:55+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
> than libc. With this it is possible to move to nolibc in smaller steps.
> 
> Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
> simple and cannot handle threading. nolibc provides sys_* functions that
> do not emulate the libc errno behaviour and can be used instead.
> 
> Leave the syscall definition for kernel code for now, but guard it as it
> is a macro in nolibc.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> v3:
> - Change the syscall guard to use __KERNEL__
> 
> v2:
> - Do not include nolibc.h via CFLAGS
> - Make syscall guard more explicit
> - Remove __UM_NOLIBC__ define, it is not needed
> - Fix out-of-tree building
> ---
>  arch/um/Makefile               | 20 +++++++++++++++++++-
>  arch/um/include/shared/os.h    |  2 ++
>  arch/um/include/shared/user.h  |  1 -
>  arch/um/scripts/Makefile.rules |  8 +++++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index f7c509262568..c3a81df50911 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -78,6 +78,24 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>  		-include $(srctree)/include/linux/kern_levels.h \
>  		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
>  
> +NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
> +		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
> +		-I $(srctree)/tools/include \
> +		-D__EXPORTED_HEADERS__ \
> +		-D__UM_HOST__ \
> +		-DNOLIBC_NO_RUNTIME \
> +		-DNOLIBC_IGNORE_ERRNO \
> +		-nostdlib -nostdinc -static \
> +		-I$(srctree)/include/uapi \
> +		-I$(srctree)/$(HOST_DIR)/include/uapi \
> +		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
> +		-I $(srctree)/tools/include/nolibc \
> +		-I $(srctree)/usr/include \

This looks incorrect. The UAPI headers would be installed to $(objtree).
But UML does not even use CONFIG_HEADERS_INSTALL.
Also the whitespace is inconsistent between different lines.

> +		-include $(objtree)/include/generated/autoconf.h \
> +		-include $(srctree)/tools/include/linux/kconfig.h \
> +		-include $(srctree)/include/linux/kern_levels.h \
> +		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
>  
> @@ -160,4 +178,4 @@ archclean:
>  		-o -name '*.gcov' \) -type f -print | xargs rm -f
>  	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
>  
> -export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
> +export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH

(...)

