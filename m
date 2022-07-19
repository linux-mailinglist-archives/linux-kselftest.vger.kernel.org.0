Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93DC57A75D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiGSTml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTmk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 15:42:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B351A1B
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:42:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u5so78947wrm.4
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KYWL6l1SVnTvh6sUypslA6sYVUeo7OflVNtW2Oq/QUA=;
        b=Umk5UlaboSJgYJnGfb8ksLAjZRYn+dHlIL1GuAENAswfSXwXtwca6EnAInxuMFkOmQ
         wulLrYUlVq+8yPMZsY2t7zITtBkC4Jf5o+wMqh/TaS6f+B2LyeetbgZUGTRswZ8Tpsh8
         HsLQibanoN52S/h98J/EwyDVlBfkS6TKUfeocLsu+mD3DNVqWwUyvNuTURfsirhbX1Ll
         mfVe9BjefHUQdfapGsozYAPjDRYo3MgV5JSosAaL/2jePpUba48q67D2mLQVclraqn18
         Zi/6sZwaVAm7xFVGMXaNQ9H/JGmlVWrh8yVNNwnUzpjUMWzGNm4yzMfK4wfSTED6sf36
         z4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KYWL6l1SVnTvh6sUypslA6sYVUeo7OflVNtW2Oq/QUA=;
        b=RJuTnl1gklZEzQF+wq3UrToG07jDikMkV0kRKWgyW4TAlOqFZidj0Tta95skwBCWW1
         Nin8MshlK+/qeZWgRYTqmV9eQXbX6xdQ9UO2mr+cbmkRw3xBaRt5z1nBwDhVCXtM5n8/
         rzukEk8g99qGaPnTMcjG5Y7AhJb//6smsvadZTvXPIAnP8NfMa/a+KG+eRrHjFkHNixz
         cO940sJ9Ar63jjE88ztrjW13q3r+y1CYxd5YGaEvEIEAyw7ECkSDg+LrFfQBKuWX84SZ
         rmlASx91IHhJsM4vJsX1i7uI+UJ9h85wutPdiTXIgLY3lh6wiP6hVxDYPbMGD9iFruoM
         P8kA==
X-Gm-Message-State: AJIora+KkhMcRjkJXjawIMR+TIuA5AUom9OedpWEPS1JOTzsQ0KWzMWt
        7K+ANEdr2RAcoqjyq9BUR1k=
X-Google-Smtp-Source: AGRyM1vLTX88RJzXi1pcVFxnYNK0ci4IRhBZvIllXwZY7nRv7ecQ7B68ySfp4KJqVgz2c2rwQfWo+w==
X-Received: by 2002:a05:6000:144a:b0:21d:c50a:89dd with SMTP id v10-20020a056000144a00b0021dc50a89ddmr22275866wrx.608.1658259756418;
        Tue, 19 Jul 2022 12:42:36 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003a2e655f2e6sm20234341wmr.21.2022.07.19.12.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:42:35 -0700 (PDT)
Message-ID: <5355cf8c-96fd-f667-3352-29411c2c0e27@gmail.com>
Date:   Tue, 19 Jul 2022 20:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] selftest/net/xfrm: Add test for ipsec tunnel
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kselftest@vger.kernel.org
References: <Yta1LXmj5e4CPmNA@kili>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <Yta1LXmj5e4CPmNA@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/22 14:44, Dan Carpenter wrote:
> Hello Dmitry Safonov,
> 
> The patch bc2652b7ae1e: "selftest/net/xfrm: Add test for ipsec
> tunnel" from Sep 21, 2020, leads to the following Smatch static
> checker warning:
> 
> 	tools/testing/selftests/net/ipsec.c:2294 main()
> 	warn: impossible condition '(nr_process == 9223372036854775807) => (0-4294967295 == s64max)'
> 
> tools/testing/selftests/net/ipsec.c
>     2278 int main(int argc, char **argv)
>     2279 {
>     2280         unsigned int nr_process = 1;
>     2281         int route_sock = -1, ret = KSFT_SKIP;
>     2282         int test_desc_fd[2];
>     2283         uint32_t route_seq;
>     2284         unsigned int i;
>     2285 
>     2286         if (argc > 2)
>     2287                 exit_usage(argv);
>     2288 
>     2289         if (argc > 1) {
>     2290                 char *endptr;
>     2291 
>     2292                 errno = 0;
>     2293                 nr_process = strtol(argv[1], &endptr, 10);
> --> 2294                 if ((errno == ERANGE && (nr_process == LONG_MAX || nr_process == LONG_MIN))
> 
> nr_process is a u32 so it can't be LONG_MIN/MAX.  Do we even need to test
> this or could we just fall through to the the > MAX_PROCESSES warning?

I would think it's still needed to check parsing underflow/overflow.
But comparing u32 to LONG_MIN/LONG_MAX clearly doesn't make sense.
I think, I did it as the man strtol told, without thinking twice about
the type:

> The  strtol()  function returns the result of the conversion, unless
> the value would underflow or overflow. If an  underflow occurs,
> strtol() returns LONG_MIN. If an overflow occurs,  strtol() returns
> LONG_MAX. In both cases, errno is set to ERANGE.

I think the check of errno == ERANGE can stand without checks for
LONG_MIN/LONG_MAX.

> 
>     2295                                 || (errno != 0 && nr_process == 0)
>     2296                                 || (endptr == argv[1]) || (*endptr != '\0')) {
>     2297                         printk("Failed to parse [nr_process]");
>     2298                         exit_usage(argv);
>     2299                 }
>     2300 
>     2301                 if (nr_process > MAX_PROCESSES || !nr_process) {
>     2302                         printk("nr_process should be between [1; %u]",
>     2303                                         MAX_PROCESSES);
>     2304                         exit_usage(argv);
>     2305                 }
>     2306         }
>     2307 
> 
> regards,
> dan carpenter


Thanks,
         Dmitry
