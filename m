Return-Path: <linux-kselftest+bounces-48769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C0D13DCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 719C1302C12C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE71364050;
	Mon, 12 Jan 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI/roims";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3/oZgH7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCC2C029C
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233757; cv=none; b=TDLwaFVJEfSf0lO7J6znTTDU+3SHSZwsw3RDuLRYrsg1Pxku16O+C+SHkw7s3dieRzBHiBu+rCkNtdgTF71S+i+qkTt+exZOr3Jk00KyUJxNJViiO8JQw00MjfmFgtiCqmqY/jfM9oth8wHMWWkbldB7IgUbArNTdEZZpZNeZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233757; c=relaxed/simple;
	bh=bC/Qjyk/R/HVGN+FQeWmTeEoWIOx8ZavQXScE/JM/Vc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G+TRzc+OeC4p90bQF+fr3m9xZfUCbAcy8atgmRdUFalTvpYqP0QsKf3oJVDLS3JfE1IbMUl8zP1AnCECmFuw7qEkqrGaBPYensqGP3fYZu3s879e0csRfrl3yv2n2BCdjSILlZ3m+6HQN802ZxifHbMFsp5I2cunYNqKVvOd1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI/roims; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3/oZgH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768233754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
	b=PI/roimsEjk8QmGUqVeyENhxVYKU//c5AJQ6Bfwus9Et+pEwdmlHS9J+ZDaaMrUwWGB3Vf
	lNbLRSABKaBM1d/33Kcj/u9m9y31yU3ORicCcsXZy9CAYqWXw4IGIkdr2bkJa4eGvEeWkx
	SJ+SVotz1WPdoNElSqM/4wjr4dvWONc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-dNlxdRblPBWxUJZKroa4cQ-1; Mon, 12 Jan 2026 11:02:33 -0500
X-MC-Unique: dNlxdRblPBWxUJZKroa4cQ-1
X-Mimecast-MFC-AGG-ID: dNlxdRblPBWxUJZKroa4cQ_1768233753
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b9fa6f808cso1930749785a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768233753; x=1768838553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
        b=H3/oZgH750O3fehzP/iwP36T8l1Hqmye0ljh2E/I2gc4QudNmpH2t0dQ18GGY4y1pU
         97/bFnoht+cSoGqCo88E+hEalGtAW0XZnGdfs695tm+UpeXkgQ/lwWiZEEGlw3qvkdNK
         qCbDITAK+TSVNTZPSNgSZjjud//kkH+ZD1aLa51pQfKT2JtPYzTtBweI5njCv9TWXCXs
         cqxvGmOEteLFiuIxa05XqKY5bdZlRnZZRb0C3M6h9h8Z6tIqoJsaLwomRhwsDMp4gfPk
         W/ud4cZJYEEQ19D7fYfdbjeqWwHkSGy9gSQTf8vIFzomsIaSe182t0WsxX8Qm75T6HKy
         2s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768233753; x=1768838553;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMhXnlPrek/WOR7SOlvqEVsXnE8wyUlU5u32qXId6qk=;
        b=g11j3PtykYEV0PvEcwrN7blb4tbsXpGGmrixAoI5sguTYTNiyJ4CS1fha192fhbE2E
         +RorjeHQ6uYb1dpnFIJK+pS9zEYpkymak+CD8ROKInIG/abksK06CJU1UhZOIexHwmZB
         CgITDt+N5yBUi/wytDWQtvVZ57mzo78MU+6RJ3xDMPvL67p9rUxvGWl5c5sNXMPokOy+
         kvX59MKaJkwzvc6gZBnkGMXpXl6IMyOBzZFWbebDoDDaq35gYKgFQCIAOZnX168TcvDh
         YNJe73TGmyPVwUHJD6sMfCbXEHwfn+V7B6MmjfpktIJWCUH4nV7PoNcVaMngcnlztIbe
         sTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9D15FKj2vYatHcZ2ePtltoacoWX6k9HxqUHQE261EUZrClCSbCnBygk4aVZr6w8J4gRwVC71ctvHHTeVp3JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7wnaVmHKK6JWdVzt1lgg3uSnAZhOuvGBR8dX0wqO7VrzV+Z3
	IMC1EEho9A7xqPD9NjJTc7khM+zvNazZm1Cjh8bWIcORxCy9KXIi78p9kXX9lZ3LJhvt25hvYtF
	LzBnBTYBmogqkMeqbC9eHke4P9yvH+eetwQp6XFOh7j8x76q5fORcbCbQQMEIGUwsQitOlA==
X-Gm-Gg: AY/fxX74jutMDfionEeK0ajRDm2CR9tT1HpUr2M5aDMeRwDeUIgoJ3F7zlRL0fcRySr
	x5qRgHytXYoNkM3o668r+dy29k7GVSEK6pKvT0IRyNN1L4m6gmeDmEXKjFsSjxeE6EaafHUhqhD
	TGRRYKkpFY8GKkZUpJ7w09SGVWyr2REB4zxeNr4tpsRjUugkCOSqtBOJ08IOPc9SYOWIy5G6VAM
	rQWeWhWRGtfSYRGsPDqkeg4lxUjmKApMnAWd1pt2e8yOkexO5+ok3zY3672tUciLU5n0+olUl41
	0TQO1KFk323YWl4FltZa0DXOfJR0S5WxPO9wRjQajYLs5AXZ9gxE8AItlAIK5Iry446BBwsjmRj
	f3WnD46D/nOvkL+LGO8/aaMLusVXjc9P3VMuszriRdo7CLMKhhwH5g7k3
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id af79cd13be357-8c3893dca80mr2449104685a.45.1768233752583;
        Mon, 12 Jan 2026 08:02:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJi2/0HC1+IC4PuaBeIdB3G5w2rUk7KP+T2Nhpx9j47KDX3VY5aFRtmJJXjg0pMKFLyFlL1g==
X-Received: by 2002:a05:620a:4444:b0:8b2:e177:fb17 with SMTP id af79cd13be357-8c3893dca80mr2449083785a.45.1768233751123;
        Mon, 12 Jan 2026 08:02:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6441sm1556650385a.7.2026.01.12.08.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:02:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <86b578f3-70f5-4a72-9371-e35478ec1c01@redhat.com>
Date: Mon, 12 Jan 2026 11:02:28 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Chen Ridong <chenridong@huawei.com>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
 <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
 <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Content-Language: en-US
In-Reply-To: <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 10:15 AM, Waiman Long wrote:
> On 1/12/26 10:08 AM, Michal Koutný wrote:
>> On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long 
>> <llong@redhat.com> wrote:
>>> Sorry, I might have missed this comment of yours. The
>>> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted 
>>> to its
>>> children as exclusive CPUs. The cgroup root is an implicit partition 
>>> root
>>> where all its CPUs can be granted to its children whether they are 
>>> online or
>>> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as 
>>> well as
>>> exclusive CPUs that have been passed down to existing descendant 
>>> partition
>>> roots so it may differ from the implicit "cpuset.cpus.exclusive".
>> Howewer, there's no "cpuset.cpus" configurable nor visible on the root
>> cgroup. So possibly drop this hunk altogether for simplicity?
>
> Ah, you are right. I thought there was a read-only copy in cgroup 
> root. Will correct that.
>
Below is the doc diff between v4 and v5:

diff --git a/Documentation/admin-guide/cgroup-v2.rst 
b/Documentation/admin-guide/cgroup-v2.rst
index a3446db96cea..28613c0e1c90 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2641,9 +2641,10 @@ Cpuset Interface Files

      The root cgroup is always a partition root and its state cannot
      be changed.  All other non-root cgroups start out as "member".
-    Even though the "cpuset.cpus.exclusive*" control files are not
-    present in the root cgroup, they are implicitly the same as
-    "cpuset.cpus".
+    Even though the "cpuset.cpus.exclusive*" and "cpuset.cpus"
+    control files are not present in the root cgroup, they are
+    implicitly the same as the "/sys/devices/system/cpu/possible"
+    sysfs file.

      When set to "root", the current cgroup is the root of a new
      partition or scheduling domain.  The set of exclusive CPUs is

Cheers,
Longman


