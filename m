Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A66419B4D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 19:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgDARrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 13:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732328AbgDARrG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 13:47:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D7820784;
        Wed,  1 Apr 2020 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585763226;
        bh=pSIBaD4+b+O8FNdmNyWvEINRgzApDBhx/6Kuu3tMRp4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PX2jvi5/L/tyYNgbVT33eJrZ6Kl3dvqqGooWnn0Pffl/OUuILH++8UCg+URc3P50O
         UNHR/jeMTYFJn+9OPnDOAcNZXKhbDQsNw0bEld7tXLJgMQVhSdgxEYbQp9tZ/tjSVo
         hB1fZaKfpxczh/7FPOjFTftUtl8bp7BHfd9tYLvc=
Subject: Re: [PATCH v8 kunit-next 1/4] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
 <1585232710-322-2-git-send-email-alan.maguire@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0d310181-a172-dec9-19aa-337ece9d7380@kernel.org>
Date:   Wed, 1 Apr 2020 11:47:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1585232710-322-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On 3/26/20 8:25 AM, Alan Maguire wrote:
> add debugfs support for displaying kunit test suite results; this is
> especially useful for module-loaded tests to allow disentangling of
> test result display from other dmesg events.  debugfs support is
> provided if CONFIG_KUNIT_DEBUGFS=y.
> 
> As well as printk()ing messages, we append them to a per-test log.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> ---
>   include/kunit/test.h   |  54 +++++++++++++++---
>   lib/kunit/Kconfig      |   8 +++

Missing defaults for config options?

>   lib/kunit/Makefile     |   4 ++
>   lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++
>   lib/kunit/debugfs.h    |  30 ++++++++++
>   lib/kunit/kunit-test.c |   4 +-
>   lib/kunit/test.c       | 147 ++++++++++++++++++++++++++++++++++++++-----------
>   7 files changed, 322 insertions(+), 41 deletions(-)
>   create mode 100644 lib/kunit/debugfs.c
>   create mode 100644 lib/kunit/debugfs.h
> 

snip

> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 065aa16..95d12e3 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -14,6 +14,14 @@ menuconfig KUNIT
>   
>   if KUNIT
>   
> +config KUNIT_DEBUGFS
> +	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
> +	help
> +	  Enable debugfs representation for kunit.  Currently this consists
> +	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
> +	  test suite, which allow users to see results of the last test suite
> +	  run that occurred.
> +

Any reason why there is default for this option?

Same for all other options. I am sending pull request for now without
defaults. Would like to see this fixed for rc2.

thanks,
-- Shuah
