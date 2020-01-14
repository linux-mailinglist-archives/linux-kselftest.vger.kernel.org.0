Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93113AF5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgANQaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 11:30:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgANQaI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 11:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nus/i78kK3SpGp2U2Esf2bTqwzBG98LRZpZBiWVKPiw=; b=NY2FUl3vLOtb2XkzeXGzvfcdD
        wtXkCRAhj01IpPwNLvBWCdHKSi8O/O5hU3EK364oV+TvbT3AIfOHbU4KslE8M/+dDnRABVZJP5f5B
        nVvTsa8LWYGSOM4Oe7kfhNQEltOWrhWo+7kRk9Llr41SG9QswSNS3DxpJl/yUQI1nebSvFALhUcIS
        vJ+ZOUgj+FHvTLHw1fjZZePBqe9BkaeHhw9VUw8c9Wk96Y7kLx4tcHHpbYSy6IGE0XgHVfRiu20CZ
        qMG7VTxBe4ODOw9Z0TzIDX77HXwwVphYKSsiA08DUnJaFhEkYlDZI5z9AAdC6jAzZ5WSOFcgXLb8r
        TCDe/lYqw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irP4x-00072m-VB; Tue, 14 Jan 2020 16:30:08 +0000
Subject: Re: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        dmitry.torokhov@gmail.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
References: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2242e184-93a5-147d-d603-4017ca86eba9@infradead.org>
Date:   Tue, 14 Jan 2020 08:30:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On 1/14/20 8:09 AM, Alan Maguire wrote:
> currently the property entry kunit tests are built if CONFIG_KUNIT=y.
> This will cause warnings when merged with the kunit tree that now
> supports tristate CONFIG_KUNIT.  While the tests appear to compile
> as a module, we get a warning about missing module license.
> 
> It's better to have a per-test suite CONFIG variable so that
> we can do selective building of kunit-based suites, and can
> also avoid merge issues like this.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reported-by: Randy Dunlap <rdunlap@infradead.org>

> Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  drivers/base/test/Kconfig  | 3 +++
>  drivers/base/test/Makefile | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> index 86e85da..d29ae95 100644
> --- a/drivers/base/test/Kconfig
> +++ b/drivers/base/test/Kconfig
> @@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
>  	  The module name will be test_async_driver_probe.ko
>  
>  	  If unsure say N.
> +config KUNIT_DRIVER_PE_TEST
> +	bool "KUnit Tests for property entry API"
> +	depends on KUNIT

Why is this bool instead of tristate?

> diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
> index 2214310..3ca5636 100644
> --- a/drivers/base/test/Makefile
> +++ b/drivers/base/test/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
>  
> -obj-$(CONFIG_KUNIT) += property-entry-test.o
> +obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
> 

thanks.
-- 
~Randy

