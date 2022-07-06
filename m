Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67DA56931B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 22:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiGFUMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiGFUMF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 16:12:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4019023
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 13:12:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v12so8015159edc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVOyRJFl3auzy5uUE3eiIM7wPcPXSqEg2Dt9oNXrcRA=;
        b=F9A/ikOaqolthCndIJZefO+fHoLKvvK44RvSom0Jn2f1fnbLY01z98yfO6SAglmu6g
         ebvJCNo3VAMNdLgmCjQpAWUNiwcJ6iIjPkX2VHxTHLF7hgGzIx0Eb+RyZcaaYQaz19wQ
         B3teprZ/TfuB0OscMddQLkM7WyIEGKRPBJ8zopVGnwsWzCbjM+DTxiO8h9l5uhnE3ZhV
         hmSjqfK/VHae/9A16ZfAV9ft43alOi9r/4rS0uaiWY2/1MmnXCxzHlReQyt3Xwu1B1hz
         MJmQRF4RZwH7+514+XY2tdV5vJVu/8CPZJtWWQvm6NUVciFTGGk336na0q6FuPanRxrR
         PVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVOyRJFl3auzy5uUE3eiIM7wPcPXSqEg2Dt9oNXrcRA=;
        b=mvM6K5jyDbk7gcLHn+vCCajnKS14/uyFMwean4HHTx0btbQ0xSEbLqTvGNW+MPgZ7U
         Oek55lgsKbssaKsV25rP53QWQ1rcCNwMl/eCBdGaky48BRPgh0lExQjzDDQGww6JTRCc
         c/oXg0/dFfkVU3njk+at8dDmZKhw9nQmdEeu33EVJ4xWNohtbUtxivuxFF7qS2IF56Yg
         WgAB2y4QBASUAK4s3TgCfM23B5z3Ut36x2cU2vYq70HwqigvaLfW28Cw+nbVgsN0mdg3
         FEA0F9C9Oibb/DnaOBp1F2myZbAjW+w9GkwQ02gPVKXQTRkMbuxsIR0QrlffVb1KwaLW
         QrhA==
X-Gm-Message-State: AJIora+mkQEqlNVcTQfzBeLPcz54EZZdy96uTmVgfj/TcvF5nDKK2/4z
        3Sxy4tlGt+Qr4FTuHjHkZnpdomEek9rahuaqpSQexQ==
X-Google-Smtp-Source: AGRyM1upvjBlwtiujlobvzhUsrrWYckKitJAPdADnaI3IcTWbKbOiUCVF31DPq4GG6oCK8d+coL85qPBSdx7XLBmVRA=
X-Received: by 2002:a05:6402:4488:b0:43a:7b6e:4b04 with SMTP id
 er8-20020a056402448800b0043a7b6e4b04mr13073971edb.202.1657138322816; Wed, 06
 Jul 2022 13:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-4-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:11:51 -0400
Message-ID: <CAFd5g47LpZDVe7L1-B3Pz-pDmPkyojNFiugHEEAzWD_W5eOrHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: introduce --qemu_args
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
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

On Wed, May 18, 2022 at 1:01 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Example usage:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>   --kconfig_add=CONFIG_SMP=y --qemu_args='-smp 8'
>
> Looking in the test.log, one can see
> > smp: Bringing up secondary CPUs ...
> > .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
> > smp: Brought up 1 node, 8 CPUs
>
> This flag would allow people to make tweaks like this without having to
> create custom qemu_config files.
>
> For consistency with --kernel_args, we allow users to repeat this
> argument, e.g. you can tack on a --qemu_args='-m 2048', or you could
> just append it to the first string ('-smp 8 -m 2048').
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
