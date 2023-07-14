Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299F75383F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjGNKdg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjGNKdg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 06:33:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118430C6;
        Fri, 14 Jul 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689330812; x=1720866812;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=thbBZkxQUOn7Q+OWCjpYAJ4zB0wuhOmBAj2580NuCJQ=;
  b=WmTsU0Um50rvHaYgIhPH0tLDQ39n8eeaIIZsoK6/huPoKM0ZoSxpoF4L
   fX6QWbTKnzO0WXZOVLPt9T/9R7r7VSw1bVLY+XAutkZiu5wldTeJi9zzn
   ZqyJ1rN/ZUxcO7d90VfNp/5MT807woObd9T0O4QrudcXCMSbYVQH9z99k
   QIGOwpBU0iu+o0DNGnheW24/1p8fUoWNzjBl36M0kcffE+zFiNJ+HA3IW
   ou4nxODNwEjlm5H2Z1LwwbWUPDXlZcVpT67kee9qSFQys0UjLevOCP61T
   UT/QtflxA3xTob4hS5/DfRJpDatmj041gd5cZl3c4pKEvAVG4YENUl5NS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429206795"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429206795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835987464"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="835987464"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:33:28 -0700
Date:   Fri, 14 Jul 2023 13:33:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/19] selftests/resctrl: Convert span to size_t
In-Reply-To: <92b3ef73-6347-b52a-69ed-c1b489b11d55@intel.com>
Message-ID: <4969cf83-f070-f29-5489-1cc6a248c6a7@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-10-ilpo.jarvinen@linux.intel.com> <92b3ef73-6347-b52a-69ed-c1b489b11d55@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1953778464-1689329730=:1695"
Content-ID: <bd9e6e9-6dd-9a8d-602c-837010c9891@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1953778464-1689329730=:1695
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <92a9314-13ff-8d2b-8649-b666807b483d@linux.intel.com>

On Thu, 13 Jul 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> 
> ...
> 
> > @@ -188,10 +188,10 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
> >  	return 0;
> >  }
> >  
> > -int run_fill_buf(unsigned long span, int malloc_and_init_memory,
> > -		 int memflush, int op, char *resctrl_val)
> > +int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
> > +		 char *resctrl_val)
> >  {
> > -	unsigned long long cache_size = span;
> > +	size_t cache_size = span;
> >  	int ret;
> >  
> >  	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
> 
> Any idea what the purpose being run_fill_buf() is? From what I can tell it is
> an unnecessary level of indirection.

You already mentioned it, fill_cache() could be included into 
run_fill_buf() but it's not part of this series.

> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> > index f622245adafe..8be5b745226d 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -298,7 +298,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
> >  void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> >  {
> >  	int operation, ret, malloc_and_init_memory, memflush;
> > -	unsigned long span, buffer_span;
> > +	size_t span, buffer_span;
> >  	char **benchmark_cmd;
> >  	char resctrl_val[64];
> >  	FILE *fp;
> 
> Do we now need a cast in the initialization of span?

I don't see any warning w/o cast, unsigned long -> size_t seems pretty 
safe anyway. For internally provided values, overflow does not seem 
possible even if the type sizes would disagree.

There's no existing error checking for the command in the case where 
"fill_buf" is used with -b (an orthogonal issue).

-- 
 i.
--8323329-1953778464-1689329730=:1695--
