Return-Path: <linux-kselftest+bounces-48595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D22D08DC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067FA301AD07
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B98A33C191;
	Fri,  9 Jan 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sEk6CMC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9833064D
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957636; cv=none; b=EOfQfued2WesqacU96cAWdtuT40PaLDrf5q/VLnOIxnJ9060MkpVBdX1eWxkNckCfrpAq9kQiTp7hhkd8X3PLfLYNkLg5opeVN4buW60CGScKaOQlcNq4StaKKfglxzwSVYFhdvZfS+Gm77Qnk5jy0Gwpq7sb80F0+MKhdi0Ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957636; c=relaxed/simple;
	bh=1ucrezRL5KYUk9aTfgCK3ezXrshodaiW11+u27oEpwU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OPiPx5p1xQ+1knqw7C9VVlj14+NBGFfxtQwyqMmFSSqTXMEG6ukerH1HNuoB7mkrvl86omwdkIvhiPhhRxwe/UWGKEFr4b/gswYZq4zWXKY3ouPjYJEMAJhfh1mu1WAmA7ZADHJqNlHuQe/jjp18AmiIC3b8mC3iu7pPNMjizNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=sEk6CMC7; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11b992954d4so4153080c88.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767957634; x=1768562434; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjbh2ascM6lN5330xMW5pL9VAtogXtubnfIB7Pp4LD4=;
        b=sEk6CMC7Pn0mMqBvuPyEyYSUBTyM4F4V2kz6svmnGo56JnZuT14XKAjChKhtOPTUZT
         QAE5SbiDcG8TpIXNKvK6ZaHsnUOCNQg9XF+RqeEx6PrCiPKK01dvrW/7Y7JFCtiTObOW
         1QrBUdDzClX+ZkNjvk7ut11rj9kDCS+92iTOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957634; x=1768562434;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjbh2ascM6lN5330xMW5pL9VAtogXtubnfIB7Pp4LD4=;
        b=wVij7c/tPjawi3+ck02sRaph9pat2m6h9YgCQya6+rLno9tAcMyrzM9NAYKTDRH/49
         KLCbOpsYN35AMAfP9jhHItpgdNHLoAL1cwCUFUjosfJRaOFeC8ihk0SileIuvGVtawb0
         AmnHhdnqpxYAAbkkaYCM7z6s/d9ouv4m+F90bDUyfI2xtBVS4FRjZkFoPyUxb682LVpL
         oBB4h1MewydrREQaYjj34Uoijgq2bUlE82LJ/Q3e5nPamSkvPxbVJ4kNOlDlUc4X/oDI
         h5EcKIHW6ol4+0vyA73mL//ztrRwVHY2B9d7KAWEFkaJDycv/Nf9Zd5bLn5TL3g7w1Tz
         Rq4A==
X-Forwarded-Encrypted: i=1; AJvYcCVM+QUYdCV5eL6sp1k0nUqUcEA0rzWuphcb+mfUtxdmQ9LkoGdqqORm48M4QyhOw4lAqyIruqvtOjGlNUxJcdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnJe8LzM4IC9Kntv9o2P7dN8K0K5VvlQfDTT2m2kygQ8oFkmC
	SqeYM3LVqzx58ATNl+xlK0Hqkwi5iPEfDXG1haKFFcUph6GEHBCvPgmZBW7WTcBANiw=
X-Gm-Gg: AY/fxX5C87Ly8/oAOb/54L11ZbpY8XdhLa+yZxuOovqC1UZ4lrQs6ZwfqLiolX60MIE
	oiN8uG06hn7TV57A0kbQsanXTaA7awvURAoBkNIwCAnvqUIuAdjJ5yly34qFylNf6g5uIx0dVvY
	Offbk2lf4GW9v3rEvU0FhrIIqwR7p683ij9a55ZrIS3vGtZdyAjZnVWCK81+vVp+hOSYWZGJHOJ
	pu+bTVedDYYbC6k95Sh1KlFwsQF9gkhKcGkc+y7m2mYyJO7ODphYDzIhBqJwmTP5g39Xk+qWBGL
	0laEZxryiHv5DZViSaVDPp731WwlhMfrslBmJL3fbCRgEQiZodXi73sHYj5zQD5bQ4Bje4bT715
	GOmvI2bpMb9w2D9FaZVaU2QwqdtiVMkBYjQTyarNfrax0OMWcxGOS44w77NJ/kI2Z5ZgHTsVgYe
	EWr3GBdZImGHp5gqJbOkxEdoslJK+X7vH1QA==
X-Google-Smtp-Source: AGHT+IHwpvjNCSJWmekQeZirrQelxRNRHSJWPjmlIBr/qpBDU18J3rgkqOnMBflAPYkSuvwv2uCX1A==
X-Received: by 2002:a05:7022:51c:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-121f8afc217mr8420157c88.6.1767957633847;
        Fri, 09 Jan 2026 03:20:33 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f23b798asm12586248c88.0.2026.01.09.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:20:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
Date: Fri, 9 Jan 2026 06:20:20 -0500
Message-Id: <09954A1D-CB7A-43C6-B30C-4E24731E1FC2@joelfernandes.org>
References: <aWDZNnIckOHZDolF@tardis-2.local>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Paul E McKenney <paulmck@kernel.org>, rcu@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <aWDZNnIckOHZDolF@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: iPhone Mail (23B85)



> On Jan 9, 2026, at 5:32=E2=80=AFAM, Boqun Feng <boqun.feng@gmail.com> wrot=
e:
>=20
> =EF=BB=BFOn Thu, Jan 08, 2026 at 08:39:11PM -0500, Joel Fernandes wrote:
>>> On Thu, Jan 08, 2026 at 04:57:26PM +0100, Frederic Weisbecker wrote:
>>> Le Thu, Jan 01, 2026 at 11:34:12AM -0500, Joel Fernandes a =C3=A9crit :
>>>> @@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct r=
cu_data *rdp_gp,
>>>>        return false;
>>>>    }
>>>>=20
>>>> -    ndw =3D rdp_gp->nocb_defer_wakeup;
>>>> -    ret =3D __wake_nocb_gp(rdp_gp, rdp, ndw =3D=3D RCU_NOCB_WAKE_FORCE=
, flags);
>>>> +    ret =3D __wake_nocb_gp(rdp_gp, rdp, false, flags);
>>>=20
>>> The force parameter can now be removed, right? (same applies to wake_noc=
b_gp()).
>>>=20
>>> Other than that:
>>>=20
>>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>>=20
>> Ah true! Thanks, so the following hunk needs to be squashed into the patc=
h
>> then, with the review tag. Boqun, if you want to do that please do, or I c=
an
>> send it again for the next merge window.
>>=20
>=20
> We still have time for this merge window, but I see there is still
> reviewing going on for other patches, maybe you could resend these 3
> patches once we reach agreement, and then we can decide which merge
> window. Thoughts?

Yes, or let us drop these 3 for this merge window and since I am doing the n=
ext
merge window, I will include these after agreement.  I have 3 more patches
as well in this area coming up.

So I will re-send all of them together for nocb.

That will also make it easier for you and Frederic.

If by chance, we conclude review and agreement in time for this window, you c=
ould add them too, for now ok to drop nocb ones.

Thanks!

 - Joel

>=20
> Regards,
> Boqun
>=20
>> ---8<-----------------------
>>=20
>> From: "Joel Fernandes" <joelagnelf@nvidia.com>
>> Subject: [PATCH] fixup! rcu/nocb: Remove unnecessary WakeOvfIsDeferred wa=
ke
>> path
>>=20
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>> kernel/rcu/tree.c      |  2 +-
>> kernel/rcu/tree.h      |  2 +-
>> kernel/rcu/tree_nocb.h | 14 +++++++-------
>> 3 files changed, 9 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 293bbd9ac3f4..2921ffb19939 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rd=
p)
>>    }
>>    rcu_nocb_unlock(rdp);
>>    if (wake_nocb)
>> -        wake_nocb_gp(rdp, false);
>> +        wake_nocb_gp(rdp);
>>    smp_store_release(&rdp->barrier_seq_snap, gseq);
>> }
>>=20
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index 653fb4ba5852..7dfc57e9adb1 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -499,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp=
);
>> static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>> static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>> static void rcu_init_one_nocb(struct rcu_node *rnp);
>> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
>> +static bool wake_nocb_gp(struct rcu_data *rdp);
>> static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *=
rhp,
>>                  unsigned long j, bool lazy);
>> static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index daff2756cd90..c6f1ddecc2d8 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>>=20
>> static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
>>               struct rcu_data *rdp,
>> -               bool force, unsigned long flags)
>> +               unsigned long flags)
>>    __releases(rdp_gp->nocb_gp_lock)
>> {
>>    bool needwake =3D false;
>> @@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,=

>> /*
>>  * Kick the GP kthread for this NOCB group.
>>  */
>> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>> +static bool wake_nocb_gp(struct rcu_data *rdp)
>> {
>>    unsigned long flags;
>>    struct rcu_data *rdp_gp =3D rdp->nocb_gp_rdp;
>>=20
>>    raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
>> -    return __wake_nocb_gp(rdp_gp, rdp, force, flags);
>> +    return __wake_nocb_gp(rdp_gp, rdp, flags);
>> }
>>=20
>> #ifdef CONFIG_RCU_LAZY
>> @@ -553,7 +553,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp=
, bool was_alldone,
>>                       TPS("WakeLazy"));
>>        } else if (!irqs_disabled_flags(flags)) {
>>            /* ... if queue was empty ... */
>> -            wake_nocb_gp(rdp, false);
>> +            wake_nocb_gp(rdp);
>>            trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>                        TPS("WakeEmpty"));
>>        } else {
>> @@ -959,7 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu=
_data *rdp_gp,
>>        return false;
>>    }
>>=20
>> -    ret =3D __wake_nocb_gp(rdp_gp, rdp, false, flags);
>> +    ret =3D __wake_nocb_gp(rdp_gp, rdp, flags);
>>    trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
>>=20
>>    return ret;
>> @@ -1255,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struc=
t shrink_control *sc)
>>        }
>>        rcu_nocb_try_flush_bypass(rdp, jiffies);
>>        rcu_nocb_unlock_irqrestore(rdp, flags);
>> -        wake_nocb_gp(rdp, false);
>> +        wake_nocb_gp(rdp);
>>        sc->nr_to_scan -=3D _count;
>>        count +=3D _count;
>>        if (sc->nr_to_scan <=3D 0)
>> @@ -1640,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)=

>> {
>> }
>>=20
>> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
>> +static bool wake_nocb_gp(struct rcu_data *rdp)
>> {
>>    return false;
>> }
>> --
>> 2.34.1
>>=20

