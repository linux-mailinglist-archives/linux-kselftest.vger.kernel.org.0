Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2F60369C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 01:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJRXUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Oct 2022 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRXUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Oct 2022 19:20:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC457E00A;
        Tue, 18 Oct 2022 16:20:33 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h203so13123965iof.1;
        Tue, 18 Oct 2022 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DpcZwD/VTohz2sMEZHghcKoGpwp7viWCf88pD6gczuY=;
        b=PkYye5Dx/rZwH+W9lzinlIcLs31ssQDHpMrSk3RvbH1dV4zUSX6udiS429Yw+YHbob
         J2j3vn4faLjFpi3MFJsQUZrU+sSLqu+vI3hdeh5L7SpAOG7IAlmZwpFtDTb8O1KudlBD
         yau99r7qHcXv+ELKKnV/KRV6rlFZBLb5QgOEKgXsdKEqyQW7/kQElzKqino1XMhECqUi
         RXZ4DbnRaHCVfqh+cW4G3QCHa+uEtFiY6hDdGRz5vGRx+38cZmMrSinawVt1pIFIGF7g
         yLJZ8iSV3/4Lli8+ULwk7kWRuVvNGq++DRrYFLF0kUpNL5w6I8HwperPcIDps6npJTH4
         Re5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpcZwD/VTohz2sMEZHghcKoGpwp7viWCf88pD6gczuY=;
        b=7ErX1SccKzBxMrwH4rjCHo+0vBvVcZvAUkeXTtGLxoq62odSTVIoNHH/j/yrcSxrL6
         6+oo4veD96of/oNh08TVc+aET2QJEcoy5OV+jeXcNeRI/ooegjiK2J+zT0UL9mwdqgda
         AB7F1kjCtFbfAX2imibGS0jE/SDSIvZ6bVEeA46OpEMoNrORLjnrU7NryL9s7PBNbmXp
         Sde5h10uWKS84290NbuPxG+rZTnQnRl+RcPvOSTWJx2sgtdaI681NiO7XcSiLvYO2NmP
         n1BTuk/5R0TEonsbK1zqPOM3Qk+WT+wIM5tO4FV2n87bWdjmWYoFqwp8hyWX0+RSyCDo
         QkvA==
X-Gm-Message-State: ACrzQf1Gky8UsXGppTkBu0EmVmKoT2FvNMBJANabaI3tFgrLZ3YnpW6N
        FF1MQegJ6t3g4+B8tg7+VTk1MZo6q2qujHYOgbk=
X-Google-Smtp-Source: AMsMyM4qcksNk1keuarNtmVMyvT4Mysk87fdtW2CuQ2kpElEi8xfDz+sd2PVtgVfhhbU8K3rA1Gon5Nsz2Nw8bFOnkw=
X-Received: by 2002:a05:6638:dcc:b0:35a:7ba6:ad51 with SMTP id
 m12-20020a0566380dcc00b0035a7ba6ad51mr3979566jaj.256.1666135232695; Tue, 18
 Oct 2022 16:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
 <CAGS_qxqVUmjxULZ_Kt-gWRJb=+EYpG2_K89sQTq0BYbUighn5w@mail.gmail.com>
In-Reply-To: <CAGS_qxqVUmjxULZ_Kt-gWRJb=+EYpG2_K89sQTq0BYbUighn5w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Oct 2022 01:20:21 +0200
Message-ID: <CANiq72m5nk4zvcYozFKjO=9gOXG2wx2MG1EYsgAZwB_PnHUSJA@mail.gmail.com>
Subject: Re: [PATCH 0/4] kunit: more assertion reworking
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 1, 2022 at 8:00 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> While I have you here, any thoughts on how to coordinate the change?

My bad, I forgot to reply to this, sorry. I noticed it again when
merging 6.1-rc1 into our branch.

Normally I fix the issues when I merge back from Linus. Since we
intend to keep the CI green on every PR, I added the fix for this in
the merge itself.

In any case, to clarify, the `rust` branch in GitHub is just where we
placed a lot of things that we wanted to eventually submit (and some
that should not, e.g. the GitHub CI files). We will be minimizing the
differences w.r.t. upstream in that branch by preparing proper patches
from scratch and submitting them through `rust-next` and other trees,
and eventually remove it (or reusing the name for the fixes branch
since that is the name other trees use, but we will see).

Cheers,
Miguel
