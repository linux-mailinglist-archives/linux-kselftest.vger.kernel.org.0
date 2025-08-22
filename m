Return-Path: <linux-kselftest+bounces-39719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C10B3222E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34E6627F2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E229A326;
	Fri, 22 Aug 2025 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBzrt0mG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661719DF62;
	Fri, 22 Aug 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886590; cv=none; b=L4Gw/n8loUgUM6s05ZJBIw4TOvgPAjL+tXsJ2pNYROlNumA0w4F+IUhDLvRzJEoPd0hfei8hswYUTqRZmp6v3XDDY1vUIVR0fzS8X19wBpoNrqshK/vBo5SRxfRzY6ZvitjvPrtxMf8wkLHsqWcYn/BbnTtqBpwlsXHtIdZNqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886590; c=relaxed/simple;
	bh=rNmZIGUw3d/g0T/ojRCxcBQg6wSQ5gZrXR4sPKYsW44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8cI2xppxXlr7avU160t6JJe/8TqwYHDoWIfdyoXSqlxpVGXuQXqANq5G8wIfg+sEpdPtRhf8i+OGoyupTbZYDHjEJCD26st4Hc6bPVrshcrhfwzf41v1RwnhyDMHN3F+E+KIj8ku9WR998zpkgeF7n20dxtQwr/QlEDcjzYMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBzrt0mG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6059fb47so20485527b3.3;
        Fri, 22 Aug 2025 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755886588; x=1756491388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP+mB0kUu4BWOljg1b24HEsIjMm1PkT0+k0ewTVHEHo=;
        b=TBzrt0mGCfn/hSfz2Owq7Qm6rn/bSXlrhXl6lyjIP7VxMxDv8jZr5ZipBDdo9MAI/H
         1TeOCUhLOT1hCFE9GssfQRnUpW/rbZ8EazObYRz41h0f8C7U5dP5EPxkdGQ3tXWR6c2k
         WXoIzbSJ6xw79l5ZVOY9xb6txbOWLWeTq81U0xt8LpEKBtxEeN7t+nH5fvL23OLwPqSI
         LYbweH3irOS6Ko0rC5hE/Bx3p3RRoKIVirHLC51SSs1kotgGr0m0mM7ISufxNSZQVAxm
         w631ct3toQsQNHDPvUSHK3zWYb0lOb3A7jEPqW1f4aReiSJ+LHTWg1jA2boGYOKXR1k9
         hCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886588; x=1756491388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kP+mB0kUu4BWOljg1b24HEsIjMm1PkT0+k0ewTVHEHo=;
        b=PKN7nUy1YpuKZQd8rWdyNXfTp3WPSxcvUvrZ0rnwHToH9hS2mT18l+YbIdMsYUtP9i
         2X0pUSnw1y2QTPXhUcEl0ECbMwUipYYpNqd8JhkEUJxlbxEfIQI7L/4lyuOD5IEmbZbA
         FMA/UgR4FkkgKLjIPWjRKPSx6G75MOlvYJfo6Y/peDyFbp74FVGHtGpuT0gUsuQiRzHl
         cNRrYzw/sWrAet2VVz0T67JnNbARdopkHAO7sCaSnP8ehHY3K4wJPlwj6jx0XIZs9l5S
         QJN7zUkckiyRxPSwbyH4mRhXre6VH35/EwbXZNJHPi9aXPwUgoSpxgihvgeS0SekuZOS
         KxoA==
X-Forwarded-Encrypted: i=1; AJvYcCWc2ImnrJkw5+Mj0vZku22wiCypJWLVf2zyKWXCOgulTwPNBdeBOZhZP2vMfQZWbkRtTXydOFH3Nw==@vger.kernel.org, AJvYcCX109qO2WQFQPvYRJN6yhtMtO2mPsMVKGg5UcYGlKuv7Sk67zp9gp5b4trZXFI+80CAp04=@vger.kernel.org, AJvYcCXdxJ36O/EoW9cfJ1kU1XysPOI1Ashw01Mi3sK3zITNTMgWiyUZh88j1MQxepDRU8dOa04HP8/1B21wWrjr3XDq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3h+CGjzr0PcitEmEikdq7omVrTXiFcE2e9O0v7ViDeC1289fj
	6HBAVtGmXjznJ2yT+EDne+3QSh5qPz+zdu2n2Ebn43vB/3pC+ERuXUv+
X-Gm-Gg: ASbGncsW9mf1zgTKFopELYahaKcNnUuL7XP33cHaFqu3IUhl5TG9HnP4c36fHdh+o3b
	bynlz1tTF/1MEHwmX/833QuupTzHKP/iq/2bx1TSYbPq7ZkUxNZH7ULVmqFH1GePipxSXPA009S
	g69mVvrEYRL5GBXqBVEdlUJSciBZ2gpKHGupC5hM8YoftziobP9JmK6aJ9RiXkmJQbgShvSq5/r
	ptd1DxxlTfbNZ7kwmAzHXNQ2KiWPBAFUCQ1fEypGfuXoqhKY4I9j4t90EA2+RYW6NMyMSKmfQYX
	ExEVp6RgztQDrKEnxbNJPhFvVzKjboiARVCO1MccHqsj2ea55kkRiUAyoXnh1ZcD4yBDIce2/m8
	Ws41cBZN7h+HZ570=
X-Google-Smtp-Source: AGHT+IEaTBi7A+NKIMwaNdZB9UQOpBKeXD0/S9R9QHha2piLvT4yL2Z3vb601hr5NQjdIRi3ZteNHQ==
X-Received: by 2002:a05:690c:6e01:b0:71f:b944:1002 with SMTP id 00721157ae682-71fdc566b69mr47638827b3.53.1755886588062;
        Fri, 22 Aug 2025 11:16:28 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.98.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18faa72sm722987b3.76.2025.08.22.11.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 11:16:27 -0700 (PDT)
Message-ID: <efa7d1ed-9cfc-4e32-936c-a2f7827da1c9@gmail.com>
Date: Fri, 22 Aug 2025 19:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tixxdz@opendz.org
References: <20250818090424.90458-1-tixxdz@gmail.com>
 <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
 <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
 <aKUhkIdCEsIqmvvV@slm.duckdns.org>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <aKUhkIdCEsIqmvvV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 02:14, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 20, 2025 at 12:31:01AM +0100, Djalal Harouni wrote:
> ...
>> Approach 1:
>> First RFC months ago was something like that "bpf_task_freeze_cgroup" [1],
>> can make it bpf_cgroup_freeze() as a proper kfunc, so resurrect approach 1?
> 
> Thanks for reminding me. I often feel like my memory is a ring buffer which
> lasts a few weeks at most.

yeh been a while...

>> Internally it used an ugly path to workaround kernfs active reference since
>> we don't hold a kernfs_open_file coming from userspace
>> kernfs->write path.
>>
>> I can improve it, but let's discuss please approach (2) since you
>> suggested it ;-)
>>
>> Approach 2:
>> Per the old suggestions from you and Alexei [2] [3] you wanted something
>> like:
>>
>>    s32 bpf_kernfs_knob_write(struct kernfs_node *dir,
>>                              const char *knob, char *buf);
>>
>> I didn't make it generic for kernfs, since don't know yet about sysfs use
>> cases and named it "bpf_cgroup_write_interface" to focus on cgroup base
>> interfaces.
>> Doing something that generic now including sysfs without a proper valid use
>> cases seems a bit too much. Also we have some cgroup kfunc to acquire and
>> release that integrate well, so I kept it focused.
>>
>> Alexei suggested to refactor the cgroup_base_file[] [4][5] to take
>> "kernfs_node" as argument instead of "kernfs_open_file", which will open
>> other possibilities for BPF.
>>
>> However, instead of going full change on cgroup_base_files[], I added a
>> minimalist: cgroup_kn_cftype kn_cfts[] that for now hold only
>> "cgroup.freeze".
> 
> I think there's some misunderstanding here. IIUC, Alexei didn't want to
> expose direct file interface because none of the necessary abstractions are
> available and the effort becomes too big and wide. However, I don't think
> the suggestion to use @kn as the path designator (or @cgroup for that
> matter) means that we want to pipe that all the way down to each op that's
> to be written to. That'd be rather pointless - why add generic interface if
> each needs a dedicated backend anyway?

I took time to check...

I thought to avoid precisely creating a kernfs_open_file, since we don't
have the corresponding context. Beside the user information who opened
the file, kernfs_open_file assumes a corresponding opened file and a
corresponding kernfs_open_node for each kernfs_node with one or more
open files.

Also it seems each kernfs_open_file is added back into
kernfs_open_node->files...

> Can't you make kernfs to create
> open_file from kn and follow the usual write path?

Seems tricky, needs to handle also kernfs_global_locks->open_file_mutex
compared with writing directly to the dedicated cgroup backend. The
only protection there beside cgroup_lock() is break kernfs active
protection so kernfs nodes can be drained later...

The cgroup_kn_lock_live() grabs a ref on the cgroup, breaks the active
protection, takes the cgroup_lock() and ensures the cgroup is not dead,
from there we don't dereference kn->  until we restore the protection.
Plus we have the kernfs_get(cgrp->kn) on cgroup_mkdir which ensures it
is always accessible.

I do realize taking the same usual path with write is the obvious thing,
but we don't have the corresponding open context, and faking it seems
more trouble than calling directly cgroup backends...

Allow me please to do it again directly on cgroup_base_file[] assuming
it was Alexei suggestion and see how it looks.

Also Tejun, could you please point me to extra cgroup or kernfs tests
you run? much appreciated!

Thanks!

> Thanks.
> 


