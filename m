Return-Path: <linux-kselftest+bounces-32136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F20AAA6790
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99192188B066
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316F226527;
	Thu,  1 May 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJvFdFtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4333987;
	Thu,  1 May 2025 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746143795; cv=none; b=GCGdNNKB2KKen87DRRnPoF5Nn9+h8SwCSp6zeByrFHvEFzgXgZKFE9KDHn6joajZ67CZYvl/PpU27gnOgekTURYpSDBccY4wnM1ke4n2Usuf2JrEpRy1G3B9/uuEieFkaFO6CoAN8HYZt9lQL3sOREwZHJr89dUHYNUUl0SYTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746143795; c=relaxed/simple;
	bh=22QTplWOYTRI6XYyal6CZnasrfKacMUm9YeXDusUySo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUk1OnARD1Qj5gvxGUeWcWiRFB6xinzLRPI3pJajOf7bbZunfjXkxCr1b1FbnGgkIBm8fg4HQRUL1RavoMtQe/wOXNAEB13R8W6Tpu+2Kf8wzJGll+bzF9YUM9soxMY7QPqAt4ISq5PIwrUN/+QVJnyZ0qkNhRD7kZWxDc+fDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJvFdFtP; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acb415dd8faso214426466b.2;
        Thu, 01 May 2025 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746143791; x=1746748591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IpqcdB5HKLcvCClWag1YAOoCR5dOaM4sia0jSQ91WTc=;
        b=HJvFdFtPpKRkUHN8FYiq19LesHdBtm5/m5fxiozVxKpCRDNKOAqvNoEEgJfZnEmDW9
         64uHNqxSZw3ZNUlUp2ExcemN3alHFraEPrlaJIRvUdR2e5xJtuLoP09zawT7PizdQLR/
         umD5rEVZMjxTv9Ub6+rsuJ4D5y/nN2B9pvAkp1rI2AZ+Iy4txhmNcdmJazPiR/bcm4T+
         xU+WFXQgEURxToXlgO8wDEqYiohgd4qFTrdWdogCDYxnAFWAWFFDs3r0JcifXoAhZR6z
         +p6prN+5tZtGGUVtMwto1SHCAwYUdOYe8kXtbUzeauxXxHetI0LKxDg+cFipZoahc8ci
         rIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746143791; x=1746748591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpqcdB5HKLcvCClWag1YAOoCR5dOaM4sia0jSQ91WTc=;
        b=LuQh/Fxo5Me05RIQ12pA7J1Io9Cq7CJG3QaDx8dczkkf9l1S9a2JOE5tfHGHJSu8cl
         11Gs3SVRyCUdYFXSWxSsxxhGaWimeQNe6G9YXbqboohy2gOW9pDxPoTPRuwQ9C24AgET
         QbV1beQGmgT5g0/UDTNgHcvgDTkFG9RXJMxf04CNPkGhGoi2G3WXlntXFuLGgFEs3qtR
         bI2VyF9c3d+7UTjiuOT+k4+RZxFp1r9PB7/PbJSipa9Wxc3RRvHZDJ7XR8bLTXfbjVBK
         DPcExMos7GzHMXri/ZU1RERb857xpMZLi2xSb3FRHQ0dKvZ2pMh6MWpyfv/8lAPy9lFr
         gCaw==
X-Forwarded-Encrypted: i=1; AJvYcCVPebe14FEqwWp8lafJ/cu31w7R5XT9OJIWQhWH0V2vr47+d5YYIhcL1QerEs7xALozSro=@vger.kernel.org, AJvYcCVjD38l2+/S1Xy8f1W1zFdvA6rKWsXLTdQNgM7uNXe/Ic1qa+2fNKr48tazkAJzlH7EO7sNLKUl/qrUWjOs@vger.kernel.org, AJvYcCXUuI3LEvHQ5VDIbVAe6MIJh+yYdv24cvakyBVCh+40WY9alTRK4R1EmuQ0qxera82AlHPaFwMVhY0KrVnE8+4X@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAN840A3UnFzOZ5tSIkapEMK3tZTuoOsJh0Vtt+Awrz+taYVM
	kPLycNa4jSQFDJPztw/OE8OGj0ZFZ93QAu3T3n5EMZU17fGGI88sxOYHXP5mh/H7flmQgwjknlY
	clZk9fJPExAFMNra4vU+FzAuPPBA=
X-Gm-Gg: ASbGncvRTwp0yag92YzTRHwoMQpt2VdMNbTS53YeXyVFifTk/aiLm67cj2/A0ABxkCM
	8QI1S+fN3AKZ1GjJNefyIPQDiiiD5lFgqsVNMWLfqF1DGgJtkOXEACi0A9P6jE5/KGRbfpU27Ep
	0XBr9VBkN1tVSul0V3H2eDamhjr4/EEDnj79vPoVq6hiEWw5jlUtSv4Q==
X-Google-Smtp-Source: AGHT+IE8rFYVy5AEV69cNgB7LjR9j9JDMd63wN3Vtcz9MvmQSCvUFlM2VwRHa8i1gy3jD9Ei18VDPKGcCjJ/nJCaAQ0=
X-Received: by 2002:a17:907:a587:b0:ac7:3912:5ea5 with SMTP id
 a640c23a62f3a-ad17af80715mr93822666b.58.1746143791303; Thu, 01 May 2025
 16:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de> <20250501073603.1402960-9-luis.gerhorst@fau.de>
In-Reply-To: <20250501073603.1402960-9-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 2 May 2025 01:55:54 +0200
X-Gm-Features: ATxdqUGuoTBKs9l0zhe3Yzsic4wyHg46bSXEHmrxNhmAcDg2gPFfcMFHEjWXEc4
Message-ID: <CAP01T76kOixPct5cOPHGKubFWSbSS7ztEnZc02v2wWGPOUYRCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/11] bpf: Fall back to nospec for Spectre v1
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 10:00, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This implements the core of the series and causes the verifier to fall
> back to mitigating Spectre v1 using speculation barriers. The approach
> was presented at LPC'24 [1] and RAID'24 [2].
>
> If we find any forbidden behavior on a speculative path, we insert a
> nospec (e.g., lfence speculation barrier on x86) before the instruction
> and stop verifying the path. While verifying a speculative path, we can
> furthermore stop verification of that path whenever we encounter a
> nospec instruction.
>
> A minimal example program would look as follows:
>
>         A = true
>         B = true
>         if A goto e
>         f()
>         if B goto e
>         unsafe()
> e:      exit
>
> There are the following speculative and non-speculative paths
> (`cur->speculative` and `speculative` referring to the value of the
> push_stack() parameters):
>
> - A = true
> - B = true
> - if A goto e
>   - A && !cur->speculative && !speculative
>     - exit
>   - !A && !cur->speculative && speculative
>     - f()
>     - if B goto e
>       - B && cur->speculative && !speculative
>         - exit
>       - !B && cur->speculative && speculative
>         - unsafe()
>
> If f() contains any unsafe behavior under Spectre v1 and the unsafe
> behavior matches `state->speculative &&
> error_recoverable_with_nospec(err)`, do_check() will now add a nospec
> before f() instead of rejecting the program:
>
>         A = true
>         B = true
>         if A goto e
>         nospec
>         f()
>         if B goto e
>         unsafe()
> e:      exit
>
> Alternatively, the algorithm also takes advantage of nospec instructions
> inserted for other reasons (e.g., Spectre v4). Taking the program above
> as an example, speculative path exploration can stop before f() if a
> nospec was inserted there because of Spectre v4 sanitization.
>
> In this example, all instructions after the nospec are dead code (and
> with the nospec they are also dead code speculatively).
>
> On x86_64, this depends on the following property of lfence [3]:
>
>         An LFENCE instruction or a serializing instruction will ensure that no
>         later instructions execute, even speculatively, until all prior
>         instructions complete locally. [...] Inserting an LFENCE instruction
>         after a bounds check prevents later operations from executing before
>         the bound check completes.
>
> Regarding the example, this implies that `if B goto e` will not execute
> before `if A goto e` completes. Once `if A goto e` completes, the CPU
> should find that the speculation was wrong and continue with `exit`.
>
> If there is any other path that leads to `if B goto e` (and therefore
> `unsafe()`) without going through `if A goto e`, then a nospec will
> still be needed there. However, this patch assumes this other path will
> be explored separately and therefore be discovered by the verifier even
> if the exploration discussed here stops at the nospec.
>
> This patch furthermore has the unfortunate consequence that Spectre v1
> mitigations now only support architectures which implement BPF_NOSPEC.
> Before this commit, Spectre v1 mitigations prevented exploits by
> rejecting the programs on all architectures. Because some JITs do not
> implement BPF_NOSPEC, this patch therefore may regress unpriv BPF's
> security to a limited extent:
>
> * The regression is limited to systems vulnerable to Spectre v1, have
>   unprivileged BPF enabled, and do NOT emit insns for BPF_NOSPEC. The
>   latter is not the case for x86 64- and 32-bit, arm64, and powerpc
>   64-bit and they are therefore not affected by the regression.
>   According to commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip
>   speculation barrier opcode"), LoongArch is not vulnerable to Spectre
>   v1 and therefore also not affected by the regression.
>
> * To the best of my knowledge this regression may therefore only affect
>   MIPS. This is deemed acceptable because unpriv BPF is still disabled
>   there by default. As stated in a previous commit, BPF_NOSPEC could be
>   implemented for MIPS based on GCC's speculation_barrier
>   implementation.
>
> * It is unclear which other architectures (besides x86 64- and 32-bit,
>   ARM64, PowerPC 64-bit, LoongArch, and MIPS) supported by the kernel
>   are vulnerable to Spectre v1. Also, it is not clear if barriers are
>   available on these architectures. Implementing BPF_NOSPEC on these
>   architectures therefore is non-trivial. Searching GCC and the kernel
>   for speculation barrier implementations for these architectures
>   yielded no result.
>
> * If any of those regressed systems is also vulnerable to Spectre v4,
>   the system was already vulnerable to Spectre v4 attacks based on
>   unpriv BPF before this patch and the impact is therefore further
>   limited.
>
> As an alternative to regressing security, one could still reject
> programs if the architecture does not emit BPF_NOSPEC (e.g., by removing
> the empty BPF_NOSPEC-case from all JITs except for LoongArch where it
> appears justified). However, this will cause rejections on these archs
> that are likely unfounded in the vast majority of cases.
>
> In the tests, some are now successful where we previously had a
> false-positive (i.e., rejection). Change them to reflect where the
> nospec should be inserted (using __xlated_unpriv) and modify the error
> message if the nospec is able to mitigate a problem that previously
> shadowed another problem (in that case __xlated_unpriv does not work,
> therefore just add a comment).
>
> Define SPEC_V1 to avoid duplicating this ifdef whenever we check for
> nospec insns using __xlated_unpriv, define it here once. This also
> improves readability. PowerPC can probably also be added here. However,
> omit it for now because the BPF CI currently does not include a test.
>
> Briefly went through all the occurrences of EPERM, EINVAL, and EACCESS
> in the verifier in order to validate that catching them like this makes
> sense.
>
> [1] https://lpc.events/event/18/contributions/1954/ ("Mitigating
>     Spectre-PHT using Speculation Barriers in Linux eBPF")
> [2] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
>     Precise Spectre Defenses for Untrusted Linux Kernel Extensions")
> [3] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/runtime-speculative-side-channel-mitigations.html
>     ("Managed Runtime Speculative Execution Side Channel Mitigations")
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---

The patches from here on look good in general, I will ack after taking
another look later.

I had a more high-level question though.
Back when all of this surfaced, compiler folks came up with another
solution, to rely on Intel's guarantee that conditional moves are not
predicted.

if (condition) {
   mask = !condition ? 0UL : ~0UL; // CMOVcc
   ptr &= mask;
   x = *ptr;
}

In case the condition being true in the speculative domain leads to
problems, the speculative domain will just read from NULL and not leak
sensitive data.
The assumption is that cost of instrumentation in speculative domain <
completely stalling it until prior instructions are done using lfence.
So speculation is still helpful when the branch is not mispredicted.
Now I imagine it's not fun to do such analysis in the verifier (I've
tried), but theoretically we could break it down into emitting
bytecode from the compiler side, and lifting the compiler to do it for
us, and ensuring the end result produced is sane (by still following
speculative paths) from the verifier.

You talk about this in the paper and in the presentation as future work.
My question is mainly whether you considered implementing this, if
yes, what made you choose a nospec barrier over something like above?
Was it the complexity of realizing this during verification?
Are there any implications of reading from NULL that would cause problems?
Also, did you characterize how much difference it could make?
The drop in SCTP throughput seems to suggest so, since CPU-bound
computation was moved into the program.
Otherwise most programs mostly defer to helpers for heavy lifting.
Not that it was as fast as a helper would be, even without nospec, but still.

Also a bit sad we don't split the program into BBs already, which
could help reduce your mitigation's cost + plus also reduce cost of
instruction patching (unrelated).

Anyway, all that said, this is valuable stuff, so I was just curious.

