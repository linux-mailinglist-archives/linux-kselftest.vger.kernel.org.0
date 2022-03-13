Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F04D768B
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Mar 2022 16:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiCMPtD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Mar 2022 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiCMPtC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Mar 2022 11:49:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425B2AC5A;
        Sun, 13 Mar 2022 08:47:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 605331F40F25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647186470;
        bh=CCqUGFGxjyViNQvtNtCtKouDccPCWjKRmkU2e2G8UNg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LgrFoCEL9ScYZ0PGKRkMDWdF11oCpAviEmMXWAxZor/fKQrdsJmWjnuxQxXAnadIh
         hsOCwWi8gY8u2skbSJO/etoK+kFczgtmTihD2ESVt3pEjC66N1sMsC2UP2GWbyLDNw
         t5XGHwVm6N7VcmZ2bJZf4wqssM2URzKZ/2eSsnqfm+LaqRQjUmqNevunt7xhZ0PvyW
         kkkJdp1Tmx3Trp1CUMoraNEcipKwypLIWDdid+FfPQy6JSCwNiYofEQ8mc5r3UYx9A
         od1gtuN9438gYgZC2iI+91t3RmMszj03okHZXVPn8MezY2JrhRM+HnjD5Bl+cK3aGs
         /nNBnSil8eRkw==
Message-ID: <0d4663b0-d2b9-5f8a-8476-5c81541704af@collabora.com>
Date:   Sun, 13 Mar 2022 20:47:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 4/6] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
 <20220311072147.3301525-5-tan.shaopeng@jp.fujitsu.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220311072147.3301525-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/11/22 12:21 PM, Shaopeng Tan wrote:
> In kselftest framework, all tests can be build/run at a time,
> and a sub test also can be build/run individually. As follows:
> $ make kselftest-all TARGETS=resctrl
> $ make -C tools/testing/selftests run_tests
> $ make -C tools/testing/selftests TARGETS=resctrl run_tests
> 
> However, resctrl_tests cannot be run using kselftest framework,
> users have to change directory to tools/testing/selftests/resctrl/,
> run "make" to build executable file "resctrl_tests",
> and run "sudo ./resctrl_tests" to execute the test.
> 
> To build/run resctrl_tests using kselftest framework.
> Modify tools/testing/selftests/Makefile
> and tools/testing/selftests/resctrl/Makefile.
> 
> Even after this change, users can still build/run resctrl_tests
> without using framework as before.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/Makefile         |  1 +
>  tools/testing/selftests/resctrl/Makefile | 18 +++---------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index d08fe4cfe811..6138354b3760 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -52,6 +52,7 @@ TARGETS += proc
>  TARGETS += pstore
>  TARGETS += ptrace
>  TARGETS += openat2
> +TARGETS += resctrl
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 6bcee2ec91a9..30af27b07d21 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,17 +1,5 @@
> -CC = $(CROSS_COMPILE)gcc
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
CFLAGS = $(KHDR_INCLUDES)
Please can you add this line to build this test with kernel's latest
uapi headers always? At this moment, this isn't required. But in future
if some kernel headers are changed and this test is updated to build
with latest kernel headers, the build will start to fail when following
command will be used:
make -C tools/testing/selftests O=build

> -SRCS=$(wildcard *.c)
> -OBJS=$(SRCS:.c=.o)
> +TEST_GEN_PROGS := resctrl_tests
>  
> -all: resctrl_tests
> +include ../lib.mk
>  
> -$(OBJS): $(SRCS)
> -	$(CC) $(CFLAGS) -c $(SRCS)
> -
> -resctrl_tests: $(OBJS)
> -	$(CC) $(CFLAGS) -o $@ $^
> -
> -.PHONY: clean
> -
> -clean:
> -	$(RM) $(OBJS) resctrl_tests
> +$(OUTPUT)/resctrl_tests: $(wildcard *.c)

-- 
Muhammad Usama Anjum
