Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2943B244B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jun 2021 02:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXAnA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFXAnA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 20:43:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7C7C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 17:40:41 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b2so3018479oiy.6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 17:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8aXNnJPgzFasgRQ/3SZjZxHB/iETrErIxFti8LCKPuw=;
        b=WaocPTyfDGVh9mLxAuyWMDCc0iZt0OY5B0UMEUpVasi85XWfRxg82NX3/0H4ZjKXcQ
         NPJRoYB3S6TQOiiz5UzaWct2FYfX+sIa91Zic1jKpg4IuGww7HWKxLGQ3uBfqtWa11AF
         QTHorlW9bTAWxgOJVcE8Q895b8vrbq/x/8Vos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8aXNnJPgzFasgRQ/3SZjZxHB/iETrErIxFti8LCKPuw=;
        b=OfFX7fCQReuZ6gNYsOcSz29MwWI7o/pSB/ZffzosgNXhsq+ybr5HPiZhQfniumH06C
         fKgKVBl8jSY0nG6iAx1Ric1yVWFNMxwLZfbrmWpmcXVBHCupQrcc2EfLl1B7cO0DQorW
         w3Em+mvYC57A8tZeV3NXANskhMVg6cHZGSVr4iSCuObX4NcA4/OaB2MXP6fQEAvYhHFQ
         ZJ/iRxlamFZE/U1faiMtFcc0kemFixHRuOrdEQobpSGPhz0xBT1QNuWvCdkaniOkZgiA
         N2628EJm+1BgDmRJGgzjMqHSPn1ycf6C1cyZyDKzWMZ+22syapWn+LuC0D9w7vn2q7c0
         2jhA==
X-Gm-Message-State: AOAM533QcTYsGnSYjcXLid2dRKG9dok1wUBFnu+cXLY+crrmX6DwVbaf
        i8JkrgaVgrRfsbFmJPs2IEWkyA==
X-Google-Smtp-Source: ABdhPJySlB33W2z668j7Dkn6kxnqb+RezaTEux7Oz+cmN+pHAbGFZE2M5Nyvs0HY/kx97yoNlisVXA==
X-Received: by 2002:a05:6808:4c2:: with SMTP id a2mr5108035oie.73.1624495240315;
        Wed, 23 Jun 2021 17:40:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm290426oot.25.2021.06.23.17.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 17:40:39 -0700 (PDT)
Subject: Re: [PATCH] selftests/sgx: remove checks for file execute permissions
To:     Dave Hansen <dave.hansen@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tim.gardner@canonical.com,
        jarkko@kernel.org, shuah@kernel.org, linux-sgx@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210621190556.4B5DCBB1@viggo.jf.intel.com>
 <121f7215-f11d-2533-b736-9f18516c3220@intel.com>
 <1f46324e-2cbe-f4a7-65d5-24b22a8b36b1@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a3c10daf-6531-5b09-c6fd-77ae02afdce0@linuxfoundation.org>
Date:   Wed, 23 Jun 2021 18:40:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1f46324e-2cbe-f4a7-65d5-24b22a8b36b1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/21/21 3:18 PM, Dave Hansen wrote:
> On 6/21/21 2:08 PM, Reinette Chatre wrote:
>>
>> Thank you very much for fixing this. With this applied the SGX tests are
>> able to run again on my system.
>>
>> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> I think it is missing a "Signed-off-by".
> 
> Right you are.  I think I've done this twice in a row for one-off
> patches.  Sheesh.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> If anyone wants a resend with this included, please let me know.
> 

Thanks to b4/patchwork - no need to resend. I have the signed-off-by
in the downloaded patch.

Thank you all. Now applied to linux-kselftest next for 5.14-rc1

-- Shuah
