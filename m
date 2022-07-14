Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAC57564A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbiGNUXH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiGNUXD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 16:23:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2865D67
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:23:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf4so5442288ejc.3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJyqb0gXwX9toDZcdJ0Ejs1ECxk9NdxpXaz6/AftgKg=;
        b=M14PGsSK222yjgy/D0paYcb0voen5eGphbEgK3uQZxoMuQFsHYI3PwMr7L7ibygvPr
         GLLhi8rz5UwixkPGAvjMQgDLFKeWONaCdLLlIBqCgo8gWYyXJMZBPJkTduQa8nt6tJYY
         B+fj7GPe1jgzKVT3IbSvtMjxHdUj/TN3flOxxrhwYXEoMV/Q51tJfaK9P3za3sXdcT6q
         YhHvIWvJknzfJUqZKa5dMOVDKLVbhqAMRFnxru8QbLpGZh2T84yyxwbsARJFsQdZ3RT+
         rvQAAhdepnqQ5cvErqrtSoRlecg2ltgzxbYu/sOGZGi0G2BYsp8MV2q7CG1eskRXS7Cr
         nkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJyqb0gXwX9toDZcdJ0Ejs1ECxk9NdxpXaz6/AftgKg=;
        b=xOunaMJi8ym3wREgQeV5zv2+qnk0Wx7LQWyTv5Kv9QQJRO18dHBayCoVPFLzYhjSDx
         aJSJ/AbpfSm1trJgu0RuzOh+2XUDdMI3LmPNJjCEsLf/a22XdbDvHH8ogrsLgbn01J9U
         pzrNknDvv5HoRV4Hb4vLyp4U4DNWWnP7AcBiscdMw9G/aXSp/ntvdXVrKVUHhLKdNIad
         8md1Q6XnMNgH8j/b3lp0eyCnGmorRJJymvyhv0jW/7uqx/oDhRM2YaCLta608WzQVE7e
         h0WN5tarPK9UOEUZa3Gvv9AlFUSZIsEwUTsCvN/BGOM0reDjVONQS27myBv7bIWdw0NV
         t86w==
X-Gm-Message-State: AJIora8uywq2f3+cUqhB4gCNaviVxHQkvieFAQTNuFLBX5dEekswu0RR
        eWuWB6mJv82ntaVeMMg3k+zkAlr7N1EneBJFvVPqjQ==
X-Google-Smtp-Source: AGRyM1urEg/+DXbwKT4pbV7A84j1nZyYkeQHhMSsXo05Z1UxOCW6E7p3rkEfaP8QP5me41BU6K9CvpT8nEXtJ5wi2Qo=
X-Received: by 2002:a17:907:a06e:b0:72b:2cba:da35 with SMTP id
 ia14-20020a170907a06e00b0072b2cbada35mr10407054ejc.358.1657830181392; Thu, 14
 Jul 2022 13:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
In-Reply-To: <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 14 Jul 2022 13:22:50 -0700
Message-ID: <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     Marco Elver <elver@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 19, 2022 at 6:24 AM Marco Elver <elver@google.com> wrote:
> I'd keep it simple for now, and remove both lines i.e. make non-strict
> the default. It's easy to just run with --kconfig_add
> CONFIG_KCSAN_STRICT=y, along with other variations. I know that
> rcutoruture uses KCSAN_STRICT=y by default, so it's already getting
> coverage there. ;-)

David decided to drop the parent patch (the new QEMU config) now
--qemu_args was merged into the kunit tree.
Did we want a standalone v2 of this patch?

Based on Marco's comments, we'd change:
* drop CONFIG_KCSAN_STRICT=y per this comment [1]
* drop CONFIG_KCSAN_WEAK_MEMORY per previous comments
Then for --qemu_args changes:
* add CONFIG_SMP=y explicitly to this file
* update the comment to show to include --qemu_args="-smp 8"

Does this sound right?

[1] Note: there's also patches in kunit now so you could do
--kconfig_add=CONFIG_KCSAN_STRICT=n to explicitly disable it. This
wasn't possible before. Does that change what we want for the default?

Daniel
