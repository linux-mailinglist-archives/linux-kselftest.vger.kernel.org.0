Return-Path: <linux-kselftest+bounces-1303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5798075DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E45BB20D3D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF20495E5;
	Wed,  6 Dec 2023 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAGil8+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598ACD50
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701881701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atxHvBL0eYNcgagFI4r9frbYTqT5z/NDxowpslDH6qQ=;
	b=hAGil8+KzhTAUV+ErKM+YLWMdKSyEPOiSh9JD0o/rCxUP+XQzy8L3cyrAbpycVrIXMCW4s
	DSIqaMFYN+4feHzYgQ273Scw7tYqHRpmjIeBOARXmSMqXlFD646X10mjo+RkHugChaRosx
	faIcz2h+pvIgHxb2KlLzB6kvlp4qanM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-Ol7bxNc0NbCPxivi4o0jqA-1; Wed, 06 Dec 2023 11:54:59 -0500
X-MC-Unique: Ol7bxNc0NbCPxivi4o0jqA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a4c765d3bso125295e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 08:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881698; x=1702486498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atxHvBL0eYNcgagFI4r9frbYTqT5z/NDxowpslDH6qQ=;
        b=XcOz8cEZuzftzSb+qECO11CBG2TMUBQfta4eR0Y2yfT6iwgOG8vJwTSlMaRkk0BqCN
         lkjjvQL9ioIPyoZ074c4F46MuVNx2suoE+qGLjfR3ctyFZOjhRvJZ6PxnsB5hZzFbdMy
         6pGZ0KJos/8N7veOuDmOYBGKtwb8Bcvt3wWxp2aI/KYcov6CoH45/a9Xi0RQaawR8leM
         2V9sP/nxKXxvG7DtPZ85uxNtYNyTsUMaJXNDzCFcNcDxIi4XcLDihKkKR0bRZXzLMEjP
         K5rX2kyq5nOUMJ4YZvL/7KwIVo4ZX3OoHbXShfazcb3YzWtlMAYe6V569s5GscYFP/SJ
         n9IA==
X-Gm-Message-State: AOJu0YyMtDoKEFPLk98vJakvlcqE0onzLcLy7TzAmDPE+V2Zg9VDXoxf
	/bAKoOwQpQM6c1yr5a1KP7KJDrryPItIThP76eneLNwLYtW2Hj8lTtpJtZY2TEij1Eivbr08Z4n
	zzMQUsBALTASOlgcQbbWHVpfcUUEg
X-Received: by 2002:a05:600c:3b25:b0:40b:29e7:c150 with SMTP id m37-20020a05600c3b2500b0040b29e7c150mr1766011wms.0.1701881697987;
        Wed, 06 Dec 2023 08:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGApzDn3gWY0wzR7OuPjSeHht/rxmk49mHdttKkYgnXEeSZCGG+1ECABcB8N2fpPvSO1UG/3Q==
X-Received: by 2002:a05:600c:3b25:b0:40b:29e7:c150 with SMTP id m37-20020a05600c3b2500b0040b29e7c150mr1765993wms.0.1701881697689;
        Wed, 06 Dec 2023 08:54:57 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id ay17-20020a05600c1e1100b004063cd8105csm251204wmb.22.2023.12.06.08.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 08:54:56 -0800 (PST)
Message-ID: <1a3ad44d-cdc5-4dd0-a734-49b197ad1c37@redhat.com>
Date: Wed, 6 Dec 2023 18:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/10] MAINTAINERS: Support referencing test docs
 in V:
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
 Theodore Ts'o <tytso@mit.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "Darrick J . Wong" <djwong@kernel.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-7-Nikolai.Kondrashov@redhat.com>
 <CABVgOSnW1Yzz-1Zdr-k-qWL25yUDZo+jbhPwNkK7dG-8-WonFg@mail.gmail.com>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <CABVgOSnW1Yzz-1Zdr-k-qWL25yUDZo+jbhPwNkK7dG-8-WonFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/23 10:03, David Gow wrote:
> On Wed, 6 Dec 2023 at 02:45, Nikolai Kondrashov
> <Nikolai.Kondrashov@redhat.com> wrote:
>>
>> Support referencing test suite documentation in the V: entries of
>> MAINTAINERS file. Use the '*<name>' syntax (like C pointer dereference),
>> where '<name>' is a second-level heading in the new
>> Documentation/process/tests.rst file, with the suite's description.
>> This syntax allows distinguishing the references from test commands.
 >
> I like the idea here, but wonder whether it makes sense to put all of
> these tests into a single 'tests.rst' file. There's already lots of
> existing documentation scattered around the tree, and while keeping
> all of the testing information in one place does have advantages, I
> think there's a lot to be said for keeping subsystem-specific test
> docs alongside the rest of the documentation for the subsystem itself.
> And it'd be less work, as the docs are already there.
> 
> So, could we just make this a path under Documentation/ (possibly with
> an #anchor if we need to reference just one part of a file)?
> 
> e.g., something like these, all of which are existing docs:
> V: *Documentation/dev-tools/kasan.rst#Tests
> or
> V: *Dcoumentation/RCU/torture.rst
> or
> V: *Documentation/gpu/automated_testing.rst
> or
> V: *Documentation/process/maintainer-kvm-x86.rst#Testing
> 
> (We could even get rid of the '*' and just use 'Documentation/' as a
> prefix, or the executable bit on the file, or similar to distinguish
> these from scripts.)
> 
> If we wanted to be very brave, we could extend this further to
> arbitrary webpages, like:
> V: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/README

Sure, having a filename (in a specific directory) or a just piece of path in 
the source (sub)tree would work too. The idea of single file was mostly to 
make it easier to access a *catalog* of all tests in a single file with small 
bits of introductory documentation, pointing to the more detailed 
documentation (wherever you prefer it to be) from there.

URLs would work as well for pointing to the docs, but they become somewhat 
more cumbersome and error-prone for use in Tested-with: tags (if we would like 
them), just because of their length and complexity. If we won't care for that, 
it's not a problem.

However, overall, I would be cautious multiplying the ways tests can be 
specified in V: entries (and Tested-with: tags), as that could quickly become 
unwieldy and confusing for humans, who are expected to be interpreting and 
writing them. Especially if the syntax could potentially be ambiguous.

Nick


