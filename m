Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A436218FDDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 20:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCWTmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 15:42:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57253 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgCWTmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 15:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584992551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smmSxlhEOR5qNhn11L1ve0W1BbFnYt0RhPTc7f7mic0=;
        b=i2ZRIgCfppNiAOGVsnkTGA7D+iQBu85SsCnVN80e/SsYLfmGR14J24Mv4bB5at9Br6NR3Y
        nnYFN5lj3rc7G4SPgCdyIR14eXd44mxCCSLARr9OfuhsNlv4xFrg5xW1w21BnjZmP1sSXe
        qVux2s1HpUz1o+DYfTvwredTH60KC6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Skxbu5fBNvi6PUPhKcsphA-1; Mon, 23 Mar 2020 15:42:29 -0400
X-MC-Unique: Skxbu5fBNvi6PUPhKcsphA-1
Received: by mail-wr1-f71.google.com with SMTP id d17so7815713wrs.7
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 12:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=smmSxlhEOR5qNhn11L1ve0W1BbFnYt0RhPTc7f7mic0=;
        b=iclHfGNxYrQG9fhjM3fXir+sJhLq3ZAA2anQGtwGq7gGxzMTUeA9pEfC+Q4NtpjbYb
         SazZVbWjXeGLdzAej9w6YddJezqWBEzkizya7V8J5bl6LlJQimjGuS61hbuTvSBUkr8r
         wLvqjio6jdeiDb4/9UfyKX7tqpim7ulYXRSN+o4flB0PUwaPo4y1PNOcvlTGBNdLo5P/
         iq1YTM47UcH33RaNBEelOgcwUgrjdfXH5zSFzvAz2ix06VzKQDH9oRCd4RtQM4yONdEO
         StzwEFNGZKv94acROfI8GgIgF+oQQQVAXhNr8YuTSLWNTMa/trL67vFvjRlOnUoQnoDD
         b83Q==
X-Gm-Message-State: ANhLgQ04vMb2mpq6nmcBl41XWXENb6s8WKXbRho4UKcqA4OPdKC9icj1
        JLr63oBPZ8dWNV0SLH0TWnYT5aKNEQpnVqua8jBvpL0KeBBZ24TwgVEJqd1EAlez/tgMsloW3SS
        AZ+5kqdI2SpH/bJX92gjGbS/1qQel
X-Received: by 2002:a5d:44d0:: with SMTP id z16mr9536737wrr.28.1584992548663;
        Mon, 23 Mar 2020 12:42:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQtBDqi8UHm7eMe+WXYdgVpyqZ4rAOMGiQwUhT4b15bVIuSlqY9zZJBAt+/xHFll+hTH7sBQ==
X-Received: by 2002:a5d:44d0:: with SMTP id z16mr9536706wrr.28.1584992548365;
        Mon, 23 Mar 2020 12:42:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id h26sm831009wmb.19.2020.03.23.12.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:42:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix errors when try to build kvm selftests on
To:     shuah <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
 <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
 <ed26428d-00bc-e90c-f2ee-ee7c0f874715@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d89b9433-7825-c204-a7b7-cce07d4ba7e7@redhat.com>
Date:   Mon, 23 Mar 2020 20:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ed26428d-00bc-e90c-f2ee-ee7c0f874715@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/03/20 16:44, shuah wrote:
> On 3/18/20 7:13 AM, Paolo Bonzini wrote:
>> On 15/03/20 10:34, Xiaoyao Li wrote:
>>> I attempted to build KVM selftests on a specified dir, unfortunately
>>> neither    "make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
>>> "make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.
>>>
>>> This series aims to make both work.
>>>
>>> Xiaoyao Li (2):
>>>    kvm: selftests: Fix no directory error when OUTPUT specified
> 
> This definitely isn't thr right fix for this issue.
> 
>>>    selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
> 
> Might be okay, but hard to find problems with the limited testing
> done just on the kvm test.
> 
>>>
>>>   tools/testing/selftests/Makefile     | 6 +++++-
>>>   tools/testing/selftests/kvm/Makefile | 3 ++-
>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>
>> Queued, thanks.
>>
>> Paolo
>>
>>
> Can you please drop these for your queue. I would like to make sure
> they work with other patches queued in kselftest next and would like
> these go through kselftest tree.
> 
> It will be easier to find regressions when tested with other patches
> to framework as opposed to limited testing on just the kvm test.

Sure, thanks.

Paolo

