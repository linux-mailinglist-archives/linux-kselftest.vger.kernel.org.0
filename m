Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F695746B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiGNI2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiGNI2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 04:28:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB93AE40;
        Thu, 14 Jul 2022 01:27:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t1so1593102lft.8;
        Thu, 14 Jul 2022 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2pK5vnd3CztnzTkE+rNKn5a3mKucIwku8ySPesIgYDQ=;
        b=ZaBl6ghxvOoCi15XY7qnZBNcwSAQq29ipWDnkOjW6Sp5EsSr7uOPMemPswdqcPWkYp
         6MZiFNq9PAhKgbk0xizQDei8rGueEFZCLniFzvjS2ugzK8lo6oQWrcqd5KgCliZfdO9+
         12EozpOMgeZApBKc02vGMBtiEoYOGUEuZIh7VrniCktqlKIgt5niU1W2xTXyf1eW4UcO
         nf7W5NgqChCM9CKHYbWOnpxdX8ncjlitS7vuPeFs9hoMx6ztcL+EON+bB6bSwdJhlOd2
         CQFNzcgW8kmbUMyica39G2XhqPWzRRcfv/VKFsP1V6D9ivzhgCjyRSLtMdG8T+cWFG7X
         mS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pK5vnd3CztnzTkE+rNKn5a3mKucIwku8ySPesIgYDQ=;
        b=LVpkF89vUI+RzafkCY50kCZK/r/ua+9PjUkzxLYuResSIpDRWlqcyoz2GUDZNxFxpS
         16oIF5hPLXhykjGT4R+tntizW0b341QGBKg6T7GdE4SIsuTYSaQS6QKwiZ0OFYdQkdNx
         95GVlp3YxKIeCRguFTAQ/JaXfWjMGLC+lTnbv0PC/HYCca8QZo59I+IidPfM3iJqN/na
         yS2AJNcseKwpY0TlY/LsJLAzkbJuf1IRkojUiQ9FJyTh7hLeWX1VGyItWEVtwqb7ZbkK
         3UitlltlQIJfMsiXA4JE81UKm6tJbwMlKxieI6W4GgMXpjR8TjHQZctNQCck7EUJwZOt
         Puaw==
X-Gm-Message-State: AJIora8ZDuQK10mB39InRvt/Wi54rorRCAk3oRyIW5lqGvsRWgs6ei/0
        U8G4DD7vAGjrs4yPWgsKusfAV14c6Xk=
X-Google-Smtp-Source: AGRyM1t+uRyJiclu/xiFS5ssRkQcD6WpY+R19402VHqaEJtkQFqVPRddhHNT4oZ92QGEmNDMBxg3nA==
X-Received: by 2002:a05:6512:ea1:b0:489:2930:9f1a with SMTP id bi33-20020a0565120ea100b0048929309f1amr4760060lfb.291.1657787277443;
        Thu, 14 Jul 2022 01:27:57 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.79.77])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512345200b00489f0c8bddesm234621lfr.207.2022.07.14.01.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:27:56 -0700 (PDT)
Subject: Re: [PATCH 8/9] selftests: timers: clocksource-switch: add 'runtime'
 command line parameter
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <23526df7-b77d-4223-71ee-51c456dbc236@gmail.com>
Date:   Thu, 14 Jul 2022 11:27:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On 7/13/22 11:46 PM, Wolfram Sang wrote:

> So the user can decide how long the test should run.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  tools/testing/selftests/timers/clocksource-switch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
> index 5256e6215980..a1d0d33738b6 100644
> --- a/tools/testing/selftests/timers/clocksource-switch.c
> +++ b/tools/testing/selftests/timers/clocksource-switch.c
[...]
> -	while ((opt = getopt(argc, argv, "s")) != -1) {
> +	while ((opt = getopt(argc, argv, "st:")) != -1) {
>  		switch (opt) {
>  		case 's':
>  			do_sanity_check = 0;
>  			break;
> +		case 't':
> +			runtime = atoi(optarg);
> +			break;
>  		default:
>  			printf("Usage: %s [-s]\n", argv[0]);
>  			printf("	-s: skip sanity checks\n");

   Hm, you probably forgot to update the usage msg?

[...]

MBR, Sergey
