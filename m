Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2B52F978
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiEUHCJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 03:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEUHCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 03:02:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5575711C;
        Sat, 21 May 2022 00:02:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 498B91F46903
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653116526;
        bh=sH7UfRS3UIUyKaHG2wGRnh4xyDEGveCZlyH381jkeBM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VqS6LSySAqQZ3JKakpXk+RNPCsmH3C7OVYMrB/92uFJ2zD9lZGicwJbUnhLbrbEny
         lV1p9o/Vu9eHZsk76jzZkBMPekXuXeOn9Osopfy5FF2psSm/hbcELr4r1Nn6Rzf+Qw
         O+bmZmYJEngCSbE7qTQuQFdGM2xxFyTfvD1z1ITr3gNWnfmc+QN6xlUDYv+D6memeb
         0uOqog9QwCNfCeo5O62e0ObCvgyCWeOkVklcu58yGGziqUv22gTivgYRVinWnqWrRx
         2XnqPEtzblh2s+3egs6y2KZUJJnIvmvkwXGSGZTjVfArlbO9jQKus0AUNdofGEYrFJ
         a4zW7FMJe7hTg==
Message-ID: <3dfca666-21b7-f5fd-a22e-54562e9215f6@collabora.com>
Date:   Sat, 21 May 2022 12:02:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/kselftest: add more guidelines for adding new tests
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20220317172758.582690-1-usama.anjum@collabora.com>
 <07033c8a-fe1a-f97e-49b3-48d1da1e0413@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <07033c8a-fe1a-f97e-49b3-48d1da1e0413@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/18/22 9:50 AM, Bagas Sanjaya wrote:
>> + * Use lib.mk instead of writing Makefile from sratch. Specify flags and
>> +   binaries generation flags on need basis before including lib.mk. ::
>> +
>> +    CFLAGS = $(KHDR_INCLUDES)
>> +    TEST_GEN_PROGS := close_range_test
>> +    include ../lib.mk
>> +
> 
> I think what you mean is "In your Makefile, use facilities from lib.mk by
> including it instead of reinventing the wheel.", right?
Yes, right.

> 
>> + * Add new test name in TARGETS in selftests/Makefile::
>> +
>> +    TARGETS += android
>> +
>> + * All of the following build commands should be successful
>> +
>> +   - Same directory build of kselftests::
>> +
>> +      make kselftest-all
>> +      make kselftest-install
>> +      make kselftest-clean
>> +      make kselftest-gen_tar
>> +
>> +   - Build with absolute output directory path::
>> +
>> +      make kselftest-all O=/abs_build_path
>> +      make kselftest-install O=/abs_build_path
>> +      make kselftest-clean O=/abs_build_path
>> +      make kselftest-gen_tar O=/abs_build_path
>> +
>> +   - Build with relative output directory path::
>> +
>> +      make kselftest-all O=relative_path
>> +      make kselftest-install O=relative_path
>> +      make kselftest-clean O=relative_path
>> +      make kselftest-gen_tar O=relative_path
>> +
>> +   - Build from Makefile of selftests directly::
>> +
>> +      make -C tools/testing/selftests
>> +      make -C tools/testing/selftests O=/abs_build_path
>> +      make -C tools/testing/selftests O=relative_path
>> +
> 
> For simplicity, we can say "All changes should pass
> kselftest-{all,install,clean,gen_tar} builds."
We (me and maintainer) want a list of commands to run before patch
submission. I'll use the {...} short hand method and update.

> You don't need to spell out full command-line in the guideline unless
> absolutely necessary, in general.
> 

-- 
Muhammad Usama Anjum
