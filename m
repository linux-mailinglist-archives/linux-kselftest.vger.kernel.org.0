Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3D35740B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 20:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348411AbhDGSPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhDGSPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 14:15:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1EC061760
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Apr 2021 11:15:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so19685061oif.6
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Apr 2021 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoEi3BP3d29vcJAQRKbNC4SG8iDtnjjh94HE5FU651c=;
        b=K83N5rh9ut515leNqDhrXT9JgDlyPDxDpX77guxK/mO9vXGV3Jbe8iKqVkZHOC5lm3
         h0RIqlqvs4vpnd7fztqsO4S62/zNapA/6Q/Jz2FC1x2TDQHiF6zPY2h4rqSKJAiWWkXg
         +wo5BpbBT+qCOujgsniETQRNPwduzfyciOZvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoEi3BP3d29vcJAQRKbNC4SG8iDtnjjh94HE5FU651c=;
        b=V+6F3zRy9CXlldZIwkMqg/FoaHTE4KylXv9cgPZfwdDewgGdVWA+6w3cw1cGfT56Mu
         1iVwwcL0JgG0betf/29QkNGqAa/z5deXP/h2Ag5Z4wC0+ed2aBUt0z1Knzv9lo8ojdrx
         5dEq6pBaN5YYS0ZB+LFAAzIjBuhpJ5mQZwHaG8rnDasvvypkp91n7nkGi7zUgPE3IINl
         VW641N57GBzqLlOhurnoHBf3+5Kwn+pcj78JArX7Wj3MlJB3yjoVrnqEoWT2PXXeI4AJ
         bYNcGpHkeJNy6wkHfYBm2KX2S//HORpR/ZbESzLualjlNRkeYL32N74qoLIHjdsiTVYt
         TpTw==
X-Gm-Message-State: AOAM530IoY2h/yQubzvoEIeInhNfM/eD0TUcVbdIFRbqxRdIpxKj7HvU
        QXKFEEcIJ44vhUWrj13k9rc8rA==
X-Google-Smtp-Source: ABdhPJwuzgvRhgvbMl5pTOzFGcrVdkaCXJC/0TY6RWsoDgz8FNEjiObb1YugHss+uSxcImQRZ7yyPA==
X-Received: by 2002:aca:4a95:: with SMTP id x143mr3106178oia.59.1617819335056;
        Wed, 07 Apr 2021 11:15:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k24sm4416554oic.51.2021.04.07.11.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:15:34 -0700 (PDT)
Subject: Re: [PATCH] selftests/resctrl: Change a few printed messages
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210406005242.3248706-1-fenghua.yu@intel.com>
 <67062f6c-d09a-f8e0-4d22-49c4452d0552@linuxfoundation.org>
 <YG3n7gsIhqOGjltv@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c38f6fd-d53f-0f79-f5fe-456090368330@linuxfoundation.org>
Date:   Wed, 7 Apr 2021 12:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YG3n7gsIhqOGjltv@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/7/21 11:12 AM, Fenghua Yu wrote:
> Hi, Shuah,
> 
> On Wed, Apr 07, 2021 at 08:33:23AM -0600, Shuah Khan wrote:
>> On 4/5/21 6:52 PM, Fenghua Yu wrote:
>>> -	ksft_print_msg("%s cache miss rate within %d%%\n",
>>> -		       ret ? "Fail:" : "Pass:", max_diff_percent);
>>> +	ksft_print_msg("Check cache miss rate within %d%%\n", max_diff_percent);
>>
>> You need %s and pass in the ret ? "Fail:" : "Pass:" result for the
>> message to read correctly.
> 
> Should I keep the ":" after "Pass"/"Fail"?
> 

Yes please.

>>
>> I am seeing:
>>
>> # Check kernel support for resctrl filesystem
>>
>> It should say the following:
>>
>> # Fail Check kernel support for resctrl filesystem
> 
> i.e. should the printed messages be like the following?
> # Fail: Check kernel support for resctrl filesystem
> or
> # Pass: Check kernel support for resctrl filesystem
> 

This looks good.

thanks,
-- Shuah


