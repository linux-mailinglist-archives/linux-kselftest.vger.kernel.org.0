Return-Path: <linux-kselftest+bounces-1302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74004807599
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528C11C2085C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D947778;
	Wed,  6 Dec 2023 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn+jTRqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549661BD
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701881194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztLXRobUGlRg7eZ1W79vYwaD7gzoNeRhSy97eRCnmUA=;
	b=Mn+jTRqVMyASx0X+FPLuga8QzaIowrYdfuzkfJE6CZCFk7lcIohOw6ylb12dw6Iw4vODP/
	e3wdF6ViDkgQjOjmKCgxZyufisCzub2YGCbasedXdKY3FNquWAp4Y2Kny+Gvo3AsciaklD
	vWJibgibm0ZoqhcmMxXnJdJ6jxNc7/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-IYOjLuxFNTyeXGhZQIh-Lg-1; Wed, 06 Dec 2023 11:46:33 -0500
X-MC-Unique: IYOjLuxFNTyeXGhZQIh-Lg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b5e096365so6495e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 08:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881192; x=1702485992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztLXRobUGlRg7eZ1W79vYwaD7gzoNeRhSy97eRCnmUA=;
        b=FxvexW0OEniAb3gqM66Tu5jiCC/maGXv/Th2PzqxK8ufj5PmDpaN9ergJBcmZgNhKv
         /rrFyrz+KlkjlPtyYYYYfL0y2qL7W87tPQVV1DOI88AkPLvJDl8EAAnpmD2HMj17ME2i
         yc4QU1Qs9A0LvL3gZ7md75hnRTxSvwImfBHLIGuGfZGMcMSaVynV2qJw9D79XMxIO+xc
         76p/sWskdd19ljouXDOrBTgnxk8uaElpDZBZ33ia1IuGNXZOsFNL27LyndDBxXuJUVLM
         Lqj60sex/1wr0soar0zPfATbhl882s/hsIWA+SRee8JjPkK7DKsawQ/rpbYKBQcoQsJY
         Lj6g==
X-Gm-Message-State: AOJu0Ywp6ZmwcyGvq0ii2JbfBowv9Y64uO0XggNysGgtokAgx2r/2h3e
	QuJPzolvWieOG5ccof7kpvxqEQHTCdHBDnrzDjv4b0TlUn/+5yxBsMV3bUX8BW0oPa+EOaRjDbi
	7RiXv4i5q6nxqdKaEVc9ye3TVdkOi
X-Received: by 2002:a05:600c:1713:b0:40c:25be:8a99 with SMTP id c19-20020a05600c171300b0040c25be8a99mr209624wmn.180.1701881192149;
        Wed, 06 Dec 2023 08:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6+sJCQ7NPS9J3bWUaCeQ035R0YndFZiH1h1M8dTENxMmIOZL3Iu6YxOH5ePuLcu7bSBwMbw==
X-Received: by 2002:a05:600c:1713:b0:40c:25be:8a99 with SMTP id c19-20020a05600c171300b0040c25be8a99mr209612wmn.180.1701881191880;
        Wed, 06 Dec 2023 08:46:31 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b004064cd71aa8sm131226wmb.34.2023.12.06.08.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:46:31 -0800 (PST)
Message-ID: <4a5d9c6e-186b-4681-88a6-63c50576adea@redhat.com>
Date: Wed, 6 Dec 2023 18:46:29 +0200
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
To: Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
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
 <fcc8a2d856dda4afbc85e70a36fc9ea903adc922.camel@perches.com>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <fcc8a2d856dda4afbc85e70a36fc9ea903adc922.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 21:07, Joe Perches wrote:
> On Tue, 2023-12-05 at 11:59 -0700, Jonathan Corbet wrote:
>> Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> writes:
>>
>>> Introduce a new tag, 'Tested-with:', documented in the
>>> Documentation/process/submitting-patches.rst file.
> []
>> I have to ask whether we *really* need to introduce yet another tag for
>> this.  How are we going to use this information?  Are we going to try to
>> make a tag for every way in which somebody might test a patch?
> 
> In general, I think
> 	Link: <to some url test result>
> would be good enough.
> 
> And remember that all this goes stale after awhile
> and that includes old test suites.

Yeah, things go stale, for sure. And Link: will work for specifying the test 
results (provided the contents says what the test was), but it doesn't help 
maintainers to know immediately which tests were executed and which weren't.

It also won't allow involving checkpatch.pl in checking the submitter ran all 
the required tests, and telling them to run whatever they didn't.

Nick


