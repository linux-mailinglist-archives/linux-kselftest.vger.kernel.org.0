Return-Path: <linux-kselftest+bounces-7406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C089C81C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DE51C23FFE
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ACD14037F;
	Mon,  8 Apr 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibncLV5x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFE13F45E
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Apr 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589781; cv=none; b=I4RU7XaE9g9LbLBmJ4T2dlDjWP1Z/bMiPR9ZlT/pcU9+VS3FInm4XT8igci4bGObw/5lo5PVvpkmuwfriHIrrpbkt5nQUBIRktC+5wtRZopBgNl+2aBmK8aWvDOMEJAePeSgj5PtReM4EkTBfuxOnownGJ3rMHpwOgWpRMM0ib0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589781; c=relaxed/simple;
	bh=OU2tVQvyT4SRuoCW2qCM4+ovjL9o9abprj5AcavWWWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTwjJeMymNFJiiMhK2jJ213RUIy/81qg2NBtJDbXLtKJWGdxBr/uav1B8HtLqrCVzS8PxnPGfWzFY6JaGUeUSxLRGvpvvs7OId8dfBn7DH8sDgqFCVtM7CF67C178SBOe1S/3AYeSoNQTYnRHvdJd3eG3VOt4L3f6TVfGa3sUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibncLV5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712589778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNaLEe1EqaX5cisZeqS+C09rvuUmVecNNaJN/+fnKGc=;
	b=ibncLV5xqay9XjS7DvkKxu5UWg6bpwjatYfmsK1PAnNDcgYzEuvC+vZJkw0262lrBe8X8K
	mbPcTWg9apztFK8TGQd92ZYJ2iBUBd7QV6RXq/w6aQVP0KeQffl5GF9tSschbDOWdGl3zq
	elwmNEy4SrdkkOSciHzHmcf1Hr8qt2w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-aW1Gztp6PdWEx7mpy37kUg-1; Mon, 08 Apr 2024 11:22:57 -0400
X-MC-Unique: aW1Gztp6PdWEx7mpy37kUg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69942c6d975so37099986d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Apr 2024 08:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712589777; x=1713194577;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNaLEe1EqaX5cisZeqS+C09rvuUmVecNNaJN/+fnKGc=;
        b=Zr2cr0CSGXfd6F/lt7g3Gl9MBk2iqqMI8yWwIF62B+Dl6HQ/SMOp5hAHeUyhSxQUMQ
         W/tCj1Om7oTscOjEctvTcjKZQMhlIitE9U/QDxzSt/fNIAqmbQDOvm/eCgBQv85trlId
         ra5dHAya3DYt265jQlJI+/FrV4zgh9rxkh2nZ1/b75aw/IM0GOXizwqgpftZTrp7llbE
         eKK6K1wqbgNjrUcrhYxJes7ZD7Rw0NM9mlObLrOwoXvmTY9xeFQijYhKaHz42nylZl/T
         En2wfW8OFBrZfuE9Twlon3JTp2jo6P2/P2yqyUC8jcXJDAsKpqhsTQ7DE5+B/9qqU/Vr
         Wthg==
X-Forwarded-Encrypted: i=1; AJvYcCVUnkqRtlr9vhB/70yaupMbj2USanKeBD2iXayvS2IVBilDwU6bC2+LiDhfSRFjGStzbDjoJyoZbnafkDWs3TVAtJ4VI2LX/N4JbtXGlQPH
X-Gm-Message-State: AOJu0YyquI00fwS9EQtMSNpdTeJn77MXBqv66InnEAoMhCJ5Sis/0cY0
	qP32RlazBFRriQ90Sz4OJZF8YhHjWgPakevErHcqKT8h7d3h1VbyaD5LE5ktAToBcCr2fSWjeI7
	6+fJe7QJHgztmYmLcimzCmmzthKxI9Ev7RjSka7sQHMFVisu2mDTSO6MlfinjWlFmZw==
X-Received: by 2002:a05:6214:d81:b0:696:8c2f:9a12 with SMTP id e1-20020a0562140d8100b006968c2f9a12mr9180116qve.37.1712589777104;
        Mon, 08 Apr 2024 08:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSJndSw8uJPc8rgUwKsJDwcdZZq27Y+2zqtPiQYmLDnd0ZNc7Lo/hTxepEvEegZZ6PNqLwXw==
X-Received: by 2002:a05:6214:d81:b0:696:8c2f:9a12 with SMTP id e1-20020a0562140d8100b006968c2f9a12mr9180088qve.37.1712589776789;
        Mon, 08 Apr 2024 08:22:56 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ev6-20020a0562140a8600b0069aae04b06esm2277699qvb.85.2024.04.08.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:22:55 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>, Waiman
 Long <longman@redhat.com>
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
In-Reply-To: <20240404134749.2857852-2-longman@redhat.com>
References: <20240404134749.2857852-1-longman@redhat.com>
 <20240404134749.2857852-2-longman@redhat.com>
Date: Mon, 08 Apr 2024 17:22:50 +0200
Message-ID: <xhsmhr0ffang5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/04/24 09:47, Waiman Long wrote:
> Since commit 3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside
> get_online_cpus()"), cpuset hotplug was done asynchronously via a work
> function. This is to avoid recursive locking of cgroup_mutex.
>
> Since then, the cgroup locking scheme has changed quite a bit. A
> cpuset_mutex was introduced to protect cpuset specific operations.
> The cpuset_mutex is then replaced by a cpuset_rwsem. With commit
> d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock
> order"), cpu_hotplug_lock is acquired before cpuset_rwsem. Later on,
> cpuset_rwsem is reverted back to cpuset_mutex. All these locking changes
> allow the hotplug code to call into cpuset core directly.
>
> The following commits were also merged due to the asynchronous nature
> of cpuset hotplug processing.
>
>   - commit b22afcdf04c9 ("cpu/hotplug: Cure the cpusets trainwreck")
>   - commit 50e76632339d ("sched/cpuset/pm: Fix cpuset vs. suspend-resume
>     bugs")
>   - commit 28b89b9e6f7b ("cpuset: handle race between CPU hotplug and
>     cpuset_hotplug_work")
>
> Clean up all these bandages by making cpuset hotplug
> processing synchronous again with the exception that the call to
> cgroup_transfer_tasks() to transfer tasks out of an empty cgroup v1
> cpuset, if necessary, will still be done via a work function due to the
> existing cgroup_mutex -> cpu_hotplug_lock dependency. It is possible
> to reverse that dependency, but that will require updating a number of
> different cgroup controllers. This special hotplug code path should be
> rarely taken anyway.
>
> As all the cpuset states will be updated by the end of the hotplug
> operation, we can revert most the above commits except commit
> 50e76632339d ("sched/cpuset/pm: Fix cpuset vs. suspend-resume bugs")
> which is partially reverted.  Also removing some cpus_read_lock trylock
> attempts in the cpuset partition code as they are no longer necessary
> since the cpu_hotplug_lock is now held for the whole duration of the
> cpuset hotplug code path.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Tested-by: Valentin Schneider <vschneid@redhat.com>


