Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268C949FFB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 18:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbiA1RlO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 12:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbiA1RlN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 12:41:13 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76267C061714
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 09:41:13 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id p7so1961813ilp.11
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jan 2022 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fQlz1xziBeq1SeHO++Hr/139HiVIGqtFfW/7WrMMhfI=;
        b=Hgdh/XQXfk33Xt3jd8tXLLJCdOBmbM+FjflNCYNPCEOJHpk/Vcr+ks8GZJ7EIcuEjM
         ddvM3Uc6AYJStH5XGX547CbMqiky5AfLDufhb5dHYRZMON9xZ+1zbOa7o9W1CP6vXD6T
         Ztv69y29DVzTHbirihTsW8dAZs8m4nKCJwJN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQlz1xziBeq1SeHO++Hr/139HiVIGqtFfW/7WrMMhfI=;
        b=4y1lqVUGKHaDrfxl6QTUJAyYEqnavwesdYsxSn+B0LdSi5rxPlSFJmKHdG0kVAP5gS
         asEMBRIZJ45NqTLW3Ml/Z9wptBa6M/0lUFaLPxnTuMdZbqdEN6wLOiOKEWbMs1mLZig6
         sGu+rP6H/WJijCYPBlffjqHjRqyKdl2fntc8vHlBy0Rs5oPjfrOP0clSfS5oXk/TiwK5
         sBMQzTNmNMWzCkD75cQIkSJ1KIX+6swv0FmPaj2RueSL+p2q3fWSOmFcDUn50rHIpxj3
         eSYd02TZaW4DT8VShJcT/hkOPLzBXgNnhJJ+4PYH7yAYEVK3hvjgMFtpZjPPrAa8qdpH
         vIYA==
X-Gm-Message-State: AOAM531zx9JLHsMj1rxJ9GvKaR7V+f2X7DGLU2L1LOPhliOzofnBA7mb
        m3ecm8I3SINt4ybG9hmeVJzt9HVi1SQ/Sg==
X-Google-Smtp-Source: ABdhPJxS/FEJzAv1hn1ujb1xIJ2l8SSk7twyhkuztl7U9wB4Prc0rBa8/XxATuRjJDk7ojcWb+kuYA==
X-Received: by 2002:a05:6e02:1202:: with SMTP id a2mr6387557ilq.2.1643391672729;
        Fri, 28 Jan 2022 09:41:12 -0800 (PST)
Received: from ?IPv6:2601:282:8200:4c:4e31:d3a8:3801:7e36? ([2601:282:8200:4c:4e31:d3a8:3801:7e36])
        by smtp.gmail.com with ESMTPSA id x17sm5487600ilo.21.2022.01.28.09.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:41:12 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: Fix vdso_test_abi return status
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220128130701.17511-1-vincenzo.frascino@arm.com>
 <20220128144451.GC5776@e120937-lin>
 <82d59ef7-39a1-c1f7-2746-f4fc19593add@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <25eb270c-fa11-f2bc-0686-b5a8c55cd0a7@linuxfoundation.org>
Date:   Fri, 28 Jan 2022 10:41:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <82d59ef7-39a1-c1f7-2746-f4fc19593add@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/22 10:35 AM, Shuah Khan wrote:
> On 1/28/22 7:44 AM, Cristian Marussi wrote:
>> On Fri, Jan 28, 2022 at 01:07:01PM +0000, Vincenzo Frascino wrote:
>>> vdso_test_abi contains a batch of tests that verify the validity of the
>>> vDSO ABI.
>>>
>>> When a vDSO symbol is not found the relevant test is skipped reporting
>>> KSFT_SKIP. All the tests return values are then added in a single
>>> variable which is checked to verify failures. This approach can have
>>> side effects which result in reporting the wrong kselftest exit status.
>>>
>>> Fix vdso_test_abi verifying the return code of each test separately.
>>>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> ---
>>
>> Hi,
>>
>> LGTM.
>>
>> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
>>
>> Thanks,
>> Cristian
> 
> Thank you both. Will queue this up for 5.17 rc3.
> 

Vincenzo,

A couple of checkpatch warns. Please fix them and send me v4.

thanks,
-- Shuah
