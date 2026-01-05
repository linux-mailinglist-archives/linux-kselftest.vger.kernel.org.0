Return-Path: <linux-kselftest+bounces-48194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DFCF3152
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1EFF302D529
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C842286D5D;
	Mon,  5 Jan 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGNOBICu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADC22B5A5
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610369; cv=none; b=MAlL+7VfBuiCPRH5w9gXkIYdMlghm/+Czz9B5dQN0JSyMr/zV9fF3oHSSuwMJFLOjIHiD0NznhK0WcNu7QqtaRQpM+7akyawsygm+pxOFALGFM0HxAjOz4gue6gvkZCmPKyOc3A+OsLnZGbh0LGygjrlosNwUdP9ZWNxPEvKjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610369; c=relaxed/simple;
	bh=S+2jW6sr68INml29A9/xooxgR+jzLaZCiBjWWY+6t5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TsKWHeAu/vM5VL4jDcoam3bKiADCf6s2B7gyCQjGuMwpbWx3ZXNu4Y8IWG4jJDFoBeavMQeTou7qPHq22pBFZP7b80qumJs/Qmaf4ulIrcLGigfELEpVZURsovaXYthGxZ7+SoyPu+tVM5Ss/KqFIHWJRVSOxh3QZ5mFSUhfQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGNOBICu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso90577055e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767610365; x=1768215165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZIE86Erp1QGbs2m/K1kc889xwmLfFaps0VsChU7D34=;
        b=XGNOBICuBd4BWpun70D0JQwg9GGyoI+In9wJZ3j1cKZ73ZlLI/j3uTRtRg7dTxnYFs
         nMS2bP9Wf1FMat23xwpG37OKPuw7LCShdPoti5LfimxbO7i9VrzlL7265o2SbiygxpN9
         K9lhJOeDE03llzQ/PZ/zJxtm158L7P/vn4yojSckfCJ/Pk+RUwWTjQ0HwyhF22dMyJ5R
         o0HEKAlnzisuXWOWaX9WRy8YpU4a2+3SYzE9aIEzre+qc8HVvENeJ/57oMqDVVFrfRC2
         IoY/U64lT7UCDrd/Ll+MjyJ/l5s4lI/Q7FcDDS44qVge0/rqpl83lIoflTESKovTCPWr
         Gpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610365; x=1768215165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZIE86Erp1QGbs2m/K1kc889xwmLfFaps0VsChU7D34=;
        b=MpkBE+2+EFK/ibJr6Vm4Wwkf+jHVp0oYz784Z4r9NuXSl70l+gdRvdew+Wqbm6p5qw
         rjlz/7XXwNBzemrai+8ac0aj/wbJlbkK/Rl5mpCtqRC/zqniYeicTNtvhTq/7JtWF9F8
         q18ZRywvhGVkDIT1nU2LgGcu08PzF1I2FmeY3ayBal5oBx46f2LkHOVRCHikLbNnzPog
         /wKJs8C08ECkV/DCVljIr+d5UW5L/qZTdlwdFSu5KfR+9F7qldJLAocV9oJ6Zt40tfus
         Y93SwyJj0+9DedWgwQVT6bQwEqJeayICLPjxIfd6Jcu3AhVHgybT5xDjgl15Vkbv64ju
         q/GA==
X-Forwarded-Encrypted: i=1; AJvYcCWGO6pXeZ/5XCP9YNpgrdRAPoobjb3X9AUzfGAzNcg9AIGOybY6eELFL/1ZhLJZTt8BHZEMnODQwswgc1Ry08U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bqbbsmauV+jhnLi3dGPcRvVtPMo7cH3tMV597QVAzvfD20RP
	1QzFb3VDXBc/yfS7dSRd2igOJljPyfSJbEA2JewZwdkTP7Nak0tUG6o/GetYUVjl/kxsudOWJZb
	a6zcxzhtq6bDQDw==
X-Google-Smtp-Source: AGHT+IEAJYABQdl0S3AMd+Kym0YbP2ev2YfxQ/hHue5b+xcTvswe3K5CPOaAuQwSBUuFhDhZ84cMtaq210atDg==
X-Received: from wrbgv28.prod.google.com ([2002:a05:6000:461c:b0:42f:b138:c617])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8718:b0:479:1a0a:ebbe with SMTP id 5b1f17b1804b1-47d25082cc8mr551544395e9.14.1767610364788;
 Mon, 05 Jan 2026 02:52:44 -0800 (PST)
Date: Mon, 05 Jan 2026 10:52:44 +0000
In-Reply-To: <CABVgOSmMXsbhJsBBy9p=WK1RdB+gcgyuma_FTSfQOGWJ0eqU8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
 <20251223-b4-kunit-user-alloc-v1-2-fb910ae0e50c@google.com> <CABVgOSmMXsbhJsBBy9p=WK1RdB+gcgyuma_FTSfQOGWJ0eqU8A@mail.gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DFGLKV1IYDM7.1W30Z9PG0WIA9@google.com>
Subject: Re: [PATCH 2/3] kthread: Add kthread_take_mm()
From: Brendan Jackman <jackmanb@google.com>
To: David Gow <davidgow@google.com>, Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Jan 5, 2026 at 9:56 AM UTC, David Gow wrote:
> On Wed, 24 Dec 2025 at 00:18, Brendan Jackman <jackmanb@google.com> wrote:
>>
>> lib/kunit/user_alloc.c currently uses kthread_use_mm() without a
>> corresponding kthread_unuse_mm(). This is a bug, but fixing it in KUnit
>> makes writing tests that use mms more difficult, because of KUnit's
>> resource/try-catch model.
>>
>> Therefore, introduce a new operation that does what kunit_attach_mm()
>> wants, namely an unbalanced call with cleanup deferred to
>> kthread_exit().
>>
>> This is actually just the same as kthread_use_mm() but without taking a
>> reference on the mm_struct.
>>
>> While adding this, clarify the reference returned by mm_alloc(), since
>> that is what kthread_take_mm() is gonna be paired with, in practice.
>>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>
> This makes some sense to me from the KUnit side, though it'd probably
> be nicer to have a way of actually triggering kunit_unuse_mm() at the
> right spot. I'm not sure if we'll want to have tests spawn additional
> threads sharing the same mm in the future, too, which this shouldn't
> make impossible, particularly if we have a requirement that those
> threads don't outlast the original test thread.
>
> Otherwise, Is there a reason we can't mmdrop() from another kthread
> instead of trying to kthread_unuse_mm()? I wouldn't be surprised (it
> doesn't _seem_ right), but seems to work here.

No I think this works and it's actually how I originally wrote the
patch. 

However I think it's very messy, it depends very heavily on the
implementation of kthread_use_mm(), i.e. it is saying "I assume that
everything in kthread_use_mm() gets undone by kthread_exit(), except
that there's exactly one mmdrop() missing". This seems like a natural
conclusion when you've just spent half an hour staring at
kthread.c and drawing up a stupid little ASCII diagram to try and
drill this godforsaken refcount API into your head... But once you step
away from this patchset I think it would look completely bonkers. Here
I'm looking for a way to actually solve this with a proper API.

On the other hand, I'm now adding a weird special kthread API just to
solve this one little problem in KUnit, which people might reasonably
object to.

So yeah I probably should have laid out some other options in the cover
letter. The ones I can obviously see are:

1. The current proposal.

2. Just call mmdrop() from the other kthread and spray comments
   everywhere to try and make it make sense.

3. Find a way to call kthread_unuse_mm() before the kthread dies, with
   some sort of magic in the kunit_try_catch logic.
   But presumably to make that all work with faulting tests etc is gonna
   mean more special APIs, probably worse than kthread_take_mm(). (I did
   not explore this very carefully so it's possible this is easier than
   I guess).


