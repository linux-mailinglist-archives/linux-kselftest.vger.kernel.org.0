Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C105FE2EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJMTsk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJMTsf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 15:48:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2518B497;
        Thu, 13 Oct 2022 12:48:33 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e733329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e733:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70521EC0662;
        Thu, 13 Oct 2022 21:48:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665690507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AQTsN58dqUBa4kccfsq8CI7L28beVehD34GLLpg/uVc=;
        b=AmiWO7JHwt9MRtIisXFnueA6sDdHqexmuRNDepSGd+d93yeoUVOPU4f1DbvEWzz7EjDfra
        4FPPbxLDsT41p+Zh/zUV3Zn6bh1uFDGcPjPGrX2DMGu1JJf8RZbLVT0gx8e6j5cUOiDUhL
        z+IYAah5BFbT7jNkEze8Rktk+M2UcMo=
Date:   Thu, 13 Oct 2022 21:48:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v9 0/9] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <Y0hrhzprPFTK+VWV@zn.tnic>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 04, 2022 at 10:58:24AM -0300, Martin Fernandez wrote:
> If all nodes are capable of encryption and if the system have tme/sme
> on we can pretty confidently say that the device is actively
> encrypting all its memory.

Wait, what?

If all memory is crypto capable and I boot with mem_encrypt=off, then
the device is certainly not encrypting any memory.

dhansen says TME cannot be controlled this way and if you turn it off in
the BIOS, EFI_MEMORY_CPU_CRYPTO attr should not be set either. But that
marking won't work on AMD.

You really need to be able to check whether memory encryption is also
enabled.

And I believe I've said this before but even if encryption is on, it is
never "all its memory": the machine can decide to decrypt a page or a
bunch of them for whatever reason. And then they're plaintext.

> It's planned to make this check part of an specification that can be
> passed to people purchasing hardware

How is that supposed to work?

People would boot a Linux on that hardware and fwupd would tell them
whether it can encrypt memory or not?

But if that were the only use case, why can't EFI simply say that in its
fancy GUI?

Because all the kernel seems to be doing here is parrot further
EFI_MEMORY_CPU_CRYPTO.

And that attribute gets set by EFI so it goes and picks apart whether
the underlying hw can encrypt memory. So EFI could report it too.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
