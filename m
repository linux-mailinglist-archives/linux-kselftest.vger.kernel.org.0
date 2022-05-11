Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00D523F50
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbiEKVPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbiEKVPT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 17:15:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188921F35F0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:15:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dk23so6474632ejb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mP/86oh5D3d7YPJx0+zhN/dtgBHPyShEV7A2+2ykn3Y=;
        b=LQHpzRt60RV1fucmT70DWSrOSPuZzASiWAbm8oOfHI4KsEbfBuz2Ox2D7eQlee2ViN
         w+eyxRny5jRgpeNImOZtDMVmqua/OnVr5Mu/veRfxmHMlHP/x34qY28r2zrTbEfhM8mE
         iwi9+NJrboMpwrNABMky8Nri4WCxu4/eUytH13qsYib8cMxRw0/NL3fCohsaeqBi+KpM
         E48nKIY6B/1zCZjJ9tzleQprrXwzhKgiwewCS4yUZ25dpm/3Rhiiu/vGh2tg7wpSNAh4
         ZJhUfmY0GFeq5NMKJ1cV/MV8uRlzgNYZIxzv8Ps9GOWnOOKFitvKpFQzCOJISSsylKf2
         +L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mP/86oh5D3d7YPJx0+zhN/dtgBHPyShEV7A2+2ykn3Y=;
        b=kRw73/RRYHd49mmanC7nbrqw5aAsJQidQkJfMXfJ9Stw5carDwX6/8gV6VIkXmh2oI
         qTlpo1aWz2d/Gm0iPUVFitQxRD1yvRTnUjSbOGWqP8eHFGkeDbIcE4jEZuOFchF+WQw5
         Fd4no2EMHAPMM6E+nErJg51JMErADOi4OU7mJAdbik/wpaEWJxUzH2qWTP5uMQKqHk5W
         3/ts6FP8RjXZOjwfaFLxLCBhRpqo+4UGrBO2Eoup+D8TXcyjUVQgIE/BhRMDsXaZqYfO
         OZNf+nNMp8CrQu6WDyxR5c0cDonCLQuEV3/gd/YKEj2HtMUziQE5JjH9cJmcvm+ZsmU/
         B9OQ==
X-Gm-Message-State: AOAM531LMsyrhWzWQasqSCzdNgjCbjVeazeeWhnmVAE7cELrzTxz2G4f
        onp6ASCDubJm19wesqgEdGtOhqk7JAkEcRt0wmyVRg==
X-Google-Smtp-Source: ABdhPJyTDAzw61+HnTysjMMyR2wNj1ex3YWIWHpzm0mTrqKUznEA+lzeIt74m421YDanL7xilWhmQPAQI2uRiRR6Yz4=
X-Received: by 2002:a17:907:a40e:b0:6fd:c29b:e0b3 with SMTP id
 sg14-20020a170907a40e00b006fdc29be0b3mr7108434ejc.542.1652303716467; Wed, 11
 May 2022 14:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220406232240.1825048-1-dlatypov@google.com>
In-Reply-To: <20220406232240.1825048-1-dlatypov@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 11 May 2022 14:15:05 -0700
Message-ID: <CAGS_qxo6KH8GQe=WN1BjxKV8Aj_Q-czSXckeN7vAPFu4MqFtcg@mail.gmail.com>
Subject: Re: [PATCH] kunit: bail out of test filtering logic quicker if OOM
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Zeal Robot <zealci@zte.com.cn>, Lv Ruyi <lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 6, 2022 at 4:22 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When filtering what tests to run (suites and/or cases) via
> kunit.filter_glob (e.g. kunit.py run <glob>), we allocate copies of
> suites.
>
> These allocations can fail, and we largely don't handle that.
> Note: realistically, this probably doesn't matter much.
> We're not allocating much memory and this happens early in boot, so if
> we can't do that, then there's likely far bigger problems.
>
> This patch makes us immediately bail out from the top-level function
> (kunit_filter_suites) with -ENOMEM if any of the underlying kmalloc()
> calls return NULL.
>
> Implementation note: we used to return NULL pointers from some functions
> to indicate either that all suites/tests were filtered out or there was
> an error allocating the new array.
>
> We'll log a short error in this case and not run any tests or print a
> TAP header. From a kunit.py user's perspective, they'll get a message
> about missing/invalid TAP output and have to dig into the test.log to
> see it. Since hitting this error seems so unlikely, it's probably fine
> to not invent a way to plumb this error message more visibly.
>
> See also: https://lore.kernel.org/linux-kselftest/20220329103919.2376818-1-lv.ruyi@zte.com.cn/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Oh, I just realized the typo here.
This was meant to be a second "Reported-by:"

Let me sound out a v2 to fix that.
