Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9566E4220
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQIIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDQII2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 04:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D093AA8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681718865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XDJUkJSvTcFW4wLRJcoZAIOzG/umFn3ICclB/IgMrw=;
        b=ejXkr79h5dSm5r8vX3RejGD8WEYyMDlmb2aiT8Lf4pJDSrttp4LS2/k0/xqtKiQ59BqCtB
        ewB3QTcPS6cE+79tyFYdOAFoj1fX5Ov1BkoX6tBSSimQS1wdsXLqqPQFri6vYpLPHmdlti
        ANXizXXz0ANxBjIO7Du8WstdZVkkAFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Gd49fsnKPfO_MfdLF9iM2w-1; Mon, 17 Apr 2023 04:07:44 -0400
X-MC-Unique: Gd49fsnKPfO_MfdLF9iM2w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f6cd27b991so338896f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 01:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718863; x=1684310863;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XDJUkJSvTcFW4wLRJcoZAIOzG/umFn3ICclB/IgMrw=;
        b=dFKGcV2iNOLWk4Rsne1NT+K2oapsgLmjtsZcj/oaPilhBymCNCKUQh+cfW57iVqrXu
         QQx8GcxSQ3FO0pebMLkLtqNUfWg4Ab/GSgxy0VxaKPAz4e8njjL0n5pKKFEtHQ6tW6zp
         lFGWK/wT5nqZoC5xoOLpnEFPpDgTvopgR5qAMqRQWI2XFlc0qZlKoAx9U2AtqpRgSNI7
         0V5uhzX8i97spoZeDwsOHR//3/HddlG885+A8SzqvPPQnEf1IaFdSMVwq3DHkdYTP9Uh
         4D6hszla5tCZeDYdlLsuY8RFBmLtJeLnDRDn0oEO+rkjkeooEPjqT+B52hzZd8Q0H9Ry
         BwGA==
X-Gm-Message-State: AAQBX9dHNYF1sd6l31XlBb1UjWABizXkg5bDtch8Ly845JqfDO307TKR
        XZRXOc4bRTynuL0qh0HE3qc+8QOdgKJooMBzLhKAPj9erZ7GgUgtJVQMWwbAmz1YvorfDtVWISe
        AsokipudD9X7At8ZPMljZzVSTc/Bw
X-Received: by 2002:adf:f4cb:0:b0:2f1:d97f:5711 with SMTP id h11-20020adff4cb000000b002f1d97f5711mr4953833wrp.30.1681718862987;
        Mon, 17 Apr 2023 01:07:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350a9rGmIWSRvojrm++FPjUBfEQgeOHMw1tsfV3SCV6FaW83hBR0mvAH+OMV0MV+atsmj58sfCg==
X-Received: by 2002:adf:f4cb:0:b0:2f1:d97f:5711 with SMTP id h11-20020adff4cb000000b002f1d97f5711mr4953816wrp.30.1681718862608;
        Mon, 17 Apr 2023 01:07:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id h12-20020adffa8c000000b002d322b9a7f5sm9905360wrr.88.2023.04.17.01.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:07:42 -0700 (PDT)
Message-ID: <5b040572-18cd-f1f1-d24e-5d02494cc3ad@redhat.com>
Date:   Mon, 17 Apr 2023 10:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/3] selftests/mm: add new selftests for KSM
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-4-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230415225913.3206647-4-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16.04.23 00:59, Stefan Roesch wrote:
> This adds three new tests to the selftests for KSM.  These tests use the
> new prctl API's to enable and disable KSM.
> 
> 1) add new prctl flags to prctl header file in tools dir
> 
>     This adds the new prctl flags to the include file prct.h in the
>     tools directory.  This makes sure they are available for testing.
> 
> 2) add KSM prctl merge test to ksm_tests
> 
>     This adds the -t option to the ksm_tests program.  The -t flag
>     allows to specify if it should use madvise or prctl ksm merging.
> 
> 3) add two functions for debugging merge outcome for ksm_tests
> 
>     This adds two functions to report the metrics in /proc/self/ksm_stat
>     and /sys/kernel/debug/mm/ksm. The debug output is enabled with the
>     -d option.
> 
> 4) add KSM prctl test to ksm_functional_tests
> 
>     This adds a test to the ksm_functional_test that verifies that the
>     prctl system call to enable / disable KSM works.
> 
> 5) add KSM fork test to ksm_functional_test
> 
>     Add fork test to verify that the MMF_VM_MERGE_ANY flag is inherited
>     by the child process.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

