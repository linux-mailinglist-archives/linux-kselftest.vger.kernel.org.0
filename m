Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFA77E57C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjHPPpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbjHPPpP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 11:45:15 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909B26A6
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 08:45:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso912727fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692200713; x=1692805513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEU+8ucHz0YvKsSQ3I6NswEdG1bcEE/gZGFPl1VDIx8=;
        b=K6QVykcZbYwc/o6zSziCiKSG+diRzFDHgi7SMz9eb1TIoTwuPsSfoo14OZK8XMuyCp
         mTVALWlqHxpqsaMb1RAkiEiZpONH/yqoESQkoBWJBY+4KmeZLDG86FPqfhp0W5dGsKcN
         uFgVOSzz5RQo3HepuMDIJ5ik4eSO3dxEtA3ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200713; x=1692805513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEU+8ucHz0YvKsSQ3I6NswEdG1bcEE/gZGFPl1VDIx8=;
        b=RVEuq3KB73FUZnqRq17nrcPKQI+feEjkR8usFBNknvhB+nI6M0N+i6s8yTP2+dyxPf
         XFOCAyeFKe8t/d52/sGvR2WbRtIKzFtbHwH7opgjBrCSDRYD2baDXy29aXZcqHhD0qm4
         5oV7KsUqg9bNSGHo1EOQe5Npcq5A00Akgi4guHs66VZkKvnhM3juG3GBlI+NX/YlQ768
         GbKKoRBcrlJazt5Ap5GGA0gf4k93gJuvpeah1HjtqlZYr4On1WwxO1zh96fIGBbuBgVt
         YCY8zzir/WOaE5EC/LusNWM0vcCzSVWOtaLSo+2M5bu70bv2Od64wzkXUo96Jz9GbxvE
         /DTA==
X-Gm-Message-State: AOJu0YxRdBvYuQywKEO8vdG6qaHuA0Nxj5I5gQt67fYlIMFzq9IilKRm
        A3vxUe3uQrZbQFhIoP050ZDyQZCIlAtDaEoF9L4=
X-Google-Smtp-Source: AGHT+IFZI1bmpt8fYRO2PdzcSUfT+9kORGQxxdbSVlMJZKnSIVeZddLfgx78SoeNnj0JlLFaARQHiQ==
X-Received: by 2002:a05:6871:85:b0:1bf:9fa2:bfa3 with SMTP id u5-20020a056871008500b001bf9fa2bfa3mr2207319oaa.1.1692200713576;
        Wed, 16 Aug 2023 08:45:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id zc13-20020a056871270d00b001c03d1a519fsm7545465oab.39.2023.08.16.08.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:45:12 -0700 (PDT)
Message-ID: <26d32ad9-6b83-d959-adae-d7181695db18@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 09:45:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] selftests: ipc: Updates the msgque test to use
 kselftest framework
Content-Language: en-US
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230723064154.89443-1-atulpant.linux@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230723064154.89443-1-atulpant.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/23/23 00:41, Atul Kumar Pant wrote:
> Updates the msgque test to print the pass or fail status after the
> completion of the test.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>   tools/testing/selftests/ipc/msgque.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
> index 656c43c24044..513b1265bb75 100644
> --- a/tools/testing/selftests/ipc/msgque.c
> +++ b/tools/testing/selftests/ipc/msgque.c
> @@ -9,6 +9,7 @@
>   
>   #include "../kselftest.h"
>   
> +#define NUM_TEST_CASES		1
>   #define MAX_MSG_SIZE		32
>   
>   struct msg1 {
> @@ -197,6 +198,7 @@ int main(int argc, char **argv)
>   	int msg, pid, err;
>   	struct msgque_data msgque;
>   
> +	ksft_set_plan(NUM_TEST_CASES);
>   	if (getuid() != 0)
>   		return ksft_exit_skip(
>   				"Please run the test as root - Exiting.\n");
> @@ -243,13 +245,16 @@ int main(int argc, char **argv)
>   		printf("Failed to test queue: %d\n", err);
>   		goto err_out;
>   	}
> +	ksft_test_result_pass("# Test Passed\n");
>   	return ksft_exit_pass();
>   
>   err_destroy:
>   	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
>   		printf("Failed to destroy queue: %d\n", -errno);
> +		ksft_test_result_fail("# Test Failed\n");
>   		return ksft_exit_fail();
>   	}
>   err_out:
> +	ksft_test_result_fail("# Test Failed\n");
>   	return ksft_exit_fail();
>   }

I am not seeing any value in adding these. It already has messages
in error legs and it prints totals at the end:

# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

thanks,
-- Shuah
