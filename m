Return-Path: <linux-kselftest+bounces-39721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E8B322E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491D91D642A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41742C3761;
	Fri, 22 Aug 2025 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dR7ROAdA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8627FD43
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891135; cv=none; b=tK1DMUpofpQmBPfJS9x1/0P1vVY8Gwh5owcxVg5r8MhEfQFOpacPcrVqAikPCWgOfNGocEuHNYIzA1Z3/UhAmMS4WOtAN94ADFPrt2dtBKI1aFDXJdRV7wg2nisX+xg6RoYvxkw7jq2gai1sEXyyw0zcmv7rBGS8nNoh/gy+2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891135; c=relaxed/simple;
	bh=3s64Jp3QulTlwiE5ofAQsTztr0p9BKTORR1dATMvr5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a5BgWmJaGRAjfpiMQml+cCLfW65wkSgaUHeUZn/h0S/7vuyb6k3vWJx5jSGzuviMIqXypBs2iq/12FKRAwPVTikt/WKJ34qZ8gqlb4vHCAvR+2nsdQIeuNIzUmLMGLnM7EfE69q3rPNKUJO2J6q8FFo87TIMOR+xaG4vszueeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dR7ROAdA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2463648439eso16311445ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755891134; x=1756495934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eijYJKB1jyNJ4RwfrMBM0aX3LJrO4Yk41oZgCcMnL9M=;
        b=dR7ROAdAArzTJQSTXW9Y+ggpVgR/1xXPD2I3e6aKqBBHKsaRLmyOSCsRtCW7Pfq3Ap
         arGO3/IHEFnNpU1W5zyKdHMuWnJ6I/LtzTmatZHTDhROMvd1pX9areGKCtslrzRzl6Gk
         uKIZYfnqbOOktk9PqyCHcIFdHfpJ7ugLYq92GwOfvP1/uHX3TL3qzUKZey/AlpAjWCj3
         7Vzn5m94lsote16lBVoP3K9yWCTATemwi5gJg6wGKM1iEbN1XCGtTSauRWpyDZ0q/YhN
         3dXjb3qppCgHRKpmvPeJhdntoV2GR+A+OzzCZPMIpbC8hZUZpyxzNfUqCx8+yd4aisRq
         ocKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891134; x=1756495934;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eijYJKB1jyNJ4RwfrMBM0aX3LJrO4Yk41oZgCcMnL9M=;
        b=LSLuLbhzTie5BkpAJ8+X8zXpclB9t35zdA8Q/yPPMNHabCRVcrLSiPuKEIV2KzeUwI
         LzZQlUrCARRuvRZBL821IDrpo1esqCSG7XKTXg/3nzxw3YD9FLQDZAgfX4ZBzdY4IOf0
         xbQF2HI8S/B26eLwVKsKwVhN2a3A5CW+6xZTBvG1M+g0LGZhrORqArWvqbDOe6pHCSF9
         J+o8UaHBRv7hMb+NdxaGjOU3kba5poDmVm7/S9Z3WirOdMNUrEVakBAXvcjJATCvCjrj
         r7eG5XaIKtU98O2bGWEc+ZqNvcmeCiMMMRi0Tgx7QmhruUe1Mn9zGGYtdb6XDsOoM8dI
         XSjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJHKaQPaXjYQlBtrv0oFqvru7rQ/JSZ/6iYfgWMSjNQW/ncsFVViEnIo73Ccb0bK3/Joetxw/ogQSxPkzGhgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0AnvwzMqs8LMpThuZI2Vhad5Mn4/omrk6d4YpS1vdwOIReJt
	Vw4hiN0wqn9ey5YJi7gx+rBpU6aKGxMuAU8fdZ+It20K1Gdg9/Hjw7vdLnALROb87iKP94mipZc
	Sm87V+u4SsQ==
X-Google-Smtp-Source: AGHT+IGWGHuUiecwNE0J430fRtd++8O33kwJ8O32CpxkTDJrZOVJ0navu1kOZKt8+rWhHyZP/XTWBJb8tmWD
X-Received: from pldq21.prod.google.com ([2002:a17:902:c9d5:b0:240:5c79:f17d])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0f:b0:242:29e1:38f0
 with SMTP id d9443c01a7336-2462ee86bb6mr63371135ad.24.1755891133656; Fri, 22
 Aug 2025 12:32:13 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:32:12 -0700
In-Reply-To: <a309c2b5-5425-428c-a034-d5ebc68cb304@huaweicloud.com> (Chen
 Ridong's message of "Fri, 22 Aug 2025 14:58:48 +0800")
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822013749.3268080-6-ynaffit@google.com> <20250822013749.3268080-7-ynaffit@google.com>
 <552a7f82-2735-47a5-9abd-a9ae845f4961@huaweicloud.com> <a309c2b5-5425-428c-a034-d5ebc68cb304@huaweicloud.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8ms7r885f.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v4 1/2] cgroup: cgroup.stat.local time accounting
From: Tiffany Yang <ynaffit@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Chen,

Thanks again for taking a look!

Chen Ridong <chenridong@huaweicloud.com> writes:

> On 2025/8/22 14:14, Chen Ridong wrote:


>> On 2025/8/22 9:37, Tiffany Yang wrote:
>>> There isn't yet a clear way to identify a set of "lost" time that
>>> everyone (or at least a wider group of users) cares about. However,
>>> users can perform some delay accounting by iterating over components of
>>> interest. This patch allows cgroup v2 freezing time to be one of those
>>> components.

>>> Track the cumulative time that each v2 cgroup spends freezing and expose
>>> it to userland via a new local stat file in cgroupfs. Thank you to
>>> Michal, who provided the ASCII art in the updated documentation.

>>> To access this value:
>>>    $ mkdir /sys/fs/cgroup/test
>>>    $ cat /sys/fs/cgroup/test/cgroup.stat.local
>>>    freeze_time_total 0

>>> Ensure consistent freeze time reads with freeze_seq, a per-cgroup
>>> sequence counter. Writes are serialized using the css_set_lock.

...

>>>   	spin_lock_irq(&css_set_lock);
>>> -	if (freeze)
>>> +	write_seqcount_begin(&cgrp->freezer.freeze_seq);
>>> +	if (freeze) {
>>>   		set_bit(CGRP_FREEZE, &cgrp->flags);
>>> -	else
>>> +		cgrp->freezer.freeze_start_nsec = ts_nsec;
>>> +	} else {
>>>   		clear_bit(CGRP_FREEZE, &cgrp->flags);
>>> +		cgrp->freezer.frozen_nsec += (ts_nsec -
>>> +			cgrp->freezer.freeze_start_nsec);
>>> +	}
>>> +	write_seqcount_end(&cgrp->freezer.freeze_seq);
>>>   	spin_unlock_irq(&css_set_lock);


>> Hello Tiffany,

>> I wanted to check if there are any specific considerations regarding how  
>> we should input the ts_nsec
>> value.

>> Would it be possible to define this directly within the cgroup_do_freeze  
>> function rather than
>> passing it as a parameter? This approach might simplify the  
>> implementation and potentially improve
>> timing accuracy when it have lots of descendants.


> I revisited v3, and this was Michal's point.
> 	p
>       /  |  \
>      1  ...  n
> When we freeze the parent group p, is it expected that all descendant  
> cgroups (1 to n) should share
> the same frozen timestamp?


Yes, this is the expectation from the current change. I understand your
concern about the accuracy of this measurement (especially when there
are many descendants), but I agree with Michal's point that the time to
traverse the descendant cgroups is basically noise relative to the
quantity we're trying to measure here.

> If the cgroup tree structure is stable, the exact frozen time may not be  
> really matter. However, if
> the tree is not stable, obtaining the same frozen time is acceptable?

I'm a little unclear as to what you mean about when the cgroup tree is
unstable. In the case where a new descendant of p is being created, I
believe the cgroup_mutex prevents that from happening at the same time
as we are freezing p's other descendants. If it won the race, was
created unfrozen under p, and then became frozen during cgroup_freeze,
it would have the same timestamp as the other descendants. If it lost
the race and was created as a frozen cgroup under p, it would get its
own timestamp in cgroup_create, so its freezing duration would be
slightly less than that of the others in the hierarchy. Both values
would be acceptable for our purposes, but if there was a different case
you had in mind, please let me know!

Thanks,
-- 
Tiffany Y. Yang

