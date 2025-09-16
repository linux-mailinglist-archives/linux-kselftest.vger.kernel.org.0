Return-Path: <linux-kselftest+bounces-41616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF3B5A071
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9372A0863
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495A2BE051;
	Tue, 16 Sep 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHZOcV+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E8287273
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047000; cv=none; b=OgbA1S9wQFTW6vcAlJSP3A/B5rJ+LPiDbV8iYO+/8UjmYYHV71dcX07jXeY8eI9hT4gHQoaN/kjhInwrVoGvxa07VcD9DCghi8FJz4svJGbU971XF/pOAbB/GfaulRjKfQ6MR3QpiSF7BEasnULIpfOtCYWM3/C5eh3oHXZWg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047000; c=relaxed/simple;
	bh=MWP0yXO5hqblKAsf86sVb92EBQ6Tee6NsUCw9nEvo9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxruMw3YRGiUdwv/NUkJxR6FCOXDwkEF6iUVmj8ehv9LnXbmshd31MOUDsYC2+lHC5174oBzutbcsl2yhlNYhXKI8Akzawmu9XkdG7UlBxkG6lBaLukdU5QLECVXXivdSqHSa9uPWWCkxCzFN4YScwbyhEEFpqgVncP1aP8G1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHZOcV+c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-265abad93bfso23005ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758046997; x=1758651797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=BHZOcV+c6MvOfCF65mjwe2IECKvFxVl2aV2YgpzUCnkCAPcYhJJVMweggAcfmmLOIe
         2RV9aX5ubl/xGN/A9Lkl5iHYRnNCxLahMeFB20QpHZ9A2tT5gcx7soK4U/UpdeuVma3J
         i7n2UtmYDVwc1SaptmDPUfClDnslr+ozNmj5dYzjpjQezKEsa78W3yEy7ZoHBtB5t6LC
         mGTdm6imIgfYUrVjpyDpmmZPjgaLHYwlkTGoOq3oyYSpDSrPFi7DGlmKfh1sENmglEgC
         VTzOtoHzZYMDNNZSWa5FLUzvl8D2OI+o2UaZmkoxNav7lwfybTzYQRQCeac5o7ljViKc
         5rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046997; x=1758651797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=IyQx8pg9jV5xkr8OYj+C5CHDNIQ0McJTPoPnMXX+OWS4i1iT515cTFY78tFrkbT4w4
         4ZVX6eHW6dMskFKE50VbfOeFv9W7FDEVplG950AIGvqNm1Hrrj9lb9QWDQJ058CAkMBJ
         zOHzYRWLG342xgzHve7KWp74ZBxqbXWLSySMPCazdAHZ+RtZsV8LnltPx59W6LsH1H3j
         LMoS0+xEy5sK37Hnx6A0XS6sRYchrH9HbIqNzBQLQGwgkybu7+zUDXKpSz0kf8m7w0JX
         Ale0V5GWSFH6+4MsY1g604IDVUkE9IgHY50Z/hXv+aMgwoGKYMumhDFAeuP+yltZefvK
         tRfg==
X-Forwarded-Encrypted: i=1; AJvYcCWonyad+42AnhYWndeeNrsEa7XAZMgOxgpJHcdrrTheeKCtRYmGFeeaKFSrWDn8zTKcMaFt+qzGyEjKWPhxsWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFoHkThk+cNgqysE/I+YVVXIljRl3T4WFJTaf5GKlKCpexxMKD
	N0jHmoXdOB00BHJuPer/YqTDst6HMbzXC/rSwQnDJywxRqIvVq18egeDGNCVTBIwSo3E2PMncDd
	lHEve9b8dXcfqWm8379vqsCTit7tYO1/pS1bGJOm2
X-Gm-Gg: ASbGncuHzqM6YnPAUb5CS85HVKI++KVYkhdF9zzKNkBT1SK76Ipc9AtsUFtRxjSwr0p
	JeqC4zYmz59uGqnQfSXV090cGdaFai8EeqQ4Q6N3fY4FhtvM9DUrPi0mDF08WPEKREV0H5NJoFD
	OsmIfhMzd621YpDp4/8TxtYYoFWhpjhd0fqhZ3AizuGyuLrx+4QHsoDURxMiAMsCqtdCiSRDWt2
	jiw/zeblZs+N9f5Uc6m2ui1AB8frVJlKh70mrwVsGyH/D56Z71i5es=
X-Google-Smtp-Source: AGHT+IFeMeqAy+cuIfy8BDPUr07CVnLWSx0isY1COTxmQUhbfeHhUc/gJKs+z9vTXpQo6NDvDMpWAnnnlJDkjgySN7E=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-2680120ed16mr333025ad.3.1758046996934; Tue, 16 Sep 2025
 11:23:16 -0700 (PDT)
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
 <20250916134833.281e7f8b@gandalf.local.home> <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
 <20250916140245.5894a2aa@gandalf.local.home>
In-Reply-To: <20250916140245.5894a2aa@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 11:23:03 -0700
X-Gm-Features: AS18NWDeydKXZzxWqGElteJppqO6QozHlpb4s_Ylp5BcEhKGMmDvVoyYUojBOGg
Message-ID: <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 10:57:43 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > > BTW, why the hash of the mm pointer and not the pointer itself? We sa=
ve
> > > pointers in lots of places, and if it is the pointer, you could use a=
n
> > > eprobe to attache to the trace event to dereference its fields.
> >
> > In Android we try to avoid exposing raw kernel pointers to userspace
> > for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
> > immediately after symbols are resolved for necessary telemetry tooling
> > during early boot. I believe this is also why rss_stat uses the hash
> > and not the raw pointer.
>
> When it comes to tracing, you already lost. If it goes into the ring buff=
er
> it's a raw pointer. BPF doesn't use the output of the trace event, so you
> are exposing nothing from that. It uses the proto directly.

My understanding is that the BPF tracepoint type uses the trace event
fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
access to the proto arguments. Please CMIW: Isn't what we'd be adding
to the trace buffer is the hashed mm_id value?

>
> Heck, if you enable function tracing, you are exposing every function
> address it traces via the raw data output.

Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
Android production kernels.

Thanks,
Kalesh

>
> -- Steve

