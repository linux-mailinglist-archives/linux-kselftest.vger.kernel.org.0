Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4B42352B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 02:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhJFAkg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 20:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhJFAkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 20:40:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6EC061749;
        Tue,  5 Oct 2021 17:38:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so3232504pjb.5;
        Tue, 05 Oct 2021 17:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zzDDAIEMa5R+SxaD0Q9mpqRpAiQrzj5J68SVdWVvLvk=;
        b=KPzTWEyf5ITwfN2iPOyJJqgEDZ0zq2jo2PwRtDDm3jGazz7APt0yAIs7iPhW94OcOX
         fiSUJ1zAxfFSShSbCgJ1XzOMNYvXTz0tl46w7u81FJyX1wvvKlfEuDrbqrX03evm/XF8
         cClmSRIjs3gF2J0R245pbw/Jnur9ir+A84Rz/z2EZeV/B157Zy+/6GYSZGa4sMqQOBIM
         2MXCS9A/tiaED9DU8qM28NVb+eHwZ+skiIOHduWpI6i81nqvzy7zHfXKfr4fDLdlEXNQ
         Mq7svXDnobK9eIzQuKGTuc3scbdNX2+Y9v75CjTS93LTabDHA3oCEadvQFJsyvWjIK4K
         yKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zzDDAIEMa5R+SxaD0Q9mpqRpAiQrzj5J68SVdWVvLvk=;
        b=qRLFMGfgn2M5cvzLQDU7VmJ4LV743n6xjGNPNQ88Q+1sVlKi0ss7zvP2iYj3vIL+7o
         85HqoFyUcbKkQeBKtcfOSRTL5xfqIW2FzfOeA+/LH9jp644QRTMxvy9QRMs3EjPyE+fw
         52BiI3D8oan+j2D7+RpVhNpx8Y2PmhWrCtuqvmz0kePbw7gzIN0mLNHcqtsvInpkJxGR
         4PeVXlTVIGlM1yMkw+N5oK0MsjBY56a5dptSOofVoPLYp4KcMZQtWHA63mwnvrFOKZdg
         Zzs1NAi9JCJIhIutKu2GiF0/fzJOPpjcd9dvoCFq9+7J8RywzQzQ/qIs8xmJtHqcMaqn
         JI3g==
X-Gm-Message-State: AOAM530ScK2URKuPcSEa7B9PvwUDYzjLOHtQR02k8wRXhVvS9FRhWzfu
        kxpdkGCVZAcMLgHqw+eKyN8=
X-Google-Smtp-Source: ABdhPJwgssHhagBwcPahy8nzMMlV5HEwVfBVtzph6pKi3tiE3istXQLF9gnmbZtSRXIuY190DQWlDA==
X-Received: by 2002:a17:90a:73ce:: with SMTP id n14mr7405381pjk.215.1633480724266;
        Tue, 05 Oct 2021 17:38:44 -0700 (PDT)
Received: from sol (106-69-170-56.dyn.iinet.net.au. [106.69.170.56])
        by smtp.gmail.com with ESMTPSA id p21sm3222315pjo.26.2021.10.05.17.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:38:43 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:38:37 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] selftests/gpio: Fix gpio compiling error
Message-ID: <20211006003837.GB4410@sol>
References: <20210903012236.160858-1-lizhijian@cn.fujitsu.com>
 <CACRpkdaMYdc4WLcLFMKd3MyyKnQpdhP3Wxkx6YPoR+0YmH8ifw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaMYdc4WLcLFMKd3MyyKnQpdhP3Wxkx6YPoR+0YmH8ifw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 01, 2021 at 12:39:42AM +0200, Linus Walleij wrote:
> Hi Li,
> 
> thanks for your patch!
> 
> It needs to be sent directly to Bartosz Golaszewski so he can apply
> it to the GPIO tree.
> 
> Thanks!
> Linus Walleij
> 
> On Fri, Sep 3, 2021 at 3:18 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> >
> > [root@iaas-rpma gpio]# make
> > gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selftests/gpio/gpio-mockup-cdev
> > gpio-mockup-cdev.c: In function ‘request_line_v2’:
> > gpio-mockup-cdev.c:24:30: error: storage size of ‘req’ isn’t known
> >    24 |  struct gpio_v2_line_request req;
> >       |                              ^~~
> > gpio-mockup-cdev.c:32:14: error: ‘GPIO_V2_LINE_FLAG_OUTPUT’ undeclared (first use in this function); did you mean ‘GPIOLINE_FLAG_IS_OUT’?
> >    32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
> >       |              ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > gpio-mockup-cdev.c includes <linux/gpio.h> which could be provided by
> > kernel-headers package, and where it's expected to declare
> > GPIO_V2_LINE_FLAG_OUTPUT. However distros or developers will not always
> > install the same kernel-header as we are compiling.
> >
> > So we can tell compiler to search headers from linux tree simply like others,
> > such as sched.
> >
> > CC: Philip Li <philip.li@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >
> > ---
> > V2: add more details about the fix
> > ---
> >  tools/testing/selftests/gpio/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> > index 39f2bbe8dd3d..42ea7d2aa844 100644
> > --- a/tools/testing/selftests/gpio/Makefile
> > +++ b/tools/testing/selftests/gpio/Makefile
> > @@ -3,5 +3,6 @@
> >  TEST_PROGS := gpio-mockup.sh
> >  TEST_FILES := gpio-mockup-sysfs.sh
> >  TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
> > +CFLAGS += -I../../../../usr/include
> >

While this fixes the bug at hand, I think the root cause is that I
removed all the CFLAGS, assuming they were only relevant for the old
code and that lib.mk set sensible defaults (it doesn't), when in
fact most of it should've been retained, specifically:

CFLAGS += -O2 -g -Wall -I../../../../usr/include/

The -Wall turns up an uninitialised variable warning.
It is a false positive, but should be fixed regardless.

Any problems with me creating a series to do that, with the first patch
fixing the uninitialised variable and the second being this patch,
though with the full CFLAGS restored?

Cheers,
Kent.
