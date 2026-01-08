Return-Path: <linux-kselftest+bounces-48468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8AFD00E25
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 04:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F0DC30022CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 03:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5623422DA1C;
	Thu,  8 Jan 2026 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XUmIi+lO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68E3595B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843359; cv=none; b=q22aaGNkbJAZGD4CcKmXm+4VhE9CheW7rrwT6I6o/QXTH55EtiJes74J1t79O8oHVKe6Ee0rg76RiLtddg5LcQVgV4w1wCQcfXT3JLsYvMPmN9eBx8nAUAZ6hwwQOsRFQ50Y2lWzIyEKixpg4Lm7O5e2vNTCU9k7hM8GnZwbC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843359; c=relaxed/simple;
	bh=OUSUa3JVi/pJzeRjA4bmswB04mMBN1FnkpmN0sG21fo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dIRGnS5NprbzWWkuJdjFcID8ORSobmEqI0SzkFw2HCvQxWX9qpcbKAc4T3NSvGQUjjl5BOPWKGTsCfdIbnYuDrnm+QOxOxkDmc/BALrp68TZTJGGl5s9yRJjHsiZKSSFCKT7phaZbMtFOzkM22LWoNzOurQagF7ARoLVhh9BFas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=XUmIi+lO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f3e3f0cacso2830928c88.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 19:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767843357; x=1768448157; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X4Knn9pY1z2Gy3OFy/plOBcsNAl0BNLjnRa7lFGlZw=;
        b=XUmIi+lOe30mfhKSSmBgo53Uht4s20O1wugUnOWHXhH8lXmc/NKycTChIdh3SbFJ/Y
         TfeBJjGO7EvkDnAHkcWGbOYbEKnF57aXeiuGJq2i9C5HZQF8sPJs+NmcWhtLGnSsEzkM
         boSUnAmZvxk4uHGVhVbHQw2E7+WiYkoieSjqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843357; x=1768448157;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5X4Knn9pY1z2Gy3OFy/plOBcsNAl0BNLjnRa7lFGlZw=;
        b=wNiZYVAG1XFV/i0ZNv1gBf3t9OfEotDECVdKH0lbBbNitqwFUYsLMt1iVdUAku3EIM
         fRGNrTMkYqt4dRWnWQiE7ZlfiDg7Kwbrd85oErzey8Oe/Oaj3SkndcJNFdS94hZPTDmQ
         YJe9LxLuQG0MHTnyM5idLEi/kYnYhlWPRNWiCN3fQgLyEiko7cJkWQhMrCbDkeuZS46C
         OPj9e5HqWYeFXwWxREMS0c+G1HB9PKea0aTtulMcBt3r6P+Oku414i04yEDQO1jGcWhm
         z6TJUYEPzCSPkv6aDsyxQyXqb1sckuPxWnG9Ojqkg9+1eTtj6tVjosiWkD4DlPKswsAx
         aPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVzl7Sr1A7jotH6i4ivEb73djw52djCxG63BWPCphHnCfHmAYJeQAfYfN6CJPPGOokw6q345Iqh5ITppMO507U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pAISkt1oi0rffaxu33W53M2PUH+xxoIDO2L7U2Q9RKbT+78Y
	ACpbJQ69u8JkIoY7XcCx1Yk3Z6uaBUS1VrfRno2Rncbn+/vq7Ct/5/N8XRIhx4dIYHs=
X-Gm-Gg: AY/fxX5mwkY9tWCIth89GiY22HUmUsJc2MQhCU0r9jLUum4VB4qwRpkAVVI4RenLMzY
	AC2RnidrU+2B0txPxxYyv1194xKZ4uof+BDoWpeNk81ksgis94VrPw0ES7w9IfMiOGc1X3zfVcA
	I5l9E9SUbjLJJAROp0mafVeq5B29y5R8GQswbsPGM1kPCORpoU5BFtqkMwSHDppnCns22o6wgng
	UKog/VlSMaVXEF3no/qEpWt6F/WIaPKVQrL/InU7YLRxWiGix3StIhBelU5EBKksqwpQIxvzN3b
	0m9sWI9XlvLiQ1fPmfioHT6IQuBVLqIkPga4aDydApm8Jxr1TanlsahUWlq5VUkof91ubv2L1+4
	7ODEuqINJtRvGu6pI8v3x5CM5Ql5bVqYzaf6Rl6DzY/8yVLmb34c4Iw7PrL4pVV5z8l/HnP37Mg
	ocxPtmqp6AdgK4phzhQseSvcb7c6OVdVsr7LEpPgF75Cfd
X-Google-Smtp-Source: AGHT+IEPEjW0MFF7XpVGkwzAcntgXmiMlF44sJn5/0D75QBASzgkXeFz6g/IOk7ES0aszo/qNinGTw==
X-Received: by 2002:a05:7022:252c:b0:11b:9b9f:427a with SMTP id a92af1059eb24-121f8af43e6mr4626456c88.21.1767843356493;
        Wed, 07 Jan 2026 19:35:56 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243f743sm9943034c88.8.2026.01.07.19.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:35:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to softirq
Date: Wed, 7 Jan 2026 22:35:44 -0500
Message-Id: <9086EA4F-0393-4E01-AE74-1B428904BFCE@joelfernandes.org>
References: <B952AB3F-16CC-4D28-8038-23DD052D6DDC@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 Paul E McKenney <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kai Yao <yaokai34@huawei.com>,
 Tengda Wu <wutengda2@huawei.com>
In-Reply-To: <B952AB3F-16CC-4D28-8038-23DD052D6DDC@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (23B85)



> On Jan 7, 2026, at 8:35=E2=80=AFPM, Joel Fernandes <joel@joelfernandes.org=
> wrote:
>=20
> =EF=BB=BF
>=20
>> On Jan 7, 2026, at 8:02=E2=80=AFPM, Joel Fernandes <joel@joelfernandes.or=
g> wrote:
>>=20
>> =EF=BB=BF
>>=20
>>>> On Jan 7, 2026, at 6:15=E2=80=AFPM, Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>>>=20
>>> =EF=BB=BFLe Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a =C3=A9=
crit :
>>>> From: Yao Kai <yaokai34@huawei.com>
>>>>=20
>>>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>>>> __rcu_read_unlock()") removes the recursion-protection code from
>>>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>>>> raise_softirq_irqoff() with ftrace enabled as follows:
>>>>=20
>>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stac=
k.constprop.0+0x172/0x180
>>>> Modules linked in: my_irq_work(O)
>>>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 P=
REEMPT(full)
>>>> Tainted: [O]=3DOOT_MODULE
>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
>>>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>>>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>>>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>>>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>>>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>>>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>>>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>>>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:00000000000=
00000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>>>> PKRU: 55555554
>>>> Call Trace:
>>>> <IRQ>
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> unwind_next_frame+0x203/0x9b0
>>>> __unwind_start+0x15d/0x1c0
>>>> arch_stack_walk+0x62/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> raise_softirq_irqoff+0x6e/0xa0
>>>> rcu_read_unlock_special+0xb1/0x160
>>>> __is_insn_slot_addr+0x54/0x70
>>>> kernel_text_address+0x48/0xc0
>>>> __kernel_text_address+0xd/0x40
>>>> unwind_get_return_address+0x1e/0x40
>>>> arch_stack_walk+0x9c/0xf0
>>>> stack_trace_save+0x48/0x70
>>>> __ftrace_trace_stack.constprop.0+0x144/0x180
>>>> trace_buffer_unlock_commit_regs+0x6d/0x220
>>>> trace_event_buffer_commit+0x5c/0x260
>>>> trace_event_raw_event_softirq+0x47/0x80
>>>> __raise_softirq_irqoff+0x61/0x80
>>>> __flush_smp_call_function_queue+0x115/0x420
>>>> __sysvec_call_function_single+0x17/0xb0
>>>> sysvec_call_function_single+0x8c/0xc0
>>>> </IRQ>
>>>>=20
>>>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ wo=
rk")
>>>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>>>> setting a flag before calling irq_work_queue_on(). We fix this issue by=

>>>> setting the same flag before calling raise_softirq_irqoff() and rename t=
he
>>>> flag to defer_qs_pending for more common.
>>>>=20
>>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_re=
ad_unlock()")
>>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>=20
>>> Looks good but, BTW, what happens if rcu_qs() is called
>>> before rcu_preempt_deferred_qs() had a chance to be called?
>>=20
>> Could you provide an example of when that can happen?
>>=20
>> If rcu_qs() results in reporting of a quiescent state up the node tree be=
fore the deferred reporting work had a chance to act, then indeed we should b=
e clearing the flag (after canceling the pending raise_softirq_irqoff()).
>>=20
>>>> flag to defer_qs_pending for more common.
>>>>=20
>>>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_re=
ad_unlock()")
>>>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>>>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>>>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>>>=20
>>> Looks good but, BTW, what happens if rcu_qs() is called
>>> before rcu_preempt_deferred_qs() had a chance to be called?
>>=20
>> Could you provide an example of when that can happen?
>>=20
>> As far as I can see, even if that were to happen, which I think you are r=
ight it can happen, we will still go through the path to report deferred qui=
escent states and cancel the pending work (reset the flag).
>>=20
>>> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
>>> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_spe=
cial()
>>> (unless the task is blocked). And further calls to rcu_preempt_deferred_=
qs()
>>> through rcu_core() will be ignored as well.
>>=20
>> I am not sure if this implies that deferred quiescent state gets cancelle=
d because we have already called unlock once. We have to go through the defe=
rred quiescent state path on all subsequent quiescent state reporting, even i=
f need_qs reset. How else will the GP complete.
>>>=20
>>> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state unti=
l
>>> the next grace period. And if rcu_read_unlock_special() is called again
>>> during the next GP on unfortunate place needing deferred qs, the state m=
achine
>>> will spuriously assume that either rcu_core or the irq_work are pending,=
 when
>>> none are anymore.
>>>=20
>>> The state should be reset by rcu_qs().
>>=20
>> In fact I would say if a deferred QS is pending, we should absolutely not=
 reset its state from rcu_qs..
>>=20
>> Maybe we should reset it from rcu_report_qs_rdp/rnp?
>>=20
>> Unfortunately, all of this is coming from me being on a phone and not at a=
 computer, so I will revise my response, but probably tomorrow, because toda=
y the human body is not cooperating.
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
>>> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_spe=
cial()
>>> (unless the task is blocked). And further calls to rcu_preempt_deferred_=
qs()
>>> through rcu_core() will be ignored as well.
>>=20
>> I am not sure if this implies that deferred quiescent state gets cancelle=
d because we have already called unlock once. We have to go through the defe=
rred quiescent state path on all subsequent quiescent state reporting, even i=
f need_qs reset. How else will the GP complete.
>>>=20
>>> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state unti=
l
>>> the next grace period. And if rcu_read_unlock_special() is called again
>>> during the next GP on unfortunate place needing deferred qs, the state m=
achine
>>> will spuriously assume that either rcu_core or the irq_work are pending,=
 when
>>> none are anymore.
>>>=20
>>> The state should be reset by rcu_qs().
>>=20
>> In fact I would say if a deferred QS is pending, we should absolutely not=
 reset its state from rcu_qs..
>>=20
>> Maybe we should reset it from rcu_report_qs_rdp/rnp?
>>=20
>> thanks,
>=20
>=20
> By the way, when I last tried to do it from rcu_qs, it was not fixing the o=
riginal bug with the IRQ work recursion.
>=20
> I found that it was always resetting the flag. But probably it is not even=
 the right place to do it in the first place.

I think we need to reset the flag in rcu_report_exp_rdp() as well if exp_hin=
t is set and we reported exp qs.

 I am working on a series to cover all cases and will send RFC soon. However=
 this patch we are=20
reviewing can go in for this merge window and the rest I am preparing (for f=
urther improvement) for the next merge window, if that sounds good.

Thanks!

 - Joel


>=20
> Thanks,
>=20
> - Joel
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>>=20
>> - Joel
>>=20
>>=20
>>>=20
>>> Thanks.
>>>=20
>>> --
>>> Frederic Weisbecker
>>> SUSE Labs
>>>=20

