Return-Path: <linux-kselftest+bounces-7001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B44895ADB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499691C21E10
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F315A4BE;
	Tue,  2 Apr 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElHfBM9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449515A4A6;
	Tue,  2 Apr 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079616; cv=none; b=kJPXka3GcPtGwtoqormqQrUMWM0lEm/QFKeAmUQPOIFsGjVAuFE2H7D1rCsGTc8ftcUw6P1tSpiKpBwkTG7Q8/Swk1+lVywfgMM+qvIg6zOe44puJ4Bj/xUsZ9A3gqwdjJoIE9LwarFc+Vq0GaWZkUYL0vFE2DnGpXWZAZJkphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079616; c=relaxed/simple;
	bh=MscKq/8gkBCFgvt3n4gtlA3Tf/nCtzMAsDOYundCczc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzseVmiMD7KNagc/dANbqRWuWWuJoWfNfultX7HY1f0kJV0AKnh9bRi8WHdHDLOf2UzNtSCKkJzX/Q+++uFwklL/jzUgw/PwOllyWehPdKG0pN082RImSHHwY5tKPLihCeWzecti2vNMRAhO+u4ChdPEovBqJw3fCB6cz0afpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElHfBM9p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41569865b2fso15055135e9.3;
        Tue, 02 Apr 2024 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079613; x=1712684413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjam2eBJdJRG2fZGTFSdYNfYJSyh+oC0wKhKtBnov7o=;
        b=ElHfBM9pAu5Jf/vTqNXHMBmY9YGq9oJuU+43bJxqesXTFJYNaNzlqB0Ve7gJerYGs2
         kolOu2OtrWTWPpG4B3WJ+KE5CdS4hkAeeOAX9tu32oee4DtH7jFjNxZLxQ2xdnziSjw4
         mc2G+DNorpXPclYuP0WsO6yqQd6WLXAK41+vAIpCXa+XAt+qGBt8jrkp2+fINbXu16O2
         ZeOrsu5wRQ8Fj0whft7FatmVrKI7IuZh9frjAMhgGTluf1cR22u5Lm590XNOJcvPh06Y
         2yYw5tCUqnkWa0sLeCs86JrMrzHuQXxP+jBTW4zC/EixMdyP+k4PkhvTL5LGxT7B/JD9
         CiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079613; x=1712684413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjam2eBJdJRG2fZGTFSdYNfYJSyh+oC0wKhKtBnov7o=;
        b=fQSWeZRTMzMcWsVjXFbfoegi7JJyqvJLpxM9dT3kLdVogA/TSZpv52lB0jNgKZQitn
         5ZgnJDyyaDMhKMUjMxDfrvmRLjiJ/Eq16DkMXSle5PcxZ61h1Re1m0KvPvtBq6ci2/Bf
         0ln75ZVktrF9JfMPSbhMarCVirTctecH68qLr38ZX9cV7/OzXP1+MRKWn98s6wY4AChS
         /EQeAOYdT2KKQ6hYTrTnB5GFSzzWcfLmE24mnMfcUp2xmtfLjcyftzmS+SA0lwMUB6sl
         Sa+SNf415ENDTbXZWmRx+snPHwQLVB9yNk055lz4y5HVWjz3CID/AckirA3Hc+4hfcBQ
         0Yew==
X-Forwarded-Encrypted: i=1; AJvYcCXQNI7n5j86lCoQ/PPY9saUW1+g3+4nqTylnZAj7X2tONseNlWnfAku+0NzeghBxm7eC+bBrjq+xuHoHeeCmmMdJ9QMzFcOU4KVhmLGGEqZvUVQ1v8v1zRDAuA9YovR2EOoIL30jKhTmdn1N9BONE+Wcl1x8cOvya3dd0gnAhRv2vXASJb2BI5emG6uweD07g09fG4p5Yj353ObNA==
X-Gm-Message-State: AOJu0YygxunskVnXoXlDSuOrYR0Krao/Bwgdz7FcXc+e8n+bnETxUCDY
	qNU7lkqG9b0xLDqi/X3Cb81duGdyhkrUJBDipm3lBsIJFugUYpXW
X-Google-Smtp-Source: AGHT+IFTdYFOedAHp4Dl0n4GjWI38WqXcFhf6wugTcqAxj4SVyGxGfeaVkTopHNW6IqKHYA7IkeZ0A==
X-Received: by 2002:a05:600c:358b:b0:414:8e02:e432 with SMTP id p11-20020a05600c358b00b004148e02e432mr9530370wmq.7.1712079613095;
        Tue, 02 Apr 2024 10:40:13 -0700 (PDT)
Received: from [192.168.1.113] ([105.109.56.176])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b004156ea0faa0sm3952488wms.4.2024.04.02.10.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 10:40:12 -0700 (PDT)
Message-ID: <7f4273bd-bff9-44cc-9158-ab69d7deaa50@gmail.com>
Date: Tue, 2 Apr 2024 18:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20240327-ccb56fc7a6e80136db80876c@djalal>
 <20240327225334.58474-1-tixxdz@gmail.com> <ZgWnPZtwBYfHEFzf@slm.duckdns.org>
 <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org>
 <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
 <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
 <ZgXallkHApJC-adM@slm.duckdns.org>
 <bcb084ae-c934-4eba-aadd-95bbec2a63cb@gmail.com>
 <Zgc1BZnYCS9OSSTw@slm.duckdns.org>
 <CAADnVQ+WmaPG1WOaSDbjxNPVzVape_JfG_CNSRy188ni076Mog@mail.gmail.com>
Content-Language: en-US
From: Djalal Harouni <tixxdz@gmail.com>
In-Reply-To: <CAADnVQ+WmaPG1WOaSDbjxNPVzVape_JfG_CNSRy188ni076Mog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 3/30/24 00:04, Alexei Starovoitov wrote:
> On Fri, Mar 29, 2024 at 2:39 PM Tejun Heo <tj@kernel.org> wrote:
>>
>> Hello,
>>
>> On Fri, Mar 29, 2024 at 02:22:28PM +0100, Djalal Harouni wrote:
>>> It would be easy at least for me if I just start with cgroupv2 and
>>> ensure that it has same available filenames as if we go through kernfs.
>>> Not a root cgroup node and maybe only freeze and kill for now that are
>>> part of cgroup_base_files.
>>>
>>> So if I get it right, somehow like what I did but we endup with:
>>>
>>> In bpf, cgroup was already acquired.
>>>
>>> bpf_cgroup_knob_write(cgroup, "freeze", buf)
>>> |_ parse params -> lock cgroup_mutex -> cgroup_freeze() -> unlock
>>>
>>>
>>> cgroup_freeze_write(struct kernfs_open_file *of, char *buf,...)
>>> |_ parse params -> cgroup_ref++ -> krnfs_active_ref--  ->
>>>      -> lock cgroup_mutex -> cgroup_freeze() -> unlock + krnfs++ ...
>>>
>>> Please let me know if I missed something.
>>
>> I've thought about it a bit and I wonder whether a better way to do this is
>> implementing this at the kernfs layer. Something like (hopefully with a
>> better name):
>>
>>  s32 bpf_kernfs_knob_write(struct kernfs_node *dir, const char *knob, char *buf);
>>
>> So, about the same, but takes kernfs_node directory instead of cgroup. This
>> would make the interface useful for accessing sysfs knobs too which use
>> similar conventions. For cgroup, @dir is just cgrp->kn and for sysfs it'd be
>> kobj->sd. This way we can avoid the internal object -> path -> internal
>> object ping-poinging while keeping the interface a lot more generic. What do
>> you think?
> 
> And helpers like cgroup_freeze_write() will be refactored
> to take kernfs_node directly instead of kernfs_open_file?
> Makes sense to me.
> Sounds like a minimal amount of changes and flexible enough.

Thank you Alexei, Tejun for the feedback. Will try to get back with a v2.

One particular thing is the kernfs_open_file->mutex nests outside of the
refcounting of kernfs_node,  let's see.

Thanks!

