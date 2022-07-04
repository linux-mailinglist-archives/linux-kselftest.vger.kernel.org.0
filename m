Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8016A5658AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiGDOeL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiGDOeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 10:34:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C6FF9;
        Mon,  4 Jul 2022 07:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4D8DB81049;
        Mon,  4 Jul 2022 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF35C3411E;
        Mon,  4 Jul 2022 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656945247;
        bh=4vKkwLFsxCCUt/DAhoYCumD0GwJFvW4QXmj93+cMZW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSSMjnRvHEhLaq2SqI13XHvyeKm9xgdB7Rxg7uUjG1APSl1ifH5mMeUs3cFqKYAER
         vL1Me2dmsgCYsZp67z7BMkRNDdq6YmK1JuGCrUiG5l+2OwtSKNni8hQTYRK5ku1rCG
         CwIwzYKeytu08BvL1qPdqWl9G5LRbS+1nNMy9hjg=
Date:   Mon, 4 Jul 2022 16:34:04 +0200
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
Message-ID: <YsL6XCWmgiIeLKJ9@kroah.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-10-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704135833.1496303-10-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 04, 2022 at 10:58:33AM -0300, Martin Fernandez wrote:
> Show in each node in sysfs if its memory is able to do be encrypted by
> the CPU; on EFI systems: if all its memory is marked with
> EFI_MEMORY_CPU_CRYPTO in the EFI memory map.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
>  drivers/base/node.c                          | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-node
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
> new file mode 100644
> index 000000000000..0e95420bd7c5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-node
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/node/nodeX/crypto_capable
> +Date:		April 2022
> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> +Users:		fwupd (https://fwupd.org)
> +Description:
> +		This value is 1 if all system memory in this node is
> +		capable of being protected with the CPU's memory
> +		cryptographic capabilities.  It is 0 otherwise.
> +		On EFI systems the node will be marked with
> +		EFI_MEMORY_CPU_CRYPTO.

Where will such a node be "marked"?  I do not understand this last
sentence, sorry, can you please reword this?

And why is EFI an issue here at all?

thanks,

greg k-h
