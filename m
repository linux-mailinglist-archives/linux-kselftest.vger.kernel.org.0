Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC0717B9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjEaJRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjEaJRy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 05:17:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B668124;
        Wed, 31 May 2023 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685524672; x=1717060672;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bmNwWz+Sl3NGLRCdcR2hGpS3AQE5LBSVmGQYcIBJFS4=;
  b=X1ONqH5Xc1B2PqUZTLRLimF4Yb4beDk7PEuqGUFBh9G6cig+CvkzQKU+
   RtCpbkNjZLDSek8R85SA8jGWIRejvMOki2h2yuauZN9Rdw0oroC5kRUkt
   NYg9eexrKD5dTQVXltf4LElhlW5BAIjOCvKAvqiVJdje+JvlTRRRr6dDX
   Bs8ysUhRUBOLaQxaidGzSPI1umggzrZGmIj+uX8gODTEiPl/2CV5Z89Zz
   kpbiITBEbrpBasltPiSbIqhKxX62k2ZEgjp2xLMU9K23xBc9J0wYCqMqR
   WWP1bVEkSicTu0PYxPPzq3Cne6T8EjnXeEXG662u4Jgmqc8s49A/7mCrD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="352680551"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="352680551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="851139174"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="851139174"
Received: from lmmelle-mobl1.ger.corp.intel.com ([10.252.47.216])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:17:44 -0700
Date:   Wed, 31 May 2023 12:17:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
In-Reply-To: <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
Message-ID: <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com> <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-566315524-1685524665=:5379"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-566315524-1685524665=:5379
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 31 May 2023, Shaopeng Tan (Fujitsu) wrote:

> Hi Ilpo,
> 
> > When reading memory in order, HW prefetching optimizations will interfere
> > with measuring how caches and memory are being accessed. This adds noise
> > into the results.
> > 
> > Change the fill_buf reading loop to not use an obvious in-order access using
> > multiply by a prime and modulo.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/fill_buf.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> > b/tools/testing/selftests/resctrl/fill_buf.c
> > index 7e0d3a1ea555..049a520498a9 100644
> > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > @@ -88,14 +88,17 @@ static void *malloc_and_init_memory(size_t s)
> > 
> >  static int fill_one_span_read(unsigned char *start_ptr, unsigned char
> > *end_ptr)  {
> > -	unsigned char sum, *p;
> > -
> > +	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
> > +	unsigned int count = size;
> > +	unsigned char sum;
> > +
> > +	/*
> > +	 * Read the buffer in an order that is unexpected by HW prefetching
> > +	 * optimizations to prevent them interfering with the caching pattern.
> > +	 */
> >  	sum = 0;
> > -	p = start_ptr;
> > -	while (p < end_ptr) {
> > -		sum += *p;
> > -		p += (CL_SIZE / 2);
> > -	}
> > +	while (count--)
> > +		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
>
> Could you please elaborate why 59 is used?

The main reason is that it's a prime number ensuring the whole buffer 
gets read. I picked something that doesn't make it to wrap on almost 
every iteration.

-- 
 i.

--8323329-566315524-1685524665=:5379--
