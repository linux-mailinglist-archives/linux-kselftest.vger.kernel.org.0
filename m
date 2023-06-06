Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C20723ABF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjFFH5e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjFFH5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:57:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2B30E0;
        Tue,  6 Jun 2023 00:54:39 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1FA96606E98;
        Tue,  6 Jun 2023 08:54:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038077;
        bh=pIGKvYGDq4T5r3V/OOhF4iPvxLXerjQw652JcJRg8XM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ZhwgoBkNEfc858rFfDwHEziWJCXBGbCiT9KcASsdCA1q+WF96wi7NcL913qqnfzWU
         OPeqri3jdY5sJsn5g+juVYRmfcgDM+vSgOcFxtV7FYAMN3fpM5YyQIihMqehaRnDZp
         MGfQ3GHISalJizfUUjfbhgJZz+UCCD+iLcqz3vHtO3Yg6r631UGJK9pfXPIMaWGlAl
         xyUQhWWlgBvXcUSoDVWec1YElRBvaM4sOctVQ8xjZBsD+KfEJhtUeDIWUcVPcpPgzV
         zYZJkUZlJjRRTo2B9OpHAgiZ3e5mFOf2mhABP8nUsvajUV2shBACl6VLLFilTs5qpp
         ZmUylZSLjUvbg==
Message-ID: <53862bd4-c991-a17f-eacb-25ab2aa1e7b0@collabora.com>
Date:   Tue, 6 Jun 2023 12:54:30 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/11] selftests/mm: fix two -Wformat-security warnings
 in uffd builds
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-7-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-7-jhubbard@nvidia.com>
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
> The uffd tests generate two compile time warnings from clang's
> -Wformat-security setting. These trigger at the call sites for
> uffd_test_start() and uffd_test_skip().
> 
> 1) Fix the uffd_test_start() issue by removing the intermediate
> test_name variable (thanks to David Hildenbrand for showing how to do
> this).
> 
> 2) Fix the uffd_test_skip() issue by observing that there is no need for
> a macro and a variable args approach, because all callers of
> uffd_test_skip() pass in a simple char* string, without any format
> specifiers. So just change uffd_test_skip() into a regular C function.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/uffd-unit-tests.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 269c86768a02..04d91f144d1c 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -109,12 +109,11 @@ static void uffd_test_pass(void)
>  		ksft_inc_fail_cnt();		\
>  	} while (0)
>  
> -#define  uffd_test_skip(...)  do {		\
> -		printf("skipped [reason: ");	\
> -		printf(__VA_ARGS__);		\
> -		printf("]\n");			\
> -		ksft_inc_xskip_cnt();		\
> -	} while (0)
> +static void uffd_test_skip(const char *message)
> +{
> +	printf("skipped [reason: %s]\n", message);
> +	ksft_inc_xskip_cnt();
> +}
>  
>  /*
>   * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
> @@ -1149,7 +1148,6 @@ int main(int argc, char *argv[])
>  	uffd_test_case_t *test;
>  	mem_type_t *mem_type;
>  	uffd_test_args_t args;
> -	char test_name[128];
>  	const char *errmsg;
>  	int has_uffd, opt;
>  	int i, j;
> @@ -1192,10 +1190,8 @@ int main(int argc, char *argv[])
>  			mem_type = &mem_types[j];
>  			if (!(test->mem_targets & mem_type->mem_flag))
>  				continue;
> -			snprintf(test_name, sizeof(test_name),
> -				 "%s on %s", test->name, mem_type->name);
>  
> -			uffd_test_start(test_name);
> +			uffd_test_start("%s on %s", test->name, mem_type->name);
>  			if (!uffd_feature_supported(test)) {
>  				uffd_test_skip("feature missing");
>  				continue;

-- 
BR,
Muhammad Usama Anjum
