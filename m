Return-Path: <linux-kselftest+bounces-41533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF53B5880C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31931B22806
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B702D47F1;
	Mon, 15 Sep 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhCobLao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F72C0F64
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977869; cv=none; b=lNfGaI3o4d1zDJvYzmNZK8kH+Qo7ldedv/LixUsfMDQksS39IF95I6+oA1NclVmyKPTYB9Uz/2ktxRp2OvvOagEYOSOcrEWhgUmldsD2Pt0bbGCGxNLAsgfYzJhS9RwSk1emrnuie1Sdp9zGz3tIi1EEb8BMpTu1ml63JuQOA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977869; c=relaxed/simple;
	bh=yCf7pdssRjrTw8YwfJN/Luc4l85IOtsGpURxNehXsC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDqJ6u2WLky914I5PThS5OoY2W73aZvUaYUFMwT9ellOtGi9FId1HKzO6b/1HX0kKWfLsFekJwxTIL/Llh66Zq63mbKDBpw3BVhxHMCMJzlpdPhTHuWL4NlNwNpK8DuBv/uqJH0ywDAc29ONLIV6Jw+a2y3vAhwzVtnJqmtuCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhCobLao; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-265f460ae7bso77425ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977867; x=1758582667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsKsrMGZGN6//cTNQ+8/HyCAfqvHtLWhWR4uwDDiSCM=;
        b=PhCobLaoxda2DRQRlts3OtzFxxEFjUMzFfsh9gDOplybwM7WGJ8sjvwbG9pk69WMRq
         P7gDpreGwLJi+ReyyF7mNDKo1dltxo7oHrNSw5hKQ9X06ZE/e1E++FllF4jPJ5vQ8sfg
         3ZePUM3vXifrZim6K8u6PhJ0YH31YOUnnzH23VsN8m9aPsrDpdqN0ipCZLcoWbkQFLss
         TfqBmtRHZBZwizIyEvfPWfB6LSZC24nAlhuhVx6phFg9py7I/VGeW6cIFgaTdBYyjjCa
         tfxoj1icZCV80HA/mw/xprWBVRYy0eWcvAfrBNkT/1dtgPvQo5FqIL3Gyr3zO3xTNqSi
         U1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977867; x=1758582667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKsrMGZGN6//cTNQ+8/HyCAfqvHtLWhWR4uwDDiSCM=;
        b=uHhv4iwaG+PACN5pE9SJYw1x7TjZUS1xssBZf6MVUMCtPGR/mNgcYJRLFBDsPI0KoN
         GKwpbmxuQmlBy1WW0k5h98bSDtQMKXcsakFmWnbrjILC1waiVHadFoKZqGcHN21CZCCt
         pVnzWcp7Ec2vSKt9oA2o2s2ITDqDFxDT7x8KXzpcjzhF4mKnGL8MktdIF79P+RP6w082
         fWkqr9zH6nj0PU3LqT2Acy9zMISofoSKZktI5JgvrTGx69b0XVE3fqjzIpvl5saNXh5x
         SaqnX3Dxibp1zYlvZQJuoQRtvFJkC1KqIMkKpha4JLtTLxKp+4l8/nCu5xgUGR9lhj5o
         GG8A==
X-Forwarded-Encrypted: i=1; AJvYcCXb09R/68BNEU64kPB0jZ/dw8F20G/WWf7RCcX/K+Na5em19Qd/YvsvbImGVx3qMtqFnHaq+KN5EWXSli4lMfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKp3Kk30MnxzAhg5AEmmFrDwnYoJgzl3ixQzYzwX6zo9BP8sGs
	k5zgRVUphK0UOjcgXFN36Sjh2MyUM6abYJCVPtD+wmq1D8iCUr5Ggai8RaRGQitpvMh7swxXBrE
	rZEKvk3OU/9plDh69PPTC+SA3KvjuRGg+GGd7JXJf
X-Gm-Gg: ASbGncsc4QWMpjs+t+LB+PNTGaJVlAh3DYCoEJnHFug3/+Po65UC+4adt0iQ4ln4Q2l
	Dq9ROHqh+58EeF3IJqRe9qQj/K6UHePOfpMbY36xGzv0o3/cDo4JDSPdgtr/9mcUT49NBGwRv2v
	+oTFPHqMkrP2m262KEYz9LTpqBWQrUq1A/EEGjNFX803//wviQhOomOABSN2hNi7nQ9ylhIL+46
	jnIMhTKpghLVD+HFj2KLiWwXbUgEEO1xuZ9uuk6JG4x8COYaxVUhcs=
X-Google-Smtp-Source: AGHT+IEkitpGEz8BMKWmLGPZ3W85vqrSP9MG29lIbMnJb9upndiATYfQPV08S+weYTCqY9YvT87o5wWIohG6pp/8rq4=
X-Received: by 2002:a17:903:181:b0:246:a8ac:1a36 with SMTP id
 d9443c01a7336-267c1903062mr2169965ad.2.1757977867063; Mon, 15 Sep 2025
 16:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com> <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
In-Reply-To: <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 15 Sep 2025 16:10:55 -0700
X-Gm-Features: Ac12FXwVYGcBZT9d6NPCct-EK04uGWSzFyRbMpRKe55ZXQp9Zltcw49n-TJl9YM
Message-ID: <CAC_TJvd=zwhRZcXTvDPfuzdjYV7j_jvZKZ--eKDRTsE+LBmASA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Andrew Morton <akpm@linux-foundation.org>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 09:36:31 -0700 Kalesh Singh <kaleshsingh@google.com> =
wrote:
>
> > Hi all,
> >
> > This is v2 to the VMA count patch I previously posted at:
> >
> > https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.c=
om/
> >
> >
> > I've split it into multiple patches to address the feedback.
> >
> > The main changes in v2 are:
> >
> > - Use a capacity-based check for VMA count limit, per Lorenzo.
> > - Rename map_count to vma_count, per David.
> > - Add assertions for exceeding the limit, per Pedro.
> > - Add tests for max_vma_count, per Liam.
> > - Emit a trace event for failure due to insufficient capacity for
> >   observability
> >
> > Tested on x86_64 and arm64:
> >
> > - Build test:
> >     - allyesconfig for rename
> >
> > - Selftests:
> >       cd tools/testing/selftests/mm && \
> >           make && \
> >           ./run_vmtests.sh -t max_vma_count
> >
> >        (With trace_max_vma_count_exceeded enabled)
> >
> > - vma tests:
> >       cd tools/testing/vma && \
> >           make && \
> >         ./vma
>
> fwiw, there's nothing in the above which is usable in a [0/N] overview.
>
> While useful, the "what changed since the previous version" info isn't
> a suitable thing to carry in the permanent kernel record - it's
> short-term treansient stuff, not helpful to someone who is looking at
> the patchset in 2029.
>
> Similarly, the "how it was tested" material is also useful, but it
> becomes irrelevant as soon as the code hits linux-next and mainline.

Hi Andrew,

Thanks for the feedback. Do you mean the cover letter was not needed
in this case or that it lacked enough context?

>
>
> Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> feeling a need to slow things down for additional stabilization and so
> people hopefully get additional bandwidth to digest the material we've
> added this far.  So I think I'll just cherrypick [1/7] for now.  A
> great flood of positive review activity would probably make me revisit
> that ;)
>

I understand, yes 1/7 is all we need for now, since it prevents an
unrecoverable situation where we get over the limit and cannot recover
as munmap() will then always fail.

Thanks,
Kalesh

