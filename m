Return-Path: <linux-kselftest+bounces-3821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA874843CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A8DB231BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 10:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83469978;
	Wed, 31 Jan 2024 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CZUhsYPG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBB67E7A
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697336; cv=none; b=cw4FIWl1clfBXCyh42Bl0IR/a9lqlK/Cvua7u8h3YRcsY67d7j59QSYfWXGrOOMyow2CZK3q5GHJ6/eI0J5hRO084kCFIHfoIXlITanCR+SJLH4hcDbTHVtzQX7qxpVdOkyLHU5wmFXvKG0esrtze8t2K61VUKh0UXGkLzIErvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697336; c=relaxed/simple;
	bh=hcr8+EObxo70xFMO4+qN4GCqT0KgZ/9uH1qX4M/1tto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jd8pLbWG3fvw6zBLNYkf9ZrmiaF5TP6CVHgnJpx1L4jGYiJri9JXRjmdlAeQknRwtlfOT6Zcp4/5z3+UQibwDl++j3UyNSpT5i8ky2b7dI9GvgMFbFLIpqlQS0mgZXBFJg8kP1EYcKoOwnpKUXOFMg1NKpTMQ8pESAh3wYVcHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CZUhsYPG; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V4reJl002711;
	Wed, 31 Jan 2024 04:35:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=/o2fcNwC0JjuDwvT9ZUEjoZVc33+3CttcxJLvAi6q0Y=; b=
	CZUhsYPGRW9WDwamb6F8JCXQEV5yUh6b2NN094ws0WfjBkx37da5jx89GlXmh2CA
	qygGH2RzLUeAbyjJ45N6lzbSyAivbJgl9sp2rGHjj4dH3Q+CaF4eeQuTipXvBvru
	94NMJnDaL6MRC3+R9aorjYwLZXHFPaBQW7S686jR9hgCNkz/Rzzn8QAvJSLNEmI0
	gZSvSfP1I5fA0p4oOnvj9GF1UhGwYYDeHKaCZxTSwyY6EpZuSlytnYc8X3ddiksS
	vE1h45I9U4qO0HMnmyz3vdumJqoMTJrKeeSpUSid64m8sxUk7D7YbnURhcNlaWvE
	iemaXk6eTCXy+LqsY5V1dQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nvj2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 04:35:21 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 10:35:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 31 Jan 2024 10:35:19 +0000
Received: from [198.61.64.228] (EDIN4L06LR3.ad.cirrus.com [198.61.64.228])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2F118820241;
	Wed, 31 Jan 2024 10:35:19 +0000 (UTC)
Message-ID: <b77d8588-6809-416c-b598-7a33a672c1e7@opensource.cirrus.com>
Date: Wed, 31 Jan 2024 10:35:18 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on drm-tip
Content-Language: en-US
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
        "Saarinen, Jani"
	<jani.saarinen@intel.com>,
        David Gow <davidgow@google.com>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>
References: <SJ1PR11MB6129E1EA583B3DA3B45E37A4B9CAA@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129B9D6396E5BECB46A25A6B9DBA@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129CB39EED831784C331BAFB9DEA@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129508509896AD7D0E03114B9AFA@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB6129B0FAD6E18FD3FA56C981B986A@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <DM4PR11MB614179CB9C387842D8E8BB40B97C2@DM4PR11MB6141.namprd11.prod.outlook.com>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <DM4PR11MB614179CB9C387842D8E8BB40B97C2@DM4PR11MB6141.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wps-g3rZo6n447LsVqKKg5pC9b3zsgPl
X-Proofpoint-GUID: wps-g3rZo6n447LsVqKKg5pC9b3zsgPl
X-Proofpoint-Spam-Reason: safe

On 31/1/24 05:34, Borah, Chaitanya Kumar wrote:
> Hello Richard,
> 
> Hope you are doing well. I am Chaitanya from the Linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on drm-tip[2] repository.
> These are captured by gitlab issues[3].
> 
> We bisected the issue and have found the following commit to be the first bad commit.
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit a0b84213f947176ddcd0e96e0751a109f28cde21
> Author: Richard Fitzgerald rf@opensource.cirrus.com
> Date:   Mon Dec 18 15:17:29 2023 +0000
> 
>      kunit: Fix NULL-dereference in kunit_init_suite() if suite->log is NULL
> 
>      suite->log must be checked for NULL before passing it to
>      string_stream_clear(). This was done in kunit_init_test() but was missing
>      from kunit_init_suite().
> 
>      Signed-off-by: Richard Fitzgerald rf@opensource.cirrus.com
>      Fixes: 6d696c4695c5 ("kunit: add ability to run tests after boot using debugfs")
>      Reviewed-by: Rae Moar rmoar@google.com
>      Acked-by: David Gow davidgow@google.com
>      Reviewed-by: Muhammad Usama Anjum usama.anjum@collabora.com
>      Signed-off-by: Shuah Khan skhan@linuxfoundation.org
> 
> lib/kunit/test.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> We tried reverting the patch and the original issue is not seen but it results in NULL pointer deference[4] which I am guessing is expected.
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?
>   
> [1] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=drm
> [2] https://cgit.freedesktop.org/drm-tip/
> [3] https://gitlab.freedesktop.org/drm/intel/-/issues/10140
>        https://gitlab.freedesktop.org/drm/intel/-/issues/10143
> [4]
> 	[  179.849411] [IGT] drm_buddy: executing
> 	[  179.856385] [IGT] drm_buddy: starting subtest drm_buddy
> 	[  179.862594] KTAP version 1
> 	[  179.862600] 1..1
> 	[  179.863375] BUG: kernel NULL pointer dereference, address: 0000000000000030
> 	[  179.863381] #PF: supervisor read access in kernel mode
> 	[  179.863384] #PF: error_code(0x0000) - not-present page
> 	[  179.863387] PGD 0 P4D 0
> 	[  179.863391] Oops: 0000 [#1] PREEMPT SMP NOPTI
> 	[  179.863395] CPU: 1 PID: 1319 Comm: drm_buddy Not tainted 6.8.0-rc1-bisecttrail015 #16
> 	[  179.863398] Hardware name: Intel Corporation Meteor Lake Client Platform/MTL-P DDR5 SODIMM SBS RVP, BIOS MTLPFWI1.R00.3471.D81.2311291340 11/29/2023
> 	[  179.863400] RIP: 0010:__lock_acquire+0x71f/0x2300
> 	[  179.863408] Code: 84 03 06 00 00 44 8b 15 27 f6 72 01 45 85 d2 0f 84 9c 00 00 00 f6 45 22 10 0f 84 63 03 00 00 41 bf 01 00 00 00 e9 8a 00 00 00 <48> 81 3f 40 d7 fa 82 41 b9 00 00 00 00 45 0f 	45 c8 83 fe 01 0f 87
> 	...
> 	[  179.863445] PKRU: 55555554
> 	[  179.863448] Call Trace:
> 	[  179.863450]  <TASK>
> 	[  179.863453]  ? __die_body+0x1a/0x60
> 	[  179.863459]  ? page_fault_oops+0x156/0x450
> 	[  179.863465]  ? do_user_addr_fault+0x65/0x9e0
> 	[  179.863472]  ? exc_page_fault+0x68/0x1a0
> 	[  179.863479]  ? asm_exc_page_fault+0x26/0x30
> 	[  179.863487]  ? __lock_acquire+0x71f/0x2300
> 	[  179.863493]  ? __pfx_do_sync_core+0x10/0x10
> 	[  179.863500]  lock_acquire+0xd8/0x2d0
> 	[  179.863505]  ? string_stream_clear+0x29/0xb0 [kunit]
> 	[  179.863523]  _raw_spin_lock+0x2e/0x40
> 	[  179.863528]  ? string_stream_clear+0x29/0xb0 [kunit]
> 	[  179.863540]  string_stream_clear+0x29/0xb0 [kunit]
> 	[  179.863554]  __kunit_test_suites_init+0x7e/0xe0 [kunit]
> 	[  179.863568]  kunit_module_notify+0x20f/0x220 [kunit]
> 	[  179.863583]  notifier_call_chain+0x46/0x130
> 	[  179.863591]  notifier_call_chain_robust+0x3e/0x90
> 	[  179.863598]  blocking_notifier_call_chain_robust+0x42/0x60
> 	[  179.863605]  load_module+0x1bcd/0x1f80
> 	[  179.863617]  ? init_module_from_file+0x86/0xd0
> 	[  179.863621]  init_module_from_file+0x86/0xd0
> 	[  179.863629]  idempotent_init_module+0x17c/0x230
> 	[  179.863637]  __x64_sys_finit_module+0x56/0xb0
> 	[  179.863642]  do_syscall_64+0x6f/0x140
> 	[  179.863649]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 	[  179.863654] RIP: 0033:0x7f0e6676195d

Looking at the gitlab bug reports compared to the crash log above:

[3] You have hit a failure on the 3rd test case:

     <6> [59.039608] [IGT] drm_buddy: starting dynamic subtest
     drm_test_buddy_alloc_limit
     <6> [59.077701] KTAP version 1
     <6> [59.077705] 1..1
     <6> [59.078487]     KTAP version 1
     <6> [59.078494]     # Subtest: drm_buddy
     <6> [59.078496]     # module: drm_buddy_test
     <6> [59.078498]     1..4
     <6> [59.079321]     ok 1 drm_test_buddy_alloc_limit
     <6> [59.079973]     ok 2 drm_test_buddy_alloc_optimistic
     <6> [59.080479] [IGT] drm_buddy: finished subtest
     drm_test_buddy_alloc_limit, SUCCESS

When you revert my NULL-dereference bugfix, you are hitting the NULL
dereference crash immediately, before executing the test case that is
causing [3].

     > [  179.862594] KTAP version 1
     > [  179.862600] 1..1
     > [  179.863375] BUG: kernel NULL pointer dereference

So, my commit is not causing your [3]. It is allowing you to
reach your test case that is causing [3].


