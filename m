Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEF7327CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFPGoj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFPGoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 02:44:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C22126;
        Thu, 15 Jun 2023 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686897877; x=1718433877;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FJoTseXXC/qmF5H2VbRQGIgWDiytlRvus0qimHzAX3E=;
  b=Gj3HSRBzUi6aMRATEskQUzT88vleOPTtJLAnQplhZo/+qGO+WpCruLCk
   hPiQLrlqmkTPw1/PefhXIXg2AYVhoPGMRDLxd4ZS9Fi5HsevXTKHPV4+l
   MLYR0cZzr+UxKjJABfCmQxh9N/DnpDLB3AZYVNVZsVVcmwREXKZQRl9Oe
   enysS6inEhLLjewooqYOb3GkcFxRAZqp9eXngmOnvr/djw7X7m0frmLzL
   m36AY4h3ZrQDgaIp6F9eFa3Wvt0h8W91B5+UUsKX2m7/CuHSd9vVZXgIY
   RFMRGHpL0jTFOnArlWOWY97UFjrMi6KmPxD7XnTidOoVuWIh2Aa40Niit
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348853286"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="348853286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042989003"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="1042989003"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.211.240])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:44:34 -0700
Date:   Fri, 16 Jun 2023 09:44:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
In-Reply-To: <TYAPR01MB633074204B37B91216FA13468B58A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Message-ID: <66876a5-2513-1271-dfce-b11b2eb2b832@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com> <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com> <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
 <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com> <b7dfc9b-74da-5fe2-9060-fd36eb636c6@linux.intel.com> <TYAPR01MB633074204B37B91216FA13468B58A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1657206240-1686897876=:3967"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1657206240-1686897876=:3967
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 16 Jun 2023, Shaopeng Tan (Fujitsu) wrote:

> Hi Ilpo,
> 
> > On Thu, 1 Jun 2023, Shaopeng Tan (Fujitsu) wrote:
> > > > > > When reading memory in order, HW prefetching optimizations will
> > > > > > interfere with measuring how caches and memory are being accessed.
> > > > > > This adds noise into the results.
> > > > > >
> > > > > > Change the fill_buf reading loop to not use an obvious in-order
> > > > > > access using multiply by a prime and modulo.
> > > > > >
> > > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/resctrl/fill_buf.c | 17
> > > > > > ++++++++++-------
> > > > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> > > > > > b/tools/testing/selftests/resctrl/fill_buf.c
> > > > > > index 7e0d3a1ea555..049a520498a9 100644
> > > > > > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > > > > > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > > > > > @@ -88,14 +88,17 @@ static void *malloc_and_init_memory(size_t
> > > > > > s)
> > > > > >
> > > > > >  static int fill_one_span_read(unsigned char *start_ptr,
> > > > > > unsigned char
> > > > > > *end_ptr)  {
> > > > > > -	unsigned char sum, *p;
> > > > > > -
> > > > > > +	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
> > > > > > +	unsigned int count = size;
> > > > > > +	unsigned char sum;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Read the buffer in an order that is unexpected by HW
> > prefetching
> > > > > > +	 * optimizations to prevent them interfering with the caching
> > pattern.
> > > > > > +	 */
> > > > > >  	sum = 0;
> > > > > > -	p = start_ptr;
> > > > > > -	while (p < end_ptr) {
> > > > > > -		sum += *p;
> > > > > > -		p += (CL_SIZE / 2);
> > > > > > -	}
> > > > > > +	while (count--)
> > > > > > +		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
> > > > >
> > > > > Could you please elaborate why 59 is used?
> > > >
> > > > The main reason is that it's a prime number ensuring the whole buffer gets
> > read.
> > > > I picked something that doesn't make it to wrap on almost every iteration.
> > >
> > > Thanks for your explanation. It seems there is no problem.
> > >
> > > Perhaps you have already tested this patch in your environment and got a test
> > result of "ok".
> > > Because HW prefetching does not work well, the IMC counter fluctuates
> > > a lot in my environment, and the test result is "not ok".
> > >
> > > In order to ensure this test set runs in any environments and gets
> > > "ok", would you consider changing the value of MAX_DIFF_PERCENT of
> > each test?
> > > or changing something else?
> > >
> > > ```
> > > Environment:
> > >  Kernel: 6.4.0-rc2
> > >  CPU: Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz
> > >
> > > Test result(MBM as an example):
> > > # # Starting MBM BW change ...
> > > # # Mounting resctrl to "/sys/fs/resctrl"
> > > # # Benchmark PID: 8671
> > > # # Writing benchmark parameters to resctrl FS # # Write schema
> > > "MB:0=100" to resctrl FS # # Checking for pass/fail # # Fail: Check
> > > MBM diff within 5% # # avg_diff_per: 9% # # Span in bytes: 262144000 #
> > > # avg_bw_imc: 6202 # # avg_bw_resc: 5585 # not ok 1 MBM: bw change ```
> > 
> > Could you try if the approach below works better (I think it should apply cleanly
> > on top of the fixes+cleanups v3 series which you recently tested, no need to
> > have the other CAT test changes).
> 
> I ran the test set several times. 
> MBA and MBM seem fine, but CAT is always "not ok".
> The result is below.

Ok, thanks a lot for confirming. I was just interested to see MBA/MBM test 
results.

I'm not surprised the old CAT test is failing with "not ok". I see it 
occurring quite often with the old CAT test. It is one of the reasons why 
it is being rewritten, although the main motivator is that the old one 
doesn't really even test CAT because it flushes LLC and reads the 
buffer only once after the flush.

The rewritten CAT test should work better in this regard but it was not 
among fixes+cleanups series (v3) + this patch.


-- 
 i.


> ---
> $ sudo make -C tools/testing/selftests/resctrl run_tests
> make: Entering directory '/**/tools/testing/selftests/resctrl'
> TAP version 13
> 1..1
> # selftests: resctrl: resctrl_tests
> # TAP version 13
> # # Pass: Check kernel supports resctrl filesystem
> # # Pass: Check resctrl mountpoint "/sys/fs/resctrl" exists
> # # resctrl filesystem not mounted
> # # dmesg: [    3.658029] resctrl: L3 allocation detected
> # # dmesg: [    3.658420] resctrl: MB allocation detected
> # # dmesg: [    3.658604] resctrl: L3 monitoring detected
> # 1..4
> # # Starting MBM BW change ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Benchmark PID: 9555
> # # Writing benchmark parameters to resctrl FS
> # # Write schema "MB:0=100" to resctrl FS
> # # Checking for pass/fail
> # # Pass: Check MBM diff within 5%
> # # avg_diff_per: 0%
> # # Span (MB): 250
> # # avg_bw_imc: 6880
> # # avg_bw_resc: 6895
> # ok 1 MBM: bw change
> # # Starting MBA Schemata change ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Benchmark PID: 9561
> # # Writing benchmark parameters to resctrl FS
> # # Write schema "MB:0=100" to resctrl FS
> # # Write schema "MB:0=90" to resctrl FS
> # # Write schema "MB:0=80" to resctrl FS
> # # Write schema "MB:0=70" to resctrl FS
> # # Write schema "MB:0=60" to resctrl FS
> # # Write schema "MB:0=50" to resctrl FS
> # # Write schema "MB:0=40" to resctrl FS
> # # Write schema "MB:0=30" to resctrl FS
> # # Write schema "MB:0=20" to resctrl FS
> # # Write schema "MB:0=10" to resctrl FS
> # # Results are displayed in (MB)
> # # Pass: Check MBA diff within 5% for schemata 100
> # # avg_diff_per: 0%
> # # avg_bw_imc: 6874
> # # avg_bw_resc: 6904
> # # Pass: Check MBA diff within 5% for schemata 90
> # # avg_diff_per: 1%
> # # avg_bw_imc: 6738
> # # avg_bw_resc: 6807
> # # Pass: Check MBA diff within 5% for schemata 80
> # # avg_diff_per: 1%
> # # avg_bw_imc: 6735
> # # avg_bw_resc: 6803
> # # Pass: Check MBA diff within 5% for schemata 70
> # # avg_diff_per: 1%
> # # avg_bw_imc: 6702
> # # avg_bw_resc: 6770
> # # Pass: Check MBA diff within 5% for schemata 60
> # # avg_diff_per: 1%
> # # avg_bw_imc: 6632
> # # avg_bw_resc: 6725
> # # Pass: Check MBA diff within 5% for schemata 50
> # # avg_diff_per: 1%
> # # avg_bw_imc: 6510
> # # avg_bw_resc: 6635
> # # Pass: Check MBA diff within 5% for schemata 40
> # # avg_diff_per: 2%
> # # avg_bw_imc: 6206
> # # avg_bw_resc: 6342
> # # Pass: Check MBA diff within 5% for schemata 30
> # # avg_diff_per: 1%
> # # avg_bw_imc: 3826
> # # avg_bw_resc: 3896
> # # Pass: Check MBA diff within 5% for schemata 20
> # # avg_diff_per: 1%
> # # avg_bw_imc: 2820
> # # avg_bw_resc: 2862
> # # Pass: Check MBA diff within 5% for schemata 10
> # # avg_diff_per: 1%
> # # avg_bw_imc: 1876
> # # avg_bw_resc: 1898
> # # Pass: Check schemata change using MBA
> # ok 2 MBA: schemata change
> # # Starting CMT test ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Cache size :25952256
> # # Benchmark PID: 9573
> # # Writing benchmark parameters to resctrl FS
> # # Checking for pass/fail
> # # Pass: Check cache miss rate within 15%
> # # Percent diff=10
> # # Number of bits: 5
> # # Average LLC val: 12994560
> # # Cache span (bytes): 11796480
> # ok 3 CMT: test
> # # Starting CAT test ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Cache size :25952256
> # # Writing benchmark parameters to resctrl FS
> # # Write schema "L3:0=3f" to resctrl FS
> # # Checking for pass/fail
> # # Fail: Check cache miss rate within 4%
> # # Percent diff=24
> # # Number of bits: 6
> # # Average LLC val: 275418
> # # Cache span (lines): 221184
> # not ok 4 CAT: test
> # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: resctrl: resctrl_tests # exit=1
> make: Leaving directory '/**/tools/testing/selftests/resctrl'


--8323329-1657206240-1686897876=:3967--
