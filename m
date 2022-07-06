Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6395692EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiGFT67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiGFT67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:58:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CD1659A
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:58:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dn9so23611252ejc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTNGgjqkz2i9jOPOcItVEbeQ0jxQ0QpDjfjTJFVrwkU=;
        b=M2WUc3yqCrQNl6IC5KPsFmi9IMNMddHBmWopzsOro7NzVcBYgK9Znk35UelqCq7o+5
         GF0I5TsuOGb/zpp81C5iDvkXEmiy9wO6kKmNUUa7wK2gH44wewzM/7vLadCmCEftVSne
         aSoFHeY19PpvlSXBCDrEpPr65YD6HLHsBK+m3X5sLARERrp7fR5J6NMSoAg1TGYsjiLD
         Q9kuge5amCUR6csjXshl7HJbWFLzpCxwpq16nWtz8y0hyYZcNmIeZ6jjJd3Jub1yd6fm
         Nf8IY4oBRRQ7S2ew3rvwNqT+FaeKErGm7ZZTwfNF8iyrb641lTzD7SCcp9IjqdkmiLiU
         oTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTNGgjqkz2i9jOPOcItVEbeQ0jxQ0QpDjfjTJFVrwkU=;
        b=ZBott6Ozepu6TBMWOBnsv2AMTJBNgJW+0GTRbIjLSyCd2osFGRNSKCL4tDeWY6pHPr
         a/qdDkIfwU452UBpapruHQznHATrmFbOT31egZFlPgZQEou1GUf8Fo3v17yAUK6eIYJD
         oBJatCiG+kHrWELr9+p95gF8ijNCmMQxAYsp1H9QTABSr3WqSEsAOEEWGurmJLDL8E8A
         Mo72yrbP4fMxRrl5ttTKw1ghPQaTEUn10VyvchEcYjHwmBUC9zqUsLyeA+/mOaStducm
         rk3kxC7/e204vREmeplvnFtm1aE4ZkflHcgTrqYO1O3z1gBtD6Kyzq0XDB9T3MLLVb95
         +xXA==
X-Gm-Message-State: AJIora8LxDZluEVD2kUlSvw8k1Ef1PAbOwNAufhM3uOJPEEutzfgADhJ
        gYjBN0jk7EvhZDVw9UwMELU21PwUfPtaftU+N3/Crg==
X-Google-Smtp-Source: AGRyM1v7A/MquaHP5PJo1EWlwJrbCKNfY4bpW1A9o0wbsht2xfrGiZcfDPvidtmZAMizypVoC5VQo2xPBqsuSAufP18=
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id
 g4-20020a1709065d0400b00722f46cb891mr42052343ejt.4.1657137536835; Wed, 06 Jul
 2022 12:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220513181032.24484-1-dlatypov@google.com>
In-Reply-To: <20220513181032.24484-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:58:45 -0400
Message-ID: <CAFd5g47g6Tb4nMB-NQQAF3vXZ9FZj9YwcdP=E_-=5A6fBTbfNw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: cosmetic: don't specify duplicate kernel
 cmdline options
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, May 13, 2022 at 2:10 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> When using a non-UML arch, kunit.py will boot the test kernel with
> options like these by default (this is x86_64):
> > mem=1G console=tty kunit_shutdown=halt console=ttyS0 kunit_shutdown=reboot
>
> The first three options are added unconditionally but are only intended
> for UML.
>
> 1. 'mem=1G' is redundant with the '-m 1024' that we hard-code into the
>    qemu commandline.
>
> 2. We specify a 'console' for all tools/testing/kunit/qemu_configs/*.py
>    already, so 'console=tty' gets overwritten.
>
> 3. For QEMU, we need to use 'reboot', and for UML we need to use 'halt'.
>    If you switch them, kunit.py will hang until the --timeout expires.
>
> This patch:
> Having these duplicate options is a bit noisy.
> Switch so we only add UML-specific options for UML.
>
> I.e. we now get
> UML: 'mem=1G console=tty kunit_shutdown=halt' (unchanged)
> x86_64: 'console=ttyS0 kunit_shutdown=reboot'
>
> Side effect: you can't overwrite these options on UML w/ --kernel_arg.
> But you already couldn't for QEMU (console, kunit_shutdown), and why
> would you want to?
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
