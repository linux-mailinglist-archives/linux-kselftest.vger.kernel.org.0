Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7F7D97A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0MSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbjJ0MSP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:18:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47A121;
        Fri, 27 Oct 2023 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698409093; x=1729945093;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6l46F4HRC2paRPeWRlB0FMlwAAK+TWqvJ+qzgL9f2nU=;
  b=oKzb+qqUfAP1ttmkzOkYN32QZuk1A+qM3+Wsfi6fRLgf8J3DEUZsLvO0
   K7zcPiFtzMls+qoVZj3Cv8C5QBAqnV7iYHMySUFRNuztWYeaeJ8mT1eyc
   JtpUTPpgTfyk7PxXLCt2+r0peGBu8FALzvKDbMtahwPQ8I/wDPV+KuB0g
   G+6+fux4rQiCyeS/E7/joqjv6+CEWuzLNH8SEkCMrtc5XlA9dLWyhOBFx
   vXwVqGaNgTdVxcwPb13XkiKmQBHpvwLLo/SmJCb1AmZW+/JQOj45smkRX
   BAjRpm3ucuS7NoU2yeOVZ7OoEaP27doe/I3koerRJldBHgs8u1LKmL3cJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384972813"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="384972813"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="759577201"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="759577201"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:18:10 -0700
Date:   Fri, 27 Oct 2023 15:18:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/24] selftests/resctrl: Move cat_val() to cat_test.c
 and rename to cat_test()
In-Reply-To: <5x3wlnejagee5hbigjo6dpvbc5453gnaab4ue6doplneumfgzd@q7yo3j3prh2h>
Message-ID: <84d4d30-72f6-f09d-95bc-8861b6686a81@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-15-ilpo.jarvinen@linux.intel.com> <5x3wlnejagee5hbigjo6dpvbc5453gnaab4ue6doplneumfgzd@q7yo3j3prh2h>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1936397613-1698409092=:2740"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1936397613-1698409092=:2740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-24 at 12:26:24 +0300, Ilpo Järvinen wrote:
> >diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> >index 2106cc3601d9..e71690a9bbb3 100644
> >--- a/tools/testing/selftests/resctrl/cat_test.c
> >+++ b/tools/testing/selftests/resctrl/cat_test.c
> >@@ -111,6 +111,77 @@ void cat_test_cleanup(void)
> > 	remove(RESULT_FILE_NAME2);
> > }
> > 
> >+/*
> >+ * cat_test:	execute CAT benchmark and measure LLC cache misses
> >+ * @param:	parameters passed to cat_test()
> >+ * @span:	buffer size for the benchmark
> >+ *
> >+ * Return:	0 on success. non-zero on failure.
> >+ */
> >+static int cat_test(struct resctrl_val_param *param, size_t span)
> >+{
> >+	int memflush = 1, operation = 0, ret = 0;
> >+	char *resctrl_val = param->resctrl_val;
> >+	static struct perf_event_read pe_read;
> 
> Is there a reason why this struct is declared as static?

Good catch.

I'll change the earlier patch which made the global -> local var move and 
failed to remove the static keyword.

-- 
 i.

--8323329-1936397613-1698409092=:2740--
