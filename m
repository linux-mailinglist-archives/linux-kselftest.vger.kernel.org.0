Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1F6B6300
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Mar 2023 04:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCLDOd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 22:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCLDOc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 22:14:32 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5C83CE0A;
        Sat, 11 Mar 2023 19:14:31 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id bo10so6203865qvb.12;
        Sat, 11 Mar 2023 19:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678590870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5OCAEk0pvKYlAk7IZt+dUus+mMzuNElR+Bz01K7S0k=;
        b=IrKJnmizti4sSlJDnAqcy4dnKpg+S28nkHvaasvlkoNygGqW+aHKfM29XqJLAo4pcr
         kzLEovpF9wrQGlFXj9SaQQ/BWY+nOqlzGLnVHt3l4ftA+efqYCSKIv4RM/JMKK15UvWI
         T/0ph7SADG3ebil5kTrYps7oJerhamk/KXlGs5KK3DCEk4aqOk0ocF3L6o0TWZ75Ztof
         Tt05Fbu3eV5oIYiJ5H01+UW0d4AQmSJSm1MRNnUpSvzprZW7J0WzPgLPJTqTU0kQ8KGT
         p1fi6UyBy9+GiFj2kMjm+dGRb553mlwtfwfjzuqQZwfYaUON9gCoqpF1Pc8REtAVLWI7
         YVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678590870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5OCAEk0pvKYlAk7IZt+dUus+mMzuNElR+Bz01K7S0k=;
        b=l/oFEq4rFW/oG20vKUJmWeqhLvrkYG+eYPNemsCzmFs64w/cmAw8gHstCECFiTY3gF
         P+ZCWtgXVBXZNswNAmbJHZYm4EIh8p92dy8u5mCA4PpqUEYC56OlY2B+uN7I8H5RclJK
         wCZ5KB4TwbG/OXwSOdyH9P8sWL9oVLRyRUTjrge6mv4PjDOoeo8yGLZ9BuJks8TKHlhb
         2JacvmfCB3z+kVe6brwQln3f8pxqj8OilPs8zmv9TcVQEiQ+ajL0XX3oEAza0Wg+qmlw
         fUkcQBqgDJCDqoMelmZPSCxsKj1BIdysV3ZzmYLhJotGi5dgRiZp0xaPdQlyDRxiJv27
         wzzw==
X-Gm-Message-State: AO0yUKV4GirNN+IPu1dP3vLTqfTT1snT+zuQYUpFKLTQbx6Iho/1RCtr
        aDfRBE5BDDyUyPCUoLDjQA8=
X-Google-Smtp-Source: AK7set/AxS15pge8gVtFcMi1MHDGns/GIwklJxyX4utvPJOKbNgFURvQWJbVvQ9udeXrGRJAQt5z7w==
X-Received: by 2002:ad4:4ee2:0:b0:56e:ff37:6b6e with SMTP id dv2-20020ad44ee2000000b0056eff376b6emr12836728qvb.10.1678590870174;
        Sat, 11 Mar 2023 19:14:30 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:147a:a472:2165:1ae5? ([2600:1700:2442:6db0:147a:a472:2165:1ae5])
        by smtp.gmail.com with ESMTPSA id s20-20020a37a914000000b00741a984943fsm2851634qke.40.2023.03.11.19.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 19:14:29 -0800 (PST)
Message-ID: <5e101997-77c9-4dc0-e439-90b3b550e1f3@gmail.com>
Date:   Sat, 11 Mar 2023 21:14:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310222002.3633162-1-rmoar@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230310222002.3633162-1-rmoar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/10/23 16:20, Rae Moar wrote:
> Add the test result "skip" to KTAP version 2 as an alternative way to
> indicate a test was skipped.
> 
> The current spec uses the "#SKIP" directive to indicate that a test was
> skipped. However, the "#SKIP" directive is not always evident when quickly
> skimming through KTAP results.
> 
> The "skip" result would provide an alternative that could make it clearer
> that a test has not successfully passed because it was skipped.

< snip >

General information about the KTAP Specification version 2 process and progress
can be found at:

   https://elinux.org/Test_Results_Format_Notes#KTAP_version_2

This patch has been added to that page.
