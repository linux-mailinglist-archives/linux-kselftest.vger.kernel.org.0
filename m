Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE13C6CA29F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 13:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjC0Lja (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0Lja (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 07:39:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EA330FE;
        Mon, 27 Mar 2023 04:39:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bi9so10979591lfb.12;
        Mon, 27 Mar 2023 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679917167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MXsTO1YaTjQaF1C2U0QAcp9mTJJ/Y0aDw0l/cFukcA=;
        b=dJ7uEVyurBgijJf3BLp6Cz6LS0l4osnxZTNEcOkK3vHvpVC6XIGCDqxNCQqOOROC0o
         06KxlK4V37IpRQUre+VKvdztnGoFTwDi5awmOui03+sK6pnJQ8nGii2LuzZlp1kCtePf
         PIh5Obmob2xP42PT7UIMbin5rqdjwCWs6KIBZDAklJmNQEnqxeoz+3IQgj+uJ+QVUZGL
         lyaN6Qbu3IoyjmJnqNVNy1opG3jdKrCqPfSIQ5cxg7l3kV6nQ60KdXjQz7BevQrLITgZ
         sGfZXte7vH/q8gvgixdqC2u3SRjbft93l4nOpHCBgKrn2KhCSxsVvIwo4QkJoTSg7qSc
         Qn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MXsTO1YaTjQaF1C2U0QAcp9mTJJ/Y0aDw0l/cFukcA=;
        b=jj6Ox6e366mY24vZ4WpKr2jDMC/ozV+gSAdbUwXJZnu2L05CI8uTzKH3dmfVrtud1T
         WeaKGiLvZU4w6HNMxN3eUyZ/KAxTNzd5aE5mjsAK3n7Ek/TlD2B5vZLx8dE5vIJuqMnt
         m5P8rvcJafQcV34EAPhZb2Y4I7j/QbOUDl/61wHrT/EuffswzfbSEqb5oY7mL90VseJf
         Oh1yvXpqlicXasIpiYuqw14mZ0GhOn9EdItL1Bke8+09BrfvM1Qcl6ahc/pFnJL1lvA3
         v/a+0H04jFlIxbKzymQiX5pLsVTgZtf+MyfbMfqlnucOnNN55TOgQyJSYI2E+VYfG5Z0
         KI+g==
X-Gm-Message-State: AAQBX9dqY0XzblLj1TOS1mJXMogCNum45Z5e+cVphtZ4wqYUbfpwpGbb
        I4JqjwGwAzsIpZnxTJZZAho=
X-Google-Smtp-Source: AKy350YWi0FEXzPC7jGgefKJ/Iv50AfF7CkjgHbeoTQxsS1jMiJGxcdiEafeBaS1LJmkxnLZq8YPBw==
X-Received: by 2002:ac2:4c11:0:b0:4dc:65c0:c74e with SMTP id t17-20020ac24c11000000b004dc65c0c74emr3176233lfq.29.1679917167014;
        Mon, 27 Mar 2023 04:39:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id i15-20020ac25d2f000000b004a6f66eed7fsm4619465lfb.165.2023.03.27.04.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 04:39:26 -0700 (PDT)
Message-ID: <091178da-f4dd-52f7-3cb6-f6f4b92bf6c4@gmail.com>
Date:   Mon, 27 Mar 2023 14:39:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 0/7] Support ROHM BU27034 ALS sensor
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, Zhigang Shi <Zhigang.Shi@liteon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org
References: <cover.1679915278.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/23 14:27, Matti Vaittinen wrote:
> Support ROHM BU27034 ALS sensor
> 
> The patch 1/7 introduces the helpers for creating/dropping a test device
> for devm-tests. It can be applied alone.

Sorry folks. The wrapper is 3/7 not 1/7

> The patch 4/7 (IIO GTS tests) also depends on the patch 1/7 (and also
> other patches in the series).
> 
> Rest of the series should be Ok to be applied with/without the patches
> 1/7 and 4/7 - although the 4/7 (which depends on 1/7) would be "nice to
> have" together with the rest of the series for the testability reasons.
> 

snip.

> 
> Matti Vaittinen (7):
>    dt-bindings: iio: light: Support ROHM BU27034
>    iio: light: Add gain-time-scale helpers
>    kunit: Add kunit wrappers for (root) device creation

Here.

>    iio: test: test gain-time-scale helpers
>    MAINTAINERS: Add IIO gain-time-scale helpers
>    iio: light: ROHM BU27034 Ambient Light Sensor
>    MAINTAINERS: Add ROHM BU27034
> 
Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

