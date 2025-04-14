Return-Path: <linux-kselftest+bounces-30763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129DDA88D7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DA37A25E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0341EA7FC;
	Mon, 14 Apr 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzVuOzT4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72615575C;
	Mon, 14 Apr 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664218; cv=none; b=V0XcodPzBThM5j8OxvAAxiPm3uRbDuevIvq+esVRjg8YTXDJCDcSL9w5/A+JSu298tT/uMlfILA99WiO4Y3QjDEmqk58BXQmrl0i3bczYZz0N9lVttqk2awkOt5QHNFzjSpEcmT0dxKajDht58N1swK/AxVqBdEzQnv+BZtn5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664218; c=relaxed/simple;
	bh=59DG5cicG2nYVNl6LJKyYhu1RhtD/HerSJsdOedeqQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXQBy45UPvIRgsrtn5rTxLk+qG75o/n2kD8ErdAFbaLQ94ip1JGPcZ/j4ZcbWv/stBEuO1wYe4Vhq/VD17X+LRLYfINKQFMoykoyDqke6ZZ2qQj8E5WLQzeGYKQYYlJOchRRgAS10JlxPMRU9ivxm9gCuhKwe8Y5FX26aXgFq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzVuOzT4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso34860245e9.1;
        Mon, 14 Apr 2025 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744664215; x=1745269015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TcZJJNpo591s6xoFqHx75vVN+ieiVBofj1AeFVZgrg=;
        b=PzVuOzT4fBc3xml+NOLwoW9AiewIoYrS+AxPuBw9aMZ9YWSkvyhtYH5dbkEcxo9B/r
         stCTCKdhU6cqHLXeJiBXBkiMtIrhuF3k/vMSy8ODhxN3RPXEpsFjmBvo6NiOnteZsY9S
         cIOsOjogeKhejhCT+nIln6A01Xc8laP6ev2w5BYOQ8uXr7ca6+SgBrOYhD53WYP+hQ1X
         Wnxv3oMQpYTyD79JFQKzkeBMAlTS2Clw002OQkDFtBMEJRvqyDrMlKSYWz7oCuwDw9hY
         NFEJIxwtzmA7aAcpkR4iJzXxPgHuAwEhflTa0rHSlvLxnxHtBmbTR+uBMMiWGe22/ZAz
         3Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664215; x=1745269015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TcZJJNpo591s6xoFqHx75vVN+ieiVBofj1AeFVZgrg=;
        b=tZrmNXe46eokoYjTG44XVIOnhNkXWlK2so+m6PCs8Go8r/FuVvNLeK3x+bgMkv562o
         pc/8hP6NTs4Jw6ddC2Jz/MWRYcsgoMcEUkATBN8vrNWSlZwKk6f3R3HlwrOD3kLM1VLT
         Uq0ckhdd6aerUVozyXkixtlIclUtmDfhjlabgOgDQ4KcsnFBjk7+GRQRRS9Ub5yP55Xx
         Cik2Cc9UX/Sy08Tx9DAPeKj3l5DTVqaMXXrdAAEH9bPs31se4XD4uDf4IkSHqviBD98F
         gqZUwfTEftQB9sNgC2h8nXWABPQbbxAFtj+P1D3ZX83R1cJT3UV5H32GDfjkcbITBIm+
         MkTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9hRL9ZHFtEmEhx0PCz+tXcRrmfUnmgNzFJKWM1cuFr3MufTEg16j0FHJEYeG2Q65Xi0UswvKfr1a4xCx@vger.kernel.org, AJvYcCUfdgssTDPX71N7y301jCn1TkjTDoIIMo1WuoXZB47aEcadi2NdabZgqfwl9tAd4vsSoDNNM42DFFdJ@vger.kernel.org, AJvYcCUieUCHc+1uAli+HuXiX2E88609zdYIO0lRa7RemaxO0wgByl6IXc471sNJR61L3FfrmL1NBD8b+RE=@vger.kernel.org, AJvYcCV1YGDrP+Q1nCGtZGbgaiRGaJ210lhswG12tMAj6WdYjzmGoVZcWq6np/RxMpnbhGNOdme+fLNnDzYaCeJbp+Tw@vger.kernel.org, AJvYcCVBzcKFsErzncqZdn8MMjDFOde6rGP0khGNYqSqveOmbdqTflrYMrD5fQa/cWpvYTRy5uk=@vger.kernel.org, AJvYcCVhTCSJbRfrBAeJlHNCnFZCALarOCy5yspY12xRmPvY1F0dINepdRpkReQ2s9plQYQCqaW9irGlmBJ525b3@vger.kernel.org, AJvYcCWAyPnL43WxtqznTx1ipljrLwzQFoVUVO2hZiGosULE/+HewMmwIWubylOrH8Ki3R3Ld6F6flRkmrUVDM5aoHsFO+VkS4Vf@vger.kernel.org, AJvYcCWfLxqOvdm3PUs9B6nftTkGZDzyOla2vPDkfdsZy6vspO7SAukbJqB86Q23gHZ3elWkTsncod8TOiGFizlQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxryvs4wzvwZkYD+l4tgCl+58jbqSdGGiJS2lSvRDiKMkMbiwyF
	pVShQXrUij/TMISUhWhRgahLVPHm5sZO5/CXEJtVft8hX8WDeuWy82+91nC5SD7B2dLKGYrK+yr
	RvHGbiIp1cx6lO70z3ep9icQ3CHU=
X-Gm-Gg: ASbGncvPZF5bgBGOEPZ0oXaZYAyVJ+sjN8ATMcLqUZaPH33PWqWvKWNw29xtgscgxnK
	RVzgKd1B2t4/Rcq7npXlk1yQdPdIx90V7b0Nf9BjEBRH8zuaMMKJHfWSPlGvIRUmLv4K4FYiAD2
	KhqK1gV6h+IGQgNoBYqP/gWst2uWd2lTP27xFE+Q==
X-Google-Smtp-Source: AGHT+IFcREG/4yFEmC+ZxV8s2QA/5bd3ZV1RNpvIrg2UOkqeg3XFOew6fBn8aG27bqWGkg7Xi5BfChdrPFBmpTvrP3w=
X-Received: by 2002:a7b:ce16:0:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-43f4aafa80dmr58064325e9.17.1744664214557; Mon, 14 Apr 2025
 13:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com>
In-Reply-To: <87semdjxcp.fsf@microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Apr 2025 13:56:42 -0700
X-Gm-Features: ATxdqUHCb53j5ciFtAcQCnJkNA0yls1KzsDz-H40EWEXDT9mEyWFo_Dj8Pa3eyk
Message-ID: <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 6:58=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> TAlexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >> +
> >> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet_maps=
 *maps)
> >> +{
> >> +       struct bpf_insn *insn =3D prog->insnsi;
> >> +       int insn_cnt =3D prog->len;
> >> +       int i;
> >> +       int err;
> >> +
> >> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> >> +               if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
> >> +                       switch (insn[0].src_reg) {
> >> +                       case BPF_PSEUDO_MAP_IDX_VALUE:
> >> +                       case BPF_PSEUDO_MAP_IDX:
> >> +                               err =3D add_used_map(maps, insn[0].imm=
);
> >> +                               if (err < 0)
> >> +                                       return err;
> >> +                               break;
> >> +                       default:
> >> +                               break;
> >> +                       }
> >> +               }
> >> +       }
> >
> > ...
> >
> >> +               if (!map->frozen) {
> >> +                       attr.map_fd =3D fd;
> >> +                       err =3D kern_sys_bpf(BPF_MAP_FREEZE, &attr, si=
zeof(attr));
> >
> > Sorry for the delay. Still swamped after conferences and the merge wind=
ow.
> >
>
> No worries.
>
> > Above are serious layering violations.
> > LSMs should not be looking that deep into bpf instructions.
>
> These aren't BPF internals; this is data passed in from
> userspace. Inspecting userspace function inputs is definitely within the
> purview of an LSM.
>
> Lskel signature verification doesn't actually need a full disassembly,
> but it does need all the maps used by the lskel. Due to API design
> choices, this unfortunately requires disassembling the program to see
> which array indexes are being used.
>
> > Calling into sys_bpf from LSM is plain nack.
> >
>
> kern_sys_bpf is an EXPORT_SYMBOL, which means that it should be callable
> from a module.

It's a leftover.
kern_sys_bpf() is not something that arbitrary kernel
modules should call.
It was added to work for cases where kernel modules
carry their own lskels.
That use case is gone, so EXPORT_SYMBOL will be removed.

> Lskels without frozen maps are vulnerable to a TOCTOU
> attack from a sufficiently privileged user. Lskels currently pass
> unfrozen maps into the kernel, and there is nothing stopping someone
> from modifying them between BPF_PROG_LOAD and BPF_PROG_RUN.
>
> > The verification of module signatures is a job of the module loading pr=
ocess.
> > The same thing should be done by the bpf system.
> > The signature needs to be passed into sys_bpf syscall
> > as a part of BPF_PROG_LOAD command.
> > It probably should be two new fields in union bpf_attr
> > (signature and length),
> > and the whole thing should be processed as part of the loading
> > with human readable error reported back through the verifier log
> > in case of signature mismatch, etc.
> >
>
> I don't necessarily disagree, but my main concern with this is that
> previous code signing patchsets seem to get gaslit or have the goalposts
> moved until they die or are abandoned.

Previous attempts to add signing failed because
1. It's a difficult problem to solve
2. people only cared about their own narrow use case and not
considering the needs of bpf ecosystem as a whole.

> Are you saying that at this point, you would be amenable to an in-tree
> set of patches that enforce signature verification of lskels during
> BPF_PROG_LOAD that live in syscall.c,

that's the only way to do it.

> without adding extra non-code
> signing requirements like attachment point verification, completely
> eBPF-based solutions, or rich eBPF-based program run-time policy
> enforcement?

Those are secondary considerations that should also be discussed.
Not necessarily a blocker.

