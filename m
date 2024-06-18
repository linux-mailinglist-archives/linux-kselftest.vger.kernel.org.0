Return-Path: <linux-kselftest+bounces-12151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65590CF14
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD7E281E25
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38781BF32B;
	Tue, 18 Jun 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drh5Zze2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FE21A4F1D;
	Tue, 18 Jun 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714631; cv=none; b=gS2ANoPR6YjlFM7+kKCSg6wjAsExlR/Dr4pNOKM/dNv7RJPYpwaRE/1DdfQZ1CeoGvh5igbvi3oYz4Mk1YA9B3Z0uHhk0AHoq6RdSXSLt74SV1JDd161yNWpdedPK3IOjW8OFzyIkPkmiMrP8hPwrQ0KC58qHJy3yM4wFe190k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714631; c=relaxed/simple;
	bh=QUAzUy4onAAF6jIhz9BhKFZSRxoOz6ehfEuVXM43BKs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRpqfiez+mCoVi6VJis8sUto+7hnhS9Grduq05vRkEeSD14CiX6HFbTFl78CHCTzV+dBcc4SNtBTMdBwxZf6IyN/fBXS9IPUc3qnfX93pKqdwZv+mAE88aVxVWxMnDWbaAj2THw4JWGNRG3OfijzU69Cz2QqxiQiVqQPLar41rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drh5Zze2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so556331166b.1;
        Tue, 18 Jun 2024 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718714628; x=1719319428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9lG+gQG2kpp6YJba8a9qUBiAr0ayiGiMtXPv1kcl7c=;
        b=drh5Zze2/khNNyeI0jdwDeBTPPdH10Z43sXM4jb9AzJ3M/IWa3RO/m2tPyG8NGDWVO
         6hby6QZ9s8gr3AHz5rweJO6J6Nai0ea5pRVnYkW1kAw1UgZ8TFlknGU4jdroOrA1ljUg
         /h1Y0SwOdg5NdL3cqbus4cIbbQymCnQo1PkJSvwP3+NWanSnd1dUVpkY2PNd5kcsj4y/
         MV5rCiDfIdx9HugMzHzYQ7CMk3sHCAnsFINbm05orvMe1Q+1r6XDUuLYRInoNJN5MSdG
         Zgg3S8Hxe8pVNVDY7ZCT5YeD40suQ4wGM4mDMTVuW2A/ZokoDkgt2gjt+gtfV9lz8F5Z
         Pm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714628; x=1719319428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9lG+gQG2kpp6YJba8a9qUBiAr0ayiGiMtXPv1kcl7c=;
        b=akLJDwiChFCLppV7UG+J3YVDw8dPW2vBk6G0+oLKVwACEgDHImgzIP1D+XNTrZpB3Z
         hWOw//5bmeGfglrqeeCkOvvsor2s9cSiEZn/Sl9N21Cefa4S4IwjAjLKwyvKHlfXQVMF
         edtflqKqDx1HnvjPX3J1TATbgsRWEaH5lM5RwoshhaTqlR4m/sDCJpQtUAuQpJ/lycyp
         YIjGVUAqjXJsfU9o0dfjUo2o+6iyIf5jxDJqyDIqpU1b4XF3OChcZ5xO6/KQE1+st48z
         A5LA3yfAdrwflMjxGJotAh+M3LJ7NCYmjkCq5PhdyG9w9RvELgoj34TRlLTs6dNsqF88
         ckAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwe64nyiKoGnm+hveVs4zozsnmA/napAW4Ab81UhGujHsZE41mbtHzvPhjPHjNT05FoHC1guhYJ7/aGCXrrcfOVw6eawUKODZCd9wGFLVOqGT6RfpL6CzgPS0/BTsCbxF4sPtahJjFlLxu8hxTijc4+Otq9/4smKCtCvpy27b2c2BO
X-Gm-Message-State: AOJu0YzIT8G24OqK9gJR06ujT6j1gjd6Z5IN/MLivR08+hIdHVhpjZhC
	ZEMBKN33301GmJY4iuQy4RGpvIRajTar6uC2ijvI/haxPv8hbyAe
X-Google-Smtp-Source: AGHT+IFhQ5TJhZiQGfJWznWvinxacb9G9eNHS5sBp4Ss9PzaItdY1bvwNXPD1UrF6O3Tza/MbzZviA==
X-Received: by 2002:a17:907:3f03:b0:a6f:5fe2:56e9 with SMTP id a640c23a62f3a-a6f60d2b9a7mr1032178766b.17.1718714627812;
        Tue, 18 Jun 2024 05:43:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b3asm618118366b.52.2024.06.18.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:43:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Jun 2024 14:43:44 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, daniel@iogearbox.net, quentin@isovalent.com,
	alan.maguire@oracle.com, acme@kernel.org, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 06/12] bpf: selftests: Fix
 bpf_session_cookie() kfunc prototype
Message-ID: <ZnGBANDTF80gNDHR@krava>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava>
 <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>

On Mon, Jun 17, 2024 at 03:25:53PM -0700, Andrii Nakryiko wrote:
> On Mon, Jun 10, 2024 at 6:04 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > > The prototype defined in bpf_kfuncs.h was not in line with how the
> > > actual kfunc was defined. This causes compilation errors when kfunc
> > > prototypes are generated from BTF.
> > >
> > > Fix by aligning with actual kfunc definition.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | 2 +-
> > >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > index be91a6919315..3b6675ab4086 100644
> > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
> > >                                     struct bpf_key *trusted_keyring) __ksym;
> > >
> > >  extern bool bpf_session_is_return(void) __ksym __weak;
> > > -extern long *bpf_session_cookie(void) __ksym __weak;
> > > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> >
> > the original intent was to expose long instead of __u64 :-\
> >
> 
> Cookies internally are always u64 (8 byte values). Marking them
> internally in the kernel as long could lead to problems on 32-bit
> architectures, potentially (it still needs to be 64-bit value
> according to BPF contract, but we'll allocate only 4 bytes for them).
> 
> It seems better and safer to be explicit with __u64/u64 for cookies everywhere.

hum, I based that on what we did for kprobe session,
but I guess it makes sense just for bpf side:

  https://lore.kernel.org/bpf/CAEf4BzbyQpKvZS-mUECLRq3gyBJbsqQghOKyAbutoB76mJM8xw@mail.gmail.com/

jirka

> 
> What am I missing?
> 
> > could we rather change the bpf_session_cookie function to return long?
> > should be just return value type change
> >
> > thanks,
> > jirka
> >
> >
> > >  #endif
> > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > > index d49070803e22..0835b5edf685 100644
> > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > > @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
> > >
> > >  static int check_cookie(__u64 val, __u64 *result)
> > >  {
> > > -     long *cookie;
> > > +     __u64 *cookie;
> > >
> > >       if (bpf_get_current_pid_tgid() >> 32 != pid)
> > >               return 1;
> > > --
> > > 2.44.0
> > >

