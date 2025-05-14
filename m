Return-Path: <linux-kselftest+bounces-32954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3971AAB72DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA4A868286
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC5A27A139;
	Wed, 14 May 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoM4SWV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C041AC458;
	Wed, 14 May 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244112; cv=none; b=IbgapnMcjIVLbuIYVarXC/eyF3LfgkOX1vD6F9x+/adN5AcX9xiBc6NTN46G0kuuIJK9qO24lsG0xXyRcnnuqhD+C992hPY2uD/2LWKOnOwzCbx60g1VGHazmSCw+m675ePP2RsCGKtravkkmYppN4VkK4JEKK+UXgsQg78ijsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244112; c=relaxed/simple;
	bh=7nwNgpN0cnCxJKCNbw0aN9awUsHMoztY59VcKdPHPoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMY6O7ZxXJDwLkvYfjtEn4/BTIsJYPx4jixn/MWeAXP4t2pTWisIcTZj0OJyGtMO0YWk0NQ8vEGVKgcSOpaWeWVU/ss2rhWd1tSvat6hoFEhYpJATftfJmZk+BvR1wcn2FY9m9QxOKplbEWyuBKeYvqlaTah+zinaHqOGnEnCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoM4SWV/; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so11270566b.1;
        Wed, 14 May 2025 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747244109; x=1747848909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFdlJ6N6MHe++MwGWkILbc9+cPIo/XiWxbVEpXS+OnQ=;
        b=FoM4SWV/l2TyNJbDnAfuanoaEX7wK+Jq8dT3ozkjVAE/TKc/GWAOqQe+Vot3UKUmzc
         ILsilav6pJDfStnwYAQvda7zRMZpMF28CYBpXYNHrSvAQ1QkVrMGWY7tvrQ1Sc0+0sRD
         nWEzaEdzYftGMNTBQEJfS+Q/bplSwe4mYb65vMyOAwyk+ND/47Vt6aNna0BsBr6XOm56
         AadYuPPfBH/3qZQUZ4z9s+SZRtwVf4YC8kMCKUj6oh1NNg2cj/K8vIeuYPTgzOZNftgm
         Fs1fy8//MQYVynAGBKJJ1Eo84UrOLESdXXf8oFSPrs0T479+uAUHJAjOAM6B+ENQPsai
         weQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244109; x=1747848909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFdlJ6N6MHe++MwGWkILbc9+cPIo/XiWxbVEpXS+OnQ=;
        b=vxmghXAsfE5votiTwYvOYD4stQliHPKtYNjz/2ttW9vOYXBaKT7zpHQ2g2hEMTUzCq
         9U5F7sxhue6gVW2abhmP+w7/YKZb8d+7E2aRtJchhsE41BbVfrp/nr5hZYcfsEE+GE+v
         NF0IYf/xkebYxXAM7u8GGH6SXY4V6kqln+tkrZ4tR1PGO9k1qbis4F3LZASFx8xfXByK
         ecceP8yyNQ+H66vHXX+wnTchxxUvyvB1/P6uVKaIyQi5ss0q3rRQvK/JMC8DnCfCtSxo
         OMqvOHfniOD3utitdN15Ytfs/SqQRPbQxh2hIjKv3jSEDQKBCOazkjzYJstCsa05lvLW
         3Pcg==
X-Forwarded-Encrypted: i=1; AJvYcCVR0WDKDlGeCoYfefcTf+JRCoHg7fUFfR9yitIewUNvDX25uZWcXP5l08BIoZpuqZ7XqX+FbXdp6kWhf2qM@vger.kernel.org, AJvYcCWMA8FmE88z3LeDMNx6GWslu8BokYLc6decE83saL/9/Q7qh65CODSqyVZT7yjmnM5A8UffEC7m/V1GmFHxX5Bg@vger.kernel.org, AJvYcCWsZ/psPKj6sy0MD9bwNeNRoDCgR0KgV30kPczvqNf6OrZpboi8vV04dImlYOiT0Xwk6jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07+UhpNr7OQ9i3O698jwJsbg90t7ZeBLnRkyYKvcf+lHVHK/m
	yQ7HS4r5vqYWB0RyTcAURH/cwl4SPTgEl71U9CRhMQaKq9mao/wGekvDZ8vTypJrbIe2rxL4/Cb
	HqGMVK6BLB+LxOKVSAK62NXrRo7o=
X-Gm-Gg: ASbGncuqP5iYl99z79t6DVXpogcU4jTwrGDum/e2vHx9bZayTW1J4amKrGJrBz9F0+H
	BxsXdXHbiRdud1BsYDTmdMapkypvDy2y/0Z14jOnVV7AOgN0lbGqOYJWef7B4EH188IQVvNUwZ/
	jzQo8c1bRBk7Qw04W1G0vcd7/GBPJYmxnX6THSDtZk70JPmo6B
X-Google-Smtp-Source: AGHT+IE+VwudLGlVqV7MTPJNv/2IatRwQ5fmgPNY2cQCAUPG/OX3YqdyDUfjFCe1H9Ew0BhHDSRLrN8kqa+WikFcqEc=
X-Received: by 2002:a17:907:8747:b0:ad2:4787:f1f4 with SMTP id
 a640c23a62f3a-ad4f7114433mr410241466b.15.1747244109100; Wed, 14 May 2025
 10:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
 <20250501073603.1402960-12-luis.gerhorst@fau.de> <CAP01T76jeSg3W-OyfBfSbAjpEhBr_h8rbS-Hubk6gDdrkeEj_Q@mail.gmail.com>
 <87ecwr14mt.fsf@fau.de>
In-Reply-To: <87ecwr14mt.fsf@fau.de>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 14 May 2025 13:34:32 -0400
X-Gm-Features: AX0GCFtOVfH8muGhMGHBFxUVlaXx-8L6TgNxC77DPS2kBNNOVj7O1t8HiDkeHPo
Message-ID: <CAP01T75xiWn56dtpS06Vm9sMRfCBv+uHNe47Fh5hqu+4xCxOiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/11] bpf: Fall back to nospec for sanitization-failures
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

On Wed, 14 May 2025 at 13:30, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> (including relevant part from other message)
>
> > On Thu, 1 May 2025 at 04:00, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
> >
> >> +static bool error_recoverable_with_nospec(int err)
> >> +{
> >> +       /* Should only return true for non-fatal errors that are allowed to
> >> +        * occur during speculative verification. For these we can insert a
> >> +        * nospec and the program might still be accepted. Do not include
> >> +        * something like ENOMEM because it is likely to re-occur for the next
> >> +        * architectural path once it has been recovered-from in all speculative
> >> +        * paths.
> >> +        */
> >> +       return err == -EPERM || err == -EACCES || err == -EINVAL;
> >> +}
> >
> > Why can't we unconditionally do this? So the path with speculation
> > that encounters an error (even if EFAULT) is not explored for the
> > remaining pushed speculative states. If the error remains regardless
> > of speculation normal symbolic execution will encounter it. The
> > instructions only explored as part of speculative execution are not
> > marked as seen (see: sanitize_mark_insn_seen), so they'll be dead code
> > eliminated and the code doesn't reach the JIT, so no "unsafe gadget"
> > remains in the program where execution can be steered.
> >
> > So the simplest thing (without having to reason about these three
> > error codes, I'm sure things will get out of sync or we'll miss
> > potential candidates) is probably to just unconditionally mark
> > cur_aux(env)->nospec.
>
> [...]
>
> > Hm, now looking at this and thinking more about this, I think
> > recoverable error logic is probably ok as is.
> > Scratch my earlier suggestion about unconditional handling. I guess
> > what would be better would be
> > handling everything except fatal ones. In case of fatal ones we should
> > really quit verification and return.
> > We may make partial changes to verifier state / env and try to bail
> > out using -ENOMEM and -EFAULT.
> > So unconditional continuation would be problematic as we'd act in a
> > partial state never meant to be seen.
> >
> > The logic otherwise looks ok, so:
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Thank you very much for having a look, so then I will leave it as is if
> I understand you correctly.
>
> Please let me know if "what would be better would be handling everything
> except fatal ones" was meant literally. Such a deny-list approach would
> likely be:
>
>   return err != -ENOMEM && err != -EFAULT;
>
> I initially decided to limit it to -EPERM, -EACCES, and -EINVAL as I was
> relatively confident all their cases were safe to "catch" and because it
> already had the desired effect for most real-world programs. However, if
> you find the deny-list approach easier to reason about, I can also do
> that. In that case, I will review the remaining errors (besides -EPERM,
> -EACCES, and -EINVAL) and make sure they can be caught.
>
> Also, thanks for the pointer regarding sanitize_check_bounds() (sorry
> for the delay; the message is still on my to-do list). I will address it
> in v4 if it is safe or send a separate fix if it is indeed a bug.

Yeahl, that's correct.

My only concern was if things shift around we return -EBUSY or whatever
(even though it's unlikely, but you get the idea) it will be missed
and we may break use cases we were permitting? Definitely need to be
careful either way, but I guess the surface of interaction for unpriv programs
is relatively set in stone so it won't matter too much.

It's probably better since you've audited paths returning that error
which do not leave things in a partial state. So I guess we should be
conservative and stick to the three you have right now.

