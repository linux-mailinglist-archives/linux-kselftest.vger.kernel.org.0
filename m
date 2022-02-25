Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A084C4842
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiBYPEf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiBYPE3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:04:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F317B8AF;
        Fri, 25 Feb 2022 07:03:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BD7CB82F20;
        Fri, 25 Feb 2022 15:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9078C340E7;
        Fri, 25 Feb 2022 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645801432;
        bh=LtbDai42acTPOfd/QYcCGh9zUlApU/osVJ87ShVYM3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=oNP/07dnTE/sMt4r4KjSSYaTsDSXzjcsaNsyt/DenDdU5rVvCz4sAKP/tYWFbuDER
         BV9zHnmeEEsIhRNM2FoC0XGxn6L0weGT3pUv5vZwny1+smvnwoyMyJXsOOjCYe7KW+
         tB9MRbiIMEqbrmh6C5EMY69k8GVSppg1bvoKLYfRJH/Fh4GJ212hwW0k+hdaNBAPY/
         wwxv79+hALUBzoePc7NSKDULQFdSav5Cl9fcq6susTQWknEQn9GUXVi3ET4hQf6JIp
         XMFCLlH/0Eu3IQ3ddx6P6cNVQOGCaBqpVsRp4fUfSl+BmawaO6F32zwVmtxthC6UZb
         HxeOYmxYATUNg==
From:   SeongJae Park <sj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI document
Date:   Fri, 25 Feb 2022 15:03:47 +0000
Message-Id: <20220225150347.13173-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YhjuqWAsT2PY5sPg@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gregg,

On Fri, 25 Feb 2022 15:58:49 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 25, 2022 at 02:15:40PM +0000, SeongJae Park wrote:
> > On Fri, 25 Feb 2022 14:10:07 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > Hello Gregg,
> > > 
> > > 
> > > On Fri, 25 Feb 2022 13:23:00 +0000 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Fri, 25 Feb 2022 14:18:59 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > > On Fri, Feb 25, 2022 at 01:07:12PM +0000, SeongJae Park wrote:
> > > > > > This commit adds DAMON sysfs interface ABI document under
> > > > > > Documentation/ABI/testing.
> > > > > > 
> > > > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > > > ---
> > > > > >  .../ABI/testing/sysfs-kernel-mm-damon         | 276 ++++++++++++++++++
> > > > > >  MAINTAINERS                                   |   1 +
> > > > > >  2 files changed, 277 insertions(+)
> > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > > > 
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > > > new file mode 100644
> > > > > > index 000000000000..11984c3a4b55
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > > > @@ -0,0 +1,276 @@
> > > > > > +what:		/sys/kernel/mm/damon/
> > > > > > +Date:		Feb 2022
> > > > > > +Contact:	SeongJae Park <sj@kernel.org>
> > > > > > +Description:	Interface for Data Access MONitoring (DAMON).
> > > > > > +		See Documentation/admin-guide/mm/damon/index.rst for details.
> > > > > 
> > > > > Ick, no.  Put the real details in here please.  That way it works with
> > > > > our tools.
> > > > 
> > > > Ok, thanks for the quick comment!
> > > 
> > > Before sending the full series again, I'd like to get your comment if you're
> > > ok.  What do you think about below?
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > new file mode 100644
> > > index 000000000000..11984c3a4b55
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > @@ -0,0 +1,276 @@
> > > +what:		/sys/kernel/mm/damon/
> > > +Date:		Feb 2022
> > > +Contact:	SeongJae Park <sj@kernel.org>
> > > +Description:	Interface for Data Access MONitoring (DAMON).
> > > +		See Documentation/admin-guide/mm/damon/index.rst for details.
> > 
> > Oops, I pasted wrong, sorry.  Please read below:
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > new file mode 100644
> > index 000000000000..e58d844b4f82
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > @@ -0,0 +1,273 @@
> > +what:		/sys/kernel/mm/damon/
> > +Date:		Feb 2022
> > +Contact:	SeongJae Park <sj@kernel.org>
> > +Description:	Interface for Data Access MONitoring (DAMON).  Contains files
> > +		for controlling DAMON.
> 
> For this entry, point people at your larger documentation.

Good suggestion, I will.

> 
[...]
> 
> Yes, this looks much better, thanks.  But you might want to change the
> month as I doubt this will be merged in the next few days :)

Thank you for the quick and nice comment :)


Thanks,
SJ

> 
> thanks,
> 
> greg k-h
> 
> 
