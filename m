Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335F32543A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgH0KXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgH0KXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 06:23:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2712EC061264
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 03:23:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so4834875wrl.4
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0vdvNJDaA2R7UXSkN77bjSvK1qeX8JyEc0qDlajxxQs=;
        b=rL9s269pC6oLPkDI3tfzuJ3tZopAeQgT12ll7VhkWMrh63n8tMcGzsY2JpzvUyY+2V
         BnJoTVPMzTTKxL2ZYBqaJb/jvPfj/1afWfg89ZMHpUb3Svwd6G3PRT3EnIhj9OvUMJ54
         ookJUfCmWVwiMG/53gmkqcqX5C6OZjjwKAMZzpAvBtwBJ86bjd7HemRjxRpSGfSLmA9i
         qXBv62SNbammdu2urTkc3+B87Y8ZtDUgCFBF7f6yzegW6wqTA5QKgw2GxtxNTbWOZDaB
         9Caq/5XYLKnqKdOMzAiYdzHptBi95kgEr3utkviH2i+wTx5Qa3VoZmWOBbPe1L/dNfiI
         VaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vdvNJDaA2R7UXSkN77bjSvK1qeX8JyEc0qDlajxxQs=;
        b=qyeekeySNNAyTbhPHZY01MUZLwqidXN9s5r64fbPDRREYnmp/aAGztmPIZV8tebO/J
         mTR+qBGd5vq4qzupakLiFVrldtw9DnOcMhR+kW+lsX/51LQKpKCRDN6DpiOaGt1T6FRj
         u/qJykUk3W7ss7AXjzPAkJU/uG/dp3eimEDl5uTWDPbZQfHFPieqr6YV5a2OW4movfIn
         GzXgdW+IXR9xVEYXUdls+bqY1GuxVIFE80fax5kV2PQ7pQTfnnsjk78lKJ9sERRnQm9H
         YBP/eK8vI1IOpR6zPk/9vDA1u192c5S7N2U+iao57yKfaxVbsQLHmFHRwqxHYOhlgpzM
         /X1w==
X-Gm-Message-State: AOAM533RSBRcvncCCFSjNK3lXonQwdH4lsW/9AcCN/vUJasRjwrEYvAI
        S+tkkqrf8Az/dXDi3nzbjsLIiTArX2OVOA==
X-Google-Smtp-Source: ABdhPJyoJ9GbQB398A5GCtwxbatRdwlRJ0T5rbxABDfukLqBP6BMHFxbSgZX80fPQmQT5e64awRLCQ==
X-Received: by 2002:adf:a48d:: with SMTP id g13mr3444805wrb.212.1598523819563;
        Thu, 27 Aug 2020 03:23:39 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k13sm4157086wmj.14.2020.08.27.03.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 03:23:38 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:23:33 +0200
From:   Marco Elver <elver@google.com>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        andriy.shevchenko@linux.intel.com, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Subject: Re: [PATCH] lib: kunit: add list_sort test conversion to KUnit
Message-ID: <20200827102333.GA3564678@elver.google.com>
References: <20200729192357.477350-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729192357.477350-1-vitor@massaru.org>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 04:23PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_list_sort,
> from `lib/test_list_sort.c` to KUnit tests.
> 
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> 
> Code Style Documentation: [0]
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
> ---
>  lib/Kconfig.debug                           | 29 +++++---
>  lib/Makefile                                |  2 +-
>  lib/{test_list_sort.c => list_sort_kunit.c} | 73 +++++++++++----------
>  3 files changed, 58 insertions(+), 46 deletions(-)
>  rename lib/{test_list_sort.c => list_sort_kunit.c} (62%)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..de4fd020a4af 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1854,16 +1854,6 @@ config LKDTM
>  	Documentation on how to use the module can be found in
>  	Documentation/fault-injection/provoke-crashes.rst
>  
> -config TEST_LIST_SORT
> -	tristate "Linked list sorting test"
> -	depends on DEBUG_KERNEL || m
> -	help
> -	  Enable this to turn on 'list_sort()' function test. This test is
> -	  executed only once during system boot (so affects only boot time),
> -	  or at module load time.
> -
> -	  If unsure, say N.
> -
>  config TEST_MIN_HEAP
>  	tristate "Min heap test"
>  	depends on DEBUG_KERNEL || m
> @@ -2173,6 +2163,25 @@ config LIST_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_SORT_KUNIT
> +	tristate "KUnit Linked list sorting test"
> +	depends on KUNIT
> +	depends on DEBUG_KERNEL || m

I think the style [0] you linked suggests '*_KUNIT_TEST' for config
variables.

Only noticed this because I was doing a
	
	git grep 'config.*TEST'

to find tests in the kernel + new tests floating on the LKML.

Apologies for picking this patch to comment on, but if it's still
changeable it might be worth adjusting.

> +	help
> +	  Enable this to turn on 'list_sort()' function test. This test is
> +	  executed only once during system boot (so affects only boot time),
> +	  or at module load time.
> +
> +          KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running the KUnit test harness, and not intended for inclusion into a
> +	  production build.

Not a big deal, but I'm not sure if summarizing KUnit here is useful.
You already link to the documentation below.

> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
...

Thanks,
-- Marco
