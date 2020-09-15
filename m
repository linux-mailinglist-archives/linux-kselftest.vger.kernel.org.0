Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582EC26A8A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 17:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIOPUf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgIOPSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 11:18:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E6C06174A;
        Tue, 15 Sep 2020 08:18:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so3698970wrn.13;
        Tue, 15 Sep 2020 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZLNp53JnXqD+zI2AfbeY3jtwOS37p2pT80fxgLiWZN8=;
        b=vMUOfnucxpczHnWvB+f5WMzHUAw3odnOlDddbX5Qms5eQnxEPkZuGEBsFrH9Hx2brs
         4EhjylGdU2T1HM+nFS4hkEGNotC528/Finps0OSX4OUCaD679lDNPshLWoDM2d+r0/YP
         66ZzwP2znUksqEESxJYeO/iUJ8coQff6dSQrVZaDO7wcFengNrBmfxWTJ64PAf5Jnowz
         6wNc053uWNZAX1q5O9HZd0GZlesITrAEpqz0QAIq/hgT8jea339psONFXSHR7z8fqJ+z
         iWiOr/0u9I38tvaqFmympOKp4X7CXxzotFk1ehM1kJdSpTY/rCC4FOtOMrESqpoFLiqP
         k/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLNp53JnXqD+zI2AfbeY3jtwOS37p2pT80fxgLiWZN8=;
        b=c9j+81H86g0LMQvZo01OOfQ4D6d7e9YOqbgMLPBs7wlDYvtp9WiwQzee+tXiPLWMVE
         23x7b+sY+MUSyNV5JrcogRfd+Hp5No/d7Gke7NQelzmeBixUmBnjGjybnIsLL70MnHo8
         +BUDquCKThrP+gRaIvNkC0ek0yBG6Rfxq0bqS3uTw8kh/1La2NKDAqvIAA9x28L6K85h
         Dp4YvjCf7lMa4MHTYwqsimNuBK1ru3odugTGSSp4xOHpiNtam9cJmcy1lTJ+lZSNEwsS
         uyfc3rcLjEi+ghotgrCF31NqQnk354cxZb2MiEEkQVamSOfxle5aGiN0sSmllfk8sdvO
         xCyg==
X-Gm-Message-State: AOAM531WJ0IQcLRPI9k9VW+vRoCI7CHqX4/mPCMCjkMrWBQsIe/OIwO+
        a1I2o1NXN2fmfyplQtqcBROy2Z8xCMoQtH7u5gg=
X-Google-Smtp-Source: ABdhPJy8Aacl0eZ69vdzAYYGA2hLxLkklddZa1Z+vpkwnGOXg3eRfCeWWWygKDpBDzculKRm6NyRTg==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr21319559wrq.282.1600183113296;
        Tue, 15 Sep 2020 08:18:33 -0700 (PDT)
Received: from [10.127.42.3] ([94.156.155.144])
        by smtp.gmail.com with ESMTPSA id t16sm27840401wrm.57.2020.09.15.08.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 08:18:32 -0700 (PDT)
Subject: Re: [PATCH 3/4] kselftests/arm64: add PAuth test for whether exec()
 changes keys
To:     Dave Martin <Dave.Martin@arm.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-4-boyan.karatotev@arm.com>
 <20200902170052.GJ6642@arm.com>
 <70e207ea-f7c2-2c9d-e868-3ba3b6451c6f@arm.com>
 <20200907102717.GM6642@arm.com>
From:   Boyan Karatotev <boian4o1@gmail.com>
Message-ID: <4f38a974-d5a0-87e6-3db3-647e3cc32c0e@gmail.com>
Date:   Tue, 15 Sep 2020 16:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907102717.GM6642@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07/09/2020 11:27 am, Dave Martin wrote:
> On Thu, Sep 03, 2020 at 11:20:25AM +0100, Boyan Karatotev wrote:
>> On 02/09/2020 18:00, Dave Martin wrote:
>>> On Fri, Aug 28, 2020 at 02:16:05PM +0100, Boyan Karatotev wrote:
>>>> +int exec_sign_all(struct signatures *signed_vals, size_t val)
>>>> +{
>>>
>>> Could popen(3) be used here?
>>>
>>> Fork-and-exec is notoriously fiddly, so it's preferable to use a library
>>> function to do it where applicable.I would love to, but the worker needs a bidirectional channel and popen
>> only gives a unidirectional stream.
> 
> Ah, fair point.
> 
> Would it help if you created an additional pipe before calling popen()?
> 
> May not be worth it, though.  For one thing, wiring that extra pipe to
> stdin or stdout in the child process would require some extra work...
Well, I probably could, but I doubt the result would be any better. I
agree that I'm not sure the effort is worth it and would rather keep it
the same.
