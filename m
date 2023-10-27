Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65C7D96CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjJ0Llp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjJ0Llo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:41:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29935192;
        Fri, 27 Oct 2023 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406902; x=1729942902;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qn6YR15Bmkgy5ebgPTMxFjFtqQ8cI5zB/vWtuqUqkNc=;
  b=V+ezcjJHgNNRQpOVYaUOvrmwYFxDcOz0SGRxA9vx2I3seLgrBAtc5Du+
   1iIGTo0mwLdTielHHRIz5ZsDX3a4fsryM/nD8tPJfHDtjtXDvkVhhaCeP
   ZWH9wDp3ZmklWdot3OBQcJUhBmpNa1tgirOI5/xwjjgFDhG5FTXkjH8k3
   ZWyAt/jnpFAGg9Sro5IuK/mdo9pu27vP0HVf6yJHUm46/F+cDGBQ8ZHc4
   yfP/ofwKBmfOd8rnQX1enlw5Tsbhsy9WQkkTq/ASQpieIO0uej5mw2xXY
   irucuUIl3KFn9J/7xNXuWzyLubGDqEg5KDOYMVA7K4akFlMk9hbvKni7o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473999329"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="473999329"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794557792"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794557792"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:41:39 -0700
Date:   Fri, 27 Oct 2023 14:41:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/24] selftests/resctrl: Refactor fill_buf functions
In-Reply-To: <v5jdxr2sayffhq5sslyn2f5x6ogynosuhjxgdmfwzwdpvejngu@aahvjgz3sqcp>
Message-ID: <3a73f8e0-4482-679-d197-6a67c9e23f0@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-3-ilpo.jarvinen@linux.intel.com> <v5jdxr2sayffhq5sslyn2f5x6ogynosuhjxgdmfwzwdpvejngu@aahvjgz3sqcp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-126731212-1698406901=:2740"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-126731212-1698406901=:2740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-24 at 12:26:12 +0300, Ilpo Järvinen wrote:
> >There are unnecessary nested calls in fill_buf.c:
> >  - run_fill_buf() calls fill_cache()
> >  - alloc_buffer() calls malloc_and_init_memory()
> >
> >Simplify the code flow and remove those unnecessary call levels by
> >moving the called code inside the calling function.
> >
> >Resolve the difference in run_fill_buf() and fill_cache() parameter
> >name into 'buf_size' which is more descriptive than 'span'.
> >
> >Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >---
> > tools/testing/selftests/resctrl/fill_buf.c | 58 +++++++---------------
> > tools/testing/selftests/resctrl/resctrl.h  |  2 +-
> > 2 files changed, 20 insertions(+), 40 deletions(-)
> >
> >diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> >index f9893edda869..9d0b0bf4b85a 100644
> >--- a/tools/testing/selftests/resctrl/fill_buf.c
> >+++ b/tools/testing/selftests/resctrl/fill_buf.c
> >@@ -51,29 +51,6 @@ static void mem_flush(unsigned char *buf, size_t buf_size)
> > 	sb();
> > }
> > 
> >-static void *malloc_and_init_memory(size_t buf_size)
> >-{
> >-	void *p = NULL;
> >-	uint64_t *p64;
> >-	size_t s64;
> >-	int ret;
> >-
> >-	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
> >-	if (ret < 0)
> >-		return NULL;
> >-
> >-	p64 = (uint64_t *)p;
> >-	s64 = buf_size / sizeof(uint64_t);
> >-
> >-	while (s64 > 0) {
> >-		*p64 = (uint64_t)rand();
> >-		p64 += (CL_SIZE / sizeof(uint64_t));
> >-		s64 -= (CL_SIZE / sizeof(uint64_t));
> >-	}
> >-
> >-	return p;
> >-}
> >-
> > static int fill_one_span_read(unsigned char *buf, size_t buf_size)
> > {
> > 	unsigned char *end_ptr = buf + buf_size;
> >@@ -137,20 +114,33 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
> > 
> > static unsigned char *alloc_buffer(size_t buf_size, int memflush)
> > {
> >-	unsigned char *buf;
> >+	void *p = NULL;
> 
> Is this initialization doing anything? "p" seems to be either overwritten or in
> case of an error never accessed.

I'm aware of that but the compiler is too stupid to know that p is 
initialized if there's no error and spits out a warning so I'll have to 
keep the unnecessary initialization.

> >+	uint64_t *p64;
> >+	size_t s64;
> >+	int ret;
> > 
> >-	buf = malloc_and_init_memory(buf_size);
> >-	if (!buf)
> >+	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
> >+	if (ret < 0)
> > 		return NULL;
> > 
> >+	/* Initialize the buffer */
> >+	p64 = (uint64_t *)p;
> >+	s64 = buf_size / sizeof(uint64_t);
> >+
> >+	while (s64 > 0) {
> >+		*p64 = (uint64_t)rand();
> >+		p64 += (CL_SIZE / sizeof(uint64_t));
> >+		s64 -= (CL_SIZE / sizeof(uint64_t));
> >+	}
> >+
> > 	/* Flush the memory before using to avoid "cache hot pages" effect */
> > 	if (memflush)
> >-		mem_flush(buf, buf_size);
> >+		mem_flush(p, buf_size);
> 
> Wouldn't renaming "p" to "buf" keep this relationship with "buf_size" more
> explicit?

I'll change it to buf. This patch has a long history which preceeds the 
change where I made the buffer ptr naming more consistent and I didn't 
realize I departed here again from the consistent naming until you now 
pointed it out.

-- 
 i.

--8323329-126731212-1698406901=:2740--
