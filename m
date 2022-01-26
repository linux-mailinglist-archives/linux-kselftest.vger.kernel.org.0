Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FCC49D3D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiAZUuk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 15:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiAZUuk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 15:50:40 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1667C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:50:39 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so767016ils.5
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 12:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g1rJEPs0w7TbjO5LiluyOsT70KWk/Gaa2amZ6SzJSNg=;
        b=LuTGWXQWifwYDRK0Ygp4ORRKoXWDKfu7JXpfxYvH6+xWS0MeZ9A4AfeBilXSkvtRDh
         znkkYjymaQGxlMvI2lgPErqRP7a/jxHudidDzFapBEmfCM2qCLbzzch1gj9urnz+FMnL
         Lmh0myULWkTSD9DSPqbNzQPld8cp0zd1ZYqV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1rJEPs0w7TbjO5LiluyOsT70KWk/Gaa2amZ6SzJSNg=;
        b=i3NCIwk3eZ7zdhnkFyjFAbLFID7VDpFzyYE8eau0gIRfNdaE23u9lH/ImVvlvgiBdo
         wi6S9SX+8zHYt+UabphGO5gymzON3gOV2hTAEtd2gdgCEULgDAkHOHJ/s43M8abo2+FA
         9tPzqD26gwiLsudsbkpYNvAnPoyoaEiJo7DuYF0nao/QkVWFqEnzl+n3n2x+4KvjD3kk
         13e0IPrvoPeHZIMLI9njvxDzqrRkf5iIF+nn2YM9G8RD87Tpw6DniWnR5q5U8CanEeoM
         jhTDOBde9whlz7CXaXIU6jjVqGI9X14aRSAh8yUn7IQHeEIduChsyUfVcugNpZmMpNKZ
         VInQ==
X-Gm-Message-State: AOAM532iDt8uqfryq9lkq5x9SJYvLCy6bdWkGyvTXasNBPKk1GO6igZV
        vfE6WbxerCdhcvxETGYXs2+s0A==
X-Google-Smtp-Source: ABdhPJzLASiBQ1mqUUkmTRKw+Qt83yRsQOKnC9rpNhp0UwVvoRvgbqpJPBIXvFLNV8BTOFeyn3PSHw==
X-Received: by 2002:a92:d4ce:: with SMTP id o14mr645706ilm.218.1643230239216;
        Wed, 26 Jan 2022 12:50:39 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f2sm11441452ilu.79.2022.01.26.12.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 12:50:38 -0800 (PST)
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220126145242.3473836-1-broonie@kernel.org>
 <4424dd30-f74b-006f-b540-dbaf02e45e28@linuxfoundation.org>
 <YfGmk1I8l+ROoE/k@sirena.org.uk>
 <48c44d74-6668-7823-ada6-0285a8b32a35@linuxfoundation.org>
 <YfGrXr1/NGREULnB@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2e9162ef-6107-e56c-e713-1f1ac7f83003@linuxfoundation.org>
Date:   Wed, 26 Jan 2022 13:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YfGrXr1/NGREULnB@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/26/22 1:13 PM, Mark Brown wrote:
> On Wed, Jan 26, 2022 at 01:03:44PM -0700, Shuah Khan wrote:
>> On 1/26/22 12:52 PM, Mark Brown wrote:
> 
>>> If the function fails for any reason other than the system not
>>> supporting vgic-v3 it will abort rather than return.
> 
>> Hmm. vgic_v3_setup() return gic_fd looks like and the interface says
>> Return: GIC file-descriptor or negative error code upon failure
> 
> Yes, but in reality the only return other than a valid file descriptor
> is just -1 rather than a useful error code.
> 

The interface document gives the impression that it will return
error - Oh well. In which case, no point in printing that. Agree.

>> I don't follow the abort part.
> 
> All the TEST_ASSERTS() in the code (including those in the functions
> called) are calls to test_assert() in assert.c which if the test
> asserted isn't true will print some diagnostics and call exit(), the
> general idiom is to give up immediately on error.
> 

Ah right. Makes sense.

thanks,
-- Shuah
