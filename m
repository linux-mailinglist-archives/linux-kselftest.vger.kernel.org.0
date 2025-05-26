Return-Path: <linux-kselftest+bounces-33793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08753AC4134
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4954C189A659
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58720B804;
	Mon, 26 May 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dhZ+8xVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C187202C31
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269205; cv=none; b=s5lyTBOvtgGiAxrJFe5ArQ6VI8zkjZ4ATEPrF41GYrGCeC0fTA5ph42OgXnyXDdUSGTGLSlGy40L8UdBT5kRenIVQ6c7wJPcNvvjWLDX8FVhyAjwj+2Mv6FOnVmYdI13Hk3rUBWDw9WR4GOaxigS8rIJ9kSFDpsdzWDFoeOWGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269205; c=relaxed/simple;
	bh=teIdTvA6agQ3URnPoSAFhH+20mVDDaCR0mFd7vn8Bn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfxPmNJiM+aQkA9rXrTFHReeUTw7vLkivSmyeg6Fods8VVUiMlYfP8w1J9pud84Jbm3a+8KVF20e+UJ6yDziuOhsVCVlNSN4JegHDlFCqigob1b2dYpGJk7lr4YD0ccQBXmAHjIwLGtbZqxpyPKAlrMjEKpkmENv+8P8GShPrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dhZ+8xVh; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 May 2025 16:19:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748269201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3lctXpPr3gCedY2X7J7a/9DwfzkqXCtm6oTaRoym/A=;
	b=dhZ+8xVhGACOPmI0apdxpLkrKWfJVUimjl3u8iOk0pxKsnlMN7U1+1TqOn2026+snma+cq
	G2+KZRj4qgxjsVivfZ83jYtITl1/pPLAcKFoqVrKser38XLJttOEoqm1ImsY9aiSacUJ9j
	luswcG1wYpiD7TeLQaDht4ZRX3LT+6s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/11] kbuild: userprogs: add nolibc support
Message-ID: <20250522-fluorescent-liberal-pigeon-0404ed@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-1-454114e287fd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-kunit-kselftests-v2-1-454114e287fd@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 07, 2025 at 09:42:38AM +0200, Thomas Weißschuh wrote:
> Userprogs are built with the regular kernel compiler $CC.
> A kernel compiler does not necessarily contain a libc which is required
> for a normal userspace application.
> However the kernel tree does contain a minimal libc implementation
> "nolibc" which can be used to build userspace applications.
> 
> Introduce support to build userprogs against nolibc instead of the
> default libc of the compiler, which may not exist.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> This could probably be moved out of the generic kbuild makefiles.
> I think the ergonimics would suffer and this functionality could be
> used by other users of userprogs.
> 
> Also this does currently not support out-of-tree builds.

(out-of-tree == external kmods;  out-of-source == build-dir != source-dir)

you probably meant out-of-source.

> For that tools/include/nolibc/*.h and usr/include/*.h would need to be
> installed into the build directory.

Out-of-source builds could be achieved by adding 'headers' as 
dependency, see below.

> ---
>  Documentation/kbuild/makefiles.rst | 12 ++++++++++++
>  scripts/Makefile.userprogs         | 16 +++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 3b9a8bc671e2e92126857059e985d6e5b2c43fd4..f905a6f77c965311c491cfd7ab3103185af7e82e 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -970,6 +970,18 @@ When linking bpfilter_umh, it will be passed the extra option -static.
>  
>  From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
>  
> +Bulding userprogs against nolibc

Bulding -> Building

> +--------------------------------
> +
> +Not all kernel toolchains provide a libc.
> +Simple userprogs can be built against a very simple libc call "nolibc" provided
> +by the kernel source tree.
> +
> +Example::
> +
> +  # lib/kunit/Makefile
> +  uapi-preinit-nolibc := $(CONFIG_ARCH_HAS_NOLIBC)
> +
>  When userspace programs are actually built
>  ------------------------------------------
>  
> diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
> index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..a1447c02b948901631098b585f5cf4d3ea383a57 100644
> --- a/scripts/Makefile.userprogs
> +++ b/scripts/Makefile.userprogs
> @@ -16,10 +16,20 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
>  user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
>  user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
>  
> +user-libgcc     := $(call try-run,$(CC) -Werror $(KBUILD_USERCFLAGS) -lgcc -x c -shared /dev/null -o "$$TMP",-lgcc)
> +
> +user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
> +		      -ffreestanding -fno-stack-protector \
> +		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
> +user_nolibc_ldflags := -nostdlib -nostdinc -static
> +user_nolibc_ldlibs  := $(user-libgcc)
> +
>  user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
> -			$($(target-stem)-userccflags)
> -user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
> -user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
> +			$($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
> +user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
> +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
> +user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs) \
> +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
>  
>  # Create an executable from a single .c file
>  quiet_cmd_user_cc_c = CC [U]  $@

Adding another hunk for scripts/Makefile.userprogs would allow to build
out-of-source:

@@ -39,5 +49,5 @@ $(call multi_depend, $(user-cmulti), , -objs)
 # Create .o file from a .c file
 quiet_cmd_user_cc_o_c = CC [U]  $@
       cmd_user_cc_o_c = $(CC) $(user_ccflags) -c -o $@ $<
-$(user-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+$(user-cobjs): $(obj)/%.o: $(src)/%.c headers FORCE
        $(call if_changed_dep,user_cc_o_c)

But I am unsure if it is ok to add 'headers' as a build dependency for 
userprogs.  For me, it feels a bit odd, but I think it really makes 
sense here.

-- 
Nicolas Schier

