Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1C567EB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGFGin (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 02:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFGin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 02:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E12167CA;
        Tue,  5 Jul 2022 23:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D2361D84;
        Wed,  6 Jul 2022 06:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39758C3411C;
        Wed,  6 Jul 2022 06:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657089519;
        bh=sIhADMY3Ddiwqu/4zmrMxVcxGylkvp6d6ylGolHrEgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv8K6kxrFf7OTnxoy7BJoYTK27INCS/dp6gsLZU+mDz0eG+7Cfsq3vGkwutzzXz77
         jOM4u9OlUDKwA1RaRr22Fe34PTWi+7e+iuBGypoSgP3RRd1neORWeqv6u+fz4YMohn
         QmQwowyzodvSl9o04hklMK59Etq0P85n2f5nOg/4=
Date:   Wed, 6 Jul 2022 08:38:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com,
        keescook@chromium.org
Subject: Re: [PATCH v9 9/9] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <YsUt7X6HLIY6wt1Z@kroah.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-10-martin.fernandez@eclypsium.com>
 <YsL6XCWmgiIeLKJ9@kroah.com>
 <CAKgze5aD3vJwMQwzJ1syzAKvSvPgYDFvtapDea_zBki5taoFEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5aD3vJwMQwzJ1syzAKvSvPgYDFvtapDea_zBki5taoFEQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 05, 2022 at 02:35:18PM -0300, Martin Fernandez wrote:
> On 7/4/22, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, Jul 04, 2022 at 10:58:33AM -0300, Martin Fernandez wrote:
> >> Show in each node in sysfs if its memory is able to do be encrypted by
> >> the CPU; on EFI systems: if all its memory is marked with
> >> EFI_MEMORY_CPU_CRYPTO in the EFI memory map.
> >>
> >> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
> >>  drivers/base/node.c                          | 10 ++++++++++
> >>  2 files changed, 20 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-devices-node
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-devices-node
> >> b/Documentation/ABI/testing/sysfs-devices-node
> >> new file mode 100644
> >> index 000000000000..0e95420bd7c5
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-devices-node
> >> @@ -0,0 +1,10 @@
> >> +What:		/sys/devices/system/node/nodeX/crypto_capable
> >> +Date:		April 2022
> >> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> >> +Users:		fwupd (https://fwupd.org)
> >> +Description:
> >> +		This value is 1 if all system memory in this node is
> >> +		capable of being protected with the CPU's memory
> >> +		cryptographic capabilities.  It is 0 otherwise.
> >> +		On EFI systems the node will be marked with
> >> +		EFI_MEMORY_CPU_CRYPTO.
> >
> > Where will such a node be "marked"?  I do not understand this last
> > sentence, sorry, can you please reword this?
> 
> What I meant is that if all the memory regions in a given node are
> flagged with EFI_MEMORY_CPU_CRYPTO then that file will hold a 1.
> 
> Maybe it's a little confusing if you don't know what
> EFI_MEMORY_CPU_CRYPTO is.
> 
> > And why is EFI an issue here at all?
> 
> Checking for EFI_MEMORY_CPU_CRYPTO is the way to know if a memory
> region is able to be encrypted by the CPU on EFI platforms. It's not
> really an issue and it's currently the only implementation for this
> file.
> 
> Is it clearer here?
> 
>   This value is 1 if the memory in this node is capable of being
>   protected with the CPU's memory cryptographic capabilities.  It is 0
>   otherwise.
>   On EFI systems this means that all the memory regions of the node
>   have the EFI_MEMORY_CPU_CRYPTO attribute set.

Much better, thanks.

greg k-h
