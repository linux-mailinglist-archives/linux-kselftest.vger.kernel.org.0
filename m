Return-Path: <linux-kselftest+bounces-41607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1CB59F70
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA731C02551
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8842F2607;
	Tue, 16 Sep 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k08uJiM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D627A927
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044232; cv=none; b=i1E7X14ku8x3lTIcDIMLcW9KXjML/jruRf5hoP6AgQESI+ZPGDQasqiVeiQx5nNmJ+mbAeuvs/w74ek+jViH0WW+HDlhs0xTlvaow1XzjX82/+LM8TWHnxxeQd9Z+FqZj8DBHX3BpuHuw1Z8k0vxSnofYCPzyLJxUsj+PDP1BPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044232; c=relaxed/simple;
	bh=kv6ZpslqdALj+1UMNbOILF/wNT6aZwL4VN3adeyqTFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRfOpo4puGQqDzu+AuZP1yudYFfCysXYJ4Dt6SCM9rF7Ic9/sr85O6szgiYyFaWhtnDuOGxMjs63aQkOnZDI89Ugr6Gk0t3E9VSjw3+gC8EFK50A308HeYJRoBXwYx+BgXl1MPUbaE5J738ml2ioSMkyTBnpdiTA2dSaYf827dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k08uJiM7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-267c90c426dso15785ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758044231; x=1758649031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA74VvTmfLQYH/wAbK7AqscvwtHz9UXBzDQdDDhZ8Jk=;
        b=k08uJiM7txpO1WRoqFpvQzpQAB43CiL3UIm0PefaA3vZ4KZ3J0p9tvqCxzaG/MRNW2
         Ia8rFSAvvXsZmEFQZFqFRrlg/SEhiYvI5cbsptil+by62NWCz8kMis7E37lJ7S4VUhsn
         btXXO1NZijjLiix6HKVv2mzk3x9JeIx7KX6tVYqPvdXbWvkR035cag298xZu6ZE5Fedx
         Htspzbx1Pro1GIApH2A7Ow6ePdBUw5wf1UjoGCLHqFWNBlLIuzK5qVLDeFLkeA6XJ470
         rEDSlp/VtSFwI+WOeDyj3RFtf6CMX1YaOt4a+HwWs6HtGIJIKutZlk7o13cgo5NGv1lI
         EMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044231; x=1758649031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA74VvTmfLQYH/wAbK7AqscvwtHz9UXBzDQdDDhZ8Jk=;
        b=J/KIZCeN6nwcFuVHzUux14M9gRvZqubAWTbpLemScj1uq6oR7bbokvKRkjqVzTWnuk
         7T+Dp7WqdfgkyUoOnVa+EE0qqXLxpkXo0SPDKdrtP955lBo5QmgGYxytNjfPFRrnHVuB
         qXPGBzuNjdbqh+AlFT11i3o/RKtfjEG5zKTuI5KTqUs9AdBK3hkWzl2+n569RgJfmjuw
         3ZTxmal+9dYnl2GZDLwvyNbFxEjx//p5BgQKrHPG2CaQQGx7vDJIo2AtDsBsRyBJ+5i7
         FJJyh0+q9I/rSJgieqi4D/0GbfqeYKW7FWcdk/F87NvQ6n946uTY5JYhTw9Hwz2lIsSE
         rv/A==
X-Forwarded-Encrypted: i=1; AJvYcCUPi9Pr+vtrXuW1gHsIlOkFo9qcMhkl6qoTtzeO2ZPO61I/IJ6RcUHUZu2icmKI08rIAlEn/NstVKV+ZvxY4jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3cuhCraq3xeWRIETt4gBIShvtlwDvwRz8hurlDN4IHvidKoY
	hETA6wy0bdzgBqOL7gJcZrwUD5XVAuIsTyDE+kv5PH6MS8IzmNkHpTcsOWjiY+fXErIBKfcnf1Z
	qfNIc4yeC0jjeZ70ALDiRXRbBjL572Z7S0skgs3/v
X-Gm-Gg: ASbGncvvsYN9FOADEh4JILz7ttBoRGfBZdMFiC8dqtf6RT1u4h+lrpJkzVtcbvksl+V
	vla76OuS5hQO89wNS/4ljq7/XVqJk/Yh3P/CTCBWnuDxluipMYFrNIGn0iLl8ayKLn5fjjBhaV1
	BLml/T4pKqXuWkNK5MHyPR6rcoEuNBKMel235AdXjAXKqjKFQi82cwXc7poS/z9KnOblYRlFCcr
	HFiKzVMgtnKcEXVLZWSo7zGY1voX/q+FNGOjl7e3KRS2VF2bmstCPA=
X-Google-Smtp-Source: AGHT+IEX8t5jebkJIlwMxZnNynAqrdl33amj/WSy/bikpKDzclCAMtzRK9J6Z6CrGhjF/ewhMpAMvfCa6gHuq1eekRA=
X-Received: by 2002:a17:902:e5cb:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-26801092aefmr164555ad.16.1758044228996; Tue, 16 Sep 2025
 10:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com> <20250916115220.4a90c745@batman.local.home>
In-Reply-To: <20250916115220.4a90c745@batman.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:36:57 -0700
X-Gm-Features: AS18NWA2d_yigeV8O2eyFGhdEoQ1sMbWT_8VJ2GS10eRsMmT9vFpF8pvM3GYncQ
Message-ID: <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:52=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 15 Sep 2025 18:19:53 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
>
> > Hi Steve,
> >
> > Thanks for the comments and suggestion you are right we can use bpf to
> > get the comm. There is nothing special about this trace event.  I will
> > drop comm in the next revision.
> >
> > The reason I did the task_struct parameter (current): I believe there
> > is a limitation that we must  specify at least 1 parameter to the
> > TRACE_EVENT()  PROTO and ARGS macros.
>
> OK, then this is another issue. We don't want tracepoint "markers".
> Each tracepoint can take up to 5K in memory due to the code it
> generates and the meta data to control it.
>
> For something like that, we highly recommend dynamic probes (fprobes,
> kprobes, etc).
>
> The only purpose of a static tracepoint is to get data within a
> function that is too difficult to get via a probe. It should never be
> used as a trigger where its purpose is "we hit this path".

Hi Steve,

I completely agree with the principle that static tracepoints
shouldn't be used as markers if a dynamic probe will suffice. The
intent here is to avoid introducing overhead in the common case to
avoid regressing mmap, munmap, and other syscall latencies; while
still providing observability for the max vma_count exceeded failure
condition.

The original centralized check (before previous review rounds) was
indeed in a dedicated function, exceeds_max_map_count(), where a
kprobe/fprobe could have been easily attached without impacting the
common path. This was changed due to previous review feedback to the
capacity based vma_count_remaining() which necessitated the check to
be done externally by the callers:

https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.com/

Would you be ok with something like:

trace_max_vma_count_exceeded(mm);

TP_STRUCT__entry(
__field(unsigned int, mm_id)
__field(unsigned int vma_count)
)

mm_id would be the hash of the mm_struct ptr similar to rss_stat and
the vma_count is the current vma count (some syscalls have different
requirements on the capacity remaining: mremap requires 6 available
slots, other syscalls require 1).

Thanks,
Kalesh

>
> -- Steve

