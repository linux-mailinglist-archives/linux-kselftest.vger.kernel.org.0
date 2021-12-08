Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD946D158
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 11:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhLHKwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 05:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhLHKwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 05:52:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB4C061746;
        Wed,  8 Dec 2021 02:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2936B82089;
        Wed,  8 Dec 2021 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54905C00446;
        Wed,  8 Dec 2021 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638960521;
        bh=aZCHSWMXNx/yJOGQvjgTK6Bw1r7H5PDORW4SOKvg2oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXS2a4SQPk7Vq/PRar4BbPA+s9HBID1MewzdG9Fgimuc6blGehYijv+j05LMYLj8D
         fV1+pxfH1xA8EC93p5HYq2+00NJBzGtj+0Ew4Uvu9SajDp5AWEvpxhNXju2VEKG0ve
         o1LnHkuNaArHN5gSa8wEbCXIhuvERe9CbbIAlGizGNmV9R2qlbHDiHYvMtqiMCySvF
         LIAWt1YrvHoLi5vjfO2kBDu20EL9yOBo2uMOgCuCT9Od9zjVixqBn6BQYBDZ917d6X
         AKv26JZzFtx+5QKSQ6t31tcALyIBUJvIjGwGRMG7fqfY90Zi/9QAh/9t3pn18KjoLZ
         AexSGNgcVAxqA==
Date:   Wed, 8 Dec 2021 12:48:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        hdegoede@redhat.com, bhelgaas@google.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbCNhAtiueFZ/hkJ@unreal>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBtjSNz8z34czeN@unreal>
 <YbBwOb6JvWkT3JWI@kroah.com>
 <YbB29BaOWibImGf5@unreal>
 <YbCFkQZvIDLtPJTR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbCFkQZvIDLtPJTR@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 08, 2021 at 12:14:41PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 08, 2021 at 11:12:20AM +0200, Leon Romanovsky wrote:
> > On Wed, Dec 08, 2021 at 09:43:37AM +0100, Greg KH wrote:
> 
> ...
> 
> > The idea that you have two APIs which do the same thing, one is
> > obfuscated version of another.
> > 
> > If you don't want from people to use driver core function and structures,
> > you shouldn't expose them in global headers.
> 
> For all these APIs the rationale is very simple. If you have callback that
> takes a pointer to the container (*), you better use the APIs related to
> this container (no need to have an explicit dereferencing). Otherwise you
> use dev_*() APIs (when it's pointer to the pure struct device).
> 
> The value is to have coherent APIs around struct device containers.
> 
> *) under container here I assume the data structure that has the embedded
>    struct device in it.

Thanks

> 
 -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
