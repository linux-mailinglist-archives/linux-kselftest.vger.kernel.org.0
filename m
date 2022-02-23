Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8560C4C18EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiBWQpr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 11:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBWQpq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 11:45:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094474847;
        Wed, 23 Feb 2022 08:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA7C5B81711;
        Wed, 23 Feb 2022 16:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D716DC340E7;
        Wed, 23 Feb 2022 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645634716;
        bh=SqOGPss8W5UPV/EirpHZ5v3lVEHrAzC5LHdF1L/Apgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=LPNTV0OGyBOD9kwKtRxATg9rqREM5k1tRxwVotYlhajlm8jFiqL9d41bMbaraLgyB
         Nd9pIix88TJSwGBD0lhHweQJIBhpfq80hZM5/gzQD2Rs5pCHDPoTJux5kwZhvbf8Bj
         eVAHiZnOFjDEbd54RQosr9yu/pqpxof97V2r0D+h9Cj75oYZbAvie3WVBYYwANsXCy
         tktlff6RrSBiZRyTMzjoTkw6uoyzJCXKf5x435AFQ6stzE2U28FUVIfjqzKDQkp9/r
         Oe7a9NzHpfW/0+BxiFNNFPMlcPrxYicL05iW8Ib1dZphNn1G5oPLY5vJl+3W/UnPMe
         tvoU7VT4zMv1A==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Wed, 23 Feb 2022 16:45:13 +0000
Message-Id: <20220223164513.23089-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YhZcQnsP0aA8RSTs@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Feb 2022 17:09:38 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 23, 2022 at 03:20:42PM +0000, SeongJae Park wrote:
> > +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> > +		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
> > +				damon_sysfs_ul_range_min_store);
> > +
> > +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> > +		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
> > +				damon_sysfs_ul_range_max_store);
> 
> Can you use __ATTR_RW_MODE() instead here and elsewhere?

Sure, I will, in the next revision.


Thanks,
SJ

> 
> thanks,
> 
> greg k-h
> 
