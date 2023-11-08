Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736847E5C82
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjKHRjb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 12:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjKHRja (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 12:39:30 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC51FFB
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 09:39:28 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-586ae6edf77so3367518eaf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 09:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699465167; x=1700069967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=fwUNLQwAxEmRN4Jb+IeGWHIvxCMg/UXv9u79Y5OV97aXClbHKtCWRPiR4qLkxomCKQ
         kn4NbGXS/gztBLtFrXRE355YY00tM2FT78YYu54T5Z+bx6Dxz3QZ+iO4c6jarkkvl/kV
         jvK5+zbAPpyFMum4p5tDhy1Sy3qkXoj7ZqGCLPFXghv0XIij4UJSQ9Yl3aL0kOhczBRI
         5zBMOyCysmPJge/4BTEANOoo1/XHnu28GT1+pleLanducwiv3iq0bdFhJDStG21XPzUV
         vTZKhqFl1tYADNSU9FjEiX4FRifXzn32CThTdkYRfC1crhgVowyUWp681+SOvZPW2onf
         2nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699465167; x=1700069967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fez7d2oD0jqA877WtYGemcz1mIG1xNotv9HuUKl17lg=;
        b=Y9bzTLXOS2sg3g/3viISSTUcaoUaIo75688ncbG37PbYkGVqdLXqxda7BMrNm6g3c/
         x9fOCet0tRI8501tJ8gUMYMAumljGI7Ha3n+cC8KF67bJfgj7geIvGgyNdZnPuSjFSsa
         +PV9Dks5H6pjhPOCaIXPWIHZ8y9Z0C5wI69BIEzmroch/Dv7axXf6ob9oFEjE8nEahF7
         OfCDYum0mGiH67ZM2M17uf9XKdSt1RArq8l6+Y+PxEJVOkgzXIYhuxB4d3JrLYJPTCi7
         vSFD5OqjuTCSgT6/IICO0rURPs/clMh5cUP5vEbwgg9ZqVpzjEmXY6giSDxjkR7D9XF4
         cJpA==
X-Gm-Message-State: AOJu0Yyeq6yU9YFLTC8trQjZNrEEIooOY/De1EP7R57ju5f4HF0Koc+b
        km8Lgmxc4W+zrjqsLdc9XVBIPg==
X-Google-Smtp-Source: AGHT+IFej9NZgQ/+2LjPp+xoxu9RiYGW6gMR81sDvfm8bHBPH21cB7z0X7CwypR1KBJQgpyCkOlg8g==
X-Received: by 2002:a4a:e282:0:b0:57b:de27:28ed with SMTP id k2-20020a4ae282000000b0057bde2728edmr1987087oot.6.1699465167350;
        Wed, 08 Nov 2023 09:39:27 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id v15-20020a4aad8f000000b005737ca61829sm940312oom.13.2023.11.08.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:39:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r0mWS-001gwa-G6;
        Wed, 08 Nov 2023 13:39:24 -0400
Date:   Wed, 8 Nov 2023 13:39:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231108173924.GF4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231107175405.GD4634@ziepe.ca>
 <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 08, 2023 at 08:53:00AM +0000, Tian, Kevin wrote:

> > There are many events related to object in guest memory or controlled
> > by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
> > the emulation is not working well.
> 
> so that's the category of unrecoverable faults?

I haven't looked exhaustively but I do have the impression that the
only recoverable fault is the 'page not present' one.

> btw I can understand C_BAD_CD given it's walked by the physical SMMU
> in nested configuration. But presumably STE is created by the smmu
> driver itself then why would there be an error to be relayed for
> guest STE?

If the guest programs a bad STE it should still generate a C_BAD_STE
even if the mediation SW could theoretically sanitize it (but sanitize
it to what? BLOCKED?). Since we have to forward things like C_BAD_CD
and others we may as well just drop an invalid STE and forward the
event like real HW.

> > > but I didn't get the last piece. If those domains are created by kernel
> > > drivers why would they require a uAPI for userspace to specify fault
> > > capable?
> > 
> > Not to userspace, but a kapi to request a fault capable domain and to
> > supply the fault handler. Eg:
> > 
> >  iommu_domain_alloc_faultable(dev, handler);
> 
> Does it affect SVA too?

Inside the driver the SVA should be constructed out of the same fault
handling infrastructure, but a SVA domain allocation should have a
different allocation function.

Jason
