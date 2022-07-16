Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30024576E5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jul 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGPN4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGPN4M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 09:56:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E751F2EE;
        Sat, 16 Jul 2022 06:56:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a12so3809440ilp.13;
        Sat, 16 Jul 2022 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4FhIyepvRr1gXawjyEQpzIVadAC7ZxwCjKEzgRh/bc=;
        b=KdWH1PfnFwqpPxd7W0PxapNamksI04N1J1pzzmASbjhZAa3HLxSSk5HwzaEAseuXpW
         nNsgKAEAxGvztay7gho66xNc2QCxWwEyGXbCv5lAz3EAhFpFJfuIeY7K76/0vq1k3vCQ
         2A4ZeWEkN4IZQH1TYyqAVV2R0ANWdmP2osXk1QbS92RBijpvBQo0R3fnlJ87Bav+p7xf
         FSAfrCYfgPPgpP/Eo2QbIXBrRk5zd4AvPDHrzOq47USph/a5huS67TiBDFyW8noTS6Uh
         Rr0qFvkmBG2Rj2WAofY8yIfRhbQByw8ah0SxA+yZ2h9GNamE5b2FqVNxaZBPSBZiccV0
         aKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4FhIyepvRr1gXawjyEQpzIVadAC7ZxwCjKEzgRh/bc=;
        b=OmqNJv4F79HDKtzmwqhBTenlD/euEtgNobwW+wx4fV4suX3whDRHJavCu8Clg7/Bjv
         oQ/vo6f2efo/WEd6qOyufXnEhlAY4eMlYk+tsDNXMilShiuj6wvtWTxKCbKUsC4yVo3f
         U5eqQnsH3TRUSdlp7xdBL3/dHthS9ee0r7bnZV9VCUSLvzonZmyhll8BCPhiuBzeOiKs
         XIhuKGHQRM6ZQEt+7+6IKuSbgBkIISgPgJoNDobLbtKJfpHfRhwOupyiiecx+dlOVfH3
         MOMGdC9xK4TiFubxMiQshLT+/q/RiaGjnXY1H+6cQgcILTngiTbuQ/vYZuA4915IBlFF
         rnOw==
X-Gm-Message-State: AJIora/8kkXUzBujRAWsrzQjiNnPsNm5ORPpe31GQ2tqYIeY2DcdtGyc
        oJTCaaVEWcwq0bRDwwXd5pslV8Pv+n9c04/pwXRwI0N6RaQ=
X-Google-Smtp-Source: AGRyM1tr+wIQ9WPj4ffi06adPAclHl6+H10vOy21nRYCi1+gt6eZYnfIg0TqG8PTuM+GqMyjQgVFJxK/0/WWZ5rGrRw=
X-Received: by 2002:a05:6e02:1c2a:b0:2dc:621e:df15 with SMTP id
 m10-20020a056e021c2a00b002dc621edf15mr9816280ilh.151.1657979771086; Sat, 16
 Jul 2022 06:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220716124214.329949-1-conor@kernel.org>
 <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com> <4a6240da-9003-cd74-cd47-f95ba2d9e7ae@microchip.com>
In-Reply-To: <4a6240da-9003-cd74-cd47-f95ba2d9e7ae@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 16 Jul 2022 15:56:00 +0200
Message-ID: <CANiq72nDcJLSB3pLhkdqGdLitfmqqCUVVfkY5EjP9AcwVv9B4A@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Rust support
To:     Conor.Dooley@microchip.com
Cc:     Conor Dooley <conor@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        live-patching@vger.kernel.org,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Sat, Jul 16, 2022 at 3:51 PM <Conor.Dooley@microchip.com> wrote:
>
> Ah right, sorry for the noise so. I checked the ml but didn't see a
> report there.

No apologies needed -- thanks to you for the report, instead! :)

> Thanks Miguel, good to know! I'll just wait around for a new version.
> Just been trying to get my CI etc in order for when rust support lands,
> but it sounds like I should be okay as it's a known problem & not some
> only-broken-on-riscv thing.

Yeah, it is a simple `bindgen` issue. Thanks a lot for making the
effort to prepare your CI in advance!

Cheers,
Miguel
