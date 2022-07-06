Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C73B5691F9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiGFSfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiGFSe6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB12612D
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:34:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e40so20358333eda.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG8GWm0pmr1Neu+cMWEfjz23I2y6CFYI8JxXePQozTs=;
        b=K6UVv820cw4CP15PiN8DijrpJiKXTK2nYW2xtVIQZTStYnHOZp1tjf20TsCZCG4HGr
         RZafD5eelpwYaHVcAyMuETGjixhszK4DQ6YKv+Q80G1fKFpt+G0t+ngcqsJyYT7nhalp
         Tt5yhV6pPeJFmbW/z+5gHkZta0h1PghK059lHia6BlfJdTtC1KiwQBLWh5RB4eluxNoP
         q912y26LeH0Graq9HfNSoI2iFrXc2npjKA+rDzeeExj9ItUikpyIwH8W2zqTSxqSlqkR
         uC+MqbwYAJWSLMTs6wWURW91QD/UdbvDNtMO/K16eQfzcaeADys3RXFvbp4d2iZV/J0Q
         Kf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG8GWm0pmr1Neu+cMWEfjz23I2y6CFYI8JxXePQozTs=;
        b=LDv42U07jZkL083e0i12HAfdaSZoGV6eMG2xdW/zy1jdbaruf/zF99OVqp5TmwbuQ3
         1cpJ7TZWx90QETSCwy7yB8ZhhGQswXeTk/YJkIXVKsiqOELFKEve2kfE42FBmNTWZgkM
         Fm6A9BLy4yXfBAXf2hTjgkLG5AGPllt9pzHCiLJoW/UmPqGIXVeNQzrX5CPIZRai1i8C
         xOpMJIAc2x1CIq+usriVXGYgZs6u2TSwwLsQAp9Mdqmry+vZWtW5cJ/V/kSSWYH5huDH
         RSbJmHLjNoG9DrnsSfb7CyHZlARi5J8cYWMt4jYg1Qswj9oiYSGz5nOPC8/3y/kjCuTk
         diow==
X-Gm-Message-State: AJIora9aPld+t7BieE7cIrOfqqy3G4B8MkH8Re3oYZ/VUTDAd8ZgXqWO
        UDmujAInXT9wwjP4zeRw/62Rm/1Vm2bTtkSrX5ld6A==
X-Google-Smtp-Source: AGRyM1sSAqvMx+0ORQYHC+kWiR2XZFBAlJ1EmdoGnAa/0iwRNyIrGUH5koEkoCAc7cvHJBODOLxTNoFKHmP3ILtn6x8=
X-Received: by 2002:a05:6402:201:b0:431:665f:11f1 with SMTP id
 t1-20020a056402020100b00431665f11f1mr56090922edv.378.1657132493907; Wed, 06
 Jul 2022 11:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-2-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:34:42 -0400
Message-ID: <CAFd5g47NFMnOWioSws9k1S7_qhHGnF0rhB4bHy5FaseiMi95fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation: kunit: fix example run_kunit func to
 allow spaces in args
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
> Without the quoting, the example will mess up invocations like
> $ run_kunit "Something with spaces"
>
> Note: this example isn't valid, but if ever a usecase arises where a
> flag argument might have spaces in it, it'll break.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
