Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE805F59DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJES2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJES2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 14:28:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DB7F26B
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 11:28:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y100so23652691ede.6
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FBEfO1rQUq7kj71Ct0f//FmMkbcVfUhb6nYeOsxTaRw=;
        b=O99hsOVXQr2ervEPtCirAL8UoEUshuvpPpQcBU32Kb0SU4lrUDoWMEMvlAGYISluhA
         uSOnOS6bha1OdgG0iu8G6IoLCb5OpNTn07J7x1Hj/9BhFwbl6ujEQt0cEzRae5sn900F
         SJ/WUzgYocwDLteWgSuBEsO2OdPwDekm4YOlBfTrJ/bKNG11IE/D0sptwIwiPvsGkz18
         fS61tvdU3o87+IuwXhM7srDCu0Z4tEpJgbSAeRqgWlDLjM1KuC2jBtuYTFnbGbAwGpJH
         jrGrtWgTUS9PaHPHYFYaWSijACplWf8VveHi0eKfTyLX5wlpKgNBo3Y5HCpMOMa5yjeu
         2wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FBEfO1rQUq7kj71Ct0f//FmMkbcVfUhb6nYeOsxTaRw=;
        b=S3P9iBK62YWSAluSsjHfRHCl+vp4w6nlHkSVM5XdsLxxWoAvHbJXysacl3hYfV0wXn
         9cR2oaujZub4S/ngayPu21vHJNOOcNejw6+bd823PWtDJCfVsBSsryWmrQyvFaaHPgsr
         64ySkwZQSe+0SPteN1Cp/TRJ0U3I50l9GXn1DVAroTsZrE3BNZWqDIywR7PTIZcysPVf
         yk10r03wDMhMyONNKPxm0bzi0uF/qjZW2D9HkRKPBpvTJMKip+OxVyOWDcFuM0nr8yp7
         kOgubBiG+2oLu8yhzKLILDwKSfw/rGmL+bVg9oufIO0C/PNVvPN3y6XwUWD3HQtPZqZ4
         oxTg==
X-Gm-Message-State: ACrzQf3PL8iYmY3yuSInKdzM0r/cJX1BTNTOns2/U4o4O813bOAwk+gd
        sC7FlK3I85mZITTUE8MxquXaC2mHPdgvcRsRZiEnNA==
X-Google-Smtp-Source: AMsMyM7LeAex/s852ufNxcEBQjp+6mvRJR3gI6My56jq3iz4cu9l3F6UcZ29fYLW7iVRAZuhjzy8IPA5BEQopgbiFD4=
X-Received: by 2002:a05:6402:5cb:b0:452:e416:2bc4 with SMTP id
 n11-20020a05640205cb00b00452e4162bc4mr994771edx.114.1664994518712; Wed, 05
 Oct 2022 11:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221005175149.611068-1-mark.rutland@arm.com>
In-Reply-To: <20221005175149.611068-1-mark.rutland@arm.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 5 Oct 2022 11:28:27 -0700
Message-ID: <CAGS_qxok+UigJqoROJO2ryUXAWet5V8FL62cn0mr1iuporLu6g@mail.gmail.com>
Subject: Re: [PATCH] kunit: log numbers in decimal and hex
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, brendan.higgins@linux.dev,
        davidgow@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 5, 2022 at 10:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> When KUNIT_EXPECT_EQ() or KUNIT_ASSERT_EQ() log a failure, they log the
> two values being compared, with numerical values logged in decimal.
>
> In some cases, decimal output is painful to consume, and hexadecimal
> output would be more helpful. For example, this is the case for tests
> I'm currently developing for the arm64 insn encoding/decoding code,
> where comparing two 32-bit instruction opcodes results in output such
> as:
>
> |  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
> |  Expected obj_insn == gen_insn, but
> |      obj_insn == 2332164128
> |      gen_insn == 1258422304
>
> To make this easier to consume, this patch logs the values in both
> decimal and hexadecimal:
>
> |  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
> |  Expected obj_insn == gen_insn, but
> |      obj_insn == 2332164128 (0x8b020020)
> |      gen_insn == 1258422304 (0x4b020020)
>
> As can be seen from the example, having hexadecimal makes it
> significantly easier for a human to spot which specific bits are
> incorrect.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com

Acked-by: Daniel Latypov <dlatypov@google.com>

This is definitely something that has irked me as well.

I vaguely feel like this can clutter up the output for things that are
just ints, e.g.
    Expected len == 0, but
        len == 2 (0x2)

But I can't think of any suggestions that are actually worth doing [1].
And since this feels like a common enough case, I don't think the
existing workarounds [2] are sufficiently ergonomic.

So I think always showing the hex makes sense.

[1]
E.g. only emitting hex when the number in question is >16, but that
feels too magic (also needs more if's).
E.g. adding in a macro argument/separate set of macros that always format in hex

[2] can use these to coerce hex output
         KUNIT_EXPECT_EQ_MSG(test, obj_insn, gen_insn, "obj=0x%llx, gen=0x%llx",
                             obj_insn, gen_insn);
         KUNIT_EXPECT_PTR_EQ(test, obj_insn, gen_insn);
