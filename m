Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7922B4ADBC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 15:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378981AbiBHO5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 09:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbiBHO5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 09:57:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E308C061579
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 06:57:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f17so20925196edd.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 06:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPGckZDXD5dKY+OHvFvXimjXLNAanNMSNprTgL/Df4o=;
        b=jeUTJv7bqTiD0hTflysO1LMASbBud7a0GhZ5bnMOKyjPKNZTXG5m28cAe+2i+iSg89
         sWw4nhjmCG5xCqWN725Gb3J4aFbv7Y73NAacVw/LNL6wnlegJAuh5ppeymEBeR8DYCJc
         83IbqVGQCi4gtzdyxf4vD57gIEmtw20JAeuOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPGckZDXD5dKY+OHvFvXimjXLNAanNMSNprTgL/Df4o=;
        b=j3/4APDYtvxvQ1KzbrfC1uBPn6jFRpIan0fBkXWkaEZDnOlFrNldDdLBbyJMsHn0dj
         7OkN9jQ8N3t43jdhU5xFpOg1/9nmLYFvhyGpthEEgi9zfBjCCVOwb+0ksJq6FJ4dEJ+A
         rHfNFuo4XZgt6q1V51giKeGTxzfDp/K6MX/TeJf5EshM4Z+1iBGnT/SGEs0WhcWF17NE
         qZUo/KwA14cnPaex0unzE2ay7nEG52bodIimJu3qruakJRQII9DGVYvDo3g9p65HuZSN
         7IqklapfGSo6/tMhnjHea31cun/BqxkqV2YdEx5R3ul1mcPJzZ5fuAsFDR2bkxBdqOYy
         Rt0g==
X-Gm-Message-State: AOAM531Rq9N4fN8yfLPgijtj8MnML4tFDRVFDqafhwaL/Fl6PVv2LvNy
        hhpi6HW4Ol3LPmfdRDcaEDvTvHWqA1ZTH7xu
X-Google-Smtp-Source: ABdhPJz9u6F9eMUl14Dx2XbmRNAoVHwWahYK77kcHDAH9jEWg2dl+skt6VSRuZB/PkC047shDskjyw==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr5022944edb.158.1644332241931;
        Tue, 08 Feb 2022 06:57:21 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id j19sm4881444ejm.111.2022.02.08.06.57.20
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 06:57:21 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id f17so20925029edd.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 06:57:20 -0800 (PST)
X-Received: by 2002:a05:6402:1681:: with SMTP id a1mr4855489edv.167.1644332240523;
 Tue, 08 Feb 2022 06:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20220208114541.2046909-1-ribalda@chromium.org>
 <20220208114541.2046909-3-ribalda@chromium.org> <YgJmaDJTGTmRgNIy@lahna>
In-Reply-To: <YgJmaDJTGTmRgNIy@lahna>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 8 Feb 2022 15:57:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCu_QCbTmvrwDsrEeoMKoc4JN1HmQDDCKnYdQTtWUgWnPQ@mail.gmail.com>
Message-ID: <CANiDSCu_QCbTmvrwDsrEeoMKoc4JN1HmQDDCKnYdQTtWUgWnPQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] thunderbolt: test: use NULL macros
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mika

Thanks for your review

On Tue, 8 Feb 2022 at 13:47, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, Feb 08, 2022 at 12:45:38PM +0100, Ricardo Ribalda wrote:
> > Replace the NULL checks with the more specific and idiomatic NULL macros.
> >
> > Reviewed-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/thunderbolt/test.c | 130 ++++++++++++++++++-------------------
> >  1 file changed, 65 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
> > index 1f69bab236ee..f5bf8d659db4 100644
> > --- a/drivers/thunderbolt/test.c
> > +++ b/drivers/thunderbolt/test.c
>
> You could add these too while there:
>
> >       p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
> >       KUNIT_ASSERT_TRUE(test, !p);
>
> >       p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
> >       KUNIT_ASSERT_TRUE(test, !p);

To avid keeping spamming the list. I have pushed my series to
https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/log/?h=kunit_null-v5

if there are no more comments by tomorrow I will resend it to the
list. Maintainers can also pick the patches from there if they prefer
so.

Thanks!

-- 
Ricardo Ribalda
