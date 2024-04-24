Return-Path: <linux-kselftest+bounces-8751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA418AFEDB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A197D1C22196
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28731E51E;
	Wed, 24 Apr 2024 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHawKw7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A66112;
	Wed, 24 Apr 2024 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927366; cv=none; b=HPFlGkhNaym4GavbTJacA6yRGinfgSjHY/d8BdAu56ciI9a8YCq9kxCKAY3waLThiXVuoqRt+JWay06L913L39egf6ubCdxi3ynU7sBxnHcNUiUsA0PC84W80YP14MlDPdxqDczjz9f4e1ebZieyrPq6kUCjJR7AFPUjVmPLAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927366; c=relaxed/simple;
	bh=cZ1+PthYFxekHfTKbti9TARG+0YsZEUSPJ3mG9Hfks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9yitkrWjWiOv7FpwbJOwB1nRXt4a56RYnHtnVnO12hFKZAjsnEQf8wqoNqpnXmt2eEaaJUMo9V0B//mRK4A+b2fTDEgYDo1ExSyUbphjccjHCBbIYFpgqfyTRyyT2olePGElontVZwWs2ZAyKzCHD7dTnxvzSXO6HpMOHjIykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHawKw7M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343f62d8124so5162452f8f.2;
        Tue, 23 Apr 2024 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927363; x=1714532163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlhSmXI6ce5F+KqlqRODw0wCoktBpqlg9+oR37zocs0=;
        b=jHawKw7Mtj5WezHbkkG0GzV+2l9Ae5roa0vFuS/fO94JLNVR+Kgg/qCZezb36ePC43
         OmNMmEsnPi7Ze6bfqbx3BeFLo+DOPkYlapHVc6x+4indRUUkVqN3DFREk9XecrG9UVaf
         beCDoRmvdSJt2tN1yu2NpnIQ9M3Nrjd3K2M3tFRCizMl44jrqh5WshpbAkopqXGgEqGR
         zwlflTyEd4Tjn8VnrolUCKogYpMy0f+0wsO4LYBDWD+qH+8Cb3okTutvqgUXt6B0/eZ5
         L4wHXCLX9LVleQ7ZBqKkkIiFRcChKvfW2fddXof8+g3baYFCA/5JEndeN/dcBeMnD/v+
         efKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927363; x=1714532163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlhSmXI6ce5F+KqlqRODw0wCoktBpqlg9+oR37zocs0=;
        b=xRKMCKiIzhRM3TpXE69Jdj9gBh0APHhl9KdftXS7LuQdmleOKl8fe4F6EOMoV8XnEu
         WSdMmVjnI5Jd4zI6CYeYTR/pZma9M559Hb5KKQ3mcNoEniiNqIBcFY1PMwuwvvt1I41a
         QQMkGuuwMXyRbXRVXpCgMFKnhmRjKz1CA5O9uPiHqf4A23XY/L82k3CtAQ5+y9gYivv2
         G386IB//YNUaRuZi2m8Q3NwIHZPGKxHKBSSAkH0SmVsBb9CqzH9g5RPRIv1ARLLgacU9
         VzKEQEFNybw8cMzFkSa3cwiHa3Ba9WxtxT4RgCPA69+0lO+bslRimkA5WX4GkLma/YvL
         OjhA==
X-Forwarded-Encrypted: i=1; AJvYcCUGs+JGT70QwjBlnLHqkHPeHZ5aapjlCtH04Pm3PfrsiHgsyLMqQOrDiciBvaPsDZl2+DXKLU0qMZsV7e7azeMA1Ki4xvvK/JlxGEMLebfYGgLv785G4EtZyeYvPOU2ywv+k1FtcJeYKkUdMf2Vp0gAjC5S2gD/KEyUnOvdpB3Yj3Yv
X-Gm-Message-State: AOJu0Yy/IckDmfLtn5ZNzTaYuH/pLMUGpKe03i22xkSHGRWaGY1Ch0Ld
	qC3p8VzUSMyDnWRGjbj/s4wDHL7EpnwHGkaDgHEwo+ejEHaLMg76yJqCrjPs6ihaF/O7ibr9pRB
	eDU29lk0Rrxe2Lh49DJDYI3FQN1Q=
X-Google-Smtp-Source: AGHT+IEwfPyMo2qk86mudfX969TI7whouNyi5jn3rjzXoP3vCj5EIyefPNRFNWkJYGp6SPNigNYp70Ui07ToC7GGOHU=
X-Received: by 2002:a5d:4d12:0:b0:33e:c924:5486 with SMTP id
 z18-20020a5d4d12000000b0033ec9245486mr627750wrt.46.1713927362917; Tue, 23 Apr
 2024 19:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-11-6c986a5a741f@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 19:55:52 -0700
Message-ID: <CAADnVQJ9Qw6Lr644xRTU-n16UkBCyHoTAQs7QqGiniOdsOVAJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] bpf: wq: add bpf_wq_init
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> We need to teach the verifier about the second argument which is declared
> as void * but which is of type KF_ARG_PTR_TO_MAP. We could have dropped
> this extra case if we declared the second argument as struct bpf_map *,
> but that means users will have to do extra casting to have their program
> compile.
>
> We also need to duplicate the timer code for the checking if the map
> argument is matching the provided workqueue.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> FWIW, I still have one concern with this implementation:
> - bpf_wq_work() access ->prog without protection, but I think this might
>   be racing with bpf_wq_set_callback(): if we have the following:
>
>   CPU 0                                     CPU 1
>   bpf_wq_set_callback()
>   bpf_start()
>                                             bpf_wq_work():
>                                               prog =3D cb->prog;
>
>   bpf_wq_set_callback()
>     cb->prog =3D prog;
>     bpf_prog_put(prev)
>     rcu_assign_ptr(cb->callback_fn,
>                    callback_fn);
>                                            callback =3D READ_ONCE(w->cb.c=
allback_fn);
>
>   As I understand callback_fn is fine, prog might be, but we clearly
>   have an inconstency between "prog" and "callback_fn" as they can come
>   from 2 different bpf_wq_set_callback() calls.
>
>   IMO we should protect this by the async->lock, but I'm not sure if
>   it's OK or not.

I see the concern, but I think it's overkill.
Here 'prog' is used to pass it into __bpf_prog_enter_sleepable_recur()
to keep the standard pattern of calling into sleepable prog.
But it won't recurse.
We can open code migrate_disable,etc from there except this_cpu_inc_return,
but it's an overkill.
The passed 'prog' is irrelevant.
If somebody tries really hard by having two progs sharing the same
map with bpf_wq and racing to set_callback... I can see how
prog won't match callback, but it won't make a difference.
prog is not going trigger recursion check (unless somebody
tries is obsessed) and not going to UAF.
I imagine it's possible to attach somewhere in core wq callback
invocation path with fentry, set_callback to the same prog,
and technically it's kinda sorta recursion, but different subprogs,
so not a safety issue.
The code as-is is fine. imo.

