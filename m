Return-Path: <linux-kselftest+bounces-7157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70C897D3B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 03:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C1EB22112
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82FD4C97;
	Thu,  4 Apr 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt5Dbdpn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D123CE;
	Thu,  4 Apr 2024 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192482; cv=none; b=jDVuDnglQkvluN2ShVF/olh4YI5RVtuY1l46MYY63suJMzR8R4u9wOjro3cO5/bF+q7Vo4dNbrXxv+1S6xGpqZ53RhuAI0LPvrr4V7g+v881SER83i8g2e8Xfw/B99iJUFwMkNoIknm3/d4SIcYuJfT8WW5V5iWVXBtLUvA65jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192482; c=relaxed/simple;
	bh=VcITItGHjtKY9dfEMl4G05gYTHqgBMk3fUlh/7jjiJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMJC7dYTlJX1NWVGmvVzpvPyVBb+0Mq+SUmpaT6L/h8gwR8Ac/hykqLDJ3Dse61PqKc4ktisdjksuTtli8kC6l7hRp9v6A2mYoMcKWI3Hfw1ImgTZQ9aOP+mgkbLwyEiUXcnNTbxODDYRFCFTyq6c9dEmBF9Tztzgt8KQAf2hHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt5Dbdpn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ddd1624beso207012f8f.1;
        Wed, 03 Apr 2024 18:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712192479; x=1712797279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLU2APTaqoheKuuzuNc2tSXn6E7XDkIQ0oPwW38nA4I=;
        b=Xt5DbdpnBGpOIWyRpSnbHEtDXN0wnQd1F7Qou3PIzQSoe/wf57mdql9R4FJxiiEG8V
         ffsNkTEMPFwGCSxykrCWYEGIs6Wfe7a7zsY3RdSe0zSxjT6u8TdQIiSh/4oCPfCOhTDO
         j0WwvGfhZ1EWzyzN1R9AoXt0sEFgSfJE83YffBaiIWuMPh5Y+B6Z11Bo9jsQ81av5LyF
         QtLzYxRkuZJEG3qndqKCs/GqMLfpN0JKA0yG6T/AenSuPMGyfr8JO+3XZU04C4mK4U9Z
         ObN5UKhUnGc0fe7Xay/5W1qRSr+wvhmXqtMQqej4Y485rY/kkB8cH6bYU++b+CQC3SWd
         QX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712192479; x=1712797279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLU2APTaqoheKuuzuNc2tSXn6E7XDkIQ0oPwW38nA4I=;
        b=bzfBPktrhhOsbsS+4XdoHH2WMXxsxZcSSS2CucFW0NKFL4z5ciDQVUCnv4iIPr4Z4w
         wbpjHip8I7GYxGfakJoVFBF2Tl4olddnDnrfatE/1zObmB/EPGVPmr5basbxFtqNt2kv
         OJuZSJb1boqWJU2GX10sbAcMQnDA58dnK7y7G4CKVp5vRQGOyVRcxRt2ehXd/IwTW7VC
         1Fy7LwsselMEiSyGRMQAwmMiEWKxIRZUJoft8BLpUqzEtxhFADfpHqMem8sbHVwxtWG2
         g6UrbU2tW3JaNdsZ0rP7XJr89faXo3LAAsHXDD+DKVWzOoGZETkzcXN4M/GsdwwGIzNe
         Q9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3ovBuL1GzsPXy1KvQfVa2F2DnNXRdTyA1ELG2hSRDyB696Lkln7EICeEEZnfVT4bM/sawSnf8UdJefkKzsmsOmj/c1WRJzUBU1NOPCAx+nlx2Qk5/JwRijQVi5MK7jfIG6q4S32G415oHOSUsrjYLLLojLvAa187oi5J9alTmUGql
X-Gm-Message-State: AOJu0YwpKjn+lYaIO+pa8wrRYQWwsjyXrCr5rWtbykkQnExEPA87Uqun
	ukuWJPTt9S5gD1Txn4qWXXgPNIzAxXDUy/xIlXN72qIYASyXnALnvlzklyVbZzW+nNmCVKTCk3F
	VLB8rJ89gbH5//dE6v29bLmAr3gQ=
X-Google-Smtp-Source: AGHT+IGgve8RYBKKY6vg33L/syRyrb3Z5pP3xZmPioDKEq/WUwRK0ivhdEAPpSvjxORCV87KADxzfEeudnxPjlunbPA=
X-Received: by 2002:a05:6000:4f1:b0:343:6c07:c816 with SMTP id
 cr17-20020a05600004f100b003436c07c816mr1064770wrb.16.1712192478995; Wed, 03
 Apr 2024 18:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com> <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
In-Reply-To: <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 18:01:07 -0700
Message-ID: <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 11:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 10:02=E2=80=AFAM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > > >                 goto out;
> > > >         }
> > > > +       spin_lock(&t->sleepable_lock);
> > > >         drop_prog_refcnt(t);
> > > > +       spin_unlock(&t->sleepable_lock);
> > >
> > > this also looks odd.
> >
> > I basically need to protect "t->prog =3D NULL;" from happening while
> > bpf_timer_work_cb is setting up the bpf program to be run.
>
> Ok. I think I understand the race you're trying to fix.
> The bpf_timer_cancel_and_free() is doing
> cancel_work()
> and proceeds with
> kfree_rcu(t, rcu);
>
> That's the only race and these extra locks don't help.
>
> The t->prog =3D NULL is nothing to worry about.
> The bpf_timer_work_cb() might still see callback_fn =3D=3D NULL
> "when it's being setup" and it's ok.
> These locks don't help that.
>
> I suggest to drop sleepable_lock everywhere.
> READ_ONCE of callback_fn in bpf_timer_work_cb() is enough.
> Add rcu_read_lock_trace() before calling bpf prog.
>
> The race to fix is above 'cancel_work + kfree_rcu'
> since kfree_rcu might free 'struct bpf_hrtimer *t'
> while the work is pending and work_queue internal
> logic might UAF struct work_struct work.
> By the time it may luckily enter bpf_timer_work_cb() it's too late.
> The argument 'struct work_struct *work' might already be freed.
>
> To fix this problem, how about the following:
> don't call kfree_rcu and instead queue the work to free it.
> After cancel_work(&t->work); the work_struct can be reused.
> So set it up to call "freeing callback" and do
> schedule_work(&t->work);
>
> There is a big assumption here that new work won't be
> executed before cancelled work completes.
> Need to check with wq experts.
>
> Another approach is to do something smart with
> cancel_work() return code.
> If it returns true set a flag inside bpf_hrtimer and
> make bpf_timer_work_cb() free(t) after bpf prog finishes.

Looking through wq code... I think I have to correct myself.
cancel_work and immediate free is probably fine from wq pov.
It has this comment:
        worker->current_func(work);
        /*
         * While we must be careful to not use "work" after this, the trace
         * point will only record its address.
         */
        trace_workqueue_execute_end(work, worker->current_func);

the bpf_timer_work_cb() might still be running bpf prog.
So it shouldn't touch 'struct bpf_hrtimer *t' after bpf prog returns,
since kfree_rcu(t, rcu); could have freed it by then.
There is also this code in net/rxrpc/rxperf.c
        cancel_work(&call->work);
        kfree(call);

So it looks like it's fine to drop sleepable_lock,
add rcu_read_lock_trace() and things should be ok.

