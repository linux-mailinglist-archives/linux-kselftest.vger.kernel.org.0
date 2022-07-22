Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F757E018
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiGVKfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 06:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVKfz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 06:35:55 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A48CC8F;
        Fri, 22 Jul 2022 03:35:54 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id v10so1453331uap.11;
        Fri, 22 Jul 2022 03:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZKnuW8mda+Pv5ODyCfzYHYQK47yGtIeMQTcXQHTm4vQ=;
        b=I5W7LvuxRkO874+1/M/uqpXEGVpFohH0JlBJSXwZFFkWKq8p0MC0R7WLPCseZA2JS3
         K6f5XQTAPEBao+OfyDWSrRP1l6XSBNiFmRTUaeAcXB+Wo7+qRHvRO6xSQZFVcMZYInbA
         DHfpMyllmWvLmwD6g1rKPNe+xX3lGd4LfZYMVdY1IQ3uqo/oC0wpMn9ZCVphjQ3XgQ2T
         Lub7Bwyumq3LX6ft7PPkSDyB0yYf4bd4jiok1HhQ3zjNZMkzGGWkF450AeC82Lyi4jMM
         1K/sX9K+nqOiWVtPjxmzbkJ2GkvOcmGRLK9VJTVWk535KHoNidA6f27Rvyl2VCeCiOBM
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKnuW8mda+Pv5ODyCfzYHYQK47yGtIeMQTcXQHTm4vQ=;
        b=gs2H2HtLQfOonv2anFFdKltKYJfLjNRUKnrzPrHw6dsjwdSQ4Nhw8aWNCmyWsId1Ib
         EYf3ymd1tKis20rfcqY1SX7+/rc+5en1IVGAmY6QkdCPT0NQV/H7N1DcgpgRgQHv3Qku
         uVu5xaAM4x6hYzWiZWrBjuZkJhoayhk8dQOI8T81o1vCMTQGHqB6Hv0MrBxVBAJmap2r
         Akev5Y+prZAEuSTvVTCyted5xNrrEYA0sj2f1cPqxV8tnUH3SoJXF9U59tt6RkNWXLrJ
         caXywvcu1sbueiHyZpNVZ5SkZOVA34zFEeTdM5csj4dHWtlfFv1D3kG90O/E3IBdzZ1d
         MqMA==
X-Gm-Message-State: AJIora8QD1zL0OEq2c+Q6SbV2Lo1oib5DZFH+PUBa5JiasBT6pu70Xma
        YRXl9yWOAFOHDDoO+rkOG2It9bKUZBU4+PpALKM=
X-Google-Smtp-Source: AGRyM1utRwQRjz3mhWTLtpsFB6mhF2NbXXEDBgFnQ5cwOqFH2vmyeg5LbXrRR4m7MEEgLizLYgYCjg8eUcjJPiQnMaY=
X-Received: by 2002:ab0:20d7:0:b0:373:5c54:724c with SMTP id
 z23-20020ab020d7000000b003735c54724cmr841210ual.56.1658486153236; Fri, 22 Jul
 2022 03:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220708203052.236290-1-maira.canal@usp.br> <20220708203052.236290-10-maira.canal@usp.br>
In-Reply-To: <20220708203052.236290-10-maira.canal@usp.br>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Fri, 22 Jul 2022 11:35:26 +0100
Message-ID: <CAM0jSHNG8Ozs+NpvwMK6zvbRm3Ve=Wa1_H7jS0uQ8FeAWgvyoA@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, Arthur Grillo <arthur.grillo@usp.br>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 8 Jul 2022 at 21:32, Ma=C3=ADra Canal <maira.canal@usp.br> wrote:
>
> From: Arthur Grillo <arthur.grillo@usp.br>
>
> Considering the current adoption of the KUnit framework, convert the
> DRM mm selftest to the KUnit API.

Is there a plan to convert the corresponding selftest IGT that was
responsible for running this (also drm_buddy) to somehow work with
kunit? Previously these IGTs were always triggered as part of
intel-gfx CI, but it looks like they are no longer run[1].

[1] https://gitlab.freedesktop.org/drm/intel/-/issues/6433
