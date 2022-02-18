Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957A4BC286
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiBRWUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 17:20:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiBRWUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 17:20:23 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489B10F9AF
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 14:20:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s1so9250517iob.9
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ov444w7dABSwi4r2TCRkfeEWs8ZARWwEHZMMyU757uk=;
        b=Z3thpX4xxbk8lHOctIqVlaL3kQYFY35ABYgj/kfvYgFWCEYmingxv9EVu+rMx/tQjn
         /ETpDpvcQoOHGLF+Sl/1jHS+e/qmN0bQOrecC4myXALsJnGNfeKuGhUkLtqClspb4ow9
         xqUDlWjAEt/kE9D+fSbBABDgo4hHcKtK4Wyqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ov444w7dABSwi4r2TCRkfeEWs8ZARWwEHZMMyU757uk=;
        b=QdTkFDakRW2FW2wSsyRW2ebphm+TCRk9hmnOSBiels6YXchqG7R0ySIyrAfEP7YHOx
         3jLHkeYMZ99T5oUPBUMYcr4Tu5Wlm/U2NVdgmPKo7JmS9yIh6TLvyv8elbA9lLxFnZI0
         tLjYATR0AB972aIOy3Z6ICLyhdL17vlbo3i5YRbjaP2hbYRHcPtRlvDAUi4cvBORzn/2
         2tIQq7IHwn6wGqIdBrt2tHRDgiMqorJ5tsACBkVP5PZmtG7gQVRFPXFWq972nI4wsFBC
         yx/0VxY0tm7t9Z7zm1FL3Eb0u7csq6LLsW/9rnfjJYKV5V+ladBZLiuUdR+NnThjHrwi
         MuyA==
X-Gm-Message-State: AOAM532okpAgkQiU2x7m5KBHy62t3xPlm2O2hOZwZJJsYxnmNh/I6Y5R
        o8WGZ1Z05sk0o82ZQ2IN9ojmSA==
X-Google-Smtp-Source: ABdhPJxfIc4uINefXIIAOEstEqIh0Dcy1b30NNFjDj759s3uMDQv1kPuSO3pBM7A7TTq459Qi+j/Tw==
X-Received: by 2002:a05:6602:27cc:b0:5f0:876e:126b with SMTP id l12-20020a05660227cc00b005f0876e126bmr7123973ios.129.1645222804355;
        Fri, 18 Feb 2022 14:20:04 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o7sm4372727ilu.83.2022.02.18.14.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 14:20:04 -0800 (PST)
Subject: Re: [PATCH 2/2] selftests/damon: make selftests executable
To:     SeongJae Park <sj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Shuah Khan <shuah@kernel.org>,
        Markus Boehme <markubo@amazon.de>, rientjes@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220218082428.11699-1-sj@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9a7f8d0b-3f0f-8584-6c12-423b0d5a979d@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 15:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220218082428.11699-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 1:24 AM, SeongJae Park wrote:
> On Fri, 18 Feb 2022 09:01:11 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Fri, Feb 18, 2022 at 07:52:54AM +0000, SeongJae Park wrote:
>>> Hello Yuanchu,
>>>
>>> Thank you for this patch!
>>>
>>> On Fri, 18 Feb 2022 00:10:17 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
>>>
>>>> The damon selftests do not have the executable bit on. We fix that by
>>>> setting the x bits on the .sh files similar to other existing shell
>>>> selftests.
>>>>
>>>> Fixes: 9ab3b0c8ef62 ("selftests/damon: split test cases")
>>>> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
>>>
>>> Reviewed-by: SeongJae Park <sj@kernel.org>
>>
>> This type of change does not work outside of git, so why not just make
>> the tool that calls these scripts not care about the executable bit like
>> we do for other scripts?
> 
> Actually, we made kselftest receives scripts having no executable bit[1],
> though it still prints warning.  I guess Yuanchu wants to remove the warning?
> 
> To remove the warning, simply making kselftest (runner.sh) stop printing the
> warning message might make more sense.  Nevertheless, it's also true that
> letting some scripts have executable bits while others not looks inconsistent
> to me.  That's why I left the warning message there.  Should we remove the
> warning from kselftest and remove executable bits from other selftest test
> scripts?  Or, let the inconsistency be?  I have no real opinion here, so just
> wanted to hear others' opinion if possible.
> 

I don't recall why we decided to add the check in runner.sh - let's keep them
consistent with the rest of the scripts. If we get rid of the check, we can
make the change then.

thanks,
-- Shuah

