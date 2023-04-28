Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A96F1802
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjD1MbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjD1MbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 08:31:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14D49D9;
        Fri, 28 Apr 2023 05:31:16 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FC7566032C8;
        Fri, 28 Apr 2023 13:31:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682685074;
        bh=tGnKZ3rFZPSqnR4uOMIKu6wtOcsB+ljP83ONKnVPrRw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ne+9e738HldKPMdZI5/oYXoALzeip99I9e4nH4zIaOlhdLEEqvw9n+Q8mB6YtYqL6
         nLp26+vrjlFo7kctTV94njb7JGrzWJ7NxhWqNTKnqp4sZPR+mRprtuvfWlrRH/a8qy
         X3veJRuVYIh8k7yP5melVdsjrlsFJp+3hpCsp2YjXUxXcHAlfTx34com41k79AUrLB
         Jz9kD6kkl3OYRoY3bV1XXu/vYmkfkqLrjOgPUE03pA3GrP6ry7Caz8eK0V9gwwp9pc
         oLutCw2CFWppl5XZKevs0R9NxHvsIFGUnQCOD16sEuZ8pHSb1kQQWC4jM/i+P5QST8
         5oMC8/tZXeP5g==
Message-ID: <9005b73c-85c5-8296-e329-5bb87bc8c3ec@collabora.com>
Date:   Fri, 28 Apr 2023 17:31:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        heng.su@intel.com, pengfei.xu@intel.com
Subject: Re: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
Content-Language: en-US
To:     Yi Lai <yi1.lai@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, shuah@kernel.org, jethro@fortanix.com,
        bp@suse.de
References: <20230421033123.445883-1-yi1.lai@intel.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230421033123.445883-1-yi1.lai@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/21/23 8:31 AM, Yi Lai wrote:
> The "test_encl.elf" file used by test_sgx is not installed in
> INSTALL_PATH. Attempting to execute test_sgx causes false negative:
I've ran the following on next-20230427:
make -C tools/testing/selftests O=build2 -j `nproc`

find | grep test_encl.elf
./build2/kselftest/sgx/test_encl.elf

test_encl.elf is being copied already. Am i missing something?
> 
> "
> enclave executable open(): No such file or directory
> main.c:188:unclobbered_vdso:Failed to load the test enclave.
> "
> 
> Add "test_encl.elf" to TEST_FILES so that it will be installed.
> 
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Signed-off-by: Yi Lai <yi1.lai@intel.com>
> ---
>  tools/testing/selftests/sgx/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 75af864e07b6..50aab6b57da3 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -17,6 +17,7 @@ ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
>  
>  TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
> +TEST_FILES := $(OUTPUT)/test_encl.elf
I think this isn't needed just like sign_key.o is being copied already.
test_encl.elf is being copied.
>  
>  ifeq ($(CAN_BUILD_X86_64), 1)
>  all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf

-- 
BR,
Muhammad Usama Anjum
