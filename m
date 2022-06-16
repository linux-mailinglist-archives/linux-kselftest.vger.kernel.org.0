Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2054E75C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiFPQdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQdL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 12:33:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36C183B4;
        Thu, 16 Jun 2022 09:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AFA2ACE2645;
        Thu, 16 Jun 2022 16:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7758EC385A2;
        Thu, 16 Jun 2022 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655397186;
        bh=ajIRcyhE9euZCf1gQtbn+SYSBSduLaCdd2YqjZLkIUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TlT4LUsV3F8YRNp8qbdZsuzsR23JJT5NWD/GUaFPFc8K20X/Y/EZgUacqoXx5HDFo
         o39yp4HHzQzWHNQWGi8UNzM2oRQO/5d68Ee3GsEje5VWyv1XA1R9daOJ/AL1BtxZ19
         WWlAkhrQo85/qLhfxfX2ADK24OIoETzkHEhGE4mJZnUAqhabgVIGHrNDU10byThhiI
         jXBefplHE10QQfkckrAkU7mXqcdgbHzu2TdYco8cpal8BjVXamuXQEZFb6X5nGSwbc
         W1AYBsdWZ/WSpZoGrkdh9tcJHld8r+TFiHNbmPCHuI0j7Wz+iYG9zkIcb5XZH3sXpg
         +qvXBsC1a2JbA==
Received: by mail-oi1-f178.google.com with SMTP id s124so2542684oia.0;
        Thu, 16 Jun 2022 09:33:06 -0700 (PDT)
X-Gm-Message-State: AOAM531LNFyd1a7x0eam8NRMwrKnhMtkYHeWD2ZqW9fS/brkaL3eZQ51
        PFXCz3Q/zvuoqT11j0FW+9UjGTHQJVczEac8zBE=
X-Google-Smtp-Source: ABdhPJzvTcTzDyBn3A6U05nubb1Udaj+J1O806kE5tNDRAfbLDFrGbibjpdd5fShQ53UcGBhHIVVTr3XGgkzvsMvDmg=
X-Received: by 2002:aca:aad5:0:b0:32f:3b9b:e0f with SMTP id
 t204-20020acaaad5000000b0032f3b9b0e0fmr8420111oie.228.1655397185610; Thu, 16
 Jun 2022 09:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220616124740.580708-1-ardb@kernel.org> <20220616124740.580708-3-ardb@kernel.org>
 <202206160919.360DB5F4@keescook>
In-Reply-To: <202206160919.360DB5F4@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Jun 2022 18:32:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF9RWXrZbNZwLU9y7rM36b=sUM97i-12ngAsW+WnKfZ4A@mail.gmail.com>
Message-ID: <CAMj1kXF9RWXrZbNZwLU9y7rM36b=sUM97i-12ngAsW+WnKfZ4A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] efi: remove deprecated 'efivars' sysfs interface
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 16 Jun 2022 at 18:20, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 16, 2022 at 02:47:40PM +0200, Ard Biesheuvel wrote:
> > Commit 5d9db883761a ("efi: Add support for a UEFI variable filesystem")
> > dated Oct 5, 2012, introduced a new efivarfs pseudo-filesystem to
> > replace the efivars sysfs interface that was used up to that point to
> > expose EFI variables to user space.
> >
> > The main problem with the sysfs interface was that it only supported up
> > to 1024 bytes of payload per file, whereas the underlying variables
> > themselves are only bounded by a platform specific per-variable and
> > global limit that is typically much higher than 1024 bytes.
> >
> > The deprecated sysfs interface is only enabled on x86 and Itanium, other
> > EFI enabled architectures only support the efivarfs pseudo-filesystem.
>
> Does anything still use the sysfs interface? (e.g. do paths to it exist
> in anything meaningful in, say, a Debian code search?)
>

All the hits I get there are in code that refers to
/sys/firmware/efi/vars as the 'legacy' path, and also carries a
reference to efivarfs. (i.e., /sys/firmware/efi/efivars)
