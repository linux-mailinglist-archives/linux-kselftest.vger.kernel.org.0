Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF84D4233
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 09:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiCJIJD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 03:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiCJIJC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 03:09:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D90713395D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:08:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bg10so10320563ejb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgU1YiosBtNsX8vphzejZ6JG2mH1MwmM6we31LMy0vU=;
        b=XLRUu4GLZhPreZ806DmRXf99JDmVKiWPeD1LAmNi7iFs6z59L9i4F/jRJrJzqAuARi
         YAmhAmHeyyGhZBCOKFVLcVeIEULX25XpOtWyaOv66sQiLWnG03dQqvp6x10xSzfMN31O
         +/KwWBXJfLYujoJ8RwtBipptXGR7a+5ojbcQ2nXwtJA0WLUC9YEVbJ/tyizIz3MPYhRL
         /FMfBvFlNFGA8ztjCHVRzSwYlGlWTQatA7xT0yVR8mVHOnHBKTJ7GqntDNZXtfxfmT99
         VRwDwzUKVLKrTIHdhlsq0P/caDi8xYsldEGJKFEwrYgVGk82TH18IxXM9pMzHhbS8zXW
         U7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgU1YiosBtNsX8vphzejZ6JG2mH1MwmM6we31LMy0vU=;
        b=xwa3hzoP5BTZYHjxpseBYVk8P30/XH/5h2wu13v4k4vN1VMYIqVK5fwMjpSmlI90TP
         +2IYyr7ghLHfMQ57zAByCXZ0MRiRmXAkDxbr+u4JgB/Z0tXC+P5P9ESOUC739Wpxp4Oo
         e3PQf5zDEbD5mFLNjHt3STR1NFJpkjLfywyhEyPJomc8XGm6gNNinkfAKKNArY3tRswf
         SLj4isPS9M3hpP9SkiQOQwAHWov/WdipNVZHJ2gg0UCvw3t1LTV4fvdzKHbsJ4qUqcfo
         SaHD2BWdPMHFxd95C2dP6fhfIVVmsbDGdGDvW8fox1XFKieTfTu/6Ky8U5IM6EyDGCIA
         KmZg==
X-Gm-Message-State: AOAM531qqp2fglm/VfZA7MaqWpWPKw0dh30RaB+DCfP4qD2P8xkjhNqS
        49EslIq47TYJ50REHZYtfTzHyITLFPp0EeNppOqlPw==
X-Google-Smtp-Source: ABdhPJyk8Rd7RVAixssO/1MkmMF/h7pn5Vdo7uxGHhPCpqNsEQqkq7TGhVTpdF1GQhCClhgrzKqe7Q7gtj9jsduNMHU=
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id
 o25-20020a170906289900b006d6e4791fe2mr3149308ejd.394.1646899680427; Thu, 10
 Mar 2022 00:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-1-liupeng256@huawei.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 03:07:48 -0500
Message-ID: <CAFd5g457_aWs2mbiD0Eq6Tz=8dpjJD9nHa+iK-RTe8H6kXwT=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kunit: fix a UAF bug and do some optimization
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 9, 2022 at 3:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> This series is to fix UAF when running kfence test case test_gfpzero,
> which is time costly. This UAF bug can be easily triggered by setting
> CONFIG_KFENCE_NUM_OBJECTS = 65535. Furthermore, some optimization for
> kunit tests has been done.

I was able to reproduce the error you described and can confirm that I
didn't see the UAF after applying your patches.

Tested-by: Brendan Higgins <brendanhiggins@google.com>
