Return-Path: <linux-kselftest+bounces-4912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA7858FBE
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 14:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76331F21EC8
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE247B3CC;
	Sat, 17 Feb 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpK0gP6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042679DD8
	for <linux-kselftest@vger.kernel.org>; Sat, 17 Feb 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177357; cv=none; b=lxafDus3rcDFXmUi2aTfLeAZ+Cqonzfrrj1JECiV6mHhOeF3tOWdkHSWBH8ADTUbimZcjPzGm376uCc9uZU2kx/EK9qAfmXXQwOv1FXa1xOEYgocA4CZdGGkzo9KkBA3xGBcZlUzCkEI4zZR5KCzVvIUaVvNWkOM1l6QyjD29zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177357; c=relaxed/simple;
	bh=OtK3IzgJ3fGYA4kSv5N/upSwJ7FGiRagAHvl4Kht5OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Skhphj01uA3pOL1QSoSDbYySX24uUGWV5zUq9gWpBtVwZWcK3Rg+Ccx84yN+tWsp+VgWvXBU18RNA3rTZ0FpisbGLIyTayNnR5jZl7m/Vr2zcls5lzFamDD+VUQk69bUVV5HZ00teddcAS3D47yNefzoaypiDFH8kLLqafJxink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpK0gP6r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708177354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1qCU6uoJSv5O0JLAhuPC8zEwWfa2duu6xW/6J/EB3s=;
	b=KpK0gP6r/WqR5Olg2TYJ4JSxLpEpvmpIhgQWmfrw9EpNU4h3rJWw606mZZZyLTbaMenByK
	q/seQxuq1Wja1tUxTOl89nKgupT/oaoEz3YDZb8lRmllOU9hMwGxVHsiAqdG1hbbcjqxfu
	fSaTtSU4e4W9LjcLgOmeci2o3ZjIWJo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-WjxrLXKhNwC1Qm4QG_JJpg-1; Sat, 17 Feb 2024 08:42:32 -0500
X-MC-Unique: WjxrLXKhNwC1Qm4QG_JJpg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-512aacf66d1so52331e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Feb 2024 05:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177351; x=1708782151;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1qCU6uoJSv5O0JLAhuPC8zEwWfa2duu6xW/6J/EB3s=;
        b=bn33yG62l7hV9WLBIpPIabdtto9LGix6jiCurkWvD7DJdRInR6qNwDQF4Wt+aUsi5j
         viAbV2xG5wfkPu0SKEHWsrsDi612luI3GoYhofQS7JF2R6/uvVRj+t8EfU36iynCKonc
         n7pfsSBB8/Srg2PUYxn121/x/nvvz6FJK4MC5TfYYhsOSdadz2ssydrzUFVYn8RbZI0Y
         5BAtKUw8tNAe+45taG5HVeKmwlIWC7JRc7SWovkw/IlcGPbbf1mqIwCQ3feFaLwHNCIt
         NwO6WYHc8d9sWHOga4+scRih35D91FRKIKcB4MynSn9PMx/4vOxZFqAOf4OB1tvwnAH0
         7tjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUmXLYYTIFIz1+LnaKA6RO7TyRMN1kE2qcHUxqhMREw3l9f3Q92lFIX/xDafOXBYCvCjklz9FMbf9XduZBpHpTSsAOv8jicDTd2BJvExWH
X-Gm-Message-State: AOJu0YxIpnIa5dvnOPQoWpPa4nVSdFhJqlVESL0Rd12rnA2M+UTNSGf4
	zsGsYkoIclXz7MQ1ErnJGEsiEoz2KOLV1vsPSofXRseTjRjSlbYoxH79mxm3oBIenzta778miiz
	151uRUp7OAtTnU7qIHzxrcP5Ym4QrVln27qPKHPDJ3NrYkdRgX9RUn0rzW3YK9rbyXA==
X-Received: by 2002:a19:690e:0:b0:511:87b5:7ddb with SMTP id e14-20020a19690e000000b0051187b57ddbmr4737941lfc.37.1708177351165;
        Sat, 17 Feb 2024 05:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzlzEcMgskLO4de5rW93PPpUzg2F1sD9bjOjwmEyrVCbfcZUo7mXf1ARcPnPiTPqsEAqCZsw==
X-Received: by 2002:a19:690e:0:b0:511:87b5:7ddb with SMTP id e14-20020a19690e000000b0051187b57ddbmr4737925lfc.37.1708177350717;
        Sat, 17 Feb 2024 05:42:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709062bd200b00a3d3bc0d689sm992614ejg.72.2024.02.17.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 05:42:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6D46710F5DDE; Sat, 17 Feb 2024 14:42:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
In-Reply-To: <fckhc367l6eha2gpftixhzjdsmo2jts5p6ir6ukx2q5xndsbhf@btzjwvuamcv4>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
 <a72147f5-2b7d-4267-9881-6a645c575838@linux.dev>
 <r3yhu4h23tdg2dqj7eq3lhevsigvvb3qkge3icxmaqpgkayvoi@gxfxstkr2pxl>
 <87eddccx1q.fsf@toke.dk>
 <fckhc367l6eha2gpftixhzjdsmo2jts5p6ir6ukx2q5xndsbhf@btzjwvuamcv4>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 17 Feb 2024 14:42:29 +0100
Message-ID: <878r3jcim2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benjamin Tissoires <bentiss@kernel.org> writes:

> On Feb 16 2024, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Benjamin Tissoires <bentiss@kernel.org> writes:
>>=20
>> > On Feb 15 2024, Martin KaFai Lau wrote:
>> >> On 2/14/24 9:18 AM, Benjamin Tissoires wrote:
>> >> > +static void bpf_timer_work_cb(struct work_struct *work)
>> >> > +{
>> >> > +	struct bpf_hrtimer *t =3D container_of(work, struct bpf_hrtimer, =
work);
>> >> > +	struct bpf_map *map =3D t->map;
>> >> > +	void *value =3D t->value;
>> >> > +	bpf_callback_t callback_fn;
>> >> > +	void *key;
>> >> > +	u32 idx;
>> >> > +
>> >> > +	BTF_TYPE_EMIT(struct bpf_timer);
>> >> > +
>> >> > +	rcu_read_lock();
>> >> > +	callback_fn =3D rcu_dereference(t->sleepable_cb_fn);
>> >> > +	rcu_read_unlock();
>> >>=20
>> >> I took a very brief look at patch 2. One thing that may worth to ask =
here,
>> >> the rcu_read_unlock() seems to be done too early. It is protecting the
>> >> t->sleepable_cb_fn (?), so should it be done after finished using the
>> >> callback_fn?
>> >
>> > Probably :)
>> >
>> > TBH, everytime I work with RCUs I spent countless hours trying to
>> > re-understand everything, and in this case I'm currently in the "let's
>> > make it work" process than fixing concurrency issues.
>> > I still gave it a shot in case it solves my issue, but no, I still have
>> > the crash.
>> >
>> > But given that callback_fn might sleep, isn't it an issue to keep the
>> > RCU_reader lock so long? (we don't seem to call synchronize_rcu() so it
>> > might be fine, but I'd like the confirmation from someone else).
>>=20
>> You're right, it isn't. From the RCU/checklist.rst doc:
>>=20
>> 13.	Unlike most flavors of RCU, it *is* permissible to block in an
>> 	SRCU read-side critical section (demarked by srcu_read_lock()
>> 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
>> 	Please note that if you don't need to sleep in read-side critical
>> 	sections, you should be using RCU rather than SRCU, because RCU
>> 	is almost always faster and easier to use than is SRCU.
>>=20
>> So we can't use the regular RCU protection for the callback in this
>> usage. We'll need to either convert it to SRCU, or add another
>> protection mechanism to make sure the callback function is not freed
>> from under us (like a refcnt). I suspect the latter may be simpler (from
>> reading the rest of that documentation around SRCU.
>
> Currently I'm thinking at also incrementing the ->prog held in the
> bpf_hrtimer which should prevent the callback to be freed, if I'm not wro=
ng.
> Then I should be able to just release the rcu_read_unlock before calling
> the actual callback. And then put the ref on ->prog once done.
>
> But to be able to do that I might need to protect ->prog with an RCU
> too.

Hmm, bpf_timer_set_callback() already increments the bpf refcnt; so it's
a matter of ensuring that bpf_timer_cancel() and
bpf_timer_cancel_and_free() wait for the callback to complete even in
the workqueue case. The current 'hrtimer_running' percpu global var is
not going to cut it for that, so I guess some other kind of locking will
be needed? Not really sure what would be appropriate here, a refcnt, or
maybe a full mutex?

I am not actually sure the RCU protection of the callback field itself
is that important given all the other protections that make sure the
callback has exited before cancelling? As long as we add another such
protection I think it can just be a READ_ONCE() for getting the cb
pointer?

>> >> A high level design question. The intention of the new
>> >> bpf_timer_set_sleepable_cb() kfunc is actually to delay work to a wor=
kqueue.
>> >> It is useful to delay work from the bpf_timer_cb and it may also usef=
ul to
>> >> delay work from other bpf running context (e.g. the networking hooks =
like
>> >> "tc"). The bpf_timer_set_sleepable_cb() seems to be unnecessary forci=
ng
>> >> delay-work must be done in a bpf_timer_cb.
>> >
>> > Basically I'm just a monkey here. I've been told that I should use
>> > bpf_timer[0]. But my implementation is not finished, as Alexei mention=
ed
>> > that we should bypass hrtimer if I'm not wrong [1].
>>=20
>> I don't think getting rid of the hrtimer in favour of
>> schedule_delayed_work() makes any sense. schedule_delayed_work() does
>> exactly the same as you're doing in this version of the patch: it
>> schedules a timer callback, and calls queue_work() from inside that
>> timer callback. It just uses "regular" timers instead of hrtimers. So I
>> don't think there's any performance benefit from using that facility; on
>> the contrary, it would require extra logic to handle cancellation etc;
>> might as well just re-use the existing hrtimer-based callback logic we
>> already have, and do a schedule_work() from the hrtimer callback like
>> you're doing now.
>
> I agree that we can nicely emulate delayed_timer with the current patch
> series. However, if I understand Alexei's idea (and Martin's) there are
> cases where we just want schedule_work(), without any timer involved.
> That makes a weird timer (with a delay always equal to 0), but it would
> allow to satisfy those latency issues.
>
> So (and this also answers your second email today) I'm thinking at:
> - have multiple flags to control the timer (with dedicated timer_cb
>   kernel functions):
>   - BPF_F_TIMER_HRTIMER (default)
>   - BPF_F_TIMER_WORKER (no timer, just workqueue)
>   - BPF_F_TIMER_DELAYED_WORKER (hrtimer + workqueue, or actual
>     delayed_work, but that's re-implementing stuffs)

I don't think the "delayed" bit needs to be a property of the timer; the
context in which the timer is executed (softirq vs workqueue) is,
because that has consequences for how the callback is verified (it would
be neat if we could know the flag at verification time, but since we
can't we need the pairing with the _set_sleepable_cb()).

But the same timer could be used both as an immediate and a delayed
callback during its lifetime; so I think this should rather be governed
by a flag to bpf_timer_start(). In fact, the patch I linked earlier[0]
does just that, adding a BPF_TIMER_IMMEDIATE flag to bpf_timer_start().
I.e., keep the hrtimer allocated at all times, but skip going through it
if that flag is set.

An alternative could also be to just special-case a zero timeout in
bpf_timer_start(); I don't actually recall why I went with the flag
instead when I wrote that patch...

-Toke

[0] https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?=
h=3Dxdp-queueing-08&id=3D54bc201a358d1ac6ebfe900099315bbd0a76e862


