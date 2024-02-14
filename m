Return-Path: <linux-kselftest+bounces-4633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A2E8549CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF93D282720
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8BA53E24;
	Wed, 14 Feb 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzMaoC2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1852F90
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915396; cv=none; b=mv+VrDWGZg0BssKbipIgqWrOLEWV19oY7gzNI8rI5cnqlg4FkhnmuEQoLlBpUquyddZAczal1JA8lac9uPMLQ+UAcz9sBtnDefLc4CarVSGph0cWCNVN8kvu3zcacCA3poewMeYtsQfiSCeAzn3aM4+Ve0vNRkERaHFNipuYEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915396; c=relaxed/simple;
	bh=FJp37iTRPYPRDJyHF81G0HZwGNHWM28gXJ/LmpRlD1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t97YMzWbQysl+ffetY/B5lPSthsVwuzDAuY3QvkePZ1XkrlEe1ING1djmiXexGG9dFAzbH7nFpLbhCbCLvjyhHiyYm5lrnjq8LcQaH0g+5KNzI4mr508dkAo0M7K4DM3+SgC29U8ngn7qQQSh7xNX94HpcVpxcUJCQqZgDSrgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzMaoC2B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707915393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJp37iTRPYPRDJyHF81G0HZwGNHWM28gXJ/LmpRlD1c=;
	b=YzMaoC2BsRjV+QxtjJUieTSlQzt0jlhZ35SDci2FTNzFMefvYMst/s+5xTUPEynb1P6Phg
	3xPXwcsZ4IJX/b4IITU/Vk0igcyYsvbJSDgT/iZSohGd2atUnWDFjHyC1ee0gLh8YpHGda
	mmxpfjgZo2erCgoJiMwdmtTDqGD6WH0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-pVdL3u36MO65hMO1GYmcRA-1; Wed, 14 Feb 2024 07:56:32 -0500
X-MC-Unique: pVdL3u36MO65hMO1GYmcRA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d481c7d8cso32941066b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 04:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915391; x=1708520191;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJp37iTRPYPRDJyHF81G0HZwGNHWM28gXJ/LmpRlD1c=;
        b=cY39qXe1hOecHeMTmLhh31NWz12ygzE+xRfs1DBndLTlLhk4x+uxXO7P4bEFu/PfSx
         /w2s/vCHf+B6YsqYj3dvQCUCDJbAJlPaTFhQOn0+3djtqkItDGogqWbeJUmQ/6e812qa
         zl49idrVuwnD0upz7LhVqWDNAOG2+vxZnU2MJCQwaFHrIb0BT+FaKw+Si//HdFA1FTiU
         BxjGE+pOqbmNk4zvwUQlVje7GVSqe03cqf80d4/eGnykn4vTghxzBDY/6Yf2YnGcV48K
         JzetZQgEzntAmWXGiiMo41nRxlCtAGf2vNbtsqHqRfBMe5G2hKa7dzcIOREL98DwDNhw
         cl3A==
X-Forwarded-Encrypted: i=1; AJvYcCXhLVBZkrg5Diy/PgimABB5AuAyXwsu4R7+1mEEbSG0tCPuL6GbNOEBppgmqUqGndRHVFOZw5MmmOwlDg7ED2TUraq7lbF4o7wF5Gd50WGR
X-Gm-Message-State: AOJu0YxoIk+YZoWtFDLq4JMviX6UQLDBwLPMP2kts5WAIpD4cevHo6zS
	eKm0WSYcmxah86gP89vFSajzMTa8HTaiF/zkQloTdhGz7MoY5nKiADgSEgD3eIgmgVBHfpEZRGf
	o1TfbLjrPsr3qVgGVL50V1pK5+WGmmyVrfJwEKDo/kd4MLLGIzlr5nl/fC8+agbU5sA==
X-Received: by 2002:a17:906:f8cf:b0:a3d:2422:ee73 with SMTP id lh15-20020a170906f8cf00b00a3d2422ee73mr1559801ejb.77.1707915391120;
        Wed, 14 Feb 2024 04:56:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtC4RmVIKd3BfBmk6nYmZIZiM8phFHfpA/m86d7qk4SVIPJZDEl1BVx7eVsmIDBaNUG11aPw==
X-Received: by 2002:a17:906:f8cf:b0:a3d:2422:ee73 with SMTP id lh15-20020a170906f8cf00b00a3d2422ee73mr1559778ejb.77.1707915390722;
        Wed, 14 Feb 2024 04:56:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeVT566eawAqV4mSiYIM54RSXg8KcFzFeTfM3lTaqYUMHBIUCXS/1t/A3OUh7PJjPlqfAuhmCDkluKHV5tDkoxAwbqEWcsb9OHKXszu9xt1+XsHDsqQR/Gt6oMAJQxj44Rtg1OIEF+AcFruNXTnueqhOSsty1y8hMHV/Q0Hy+vXJQpN0xBV3ghNG/4nguQ2hrqJJDM8MZHSY6bIj5ts1xFNA5MQpgsHrvI1Em0gVn7Y2389Jy3RsiAL7THwe00c2TzV7T7EyOWYKihiAu5o+rtxRs8uXtR/8gGy9RDXg28p1fPZJIaYFZR1R9IsZYukb84tHI0pSYWTJNbTvxqu+j6oHcO43pcoCf5hxkqfgFDAJYr0ELb4pmAHgPMPEFoJrJLDNiCLG16PPatmNBKy1MNPwrf/YGrGwcacXGEO19Jn8Suusnc+ODFM+fkSY0zIFsLdG799C9+nD4ryXbDWIt+ojfqV8NyG0IJdWyrRLa3cNG4+hmXhFUq3zif8GB1EA/FMNM7pf8JVk4YNRjHpH32s+cpFXVMNmhubaIYqYaL8uDYxGAF20wM0VY6oYtaO5GfSYOZhvG4Fuyz/XALrhx2z6Z7dsYB2dG2bUYSeLI8tCQ1YzLYVj6dKMcM3F9nDqm3Ur2Xrh8lMjGM0WTj7OwrpTIo9R78b+zsq8Yv9X+UDIL64djWOPfW1itQBIqU6VQ=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3cfe376116sm1673172ejc.57.2024.02.14.04.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:56:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CF25D10F578E; Wed, 14 Feb 2024 13:56:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Benjamin Tissoires
 <bentiss@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:HID
 CORE LAYER" <linux-input@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
In-Reply-To: <b2k6rlzu5vgpouedwjbsigoteo43nwfk6qeeb2pc7c3r4ejnm6@nml66ds6wbeo>
References: <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
 <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
 <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
 <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
 <877cj8f8ht.fsf@toke.dk>
 <b2k6rlzu5vgpouedwjbsigoteo43nwfk6qeeb2pc7c3r4ejnm6@nml66ds6wbeo>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 13:56:29 +0100
Message-ID: <874jebfblu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Feb 13, 2024 at 08:51:26PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>=20
>> > On Tue, 13 Feb 2024 at 18:46, Benjamin Tissoires <bentiss@kernel.org> =
wrote:
>> >>
>> >> On Feb 12 2024, Alexei Starovoitov wrote:
>> >> > On Mon, Feb 12, 2024 at 10:21=E2=80=AFAM Benjamin Tissoires
>> >> > <benjamin.tissoires@redhat.com> wrote:
>> >> > >
>> >> > > On Mon, Feb 12, 2024 at 6:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8=
rgensen <toke@redhat.com> wrote:
>> >> > > >
>> >> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
>> >> > > >
>> >> [...]
>> >> > I agree that workqueue delegation fits into the bpf_timer concept a=
nd
>> >> > a lot of code can and should be shared.
>> >>
>> >> Thanks Alexei for the detailed answer. I've given it an attempt but s=
till can not
>> >> figure it out entirely.
>> >>
>> >> > All the lessons(bugs) learned with bpf_timer don't need to be re-di=
scovered :)
>> >> > Too bad, bpf_timer_set_callback() doesn't have a flag argument,
>> >> > so we need a new kfunc to set a sleepable callback.
>> >> > Maybe
>> >> > bpf_timer_set_sleepable_cb() ?
>> >>
>> >> OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini=
() flag?
>> >>
>> >> > The verifier will set is_async_cb =3D true for it (like it does for=
 regular cb-s).
>> >> > And since prog->aux->sleepable is kinda "global" we need another
>> >> > per subprog flag:
>> >> > bool is_sleepable: 1;
>> >>
>> >> done (in push_callback_call())
>> >>
>> >> >
>> >> > We can factor out a check "if (prog->aux->sleepable)" into a helper
>> >> > that will check that "global" flag and another env->cur_state->in_s=
leepable
>> >> > flag that will work similar to active_rcu_lock.
>> >>
>> >> done (I think), cf patch 2 below
>> >>
>> >> > Once the verifier starts processing subprog->is_sleepable
>> >> > it will set cur_state->in_sleepable =3D true;
>> >> > to make all subprogs called from that cb to be recognized as sleepa=
ble too.
>> >>
>> >> That's the point I don't know where to put the new code.
>> >>
>> >
>> > I think that would go in the already existing special case for
>> > push_async_cb where you get the verifier state of the async callback.
>> > You can make setting the boolean in that verifier state conditional on
>> > whether it's your kfunc/helper you're processing taking a sleepable
>> > callback.
>> >
>> >> It seems the best place would be in do_check(), but I am under the im=
pression
>> >> that the code of the callback is added at the end of the instruction =
list, meaning
>> >> that I do not know where it starts, and which subprog index it corres=
ponds to.
>> >>
>> >> >
>> >> > A bit of a challenge is what to do with global subprogs,
>> >> > since they're verified lazily. They can be called from
>> >> > sleepable and non-sleepable contex. Should be solvable.
>> >>
>> >> I must confess this is way over me (and given that I didn't even mana=
ged to make
>> >> the "easy" case working, that might explain things a little :-P )
>> >>
>> >
>> > I think it will be solvable but made somewhat difficult by the fact
>> > that even if we mark subprog_info of some global_func A as
>> > in_sleepable, so that we explore it as sleepable during its
>> > verification, we might encounter later another global_func that calls
>> > a global func, already explored as non-sleepable, in sleepable
>> > context. In this case I think we need to redo the verification of that
>> > global func as sleepable once again. It could be that it is called
>> > from both non-sleepable and sleepable contexts, so both paths
>> > (in_sleepable =3D true, and in_sleepable =3D false) need to be explore=
d,
>> > or we could reject such cases, but it might be a little restrictive.
>> >
>> > Some common helper global func unrelated to caller context doing some
>> > auxiliary work, called from sleepable timer callback and normal main
>> > subprog might be an example where rejection will be prohibitive.
>> >
>> > An approach might be to explore main and global subprogs once as we do
>> > now, and then keep a list of global subprogs that need to be revisited
>> > as in_sleepable (due to being called from a sleepable context) and
>> > trigger do_check_common for them again, this might have to be repeated
>> > as the list grows on each iteration, but eventually we will have
>> > explored all of them as in_sleepable if need be, and the loop will
>> > end. Surely, this trades off logical simplicity of verifier code with
>> > redoing verification of global subprogs again.
>> >
>> > To add items to such a list, for each global subprog we encounter that
>> > needs to be analyzed as in_sleepable, we will also collect all its
>> > callee global subprogs by walking its instructions (a bit like
>> > check_max_stack_depth does).
>>=20
>> Sorry if I'm being dense, but why is all this needed if it's already
>> possible to just define the timer callback from a program type that
>> allows sleeping, and then set the actual timeout from a different
>> program that is not sleepable? Isn't the set_sleepable_cb() kfunc just a
>> convenience then? Or did I misunderstand and it's not actually possible
>> to mix callback/timer arming from different program types?
>
> More than just convience.
> bpf_set_sleepable_cb() might need to be called from non-sleepable and
> there could be no way to hack it around with fake sleepable entry.
> bpf_timer_cancel() clears callback_fn.
> So if prog wants to bpf_timer_start() and later bpf_timer_cancel()
> it would need to bpf_set_sleepable_cb() every time before bpf_timer_start=
().
> And at that time it might be in non-sleepable ctx.

Ah, right, makes sense; didn't think about bpf_timer_cancel(). Thanks
for the explanation :)

-Toke


