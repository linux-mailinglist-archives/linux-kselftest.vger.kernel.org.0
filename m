Return-Path: <linux-kselftest+bounces-31617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE304A9BB6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3431921D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3628F53D;
	Thu, 24 Apr 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrZcRxo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD228D850;
	Thu, 24 Apr 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538117; cv=none; b=AoOuz8vgA1DIqgT5gjM/SFbI6cU79TQFOmYBopY43wqTCNBGVlcnVWLx5uQk47QwraVoaBtW83sBn5loZGgUsaShm1zinWutUdG+Lh3LwGd9jJCDDHTS1YlzuZeOjAlC6HmCmX5WuPmZsRudoziYD2Bp3pnDW8sFrKdhgS7vCvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538117; c=relaxed/simple;
	bh=RPTxBkbH9A8ifRnn+WjYkSgINVnGKcdTM3iQNtEfaRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtafjfOKS6jqbUfJxqHv0V1hSQSusdBI29N/JPmLw3rMF8FvaG/MMMlTFQ6/mMWyniIbRpflMx1rf7G2toWNeY8oBKbeQUIFXrzPYqn6ssaif8uFvarTOEpD/KwvEmHoF0YscRRL4XvxXRutyKRgz7BMUD4xt0ui7vJ1HyaHUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrZcRxo2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1267498f8f.3;
        Thu, 24 Apr 2025 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745538114; x=1746142914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++aXbzVblpKG8Wdpinq9Se3gJFCNKU+xCUDkz1Ba3PQ=;
        b=YrZcRxo2yB5/e7W5vTJ4kJkDpC4kSD56+bgi2oGF1CGJf04Q6gsIRXLmj/29BiN02A
         t8SbRu5MhAjhowvTIooH74ZPwqxGIqz94lCJo3aQUNLLazfqoqRcuoOIf/trSCmgmn8n
         Q8eRVoP26qrnJAAvpjkOLLqNKexaRmbPkIPqhsLL8lpzynsQV1xFDj89snGZS/L773tb
         rtBPTJ40PLRlP7GNMTodT9NrQgJv1OMIOjjzKjWdkOcVoUYjR7Mfy/sfj4VGV6GPua/S
         c+9wO4BX96gcfVLXxdNEwQ54wBoFWZ7hlacsm0JhNh6v/3wpiv5RrrtAGcYKzxQslWSe
         R6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538114; x=1746142914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++aXbzVblpKG8Wdpinq9Se3gJFCNKU+xCUDkz1Ba3PQ=;
        b=C5lBZ8V2RKPFsI3lb2V9DJldA4smG+XUKuZsM6ZBl2Tcor4shNJXWwusPGgsz01Rx6
         MOCOWKK/J3tqnkaRfA5gthhK1YvGN6YO3JIlJhVree8lv/iMFOsTM5heFlyp1cGAEx55
         kxzYxOgjOWjELuwjG6Yj66ZMelIjopATCSi+hM9qu66lTdh/XlszikznXbbGTPGP+p7D
         ajis4niqDSO3jqTVjhakYIgQWUYyEqzh+bIBccOgPqhchkVZ86GodPt9Y/5BShCK1e9a
         6YwaO47c7Q/Z5t1hG5i67cvY2k6BDMgcN9Xyc/O2LONbiNXE96oNqCH0CsiJQi7GKn2/
         dW2A==
X-Forwarded-Encrypted: i=1; AJvYcCU+Tz+7zNB07sH9FYfR7BG+UdycbtPY3uF7cr9vJucFiZGTAysEJ/G8qTLBv7Dd+GAjfTX5phMLMzs=@vger.kernel.org, AJvYcCUa0RgGiWHfvFbd8rSO3PEG8+V/vp+eqkQ7ibyLTN2BNWXs1+Fgal/alU+0+57kGylzzQi1uV/cAE9NAR9rs1ODyibG/bBZ@vger.kernel.org, AJvYcCVCGRHsJ7CVUF7MpsJjKTjwbPLXrAQJe2xNUN4O+APhTJbMA8iILmb7vGVDtQMmD0acUGGjpnlxTXjzt1ex0IUM@vger.kernel.org, AJvYcCWOVBxX3Nf1KUs3okt7dVZ/2v1hU/2pS4k+YwxGHnbZDgE6g2yNPDcUrfcdvaYXXvyBRWy7EokDH6c7Y5LK@vger.kernel.org, AJvYcCWWTMoRuSnF6YfKNaUmAUSxHOaBvdtbAxTU0iPpSayc7fOutEmb3ZPGtlPyp25psg2wqX4toCGOJ4E2@vger.kernel.org, AJvYcCWbsmlHtxHPhBZv+FVeTaqEg5ZIeqxplt2trOCCchfm8CaKvHVKdm2ydyUMb0NmDN8IdlAReod1B0s5Wlpr@vger.kernel.org, AJvYcCXGsEeqyndDxwRFpNnal61pEMmIYqxw45/qre3XZ7NUa4JfNUf7OkAg8c6JWGQH41oO1HSAxRj05qytjlYh@vger.kernel.org, AJvYcCXQpqE5JF0tpwKwzh/ZlZ4wPfdIN6sNjhtl7GnGiocIlduBrfvLxgXERoHcETGHnzzBzy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyBseOM+umWg9i+xinAjWKctveBmwXuwZUc+i07KFZ2wWxQ3w
	3HKewaQ3MUK6mgoznXd5iQo11hANZonhRbvCSj2USt0qf+AcnrjWtjv7bQhHv69lhFEk+M3ApIK
	H/lGOAIkqmdVARYxi5ODUIWX4uSA=
X-Gm-Gg: ASbGncs8Tiqp3xwB+CXxc/R1YbTrKeQJm16RRyqAktY5fDOwVdDbcBzpbVeupUBjoP0
	0nPi+jXVoYX76y49Nj/gpWZSQS9ttJVOtExgFySFDa8xCCRI11iNIWU/O6m8b6mNhZjEdAanAl8
	wfEJQg5ZtB320W5kaRkdwYS4f7qvXiaFCohvUrjV7SauVir3Ta
X-Google-Smtp-Source: AGHT+IHKHTPUeCJbp/2K9OpvypUGo3fHAzmM52oJ/sIEmUDEupOSZOiZupc2hYCRKYbQoWZlx5V2SSGQrb0bFiUjwSA=
X-Received: by 2002:a05:6000:402c:b0:39e:f51d:9cf9 with SMTP id
 ffacd0b85a97d-3a074f42e7amr28887f8f.48.1745538113966; Thu, 24 Apr 2025
 16:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
 <20250404215527.1563146-2-bboscaccy@linux.microsoft.com> <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
 <87semdjxcp.fsf@microsoft.com> <CAADnVQ+JGfwRgsoe2=EHkXdTyQ8ycn0D9nh1k49am++4oXUPHg@mail.gmail.com>
 <87friajmd5.fsf@microsoft.com> <CAADnVQKb3gPBFz+n+GoudxaTrugVegwMb8=kUfxOea5r2NNfUA@mail.gmail.com>
 <87a58hjune.fsf@microsoft.com> <CAADnVQ+LMAnyT4yV5iuJ=vswgtUu97cHKnvysipc6o7HZfEbUA@mail.gmail.com>
 <87y0w0hv2x.fsf@microsoft.com> <CAADnVQKF+B_YYwOCFsPBbrTBGKe4b22WVJFb8C0PHGmRAjbusQ@mail.gmail.com>
 <2bd95ca78e836db0775da8237792e8448b8eec62.camel@HansenPartnership.com>
In-Reply-To: <2bd95ca78e836db0775da8237792e8448b8eec62.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 16:41:42 -0700
X-Gm-Features: ATxdqUH6sfn1n7O-XtBH84L_ffinqPSTcAgsLr1DgVXlhHPwzgkdSH_nw0dH5ao
Message-ID: <CAADnVQJ6SRePz7yc5x3BAz7q-e8DVYq=vRdahxCZ4XzpWtnYpQ@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
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

On Wed, Apr 23, 2025 at 7:12=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-04-21 at 13:12 -0700, Alexei Starovoitov wrote:
> [...]
> > Calling bpf_map_get() and
> > map->ops->map_lookup_elem() from a module is not ok either.
>
> I don't understand this objection.

Consider an LSM that hooks into security_bprm_*(bprm),
parses something in linux_binprm, then
struct file *file =3D fd_file(fdget(some_random_file_descriptor_in_current)=
);
file->f_op->read(..);

Would VFS maintainers approve such usage ?

More so, your LSM does
file =3D get_task_exe_file(current);
kernel_read_file(file, ...);

This is even worse.
You've corrupted the ELF binary with extra garbage at the end.
objdump/elfutils will choke on it and you're lucky that binfmt_elf
still loads it.
The whole approach is a non-starter.

> The program just got passed in to
> bpf_prog_load() as a set of attributes which, for a light skeleton,
> directly contain the code as a blob and have the various BTF
> relocations as a blob in a single element array map.  I think everyone
> agrees that the integrity of the program would be compromised by
> modifications to the relocations, so the security_bpf_prog_load() hook
> can't make an integrity determination without examining both.  If the
> hook can't use the bpf_maps.. APIs directly is there some other API it
> should be using to get the relocations, or are you saying that the
> security_bpf_prog_load() hook isn't fit for purpose and it should be
> called after the bpf core has loaded the relocations so they can be
> provided to the hook as an argument?

No. As I said twice already the only place to verify program
signature is a bpf subsystem itself.
Hacking into bpf internals from LSM, BPF-LSM program,
or any other kernel subsystem is a no go.

> The above, by the way, is independent of signing, because it applies to
> any determination that might be made in the security_bpf_prog_load()
> hook regardless of purpose.

security_bpf_prog_load() should not access bpf internals.
That LSM hook sees the following:
security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
                       struct bpf_token *token, bool kernel);

LSM can look into uapi things there.
Like prog->sleepable, prog->tag, prog->aux->name,
but things like prog->aux->jit_data or prog->aux->used_maps
are not ok to access.
If in doubt, ask on the mailing list.

