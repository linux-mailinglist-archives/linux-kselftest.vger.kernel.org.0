Return-Path: <linux-kselftest+bounces-41610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D372B59FDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B927B424D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690327E1B1;
	Tue, 16 Sep 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxQ2mHJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBABE23E35E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045478; cv=none; b=gfUI+jAMIEurrD1MUGwpHd/GayGTQ0KE6biy8LQHBM87F43l5rCalsncD49XRkaGqOBUlYH9FMHq8WdLYpgdL7JkB+bmSRQzrNACHzK0FuhDFypctDumqYLQWS8cWexAJSmZi/CYgndLqyj0/3WOD8+u4OcjBQSWoTmzTr+df98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045478; c=relaxed/simple;
	bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvMX/og355byqLKUBOPKmhPH/spITyD6XRBxEHEJpA+SmDy9Dl1EZmuRgIFZLEe0XXV7UdblNmC71cGi3DC5cZyJH+FLiji7lKGkugdoCbYCy//+dh3k1rJtPMxsSRnHiciuF1Wk/JTeP+PEoyFOPQHM8pD93micjoqoGK1DDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxQ2mHJF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267c90c426dso21315ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758045476; x=1758650276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
        b=IxQ2mHJFksAjwiKMp+8HY74q1i9vBJT0GEZMLF0iQcYUBwUXIu8SsvYNCKnPVbkVb6
         rX92i/la24a+ITL+7nzR86R21ihixylJap8q6NO0qi+uwnBWdUn2ZWFSKJ0hWBL9XqwI
         8B3aYWQxL+Pgx276zqcE/M22L+fXa1RC38do2i13fR4Bmic0MKXGkLUsLcXzLbPINtRL
         neng8DiyDR4KyBZJurIOxYIX+ulDzK3sneEe9McmyvZRbZeSHagizaqjDJiMeglmPa75
         XDfLTJG/0JXcWe+bCOEJVdtiHRg+pz3CinydTQzKrG7mzpBNcDBoUQz+Fn5kVtxwDY/8
         Y3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045476; x=1758650276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
        b=qoshzdk48EuHjo3QEJjvBRJcR/OFzNamfHqAX3z5mBLLKcuRgqNjF9rEM1zy5c+Bm3
         BcP5EtG5fJwjVElj7GvDugULCHo9seXsyxlCVkkVL4CF4+W7WhgbbQfHOeMWJyG8108c
         DH436cG9jmAVS1EJnpEdPmvSWi+qlQlQpcSs7aHf832zUHa8U56Ii1TMferGeINcVlVh
         wkxAvtjdEuf/w67EDcfbeGzr3HvwhkklMufeKlvSDu8I8JDw0aCg4jxIe+2ObFOh5LqJ
         8qKoIP9OY84v8pLtTyQ5kgJcuSCmJ+5GFNwQ8Mw+X49b7E3COssN3Vc7GK4EsQ53TTN8
         HL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlgRww4RpMr6LUboNbW1BWHmTMvwLP6VsuQUqq5YHODkKt5o8Mt3jcvjPA9vO5sNVbtfpED+Ae5DatDdaqIR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeqwso74LfGwNs5cjJ62HJGyfkxZ9E9fo+Obj61U1PHp0ruP2
	PsaS436K6HC9knKPZYHLgsX/HE1i09aIDNQr8tuW22V/1qFOpbFgtLJ5DDW8IrdbmAnicxDzqXg
	RRuk1iAp0cQYnWGnXFTQQp0P7MFs6ZKzS26iexXwK
X-Gm-Gg: ASbGncsIvYn49pr7gZeDIp8lgBAGoTjeBazLNQkXMQCqvRdVoA0AapZZIJcyvAj9zfN
	1Hwpitw94qzTvJY2/r1+s+/i2gkZ6JSSuFKn8Ur5kq/pltVYUP7Q2rr4Ah5d9QoC3ZXOHTz5ijJ
	l9dExvkbUYnc2bKjA8Np+N+U1PxE0qbGoUNUdqlsTc7lEmOc+QqumnvnqZmBQ8Ulwhxg7MTYZep
	Cl2G9C1yXWHwVBpI4YL/bvbE+LuATnj3NQ57dXuELQ5DfGziJEaNOc1QqZZUShTWg==
X-Google-Smtp-Source: AGHT+IHGbR0nw70VyQc9zW85E2AhlbNJIVkFU9yxJMWLzRlBiKSa4wpgGT7Ne4ww3kizHSnL1IWHtB6HnScEencWC14=
X-Received: by 2002:a17:902:e751:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-26800f6615emr380685ad.8.1758045475525; Tue, 16 Sep 2025
 10:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
 <20250916115220.4a90c745@batman.local.home> <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
 <20250916134833.281e7f8b@gandalf.local.home>
In-Reply-To: <20250916134833.281e7f8b@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:57:43 -0700
X-Gm-Features: AS18NWDROcLW9crQ0p334hZw_COODCH3F9NCEGYQeh0xi3klCf483KDt2XFW7i8
Message-ID: <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 10:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 10:36:57 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > I completely agree with the principle that static tracepoints
> > shouldn't be used as markers if a dynamic probe will suffice. The
> > intent here is to avoid introducing overhead in the common case to
> > avoid regressing mmap, munmap, and other syscall latencies; while
> > still providing observability for the max vma_count exceeded failure
> > condition.
> >
> > The original centralized check (before previous review rounds) was
> > indeed in a dedicated function, exceeds_max_map_count(), where a
> > kprobe/fprobe could have been easily attached without impacting the
> > common path. This was changed due to previous review feedback to the
> > capacity based vma_count_remaining() which necessitated the check to
> > be done externally by the callers:
> >
> > https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.c=
om/
> >
> > Would you be ok with something like:
> >
> > trace_max_vma_count_exceeded(mm);
> >
> > TP_STRUCT__entry(
> > __field(unsigned int, mm_id)
> > __field(unsigned int vma_count)
> > )
> >
> > mm_id would be the hash of the mm_struct ptr similar to rss_stat and
> > the vma_count is the current vma count (some syscalls have different
> > requirements on the capacity remaining: mremap requires 6 available
> > slots, other syscalls require 1).
> >
>
> BTW, why the hash of the mm pointer and not the pointer itself? We save
> pointers in lots of places, and if it is the pointer, you could use an
> eprobe to attache to the trace event to dereference its fields.

In Android we try to avoid exposing raw kernel pointers to userspace
for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
immediately after symbols are resolved for necessary telemetry tooling
during early boot. I believe this is also why rss_stat uses the hash
and not the raw pointer.

Thanks,
Kalesh

>
> -- Steve
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

