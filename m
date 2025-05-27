Return-Path: <linux-kselftest+bounces-33859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935EAAC5070
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E3189E1A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D592749C3;
	Tue, 27 May 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BAk2Pbd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3126A0E0
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354541; cv=none; b=GKLIDPLLqw7Wo9rMTGK07f6BOE3vNKdv33uKMI8bLD5VpPsl5uF5wT8lCTLvgYIBbBkofCm7DQJi5VROvb6Av3Y71Nu7mMoQDQSD1k7OSZVkF4QdmZzE/jybDVfALPcxX5rpR9fHhrU91voAXuGmnxizVKJ/18h2QLIlfJcvPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354541; c=relaxed/simple;
	bh=yo0oZBlfMtOYp40SB2fAqqqKfsg0rNIT7m84sU2j4s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeItdfDA/h8GkZSEgCzWPL+vN61MsjnwITcv6Q1ACTTo9i1pm+kBD3HtdatOrr6ayR2W+KrU0/MBvvji5lRKSV/g4fD9N1gOlCGpaRiJNJs0XOgW9a+OHByMzZhpMfc6nn7sbZz8qVgFSKiYZxzrWUCYZrxkZ32OBOSRB8RxR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BAk2Pbd/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 16:01:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748354526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RLjeN+B9ynhfLIpwmZXtdB5HF0huSI0hOjSO/VoOEo=;
	b=BAk2Pbd/JJPysmSNfFdWpiFzw1ZbscmqwYi0OO5P4uUbbl/cxRm+cE67R9CUmG77lSWEKN
	OIVxcR42DttYY+yGY3ybCgCJFgSCcRgI8cMZvgho5su03pe8ri6GZRqnaWb6SeVn/uRWGy
	JEB9XIELPgnKUhyf/iGlS86pm8X460E=
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
Message-ID: <20250527-fearless-impala-of-poetry-8acc3a@l-nschier-aarch64>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
 <20250407-kunit-kselftests-v2-1-454114e287fd@linutronix.de>
 <20250522-fluorescent-liberal-pigeon-0404ed@l-nschier-aarch64>
 <20250526163610-88b7aae6-7be4-4a02-be20-ec7fe74cbf31@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526163610-88b7aae6-7be4-4a02-be20-ec7fe74cbf31@linutronix.de>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Mon, May 26, 2025 at 04:40:17PM +0200, Thomas Weißschuh wrote:
> On Mon, May 26, 2025 at 04:19:53PM +0200, Nicolas Schier wrote:
> > On Mon, Apr 07, 2025 at 09:42:38AM +0200, Thomas Weißschuh wrote:
> > > Userprogs are built with the regular kernel compiler $CC.
> > > A kernel compiler does not necessarily contain a libc which is required
> > > for a normal userspace application.
> > > However the kernel tree does contain a minimal libc implementation
> > > "nolibc" which can be used to build userspace applications.
> > > 
> > > Introduce support to build userprogs against nolibc instead of the
> > > default libc of the compiler, which may not exist.
> > > 
> > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > ---
> > > This could probably be moved out of the generic kbuild makefiles.
> > > I think the ergonimics would suffer and this functionality could be
> > > used by other users of userprogs.
> > > 
> > > Also this does currently not support out-of-tree builds.
> > 
> > (out-of-tree == external kmods;  out-of-source == build-dir != source-dir)
> > 
> > you probably meant out-of-source.
> 
> I *did* mean out-of-tree.
> 
> Out-of-source already works with the current patchset. It is the default setup of kunit.py.
> 
> > > For that tools/include/nolibc/*.h and usr/include/*.h would need to be
> > > installed into the build directory.
> > 
> > Out-of-source builds could be achieved by adding 'headers' as 
> > dependency, see below.
> > 
> > > ---
> > >  Documentation/kbuild/makefiles.rst | 12 ++++++++++++
> > >  scripts/Makefile.userprogs         | 16 +++++++++++++---
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> > > index 3b9a8bc671e2e92126857059e985d6e5b2c43fd4..f905a6f77c965311c491cfd7ab3103185af7e82e 100644
> > > --- a/Documentation/kbuild/makefiles.rst
> > > +++ b/Documentation/kbuild/makefiles.rst
> > > @@ -970,6 +970,18 @@ When linking bpfilter_umh, it will be passed the extra option -static.
> > >  
> > >  From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
> > >  
> > > +Bulding userprogs against nolibc
> > 
> > Bulding -> Building
> 
> Ack.
> 
> > > +--------------------------------
> > > +
> > > +Not all kernel toolchains provide a libc.
> > > +Simple userprogs can be built against a very simple libc call "nolibc" provided
> > > +by the kernel source tree.
> > > +
> > > +Example::
> > > +
> > > +  # lib/kunit/Makefile
> > > +  uapi-preinit-nolibc := $(CONFIG_ARCH_HAS_NOLIBC)
> > > +
> > >  When userspace programs are actually built
> > >  ------------------------------------------
> > >  
> > > diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
> > > index f3a7e1ef3753b54303718fae97f4b3c9d4eac07c..a1447c02b948901631098b585f5cf4d3ea383a57 100644
> > > --- a/scripts/Makefile.userprogs
> > > +++ b/scripts/Makefile.userprogs
> > > @@ -16,10 +16,20 @@ user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
> > >  user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
> > >  user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
> > >  
> > > +user-libgcc     := $(call try-run,$(CC) -Werror $(KBUILD_USERCFLAGS) -lgcc -x c -shared /dev/null -o "$$TMP",-lgcc)
> > > +
> > > +user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
> > > +		      -ffreestanding -fno-stack-protector \
> > > +		      -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
> > > +user_nolibc_ldflags := -nostdlib -nostdinc -static
> > > +user_nolibc_ldlibs  := $(user-libgcc)
> > > +
> > >  user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
> > > -			$($(target-stem)-userccflags)
> > > -user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
> > > -user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
> > > +			$($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
> > > +user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
> > > +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
> > > +user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs) \
> > > +			$(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
> > >  
> > >  # Create an executable from a single .c file
> > >  quiet_cmd_user_cc_c = CC [U]  $@
> > 
> > Adding another hunk for scripts/Makefile.userprogs would allow to build
> > out-of-source:
> > 
> > @@ -39,5 +49,5 @@ $(call multi_depend, $(user-cmulti), , -objs)
> >  # Create .o file from a .c file
> >  quiet_cmd_user_cc_o_c = CC [U]  $@
> >        cmd_user_cc_o_c = $(CC) $(user_ccflags) -c -o $@ $<
> > -$(user-cobjs): $(obj)/%.o: $(src)/%.c FORCE
> > +$(user-cobjs): $(obj)/%.o: $(src)/%.c headers FORCE
> >         $(call if_changed_dep,user_cc_o_c)
> > 
> > But I am unsure if it is ok to add 'headers' as a build dependency for 
> > userprogs.  For me, it feels a bit odd, but I think it really makes 
> > sense here.
> 
> Currently this dependency is encoded in Kconfig.
> If CONFIG_HEADERS_INSTALL=y then the headers are installed in the 'prepare'
> phase and already available when building any userprog.
> To me this seems like the easier and nicer implementation.

I am sure, I had an out-of-source test build that failed due to missing 
header files -- but I can't reproduce it any more and yes, 
CONFIG_HEADERS_INSTALL should really be enough and better in several 
ways.

Sorry for the noice.

Kind regards,
Nicolas

