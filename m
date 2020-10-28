Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF54329D3E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 22:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJ1Vrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbgJ1Vrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A343C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 14:47:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 133so541571pfx.11
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvlKRy98/mKD4i++41TPaeWlyBu9sqx7wcGcKaY/TDM=;
        b=BQQnwtRrM3JUiw2DhRadtME6Z6sUkD5n6fu2E6LSdZUkBOKG9RJR/ssiGKxjEc3LIA
         5EAWt6/E70btoxpHHlHq36FBBEpQQ2REMnnTcibs8MvVVidJrQQmwbVHQNgPnAexTMfz
         Lk0Smru33FJ0nwUQ/NZPAhyuYvLY23MxF/0NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvlKRy98/mKD4i++41TPaeWlyBu9sqx7wcGcKaY/TDM=;
        b=Y2C9Zufo5MQP44I/z4eldkMqXuCKKLOH/E7WZUGgQr/ZYf+wJ0/+wzNhhZVb/OtkyC
         fyEs8qcRn9QHiFE4garSysHX3U3RvksGfS1CSmnd6EWIItPAm0jMzV9ixbIre/oWKgtx
         hRo8WE9ZJ3kQCN3h7FqZUfDwe5kJT49JA7l5EgVqFmqQ2BHzeoZO05kJzNCboPaAVSGB
         K8ezEfKXUvOPZKJINIhdoCmbJ/S+/U1JkvzGYhF39lReUVlThn1/1shy3zBSPb2EDHgM
         ITd3CKi7h6t//njTzT3u+LbLWT8s768JBK36zchAVr4j4rgrKziYur9PgcI4T5RuPAYN
         9mSA==
X-Gm-Message-State: AOAM532HrASGQaPmy+IxbNpVJxKLA49X6cKNSESlDlHw4Q2ZBVxR67xZ
        E7U5iaNLe1VmwCnUAwX1A247SCE7Ug4tZQ==
X-Google-Smtp-Source: ABdhPJzitR2S3/iO7EJ4vic5n1z0znADrqVMesrvJJ9W1lAnekXb85rB1swPySolffPwtbqYkgGvVw==
X-Received: by 2002:a92:5eda:: with SMTP id f87mr6288369ilg.131.1603895499474;
        Wed, 28 Oct 2020 07:31:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z9sm2740868ilm.21.2020.10.28.07.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:31:38 -0700 (PDT)
Subject: Re: [PATCH 00/13] selftests fixes
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <87tuufw2on.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <18daa545-b1d6-1867-fadc-cada628e2406@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 08:31:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuufw2on.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/27/20 7:37 PM, Michael Ellerman wrote:
> Tommi Rantala <tommi.t.rantala@nokia.com> writes:
>> Hi, small fixes to issues I hit with selftests.
>>
>> Tommi Rantala (13):
>>    selftests: filter kselftest headers from command in lib.mk
>>    selftests: pidfd: fix compilation errors due to wait.h
>>    selftests: add vmaccess to .gitignore
>>    selftests/harness: prettify SKIP message whitespace again
>>    selftests: pidfd: use ksft_test_result_skip() when skipping test
>>    selftests: pidfd: skip test on kcmp() ENOSYS
>>    selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=y to config
>>    selftests: pidfd: drop needless linux/kcmp.h inclusion in
>>      pidfd_setns_test.c
>>    selftests: android: fix multiple definition of sock_name
>>    selftests: proc: fix warning: _GNU_SOURCE redefined
>>    selftests: core: use SKIP instead of XFAIL in close_range_test.c
>>    selftests: clone3: use SKIP instead of XFAIL
>>    selftests: binderfs: use SKIP instead of XFAIL
> 
> This series doesn't seem to have been picked up?
> 
> cheers
> 

I applied them to linux-kselftest fixes yesterday.

thanks,
-- Shuah
