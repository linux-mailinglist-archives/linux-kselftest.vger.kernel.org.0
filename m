Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857F681BB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 21:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjA3UsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 15:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjA3UsD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 15:48:03 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57413E0AE;
        Mon, 30 Jan 2023 12:46:51 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 60F753F307;
        Mon, 30 Jan 2023 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675111609;
        bh=RXq2UM0+WksUOmibUuTIAvL8Lbl2rVqMKpgMUhz1XeM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZXDgPGfEC8pCqG7c2Nm0foAQ7q+/b2tORV74ptp1ctfm/vxQARMlBskLaMjKWTjpY
         GMJVpi21mhw9NFbHsRFuWis3hQ/86sx3V4kLpTK2FsjGkxQMwMiCrnSsbB9wHVXQF6
         SwZmPQWQermRBQ7ODwuaeMSBQPsDch/QfX0oU8QxhcW8Knxm/xnPlFN7JtpGG/RVIz
         RZDrjT9BzegIJUEjd2qT05WyY9yvu1uX7+HoeQPiUzveAGOi/t44wJN+KEwf28WYc+
         9aceCaeUeSnbeOVGzH1K7T0wntnTVzvyUXv4BpK/WEty1hlaj1i/HNW7H+NS2Hzm8j
         IgP3Yf0Vhdn7A==
Message-ID: <94ba4bd9-5aaf-2469-457c-196b864c76f1@canonical.com>
Date:   Mon, 30 Jan 2023 12:46:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] apparmor: fix use of strcpy in policy_unpack_test
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     apparmor@lists.ubuntu.com, skhan@linuxfoundation.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20230127201219.775410-1-rmoar@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230127201219.775410-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 12:12, Rae Moar wrote:
> Replace the use of strcpy() in build_aa_ext_struct() in
> policy_unpack_test.c with strscpy().
> 
> strscpy() is the safer method to use to ensure the buffer does not
> overflow. This was found by kernel test robot:
> https://lore.kernel.org/all/202301040348.NbfVsXO0-lkp@intel.com/.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Rae Moar <rmoar@google.com>

lgtm

I have pulled this into apparmor-next

> ---
> 
> Note: This patch is based on the apparmor-next branch. However, the
> patch should also apply cleanly to the kselftest/kunit branch.
> 
>   security/apparmor/policy_unpack_test.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index e1bfdab524b7..5c9bde25e56d 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -69,31 +69,30 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
>   
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
> -	strcpy(buf + 3, TEST_STRING_NAME);
> +	strscpy(buf + 3, TEST_STRING_NAME, e->end - (void *)(buf + 3));
>   
>   	buf = e->start + TEST_STRING_BUF_OFFSET;
>   	*buf = AA_STRING;
>   	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
> -	strcpy(buf + 3, TEST_STRING_DATA);
> -
> +	strscpy(buf + 3, TEST_STRING_DATA, e->end - (void *)(buf + 3));
>   	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
> -	strcpy(buf + 3, TEST_U32_NAME);
> +	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
>   	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
>   
>   	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
> -	strcpy(buf + 3, TEST_U64_NAME);
> +	strscpy(buf + 3, TEST_U64_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
>   	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
>   
>   	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
> -	strcpy(buf + 3, TEST_BLOB_NAME);
> +	strscpy(buf + 3, TEST_BLOB_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
>   	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
>   	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
> @@ -102,7 +101,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
>   	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
>   	*buf = AA_NAME;
>   	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
> -	strcpy(buf + 3, TEST_ARRAY_NAME);
> +	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
>   	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
>   	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
>   
> 
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2

