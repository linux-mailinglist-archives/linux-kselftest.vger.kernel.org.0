Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4F41F610
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354071AbhJAUBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Oct 2021 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhJAUBE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Oct 2021 16:01:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D534C06177E
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Oct 2021 12:59:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i62so13009634ioa.6
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Oct 2021 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pDTsW1n9PK29PC83itCom+RuJCbJXbDX2PBAwxtEi5Q=;
        b=Ml99nyYTXl1us4C9eU4XDofXWruq6cG2KGnk9dBR0BrGt6e9VpgeS9aQ5dGZaNTLWa
         gq89Rn4zH9/iiMwTTtcuhkBn4FnGHAWSCFXQrwPFb7ygn1Cl6uLRfzmGcA6KN3JjIKTM
         ZldSrFlNMxq9AJf2SMJl3OQAOWl7m9tPSFXQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pDTsW1n9PK29PC83itCom+RuJCbJXbDX2PBAwxtEi5Q=;
        b=AorT4ghqLLlFSLhyTSbluh6a5Rn/BcRLKH8jyEGOjPPFSRHMZTN13KZfnf7gbmFRvn
         h/K62yVc4FfcYzz+HVwzELQJ8zV0AbPfHZ/MtkEEPrlIabVUUfx+2bLuAjcuhXrfOsNQ
         IDkvIu1frb/suuZ8Pi47Q1KnQ+pfRGBJvo0TyO0gyCYwb8hMrOKfOx1xXP9sn+a8e9Ao
         9Nw0zaGCxJ30Qe9iWJ3O+uY//Tg0cQO7F4MzFkAM8aaQz4oMTjhRVVXmIja0cCfn8EKv
         KC4uIGNffAYhkICC5Z5DjmBwYxWR/pnsUYL0DkbrRbF6VNK8Kv/LgR4sWdJJY2SIhL9t
         QkAw==
X-Gm-Message-State: AOAM533/l/Q3ACXTPjDtW0T2v6rS7KgRSg+asar6k4ciI9DJNxFXX/5q
        vy5LpMO9JV2KN3kyOM+ZyFrhAQ==
X-Google-Smtp-Source: ABdhPJz7WObTRwrNwsUIUmOaCxXC6fSE3ENtuiDAss6zrGtbO8V3lFAqhwaVSA/N9RO0GGFulz0KNQ==
X-Received: by 2002:a02:23c3:: with SMTP id u186mr4578264jau.34.1633118358965;
        Fri, 01 Oct 2021 12:59:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f20sm4000141ile.57.2021.10.01.12.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:59:18 -0700 (PDT)
Subject: Re: [PATCH v2] kunit: fix reference count leak in kfree_at_end
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1631172276-82914-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <CAFd5g45mgi-bnTEiHshpyxnah74toncgCgmcQcHq=kP3L3r+Vw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aad94cba-5d07-b816-d307-382894f0a012@linuxfoundation.org>
Date:   Fri, 1 Oct 2021 13:59:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45mgi-bnTEiHshpyxnah74toncgCgmcQcHq=kP3L3r+Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/21 3:27 PM, Brendan Higgins wrote:
> On Thu, Sep 9, 2021 at 12:26 AM Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:
>>
>> The reference counting issue happens in the normal path of
>> kfree_at_end(). When kunit_alloc_and_get_resource() is invoked, the
>> function forgets to handle the returned resource object, whose refcount
>> increased inside, causing a refcount leak.
>>
>> Fix this issue by calling kunit_alloc_resource() instead of
>> kunit_alloc_and_get_resource().
>>
>> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
>> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> Thanks!
> 

Thank you for the fix.

Applied now after fixing a checkpatch alignment check to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/
kunit-fixes branch.

Please remember to run checkpatch.pl before sending patches.

thanks,
-- Shuah
