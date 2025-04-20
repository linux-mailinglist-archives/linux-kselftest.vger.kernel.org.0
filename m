Return-Path: <linux-kselftest+bounces-31220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7FA949BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7C0188FD6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E31D63F7;
	Sun, 20 Apr 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzmQA7rV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E91A5BA4
	for <linux-kselftest@vger.kernel.org>; Sun, 20 Apr 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745185703; cv=none; b=mcVgCs+zULE0nF5oYVi/Sn0wundvVJQ2+OY9C3L3Vhzs16sa1gnvcn6c1u7mbecyNUT650y+g3YDokDunnEf7BEYDVsrJlR2Yw1kj6dmkiyha2AH4Bi3rU4c2jpIX+ikiuwjw3gEFdfXQOf3zp0+EBWEN4sbDVGx1hSiUhyD4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745185703; c=relaxed/simple;
	bh=IBu7tifNB1j2tCG4W4YMRP4oTCUk0PFSrFVfM3EZhOw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kWv4/vbDn+WwNYEbtCeC+PyQyoY0J9yI9sKaWcu2O1txZEGp+OXRKCMDrupZXXsR3Tt1r6N2YRoXGW/QTfHeONG+t3qKycuwp07GMqnixRotM2zkBJ8OzylnsfVxYPBBJZu9osDnQjhjR7VQr3jscbzmjvyoS9qQRrMrd5/atAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzmQA7rV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745185700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOUfeRWcjMIh7HWgzJ0PWrB/E+2a4XRZ58CSESwgEfQ=;
	b=KzmQA7rVzLpXT6SxTkoRiFWciCgYynkTdAE/g10vd1JyQiA3k/fTlAaTkJQnaxBdML41TK
	18XxBQdC2o8su0+VV8P8rdCHCuTRqlylcss8AT5HpAUOCcs3swS80ZJGpq8VikHHBKWpkF
	cFMZ5DKjZNxlpYVJFRmrURvF9PHQc40=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-bbg5rLP6P3emhTQ6CCComQ-1; Sun, 20 Apr 2025 17:48:18 -0400
X-MC-Unique: bbg5rLP6P3emhTQ6CCComQ-1
X-Mimecast-MFC-AGG-ID: bbg5rLP6P3emhTQ6CCComQ_1745185698
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f2b3e4c176so74307226d6.2
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Apr 2025 14:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745185698; x=1745790498;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOUfeRWcjMIh7HWgzJ0PWrB/E+2a4XRZ58CSESwgEfQ=;
        b=vL/XxgxrunJM7+G014a1BTLQz5SSrmbCwcVLUkF6DAGpuF3rMAlNrc/VbK4pcB86wd
         6H2dp7pUBv+Pmfzb0siyXJ4+o4NIDyDQ2DUlyRkpddaqOYjOuaGQUW+skKFrxg0CCAk0
         /E/gHhey06HGgIyVWks+lZBgLuJ0DnA3AcS3eKCY82xbw/fO0TV2Gnw5WpBG7BmeDNki
         joXZKX2i6oCsrscwfy07obX/YYm/3CzoQNWNFZe3sY8gR10eO32MFZqZ+pFfoboFquHk
         diwbQxvMUoDWMEV1qhSRYN4qNqup2dKwsAd2DOZGbKbahaXrPYF7QRl2k3Y6rPShd9Mu
         nyzA==
X-Forwarded-Encrypted: i=1; AJvYcCV85DQG66rKyiWMAnaTeq6aU+ZhPHOh6yiz6diGI5B0VscLG2z+r75DHFhUiZwG6ISpisnSVMu4OB/3b9ZC/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRg0YqJf078zEnLDfljeRtF2CnGH1ycaH+lrF/+7J+sQuG7PJ
	kobBbJIRNG8T8A+sXb2GPif5l228b3Eff4SOZaqlm1YBfy14gao5DzYykhvON7SfXGCeu/5NQFZ
	6yRx+M7pBpqueoosZ7Z0qqmJwmE2dI+X4GzuQraGVCvs4lD+K8PAhyKt5W5WdN0Jo4A==
X-Gm-Gg: ASbGnctlfsxnrMrFMXNQbAi/w2QXTWHCXVnfnnyNk1kDvEqxhO9FWLFbta9RcuvFnXi
	+ojDDSSIj0HolvOBX7FtX1u/f254XCIPvKNdaotexd1/Xs46nyqVn5yg2krsbEnp1MjDOtScOny
	dSVTAvH3kgCWOEv5amkKAanfdA7InyBVPMxWH0lZVlDH9h4FPmRgfX9ZoKorDqaZeAaEM7ffCFl
	tG/MIgNTOthyV8JmMlNQH+xOs7rxHhldOEf6g6HAmmePv6cf/su45SDL1ENpzRZJppP1kfYkYRG
	SFpD7oN6px5x7WS2QunqtC5ADYxcztHuJZs0vi18tYvf3utzzQ==
X-Received: by 2002:a05:6214:20ee:b0:6f0:e2e1:50b4 with SMTP id 6a1803df08f44-6f2c4665552mr155639786d6.35.1745185698073;
        Sun, 20 Apr 2025 14:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1rjz0rbTdMsGxlXep21QS1BL8dfWYnSrJCLKXWkQdNHadHwWjUHhvmnzBn0KbSPKMCrPC5Q==
X-Received: by 2002:a05:6214:20ee:b0:6f0:e2e1:50b4 with SMTP id 6a1803df08f44-6f2c4665552mr155639546d6.35.1745185697701;
        Sun, 20 Apr 2025 14:48:17 -0700 (PDT)
Received: from [192.168.130.170] (67-212-218-66.static.pfnllc.net. [67.212.218.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0e2b2sm36456396d6.28.2025.04.20.14.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Apr 2025 14:48:17 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
Date: Sun, 20 Apr 2025 17:48:15 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
Content-Language: en-US
In-Reply-To: <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/25 5:25 AM, Michal Koutný wrote:
> On Tue, Apr 15, 2025 at 05:04:14PM -0400, Waiman Long <longman@redhat.com> wrote:
>> +	/*
>> +	 * Child 2 has memory.low=0, but some low protection is still being
>> +	 * distributed down from its parent with memory.low=50M if cgroup2
>> +	 * memory_recursiveprot mount option is enabled. So the low event
>> +	 * count will be non-zero in this case.
> I say: Child 2 should have zero effective low value in this test case.
> Johannes says (IIUC): One cannot argue whether there is or isn't
> effective low for Child 2, it depends on siblings.
> (I also say that low events should only be counted for nominal low
> breaches but that's not so important here.)
>
> But together this means no value of memory.events:low is valid or
> invalid in this testcase. Hence I suggested ignoring Child 2's value in
> checks.
I understand your point of view. What I want to do is to document the 
expected behavior and I don't see any example of ignoring a metric for a 
particular child in the test. In this particular test, I did see an elow 
of 17 for child 2.
>
>> +	 */
>>   	for (i = 0; i < ARRAY_SIZE(children); i++) {
>> -		int no_low_events_index = 1;
>> +		int no_low_events_index = has_recursiveprot ? 2 : 1;
>>   		long low, oom;
>>   
>>   		oom = cg_read_key_long(children[i], "memory.events", "oom ");
> But this is not what I Suggested-by: [1]

I was referring to the suggestion that the setting of 
memory_recursiveprot mount option has a material impact of the child 2 
test result. Roman probably didn't have memory_recursiveprot set when 
developing this selftest.

I can take out the Suggested-by tag.

Cheers,
Longman


>
> Michal
>
> [1] https://lore.kernel.org/r/awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5


