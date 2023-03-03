Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E376A91ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 08:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCCHtT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 02:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCCHtS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 02:49:18 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C616ADA;
        Thu,  2 Mar 2023 23:49:17 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id cf14so1969826qtb.10;
        Thu, 02 Mar 2023 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAR2N87vP4MjUgtQ2gw4JnK3iq+Hn4L+wybsd58CSxY=;
        b=ZevB0hkG8a75zv4SHOwV9rf4BYPWelSyH2qBdP98JKk5q/MGzEweTeKdDOKgdgFyPg
         hsVleJ5P02JgaZ3Sm6dHi6kfV5kDmmgHS9CWutCxImqXTqElX/xEw1oVU2wkm9JdnNF3
         wkmzTJ0kMyZflqarq1uWDK8xBAyjycA1/RL7QgtNnEjkhwyWYpEJ7X5Ue8UxHmAmBBUP
         8PdJtzfvxqbB8UCHfMi0ndztt+lYlVtwQq3+yLPofQJSeu73ZtAbDeDdyB9rfH6X1ZkM
         1NecRoek2lnN8i91x2XQcjHkn/DS3WuBOe88OZUmOocu95SwFJMLG97c8cY9p/W/ydRQ
         WjOw==
X-Gm-Message-State: AO0yUKXnYRqw6pbiabZG6AayqKQoJmQ4hYxiKpvukxazebMk047d/ECZ
        ykwuTzISXOsnlG3KeIhjM2PnTAfVaYT0fA==
X-Google-Smtp-Source: AK7set+8teQiyKpyGXsnFvHCI7CoC9uaraSl0CzLg3kx7Q7xyoZD/wz12wJA8Bt8aGB04l0aAMMpnw==
X-Received: by 2002:a05:622a:1353:b0:3bc:dd21:4a0 with SMTP id w19-20020a05622a135300b003bcdd2104a0mr1483967qtk.30.1677829756468;
        Thu, 02 Mar 2023 23:49:16 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id r15-20020ac867cf000000b003bfc2fc3235sm1243286qtp.67.2023.03.02.23.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:49:16 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-536bbef1c5eso28282997b3.9;
        Thu, 02 Mar 2023 23:49:15 -0800 (PST)
X-Received: by 2002:a81:f105:0:b0:538:49a4:b1e0 with SMTP id
 h5-20020a81f105000000b0053849a4b1e0mr3042397ywm.2.1677829755610; Thu, 02 Mar
 2023 23:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-2-sboyd@kernel.org>
 <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
In-Reply-To: <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Mar 2023 08:49:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVN=s-ytn03Kze5okA6rhzdWJ0cWxXV0vrtYXDvLoFMQw@mail.gmail.com>
Message-ID: <CAMuHMdVN=s-ytn03Kze5okA6rhzdWJ0cWxXV0vrtYXDvLoFMQw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: Add linux,kunit binding
To:     David Gow <davidgow@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Fri, Mar 3, 2023 at 8:16 AM David Gow <davidgow@google.com> wrote:
> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > Document the linux,kunit board compatible string. This board is loaded
> > into the Linux kernel when KUnit is testing devicetree dependent code.
>
> As with the series as a whole, this might need to change a little bit
> if we want to either use devicetree overlays and/or other
> architectures.
>
> That being said, I'm okay with having this until then: the only real
> topic for bikeshedding is the name.
> - Is KUnit best as a board name, or part of the vendor name?
> - Do we want to include the architecture in the name?
> Should it be "linux,kunit", "linux-kunit,uml", "linux,kunit-uml", etc?

I would not include an architecture (or virtualization method), as
this is independent of the architecture or virtualization method.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
