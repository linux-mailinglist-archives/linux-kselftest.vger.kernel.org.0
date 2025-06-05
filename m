Return-Path: <linux-kselftest+bounces-34378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A5ACF3CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47F47A681D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560FA2749CF;
	Thu,  5 Jun 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfuKyTca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118327465B;
	Thu,  5 Jun 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139808; cv=none; b=jFcO788qlgC1R0dpFSoO5U5tZlohHHbKe0kauzndpgubnzya2ohFlExdkjk369rmX6EOccfItGCwlmFKHBZsPN58LzpXNFv7/lXbrNctwDMjHRWipIAZhR8NKIwMTcbqY1WnB8DYe1QSa+3S6e8/UUk7N9JOiCIArHInupGXd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139808; c=relaxed/simple;
	bh=YnIQvPD9lJYDOlBpOrCy1ioFdRL5RyD0q+hZaolXlzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn5pWzuZdMpAIaUseEMEeFekcvFyaCnOVbyneo3RAe0G0Zqzc9JxxkKeBVL0JoDHefh0p+87HoE43fLjzotMMsZQUgCPmF+qziqLSoGisVpMmPFLeVYBRHjZH6MpgIdOdkWTZb/ZOjEbSRhN80V28Y/8ozVrjMfjU3Sumowgoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfuKyTca; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3673e12c4so741579f8f.2;
        Thu, 05 Jun 2025 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749139805; x=1749744605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnIQvPD9lJYDOlBpOrCy1ioFdRL5RyD0q+hZaolXlzo=;
        b=ZfuKyTcaeJFqu+dTkbPlSa7ggOFULpTlQC0g4os60Fxs9toYm9QedRnswqwwPB0qtM
         d4kq0tj94rZw/EGp99Hl5jXMwlI74USyXppVjuQXZngYp69zfb57C+3kK5AD907S6MFy
         YdlpGlHzNqRhGIdxzQu0lja7DzWsXVeEK58VGUyjivC5DcWiACHH/my26n38VXG+rMD4
         bfnWuJuDwkFfx0n0vYxDCWZaJSA4ebQUqhERQboADu7qpL7RRLFYg2ACyzASQw2VYeDy
         Z3lZrDtDWJxa+wESUIvNINVdrZsCRHvffVwa1SSaHdNmxMuP28si3REGpurut0VU0bV/
         qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749139805; x=1749744605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnIQvPD9lJYDOlBpOrCy1ioFdRL5RyD0q+hZaolXlzo=;
        b=vi+WHxLFmjDlPVV5+WXVUs73ef8DptcbpfV/F6+aBBd5IfpZ1cU/bgquwwcVO/92ni
         0Pn9h3Gj0JEoW3lJL0Wx2AKHf3zi/ohDAuPKQHhumV1RucS09rajB2dtWQFaygIheMKE
         8dRNZjL+aZSi3oxeuHgLwKaDHRXAvzdSMTHPJODSLOmAO9K/sSKrpRJw5UpEKR27zk1E
         s2fFNLbbx2M9+WIeQoT5aGlG4SEUqeSBK4fq/41uc4sGZTXp4F8IR2Uo1+l4kibvjE3O
         W97+CNckZlN3uo13Wi4bcm4DhC09uSTAGwwXx+w/BRsvR6G4iYbpUMwPvPvq4u3O7mnB
         Yq7w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1xrYrB6eFDe4rNOkEXKd4uZ+UMNjzGsRFgg2Zu7GbcF45F4QgWJZCIlFf9dPkKZyxahhfxjPqQ==@vger.kernel.org, AJvYcCX0MCDNvEBFXRBrxn7DNiVVVcYUFLyXRRyR76bDro/WOhL4T5YnFaq0vMo4XPI+yhn7eFqjWxHw/z29VQcw@vger.kernel.org, AJvYcCX4Ho6zlCGbRYw9yU6RTyRgbfB5nXBniZ2y3MZE75hsJKl9tk4UeSSPmGnnHn0hPPGXMfevwB5+sda9ydOLPRJC@vger.kernel.org, AJvYcCXsoUU8pcESvspGYzsM0eNqvjHZtEmDXv4h9PQEcxk4sjJSBuxDiGnbdBcVAtDixVgT4g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU85nEDqW6PtPQTbDGotUinYSZU3Qi+Tyuvxx7ml/17iftQ0q5
	oXMMmcl1EANaETli/mds4zGXVsklpfokmRdLFbkpe9Txn54PczQctZIrkDYIQz7obBXUJ6fXmeV
	ce/HCsmmhta5MVchiuZkVToQnA/en0Aw=
X-Gm-Gg: ASbGncsE0/kKnqrrSF8kNEosTzO0r4e5b5UrDKPqg2vcHvdeZkv5jqMvcgU1J4ok+Jo
	fFNFixpmEXkTnd6j+CIu5H1K478YN68R7DHb8n3QghYA+X6hOr0vNmrK3c56mESMhVro6hXdBm2
	HuqKe1guNgrUvHY1ICZs7vJiPkdkFzt5pAUMHqoU1kb5GeobhqFKMt2VPhCDzGW9bUDikD+Q==
X-Google-Smtp-Source: AGHT+IF4/r/MeCk1ofRbXjeQgnJMl2fjGGz6lBVtftByV5fvMH1+Rl6IDv+s6YX9w9uN5TsW5ALs3oMs2ojfpEr5ugw=
X-Received: by 2002:a5d:4291:0:b0:3a5:2875:f986 with SMTP id
 ffacd0b85a97d-3a52875fc63mr2749955f8f.44.1749139804629; Thu, 05 Jun 2025
 09:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com> <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com> <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com> <DADMLIVHMSSO.3AXSI5216WCT6@bootlin.com>
 <9a2ba0ad-b34d-42f8-89a6-d9a44f007bdc@linux.dev> <DAEFD2WH7HRV.2SOG9Q00QSEXH@bootlin.com>
In-Reply-To: <DAEFD2WH7HRV.2SOG9Q00QSEXH@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 09:09:53 -0700
X-Gm-Features: AX0GCFt6yH5UVLu_OY8YyoKeWCoB2_l0Zw4RyPbCo3gsHpLrUJ01bzW8146d9WY
Message-ID: <CAADnVQ+T_s6dAwJ5JKqNqA8tq1P+MdfPvPw0EoY5yOf8PnGT4g@mail.gmail.com>
Subject: Re: [Question] attributes encoding in BTF
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Florent Revest <revest@chromium.org>, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:35=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Ihor,
>
> On Wed Jun 4, 2025 at 7:31 PM CEST, Ihor Solodrai wrote:
> > On 6/4/25 2:02 AM, Alexis Lothor=C3=83=C2=A9 wrote:
>
> [...]
>
> >> Could I be missing something obvious ? Or did I misunderstand the actu=
al
> >> attribute encoding feature ?
> >
> > Hi Alexis.
> >
> > The changes recently landed in pahole and libbpf re attributes had a
> > very narrow goal: passing through particular attributes for some BPF
> > kfuncs from the kernel source to vmlinux.h
> >
> > BTF now has a way of encoding any attribute (as opposed to only bpf
> > type/decl tags) by setting type/decl tag kind flag [1]. So it is
> > possible to represent attributes like packed and aligned in BTF.
> >
> > However, the BTF tags need to be generated by something, in case of
> > vmlinux by pahole. Pahole generates BTF by parsing DWARF. And, as far a=
s
> > I understand, attributes are not (can not be?) represented in DWARF in =
a
> > generic way, it really depends on specifics of the attribute.
> >
> > In order to support packed/aligned, pahole needs to know how to figure
> > them out from DWARF input and add the tags to BTF. And this does not
> > happen right now, which is why you don't see anything in bpftool output=
.
> >
> > [1]
> > https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linu=
x.dev/
>
> Thanks for the details ! I have missed this possibility, as I have been
> assuming that DWARF info was exposing the needed info. I'll take a look a=
t
> it, but if those attributes can not be represented by DWARF, I'll have to
> find another way of getting those packing/alignment modifications on data
> type (eg: re-use/share btf__align_of from libbpf, as suggested by Andrii,
> but it may not able to cover all cases).

Not sure all the trouble is worth it.
I feel it's a corner case. Something we don't need to fix.

