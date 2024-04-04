Return-Path: <linux-kselftest+bounces-7213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537C898C6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B005B2CC0B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BBD41C7A;
	Thu,  4 Apr 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ/+1JrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FB1F922;
	Thu,  4 Apr 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248863; cv=none; b=aIvp7vUwwywGVg4hdyU3tF3a8gjeSf4a5bXM2AUEYVvN0djZwmz3T4PF52R5jf8yx+XWkCSj2zriDyPViEXkWo0ENSm64C3YqNi4LeXg+oFt2VqJTetEk0bfrtT4+XOmiJ8xvO7rSHJC46c/W/r6FfDNeAY4pFSKO8Rawem8O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248863; c=relaxed/simple;
	bh=x/s6vyO2Ku1FEpgpwyNPo6be9Ds/5FEj3IOqROrewf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiMyexmqrqEt/UvNPhyceqpxeP4XU5ow3YUFYHl9khtAjf+PQgQ2KQ4DC+qWiH5LISoOtckx9YH0LQs6W5qcvhBeZ27OHAWlP8JLooNFjNZBAR28XkzwqrWGcmX+m2P9dqryFaQkUy2P3isWoEKATbymvKArSG1+TZXRWDd9zUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ/+1JrV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41550858cabso8380035e9.2;
        Thu, 04 Apr 2024 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712248860; x=1712853660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbLmsAzzJdGPLAvAsCum54KXU9vJ5+iCYp76EK5DMIc=;
        b=aQ/+1JrVRIUJqsPG4P6DjD4SkvkSowefXsG5zplfk5m2hfJ9iUnD/lXLpfvsKoM9l1
         iHHWjg2AWJJ7fdzdOdjPxttD/FXwMj54Or0a/a7hAkl9dmafaV2VaqJzmc0To7U5nPcV
         IHP3djtbJiYtxFSrA2ko4hTZc2UpolQaEG/vl/pcSBAKdWnBlPhtfVblfERog9saqjfE
         jQ1Wd89MVvq5fUzK2Gh/oH3gHHvdYQYUbdz8KpM0ZR45BXuzs7Ov/saY8pJlVwJabpkr
         pfpsz93EyHrZp6nKpYvh9Z15SGmkTXnDZTp87QAP6kEhS9Ved9Nl28SeTNLE+x05oSgT
         D53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248860; x=1712853660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbLmsAzzJdGPLAvAsCum54KXU9vJ5+iCYp76EK5DMIc=;
        b=JoG9AmIxsSx0IvWfiO5CUkKPrcJvR+nhywUPpGqkqOWa2d6ZR3scaMjuwHINJQle5b
         JJLf1ra41L/TO/xEuQm9F8SvW1ybRtzEwH33vVnBn2zLeUCm11ak+0lB0iYJFiSeQbKU
         vM77YOYytVtyPeY9Gmd/W5lk1oDysQQkG0wNqqfrCJePyODWUlqkAdpuu01a1ElTV7Fd
         NiaRUUAQavUlwydkJyzF9HUB3DdeojjflscPrbXQLOFbg0YnSXzXvJ5obW0N9/uAWo4j
         qUD03OqXNOKAqB+Y0gxkZOBZ4ZiOAMiixhs9xRTx7ttRivtRsvBVOmPl2mEPCI3sOYCO
         wZew==
X-Forwarded-Encrypted: i=1; AJvYcCWIrwH15QYkzpM+qrSZW5hKToLYeVciFACXFY5aNqKldqVe2Xajktxhv+9qGnGWtGv9Mq9kM5hE6FTkk+bUnJnlX+YWsv6uVbJ6T1+8mRQuiJUdfvOQA4lZuaDw/cdHh/SFq8lxNfisFoFybj8czx4azMDWXZWO0arSj256EyQJ0G83
X-Gm-Message-State: AOJu0YxB8qkp21110KMFu5GnKFA0bwmcQ5IWgA8jb21MXWleZXncf5MT
	QhC7Kwagq83yXsraBvFA3GfaL6ssA5OZg8xyzbMQkYyvYMgZeTR6xEe40JdxhzaNGnnIZ7rVJhS
	cpA/ESttfl2HJVAAwjFdbC+jpwsk=
X-Google-Smtp-Source: AGHT+IENju6fEsOOukUPwNqBM2TZ0toG5669WTAz1FK3UDS5gktOsM7A6IIBw/7mHgbIRKed3y6wUaA4IkqZ95L64zw=
X-Received: by 2002:a5d:58c8:0:b0:341:abd4:a6e8 with SMTP id
 o8-20020a5d58c8000000b00341abd4a6e8mr2184968wrf.60.1712248859779; Thu, 04 Apr
 2024 09:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-1-179c7b59eaaa@kernel.org> <CAADnVQJdm7+7tbJC8yhPqDUijE0DTD9UG4LOQmNRCWchQ3uGsg@mail.gmail.com>
 <CAO-hwJKVVjhg6_0tAM75HGJL0WcERotyJc+7oBVvDiTGJAqTfw@mail.gmail.com>
 <CAADnVQ+5NqjqyeFS3XgDU0OCFgt1Y9bmTbHOPv6ekw1sJasyaA@mail.gmail.com>
 <CAADnVQJm7bi=iFtWj1XCmEdyDwb64KjxeP5RFo57paG3-zZo_g@mail.gmail.com>
 <CAADnVQKSwdpfx8EoqURvzFymYNr1evkB3+4dRt_coPOZhW2LTw@mail.gmail.com> <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
In-Reply-To: <CAO-hwJLDuGHDNLRAJit7+5Dh7MRmwmWNt0+rreMyjf7P6UpAYg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 09:40:48 -0700
Message-ID: <CAADnVQ+gikPakTuYpD4-oxS6yS5-Dd_HanfqyNnGW-nk7=eXNg@mail.gmail.com>
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

On Thu, Apr 4, 2024 at 8:27=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
>
> >
> > So we need something like:
> >
> > struct bpf_hrtimer {
> >   union {
> >     struct hrtimer timer;
> > +   struct work_struct work;
> >   };
> >   struct bpf_map *map;
> >   struct bpf_prog *prog;
> >   void __rcu *callback_fn;
> >   void *value;
> >   union {
>
> Are you sure we need an union here? If we get to call kfree_rcu() we
> need to have both struct rcu_head and sync_work, not one or the other.

why? with an extra flag it's one or the other.
In bpf_timer_cancel_and_free()
if (flag & SLEEPABLE) {
    schedule_work() to cancel_work_sync + kfree_rcu
} else {
   hrtimer_cancel
   kfree_rcu
}

> >     struct rcu_head rcu;
> > +   struct work_struct sync_work;
> >   };
> > + u64 flags; // bpf_timer_init() will require BPF_F_TIMER_SLEEPABLE
>
> If I understand, you want BPF_F_TIMER_SLEEPABLE in bpf_timer_init()
> (like in my v2 or v3 IIRC). But that means that once a timer is
> initialized it needs to be of one or the other type (especially true
> with the first union in this struct).

yes. That's an idea.
The code to support wq vs timer seems to be diverging more
than what we expected initially.
It seems cleaner to set it as init time and enforce in
other helpers.

Also with two work_struct-s we're pushing the sizeof(bpf_hrtimer)
too far.
It's already at 112 bytes and some people use bpf_timer per flow.
So potentially millions of such timers.
Adding extra sizeof(struct work_struct)=3D32 * 2 that won't be
used is too much.
Note that sizeof(struct hrtimer)=3D64, so unions make everything
fit nicely.

> So should we reject during run time bpf_timer_set_callback() for
> sleepable timers and only allow bpf_timer_set_sleepable_cb() for
> those? (and the invert in the other case).

yes.

> This version of the patch allows for one timer to be used as softIRQ
> or WQ, depending on the timer_set_callback that is used. But it might
> be simpler for the kfree_rcu race to define the bpf_timer to be of one
> kind, so we are sure to call the correct kfree method.

I think one or another simplifies the code and makes it easier
to think through combinations.

I'm still contemplating adding new "struct bpf_wq" and new kfuncs
to completely separate wq vs timer.
The code reuse seems to be relatively small.
We can potentially factor out internals of bpf_timer_* into smaller
helpers and use them from bpf_timer_* and from new bpf_wq_* kfuncs.

One more thing.
bpf_timer_cancel() api turned out to be troublesome.
Not only it cancels the timer, but drops callback too.
It was a surprising behavior for people familiar with
kernel timer api-s.
We should not repeat this mistake with wq.

We can try to fix bpf_timer_cancel() too.
If we drop drop_prog_refcnt() from it it shouldn't affect
existing bpf_timer users who are forced to do:
bpf_timer_cancel()
bpf_timer_set_callback()
bpf_timer_start()
all the time.
If/when bpf_timer_cancel() stops dropping the callback
such bpf prog won't be affected. So low chance of breaking any prog.
wdyt?

