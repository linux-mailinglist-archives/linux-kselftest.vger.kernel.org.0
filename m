Return-Path: <linux-kselftest+bounces-2659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B78251F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 11:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BC61C213CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93A2510D;
	Fri,  5 Jan 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwsjWCXh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36A2C68E;
	Fri,  5 Jan 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704450592; x=1735986592;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=DDgV9fBW6Yh/cc9rU5jJHhJFLA/an+uM2wWmEBNFbdo=;
  b=SwsjWCXh9yq8bO5c+qlPHNC/n/8H98DWJEuOsyexWxJytnOCSmHcdZt2
   LbbaRdCIUlNe0KiS6sJ8z/iKPHQsf3zgp7QchdbujfP6nQNV4qw9yd9EH
   +5PReE0qf5JsTxNwrlxCVj4RrtIyLJBZYTOb58LPDB3VUia/TSgU22Tr+
   VOjKURvE/QWT3Onz9BKTEE5i+Ro8tTtZFeOJ6dvCGgsaD1aDBX+oMSOPs
   VN50lpah26CbYZjzyI2Z5Vt2vwSL842xmc2EwsX9En3GhTVxgtWBHS4wp
   HLdDJRdOJQbK/DjK+NlnG4Zu5YOKV7DokYMs60aR/LPk5O84iTwkzx46V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376969775"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="376969775"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 02:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="904115507"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="904115507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 02:29:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:29:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 02:29:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 02:29:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 02:29:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuDZrgy4YmyqWZthfiynT7sEy15v5EDJDQE6Av3LhYgrQHjp7OTuA1drsQxlqLWmWsrlvAHgW07Z2QrV0PAToowH8uQd8raYUdOp55RP5uAHscs4/j25XQJ1DDuMIFyT3LVSdDBIVqlwI9W33RmIPDZ/p6+2Qf333ZnAuzwRlFmyiW3uHhe2xV43ay8Y5rpbh54fgXo5WhNIvV/SS58hNK81V38cXscRFtzo/LnyY9x/hsaww7YWJn1FAdamm50bjnzrBCuUCZtgpr9oLim/yV+DjNG8V4o4pV+WDwbogtb8KvNRNKM7IuiSbiQ3yVZqrwhCMPPoLqlB2ph70lhBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+G39496TUd1BWgh0fgfF0Bn4sxAXHuQO5qXnEYguho=;
 b=ledrhA5vJGS34J8z1OCs5xV1oMN0FfQP5s2zsPCbV+zTtuoqOfHsd+KFwz+FFmPKIHX09Arq6PmdxMiNxX6Tgcd6FcLHCK6QxdlULT7r98EpzPaFXMsMnSm2rBkuYPZVrrPwi85XeBI3sDgITTYuT6OeYGTyTo7upyYUQjiV/6b/1dcU298RNTZkYFBEv7enZG704oAViBsSgG27c1v/s6ywR/HMPs4wfBmO+m7ftI9vy2tfg1ixJywMNbpYXbKG59Mzslqr4L2qM6OK2TivQdUtfUnatKFeuEaJqkwYlijmJyxGg2mwjKWWi5pRk27+lP8LxRCnPsEayTZFWz0wBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 10:29:46 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 10:29:46 +0000
Date: Fri, 5 Jan 2024 18:00:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Yuan Yao <yuan.yao@linux.intel.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
	<seanjc@google.com>, <shuah@kernel.org>, <stevensd@chromium.org>
Subject: Re: [RFC PATCH v2 3/3] KVM: selftests: Add set_memory_region_io to
 test memslots for MMIO BARs
Message-ID: <ZZfTPkq3L4Tk+GIW@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084535.20162-1-yan.y.zhao@intel.com>
 <20240105062526.4nrczazdbn3ysd62@yy-desk-7060>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240105062526.4nrczazdbn3ysd62@yy-desk-7060>
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe3660e-c04c-4f83-767c-08dc0dd93ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/5LRwNFX/W6HyU+kILccXKBWmFZKnZzNkT9v3LyUP4QnyL/hu7/ngez+F0o40IeA+iIyTPnU6or9uCj9siDnZaJMgj3r9W9SQ59XL4i7jyPXLmD4MnyhEzDBD9CV7G6OZMtwpPFiBHZjovxkGkL7sj/ABfHhgHB74rHEw+6VT5X9COuw0KfdezzWZSTKb8bvF7WtdD944yB5HzE/uCoNArV6mUhRBrZ2fTRGrDI6dHUgCmoyi9RTzgX5SIV2tfXn9HCtqU5RcIujq0vJu8Y+FmBiT+MFSwv2pZB08ju/qhEEPv9MHgdiCBCFus1IyAKCXHlqs6tVFqeI/FE4HZo4xoqVjuOSVlCPs8UKOjyOUX+V+MC1+r6iZM+MNJB7sBdPns6S2WKrc5myxwvlUWsMS6pChhQzo6uOhR5qGXPYdK9ZFEYMUJIBRMesC3l6VfJJjQUEQXcj+6gdnTHu/flYlzOdIaMF21N/KtdmTdYgfKWprFNvhG3X4EZdT8F3u1ZRqJjruSZPOGwqfJnCG2EsYDNFnkyEea1L58UTI5mMj4kiXWgnZ5uZxl+DSDurZSdU51J4qG1oYHGk6WZeYOr/ruSD/Mh+2kHIj6lhDGFVlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66946007)(6916009)(66556008)(66476007)(38100700002)(82960400001)(6512007)(6506007)(6666004)(86362001)(26005)(5660300002)(2906002)(3450700001)(966005)(478600001)(6486002)(83380400001)(316002)(8936002)(8676002)(4326008)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZz4Vg4ZUGlCgAahMaoafB2rAAGz+eseRN5PVEB+KafTAxeX9mV2iSUp4iB6?=
 =?us-ascii?Q?yUTbp5Bxz7IwErsi1iRZGyOkkY+w6F2+8tRIgcfq4ltJD4+7U6p8JF16G0i4?=
 =?us-ascii?Q?5a7jxoLN8izoty0fgI6EAySRJiHCRusdV6KF4tQItlXltwQcEWw8KgPg88B4?=
 =?us-ascii?Q?QgW/3GRmKtmK9Ai9FsKxIVW+ryVStSNsqVecytK+DuOK51O1fGJ4+j4iauzD?=
 =?us-ascii?Q?e6s9GZDDe/+dGWB7gBHp/HulGuBRHqQu6woL1An9c3rdkSDF1ocoFwobC6Rx?=
 =?us-ascii?Q?L6igAnwq6ThS1RzknNOWr3ppdqKaODpe8N/oi+NgTLHRc6+xYHo158s+uaNr?=
 =?us-ascii?Q?LXR0ck9q3tFt3GyeCMuXEfmzJ9xQlfFFD4p1Am0utKUQvDkh5Z5xqqFSDkfA?=
 =?us-ascii?Q?1n06fev5Hg7j1e3vjJRXL2CtNOyiQC5Ala/A0khsouxBaUc2DYoWOgVP0SAJ?=
 =?us-ascii?Q?ilfWr5K66v7z3pH4fc3D3QlXq5wd/bxTWuJrQB55RgOJNvJkJj61LyTsPy8n?=
 =?us-ascii?Q?hyztUz4Y232jVkKqmATWV2Cw+kvEmF7R6/wL1g8/cpxeJjO2D41EYohcpFJh?=
 =?us-ascii?Q?En0FGgWylOob0FBp6ggVc9vYW4jbE3DsCKnxjCHkquStPgyvmSK33elvPjsj?=
 =?us-ascii?Q?paoxE0UvT4+Oax/c4v6gbuZCqtjmi+PJr5KE5HIJg2odjaykXYKB9fs71bce?=
 =?us-ascii?Q?jV0KeC3e/PrdUA92b9tjysidHjRS9OdQ+FHAh1JVuy8P2yFEzAvkQbRTp+1U?=
 =?us-ascii?Q?VjXY8m96aE3j0Uv7geCm4CwKnziJwRNNsrQfZesupTnJuGLiK3bURh7hU17j?=
 =?us-ascii?Q?FWC2wz3kH8wH1lCpP1HkZkiB9a14O4gg+UdoUMk7t4LtyFLjG8JBh+YH719x?=
 =?us-ascii?Q?9IXWTjKj3I/1Q3mSTLJIU9JiB+KaxC5c1g37AHJiVT3yxQWa7rlfeud2ktE6?=
 =?us-ascii?Q?sr/CvMdBK0hn8WYV3bAbA23Lf29izVPPkqvymix0INfufZY4xY2gLrPz2K/x?=
 =?us-ascii?Q?gt2CKQ+MMqHopjfmDHB4P5Z/clpEVv0bzjYYA21Afs4DJAWyORbC2C/Z3RVh?=
 =?us-ascii?Q?Brj9H5hH0sUFpkPOso2hkh2C/NVNmcD8BoacmdgkFyVTrOnZhoz5GQ9rNRgU?=
 =?us-ascii?Q?aCxXh/6uGAykjLZ59IzVyeDFuzQFKhyzWChBfmr5u5rbKWF2Gl8i99jDLj4m?=
 =?us-ascii?Q?TfZaZKsuOhla5L4iUK/7z3hX3ilxxcyTZSvka2o6bF9Txab9xuEP5QshH458?=
 =?us-ascii?Q?CdxRCaAcbXALqrQv/JvBxx4hV4D2SG/mkhHZw72T3/mAaXwMlgzsebA1jY+z?=
 =?us-ascii?Q?nbU447fadFOh1RHswqW7CbrqGmjvHNnH9oytSxQhRMX0fp52dbei7n8Tfwsj?=
 =?us-ascii?Q?BQkefnIoGWc6MixsrP1+Tjslzfth8P7NNKdjawbTZnZPb3RrtNgvE92WI3Vw?=
 =?us-ascii?Q?oBjCjcH4xtqW2fUmqk7zeuU+CoDTEPfFjyWJK9OkwqVsezgi1kTQ7awpDwrH?=
 =?us-ascii?Q?3GigAyb/bHz7JGxkyijsCUSxl9h4afXDdNyivNawGadPAfNJ/bPTqyEUGPdt?=
 =?us-ascii?Q?sNghNPDl2WnFL32mfQT9GpMM0UYlSc5MAHK5oxOm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe3660e-c04c-4f83-767c-08dc0dd93ce6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 10:29:46.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F48aXaxwplI5OMmI3mI48DdAQcLn6n5If4BtenOH6NjmcXLzJE/5m6Vt5iPkwCVj03jv/442VhKCieqzUHAJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com

On Fri, Jan 05, 2024 at 02:25:26PM +0800, Yuan Yao wrote:
> On Wed, Jan 03, 2024 at 04:45:35PM +0800, Yan Zhao wrote:
> > Added a selftest set_memory_region_io to test memslots for MMIO BARs.
> 
> Emm.. "set_memory_region_io" doesn't represent the real testing purpose,
> but not sure if things like "memory_region_page_refcount_test" become
> better...
Hmm, memory_region_io_page_test?
Not just ref count is tested.
Without patch 1, mapping of pages will even fail.

> 
> > The MMIO BARs' backends are compound/non-compound huge pages serving as
> > device resources allocated by a mock device driver.
> >
> > This selftest will assert and report "errno=14 - Bad address" in vcpu_run()
> > if any failure is met to add such MMIO BAR memslots.
> > After MMIO memslots removal, page reference counts of the device resources
> > are also checked.
> >
> > As this selftest will interacts with a mock device "/dev/kvm_mock_device",
> > it depends on test driver test_kvm_mock_device.ko in the kernel.
> > CONFIG_TEST_KVM_MOCK_DEVICE=m must be enabled in the kernel.
> >
> > Currently, this selftest is only compiled for __x86_64__.
> >
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
...
> > +static void *vcpu_worker(void *data)
> > +{
> > +	struct kvm_vcpu *vcpu = data;
> > +	struct kvm_run *run = vcpu->run;
> > +	struct ucall uc;
> > +	uint64_t cmd;
> > +
> > +	/*
> > +	 * Loop until the guest is done.  Re-enter the guest on all MMIO exits,
> > +	 * which will occur if the guest attempts to access a memslot after it
> > +	 * has been deleted or while it is being moved .
> > +	 */
> > +	while (1) {
> > +		vcpu_run(vcpu);
> > +
> > +		if (run->exit_reason == KVM_EXIT_IO) {
> > +			cmd = get_ucall(vcpu, &uc);
> > +			if (cmd != UCALL_SYNC)
> > +				break;
> > +
> > +			sem_post(&vcpu_ready);
> > +			continue;
> > +		}
> > +
> > +		if (run->exit_reason != KVM_EXIT_MMIO)
> > +			break;
> 
> Can the KVM_EXIT_MMIO happen on x86 ? IIUC the accessed GVAs
> in guest code have 1:1 mapping to MEM_REGION_GPA_BASE, which
> is covered by the memslot, and the memory slot is there
> until the guest code path done.
> 
It can, if the GPAs accessed by guest code are not even mapped as a
memslot.
This check is to ensure GPAs are read from the testing memslot for mock IO.

> > +
> > +		TEST_ASSERT(!run->mmio.is_write, "Unexpected exit mmio write");
> > +		TEST_ASSERT(run->mmio.len == 8,
> > +			    "Unexpected exit mmio size = %u", run->mmio.len);
> > +
> > +		TEST_ASSERT(run->mmio.phys_addr < MEM_REGION_GPA_BASE ||
> > +			    run->mmio.phys_addr >= MEM_REGION_GPA_BASE + bar_size,
> > +			    "Unexpected exit mmio address = 0x%llx",
> > +			    run->mmio.phys_addr);
> 
> Ditto, I just think you don't need this part in this testing.
> 
> > +	}
> > +
> > +	if (run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
> > +		REPORT_GUEST_ASSERT(uc);
> > +
> > +	return NULL;
> > +}
> > +
> > +static void wait_for_vcpu(void)
> > +{
> > +	struct timespec ts;
> > +
> > +	TEST_ASSERT(!clock_gettime(CLOCK_REALTIME, &ts),
> > +		    "clock_gettime() failed: %d\n", errno);
> > +
> > +	ts.tv_sec += 2;
> > +	TEST_ASSERT(!sem_timedwait(&vcpu_ready, &ts),
> > +		    "sem_timedwait() failed: %d\n", errno);
> > +
> > +	/* Wait for the vCPU thread to reenter the guest. */
> > +	usleep(100000);
> 
> In this testing it's not needed.
> Because you only check guest state after guest code path done,
> so pthread_join() is enough there.
Right. Just keep to the convention :)

> 
> > +}
> > +
> > +static void test_kvm_mock_device_bar(bool compound)
> > +{
> > +	struct kvm_vm *vm;
> > +	void *mem;
> > +	struct kvm_vcpu *vcpu;
> > +	pthread_t vcpu_thread;
> > +	int fd, ret;
> > +	u32 param_compound = compound;
> > +	u32 inequal = 0;
> > +
> > +	fd = open("/dev/kvm_mock_device", O_RDWR);
> > +	if (fd < 0) {
> > +		pr_info("Please ensure \"CONFIG_TEST_KVM_MOCK_DEVICE=m\" is enabled in the kernel");
> > +		pr_info(", and execute\n\"modprobe test_kvm_mock_device\n");
> > +	}
> > +	TEST_ASSERT(fd >= 0, "Failed to open kvm mock device.");
> 
> Minor:
> May better to move this part into main(), highlight it's a
> must have dependency at beginning.
I don't think so.
main() can do other tests that are not relying on the mock device.
Actually I'm not even sure if this test needs to be put in
set_memory_region_test.c.

> 
> > +
> > +	ret = ioctl(fd, KVM_MOCK_DEVICE_GET_BAR_SIZE, &bar_size);
> > +	TEST_ASSERT(ret == 0, "Failed to get bar size of kvm mock device");
> > +
> > +	ret = ioctl(fd, KVM_MOCK_DEVICE_PREPARE_RESOURCE, &param_compound);
> > +	TEST_ASSERT(ret == 0, "Failed to prepare resource of kvm mock device");
> > +
> > +	mem = mmap(NULL, (size_t)bar_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> > +		   fd, 0);
> > +	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() kvm mock device bar");
> > +
> > +	*(u64 *)mem = BASE_VAL;
> > +	*(u64 *)(mem + RANDOM_OFFSET) = RANDOM_VAL;
> > +
> > +	vm = vm_create_with_one_vcpu(&vcpu, guest_code_read_bar);
> > +
> > +	vm_set_user_memory_region(vm, MEM_REGION_SLOT_ID, 0, MEM_REGION_GPA_BASE,
> > +				  bar_size, mem);
> > +
> > +	virt_map(vm, MEM_REGION_GPA_BASE, MEM_REGION_GPA_BASE,
> > +		 (RANDOM_OFFSET / getpagesize()) + 1);
> > +
> > +	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
> > +
> > +	/* Ensure the guest thread is spun up. */
> > +	wait_for_vcpu();
> > +
> > +	pthread_join(vcpu_thread, NULL);
> > +
> > +	vm_set_user_memory_region(vm, MEM_REGION_SLOT_ID, 0, 0, 0, 0);
> > +	kvm_vm_free(vm);
> > +
> > +	ret = ioctl(fd, KVM_MOCK_DEVICE_CHECK_BACKEND_REF, &inequal);
> > +	TEST_ASSERT(ret == 0 && inequal == 0, "Incorrect resource ref of KVM device");
> > +
> > +	munmap(mem, bar_size);
> > +	close(fd);
> > +}
> > +
> > +static void test_non_compound_backend(void)
> > +{
> > +	pr_info("Testing non-compound huge page backend for mem slot\n");
> > +	test_kvm_mock_device_bar(false);
> > +}
> > +
> > +static void test_compound_backend(void)
> > +{
> > +	pr_info("Testing compound huge page backend for mem slot\n");
> > +	test_kvm_mock_device_bar(true);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +#ifdef __x86_64__
> > +	test_compound_backend();
> > +	if (non_compound_supported)
> 
> Nobody set this, but the mock device looks already supported
> it, so how about just run the 2 testings directly here ?
Without the series "allow mapping non-refcounted pages" [1], the test
test_non_compound_backend() will simply fail.

I added this test case is to show it non-compound pages as backend can
also be tested with this selftest. And actually, I did tested that
series with this selftets.

So, can remove the "if non_compound_supported" after [1] is merged.

[1] https://lore.kernel.org/all/20230911021637.1941096-1-stevensd@google.com/,

Thanks

> 
> > +		test_non_compound_backend();
> > +#endif
> > +
> > +	return 0;
> > +}
> > --
> > 2.17.1
> >
> 

