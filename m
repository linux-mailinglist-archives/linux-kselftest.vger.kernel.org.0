Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD53550646
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiFRRLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiFRRLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 13:11:42 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840F13D72
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 10:11:36 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1016409cf0bso9133809fac.12
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Jun 2022 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B8CXs8G7SKCeidkQWd9kAuICsm7Sw1h76v8hv8CR6wQ=;
        b=cuXb7N4G9pIbYvpYCa6o9PQHUD2DfcKP/+gFugpXKusIPZ8udyvtuH7DJPmo+JUAOL
         8eagpNlDgynjnq8Gd81Y/eopVQYnjECp8OsqpfuRnKA9HNyn++ZH7HNNZ9TIjsRXeSeG
         BvdjwgCJNtORrqw8bW9YNyv+ik/h87ruk6IhWF/Ulomb3roDpockEzXUsaUcJnWsLKey
         JlqmKq38sV0x3yb+kEcSWDJ7IjC7ODgIlcJzGQ3llXc0MXXhANbar/PuhU229R0QH9qT
         lz3fsVlqpE6nT/3L7c8FVrsr8AgyflhOszSQr4SlJOROtqKz5LZwEe2tkhcIJNa2UAy5
         H5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B8CXs8G7SKCeidkQWd9kAuICsm7Sw1h76v8hv8CR6wQ=;
        b=d8gJLZIODtS6u7IpefUDHqBdHqvpqD8IemyZqwfnbqjuc04IEkoY0LYnRPDhOHk9y0
         V5hkWnxtLI+03l/r7sP1k48vjV3yEydJIZN4d5/mRRIROlcp+AjuOq8rJTn96x8DX8VL
         ZCSA7KQPoFGBBBZMSYBtIoQ8l17ei+FBboG4iGhZjUg6XMpkGO0zr7jOwfybkUIkp3SM
         I2CxBW3lOjqf2pUZFfIXDWk3UARoUkrvwuaZKHtNwFGoODlJ5uQfkO/b6GpoK8QAFpr4
         gGwvPJMjKyEKBoLQ31Gz51nTaS2IXb/iudxsyUGE5I2WGafCI1sHdBS7EYEqcSuqCYS6
         E5Dw==
X-Gm-Message-State: AJIora8WnxieNGsWmZVJpO/yBCyaFl3dbeURy6XujV5sNR97HXBh9Sl8
        PSXw/xj7okcFADKEjjNSjnD/Ww==
X-Google-Smtp-Source: AGRyM1tDVmXtipYu/LaRH32Cww8VlWl/7+4pR6EaOfqHWjwGaKiJnIATqU0fJ7tQTyGNrbOvR86wqw==
X-Received: by 2002:a05:6870:538b:b0:101:17f2:d6e with SMTP id h11-20020a056870538b00b0010117f20d6emr13782917oan.200.1655572295844;
        Sat, 18 Jun 2022 10:11:35 -0700 (PDT)
Received: from ?IPV6:2804:14d:8084:84c6:fe26:c42d:aab9:fa8a? ([2804:14d:8084:84c6:fe26:c42d:aab9:fa8a])
        by smtp.gmail.com with ESMTPSA id o5-20020a4a2c05000000b0035eb4e5a6b3sm4677268ooo.9.2022.06.18.10.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 10:11:35 -0700 (PDT)
Message-ID: <3358b97e-021a-82b7-9ae2-2113aea2c2d9@usp.br>
Date:   Sat, 18 Jun 2022 14:11:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/5] Rework KUnit test execution in modules
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
References: <20220618090310.1174932-1-davidgow@google.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
In-Reply-To: <20220618090310.1174932-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/18/22 06:03, David Gow wrote:
> This patch series makes two changes to how KUnit test suites are stored
> and executed:
> - The .kunit_test_suites section is now used for tests in modules (in
>   lieu of a module_init funciton), as well as for built-in tests. The
>   module loader will now trigger test execution. This frees up the
>   module_init function for other uses.
> - Instead of storing an array of arrays of suites, have the
>   kunit_test_suite() and kunit_test_suites() macros append to one global
>   (or per-module) list of test suites. This removes a needless layer of
>   indirection.
> 
> The upshot of this is that it should now be possible to use the
> kunit_test_suite() and kunit_test_suites() macros to register test
> suites even from within modules which otherwise had module_init
> functions. This was proving to be quite a common issue, resulting in
> several modules calling into KUnit's private suite execution functions
> to run their tests (often introducing incompatibilities with the KUnit
> tooling).
> 
> This series also fixes the thunderbolt, nitro_enclaves, and
> sdhci-of-aspeed tests to use kunit_test_suite() now that it works.
> 
> Huge thanks to Jeremy Kerr, who designed and implemented the module
> loader changes, and to Daniel Latypov for pushing the simplification of
> the nested arrays in .kunit_test_suites.
> 
> I've tested this series both with builtin tests, and with modules on
> x86_64, but there's always the possibility that there's something subtle
> and nasty on another architecture, so please test!
> 
> Cheers,
> -- David
> 

I've tested the modules on x86_64 machines, and everything looks fine.
Also, I applied the AMDGPU KUnit tests [1] on top of these patches,
tried out compiling as a module, and it runs pretty well!

Great to see this feature on KUnit!

Tested-by: Maíra Canal <maira.canal@usp.br>

[1] https://lore.kernel.org/dri-devel/20220608010709.272962-1
maira.canal@usp.br/

Best Regards,
- Maíra Canal
