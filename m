Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9F8717BCE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjEaJYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbjEaJYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 05:24:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B47135;
        Wed, 31 May 2023 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685525054; x=1717061054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3A0nFD+iW5TXQdGvTvUeIW6T4lAHiDVt8M+6Ydf9vxw=;
  b=nM0TJhedQLXPb12Stnu5o43iRtg7PofkW0PiB+zKJAE1VdLeGDa0Ey0g
   7dW2nmZUmN1FfWxtS8jwMvcfcvVfAGbc6k6pv1yhIBbUe3AI6mROm78qu
   Q6GEtp9l2cazj2BLaV1hUmCqwxZuVz1AkijEGQgTfLudXpkhkfOlfXCO0
   5vxNMA+NFUndHiBHupTgolV7IC6AHM2UqAPHdgAF56pR6kyPr4Xd+Bejj
   Dre50nnecbqYXe+WBAm+1xPEO3aE5jUGt+td6Kkd91x9CBwlg4nl0d3sq
   l1erXpOJNW34CDh4VSsp9dyjAsQ/EZfoaxqRy6gOeKgRqZrqjtQUBuHeX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339780323"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339780323"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953554998"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="953554998"
Received: from lmmelle-mobl1.ger.corp.intel.com ([10.252.47.216])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:24:11 -0700
Date:   Wed, 31 May 2023 12:24:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 15/24] selftests/resctrl: Refactor get_cbm_mask()
In-Reply-To: <OSZPR01MB63280E04EDAE0CCB21B591978B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
Message-ID: <d669f683-24c2-5e12-ea4f-65a0948b3423@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-16-ilpo.jarvinen@linux.intel.com> <OSZPR01MB63280E04EDAE0CCB21B591978B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-126042495-1685525053=:5379"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-126042495-1685525053=:5379
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 31 May 2023, Shaopeng Tan (Fujitsu) wrote:

> Hi Ilpo,
> 
> > Callers of get_cbm_mask() are required to pass a string into which the CBM bit
> > mask is read into. Neither CAT nor CMT tests need the mask as string but just
> > convert it into an unsigned long value.
> > 
> > The bit mask reader can only read .../cbm_mask files.
> > 
> > Generalize the bit mask reading function into get_bit_mask() such that it can
> > be used to handle other files besides the .../cbm_mask and handle the
> > unsigned long conversion within within get_bit_mask() using fscanf(). Alter
> > get_cbm_mask() to construct the filename for get_bit_mask().
> > 
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cat_test.c  |  5 +--
> > tools/testing/selftests/resctrl/cmt_test.c  |  5 +--
> >  tools/testing/selftests/resctrl/resctrl.h   |  2 +-
> >  tools/testing/selftests/resctrl/resctrlfs.c | 50 +++++++++++++++------
> >  4 files changed, 40 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cat_test.c
> > b/tools/testing/selftests/resctrl/cat_test.c
> > index a998e6397518..9bf5d05d9e74 100644
> > --- a/tools/testing/selftests/resctrl/cat_test.c
> > +++ b/tools/testing/selftests/resctrl/cat_test.c
> > @@ -18,7 +18,6 @@
> >  #define MAX_DIFF		1000000
> > 
> >  static int count_of_bits;
> > -static char cbm_mask[256];
> >  static unsigned long long_mask;
> >  static unsigned long cache_size;
> > 
> > @@ -101,12 +100,10 @@ int cat_perf_miss_val(int cpu_no, int n, char
> > *cache_type)
> >  	cache_size = 0;
> > 
> >  	/* Get default cbm mask for L3/L2 cache */
> > -	ret = get_cbm_mask(cache_type, cbm_mask);
> > +	ret = get_cbm_mask(cache_type, &long_mask);
> >  	if (ret)
> >  		return ret;
> > 
> > -	long_mask = strtoul(cbm_mask, NULL, 16);
> > -
> >  	/* Get L3/L2 cache size */
> >  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
> >  	if (ret)
> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c
> > b/tools/testing/selftests/resctrl/cmt_test.c
> > index 2d434c03cbba..ae54bbabbd91 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -17,7 +17,6 @@
> >  #define MAX_DIFF_PERCENT	15
> > 
> >  static int count_of_bits;
> > -static char cbm_mask[256];
> >  static unsigned long long_mask;
> >  static unsigned long cache_size;
> > 
> > @@ -82,12 +81,10 @@ int cmt_resctrl_val(int cpu_no, int n, char
> > **benchmark_cmd)
> >  	if (!validate_resctrl_feature_request(CMT_STR))
> >  		return -1;
> > 
> > -	ret = get_cbm_mask("L3", cbm_mask);
> > +	ret = get_cbm_mask("L3", &long_mask);
> >  	if (ret)
> >  		return ret;
> > 
> > -	long_mask = strtoul(cbm_mask, NULL, 16);
> > -
> >  	ret = get_cache_size(cpu_no, "L3", &cache_size);
> >  	if (ret)
> >  		return ret;
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h
> > b/tools/testing/selftests/resctrl/resctrl.h
> > index ba36eb5fdf0d..bcc95faa5b4e 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -106,7 +106,7 @@ void tests_cleanup(void);  void
> > mbm_test_cleanup(void);  int mba_schemata_change(int cpu_no, char
> > *bw_report, char **benchmark_cmd);  void mba_test_cleanup(void); -int
> > get_cbm_mask(char *cache_type, char *cbm_mask);
> > +int get_cbm_mask(char *cache_type, unsigned long *mask);
> >  int get_cache_size(int cpu_no, char *cache_type, unsigned long
> > *cache_size);  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);  int
> > signal_handler_register(void); diff --git
> > a/tools/testing/selftests/resctrl/resctrlfs.c
> > b/tools/testing/selftests/resctrl/resctrlfs.c
> > index 7fef9068d7fd..f01ecfa64063 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -186,30 +186,29 @@ int get_cache_size(int cpu_no, char *cache_type,
> > unsigned long *cache_size)
> >  #define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
> > 
> >  /*
> > - * get_cbm_mask - Get cbm mask for given cache
> > - * @cache_type:	Cache level L2/L3
> > - * @cbm_mask:	cbm_mask returned as a string
> > + * get_bit_mask - Get bit mask from given file
> > + * @filename:	File containing the mask
> > + * @mask:	The bit mask returned as unsigned long
> >   *
> >   * Return: = 0 on success, < 0 on failure.
> >   */
> > -int get_cbm_mask(char *cache_type, char *cbm_mask)
> > +static int get_bit_mask(char *filename, unsigned long *mask)
> >  {
> > -	char cbm_mask_path[1024];
> >  	FILE *fp;
> > 
> > -	if (!cbm_mask)
> > +	if (!filename || !mask)
> >  		return -1;
> > 
> > -	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH,
> > cache_type);
> > -
> > -	fp = fopen(cbm_mask_path, "r");
> > +	fp = fopen(filename, "r");
> >  	if (!fp) {
> > -		perror("Failed to open cache level");
> > -
> > +		fprintf(stderr, "Failed to open bit mask file '%s': %s\n",
> > +			filename, strerror(errno));
> >  		return -1;
> >  	}
> > -	if (fscanf(fp, "%s", cbm_mask) <= 0) {
> > -		perror("Could not get max cbm_mask");
> > +
> > +	if (fscanf(fp, "%lx", mask) <= 0) {
> > +		fprintf(stderr, "Could not read bit mask file '%s': %s\n",
> > +			filename, strerror(errno));
> >  		fclose(fp);
> > 
> >  		return -1;
> > @@ -219,6 +218,31 @@ int get_cbm_mask(char *cache_type, char
> > *cbm_mask)
> >  	return 0;
> >  }
> > 
> > +/*
> > + * get_cbm_bits - Get number of bits in cbm mask
>
> Is it get_cbm_mask?

Sure, thanks for noticing this. While correcting it, I also improved the 
description to match what the function now does.

-- 
 i.

--8323329-126042495-1685525053=:5379--
