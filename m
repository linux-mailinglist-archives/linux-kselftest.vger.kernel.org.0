Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA01757BF36
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGTUar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTUaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 16:30:46 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11C315A3C;
        Wed, 20 Jul 2022 13:30:45 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6E7313F3C0;
        Wed, 20 Jul 2022 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658349044;
        bh=BGEt2HkznZL24U9s42qayMEz611QIKArNki0juuuhFQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=mo7CpljjuC+AVQaJAPR5Wau+gc41VQAzRNFKOx8d+OwVA7oWD/aVhhr7BFB88QmfF
         uacq1yNK0vNuSQc3C8xY10V8bwekJw5r2RFux0ljP8a8Zq94be/XtCNvw/5ICnLtL9
         R77uNeu+RFTCz+7z49M9cunb7KKeuy2G0mHTk1vamK4AJmFU1H9gm4SMQzgjVzztSZ
         yqB6Angro8QXfGizezJY5tZFhZjJ/MmYFGY3axlo80JfT1OZmwu3lmxzmB1lh0wuYy
         Nu0HmgxWPQjf3V2R9zFNeiK7FrZTuJnRAJ/JF3he42QEhCI1tnd/NzE1tWOF+mTOWH
         Kr0p5MlyoSsNA==
Message-ID: <6f32491d-cefa-0a3c-a2e5-3c9cd40ec8a1@canonical.com>
Date:   Wed, 20 Jul 2022 13:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] apparmor: test: Remove some casts which are no-longer
 required
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220706100607.75761-1-davidgow@google.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220706100607.75761-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/6/22 03:06, David Gow wrote:
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in policy_unpack_test are no longer required.
> 
> Remove the unnecessary casts, making the conditions clearer.
> 
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: David Gow <davidgow@google.com>

I have pulled this into apparmor-next

> ---
> 
> This is a rebase and resend of [1], which had been accepted into the
> AppArmor tree, but eventually conflicted with [2]. Let's push it via the
> KUnit tree to avoid any further conflicts, as discussed in [3].
> 
> Cheers,
> -- David
> 
> [1]: https://lore.kernel.org/linux-kselftest/20210513193204.816681-9-davidgow@google.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f91bd9f1e7ad5a2025a2f95a2bc002cb7c9e0f9
> [3]: https://lore.kernel.org/all/20220405125540.2135d81d@canb.auug.org.au/
> ---
>   security/apparmor/policy_unpack_test.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 5c18d2f19862..7954cb23d5f2 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -177,7 +177,7 @@ static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
>   
>   	array_size = unpack_array(puf->e, name);
>   
> -	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
> +	KUNIT_EXPECT_EQ(test, array_size, 0);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>   		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
>   }
> @@ -391,10 +391,10 @@ static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
>   
>   	size = unpack_u16_chunk(puf->e, &chunk);
>   
> -	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
> +	KUNIT_EXPECT_PTR_EQ(test, chunk,
>   			    puf->e->start + TEST_U16_OFFSET + 2);
> -	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
> -	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
> +	KUNIT_EXPECT_EQ(test, size, TEST_U16_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (chunk + TEST_U16_DATA));
>   }
>   
>   static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
> @@ -408,7 +408,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
>   
>   	size = unpack_u16_chunk(puf->e, &chunk);
>   
> -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
> +	KUNIT_EXPECT_EQ(test, size, 0);
>   	KUNIT_EXPECT_NULL(test, chunk);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
>   }
> @@ -430,7 +430,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
>   
>   	size = unpack_u16_chunk(puf->e, &chunk);
>   
> -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
> +	KUNIT_EXPECT_EQ(test, size, 0);
>   	KUNIT_EXPECT_NULL(test, chunk);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
>   }

