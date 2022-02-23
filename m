Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725924C18EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiBWQpN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 11:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiBWQpM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 11:45:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8876E79E;
        Wed, 23 Feb 2022 08:44:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95D1D60B17;
        Wed, 23 Feb 2022 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E2C340E7;
        Wed, 23 Feb 2022 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645634684;
        bh=yNzZkkA2UtpmBgQG99OdPqjIkEh3BZ5nLjxVqvHizPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=My1iUTPnePhE6rx/netU/jwR/kHe9OK12+OnID8BVXpxUW4FKMUKVALhxRwaDnNUX
         KJ0Q4LpXtHVTapQY34W7LvJbCCdt4/JS7J5YBNWtKbjcp71YKQKTEzdJ4EH+w6wfxy
         J5SSvsO7xpD2im9Vtw5oG5k4uMWDmACxbvap9HMwXElVFO15//1Snj0W+Z8H073erL
         SbMbJgaSe7gvllLPDC4gCHcgo26ueaHL785ZnwGlVPfhVPva3drI77u6c064DuvzN7
         n83RdpA3jBmFhBZkh23FBc74GETIoQTCV6iWwwxkSUDwDTex7+jOSeflF1xhATjYBN
         7XOILwVCUdleQ==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Introduce DAMON sysfs interface
Date:   Wed, 23 Feb 2022 16:44:40 +0000
Message-Id: <20220223164440.23030-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YhZbuCcK8rW1rA6Z@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Feb 2022 17:07:20 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 23, 2022 at 03:20:39PM +0000, SeongJae Park wrote:
> > Chages from Previous Version (RFC)
> > ==================================
> > 
> > Compared to the RFC version of this patchset
> > (https://lore.kernel.org/linux-mm/20220217161938.8874-1-sj@kernel.org/), this
> > version contains below changes.
> > 
> > - Implement all DAMON debugfs interface providing features
> > - Writeup documents
> > - Add more selftests
> > 
> > Introduction
> > ============
> > 
> > DAMON's debugfs-based user interface (DAMON_DBGFS) served very well, so far.
> > However, it unnecessarily depends on debugfs, while DAMON is not aimed to be
> > used for only debugging.  Also, the interface receives multiple values via one
> > file.  For example, schemes file receives 18 values.  As a result, it is
> > inefficient, hard to be used, and difficult to be extended.  Especially,
> > keeping backward compatibility of user space tools is getting only challenging.
> > It would be better to implement another reliable and flexible interface and
> > deprecate DAMON_DBGFS in long term.
[...]
> > 
> > SeongJae Park (12):
> >   mm/damon/core: Allow non-exclusive DAMON start/stop
> >   mm/damon/core: Add number of each enum type values
> >   mm/damon: Implement a minimal stub for sysfs-based DAMON interface
> >   mm/damon/sysfs: Link DAMON for virtual address spaces monitoring
> >   mm/damon/sysfs: Support physical address space monitoring
> >   mm/damon/sysfs: Support DAMON-based Operation Schemes
> >   mm/damon/sysfs: Support DAMOS quotas
> >   mm/damon/sysfs: Support schemes prioritization weights
> >   mm/damon/sysfs: Support DAMOS watermarks
> >   mm/damon/sysfs: Support DAMOS stats
> >   selftests/damon: Add a test for DAMON sysfs interface
> >   Docs/admin-guide/mm/damon/usage: Document DAMON sysfs interface
> > 
> >  Documentation/admin-guide/mm/damon/usage.rst |  349 ++-
> >  include/linux/damon.h                        |    6 +-
> >  mm/damon/Kconfig                             |    7 +
> >  mm/damon/Makefile                            |    1 +
> >  mm/damon/core.c                              |   23 +-
> >  mm/damon/dbgfs.c                             |    2 +-
> >  mm/damon/reclaim.c                           |    2 +-
> >  mm/damon/sysfs.c                             | 2684 ++++++++++++++++++
> >  tools/testing/selftests/damon/Makefile       |    1 +
> >  tools/testing/selftests/damon/sysfs.sh       |  306 ++
> >  10 files changed, 3364 insertions(+), 17 deletions(-)
> >  create mode 100644 mm/damon/sysfs.c
> >  create mode 100755 tools/testing/selftests/damon/sysfs.sh
> 
> sysfs files need to be documented in Documentation/ABI/ which is where
> our tools look for them (have you run scripts/get_abi.pl with your code
> in the kernel?)
> 
> Please fix this up to use that format so we can then verify that you are
> using sysfs correctly.

Sure, I will do so in the next version.


Thanks,
SJ

> 
> thanks,
> 
> greg k-h
