Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB55198A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbiEDHxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiEDHxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 03:53:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9013E89
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 00:49:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r11so1044207ybg.6
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBQmirpc3Jzz2WCciK0xB/dSEqZbT1cDbk6dglZ1uBg=;
        b=UWuFLon1MvAHgjqPhEcsa2mVgIRhCdr07mEbCxel2hphWlSVQEC4vO/TE58K6YyZLv
         KdAt54vTokh9rWbOgXiqqIdgwmze4KE0kfH5RlEB9gP2IihVKQ4HB8zODadKn0SFW26k
         de6LUjlASatkBMKZ8rLkDafvM05dV7myRgJqYbH20gjCTAsEaA/V8ylwnVx0USGyar/0
         PxhPc8MFAi3qcTEqrfb7IOHCNpRM95mGhf2hl7dCGiAJt8XsSWKLGUUXIEZXTdL3MN9q
         +xvgTb4qfIC8nJvdcouu4KSlN9DDpFJQAgNdjoObloqDkKcAqkppEi6ypjnHRzlqDC5d
         Da/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBQmirpc3Jzz2WCciK0xB/dSEqZbT1cDbk6dglZ1uBg=;
        b=0FAOJchAa0sOUCNibLvqQk7jVNDZ020uGpHKhm3k5I44YtzBTZvCzZad/Sks5fUfcu
         7U709sE+7McIjKwPslbsdeefLXLzIty07jdI07DCk+dNtqYQMti/ww9Z6wngi0522yEF
         7bAMuF+RQRYxPdrXLHssi394Jo8zPMt8tsAFuUe00IcyBcDqoICCcW0m69kuKYdE4I5n
         JZ5X3DZ6Cw6FuVM9g9zyeG6vpCAEgVz9+pKmaFKMgrG0cv2oXingU5FRlNN+db87XVHN
         HpELpJRvww8M9Lr5dp5OjKOMUNKfIY5eD5WKcd7q6XDnj/vtBIEJJeUav/7XuG7+DmVx
         EhCQ==
X-Gm-Message-State: AOAM531Zp1ZgOFdGxnHvorrslNrcCWsx+ekSPRfpBQNQEnazk6tCGzLg
        rtusW9+FAuk5JPLscUC0pwvxMpvEduxNc63QEkdiyA==
X-Google-Smtp-Source: ABdhPJyNB77zleiVNEcTCAgG3AS4key9sktPB70PVylNOO/cLnHmygWDMqHxwR+ZMCeE8XUmznCFoc3Cpri8uFEqgHI=
X-Received: by 2002:a25:8045:0:b0:648:a9b3:96d0 with SMTP id
 a5-20020a258045000000b00648a9b396d0mr15786060ybn.88.1651650573002; Wed, 04
 May 2022 00:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220419112247.711548-1-broonie@kernel.org> <YnGrbEt3oBBTly7u@qian>
 <YnHANG5cM0CS9ffm@sirena.org.uk>
In-Reply-To: <YnHANG5cM0CS9ffm@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 May 2022 13:19:21 +0530
Message-ID: <CA+G9fYuqVq1G+zTamEqJDyaYqBSBQGkj5Qc6ZCZgBUj9qSP_Fg@mail.gmail.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
To:     Mark Brown <broonie@kernel.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Marc Zyngier <maz@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Will Deacon <will@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Luca Salabrino <luca.scalabrino@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 4 May 2022 at 05:22, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 03, 2022 at 06:23:40PM -0400, Qian Cai wrote:
> > On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> > > This series provides initial support for the ARMv9 Scalable Matrix
> > > Extension (SME).  SME takes the approach used for vectors in SVE and
> > > extends this to provide architectural support for matrix operations.  A
> > > more detailed overview can be found in [1].
> >
> > Set CONFIG_ARM64_SME=n fixed a warning while running libhugetlbfs tests.

I agree with this.
The reported kernel warning gone with
 CONFIG_ARM64_SME=n

- Naresh
