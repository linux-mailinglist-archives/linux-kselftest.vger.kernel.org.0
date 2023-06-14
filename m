Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94F272FF61
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjFNNDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbjFNNDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 09:03:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C44199C;
        Wed, 14 Jun 2023 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686747784; x=1718283784;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WDPEbxVFdzvoZ3lt67W/3QT8Nr5+/zJbjhuLHHdJoRo=;
  b=Jmk8aRSzCkp1o/6x5bWqUU7ad8rft0d+LuO+kuwHvnKm4VtL9e8CdIMU
   HcY7icrFK6woaLqnMH7Pgm3O1DVap7M8B+hs1ZCh7Ffuja7yUgx/yeDeh
   nv1Xt2KcC4hu5tCBF5hNue6VC06s68C2CPfYRo8XAvOvuyxnEcnfiGWFV
   o9jy65h0oST3F8deSSBxpIUf98ahVDVJesABJnfjVl9P3mPcZQZDbveXk
   0t35vZC87/ahPZONOH9xRup4UVwm64IoJii+5OltI/BN06Q+ohoylAXQs
   voM54L7HxNZzsx5SXkDBGox9MXDQALl+vQ68J4rD0caU3xUL1ODLlFjM7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="343300799"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="343300799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="856496471"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="856496471"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.252.34.126])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:02:56 -0700
Date:   Wed, 14 Jun 2023 16:02:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
In-Reply-To: <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Message-ID: <b7dfc9b-74da-5fe2-9060-fd36eb636c6@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com> <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com> <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
 <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-376779887-1686747778=:3473"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-376779887-1686747778=:3473
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 1 Jun 2023, Shaopeng Tan (Fujitsu) wrote:
> > > > When reading memory in order, HW prefetching optimizations will
> > > > interfere with measuring how caches and memory are being accessed.
> > > > This adds noise into the results.
> > > >
> > > > Change the fill_buf reading loop to not use an obvious in-order
> > > > access using multiply by a prime and modulo.
> > > >
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  tools/testing/selftests/resctrl/fill_buf.c | 17 ++++++++++-------
> > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> > > > b/tools/testing/selftests/resctrl/fill_buf.c
> > > > index 7e0d3a1ea555..049a520498a9 100644
> > > > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > > > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > > > @@ -88,14 +88,17 @@ static void *malloc_and_init_memory(size_t s)
> > > >
> > > >  static int fill_one_span_read(unsigned char *start_ptr, unsigned
> > > > char
> > > > *end_ptr)  {
> > > > -	unsigned char sum, *p;
> > > > -
> > > > +	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
> > > > +	unsigned int count = size;
> > > > +	unsigned char sum;
> > > > +
> > > > +	/*
> > > > +	 * Read the buffer in an order that is unexpected by HW prefetching
> > > > +	 * optimizations to prevent them interfering with the caching pattern.
> > > > +	 */
> > > >  	sum = 0;
> > > > -	p = start_ptr;
> > > > -	while (p < end_ptr) {
> > > > -		sum += *p;
> > > > -		p += (CL_SIZE / 2);
> > > > -	}
> > > > +	while (count--)
> > > > +		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
> > >
> > > Could you please elaborate why 59 is used?
> > 
> > The main reason is that it's a prime number ensuring the whole buffer gets read.
> > I picked something that doesn't make it to wrap on almost every iteration.
> 
> Thanks for your explanation. It seems there is no problem.
> 
> Perhaps you have already tested this patch in your environment and got a test result of "ok". 
> Because HW prefetching does not work well,
> the IMC counter fluctuates a lot in my environment,
> and the test result is "not ok". 
> 
> In order to ensure this test set runs in any environments and gets "ok",
> would you consider changing the value of MAX_DIFF_PERCENT of each test?
> or changing something else?
> 
> ```
> Environment:
>  Kernel: 6.4.0-rc2
>  CPU: Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz
> 
> Test result(MBM as an example):
> # # Starting MBM BW change ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Benchmark PID: 8671
> # # Writing benchmark parameters to resctrl FS
> # # Write schema "MB:0=100" to resctrl FS
> # # Checking for pass/fail
> # # Fail: Check MBM diff within 5%
> # # avg_diff_per: 9%
> # # Span in bytes: 262144000
> # # avg_bw_imc: 6202
> # # avg_bw_resc: 5585
> # not ok 1 MBM: bw change
> ```

Could you try if the approach below works better (I think it should apply 
cleanly on top of the fixes+cleanups v3 series which you recently tested, 
no need to have the other CAT test changes).

The biggest difference in terms of result stability my tests come from 
these factors:
- Removed reversed index order.
- Open-coded the modulo in the loop to subtraction.

In addition, I changed the prime to one which works slightly better than 
59. The MBM/MBA results were already <5% with 59 too due to the other two 
changes, but using 23 lowered them further in my tests (with Platinum 
8260L).

---
From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[PATCH] selftests/resctrl: Read in less obvious order to defeat prefetch optimizations

When reading memory in order, HW prefetching optimizations will
interfere with measuring how caches and memory are being accessed. This
adds noise into the results.

Change the fill_buf reading loop to not use an obvious in-order access
using multiply by a prime and modulo.

Using a prime multiplier with modulo ensures the entire buffer is
eventually read. 23 is small enough that the reads are spread out but
wrapping does not occur very frequently (wrapping too often can trigger
L2 hits more frequently which causes noise to the test because getting
the data from LLC is not required).

It was discovered that not all primes work equally well and some can
cause wildly unstable results (e.g., in an earlier version of this
patch, the reads were done in reversed order and 59 was used as the
prime resulting in unacceptably high and unstable results in MBA and
MBM test on some architectures).

Link: https://lore.kernel.org/linux-kselftest/TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 tools/testing/selftests/resctrl/fill_buf.c | 38 +++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index f9893edda869..afde37d3fca0 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -74,16 +74,38 @@ static void *malloc_and_init_memory(size_t buf_size)
 	return p;
 }
 
+/*
+ * Buffer index step advance to workaround HW prefetching interfering with
+ * the measurements.
+ *
+ * Must be a prime to step through all indexes of the buffer.
+ *
+ * Some primes work better than others on some architectures (from MBA/MBM
+ * result stability point of view).
+ */
+#define FILL_IDX_MULT	23
+
 static int fill_one_span_read(unsigned char *buf, size_t buf_size)
 {
-	unsigned char *end_ptr = buf + buf_size;
-	unsigned char sum, *p;
-
-	sum = 0;
-	p = buf;
-	while (p < end_ptr) {
-		sum += *p;
-		p += (CL_SIZE / 2);
+	unsigned int size = buf_size / (CL_SIZE / 2);
+	unsigned int i, idx = 0;
+	unsigned char sum = 0;
+
+	/*
+	 * Read the buffer in an order that is unexpected by HW prefetching
+	 * optimizations to prevent them interfering with the caching pattern.
+	 *
+	 * The read order is (in terms of halves of cachelines):
+	 *	i * FILL_IDX_MULT % size
+	 * The formula is open-coded below to avoiding modulo inside the loop
+	 * as it improves MBA/MBM result stability on some architectures.
+	 */
+	for (i = 0; i < size; i++) {
+		sum += buf[idx * (CL_SIZE / 2)];
+
+		idx += FILL_IDX_MULT;
+		while (idx >= size)
+			idx -= size;
 	}
 
 	return sum;

-- 
tg: (68d2d0512b91..) refactor/read-fuzzing (depends on: refactor/remove-test-globals)
--8323329-376779887-1686747778=:3473--
