Return-Path: <linux-kselftest+bounces-6468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D9885D09
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF7E1F21B21
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693A12BF3E;
	Thu, 21 Mar 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emZykm2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040412BF20
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037392; cv=none; b=nVRbQ8tpQu+q/ZEz94mJSODGtwfo/IsP+E56vgRmhbDzMOygUlwKj7gOACTVAXIGK8PKEGBORAF+YQRCBv4hwnwwsp+vxDWS/9o98/Jci4Loip1yeFmH78mY9lrz0QMGApkAJZ6D9qUf8bsc0Z8aVk1JdngRSB2IqMHFn6gm4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037392; c=relaxed/simple;
	bh=Efa9pooFtZFexc8t2FHAlDSOT6+OQH2tDlvcl4EcU6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpD0TU4vrhhiJi5mK3KKrH1MyXw7E2L+lBY2xnomWVVjij04xFVvJlubx4gXtCn5yGcJEH++gsF5QTPDB/XTZLhCd/pcPOpWrt60EN9NL7WP+feBqo7RnoZuBYHBuDmLk7+sT7w2VTxcgc8tVlIFJs3qvz13FuqKWqS59bQyKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emZykm2B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711037389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
	b=emZykm2BsImJeejTTs0HBrGVqbn+dPeB3+KEjhudQ+1/afZ8HmRVud2WH2ywo4+V3jFdiQ
	gCqy6nBmOxZjRV+VBafMu1E9WPmwHe9bRr748NQXTwztdmPq9SPUBobh9t//YIfELy+HUw
	nLA0oQOf+S0JLbFQnE32x2iq6OBAJMU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-acBuEzwUM2GWNqahrVmAdg-1; Thu, 21 Mar 2024 12:09:47 -0400
X-MC-Unique: acBuEzwUM2GWNqahrVmAdg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-568728e521bso1060684a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 09:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037385; x=1711642185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
        b=uTPavQUhmNWiC2el4Yy8f6YqZhJBuTqErn3XRfqiU/MccstNab8zHVMYzMfu6TqN/9
         T5m6UA32YhAJoTUoEF68lIE68aF596Uo1EtihDIFl8hkFgKJFYsR4dS72TyM8tdmVBnX
         clZjYL/K75phBj0UD/XlHkDN4sY9+1KuUaoP5rtMCHLSPRN7y2S1HbdA/YinNcv3C/5x
         bhr/gXu6YlCETU51XDaL6Z28eEnU3EvLYEA90uKlInhQFLCMFukjK7VcnlughvdMmJPm
         cnPr3LumiwsmabIMQcYtbIbsVpfdVi20oZPBmI4tZUGMOlhD//gI8LpscJHN+tJ8sfe9
         siCA==
X-Forwarded-Encrypted: i=1; AJvYcCV/mJzJRBEuD/s5AG8g5hloIesyE5CTNLPQGEhzREeo/VbOQUDwP45/fNO5dFpdGBmzgOQrBLJv/Ex5caQKQSTysa2ziL7qbMozod2fHpjL
X-Gm-Message-State: AOJu0YwAgGdjhqWYXUTBmwPLIU4moJVK7FVPAcu4u7bx5C4wgwWkxeGZ
	mDj39WkfC8t/KWefLP5ES4fwqkqiLusCbEoah/qayEqWhroMALTVsxrarbrxH753syEaWdKC18+
	+1Tv0ipM5e1BTZytfiMu7A738q+zK5ZudRGxiSK7S0eXbCCFxSmv9N47GqBT7bfVF/JheMTF6YQ
	65NYPbicWMDsGp1if8I23Up81NDF5Uyu8wZmZP2T9a
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id t33-20020a056402242100b00566f5d604b4mr6854702eda.12.1711037385193;
        Thu, 21 Mar 2024 09:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJczUOKWHiXnEN5u0YPmmuAnhgkpGir9OOZXAH68RtsDs3o/mdfwXGaEp7tIlIBwPP814Hb6KspJCMPCXLbDI=
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id
 t33-20020a056402242100b00566f5d604b4mr6854684eda.12.1711037384888; Thu, 21
 Mar 2024 09:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org> <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
In-Reply-To: <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 17:09:32 +0100
Message-ID: <CAO-hwJLh00--9AbS=7z4+W7FgA+hLA8hViMmaMMfz2mERcMwhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> [...]
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
> I was curious why 'env->cur_state &&' check was needed and found that
> removing it caused an error in the following fragment:
>
> static int do_misc_fixups(struct bpf_verifier_env *env)
> {
>                 ...
>                 if (is_storage_get_function(insn->imm)) {
>                         if (!in_sleepable(env) ||
>                             env->insn_aux_data[i + delta].storage_get_fun=
c_atomic)
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_ATOMIC);
>                         else
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_KERNEL);
>                         ...
>                 }
>                 ...
> }
>
> When do_misc_fixups() is done env->cur_state is NULL.
> Current implementation would use GFP_ATOMIC allocation even for
> sleepable callbacks, where GFP_KERNEL is sufficient.
> Is this is something we want to address?

I honestly have no idea of the impact there.

AFAICT, if env->cur_state is not set, we don't even know if the
callback will be sleepable or not, so if there is a small penalty,
then it's the safest option, no?

Cheers,
Benjamin

>
> >
> >  /* The non-sleepable programs and sleepable programs with explicit bpf=
_rcu_read_lock()
>


