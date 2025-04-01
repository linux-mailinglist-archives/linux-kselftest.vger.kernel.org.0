Return-Path: <linux-kselftest+bounces-30000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F5A78364
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125D6166211
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D020FA97;
	Tue,  1 Apr 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lsu7KDG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C13594F
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540121; cv=none; b=R9jpRxex6beSTYj1vZBgh0jszXKo1pzPdO5knsrHXbxZyItvrJiGDY9DRGU+z4syULwbq/CaqHmB9YReoFDM6+OsbaRHdPXj6+pwVnpn6Q50KObRHH1SKebmH/dBYgoOP4mwRvt8EKqGxHODGKfFQhXnvMiGIRpfu5ARB8Q2jZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540121; c=relaxed/simple;
	bh=DQqNytcES03RM+rHoX7X/MIHXjVFtwm514rcdrui4L4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JAATqfvQhmQ6Tn58rhX4uVA7aXJxDgwq6cDkPYkKpsUan3dgz1MHuaQpcEqQpHzw+pMCBZpfaemdeq5tp6QFAGgTGpXEGmQ1m6jOU7QmtiLSjWiqOKiv0ME8DgXMQOGdSS0OZ7skYwHCrTi/DZqzyOD8fo4baSnQIFQUAMh2490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lsu7KDG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743540119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Owge253k5OvzgMZCm8XexlvQc59vpIkP2hnOZmugbZE=;
	b=Lsu7KDG0vojX0X6JvuUL++YH87iEifs40pVXgX7Woh+2NKKWVolgam0i1tn0aT3uOolsZ9
	wai9cipoubhL2kbgspjqrogwSC6pMel4JFmSImZyvzUxhh/e1n81uX8zKEiweLJqLjtCZX
	Hl/NTa27M+EAWxl7EsiXC8tP1UeN4Ac=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-cu0JzUPtNVegtjoSl0GHqw-1; Tue, 01 Apr 2025 16:41:58 -0400
X-MC-Unique: cu0JzUPtNVegtjoSl0GHqw-1
X-Mimecast-MFC-AGG-ID: cu0JzUPtNVegtjoSl0GHqw_1743540117
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c57f80d258so775823585a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 13:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540117; x=1744144917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owge253k5OvzgMZCm8XexlvQc59vpIkP2hnOZmugbZE=;
        b=txA9IUa1hIgMO4Ppllk7qRB9yCADSia4I1pQs/HnqIdsJrS2yJOW+FQxsA5Kj/v37l
         yufEXzaOiNbt6sAXfEmM/IZbYHxOevjE6f4RKHbKNBTtAVgAC9proNnxhxjxuTjMCuHt
         ip9pkdpeeM2cbamIwVCPgHRZnZqElYe2EmMRtewEbi9qxiSYT2E8dizSVl0KbkSbQdYZ
         lm7KJDs8YzRobsK4sLvm9JvgQXjCCy5qAAA8CNeYy0HPjk2q8G1gKxwrM3rw7x7l01Lb
         O0sDSShxNFLz0ijeMcyFKMjCKfIp3PiekPlnS6cpwACLSJ6s4Y0hRV3K3fkCnjx+p4Or
         kORQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbrolW7xJew+Q6qFim4g66RZAYC5xrzuLHitrVlUScKWHawwsS5XMlZbazd1Fro7Ig0ONbeHGwfSiWIMiyHgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfaAbjJonbkKEQehw+gqTRwI2/l+AFhwh3iZ0Z+YIrrU+uEFAU
	U6SOcKlymCQHUjjrnzyaUODlgwrM7BgWurMvktp6ZZthOxq1gG8JwsbB2iEByrjiwt7lAMoXgn2
	4Rh2IYBcDYEe+jS+BAZKaDG5iX8EjvmiQZH5fa+XK9MQPazGUiYmY5jARYLkPXIClAw==
X-Gm-Gg: ASbGnctxOOcAARBqB+2plJqK/0suaRXFc3Bq8oRI9z/rfSykBDMpHwZtmC6/r54Wylv
	VtF0u7coOi+iJTTbQfHm8y1C0g1GHek9Jp/RxR3XP7O8N7cfnMx8jAt8bs+j5Qkim2fcgdGTNiK
	S4sMAxYO5KFzHN18XnI99iRmQS+zcpJQddbgITt5WP9lafJ4UAdo8uvUdbwRDpHa4bjq/UeNRLL
	HaqPlAsqeyMwjBQXzk/ZiDCFIV7SY3lfaLwxAfJBi88FPnYGnmgZCEehHndOJ4PrRfT+YlJZ4LI
	wb5lF8W2ghlTYNgppHWbzYNsPqUNE8MdZ/sZI45bIP1cgcIZK/0g9zxOSeptIA==
X-Received: by 2002:a05:620a:4013:b0:7c5:5276:1db7 with SMTP id af79cd13be357-7c6908974d4mr2076453885a.52.1743540117630;
        Tue, 01 Apr 2025 13:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH27u1JuY0yEa8uyZ7v4MsZRRq+k/qsw1NKT26VcX+0iVdXSIzNmBeyfSP31h9rLTX0UGAbFQ==
X-Received: by 2002:a05:620a:4013:b0:7c5:5276:1db7 with SMTP id af79cd13be357-7c6908974d4mr2076451385a.52.1743540117322;
        Tue, 01 Apr 2025 13:41:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f768b70esm699208885a.43.2025.04.01.13.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 13:41:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d9c96490-98bf-406b-8324-6cf86a536433@redhat.com>
Date: Tue, 1 Apr 2025 16:41:55 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
To: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-shjD2OwHJPI0vG@slm.duckdns.org>
 <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>
 <Z-xFqkBsh640l5j0@mtj.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z-xFqkBsh640l5j0@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/1/25 3:59 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Mar 31, 2025 at 11:12:06PM -0400, Waiman Long wrote:
>> The problem is the RCU delay between the time a cgroup is killed and is in a
>> dying state and when the partition is deactivated when cpuset_css_offline()
>> is called. That delay can be rather lengthy depending on the current
>> workload.
> If we don't have to do it too often, synchronize_rcu_expedited() may be
> workable too. What do you think?

I don't think we ever call synchronize_rcu() in the cgroup code except 
for rstat flush. In fact, we didn't use to have an easy way to know if 
there were dying cpusets hanging around. Now we can probably use the 
root cgroup's nr_dying_subsys[cpuset_cgrp_id] to know if we need to use 
synchronize_rcu*() call to wait for it. However, I still need to check 
if there is any racing window that will cause us to miss it.

>
>> Another alternative that I can think of is to scan the remote partition list
>> for remote partition and sibling cpusets for local partition whenever some
>> kind of conflicts are detected when enabling a partition. When a dying
>> cpuset partition is detected, deactivate it immediately to resolve the
>> conflict. Otherwise, the dying partition will still be deactivated at
>> cpuset_css_offline() time.
>>
>> That will be a bit more complex and I think can still get the problem solved
>> without adding a new method. What do you think? If you are OK with that, I
>> will send out a new patch later this week.
> If synchronize_rcu_expedited() won't do, let's go with the original patch.
> The operation does make general sense in that it's for a distinctive step in
> the destruction process although I'm a bit curious why it's called before
> DYING is set.

Again, we have to synchronize between the css_is_dying() call in 
is_cpuset_online() which is used by cpuset_for_each_child() against the 
calling of cpuset_css_killed(). Since setting of the CSS_DYING flag is 
protected by cgroup_mutex() while most of the cpuset code is protected 
by cpuset_mutex. The two operations can be asynchronous with each other. 
So I have to make sure that by the time CSS_DYING is set, the 
cpuset_css_killed() call has been invoked. I need to do similar check if 
we decide to use synchronize_rcu*() to wait for the completion of 
cpuset_css_offline() call.

As I am also dealing with a lot of locking related issues, I am more 
attuned to this kind of racing conditions to make sure nothing bad will 
happen.

Cheers,
Longman



