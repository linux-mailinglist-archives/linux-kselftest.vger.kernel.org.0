Return-Path: <linux-kselftest+bounces-19159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A7993257
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0A2848CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8C1D9323;
	Mon,  7 Oct 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMvlMyGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEB1D4615;
	Mon,  7 Oct 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316862; cv=none; b=Ri6WoodCATUehcmQBKW37jKkXipQii7quK25eYYzWzmq/gzX/YW5iozUGBftd9h2dz89PIhuFnq58Vcgz2lG1f1ZeGiAwcg+F+xc7CXvRTiw9YrKiq4ZtDniDPv2PQbU9cY4urkLYy0mZNyEiDmH5bgomxNSGYB5KHNuDiseCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316862; c=relaxed/simple;
	bh=e2NBHTw6PPvjULzXCQpYbFWcRNCqsXQxPgENG33mKoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1UOj9XtFLi+oUF7533yu95unfBzZTIfTNa6VBnUafHZn3jVQEjTKp+ykOi6KoHsY0FkLcG0nzjwE+rjyfpu89JUalwDH0cPTyx1lq9eVtCmifJHE4CdCS/Eq5rW0bVQf/tfwPoP5jh+r8V0W3qPdRAm4fYkD9+4WGTg3pMCJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMvlMyGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2E7C4CEC7;
	Mon,  7 Oct 2024 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316861;
	bh=e2NBHTw6PPvjULzXCQpYbFWcRNCqsXQxPgENG33mKoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WMvlMyGgn0mENSHuioUpratdm0Fb72jH/kyBzfNDdc11bZdmf3uNCn5qkmZiqgAjA
	 3ZgPvnDTMA/gDx07PgsHCfRvUUnLr1IBUyvMZ73Abl/ur+HQ14iEqXtKy3vXr7JRjM
	 MlB7ynIIb4SOzxaNenMQFfx2laXFSRsI2HH+0ndsfY+NTFJPjHQ3ymJFsy9YDIATXv
	 1jtvMsLJyLpwgwK83CxA/HKgkJ6cyX8TtM7h2AJixNYiNMj41W9xuQ6F3C+aVJxI8I
	 JjVsW2EV//PdyPUejWOFFV/pJMg95M+X3wSlsdtlmRGY82RB4OEnPrvcmEPr8wLw0W
	 OPYet1W0eHtfA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] selftests: sched_ext: Add sched_ext as proper
 selftest target
In-Reply-To: <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
References: <20241007073133.989166-1-bjorn@kernel.org>
 <ZwQBqlG6MShCkNrU@finisterre.sirena.org.uk>
Date: Mon, 07 Oct 2024 18:00:57 +0200
Message-ID: <87r08rnbra.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:

> On Mon, Oct 07, 2024 at 09:31:32AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>
>> When building the kselftest suite, e.g.:
>
>>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- \
>>     SKIP_TARGETS=3D"" O=3D/output/foo -C tools/testing/selftests install
>
>> The expectation is that the sched_ext is included, cross-built, and
>> placed into /output/foo.
>
> When building for arm64 with this applied on top of mainline or -next
> I'm seeing:

Thanks for taking it for a spin!

>    make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/testing/=
selftests TARGETS=3Dsched_ext SKIP_TARGETS=3D"
>
> give
>
>   CLNG-BPF create_dsq.bpf.o
> In file included from create_dsq.bpf.c:9:
> /home/broonie/git/linux/tools/sched_ext/include/scx/common.bpf.h:33:17: e=
rror: use of undeclared identifier 'SCX_DSQ_FLAG_BUILTIN'
>    33 |         _Static_assert(SCX_DSQ_FLAG_BUILTIN,
>       |                        ^

This is most likely due to incorrect VMLINUX_BTF_PATHS, so that
vmlinux.h is incorrectly generated. Try grepping for
SCX_DSQ_FLAG_BUILTIN in vmlinux.h.

> and more (my system clang is clang 20).  It's also failing with a native
> x86_64 build in the same way.  I've run "make headers_install", it looks
> like clang is not getting told about the copy of the headers installed
> in ./usr/include:
>
> clang -g -D__TARGET_ARCH_x86 -mlittle-endian -I/home/broonie/git/linux/to=
ols/testing/selftests/sched_ext/include -I/home/broonie/git/linux/tools/tes=
ting/selftests/sched_ext/include/bpf-compat -I/home/broonie/git/linux/tools=
/testing/selftests/sched_ext/build/include -I/home/broonie/git/linux/tools/=
include/uapi -I/home/broonie/git/linux/tools/sched_ext/include -I/home/broo=
nie/git/linux/include -idirafter /usr/lib/llvm-20/lib/clang/20/include -idi=
rafter /usr/local/include -idirafter /usr/include/x86_64-linux-gnu -idiraft=
er /usr/include  -Wall -Wno-compare-distinct-pointer-types -Wno-incompatibl=
e-function-pointer-types -O2 -mcpu=3Dv3 -target bpf -c create_dsq.bpf.c -o =
/home/broonie/git/linux/tools/testing/selftests/sched_ext/build/obj/sched_e=
xt/create_dsq.bpf.o

The sched_ext BPF programs relies on a vmlinux.h, which is generated
using bpftool and the vmlinux with BTF information. Have you built a
kernel with BTF support?

>> Add CROSS_COMPILE, OUTPUT, and TARGETS support to the sched_ext
>> selftest. Also, remove some variables that were unused by the
>> Makefile.
>
>> +ifneq ($(CROSS_COMPILE),)
>> +DEFAULT_BPFTOOL :=3D $(OUTPUT_DIR)/host/sbin/bpftool
>> +HOST_OBJ_DIR :=3D $(OBJ_DIR)/host/bpftool
>> +HOST_LIBBPF_OUTPUT :=3D $(OBJ_DIR)/host/libbpf/
>> +HOST_LIBBPF_DESTDIR :=3D $(OUTPUT_DIR)/host/
>> +HOST_DESTDIR :=3D $(OUTPUT_DIR)/host/
>> +else
>> +DEFAULT_BPFTOOL :=3D $(OUTPUT_DIR)/sbin/bpftool
>> +HOST_OBJ_DIR :=3D $(OBJ_DIR)/bpftool
>> +HOST_LIBBPF_OUTPUT :=3D $(OBJ_DIR)/libbpf/
>> +HOST_LIBBPF_DESTDIR :=3D $(OUTPUT_DIR)/
>> +HOST_DESTDIR :=3D $(OUTPUT_DIR)/
>> +endif
>
> This won't detect a cross compile when building using LLVM as that
> doesn't need to set CROSS_COMPILE, it can use the same binaries for all
> targets.  There's runes in the Makefile for the mm selftests for
> identifying the target architecture, though actually I'm wondering if
> it's worth just always building the host copy and never having to worry
> if the target build is a cross build or not?  It's obvious overhead in
> the native case though if we actually need the target copy.

Yeah, that would indeed simplify things! I'll spin a v3 with that (and
wait for more feedback).


Thanks for testing the patch!
Bj=C3=B6rn

