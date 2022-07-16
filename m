Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5E576E35
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jul 2022 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGPNgg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPNgg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 09:36:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE718B23;
        Sat, 16 Jul 2022 06:36:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o2so2384894ill.6;
        Sat, 16 Jul 2022 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DwIeby9yP04RKpyJxL5PrbdIqogg6yPOhWbo7JHmTA=;
        b=XobnjiTf7v9nif7ZIlYg6CbjUFX3cB/9L3Hz5e1BulKOtPVn2M/orxn0vsUl/cpKhY
         dqFf2lJQAMgMO7d98L+pRwuR0kxrQIFhvsuMfZeYqLfiBHZYZCWTEUSA4lkLSVrdAHUr
         Ix8rI8hyA0tAOhtbM0japKKIgJGjWKbUUtZAcLwcznI3x7/TobbZkwBk11WGmJYEkEcL
         8QiDsZ6qmsKQg4OwcqnhT1EZm9n34q8SAbthTgCkexcQOgHQg2gIreI8iCBG+J/k4Urx
         m81j8/RwwDwDhpw8LGZKfNWdJQmkOT/+vxA1G3qnh3GyJA5IWNOdXvpxn5y2BkXYBdpc
         MX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DwIeby9yP04RKpyJxL5PrbdIqogg6yPOhWbo7JHmTA=;
        b=kDHyL0/1dOMVZ5vCGz7oZ+0XwJJeE5mhPsPRO6xsVIBSAmMVyGgFJrqclhVuRMQAko
         SdpswBMbCFhbi2akePoCwpON6imfP0XCB/BYg9TQkm+jIE3v1LpV1faabjWSkZLA850K
         ZG4UlhcIaGmS/TMGeDn4BWBNh6LaxyJy0HhxNkOasuTc9I9SORgqWE/4Ni0B+cE0iof5
         x3D62yQ/c1R15H1DGBKI95PItVA2fiLs+8TTCRiJu0xxIxhm/iFA9u367en0aCTLviCq
         bxbrBDvSVcE0z7eYI9yPSiEMVtA5En51rNty1C9FZYaoc5Zqv6Y7ceEG3LoikAnvnrbA
         ctAw==
X-Gm-Message-State: AJIora+7mlXgEUbMYhthFD6H9yqqYIGiuQhZ1TRDeZxN+ZHub99Dlyx2
        +Lc0knjdNfclssoMaD3FXPR8qQVxQwU7Wi7inkbZl8SAZBd7YQ==
X-Google-Smtp-Source: AGRyM1tG1YsrvjoLRvogD9K95sp2B6IZvclnFGnFqUdc0M2V7E19ryC7xwimpnUQHvy2WNgV44DytXl4VP+O6mesyIU=
X-Received: by 2002:a05:6e02:188f:b0:2dc:7291:fd02 with SMTP id
 o15-20020a056e02188f00b002dc7291fd02mr9120346ilu.321.1657978593469; Sat, 16
 Jul 2022 06:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220716124214.329949-1-conor@kernel.org>
In-Reply-To: <20220716124214.329949-1-conor@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 16 Jul 2022 15:36:22 +0200
Message-ID: <CANiq72nYRkHV6N2bGpTz3td=2Vto21apvZW0igTT-mV8TZtB2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Rust support
To:     Conor Dooley <conor@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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

Hi Conor,

On Sat, Jul 16, 2022 at 2:42 PM Conor Dooley <conor@kernel.org> wrote:
>
> Maybe I am just missing something blatantly obvious here, but trying
> to build rust support in -next fails for me. I am using ClangBuiltLinux
> clang version 15.0.0 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa and LLD
> 15.0.0. Is it just expected that building -next with rust support is
> not a good idea?

Please see https://github.com/Rust-for-Linux/linux/issues/795 for
details about the maple tree issue.

I will update the `rust-next` branch next week with the new version of
the patches; but if you are interested in developing, please use the
development `rust` branch instead in GitHub for the moment.

Cheers,
Miguel
