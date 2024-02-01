Return-Path: <linux-kselftest+bounces-3960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834484648A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 00:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF052850AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1284C47F42;
	Thu,  1 Feb 2024 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jKsS7RJf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16373CF6B
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830638; cv=none; b=OZL6B51JSeVYRfinFAr6ujWm/bgFRDF/dSBmmtFkmyy7w+JgxflFSVcL+O0ITqIK96ocggceI0nKA7jXAGLvlFmlt969zx9PvnVh6oGSghomDZ+NgkpGO/9b22X9IHmw/cY8LiLQ7lMAaluGE6rx23qYuzN08JlGzVV8JCeGobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830638; c=relaxed/simple;
	bh=72DVGZsPCwexZxLU2zcYfw3TYZY+hy7mlHmIPt0qEn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGFAPDdY/fDDqv1LazlvwEl2AGld/sOQlo7oI5Ac3SGmP83LbMxBgfBHQ0ZXVj/8pYHFI5t4yaBNRN/+hlf23veHwfopllsRxZfcXjuM76tF0k+75LKSSUNdFCppSaIKAzjQ8jbvSBPiekWD05GvkJjBVvZMAjx96+BgjrmpVVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=jKsS7RJf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fc654a718so756835e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706830634; x=1707435434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzbcPdwB7/6WmKWK5IMLm0VrY4vYJq2nVK95Czw1I8U=;
        b=jKsS7RJf92MdORx6jkINA0pOuDH96sV9qqJ7+Nl8R0IPCVr1x3wkKq96MEdikuVFZD
         GWyMYn6mOiv10RGVQKZAzxhz+NuvS6B5AL3orNd+0EcCymq8mI2XXQHjfiYBTe8aLvrt
         9yOVm3Zubm3VrX1byZ6ACJ9DuOruCWIXAU+MpzabYRasExMAx3OI6Hp3QWmMI5Fexw4P
         uYKvaR0qG6lN3yBOSmJmlZs/DgCLMB0j2EVvuD32S3FNQkJMMEzTiAYm9Zd2a8eIDcV5
         tl8s5OxTfXlA5vof/DWoKhdQZ39ncEBVVOqY1lOkBvnogO0eJ+XlrrDoQBEp7vQlorNd
         y4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706830634; x=1707435434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzbcPdwB7/6WmKWK5IMLm0VrY4vYJq2nVK95Czw1I8U=;
        b=UGKwpH3w01m2l0umtTlcea7+4jiXrK+Jn7DZAZsN7CHDqHbw6r7b4GSftfaRTjXRDg
         ftc/HS+rEH/ZhmIk7nXkzNN7LVgq7/yojF4Gs3ldoRgmPFG3qWG1/2L+J6eZzNBLa4FD
         rnh0RjkZK96fYTcI38GCgSC89BLDaogA79Jd7X/Pkq1Tqe/KIY7G7tZv/2sNIfsSgYor
         5WIenptJnZGNdF5ujipG8/dyw8hNszOVMjdORDrojN11R2VaMo40OJbvdzAeepfghLSK
         ens75uE7Q2OiJdyFxCjsN8Xk1KEsdlCPonYOFC/0aj0iY/14f02x5TrT/2Lsw/KP+dCF
         38iw==
X-Gm-Message-State: AOJu0Yx4hwwznq9abhCc1FiTe/QBZFTGPQ5HkKywEGO0HA5moD3fOSm+
	gK3ZgIiQp6+39bnqY798u3E8tyLKPUk5Ojx3E72xsZwaEXO4mDiN3weenDgwiQ==
X-Google-Smtp-Source: AGHT+IEBgyqNdcx7X4WjzGqORG4raBezxBSjVm4nh7egvHo46furQbZLnJchD5Nv8rGb+PkiF1vPTw==
X-Received: by 2002:a05:600c:4fd2:b0:40e:f693:94dc with SMTP id o18-20020a05600c4fd200b0040ef69394dcmr303299wmq.11.1706830634198;
        Thu, 01 Feb 2024 15:37:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/4prkdBFWttbX70piivEYb9na7iVpUkyQ7exA66ZROlVNizRygGmPAtt9loGk78LM7B+Lc3o1RT3X2apq8dM7qXD5jeF+uT3P26Fyoh3R1ZGktqNeg6Pjq9XUb8lNftXiHxKypR70EspiKY1GIefZqFeCNYmLBsl+hxUUuqWOKmrpJPcK7LA256N8xgYaIEZqhzgVzEv0sUrDWPnI9JS54xtakziQM98TzdQmTT0+G0fzQ9BCsf4hxQAOXxA9O9G+y3RFBbxFtUkVYiA+m6MhAIUSLWFHUEPNfG33kV5dczA4sfx1t3qY4WxOVhYISufKmo1UgvP6jnubOwGsKuCEPzZO5ZY/ybO3qgIv
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040fc4fa15f4sm631571wmq.36.2024.02.01.15.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 15:37:13 -0800 (PST)
Message-ID: <a1ac7a6e-4447-4476-8fb7-fb5f0d7ec979@arista.com>
Date: Thu, 1 Feb 2024 23:37:06 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] selftests/net: A couple of typos fixes in
 key-management/rst tests
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
 <20240131163630.31309ee0@kernel.org>
 <e88d5133-94a9-42e7-af7f-3086a6a3da7c@arista.com>
 <20240201132153.4d68f45e@kernel.org>
 <44d893b4-10b0-4876-bbf7-f6a81940b300@arista.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <44d893b4-10b0-4876-bbf7-f6a81940b300@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 22:25, Dmitry Safonov wrote:
> Hi Jakub,
> 
> On 2/1/24 21:21, Jakub Kicinski wrote:
>> On Thu, 1 Feb 2024 00:50:46 +0000 Dmitry Safonov wrote:
>>> Please, let me know if there will be other issues with tcp-ao tests :)
>>>
>>> Going to work on tracepoints and some other TCP-AO stuff for net-next.
>>
>> Since you're being nice and helpful I figured I'll try testing TCP-AO
>> with debug options enabled :) (kernel/configs/debug.config and
>> kernel/configs/x86_debug.config included),
> 
> Haha :)
> 
>> that slows things down 
>> and causes a bit of flakiness in unsigned-md5-* tests:
>>
>> https://netdev.bots.linux.dev/flakes.html?br-cnt=75&tn-needle=tcp-ao
>>
>> This has links to outputs:
>> https://netdev.bots.linux.dev/contest.html?executor=vmksft-tcp-ao-dbg&pass=0
>>
>> If it's a timing thing - FWIW we started exporting
>> KSFT_MACHINE_SLOW=yes on the slow runners.
> 
> I think, I know what happens here:
> 
> # ok 8 AO server (AO_REQUIRED): AO client: counter TCPAOGood increased 4
> => 6
> # ok 9 AO server (AO_REQUIRED): unsigned client
> # ok 10 AO server (AO_REQUIRED): unsigned client: counter TCPAORequired
> increased 1 => 2
> # not ok 11 AO server (AO_REQUIRED): unsigned client: Counter
> netns_ao_good was not expected to increase 7 => 8
> 
> for each of tests the server listens at a new port, but re-uses the same
> namespaces+veth. If the node/machine is quite slow, I guess a segment
> might have been retransmitted and the test that initiated it had already
> finished.
> And as result, the per-namespace counters are incremented, which makes
> the test fail (IOW, the test expects all segments in ns being dropped).
> 
> So, I should do one of the options:
> 
> 1. relax per-namespace checks (the per-socket and per-key counters are
>    checked)
> 2. unshare(net) + veth setup for each test
> 3. split the selftest on smaller ones (as they create new net-ns in
>    initialization)

Actually, I think there may be an easier fix:

4. Make sure that client close()s TCP-AO first, making it twsk.
   And also make sure that net-ns counters read post server's close().

Will do this, let's see if this fixes the flakiness on the netdev bot :)

> I'd probably prefer (2), albeit it slows down that slow machine even
> more, but I don't think creating 2 net-ns + veth pair per each test
> would add a lot more overhead even on some rpi board. But let's see,
> maybe I'll just go with (1) as that's really easy.
> 
> I'll cook a patch this week.

Thanks,
            Dmitry


