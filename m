Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2F4C183B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiBWQKL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWQKK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 11:10:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D602C4B42;
        Wed, 23 Feb 2022 08:09:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D4D61949;
        Wed, 23 Feb 2022 16:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB5C340E7;
        Wed, 23 Feb 2022 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645632581;
        bh=dlIVpnDwmbEhoSgGlYaekfY+IuS9XO2thcEUMEMFHF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tt5nRsFh/5YB64wdB2b4MLtrMwJA7jLjCx6Pnp0uDxpmJRmfRpxzupLMN+bNO9hzh
         HRAEw8R9bxwD5kRb2D/U8bJvPXrkgrh0Yfovq2W2QqoRCYz6GqK5eTiWn7uTgA+EI2
         YxWiPU4JuANYIg9cwUGjdkvZ1uKtAPYfKmxViHW0=
Date:   Wed, 23 Feb 2022 17:09:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based
 DAMON interface
Message-ID: <YhZcQnsP0aA8RSTs@kroah.com>
References: <20220223152051.22936-1-sj@kernel.org>
 <20220223152051.22936-4-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223152051.22936-4-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 23, 2022 at 03:20:42PM +0000, SeongJae Park wrote:
> +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> +		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
> +				damon_sysfs_ul_range_min_store);
> +
> +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> +		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
> +				damon_sysfs_ul_range_max_store);

Can you use __ATTR_RW_MODE() instead here and elsewhere?

thanks,

greg k-h
