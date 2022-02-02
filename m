Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8684A7776
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiBBSGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiBBSGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:06:17 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A1C06173B
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 10:06:17 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p63so41236iod.11
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hNV2f3cPKa/gkBJtO8//6fZlmNRzoYVhR6xKSXFe4bw=;
        b=RT/HOtnlSeSa4BCmXs3+5JE3Zlwo23R/iJOAI5BY19ui41M03xUP+IsqTHbdv04REf
         l8vdcW+MB+vuYcDtoQULlOTblKnsZm6prBHxZ5lbLk0+5cGCHQi1igtk34KY8bplVEn4
         320XEz4BPG/NVaSHnuZT2MRrUo9sX73DfCoJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNV2f3cPKa/gkBJtO8//6fZlmNRzoYVhR6xKSXFe4bw=;
        b=2XTanYZec3Sz0QzBzu15aXHlKiwzaxgvi4DtMghwrDL20UusP0a/pAvhYdMRBkEPTb
         2E3cHlPEszkjzzPTsSkRMS3O5or1R5U6JaU2KACkj+lseZpjh0p2LAi7+gPXeY6ghGQV
         CC2Q+lqQC+wIiPoHNXeYL7pm3X8xD34RKmzzhw8HeMLu1wrG+yfiYztoBrOKJFczT0Lo
         c5jD58hFYN1fsuawIqZsywtpAdth16ZTIpCy3UUGB+X4nHtdpyfySCgiIUaIqVIlrBhf
         biVqwjCiysxdWJ4onTTshieYk7VI69gwOkqKMqjXL1Z6mxaGztwfMC4xAluLpHTq4ppt
         +5dg==
X-Gm-Message-State: AOAM530Hv7REF7aiZUNCIXT4gERAihF74u5Zq41FPd+zrRg6LCmBe5om
        Bd1qIJA3INH34l03iXxwHIpAxA==
X-Google-Smtp-Source: ABdhPJzIpUTqSUbLVW+ir23UJNN3C9kuHv/LBunZ/bu/F4vXdk2QT4v48VLk4yh70UanR972nIcQPw==
X-Received: by 2002:a05:6638:6a9:: with SMTP id d9mr9390403jad.92.1643825177189;
        Wed, 02 Feb 2022 10:06:17 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g8sm21141841ilc.10.2022.02.02.10.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 10:06:16 -0800 (PST)
Subject: Re: [PATCH V2 0/4] selftests/sgx: Early enclave loading error path
 fixes
To:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1643754040.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5217a735-336a-4c34-5eba-5141b758cbcd@linuxfoundation.org>
Date:   Wed, 2 Feb 2022 11:06:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1643754040.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/1/22 3:47 PM, Reinette Chatre wrote:
> Changes since V1:
> - V1: https://lore.kernel.org/linux-sgx/cover.1643393473.git.reinette.chatre@intel.com/
> - All changes impact the commit messages only, no changes to code.
> - Rewrite commit message of 1/4 (Dave).
> - Detail in 2/4 commit log what callers will see with this change (Dave).
> - Add Acked-by from Dave to 2/4 and 4/4.
> 
> Hi Everybody,
> 
> Please find included a few fixes that address problems encountered after
> venturing into the enclave loading error handling code of the SGX
> selftests.
> 
> Reinette
> 
> Reinette Chatre (4):
>    selftests/sgx: Fix NULL-pointer-dereference upon early test failure
>    selftests/sgx: Do not attempt enclave build without valid enclave
>    selftests/sgx: Ensure enclave data available during debug print
>    selftests/sgx: Remove extra newlines in test output
> 
>   tools/testing/selftests/sgx/load.c | 9 +++++----
>   tools/testing/selftests/sgx/main.c | 9 +++++----
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 2056e2989bf47ad7274ecc5e9dda2add53c112f9
> 

I can take these through kselftest tree if there are no dependencies on
another tree.

thanks,
-- Shuah
