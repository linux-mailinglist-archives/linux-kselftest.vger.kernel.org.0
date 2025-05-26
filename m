Return-Path: <linux-kselftest+bounces-33798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8343AC4196
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 16:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E42170815
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB72101A0;
	Mon, 26 May 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaqPh+cT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4UI7GP3j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EB20DD4E;
	Mon, 26 May 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270425; cv=none; b=exAO8XpEANKFqXc4IFVsE6/aZVc4ao+TP5mJCx4Nj9EjBgP4OY0smbLKcw6FOgSvDxXSTnLllLO7UCR93i5WvkdW4fkD8gR8veOqC0fb8DGPZyHlxdisibuangCT2aA/MWpz8gYA5ISd94rtLeUHHFlNLrG+KGHihO6blnHGSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270425; c=relaxed/simple;
	bh=ep1DMStgP4KLh6kjdF/WowDeKpc6b4Jr1zjb7jz95KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg4PtCZnG6qTAFDlN4JVwuVI0A/Ap9B7p0eTcQ95eTcNHsylhiG9clWB+OiN1hMw8m5pVx0R2Bo4aYXrVDvgZ5UXB5o4pWy9PGf9m+o9h8KcHKNvX5MFtAIE0uGZMUngxOO6Pdr/FwdNiTUvfsmFgkZPhiDP5lB0r29o6VodOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaqPh+cT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4UI7GP3j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 May 2025 16:40:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748270421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TV7kVDxmFuWEFaBNT2bTxAWVnJUcrUxNAcskziBBPw=;
	b=YaqPh+cTVv5lTI5hx6r+wn4iVxIXWsXlZq9NNG9ZJrowba5y96FUCXn4V9S9OtEmvsAnE1
	BZeIXFupqA3oxM2jR+7gypjG7pLtOzQLmaA6NfHfW6w7EpLaJUJM9K/OsNu0TAav/1ZZyp
	p3XHSmTeyQ3PdTEbF5TvaCGHyjh08ALd/czrLMDTCxgYW/1OgEV6phLi1zUBCHv4rfStV8
	XYdUId9gJEhaL98yD0Wneh6LjOuLO29r/gJ51BWJlPkOck3+g0j8JBUNFketul+PQ8I24Q
	OkzkjQYdCWQYkWo9BcEdzJwc6x+0pL71A9xM0ALChTPNFde0V3eekKclAcHhTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748270421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TV7kVDxmFuWEFaBNT2bTxAWVnJUcrUxNAcskziBBPw=;
	b=4UI7GP3jRqpneYJ72JmNnXXUSJd4HUvvqHF+iKuexX3Mz+vq6IbmremQ77q1N5HxM7CFlp
	31goQIRm4O7oynCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/11] kbuild: userprogs: add nolibc support
Message-ID: <20250526163610-88b7aae6-7be4-4a02-be20-ec7fe74cbf31@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-1-454114e287fd@linutronix.de>
 <20250522-fluorescent-liberal-pigeon-0404ed@l-nschier-aarch64>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522-fluorescent-liberal-pigeon-0404ed@l-nschier-aarch64>

On Mon, May 26, 2025 at 04:19:53PM +0200, Nicolas Schier wrote:
> On Mon, Apr 07, 2025 at 09:42:38AM +0200, Thomas Weiﬂschuh wrote:
> > Userprogs are built with the regular kernel compiler $CC.
> > A kernel compiler does not necessarily contain a libc which is required
> > for a normal userspace application.
> > However the kernel tree does contain a minimal libc implementation
> > "nolibc" which can be used to build userspace applications.
> > 
> > Introduce support to build userprogs against nolibc instead of the
> > default libc of the compiler, which may not exist.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > ---
> > This could probably be moved out of the generic kbuild makefiles.
> > I think the ergonimics would suffer and this functionality could be
> > used by other users of userprogs.
> > 
> > Also this does currently not support out-of-tree builds.
> 
> (out-of-tree == external kmods;  out-of-source == build-dir != source-dir)
> 
> you probably meant out-of-source.

I *did* mean out-of-tree.

Out-of-source already works with the current patchset. It is the default setup of kunit.py.

> > For that tools/include/nolibc/*.h and usr/include/*.h would need to be
> > installed into the build directory.
> 
> Out-of-source builds could be achieved by adding 'headers' as 
> dependency, see below.
> 
> > ---
> >  Documentation/kbuild/makefiles.rst | 12 ++++++++++++
> >  scripts/Makefile.userprogs         | 16 +++++++++++++---
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> > index 3b9a8bc671e2e92126857059e985d6e5b2c43fd4..f905a6f77c965311c491cfd7ab3103185af7e82e 100644
> > --- a/Documentation/kbuild/makefiles.rst
> > +++ b/Documentation/kbuild/makefiles.rst
> > @@ -970,6 +970,18 @@ When linking bpfilter_umh, it will be passed the extra option -static.
> >  
> >  From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
> >  
> > +Bulding userprogs against nolibc
> 
> Bulding -> Building

Ack.

> > +--------------------------------
> > +
> > +Not all kernel toolchains provide a libc.
> > +Simple userprogs can be built against a very simple libc call "nolibc" provided
> > +by the kernel source tree.
> > +
> > +Example::
> > +
> > +  # lib/kunit/Makefile
> > +  uapi-preinit-nolibc := $(CONFIG_ARCH_HAS_NOLIBC)
> > +
> >  When userspace programs are actually built
> >  ------------------------------------------
> >  
> > diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
> > index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..a1447c02b948901631098b585f5cf4d3ea383a57 100644
> > --- a/scripts/Makefile.userprogs
> > +++ b/scripts/Makefile.userprogs
> > @@ -16,10 +16,20 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
> >  user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
> >  user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
> >  
> > +user-libgcc     := $(call try-run,$(CC) -Werror $(KBUILD_USERCFLAGS) -lgcc -x c -shared /dev/null -o "$$TMP",-lgcc)
> > +
> > +user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
> > +		      -ffreestanding -fno-stack-protector \
> > +		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
> > +user_nolibc_ldflags := -nostdlib -nostdinc -static
> > +user_nolibc_ldlibs  := $(user-libgcc)
> > +
> >  user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
> > -			$($(target-stem)-userccflags)
> > -user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
> > -user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
> > +			$($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
> > +user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
> > +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
> > +user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs) \
> > +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
> >  
> >  # Create an executable from a single .c file
> >  quiet_cmd_user_cc_c = CC [U]  $@
> 
> Adding another hunk for scripts/Makefile.userprogs would allow to build
> out-of-source:
> 
> @@ -39,5 +49,5 @@ $(call multi_depend, $(user-cmulti), , -objs)
>  # Create .o file from a .c file
>  quiet_cmd_user_cc_o_c = CC [U]  $@
>        cmd_user_cc_o_c = $(CC) $(user_ccflags) -c -o $@ $<
> -$(user-cobjs): $(obj)/%.o: $(src)/%.c FORCE
> +$(user-cobjs): $(obj)/%.o: $(src)/%.c headers FORCE
>         $(call if_changed_dep,user_cc_o_c)
> 
> But I am unsure if it is ok to add 'headers' as a build dependency for 
> userprogs.  For me, it feels a bit odd, but I think it really makes 
> sense here.

Currently this dependency is encoded in Kconfig.
If CONFIG_HEADERS_INSTALL=y then the headers are installed in the 'prepare'
phase and already available when building any userprog.
To me this seems like the easier and nicer implementation.

