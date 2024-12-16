Return-Path: <linux-kselftest+bounces-23437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA4E9F3E2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 00:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A91116E098
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829F1D63E9;
	Mon, 16 Dec 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxVwKFFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666281ACA;
	Mon, 16 Dec 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391456; cv=none; b=irLwAjJfK+4hkuTqoevCfeA6vrDFV/O/s3DeIG4DXC85m+higortJEVMNPsWzl6jvVbB/49O8gCqcWj/Mk/ez5x7ig6rwXfnWyHoM0NTUtmLcESyXYLyPIEB6NjxEy5EM3m5vPPHUPS8UVXzRFcv/KspZ+lubhjIZUuV+7Zttso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391456; c=relaxed/simple;
	bh=FqyU2F+GfdfijPyRH9XrNGOxgNKLuRAGHwJ8YtTjB3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb1SxIEeRgpMY2+F+O2HP1gglXdwrRlt1xUQboG7kxiT0uxxS9v7+XpI9vzI4i1jOiaFQhiS77Vrx5mR9Axd3fbSQDPx5OwG8EmZXFEtLjCtDzKq0RB/8zzUTxqruciNrPDZa6/CUS8dxDVq9D4OS6Awm3Gg1/HymYrAcf60ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxVwKFFp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-801c081a652so3123382a12.0;
        Mon, 16 Dec 2024 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734391453; x=1734996253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1rrej6bTfckNoeV0BiN+uUX+SYIqaZUUyRvqwZzeA4=;
        b=lxVwKFFppLxhxLmpQecYBHndO7kCvFyhpq1ixL7AzMSe/i9xuiWznA6+zSbzCf1h4e
         aZVtBG5kUjEusBpHTcZRuo+vZVknZbo4UdvI8EEE0RNqF2Qs+tE0JJIN4HD2n7A4pFb5
         uY85hQnLqJ6aQ+p/RDtzzCR5yiDWkSU+pxDZqPraUCEJGmEy0RtCWIeCuWYkAbm4hUHm
         nA9+Oq0sKOtutoG8cwm01KAuOVbp6Nck86HWXc4XIS9lkcLiLDTdLwE/zT+70dgj/+95
         4oWWlPJ6PsOle6YpTaN50RUG/Kn3pK2UGxQ4qEx47VGWUxh/5n/GmXre8susCyxy4CaO
         M8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391453; x=1734996253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1rrej6bTfckNoeV0BiN+uUX+SYIqaZUUyRvqwZzeA4=;
        b=v8vAUNBK7sgNRHjuBVQxB7AIen+bsjXd+GcLuyRBhbSBrJclEwiOf3J/k/teKluhAJ
         wWAbyIJJfHoVMyU4UrEl7g2WBjQOh5nCKHdB5wwyic5uUpq8CiDgEDcLm0cLFlYkhkJ3
         vNlhO2bsBAZ0dGcxSwyDMyWOT3zR+UCoDKNVHXHVI6q+T5uzY2VkZeMxBYJWauk8YKkF
         qxbhXbMoi1s9sYfRmTjN0j+Vt+0jF852hRYRU+8qQMBBByKMB+pK4phiWg81PQxtZJR3
         /Ov0H2D7/3RUASaqe3dALhwQvwLG99Qao7awf/vrPHlh6gWwqaXg5fWmBADe7xV2tyyB
         ftOA==
X-Forwarded-Encrypted: i=1; AJvYcCWzU6Y5e3SBE18FbLDSZJFvVFbeuVs7B2qreroy7Wij2dPoe2kvDj5vpr95VvQ6qJPbUD8=@vger.kernel.org, AJvYcCX1xUcAQYz+ddJHDTPn5l+fV7WgnFq9CSADH2CcysMOGdJA9SGPiaavVeC3omXdgGn/uxWw4+uN@vger.kernel.org, AJvYcCXHpDDYAMQiMDHmz+q7hO3mN2OIr11Teb/ak2EpF0F1KsUJFsEZB+l7IGTcPOQBPlDQxmgznmA/ba5uKYZ5@vger.kernel.org, AJvYcCXTbViOJFSFyQxEWlrEqnarNuuxCg2MfzTnmlm3FqFAaZAaRkHpgpmQf36QiaOBsLxjlxUEgwvjbdy23MExnnTy@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnZ5g7wyYR3vFhQ9tEgkJDehpFkFuHGzKPOAue8oFZakrt6TS
	nFKOk2ZmhMdCrZ6KM70dS1uWbCq+uEq45qCtCmabzLBRtNKfEJtOZJJoUEBs1N81Jl5bLTscMJY
	JTFbmDm4gVvYIRPb/CzPpxdUWDdIjpQ==
X-Gm-Gg: ASbGncsk2qfuwOue3GBdK05EHCfHY1A1aoMOSAlyU6W0kALjT+9WbzxMUS1BstRKeS9
	WPe5Cmta7BXmchPoz5uzVcOax3ba+zih7Yy0JEPO8r0Vc9EfLeHBZrQ==
X-Google-Smtp-Source: AGHT+IFU1FuEzXwiVYWcoVnoCytp4SvlrA4g1SWYK8Ytf5WaPd5675uFznQpDftn+Y8gvkkTdppZSeqV5/u+6S8Ol04=
X-Received: by 2002:a17:90b:1a88:b0:2ea:61c4:a443 with SMTP id
 98e67ed59e1d1-2f2d8798991mr1703822a91.4.1734391453490; Mon, 16 Dec 2024
 15:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734045451.git.dxu@dxuuu.xyz> <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g> <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
In-Reply-To: <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Dec 2024 15:24:01 -0800
Message-ID: <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map lookup nullness
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, shuah@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 7:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-12-13 at 19:44 -0700, Daniel Xu wrote:
>
> [...]
>
> > > > +       /* First handle precisely tracked STACK_ZERO, up to BPF_REG=
_SIZE */
> > > > +       stype =3D state->stack[spi].slot_type;
> > > > +       for (i =3D 0; i < BPF_REG_SIZE && stype[i] =3D=3D STACK_ZER=
O; i++)
> > >
> > > it's Friday and I'm lazy, but please double-check that this works for
> > > both big-endian and little-endian :)
> >
> > Any tips? Are the existing tests running thru s390x hosts in CI
> > sufficient or should I add some tests writen in C (and not BPF
> > assembler)? I can never think about endianness correctly...
>
> I think that if test operates on a key like:
>
>       valid key 15
>              v
>       0000000f   <-- written to stack as a single u64 value
>       ^^^^^^^
>     stack zero marks
>
> and is executed (e.g. using __retval annotation),
> then CI passing for s390 should be enough.

+1, something like that where for big-endian it will be all zero while
for little endian it would be 0xf (and then make sure that the test
should *fail* by making sure that 0xf is not a valid index, so NULL
check is necessary)

>
> There is a guide on how to gen a s390 environment locally:
> https://docs.kernel.org/bpf/s390.html
> I used it recently to build a vmlinux for s390 with no or minimal
> issues. Used it to boot long time ago, but don't remember if there
> were any surprises.
>
> > > with Eduard's suggestion this also becomes interesting when you have
> > > 000mmm mix (as one example), because that gives you a small range, an=
d
> > > all values might be valid keys for arrays
> >
> > Can you define what "small range" means? What range is there with 0's?
> > Any pointers would be helpful.
>
> I think Andrii means that each 'm' adds 8 bits of range.
> E.g. range for 0000_000m is 0-255, range for 0000_00mm is 0-65535, etc.

yes, exactly, thank you, Eduard!

>
> [...]
>

