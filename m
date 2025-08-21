Return-Path: <linux-kselftest+bounces-39544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73FB3020A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8C2167AF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91633A02E;
	Thu, 21 Aug 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggqy1sN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D525B30E;
	Thu, 21 Aug 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800928; cv=none; b=LO/5fMkjxE+t6HiZFFgucPOBYZdNwdKDnW+U3EzFngGpP7XAmmm7++EsDYGKJ5nP7w8yW5A5tElZQSN5lJ4Bor/5fnOgxyQ2gMCOjowJAU2BwUSTdBBEf35/XWPQwFUGJHPG83b9np38PfpCNaWEHNznfkasZ60jUofgRC0o1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800928; c=relaxed/simple;
	bh=irrCb5oJOWOd724NogNnH/LuopoDXINCIHXq8vhoRVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7QayJJPAVgWHsAV3IDVt14jS8i2Xq4uAoZ2eBs8g11QU323cf3UjvCHnsZo5r3PiqvMnFKiYGd2+6T0gmM9JnhEPB+PWPzlVpPN8a7HgZLU/YSY26nRTEmsg1PHZ9vCqGBjcUecVEyRaWPhjLM/WioG/o2LCf0ACtXef6Sdp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggqy1sN5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so925624a12.0;
        Thu, 21 Aug 2025 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755800926; x=1756405726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRMXBc3KQplXBAbVSw/VgjpqcIwybUMzF6DaguqJcQk=;
        b=Ggqy1sN5+iuGQQ3yqoV4EYezixQsuyHCM9kZJG2cW5zq+3I6wFmdW5RNWg+/GSR7Xx
         niOo95VWr2oZwJ/7pPfI6rbksmv1myNb1OuSwAVDVHf/DsampCvH2qDu6QPDqZ82nTCa
         HgUFm41z6t11ElWyZvGNPORuHtGExX3XHlSshqMR6gWgd84k1h6F7Z4wY1K2xuKtLDMn
         AMhcUNB/PSX3uF2R/znTh1rME1D7vdZI+E/yfzUUD5nOk2BvX4lHJDgkXIns4OTo9/UU
         o2JOVAVi0daEWTnmB/f95XKKh6qBH3gPKvUemCvv1/c9Wder6IT7ZsGKU3qylfuJj5Ml
         7ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800926; x=1756405726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRMXBc3KQplXBAbVSw/VgjpqcIwybUMzF6DaguqJcQk=;
        b=KGntsNLQkZKY5aFULu0RcS5NWdtTHqDxvt3MpHCqwTjojE0E0TxRIvCPpPtn5Wd9Sb
         lAyJKTYmJrpgpyw9PCw42PLN5GEuMPdjh2daTdvir+R6NcpXGxvHlA/HVWqiS2nZ6x80
         rA+A4HrFJ69npIrmF3QJ7mKhI3oNHGxsZWd0iwGCcy7HtwiLT7MaSrBaoE0/3mlZGwf/
         EI4m5fXch2u6sZoQwPlf0VKZD2TcFI4hpO0DGxYmw6SnysVQPW7iYrNWgDlFFTfZwBpR
         oqU8FNT+wJJ1RIIsMjwIfpUUG1R4c0TQF7NimcJW4nV+9sk8+mzcdeZL+fsb9x4PDtvX
         CFRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfiJndfV3ZZExp4UMJwmzVWilWhdKkMQWI80X9iuF9O4BWmEuapfd/g6l3xF+s4Od73Y8=@vger.kernel.org, AJvYcCX7o8mUuDBD0i/M4qsw7Ej+WD/R/kKC0T4FAw+nTIeHOG2ZXFSxcjbc9+zjXpjzgzWTuKxF7PemQX8xIi+rmp9u@vger.kernel.org, AJvYcCXYFScK9BB+TBrj/QofOx3CU9wz+7tZFLjU3y7TBmyC8hWJYv0fTb/gxyLg2MfTg1txUlmMhXVeodvjOX1+@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIgllgthtYaZSsIe9U36xAS1motSpnmsl8r1JdgfGfbxwjjZg
	NcaNQgY2B4DZWdEVZ6xSHiwGTtZiUU/acZlKkQLXiG2BjqABGRUZzVTqxCuEk9+ILCdCf/zTn1q
	ryNA8WdPXePZxyDchjvI1jlPvMk2kFu96ypAU
X-Gm-Gg: ASbGncvGy0JrhcTje5l1dP3aRbPygKnOIK9JnxMVyTiL8ifnHkZwKjy7lLnq5dyrWFG
	VUI4uxlhJ1p1xAMQTVYK4OhHR9vYrpVyWYhqHtI2sDwTYk7vMTyaMSYuCqzlzyTytdAUYhbkXrS
	jqNxDISXGgoa7gTgRsSiTxKKr2BrwxVpIfK7sh8ukD5PHRz3BN/YDt26pG+DfxIfi5xdMZ9UQbE
	B5faSJC1Eap6Fp73xcTpQGD8V6Vk4paiIRoAmQxdOtI
X-Google-Smtp-Source: AGHT+IFnb0b/Oii6gre/2MJERcVnzSC+35nJHsL0gUNARV4flgsdPVX17CDH803ut0ZBXb7TqtGH10qMfHHodee5Jys=
X-Received: by 2002:a17:90b:2ccd:b0:324:eac4:2968 with SMTP id
 98e67ed59e1d1-32515ee13cdmr596495a91.33.1755800926466; Thu, 21 Aug 2025
 11:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com> <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
 <30d8fcac.2669.19882763de2.Coremail.phoenix500526@163.com>
 <e7ba3f7f-38b8-4c06-8aff-ef1fb8d04d86@linux.dev> <310495cd.19eb.19893314d03.Coremail.phoenix500526@163.com>
 <0f6d16c1-0e85-4709-9846-3a993a9f041b@linux.dev> <65e51538.57aa.1989d162bb8.Coremail.phoenix500526@163.com>
 <2559a8cd-b439-43fc-96e4-d5f2941ca4d8@linux.dev> <3fbb9319.20c8.198a1410186.Coremail.phoenix500526@163.com>
 <6c444d7d-524d-4bc8-bda6-0440af621ebe@linux.dev> <46f4c341.1dea.198b845a4b0.Coremail.phoenix500526@163.com>
 <7495eeb9-777b-4b9e-8312-c6654268d6ec@linux.dev> <CAEf4Bzbpu9PM6GHV6ewE_hJJ7=94Rn1ZYq5QWVnpoH6_LRQDCw@mail.gmail.com>
 <eb7a3ed.9723.198cd47d479.Coremail.phoenix500526@163.com>
In-Reply-To: <eb7a3ed.9723.198cd47d479.Coremail.phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Aug 2025 11:28:31 -0700
X-Gm-Features: Ac12FXwz8zMdMHKi5OkkmNPfee3WJJ2yngOjesrE_ZG4DaVHRNF6aLdrVLUSwr8
Message-ID: <CAEf4BzZLMp5oLnF_Nfjru7+zE2P4981GXWGf6d=6jEY4TqBt4Q@mail.gmail.com>
Subject: Re: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
To: =?UTF-8?B?6LW15L2z54Kc?= <phoenix500526@163.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:38=E2=80=AFAM =E8=B5=B5=E4=BD=B3=E7=82=9C <phoeni=
x500526@163.com> wrote:
>
>
>
>
>
>
>
>
>
>
> In the previous discussion with Yonghong Song, we found that some compile=
r would generate
> such an arguement format. Although I have never encounter such an issue, =
I found that the
> global volatile variable could trigger the compiler to generate this argu=
ment spec. So I tried to
> solve this problem. I guess this would not be a problem since we have alr=
eady used STAP_PROBE_ASM
> to reliably generate SIB argument spec.

Yep, let's hold off on implementing this, as it doesn't seem to be
really necessary in practice.

>
> BTW, I have another issue to discuss.
>
> Now, bcc framework is not a recommendation for writing bpf program, so bp=
ftrace is now migrating
> from bcc framework to libbpf. Bcc framework provides some relevant APIs f=
or get usdt probe info[1].
> And I found that there is not similar APIs in libbpf, therefore I have to=
 parse elf file manually.
>
> Could we add some relevant APIs, maybe like `bpf_program__usdt_probe_list=
`, in libbpf? I can make
> a patch to implement it. WDYT?
>

I'm not yet convinced this belongs in libbpf, tbh. The process of
discovering USDTs actually involved two separate tasks: discovering
binaries (executable and shared libs) that constitute a process, and
then for each binary discovering which USDTs belong to it. The first
part is pretty clearly out of scope for libbpf. Second one in
principle can be added, but as I said I'm a bit hesitant at this
point, as we don't even have "USDT manager" exposed through public
API.

So not yet.

>
> [1]. https://github.com/bpftrace/bpftrace/blob/1cd4bbdd4a13dd55880f2cc638=
dde641fb5f8474/src/usdt.cpp#L131C1-L152C2
>
>
>
>
>
>
>
> At 2025-08-21 07:00:35, "Andrii Nakryiko" <andrii.nakryiko@gmail.com> wro=
te:
> >On Mon, Aug 18, 2025 at 10:35=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >>
> >>
> >> On 8/17/25 6:43 AM, =E8=B5=B5=E4=BD=B3=E7=82=9C wrote:
> >> >
> >> >
> >> >
> >> >
> >> >
> >> >
> >> > Hi, Yonghong. I've already filed an issue[1] in GCC  community.
> >> >
> >> >
> >> > Accroding to the discussion, it's not a gcc bug but may be a systemt=
ap bug.
> >> > I don't know how to report this bug to systemtap, but I found that t=
he
> >> > libbpf/usdt have the same problem. I've filed an issue in libbpf/usd=
t repo[2].
> >> >
> >> > I also have some ideas about it. I wrote it down in the issue[2] com=
ment.
> >> > May be we can discuss there.
> >> >
> >> > [1]. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121569
> >> > [2]. https://github.com/libbpf/usdt/issues/13
> >>
> >> Thanks for filing an issue on gcc and getting some feedback/suggestion=
s
> >> from gcc community.
> >>
> >> Currently, libbpf/usdt does not suport format like '-1@ti(%rip)'. If w=
e do
> >
> >Exactly, it doesn't. I haven't yet ran into a case where real-world
> >applications would use such an argument format, so there was no
> >incentive in trying to support it.
> >
> >Was this issue discovered as part of testing on some real world
> >application, or it's mostly through testing on synthetic cases?
> >
> >> intend to implement this. libbpf/usdt can reject that if 'ti' is a
> >> static variable. libbpf can provide some hints about how to make it
> >> work (see above [1] and [2]). Then, it would be user's reponsibility t=
o
> >> change code so libbpf can support it.
> >>
> >> >
> >> >
> >> >
> >
> >[...]

