Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65F6F429C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjEBLWQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjEBLWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:22:15 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9370E7;
        Tue,  2 May 2023 04:22:14 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-55a1462f9f6so23779007b3.3;
        Tue, 02 May 2023 04:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026534; x=1685618534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1KRMnII3sp+pP/EIBj/BLEot9elryqaEAGvISTmf9M=;
        b=GijgkyDiCFV+xQgR+eRtsNuFotzj1TAVcBKEafgkYbT2N3Fa12QJAGrAQtF6zixMsP
         tPovwlkE0Dh1x/qz1dfZOgIgyI/UGJEYQ1BYd/tJ9VABtsbiXOd05EEykYZxpcQeILpL
         3pVgFjEwqPTxmJtz4CotiquqAJJplYnteHzllj9tKVSaPumnTMiOVQrvdCOVpPFwCtec
         5EDELyyJP33jwmuWtlnC2jsBAjTswcjsM+0Hi3vKwS0CAe2v8L5oplxroFxECBJSN5Uk
         M/UcIV03/lH4mZt2msIh+1Erh8kIOmwqjNlCRDCTxDyT40wjM3nYxh5fHFNXXn57pbcR
         OMVQ==
X-Gm-Message-State: AC+VfDzpkr9hrvaGxJ5xgv9cODM81DWYoQLOas+LgFksqxMWBcYGKhC1
        nkzaOg+6fNUQWirytjwfvmMI4IFQuuoo6A==
X-Google-Smtp-Source: ACHHUZ63KWVno0tnvGo5VqGJtUEHAjbcCuXCo5UgD+uakfrlWKGPy10a6aTYfxMO4L/zzWR+HC5dQA==
X-Received: by 2002:a81:6f41:0:b0:55a:98ff:f077 with SMTP id k62-20020a816f41000000b0055a98fff077mr1773975ywc.2.1683026533739;
        Tue, 02 May 2023 04:22:13 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g137-20020a81528f000000b00545a081847esm7918686ywb.14.2023.05.02.04.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:22:13 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b99489836aaso2973812276.0;
        Tue, 02 May 2023 04:22:11 -0700 (PDT)
X-Received: by 2002:a25:1fc1:0:b0:b8f:4e38:4560 with SMTP id
 f184-20020a251fc1000000b00b8f4e384560mr15443521ybf.2.1683026531814; Tue, 02
 May 2023 04:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683022164.git.geert+renesas@glider.be> <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
 <87ildbx9or.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87ildbx9or.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 May 2023 13:22:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWA7R7NrS-T8x4qA3tn59zmZS8w20f1UyTw-R53iryeTw@mail.gmail.com>
Message-ID: <CAMuHMdWA7R7NrS-T8x4qA3tn59zmZS8w20f1UyTw-R53iryeTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: tests - modular KUnit tests should not depend
 on KUNIT=y
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Javier,

On Tue, May 2, 2023 at 1:19 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> I've only been Cc'ed in patch #2.

Not really, you're in the To-header on the full series?
https://lore.kernel.org/all/cover.1683022164.git.geert+renesas@glider.be

> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > While KUnit tests that cannot be built as a loadable module must depend
> > on "KUNIT=y", this is not true for modular tests, where it adds an
> > unnecessary limitation.
> >
> > Fix this by relaxing the dependency to "KUNIT".
> >
> > Fixes: fdefcbdd6f361841 ("Input: Add KUnit tests for some of the input core helper functions")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
