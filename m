Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96E4C1B55
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 20:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244091AbiBWTEK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 14:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBWTEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 14:04:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADB1D0CC;
        Wed, 23 Feb 2022 11:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 719C26168F;
        Wed, 23 Feb 2022 19:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4438C340E7;
        Wed, 23 Feb 2022 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645643020;
        bh=Lo+rvEWRJNqoSEUkIFmf7EbqThnTEYWUSXqpONBnfkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=P2J6UGlEdQEAMWrh38f2++8ZXhJUUBsbLZ3ieMVLOE76r/jzNrMgZoMcSsWh++IG8
         Sfdbnqc3BJkmntD5WZkncAV9jtgkuKsvb0suXaRknEEBCDVDRgLO79wLNjJ8X1DMxe
         Pw8W2pPar7UBsCnprKZIfkZVOrhrEOe28H2FXSOKuiTRrBMqxE2phWtVMzV/tKWcR2
         V3+saGq3v9Kd4f8H2sdWQF8umx8vOB7wRIrhBz0P1mN7jLMlLn8PoBqbMpMFher9s6
         7XqKSBYU6C4k9lG/ogBe6/XOTtBBwiPlpnwMcfIC/RHyXkyYRYgpw/E6mizs414R9T
         REiFpSxFgQJow==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Wed, 23 Feb 2022 19:03:37 +0000
Message-Id: <20220223190337.1705-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YhZ9+xsQ2zNmTdjD@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Feb 2022 19:33:31 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 23, 2022 at 05:13:41PM +0000, SeongJae Park wrote:
> > On Wed, 23 Feb 2022 16:45:13 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Wed, 23 Feb 2022 17:09:38 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Wed, Feb 23, 2022 at 03:20:42PM +0000, SeongJae Park wrote:
> > > > > +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> > > > > +		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
> > > > > +				damon_sysfs_ul_range_min_store);
> > > > > +
> > > > > +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> > > > > +		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
> > > > > +				damon_sysfs_ul_range_max_store);
> > > > 
> > > > Can you use __ATTR_RW_MODE() instead here and elsewhere?
> > > 
> > > Sure, I will, in the next revision.
> > 
> > After thinking once more, I realized that it might not so simple.  First of
> > all, there are two files having same name in different directories
> > (kdamonds/<N>/pid and targets/<N>/pid).  The files work differently, so I need
> > to use different _show/_store callbacks for them but __ATTR_RW_MODE() wouldn't
> > support the case.
> 
> The reason I recommend using these macros is to prevent you from having
> sysfs files with the same name, yet doing different things in different
> places in the sysfs tree :)

Thank you for clarifying!  Maybe I was making the hierarchy unnecessarily deep
and thus naming files too short and/or common, which could confuses relative
paths users.

> 
> > Secondly, I'd like to keep the file names short because the meaning of the
> > files can easily inferred from the hierarchy, but want to keep the _show/_store
> > callback names to have prefixes that allows us easily know their meaning and
> > usage even though it makes the name a little bit longer because I don't want to
> > have too much source files for DAMON sysfs interface.
> > 
> > Am I missing some of your point?
> 
> How about renaming one of the files?

Thank you for the suggestion, will do so.


Thanks,
SJ
