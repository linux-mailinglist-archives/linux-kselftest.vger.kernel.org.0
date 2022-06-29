Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6255FAE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiF2Iog (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiF2Iog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 04:44:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1283B549;
        Wed, 29 Jun 2022 01:44:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so561988pju.1;
        Wed, 29 Jun 2022 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=78JJ3ZqpPNBpyTaz/WIYnN5t99AiYTULbLhYxhpV/I8=;
        b=PTuUavxRIJk+Bf1WnHIoAPIWof3FtFPF/TCsyb/PuN71MI024ri/2Q2iwZ0gWeachE
         5pFo4iPlmcgJfVmSPJrsT5KPA9rts/jS4YYT7+0u4utzGN3TcxrEEatLC9vZyxYNfdKt
         BAwjEvCpho5tSBz2p0QZZxDGUtSFIO+RII6Fm+qxrTs3Jb/ztJBExbaBJe8r2q3xAgL1
         gVjiPx1AaCLWePMvPZBYl1zxuDmp6ZxpigDdC0Ks/N7lovF+Preg0/QSDjaidwS8e1jr
         dlhQCkgvzd6RjYW5JoxLfG5tgel1A7MbQhbQS9Sdni8XGMpR91kH/gjdoQIu/JpRcNuV
         vWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=78JJ3ZqpPNBpyTaz/WIYnN5t99AiYTULbLhYxhpV/I8=;
        b=bsSNjhx9byHagAmELacWymPEtUd+IScv8xZ1KDCg1DJjxtg0MR1DxNMrxVX5hNEMrW
         7TZ31YQzWwIL43zeWxK/8e9dQRg7VqQTbkEbRF7Mxdbg+/VjqDiqEzhAi0/+/JXxxodK
         pl9eI9+3ZBBprMM4YBSbSikb5XJStsblXL7c53DUuZBtNSRwAP1/wxXHJF+53CCiqTvm
         IKn2nmslO61ShuIaPYcSAux2DpLHGIsSta5L3Z9XyLRey2XIzJ9SgjHZwtqPQPSgPMTs
         95XafUprm8CLwjcQh7uTjGuCI+v2ySqGWe8SCa9NUdWUR9tbHvxIBzf0x+k9sjC1aTxr
         5gzA==
X-Gm-Message-State: AJIora8qRi1IcI1j2m8vjJMTniteDE4nr13PNoW4qHIUinRf/U6PTkM6
        V4SQwAW1TTLA9XvoZynTzQm3mK5N6pk=
X-Google-Smtp-Source: AGRyM1uPAvPy05JP0TnfDi5RCZhtCy6A5azhgBRtYgl7lHcHIXeCV9+onflnnPAZiebKm00FOWl9FA==
X-Received: by 2002:a17:90b:3a8d:b0:1ef:7d4:6a5f with SMTP id om13-20020a17090b3a8d00b001ef07d46a5fmr2620753pjb.139.1656492275306;
        Wed, 29 Jun 2022 01:44:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id 14-20020a62180e000000b0051bf246ca2bsm10904955pfy.100.2022.06.29.01.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:44:34 -0700 (PDT)
Message-ID: <321d069a-0db3-6abd-c25e-4da46f361bd7@gmail.com>
Date:   Wed, 29 Jun 2022 15:44:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Documentation: kunit: Cleanup run_wrapper, fix x-ref
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20220626101553.1885428-1-davidgow@google.com>
 <20220629040605.2395481-1-davidgow@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220629040605.2395481-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/29/22 11:06, David Gow wrote:
> +This means that for most architectures, running under qemu is as simple as:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run --arch=x86_64
> +
> +When cross-compiling, we'll likely need to specify a different toolchain, for
> +example:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py run \
> +		--arch=s390 \
> +		--cross_compile=s390x-linux-gnu-
> +

nit: s/we'll/you'll/

Otherwise looks OK.

-- 
An old man doll... just what I always wanted! - Clara
