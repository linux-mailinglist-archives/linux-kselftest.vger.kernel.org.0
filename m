Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C131C4C19A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbiBWROQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 12:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiBWROP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 12:14:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934F33A;
        Wed, 23 Feb 2022 09:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 280C6B82116;
        Wed, 23 Feb 2022 17:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1CFC340E7;
        Wed, 23 Feb 2022 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645636424;
        bh=Iuzpx3eqNgHmcbEjMXJ+Gh2uRHsMErcCOx9NX8k4XKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=B1IyE4COZCZ918sC6snIEXlQ37FWTy+lbsQm8/muHoyWU51r7G2vlkgwMfeeNkkJo
         LvuUWwWIgzsv0xOKdaQyFEZ5T9cwz0p3p2UmWne4sZvuIY1cz7nOzlDmpLM68zgaJf
         wXjsKpjrJaOJ0wTGW2ySYzcG2B1OZ4C41Rnt773LWclbltXWyufpzh5CuyF29C8Ly4
         o4J2yRRP3b26m03bY+MlZ4y/Ns+5CMzG0cMBTodUAdptqggAuoPAV1RFipqqHELUCq
         v36YZRyzZKCJFamHLx+pcHWrmQOGNduvvo3l8sf8PSfT/8Y3ARBlwxl1MSbald+nmN
         R+VI6B8pEJxAA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Wed, 23 Feb 2022 17:13:41 +0000
Message-Id: <20220223171341.29010-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223164513.23089-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Feb 2022 16:45:13 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Wed, 23 Feb 2022 17:09:38 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Feb 23, 2022 at 03:20:42PM +0000, SeongJae Park wrote:
> > > +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> > > +		__ATTR(min, 0600, damon_sysfs_ul_range_min_show,
> > > +				damon_sysfs_ul_range_min_store);
> > > +
> > > +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> > > +		__ATTR(max, 0600, damon_sysfs_ul_range_max_show,
> > > +				damon_sysfs_ul_range_max_store);
> > 
> > Can you use __ATTR_RW_MODE() instead here and elsewhere?
> 
> Sure, I will, in the next revision.

After thinking once more, I realized that it might not so simple.  First of
all, there are two files having same name in different directories
(kdamonds/<N>/pid and targets/<N>/pid).  The files work differently, so I need
to use different _show/_store callbacks for them but __ATTR_RW_MODE() wouldn't
support the case.

Secondly, I'd like to keep the file names short because the meaning of the
files can easily inferred from the hierarchy, but want to keep the _show/_store
callback names to have prefixes that allows us easily know their meaning and
usage even though it makes the name a little bit longer because I don't want to
have too much source files for DAMON sysfs interface.

Am I missing some of your point?


Thanks,
SJ

[...]
