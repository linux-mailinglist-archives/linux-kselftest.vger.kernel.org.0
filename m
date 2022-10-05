Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05145F5AF9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJEU3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiJEU3L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 16:29:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982DD80BF8
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Oct 2022 13:29:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m3so74487eda.12
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Oct 2022 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Poen6yISP0M2ySyDXJTla1arHaCuw6dM2gnnJZIpk=;
        b=nv4LN43x37ei5cSd/zX+afzYMuCvOJGrL+N3rqvg4KKJtRprnHKooTvMSGSpE8tRWf
         fdHEmPmFIrHPKURblhdkZ5V8KNY+F8lDFM2RAhIlxoygrkTDlk+WtFxgCkB4uDKpanMk
         +1rK9JGjdGSInp33xZIDrZzPP/Zr6QYb7pN12lj/7KIDkRQwH/KQSW16GQH25tVGNo6s
         ZL+rODBnXHlIeS/XmalTzYVtJaLSKrl6HpHKvJ0q43KfdEw/S+jNQ74JVAZvu4GECS8J
         uyyRKCDu6JN4MXKC4qSXPK9bQ4ieJhdLmRMFObdY6SITqUmOou+FS8r3MuLuPe1k7X9M
         eQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4Poen6yISP0M2ySyDXJTla1arHaCuw6dM2gnnJZIpk=;
        b=GxoGzhagPhaJFYEC2BiXnJcxmZoh6kH7l1wcmPkfJb4wbPsQy2Pccdelxw/9od6aR4
         Z1aS7QP9BKNb+WTAYzgneZBWZbvInPgL8j/LG86yNA7izjFPla0uVLHuD5cyOegPnpqE
         ja/u//9R/tNWDLdN09kueZPssxbFjv5bc/bU3tiYd8ao/A+LCDyxan7CRdnHTwpYsJJK
         CrpI09wSle6M3PROQQHC+AjyK5YhSsHtqPXIREAoIkYqWiogHywSFqEbq/MY/0jYTgP+
         wPFMDXbD4gXw0PiHnjYEMLUgUvJPBBQMPvD92SdUE6eCyLQ4K7j8g3IpWoewZcGithN2
         Oniw==
X-Gm-Message-State: ACrzQf2TwrB23uesw3gFfvaFRFU4sQp61KXpf3b8LjZr/ryPP6sgp+kX
        88T0qdmU7PFekCj2Aec+vcMxpS08E+B7iwKvxkKRsA==
X-Google-Smtp-Source: AMsMyM55YAoYQA7BeOEG2HhT1mPC4gHA/gUc6VckANG8wkCaqHQsmaY3Oc9LccLPVT/ld9va7xDoUOkU3ZNp+4jbqwk=
X-Received: by 2002:a05:6402:3890:b0:451:ef52:8f9e with SMTP id
 fd16-20020a056402389000b00451ef528f9emr1393020edb.107.1665001749012; Wed, 05
 Oct 2022 13:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:28:57 -0400
Message-ID: <CAFd5g45B4+xZeFHp6nWPca0udk1xkAatiJAu2Y7z2tsYVi9E1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] kunit: string-stream: Simplify resource use
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

On Fri, Jul 22, 2022 at 1:15 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> From: David Gow <davidgow@google.com>
>
> Currently, KUnit's string streams are themselves "KUnit resources".
> This is redundant since the stream itself is already allocated with
> kunit_kzalloc() and will thus be freed automatically at the end of the
> test.
>
> string-stream is only used internally within KUnit, and isn't using the
> extra features that resources provide like reference counting, being
> able to locate them dynamically as "test-local variables", etc.
>
> Indeed, the resource's refcount is never incremented when the
> pointer is returned. The fact that it's always manually destroyed is
> more evidence that the reference counting is unused.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
