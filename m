Return-Path: <linux-kselftest+bounces-13948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A780F937F04
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 07:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3A8282250
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 05:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C428C157;
	Sat, 20 Jul 2024 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcRGhL/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB45DDAA;
	Sat, 20 Jul 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453018; cv=none; b=XSOK9uJzUCxrWnVbfR5ynwAdJW58LIKTwwE4vjBcn/h5GG3Ni4E/bzgfVji6d0DwL7EXDpHL/6uW5vg3hx7/mdQDggbTOkDeV9r398Lw0BBnPXN20aZfAHklZZbCm7C62U5ReDFWXqGzcmwdSovYVV8IGHKfEVrgk0ionBQC1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453018; c=relaxed/simple;
	bh=qVAdzCW8sW2diw75s7ydLU8CrfaB9d3r2iftBHMb6xU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1+rxtTUn8S+PWUnxFm8Qkw8LONObRq0PWg5RaFoMTivGpL1DpK6Xt1LEvhpxoYe1UpoQLiBiU4Pv09ZFIXUMb6+zYVWCFSgAuEhizvOtzFD1bUQyeTfejrdW2rTZIllVliCyw0GfR4VQOsjO3HUPbkTXpSF9iGDayr5pQ7tO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcRGhL/N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc658b6b2eso18644275ad.0;
        Fri, 19 Jul 2024 22:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721453016; x=1722057816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzgTpV69ev/JI3or+twS+Wi6LzM1OruuxBBcuGL2ycw=;
        b=HcRGhL/N5W78VbgtpBwwGVdTsvMmtjGX3BnE5NjZs3rWCVFqbo//gjuOjDoVgjp3Qc
         XwX+fWxzyx2Tn7Zxujn6sIy8KHWkhqxIiZSt/5wShI9DRjBW4/eoFL1ffZ4abOzVGsw4
         1h0NlXZaZFDRBCWNcUcMsmkd4YQv5vrRd7/uw6mp6ZBf0Y41WDUG1mdT2ap8ELxbL7Ig
         BNr536y/Ris8+Hwt90ugWbuhIMXaVvc8++XI5IcfGdacbACyOWWmCtFTUPCYRz7Tl0WU
         +n8Hk0LedsVABCbmU3V/LMlZmpm0yKvQYTmS1eaOunvC/yt0jdU1oZuJNQBw3YmahVIC
         NIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721453016; x=1722057816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzgTpV69ev/JI3or+twS+Wi6LzM1OruuxBBcuGL2ycw=;
        b=IJ7baX5tDHCwlUcIA44diwh8Pq1JhVyqkwPyj81d3KCJcJQjt9lrtz6WcaSSnXotuN
         efZZSUESP6XuuzIR+qJDcTC0ltTV4tedYRj+Y3K27T37ifUJmKlVRQZXYbv1JDNP6GSA
         kpj5B0dkt2Mu2FZkixvPq263is4/bxwoVzybhTDYpf//zll+DfJJqvAZzd9ino9z90AQ
         giPFn5XZaOGTaeFP/IKVSibLgdw4N4NhiDOO2LKrOPyzVcqM08yVuAxoShwEzNvy9gtE
         bovdK3mEX6rprziq747ILZrKZvy57FIO5Ay3RKHrfK6MjsvQpPM5Y3J/pIqpZwaLvWy4
         /CmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvwOwgxLfEaM9hViF0ogukaGYwg1sfb/cr3Mk+awP/eukM7ASBGMjnkQTiSGoMGpzgBXWS4csXZ8etgYDH5O9IZ2wmD2jlt8xroch8CWMg
X-Gm-Message-State: AOJu0YxHchejGM9K1l5ScyDF7cuHOKsg5tvHC4mnU+wJnI0PBw6KjOzb
	+DUn68wkqbivC9MgdsBNP8PqW2+1rJtOil3WuyNQOfhr0JhuvPNO
X-Google-Smtp-Source: AGHT+IHXOIJNwdyGtFV/WP/jERczjssGm9uj0tRJNEWl4P2Im5+nAMqNoO8h72zVFeY9cVhgFmRnWg==
X-Received: by 2002:a17:902:c94e:b0:1fc:5b68:ffb8 with SMTP id d9443c01a7336-1fd7457bd98mr16709435ad.30.1721453015633;
        Fri, 19 Jul 2024 22:23:35 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f259fdesm13813225ad.53.2024.07.19.22.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 22:23:35 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 19 Jul 2024 22:23:33 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
Message-ID: <ZptJ1dsnKbjTZ6iH@kodidev-ubuntu>
References: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
 <20240719232159.2147210-1-tony.ambardar@gmail.com>
 <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>

On Fri, Jul 19, 2024 at 07:57:09PM -0700, Andrii Nakryiko wrote:
> On Fri, Jul 19, 2024 at 4:22 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Make log output incorrectly shows 'test_maps' as the binary name for every
> > 'CLNG-BPF' build step, apparently picking up the last value defined for the
> > $(TRUNNER_BINARY) variable. Update the 'CLANG_BPF_BUILD_RULE' variants to
> > fix this confusing output.
> >
> > Current output:
> >   CLNG-BPF [test_maps] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs] access_map_in_map.skel.h
> >   ...
> >   CLNG-BPF [test_maps] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
> >   ...
> >   CLNG-BPF [test_maps] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h
> >
> > After fix:
> >   CLNG-BPF [test_progs] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs] access_map_in_map.skel.h
> >   ...
> >   CLNG-BPF [test_progs-no_alu32] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
> >   ...
> >   CLNG-BPF [test_progs-cpuv4] access_map_in_map.bpf.o
> >   GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h
> >
> > Fixes: a5d0c26a2784 ("selftests/bpf: Add a cpuv4 test runner for cpu=v4 testing")
> > Fixes: 89ad7420b25c ("selftests/bpf: Drop the need for LLVM's llc")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 0b4bfbc0ef68..67921e3367dd 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -425,27 +425,28 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> >  $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> >
> >  # Build BPF object using Clang
> > -# $1 - input .c file
> > -# $2 - output .o file
> > -# $3 - CFLAGS
> > +# $1 - binary name
> > +# $2 - input .c file
> > +# $3 - output .o file
> > +# $4 - CFLAGS
> >  define CLANG_BPF_BUILD_RULE
> > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
> > +       $(call msg,CLNG-BPF,$1,$3)
> > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v3 -o $3
> 
> this works, but did you have to renumber all parameters? Let's maybe
> pass this binary name as the 4th argument?
> 

OK, I'll update as requested and minimize the diff.

> pw-bot: cr
> 
> >  endef
> >  # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
> >  define CLANG_NOALU32_BPF_BUILD_RULE
> > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
> > +       $(call msg,CLNG-BPF,$1,$3)
> > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v2 -o $3
> >  endef
> >  # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
> >  define CLANG_CPUV4_BPF_BUILD_RULE
> > -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> > -       $(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
> > +       $(call msg,CLNG-BPF,$1,$3)
> > +       $(Q)$(CLANG) $4 -O2 --target=bpf -c $2 -mcpu=v4 -o $3
> >  endef
> >  # Build BPF object using GCC
> >  define GCC_BPF_BUILD_RULE
> > -       $(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> > -       $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
> > +       $(call msg,GCC-BPF,$1,$3)
> > +       $(Q)$(BPF_GCC) $4 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $2 -o $3
> >  endef
> >
> >  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
> > @@ -534,7 +535,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                             \
> >                      $(wildcard $(BPFDIR)/bpf_*.h)                      \
> >                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
> >                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> > -       $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
> > +       $$(call $(TRUNNER_BPF_BUILD_RULE),$(TRUNNER_BINARY),$$<,$$@,    \
> >                                           $(TRUNNER_BPF_CFLAGS)         \
> >                                           $$($$<-CFLAGS)                \
> >                                           $$($$<-$2-CFLAGS))
> > --
> > 2.34.1
> >

