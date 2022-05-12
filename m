Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259C52554E
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357841AbiELTBg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357838AbiELTBf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 15:01:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C8580C8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 12:01:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dk23so12040410ejb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pszSDfe0UbNgZW4RxKcUIgfomIDDQRx5VP5T7VUEGIM=;
        b=VQA5v8vqLahAK/ejzfmgUBIfDmleeuUyWizNuLo7eork68u0Kdo0mLk2LagPzvdFwu
         bPCS9pMREZcOLfpyQDK34HFBotdepKvHzCsAOrES5gBMNoFMkdTjhNWo3ROXCx8UIc6v
         BCV6hXpLKsRMRyhsT3mtXAL6JctiOwVyu0Mtk+yNpYb9O3TLaydg6GrpNp6If5JZq/2u
         rssY3r/WK4mSLTJQ7j7QHbvFf/6tkQnm06XpMa68d3wW/OykknmCFx3ve/RcoC7VmZQo
         aMmeuLlc6VWJC+vLFjNH6JHeTvcDMOyWHEaZB5+wgl5AgyD4B4DGg2VFzVrGtKgI1+lS
         OgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pszSDfe0UbNgZW4RxKcUIgfomIDDQRx5VP5T7VUEGIM=;
        b=lLtmVvWxiz35/t2mLOAX7vXRDs5PXdZxU0h+iF+4wRK7wfJ3Nb9PIgs464FCzw3tB3
         IPFOdBZOF6sJPbmDNySYnxNY0IRNjuqeUevmiOpWOEa4Kk65zgYz/iyrHScXLVLdJ5Hg
         LlhLyRzMgjz7W0uP4y7Oc7jnWtPM++Q1vhtX/EqIBt2LTgUTVyALxCIsc/k5HguFEm1/
         7zmzJbPVGGI0SscBFgbCQIYFNceNNv6mx+J6Agz4vfc6WlgSl25FpKCO6vCTumnqphfM
         RXmL14hOIayPxhv8AAJiJDiCHDPrBftHLl4rKaDsrjTT4qWEWzIBcNXcSmum8phEYm7J
         4uCQ==
X-Gm-Message-State: AOAM530io7RiCos50fL5zP1SSzXRhcAaPCXptu4TOpq1RCpt9iHjZIRw
        oX6GjegS3NpzfzdYRrkfK71zefzM8WydwBvtlDBQew==
X-Google-Smtp-Source: ABdhPJwemMtr42pU2bJn8Gbt0kVxmOlvLYjum2OQe6Gv6T1/qdj76xgaaBMFoVVLZwHNnlZ+i3CiOANGsUxi8Hhu0qQ=
X-Received: by 2002:a17:907:8a24:b0:6f4:82c9:9adc with SMTP id
 sc36-20020a1709078a2400b006f482c99adcmr1202252ejc.223.1652382092846; Thu, 12
 May 2022 12:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-5-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-5-ojeda@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 15:01:21 -0400
Message-ID: <CAFd5g47skTReYjQDHdv=V52+E-1odLsTJMn6E3GV7N7mYia=bA@mail.gmail.com>
Subject: Re: [PATCH v6 04/23] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Sat, May 7, 2022 at 1:26 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
>
> Therefore, the whole chain may be made `const`.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
