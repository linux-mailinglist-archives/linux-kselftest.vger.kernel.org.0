Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000586EF58D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbjDZNew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjDZNeo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 09:34:44 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E52701;
        Wed, 26 Apr 2023 06:34:42 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-b95fb433f59so12658151276.0;
        Wed, 26 Apr 2023 06:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516081; x=1685108081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeHKt905fqWZBLe33jnW16aE0fwe02cFw8ng1B7DTOU=;
        b=LDDOmRxNyxlYGsb3WSOKVdJr9oWmkJGsFQC10dsyJ1hCN+Fz8YW9P2mkArYfhGT7tl
         RSsCIP1p3amNW+4VoyZ2KYPXzWaLntxWx2oTCH2FJeQDxTKlA7KSiB7I20U4YER7rz8t
         nlyVCfLwQnkcsCv8KGmpeDx6WcVuV54a+NUsbq/Xq2tVxxcoJqOm2xlMZTv7iWJgHARZ
         357lknIYbTWzKHJd3HtkeDB/Kzl1y7e+uxKnGCts4SrzD1QZSKGFo+xzDe3MwlOCfpy8
         yNotXE7Wog6OJJPAPT/2+OzJq8OVohT8mQ6YIej51Aosmu+Np+ppz23S9WbUG28UsjZO
         7NoA==
X-Gm-Message-State: AAQBX9eQr7C8d7IC4jgMS2PSy36zJpBRWcWugJaXEfFt6ipY75bF3Nia
        MQT2tQEjoHMD3YW+8gj9Euz+RScQ4kkyag==
X-Google-Smtp-Source: AKy350YUpjzij4nVpR/rMt6Q4NNGL/nRtveFNBSP3prbrsbiht7eXjAy+rWr7EU8ItHaLhBtYU+Faw==
X-Received: by 2002:a25:6dd4:0:b0:b8f:3b82:bf9c with SMTP id i203-20020a256dd4000000b00b8f3b82bf9cmr12997920ybc.41.1682516081643;
        Wed, 26 Apr 2023 06:34:41 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id z188-20020a8165c5000000b00545a08184d0sm4186796ywb.96.2023.04.26.06.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:34:40 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54f8e81c3f3so102521817b3.1;
        Wed, 26 Apr 2023 06:34:40 -0700 (PDT)
X-Received: by 2002:a81:ab46:0:b0:552:ea90:3930 with SMTP id
 d6-20020a81ab46000000b00552ea903930mr13313007ywk.10.1682516080348; Wed, 26
 Apr 2023 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <a89cb0eae953f534011d3a655fa70feb01fb2b73.1682510075.git.geert@linux-m68k.org>
 <36a8dc3b-50bb-4db8-a7eb-bb69517187da@sirena.org.uk>
In-Reply-To: <36a8dc3b-50bb-4db8-a7eb-bb69517187da@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 15:34:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN1nbHCgRabsiJJ9cYfs2LWQkMJ-mQs6WAMb-TY59a=g@mail.gmail.com>
Message-ID: <CAMuHMdWN1nbHCgRabsiJJ9cYfs2LWQkMJ-mQs6WAMb-TY59a=g@mail.gmail.com>
Subject: Re: [PATCH] regmap: REGMAP_KUNIT must not select REGMAP
To:     Mark Brown <broonie@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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

Hi Mark,

On Wed, Apr 26, 2023 at 2:42 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 26, 2023 at 01:56:44PM +0200, Geert Uytterhoeven wrote:
> > Enabling a (modular) test must not silently enable additional kernel
> > functionality, as that may increase the attack vector of a product.
> >
> > Fix this by making REGMAP_KUNIT depend on REGMAP instead.
>
> This doesn't work since regmap is a selected library so there's no way
> to directly enable regmap other than by enabling something that uses it
> and it is very likely that the virtual configurations people often use
> with KUnit will not have any physical hardware and therefore will not
> need regmap.  It seems a lot more likely that someone would want to run
> the tests on a platform that doesn't otherwise use regmap than that
> someone would end up building in regmap on a production kernel that
> wouldn't otherwise have enabled it.

Thanks, I had missed that.  Will send a v2...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
