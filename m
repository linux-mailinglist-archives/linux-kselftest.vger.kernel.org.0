Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E436FB5CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjEHRSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjEHRSF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 13:18:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49A199A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 10:18:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763970c9a9eso15930939f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683566283; x=1686158283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8qlp5XghttjEan5YOKeJGzJQmCiegmZ3khpFvV4ZPs=;
        b=AO1hRYtglviVhhGSoTuSJwmjPi3RErsHCMTxnnQap1CnXC6UFQWMjmYvvxAatKg9VR
         bkFSRlXrZOcFkVtIKyfLw+2PA6OKDphDtHeWdBqfxY1g+tGLMOkpkejSjKwV/sUJxi4X
         cT0YryWbViHXgSNQO+9ytmYt7C8F8yvEhDTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566283; x=1686158283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8qlp5XghttjEan5YOKeJGzJQmCiegmZ3khpFvV4ZPs=;
        b=bTK8fcvrWRPPAXQzks5K0xatKm7KU6wISb2aV2YpB+kyBJnolI+Z6+W9UucIe2P9DP
         0gWQA47fMJ9j+1sskKknempA8OHpg2hYVbXc7OI9Y9q0QoBBguLpnFRRI7gCBjMgTRB4
         s8IccuoxpyOMEV4l4PHrMTayFkVp1SCxt+OErCtP4wF2iShpJdDFjX1kvTVhYw9Cwk/V
         OICdlujdiDkWexg3oqUDuz326Sc4u0LPDovbpBJ6DF580+sjRlYhjK7+qIjL9VJfO2hC
         QK/hJm6ZPIMd3cESbvDMwzkxXfoM/EDQbjyXrrM9eud3PJ4Yvu0w3b1q44SdmPOeb8kN
         gECA==
X-Gm-Message-State: AC+VfDwczEGVystLXwl5ZNIzgX2u1lXyUTowj0lTaDbxl0xpM4yJH/i2
        pQ0zTuixei6lGFUx/2HxvM9LGw==
X-Google-Smtp-Source: ACHHUZ63FdKEvsQgOvOAIVrabDVRnQT5Xqa4b68JbCg4HQ9KHodRuCp9TmxxO1eWiLYMXUkpIl3nog==
X-Received: by 2002:a05:6e02:1d05:b0:331:1129:b8a9 with SMTP id i5-20020a056e021d0500b003311129b8a9mr5643487ila.1.1683566283068;
        Mon, 08 May 2023 10:18:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a14-20020a92d34e000000b0032732e7c25esm2541449ilh.36.2023.05.08.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:18:02 -0700 (PDT)
Message-ID: <e886a835-f2d1-4fd0-8e02-82cc3a878870@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:18:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] selftests/ftrace: Improve integration with kselftest
 runner
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230302-ftrace-kselftest-ktap-v2-1-ecc482212729@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230302-ftrace-kselftest-ktap-v2-1-ecc482212729@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/8/23 07:15, Mark Brown wrote:
> The ftrace selftests do not currently produce KTAP output, they produce a
> custom format much nicer for human consumption. This means that when run in
> automated test systems we just get a single result for the suite as a whole
> rather than recording results for individual test cases, making it harder
> to look at the test data and masking things like inappropriate skips.
> 
> Address this by adding support for KTAP output to the ftracetest script and
> providing a trivial wrapper which will be invoked by the kselftest runner
> to generate output in this format by default, users using ftracetest
> directly will continue to get the existing output.
> 
> This is not the most elegant solution but it is simple and effective. I
> did consider implementing this by post processing the existing output
> format but that felt more complex and likely to result in all output being
> lost if something goes seriously wrong during the run which would not be
> helpful. I did also consider just writing a separate runner script but
> there's enough going on with things like the signal handling for that to
> seem like it would be duplicating too much.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied now to linux-kselftest fixes for Linux 6.4-rc2

thanks,
-- Shuah

