Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CF717C0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjEaJgD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjEaJgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 05:36:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49591A0;
        Wed, 31 May 2023 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685525761; x=1717061761;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BG2P5coF07HaCoqHETSci75bZseZ6QHu+Z4ErTpZr2U=;
  b=a+F1+bFRUVgcb2IzqA2PVxO9gi5wRIpQzR43N1EV5W59ae2RVnKrEDrN
   pYwlkztypbTfXoihJgHqloqn6/sPfRMaJhZY3BPM5GgkNH4VVJUclw4Kr
   xM22PiccHi5spZABrhR1geGcJbRFR6ZNcZvkt1PJPA28QPzfLC4JU+tjZ
   e0gO6uP7Fguid3XErEkW2FrOjzrpl9IJ4Vrp+w0RJdZ6KmZFwm+JPrukd
   Mub1+uVST+GNVXd2/b4+TQgqXZqq8LFrb429nq7UjfJHr/eWGyCUUMK9G
   5pxqJWmhgR9FRGwx2D1XN9Q6CsJZsZTPUJnFRSnKAOH2SQIR+2VJ5pH5i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420953181"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="420953181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036981114"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036981114"
Received: from lmmelle-mobl1.ger.corp.intel.com ([10.252.47.216])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 02:35:58 -0700
Date:   Wed, 31 May 2023 12:35:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 17/24] selftests/resctrl: Replace count_bits with
 count_consecutive_bits()
In-Reply-To: <OSZPR01MB6328A57213FA4E13C21F91D18B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
Message-ID: <9043c594-68c2-b73e-2bad-c2506f206259@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-18-ilpo.jarvinen@linux.intel.com> <OSZPR01MB6328A57213FA4E13C21F91D18B489@OSZPR01MB6328.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-423328003-1685525760=:5379"
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

--8323329-423328003-1685525760=:5379
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 31 May 2023, Shaopeng Tan (Fujitsu) wrote:

> Hi Ilpo,
> 
> > CAT and CMT tests depends on masks being continuous.
> > 
> > Replace count_bits with more appropriate variant that counts consecutive bits.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---

> > @@ -218,6 +220,34 @@ static int get_bit_mask(char *filename, unsigned long
> > *mask)
> >  	return 0;
> >  }
> > 
> > +/*
> > + * count_consecutive_bits - Returns the longest train of bits in a bit mask
> > + * @val		A bit mask
> > + * @start	The location of the least-significant bit of the longest train
> > + *
> > + * Return:	The length of the consecutive bits in the longest train of bits
> > + */
> > +unsigned int count_consecutive_bits(unsigned long val, unsigned int
> > +*start) {
> > +	unsigned long last_val;
> > +	int count = 0;
> > +
> > +	while (val) {
> > +		last_val = val;
> > +		val &= (val >> 1);
> > +		count++;
> > +	}
> 
> There may not be a case that the most-significant bit is 1 at present, 
> but if this case exists, it cannot count correctly.

Can you please rephrase what is your concern here please?

I test 0U, 1U, ~0U, and a few more complex combinations of bits, and all 
returned correct count so I might not have understood what case you meant 
with your description.

This function does not count nor calculate the most-significant bit in
any phase but the longest train of bits using the count variable (and the 
least-significant bit of the longest train in the code that is not 
included into this partial snippet).

-- 
 i.

--8323329-423328003-1685525760=:5379--
