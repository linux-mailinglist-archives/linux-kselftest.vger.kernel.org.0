Return-Path: <linux-kselftest+bounces-389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90C7F3576
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 19:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAB9B214AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C25B212;
	Tue, 21 Nov 2023 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBgEpDRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB1F12C
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 10:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700589742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yf6+OqDU33FdIyPnh42M7nerK/HZctSltnWYJNnLM3k=;
	b=PBgEpDRjTbbfmsChPTQISEDL5XuDYjeMWMacXRTkJFXedrbi5ufaXgw2Gz7pbcgvXEVSLv
	jSZbGaePA9hZWkOsbtsRAybsFA0Y2VpmYd6eXIVJnL5meMH5eesF4t6siFzlz8d3AOZHPe
	0XP6+ul7+qP/TfVjonaY1uujIESXADU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-ojQfnErOMZy1dDHz3r8Now-1; Tue, 21 Nov 2023 13:02:20 -0500
X-MC-Unique: ojQfnErOMZy1dDHz3r8Now-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d7b90c8ecso56747156d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 10:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589740; x=1701194540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf6+OqDU33FdIyPnh42M7nerK/HZctSltnWYJNnLM3k=;
        b=u2ObT3FFLFOkAGxjAYPxOF2H6eRMfyRbefhbrFBBEDl7RBvvCt9crrdWWL7R1Sk4vr
         JU9FJbnSYIEdgWXCUU2sco+xttQAbnWBLZx5NYHYez/H7VGPB8p0mDgvx7OcL1qvadry
         TVx95iZ2ao+WDAQRKmEMGqyyTt2YC7RLT8BbdmikaDg7o3f2P0xId42o1uD9Q5ePZoON
         agXyCIuucTZWdWb3BwK58QMSjXWKLfPFL6u2Lw5VR1lvfOFRw1c5osmNRxqSr5Jut/CT
         FH2YKJ4u/5qUnL4n1DN8jTIDSljDkwXj9uO771RCd+Ue0dqFGqaF0FtXiwLdR5fhgSOx
         q9uw==
X-Gm-Message-State: AOJu0Yw6gfJJYA9goWLZ8q0ZeVxk35NmA52AZdMDoRsi1eTm6/T5wfUi
	0bhUdARvYHhuE/4iu4PJZrx3Feh6A5zyL/e5i2Huo39BtWB29e2noeUqhv4G3RJwrbdQEB+9wT7
	v7JU8jM92rH3N++c8KPMXl5gzh54N
X-Received: by 2002:a05:6214:1945:b0:677:fb3c:2189 with SMTP id q5-20020a056214194500b00677fb3c2189mr18408405qvk.39.1700589740186;
        Tue, 21 Nov 2023 10:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoEG1UlzpT2qdb7kbat2sfVcRwhd5K3h5HOqjrN1kpEGZpnFJp5FxbddZ4WY+0Qnz3ytPIAw==
X-Received: by 2002:a05:6214:1945:b0:677:fb3c:2189 with SMTP id q5-20020a056214194500b00677fb3c2189mr18408374qvk.39.1700589739925;
        Tue, 21 Nov 2023 10:02:19 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id pw9-20020a05620a63c900b0076db1caab16sm3809476qkn.22.2023.11.21.10.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 10:02:19 -0800 (PST)
Message-ID: <6e50731e-1391-4a8e-9f32-adaa4f8a5119@redhat.com>
Date: Tue, 21 Nov 2023 20:02:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc: workflows@vger.kernel.org, joe@perches.com, apw@canonical.com,
 tytso@mit.edu, davidgow@google.com, rostedt@goodmis.org, broonie@kernel.org,
 skhan@linuxfoundation.org, djwong@kernel.org, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, vkabatov@redhat.com,
 cki-project@redhat.com, kernelci@lists.linux.dev
References: <87sf50imba.fsf@collabora.com>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <87sf50imba.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ricardo,

On 11/20/23 15:30, Ricardo Cañuelo wrote:
> On mié, nov 15 2023 at 19:43:49, Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com> wrote:
>> Introduce a new tag, 'Tested-with:', documented in the
>> Documentation/process/submitting-patches.rst file. The tag is expected
>> to reference the documented test suites, similarly to the 'V:' field,
>> and to certify that the submitter executed the test suite on the change,
>> and that it passed.
> 
> I think the 'V:' field in MAINTAINERS is a good addition to document
> what developers are supposed to test for every subsystem, but in the
> case of the per-commit "Tested-with:" tag, I think the real value of it
> would be in using it for accountability and traceability purposes
> instead, that is, to link to the actual results of the (automatic) tests
> that were used to validate a commit.
> 
> This would provide two important features:
> 
> 1. Rather than trusting that the tester did things right and that the
>     test environment used was appropriate, we'd now have proof that the
>     test results are as expected and a way to reproduce the steps.
> 
> 2. A history of test results for future reference. When a regression is
>     introduced, now we'd have more information about how things worked
>     back when the test was still passing.
> 
> This is not trivial because tests vary a lot and we'd first need to
> define which artifacts to link to, and because whatever is linked (test
> commands, output log, results summary) would need to be stored
> forever. But since we're doing that already for basically all kernel
> mailing lists, I wonder if something like "public-inbox for test
> results" could be possible some day.

I agree that it would be good to have a record of the actual test results
uploaded somewhere. For the start, I think it's fine to just have them
uploaded to places like Dropbox or Google Drive, or whatever can be accessed
with an unauthenticated URL.

Otherwise I'm seriously considering opening up submissions to KCIDB for the
general (authenticated) public (with pre-moderation and whitelisting). That
would require a bunch of work, though. We already have basic artifact
mirroring system, but it relies on the submitter hosting the files somewhere
in the first place. So we'd have to add some file upload service to that. And
then we'd have to think really hard on how to keep the access public, and at
the same time not to go bankrupt from somebody scraping our archive in S3
storage. Any help would be super-welcome!

I think we can make space for the results URL after the test name in the
Tested-with: tag. We can probably make up some syntax for the V: field that
would say if the URL is required or not, but it could just be always accepted.
It will be the maintainer's call to require it or not.

I think it should be up to the test to define what their output should be, and
it would be very hard (and not that useful) to unify them in a single output
format (speaking from Red Hat's CKI experience executing many different suites
for the kernel). The test name in the Tested-with: tag would help identify the
format, if necessary.

Nick


