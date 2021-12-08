Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3047C46CFDA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhLHJRZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 04:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhLHJRY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 04:17:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE35C0617A1
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 01:13:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so2898166wrb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6QmATgtA2GhRHoLOX72VCjAGoOgaVTf/7uAV72vhA2Y=;
        b=xVMypFPXZKCAS6akWukiKlAVGxtvpe4Ut+bFoLvZcUYZ2DFkJ0KZebWE5XHdIRL6e0
         wFaKN7x5xB65VhsNgeK24VEYYTU5Z+Xftgo7r+hNUDw5g2+GqkQMM5YGrzvYMc58vfJq
         XeSxaLTJ6yfgVrPwImb3U+wBkquN9xat+D+GMMDe3PXMJdhZsjQyZOq5Rmlnq9XmHS6J
         C0kCt8JWIvmjgtgF3AzCN9UfGvIbyREt3Y1lEo3sK5KGPeIypvuG9IEecqrl5Up9e4GL
         kS5wROhNtn+6I2hw1dB4cTdRq/e3Se2UxVosHSdpkwmCy+uOf3HOA1MILFezYT6DN/LN
         FBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6QmATgtA2GhRHoLOX72VCjAGoOgaVTf/7uAV72vhA2Y=;
        b=t9fOcMDYC/ElwZD8x2J6MkP6ElHyjPoWLzpVAVPjI4P9ehJPZW3cQvtsB9+YH8eVSC
         /O9FQYMu/tMtf2tcqbkw3rE+vB89jIjwOJaKG+dUNmy3KsClxeRNoGByOaxxUN9KGjud
         l4wh9hpCrmJroaDfXXy2BempT+rPBBp7jph1BteDfS7L+bf2WNx+Mu18CgNdkV/tT0sf
         UQX20qP4AgIEApLlKOV8FdiaL7aLSFpMUW5CEUgS0RCf2Z8oFtT5clxJPf+j0sjvQaT5
         0I8KGpfK3RaCTrlGHPoB4e2hl8kzx6m4GJAhBLTL8MqD/Ax1V6WDBt4Yqc+seDn0ggNQ
         kUuA==
X-Gm-Message-State: AOAM533UjQ3t3IyJ1UqVV4ALj30IlHckmvanxvR7jLbzAZvPzCsGkwM4
        R2vVLcoM/257nIedBTd5tdHGVw==
X-Google-Smtp-Source: ABdhPJw8pmx7GfrpF9j9+pWmkiEwIEkAaDCwTKdGN1dsLM1IQgMhSDxAmI4Exq8zD8cfXfIzTqlj4g==
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr19931030wrd.296.1638954831541;
        Wed, 08 Dec 2021 01:13:51 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id j40sm5211897wms.19.2021.12.08.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 01:13:51 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:13:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbB3TbU5dfPse9LU@google.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
 <YbBwSV2IwDHNUrFH@google.com>
 <YbBxPPPaQwlcgz/c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbBxPPPaQwlcgz/c@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 08 Dec 2021, Greg KH wrote:

> On Wed, Dec 08, 2021 at 08:43:53AM +0000, Lee Jones wrote:
> > On Wed, 08 Dec 2021, Greg KH wrote:
> > 
> > > On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > > > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > > > Adds get/set driver data helpers for auxiliary devices.
> > > > > 
> > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > > > ---
> > > > > V2
> > > > >   - No changes
> > > > > 
> > > > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > I would really like to see an explanation why such obfuscation is really
> > > > needed. dev_*_drvdata() is a standard way to access driver data.
> > 
> > I wouldn't call it obfuscation, but it does looks like abstraction for
> > the sake of abstraction, which I usually push back on.  What are the
> > technical benefits over using the dev_*() variant?
> 
> See my response at:
> 	https://lore.kernel.org/r/YbBwOb6JvWkT3JWI@kroah.com
> for why it is a good thing to do.

I saw this after I'd sent my query.

> In short, driver authors should not have to worry about mixing
> bus-specific and low-level driver core functions.

Okay, that makes sense.

I guess my view abstraction for the sake of it is slightly higher
level as I vehemently dislike it when driver-set writers create their
own APIs, such as; (just off the top of my head, not a real example)
cros_get_data() or cros_write() which are usually abstractions of top
level APIs like platform_get_data() and regmap_write() respectively.

Abstracting at *real* API level does seem like the right thing to do.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
