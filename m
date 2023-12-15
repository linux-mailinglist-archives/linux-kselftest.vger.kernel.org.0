Return-Path: <linux-kselftest+bounces-2090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E708E815123
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 21:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DF01F2254C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDC46458;
	Fri, 15 Dec 2023 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFLKVLtd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFE41842
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702672593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqhsEugKtVuOP/CErLGwgtJcZIJDT+/OEzsNO/Pyaec=;
	b=bFLKVLtdwVthuoDJeRvxNahzdKf3+TEDBq+pgByr4XHfeF41NH8h/Q2HfjZ8X+ixBQ9fue
	5T5xA8a7ibVzI9ljBO1jrUJbMfMmDubFXyu0mxxCfRU8sJrzelFtqOeW8AM7kFkwu2PFii
	KAYJgV4guDcbFPd9ugwAwJf7vCkjQMo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-NEpHFWHkMBCDo8WSAfoFyA-1; Fri, 15 Dec 2023 15:36:32 -0500
X-MC-Unique: NEpHFWHkMBCDo8WSAfoFyA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58dcb502313so1319903eaf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 12:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702672591; x=1703277391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqhsEugKtVuOP/CErLGwgtJcZIJDT+/OEzsNO/Pyaec=;
        b=eezxo03ORZRt3b6/HZFM5an9Cf7CP+HClSLWCuGzz+0wRKZdYev5H4XqyjzOV/oLzk
         jkuyL77R8bI5dnXswGZ58101KGs8O69xqviL2wwsywC51Wq85ZMkHrTtrJkAqucOb0SC
         YM6QSTa4KNwfZ7nmdCyWOG1osWfjeWAqUojf+QjDxA80+D4cKvrkR3AJ2ACO9c3QxNwT
         inBmRnrbCrQxJN9d9pu/0/lRlUnz9CQV7UQUpO+Z0vd622iGDEoOS52K6S3Z2LIwpFj2
         trUwGkHzB6upkDpizTDwza8wHvDuwxXIDWTbNy7xI2SCm02+X6uylJjMd9WZHLvOoAJn
         uuGQ==
X-Gm-Message-State: AOJu0Yxp7NxyyEqWG7wxiCdeWAq5AHrZasMm/tguF+7Gf1Xg1ExF4Mzh
	9kxWQs+npTIX2nQzeHgjnwZKTNh4KrtucKsmRVa5oDrZgMcV67/OIX6NsWLRrOwDGKMjXObpMd7
	weX2rNXvyJkGacZZXdKXcqbInO38DtpKaMPWE6qU=
X-Received: by 2002:a05:6359:6b82:b0:16e:579a:4d6b with SMTP id ta2-20020a0563596b8200b0016e579a4d6bmr8756620rwb.18.1702672591021;
        Fri, 15 Dec 2023 12:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwpyGuMx2YomS1YYURUwzmQgXKlPAVYfeFz7G58bPgH6jpGQedpReEFTAX5oswnIusdcpIrA==
X-Received: by 2002:a05:6359:6b82:b0:16e:579a:4d6b with SMTP id ta2-20020a0563596b8200b0016e579a4d6bmr8756610rwb.18.1702672590685;
        Fri, 15 Dec 2023 12:36:30 -0800 (PST)
Received: from [192.168.1.14] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id w14-20020a0cef8e000000b0067f172531cbsm891936qvr.114.2023.12.15.12.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 12:36:30 -0800 (PST)
Message-ID: <8a433f12-b930-6095-9a49-db5f1d2836b5@redhat.com>
Date: Fri, 15 Dec 2023 15:36:28 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: mpdesouza@suse.com, Marcos Paulo de Souza <mpdesouza@suse.de>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
 <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
 <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
 <alpine.LSU.2.21.2312061530470.13051@pobox.suse.cz>
 <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/11/23 16:53, Shuah Khan wrote:
> On 12/6/23 07:39, Miroslav Benes wrote:
>> Hi,
>>
>> On Tue, 5 Dec 2023, Shuah Khan wrote:
>>
>>> On 12/5/23 05:52, mpdesouza@suse.com wrote:
>>>> On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:
>>>
>>>> 0003-selftests-livepatch-Test-livepatching-a-heavily-call.patch has
>>>> style problems, please review.
>>>>
>>>> NOTE: If any of the errors are false positives, please report
>>>>         them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>>>
>>>> I couldn't find any mention about "missing module name". Is your script
>>>> showing more warnings than these ones? Can you please share your
>>>> output?
>>>>
>>>> I'll fix MAINTAINERS file but I'll wait until I understand what's
>>>> missing in your checkpatch script to resend the patchset.
>>>>
>>>
>>> Looks like it is coming a script - still my question stands on
>>> whether or not you would need a module name for this module?
>>
>> I admit I am also clueless here. The module name is given in Makefile. In
>> this case in test_modules/Makefile. I do not know of anything else. There
>> is no MODULE_NAME macro. Could you elaborate, please?
>>
> 
> I see that now.
> 

Hi Shuah,

In the other replies to this thread, Marcos noted that he would add some
text to the commit / documentation on running and building the selftests
directly in the kernel tree (that would get my Ack) ... is there
anything else to be updated for a hopefully final v4 (for your Ack)?

Thanks,
-- 
Joe


