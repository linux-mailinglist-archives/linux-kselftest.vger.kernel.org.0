Return-Path: <linux-kselftest+bounces-3671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057183F575
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09691F218F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jan 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1212F20DC1;
	Sun, 28 Jan 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnV1nIPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458C208AF;
	Sun, 28 Jan 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706444458; cv=none; b=UhGTyfA3s6Pl3owQYFgkt0I41z07S3NMoQtOje/IUCvx9AemBh/0xQH+TNg8MN8n1oh5r9cViKLvP//YfsPk2VYzB8xy8/PZAeXDVS92ucyd8GeNIIKyUcVJYQQb855rUEa1YpwFoxtLRI6N876gpABU4E6RqU2zHONBc/hNKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706444458; c=relaxed/simple;
	bh=+dvUSGHsnkRFKjgjnSLq9+73NC8nrTxMZZZ+gNL+okQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVeJF2hpuG9X5yviuLr0r6tzzroMqgAWxT5gRB4Vp4YbXul6Xzr1gCv1kA6X5JU896KvySX7guCEcQsKJZWCK5kWxQuVxilBFSiGeqYV88oFJL+9Hq1pIftBhewcMTbhD1Sbrbd3ysRoDuKsqL4Ku50I5PTpKDbp1EckNcrD1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnV1nIPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43A5C433C7;
	Sun, 28 Jan 2024 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706444457;
	bh=+dvUSGHsnkRFKjgjnSLq9+73NC8nrTxMZZZ+gNL+okQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NnV1nIPu2RF3iUB939WzMArE+4YHveOlJpmr4/zRsZNivVH0eDf4l1j68bds4ioLJ
	 sdbyVV6XySyJhk19cjaNkIeH2JGCIna2SFyeDDgiA4GN5xc7aoyOgt1rbTNPpYB8gS
	 BfU9OgEJk3RRlN2ndCE2hFok7cyvB91cTdizboWyvjd6dx5yh+YgBfJyVlhzu4pLsS
	 G3WGlHm081uSyTqbkqHGl63JMfJuJu/+PZaNfhC4nsVa/IKjOA2r1gfC9aM64n/02u
	 Zp1+7B32socTh1gLU/KDdmBm75sCrtLhba+1DybE/RDI8w7N6A0qbt5qRVnyBd+j3r
	 aZ3RyNF054aZw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Make install target copy
 test_progs extra files
In-Reply-To: <875xzex50m.fsf@all.your.base.are.belong.to.us>
References: <20240127133327.1594026-1-bjorn@kernel.org>
 <20240127133327.1594026-2-bjorn@kernel.org>
 <875xzex50m.fsf@all.your.base.are.belong.to.us>
Date: Sun, 28 Jan 2024 13:20:54 +0100
Message-ID: <8734uh7iop.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
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
>> v3: Do not use hardcoded file names (Andrii)
>> v2: Added btf_dump_test_case files
>> ---
>>  tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
>>  1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 830a34f0aa37..d66c689f0f3c 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -605,14 +605,15 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c		\
>>  			 json_writer.c 		\
>>  			 flow_dissector_load.h	\
>>  			 ip_check_defrag_frags.h
>> -TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.k=
o	\
>> -		       $(OUTPUT)/liburandom_read.so			\
>> -		       $(OUTPUT)/xdp_synproxy				\
>> -		       $(OUTPUT)/sign-file				\
>> -		       $(OUTPUT)/uprobe_multi				\
>> -		       ima_setup.sh 					\
>> -		       verify_sig_setup.sh				\
>> -		       $(wildcard progs/btf_dump_test_case_*.c)
>> +TRUNNER_PROGS_EXTRA_FILES:=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_test=
mod.ko	\
>> +			    $(OUTPUT)/liburandom_read.so			\
>> +			    $(OUTPUT)/xdp_synproxy				\
>> +			    $(OUTPUT)/sign-file					\
>> +			    $(OUTPUT)/uprobe_multi				\
>> +			    ima_setup.sh					\
>> +			    verify_sig_setup.sh					\
>> +			    $(wildcard progs/btf_dump_test_case_*.c)
>> +TRUNNER_EXTRA_FILES :=3D $(TRUNNER_PROGS_EXTRA_FILES)
>>  TRUNNER_BPF_BUILD_RULE :=3D CLANG_BPF_BUILD_RULE
>>  TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_=
TESTS
>>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
>> @@ -740,11 +741,17 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DI=
R) $(HOST_SCRATCH_DIR)	\
>>  # Delete partially updated (corrupted) files on error
>>  .DELETE_ON_ERROR:
>>=20=20
>> +space :=3D $(subst ,, )
>> +comma :=3D ,
>> +EXTRA_FILES_GLOB :=3D {$(subst $(space),$(comma),$(notdir $(TRUNNER_PRO=
GS_EXTRA_FILES)))}
>>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>>  override define INSTALL_RULE
>>  	$(DEFAULT_INSTALL_RULE)
>> -	@for DIR in $(TEST_INST_SUBDIRS); do		  \
>> -		mkdir -p $(INSTALL_PATH)/$$DIR;   \
>> -		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>> +	@for DIR in $(TEST_INST_SUBDIRS); do						\
>> +		mkdir -p $(INSTALL_PATH)/$$DIR;						\
>> +		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;			\
>> +		rsync -a --copy-unsafe-links						\
>> +			$$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FILE_GLOB)")	\
>
> Argh! Bad commit. EXTRA_FILE_GLOB should be EXTRA_FILES_GLOB. :-(
>
> LMK if you can fix it up, or if you want me to resubmit.

...and bpftool is missing.

I'll spin a v4. :-(

