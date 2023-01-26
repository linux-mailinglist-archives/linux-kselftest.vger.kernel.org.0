Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11F67D93D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 00:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjAZXCm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 18:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjAZXCl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 18:02:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6B53E55
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 15:02:39 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z194so1190369iof.10
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9omwqtwuc85K7LEkKSWtwNAar0VyOxK9btJvk18NJo=;
        b=ZNrZ5p2KUOB9ePfsX17Iqg6/VNrzhYXKOrOdnADpeYhW0wEK3CvdOHNLRxMpOWeosH
         nftb4y6p+C+u5AHPREPQ6W+siNmugXVKwkZY0n+zDb3/qGgjU1A+0kWAxF1BqDNieDFO
         bSuLgXJmZB6r5VbvEJYHIsah5BXK8kLx2nPDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9omwqtwuc85K7LEkKSWtwNAar0VyOxK9btJvk18NJo=;
        b=jTcihkf6OfpmZTncWU63OmrPpXOWCH2W9p1cmq8PUWF5qTDZvsWwpVQLX9JD1yZa/k
         UEkyHLTXPagycCQMQa8o/j7RNf0ZopO3j1AfL/Zg5jK0c5KXbIqJ2grCLVzWddfAbGER
         5cHqBzUVg5wMab94CjiVDdyvc1CI1JU2B4g+I2322svbKkVF0Vm7PKMe8lNpcImQqfDT
         zPP4VMsl3sg5qNirU7YkvE83wpGftFtqFxL/cc+VuCPwttvQg1xg/6Xixeav5yAhEZuq
         gVMgfAw057vSxQ1jlzXpX0znzBdZREMuzl27wlaxGL2BPZtCk7TwDeLFcLh/dLvJ/Fk2
         Kp+g==
X-Gm-Message-State: AFqh2kq+O63usDYGnQNXLcjbVpIbH4VMgssGTPxm7MHJv4AxBS+axybL
        CgZRLN9+Y6bX5tPjaZEoUp15rQ==
X-Google-Smtp-Source: AMrXdXt+h7gIE22nfJF58oX0weinUqQvFOamJUOo6SFDog6ExIMZ4zTJgBV8/JDhWNDP6MOt3W6QlA==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr4953600ioj.1.1674774158742;
        Thu, 26 Jan 2023 15:02:38 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p131-20020a6b8d89000000b00704cfea96a7sm666498iod.47.2023.01.26.15.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:02:38 -0800 (PST)
Message-ID: <cd443a9c-e5d1-a530-0400-c2cbddb6e58a@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 16:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] testing: kselftest_harness: add filtering and enumerating
 tests
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230125231356.1070986-1-kuba@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230125231356.1070986-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/25/23 16:13, Jakub Kicinski wrote:
> As the number of test cases and length of execution grows it's
> useful to select only a subset of tests. In TLS for instance we
> have a matrix of variants for different crypto protocols and
> during development mostly care about testing a handful.
> This is quicker and makes reading output easier.
> 
> This patch adds argument parsing to kselftest_harness.
> 
> It supports a couple of ways to filter things, I could not come
> up with one way which will cover all cases.
> 
> The first and simplest switch is -r which takes the name of
> a test to run (can be specified multiple times). For example:
> 
>    $ ./my_test -r some.test.name -r some.other.name
> 
> will run tests some.test.name and some.other.name (where "some"
> is the fixture, "test" and "other" and "name is the test.)
> 
> Then there is a handful of group filtering options. f/v/t for
> filtering by fixture/variant/test. They have both positive
> (match -> run) and negative versions (match -> skip).
> If user specifies any positive option we assume the default
> is not to run the tests. If only negative options are set
> we assume the tests are supposed to be run by default.
> 
>    Usage: ./tools/testing/selftests/net/tls [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]
> 	-h       print help
> 	-l       list all tests
> 
> 	-t name  include test
> 	-T name  exclude test
> 	-v name  include variant
> 	-V name  exclude variant
> 	-f name  include fixture
> 	-F name  exclude fixture
> 	-r name  run specified test
> 
>    Test filter options can be specified multiple times. The filtering stops
>    at the first match. For example to include all tests from variant 'bla'
>    but not test 'foo' specify '-T foo -v bla'.
> 
> Here we can request for example all tests from fixture "foo" to run:
> 
>   ./my_test -f foo
> 
> or to skip variants var1 and var2:
> 
>   ./my_test -V var1 -V var2
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - use getopt()
> 

Thank you. I applied this to linux-kselftest next for Linux 6.3-rc1

thanks,
-- Shuah



