Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459484C1AFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbiBWSeE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 13:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiBWSeE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 13:34:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B69E4EA0B;
        Wed, 23 Feb 2022 10:33:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DAC7B8211D;
        Wed, 23 Feb 2022 18:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEB6C340E7;
        Wed, 23 Feb 2022 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645641213;
        bh=0xj9aSd6jMvgA2fZvLT9i6WQjMs7jPcimi01inky5Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9ji03D9KgSvmPz+XksOIsQKaDXTdI0jhrmMjsQtv5QBjHdUnLPmsgA85dv7JXWw1
         2+gxlgpemNYSfq3OIa242IRKYcBtO/UhOUYlU1N1InyZybSkR3xe06n1sMfNdFYAvR
         mxHVXziWDQ4WrYxBThpaPUfJIaZvmB/RDHRWAWkg=
Date:   Wed, 23 Feb 2022 19:33:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based
 DAMON interface
Message-ID: <YhZ9+xsQ2zNmTdjD@kroah.com>
References: <20220223164513.23089-1-sj@kernel.org>
 <20220223171341.29010-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223171341.29010-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 23, 2022 at 05:13:41PM +0000, SeongJae Park wrote:
> On Wed, 23 Feb 2022 16:45:13 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Wed, 23 Feb 2022 17:09:38 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Wed, Feb 23, 2022 at 03:20:42PM +0000, SeongJae Park wrote:
> > > > +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> > > > +		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
> > > > +				damon_sysfs_ul_range_min_store);
> > > > +
> > > > +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> > > > +		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
> > > > +				damon_sysfs_ul_range_max_store);
> > > 
> > > Can you use __ATTR_RW_MODE() instead here and elsewhere?
> > 
> > Sure, I will, in the next revision.
> 
> After thinking once more, I realized that it might not so simple.  First of
> all, there are two files having same name in different directories
> (kdamonds/<N>/pid and targets/<N>/pid).  The files work differently, so I need
> to use different _show/_store callbacks for them but __ATTR_RW_MODE() wouldn't
> support the case.

The reason I recommend using these macros is to prevent you from having
sysfs files with the same name, yet doing different things in different
places in the sysfs tree :)

> Secondly, I'd like to keep the file names short because the meaning of the
> files can easily inferred from the hierarchy, but want to keep the _show/_store
> callback names to have prefixes that allows us easily know their meaning and
> usage even though it makes the name a little bit longer because I don't want to
> have too much source files for DAMON sysfs interface.
> 
> Am I missing some of your point?

How about renaming one of the files?

thanks,

greg k-h
