Return-Path: <linux-kselftest+bounces-29422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21CA68775
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 10:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F1F19C1384
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21732528F1;
	Wed, 19 Mar 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="lzSXVoxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874932512CF;
	Wed, 19 Mar 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375205; cv=none; b=t/iexH1Yfwz+1z712H5iGAIvEqfUjBgclPDi+vsiAS8vVPoBPqdYy6GR5ZF7qc1qhjYnxhwuuQqHbCG7zo3ABV0APURnU06Eh0uIfwYZJn3SxEZvtlUadJB5HIAPpPIe9L57rlrvzKGLNV1iN6vk+ljIFv+0gR285fEcxYyVNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375205; c=relaxed/simple;
	bh=mOVj79GUbV+xSH8LY8TtXyIWEdLC30++NhbN9PTTN5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDb6uP3ZL1WeK1bubmz/cvfV99GfzLkIvSnLhsXHBnUjIRYTRgpDCpeWsjgrafKNvptFiezALF4mQiN1Ugzwv74TGM/qxgTY8CiJFKed9C+Hb+dNBI2HrXvxnB8Zu/qFeE7Mb4/BWAe4myXWRNLhVuUA+VPLps5T4XAQT/J3mrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=lzSXVoxA; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1742375193; bh=/5goDERUrPXPyZzmCy7lw+XwkgPNVdvQxkY1QQaRiqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=lzSXVoxAZAnJzDEK3eE3Aj534D+oBP149HbMd5Pg72Qe/WLAC3uoTnpjRsVzsIYox
	 TnYOSHjKGuB3gHkkqfdQ1OTs1uRRT/tls2LiJQviOSpmAsToF0tuXQxoPh+Knvua7E
	 mnx3iG4H8d2/gugEFKL5yNykGUx0uN36jMW5M6pViwJaZ6mLY7uXMFkK7fy8K2/NJ2
	 HC8FUqCub2ttWnDa7p1wJy6j+33lnqdVUeBHkXu/261LFECZL0AkRC091jFVzXJD6m
	 84+ErL1QGP+WFgpl2uMQHur82B8hea9fHUY3oayifgIcBEHmBmbvegaOhKfZ7ZLv/9
	 IlIezQeTcmibw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZHjWF1N6dzPkVl;
	Wed, 19 Mar 2025 10:06:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:8071:7900:bc0:c583:a400:7f8d:5e80
Received: from localhost (unknown [IPv6:2a02:8071:7900:bc0:c583:a400:7f8d:5e80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18CrB7ddj49FWVqrSeQ4eIWyZV3PfQwQ7Q=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZHjW86Bk0zPjtK;
	Wed, 19 Mar 2025 10:06:28 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah
 Khan <shuah@kernel.org>,
	Henriette Herzog <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev
 <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf
 <bpf@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML
 <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 George Guo <guodongtai@kylinos.cn>,
	WANG Xuerui <git@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Maximilian Ott <ott@cs.fau.de>,
	Milan Stephan <milan.stephan@fau.de>
Subject: Re: [PATCH bpf-next 11/11] bpf: Fall back to nospec for spec path
 verification
In-Reply-To: <CAADnVQKL-NwxigMWM+U=n5ZXPG+xHYzSTEv0Rq8Y91m45eRJDw@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 18 Mar 2025 19:40:44 -0700")
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	<20250313175312.1120183-1-luis.gerhorst@fau.de>
	<20250313175312.1120183-2-luis.gerhorst@fau.de>
	<CAADnVQKL-NwxigMWM+U=n5ZXPG+xHYzSTEv0Rq8Y91m45eRJDw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 19 Mar 2025 10:06:27 +0100
Message-ID: <87cyedie3w.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Mar 13, 2025 at 10:57=E2=80=AFAM Luis Gerhorst <luis.gerhorst@fau=
.de> wrote:
>> With increased limits this allows applying mitigations to large BPF
>> progs such as the Parca Continuous Profiler's prog. However, this
>> requires a jump-seq limit of 256k. In any case, the same principle
>> should apply to smaller programs therefore include it even if the limit
>> stays at 8k for now. Most programs in [1] only require a limit of 32k.
>
> Do you mean that without this change the verifier needs 256k
> jmp limit to load Parca's prog as unpriv due to speculative
> path exploration with push_stack ?
>

Only with this change Parca is loadable when manually enabling Spectre
defenses for privileged programs and setting the following limits:
- BPF_COMPLEXITY_LIMIT_JMP_SEQ=3D256k
- BPF_COMPLEXITY_LIMIT_SPEC_V1_VERIFICATION=3D128k
- BPF_COMPLEXITY_LIMIT_INSNS=3D32M

>
> And this change uses 4k as a trade-off between prog runtime
> and verification time ?
>

Yes, this change uses 4k to limited nested speculative path exploration.
At the top-level (i.e., on architectural paths), spawned speculative
paths are still explored.

>
> But tracing progs use bpf_probe_read_kernel(), so they're never going
> to be unpriv.
>

I'm sorry this was not clear. Parca is only used as an example here
to test whether this improves expressiveness in general.

If you do not see this as a favorable tradeoff (because of the code
complexity), I think it would be acceptable to drop the last patch for
now. The biggest improvements is already achieved with the other patches
as evident from the selftests. I can do a more exhaustive analysis on
patch 11 later.

>
>> @@ -2010,6 +2011,19 @@ static struct bpf_verifier_state *push_stack(stru=
ct bpf_verifier_env *env,
>>         struct bpf_verifier_stack_elem *elem;
>>         int err;
>>
>> +       if (!env->bypass_spec_v1 &&
>> +           cur->speculative &&
>
> Should this be
> (cur->speculative || speculative)
> ?

No, I think it will be unsafe to add `|| speculative` here. If we were
to return -EINVAL from push_stack() when pushing a speculative path from
a non-speculative path (e.g., in check_cond_jmp_op() through
sanitize_speculative_path()), this will cause do_check() to add an
lfence before the jump-op.

Here's a minimal example program:

	A =3D true
	B =3D true
	if A goto e
	f()
	if B goto e
	unsafe()
e:	exit

There are the following speculative and non-speculative paths
(`cur->speculative` and `speculative` referring to the value of the
push_stack() parameters):

- A =3D true
- B =3D true
- if A goto e
  - A && !cur->speculative && !speculative
    - exit
  - !A && !cur->speculative && speculative
    - f()
    - if B goto e
      - B && cur->speculative && !speculative
        - exit
      - !B && cur->speculative && speculative
        - unsafe()

`|| speculative` might cause us to only add an lfence before `if A goto
e`, which would not be sufficient. Intel recommends adding the lfence
after the jump [1].

>
> In general I'm not convinced that the approach is safe.
>
> This recoverable EINVAL means that exploration under speculation
> stops early, but there could be more branches and they won't be
> sanitized with extra lfence.
> So speculative execution can still happen at later insns.
>

`goto process_bpf_exit` only causes us to stop analyzing this particular
path, not the rest of the program.

This is based on the assumption, that the lfence stops the CPU from ever
reaching those branches (if they are not reachable through other means).

>
> Similar concern in patch 7:
> + if (state->speculative && cur_aux(env)->nospec)
> +   goto process_bpf_exit;
>
> One lfence at this insn doesn't stop speculation until the program end.
> Only at this insn. The rest of the code is free to speculate.
>

Taking the program above as an example, this allows us to stop before
f() if an lfence was inserted there.

Fully patched program would be:

	A =3D true
	B =3D true
	if A goto e
	lfence
	f()
	if B goto e
	unsafe()
e:	exit

In this example, all instructions after the lfence are dead code (and
with the lfence they are also dead code speculatively).

I believe this is in line with Intel's guidance [1]:

	An LFENCE instruction or a serializing instruction will ensure that
	no later instructions execute, even speculatively, until all prior
	instructions complete locally. Developers might prefer LFENCE over a
	serializing instruction because LFENCE may have lower latency.
	Inserting an LFENCE instruction after a bounds check prevents later
	operations from executing before the bound check completes.

With regards to the example, this implies that `if B goto e` will not
execute before `if A goto e` completes. Once `if A goto e` completes,
the CPU should find that the speculation was wrong and continue with
`exit`.

If there is any other path that leads to `if B goto e` (and therefore
`unsafe()`) without going through `if A goto e`, then an lfence might of
course still be needed there. However, I assume this other path will be
explored separately and therefore be discovered by the verifier even if
the exploration discussed here stops at the lfence. If this assumption
is wrong, please let me know.

>
> The refactoring in patches 1-3 is nice.
> Patches 4-5 are tricky and somewhat questionable, but make sense.
> Patch 7 without early goto process_bpf_exit looks correct too,
> Patch 8 is borderline. Feels like it's opening the door for
> new vulnerabilities and space to explore for security researchers.
> We disabled unpriv bpf by default and have no intentions to enable it.
> Even if we land the whole thing the unpriv will stay disabled.
> So trade offs don't appear favorable.
>

Thank you very much for having a look. Let me know whether the above
resolves your concern.

In any case, should I separate patches 1-3 into another series?

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/so=
ftware-security-guidance/technical-documentation/runtime-speculative-side-c=
hannel-mitigations.html
    ("Managed Runtime Speculative Execution Side Channel Mitigations")

