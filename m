Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4B4DBAB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 23:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiCPWku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCPWkt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 18:40:49 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC589AE48
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 15:39:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id w20-20020a4ae9f4000000b003243aa2c71aso4530671ooc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=1+QbwgDl1LJslolUIJ7aexnhE/1LwjAWswIgk1iXd24=;
        b=xzzNr7XnXnHN9KieNsWW12uHCOnL1fvC5NJz2h9xZHzRho5cO/9nl2sPy+zpi89PBw
         t90jzK1RBl4EyUSMsVIuuw+T2Nw1vvRfuwtMNgivb6kL9jlZTKmHbeJK0MuJX6P+sQOm
         p9AVmuXrFwKy3HW/IwJkQRC8uSeBuS9JpgzPvcswFNxTZYoj+XYlT/vRBMS9rxbKSzi6
         fOnJyNYN0yTqvLdAD5OCLWSpyAdYtt3HvAZvoasf8hWMND+Qy+jeJ6NllsSE8mP8iXUL
         X6rudyfiV07RrbdjldFxbQi8+RJuE2aavPChDRaUKQwLFP/OfsoW/UUiRBLMRfjRDVhQ
         luRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=1+QbwgDl1LJslolUIJ7aexnhE/1LwjAWswIgk1iXd24=;
        b=P9zHs8feAca0iwwHaSl+ynTGb+ufCbFKLnv4sWNrTjXAcLsFtYpa4YA5tCeoZhaqLT
         6TqQY04c1izr+zbimUKTXzxbDz4C1oLYxcEicZdxEbg/rjnpeWQhGimtief1JGNHmVMC
         fn1QHQdsXV292x+Keq9fdLrqEsr4XE7yAz86ENVw9H3MLgOcZQjmvaUu5kjjPrhG9c2L
         CPJCzoeIiUhYk6KZ6uqZv3BvAck97OLy2FDHG86Y6KADXmg8FJ7tZK7vs9ZP+/uVTfpD
         fXtjKr5Cdx3cN6AtXkMjDEpB0uoSMwbEmyhfgWW3drq6jMtE0L9qgFkhn3l5nO/THSad
         l6iA==
X-Gm-Message-State: AOAM531oMvJr+QhNOprNB3M3nycWWsk8EOsDUqhgGyKoPg/q+Y/Yb06q
        DLoZpHMJLiWanhQUN9AoqYOuxA==
X-Google-Smtp-Source: ABdhPJxCOYtAyq6RuYOy4M7ev+ABARQur36mgrpikApcM4DwinFa1ybZoRDFPU3zAD2BCczsS2YIug==
X-Received: by 2002:a05:6870:d10e:b0:dd:a653:a25 with SMTP id e14-20020a056870d10e00b000dda6530a25mr1837976oac.299.1647470372180;
        Wed, 16 Mar 2022 15:39:32 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:b171:978c:2a42:8690])
        by smtp.gmail.com with ESMTPSA id p8-20020a0568301cc800b005b2259500e2sm1550391otg.25.2022.03.16.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:39:31 -0700 (PDT)
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-21-broonie@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v12 20/40] arm64/sme: Implement streaming SVE signal
 handling
Date:   Wed, 16 Mar 2022 19:38:30 -0300
In-reply-to: <20220225165923.1474372-21-broonie@kernel.org>
Message-ID: <84v8wdbjz4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hello,

Mark Brown <broonie@kernel.org> writes:

> @@ -186,9 +189,16 @@ struct sve_context {
>   * sve_context.vl must equal the thread's current vector length when
>   * doing a sigreturn.
>   *
> + * On systems with support for SME the SVE register state may reflect either
> + * streaming or non-streaming mode.  In streaming mode the streaming mode
> + * vector length will be used and the flag SVE_SIG_FLAG_SM will be set in
> + * the flags field. It is permitted to enter or leave streaming mode in
> + * a signal return, applications should take care to ensure that any difference
> + * in vector length between the two modes is handled, including any resixing
> + * and movement of context blocks.

s/resixing/resizing/

-- 
Thiago
