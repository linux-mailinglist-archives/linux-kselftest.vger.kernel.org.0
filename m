Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D944CC4FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiCCSUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 13:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCCSUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 13:20:22 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC151A39D9
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 10:19:36 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i1so4698259ila.7
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RsfBPvPjQbWkfsCIFYKkOFEX828krrg1hMvPgj+lvz8=;
        b=PyMMU7qd3oxhlTEd4LwgKVZiAwtJU9yGeJOO8HaL9O6vrQ9heD8W9dpOccJJd0UZBT
         dGoSWYAUHus0lHdGEC20BH8OhFs8nmbDRa5Eql/UnOR537ZiOfx1rFltWrpKJaD+IJy2
         J0dmpBD1r440ShZFzYCIMttBv1kQxMvBrvtZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RsfBPvPjQbWkfsCIFYKkOFEX828krrg1hMvPgj+lvz8=;
        b=nrHSVJ81RkrIZSmiwOW76llkv2tGYZEf8bOhsbcX/c/vXE1VBZbMPn/E3DAezH7C0W
         gWJO88Two1CzZ+iRP1rRoSv7qLUs1T05FTSwd+RzZBuCBBRE+hYOHwgMjnnCFjwK8p0V
         zdgvtT2r4/lJSDC3RDvMXbT6jObYy413fTNTUuW3vk3B/bqgGtV5WYc/vH7qgVB5GEAF
         FEFE3rSybZaK7r0AlC2A7vldQ5yGQ7fqeFQwsoPcnpo1W3AfiaTUR9uLGK5cMdvBhnPQ
         BYrSwAaCLfF8TMk3TdR1M3ntyX34FGDSxSMesWqfn8keSYmF/AKMkm+ciksEbtVyZ9x/
         ZlWQ==
X-Gm-Message-State: AOAM533JRWZhKUT6mUfYs7iOYlJ0BppwBPHsz6r99IipFjJj9L/UdQKH
        UmwxzgmcOY92a8Vt/O2/m0sfNKti9PNFBg==
X-Google-Smtp-Source: ABdhPJzGtaHtk93Fcgl7CY6dZAId/kJM/jiFz5lw+/DNdeg20AQ9EenL+JMfZK/b/qGR4YvOpOIGug==
X-Received: by 2002:a92:3314:0:b0:2bc:8054:9780 with SMTP id a20-20020a923314000000b002bc80549780mr29857850ilf.12.1646331576267;
        Thu, 03 Mar 2022 10:19:36 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d9483000000b00640d3d4acabsm2488331ioj.44.2022.03.03.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 10:19:35 -0800 (PST)
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
To:     David Hildenbrand <david@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
 <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6133317f-4da0-3aae-f352-b75f0f94dbd4@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 11:19:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/28/22 2:37 AM, David Hildenbrand wrote:
> On 24.02.22 22:23, Muhammad Usama Anjum wrote:
>> This introduces three tests:
>> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
>> check if the SD bit flipped.
>> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
>> 3) Check soft-dirty on huge pages
>>
>> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
>> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
>> same issue that he fixed, and this test would have caught it.
>>
> 
> A note that madv_populate.c already contains some SOFTDIRTY tests
> regarding MADV_POPULATE. Eventually we want to factor out
> softdirty/pagemap handling+checks for easier reuse.
> 
> 

Is this patch unnecessary then?

thanks,
-- Shuah
