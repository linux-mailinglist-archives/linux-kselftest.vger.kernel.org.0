Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1E56BF74
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiGHROo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 13:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiGHROl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 13:14:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175365D78
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 10:14:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k1so8647466ilu.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQnzdIq7+kcCIvPMe8V0sHVmwLfuOTlfVM008Ot6Py4=;
        b=KI9BztZAwGWqBN5V1q9QnQ2P553xwqMKcJ1PBZIbyQ7gMbZPbkeCwQL3TbLR8A5j79
         QjWhHerTmnfbkFySBQWjI5Y6BrZ/J1AOGdsuqZZLFZnkJNeuGMMCQiIYx7Qj85SKPQU9
         YlPkwY6JZKg/99Wui6eZ0i9bCYygP39NxVGc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQnzdIq7+kcCIvPMe8V0sHVmwLfuOTlfVM008Ot6Py4=;
        b=tQ8IZfYywumAuGGsxES8DVqM6w4oV0Ya2uNQRXus+IZvdg7Ii2ZzuvAXMuC78Mqy9i
         v39wqwGTuemo/KG3VvlDBglv8RsVZbD+cTHlJYxqBYg8ffoo8nxSUkv+MqpXZF+2RAMv
         9i5TrV1/JmY1POQSSL4BNVjK6OhCldGidwE8ozsiLZ/wZjnk2ftNXy0Uqgbyq++DLvZN
         QMbdZrOae4r7bS1jEYsZu+N30aX6fPlhkh9o6In9NAXfP8Qe7Tc10W4QfjLiT0Ii72Gs
         tHNsY2SmKk/CtleAYjaH//E1qZsjbmzwvpxQfAxGHhuedEWaHkF2MNnPJkFOEBWxlYUz
         D0nw==
X-Gm-Message-State: AJIora/pXm+uFgfvv/GvzkcNAYbqpiZADuGFsamuQ+9Avq2lkNrwzKRS
        6//ksl65HM6E30VxEdk0BwXHtUkyqb3+Rg==
X-Google-Smtp-Source: AGRyM1uT09qTDSV0u3fir2sFYjX5xcU6HWGFLwO4j1I0IojDLJl9/4U54xIYmHCJCqaxnuz8Oy29Gw==
X-Received: by 2002:a92:9412:0:b0:2da:7fb4:435d with SMTP id c18-20020a929412000000b002da7fb4435dmr2791943ili.33.1657300474283;
        Fri, 08 Jul 2022 10:14:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u194-20020a0223cb000000b0033197f42be0sm18491290jau.157.2022.07.08.10.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 10:14:33 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix kselftest build with sub-directory
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b39b9e0b-45f3-1818-39fe-58921182d957@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 11:14:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1657296695.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/8/22 10:23 AM, Guillaume Tucker wrote:
> Earlier attempts to get "make O=build kselftest-all" to work were
> not successful as they made undesirable changes to some functions
> in the top-level Makefile.  This series takes a different
> approach by removing the root cause of the problem within
> kselftest, which is when the sub-Makefile tries to install kernel
> headers "backwards" by calling make with the top-level Makefile.
> The actual issue comes from the fact that $(srctree) is ".." when
> building in a sub-directory with "O=build" which then obviously
> makes "-C $(top_srcdir)" point outside of the real source tree.
> 
> With this series, the generic kselftest targets work as expected
> from the top level with or without a build directory e.g.:
> 
>    $ make kselftest-all
> 
>    $ make O=build kselftest-all
> 
> Then in order to build using the sub-Makefile explicitly, the
> headers have to be installed first.  This is arguably a valid
> requirement to have when building a tool from a sub-Makefile.
> For example, "make -C tools/testing/nvdimm/" fails in a similar
> way until <asm/rwonce.h> has been generated by a kernel build.
> 
> Guillaume Tucker (4):
>    selftests: drop khdr make target
>    selftests: stop using KSFT_KHDR_INSTALL
>    selftests: drop KSFT_KHDR_INSTALL make target
>    Makefile: add headers_install to kselftest targets
> 

This takes us to back to the state before b2d35fa5fc80 added
khdr support. I reluctantly agreed to the change and it has
proven to be a problematic change. I would rather have had the
dependency stated that headers should be installed prior to
building tests - test build depends on kernel build anyway and
having dependency on headers having build isn't a huge deal.

So I am in favor of getting rid of khdr support. However, this
khdr support was a change originated from Linaro test ring. Undoing
this might have implication on their workflow.

I will pull them into the discussion so they are aware of it and
be prepared for this change.

thanks,
-- Shuah


