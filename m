Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5EC4B1510
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiBJSOh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 13:14:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiBJSOh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 13:14:37 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09021391
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:14:38 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id n5so5005879ilk.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXG8tJVzrMFq4C8hId95PJlogUK12YK3EnPowhKGkb4=;
        b=ZIXzPvySnYF7ILs4xx3XU4BBL0GgywKstA+ZKJv4g1ICO/A2UbZScYJFtDNaG0R1NM
         wynZtHnzJx2nKGOX+kHf796Uf3T3PSeTMqmdDocutHQY1PYtrO6tVWd2f+Rtc0Z7NhfO
         gQA1QrxQ22M1iunv2zNRNRlF0hSVM0/W3mJXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXG8tJVzrMFq4C8hId95PJlogUK12YK3EnPowhKGkb4=;
        b=eI4WEm54unTn5UaEegvEOGMY4SEGkglrmgpO/OTH8DOTB4Zm+vQ4hvRUDez2wrDPI+
         E6Wgt9mb5Wod0mqTmwgxXMjNiJmAGY9Yk16wyxJDmeZp7feHn4PAkzpJheiu8c1wtWCl
         1HBk5nXrhmy+tWTuIs7q7nC5QNT6HuhOzMjK0DbnNTpwYZ4jTxsz65StJPbedfc09luN
         jeMEL7Ztwb3PVeLpB++kyQOBrXGxD1VZy5pu1mtQUNWM7RpmKlLtcS4yGeu2t7eu6QTQ
         V0+XEEFsMziUesgAtzC8yYQHsAQcURdcs1SppbF/z0bTnQRAaTayKI6ysouCRa6kuLNr
         ZPVA==
X-Gm-Message-State: AOAM533aW1fqsjA+7VbzX+y1AeVPyW8vEAaygVTWqbQtZohuRKzT1/mi
        y79JrztPIXg9ZqgZfbGkg0Y1Tg==
X-Google-Smtp-Source: ABdhPJxzqCXnyKU0rVKea/h/aM2EYzsEG28YeSvqPRtlrTz2ig8+angmY+Yv31ftwnhbSZRR4RGbMA==
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr1338659ill.306.1644516877448;
        Thu, 10 Feb 2022 10:14:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i9sm2069385ilm.74.2022.02.10.10.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:14:37 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Fix seccomp failure by adding missing
 headers
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220202201118.13933-1-sherry.yang@oracle.com>
 <203db09a-b048-1c1b-6609-d91e51e3c2f7@linuxfoundation.org>
 <A8A651FC-37A5-4716-888B-F141E7241003@oracle.com>
 <202202031219.792E9AFF@keescook>
 <C340461A-6FD2-440A-8EFC-D7E85BF48DB5@oracle.com>
 <b908237b-63ad-ff10-8d89-540d2cab842e@linuxfoundation.org>
 <6FCDF584-C765-4344-A851-E623B2FCB9A6@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9fb71ee9-37c8-575c-0ca7-5a849403f7d9@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 11:14:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6FCDF584-C765-4344-A851-E623B2FCB9A6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 11:08 AM, Sherry Yang wrote:
> Yeah, -I works, but just with some compiler warnings.
> 

warnings aren't good. Kees, hope you are okay with this.

> If warnings are acceptable, do I need to send V2 patch with -I?
> 
> Sherry
> 

No top posting please. No need to fix it to -I - please send v2
I can't find your patch on lore - not sure why.

Please cc linux-kselftest and linux-kernel@vger.kernel.org

Also run scripts/get_maintainer.pl for a complete list of recipients
for this patch.

thanks,
-- Shuah
