Return-Path: <linux-kselftest+bounces-39341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA48B2CFFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 01:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26AF188324A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA5235BE8;
	Tue, 19 Aug 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSWOULh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD121930B;
	Tue, 19 Aug 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646275; cv=none; b=isx/RAvuzL2iyNwBb34/ve3OLAJfsrqT9cM/jTIhEGZnLGQmGnI9fTUpVn4Hsm7jAclrNIcQaiiIliOuXVcDBUrGgqQ7HXO+Btg68R0eXL89/ECgCe//IXeZFjrsk2TQGKX4Es01FDRBbVnUKwXsblOtM6dIGwmkP7vLL8KUhts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646275; c=relaxed/simple;
	bh=olEIBar2AHZQAv930f/w6UuQzWq5pErYyOO5+6mGF3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezbzh1p5JFzNTAx5zqT7i8gb8nDM8bwSQxePT6NardWeDzqOzvT3hHYlRLmhP9COjm7rdvNLzdZ3V7u8bXNXIvJpJQFvj7ESI+Z90XDMqdpO7UqbFKx5w5FoC9GxG7rMklO2UkiN0WHVq8kd3vNkSYIJ7x1xsTtwLivmGqLh+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSWOULh1; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e93cc7c64faso2862210276.0;
        Tue, 19 Aug 2025 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755646272; x=1756251072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XSS9ctI5ngSn1Mg7h2LEYJHOdO5w/OJYjQrRRXgmRQ=;
        b=aSWOULh1FNCg6mHAQhKRYZU4TffyJk6MzlNMf3STkYqUt0nDy6Xm/CN5HpYlDxUXBL
         dALwIUqMowqMcCLXzPrI6o4BxePVdKwoLicdl0A+ckAVP6xC8wvLQq+aCvc3xVzu61CI
         +/C7FDX6XKv1W2bpV/n99OjNTFyUk5CPzMUAwA08AbhT5OD2dqaHNU74U2WMDCaR+VMv
         +Y92wx9BmHWcbBoEOkoXc4nUIkJv9Qa3hpSHTT/8TUN3A2pttG7U+u0PdBqhll4j7s9a
         N+vifrweHWZw4FBFRDtuM3AjKwG/JZD3m6IQNLIdg7cPBy05fgzywux89lSoyR9KiTlU
         KxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646272; x=1756251072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XSS9ctI5ngSn1Mg7h2LEYJHOdO5w/OJYjQrRRXgmRQ=;
        b=qtkMaXelSkL2p9oRpFx63gymLuJVtKdvXWiWqCHA/TsQ93oC++g2bAsBgtHBJ2kyAy
         6qTCjMSjo46yvXKMCz6qmphawYHVAQPMD0nBhHKdHUdvhNgcpFmVpIcfWFMi022wisiA
         2GQujnFvOWENYtznvC1YWuF8XB8Fs8AoEf4Ojsev6MGAlqZEXcCWvVn3KLakdlLIeTGg
         +qEC2VGQqeXMiL/lCKSFbIDH+pmDcyr6GsBm+AsNiRGB+GkINoAkfKIieuoG6/7ygLZ5
         KwaffP96hNN/y6U+FaKO45HZEkK0qGQz+HSLnNss/18GBLtzWGk2MNt5caQABVZFJZwB
         E27w==
X-Forwarded-Encrypted: i=1; AJvYcCWPDUWV2Gdw1QcmyRJ7CKDd5Lr2WjJNM4DowlMlgZz5N7tV3X4ylf20A++/k7IPrPUMixSPtkMhOg==@vger.kernel.org, AJvYcCWUyiW7vR3gF1ZgyO0V0rYaXbvR+aJUZ2BMJY/Mo24QXLhGn/pahYxTzs1fk0tixh+2NvbtAa4KLMFmvdj1ZyI5@vger.kernel.org, AJvYcCWa8feYIZdBDHLt+fU19eXhiMo48BRHW/BHBWaaTJAPd88qkwzaq6c+3QTsZK5IhGCZyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyquakHUMY8tk9yIwkofun57zVD0Twv5VgduLQAYf9EgGF08aZP
	Beg41LKCazCF09WiQLg66FgapOKOhiKKOScp6djm6tR5bE7PVreYbNDX
X-Gm-Gg: ASbGncv2cmhoCw/nnSEpzuHq0GbqxAHr0WNlVs9I917mGISg4VcfUVT8PoDzhqI9XgJ
	gqMdcfCB4db0dYSlo9YXXt8sfhlOslgU1VFmei+Yu+JfIfQCSD1MovLa1+hOwbWquioeUyLCFQJ
	DDNReUqEhXnCS/eMe3MX/+4vIOW9OTXwzxLwtf/iOKhdZMMC/ma7SFmQJGwGZLuCahND6IzBUov
	LFQ6e5VKBh7mhR8ILOBIMYvdzMNi8cmpp99yNN1N7tumQwNMK4db9ZpjuYBNEPrVJa2dwnaKIh8
	tlC6FH4MX3fnhXb5a6KyP2EPGYhQR+q8dpZ53+BOCav7rlrRR3H7qc/TqdMyy2PtbHQMRZ0jo/x
	neXVsINvuPb7+v00=
X-Google-Smtp-Source: AGHT+IFd7TaTdh+zc3Y0j89FQF10d5FiIG6hZEla4KX+IeKfY1Q5rY2l4nuOrrIaeptzS0wwjrxc7w==
X-Received: by 2002:a05:6902:2e10:b0:e90:44a9:61bc with SMTP id 3f1490d57ef6-e94f65de2bcmr1210965276.4.1755646272430;
        Tue, 19 Aug 2025 16:31:12 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.98.163])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94da284767sm1820841276.5.2025.08.19.16.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 16:31:11 -0700 (PDT)
Message-ID: <7d8af2a3-0649-44fa-abc5-17f2911b941b@gmail.com>
Date: Wed, 20 Aug 2025 00:31:01 +0100
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
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <aKNjkp5vR2ES-2Xw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 18:32, Tejun Heo wrote:
> On Mon, Aug 18, 2025 at 10:04:21AM +0100, Djalal Harouni wrote:
>> This patch series add support to write cgroup interfaces from BPF.
>>
>> It is useful to freeze a cgroup hierarchy on suspicious activity for
>> a more thorough analysis before killing it. Planned users of this
>> feature are: systemd and BPF tools where the cgroup hierarchy could
>> be a system service, user session, k8s pod or a container.
>>
>> The writing happens via kernfs nodes and the cgroup must be on the
>> default hierarchy. It implements the requests and feedback from v1 [1]
>> where now we use a unified path for cgroup user space and BPF writing.
>>
>> So I want to validate that this is the right approach first.
> 
> I don't see any reason to object to the feature but the way it's constructed
> seems rather odd to me. If it's going to need per-feature code, might as
> well bypass the write part and implement a simpler interface - ie.
> bpf_cgroup_freeze().

Approach 1:
First RFC months ago was something like that "bpf_task_freeze_cgroup" 
[1], can make it bpf_cgroup_freeze() as a proper kfunc, so resurrect 
approach 1?

Internally it used an ugly path to workaround kernfs active reference 
since we don't hold a kernfs_open_file coming from userspace
kernfs->write path.

I can improve it, but let's discuss please approach (2) since you
suggested it ;-)

Approach 2:
Per the old suggestions from you and Alexei [2] [3] you wanted something
like:

   s32 bpf_kernfs_knob_write(struct kernfs_node *dir,
                             const char *knob, char *buf);

I didn't make it generic for kernfs, since don't know yet about sysfs 
use cases and named it "bpf_cgroup_write_interface" to focus on cgroup 
base interfaces.
Doing something that generic now including sysfs without a proper valid 
use cases seems a bit too much. Also we have some cgroup kfunc to 
acquire and release that integrate well, so I kept it focused.

Alexei suggested to refactor the cgroup_base_file[] [4][5] to take 
"kernfs_node" as argument instead of "kernfs_open_file", which will open 
other possibilities for BPF.

However, instead of going full change on cgroup_base_files[], I added a 
minimalist: cgroup_kn_cftype kn_cfts[] that for now hold only 
"cgroup.freeze".

I see three possibilities here:

A. Minimal change with approach presented here:
    add dedicated array cgroup_kn_cftype kn_cfts[] with only
    "cgroup.freeze" and later try to unify it inside cgroup_base_file[].
B. Add "->bpf_write()" handler to cgroup_base_file[] and start only with
    "cgroup.freeze".
C. Refactor all cgroup_base_file[] to take a kernfs_node directly
    instead of kernfs_open_file as suggested.

I took (C) the simple one since I wanted to do cgroup freeze first. You
also suggested maybe in future "cgroup.kill" well if we have it, we 
definitely will start using it. Not sure if we are allowed to BPF sleep 
that path, however we can also start doing "cgroup.freeze" from BPF and 
kill from user space as a first step. But we definitly want more BPF 
operations on cgroup interfaces, I can think of a companion cgroup where 
we migrate tasks there on specific signals...

So more or less current proposed approach (2) followed the suggestions, 
but focused only on writing cgroup kernfs knobs.

Thoughts, did I miss something?


> Otherwise, can't it actually write to kernfs files so
> that we don't need to add code per enabled feature?

I'm not sure how we would write to kernfs files? As pointed by Alexei 
[6] it is more involved if we want to open files...

About "that we don't need to add code per enabled feature?" well if we
go the path of "bpf_cgroup_write_interface" or "bpf_cgroup_write_knob" 
adding a new write interface will involve theoretically:

1. Check if program can sleep or/and the calling context.
2. Add the new "cgroup.x" either in cgroup_base_file[] or in the new
    array.
3. New handlers or refactor old ones to take a "kernfs_node" instead of
    "kernfs_open_file".

Compared to having multiple bpf_cgroup_(freeze|kill|...) kfunc seems 
fair too, and not that much code from BPF part.


BTW current patches contain a bug, after testing. In normal writes from 
user context we break kernfs active protection to avoid nesting cgroup 
locking under.
Forget this part. In next series since we don't grab the kernfs_node 
active protection like userspace kernfs_write, then no need to break 
it... will add a parameter to check like the revalidate one that checks 
things is cgroup on dfl and not root, things that are automatically 
handled from normal userspace ->write.


Thank you!


[1] https://lore.kernel.org/bpf/20240327225334.58474-3-tixxdz@gmail.com/
[2] https://lore.kernel.org/bpf/ZgXMww9kJiKi4Vmd@slm.duckdns.org/
[3] https://lore.kernel.org/bpf/Zgc1BZnYCS9OSSTw@slm.duckdns.org/
[4] 
https://lore.kernel.org/bpf/CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com/
[5] 
https://lore.kernel.org/bpf/CAADnVQ+WmaPG1WOaSDbjxNPVzVape_JfG_CNSRy188ni076Mog@mail.gmail.com/
[6] 
https://lore.kernel.org/bpf/CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com/


> Thanks.
> 


