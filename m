Return-Path: <linux-kselftest+bounces-7455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FD89D0CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6CC1F254CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B5548E9;
	Tue,  9 Apr 2024 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zljs23FD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C5657D4;
	Tue,  9 Apr 2024 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632455; cv=none; b=PLi5uFZEIWa8ykM1sPDBr+h5bvN5r0mr/jVwgJ9f9MSB2vD5fewk135bsnzeNuIUUt3p7nMLXlMsYpkaX7W/3uqxaueR+I2F/oau4W5bJAOjmXIcJ3xqMoipNoBjOv4TTwAuSyJc3LrRgfR5dBCByyiMBgrc/ZuZJkg+p5Fp0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632455; c=relaxed/simple;
	bh=CM4PqyEMR6sAaGtsGj1JayRPHeuY2qAqrJ0+o0qcKR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWzCRsQMCK+OMbbyl+148MDo7jeRWxyHQZrfATDGxwU1uwdVLehyO8hjn6d2Keman9M/ro/4RTUR4wMpsk7OoP6T2f7orVfuhVYBpNC8h+G6NGJvb8/MK3malW+KSJb2fawvdwiuP4trKoe365q+E+QsUix/WRKVZFwEtFxVRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zljs23FD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-345b857d7adso1113801f8f.1;
        Mon, 08 Apr 2024 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712632452; x=1713237252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/w6jt9gT3BKa04bz0+7QHX98tgP06v5Gtwmcj913TY=;
        b=Zljs23FDROh83Bit3EfPHWhHE8HiA1l6oomi/RvXM74Qwae+sLWYWyU41sUTMy3W8U
         1TnLGyGKhN5dtmbzN7kiKDCZa2UcolMjlXxNUdmzsMSHztsQJzLNawewkvKbEq82V06W
         VsAb7J1EVs1VU+eFDX34TNWydCyZgxAy3wFCDXulnZTRPnSFRcuNAX2J/R9n4IdtZtOP
         v00YNv1n8JbqDiT8T9ipUWVPnvdKM5tvsY4wP622Ek0nvO1wD1HOFoNgYXv+5bLFYpe+
         qyRnL4sopLmrin6IGAKVII5p3jzDt4iP02a7/b3Y2kSwlPMvDcwmq5qWRNGtv1HsVPQ8
         5O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712632452; x=1713237252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/w6jt9gT3BKa04bz0+7QHX98tgP06v5Gtwmcj913TY=;
        b=vgBfsYc8IH8NMdLc1kSuvIlj5JjDkLXHy5z0DUd6wOUYXnensM++BJYDpWbFBah26+
         E+8JNmM1kix5i9f7FpmNCZolBu3FaFhVC0P/sALU543hDnoLduBn7eU5sjtdSeDe0Wwf
         z6PoGASn/RrhyN11E19/aTYnhHsW2/mIFMqT0FmhN30YM0nllQY7cI2Epwg5guPrlDfR
         Z2578svuMONRe7Un0UU83hvYzaF0RY6sL2SiaioQ7gVPfUQMVwjTqgt7zilR0tiNrnNS
         RIqpP6Y0giuPWa+otfazaEpyjrm5/5bkzVdwf94HAJm1dfYCORB8So8IJcRwGUVke5P1
         Tlsg==
X-Forwarded-Encrypted: i=1; AJvYcCUEunxA88efBcuehSEKVUZw9SveYdnoMI/wWdshASL6fUb5LSscv/1Ozp8yBwU3hPbOc0j5IvieZjHdtlnsygevE6HllIhOT63O9Ozyi6PHEbWQ7eG41qQ1T1kso/SNTmPm747iQaXJbVwxC9AlNPvnrFx0Nt/pe0Xn420BJKX+izg7
X-Gm-Message-State: AOJu0YzGm0gAVcANyhLmt2KJzui0L0bdh7xyC15KqqkqT2BBp7qu58BW
	Ch0/FNKz47WNbzE1OJP70r1DGCSJZDaWNNyTDlv5s+yZlaayDij7zdqRiblbqETLiaGm05JTKRt
	Yd47dJNFOnWPV6eoqo+DqByx7cyk=
X-Google-Smtp-Source: AGHT+IHJyJtg93yK6isUzjITmuhwRvOEYT7c0OT+pFXOkgyywzS6TLcarjxjPa93uO2BLvTNnEdv3e1BvQUWYuI5nS0=
X-Received: by 2002:adf:edc8:0:b0:341:e368:a50d with SMTP id
 v8-20020adfedc8000000b00341e368a50dmr7693182wro.18.1712632451619; Mon, 08 Apr
 2024 20:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-4-0499ddd91b94@kernel.org> <db1f8413ef4ebc57b9ddc586e48acf3fad19ebf2.camel@gmail.com>
In-Reply-To: <db1f8413ef4ebc57b9ddc586e48acf3fad19ebf2.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 20:14:00 -0700
Message-ID: <CAADnVQLvRK7eYvHGv4aUyCFakqVz=3aSOzX58zP9nHtNXf9h=Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> > Now that we have bpf_timer_set_sleepable_cb() available and working, we
> > can tag the attached callback as sleepable, and let the verifier check
> > in the correct context the calls and kfuncs.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> >
> > ---
>
> I think this patch is fine with one nit regarding in_sleepable().
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> > @@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifie=
r_env *env,
> >
> >  static bool in_sleepable(struct bpf_verifier_env *env)
> >  {
> > -     return env->prog->sleepable;
> > +     return env->prog->sleepable ||
> > +            (env->cur_state && env->cur_state->in_sleepable);
> >  }
>
> Sorry, I already raised this before.
> As far as I understand the 'env->cur_state' check is needed because
> this function is used from do_misc_fixups():
>
>                 if (is_storage_get_function(insn->imm)) {
>                         if (!in_sleepable(env) ||
>                             env->insn_aux_data[i + delta].storage_get_fun=
c_atomic)
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_ATOMIC);
>                         else
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_KERNEL);
>                         insn_buf[1] =3D *insn;
>                         cnt =3D 2;
>                         ...
>                 }
>
> For a timer callback function 'env->prog->sleepable' would be false.
> Which means that inside sleepable callback function GFP_ATOMIC would
> be used in cases where GFP_KERNEL would be sufficient.
> An alternative would be to check (and set) sleepable flag not for a
> full program but for a subprogram.

At this point all subprograms are still part of the main program.
jit_subprogs() hasn't been called yet.
So there is only one 'prog' object.
So cannot really set prog->sleepable for callback subprog.

But you've raised a good point.
We can remove "!in_sleepable(env)" part in do_misc_fixups() with:
-                if (in_sleepable(env) && is_storage_get_function(func_id))
-
env->insn_aux_data[insn_idx].storage_get_func_atomic =3D true;

+ if (is_storage_get_function(func_id))
+   env->insn_aux_data[insn_idx].storage_get_func_atomic =3D !in_sleepable(=
env);

