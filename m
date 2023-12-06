Return-Path: <linux-kselftest+bounces-1298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B505E807500
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A1A1C20AC9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A1C47778;
	Wed,  6 Dec 2023 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgzJlGSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5385A18D
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701880309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaxlh8wJXgliq/77VlAO9+epZ3Cym7OmXbevnFZtFZE=;
	b=TgzJlGStrpcMMCA362LWwIEg/acE3mPRv940Zic+KPPtQmfAG3upOpp5OS1tGMiissRVJ+
	otZkj6RqPnrcZZYjwEz/OeEmrw3TeFhVgppN11tDCJLaaf0Cucaatvy3eVo9l/KrZluOHu
	gBLJUZ6GuMPMGYig5kC9pO+WQyOJKAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-y144IZMOOuONDWvVBBoOrQ-1; Wed, 06 Dec 2023 11:31:45 -0500
X-MC-Unique: y144IZMOOuONDWvVBBoOrQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c193fca81so7310435e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 08:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880303; x=1702485103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaxlh8wJXgliq/77VlAO9+epZ3Cym7OmXbevnFZtFZE=;
        b=oy+S7CKb+Bm/6JOnLPef2xvigbPssm7rCBa+2VS8R46IkApAF1dc5brLyZlriXrxSp
         VfHTrY+73qr+qLXFeOq9UXPTXwTc5a945vBUwoplWr/esHCjAG5rzavJ7eOoyMvyyDYc
         j/dADamZC3fJp9UnqyEEK2ssB7FWlsoTGOtM47BR3nPjnFYGKl08PNMGtdFs6Wrng2pN
         4rm7OYjtgcky4fxSAevWm0N8yiIvaDClbaCiyhsQ/ixr2yZ6W8s2uIhiXC/AQOOwUDuz
         GwsgQSn/O913Y/IvrkDK6rLmukIAdlf/zYc5iOyKQc7v8LC5f2nvHxFpgs/9BtKfodNY
         URPQ==
X-Gm-Message-State: AOJu0Yw3pxZxeKHnDuQWZJ5QwkdG8qKENdJ+Gpf+vXdlfEBC2SeZfQ07
	klvgkTQ2CyGFGmYuV31oJVN7BhEdGKxCXhRimi42AfQKoxucmgLD9skwYIERi8cNJtl/aCc2E+1
	3AchcVAI5eHE7UxqF82FVv1j+YzVg
X-Received: by 2002:a05:600c:198e:b0:40b:5e1d:839e with SMTP id t14-20020a05600c198e00b0040b5e1d839emr811319wmq.50.1701880303691;
        Wed, 06 Dec 2023 08:31:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFKdeeY63Rr8GYbgHOkzsiRaLtwhKYRqy4GAdN5mZSrmYVw/I5CHGSTTjMHCUL/zUr0j0s6g==
X-Received: by 2002:a05:600c:198e:b0:40b:5e1d:839e with SMTP id t14-20020a05600c198e00b0040b5e1d839emr811312wmq.50.1701880303404;
        Wed, 06 Dec 2023 08:31:43 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id w4-20020adfec44000000b003333dd777a4sm81663wrn.46.2023.12.06.08.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:31:42 -0800 (PST)
Message-ID: <a6184327-953d-4185-af8e-b0c20fb9d6e8@redhat.com>
Date: Wed, 6 Dec 2023 18:31:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/10] docs: submitting-patches: Introduce
 Tested-with:
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, David Gow <davidgow@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
 Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>,
 kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
 <87zfyomq5k.fsf@meer.lwn.net>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <87zfyomq5k.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 20:59, Jonathan Corbet wrote:
> Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> writes:
> 
>> Introduce a new tag, 'Tested-with:', documented in the
>> Documentation/process/submitting-patches.rst file.
>>
>> The tag is expected to contain the test suite command which was executed
>> for the commit, and to certify it passed. Additionally, it can contain a
>> URL pointing to the execution results, after a '#' character.
>>
>> Prohibit the V: field from containing the '#' character correspondingly.
>>
>> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
>> ---
>>   Documentation/process/submitting-patches.rst | 10 ++++++++++
>>   MAINTAINERS                                  |  2 +-
>>   scripts/checkpatch.pl                        |  4 ++--
>>   3 files changed, 13 insertions(+), 3 deletions(-)
> 
> I have to ask whether we *really* need to introduce yet another tag for
> this.  How are we going to use this information?  Are we going to try to
> make a tag for every way in which somebody might test a patch?

How I understand the purpose of this is that, first, people want to encourage 
submitters to test their patches with the relevant test suites, and second, if 
they do, to tell them they did. That is all.

The idea of Tested-with: is to specify *which* test was executed, so I don't 
think we would need another tag.

However, I let people (all copied) who expressed interest in this in the first 
place, and had this discussed earlier, chime in.

I have no specific interest in this particular way, I just want kernel testing 
to improve. If it was for me, I'd rather encourage everyone to just use GitLab 
or GitHub, post MRs/PRs (like millions of other projects do, including other 
operating systems), have tests executed automatically, results recorded and 
archived automatically, commits linked to those results automatically, and not 
mess around with any tags :D

Nick


