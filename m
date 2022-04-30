Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5E515AF5
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382265AbiD3He1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 03:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382260AbiD3He1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 03:34:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812ECE135
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:31:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so1746476ejk.5
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzDHkAqitatyTcPFJa1mY5lzI4udlQpvmGQagzLDym8=;
        b=PTUaOeLLVeSdVKlPHwLajhFQ+RGXmvKDhBLR0FRjVljxZeHtCBrwZAxMLPJ7hO9czf
         +pE5VMAFJvm7Dz5c/QiAHhG12O2ywytGcdD1ge45uWIq5F5DtgMWGkrN25Y0R6uhpP1Q
         RcppfFCqGzmGF82Rm9UIRt78+yB0exo53B45YnnmPop/gNyQg6jtmJOpJvQUHIYFHGwO
         KmCpmEK4GOzzKlknXQZzG9PCjKAqsCyJxA628WIpEeo0/vc6x5FIb8T1iNIRHCdIWCOo
         1cBv8hI0ISBk3f8ez1PCehaKcw7Ji2rWvWH5pgrxuSd1bMFrAFwnvYeLvYFGnkLmHq98
         Wn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzDHkAqitatyTcPFJa1mY5lzI4udlQpvmGQagzLDym8=;
        b=Ec0yNbI+PeC6leF2qw8NHdvqZEZjW4F3PKR9M8390XHK1JjaORSj7jPJtJ0PV6ksoN
         JaKw01PSTEMs6dAGe9WmEyNj9ORbnmt/oZglIM06xmQEjxA5waXK/RzeaUmQfCG4CxPN
         X0A5ihKotQRxzVSqrXFLq+G2ZuZLAMfJHApSzW2QJlnuYvXNOOY6VXOImmlvh3UK00c+
         RYFniI3+M+XZx7hvBv2zUU398gnEqEh7/fHVkUFPZob69ADRcgswzTL1jYCkTgZALPkQ
         il0wTRITZ3KckMKhXf550eWzTmtoXzBrK7MWiBudFGayDPoF1CKsz0t5lvqc11cEOggY
         nP7w==
X-Gm-Message-State: AOAM530I1RqlApWYfbS8L951SsJTSXHJjGXRXV/MdJz7bLTtLqYoORYt
        CAFLRd5HDoNaz2DPN2L4iUnC72FR1YpTRSRS935bsA==
X-Google-Smtp-Source: ABdhPJxLoY87J3Nwdm8bo89z/aU3TZjQtBGk1bUIDa/5ZNT9/wS66XZEEYzdJAYZvV55mk2pLmDCViVvi/DquisoBXg=
X-Received: by 2002:a17:907:3f8e:b0:6f3:d07c:b25d with SMTP id
 hr14-20020a1709073f8e00b006f3d07cb25dmr2836083ejc.59.1651303863134; Sat, 30
 Apr 2022 00:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:30:51 -0400
Message-ID: <CAFd5g46L1JZxvbV2ZS0-FPTB+je5=wDtZZvdiOLsFF=jJmXzPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: rename print_subtest_{start,end} for
 clarity (s/subtest/suite)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> These names sound more general than they are.
>
> The _end() function increments a `static int kunit_suite_counter`, so it
> can only safely be called on suites, aka top-level subtests.
> It would need to have a separate counter for each level of subtest to be
> generic enough.
>
> So rename it to make it clear it's only appropriate for suites.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
