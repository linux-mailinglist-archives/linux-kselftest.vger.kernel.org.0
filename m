Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F067756A0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQRVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGQRVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CCBD
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awDD/PnKcb73hu3hURpoBUxVh2rUvvdxON48PSh59dM=;
        b=jOQpbB74/GEsF/prkOib+QNZFgwSVY/XrcazImAaIZJKaDNGuMTUrNHM602zwogKA2j6h5
        pZJCfzkYjY5IH3SIceW75hrsvM5rggYU+RV3EovmTjSA4UaogVv0De0Fh5wQTVaU+pYd1i
        YnAdCTX1X6zCAkg9x6hPK7QzBHjR0EE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-t8T9Ss84PtmLj_Eal7aAjA-1; Mon, 17 Jul 2023 13:20:33 -0400
X-MC-Unique: t8T9Ss84PtmLj_Eal7aAjA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso2602973f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614432; x=1692206432;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awDD/PnKcb73hu3hURpoBUxVh2rUvvdxON48PSh59dM=;
        b=gBOZiDPcUwkWtbeIZgISqdzevNbFu32jZKaIrlW/QOklwaBNNzCZcsDoQN3Z/l7sQt
         nokSdN6h22/PH6or1dB969L6kmGeAE4j8eAiO7T9hsmxaTbtUbSxFaFFjHsn7ZHQdVgS
         aWQz1s1qHnUxZ6DFkdCceVtba607RsBEJsMqIX75mK0sY1FYdD4IGpCDqu+9G44naQex
         5jv4t+Iwx7NpvJFNelKG00f2vyZDYYz2RwDzsbos2gV200r0DRA1yVfHS/X384mGNH8+
         GZgeQhSAOLmxrDZEkIti5tDaa6LdKVEOMqrT3F7Sq6800paAK4oQROVek9Q+Lmj7hFb1
         K5ww==
X-Gm-Message-State: ABy/qLZSWCm9J/fAYhE6C58L2dOSIjafNm3ziBz0Vs+JBd0b+ggOozfO
        rKz1pszUzv1fw0TXL0gwB2nIrMkQVpWdCEZmYnuNgBoAU6oixS0W78uxC9Ta8begzTazZLMh5KS
        OH4VPbAm02XcqMwhJky/ZOwXPwAlH
X-Received: by 2002:a5d:5088:0:b0:314:53b5:92d5 with SMTP id a8-20020a5d5088000000b0031453b592d5mr10315399wrt.36.1689614432478;
        Mon, 17 Jul 2023 10:20:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEW6ZkAhNCQJHfhJ9Q5FlIjPycYOIpuMSAAaLJLfQDIz/wbbCBZgG9bHcogDmThf/psJWKk7g==
X-Received: by 2002:a5d:5088:0:b0:314:53b5:92d5 with SMTP id a8-20020a5d5088000000b0031453b592d5mr10315384wrt.36.1689614432122;
        Mon, 17 Jul 2023 10:20:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id u9-20020adfed49000000b00313f031876esm17465wro.43.2023.07.17.10.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:20:31 -0700 (PDT)
Message-ID: <99dead0d-08e2-ab1c-46dc-d3f4f97a71e8@redhat.com>
Date:   Mon, 17 Jul 2023 19:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/8] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-3-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717103152.202078-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
> arm64 does not support the soft-dirty PTE bit. However, the `soft-dirty`
> test suite is currently run unconditionally and therefore generates
> spurious test failures on arm64. There are also some tests in
> `madv_populate` which assume it is supported.
> 
> For `soft-dirty` lets disable the whole suite for arm64; it is no longer
> built and run_vmtests.sh will skip it if its not present.
> 
> For `madv_populate`, we need a runtime mechanism so that the remaining
> tests continue to be run. Unfortunately, the only way to determine if
> the soft-dirty dirty bit is supported is to write to a page, then see if
> the bit is set in /proc/self/pagemap. But the tests that we want to
> conditionally execute are testing precicesly this. So if we introduced
> this feature check, we could accedentally turn a real failure (on a
> system that claims to support soft-dirty) into a skip. So instead, do
> the check based on architecture; for arm64, we report that soft-dirty is
> not supported.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/Makefile        |  5 ++++-
>   tools/testing/selftests/mm/madv_populate.c | 26 ++++++++++++++++++++--
>   tools/testing/selftests/mm/run_vmtests.sh  |  5 ++++-
>   3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 66d7c07dc177..3514697fc2db 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -63,12 +63,15 @@ TEST_GEN_PROGS += thuge-gen
>   TEST_GEN_PROGS += transhuge-stress
>   TEST_GEN_PROGS += uffd-stress
>   TEST_GEN_PROGS += uffd-unit-tests
> -TEST_GEN_PROGS += soft-dirty
>   TEST_GEN_PROGS += split_huge_page_test
>   TEST_GEN_PROGS += ksm_tests
>   TEST_GEN_PROGS += ksm_functional_tests
>   TEST_GEN_PROGS += mdwe_test
>   
> +ifneq ($(ARCH),arm64)
> +TEST_GEN_PROGS += soft-dirty
> +endif
> +
>   ifeq ($(ARCH),x86_64)
>   CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index 60547245e479..17bcb07f19f3 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -264,14 +264,35 @@ static void test_softdirty(void)
>   	munmap(addr, SIZE);
>   }
>   
> +static int system_has_softdirty(void)
> +{
> +	/*
> +	 * There is no way to check if the kernel supports soft-dirty, other
> +	 * than by writing to a page and seeing if the bit was set. But the
> +	 * tests are intended to check that the bit gets set when it should, so
> +	 * doing that check would turn a potentially legitimate fail into a
> +	 * skip. Fortunately, we know for sure that arm64 does not support
> +	 * soft-dirty. So for now, let's just use the arch as a corse guide.
> +	 */
> +#if defined(__aarch64__)
> +	return 0;
> +#else
> +	return 1;
> +#endif
> +}

I guess that will also make the compiler remove any traces of 
test_softdirty()( from the binary.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

