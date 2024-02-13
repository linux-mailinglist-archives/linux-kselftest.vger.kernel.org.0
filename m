Return-Path: <linux-kselftest+bounces-4579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452D853BA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA1E1F23DB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC460B98;
	Tue, 13 Feb 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDEY51uA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1660B93
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853893; cv=none; b=GcsISBDCOG3Te6Il1PHnsugo2Tf1oZL8nflYzqpE91lBYVJ7htLqAXI3zGyY8fgd4xgklsnnaL9CX/sOoLeWVnMqL7/K9Wr6f/L+mRdWuSqKbJ236MFJ3y0c6vHKRDYkNvVZ5nrelMr16qzJADQsJQWYFcSI3ySvT5cWhUNBa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853893; c=relaxed/simple;
	bh=Tg5MsaFqKcll3WJwQ+ui4v5KYHONfl+5tZRSv1SPzR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=acmPghQ0F0MPG8aGx1NzWXOo0Q5SQj64vzy7XYqfjPS0ejlPzp4BLxMD2HPkXAp0SstBlW8l24tXU5qqtiAHiT5HMfufP5PV1ShlOEd2X/VFF82oRg52inUFLxQD785yMQMGc0Tdt2ZdJIybR0aNkrE4YAu/9qoM4BiwwzOcZls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDEY51uA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707853890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg5MsaFqKcll3WJwQ+ui4v5KYHONfl+5tZRSv1SPzR0=;
	b=gDEY51uAgp6iNPEsGD3Mb8bsLgypd6QFtgz3kXcnzFdyehoOPpVuHk0b8nXpmaxfiPYodU
	jwgZfVOC9dGMq9KEKRzGEm3MBfOqrwEwfH2dd06ah/pUxI0H+2VFU6MWaxK+FdfveXD6Kw
	gziTozI/3le0dr7BxWOQbJC72h9ecOA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-HTh-4biPOl25iPpktugnlA-1; Tue, 13 Feb 2024 14:51:28 -0500
X-MC-Unique: HTh-4biPOl25iPpktugnlA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-562111cbefcso272875a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 11:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707853887; x=1708458687;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg5MsaFqKcll3WJwQ+ui4v5KYHONfl+5tZRSv1SPzR0=;
        b=QjNyUKHV+/u/SPj3TwTANcWmOqwC02t/WRr5kqCbgJlfmjQJlsifOVJo7tGpiaSJce
         trACK/1SAMeI9p4UAC1xL9CTGZ0+hnkC0t5FMfiVqvAkdLdcmmJyTZe/sxRiUBHmrJua
         bboX6cOco2IAj4Y6IjjuAfG2UkwlgOzwF+GiJNb/OiI6OZaX2z+VvAEvG64vbZfe/5XF
         ynpIfgjbV/dReaoiFB0bzklJbYlw1ptK69Qsy2ZwWFi+lIL+W23/0eIXzQAOSbzjHCwR
         melx2+Gn9unp1gVNc/tJvapN7ZVe/j9CCDXJAYooExwTGFJEEGRtWHD3SZYwx8Fyff5z
         H3VA==
X-Forwarded-Encrypted: i=1; AJvYcCXikzodGcg3DZ8z8oVvxFbp+cbhPhMAdNjWHNSTUvcu7Ln4AdzaY1XzEqFCC0+GPCZ9mmGfYcthoLfkbRfZhwEZdN+sMCkWuPIaitixPiDx
X-Gm-Message-State: AOJu0YxsfBmYlG43PP8W37DKsTqoeCYpXdPiVCpLzN8jj9GZ89xgS/8R
	YQEbziX6pqTBbk9JXLoRaT3CA8+cdvcR2u8rt93PssqB1begHvA/eF39fN+juXi6ioY/xtuJvNc
	jTyA0rGLoQbf+hm4aaXA9qLx+VI7XvlbWCbySgXE6gid9OtVXEDvBS7zsmZbKpiH5Ww==
X-Received: by 2002:a05:6402:1cb8:b0:562:50e8:6ee4 with SMTP id cz24-20020a0564021cb800b0056250e86ee4mr40867edb.35.1707853887540;
        Tue, 13 Feb 2024 11:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP+QVjOgTJsSEOm+C1OKWk1I48GuAsDIQjHIkXhl5MbZk9on3eQ1nH0trSu94tyk1bm40KWg==
X-Received: by 2002:a05:6402:1cb8:b0:562:50e8:6ee4 with SMTP id cz24-20020a0564021cb800b0056250e86ee4mr40854edb.35.1707853887208;
        Tue, 13 Feb 2024 11:51:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi1vpllgnapDRdjcC78q+niYoasUsrFPOAiQ6LkfiADjrKhfTJiHmOobSo4WalnyZDiF+/YuSFXFCH7aQHVMo2n+AHz5/KpW64Ssb7y+33PzSHOFOhYnbFA1+FxRbrbuqEQ7J419oJzeOwfpdfaQ3OYNt4iA9CM4LVhANOmauuzt2RR/8TV24lXnLEgATzcUFsXfus/4WLI8PW2esejO5PFgMjA+wfAi9rywr4X8dTW7ugTBVU/Pnk1BX797PfMJA8QBJP0Pl5ZrXnwHOMv/jqOwOXd5kng2OSppY1E8CfdU13/sx+4Cz0zx4fplhwCVAr53NcY0jgV50NTAyZOXm+ZRf4s5ZwUW64IDZzThvRx+OGRw81x1Qv8jLiQuElQd5DvkC3YRw0k+my/b0T84+zBvaKgv5FQBa8YPA8jMdbGeJOsTVtkTfGuQBCCVnvd7EgNv2QVTuKCrulgThFTWcqJG4emd0f+fC8tQ7onXZcu52rqY/ff7VNqpIBFVlTjQ1nJYjuKFAGAc4Pralja7cffAYhTYXZkzHWLGyqysRHCjcDmJm12yB+n7HST4f/BItbu4p4o0O1g4463WbrggfFHFTPuEhn8MaPsQs4EslkwSJulnDsAh9vCg4KwOSKqWv2MQi/sYJhgdgFwHe0swP6QxeE99I/PzDxIb/+7DeRayeeB5CYiX2v0rEr6MJnW3M=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7de82000000b005621b45daffsm138386edv.28.2024.02.13.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:51:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 620B010F56C8; Tue, 13 Feb 2024 20:51:26 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Benjamin Tissoires
 <bentiss@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
 <linux-input@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
In-Reply-To: <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk>
 <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk>
 <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
 <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
 <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
 <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 13 Feb 2024 20:51:26 +0100
Message-ID: <877cj8f8ht.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Tue, 13 Feb 2024 at 18:46, Benjamin Tissoires <bentiss@kernel.org> wro=
te:
>>
>> On Feb 12 2024, Alexei Starovoitov wrote:
>> > On Mon, Feb 12, 2024 at 10:21=E2=80=AFAM Benjamin Tissoires
>> > <benjamin.tissoires@redhat.com> wrote:
>> > >
>> > > On Mon, Feb 12, 2024 at 6:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
>> > > >
>> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
>> > > >
>> [...]
>> > I agree that workqueue delegation fits into the bpf_timer concept and
>> > a lot of code can and should be shared.
>>
>> Thanks Alexei for the detailed answer. I've given it an attempt but stil=
l can not
>> figure it out entirely.
>>
>> > All the lessons(bugs) learned with bpf_timer don't need to be re-disco=
vered :)
>> > Too bad, bpf_timer_set_callback() doesn't have a flag argument,
>> > so we need a new kfunc to set a sleepable callback.
>> > Maybe
>> > bpf_timer_set_sleepable_cb() ?
>>
>> OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini() =
flag?
>>
>> > The verifier will set is_async_cb =3D true for it (like it does for re=
gular cb-s).
>> > And since prog->aux->sleepable is kinda "global" we need another
>> > per subprog flag:
>> > bool is_sleepable: 1;
>>
>> done (in push_callback_call())
>>
>> >
>> > We can factor out a check "if (prog->aux->sleepable)" into a helper
>> > that will check that "global" flag and another env->cur_state->in_slee=
pable
>> > flag that will work similar to active_rcu_lock.
>>
>> done (I think), cf patch 2 below
>>
>> > Once the verifier starts processing subprog->is_sleepable
>> > it will set cur_state->in_sleepable =3D true;
>> > to make all subprogs called from that cb to be recognized as sleepable=
 too.
>>
>> That's the point I don't know where to put the new code.
>>
>
> I think that would go in the already existing special case for
> push_async_cb where you get the verifier state of the async callback.
> You can make setting the boolean in that verifier state conditional on
> whether it's your kfunc/helper you're processing taking a sleepable
> callback.
>
>> It seems the best place would be in do_check(), but I am under the impre=
ssion
>> that the code of the callback is added at the end of the instruction lis=
t, meaning
>> that I do not know where it starts, and which subprog index it correspon=
ds to.
>>
>> >
>> > A bit of a challenge is what to do with global subprogs,
>> > since they're verified lazily. They can be called from
>> > sleepable and non-sleepable contex. Should be solvable.
>>
>> I must confess this is way over me (and given that I didn't even managed=
 to make
>> the "easy" case working, that might explain things a little :-P )
>>
>
> I think it will be solvable but made somewhat difficult by the fact
> that even if we mark subprog_info of some global_func A as
> in_sleepable, so that we explore it as sleepable during its
> verification, we might encounter later another global_func that calls
> a global func, already explored as non-sleepable, in sleepable
> context. In this case I think we need to redo the verification of that
> global func as sleepable once again. It could be that it is called
> from both non-sleepable and sleepable contexts, so both paths
> (in_sleepable =3D true, and in_sleepable =3D false) need to be explored,
> or we could reject such cases, but it might be a little restrictive.
>
> Some common helper global func unrelated to caller context doing some
> auxiliary work, called from sleepable timer callback and normal main
> subprog might be an example where rejection will be prohibitive.
>
> An approach might be to explore main and global subprogs once as we do
> now, and then keep a list of global subprogs that need to be revisited
> as in_sleepable (due to being called from a sleepable context) and
> trigger do_check_common for them again, this might have to be repeated
> as the list grows on each iteration, but eventually we will have
> explored all of them as in_sleepable if need be, and the loop will
> end. Surely, this trades off logical simplicity of verifier code with
> redoing verification of global subprogs again.
>
> To add items to such a list, for each global subprog we encounter that
> needs to be analyzed as in_sleepable, we will also collect all its
> callee global subprogs by walking its instructions (a bit like
> check_max_stack_depth does).

Sorry if I'm being dense, but why is all this needed if it's already
possible to just define the timer callback from a program type that
allows sleeping, and then set the actual timeout from a different
program that is not sleepable? Isn't the set_sleepable_cb() kfunc just a
convenience then? Or did I misunderstand and it's not actually possible
to mix callback/timer arming from different program types?

-Toke


