Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7855B2CBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 05:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiIIDKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 23:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiIIDJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 23:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291571269E0
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 20:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662692767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRURgtGX8X3gpTPCUapV5nkhXYJnWyoPcRU7PWh1IAs=;
        b=YzhX2FBYb9u/ExPmhXy4HVb385+D+3M7bbhT/jM9Jzhh/5YdVBhixZtMRJw+Y9JI4djWGN
        OBaRIVF0GZXCB38Wq3laHB0FNxenKivFaUVoeYMeThhse2PzfbMmctPHnri1oilK/LDOxw
        BYYCLYfKzwLd+ohTE6pHYqVoMaXiKH0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-X_mtU_SfNYiT8Xhn8MfWeA-1; Thu, 08 Sep 2022 23:06:06 -0400
X-MC-Unique: X_mtU_SfNYiT8Xhn8MfWeA-1
Received: by mail-ot1-f69.google.com with SMTP id l15-20020a9d550f000000b0063707d0f4dbso247365oth.11
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 20:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IRURgtGX8X3gpTPCUapV5nkhXYJnWyoPcRU7PWh1IAs=;
        b=t63Ez5tOOvkrcL/5/0a2gRgdy55av0Dv3L3izCgsHhNnSRueVuyRWzOasFisrAj8CO
         5V52m3cckseKQ7l7Nx97aTqCgccipLamhp+98lpgTPNrCjB1oxNZW7LWr22tSdeyzoZ4
         J2/sXTcvE3wRxIDtbT/3NtK3BQ70tssmi0x8OX3sUTeQLrneXn4BOtjIjx9NTgZttsp8
         yBnPI1HJBTz49yUKRwle62U3dNmFZn+0ummSRkA5r6USVrVFzYn/SIdBcaGarwGcn6Kl
         PKg/RjdwIuJcGtnXvR8ZzvWafexR/b8zzrUmFshWQUVvmsWtFmNGNG54N20E5l+IlRA3
         P9ZA==
X-Gm-Message-State: ACgBeo3IbWbaWnb5n/dGea9CxI4J6ZP1ejMysKeSrR2+s8jwequGJ9Vr
        3uFZj6y082v+kWm2MdsRNR0/+gx+4VsxfjsWeyGz3Q+PE5ORW0ZAS7241LZoxuIQicTWGCHbkVM
        m2yWC+LULrGMUBpGQd+x1FnwSOuL5
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id em4-20020a0568705b8400b0010cd1fa2f52mr3722562oab.92.1662692764982;
        Thu, 08 Sep 2022 20:06:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7MQiTOsG/QP8z4+DXZZztMsLYD43y8DUCK2rtP6/D2kclafpQbqKTECgoOL2i3LP5yOo6VOw==
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id em4-20020a0568705b8400b0010cd1fa2f52mr3722553oab.92.1662692764777;
        Thu, 08 Sep 2022 20:06:04 -0700 (PDT)
Received: from ?IPV6:2601:280:4401:4fe0::518a? ([2601:280:4401:4fe0::518a])
        by smtp.gmail.com with ESMTPSA id 5-20020aca1105000000b00344cc0c4606sm157038oir.58.2022.09.08.20.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 20:06:04 -0700 (PDT)
Message-ID: <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com>
Date:   Thu, 8 Sep 2022 23:06:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220420084036.4101604-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/20/22 04:40, Muhammad Usama Anjum wrote:
> Bring common functions to a new file while keeping code as much same as
> possible. These functions can be used in the new tests. This helps in
> avoiding code duplication.

This commit breaks a pattern in the way tests are run in the current scheme.
Before this commit the only executable (or TEST_PROGS) that was executed was
run_vmselftests.sh. Now both madv_populate and split_huge_page_test are being
run as well.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V6:
> - Correct header files inclusion
> 
> Changes in V5:
> Keep moved code as same as possible
> - Updated macros names
> - Removed macro used to show bit number of dirty bit, added a comment
>   instead
> - Corrected indentation
> ---
>  tools/testing/selftests/vm/Makefile           |   7 +-
>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
>  tools/testing/selftests/vm/vm_util.h          |   9 ++
>  5 files changed, 124 insertions(+), 113 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>  create mode 100644 tools/testing/selftests/vm/vm_util.h
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 5e43f072f5b76..4e68edb26d6b6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>  TEST_GEN_FILES += hugepage-shm
>  TEST_GEN_FILES += hugepage-vmemmap
>  TEST_GEN_FILES += khugepaged
> -TEST_GEN_FILES += madv_populate
> +TEST_GEN_PROGS = madv_populate
madv_populate is already being run in run_vmselftests.sh
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
>  TEST_GEN_FILES += map_populate
> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
> -TEST_GEN_FILES += split_huge_page_test
> +TEST_GEN_PROGS += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  
>  ifeq ($(MACHINE),x86_64)
> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> +$(OUTPUT)/madv_populate: vm_util.c
> +$(OUTPUT)/split_huge_page_test: vm_util.c
Not sure what this does but if we add a run entry for split_huge_page_test in
run_vmselftests.sh we wont really need this patch.

I'm not sure the reduction in code size is worth the change in run behavior.

Unless I'm missing something I suggest we revert this patch and add a run entry
for split_huge_page_test in run_vmselftests.sh. I can do this if no one objects.

Cheers,
-- Nico

