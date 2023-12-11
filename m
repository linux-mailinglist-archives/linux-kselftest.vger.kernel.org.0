Return-Path: <linux-kselftest+bounces-1624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1480DDA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F54282569
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FDD54FBE;
	Mon, 11 Dec 2023 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bfd6HASy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E538A1
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 13:56:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b74bc536dbso16632839f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 13:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702331776; x=1702936576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWln+CTTERyZ6ImQ/92s4pzeNQeDoALVr1bp+5tWi4A=;
        b=Bfd6HASyVBFKiddbCav9xD13UkpAkC/+RDM0FWcUg5sLMJgju+dAC/5uW9DMlzRKEx
         IaRADmo3PI4CvyVjdmdkkGI+lnl1kWBBSh5LrhQEmwqSDt6WKVO5EWaBl3Jha6Cd957U
         opexMuPQFSO+OJP28mwWqnKoTBD65sMshOW9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702331776; x=1702936576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWln+CTTERyZ6ImQ/92s4pzeNQeDoALVr1bp+5tWi4A=;
        b=uxurmDCV6XFfq7FsmsFcVITkZTBNEsvIZv1ZdFl5PEKeKpqaLAqV410cSzPPnbgvOS
         JHvIejDX7Z7+/+hulO/rltVmrgug0znK1nc95TOxSZfXpI8dQEcaY9D+/i5tQYxDHigs
         JAs4sA2Oky1KvDfQTZ2WYItbnHEuxjUE2/QiC40xlaC+pHXK+DaPO/UApTlcyz/+Lvlc
         sfs0SNuAdf2OOpKCH49aK5QEfF6JmrdKr9iYSiQppP/YXWNqTwK0W7JOc/gSCmlaBGY8
         jXGkCf9a8ZW5Z6neauV/ZVcJ4yxrc6PM7rZ4JdTRERv5hJl3rVgFEeSLl5Uf6WWvHXeL
         TVKA==
X-Gm-Message-State: AOJu0YyJjE03w4ZCrGLx2Se+M2qXzcMQMjml9qbWGNuGqSqEyIamU4Pn
	sMqfgRCLDm4NFJ3jFoXeA/zUPw==
X-Google-Smtp-Source: AGHT+IF6u9PBe1663T7e/DMZyJ7Y1Ma1Qz6eO0no0u2sL4WErWGwXoWSypjjC6bPS2hdgwcAG+zcOw==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr8560958ioi.0.1702331776554;
        Mon, 11 Dec 2023 13:56:16 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l27-20020a02cd9b000000b0046938c12608sm2097774jap.122.2023.12.11.13.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:56:16 -0800 (PST)
Message-ID: <2c4f2771-0557-4b44-9c98-6bd2e6930d2f@linuxfoundation.org>
Date: Mon, 11 Dec 2023 14:56:15 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Content-Language: en-US
To: mpdesouza@suse.com, Joe Lawrence <joe.lawrence@redhat.com>,
 Miroslav Benes <mbenes@suse.cz>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com>
 <ZWn7dEzVWoKxycmy@redhat.com>
 <alpine.LSU.2.21.2312061543280.13051@pobox.suse.cz>
 <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
 <57fb9f30afbaddb09def96aac11c45296a59a277.camel@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <57fb9f30afbaddb09def96aac11c45296a59a277.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/7/23 12:19, mpdesouza@suse.com wrote:
> On Thu, 2023-12-07 at 10:20 -0500, Joe Lawrence wrote:
>> On 12/6/23 10:05, Miroslav Benes wrote:
>>> On Fri, 1 Dec 2023, Joe Lawrence wrote:
>>>
>>>> On Tue, Oct 31, 2023 at 06:10:52PM -0300, Marcos Paulo de Souza
>>>> wrote:
>>>>> The modules are being moved from lib/livepatch to
>>>>> tools/testing/selftests/livepatch/test_modules.
>>>>>
>>>>> This code moving will allow writing more complex tests, like
>>>>> for example an
>>>>> userspace C code that will call a livepatched kernel function.
>>>>>
>>>>> The modules are now built as out-of-tree
>>>>> modules, but being part of the kernel source means they will be
>>>>> maintained.
>>>>>
>>>>> Another advantage of the code moving is to be able to easily
>>>>> change,
>>>>> debug and rebuild the tests by running make on the
>>>>> selftests/livepatch directory,
>>>>> which is not currently possible since the modules on
>>>>> lib/livepatch are
>>>>> build and installed using the "modules" target.
>>>>>
>>>>> The current approach also keeps the ability to execute the
>>>>> tests manually by
>>>>> executing the scripts inside selftests/livepatch directory, as
>>>>> it's currently
>>>>> supported. If the modules are modified, they needed to be
>>>>> rebuilt before running
>>>>> the scripts though.
>>>>>
>>>>> The modules are built before running the selftests when using
>>>>> the
>>>>> kselftest invocations:
>>>>>
>>>>> 	make kselftest TARGETS=livepatch
>>>>> or
>>>>> 	make -C tools/testing/selftests/livepatch run_tests
>>>>>
>>>>
>>>> Quick question:
>>>>
>>>> - We have been building with CONFIG_LIVEPATCH_TEST=m to generate
>>>> the
>>>>    test modules at kernel build time
>>>>
>>>> - Our packaging filters out the selftest scripts and supporting
>>>> modules
>>>>    from the general kernel RPM package into their subpackages
>>>>
>>>> - Tests are run as part of CKI or other manual tests by
>>>> installing the
>>>>    pre-built packages from the previous step
>>>>
>>>>
>>>> After this patch, we would need to add something like the
>>>> following to
>>>> our kernel build, before packaging:
>>>>
>>>>    $ make KDIR=$(pwd) -C tools/testing/selftests/livepatch/
>>>>           ^^^^
>>>>
>>>> If this is the correct way to build the test modules for *this*
>>>> tree and
>>>> /lib/modules/$(shell uname -r)/build... it might be useful to
>>>> document
>>>> in the commit message as an alternative use case.
> 
> That's right:
> 
> $ make -C tools/testing/selftests/livepatch/
> 
> is indeed the way to build the tests without running them. KDIR will be
> set to  /lib/modules/$(shell uname -r)/build is empty.
> 
> Yes, I can definitely add documentation about it inside the
> tools/testing/selftests/livepatch/README.
> 

How does the default kselftest run work with these changes?

make ksefltest - does this still work as it did before this change?

thanks,
-- Shuah


