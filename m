Return-Path: <linux-kselftest+bounces-34242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53246ACCE19
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1446D166F3F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53971FAC37;
	Tue,  3 Jun 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZEqk3QB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B913AD05
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982116; cv=none; b=rz1BWgZAwT0QRy5YrK9TuD6+SQtW0Jxm7zPy9K+h/P86O9cNBj5a2UZGsmgx3CX3CcSKzdfUUmO3bIK1TivKMw2S00QUWaTfaLSdo/fQGuRMjKAa605m1nHlaKkRDFC9bfgP9bmXLwM3TFTiaPo3Mc2pDphegvDgM1QEs/X97C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982116; c=relaxed/simple;
	bh=4Fz5TH77TNLCD+9oczh5JRAo8TzIo5lXkUA61YEuykA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr1rwusXdruuQgmxeaz/hN7BIKYAptY6jQahAs9M/W2yomUT61jb8d7m/cQQY7hf28kWpsdBAp/AEUlJZ3m7FbPLEWQLdZKfstEI7hwRpbJkan34CFLqqDjmR0JMF9xJygZlASbObD+umIWdY8hkLKgnnMiM9z9xmIDcNfzHKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZEqk3QB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748982114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qLcBjgtnlUgpXPCy7MHXi7SDjB9CHWmBHWFcHhiH6Fc=;
	b=NZEqk3QB/nZsF6sJQphvwFXVHTSt9T7hSYfxE6Pht64yvDi+g5gpcLZye0e/0vd4zCsWlX
	NYzvqt+pnKbsNzXLWLwLDaIeutO0Mpw41qYkufry7LUjQD64tzirBil1WkxMuIupLt+V30
	qo9CJA9KolKviufPlQN6m7G9NWd/pVk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-3c0CXm07MvGJahjgkYJwFg-1; Tue, 03 Jun 2025 16:21:53 -0400
X-MC-Unique: 3c0CXm07MvGJahjgkYJwFg-1
X-Mimecast-MFC-AGG-ID: 3c0CXm07MvGJahjgkYJwFg_1748982112
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d021b9b1so25056385e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 13:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748982112; x=1749586912;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qLcBjgtnlUgpXPCy7MHXi7SDjB9CHWmBHWFcHhiH6Fc=;
        b=FvZXDxgmuyme3R5FfSg5a3x1wFp6YKQfoUlDSPuxhljLI73IfU1oB2InQgVo2KBrnY
         blSZwrG7iSt7xarC6FAQ6dHTjq/87MQ5dLzBvLICKh8Az5DxCsesaLU57JkBSZJZzslJ
         ZFh1ZVi529T3gGamhHKUqzZ7jAnl/DRb/0ayM+c0u8F0V5yj/e2HqLrtorF20w82rfNj
         MK8wUX1bnnsnLJIlXCNJ6gJySnJe/op2+ziYRDkE1W31+M4gxcOaoxbSCN8UpY6sjuYy
         LgjmT+dSgjfWO5OVD30iaS0kpE+nYVqRWyGCJE40qeRgyoGPK9+xeZctM64/lxwGY54c
         Qslw==
X-Forwarded-Encrypted: i=1; AJvYcCV96OFmDv5GqbpkH71QeHUZcQ6lqyJx5hOyPSvB4IFdZitoVhUrFwwe7Fic5rqHqGuLQRAn3IN15ssLlC0oPZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeXGefT9kND+6uM5aiCtVk4Mmalu+yhLmvKJppQO058xGSjeO
	2UVPcEDPeXo4Jntm7I99O7udRXJIXfz+4SM9uhEZeHAKZZahoO4o15GdYz3xeqiZnW55NBkGxrm
	qaZ7qBRXdFMhd30ZJP/RjNq1RdWVE1WmbgERqgffoSnxx1WpwNJieQQLjhCJd7Gk8jHyTDA==
X-Gm-Gg: ASbGncvi4ELed35GE0Z+aP6n2YsfEyBIfhIssQGtEUv6+0n7uIi68jSm3sf0Y/teGKz
	uv7KZbrXnI2hpY0V8IzjCb70nUoGUoWu5urCkgvSIKoslsSRvr2MC+Muo5t7IC8P+RIRhOKiq3Q
	g0Vmqvb8nKeo5UGVmAqU/KzLqDtH/KrJlBkFCZBuiqvIwTWQ4BtEWeSkjHb/xP2R58QHINLz0eC
	+nouys1OwQm9Bkt4vKuGKllmoUGwno4lc4/KYCNF3ABF0eKglH56dsWo7RvE0SbrAV4fbHdKQWv
	m2Cvx6XLdVa/GxDqvvUsjdaJVghBd7nzeyO/rwsM+yipO3sWVbrh9PDJQm2wOKVaKCg2UUIZZTj
	2fC8oqOK6ReV6SnSpRM1IXjrO6sQ5ygN9M8p7xV8=
X-Received: by 2002:a05:600c:310e:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-451f0a7c518mr863865e9.14.1748982110295;
        Tue, 03 Jun 2025 13:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+96eBgpaWG54RursRXNAWSJJEuPTAoVA/5AzWcaySDNPnRaZ6RZz/Ebsj/IWqmWFYMpb0Qw==
X-Received: by 2002:a05:600c:310e:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-451f0a7c518mr863175e9.14.1748982108429;
        Tue, 03 Jun 2025 13:21:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006ff8sm171891555e9.34.2025.06.03.13.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 13:21:47 -0700 (PDT)
Message-ID: <299dc39a-63ff-496c-a45f-38934e4441f1@redhat.com>
Date: Tue, 3 Jun 2025 22:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
 <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
 <e1d20dbf-734f-4a2c-915a-86c9fbac998a@sirena.org.uk>
 <27f74a9c-8bf9-4877-ba14-82dcd79f6d0d@redhat.com>
 <d35bdd4d-d210-434d-b259-97a4bb93c64e@sirena.org.uk>
 <2117dfe4-befc-4fe4-9b5f-184433299494@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2117dfe4-befc-4fe4-9b5f-184433299494@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 19:55, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 06:48:19PM +0100, Mark Brown wrote:
>> On Tue, Jun 03, 2025 at 06:57:38PM +0200, David Hildenbrand wrote:
> 
>>> I agree that printing something in case KSFT_PASS does not make sense
>>> indeed.
>>>
>>> But if something goes wrong (KSFT_FAIL/KSFT_SKIP) I would expect a reason in
>>> all cases.
>>>
>>> IIRC kselftest_harness.h behaves that way:
>>
>> That's mostly just it being chatty because it uses an assert based idiom
>> rather than explicit pass/fail reports, it's a lot less common for
>> things written directly to kselftest.h where it's for example fairly
>> common to see a result detected directly in a ksft_result() call.
>> That does tend to be quite helpful when looking at the results, you
>> don't need to dig out the logs so often.

Right, and if the test fails, you immediately know why. So I am a big 
fan of the test telling you why it failed, not assuming "it's the last 
check, so the user can go figure out that it's the last check in that 
file and we just don't tell him that".

In any case, I hoe this will be gone at some point, and 
kselftest_harness.h will provide that to us automatically.


-- 
Cheers,

David / dhildenb


