Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0D22AF69
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgGWMdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jul 2020 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgGWMdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:18 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744AC0619DC
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jul 2020 05:33:18 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id q16so561802ybk.6
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jul 2020 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFgfTkrSPliJdcE2ZgsQWMPTGBVr0aakFg2hA0SWopU=;
        b=UEBq0g6zVMlm+ZOvqr+tCAlWDUA/6n2VoQROx1IZzoTys38IcwrQeOz+GShfaQzW+J
         To5Bmc/Zh7gMKe+cCUyDCqT0y3en2zd0IK7nUUAkONV9Mb0l0kObjCF9GUlkRAudUBhB
         HY/ksvKxacwrGibAXXusQ9lTg2v0qGKwWQ0/C+FS/FqdBwHdECBWUf37nyCrVtjtyq6i
         +vVvOqRZYus8UJRW+lDKpj8v7GVkGvAJoA9I1Lv/lXXf0CUAs1GOqfb6nvbye/plV4Bq
         PtASg15+JaR18XbvVx+Q00QoPJZi2CBDabxZF+Xj6xVM+fDz0gYI3vfatj5joQYchIDI
         2Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFgfTkrSPliJdcE2ZgsQWMPTGBVr0aakFg2hA0SWopU=;
        b=lM4jGH6xWbBNZo3gxBiBHzleTDb4jseXsFJotnK6E5cAjORrNUrzdPP6PwdsM9KBeW
         gnaMgd+p6jVvzA7Zvy2mTUjh9xIiHkmOn43f0aqNYy+4KeoC4tCPHE/Bz03LLrz/BToW
         sUuFhMRlQQaDwYGyWKGhTn1Z2/a0TsjvbBLazvof6T7yWsaLdhzyFwW/RI5PnFBr4MQs
         5j4c1YZMk+YG51r8tF/ndilwVHcgSHFd7NGs/juB2Jcv/fMtZ3PpR1go6d6gtNaLEHse
         NOz2EsJHwMPPFbHt1aUAKdsAwIz+Buc6QE0t39LCVtJR7N134GeYNM8HTSfVGnFltjio
         pK+A==
X-Gm-Message-State: AOAM532OsYBmE+/ZYzbvIxt5DsvkgncVz5LkzxSNg/VTzMjAnSEgbVsi
        LT0P0j4a/x3O7oSIhsuAaDPaSYX4QHb+12IawSK7TOHATc6bVbBe
X-Google-Smtp-Source: ABdhPJyhPrvkl3wnqOJZR+KE4dXDzdfdmBF8NSWdbQMOAwRHnH9rqpSXNAdzCEMhnvUlDuTGwR1GdEdZ4pIM0+kNO2A=
X-Received: by 2002:a25:cfd2:: with SMTP id f201mr6479953ybg.286.1595507597470;
 Thu, 23 Jul 2020 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200723000807.171940-1-vitor@massaru.org> <20200723080444.GE3703480@smile.fi.intel.com>
In-Reply-To: <20200723080444.GE3703480@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 23 Jul 2020 09:32:41 -0300
Message-ID: <CADQ6JjVujdtaG7HxOLxg=vuGjFt--sZ9+6QzY0ZXQuOVBDn+7Q@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: Convert test_sort to KUnit test
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, fkostenzer@live.at, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 5:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 22, 2020 at 09:08:07PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the test_sort.c to KUnit test.
> >
> > Please apply this commit first (linux-kselftest/kunit-fixes):
> > 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
>
> ...
>
> >  lib/{test_sort.c => sort_kunit.c} | 31 +++++++++++++++----------------
>
> Is it established practice to put kunit as a suffix?

Not yet. https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u

Thanks
