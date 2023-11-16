Return-Path: <linux-kselftest+bounces-217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945947EE1B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA61280FA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB372EB13;
	Thu, 16 Nov 2023 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZeej9rs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F09C
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700142089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsSXUyt/e0sQuOdfCJ7zam0EkNtcBbRjeB4I9K3C2uc=;
	b=FZeej9rs80Yi8rdgkn5tPdAfj5vc1e0AB5NPqoajBeYnkLVAiU/QmqVHJFXbZ8AIZOslvJ
	46utXeMAt2xKCWVzStdoxTw+YIrn9QAR/V/SVz4ngpiF257+/cExt94akCCIDNGM5sFwLN
	iGKxuiOorGaje7my/YKG3R/Jg9qcKyM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-2EGtPt5hMaSRbG2XpVYI2w-1; Thu, 16 Nov 2023 08:41:28 -0500
X-MC-Unique: 2EGtPt5hMaSRbG2XpVYI2w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77bc58d49dfso88318285a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 05:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142088; x=1700746888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsSXUyt/e0sQuOdfCJ7zam0EkNtcBbRjeB4I9K3C2uc=;
        b=Un16lIR+qOE9HvpnvRWO3aRLuVI1S4dcLhdnALWgm7ILrVUdeX4rmSDhaU/HOurq5k
         FPKAbsTOQ7bDDAVJ/KZ91SNh+vh0E6V01S1+4qWnX3yU3idDAo+DrDwjUVCcZwrdq2Cd
         ZbWdRQJycSaJx0Hlt6xEjTpsBJoRzCjvxEW1Tk+cNGcjYCX8Qxcuu+u4q5zTJFkiaVAn
         U+ZR0UmuJrW4u4tTKyrV8V0+GD4xzLBSlHWoFMMmd5p9Bdk/7atC6Yv8DQoGoJazMDnK
         N8ztO2OaRCTUbu4YJl4HXrW8LUXe9s6okqN8VnZZlzC9oJ4+MIefPl7vIKIhkAoeNz1E
         ii8Q==
X-Gm-Message-State: AOJu0Yy8fA6XmiOnEkizHAKxfPGdEVWl3RzNOwKVZkqh85ZUgsIuooi3
	qxXemNVrLZMQYz7zE9UBl5c7cm2LDaufFZXL8/iDMT0Alxis6wrDcijyky/xwFHYoMP/d+iK2Eh
	bzwXI6YJNNzMMsLZywMATVRLLibU9
X-Received: by 2002:a05:622a:488:b0:421:b9cb:933b with SMTP id p8-20020a05622a048800b00421b9cb933bmr9083236qtx.11.1700142087748;
        Thu, 16 Nov 2023 05:41:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP+XXYET5Ab+tO0229Z6CnnoDuA52rBAaPnwBvw0yeaoWDBt8JoZdd6VV2qb69IdSrAAk+nQ==
X-Received: by 2002:a05:622a:488:b0:421:b9cb:933b with SMTP id p8-20020a05622a048800b00421b9cb933bmr9083209qtx.11.1700142087439;
        Thu, 16 Nov 2023 05:41:27 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id bb41-20020a05622a1b2900b0041817637873sm2706590qtb.9.2023.11.16.05.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:41:26 -0800 (PST)
Message-ID: <0f517de6-9eea-4641-a1dd-4631360fbe5f@redhat.com>
Date: Thu, 16 Nov 2023 15:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>, workflows@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Charles Han <hanchunchao@inspur.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Unit Tests <kunit-dev@googlegroups.com>,
 Linux Kernel Self Tests <linux-kselftest@vger.kernel.org>,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <ZVYXEry40HTCis00@archie.me>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <ZVYXEry40HTCis00@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/16/23 15:20, Bagas Sanjaya wrote:
> On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
>> Make scripts/checkpatch.pl ensure any added V: fields reference
>> documented test suites only, and output a warning if a change to a
>> subsystem doesn't certify the required test suites were executed,
>> if any.
>>
>> If the test suite description includes a "Command", then checkpatch.pl
>> will output it as the one executing the suite. The command should run
>> with only the kernel tree and the regular developer environment set up.
>> But, at the same time, could simply output instructions for installing
>> any extra dependencies (or pull some automatically). The idea is to
>> get the developer into feedback loop quicker and easier, so they have
>> something to run and iterate on, even if it involves installing some
>> more stuff first. Therefore it's a good idea to add such wrappers to the
>> kernel tree proper and refer to them from the tests.rst.
> 
> Does it also apply to trivial patches (e.g. spelling or checkpatch fixes
> as seen on drivers/staging/)?

Do you mean, will checkpatch.pl suggest executing test suites for trivial 
patches as well? If so, then yes, of course. These are inevitable victims of 
such mechanisms in general, and it's hard to make an exception for them, but 
we have to consider the overall benefit of having more uniform testing vs. 
making trivial changes a bit more difficult.

Nick


