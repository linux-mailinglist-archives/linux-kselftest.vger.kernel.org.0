Return-Path: <linux-kselftest+bounces-48454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD93D00876
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 02:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C5503000509
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 01:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AD212FB9;
	Thu,  8 Jan 2026 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CS7nN2RQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51812116E0
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 01:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834178; cv=none; b=c8Sk5td1Ro6YhwPaebre/UMmXfdK5t7skVxit9r/luLxCTTZagq5OkCz6TPKG3D2LPzfHKZ8PNdq6CKm757avRiu1gPF3bbMJO4F5oGx6C/gJ7dotwucnBgtYEp0Mu/CsyX3N4iKU0sU6y39AFiCEgXeGqA3Nj/GgfNbHxEObns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834178; c=relaxed/simple;
	bh=LaGEFk0u9Ah0SwBDYRhYdCc2dfVBPIXzJYYYHnjJjGo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sx3hxatsVYAaBe6kThMeOnYnhOptB1NQnVILF8BjH4SWON6eXuJ3E4qfzw84YV05sVHtCzfnnbxlKtgnTR7jUvxu+9FffkBTbrof6YmQWxHxxzJ89/mLuaQH91Ru+FnaJh3cwLnjqcIMXEzc4Xy/8GE5qSz6NwLCCb6fgHD80gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=CS7nN2RQ; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f1fb91996so1686518c88.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 17:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767834175; x=1768438975; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+cibWmp2EIFIhU9pnQjoqNBSGOyWGbUTf6dJQy4Buk=;
        b=CS7nN2RQF83JnNoz3OSR47ykWro/LfK6wd1OEgfj1DgA9rwo87BHtKEsgjkPpM/Ccf
         maQViuUZfb+zVSv5O+l+zIV4i6i7Y3f0kF0+ZiczpiXiGJmUsa0d62IuI6ZURMETmrU0
         Igsn2Qf9jH++YYentv0cb1RQscjoZS6U8SyN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767834175; x=1768438975;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+cibWmp2EIFIhU9pnQjoqNBSGOyWGbUTf6dJQy4Buk=;
        b=XDQOxuCFjMj+W3qZHZHIUzLJc1h2uGVMGVBkKz8IK9KNw4h7JrXK6OhkFoxb3eT6J4
         8Mn3qtXP8JHdko7XlSN05rWUrb9CuIULsu0uZldKc0KN1IyGVNrUNmEwRi0HkWrOpPCQ
         MzxWWyzlElH8Dyubd0Rir2ja4ZpLew55pHP4LEZY3SfwfCCjCErQ+YDpDIiffhvPM+V1
         +DXTb0d73UCH1EQWwHCknfGA+ykV/t+XdQPNNM8y5ubK1S9MEgDMKZ90OoAG7mpS8rv8
         5IQw7rr6M4AIf4eg+iRD/5XaS0ryr7fruwcUKUTAp/IjP45sosrOdLBo5TtgK+TjD+Wx
         bgHA==
X-Forwarded-Encrypted: i=1; AJvYcCWYairzVSK1PSIHWH/fG+wGIUu5PG9By9h5tIDXsXv53i0qQTG1gJ0CnuWL2De970VtICBRIz0Psbvl+gR+y8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPB7sdFx0ICU0RkjrQiSDdAY/lGRJduOhcPPmCX0hweLbPpRe
	YKcwfmDB9jfK14gc4tTvFD7XAPLRFkQR5LJMUsVN+z/D9lEUnNO8oVbEDVO3OIR5Q1U=
X-Gm-Gg: AY/fxX5vNPSfdvs6s0suPEb1pyfMZWFmMSlTkShPBupnA8BJrp4A4cEAV9Qi1qPj1Yk
	9zysstfGy3JW7CxF67/75IUel4J2H64V9hpULFWixATTXBS+Lf8TF5dw7RbYYsZ8EUQGwONadTy
	QYun0GxsY+S61hZj1QmLEqGxQJy0UuJ9h4yy0jzMmwYZDauq5fkSW1yl/BlyOaPt6FPP82DmxlV
	TqDIK3dem/+vJC2hywJXm88gOlGR7jyR/DYMX4Y0IohxcXCNqGhQca2CduWH1+JFsEOk/Zy9VJ8
	03z0cpO+hC6cse9cGCOUkb+0Qh2Pkh0+Ohaaq3y3jhi7zbrLxtJ/ruAo6C5u1teNsSz4ma49ykj
	GyUnFaw6bHSOcbhL5EjWUECTP5b73cPhAG+HxT/vAa+j6Lmqabujyii4qj3znneSJ6dHCZup1Ux
	ro0NEteXZCYbYZBu9uUsL85NRt2h8p8oruEw==
X-Google-Smtp-Source: AGHT+IFsjdNLf5/MXeBe5tI14o5USLs9twXkeilj2J1WPfUL0kxHF1JfAn20WArIDxKes/KZKqbLNw==
X-Received: by 2002:a05:7022:248f:b0:119:fac9:cdb1 with SMTP id a92af1059eb24-121f8add5f5mr3973333c88.20.1767834175326;
        Wed, 07 Jan 2026 17:02:55 -0800 (PST)
Received: from smtpclient.apple ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm11733743c88.12.2026.01.07.17.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:02:54 -0800 (PST)
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
Date: Wed, 7 Jan 2026 20:02:43 -0500
Message-Id: <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>
References: <aV7o36CHTLc-tD41@pavilion.home>
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
In-Reply-To: <aV7o36CHTLc-tD41@pavilion.home>
To: Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (23B85)



> On Jan 7, 2026, at 6:15=E2=80=AFPM, Frederic Weisbecker <frederic@kernel.o=
rg> wrote:
>=20
> =EF=BB=BFLe Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a =C3=A9=
crit :
>> From: Yao Kai <yaokai34@huawei.com>
>>=20
>> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
>> __rcu_read_unlock()") removes the recursion-protection code from
>> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
>> raise_softirq_irqoff() with ftrace enabled as follows:
>>=20
>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.=
constprop.0+0x172/0x180
>> Modules linked in: my_irq_work(O)
>> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PR=
EEMPT(full)
>> Tainted: [O]=3DOOT_MODULE
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
>> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
>> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
>> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
>> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
>> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
>> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
>> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
>> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000=
000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
>> PKRU: 55555554
>> Call Trace:
>> <IRQ>
>> trace_buffer_unlock_commit_regs+0x6d/0x220
>> trace_event_buffer_commit+0x5c/0x260
>> trace_event_raw_event_softirq+0x47/0x80
>> raise_softirq_irqoff+0x6e/0xa0
>> rcu_read_unlock_special+0xb1/0x160
>> unwind_next_frame+0x203/0x9b0
>> __unwind_start+0x15d/0x1c0
>> arch_stack_walk+0x62/0xf0
>> stack_trace_save+0x48/0x70
>> __ftrace_trace_stack.constprop.0+0x144/0x180
>> trace_buffer_unlock_commit_regs+0x6d/0x220
>> trace_event_buffer_commit+0x5c/0x260
>> trace_event_raw_event_softirq+0x47/0x80
>> raise_softirq_irqoff+0x6e/0xa0
>> rcu_read_unlock_special+0xb1/0x160
>> unwind_next_frame+0x203/0x9b0
>> __unwind_start+0x15d/0x1c0
>> arch_stack_walk+0x62/0xf0
>> stack_trace_save+0x48/0x70
>> __ftrace_trace_stack.constprop.0+0x144/0x180
>> trace_buffer_unlock_commit_regs+0x6d/0x220
>> trace_event_buffer_commit+0x5c/0x260
>> trace_event_raw_event_softirq+0x47/0x80
>> raise_softirq_irqoff+0x6e/0xa0
>> rcu_read_unlock_special+0xb1/0x160
>> unwind_next_frame+0x203/0x9b0
>> __unwind_start+0x15d/0x1c0
>> arch_stack_walk+0x62/0xf0
>> stack_trace_save+0x48/0x70
>> __ftrace_trace_stack.constprop.0+0x144/0x180
>> trace_buffer_unlock_commit_regs+0x6d/0x220
>> trace_event_buffer_commit+0x5c/0x260
>> trace_event_raw_event_softirq+0x47/0x80
>> raise_softirq_irqoff+0x6e/0xa0
>> rcu_read_unlock_special+0xb1/0x160
>> __is_insn_slot_addr+0x54/0x70
>> kernel_text_address+0x48/0xc0
>> __kernel_text_address+0xd/0x40
>> unwind_get_return_address+0x1e/0x40
>> arch_stack_walk+0x9c/0xf0
>> stack_trace_save+0x48/0x70
>> __ftrace_trace_stack.constprop.0+0x144/0x180
>> trace_buffer_unlock_commit_regs+0x6d/0x220
>> trace_event_buffer_commit+0x5c/0x260
>> trace_event_raw_event_softirq+0x47/0x80
>> __raise_softirq_irqoff+0x61/0x80
>> __flush_smp_call_function_queue+0x115/0x420
>> __sysvec_call_function_single+0x17/0xb0
>> sysvec_call_function_single+0x8c/0xc0
>> </IRQ>
>>=20
>> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work=
")
>> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
>> setting a flag before calling irq_work_queue_on(). We fix this issue by
>> setting the same flag before calling raise_softirq_irqoff() and rename th=
e
>> flag to defer_qs_pending for more common.
>>=20
>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read=
_unlock()")
>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>=20
> Looks good but, BTW, what happens if rcu_qs() is called
> before rcu_preempt_deferred_qs() had a chance to be called?

Could you provide an example of when that can happen?=20

If rcu_qs() results in reporting of a quiescent state up the node tree befor=
e the deferred reporting work had a chance to act, then indeed we should be c=
learing the flag (after canceling the pending raise_softirq_irqoff()).

>> flag to defer_qs_pending for more common.
>>=20
>> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read=
_unlock()")
>> Reported-by: Tengda Wu <wutengda2@huawei.com>
>> Signed-off-by: Yao Kai <yaokai34@huawei.com>
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>=20
> Looks good but, BTW, what happens if rcu_qs() is called
> before rcu_preempt_deferred_qs() had a chance to be called?

Could you provide an example of when that can happen?=20

As far as I can see, even if that were to happen, which I think you are righ=
t it can happen, we will still go through the path to report deferred quiesc=
ent states and cancel the pending work (reset the flag).

> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_speci=
al()
> (unless the task is blocked). And further calls to rcu_preempt_deferred_qs=
()
> through rcu_core() will be ignored as well.

I am not sure if this implies that deferred quiescent state gets cancelled b=
ecause we have already called unlock once. We have to go through the deferre=
d quiescent state path on all subsequent quiescent state reporting, even if n=
eed_qs reset. How else will the GP complete.
>=20
> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state until
> the next grace period. And if rcu_read_unlock_special() is called again
> during the next GP on unfortunate place needing deferred qs, the state mac=
hine
> will spuriously assume that either rcu_core or the irq_work are pending, w=
hen
> none are anymore.
>=20
> The state should be reset by rcu_qs().

In fact I would say if a deferred QS is pending, we should absolutely not re=
set its state from rcu_qs..

Maybe we should reset it from rcu_report_qs_rdp/rnp?

Unfortunately, all of this is coming from me being on a phone and not at a c=
omputer, so I will revise my response, but probably tomorrow, because today t=
he human body is not cooperating.=20

thanks,

 - Joel


> current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
> so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_speci=
al()
> (unless the task is blocked). And further calls to rcu_preempt_deferred_qs=
()
> through rcu_core() will be ignored as well.

I am not sure if this implies that deferred quiescent state gets cancelled b=
ecause we have already called unlock once. We have to go through the deferre=
d quiescent state path on all subsequent quiescent state reporting, even if n=
eed_qs reset. How else will the GP complete.
>=20
> But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state until
> the next grace period. And if rcu_read_unlock_special() is called again
> during the next GP on unfortunate place needing deferred qs, the state mac=
hine
> will spuriously assume that either rcu_core or the irq_work are pending, w=
hen
> none are anymore.
>=20
> The state should be reset by rcu_qs().

In fact I would say if a deferred QS is pending, we should absolutely not re=
set its state from rcu_qs..

Maybe we should reset it from rcu_report_qs_rdp/rnp?

thanks,

 - Joel


>=20
> Thanks.
>=20
> --
> Frederic Weisbecker
> SUSE Labs
>=20

