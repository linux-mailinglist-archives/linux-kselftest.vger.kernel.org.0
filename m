Return-Path: <linux-kselftest+bounces-35392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF8AE0FA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 00:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE31D3B8FDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 22:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7925F797;
	Thu, 19 Jun 2025 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgKTQsXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2930E83F;
	Thu, 19 Jun 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750372457; cv=none; b=EyHKq3lcAO2WN8rtkhXoEIM8ON2njf06r2zNPLoeobfqxo7Wskixnq5p7YwfTQA+TKDR8MKk6guY9Sy1R19n6sZEft1yZi03OnQxlQT3TeN/KIyoeeeDAmhTsH7knloo95WMP2j8ShfEC5HzDrPAuNmwAzyx82cfo4JaEIM+KcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750372457; c=relaxed/simple;
	bh=GIDO9BDys8lQULlVy8TnjQvIn6yRHEVxpy5WzFL7pTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbNgv/NMObVdjmTO22aS6JMDzwtn2hCizjlNlvAiza1u1KhR2Hcyud5NGKriklylu4WNAnUEvoHCHt/MGrQXxXph2up6gkVjqsb4K26WYXXjoko+TTnmZ1GCzw3PcHe8fcfejZC5cs4oVdFNZ0WWdnnCqws37PpRQRnP1n/rkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgKTQsXE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so282181241.1;
        Thu, 19 Jun 2025 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750372455; x=1750977255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Eu0lFqQOWmj7E0S9GLB+pQ4SPFVJIlw2LIM4BGXQqs=;
        b=SgKTQsXEt3xvU8AQfsr9ORnoGP8YSdUn1GoflWbleEETDqiG9NoJjwGB08LQUjHf90
         Tm091V8YOjmWoErwZ5y5V/ld1wCU0o5BMhB14bt0Ha6cC5taPQb0zf6gvZpxH9uprjpD
         LFdHv308Fw+ar9g67NeKtOjQfJXtf+sIo+NXUa151O9CFd+SEX3GIzyELEGeFb4KMLPF
         YQbopvAvyOhSGLnrp60CxbDP5UcmF5H+8ERvwX//enXcgzbvnNVpK8mVFPkyFpJ72z3t
         qUSt3qLzQyTBJSHskNqJOrWWgI9s4oqVGqngcuw+N1Taij2R1IhMBGpoJtE0/42MPqwE
         gkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750372455; x=1750977255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Eu0lFqQOWmj7E0S9GLB+pQ4SPFVJIlw2LIM4BGXQqs=;
        b=W91KWuz6BByyfIz5bOAqEN3jpKE97thPSIIiM2iraBbkd+Bk0IHNdbclDP0B18t8w0
         ta4TOx9VHXHOHd7SFy1SQM8S55R4fSJSfAw1EA1wM47z/3s6n2JmcmOPFTqWfhZkmk3t
         XXzjz738WW8Ydyxy4wfp5B1EYGMLWN8tS9GjHoWpyR+lrpSO/vNd2Hz8YsX4ht4QnGv1
         jfWz1jyoAJr8lf4v7xwQx5FYoKBLhCLApUIsgH8YVV0fQ7Q8OLne4SFnkZYCM3SVVQL2
         DB7xLiem4kD0eEJrN4daWimGMDD/8HLvSPf1vGS+jbmDs/R/5SW2mM8JYP2mqIuPuwYd
         zrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVLgmylL27J5PhlGr4NUbkK34rSUOYomnLNPRExLwO8PGSAv2ifTrY8cTIu88CkOdwmRYe9Bt38z3wZsUC72cAm@vger.kernel.org, AJvYcCWsBPA7FuUX8NCl0mf3pE/6Yj0E4fnbYvyA0js8P/iGC55bYhQ6AO+nL+ioZ4jR9CA2eXDrknOq3+7v+lYD@vger.kernel.org, AJvYcCXeV9afQRGmh+OsUvI/rnxJbGEUAIsCoYih9WPJBfjHdVRedsXMJT3Tre5wQhqsz3//VKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26FbAnzoTmwgKKPLQBT7wcnj9mxQ709qyCjY+w++6gQ7lV4Pv
	0Ov4o/0mi6Pa9VBR64t+1vuTzmDlc/UheWIoO5swfK24wIsgA6vnySI2e7DT/nuBxQjIs83jnQ1
	F3MRcqxSXjrlUobPx0BzLAO8efgn9uLA=
X-Gm-Gg: ASbGncvOSAqqNTUvHbjSpAZgVrfdv/RRA5rEHLGMTE9EmKeNfegeO8hIQfhKuXb2gwl
	xcQYKENFMBM13Cj0LftSrl6GUa9SLVi1w9lysMi1NX1NZPRBVuYTwrZga5fjPMlSGDSebH3DB0F
	7nx1AScoNDp8ZVTRpcUbdJGJ+Qbz1DN0/YrHuIHt22XJrT41ixQfTaFKnpimJesgZY7GDj/0yJt
	lw7NQ==
X-Google-Smtp-Source: AGHT+IHe72C1tJM/iB5rsdcWJQTGhwtVphYyYCNbBUmZo81jrxCV8UJZ1GwAYAWo6O2BQQWy1dedvf63/naTFnqb+Kw=
X-Received: by 2002:a05:6102:449a:b0:4e9:b7e3:bdc5 with SMTP id
 ada2fe7eead31-4e9c2cf24d3mr410953137.15.1750372455117; Thu, 19 Jun 2025
 15:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
 <20250617231733.181797-3-harishankar.vishwanathan@gmail.com>
 <5b3b620d04fc3bcf4286dc4bb8c6fd995df86a25.camel@gmail.com>
 <CAM=Ch05aDpkCZ7xF1Fs9SVrU8DFG7kofzRw4g4bkaUSdUsp3jQ@mail.gmail.com> <04a5d2572ca2af1ec4dbc9cab5c61b1d0d9af0a9.camel@gmail.com>
In-Reply-To: <04a5d2572ca2af1ec4dbc9cab5c61b1d0d9af0a9.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 19 Jun 2025 18:34:04 -0400
X-Gm-Features: Ac12FXyGtdXXkVrsVuq7BO53UmZ4YR6jgxU7w7dp-jZNI1PCHrcOg3bcAsbVjfc
Message-ID: <CAM=Ch044aYYx_wJ+wPoDu6u0jqGk_18SyAkkTWf=ygofzDT2bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai <m.shachnai@gmail.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-06-19 at 17:13 -0400, Harishankar Vishwanathan wrote:
> > On Wed, Jun 18, 2025 at 5:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2025-06-17 at 19:17 -0400, Harishankar Vishwanathan wrote:
[...]
> Hm, I see, that's an interesting angle.
> The problem is, if I do something silly changing the code and this
> test fails I'd have a hard time understanding the expected output.
> Therefore, I'd prefer something more obvious.
>
> Maybe let's go with this:
>
>   SEC("tc")
>   __success
>   __naked void test1(void)
>   {
>         asm volatile (
>         "r3 =3D 0xa000000000000000 ll;"
>         "r4 =3D 0x0;"
>         "r4 =3D -r4;"
>         "r3 |=3D r4;"
>         "r3 +=3D r3;"
>         "r0 =3D 1;"
>         "exit;"
>         :
>         : __imm(bpf_get_prandom_u32)
>         : __clobber_all);
>   }
>
> Here is verifier log comparison:
>
>   master: 5: (0f) r3 +=3D r3     ; R3_w=3Dscalar()
>   branch: 5: (0f) r3 +=3D r3     ; R3_w=3Dscalar(umin=3D0x400000000000000=
0,umax=3D0xfffffffffffffffe)
>
> ?

Okay, this seems both readable and also demonstrates precision gains.
I'll follow up with a
v3 with similar updated test cases for full overflow and partial
overflow for all the four functions.

[...]

