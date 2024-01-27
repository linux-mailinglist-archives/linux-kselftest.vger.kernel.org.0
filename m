Return-Path: <linux-kselftest+bounces-3657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447783EC35
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 10:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64B41C21AD5
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8561E86C;
	Sat, 27 Jan 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJFemUh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABC7F;
	Sat, 27 Jan 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706346209; cv=none; b=tudypocM4OGpn3+PzQ6j22kTgUicy2qM60qXhnQwXYXSYCJW8fH9zxRpccVMakH2YfCWLqxhld6CHUd0hKoU7NAfrkqAhk4Lh/+J7ZnWtZdYSrRotwGAwGSNcaqZBrWt57x9ToQCNnvbZu0FhvsRRyZbJmgVyYvFHCie7Cpj9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706346209; c=relaxed/simple;
	bh=yg/Y2lPHCXw+ApriwYjx7xRqzTngKb2FdtskFU96fy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2YuY6ceXhaJYQfpvSM9ybC53BmTD1Hqb2ExuoP76FtUFFDtdW/4yslNF6K9GcrvUKNF2086VZE6KFm9Ant37wpHjnFjSR2dptowPWJljqb1/ua8ZVFO/YkpjbLC1cYhFKZqkycYaFMTgkpKvjAurtpUGupdsFyalB1idMovwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJFemUh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31A6C433F1;
	Sat, 27 Jan 2024 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706346209;
	bh=yg/Y2lPHCXw+ApriwYjx7xRqzTngKb2FdtskFU96fy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NJFemUh5XosxEzuQNYr3ZBJxlqQ88LeyRThWQPYHhcBd46I/Ha71V2zIDrpWwj/MY
	 EsXjF9jf85sFYjJqroHoV/XVk1x3zTb5rN/b2ZmgAH35P2eFALCd3qsoxqchHK3NRC
	 rcuN4tcEBcihc5qfYkufSpRehgZSWYRzEWup5xUr+XMZ3lXWcWk6pGbeMV/Y1asZnB
	 8Vf5RSM+8smD09u4yHzl6W7LMVppvovI3ad3Kmb7zu7o9vNNfFQXNZKY/tNk6N26S0
	 nVLllaA54+Ghqv+biNjbI95CloERJfE7oXByp5kUnhCRb4niUoL10fPw03vgH/0Dsm
	 UJ57YxXzKwe9g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Include runner extras for
 install target
In-Reply-To: <CAEf4BzaewwHQn7xBgiuckH3xbRHGc6GxvAq6rXf6Ep+KDWDEFg@mail.gmail.com>
References: <20240125160502.1512422-1-bjorn@kernel.org>
 <CAEf4BzaewwHQn7xBgiuckH3xbRHGc6GxvAq6rXf6Ep+KDWDEFg@mail.gmail.com>
Date: Sat, 27 Jan 2024 10:03:25 +0100
Message-ID: <87r0i34082.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 25, 2024 at 8:05=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> When using the "install" or targets depending on install, e.g.
>> "gen_tar", the "runner extras" weren't included for the BPF machine
>> flavors.
>>
>> Make sure the necessary helper scripts/tools are added to
>> corresponding BPF machine flavor.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>> v2: Added btf_dump_test_case files
>> ---
>> tools/testing/selftests/bpf/Makefile | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index fd15017ed3b1..d5cff32997b3 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -744,8 +744,20 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR=
) $(HOST_SCRATCH_DIR)     \
>>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>>  override define INSTALL_RULE
>>         $(DEFAULT_INSTALL_RULE)
>> -       @for DIR in $(TEST_INST_SUBDIRS); do              \
>> -               mkdir -p $(INSTALL_PATH)/$$DIR;   \
>> -               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
>> +       @for DIR in $(TEST_INST_SUBDIRS); do                    \
>> +               mkdir -p $(INSTALL_PATH)/$$DIR;                 \
>> +               rsync -a --copy-unsafe-links                    \
>> +                       $(OUTPUT)/$$DIR/bpf_testmod.ko          \
>> +                       $(OUTPUT)/$$DIR/bpftool                 \
>> +                       $(OUTPUT)/$$DIR/ima_setup.sh            \
>> +                       $(OUTPUT)/$$DIR/liburandom_read.so      \
>> +                       $(OUTPUT)/$$DIR/sign-file               \
>> +                       $(OUTPUT)/$$DIR/uprobe_multi            \
>> +                       $(OUTPUT)/$$DIR/urandom_read            \
>> +                       $(OUTPUT)/$$DIR/verify_sig_setup.sh     \
>> +                       $(OUTPUT)/$$DIR/xdp_synproxy            \
>> +                       $(OUTPUT)/$$DIR/btf_dump_test_case_*.c  \
>> +                       $(OUTPUT)/$$DIR/*.bpf.o                 \
>> +                       $(INSTALL_PATH)/$$DIR;                  \
>
> My concern is that this will get out of sync and will go unnoticed
> next time we add another "extra" file. We have TRUNNER_EXTRA_FILES,
> should we use that list to keep these extras in fewer places?

Yeah, you're completely right -- this was a lazy approach. I'll spin a
more robust v3.


Cheers,
Bj=C3=B6rn

