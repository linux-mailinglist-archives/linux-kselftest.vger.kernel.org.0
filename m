Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96130F9CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhBDRdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 12:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbhBDRbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 12:31:43 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EEEC06178A
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 09:30:56 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id g7so3333319iln.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO9O5fHDcDBQf/ZBVRiifFCMZr4KKcLpXohcqAwfJfw=;
        b=PTyvYIIk4fx541qK7FIyXAPIRQ4c21phaOdZmS/a4cTt3NEbs6xsEdIYtjPOPolPGq
         b+y1nB31fVwZr1JooPhTYrsGfF8SUrDbrkYv1mc/ApTnmdIdWixTveqLeqsM87JhPfxW
         8KT7ewa5wJHdtIPv+6Z+lY2FBK1SLowB3Rc55KB2hbfNdrwaE8MXMt2LCxAgb2RSF9zo
         7gECLq73dRUmaMhvSnhffz4nTt87Yu+x/ttUm1i3GtOrMvjPrxMs7Y078F4cSeNYKdKn
         ysgrSvUfO2Uga5aL9pvmmOb9rdvRVJnE5xG/b1dkfQdArGaMMFKM91Xpn693qeIbWLe7
         dW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO9O5fHDcDBQf/ZBVRiifFCMZr4KKcLpXohcqAwfJfw=;
        b=A7l02PCF8JI29TgwzBsrgigbY8qGl/+xeiSVadamqoFuj6uXi4Rzhpa0+t7MGp2hy/
         NGiR6CWSuE51EJDNQQrEnRIGd+Q+fTUiZx3PPDbd18/8ZHWZHnzZEijlZyqz+KWXkz90
         lKEd9C+g+oWrEa7LMOkmxvRlKd80/GqCwENCj1r+t+mJlRnpBauk76+NIdAp1d66GmmY
         77R+ZvZN8W0N8zI/QW+Kp/C7TF5zCoBpy7Q3DNj8q8jdyqQdy1zicDhgPBerZ45Kxd91
         0EeIbWDmcfHnPcdVgljI7/vG1VP5nyMhqR81GPerBDmogSEDbidaIKaiLgkJR7CJ7TpA
         +I0A==
X-Gm-Message-State: AOAM532SAZbaoB4B1t8Qsb9eEjWT39+J3Ar/Q8NyfPLysaslU9s5Z2tB
        e9T0MOevucd1Ca0+SfjdHP+U57Q9rmWBSxblKInQoUj0bqw=
X-Google-Smtp-Source: ABdhPJwkS28tebuC5lDvwBQ1SfugJjKZ+rvXGDuqSjIJnd5LVZFwEWNyv+2MyxNZtCs7BRaZ05FdLtILKE87EsodbfQ=
X-Received: by 2002:a92:dd82:: with SMTP id g2mr178595iln.194.1612459855230;
 Thu, 04 Feb 2021 09:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20210203234116.839819-2-dlatypov@google.com> <20210204071100.GB2696@kadam>
In-Reply-To: <20210204071100.GB2696@kadam>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 4 Feb 2021 09:30:43 -0800
Message-ID: <CAGS_qxpOWG_chZEAtKFPPbcfet=ZQYeo9_3k5tHSj4WHCfMToA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: add kunit.filter_glob cmdline option to filter suites
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, lkp@intel.com,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 3, 2021 at 11:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Daniel,
>
> url:    https://github.com/0day-ci/linux/commits/Daniel-Latypov/kunit-support-running-subsets-of-test-suites-from/20210204-074405
> base:   88bb507a74ea7d75fa49edd421eaa710a7d80598
> config: x86_64-randconfig-m001-20210202 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> lib/kunit/executor.c:110 kunit_run_all_tests() error: double free of 'suite_set.start'
>
> vim +110 lib/kunit/executor.c
>
> 8c0d884986ba22 Brendan Higgins 2020-08-04   96  int kunit_run_all_tests(void)
> aac35468ca20a3 Alan Maguire    2020-08-04   97  {
> aac35468ca20a3 Alan Maguire    2020-08-04   98          struct kunit_suite * const * const *suites;
> aac35468ca20a3 Alan Maguire    2020-08-04   99
> d5554dd78a454b Daniel Latypov  2021-02-03  100          struct suite_set suite_set = kunit_filter_suites();
> 45dcbb6f5ef78b Brendan Higgins 2020-08-04  101
> d5554dd78a454b Daniel Latypov  2021-02-03  102          kunit_print_tap_header(&suite_set);
> d5554dd78a454b Daniel Latypov  2021-02-03  103
> d5554dd78a454b Daniel Latypov  2021-02-03  104          for (suites = suite_set.start; suites < suite_set.end; suites++)
> aac35468ca20a3 Alan Maguire    2020-08-04  105                  __kunit_test_suites_init(*suites);
> aac35468ca20a3 Alan Maguire    2020-08-04  106
> d5554dd78a454b Daniel Latypov  2021-02-03  107          if (filter_glob) { /* a copy was made of each array */
> d5554dd78a454b Daniel Latypov  2021-02-03  108                  for (suites = suite_set.start; suites < suite_set.end; suites++)
>                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^
> This will free "suite_set.start" will in the first iteration through the
> loop

Ah, the loop is supposed to contain `kfree(*suites)`.
I'll fix the patch and resend.

I'm not familiar with conventions but it feels like adding Reported-by
on the amended patch would almost imply the report suggested the need
for the ability to filter suites.
So I'll add an informal attribution in the cover letter.

Thanks!

>
> d5554dd78a454b Daniel Latypov  2021-02-03  109                          kfree(suites);
> d5554dd78a454b Daniel Latypov  2021-02-03 @110                  kfree(suite_set.start);
>                                                                       ^^^^^^^^^^^^^^^
> and then double free it.
>
> d5554dd78a454b Daniel Latypov  2021-02-03  111          }
> d5554dd78a454b Daniel Latypov  2021-02-03  112
> aac35468ca20a3 Alan Maguire    2020-08-04  113          return 0;
> aac35468ca20a3 Alan Maguire    2020-08-04  114  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
