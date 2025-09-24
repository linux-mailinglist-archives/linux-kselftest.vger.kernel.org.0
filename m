Return-Path: <linux-kselftest+bounces-42166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA42B98B0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C116E7B60FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF94284B37;
	Wed, 24 Sep 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vgo3cKoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA381284B26
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700133; cv=none; b=umjV+EPdTCBnUWX9TY6FYXHfy+9LJZ2eF/KuO7oNR3gUhIrreTDKHIlsqInug0DJ0tHEFkRQGkmQYnIX82VDKgeavTMlWZmut2CCZJv8Fv5excQf2cXWaDuEtRHTiPT1Nh4Ma3n2QzjCr0TkQzFtf6vDWV8NeiB3Uz4myxCn1EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700133; c=relaxed/simple;
	bh=ntgz0WoIRVipjrzOQMbzUgc/QyjDqtJ9eBcmpETq3SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+KZHKzgKMwhBVvzz6KKvXLk/1qHP6w7DOJq8RVbVHY6YnuPl2yaFTZS5yVL1UiqmBrgfgFEsNHWUxcBsEuLSG4cZcgXvyRuWXeTxnngZOcPvHDRXroQud6L4Dn6SMexdyfKZMvA997z8+fMbX2VjOW0JIaPj8oBYu4/OokYzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vgo3cKoc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so43715245e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758700129; x=1759304929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=Vgo3cKocO9IKPAvFAUXQCY1KpmVTN2f1h1FQPIA+GpkLA4VqhPu6o1VF71lkxX2sjT
         zHfHdxfX+1Pi66GTtnma5ywW3EgNB/Ej/3mtC8EY5IEz1z5rupqzP9vlXq2RmYMLrKSR
         eVxYeA7Uq6u/aZR0ZOQREL77KOqHgj8BN4nPj6F7H6DMuaBMKGZTwvKTg9ggwLPiXEDv
         JW5brNLHUaM6ZHpNTb//6VTK9l6UwfzpLhDP2x1xqauShDf478VAj+74iGhiQP5Qax/L
         Zhz5Xsi/aNWIPufa7BYGyoeT9PzuRDd0gzPahqUgE0TMOMUcTFeoi/KG4IznyHZ4tp+b
         FU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700129; x=1759304929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8l3AdnOSsRSws2FudDrnNOobQlzeM81boeBiHgd3uA=;
        b=jzqreNk1o4UbVD0EuzCsAPR0M4SME3T6SjDjHVMmo0MqxJqmTUO6dlgr64R3r5WbbH
         ZlpxwhtTCj3wWkPOHkbiqhu1orgwDn/A3LGBCKE6p5VHOS754Di0/SGgsL3yYvesZDwe
         hmTEoQPgN/OXQU1Z3Iv968MSd2GY5rBoipWp/lWraZiNWMIHD09rEl9j9nz3KSSEfwt2
         RDbwB+/uAC1dhJ/4U3r6VA33273IA41LIFrvsWceF0D7ZEbM3b8EWR9lJqemYeP06Dfm
         XSs1vtRaehtNRowoTKVkrN41su63dUOImjMJK5WGHblSSretWPHIP39KGUBuiCKR73fz
         vVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoiMKJS3w1ejHHEpOS65wShcakfs8P6/jVprZM2eyW7vZP89KPN6eftCDGIaGehCJR9mFVRte0Gb8DJ09B1Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpLOqXEddcrLU2EAQCAFSPW1gem7XLE1doujKC2chhvjlBBGL
	5Ccgzy0w2o9Uxt42s0ckkXS2tN0/zbOvf0YpE7nhQM/QA0Sebu2IsPKwelEFt6j7U7o=
X-Gm-Gg: ASbGncv/rNYKoyeebxQWAijRWQ2AyKMVxxMnZokLMPpT5wDQAILDzIRuBMsFhaE5tDx
	ePKqwT9Tgeq1PFUw5mwhKk7UW5CxMjvClutCukSCW2NiYE+BxBUmA5/pKoEeB/MSYoGrJ4JTtx3
	oP2Yd9k+qLIosARyH0voNgoT9aOyzlqaqq1C1tdk5TB7EV2lU6XsBzrhjA5yZPCtT7xjg2lAxwA
	9VzoSXxMys7NJ+16i8j7S/9JvihBfyVT1KWuJKO6jYD8I37Sx3yMzcBSrYgCmgLKG5Q1Cyj2KBb
	XXGizghrhNjrYR6PPxRHhq4klucGd5iOI9WHzf/MT2B5b3nbV6KoYGVzaGLwqv7JpeBjdzNHGxo
	Rn/EosUDRmD4RzlNa2+mJUW5CNInPe9HlIj0pMeLiHH93WT/clGU=
X-Google-Smtp-Source: AGHT+IFwNQTWzI6GYN83BC1thuAIQC8cKI7ga+QSPsI75xrmILyCBppuSPCKc3GbCcHRTNLHchQcjw==
X-Received: by 2002:a05:600c:1c87:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-46e1d9746d5mr69959415e9.8.1758700128971;
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af289sm20857535e9.6.2025.09.24.00.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:48:48 -0700 (PDT)
Message-ID: <2071b071-874c-4f85-8500-033c73dfaaab@suse.com>
Date: Wed, 24 Sep 2025 09:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Support FIXUP quirks in modules
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
 Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 Johannes Berg <johannes@sipsolutions.net>,
 Sami Tolvanen <samitolvanen@google.com>, Richard Weinberger
 <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-2-briannorris@chromium.org>
 <c84d6952-7977-47cd-8f09-6ea223217337@suse.com> <aNLb9g0AbBXZCJ4m@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aNLb9g0AbBXZCJ4m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 7:42 PM, Brian Norris wrote:
> Hi Petr,
> 
> On Tue, Sep 23, 2025 at 02:55:34PM +0200, Petr Pavlu wrote:
>> On 9/13/25 12:59 AM, Brian Norris wrote:
>>> @@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>>>  		return;
>>>  	}
>>>  	pci_do_fixups(dev, start, end);
>>> +
>>> +	struct pci_fixup_arg arg = {
>>> +		.dev = dev,
>>> +		.pass = pass,
>>> +	};
>>> +	module_for_each_mod(pci_module_fixup, &arg);
>>
>> The function module_for_each_mod() walks not only modules that are LIVE,
>> but also those in the COMING and GOING states. This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked, and similarly, a fixup can be executed after the
>> exit function has already run. Is this intentional?
> 
> Thanks for the callout. I didn't really give this part much thought
> previously.
> 
> Per the comments, COMING means "Full formed, running module_init". I
> believe that is a good thing, actually; specifically for controller
> drivers, module_init() might be probing the controller and enumerating
> child PCI devices to which we should apply these FIXUPs. That is a key
> case to support.
> 
> GOING is not clearly defined in the header comments, but it seems like
> it's a relatively narrow window between determining there are no module
> refcounts (and transition to GOING) and starting to really tear it down
> (transitioning to UNFORMED before any significant teardown).
> module_exit() runs in the GOING phase.
> 
> I think it does not make sense to execute FIXUPs on a GOING module; I'll
> make that change.

Note that when walking the modules list using module_for_each_mod(),
the delete_module() operation can concurrently transition a module to
MODULE_STATE_GOING. If you are thinking about simply having
pci_module_fixup() check that mod->state isn't MODULE_STATE_GOING,
I believe this won't quite work.

> 
> Re-quoting one piece:
>> This means that this code
>> can potentially execute a PCI fixup from a module before its init
>> function is invoked,
> 
> IIUC, this part is not true? A module is put into COMING state before
> its init function is invoked.

When loading a module, the load_module() function calls
complete_formation(), which puts the module into the COMING state. At
this point, the new code in pci_fixup_device() can see the new module
and potentially attempt to invoke its PCI fixups. However, such a module
has still a bit of way to go before its init function is called from
do_init_module(). The module hasn't yet had its arguments parsed, is not
linked in sysfs, isn't fully registered with codetag support, and hasn't
invoked its constructors (needed for gcov/kasan support).

I don't know enough about PCI fixups and what is allowable in them, but
I suspect it would be better to ensure that no fixup can be invoked from
the module during this period.

If the above makes sense, I think using module_for_each_mod() might not
be the right approach. Alternative options include registering a module
notifier or having modules explicitly register their PCI fixups in their
init function.

-- 
Cheers,
Petr

