Return-Path: <linux-kselftest+bounces-32547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0936AAD236
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 02:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C041BA8AF1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7CA94A;
	Wed,  7 May 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfZ0be1b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606046BF
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577258; cv=none; b=kWXj3Fwj/9ZVxJUoTIgU7/FV571FeOxMVNXc7icX7OC2GAE529JqsMKQ4uDawqeQ/qDMlGWIaEsCkRfW7Cjtzo81fqdq//dhnAu2dwW1OoNfXeyOS9C9ywqtFMuyODvNri0ALCFMZtllj9nE5EU4T6TpTk/o2uvdrbFZGov/Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577258; c=relaxed/simple;
	bh=G6gAUQycut/T+2CZirkREPT2GpqAeWue10g5qr+MmfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6o2iCLkaLyc5G8xS665um1OPK5FOMFwNuPQ1jUihAPlSKbZCcOPCBhdivjo5mm3uo/0GvaOcSqMaXI9C3w1sNsC8bE/xk2oT4Vp4sPkv6FoIwydt8g732HX/nZiIi15QiNwlh6OVeYfMuo2A9XqZvjiCb+ccYSu3hGNpX/MFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfZ0be1b; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so163217439f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746577255; x=1747182055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1p8Te43sC4t3hJ6UV6SjoKwR9VsORN78Fe3DTZ7doec=;
        b=AfZ0be1b3f0c5zh2unFqt/5r7cnMgAAfgOmX8lZ2899bwjGn2kiUdk2iO9Gm1kx8Nl
         BEdowkBDFRc3nB64KpTvLCQtvhxjtoP0gs39Z4APwzr+lWkT7mvh6c/W/ikc4jDegDA8
         XMgczl+WWxNj0rZUecLnR7Oaok7KRIb72p8hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746577255; x=1747182055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p8Te43sC4t3hJ6UV6SjoKwR9VsORN78Fe3DTZ7doec=;
        b=d+qBmXzgRRbjRMEfvDTrONs3Hphsn6m+gam3mmkZdtkdlGYEYZ/sHWO57vV4vJig5Q
         SuKyQsjQRx7JSTPdv1naBX0tuYXCDtMkP58mTjB5UP4RlkJnxufX9VDMs1Mrij8upE7D
         WbT6/oiZt+Bj9juVhm+TCuKv0BnWsvdfmccfRCGJ8uK+I1s/8YldjBqG0I/cFwk+x9Dl
         5RaMUeV7liwRf19XxsYA0FEBOZEHKgtAj0RcuUUBtYJP2NRPS5idV+WyNYW6qt9GMZZH
         2/GyYd59idDUs3XOmXO/jo2G/7n++3xXkVVOlPgtlvxTXiADoo2NYGGa7uTGMmJXNcNM
         1bzg==
X-Forwarded-Encrypted: i=1; AJvYcCX/1NXanZGYvkuyTJYyxjH86dkqi2cpBmrmvV5cmdxmoKy7aCEp8whORIamdHtJpLU16il288FJ1g3HUbOskyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Zs1hdz9o38bLjAqnVN4985XMf7ldjEcc1eRAXOdaMS+o3zry
	+2Ob1NEPMoIziTRPo6xbBb3rOK+t37Ec+U68waXVCSfCBZ4TfQQF0k/llPStGUE=
X-Gm-Gg: ASbGncvLtwVxcfbgrsyKHeXKy943jh8k81VRz1J+NAI/881UXsmNvUb5uEetcAFM7/e
	WsEKHmlZR3BoV9hhV3z+bsSEAmk3fgTb4ks4RdmzScp3/DvnR34SAZxwHRoepW5znU/n4f/HDNK
	BVjzZJ8C4rUlICFYzz38QGIKUB8UctP6e3elzlNQGjB7QhMPkFQ8yFa6IbQ4LANcoFWw90dqwad
	pQucb/oVjSrEVP6cMihEUP01Ov0kqh6qWVix1Wd6TCjRT4Pe6RzJN42nyhYQXFHWyVxDpqiC4CL
	g8WRzyKmJcMqQWl5Jg9qc8yX0rWmzEQSxR/Ay7qz5MFNVp8Z6EU=
X-Google-Smtp-Source: AGHT+IH7QbHC9bqwsqypvxUzmNSPFB9WbqLDm+bCP/SWmCn31scTykEeIuT9VsesmC58fV0f4we/7Q==
X-Received: by 2002:a05:6602:490:b0:862:ba37:eb0e with SMTP id ca18e2360f4ac-867473b0b2emr213153439f.12.1746577255116;
        Tue, 06 May 2025 17:20:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a8cfb51sm2461914173.3.2025.05.06.17.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 17:20:54 -0700 (PDT)
Message-ID: <37234cf8-ac79-45b8-9bcf-dcf4792b9877@linuxfoundation.org>
Date: Tue, 6 May 2025 18:20:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: use ARCH from compile.h in unclean source tree
 msg
To: Nicolas Schier <nicolas.schier@linux.dev>
Cc: masahiroy@kernel.org, nathan@kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250502172459.14175-1-skhan@linuxfoundation.org>
 <20250506-accomplished-earthworm-from-valhalla-dbcbcc@l-nschier-aarch64>
 <0d27886e-5a3c-4073-a044-f6684de8333d@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0d27886e-5a3c-4073-a044-f6684de8333d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/25 16:07, Shuah Khan wrote:
> On 5/6/25 05:12, Nicolas Schier wrote:
>> On Fri, 02 May 2025, Shuah Khan wrote:
>>
>>> When make finds the source tree unclean, it prints a message to run
>>> "make ARCH=x86_64 mrproper" message using the ARCH from the command
>>> line. The ARCH specified in the command line could be different from
>>> the ARCH of the existing build in the source tree.
>>>
>>> This could cause problems in regular kernel build and kunit workflows.
>>>
>>> Regular workflow:
>>>
>>> - Build x86_64 kernel
>>>     $ make ARCH=x86_64
>>> - Try building another arch kernel out of tree with O=
>>>     $ make ARCH=um O=/linux/build
>>> - kbuild detects source tree is unclean
>>>
>>>    ***
>>>    *** The source tree is not clean, please run 'make ARCH=um mrproper'
>>>    *** in /linux/linux_srcdir
>>>    ***
>>>
>>> - Clean source tree as suggested by kbuild
>>>     $ make ARCH=um mrproper
>>> - Source clean appears to be clean, but it leaves behind generated header
>>>    files under arch/x86
>>>       arch/x86/realmode/rm/pasyms.h
>>>
>>> A subsequent x86_64e build fails with
>>>    "undefined symbol sev_es_trampoline_start referenced ..."
>>>
>>> kunit workflow runs into this issue:
>>>
>>> - Build x86_64 kernel
>>> - Run kunit tests:  it tries to build for user specified ARCH or uml
>>>    as default:
>>>     $ ./tools/testing/kunit/kunit.py run
>>>
>>> - kbuild detects unclean source tree
>>>
>>>    ***
>>>    *** The source tree is not clean, please run 'make ARCH=um mrproper'
>>>    *** in /linux/linux_6.15
>>>    ***
>>>
>>> - Clean source tree as suggested by kbuild
>>>     $ make ARCH=um mrproper
>>> - Source clean appears to be clean, but it leaves behind generated header
>>>    files under arch/x86
>>>
>>> The problem shows when user tries to run tests on ARCH=x86_64:
>>>
>>>     $ ./tools/testing/kunit/kunit.py run ARCH=x86_64
>>>
>>>     "undefined symbol sev_es_trampoline_start referenced ..."
>>>
>>> Build trips on arch/x86/realmode/rm/pasyms.h left behind by a prior
>>> x86_64 build.
>>>
>>> Problems related to partially cleaned source tree are hard to debug.
>>> Change Makefile to unclean source logic to use ARCH from compile.h
>>> UTS_MACHINE string. With this change kbuild prints:
>>>
>>>     $ ./tools/testing/kunit/kunit.py run
>>>
>>>    ***
>>>    *** The source tree is not clean, please run 'make ARCH=x86_64 mrproper'
>>>    *** in /linux/linux_6.15
>>>    ***
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>>   Makefile | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 5aa9ee52a765..7ee29136b4da 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -674,7 +674,7 @@ ifeq ($(KBUILD_EXTMOD),)
>>>            -d $(srctree)/include/config -o \
>>>            -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
> 
> Would it make sense to check for include/generated as a catch all?

Adding check is good, but it won't cover the compile.h missing. I don't
know if compile.h could go missing if include/generated exists. In any
case, it is good to check for compile exists or not and print appropriate
message for these cases.

I have the change working. Will send it out. Thanks for the tip on
the (rare) cases.

thanks,
-- Shuah

