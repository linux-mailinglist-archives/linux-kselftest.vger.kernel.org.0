Return-Path: <linux-kselftest+bounces-1354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA18089CA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0F1C20AC8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61AD41206;
	Thu,  7 Dec 2023 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx0NFVnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259310C2;
	Thu,  7 Dec 2023 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701957852; x=1733493852;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sQ3VPlHWz03Xl+CmKdb7cfnD+1sqirMdhZ7aUAJOLcI=;
  b=dx0NFVnxmjHsMraKtyFHMB5OgbdBxW2XQmX5nMTfGfyzPY1+lfXf1fs1
   rsE1L15sM5aa0deNTZTr+Td8Exmkhznb8uu0cC2oPMDx2VeQs/T0gVgc2
   Wbk+oNEDm/klJJ6YmAJgP4utkX3r5+aPwNev0ONabZDZIt4PUrq1HfZE4
   h/8DbjP6H+2yJziVH2VwuzNwr/CucJxTGWAas7zBcpWzr7uoxXMQsSB2L
   d6Zd495ff8PDfFNiCfh1rLCuscq9z+iLNjYN5ymP+8LlPcITcugJZIeps
   7BTVlLxNS110A6fDcvNtsfCLa0QkQGTf2OtoqSPeke61dpPC8GgttTZv6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397024582"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="397024582"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19709866"
Received: from dkrupnov-mobl3.ger.corp.intel.com ([10.249.34.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:04:10 -0800
Date: Thu, 7 Dec 2023 16:04:07 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/26] selftests/resctrl: Split fill_buf to allow
 tests finer-grained control
In-Reply-To: <356eb613-a380-4389-96d3-f2667b7d18d3@intel.com>
Message-ID: <4ad2d41-9d65-e2ae-ade8-6d38dd4cbd81@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-3-ilpo.jarvinen@linux.intel.com> <356eb613-a380-4389-96d3-f2667b7d18d3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1882619583-1701957851=:1765"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1882619583-1701957851=:1765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > MBM, MBA and CMT test cases call run_fill_buf() that in turn calls
> > fill_cache() to alloc and loop indefinitely around the buffer. This
> > binds buffer allocation and running the benchmark into a single bundle
> > so that a selftest cannot allocate a buffer once and reuse it. CAT test
> > doesn't want to loop around the buffer continuously and after rewrite
> > it needs the ability to allocate the buffer separately.
> > 
> > Split buffer allocation out of fill_cache() into alloc_buffer(). This
> > change is part of preparation for the new CAT test that allocates a
> > buffer and does multiple passes over the same buffer (but not in an
> > infinite loop).
> > 
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> 
> Could you please list the changes to a patch in this area instead of
> lumping all in the cover letter? Without this it is not clear what,
> if anything, changed in the new version.

Okay, I'll try to keep them per patch.

> > +static int fill_cache(size_t buf_size, int memflush, int op, bool once)
> > +{
> > +	unsigned char *buf;
> > +	int ret;
> > +
> > +	buf = alloc_buffer(buf_size, memflush);
> > +	if (!buf)
> > +		return -1;
> > +
> >  	if (op == 0)
> >  		ret = fill_cache_read(buf, buf_size, once);
> >  	else
> >  		ret = fill_cache_write(buf, buf_size, once);
> > -
> >  	free(buf);
> >  
> > -	if (ret) {
> > -		printf("\n Error in fill cache read/write...\n");
> > -		return -1;
> > -	}
> > -
> 
> The changelog does not motivate the removal of this error message.
> It seems ok at this point since the only failing functions already
> print their own error message. Without a motivation of this change
> it is not clear if it is actually intended.

Hi,

I don't have recollection of how it ended up into this patch as it's so 
long time ago already... But in any case, it naturally seemed to fit into 
the next patch that removes the extra call level so I moved the removal 
of the duplicated error printout to that patch instead.

> In any case, this looks good.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


-- 
 i.

--8323329-1882619583-1701957851=:1765--

