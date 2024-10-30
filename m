Return-Path: <linux-kselftest+bounces-21130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F29B67C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC01C20B6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863112144BD;
	Wed, 30 Oct 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCY+f7Hz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7982144A6;
	Wed, 30 Oct 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301869; cv=none; b=iARNJkxEVbTfN4f2+rZq5iPfGTmUr48e08Lcnmo4lbgHNJCLpvi2TFYJQx9MdVcdHxHgWflJl2EMzkbwyC8PUlJFcWdv7Nu5JKB6QCfNPgeNYbJP2NRouHOiusgkp7FB+ZDGv3+LlLbwUd21HClhqc7KajI2n5/AvcLrszVW52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301869; c=relaxed/simple;
	bh=n999IZOA4rDYc27Hp0H+miRj5tRQoBGIlyVHQmeFAb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYGOWeH8rdOb2gz/VB15/Lkvb0PDv/VKR1RACqf/8fNaOBAzGkBR1p9iJOAnolSMh6FO54ipVmhA+foTMLAGwfsgJnliwZTID0KUfgKguv8HcUmz0ieoJVrvc9K0sXuQpmqioL79FgNkYd33F+mHlEfqfRAjSPm8Ca8pKCW/OVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCY+f7Hz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso992316566b.1;
        Wed, 30 Oct 2024 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301865; x=1730906665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH03TetyHfAgyaa2uTodt4n0nCoJG2QadBNpvOTrh70=;
        b=UCY+f7HziinpdOPcW2+WnKgKq0s6+ba5YaGcivNsd0NT/YBJQAvOt05Hg1i1SpelAR
         ZmiIHAYM+x4f55wIFsbo/YQrPsnYHgYgvBtpixW2ukTDPti5f93U2ryM3/Sp96KOftF8
         IZ5zNtNWF4cpw5lue2ZBkxaFTsuRmWNWSTryhJFcODfamFIVpIgDMgqUQieRisEG1f+l
         XftghNUJm0znNrphrdNEUJp4OBdT3pFcHLTPgoj3uzsqFuttkdXCI3kGSJLXQiMMDoi0
         G6nKv4207U+Mk5ENVfqdgZz8dRxHmo4YyLaqUTTE55MGc0tkgq8GmpMKqJvcGcUH8lr5
         PP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301865; x=1730906665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH03TetyHfAgyaa2uTodt4n0nCoJG2QadBNpvOTrh70=;
        b=U0yHcE8X1DYp18hpIHHzSWLniOu6hyeLyLoucv9zUO1gfcXZ6JYSukUTsHjKNXRI/4
         8/tS7CSjau6teCeygWgNHgU+9nSncJKpwk3KzeHVg6BNu2/SQz+DvL2QehTNBCaGevCU
         TfrK1ITJjNh6D6JF4ERfps45zKXrlp80M/ox5TkoSJnfgK+khH06r6vJgHeXPKHcQnHQ
         c38qrVSG0BpzMw5Ct3S744xTGLBwG1ic0rU6bMetpFPJqk3hXMOHK2YzYqfAvsZPtHrG
         SF8xN201C2GfjqiGPLeDADb82sQU++janJdNpx3wZP3QTSWiBnZ0zKkUCp3J6iE6AeGl
         QzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdOzvY/u3vm6TRNkjULjx/L3aFQPWcLAK6fk7VTtmFRwhUGdkYvshc4NGYTQ9SuVC4WhY=@vger.kernel.org, AJvYcCUzgMGQrke3fnF3ek926oG/DLptGT9bfmH10hWC+7WoXjgpmE1Kih/Ceus0oB5+OprPY2hIT4knypmUgLE+@vger.kernel.org, AJvYcCWVwuMB7Xl7DEV8qV7t11FfWEaImSo0TNX5dHS5CoGaWyTxgecwraG8fNbp+qQZzzzCjWsR0d5qLqH3l9LDBmna@vger.kernel.org, AJvYcCXNyNJxAOxD3yiRcFHUe8o4x3uzLPXb4kK9dmeU9LHzquyvK7lfxj3GrfryDPQHoczB2h2DrE2qSrDGxztuNtzts4eg@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXYTotpkPcftODwaFVuiUj6yC0j0GWlJeqAzUTxiu6AzJk/Pa
	xQfIdl/n9TjVsDuyzB7yt8Djuej2dYZKQo7462gSq9AbYNdtn1rE95vCQUmTSjDiF0HtQ9FwaHb
	nX1Od1GnvqtVhZmnfjpK3GI5OCNU=
X-Google-Smtp-Source: AGHT+IEOif/f/Zl1LrJt+2Gcyo6SzzYJtNymmKKu1iahMKcKCBKKgoSUjNWuEBzxjc1lnPieK9zMO7mK1eUPJ+v9MGg=
X-Received: by 2002:a17:907:9722:b0:a99:403e:2578 with SMTP id
 a640c23a62f3a-a9e3a57531amr379536766b.5.1730301865101; Wed, 30 Oct 2024
 08:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002208.1947947-1-dolinux.peng@gmail.com>
 <20241029002208.1947947-4-dolinux.peng@gmail.com> <CAEf4BzYZgAPZSQTTk20s8vUwDMipe+0HRyKNnQchM+C10-1qOQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYZgAPZSQTTk20s8vUwDMipe+0HRyKNnQchM+C10-1qOQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 30 Oct 2024 23:24:13 +0800
Message-ID: <CAErzpmsuf0e9O4p1srdadoCwn7zNN6rEb8wt5yEOT0FByx5RJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] libbpf: Using binary search to improve the
 performance of btf__find_by_name_kind
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 6:15=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 28, 2024 at 5:22=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > Currently, we are only using the linear search method to find the type =
id
> > by the name, which has a time complexity of O(n). This change involves
> > sorting the names of btf types in ascending order and using binary sear=
ch,
> > which has a time complexity of O(log(n)).
> >
> > Another change is the search direction, where we search the BTF first a=
nd
> > then its base.
> >
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 159 ++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 140 insertions(+), 19 deletions(-)
> >
>
> same complaints as with kernel-side implementation
>
> I'm not sure if this is the right approach, overall. I can see how
> pre-sorting might be useful if done by pahole. But then I'd say we
> should record some bit somewhere in btf_header claiming that this is
> sorted BTF, and then if that bit is set and we confirmed (on the
> kernel side) that sorting is indeed correct (and if not, reject, don't
> silently ignore), then we can use that sorting to our advantage.

Thank you, I also agree. we could utilize a bit of the flags within the
btf_header structure to indicate if the btf file has been sorted.

>
> I don't think libbpf should unconditionally sort or check sorting in
> the way that you implemented.

>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 5290e9d59997..cbf88a6b92e5 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -94,6 +94,10 @@ struct btf {
> >          *   - for split BTF counts number of types added on top of bas=
e BTF.
> >          */
> >         __u32 nr_types;
> > +       /* number of types in this BTF instance which are sorted by nam=
e:
> > +        *   - doesn't include special [0] void type;
> > +        */
> > +       __u32 nr_types_sorted;
> >         /* if not NULL, points to the base BTF on top of which the curr=
ent
> >          * split BTF is based
> >          */
>
> [...]

