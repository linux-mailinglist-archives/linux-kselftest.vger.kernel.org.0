Return-Path: <linux-kselftest+bounces-3740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29602841BEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF08E1F2541E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999123838B;
	Tue, 30 Jan 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nawke5cc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC238384;
	Tue, 30 Jan 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595868; cv=none; b=caN7NPg0DZllqn5UxOMDak3fSBntSemASzSv1IuT4+HZRerLR4Q86Rfry6kT9TMk0GYb1T27KcA69h/RrL1LBRFaq06T8ezimRdertqeGgSEWfpGvoy26NC3sZ0oU7GSfPj4CAsVKQH0nve+39L9pZ1DOcvJQ/N+nWRwW2sVGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595868; c=relaxed/simple;
	bh=1FPCfYNOVCQAsz+lNfdjUqoOGoVVW//2zmuZQ8t4ozQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y09y+H00c5HFXL0wOkSHA1jJcBZ+2gqbQ/44ceh1SiUSS52BkAr/kldSK/HJMKU4bQCI8059CFN3fiOkL46v1E7t/3OEXXEDqvMa7fjyFhEN59QP7TUvtWhq2JJt1mx7FxRgKvHE916z6xtL/Siu/bSHm8gfVpOZhKeCgONin40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nawke5cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E9BC433F1;
	Tue, 30 Jan 2024 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706595867;
	bh=1FPCfYNOVCQAsz+lNfdjUqoOGoVVW//2zmuZQ8t4ozQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nawke5ccLC3klm6goGKtd2Xz091ubnhTd77X+zvKribg/V+1fdqvsDU1CYyKU/ifu
	 16sKqlri6DwMfRJTcI/UEPb6YNRcMWC0ojaIMjDaBTK9R2U7tlA1OVbnGPzcd8NVqT
	 igKgBQ37QfL8TWWviNQhUhNwBao2D3SIQKjsKC/YAoSYbKqOHN1tMS/b0qCJ2dN0L6
	 WVkPG072iFQPQQhAMim9o6r9xroIj0s1ixLWgRuBkDgVlm8p/S509/tpb8bcQZmeZm
	 wNttxOLj1h5+ohiR4WzF1ckvbbG2yKNCI8X/PS3mHv5F594e87jIvQIGTdE35Gq9hu
	 +VHcB/uDaNSew==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Make install target copy
 test_progs extra files
In-Reply-To: <CAEf4BzZwbfqY15=f6uGLgJ3aaPCDqjFk_DTbpzRnWJfr+jckGA@mail.gmail.com>
References: <20240129070916.1639008-1-bjorn@kernel.org>
 <20240129070916.1639008-3-bjorn@kernel.org>
 <CAEf4BzZwbfqY15=f6uGLgJ3aaPCDqjFk_DTbpzRnWJfr+jckGA@mail.gmail.com>
Date: Tue, 30 Jan 2024 07:24:24 +0100
Message-ID: <87wmrruynb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sun, Jan 28, 2024 at 11:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Currently, "make install" does not install the required test_progs
>> "extra files" (e.g. kernel modules, helper shell scripts, etc.) for
>> the BPF machine flavors (e.g. cpuv4).
>>
>> Add the missing "extra files" dependencies to rsync, called from the
>> install target.
>>
>> Unfortunately, kselftest does not use bash as the default shell, so
>> the globbering is limited. Blindly enabling "SHELL:=3D/bin/bash" for the
>> Makefile breaks in other places. Workaround by explicitly call
>> "/bin/bash" to expand the file globbing.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
>>  1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 830a34f0aa37..c3c5b85f7dae 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -605,14 +605,15 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c           =
  \
>>                          json_writer.c          \
>>                          flow_dissector_load.h  \
>>                          ip_check_defrag_frags.h
>> -TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.k=
o \
>> -                      $(OUTPUT)/liburandom_read.so                     \
>> -                      $(OUTPUT)/xdp_synproxy                           \
>> -                      $(OUTPUT)/sign-file                              \
>> -                      $(OUTPUT)/uprobe_multi                           \
>> -                      ima_setup.sh                                     \
>> -                      verify_sig_setup.sh                              \
>> -                      $(wildcard progs/btf_dump_test_case_*.c)
>> +TRUNNER_PROGS_EXTRA_FILES:=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_test=
mod.ko    \
>> +                           $(OUTPUT)/liburandom_read.so                =
        \
>> +                           $(OUTPUT)/xdp_synproxy                      =
        \
>> +                           $(OUTPUT)/sign-file                         =
        \
>> +                           $(OUTPUT)/uprobe_multi                      =
        \
>> +                           ima_setup.sh                                =
        \
>> +                           verify_sig_setup.sh                         =
        \
>> +                           $(wildcard progs/btf_dump_test_case_*.c)
>> +TRUNNER_EXTRA_FILES :=3D $(TRUNNER_PROGS_EXTRA_FILES)
>>  TRUNNER_BPF_BUILD_RULE :=3D CLANG_BPF_BUILD_RULE
>>  TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_=
TESTS
>>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>> @@ -740,11 +741,17 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DI=
R) $(HOST_SCRATCH_DIR)    \
>>  # Delete partially updated (corrupted) files on error
>>  .DELETE_ON_ERROR:
>>
>> +space :=3D $(subst ,, )
>> +comma :=3D ,
>> +EXTRA_FILES_GLOB :=3D {$(subst $(space),$(comma),$(notdir $(TRUNNER_PRO=
GS_EXTRA_FILES)))}
>>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>>  override define INSTALL_RULE
>>         $(DEFAULT_INSTALL_RULE)
>> -       @for DIR in $(TEST_INST_SUBDIRS); do              \
>> -               mkdir -p $(INSTALL_PATH)/$$DIR;   \
>> -               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>> +       @for DIR in $(TEST_INST_SUBDIRS); do                            =
                \
>> +               mkdir -p $(INSTALL_PATH)/$$DIR;                         =
                \
>> +               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR; =
                \
>> +               rsync -a --copy-unsafe-links                            =
                \
>> +                       $$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FI=
LES_GLOB)")     \
>
> this feels quite hacky... have you tried using $(foreach) to go over
> each element of TRUNNER_PROGS_EXTRA_FILES and append $(OUTPUT)/$$DIR/
> to each one? Hopefully that will allow us to get rid of space and
> comma hacks?

I haven't -- I'll try that out. Another ugliness is that *.bpf.o and
bpftool has to be explicitly specified, which hints of unrobustness.

> I'm also wondering if it would be ok to just combine two rsync calls
> into one, so that $(INSTALL_PATH)/$$DIR is specified once?

FWIW, I fold the two calls in patch 3. Regardless; I'll try to make the
whole series more palatable.


Bj=C3=B6rn

