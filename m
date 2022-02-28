Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104344C71AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiB1QZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 11:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiB1QZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 11:25:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C685968;
        Mon, 28 Feb 2022 08:25:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DD56121D;
        Mon, 28 Feb 2022 16:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C67FC340E7;
        Mon, 28 Feb 2022 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646065517;
        bh=Q0cEvw/frXXnhjYmTo/ZA9LzRmt/3h/tiuHVYJ0ctxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=OCmP6aWMMnf4KaCmCJEOLdcao/Ab+DavbUAit4REqVOV3iU9uAvUPl4k8GsnFCwBN
         RdNi93PTBCCt7c5sjFUebdj5EkzXw22tg10aR2iVZ3wuxHqkodcyMxOBgZHn+I2nHG
         pEfUx33gN9RA7sjChfZuN1wz63A/0bMc4EIb3SakjesmDQ5DS2ynF0GMpZLGp7fg5t
         VaZjsYFZgCNl0k+kqLiB75sOSy1SwXqBkn3G43FgFhaql2wYuyKLHNcNOx7SpOzDdn
         2Lud2JyX6RFtUBbusoAvGXaWGglnIhiIdfCuR+p3Oy5BVtZK3tFAlFz/uvtBnB1d1v
         qEgffWc5zmneQ==
From:   SeongJae Park <sj@kernel.org>
To:     xhao@linux.alibaba.com
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        gregkh@linuxfoundation.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] mm/damon/sysfs: Support the physical address space monitoring
Date:   Mon, 28 Feb 2022 16:25:14 +0000
Message-Id: <20220228162514.4111-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <d4b7fe7b-a908-989c-e86b-2ed404372d78@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 1 Mar 2022 00:11:12 +0800 xhao@linux.alibaba.com wrote:

> 
> On 2/28/22 4:13 PM, SeongJae Park wrote:
> > This commit makes DAMON sysfs interface supports the physical address
> > space monitoring.  Specifically, this commit adds support of the initial
> > monitoring regions set feature by adding 'regions' directory under each
> > target directory and makes context operations file to receive 'paddr' in
> > addition to 'vaddr'.
> >
> > As a result, the files hierarchy becomes as below:
> >
> >      /sys/kernel/mm/damon/admin
> >      │ kdamonds/nr_kdamonds
> >      │ │ 0/state,pid
> >      │ │ │ contexts/nr_contexts
> >      │ │ │ │ 0/operations
> >      │ │ │ │ │ monitoring_attrs/
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ nr_regions/min,max
> >      │ │ │ │ │ targets/nr_targets
> >      │ │ │ │ │ │ 0/pid_target
> >      │ │ │ │ │ │ │ regions/nr_regions    <- NEW DIRECTORY
> >      │ │ │ │ │ │ │ │ 0/start,end
> >      │ │ │ │ │ │ │ │ ...
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ ...
> >      │ │ ...
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/damon/sysfs.c | 276 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 271 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 9221c93db6cc..968a4ba8e81b 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -113,12 +113,220 @@ static struct kobj_type damon_sysfs_ul_range_ktype = {
> >   	.default_groups = damon_sysfs_ul_range_groups,
> >   };
> >   
> > +/*
> > + * init region directory
> > + */
> > +
> > +struct damon_sysfs_region {
> > +	struct kobject kobj;
> > +	unsigned long start;
> > +	unsigned long end;
> > +};
> > +
> > +static struct damon_sysfs_region *damon_sysfs_region_alloc(
> > +		unsigned long start,
> > +		unsigned long end)
> > +{
> > +	struct damon_sysfs_region *region = kmalloc(sizeof(*region),
> > +			GFP_KERNEL);
> > +
> > +	if (!region)
> > +		return NULL;
> > +	region->kobj = (struct kobject){};
> > +	region->start = start;
> > +	region->end = end;
> > +	return region;
> > +}
> > +
> 
> The interface "start" and "end" have the same problems
> 
> [root@rt2k03395 0]# echo 100 > start
> [root@rt2k03395 0]# echo 10 > end
> [root@rt2k03395 0]# cat end
> 10
> [root@rt2k03395 0]# cat start
> 100

As mentioned on the above answer[1], this is an intended behavior, so I don't
think a fix is needed.

[1] https://lore.kernel.org/linux-mm/20220228162318.4046-1-sj@kernel.org/


Thanks,
SJ

[...]
> -- 
> Best Regards!
> Xin Hao
> 
