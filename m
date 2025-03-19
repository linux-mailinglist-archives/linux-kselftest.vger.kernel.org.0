Return-Path: <linux-kselftest+bounces-29405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B8A68339
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B3019C6469
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 02:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E741209674;
	Wed, 19 Mar 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9fzD6cz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30815145A18;
	Wed, 19 Mar 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352059; cv=none; b=fJ7bEi3vi4zohT2C+R2w7HNEd5KkfbEFQFieSti808g7YuF+r0D5ba93EOFWkFooagSDU1zXwA1ioewV2+Wbj/8rVI1Nxcj3D52M7eeVA0wbpUyHmgnVfxe15OlqY9SWaBK6z+7nqe8DTnQnv72GhkU9NLkFu1oGfSErM3HubWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352059; c=relaxed/simple;
	bh=E9i51D+sRDYe7TIlKQ1t9tMjTNjd9YGS/QutLm8JaFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwXROgD42JDZ1kCIQ3lczysclvRSQaBaEfQT9ibxuPR3YjOS80K5pRi2bpRwri2ClpYG2u8DaiZ4+8bpe0Rz9BWa3GfxDDh5LVbHiRG23muE3jHpJ8GzE4+TkoOh+Jh0j92dJgTq+NaLPS8dRhkCIZJ9qN/sFTYyfIgXc7uhgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9fzD6cz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913cf69784so5327702f8f.1;
        Tue, 18 Mar 2025 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742352056; x=1742956856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeqBB++rcOx94nz1IuSE0ME1aOopqq+egTiTenlENkM=;
        b=A9fzD6czaWgqPHgPTJWQwI72INyjZfHnqrNa+m9vUmZatNGjffxiSLMTZKWMicWEWX
         P/kJeDGR/rgK9ldg/iuMlLcMvel+AzHxKv55gdstRs/Gm+4MIt9DhNQEXlHumBsXKFyQ
         mRutAoJjWBatoBByWsh8Yw9M1sfw7nnxRkpU6hJOEWehIAR4rn5K2x+zMRnZFvpnRm/P
         y/AGN1kv5PloH1BoT7XT8d4FTXY+KKqpCkWHh4xsuKtX3MCi7jH30HU14cdIG4KYEs9s
         UTxA2zVv2csM9BR2qsM3CODVplSRjTKcdO1NVyGh4Uak3j5DjXauuvt8FmY1wkZuNwET
         ys4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742352056; x=1742956856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeqBB++rcOx94nz1IuSE0ME1aOopqq+egTiTenlENkM=;
        b=UxINhRNIPrEt8y2m3yNhZnP2btyyr0OO8vhElK3uEmw+URqMbtf1aBAICQoh2BNuSs
         9s7Wl8bSqgEjMMb7uaTYSiMXKdVFwB43JNuLhWuOtBLNq9HAtcN9PpWlZ19bAfxMrCKg
         c0OiRp2HgILNu8AoEBVsa/RcwNqkOjnQay/zabpdce/CdVolggOySYvVJr+5a9kxah0T
         YY5uAv5d4y+aGf6FF9g5dm3udrG8XcBNkDPtYqbGwUQTn2dMDOlndL74a/ABDSB2IgqN
         aCbJR6LLStksxoxbq7fAOkulsVwAf4RpL0dGu9rznks4XeG9r8Vr8BdKmYk6R1lFJzD7
         8oLg==
X-Forwarded-Encrypted: i=1; AJvYcCVUNU9x+jqRGaaK63iTCyHSehllaj/qXRSkfSRMiNf8wcMo4FVF8wEWKA+iwzjA8qj/XyM=@vger.kernel.org, AJvYcCW/nGsQLxqpPVSuIs4fat3A/GtLB3UvHW9pTmk8qhTnwUHVdtD9MY2P47zjzh6h7dsbps029PhIPRzFUx67p/6T@vger.kernel.org, AJvYcCXJJe6yjH0l2GIVgBhIQ0km317og1sW3KHyziKe2KcCgTf0xdcSEMHVm3ebDcGtiSoH4AkusHWRbVI0t1zv@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwss2TcWKYC7ly9rlRuOno6rhze2A+nGf1bu06Q0iFcGlC8RD
	9vB6ssLW4I92aOUO8yNyyKUT9X7PFgayIb97WgkSXDH87+IKK9lqoU33QV4ur7dHP3DZrs88Cqu
	Yi6tQ4FGIQflh7XExPqAxhuCok5o=
X-Gm-Gg: ASbGncuuOYanJNza1o/Pdhc2d/HAZH/wvFhBRVUJcKAgK7TBEmP6zCOe2aFBqvA/y6Y
	GUxummNs5knrskCgls8etuaVz3Z0rPLuWpxfps27rOEPHRofA21D87nfD9ZPANyNRkbfgD6C6pa
	GYF/psRZ7E1tWuXZKUbqjAU9D5a9vrHAC/E4KDffwRHUwAFPAtlL1P
X-Google-Smtp-Source: AGHT+IEq4Cvjw+V0zW8HacPzY7dpEsXkttELmIjzb3h1MDYt7G6p44IBkRudTjyMAKCZQZF68Vdm9Bd7RVSCNEeyHA4=
X-Received: by 2002:a05:6000:2a6:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-399739b7c7cmr810733f8f.1.1742352056133; Tue, 18 Mar 2025
 19:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
 <20250313175312.1120183-1-luis.gerhorst@fau.de> <20250313175312.1120183-2-luis.gerhorst@fau.de>
In-Reply-To: <20250313175312.1120183-2-luis.gerhorst@fau.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Mar 2025 19:40:44 -0700
X-Gm-Features: AQ5f1Jql7yFmS7_MWNSMia475Ma-4TwbNZCE_S5_030qdEibYwvwxGNs5a0zSMA
Message-ID: <CAADnVQKL-NwxigMWM+U=n5ZXPG+xHYzSTEv0Rq8Y91m45eRJDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/11] bpf: Fall back to nospec for spec path verification
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
	Henriette Herzog <henriette.herzog@rub.de>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, George Guo <guodongtai@kylinos.cn>, 
	WANG Xuerui <git@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, Maximilian Ott <ott@cs.fau.de>, 
	Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:57=E2=80=AFAM Luis Gerhorst <luis.gerhorst@fau.d=
e> wrote:
>
> This trades verification complexity for runtime overheads due to the
> nospec inserted because of the EINVAL.
>
> With increased limits this allows applying mitigations to large BPF
> progs such as the Parca Continuous Profiler's prog. However, this
> requires a jump-seq limit of 256k. In any case, the same principle
> should apply to smaller programs therefore include it even if the limit
> stays at 8k for now. Most programs in [1] only require a limit of 32k.

Do you mean that without this change the verifier needs 256k
jmp limit to load Parca's prog as unpriv due to speculative
path exploration with push_stack ?

And this change uses 4k as a trade-off between prog runtime
and verification time ?

But tracing progs use bpf_probe_read_kernel(), so they're never going
to be unpriv.

> @@ -2010,6 +2011,19 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>         struct bpf_verifier_stack_elem *elem;
>         int err;
>
> +       if (!env->bypass_spec_v1 &&
> +           cur->speculative &&

Should this be
(cur->speculative || speculative)
?

In general I'm not convinced that the approach is safe.

This recoverable EINVAL means that exploration under speculation
stops early, but there could be more branches and they won't be
sanitized with extra lfence.
So speculative execution can still happen at later insns.

Similar concern in patch 7:
+ if (state->speculative && cur_aux(env)->nospec)
+   goto process_bpf_exit;

One lfence at this insn doesn't stop speculation until the program end.
Only at this insn. The rest of the code is free to speculate.

The refactoring in patches 1-3 is nice.
Patches 4-5 are tricky and somewhat questionable, but make sense.
Patch 7 without early goto process_bpf_exit looks correct too,
Patch 8 is borderline. Feels like it's opening the door for
new vulnerabilities and space to explore for security researchers.
We disabled unpriv bpf by default and have no intentions to enable it.
Even if we land the whole thing the unpriv will stay disabled.
So trade offs don't appear favorable.

