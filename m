Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390C54E6E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbiFPQU5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377204AbiFPQU4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 12:20:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31642A10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:20:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 129so1691211pgc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y9i2UaKM9g/AdwlOLX3q72dPfl3fDu2HSqiXz/urf2k=;
        b=Y1JWTj2a8jakWuo8reBEFDWXyjspvcpnlZi9rK7Rp3nZYIx7Mo2Wq/OfqpcxmVSE3t
         ZrQ4rXWC8v14StGshqIDPL2V5O6VLZZIidiwRXns6uI/PHJ7O+3PAcK1A1XySsYYLiuq
         /sGld8Uay09+0nfdlDuRGn+p5waw+zOBiYr/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9i2UaKM9g/AdwlOLX3q72dPfl3fDu2HSqiXz/urf2k=;
        b=yTXWwIqx1scV0NZElPgr/BA+l10obgP5wbM06pxTVPzqTeBSsGljfzK37xlbBBfH3v
         rqev+6u3TsYxWfFirBhuUI4822Lez23blILEXxtnknaY7exxCVWSV581zmbcvqFdPzc4
         Z5zLeDulVoqVx3BUFDvmUhvatoMOnsm8xQ2BFxjwkvDZ0I8qrwzv/6a8dK9daWY5KJeN
         Q0C8vMON59lTFmEKdPShCVT51rlMD3F5Z52pF9m0Sdl2oF0/7b8VKjbmOqp3AMkD6H0T
         NH12uyB7e9BncvlgolABDD1lN7qNEIrGc8+alqdjRxC0A78piM6PyqjSidiYZWdB+goH
         cNUA==
X-Gm-Message-State: AJIora/tQB6N7bZd+Vl4/qETA0xDMTjqRZVLsXvvvtEzlkXeHEW1sGUd
        Yxz83pECld+QfhqxJPp0xOicKA==
X-Google-Smtp-Source: AGRyM1vCjkA689i2XYRUWz7V9fwE8nRteMkFMgG1fZvk0aXO64dwkkuz3ZjGlHpXFpAb19FgEiKz6g==
X-Received: by 2002:a63:4c1d:0:b0:3fd:9833:cdd9 with SMTP id z29-20020a634c1d000000b003fd9833cdd9mr5210207pga.103.1655396454160;
        Thu, 16 Jun 2022 09:20:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mr11-20020a17090b238b00b001cd4989fec6sm3985726pjb.18.2022.06.16.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:20:53 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:20:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] efi: remove deprecated 'efivars' sysfs interface
Message-ID: <202206160919.360DB5F4@keescook>
References: <20220616124740.580708-1-ardb@kernel.org>
 <20220616124740.580708-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616124740.580708-3-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 16, 2022 at 02:47:40PM +0200, Ard Biesheuvel wrote:
> Commit 5d9db883761a ("efi: Add support for a UEFI variable filesystem")
> dated Oct 5, 2012, introduced a new efivarfs pseudo-filesystem to
> replace the efivars sysfs interface that was used up to that point to
> expose EFI variables to user space.
> 
> The main problem with the sysfs interface was that it only supported up
> to 1024 bytes of payload per file, whereas the underlying variables
> themselves are only bounded by a platform specific per-variable and
> global limit that is typically much higher than 1024 bytes.
> 
> The deprecated sysfs interface is only enabled on x86 and Itanium, other
> EFI enabled architectures only support the efivarfs pseudo-filesystem.

Does anything still use the sysfs interface? (e.g. do paths to it exist
in anything meaningful in, say, a Debian code search?)

-- 
Kees Cook
