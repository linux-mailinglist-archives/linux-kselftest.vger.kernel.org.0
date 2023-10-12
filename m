Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D417C7052
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbjJLOaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbjJLOal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 10:30:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE066E6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 07:30:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-355fbb84257so459445ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697121039; x=1697725839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BtIVBlpSIVQw6t8LBvInNyNxUiBSBsc/dgu+7xr1DM=;
        b=BnnIRehlNpdIkyHHezJpYzvt9OEX133vLDjEs9WwMw6duUBe8RJZbXCCQh5+yLO65A
         /ioSpGKdnv9lSHQ2Tx1UGszln6WPAeUCYvpZIH0lwS+uf/0nCoTTEy1oXbQlUE73oIqp
         MNSoVIBqOfgUHAltjn11P+zjO3giLJG60ji5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121039; x=1697725839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BtIVBlpSIVQw6t8LBvInNyNxUiBSBsc/dgu+7xr1DM=;
        b=NkvcWXkQccoXuzjda6t3IZt2tN/XcBRLBNhemjKMH1104aoHoSwfoqX4LsJ3XkbdB2
         E6pyi9Xr/oR3tE+7GCqOho9lBEVse2/oXGkbHVqgAxFTOBbPykp9mjax5/eHeGcAd/D+
         X3UQLHiL9ptdR/heyu/K1ZA2j+1PBTUb09x/f5H7wLYgZQgvYHLHU7I08ZGLDIK32CeE
         qcYw6ZZrTU5LHXJ5KOjCxZSls8UrfvurjcvUCTeXsaD/o7zJIRxhQ9TEeQBSvA1e3yeb
         o0XfxHeVkcsbG3vvnWUhbSnmCzvaosk07ZPh1T+mKGAjxIrmg4NKPPC8plKzqh4r5Lb0
         gApQ==
X-Gm-Message-State: AOJu0Yw6UpQ7DyW31KFWSy2GWTIsG5hTmwspWGqkn+ZdKpW9A/HK3kXx
        0raBR6NY6TNQfbnq4bp/hgEIo9AilWJgDEir6/Q=
X-Google-Smtp-Source: AGHT+IEjKGDpe0KBGUPxH0HbRdhr8dUkJea9vMZ8EDBfdFLs7XawCtgbT5fturBjhOCH1RLjeVTwRA==
X-Received: by 2002:a6b:3b83:0:b0:7a5:cd6b:7581 with SMTP id i125-20020a6b3b83000000b007a5cd6b7581mr2814293ioa.2.1697121039213;
        Thu, 12 Oct 2023 07:30:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f3-20020a02cac3000000b0041ab9b6f5b0sm4059769jap.128.2023.10.12.07.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:30:38 -0700 (PDT)
Message-ID: <fafe90f3-5612-4dac-8ca7-4f0d0d6a05f7@linuxfoundation.org>
Date:   Thu, 12 Oct 2023 08:30:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] selftests: Add printf attribute to kselftest
 prints
To:     =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>, Shuah <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
 <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
 <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
 <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4h2eu6yhodrujbvem24v7cwal5tnk2agsqulpxwi4myk7n35uq@phbxlajivrpq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/23 01:32, Maciej Wieczór-Retman wrote:
> On 2023-10-11 at 13:40:48 -0600, Shuah wrote:
>> On 10/11/23 02:23, Maciej Wieczor-Retman wrote:
>>> Kselftest header defines multiple variadic functions that use printf
>>> along with other logic.
>>>
>>> There is no format checking for the variadic functions that use
>>> printing inside kselftest.h. Because of this the compiler won't
>>> be able to catch instances of mismatched printf formats and debugging
>>> tests might be more difficult.
>>>
>>> Add the common __printf attribute macro to kselftest.h.
>>>
>>> Add __printf attribute to every function using formatted printing with
>>> variadic arguments.
>>>
>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>> ---
>>> Changelog v4:
>>> - Fix typo in patch subject. (Reinette)
>>> - Add Reinette's reviewed-by tag.
>>>
>>
>> I still need information on how you found these problems. Please
>> add it to change log for each of these patches.
> 
> Sure, I'll add notes on methodology to patches 2-8. I understand that
> this patch (1/8) message doesn't need that addition since the problems
> it exposes are in separate patches.
>

Yes please. As mentioned a couple of times, I would like to see how
the problem is found in each patch commit log.

> Or would you like me to also note here more specifically what effect it
> has in the rest of the series?
> 

Yes please.

>> I am seeing checkpatch warning:
>>
>> WARNING: Prefer __printf(a, b) over __attribute__((format(printf, a, b)))
>> #102: FILE: tools/testing/selftests/kselftest.h:81:
>> +#define __printf(a, b)   __attribute__((format(printf, a, b)))
> 
> Running checkpatch.pl with --show-types shows the
> PREFER_DEFINED_ATTRIBUTE_MACRO is raised. From looking at the error
> message in the script it looks like a false positive:
> 	"Prefer $new over __attribute__(($orig_attr$params))\n"
> 
> Please correct me if my train of thought is wrong but I think checkpatch
> sees __printf() macro defined and it sees it's raw version
> "__attribute__((format(printf, a, b)))" which it wants to replace with
> the macro. But since the raw version is found in the define line that is
> obviously not possible.
> 

This is fine.

thanks,
-- Shuah
