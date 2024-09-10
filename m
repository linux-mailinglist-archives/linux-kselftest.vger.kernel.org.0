Return-Path: <linux-kselftest+bounces-17658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB09745C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BF1F220F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57D1ABEC5;
	Tue, 10 Sep 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQbpllxT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDB1AAE25;
	Tue, 10 Sep 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006749; cv=none; b=I4NqVa8ofusik7JKn0KxBnFns2kBobB4/KBaPYroDLpMJ87uY994s6KNdmSw04aIZQSjw3Zzs9kTOhDS4DlJvRswgicD7HxT4f+G59MjwauFTprNVkz/StI2F/VerpuPg7LzpiGDiizUo0PixWsXJozrBTPq5xw+cwJcrjc1iIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006749; c=relaxed/simple;
	bh=UFuuxW0soNlN52g9otgpgl4fMEI2WSTOOMH/CN0LhtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6aXHZVzJHRmlFwJIioV+uy6DfOdpvqozq6TB1qlhbkkazgyQEPkeBDOBv/Po/v3LdFF1Bu2XPmI6iODbhCB+HltFdWuqImnUO7MsJUN8Ux5uXDW9vLAuI6YFOuOkbA2WMpdKT911T1dBVS334cf/TPFYxru2IoIiwONClQrtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQbpllxT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87176316eso216960a91.0;
        Tue, 10 Sep 2024 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006747; x=1726611547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cb9Q1J+iiadzHKEFsqhGE/rpP4wr5ZZp/lo1oFo9bA=;
        b=JQbpllxToXPgvpvG+8+qqilDg6rKQ9a40Epf/7FCNUkqAHh73Brfm3dcwXIm8my0x8
         bsQ8VqDjZmkWXkKTfCjjzqByc04+ZhsJOIhRutBeGFHhzXEi2H1QEbcSnDd0GUHaN6i4
         hLu4BJM0xrCE7fFQMHphXp7YvhWCVWBdG2iYttWuiFTxiceyPnVn9efqmpVACMsB0WyT
         uxzAlW/uNRt4DzcbmvwjtHkXY4EFgb2KzLBTei4azCaLgmZFtsYAyrDqVmmkUQFezPPU
         vjQK/Ija5s5DRhSuLS+a/judTdFIRamcFTi92nWqSVASUgx/bo/ptx7BY5OtuYVVA9i4
         PelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006747; x=1726611547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Cb9Q1J+iiadzHKEFsqhGE/rpP4wr5ZZp/lo1oFo9bA=;
        b=cB8bodTu0UnQrg6C5P9v/CfZcvKvDbA8yNK10HpqThP6T4lpmBDTAnv30Ms7otDrG+
         0SjMyIRdv3yLeOjazVGdScSB/0fBq5qQeU48jE8abhY2gOHxpICLUa1KrLIzTuaFXeAN
         3tdiVNhmxRejoDk6YMUDEhPVYR88WccK5iF5SEhcWiNQ5pTRRqvheXqJq0Ynd1AF5JAl
         Qwu2HoHHCoZm97pEW7ge0wKZbXSxYenGm8xT5SFl/kx51vVaXf/bfWyojGtW+hDuUODK
         JMfO/VLymjfxcFSwdMuI9jFqCGTcwAckbYNFgFx8LsK29ysF9wTr2+vzlWw1LY/AUaCf
         2qKw==
X-Forwarded-Encrypted: i=1; AJvYcCVtvhMOsklxX67Z2IQ/JZLRMU3SyzJfXY3M06hDGBkVM+c9jQ/HW3HhRxiPUHLtxrim6Y9G/TqhkwkdV/Oj@vger.kernel.org, AJvYcCXUIgclVn9Ul7a4R1ryeyb4qgYl47boAX1gIgd0ydmcTZLXcyfxSJXWYO36fm6fVIo+nK0=@vger.kernel.org, AJvYcCXpxhSj4Zrx6mrDXq4BpaMvr14xFjCfpUAXGp1RU+j/GmLwYDm91gNKwy+mOUDzl4hVUP6HCPIrcV6J5rYny7+W@vger.kernel.org
X-Gm-Message-State: AOJu0YzBG/O9wNLw0CgpV9OUKFN4WlSdM+5fX0sOwBFkCYhGib0TYrb1
	xqPptNJEJ6/KcliHY0E2A9nJ6GICAvpwjbnBVGguvMmi5A6gzqW0vBLSrLUsFCiuY1s068EAumG
	UkyO3cB9MdTwNQ4wL1gvDJCUszE4=
X-Google-Smtp-Source: AGHT+IGN04DnfI2S7+FK9ucoPy6zCVdQaLMdv6LJzualnLQynvqTC+vZMJAarS4BmJkNdMLqxkaCWUXlQe6FEovETnw=
X-Received: by 2002:a17:90a:2c4a:b0:2d8:719d:98a2 with SMTP id
 98e67ed59e1d1-2db671989damr6692283a91.7.1726006747202; Tue, 10 Sep 2024
 15:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com> <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
In-Reply-To: <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 15:18:52 -0700
Message-ID: <CAEf4BzZRExYJtPz9p05p9sWKHzsE9KaDnXifoWqim2XsA8K_eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:07=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
> > On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 9, 2024 at 5:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
> > > >
> > > > Right now there exists prog produce / userspace consume and userspa=
ce
> > > > produce / prog consume support. But it is also useful to have prog
> > > > produce / prog consume.
> > > >
> > > > For example, we want to track the latency overhead of cpumap in
> > > > production. Since we need to store enqueue timestamps somewhere and
> > > > cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BP=
F
> > > > ringbuf is such a data structure. Rather than reimplement (possibly
> > > > poorly) a custom ringbuffer in BPF, extend the existing interface t=
o
> > > > allow the final quadrant of ringbuf usecases to be filled. Note we
> > > > ignore userspace to userspace use case - there is no need to involv=
e
> > > > kernel for that.
> > > >
> > > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > > ---
> > > >  kernel/bpf/verifier.c                         |  6 +-
> > > >  tools/testing/selftests/bpf/Makefile          |  3 +-
> > > >  .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
> > > >  .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++=
++++
> > > >  4 files changed, 120 insertions(+), 3 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_=
bpf_to_bpf.c
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 53d0556fbbf3..56bfe559f228 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struc=
t bpf_verifier_env *env,
> > > >                     func_id !=3D BPF_FUNC_ringbuf_query &&
> > > >                     func_id !=3D BPF_FUNC_ringbuf_reserve_dynptr &&
> > > >                     func_id !=3D BPF_FUNC_ringbuf_submit_dynptr &&
> > > > -                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr)
> > > > +                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr &&
> > > > +                   func_id !=3D BPF_FUNC_user_ringbuf_drain)
> > > >                         goto error;
> > > >                 break;
> > > >         case BPF_MAP_TYPE_USER_RINGBUF:
> > > > @@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struc=
t bpf_verifier_env *env,
> > > >                         goto error;
> > > >                 break;
> > > >         case BPF_FUNC_user_ringbuf_drain:
> > > > -               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF)
> > > > +               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF &&
> > > > +                   map->map_type !=3D BPF_MAP_TYPE_RINGBUF)
> > > >                         goto error;
> > >
> > > I think it should work.
> > >
> > > Andrii,
> > >
> > > do you see any issues with such use?
> > >
> >
> > Not from a quick glance. Both ringbufs have the same memory layout, so
> > user_ringbuf_drain() should probably work fine for normal BPF ringbuf
> > (and either way bpf_user_ringbuf_drain() has to protect from malicious
> > user space, so its code is pretty unassuming).
> >
> > We should make it very explicit, though, that the user is responsible
> > for making sure that bpf_user_ringbuf_drain() will not be called
> > simultaneously in two threads, kernel or user space.
>
> I see an atomic_try_cmpxchg() protecting the drain. So it should be
> safe, right? What are they supposed to expect?

User space can ignore rb->busy and start consuming in parallel. Ok,
given we had this atomic_try_cmpxchg() it was rather OK for user
ringbuf, but it's not so great for BPF ringbuf, way too easy to screw
up...

>
> >
> > Also, Daniel, can you please make sure that dynptr we return for each
> > sample is read-only? We shouldn't let consumer BPF program ability to
> > corrupt ringbuf record headers (accidentally or otherwise).
>
> Sure.
>
> >
> > And as a thought exercise. I wonder what would it take to have an
> > open-coded iterator returning these read-only dynptrs for each
> > consumed record? Maybe we already have all the pieces together. So
> > consider looking into that as well.
> >
> > P.S. And yeah "user_" part in helper name is kind of unfortunate given
> > it will work for both ringbufs. Can/should we add some sort of alias
> > for this helper so it can be used with both bpf_user_ringbuf_drain()
> > and bpf_ringbuf_drain() names?
>
> You mean register a new helper that shares the impl? Easy enough, but I
> thought we didn't want to add more uapi helpers.

No, not a new helper. Just an alternative name for it,
"bpf_ringbuf_drain()". Might not be worth doing, I haven't checked
what would be the best way to do this, can't tell right now.

>
> Thanks,
> Daniel

