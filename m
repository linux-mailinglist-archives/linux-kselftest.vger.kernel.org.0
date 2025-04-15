Return-Path: <linux-kselftest+bounces-30878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40117A8A119
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA961189F5FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1492E198823;
	Tue, 15 Apr 2025 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIMxjNui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00EEAC7;
	Tue, 15 Apr 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727520; cv=none; b=BPHH5HEro553qFafnmtJ/Dq1rvtX5vemKYFDypdBUdBEFR+b8bG1Vdzx+fr/MxL74OjUsQ38i0FGJnCgZR6r6DANvH4BDN1EPu+TLITb2FKDmNJm4u8i2V4jbJnbO5jWRouA/BwajNEOkm6ef9Eje9GymVVpN3Ye6Fs9xn2RmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727520; c=relaxed/simple;
	bh=fXqIeq7CWJvldc7w3rHaixxKTTIDuRehE+ejMsOrktw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtNmiWXTshZEdVvIDbWDmhITQO0FY0PYF0YyPe0ectpcMU4f/RoQS5qNh2nuJ5ORspdJq181LdMAB7HgG8dPpzcRn+TUTpQKC150nQymw4d4NSRnw8aWQfumDyO4zC5IlrIrX1evOolMakDw7gDF3JrL4TKtyO4VjjceJ7R5acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIMxjNui; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6febf391132so52929397b3.1;
        Tue, 15 Apr 2025 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744727517; x=1745332317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/2ovr2vmJ79vIM11cUqi82N76Xi+yiNnmI/LMBgOek=;
        b=nIMxjNuifwHzHwocWw9JxAnCzV4HVChYI7dxCgrlAkH9THGC+NV9s0ZrF/fpz1tltx
         207yFyIv3V28CdB/3J9bkgI+l3PVTs3UHGNCR3gEp/AhHpTENbSlzGRUelWbl9gNrAT0
         /524oSUiBQ7JFZa7rT0f/WeBhQQo8m3zRohcnuYjv4P1VwmFRto4ueEhSMRZtRuTl0sF
         lAa9dyDJ6YOGPSxQ/TLBAhc3gs5bTJWmXQW0I4UUFhYQDvYWWUBTh66Rz7Ex2B/JmMFE
         KgQ29ooUNAKeuKlqTHa1kktRin+fSEa1ot+MCVEkyehLq3dJKsvKTQxujTviz4CFWHNS
         JjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727517; x=1745332317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/2ovr2vmJ79vIM11cUqi82N76Xi+yiNnmI/LMBgOek=;
        b=vVDH85K5Jav8LnnfdJyyDjNOiqMuMym2AQgbf1ytea//A3fQFL6/HSD2F3yoENtZhp
         eTmc7wCRN3QDBrDgcswV5Ii6uSkcPk83hBczNvSTG8TP9TwPjcsyjRFQa8f4ATt5Vqmv
         Vf8E5a+HDsTzePE/2o70bk6p0ycOebqMHMufnv7bO9PyheGX7J8VHdKb4KbKAZXtE2Kr
         Qvl/aPTpDPn+xyH8qBkq6UJYDmgEQGgYVEMyXKxkZ+VZCvN7Vx14u8KkSRLb4Ad0sIHy
         o0PV7SC7B4IlhuReggILdHk+WKRa63xIEsRfZFYJBG0PmqgCdE8jccYeR562Wc705Q0s
         isdg==
X-Forwarded-Encrypted: i=1; AJvYcCVtR7GXtimvwzmHQOwPlE7BFKAMHbu0VksrxYrqVwVxMYm+6NOSud1e57Dn8sZh1IHLG5Bguiw38mEo+4rwvxvm@vger.kernel.org, AJvYcCW3in2jiv6OXdTm+oZu5pwbqX++4LrQ+H+aG1eWEMCwyVMyV5P2ZGgY3COqFgciNQGxcsM=@vger.kernel.org, AJvYcCXHiyK+IIMMK5/E9Sc8Hsh43bEC+tjuw5IPZy9NJgKijEgZuu74X6QjVUh8OJEon2q90k5Si/lWvbYSrciV@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFcJQjuATrwjXv2PWhgpy63d22Oh/BzTIq1hTAJ9GESjQfH2t
	krHTQoe7odKLTDWHbTV9Rx8BK+ss1/88YJ1hH58JSa+tYbDkwbeMhKMpjAG3W87n2TGPHYjlX17
	pnPPJ/YECN4aT9jtz00yAkizctEi5Behqr48=
X-Gm-Gg: ASbGncu9jUK+xsWxCWboYZspk9Hq4Hyu/yCS7D1FZQSGi++NqIaiLvXyKNr3t4LvgE8
	WCvCojrGiBKA9VU9h+CaHVXtCJYJ/bT2Lkw4LXzShr+xWAHFhayA1FVFiEZNCXwhWThtWhqlAkP
	BIni2ZjZQpBjCU6cqjtS9o5Q==
X-Google-Smtp-Source: AGHT+IGvJDqMVgrVxDOvG3hjCsnkDf6UkRZzee7PLxZfputosSJ55+NmkW5312xI/va5Ra1iOrkRjcWYH6TwsLGnfok=
X-Received: by 2002:a05:690c:6208:b0:6fb:4c11:61cf with SMTP id
 00721157ae682-705599e7e97mr272049757b3.19.1744727517386; Tue, 15 Apr 2025
 07:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
 <20250412170626.3638516-3-kafai.wan@hotmail.com> <Z_zk4kg_qQviauLE@krava>
In-Reply-To: <Z_zk4kg_qQviauLE@krava>
From: Kafai Wan <mannkafai@gmail.com>
Date: Tue, 15 Apr 2025 22:31:46 +0800
X-Gm-Features: ATxdqUFbUqDSXKgTvAcCWrS0g742f5K2dBB0e491Buv-EJOksGp6DfV_mssUbaw
Message-ID: <CALqUS-7Jh2MpBTjQ9GNfRZKjUqg1t3n-OT_GYQqH=0TmkXoc0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test to access const void
 pointer argument in tracing program
To: Jiri Olsa <olsajiri@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, shuah@kernel.org, 
	memxor@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kafai.wan@hotmail.com, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 6:35=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Apr 13, 2025 at 01:06:26AM +0800, KaFai Wan wrote:
> > Adding verifier test for accessing const void pointer argument in
> > tracing programs.
> >
> > The test program loads 2nd argument of kfree tp_btf which is
> > const void pointer and checks that verifier allows that.
> >
> > Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
> > ---
> >  .../selftests/bpf/progs/verifier_btf_ctx_access.c        | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.=
c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> > index 28b939572cda..a6cec7f73dcd 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
> > @@ -65,4 +65,13 @@ __naked void ctx_access_u32_pointer_reject_8(void)
> >  "    ::: __clobber_all);
> >  }
> >
> > +SEC("tp_btf/kfree")
> > +__description("btf_ctx_access const void pointer accept")
> > +int ctx_access_const_void_pointer_accept(void)
> > +{
> > +     /* load 2nd argument value (const void pointer) */
> > +     asm volatile ("r2 =3D *(u64 *)(r1 + 8); ");
>
> I think we should follow formatting of other tests in the file,
> a do smth like:
>
>         asm volatile ("                         \
>         r2 =3D *(u64 *)(r1 + 8); ");   /* load 2nd argument value (const =
void pointer) */\
>         ...

I will fix it. and I find out the kernel does not support test_run of tp_bt=
f, I
will change to fentry.

>
> thanks,
> jirka
>
>
> > +     return 0;
> > +}
> > +
> >  char _license[] SEC("license") =3D "GPL";
> > --
> > 2.43.0
> >

thanks,
kafai

