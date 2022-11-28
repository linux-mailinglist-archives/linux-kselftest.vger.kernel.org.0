Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567363B272
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 20:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiK1Tow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiK1Tov (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 14:44:51 -0500
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FAA205D2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 11:44:49 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NLbXH1PfpzMq2xb;
        Mon, 28 Nov 2022 20:44:47 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NLbXG0YsSz3b;
        Mon, 28 Nov 2022 20:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669664687;
        bh=xtG6qsMJEfUAt6o9RtMO7Q9XohBwkoKwmV/hAY7T+fk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R/XAxh8PlLTIrSeHXZgYmfRsKzExLYNoB3M5VKPSHJU0PAuzhH7fLzerfGiPFnje5
         0S95vulRmmaxsNkv4e8Zr212jNQx/sbWsXZcEcGbE4IKRujgIRCCaAoi3SyDV59/NY
         RXeiQKkoTai2lF12S33yMaKorotSHLqSqSEB/krE=
Message-ID: <1232e4f3-e4b8-ff23-61e8-5465c8406f6e@digikod.net>
Date:   Mon, 28 Nov 2022 20:44:44 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run
 fail
Content-Language: en-US
To:     limin <limin100@huawei.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, songmuchun@bytedance.com, tj@kernel.org,
        lizefan.x@bytedance.com
References: <20221128020409.1545717-1-limin100@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221128020409.1545717-1-limin100@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch changes the test semantic and then cannot work on my test 
environment. On which kernel did you run test? Do you use Yama or 
something similar?

On 28/11/2022 03:04, limin wrote:
> Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
> trace parent return -1 when child== 0
> How to reproduce warning:
> $ make -C tools/testing/selftests TARGETS=landlock run_tests
> 
> Signed-off-by: limin <limin100@huawei.com>
> ---
>   tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index c28ef98ff3ac..88c4dc63eea0 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
>   		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
>   		err_proc_read = test_ptrace_read(parent);
>   		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
> +		EXPECT_EQ(-1, ret);
> +		EXPECT_EQ(EPERM, errno);
>   		if (variant->domain_child) {
> -			EXPECT_EQ(-1, ret);
> -			EXPECT_EQ(EPERM, errno);
>   			EXPECT_EQ(EACCES, err_proc_read);
>   		} else {
> -			EXPECT_EQ(0, ret);
>   			EXPECT_EQ(0, err_proc_read);
>   		}
>   		if (ret == 0) {
