Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E131F4806
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 22:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgFIUZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 16:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbgFIUZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 16:25:07 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43351C03E97C
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 13:25:07 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b8so20072446oic.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3a1cFohP5xw0SV+VDh6kY4yNG0l/fwhW7wJHz/37M90=;
        b=cHeNgvM5Hf+c4H85+zrIqqKMKChQ7S50KExa9V4xoBcS5wkf0/gAR35whBaF7VbuxQ
         lGrGPr3/7TrOiAjgfs8MYAx01JEZu4oaU2/w+3/dZGAWBuwZgJdy2L4izk6jjv2TfY3w
         tzw/q7Wwg/rLiFR4hdka4xMMe6NWOSMxPTY+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3a1cFohP5xw0SV+VDh6kY4yNG0l/fwhW7wJHz/37M90=;
        b=boapNxqRJ2cGnayjwbDzHI5hU9UAKU/pmU61A0IifnD2DcogAqBoc7YcDJapjE8rn0
         o6EADjWn0EwyLoNovo115PJVIzXnDf+gbSZRkymyYptZHi8y+qyHae6VdsTP8Pb2G3fi
         yDiUVDADb6E5NBZkVH2W0sSGSXxlOllzAyoGs3OaVW14wPbXOk39xKz+xeBvyr2BrDUI
         bz4a9M4bgR15sVH9LWmGDGHNGicLPxXIt7+9PkV9kqp3vAoBI7bXV9h8LFFdWN1sDsYJ
         Pxrt23C0PWT/raaDK5h5a+6e9fbh5iVSos9jfQJdebLNRp6+VyhN9SrN0yhJbV2bPeXk
         KyZg==
X-Gm-Message-State: AOAM531b3JrYQQFA2eWKmgJPYwERCblTThtST7IFpuXTBPCbqNdSxUXd
        A8yrj7Yd4Jm4XAKqbUOVkIGyFw==
X-Google-Smtp-Source: ABdhPJzxTh55TjnmOg/XSzXnQ/u8fDQYGX0Tks1gLIZvUQGYGRIMrDcm5uD/nL/rlrEgh2ptqf0H+A==
X-Received: by 2002:aca:4757:: with SMTP id u84mr30544oia.95.1591734306589;
        Tue, 09 Jun 2020 13:25:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n60sm2385638otn.75.2020.06.09.13.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 13:25:06 -0700 (PDT)
Subject: Re: [PATCH v4 kunit-next 0/2] kunit: extend kunit resources API
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
 <CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cef5ddd1-52c2-dc2b-2e11-9196ab5b094c@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 14:25:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/20 3:20 PM, Brendan Higgins wrote:
> On Fri, May 29, 2020 at 2:46 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> A recent RFC patch set [1] suggests some additional functionality
>> may be needed around kunit resources.  It seems to require
>>
>> 1. support for resources without allocation
>> 2. support for lookup of such resources
>> 3. support for access to resources across multiple kernel threads
>>
>> The proposed changes here are designed to address these needs.
>> The idea is we first generalize the API to support adding
>> resources with static data; then from there we support named
>> resources.  The latter support is needed because if we are
>> in a different thread context and only have the "struct kunit *"
>> to work with, we need a way to identify a resource in lookup.
>>
>> [1] https://lkml.org/lkml/2020/2/26/1286
>>
>> Changes since v3:
>> - removed unused "init" field from "struct kunit_resources" (Brendan)
> 
> Shuah, it looks like you haven't sent a PR to Linus yet. Would you
> mind picking this up for 5.8?
> 

Applied to linux-kselftest kunit branch for second update for
Linux 5.8-rc1

thanks,
-- Shuah
