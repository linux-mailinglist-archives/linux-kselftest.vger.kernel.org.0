Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190F410772
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Sep 2021 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhIRP4L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Sep 2021 11:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237245AbhIRP4K (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Sep 2021 11:56:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB92261244;
        Sat, 18 Sep 2021 15:54:40 +0000 (UTC)
Date:   Sat, 18 Sep 2021 16:58:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 2/6] iio/test-format: build kunit tests without
 structleak plugin
Message-ID: <20210918165820.076237b4@jic23-huawei>
In-Reply-To: <20210917061104.2680133-3-brendanhiggins@google.com>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
        <20210917061104.2680133-3-brendanhiggins@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 16 Sep 2021 23:11:00 -0700
Brendan Higgins <brendanhiggins@google.com> wrote:

> The structleak plugin causes the stack frame size to grow immensely when
> used with KUnit:
> 
> ../drivers/iio/test/iio-test-format.c: In function ‘iio_test_iio_format_value_fixedpoint’:
> ../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> 
> Turn it off in this file.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/test/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> index f1099b4953014..467519a2027e5 100644
> --- a/drivers/iio/test/Makefile
> +++ b/drivers/iio/test/Makefile
> @@ -5,3 +5,4 @@
>  
>  # Keep in alphabetical order
>  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
> +CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)

