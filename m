Return-Path: <linux-kselftest+bounces-12103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAA90BD7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 00:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560A72820AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCD199238;
	Mon, 17 Jun 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8GS1nrN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A76198E9E;
	Mon, 17 Jun 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663168; cv=none; b=K+gMfpNmjL0P1m6cixRUvT7y/YDEH8fWxTBO2feSLbI8T0PUYtq5hKIlKWDpO26AQ+cA0GreqoRXK2Y+Oxexi91AjndXXsHrGcvOlFdOpNEZKXa3Vnr8sjWIQ+xGK5XyHm2IGFrEAAYjApuYe9x9N1woSYAB3n4VL8R89WRXdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663168; c=relaxed/simple;
	bh=WnKdnf8toMJeFBnLdKSlbykGNXt8GLauAnpYj6hAGlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcfVD5Xvd/gzSwUllXsLxmC96+Qbuiv+jbhj9Q0l57mk7nk7kh9JlQ8xha42ytmAi7hlT5YnsvytGO6+WzB0QeYHC61W1CvG8QBVlVDQT8evEeCSpU2B60aKAQmw86SeNEby0AnQo7bG3unLB7mz/VjVOt14WV7O//H2G2FlKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8GS1nrN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e5fd488d9fso3616199a12.3;
        Mon, 17 Jun 2024 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718663166; x=1719267966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWZR9+o4MQmZdZglbiV2Ru8G5/u2Xf1KFlJWCQsbllM=;
        b=e8GS1nrNcbKykP1pKwZJ8A0NcnQyMNfJfRjXxKVn/W0jT3K46diNpHFigdCnhAUbOU
         C4cUQupYEmPSzDhijEs4/IxtbT86jClBpzGq7i9W1QXK5Ys4jTDnH7xEN6ETsm/xf30s
         Upj5VThi78dKJZj+Kc2knwUOpHrP2qYKuutqEl5Islq8hjoTzCwbyCAyHod8uM4NL9fJ
         ysRS1xF7kfTk7CvNOZvCfBKxMsNCJoHr6ISbwLPdt5XQApI+8vpmpEnGJWIcFASZlgy7
         iVuZ7scq+pAYO44fAo7wWzpP53AQSUDLCFplvdUqaBVrQ4TscXDuuB7BHDefd4vjz66U
         KnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663166; x=1719267966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWZR9+o4MQmZdZglbiV2Ru8G5/u2Xf1KFlJWCQsbllM=;
        b=iJuHrAteBzYFcWdI9BiUMvU1iKhUzM2XwlsAHTjedeuKwXlsfrYRlDRwhxMkGy3hS0
         CfP0tLKtsJZWgLnjpa4VWBO3d+Mts5ZGEPvD+R/tu4dTfT/4w3S1OIfvOoK9EUrEoHhE
         pUxupSJCOxcPUKlsgqLZ1q47lg+EtjzRU0iUshmbAiybsvPNsOhb6bfQ9X2qS3Ue0wdQ
         WNx/GsZ94bpvwLuQzffvS84CDJGszu816tiFDgZat7gsxRYZmg/eC3syMdnQ3djPT5C4
         zstVEoCdrRBoT1GM9amKMe5e1Tr6mvf5ZAq3qR3JzIItpLyvDJ1ZCoezwwxM4cZlFWpZ
         QD5g==
X-Forwarded-Encrypted: i=1; AJvYcCVnXz/Mtg/G7vkmPk38GBJ+H8JdG0iuQdmI95gMQNnp/2vG1/Fd1aS5JNp4yjDfx26A3KhHDb1zgdkDhvqjvsSF8Pz0xHr2CUnL7KZjvc1oHLVDEf4e6AEPESEC+NcRSvu/5q6YeE9V2+QEBfaJEpce8nyzv0Nz71e+gP54dew85peN
X-Gm-Message-State: AOJu0YxgTjah58NIMGRQklaIdF84UFqxNPyHBEw0ntkm/DQY5RreHuSP
	CaDT2c2IAUV7Pkd78hywD+fSBbiZO43evBlRYrjFy4dPbL/LNbMpNbbGT7iK7sEMcujembmAxWb
	MD3Bd8ZZhIKzUpAaleTzc+LKKzu0=
X-Google-Smtp-Source: AGHT+IEMTnYx4VeeS5H3uXM8OvL59xMSDb5iEb4PnFyF6+3PrFuMDUUfJAzp0SGo+Ah4wYrfPfTkzKbZocSI9aB7mqs=
X-Received: by 2002:a17:90b:8d5:b0:2c2:cefc:abe2 with SMTP id
 98e67ed59e1d1-2c4dbb41b40mr13043877a91.31.1718663165850; Mon, 17 Jun 2024
 15:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717881178.git.dxu@dxuuu.xyz> <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava>
In-Reply-To: <Zmb52Qp__CBzbgDh@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 17 Jun 2024 15:25:53 -0700
Message-ID: <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix bpf_session_cookie()
 kfunc prototype
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, shuah@kernel.org, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, daniel@iogearbox.net, quentin@isovalent.com, 
	alan.maguire@oracle.com, acme@kernel.org, mykolal@fb.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > The prototype defined in bpf_kfuncs.h was not in line with how the
> > actual kfunc was defined. This causes compilation errors when kfunc
> > prototypes are generated from BTF.
> >
> > Fix by aligning with actual kfunc definition.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
> >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index be91a6919315..3b6675ab4086 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynp=
tr *data_ptr,
> >                                     struct bpf_key *trusted_keyring) __=
ksym;
> >
> >  extern bool bpf_session_is_return(void) __ksym __weak;
> > -extern long *bpf_session_cookie(void) __ksym __weak;
> > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
>
> the original intent was to expose long instead of __u64 :-\
>

Cookies internally are always u64 (8 byte values). Marking them
internally in the kernel as long could lead to problems on 32-bit
architectures, potentially (it still needs to be 64-bit value
according to BPF contract, but we'll allocate only 4 bytes for them).

It seems better and safer to be explicit with __u64/u64 for cookies everywh=
ere.

What am I missing?

> could we rather change the bpf_session_cookie function to return long?
> should be just return value type change
>
> thanks,
> jirka
>
>
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_coo=
kie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > index d49070803e22..0835b5edf685 100644
> > --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
> >
> >  static int check_cookie(__u64 val, __u64 *result)
> >  {
> > -     long *cookie;
> > +     __u64 *cookie;
> >
> >       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> >               return 1;
> > --
> > 2.44.0
> >

