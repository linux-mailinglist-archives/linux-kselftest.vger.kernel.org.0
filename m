Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58032723AB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjFFHzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjFFHyM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:54:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C21172E;
        Tue,  6 Jun 2023 00:51:48 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 882CC6602242;
        Tue,  6 Jun 2023 08:51:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037907;
        bh=BqZOGQbEcyYCHcBE1RRO2kBEWXV2+B/RC+2FIhcFIDQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=QKazdlAQyr0a+xe5O6k37BRnj9CwvM7X9kmjf9BQS2S9G41BXy3z8dJskBw3QM1EM
         aUX6xep0bsF0M6UoNq1dYoWXbR+E9CP6cuE+13CimEJR7gL/7fqMlf16ZHhEMCiudZ
         4sTfGyAmwwoUlPqGtf5WMZV02lLQZAVZS7qbRgZy+iN+c8CbTAiAD0d6Wg6er1acQi
         FzLtr+KEK4auuB0K22WOUDsAC3u6RDbxw2SOez0zHtAxI5Adwx3b+ud1tmcd3abz2l
         ywzSq46t1xjSuttD7Em0UiwnZGQhpwqTqWbWhffxy9j8/MTCNR8H5buaQQpysXhFW0
         8aQ61uL++/krQ==
Message-ID: <9464d0a6-adc2-9b7e-4771-4eb3805d02aa@collabora.com>
Date:   Tue, 6 Jun 2023 12:51:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] selftests/mm: fix invocation of tests that are
 run via shell scripts
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-5-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-5-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 12:16 PM, John Hubbard wrote:
> We cannot depend upon git to reliably retain the executable bit on shell
> scripts, or so I was told several years ago while working on this same
> run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
> lately failing to run, due to lacking execute permissions.
> 
> Fix this by explicitly adding "bash" to each of the shell script
> invocations. Leave fixing the overall approach to another day.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 4893eb60d96d..8f81432e4bac 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
>  	if [ "$ARCH" == "$ARCH_ARM64" ]; then
>  		echo 6 > /proc/sys/vm/nr_hugepages
>  	fi
> -	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
> +	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
>  	if [ "$ARCH" == "$ARCH_ARM64" ]; then
>  		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
>  	fi
>  fi # VADDR64
>  
>  # vmalloc stability smoke test
> -CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
> +CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
>  
>  CATEGORY="mremap" run_test ./mremap_dontunmap
>  
> -CATEGORY="hmm" run_test ./test_hmm.sh smoke
> +CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate

-- 
BR,
Muhammad Usama Anjum
