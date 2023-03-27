Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78A6C9B6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjC0Gae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 02:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjC0Gac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 02:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0D3A9A;
        Sun, 26 Mar 2023 23:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B50CB60FC6;
        Mon, 27 Mar 2023 06:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607DEC433EF;
        Mon, 27 Mar 2023 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679898626;
        bh=ju/d3q0v2bf5FDc4EUiRscamg6Isw0kzmX3UyI6cgCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZYv3p4//3I4ZFnwKiWQ8XJHI7UWl6RiSftpivRsW+GLQ7F2V5s4Ez43RwaO7oRc26
         uy+SwxyfKE9r3MNjY7t/6uaTxU9DIfXAUpMqXTlcEHOZEQbvULPcwGA4UVtr3L0GVV
         AP1JnveRLuIfkOxa6DnQ83R0cIG/DOS+nV90ukKE=
Date:   Mon, 27 Mar 2023 08:30:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] virt: tdx-guest: Add Quote generation support
Message-ID: <ZCE4AJBX8zM53XCM@kroah.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230326062039.341479-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ZB/njYsTTwgTtAeA@kroah.com>
 <d09f30f5-23da-4fb6-141e-3dd9483217c7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09f30f5-23da-4fb6-141e-3dd9483217c7@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 26, 2023 at 12:06:26PM -0700, Sathyanarayanan Kuppuswamy wrote:
> If usage of DMA APIs / platform device is not acceptable for this use case,

It is not ok to use a platform device for this because you just do not
have a platform device for it, don't make one up out of thin air please,
as that really doesn't even have the correct bindings to the DMA memory
that you want here.

> an alternative approach is to allocate a fixed number of shared buffers during
> the TDX guest driver probe and use it for GetQuote requests. Although it would
> limit the amount of memory we can use for GetQuote requests at a time and also
> reserve a chunk of memory during the init() time, I think it is an acceptable
> tradeoff when compared to alternative choices. The AMD SEV guest driver also
> adopts the similar approach. Please let me know if this approach is acceptable.

This sounds like a better approach.

thanks,

greg k-h
