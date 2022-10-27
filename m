Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154EE60F2F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 10:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiJ0I5l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiJ0I5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 04:57:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72560B03E3;
        Thu, 27 Oct 2022 01:57:38 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7CC11EC0304;
        Thu, 27 Oct 2022 10:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666861056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+Dn95uGpUyy1KhkBzIVhKQkCCrUE6w8O6ZoG0Tkf6u8=;
        b=WojIgMNXOqeXZOqiCZOflOU3lezPYEHMfd6YrCKkeVZv++P42OddnBZvTyqtS1XBWzys7n
        jctQye88xdiJWKoUKNVVce4O2CtcNIA5rPtDcPUKWK7HEmREnJvOrey6nTqqF9U7ME68CA
        hhGZInPyavGa4AN+nEjZVVpKL0AvCJI=
Date:   Thu, 27 Oct 2022 10:57:32 +0200
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
Message-ID: <Y1pH/DuYJeo7Kyo5@zn.tnic>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <Y0hrhzprPFTK+VWV@zn.tnic>
 <CAKgze5ajp-z0+F+8Qo2z=834=i=HNa5=s54MLyrk16wQVnxCzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgze5ajp-z0+F+8Qo2z=834=i=HNa5=s54MLyrk16wQVnxCzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 13, 2022 at 06:00:58PM -0300, Martin Fernandez wrote:
> That's bad, because it would be nice if that attribute only depended
> on the hardware and not on some setting.

Why would that be bad?

You want to be able to disable encryption for whatever reason sometimes.

> The plan of this patch was, as you mentioned just to report
> EFI_MEMORY_CPU_CRYPTO in a per node level.
> 
> Now, I think I will need to check for tme/sme and only if those are
> active then show the file in sysfs, otherwise not show it at all,
> because it would be misleading. Any other idea?

Well, I still think this is not going to work in all cases. SME/TME can
be enabled but the kernel can go - and for whatever reason - map a bunch
of memory unencrypted.

So I don't know what the goal of this fwupd checking whether users have
configured memory encryption properly is. It might end up giving that
false sense of security...

> You mean that EFI_MEMORY_CPU_CRYPTO means nothing on an AMD system?

I mean, you still can disable memory encryption.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
