Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55D6C6907
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 14:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWNCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCWNCN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 09:02:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B70F31E2F;
        Thu, 23 Mar 2023 06:02:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i13so11940394lfe.9;
        Thu, 23 Mar 2023 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576525;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcDN4yLObJ91VpozedlyiBLgn6rGqURr9Yuhok2Y+PA=;
        b=P9YYByKLmgGDibnq/rP1BZQfemo0fBl8D6TnLrSBncDfJdN+NJwfTBfZSQztaByYza
         VYON0dKQBtNI0nLdNUIl1RQDbOEbgATojc8xGo+u24vkXeXtq6IclmD4RXKu45xYZGxK
         JUY1dEeR80lqHDlHJV0RcQBXkk3kK56eyRAVFfyQLzxXoTz0bYGEcX5tGu+YlnaKV61/
         o0nWH3/zDQdXmC6jAo/xDFp2r8cXtGV5IYx+r/z23WyVidpAyofkzx3s6mX4ViwBY9W0
         I725KRdUfwzqXCIGIoxGhZxdSWQXrQfHtvkNuM9if2SvxKFqdX2AHIA9v1TezwGhAK/p
         HR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576525;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcDN4yLObJ91VpozedlyiBLgn6rGqURr9Yuhok2Y+PA=;
        b=yKrtTlp5o2Pz5D9adGysDOKxrQGZsgmw2LEEzfsuwNvfVYA4O1R8+2nenEGmJ1U9ub
         ZrKK61y7OD+Whl1/UjMMkZhdKrysh1eRRYrR8Lxdamc51rv49NeWJtEVRiCBcmtO1zJM
         PoHuWPsSub8c/llhtferllptfD6ZUzl9/YJx+9PEX5XpvwbQz4MrexICD9ih9oTwxooV
         7PBvct8sLwVDe7K2f23Ndit0syTAgXcZ/1RFfdwLY0y4hPu29UxkbPxRY5Nmqns0D3t8
         My74PdrHS0rO9ch6RrcjqnnZJiymyj3aoScM8yhAL6p/m/b2ZbmfcNtpXV+QSdzOfG9j
         5sOw==
X-Gm-Message-State: AO0yUKUt4qvNXUJDIr2gGwHMMAa3224DJt0NLW0lQ4wXKO1js2NhsR39
        R6BhGr/oa5WENCbjV8Uv8e4=
X-Google-Smtp-Source: AK7set+W8n4uIYXwqNHfqW8BE/2LJLNEU5F3JtARAr9XGBckvjabyntzWh8SW6QGar1nj3fcm3GMmQ==
X-Received: by 2002:ac2:55ac:0:b0:4a4:68b7:f86d with SMTP id y12-20020ac255ac000000b004a468b7f86dmr3714637lfg.17.1679576525021;
        Thu, 23 Mar 2023 06:02:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id q5-20020a19a405000000b004db513b017esm2944811lfc.45.2023.03.23.06.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 06:02:04 -0700 (PDT)
Message-ID: <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
Date:   Thu, 23 Mar 2023 15:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com> <20230323101216.w56kz3rudlj23vab@houat>
 <ZBwoRgc2ICBJX/Lq@kroah.com> <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <20230323122925.kqdnomr7i46qnyo4@houat>
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

On 3/23/23 14:29, Maxime Ripard wrote:
> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
> 
> This is the description of what was happening:
> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
Thanks Maxime. Do I read this correcty. The devm_ unwinding not being 
done when root_device_register() is used is not because 
root_device_unregister() would not trigger the unwinding - but rather 
because DRM code on top of this device keeps the refcount increased?

If this is the case, then it sounds like a DRM specific issue to me. 
Whether it is a feature or bug is beyond my knowledge. Still, I would 
not say using the root_device_[un]register() in generic code is not 
feasible - unless all other subsytems have similar refcount handling.

Sure thing using root_device_register() root_device_unregister() in DRM 
does not work as such. This, however, does not mean the generic kunit 
helpers should use platform_devices to force unwinding?

Well, It's almost the best season for ice-fishing in Finland so opening 
a can of worms is not that bad, right? :)

Thanks for the education people! I did learn a thing or two Today.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

