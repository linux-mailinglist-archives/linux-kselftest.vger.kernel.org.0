Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2DE60FC0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 17:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiJ0PeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiJ0PeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 11:34:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DEE188590;
        Thu, 27 Oct 2022 08:34:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9004B1EC02FE;
        Thu, 27 Oct 2022 17:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666884843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o5hkvVaAtguyvk+k1KB1ZUt++tlUO5KVc3yFFqeqwX8=;
        b=jqoWyf9qttnPb1+ejaXSkAQOCfFzrggbp28/nlN8EkIbUOPw29RsgsiZ/z2ZG3u7VebuUn
        MU6EhhvMZF3MT30dMrQuwvBB4su92pEFWDht57T07pN0s+yx1x8dRH6ocnyL7EltL/BRbd
        UR76zX2oet+PZlDCIfKHc5VatyLLel8=
Date:   Thu, 27 Oct 2022 17:33:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
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
Message-ID: <Y1qk56DGw00IyjU0@zn.tnic>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <Y0hrhzprPFTK+VWV@zn.tnic>
 <CAKgze5ajp-z0+F+8Qo2z=834=i=HNa5=s54MLyrk16wQVnxCzQ@mail.gmail.com>
 <Y1pH/DuYJeo7Kyo5@zn.tnic>
 <6758af9b-1110-ad5a-3961-e256d5c8d576@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6758af9b-1110-ad5a-3961-e256d5c8d576@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 08:21:02AM -0700, Dave Hansen wrote:
> On 10/27/22 01:57, Borislav Petkov wrote:
> > Well, I still think this is not going to work in all cases. SME/TME can
> > be enabled but the kernel can go - and for whatever reason - map a bunch
> > of memory unencrypted.
> 
> For TME on Intel systems, there's no way to make it unencrypted.  The
> memory controller is doing all the encryption behind the back of the OS
> and even devices that are doing DMA.  Nothing outside of the memory
> controller really knows or cares that encryption is happening.

Ok, Tom just confirmed that AMD's TSME thing also encrypts all memory.

So I guess the code should check for TME or TSME. If those are set, then
you can assume that all memory is encrypted.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
