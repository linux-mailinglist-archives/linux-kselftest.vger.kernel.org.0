Return-Path: <linux-kselftest+bounces-7113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EA89789C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0701C21844
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFD154431;
	Wed,  3 Apr 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPEgSBQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714C146D62;
	Wed,  3 Apr 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170251; cv=none; b=bMZrlcVHnLNFUnatHAHPnzIALaT27H7LRY/4XFKPDYaVaUsnGHM0I9+Jux6fXkmoyRZ7hmH2b5VINat1tlh+vSXCQCr6kntoS16LugEsDA2gpmC9TL5mUE2EnRiQ+k2SHQ20AfO0b1Xm41YJ+/3GeoNHnRlyBQoi9m7xk51VMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170251; c=relaxed/simple;
	bh=qafNT2/0QJfqG8NsAUxvf/4aoz+ZQ2sjYAFG0qQ4kJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5B4aWXqWm9CMCCZCMZLXFEYx21gaOiTlkdu3XyJc6B+V6/AvBgoDMRfreFMM/1zFs2oltCwREKZRnpbKmqjiT6ofgTNkEibqddGUUt7jVab7ZMhUh8IMgYdV+2uLIJXVooy6AKThH5v98zA3UACVsCiB1qQegwsxFYrGt8vFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPEgSBQJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so7937215e9.1;
        Wed, 03 Apr 2024 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712170248; x=1712775048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxSYstRLcf6NjaNLix3NVlN+e1nyvxy/tW96r1wlIgc=;
        b=WPEgSBQJ5wtLUjOybunFFfwsczl9sjhe1roV+ajMlLAxLxUbCCwhPaUceSgIwMxF0G
         Oc3qtC2uqJOh8fHJdoI/kgqMspN1aCS555KpppEdQLpaJ0kV34WUoPElPHdDqiocAp1A
         MM6dxfy/232X48KWC9k975ectWnC/OIllDGk9CFMvr2HQQ0OaOAZj2JyDWFCgTgRYOQV
         vJQDOEunVPbeNVHwI23FitC4CoOtj5+BLh6Sr04RRAhikBCo+XmF7jiDBUxkp8hCf4HO
         vtTQfNd8ccmS2Gs3lzkd07AzEnWz8awtNyBD5R3SsF1++d+UcG6y9UEVqQThQpZkAVmu
         DnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170248; x=1712775048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxSYstRLcf6NjaNLix3NVlN+e1nyvxy/tW96r1wlIgc=;
        b=lBViPiPMuDsKzkIuNUpmziEwhK0jMyHqTjg7FGOm3uqcD1AyJ24CREV7sLfJ1xY5mE
         rsJ2Us9B6DL8vVP69jKykWQd+OHWUYaWNAePM1Kyr48O1OPOGD/Xoi8GY4O9PzF2Bhd4
         VRRr7hBEvLGMfLqno/zUKNgBn+ehmhNV2hp7+gyjce+h1r1MQPuw5Vrj64UyhdH0PeDD
         06b648w9PTiInHNbm2O9+5tfqcXBKovq3cQAwWWRLpL1RRqBA0XOfH/BSDpCAP9SaUhY
         RUXK7dOFXyCsDnZ6MuXt8KxLBLUxsFM6ywPWfrEk6fix4Yzp/2mnwwUcZZfjzc2Hpqk3
         pYhA==
X-Forwarded-Encrypted: i=1; AJvYcCVN0z60jiwquGpM1wmFzoFA93Lp2MkUfgnEBi3jdiu4aV+fMNvpcbzrMKhXwNNtbq74deFC3cPjrDr6Xh11trygMkMM/uAeqHTMgIOhHg3bLcJ0bHVL12skTQ6AFqq2bsd0aVuqfVyJMTomFu/Lpbjo/aP/DaM+zvuvnbKu8IjNn9rq
X-Gm-Message-State: AOJu0Yxr3cjRJKhMPG67bI8Hy3TUeq0tnvGOxQxKU5cB4NjL6Spz2slr
	2h4fekBxQMCmiVr8LmvAanwRG2qj5b2xeSrVgvzRd+OGuhxNFMNFPgW/RlrWmocRknL/FQfq/at
	4S6tko31CEqOsY2c53s5eM+POYPs=
X-Google-Smtp-Source: AGHT+IFHD+3PR+fgRwZMJjTgYhMmPSdB2eD57GJTKu9dMg2ovytKxAkRB3EOzbVq0oLmPVabnf7ws4D80/Hi2rZ5M34=
X-Received: by 2002:a5d:6845:0:b0:341:c9bc:6340 with SMTP id
 o5-20020a5d6845000000b00341c9bc6340mr462892wrw.12.1712170248019; Wed, 03 Apr
 2024 11:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
In-Reply-To: <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 11:50:36 -0700
Message-ID: <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] bpf/helpers: introduce sleepable bpf_timers
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:02=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> > >                 goto out;
> > >         }
> > > +       spin_lock(&t->sleepable_lock);
> > >         drop_prog_refcnt(t);
> > > +       spin_unlock(&t->sleepable_lock);
> >
> > this also looks odd.
>
> I basically need to protect "t->prog =3D NULL;" from happening while
> bpf_timer_work_cb is setting up the bpf program to be run.

Ok. I think I understand the race you're trying to fix.
The bpf_timer_cancel_and_free() is doing
cancel_work()
and proceeds with
kfree_rcu(t, rcu);

That's the only race and these extra locks don't help.

The t->prog =3D NULL is nothing to worry about.
The bpf_timer_work_cb() might still see callback_fn =3D=3D NULL
"when it's being setup" and it's ok.
These locks don't help that.

I suggest to drop sleepable_lock everywhere.
READ_ONCE of callback_fn in bpf_timer_work_cb() is enough.
Add rcu_read_lock_trace() before calling bpf prog.

The race to fix is above 'cancel_work + kfree_rcu'
since kfree_rcu might free 'struct bpf_hrtimer *t'
while the work is pending and work_queue internal
logic might UAF struct work_struct work.
By the time it may luckily enter bpf_timer_work_cb() it's too late.
The argument 'struct work_struct *work' might already be freed.

To fix this problem, how about the following:
don't call kfree_rcu and instead queue the work to free it.
After cancel_work(&t->work); the work_struct can be reused.
So set it up to call "freeing callback" and do
schedule_work(&t->work);

There is a big assumption here that new work won't be
executed before cancelled work completes.
Need to check with wq experts.

Another approach is to do something smart with
cancel_work() return code.
If it returns true set a flag inside bpf_hrtimer and
make bpf_timer_work_cb() free(t) after bpf prog finishes.

> Also, side note: if anyone feels like it would go faster to fix those
> races by themself instead of teaching me how to properly do it, this
> is definitely fine from me :)

Most of the time goes into analyzing and thinking :)
Whoever codes it doesn't speed things much.
Pls do another respin if you still have cycles to work on it.

