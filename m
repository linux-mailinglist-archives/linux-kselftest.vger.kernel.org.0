Return-Path: <linux-kselftest+bounces-40499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61798B3EEFB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E27F4E06EE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE96258EDF;
	Mon,  1 Sep 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc9GWhx4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE120296C;
	Mon,  1 Sep 2025 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756423; cv=none; b=ld8dILSqD+ZaXoIX5xvqq/j/MgSi9SGAq/VxbfxRQRO8qBklXSPS+DPKgnv5/OwYuvl+b42lxt0bQHfwjLGQoM0hbHsd0TCGOvCqthBRgzObsxo1PgL3SW9L/C52Hn7XDQ46MGMmSbVqWomS6iTUZVjblM8fDI5VTimSKfAAuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756423; c=relaxed/simple;
	bh=BqfrjMPuGiaKQBMWPv9o8TEs9m15Yj2+7KdBDuWr2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUPqQPAArboK1289Mh/j8BumQ2Ceqbtys65dM++0PTW5iTOagc6vuyb3YeCNPER3pOD0ncoB6BmCbZ4lwSUSeyORI/R5e42y1phRaus9urRgWVI9eoPKutHojlvhGn1TvYnCvfBWqsmGRX60nXglHSQYnjwzlK2q3JYVm7F39ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc9GWhx4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso15471975e9.3;
        Mon, 01 Sep 2025 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756756420; x=1757361220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6dC2QIlPVYDynwThj1XsMObK2EBHiK+oeTA9R38dbg=;
        b=Zc9GWhx4gfrsrrDepQ6gSrVgvSCoc9oMlcnWqx7Go5tfHCKBLiplt7aLmHxf+aHJNE
         tV+6iRo9FpvhzdO2XZ9b9N4gqxc5leNxSi2efLcomcJJBIU6YienVbAkYD0UxiFJxeaf
         rhyd859RTkWIprgpYo2bCoVOsPyyGrkfA/FW8X75PqK9Mpej2n64fI7+cnvnisfLTsN3
         tCMexANo2ya38VlZ1sR2WiGrzNOL/TmOqR+5euCpL6SnuO0Xm2F9JxiA7h64NwRkwwxc
         t1eIpPw4DlrbjyDsBHU7jqs2abHClgMsKuYzUEUywqhwxeIh+bmGl6fpVHOHHkPlwSBT
         CVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756756420; x=1757361220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6dC2QIlPVYDynwThj1XsMObK2EBHiK+oeTA9R38dbg=;
        b=l2j43ZWalVLAfDrC59scx74PPj8pfEl84G0mHLNQfC0DBxMriioJtBVOUPpNzQUsr2
         ovCC4OyxXtwhjafZrvFpsLAQqRTcA7QNr6yRYthjhTCLMeKodRP2zrP3llBBc1NiAAZM
         H2fCsqvi3lpoeua9qDM2E8gP/EAOi6AjyhRXX84cdIp853GW8+1U6imiPf7bLezwdPfS
         wKeXA3q9EmCavzyMW+0xlnFCejMgIskyyOll38SrLJByWw4mMEtQ/JNbXjEIsP66hfzT
         hOw7HaMWoketFzTqZ9ssbyrDYMPhJzM8h0jVAcQfyIcwfRFNxwWKBHquafGIVJQnKPy6
         JQfA==
X-Forwarded-Encrypted: i=1; AJvYcCU6iaOPLR4I4pNIUgtd5wMpVcS0CHCkVcVGnxV/pjbSB8/pyVtOm5yiIF47V15sOqsppojBXDT3AA==@vger.kernel.org, AJvYcCVLOXRWlG9iG4pVwz3Tyb0KxX3m961BUqySGZ6x4mD6fLLaR4MBIHtAOVir1JXM/+fJItM=@vger.kernel.org, AJvYcCXl8Be3O0Xv4y2OyJ7GyQtcD80wPq/pyCSm8QIWP6coVRg71+FRgH+OhADhLluSYGC6q9Fpmi5XS1CWxyQRZpp7@vger.kernel.org
X-Gm-Message-State: AOJu0YynpKQj+QHxR5jEXGHIKiQqbBJg9/KilIaetwESJ4hHJEyoTrnd
	mE0cSY5uncGUoiXy5GCEHrVu5laf2iFslQc6dpydi917m8jjzLhTkKHp
X-Gm-Gg: ASbGncuSIUOwPIpM7RlHJN72tkCimwtngkANAuwhyZbnQxaEg9OapntDcMyEQeByKcR
	OfRj/YPyGTEg9QB5xyPG4p2tvaDUaOWSsBotiEMN65xR7AZ74w7R2f6kMQrVtJcAMhOefs4tThT
	cOcKJx3Txiw9xyGFxbP6XseSUwc4+W4Th8tNIYYvfuEAxxCzaJZ6P86wIEq2EXTK+7q7wQ8tUc5
	Ph6wsb5VFGclhNNqrKB4gerqi4SSN/khw/tVeRgOezZ4M2vzwBmcv1crx0JNWiKF2LPM1bDpEOi
	bqBmAJP9Njo1nIuBgRYiyOlnstqmESDaCjVlBtBsh6BYQKUiwz4yyrsOu7GxAObfAlnJGpBSh+W
	5GEeTa37qamQMI6q097r4Z4hb
X-Google-Smtp-Source: AGHT+IFqmqy7JTqCE8kp/izmK35smwPEY9oWGFGG/gnBIrSVmpVJnbVt7jfeeObUA4ZRq4rWsdC6CA==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-45b855bec6emr71221655e9.35.1756756419930;
        Mon, 01 Sep 2025 12:53:39 -0700 (PDT)
Received: from [192.168.100.3] ([105.109.196.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34493b8csm16184910f8f.59.2025.09.01.12.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 12:53:39 -0700 (PDT)
Message-ID: <28cbe760-e218-4f2e-a18a-651e2477ebfe@gmail.com>
Date: Mon, 1 Sep 2025 20:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tixxdz@opendz.org
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <356xekrj6vqsmtcvbd3rnh7vg6ey7l6sd6f4v3dv4jxidxfd6m@cepwozvwucda>
 <0e78be6f-ef48-4fcc-b0c7-48bc14fdfc7f@gmail.com>
 <m7laj6747wtu5r732iph47zn6no3mbu6iq3mne3zslzyqlq523@7tmw25ap77ek>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <m7laj6747wtu5r732iph47zn6no3mbu6iq3mne3zslzyqlq523@7tmw25ap77ek>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michal,

On 8/28/25 15:38, Michal Koutný wrote:
> On Wed, Aug 27, 2025 at 12:27:08AM +0100, Djalal Harouni <tixxdz@gmail.com> wrote:
>> It solves the case perfectly, you detect something you fail the
>> security hook return -EPERM and optionally freeze the cgroup,
>> snapshot the runtime state.
> 
> So -EPERM is the right way to cut off such tasks.
> 

Indeed. A process can retry x y z paths, at some point we just
want to stop the process or container before snapshot.

>> Oh I thought the attached example is an obvious one, customers want to
>> restrict bpf() usage per cgroup specific container/pod, so when
>> we detect bpf() that's not per allowed cgroup we fail it and freeze
>> it.
>>
>> Take this and build on top, detect bash/shell exec or any other new
>> dropped binaries, fail and freeze the exec early at linux_bprm object
>> checks.
> 
> Or if you want to do some followup analysis, the process can be killed
> and coredump'd (at least seccomp allows this, it'd be good to have such
> a possibility with LSMs if there isn't (I'm not that familiar)).
> Freezing the groups sounds like a way to DoS the system (not only
> because of hanging the faulty process itself but possibly spreading via
> IPC dependencies to unrelated processes).

Well mis-using things is possible, but here nothing is new.

Pausing a container, freezing the cgroup, or criu have been there for
years, no new features here ;-)

> 
>>> Also why couldn't all these tools execute the cgroup actions themselves
>>> through traditional userspace API?
>>
>> - Freezing at BPF is obviously better, less race since you don't need
>>    access to the corresponding cgroup fs and namespace. Not all tools run
>>    as supervisor/container manager.
> 
> Less race or more race -- I know the race window size may vary but
> strictly speaking , there is a race or isn't (depends on having proper
> synchronization or not). (And when intentionally misbehaving processes are
> considered even tiny window is potential risk.)
> 
>> - The bpf_send_signal in some cases is not enough, what if you race with
>>    a task clone as an example? however freezing the cgroup hierarchy or
>>    the one above is a catch all...
> 
> Yeah, this might be part that I don't internalize well. If you're
> running the hook in particular task's process context, it cannot do
> clone at the same time. If they are independent tasks, there's no
> ordering, so there's always possibility of the race (so why not embrace
> it and do whatever is possible with userspace monitoring audit log or
> similar and respond based on that).

The complexity to do that from userspace for an eBPF security tool
that is not running as a supervisor in other namespaces is high.
Basically the race window is reduced... we trigger in the task context 
that we want to freeze and set the freeze jobctl bit of the other
tasks.

The extra offending syscalls by that cgroup tasks are reduced.

> 
>> The feature is supposed to be used by sleepable BPF programs, I don't
>> think we need extra checks here?
> 
> Good.
> 
>> It could be that this BPF code runs in a process that is under
>> pod-x/container-y/cgroup-z/  and maybe you want to freeze "cgroup-z"
>> or "container-y" and so on... or in case of delegated hierarchies,
>> freezing the parent is a catch all.
> 
> OK, this would be good. Could it also be pod-x/container-y/cgroup-z2?
> 

Yes, basically the cgroup of the task, or any parent by fetching its
cgroup.

BPF is already the core interface of cgroup device controller.


Thanks!

> ---
> 
> I acknowledge that sooner or later some kind of access to cgroup through
> BPF will be added, I'd prefer if it was done in a generic way (so that
> it doesn't become cgroup's problem but someone else's e.g. VFS's or
> kernfs's ;-)).
> I can even imagine some usefulness of helpers for selected specific
> cgroup (core) operations (which is the direction brought up in the other
> discussion), I just don't think it solves the problem as you present it.
> 
> HTH,
> Michal


