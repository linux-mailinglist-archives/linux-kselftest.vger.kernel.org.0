Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5036E0E16
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDMNJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 09:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjDMNJL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 09:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D26A42
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681391303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLxMOFwtCTuKusCwzTh/CCer82vVpWIO4TFSOoP+UhY=;
        b=LCuwI5Elr6lGFE2gLd0e9ueWLz84t8c7HMC5/3KEsSZGusfiIW0S3dNu9vuubqc2sgcIb1
        wpfA+bz0U9j4eJtG8RLN5Ioz8mgS60ro8CNHSBmrGBhvKlYjGK8Cv4lvsXhk/qw/uKqNEh
        OsDNeLO/KjB1ei+49EmwcioJFfR+now=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-l6QYrXCoOJqHxCe8ORbS-w-1; Thu, 13 Apr 2023 09:08:22 -0400
X-MC-Unique: l6QYrXCoOJqHxCe8ORbS-w-1
Received: by mail-wr1-f70.google.com with SMTP id i18-20020adfa512000000b002efac436771so2875565wrb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 06:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391301; x=1683983301;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLxMOFwtCTuKusCwzTh/CCer82vVpWIO4TFSOoP+UhY=;
        b=hW8mOdGDk50viJ5qWTrtgibkfV/IepIlLpRt68Wa6AVXI5MoW8yP+gi8Xhy3umDOop
         L03sD0PPnsCtYRamFCvxmAtzcJkIAiLHBVR43JT1BSR7uN48D6WO0N+QOoh3sH0tKjzb
         UDrayVpa/hZ2iA5A8veA9h9F3O+5FZSVTE2e8ipK15qhIDETh9IrNWlpERP8mk59WolB
         w3OxbTsms9mxvUf5n2d0xc3Cq/UirplLrFeiAVs2PG5kz0yaCLcSGBWzNe3FEc8KmWRz
         lQA1YpqV+K4OAbcw4QqzCopfybXUPJHCDvzLIDJTW2K8xnzutQzT4Fw+Hepuwm6FNzic
         dbSQ==
X-Gm-Message-State: AAQBX9dGfxt2LMfyFRR1O9supv9/XklBUnqlsMq0UKasPbErwyHcDNRL
        0Udfl/GZ1TSG641zzzbuwaE6cKRNlU7dz+2H9dD7IJXidU4fs/+i1GSfYXfhzAdXwqLY9ZdurHo
        ID8BA6a0avfBaIlmnRGet+tD4DIFu
X-Received: by 2002:a05:600c:2051:b0:3ed:8780:f27b with SMTP id p17-20020a05600c205100b003ed8780f27bmr1888727wmg.16.1681391301107;
        Thu, 13 Apr 2023 06:08:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y55JsVfSG6cqI5hM+rvCoSFl0/EwbLG1ziWZ2V3jk+27V2WCnOKEnjqr3iEAcf0fE0IxV6mQ==
X-Received: by 2002:a05:600c:2051:b0:3ed:8780:f27b with SMTP id p17-20020a05600c205100b003ed8780f27bmr1888702wmg.16.1681391300734;
        Thu, 13 Apr 2023 06:08:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id hn25-20020a05600ca39900b003f0a9e986ddsm1282283wmb.24.2023.04.13.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:08:20 -0700 (PDT)
Message-ID: <190bed16-7b7b-a880-9793-cdeb1baef29d@redhat.com>
Date:   Thu, 13 Apr 2023 15:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 3/3] selftests/mm: add new selftests for KSM
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-4-shr@devkernel.io>
 <7c5606cc-ca58-c505-b0d3-2eec29fe606a@redhat.com>
Organization: Red Hat
In-Reply-To: <7c5606cc-ca58-c505-b0d3-2eec29fe606a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.04.23 15:07, David Hildenbrand wrote:
> On 12.04.23 05:16, Stefan Roesch wrote:
>> This adds three new tests to the selftests for KSM.  These tests use the
>> new prctl API's to enable and disable KSM.
>>
>> 1) add new prctl flags to prctl header file in tools dir
>>
>>      This adds the new prctl flags to the include file prct.h in the
>>      tools directory.  This makes sure they are available for testing.
>>
>> 2) add KSM prctl merge test
>>
>>      This adds the -t option to the ksm_tests program.  The -t flag
>>      allows to specify if it should use madvise or prctl ksm merging.
>>
>> 3) add KSM get merge type test
>>
>>      This adds the -G flag to the ksm_tests program to query the KSM
>>      status with prctl after KSM has been enabled with prctl.
>>
>> 4) add KSM fork test
>>
>>      Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited
>>      by the child process.
>>
>> 5) add two functions for debugging merge outcome
>>
>>      This adds two functions to report the metrics in /proc/self/ksm_stat
>>      and /sys/kernel/debug/mm/ksm.
>>
>> The debugging can be enabled with the following command line:
>> make -C tools/testing/selftests TARGETS="mm" --keep-going \
>>           EXTRA_CFLAGS=-DDEBUG=1
> 
> Would it make sense to instead have a "-D" (if still unused) runtime
> options to print this data? Dead code that's not compiled is a bit
> unfortunate as it can easily bit-rot.
> 
> 
> 
> This patch essentially does two things
> 
> 1) Add the option to run all tests/benchmarks with the PRCTL instead of
> MADVISE
> 
> 2) Add some functional KSM tests for the new PRCTL (fork, enabling
> works, disabling works).
> 
> The latter should rather go into ksm_functional_tests().


"tools/testing/selftests/mm/ksm_functional_tests.c" is what I wanted to say.

-- 
Thanks,

David / dhildenb

