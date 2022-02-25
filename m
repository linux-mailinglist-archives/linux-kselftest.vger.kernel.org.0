Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3F4C45E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiBYNTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiBYNTf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:19:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38061239327;
        Fri, 25 Feb 2022 05:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59DD61CD5;
        Fri, 25 Feb 2022 13:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1E0C340E7;
        Fri, 25 Feb 2022 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645795142;
        bh=M7/gvzCKq5TuK4z3DH4FOHDLYrRwAuuauyqlFvHgbTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsDWHxVOc0dHDHVPagKPYYobvtiTSxF7g2HTJ/8JV2YAp+Fay/mgILyN1oQw2HzqX
         LuU7DknzXH8hLFz0sAyp9T3uWC0ie9EFnWpJX36mhndrHBc2U0swx2RLyljxPKoiH1
         yIbJKdtSr51lva9D96PAGzvUO1xl6kqnL7QcXtMQ=
Date:   Fri, 25 Feb 2022 14:18:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI
 document
Message-ID: <YhjXQ/O0wg7AzHCq@kroah.com>
References: <20220225130712.12682-1-sj@kernel.org>
 <20220225130712.12682-14-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225130712.12682-14-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 25, 2022 at 01:07:12PM +0000, SeongJae Park wrote:
> This commit adds DAMON sysfs interface ABI document under
> Documentation/ABI/testing.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  .../ABI/testing/sysfs-kernel-mm-damon         | 276 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 277 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> new file mode 100644
> index 000000000000..11984c3a4b55
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -0,0 +1,276 @@
> +what:		/sys/kernel/mm/damon/
> +Date:		Feb 2022
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Interface for Data Access MONitoring (DAMON).
> +		See Documentation/admin-guide/mm/damon/index.rst for details.

Ick, no.  Put the real details in here please.  That way it works with
our tools.

thanks,

greg k-h
