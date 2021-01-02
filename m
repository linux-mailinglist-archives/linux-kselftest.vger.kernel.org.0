Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1952E8792
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbhABOIE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jan 2021 09:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbhABOID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jan 2021 09:08:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B094C061573;
        Sat,  2 Jan 2021 06:07:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so15862203pgl.10;
        Sat, 02 Jan 2021 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zODgmMsUo4/IIJyoPsklfStQhpL3NQIU7j98XxEPRak=;
        b=X+82N45w2/VfcpYrHtsCrFjjjQTFyiJvLbtJOnINmulPaxl65y5Bjq4hM7A6N7AVKM
         elCiZsNrN3rzPHqhOA7egWNn2dSA4lnKOjRz39hiixUWM/dCfwm/eIwuCiT5Lr8McrGu
         Anrk1JdZCVH0JkN5faR+f/naq9CTKbwRi9sTaQEmjxHkFj1YGq/zpTptWztP9yZFBCnU
         5IinbcZ0xDAaM6f9G+aQkGyjWmMckUvd+ooOdk6ZB5fRUSSP3bYClk0HI/KeXqFOdfHc
         ueDrG0sm0AO1nQjkInfBk+1OsjvpgWW+NiyLCNjlv08WMU9Fh8LAwyPC1BXTKFugEtPO
         Cq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zODgmMsUo4/IIJyoPsklfStQhpL3NQIU7j98XxEPRak=;
        b=d11pcQBwx6KUOymFMFGZPndhqrCEV2cGA3ptF1KlgcwewVgzIfO875itkrgHN09QpN
         1zv/3lSNs23wAGmePxemeGqyuhCA1XFJ0qelACNUg1bQjtFTIjSLwtHGm4cDP1ezwsTb
         IDYCvqOxyOy3MZGZFRd20pERB7EiiCzRjloo2Dl0+BjEVoiRCLmBvF3BNJpZdcIn9IA0
         lF7XnX5ZwLyFUSBi9EPb+tnv0z+NO8KHPG59XYSUezogLVw1xCRgcHkJUH35+1QH0RNe
         1VCe2P+2qAm0us1sEy865832ob7j1ltwaf0qpBdy0YOq7T2nLglivnzMS/4qywP5tj+m
         Yf5g==
X-Gm-Message-State: AOAM5335TZw9xPW9wsT7AY7OPFX+0KMxUfizfCfUuMcbneXIR4b2Kjwe
        j3YWc44oE/3NfJNMA0yGTutpM+FIB10Cjg==
X-Google-Smtp-Source: ABdhPJz5H/NWMPUOymjzil2ZXW5N+axc2TBrCqPhT8eA+XVzWX2LPPOrwDfjKXHvRhK0ARh33SfNjQ==
X-Received: by 2002:a62:fc4f:0:b029:19d:d060:27ca with SMTP id e76-20020a62fc4f0000b029019dd06027camr35332157pfh.66.1609596442480;
        Sat, 02 Jan 2021 06:07:22 -0800 (PST)
Received: from sol (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id jx4sm15729119pjb.24.2021.01.02.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 06:07:21 -0800 (PST)
Date:   Sat, 2 Jan 2021 22:07:16 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bamv2005@gmail.com" <bamv2005@gmail.com>
Subject: Re: [PATCH 1/7] selftests: gpio: rework and simplify test
 implementation
Message-ID: <20210102140716.GA1624076@sol>
References: <20210102022949.92304-1-warthog618@gmail.com>
 <20210102022949.92304-2-warthog618@gmail.com>
 <CAHp75VdPdRRm+YQ-FzcFV5=XcNL6dXHDROutkgUbPLbj4xa8SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdPdRRm+YQ-FzcFV5=XcNL6dXHDROutkgUbPLbj4xa8SQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 02, 2021 at 03:52:32PM +0200, Andy Shevchenko wrote:
> On Saturday, January 2, 2021, Kent Gibson <warthog618@gmail.com> wrote:
> 
> > The GPIO mockup selftests are overly complicated with separate
> > implementations of the tests for sysfs and cdev uAPI, and with the cdev
> > implementation being dependent on tools/gpio and libmount.
> >
> > Rework the test implementation to provide a common test suite with a
> > simplified pluggable uAPI interface.  The cdev implementation utilises
> > the GPIO uAPI directly to remove the dependence on tools/gpio.
> > The simplified uAPI interface removes the need for any file system mount
> > checks in C, and so removes the dependence on libmount.
> >
> > The rework also fixes the sysfs test implementation which has been broken
> > since the device created in the multiple gpiochip case was split into
> > separate devices.
> >
> >
> 
> I briefly looked at code in shell below... there are places to improve
> (useless use of: cat, test, negation, etc).
> 

My shell is clearly pretty poor, so I would really appreciate a pointer
to an example of each, and I'll then hunt down the rest.

Thanks,
Kent.
