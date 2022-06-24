Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703CD55A468
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiFXWjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 18:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiFXWjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 18:39:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5788952
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 15:39:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z7so4081865ioe.11
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQQmKxN2h+LYjeKUM4BraK5L3IPF7+QlZ0l5spgkF9c=;
        b=RVz59sDENa+U5x+NH96Lm8QiTDdGRBtyaA3ptChX3D4522O7bQk/BeJrjkBKD8dWgR
         QVq1chg/0cKyERpIAIfDoqOqhI5iCXmlHSxUIdI2kBgE6UAHzwjtot7yfqWew6MGyjHG
         ORCOYshhjEIF3A6r3zZs+KqYdc+hSGd5XsPwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQQmKxN2h+LYjeKUM4BraK5L3IPF7+QlZ0l5spgkF9c=;
        b=qekRm5QBAgGStpXVJiyYnQZzYvDwBKTFEXl8SIAMoMCtShVieZ3j7DiGBg2KvOx3Oy
         /G50EgIJJZmnpiDjEppBDiIxFl7MOKMp9ZzAhHYu3XNnGR4VtVEGnHYK01somTBxViHm
         hfltlNSydRuzTToBdivvtjAZGCoEhqu0o4mCLbm6NpHU09o5Kmb/aLILuty+Xn1NemU2
         6ABIE8ZpRC3ktc9CtdKIba8L/oKkx7YywJ1H4JV8EUUtOXVbWPPfe1qyZM3w3j3aJh9m
         KGmx/jLoIfjN7nSJ9IdKCGanATfCXUALNVU8sapyzrLDlpDWoBeuguSDKUeh/H15EBW2
         DhVw==
X-Gm-Message-State: AJIora8v/AVE/rKb4HaMtZRTlajkmSq4t8k4XyKa2JPUtrjx2Rv8yHKw
        k5WzyE55VE9lhjjUvpHg6vdKc74+OOJFpw==
X-Google-Smtp-Source: AGRyM1scnispmgLVpvQoOj+mIQ8GWh6Y9P7V+cn3cb8XyynRyySRajpPnvkEW6l5pRAc5JAUtma3rA==
X-Received: by 2002:a6b:4e14:0:b0:674:f787:ccc9 with SMTP id c20-20020a6b4e14000000b00674f787ccc9mr598678iob.55.1656110348263;
        Fri, 24 Jun 2022 15:39:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bf3-20020a056602368300b00669b8999911sm1774814iob.15.2022.06.24.15.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 15:39:07 -0700 (PDT)
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
To:     Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, bagasdotme@gmail.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
 <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
 <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
 <0e8ea624-3cf0-7c63-9b24-8c4109096d3d@collabora.com>
 <87letl3kqx.fsf@meer.lwn.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4eb3c81c-a86c-4ca9-f553-caf3282f2d51@linuxfoundation.org>
Date:   Fri, 24 Jun 2022 16:39:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87letl3kqx.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/24/22 1:49 PM, Jonathan Corbet wrote:
> Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
> 
>> On 6/8/22 2:41 AM, Shuah Khan wrote:
>>>
>>> The change looks good to me. I am catching up on patch backlog after the
>>> merge window and vacation. I can take this through kselftest or if it
>>> goes through doc tree - here is my
>>>
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>> This patch hasn't been accepted yet.
> 
> I've applied it now, thanks.
> 

Thank you Jon. Kind of slipped through my backlog.

thanks,
-- Shuah

