Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3785077CAA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbjHOJnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbjHOJme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 05:42:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C30D1BDF;
        Tue, 15 Aug 2023 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692092537; x=1723628537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=OTKa2DU5uLIfglQn+15YxSLcT/W/rPMm7HdupfRTTQE=;
  b=csex3Cil3phXGXx4wsOFOITLKwncY37jgxxdSk1FdMYOXtWWX8InDezo
   PSfwcGeVO7cFnPV8RPyPBEJ7vVr6bS2d4cnEF9qgRuuYra0m4J0VFDJg9
   5+717h/om50rchgJ5vQkSEUIA5XjR8+AWeGgc4Out+aSprLOZgKf2yu/G
   NfY74xB3O+jaR4VphVSyZLVf8R/jlfSEFfNsiffhZoK47gEwudaY8MdJZ
   PAblfRByMmbcdQt+27Z5ObWOTq9TZ/7jk7nSQxXANgH8x68E6K5pffXKr
   AxI4Sk6O7TQ7NYORiQAeCqLjO8d8SQSWyYBzwz+3ze1HQTeS5SVrfBmQI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403222805"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403222805"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064393692"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="1064393692"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 02:42:13 -0700
Date:   Tue, 15 Aug 2023 12:42:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark
 cmd and make it const
In-Reply-To: <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
Message-ID: <dd83f672-b9fc-cd79-10ff-70651d4822af@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com> <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com> <f300a52c-d65f-fd74-18ce-7d37e76d144f@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-560072619-1692090068=:1736"
Content-ID: <651bd820-3777-d413-5647-70f899ee13b@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-560072619-1692090068=:1736
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c91af58e-624a-59f5-5f95-7dbdcaed112f@linux.intel.com>

On Mon, 14 Aug 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 8/8/2023 2:16 AM, Ilpo Järvinen wrote:
> > Benchmark parameter uses fixed-size buffers in stack which is slightly
> > dangerous. As benchmark command is used in multiple tests, it should
> 
> Could you please be specific with issues with current implementation?
> The term "slightly dangerous" is vague.

I've reworded this so this fragment no longer remains here because the 
earlier patch got changes so the dangerous part is no longer there.

> > not be mutated by the tests. Due to the order of tests, mutating the
> > span argument in CMT test does not trigger any real problems currently.
> > 
> > Mark benchmark_cmd strings as const and setup the benchmark command
> > using pointers. As span is constant in main(), just provide the default
> > span also as string to be used in setting up the default fill_buf
> > argument so no malloc() is required for it.
> 
> What is wrong with using malloc()?

Nothing. I think you slightly misunderstood what I meant here.

The main challenge is not malloc() itself but keeping track of what memory 
has been dynamically allocated, which is simple if nothing has been 
malloc()ed. With the const benchmark command and default span, there's no 
need to malloc(), thus I avoid it to keep things simpler on the free() 
side.

I've tried to reword the entire changelog, please check the v2 changelog 
once I post it.

> > CMT test has to create a copy of the benchmark command before altering
> > the benchmark command.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cmt_test.c    | 23 ++++++++++---
> >  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
> >  tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
> >  tools/testing/selftests/resctrl/resctrl.h     | 16 ++++++---
> >  .../testing/selftests/resctrl/resctrl_tests.c | 33 ++++++++-----------
> >  tools/testing/selftests/resctrl/resctrl_val.c | 10 ++++--
> >  6 files changed, 54 insertions(+), 32 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> > index 9d8e38e995ef..a40e12c3b1a7 100644
> > --- a/tools/testing/selftests/resctrl/cmt_test.c
> > +++ b/tools/testing/selftests/resctrl/cmt_test.c
> > @@ -68,14 +68,16 @@ void cmt_test_cleanup(void)
> >  	remove(RESULT_FILE_NAME);
> >  }
> >  
> > -int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> > +int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
> >  {
> > +	const char *cmd[BENCHMARK_ARGS];
> >  	unsigned long cache_size = 0;
> >  	unsigned long long_mask;
> > +	char *span_str = NULL;
> >  	char cbm_mask[256];
> >  	int count_of_bits;
> >  	size_t span;
> > -	int ret;
> > +	int ret, i;
> >  
> >  	if (!validate_resctrl_feature_request(CMT_STR))
> >  		return -1;
> > @@ -111,12 +113,22 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
> >  	};
> >  
> >  	span = cache_size * n / count_of_bits;
> > -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
> > -		sprintf(benchmark_cmd[1], "%zu", span);
> > +	/* Duplicate the command to be able to replace span in it */
> > +	for (i = 0; benchmark_cmd[i]; i++)
> > +		cmd[i] = benchmark_cmd[i];
> > +	cmd[i] = NULL;
> > +
> > +	if (strcmp(cmd[0], "fill_buf") == 0) {
> > +		span_str = malloc(SIZE_MAX_DECIMAL_SIZE);
> > +		if (!span_str)
> > +			return -1;
> > +		snprintf(span_str, SIZE_MAX_DECIMAL_SIZE, "%zu", span);
> 
> Have you considered asprintf()?

Changed to asprintf() now.
 
> > +		cmd[1] = span_str;
> > +	}
> 
> It looks to me that array only needs to be duplicated if the
> default benchmark is used?

While it's true, another aspect is how that affects the code flow. If I 
make that change, the benchmark command could come from two different 
places which is now avoided. IMHO, the current approach is simpler to 
understand even if it does the unnecessary copy of a few pointers.

But please let me know if you still prefer the other way around so I can 
change to that.

> >  	remove(RESULT_FILE_NAME);
> >  
> > -	ret = resctrl_val(benchmark_cmd, &param);
> > +	ret = resctrl_val(cmd, &param);
> >  	if (ret)
> >  		goto out;
> >  
> 
> ...
> 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index bcd0d2060f81..ddb1e83a3a64 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -6,6 +6,7 @@
> >  #include <math.h>
> >  #include <errno.h>
> >  #include <sched.h>
> > +#include <stdint.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> >  #include <string.h>
> > @@ -38,7 +39,14 @@
> >  
> >  #define END_OF_TESTS	1
> >  
> > +#define BENCHMARK_ARGS		64
> > +
> > +/* Approximate %zu max length */
> > +#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
> > +
> > +/* Define default span both as integer and string, these should match */
> >  #define DEFAULT_SPAN		(250 * MB)
> > +#define DEFAULT_SPAN_STR	"262144000"
> 
> I think above hardcoding can be eliminated by using asprintf()? This
> does allocate memory though so I would like to understand why one
> goal is to not dynamically allocate memory.

Because it's simpler on the _free() side_. If there's no allocation, no 
free() is needed.

Only challenge that remains is the int -> string conversion for the 
default span which can be either done like in the patch or using some 
preprocessor trickery to convert the number to string. If you prefer the 
latter, I can change to that so it's not hardcoded both as int and string.

-- 
 i.
--8323329-560072619-1692090068=:1736--
