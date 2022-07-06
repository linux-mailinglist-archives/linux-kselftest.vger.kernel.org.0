Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA87569203
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiGFSkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiGFSkw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:40:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C120F4A
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:40:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so2325154ejs.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzZxytl6Wz1ULT/c3I88/Se1K67ZgUfdG5WNP/NRkJ8=;
        b=dQwN+tvPKIRMd1vYHaBJh6VuS0FJt91XOeuM/qjAhRLitRoEcZx2s1ezkBqZ/ws0Pg
         3fiFn3BV2KEol8zrCiUrVmhY3GaspEBJYeJJtDFNmL/rqQWZTf8d+hj2qKX+/70qXGfe
         irqBzNKxgl33ozpVHsT36ij1G44wFTxKWPMhBtLHLh8apjOtVYWDtRX8seWCmAySMsr8
         wuwTTOie4Yj7HXN+8JVP9mNeWL3gK2Gp+P304WDehcZqKNquzHDl8Trkvdb3bQn7+CTd
         LQvXjGrNOJXt55jX0zVxcj5ddRCMscsy3SaZNpt+o7opQAZBQ/d9Khe2YTFjaiQTFY1V
         bqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzZxytl6Wz1ULT/c3I88/Se1K67ZgUfdG5WNP/NRkJ8=;
        b=c9PbcukLoRSxvkFnwpOdTQKk4XD8IRQQY0ik6BaD0NxYuLkBON2anOGshLm34FwZdf
         zLKvEpAbxtjkFuUWQ6iqTBzJBGr6Pj2vWWpZrXhyAiTUq/Uw2/YXG2NoPyKVCNSaLZjC
         2j1Lt9ftg22Ma5dedStUim0kRWZuwdpfCHZLdqIzWNVZC1H2QHaKX1JC24AIKiRBsCLF
         i/sYRIrdlSsdnr3WWJ1IF5ZB5Bqe910BQxt+htKNTtgCoc/U5jKozfrB8S6WmJ1jrjUX
         +oxseXBNUcDeRqolmmi+6VKh5xJCmAaEpUmIhJgcmLifgrDlyYGJpJDPcWIqlX9Dyn80
         EXaA==
X-Gm-Message-State: AJIora9Ks0/K4CUUr0zhwhptxNu8urAZ41p5D9bNgJ4dF/HZfEDnwpYd
        budB/uBJrwlo4U39kH9k/a0bv2lS/BZkE/JmYynfCg==
X-Google-Smtp-Source: AGRyM1t/wfpA6fOyKP5JwHbP+bdVJjg4/MG8xC6r/8iY7QXRXmsDubgkBJpnvhrkzd1QnRJThbyM11ZX1GZakD841c8=
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id
 hr1-20020a1709073f8100b006ff1a3d9092mr40708168ejc.319.1657132849397; Wed, 06
 Jul 2022 11:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220626101553.1885428-1-davidgow@google.com> <20220629040605.2395481-1-davidgow@google.com>
In-Reply-To: <20220629040605.2395481-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:40:38 -0400
Message-ID: <CAFd5g4507mJryQy=fYeVSPpk=zf3LAm2wojM05rLkdTdyV-0Cw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Cleanup run_wrapper, fix x-ref
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Wed, Jun 29, 2022 at 12:06 AM David Gow <davidgow@google.com> wrote:
>
> The "Run Tests on qemu" section of run_wrapper.rst had a few issues left
> over from the last big documentation refactor[1]:
> - It referenced a non_uml.rst page, which was integrated into the other
>   pages (including run_wrapper.rst).
> - It skimmed over the use of --arch= and --cross_compile= in favour of
>   using a custom --qemu_config. Since most users will want to use the
>   former, let's give examples.
>
> Remove the reference to the non-existant page, and add a couple of
> examples to encourage the use of --arch= and --cross_compile=.
>
> With this change, there should be no more broken references in the KUnit
> documentation (i.e., the one mentioned in [2] is gone).
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46201d47d6c4be594c1d57b7f3251c371626a9c4
> [2]: https://lore.kernel.org/linux-doc/cover.1656234456.git.mchehab@kernel.org/
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
