Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2354ED90
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 00:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378587AbiFPWrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbiFPWri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 18:47:38 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0151276A
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 15:47:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bd16so3510068oib.6
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GM+MxIdk9slM5wjdPHD9Zax+Dsa/pID19o6T4nwKFOY=;
        b=AdJKbDYjyOsot33Mt5w2UgXp5E4FLRH4NkzxBwxPiPtcjG2oX+cnUys4Q6R518FkGs
         jfrSh2msjbfDnnVQvq1MPQk3EcamkjY62ZNWlHlWXaJF5Sez/ZSk0AW3/ig1FajhibDb
         rBr+oz6HJTMU27pUb0lEe61u6Fk7Maah4z/+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GM+MxIdk9slM5wjdPHD9Zax+Dsa/pID19o6T4nwKFOY=;
        b=xsEPcnpTUgXt7YknG6Fo0lXqXZ5SC/RPOZWdjNGul7AD4OWgvNmv3LwYqjtSN6G1av
         tGvT69amgATypZl/vXNr99QbUeAq9TGcEGep8Mui3cam/87q0HoTGhlM+mLrYxmiTUuu
         PETesOgaMgiEMpXZGqpZeKiXYnzm2xHArnd8uM7eUvx0+CCt1490Li7/SdOioDNEELhl
         s2p/EsceLQgnKd+9kQdVp5YYRjdYUfdj9H7kSFuUr7ocKqyBs7x4ueaI8ppkJlrYTt8G
         AWNMb2LgNePuImlmUhJQAjXw7i13npTpMOCUA568Fmx80u3CX7LORBIo8d2XogtgXYid
         I2Uw==
X-Gm-Message-State: AJIora9hCNTsQnOxCsrlYwOXl2Fts/WqHXfUchwum4xhkGmNQnnJ/mtc
        4FhYwokULLPf8UCPZiBzt84DLQ==
X-Google-Smtp-Source: AGRyM1sB8bWR1e15e8NLmVfJh4/Uu6LO7hmk6kC9SvkATS7W4FbUb3nJs40uaE6qDhQHX7dHApDNcw==
X-Received: by 2002:a05:6808:1b12:b0:32e:6c9f:fb13 with SMTP id bx18-20020a0568081b1200b0032e6c9ffb13mr3680171oib.172.1655419655747;
        Thu, 16 Jun 2022 15:47:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l3-20020a4aa783000000b0041bc35464e0sm1719359oom.0.2022.06.16.15.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:47:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests/x86/signal: Adjust the test to the kernel's
 altstack check
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
 <20220401221014.13556-2-chang.seok.bae@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8b3eb12a-a962-a17e-04d4-7121d751504b@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 16:47:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220401221014.13556-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/1/22 4:10 PM, Chang S. Bae wrote:
> The test assumes an insufficient altstack is allowed. Then it raises a
> signal to test the delivery failure due to an altstack overflow.
> 
> The kernel now provides an option to tweak sigaltstack()'s sanity check to
> prevent an insufficient altstack. ENOMEM is returned on the check failure.
> 
> Adjust the code to skip the test when this option is on.

Mention the option name here and in the Skip message.

> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/testing/selftests/x86/sigaltstack.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
> index f689af75e979..22a88b764a8e 100644
> --- a/tools/testing/selftests/x86/sigaltstack.c
> +++ b/tools/testing/selftests/x86/sigaltstack.c
> @@ -88,8 +88,18 @@ static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
>   
>   static void test_sigaltstack(void *altstack, unsigned long size)
>   {
> -	if (setup_altstack(altstack, size))
> +	if (setup_altstack(altstack, size)) {
> +		/*
> +		 * The kernel may return ENOMEM when the altstack size
> +		 * is insufficient. Skip the test in this case.
> +		 */
> +		if (errno == ENOMEM && size < at_minstack_size) {
> +			printf("[SKIP]\tThe running kernel disallows an insufficient size.\n");

Please improve this message to clearly why it is okay to skip the test.
Mention that the option to disallowing insufficient is enabled and that
the test can't be run.


> +			return;
> +		}
> +
>   		err(1, "sigaltstack()");
> +	}
>   
>   	sigalrm_expected = (size > at_minstack_size) ? true : false;
>   
> 

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
