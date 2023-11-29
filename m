Return-Path: <linux-kselftest+bounces-815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B806B7FD536
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E6A1F20E0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6501C28A;
	Wed, 29 Nov 2023 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TisVpBge"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 03:12:52 PST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D282113;
	Wed, 29 Nov 2023 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701256373; x=1732792373;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mH0FS1PLtuPl2wqA0IuYz8tUlWqy6R9bNKMXpWxQdbg=;
  b=TisVpBget2nvD0BtphitsUgNhKnTdaeA6iGV11VTTP9VpvOZWJ96Cqix
   FzW9l0BRp5ISoZa2wz4/AyCUnTlSEjjTMCPbX/fi5tnMbqOyDbuoPWEaT
   SVTpIoVdXvQmXhkvcfJHbtpgPhmriYrbriVzqsAk07CL7O5KpeLmM5Ww2
   b7Q9YSGeCXRbdtCYCvfDVWcgwQTUBMXbDwNualOo+MeU9wP9K220et95D
   RTZ/m2Jt8UV+RpP5UcRVHSVhpy6ukNiLkqQYohrPuLjFoWGw6gy8hHm6v
   M4XLtcSylbcafTApy/BIXVu4gJd4TOx8bUfinAaI79JewJMGW/FVVerfa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="133836"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="133836"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="17172215"
Received: from akuporos-mobl.ger.corp.intel.com ([10.251.221.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:11:47 -0800
Date: Wed, 29 Nov 2023 13:11:44 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 26/26] selftests/resctrl: Add test groups and name L3
 CAT test L3_CAT
In-Reply-To: <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
Message-ID: <ca49fc8f-f9f7-138f-ff2f-60f754525df7@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com> <20231120111340.7805-27-ilpo.jarvinen@linux.intel.com> <2787018d-9661-4169-9571-a4016691cfa6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1781121945-1701256309=:1861"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1781121945-1701256309=:1861
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Nov 2023, Reinette Chatre wrote:
> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> > To select test to run -t parameter can be used. However, -t cat
> > currently maps to L3 CAT test which is confusing after more CAT related
> > tests are added.
> > 
> > Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
> > group will enable all CAT related tests.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> 
> Could you please defer this patch to accompany the series that
> introduces other CAT related tests?

Can be done but it implies Maciej non-continuous CAT test series would 
still be blocked by the lack of this feature which is why I included it 
here.

But perhaps Maciej wants to take this patch and submit it as a part of his 
series. Maciej, are you okay with that change of patch ownership?


-- 
 i.

--8323329-1781121945-1701256309=:1861--

