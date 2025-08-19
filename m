Return-Path: <linux-kselftest+bounces-39342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDCB2D019
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8351C28A31
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9D1274B59;
	Tue, 19 Aug 2025 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRg6aPxm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B677272E5D;
	Tue, 19 Aug 2025 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646614; cv=none; b=fzGBShDFPT3acaWhoToljb7CQkKeAa9GlhurICZPImvBKPDZjLp3KX7kfc8DuszOiFijhdP7Ec2lHYX6Gv6QaAp+5gX2yQVq2z+1gpyk4Rx2CB3WZVBQCluIO5G+UKcdy2PYZ0AjmsKuB2uGZCI11Z/x34jf5B0W6oNI/+Q3Khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646614; c=relaxed/simple;
	bh=TOKfweEnWpkVJmFNJAeDovBTkeClQOyKd5jxh5SYCno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lKOm938YwrrskXjUCmdLIhhfexEbBfIwsxSGkzKW2eWUU3SaPBEVfMtP/948gmL23L9MaHO686o8xVCZ/hDNUi1IXM2SeiqYkVg/Dn0n4mq+KhEBDauwTGz+/xMO9+m6FUAejbxYw3s4bXObN+OW6aKW5eQQ7DcsOf1zKQMNtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRg6aPxm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e93cc7c64faso2865737276.0;
        Tue, 19 Aug 2025 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755646612; x=1756251412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WNV2bkDK4cOMyNuox6oERMn9oKu1yr4PecuPjiBUNcg=;
        b=nRg6aPxmxtR1rRN+iQhb2j5CI6C+J4lXzGPzQ6AShWFbvPILXckVKjbA7satYatHus
         17M+jPiugVRx3B2ru060G46bgvvELQv3SMJPJq/aw3vlGNg4ZwFQtQl3wIGz599hY1vW
         A4jlh7NvRrVTtcnRpGRoBsmnYI6/h9KWMMjL+rqo+16ij1Z8TbfpsrOOavKarjFI1Dg2
         jQ0eSKg5W2hJVpBpe1/H48db+Z/Gn2VX2lyNPDoxyGNNjp5HlKpubrvo85WNEkC5Qh67
         JSAbHN2WNjpnf7JSe8r2SPBP+GlAi6V80ocygnZ7eexnocOgTG4ZCYSFkJZfKMzqXPUi
         PuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646612; x=1756251412;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNV2bkDK4cOMyNuox6oERMn9oKu1yr4PecuPjiBUNcg=;
        b=SmUkSrA0ur/ic8j87F6g64KGF5qBgWSXgx929tQKKfdz7YKChh8xeVb1dEv5k7VqQX
         XZsGudecDPL49KoFDl6l6TMQXVSrITO5YmkR/T/I+rV3HTvQTeh4UCNpz8IqY+yGBEC7
         9yjV/Mpb2ky8/6qog5Vg1BpvEDdw8tgWHw5Cc+tv9ovzxOXGIadDWG7cjJ7aZKPlB28R
         paB+g+2qFCc1qAelXz/0dciOnd1C2ptwWiMoOtRr3XAK+rcZ+qp6rqfu+sFtI7ceK+SC
         6f2LFd/agkbS3G1jJnuTxZoRIaoITzk0ryjswGCyAHGF9qDRFNfCLAlNx0QwF6tx7Dgi
         xM0A==
X-Forwarded-Encrypted: i=1; AJvYcCUTOESscebpWA/AKcvt0J5SpICZ5NW7qY2GbnYkftfQKIXG/NlZ0GPagnb+5FRfr5eOhU+LfEWbMBHdObSOU+cQ@vger.kernel.org, AJvYcCWYMp2CY1V/8Ma/P88BMYOXkg23NBdh0F/daIUx9ot3WaUpnLmInmZL8l/Lq4/RAkqM05Q=@vger.kernel.org, AJvYcCXReMAeAVFxK2sZn7vq3mT/HkJ3zDCQPBqvnwqMNPyPWNzdLB7ViYCY1ZYX9oAoqwtzMf14vScrDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKmz3x/in+T6zxE44QwhMBF8bviNXWHvdoF9taTMF9HxYT/K0
	f1CvObmP0ttNaiH2+8v7AyfsOSr/a7VDajn5m8t5dOfHumGSDK8S6/Xo
X-Gm-Gg: ASbGncvoGVexI9kuSH0bBN8OZGmlv4DUpD10zCITuaWGOWehGXiLk5t5ve8ZnCKghjm
	KPR36EM6t+T2ZwhxzZIMwsoVaI1KgU4IKFpb7CLAZN+vtk/92mHmEUxJbStyYVt1+VmxaymUArt
	DRt1xd3pM18MWo/Nx8fIKZAdsWQrT9eynp1x1xCZDjFGxlZ/Yj5CPhZmSxRJgPjRCZEhOC94pen
	0x6Y6BYR//ik95wEZcChBJheoMyC8vHM8nkWo9UrG4NkrMTI+VI4F/quXC2tTMeX15yfXmpusaG
	RWYCZCUezXgSh04LozaMHf6ojiy/C8VCe6Yenwq7sF71/GQfoaebi0IHoZFg9VnHRjHEiEzQ4rz
	78IHAIlwOKIsh4FLsgR7+qK+Gug==
X-Google-Smtp-Source: AGHT+IF6lZtlhl1QkoIDE6+xs9E9YD+D8JgA6z+WnbAxrlK0EB1x+1ummXmNeEQPJTdFKuO5R0MuBA==
X-Received: by 2002:a05:690c:dcf:b0:71f:938f:b133 with SMTP id 00721157ae682-71fb320f136mr14383387b3.30.1755646612066;
        Tue, 19 Aug 2025 16:36:52 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.98.163])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0aa17csm32657467b3.57.2025.08.19.16.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 16:36:51 -0700 (PDT)
Message-ID: <e6fe1ae5-668b-4ea1-835b-443af1d94482@gmail.com>
Date: Wed, 20 Aug 2025 00:36:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 bpf-next 0/3] bpf: cgroup: support writing and
 freezing cgroups from BPF
From: Djalal Harouni <tixxdz@gmail.com>
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
Content-Language: en-US
In-Reply-To: <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/25 00:31, Djalal Harouni wrote:
> On 8/18/25 18:32, Tejun Heo wrote:
>> On Mon, Aug 18, 2025 at 10:04:21AM +0100, Djalal Harouni wrote:
>>> This patch series add support to write cgroup interfaces from BPF.
>>>
>>> It is useful to freeze a cgroup hierarchy on suspicious activity for
>>> a more thorough analysis before killing it. Planned users of this
>>> feature are: systemd and BPF tools where the cgroup hierarchy could
>>> be a system service, user session, k8s pod or a container.
>>>
>>> The writing happens via kernfs nodes and the cgroup must be on the
>>> default hierarchy. It implements the requests and feedback from v1 [1]
>>> where now we use a unified path for cgroup user space and BPF writing.
>>>
>>> So I want to validate that this is the right approach first.
>>
>> I don't see any reason to object to the feature but the way it's 
>> constructed
>> seems rather odd to me. If it's going to need per-feature code, might as
>> well bypass the write part and implement a simpler interface - ie.
>> bpf_cgroup_freeze().
> 
> Approach 1:
> First RFC months ago was something like that 
> "bpf_task_freeze_cgroup" [1], can make it bpf_cgroup_freeze() as a 
> proper kfunc, so resurrect approach 1?
> 
> Internally it used an ugly path to workaround kernfs active reference 
> since we don't hold a kernfs_open_file coming from userspace
> kernfs->write path.
> 
> I can improve it, but let's discuss please approach (2) since you
> suggested it ;-)
> 
> Approach 2:
> Per the old suggestions from you and Alexei [2] [3] you wanted something
> like:
> 
>    s32 bpf_kernfs_knob_write(struct kernfs_node *dir,
>                              const char *knob, char *buf);
> 
> I didn't make it generic for kernfs, since don't know yet about sysfs 
> use cases and named it "bpf_cgroup_write_interface" to focus on cgroup 
> base interfaces.
> Doing something that generic now including sysfs without a proper valid 
> use cases seems a bit too much. Also we have some cgroup kfunc to 
> acquire and release that integrate well, so I kept it focused.
> 
> Alexei suggested to refactor the cgroup_base_file[] [4][5] to take 
> "kernfs_node" as argument instead of "kernfs_open_file", which will open 
> other possibilities for BPF.
> 
> However, instead of going full change on cgroup_base_files[], I added a 
> minimalist: cgroup_kn_cftype kn_cfts[] that for now hold only 
> "cgroup.freeze".
> 
> I see three possibilities here:
> 
> A. Minimal change with approach presented here:
>     add dedicated array cgroup_kn_cftype kn_cfts[] with only
>     "cgroup.freeze" and later try to unify it inside cgroup_base_file[].
> B. Add "->bpf_write()" handler to cgroup_base_file[] and start only with
>     "cgroup.freeze".
> C. Refactor all cgroup_base_file[] to take a kernfs_node directly
>     instead of kernfs_open_file as suggested.
> 
> I took (C) the simple one since I wanted to do cgroup freeze first. You

Sorry here I meant (A).

Thanks.


> also suggested maybe in future "cgroup.kill" well if we have it, we 
> definitely will start using it. Not sure if we are allowed to BPF sleep 
> that path, however we can also start doing "cgroup.freeze" from BPF and 
> kill from user space as a first step. But we definitly want more BPF 
> operations on cgroup interfaces, I can think of a companion cgroup where 
> we migrate tasks there on specific signals...
> 
> So more or less current proposed approach (2) followed the suggestions, 
> but focused only on writing cgroup kernfs knobs.
> 
> Thoughts, did I miss something?
> 
> 
>> Otherwise, can't it actually write to kernfs files so
>> that we don't need to add code per enabled feature?
> 
> I'm not sure how we would write to kernfs files? As pointed by Alexei 
> [6] it is more involved if we want to open files...
> 
> About "that we don't need to add code per enabled feature?" well if we
> go the path of "bpf_cgroup_write_interface" or "bpf_cgroup_write_knob" 
> adding a new write interface will involve theoretically:
> 
> 1. Check if program can sleep or/and the calling context.
> 2. Add the new "cgroup.x" either in cgroup_base_file[] or in the new
>     array.
> 3. New handlers or refactor old ones to take a "kernfs_node" instead of
>     "kernfs_open_file".
> 
> Compared to having multiple bpf_cgroup_(freeze|kill|...) kfunc seems 
> fair too, and not that much code from BPF part.
> 
> 
> BTW current patches contain a bug, after testing. In normal writes from 
> user context we break kernfs active protection to avoid nesting cgroup 
> locking under.
> Forget this part. In next series since we don't grab the kernfs_node 
> active protection like userspace kernfs_write, then no need to break 
> it... will add a parameter to check like the revalidate one that checks 
> things is cgroup on dfl and not root, things that are automatically 
> handled from normal userspace ->write.
> 
> 
> Thank you!
> 
> 
> [1] https://lore.kernel.org/bpf/20240327225334.58474-3-tixxdz@gmail.com/
> [2] https://lore.kernel.org/bpf/ZgXMww9kJiKi4Vmd@slm.duckdns.org/
> [3] https://lore.kernel.org/bpf/Zgc1BZnYCS9OSSTw@slm.duckdns.org/
> [4] https://lore.kernel.org/bpf/ 
> CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com/
> [5] https://lore.kernel.org/bpf/ 
> CAADnVQ+WmaPG1WOaSDbjxNPVzVape_JfG_CNSRy188ni076Mog@mail.gmail.com/
> [6] https://lore.kernel.org/bpf/CAADnVQLhWDcX-7XCdo- 
> W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com/
> 
> 
>> Thanks.
>>
> 


