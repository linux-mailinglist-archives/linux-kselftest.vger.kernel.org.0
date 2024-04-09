Return-Path: <linux-kselftest+bounces-7482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60889D9B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD1A1F21CF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09D12E1E7;
	Tue,  9 Apr 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5OiQGvD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBC12DDB0;
	Tue,  9 Apr 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667614; cv=none; b=feuYLaokAa62CH5ZOTrbkrSoS/PgQTXvAalX79mCxhqBYzaRfEjh2bW5JgV66PdTuWn+3JzKEgLm28wqDG9eT48FnXtwuTRu4aOmrw8jPI9NhiIKSB+CZKlMpTROLJwKtdi+O6utFCYfQXMUNx7VYhQgOAA5ZZyVWveRciA2RTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667614; c=relaxed/simple;
	bh=t5r6dEc4u5E4PiDu2jwLXpYVRAhdOQAi2gPnB6n/Xl4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dPoS9EaV6X0sPZAeSF9HvBJtCp5A31et15BoREoKmAySPYHvJaN8HxRHcZHkuN7142qjKzLycUBXc6cOMHVccgz9eowWehc1SE2H+lp0CxckukLwWYbQVG3fFx6ivoUMdvUmvmYoGdRR+fLKaMIoDbkoJuCGSL7vHzGQRrm893A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5OiQGvD7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712667610;
	bh=t5r6dEc4u5E4PiDu2jwLXpYVRAhdOQAi2gPnB6n/Xl4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=5OiQGvD7axFiUJem0skEujBB3FJUsOqa8tiYES6UVyUJFgHmoCKC1zok06I7SA8Xq
	 Vgq6X6hTN3Qq2f/Tg6OTgutyepD4O4DKLurqpbfe/rbW4zBXx3BnMMeU8YMPMyyf7t
	 JQ7IReNSoakpdea71ct8clLTbubfiOrJ9HT598qm4z+lsS2C30eUf1mZ/veWAZ5/Zz
	 cm1zr7sCxa6ZJcNKU742cin8jhFKQdO8VVbFBzMlWXpQpb5y4sWagvcIay8hq5YFOw
	 YB6vDxJnSmGIXe7VsFrx538nve+eB+3+VQ+Y7DLeC+lAUoAHRA7usOQfpSDpBf9bam
	 ND/Rh1oCXnj6Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6C83237813CA;
	Tue,  9 Apr 2024 13:00:06 +0000 (UTC)
Message-ID: <2196cc49-e5da-432b-bc35-64d55623749d@collabora.com>
Date: Tue, 9 Apr 2024 18:00:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 6/9] selftests: cgroup: Add basic tests for pids
 controller
To: Waiman Long <longman@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-7-mkoutny@suse.com>
 <a45c2ece-acb4-4cff-9d53-f5c007c9b905@collabora.com>
 <qweowkm4wlfzovp3qhtkzbybeampodtwmpbp2kbtiqcrhmjtdt@syk4itfkpmfr>
 <41dd9c5a-0e07-4b98-9dfb-fb57eaa74fa2@collabora.com>
 <oosadt3f5i3qsvisrxe6hrs46ryfqbyxyk3a6jimd7cqczjtcw@dvlsm7eh3b6r>
 <4bae7682-801e-498f-88c9-9c9d45364bfc@collabora.com>
 <ec74bc9f-8e63-44b9-b3a6-ca7d6d366c69@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ec74bc9f-8e63-44b9-b3a6-ca7d6d366c69@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/9/24 5:12 AM, Waiman Long wrote:
> 
> On 4/8/24 08:04, Muhammad Usama Anjum wrote:
>> On 4/8/24 5:01 PM, Michal Koutný wrote:
>>> On Mon, Apr 08, 2024 at 04:53:11PM +0500, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> ksft_test_result_report(tests[i].fn(root), tests[i].name)
>>> $ git grep ksft_test_result_report v6.9-rc3 --
>>> (empty result)
>>>
>>> I can't find that helper. Is that in some devel repositories?
>> Sorry, I always do development on next. So it has been added recently. Try
>> searching it on next:
>>
>> git grep ksft_test_result_report next-20240404 --
> 
> I don't believe it is a good idea to make this patch having a dependency on
> another set of patches in -next because the test won't run in a non-next
> environment. We can always have additional patches later on to modify the
> tests to use the newly available APIs.
Sure, it is okay with me.

> 
> Cheers,
> Longman
> 
>>
>>> Michal
> 
> 

-- 
BR,
Muhammad Usama Anjum

