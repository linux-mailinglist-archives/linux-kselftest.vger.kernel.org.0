Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A263F4C4617
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241183AbiBYNXo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbiBYNXm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:23:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477F1FEFA0;
        Fri, 25 Feb 2022 05:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67234B830B8;
        Fri, 25 Feb 2022 13:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0ACC340E8;
        Fri, 25 Feb 2022 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645795383;
        bh=Z72PKv1Afbtnvn/SooJudW6xoZ4FRHM0SMyv3n4+3C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=dz0Z82piAZ47kEH/1hs6espGEdrbLnK/oQ6L+7NWZg/PoVYjzcD8B+BVlTu2V4nxf
         8kcjJd0Uo9N25Uiq+aOF8qUTuJRrR3CVsyop9LQ3N/7U8DdEPimz8f20xZCuu3fvNw
         ZrEEDjSXRK2JBuKu8Q2kiSZnqgEzFGNDlLSEiNETbUe40MmrSjkpYVxwENwr0hzT2i
         leX5oKIVwYiULyvYoWG2P4+CA3XOvgn3mxFw7eFg//2bmIN516IUJ62YnSu/K8/xig
         BBdTK1nWAeu820F5PGRJU5ceeV+lxvVkykv33mrKR2aNwsUdGORvVlS8rfAMVULfsZ
         m5QiR2jVVu2bA==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI document
Date:   Fri, 25 Feb 2022 13:23:00 +0000
Message-Id: <20220225132300.12767-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YhjXQ/O0wg7AzHCq@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Feb 2022 14:18:59 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 25, 2022 at 01:07:12PM +0000, SeongJae Park wrote:
> > This commit adds DAMON sysfs interface ABI document under
> > Documentation/ABI/testing.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  .../ABI/testing/sysfs-kernel-mm-damon         | 276 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 277 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > new file mode 100644
> > index 000000000000..11984c3a4b55
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > @@ -0,0 +1,276 @@
> > +what:		/sys/kernel/mm/damon/
> > +Date:		Feb 2022
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Interface for Data Access MONitoring (DAMON).
> > +		See Documentation/admin-guide/mm/damon/index.rst for details.
> 
> Ick, no.  Put the real details in here please.  That way it works with
> our tools.

Ok, thanks for the quick comment!


Thanks,
SJ

> 
> thanks,
> 
> greg k-h
