Return-Path: <linux-kselftest+bounces-218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C047EE1BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2824E1F2461F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88F2EB13;
	Thu, 16 Nov 2023 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbfJo4Uh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC0A0;
	Thu, 16 Nov 2023 05:43:24 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc0e78ec92so6450835ad.3;
        Thu, 16 Nov 2023 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700142204; x=1700747004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqxTrnOujdy/nYz+c4pJkGoTHd351bDKHsXR781Nnak=;
        b=cbfJo4Uh2j/t39joPg/qxfRFxsFDWm49n62yw5CPmUwSSI2DvZG8zeJE3N86rtZtAn
         QaBb8sTYK7FDRhsBmwYPhL9RNxgj/1MFi3pK+CxuIewE6z8ht+9ocnDGghJb29oB++ur
         h8xl2PSIDTKD1GiRXClkE/0MIk1lonI3CLmWr3OePSVvkTSIKEtWisOODzwnmaWSZ7ks
         eaz9N9K+B4oJyCpT0yL2TWcuuEY0/NqjyPHoEzAWKQoTmH1whxjPhROapOV6/6Cnqk+C
         W5UAaPCiNvc/MKWQFC+I8ccy5W2Hll2WHF/0cF/ml3d75ZF2Ku0ZJ8evKOg6mgW4sdL5
         0wAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700142204; x=1700747004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqxTrnOujdy/nYz+c4pJkGoTHd351bDKHsXR781Nnak=;
        b=PCYtnOZH1X31MxQHR0pzNl3Hnk0lmPz5VgTFgqDJPGgwBmiQGhnZ6bc7XpczXzl/P8
         tEtlSVZhVtFBnSCQERPx2/0ycSGZQxZanOZkioE+q2WrRZ5q375j+0ty3G9BP86B+jr/
         K5b8d+aqaw8Hg+fGuLhDBBjfeE0jPJRul6QKcvP7dHtHlBBHQM4Fza8+a1xRR9YjJNhT
         QRtDybItC8D+e66kMxj28IVS5A79TLX2Qz6Ane/dWgX3W8Ga4m5boQMc1ArG2Pj9X4Qt
         S562PralMYk1ygdsX7BVMttaQ58uQek8dMNP1pCpcPvHQJN5fxoIJxJU0fRgYS9ngdBZ
         9NbA==
X-Gm-Message-State: AOJu0YyVpBQq4DoxeaxZf/bNQJ9/sKm+hKCJfz3gj3XTDrhSS1sDZP6/
	eYqPyUEXIO/aCO3iQDO5RVA=
X-Google-Smtp-Source: AGHT+IFWfUiIdUAuddWFdFYM8+CmBIlNqjS9jfS5sD1HpxVboDTNcs9BIeDE0HkK8N0x7Dp+7+mp0Q==
X-Received: by 2002:a17:902:bc84:b0:1c6:b83:4720 with SMTP id bb4-20020a170902bc8400b001c60b834720mr1919856plb.63.1700142203852;
        Thu, 16 Nov 2023 05:43:23 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001c5fc291ef9sm9225411plg.209.2023.11.16.05.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:43:23 -0800 (PST)
Message-ID: <d7820a7a-4d30-4db8-9829-078eb6781454@gmail.com>
Date: Thu, 16 Nov 2023 20:43:17 +0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Darrick J . Wong" <djwong@kernel.org>, Charles Han
 <hanchunchao@inspur.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Unit Tests <kunit-dev@googlegroups.com>,
 Linux Kernel Self Tests <linux-kselftest@vger.kernel.org>,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <ZVYXEry40HTCis00@archie.me>
 <0f517de6-9eea-4641-a1dd-4631360fbe5f@redhat.com>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <0f517de6-9eea-4641-a1dd-4631360fbe5f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/23 20:41, Nikolai Kondrashov wrote:
> On 11/16/23 15:20, Bagas Sanjaya wrote:
>> On Wed, Nov 15, 2023 at 07:43:49PM +0200, Nikolai Kondrashov wrote:
>>> Make scripts/checkpatch.pl ensure any added V: fields reference
>>> documented test suites only, and output a warning if a change to a
>>> subsystem doesn't certify the required test suites were executed,
>>> if any.
>>>
>>> If the test suite description includes a "Command", then checkpatch.pl
>>> will output it as the one executing the suite. The command should run
>>> with only the kernel tree and the regular developer environment set up.
>>> But, at the same time, could simply output instructions for installing
>>> any extra dependencies (or pull some automatically). The idea is to
>>> get the developer into feedback loop quicker and easier, so they have
>>> something to run and iterate on, even if it involves installing some
>>> more stuff first. Therefore it's a good idea to add such wrappers to the
>>> kernel tree proper and refer to them from the tests.rst.
>>
>> Does it also apply to trivial patches (e.g. spelling or checkpatch fixes
>> as seen on drivers/staging/)?
> 
> Do you mean, will checkpatch.pl suggest executing test suites for
> trivial patches as well? If so, then yes, of course. These are
> inevitable victims of such mechanisms in general, and it's hard to make
> an exception for them, but we have to consider the overall benefit of
> having more uniform testing vs. making trivial changes a bit more
> difficult.
> 

Yes, that's what I mean. Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara


