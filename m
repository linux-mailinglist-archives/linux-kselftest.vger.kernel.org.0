Return-Path: <linux-kselftest+bounces-34536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CBAD2C0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 05:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC68A16C47F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 03:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E42566FD;
	Tue, 10 Jun 2025 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAg4c81g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E7EEAA;
	Tue, 10 Jun 2025 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749524596; cv=none; b=VEhWxWzLkCBw5QuMfsLwyrhngj9s66ARR7WQ5lUx2gv800KF0nolY0vG5piqV+NLsFB3mVGdCWMHX17WpjZWIgUuCtHTmYvPVHEI/J7vl1Yc4tvZYqrThyZPsMARpftQND4BFe1/bA2jyGOTnaLuic1nEGdGdfxwczY6VMMm7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749524596; c=relaxed/simple;
	bh=zv0yreVmcdl60T5BhuMgSl2cqisSgrbqf6ghuj2YQNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfyULqXRIkHLBAc0/00Q405CaIp/SYX5nmKmAm9yrUrtAA5xdiztxWf5fMmzVDqO7vjxb1i/odsnFLOouZGjlfUbGkGmMgLvV6HukHfIVOSIoJP+V7SlmpmRDnP/B9REiSg7dAeaXyUtWZFu6CZT/OMvR0bu5MWsJZY1dj4tzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAg4c81g; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad8a8da2376so802972466b.3;
        Mon, 09 Jun 2025 20:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749524593; x=1750129393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIEKtN06Lki2LXMwWPqlBYVbjTpO1FFusGuijePViww=;
        b=GAg4c81g9V7FI467sN72x+8ej2lckmCEdPVvM7bFwVeUWgSlBSwN2WJEM5q2sKwlCh
         fYkty3RY3aRAoVaN9HB8Hz6tWlhNed1KuQS4X4v0PIV0oBKBdP0dDGNdQh5/zUqqDUlL
         PJy11K17UTnvuBwuAxYVe5krtoNoQ+r8iSXe50Q8Qp0DssQrKBZHjlEFA070CO+Qdwt4
         eINdvfGo/rHBsYI+CMyi+JEndgtKfD+mZ2Q6Z0btSNUzVynrimY0ODZJr8mPU2cqpfO/
         4D+rkzHTKNeq1q1246/Z2DqPn+JMZ7F6a3Gy7/ZWN4MUCvVvPfOoQVXi632xUVcAtLom
         ubXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749524593; x=1750129393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIEKtN06Lki2LXMwWPqlBYVbjTpO1FFusGuijePViww=;
        b=f7KbaxK2LcOM3BgvpczCRJCOrO/Fyr/Vr8RrHXZzUqD22N17FYX7d0KI6s2PB1PCeG
         NLYluiFvbubii3C0ZaoILlof7QoCmwy/WiQ4qPjiJcciVN7yvbQxB8xNiVKpNqFmb2to
         IhfBjTAqUROOObzY7N8M5WZjbVqSCpUstHrTCZaqwnsoFEUXSJ2U2kXZArdRGmQB7Uw2
         GJxue8Nvm4hNlL3SRsdg0KtBtq0LEzbaxf3P+VVQH3R8eA8dUsLO9d5p/I+hDQq8IkpP
         jPZzUAe+RmFI6zpgZ9ayA4NrHogh1j/p3x06KgNZtwyY9Iny1XjkAlm8Q6MArDlJ2tLO
         UJwg==
X-Forwarded-Encrypted: i=1; AJvYcCVVc1rkEEXYQarWGeZOY/t0F08TwF5rs+d+nzabz+u6cT1KZjBMBnU00UIMBOQDsfEkCQ+6vs0ALny7Tmeg@vger.kernel.org, AJvYcCVrpUOr1LSL+cWPDz/0ldjpnK7W9Ii/W8/ETLAV5GgHy0tLOoWm0YCwTcKoGNADCDTDKwM=@vger.kernel.org, AJvYcCVxFveIxZBPLY4ogVvAa3tctbYzXf0tr0StsStSFw92bTMEn/8bKNKgpANkrOzZwlkKo9rKjmW6Q4EOipOyERCk@vger.kernel.org
X-Gm-Message-State: AOJu0YyxubkkuYcdEOfzMJQeQoAlh0XjE2sSxlkJ+6U1YZzfMQKtQu79
	pQiPYzUyvONWrgiR2t9+zkd0lYoBRKX8pAnDL3zm/oUkYe8IvsaYbtEnW2j5KJNmCrKJsi4yVjo
	M9eEv/1dDRPCbtbOWoPYrMlBzgUclrUA=
X-Gm-Gg: ASbGncv5oK68Ip8yIWTok/NaKquzICsyb+NNOtx5fGqpQC7+Nx9KX6FwXiEWC5HpmJ8
	f5dQeOewRR0OyY0IuMna6evKS+iDyI1ZG62dup+hLdtq3qiMristEbYojcw8JVJ88ZA1k+/LXG7
	7mcTVKEIUKpdaxR7xQRRO2vitI/78Ay+pR2/6elwL+z2eRc9uuBii09GKDNSRz5pMekEpcphSec
	sJbzLyIGw3c5A4d
X-Google-Smtp-Source: AGHT+IGSVrkhyZq9vvvsVr44VoqUZGF3wcQ/tPIjHH2PKLhYYyk/OK3JkxJPJ6OOCePVO2GT4bNI9XVsW4Z5WF4Rz1o=
X-Received: by 2002:a17:906:6a0e:b0:ad5:72d4:85f9 with SMTP id
 a640c23a62f3a-ade1a9c7cd2mr1539157966b.40.1749524592671; Mon, 09 Jun 2025
 20:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603205800.334980-1-luis.gerhorst@fau.de>
In-Reply-To: <20250603205800.334980-1-luis.gerhorst@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Jun 2025 05:02:36 +0200
X-Gm-Features: AX0GCFsg0jFdSRfQwjdMDtUT5JBYaZq4q7ARo5V7e_WrDdDiMUVd3IyUlXozaCc
Message-ID: <CAP01T76BFe57wUaqsQYFu0vk-ST1kSSk1MghDAUhS3n2F892AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/9] bpf: Mitigate Spectre v1 using barriers
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
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 23:04, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> This improves the expressiveness of unprivileged BPF by inserting
> speculation barriers instead of rejecting the programs.
>
> The approach was previously presented at LPC'24 [1] and RAID'24 [2].
>
> To mitigate the Spectre v1 (PHT) vulnerability, the kernel rejects
> potentially-dangerous unprivileged BPF programs as of
> commit 9183671af6db ("bpf: Fix leakage under speculation on mispredicted
> branches"). In [2], we have analyzed 364 object files from open source
> projects (Linux Samples and Selftests, BCC, Loxilb, Cilium, libbpf
> Examples, Parca, and Prevail) and found that this affects 31% to 54% of
> programs.
>
> To resolve this in the majority of cases this patchset adds a fall-back
> for mitigating Spectre v1 using speculation barriers. The kernel still
> optimistically attempts to verify all speculative paths but uses
> speculation barriers against v1 when unsafe behavior is detected. This
> allows for more programs to be accepted without disabling the BPF
> Spectre mitigations (e.g., by setting cpu_mitigations_off()).
>
> For this, it relies on the fact that speculation barriers generally
> prevent all later instructions from executing if the speculation was not
> correct (not only loads). See patch 7 ("bpf: Fall back to nospec for
> Spectre v1") for a detailed description and references to the relevant
> vendor documentation (AMD and Intel x86-64, ARM64, and PowerPC).
>
> In [1] we have measured the overhead of this approach relative to having
> mitigations off and including the upstream Spectre v4 mitigations. For
> event tracing and stack-sampling profilers, we found that mitigations
> increase BPF program execution time by 0% to 62%. For the Loxilb network
> load balancer, we have measured a 14% slowdown in SCTP performance but
> no significant slowdown for TCP. This overhead only applies to programs
> that were previously rejected.
>
> I reran the expressiveness-evaluation with v6.14 and made sure the main
> results still match those from [1] and [2] (which used v6.5).
>
> Main design decisions are:
>
> * Do not use separate bytecode insns for v1 and v4 barriers (inspired by
>   Daniel Borkmann's question at LPC). This simplifies the verifier
>   significantly and has the only downside that performance on PowerPC is
>   not as high as it could be.
>
> * Allow archs to still disable v1/v4 mitigations separately by setting
>   bpf_jit_bypass_spec_v1/v4(). This has the benefit that archs can
>   benefit from improved BPF expressiveness / performance if they are not
>   vulnerable (e.g., ARM64 for v4 in the kernel).
>
> * Do not remove the empty BPF_NOSPEC implementation for backends for
>   which it is unknown whether they are vulnerable to Spectre v1.
>
> [1] https://lpc.events/event/18/contributions/1954/ ("Mitigating
>     Spectre-PHT using Speculation Barriers in Linux eBPF")
> [2] https://arxiv.org/pdf/2405.00078 ("VeriFence: Lightweight and
>     Precise Spectre Defenses for Untrusted Linux Kernel Extensions")
>
> Changes:
>
> * v3 -> v4:
>   - Remove insn parameter from do_check_insn() and extract
>     process_bpf_exit_full as a function as requested by Eduard
>   - Investigate apparent sanitize_check_bounds() bug reported by
>     Kartikeya (does appear to not be a bug but only confusing code),
>     sent separate patch to document it and add an assert
>   - Remove already-merged commit 1 ("selftests/bpf: Fix caps for
>     __xlated/jited_unpriv")
>   - Drop former commit 10 ("bpf: Allow nospec-protected var-offset stack
>     access") as it did not include a test and there are other places
>     where var-off is rejected. Also, none of the tested real-world
>     programs used var-off in the paper. Therefore keep the old behavior
>     for now and potentially prepare a patch that converts all cases
>     later if required.
>   - Add link to AMD lfence and PowerPC speculation barrier (ori 31,31,0)
>     documentation
>   - Move detailed barrier documentation to commit 7 ("bpf: Fall back to
>     nospec for Spectre v1")
>   - Link to v3: https://lore.kernel.org/all/20250501073603.1402960-1-luis.gerhorst@fau.de/
>

LGTM. For the set,

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
>

