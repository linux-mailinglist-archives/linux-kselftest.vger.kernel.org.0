Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAAAD0309
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfJHVrJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 17:47:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJHVrI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 17:47:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so4061pgp.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deKxqqIeBJnms1ArtnCHEcClgbbTOafzse1Vw29vp3M=;
        b=FiOaf3BluQtz79g61N30s9XrSWDujtsm+6AAYd+wa70Q+3AsODwCTRCuR4GyRN/hrT
         SIad+dd5d2TROZ/tWHeb/O0bcimfWZJEHD0C58O17e+eWehUTHa50JxLCXaGg3+Pwdbf
         Rv3HMnwA2hLHY2pOpUmPw0Y5VkDqFL7ZadoKP80JrU+moRBfy3+2TZ/nn3cbt9mjZwuA
         qTxwsVmuRA7CM2wqEwxmW5X/rCeEwtekbfUduwXKxyXaKW96nPQfnT8on+T27qsC11L5
         bQdsep4WzKpTicx+rsKUnVpbKIFpHXsrKbxKKYnG/iWR3w+vYpF6IULBXXFsN1cFpX4+
         9z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deKxqqIeBJnms1ArtnCHEcClgbbTOafzse1Vw29vp3M=;
        b=i4lu6TvX3VKRUsAy3QwyR88o7HtSe/knIwcvWjpbt8AlBjCebY7JHCGtlAUtKtTwfM
         l/66XAznGoAJ8/FOCAvP3D2sMboCBRYw0hUdJllJ+W8ER8c7C8VXhk534ci5SKUqs7Dx
         ZiKscZ/5Cwp30uUhZ/iqeS3aV/A75n1IguJDkCYZK+505dpUbCCMWEw4RAvGZjEupeGW
         CUeW8XJWqZVfnqfm0TTGcQtV9yA5alPHxvXuKK2Jq+ETfhGPoCC5QGVHqrO+XgW4VKCg
         VCeWyrlj4LUTenapsOY6yS+a7eR1mXvWf7jLG1dhlBBLqPU7hO47fxeHiQqoGS4Ij7V/
         7tig==
X-Gm-Message-State: APjAAAXAn02u1ky6s1q+hhzx9RDrFfBdZn98mfCEcLgoUExcmQFtFB3B
        TosNAMtkAQwxCGkmfA/+LbdRwg==
X-Google-Smtp-Source: APXvYqzrPn6t1Floi5tLW9Ts9jTNHSZ5+XjjhsO4ow7Qm01JTGlIdau0pgLA4Keuom9H5ytTcP0GsA==
X-Received: by 2002:a63:ba58:: with SMTP id l24mr591901pgu.434.1570571226070;
        Tue, 08 Oct 2019 14:47:06 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id v19sm87014pff.46.2019.10.08.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:47:04 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:47:00 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v2 linux-kselftest-test 3/3] kunit: update documentation
 to describe module-based build
Message-ID: <20191008214700.GC186342@google.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-4-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570546546-549-4-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 03:55:46PM +0100, Alan Maguire wrote:
> Documentation should describe how to build kunit and tests as
> modules.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> 
> ---
>  Documentation/dev-tools/kunit/faq.rst   |  3 ++-
>  Documentation/dev-tools/kunit/index.rst |  3 +++
>  Documentation/dev-tools/kunit/usage.rst | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
[...]
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index c6e6963..fa0f03f 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -539,6 +539,22 @@ Interspersed in the kernel logs you might see the following:
>  
>  Congratulations, you just ran a KUnit test on the x86 architecture!
>  
> +In a similar manner, kunit and kunit tests can also be built as modules,
> +so if you wanted to run tests in this way you might add the following config
> +options to your ``.config``:
> +
> +.. code-block:: none
> +
> +        CONFIG_KUNIT=m
> +        CONFIG_KUNIT_EXAMPLE_TEST=m

This doesn't appear to be properly tabbed.

> +Once the kernel is built and installed, a simple
> +
> +.. code-block:: bash
> +	modprobe example-test
> +
> +...will run the tests.
> +
>  Writing new tests for other architectures
>  -----------------------------------------
>  
> -- 
> 1.8.3.1
> 
