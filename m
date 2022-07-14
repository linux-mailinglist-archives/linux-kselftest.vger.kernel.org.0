Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D675575827
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbiGNXsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbiGNXsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 19:48:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913986D9DC
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 16:48:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so6156709ejc.9
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 16:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtB7Ozk+Cxa7ka7EGUvIpISJLyIGflqVSLPjqA/TC+E=;
        b=bFleYVBqGeZKBfSfgno7pfLfs+mqMudf/doLnSi5uuw6FkgmL9axt/8kDlFHhh/krX
         oxPSmnK+wSQSYc0LQb4MIgL3wsfFLXATvM5HV0m0Y1+ROymhv0S6WmVq/Z5ni7Svk7Ad
         nE7cAe7E5SiqRHXDNNfJkMc+9GwuJuPGCcfcNkSw+7nbX962MP5FgnN/iqxMlxf+eh6P
         2GA3DSJ+PToE/NUzympAmLWhylB2owsEXy6KpR3U/lip5pHtDBZDWOXxvXUoFTL/UuGl
         jQvd8sx7aqy9DxJMGChIQ4a+RFFy2CqopFAb2bM/b+5yXXLusaXq81wCqlVqcL6Wt1qx
         XoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtB7Ozk+Cxa7ka7EGUvIpISJLyIGflqVSLPjqA/TC+E=;
        b=Jek6qgJ4+3tHc+/ZNqvQzz9iLs6WP+kNNwFyj4K7iKCLNjTbePKojTBdWatU7Y7Rb6
         RZKDNIVed2ocKU4ybQJcYUHQ3DJXkPo0VKnvnwAkrcKVpvm7K2ZKMfn9H4lUe/sfU7C1
         sYrI/sFs3wigehKFKYFHOiXxayZ+qTiXY3K4KghJwrdNjL9OzRumCRr3+0d3BxY4kFW+
         Gxysr474SoqqQS4YFWuf+v3CGwbVRRmqBECMFA6uBWOVQtX57S9RWBQEBBdpNGKc/tVu
         8qxe39cAD4pLO9qxeFGu5ZIE0efY+XN4OYofx/8ma9RA+zf4DNQSV6fpWNmCwYectUMa
         CGNA==
X-Gm-Message-State: AJIora9kz4iMh++J+PML7rUCuelk3vfEtZDV21Z3D/1PmIfWbj22X2bF
        iQ0rcQPfA5+ZV7rp7oPxYXnhAn/6VtAE/UkFv9+dYA==
X-Google-Smtp-Source: AGRyM1vaTiICwkcHlN20EEVbkmpYuLihgqvtTFHttjuhk+0JrDjbSPErwCqUfHFynWuVlGKRia0SOMRPVEUf4QEpMDs=
X-Received: by 2002:a17:906:98c7:b0:72b:20fe:807d with SMTP id
 zd7-20020a17090698c700b0072b20fe807dmr11332291ejb.75.1657842486964; Thu, 14
 Jul 2022 16:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
 <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
 <CAGS_qxr_+KgqXRG-f9XMWsZ+ASOxSHFy9_4OZKnvS5eZAaAT7g@mail.gmail.com>
 <CANpmjNP-YYB05skVuJkk9CRB=KVvS+5Yd+yTAzXC7MAkKAe4jw@mail.gmail.com> <CAGS_qxq5AAe0vB8N5Eq+WKKNBchEW++Cap2UDo=2hqGzjAekCg@mail.gmail.com>
In-Reply-To: <CAGS_qxq5AAe0vB8N5Eq+WKKNBchEW++Cap2UDo=2hqGzjAekCg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 14 Jul 2022 16:47:55 -0700
Message-ID: <CAGS_qxpNHrWxGBV6jcee7wPzkWTb1Mh0fpE7j4_0LrgeLv+4Ow@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 14, 2022 at 4:45 PM Daniel Latypov <dlatypov@google.com> wrote:
> Ack.
> So concretely, so then a final result like this?
>
> $ cat kernel/kcsan/.kunitconfig
> # Note that the KCSAN tests need to run on an SMP setup.
> # Under kunit_tool, this can be done by using the x86_64-smp
> # qemu-based architecture:

Oops, this bit would need to be updated to something like:

# Under kunit_tool, this can be done by using --qemu_args:

> # ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> --arch=x86_64 --qemu_args='-smp 8'
>
> CONFIG_KUNIT=y
>
> CONFIG_DEBUG_KERNEL=y
>
> CONFIG_KCSAN=y
> CONFIG_KCSAN_KUNIT_TEST=y
>
> # Need some level of concurrency to test a concurrency sanitizer.
> CONFIG_SMP=y
>
> # This prevents the test from timing out on many setups. Feel free to remove
> # (or alter) this, in conjunction with setting a different test timeout with,
> # for example, the --timeout kunit_tool option.
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=100
