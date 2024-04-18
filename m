Return-Path: <linux-kselftest+bounces-8302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409398A956A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6F4281AEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D115AAD9;
	Thu, 18 Apr 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvR69bnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C015AABE
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430529; cv=none; b=A0U0XuqlL/oE18woDSmWRi5AGF9CCJza870V2TmTECwLNKFkI15P3nmztiPLqQQDcbtXSsSTMLT0XTXP45UcYKixv+nywAnlr2AZxnCU1PAF+twry5rZP63sNciOZo1rzmoCGEN4Bmx2K6dzCSzkQMZpyEStbkE27BBddlLSZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430529; c=relaxed/simple;
	bh=/tb4QbVu8c2QRsgW5XBC6GGQL9b2y9oos5e54hq7gZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuboodJuYXzj0GhoQS3HvunfZsx6vi1ncTB+Amq/p0UxNtBn+VktgU6BzP9c6++dZXjTpxjT1AeOUqDun/cPbSnUUdWPfr3/3Gyo0sUqUQV66zI/jLmVu71dg92dIN3x25IZNo1trpZUw+kntg4x4FqQb16XRFa6/dwdGj9QHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvR69bnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713430527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YlIQQIdea0zY9K7SGuaix12g/A/bXwMZDxEbsfa9Qo=;
	b=OvR69bnr/X/zx3ecpKg76TAsaj9z5okvmhXBHGtk1+c2UpMnbe0XGq9sAwJzgYohUFJ8jA
	hKJTyQqVn6FaMJI5tb9KKIBooHPo6nyW4oBR8SajZDIDDQKYuMBBvNM7kvNzoRZ9i54IWd
	51CC/PptEqyRIcbeOE+XyQKpzE9G+rQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-5YP8iDRjOLOOVW92yho75Q-1; Thu, 18 Apr 2024 04:55:25 -0400
X-MC-Unique: 5YP8iDRjOLOOVW92yho75Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5684c1abc7fso297638a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 01:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430524; x=1714035324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YlIQQIdea0zY9K7SGuaix12g/A/bXwMZDxEbsfa9Qo=;
        b=JytZ5b1bSpsIyDbeR+8ntPVoHcMFy7UtCbFbkt/2LhEFyOBmLUC+umfh2+t982/Kiz
         BB+6ojfPMK1vN8OPoBSGRI95H/tChCffqI3OX5xkcsvm/mSTJK8KkmgLLxngQpu1WrO0
         uk3Y2b5HOoZ1P5Wkb4zM/WeIgHwUL51toNQUw9OiU/zF4C8urlDoIMxMmL4KFEFgmwNI
         0+glncxg93fxYmwUq5zqQ2nuML88PgxykAqAZLXLAgUov0VBduRlnnTLFwDZ2l4ONUNr
         mG+gHf/kPoIkkc6r+G9awY1WKl7ozLRmxa6h4eUIcUbPbi2zFtPk9gvAG16saTqke2pN
         Xr6A==
X-Forwarded-Encrypted: i=1; AJvYcCVBegHgLLjVBMgNkODr1nChO01uPZOg/NJm8bChzF+ueWkdesbuU9qP4DNJOMdqjBSsuFYKve8B70SWWoU/JZeE7pVbD4V+XuBS0Pqk6BF3
X-Gm-Message-State: AOJu0YzEHz8HmbPcpIg9Adi3aacBeEa3vP6uxRap8YdSuIFQEPQ2L7Zb
	yherLPF/VxsmUqLRUBNFQ/W2uGUXIjyzYc/aiLLaI68pTvcn9Q0OiU9/TB1vw9fUevLfzcd28W4
	Oxvdq0l9tC8tl4eOKBFqwwFaP5D4MpXzPU1Rrstg/Dly/2XTxMCjFNMt54EA4e7RL1PjSLbcYPG
	ew1/ZTaYsPf2vu29fqBvq1CBjyEF3OZlIWEkKxbk3X
X-Received: by 2002:a50:d70b:0:b0:566:d333:45e8 with SMTP id t11-20020a50d70b000000b00566d33345e8mr1330867edi.20.1713430524362;
        Thu, 18 Apr 2024 01:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxI+7tuc8Le9HhsVxIWdWWRsOFfxFhBkIX4vcIcKLU6knTudbsJ0kY7SSOQ7z7lM64duYb3lMTtZqcPMqH8sc=
X-Received: by 2002:a50:d70b:0:b0:566:d333:45e8 with SMTP id
 t11-20020a50d70b000000b00566d33345e8mr1330856edi.20.1713430523993; Thu, 18
 Apr 2024 01:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org> <20240416-bpf_wq-v1-16-c9e66092f842@kernel.org>
 <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
In-Reply-To: <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 18 Apr 2024 10:55:11 +0200
Message-ID: <CAO-hwJJ7e-h7RwPGPe=GZf6F5+WpWyHcLHqBFiv-3HRafdZjeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/18] selftests/bpf: add checks for bpf_wq_set_callback()
To: Song Liu <song@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 5:25=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Apr 16, 2024 at 7:11=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
> [...]
>
> > +SEC("?tc")
> > +__log_level(2)
> > +__failure
> > +/* check that the first argument of bpf_wq_set_callback()
> > + * is a correct bpf_wq pointer.
> > + */
> > +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before")
>
> This line and some other "mark_precise" lines are causing issues for
> test_progs-no_alu32 in the CI. I can reproduce it in my local tests.
>

Indeed. I can also reproduce locally. Here, it only happens for
test_wq_init_nomap() and test_wq_init_wrong_map().
TBH, I'm not sure what "precise" means, I just copied the checks from
timer_failures.c.

>
> I am not quite sure what is the best fix. Maybe we can just
> remove it.

Given that most of the code is shared with timer, but given that we
are working with kfuncs, we are not using the same r0 registers.
So yeah, I would think we could rely on the timer tests for precise,
and drop them here...

Cheers,
Benjamin

>
>
> Thanks,
> Song
>
> > +__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
> > +__msg("off 1 doesn't point to 'struct bpf_wq' that is at 0")
> > +long test_wrong_wq_pointer_offset(void *ctx)
> > +{
> > +       int key =3D 0;
> > +       struct bpf_wq *wq;
> > +
> > +       wq =3D bpf_map_lookup_elem(&array, &key);
> > +       if (!wq)
> > +               return 1;
> > +
> > +       if (bpf_wq_init(wq, &array, 0))
> > +               return 2;
> > +
> > +       if (bpf_wq_set_callback((void *)wq + 1, wq_cb_sleepable, 0))
> > +               return 3;
> > +
> > +       return -22;
> > +}
> >
> > --
> > 2.44.0
> >
>


