Return-Path: <linux-kselftest+bounces-12159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A418290DA23
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6320F28467A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389513A400;
	Tue, 18 Jun 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb2rLFAP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D61CA80;
	Tue, 18 Jun 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729918; cv=none; b=F1PuGKOIc2JSOWyZejKXZHaISa4Ur+HMh/se7jLn8aDG4xR7sCdDgm3n52KckGPG6/Tk3CxGo8QqRU/PTU1M/EQhcQSeUvv5ADQNIJ/ALL7GaEVbEOzmJfT/QARjWsR2rvNeAMpqKKMdJnxeKy3E9j/Rl1jILcPLqtadVR/hQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729918; c=relaxed/simple;
	bh=CGLMfP+9fmPVHWYRrQk0VH746bSAgH57jOcdZOrbsm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2f6xI7Ps3XQdvnvyTBVA9MWAtB9gXWZy3wOx6pvgki+AixAAIoJ0L+36tNj5My5sHo1wIUHjYKTLYh6VJxjwDzg0aXPCS2Frq5XJxneXUipbcTVxsGcHCdb/H8yt8voJGUziuU7WMEgqR1Yw5VU15USGGQTKjMQZXL+JOsd34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb2rLFAP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-709423bc2e5so1902937a12.0;
        Tue, 18 Jun 2024 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729916; x=1719334716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amL0dvQdgPJSIGkY5besFFBPs9/nrgT130CTChfqsCg=;
        b=Hb2rLFAPAI59X2EYs53ta2d+SUuVicN+gWfN41BhaDcH3eey3moOl7gfdBc13r9v8v
         0Q/nUaem093sOO9Yc4amhiGhP29OI7jB2hv+8FIeM5w5xv1ocTI+QdhUgiTC/7ID9hdk
         qXkcHRKgGqhiIPzlXas5dTryprV1qiLRlzTU0QNgNfZAjp7X18ITy4GdGwy0nEYDL8X7
         z6aamTjtiqBRljOXeje08KaWxmvpp8GHUEDOt5lKS58nQ61bFdmqCLEZRErll+xbvdmX
         dNzWARM90xwRKq8Hn1HKiCxyikfNjcGK3zWSp42eLInH46UXD5/dfTQOndFAsTasOK2s
         U1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729916; x=1719334716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amL0dvQdgPJSIGkY5besFFBPs9/nrgT130CTChfqsCg=;
        b=T2xPyPS0kbxQwDQq8M8dQ7eI5m0cs8I7eNIDmeRxBjJRYWtVCYDaPoy0kXVooLDPuu
         rK+foKkOAy8oubCNRxsp5YcePWJjE9nqnxfEOibL/7TxQuKMqtf9BBQvvYaZCFGhvyo4
         gqveeFIupcY+XA3O2SZ8ihATMXlcxL9FGuFwgQf0FB4ScW0/Fccxp0g6egUAsQunZvJP
         HMRVHcmgw61XBfssdmWasWBnPMIf5P42kwttfUfQ0+ToI4XHyEnHXR0rTC8iWiXlhKAU
         raY+N//k4i+x/CZ/Cb5BYaW0bk5FnyCING8sVnVrbeB490SV7kVF4pJZwUWyBV2eFHYk
         agUA==
X-Forwarded-Encrypted: i=1; AJvYcCWOJ8e2Lh3cu8FaOz57ecqCLOB8mAFwZPvkLA5TmVQXPG8MSxpHTQAlmGprRCF2Tb2UtWgpu5PPKAZia7nVgpU7kyQkWUxKKSdFEYMs7tVySsSxMCUpKvOVFKkE5hwbaZd/8oC76HlGSY23Pk3V26XatKtXCWu22AwVo9o2sXWH0vFI
X-Gm-Message-State: AOJu0YxmA1BkqePo7g5vQGnVXtnmNj33Eftxy0jVSwUQYy2aMjq8ROAK
	fjQdb0fPCZQLEIoiJGEghC9ROyU6WJ0eIhJhn0EM0lQ+E+A43WhO12KvDAEx7ckSXJij2qGbOmQ
	ztDlBidVh7RPK28pPwWBZ6S4+txA=
X-Google-Smtp-Source: AGHT+IGAKcPHkZAX1pWY+gmY9Pwq3uPjHV5FgVn6f9ezL8+Y0l5A6TL0X7loIn/HOeudP+0S0KFX54LgmHNxJj1liW8=
X-Received: by 2002:a17:90a:128e:b0:2c0:238c:4ee6 with SMTP id
 98e67ed59e1d1-2c7b57f3b2fmr325160a91.2.1718729916022; Tue, 18 Jun 2024
 09:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717881178.git.dxu@dxuuu.xyz> <34708481d71ea72c23a78a5209e04a76b261a01d.1717881178.git.dxu@dxuuu.xyz>
 <Zmb52Qp__CBzbgDh@krava> <CAEf4BzaT7XNnGFUqAr=+pi106bT0o4=TJ7JLOPNjZEBHw4+M7Q@mail.gmail.com>
 <ZnGBANDTF80gNDHR@krava>
In-Reply-To: <ZnGBANDTF80gNDHR@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 09:58:23 -0700
Message-ID: <CAEf4BzZVfppin_mfEJF9eVcZUu9hds5PKuLysWOXeSJ7gdV3dg@mail.gmail.com>
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

On Tue, Jun 18, 2024 at 5:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 17, 2024 at 03:25:53PM -0700, Andrii Nakryiko wrote:
> > On Mon, Jun 10, 2024 at 6:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Sat, Jun 08, 2024 at 03:16:02PM -0600, Daniel Xu wrote:
> > > > The prototype defined in bpf_kfuncs.h was not in line with how the
> > > > actual kfunc was defined. This causes compilation errors when kfunc
> > > > prototypes are generated from BTF.
> > > >
> > > > Fix by aligning with actual kfunc definition.
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > >  tools/testing/selftests/bpf/bpf_kfuncs.h                        | =
2 +-
> > > >  tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c | =
2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testi=
ng/selftests/bpf/bpf_kfuncs.h
> > > > index be91a6919315..3b6675ab4086 100644
> > > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > > @@ -77,5 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_=
dynptr *data_ptr,
> > > >                                     struct bpf_key *trusted_keyring=
) __ksym;
> > > >
> > > >  extern bool bpf_session_is_return(void) __ksym __weak;
> > > > -extern long *bpf_session_cookie(void) __ksym __weak;
> > > > +extern __u64 *bpf_session_cookie(void) __ksym __weak;
> > >
> > > the original intent was to expose long instead of __u64 :-\
> > >
> >
> > Cookies internally are always u64 (8 byte values). Marking them
> > internally in the kernel as long could lead to problems on 32-bit
> > architectures, potentially (it still needs to be 64-bit value
> > according to BPF contract, but we'll allocate only 4 bytes for them).
> >
> > It seems better and safer to be explicit with __u64/u64 for cookies eve=
rywhere.
>
> hum, I based that on what we did for kprobe session,
> but I guess it makes sense just for bpf side:

yep, exactly, long is 64-bit only for BPF "architecture", but
internally it will be 4 bytes for 32-bit architectures, which will
potentially lead to problems. With recent kfunc vmlinux.h generation,
it's probably better to stick to explicitly sized types.

>
>   https://lore.kernel.org/bpf/CAEf4BzbyQpKvZS-mUECLRq3gyBJbsqQghOKyAbutoB=
76mJM8xw@mail.gmail.com/
>
> jirka
>
> >
> > What am I missing?
> >
> > > could we rather change the bpf_session_cookie function to return long=
?
> > > should be just return value type change
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > >  #endif
> > > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session=
_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
> > > > index d49070803e22..0835b5edf685 100644
> > > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie=
.c
> > > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie=
.c
> > > > @@ -25,7 +25,7 @@ int BPF_PROG(trigger)
> > > >
> > > >  static int check_cookie(__u64 val, __u64 *result)
> > > >  {
> > > > -     long *cookie;
> > > > +     __u64 *cookie;
> > > >
> > > >       if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
> > > >               return 1;
> > > > --
> > > > 2.44.0
> > > >

