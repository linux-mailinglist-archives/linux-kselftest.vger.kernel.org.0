Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1A604774
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Oct 2022 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiJSNj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Oct 2022 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiJSNjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Oct 2022 09:39:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB914C53C;
        Wed, 19 Oct 2022 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DMfo3vlJ+nr6H0YFpZ0tb2uuXDjhc2GyhwauQdw41Tc=; b=xcxnnOc5b+UKA+HUHyI0gwFc9b
        US6B71/1iL72nJ16wadEPkMKP3huGYHXLegNWN8IZ5A8R9N+kUXsozwkWQ0tD38hszv4IVtin4bRQ
        8N1svNYM6RDo7nTEGcUsq601uXyypMqsGepg/BlR6z33rsPGXNRVwqA5RmOCgg9AjF5f2cBM18rKi
        I/8zkORY9Yzp9s514Ersqb+x8J7zin3DDIvNox12OoMINwvTbM6J5Tel3c4iSjw+ZgwhM2xelK9n0
        fLx01DwvNmmw7SKIJ6KxagqJAMiFcVYdMC5C6JJukLfcWiiU5txpcA7SYgFHJgHz59E9/e9sgUR7y
        gxNjTkjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ol95p-0027td-DD; Wed, 19 Oct 2022 13:26:45 +0000
Date:   Wed, 19 Oct 2022 06:26:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, keescook@chromium.org
Cc:     joe@perches.com, rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] SPDX: add copyleft-next-0.3.1
Message-ID: <Y0/7FZCk7D+ygf2o@bombadil.infradead.org>
References: <20221003165849.1658170-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003165849.1658170-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 03, 2022 at 09:58:47AM -0700, Luis Chamberlain wrote:
> As suggested by Thomas Gleixner, I'm following up to move on with
> the SPDX tag needed for copyleft-next-0.3.1. I've split this out
> from the test_sysfs selftest so to separate review from that.
> 
> Changes on this v11:
>   o Fixed a minor typo on patch #2 as noted by Kees Cook
>   o Added Reviewed-by tags by Kees Cook
> 
> Changes on this v10:
>   o embraced paragraph from Thomas Gleixner which helps explain why             
>     the OR operator in the SPDX license name
>   o dropped the GPL-2.0 and GPL-2.0+ tags as suggested by Thomas Gleixner
>     as these are outdated (still valid) in the SPDX spec
>   o trimmed the Cc list to remove the test_sysfs / block layer / fs folks as
>     the test_sysfs stuff is now dropped from consideration in this series
> 
> Prior to this the series was at v9 but it also had the test_sysfs and its
> changes, its history can be found here:
> 
> https://lore.kernel.org/all/20211029184500.2821444-1-mcgrof@kernel.org/
> 
> Luis Chamberlain (2):
>   LICENSES: Add the copyleft-next-0.3.1 license
>   testing: use the copyleft-next-0.3.1 SPDX tag
> 
>  LICENSES/dual/copyleft-next-0.3.1        | 236 +++++++++++++++++++++++
>  lib/test_kmod.c                          |  12 +-
>  lib/test_sysctl.c                        |  12 +-
>  tools/testing/selftests/kmod/kmod.sh     |  13 +-
>  tools/testing/selftests/sysctl/sysctl.sh |  12 +-
>  5 files changed, 240 insertions(+), 45 deletions(-)
>  create mode 100644 LICENSES/dual/copyleft-next-0.3.1

*poke*

  Luis
