Return-Path: <linux-kselftest+bounces-29971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48DA772E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 05:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEE8188DB2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 03:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D51519B8;
	Tue,  1 Apr 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSs5IZ/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220A85C5E
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743477148; cv=none; b=AMQD0SHyMez4HG7CdUXB0nro9wXK0Ug6DpOhTphy/+XSwFGk/To8MUc382h3quWCKpzkFCc7szKXUOI+dqe1LjOh3TdACgyhJyk0l63trneWd86sLDo2WNptsqeeQovuvKjo//n44lnmzmZpFnc8jUHhqhCRdSBJqQOOc+9KJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743477148; c=relaxed/simple;
	bh=YH7JCvQ8t1ajK7yqoxSreEprl3ng3fcJ/g1aGkjZ1Ok=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HzUe11R+Jh/YXWb0ttdXbO47HqUczBnyn2c0BPu5rqDcD33PFJdRU2SXEbnJjv02vplJ/Qc6I9YlOR5WFMz7WIUk1sx9az/FqwcQYpwmo/CgG1hkDHA61/XSV+DBzcv+ZzKNmmOztZkET1nZR6U1p0XAA9IhJZqEHIO0hfLuYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSs5IZ/w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743477145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+yChQ8LHPX/9hgzwjNue2CwizV8oJdhGjOx1G3bhZ4=;
	b=TSs5IZ/wvX9HKQF60H0oDOAPRBIMZ4YjG6HK8lIslMCeSkgkZ7Aqah4bQzZClWB9GmpSPJ
	V9X68Vf/CqmKRlzJ42sIHwB47Zs0HE1mD7IfVqtVYp9UJvYHt33jTRTpia7xm4HFC1bfvJ
	/Ueyzp76SJ/tD5bxEcGDHbshXxPW2zI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Ux9JFU-kN8SyaawzOrt2nA-1; Mon, 31 Mar 2025 23:12:08 -0400
X-MC-Unique: Ux9JFU-kN8SyaawzOrt2nA-1
X-Mimecast-MFC-AGG-ID: Ux9JFU-kN8SyaawzOrt2nA_1743477128
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c09f73873fso785607885a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 20:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743477128; x=1744081928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+yChQ8LHPX/9hgzwjNue2CwizV8oJdhGjOx1G3bhZ4=;
        b=xGu7S7OCZ5HBghdJwZJgud+1Ax9IE+87yd3Sae5PmBbcQMP1NUiM9MvleEymxt4RlA
         MJvCGQ4JIkj+sEzT0TI7tQo2DXd0XwEOE4tXWoiGOytPQif5D534BJpMYzMdSHHPaqEd
         mw/el62boxvHBgbD9yDQcPXtT9Y7MQSEtJv+7lvjv9smTQiRiiwF+y75XWNfs5qOrLGV
         28tEXis84hTWQ/yoJQkaRsPrZ7Qi6Svy4trC/cEYMedGIpRvQdOGGZr9WJtw1KT6dxrN
         El4hfM5FvbQpMALKntf+OdYXWFeJgtqYsSTBqU64d2GNRJ7SXGqlHj17Rp7yr0n/r079
         ncNw==
X-Forwarded-Encrypted: i=1; AJvYcCX0FXLMvFgp9uoQ8kgukF1hdwhcPnWIP1BPnVwx1a2EjLu0gGSZ6DWZ+77uEE2vF44ftB70PpgcIgeHcoy/W7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo6E8OPzeRwZE3xkqmYWb9FRrVBzIVqxKxMtU/hA72k5SLQ5U
	UoQqGsYCiJ2vMuQyGyyaHOIzw+Q1TkNfYBhp7YVRNXwse+KkV4w/HGhlOBr2LXxUIoYs+hWi6Ru
	gMN7J8S0b8RHMLyi3vhEJErCWck4wdj+SKlIX9X2X6nG4ZEkqEbVepvWqteYTdVkMAQ==
X-Gm-Gg: ASbGnctA+oiWX4rh/czpz6dbfoXuqKROEaqKGxpV9wkxMcqkhl5gJPiAufF4HUH75M2
	CVp9Hw0aNmP2J7DVYWYMtIahRJm0tXAoyMSOavpe8jkfFAHp279coBEbyC97WGzSazSwJKUxS3n
	xbXGx+x+N3HexLKX6Rh6J2aeti9iyt/c3qtm9lV9CyYDkHX1rlJkj7NZjv0vXjfH43sVzBnsWQo
	P2Iw2/gXk0nQoYr3XYIrfIfpS5ZaZMs21quhvWtGmQspyOQpPXJVMD1k4TlqM5wCkkZd483wgJJ
	GmTqxfQx+9QOnegtco/ENHGqleqorNNR81Cc5jN1XLlhLZzCKYtZocmMhsxmLQ==
X-Received: by 2002:a05:620a:3193:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c75bbb2973mr216489785a.13.1743477128008;
        Mon, 31 Mar 2025 20:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg1j7Vc+zuUQ1pOrhianPa9k1mLxzvuGG2Gm2NPTKGwMMBDaWsWyn19rFctKJdNGrDvU+WZw==
X-Received: by 2002:a05:620a:3193:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c75bbb2973mr216488085a.13.1743477127711;
        Mon, 31 Mar 2025 20:12:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764c7fsm587396785a.84.2025.03.31.20.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 20:12:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>
Date: Mon, 31 Mar 2025 23:12:06 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-shjD2OwHJPI0vG@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z-shjD2OwHJPI0vG@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 7:13 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
> ...
>> One possible way to fix this is to iterate the dying cpusets as well and
>> avoid using the exclusive CPUs in those dying cpusets. However, this
>> can still cause random partition creation failures or other anomalies
>> due to racing. A better way to fix this race is to reset the partition
>> state at the moment when a cpuset is being killed.
> I'm not a big fan of adding another method call in the destruction path.
> css_offline() is where the kill can be seen from all CPUs and notified to
> the controller and I'm not sure why bringing it sooner would be necessary to
> close the race window. Can't the creation side drain the cgroups that are
> going down if the asynchronous part is a problem? e.g. We already have
> cgroup_lock_and_drain_offline() which isn't the most scalable thing but
> partition operations aren't very frequent, right? And if that's a problem,
> there should be a way to make it reasonably quicker.

The problem is the RCU delay between the time a cgroup is killed and is 
in a dying state and when the partition is deactivated when 
cpuset_css_offline() is called. That delay can be rather lengthy 
depending on the current workload.

Another alternative that I can think of is to scan the remote partition 
list for remote partition and sibling cpusets for local partition 
whenever some kind of conflicts are detected when enabling a partition. 
When a dying cpuset partition is detected, deactivate it immediately to 
resolve the conflict. Otherwise, the dying partition will still be 
deactivated at cpuset_css_offline() time.

That will be a bit more complex and I think can still get the problem 
solved without adding a new method. What do you think? If you are OK 
with that, I will send out a new patch later this week.

Thanks,
Longman


