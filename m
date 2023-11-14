Return-Path: <linux-kselftest+bounces-77-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40F7EAC4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 09:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D50F1C209EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B79154B1;
	Tue, 14 Nov 2023 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glnImyLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD4156C8;
	Tue, 14 Nov 2023 08:59:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348DBA4;
	Tue, 14 Nov 2023 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699952359; x=1731488359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QvaTaGk2DQ5nitvBuPs4aIJdUkfKrTAsbVZwFqvx9eo=;
  b=glnImyLMgNIwQ4E0QnCAwT19+tSH5Rt4gBKwRQfi2axhGWu1xzajuH7w
   NK3VK5vf2Uy6owlmX+k/Aak3Nq3oooTD8lM1EV8BIButQFcXx6MdfP9qu
   WF+z1Ce+akiLAC3rwp6OwZ0ZS1WKoyR2Watdym3vKhKaaLrh+CfMkunLX
   XqKkTkZ7DFeOVMxtT93NVQ3Tl9VAUoMHjG+jBF4+y1llZm7eWrXSz2Vv/
   LZ6/G9fAalRAWRAdbKv7+DLZqb+owG91ZYqwhydpd62TJHYu7F7AGF4Yu
   7HEHx99X8+VcXwGye+IcM+Xe1DwhOZX4vOEazdYszDG3YZ/C7KrdWQqj3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375657293"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="375657293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:59:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830517736"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830517736"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 00:59:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:59:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:59:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 00:59:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 00:59:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tna5+KUzu6k8s7cR7U/sPLnQ/GjEefJgGE0mxj9ZuGkhbOUVyZm0+CYfsvM2+UVskDjHIhjnj/hf72oaJ12e+QsCnFY9xE5E49zecS2Ho1vN3e/A/pawGfU5hKgGzkz8QgJmHzSR8IyS59KmZLvMGmSGr/Hevir3hCA63D4MHA4SyIZAne7WkVdDpjDSlJozET7o/0m7KSYBFCA1a70eENo7gQI2qAQHvX7CifQ7epX+eadWtTYtZrkgX3sNks1sfCYQNQwDoyy1NT3iCuLhf14rqFiMATjdnQVqR04cnIkbBOMxlj5EiglT6ou+giZ/KqFWxl/Y0yzCf7FyVvx96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNgAIguzSbh5yk7rmRs5Ud1iSw1cXu8yAsvM6Lj+buQ=;
 b=jc3UXS5IW/jyANaeADeRkFKV9tEj3tj4C0OpyJxCwaDz01mDHPqiSNgmc8vZeil0YNHnoZG3EO4D7mBpnXpXAS7PHP/IYPkeQF617P4ElKXgrpWvVcbdToKBFaXTJW+lVwuWklsf/R4isVc1Qa1Mv51k/+hn1+0UXvW5bT4R2ppwhEezSuRX5A+Jih5z0grvpZcWMGYt2x+8bmD9HWtZBSTK5nLa/upOFqusfuIpaMyStfn576QTJ41EcyIl5qZvSnORU28UHQwxPG3pK1PVlMthBzyIjVdoPux7IOPultES0q1wQFfWmM6rtLLdJPqIhUDM78f/unxgAaedbcSUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 08:59:13 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 08:59:12 +0000
Date: Tue, 14 Nov 2023 16:58:59 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v1 12/23] KVM: VMX: Handle FRED event data
Message-ID: <ZVM203KI5D3o+ksS@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com>
 <ZVH3IUsfvzuPaj6L@chao-email>
 <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: b02dbee7-54c5-4baf-5075-08dbe4eff8b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhutysPbHVrYsUdzyLc+So+8VaV3j3ylNgNyatkKMSp/HEpq6qo99xKszgiexfgVHRTr2a++0g+coljQD3ms4IDtVddUD4ltD91xM88BBzIcHr8zarewPEEwalj80fq63Tr4uUR+gjQtKJ37LDRgZ+ueauEk4a7paSGDYdsPfGxfPKqpBAYBQFlJoy4WGSXAxfiSQk26SU9ciGqMS4pu+J6CxNgna2ZsW5Yctoo8QbmfNpCl+OvThF4CkDJVzXflhBsS3r14wTT2XROsv5u7Beu0mnD5iA4RYVXs2JPDhtRk6GMKxGzjRSc9N5OmXomb8UZaW4XUYgbhqHZx42mahRrVvJ6fTUnsfJxA4HtO5d2dOmbutca5fYGp6riJNxIJQXYS5rCoR04dfmTpM38X7vMXXN05v19E8HNUw0VTHjPltnF6LBFRta0WAKpfL5zIvJiVsrD90QYPxSFcFmEsBXqo0xC5kdGOm0tkJyody+K2WZUKGN8+8u6ZOuNC8jZkew5uTYpIjEW/KEVHb9PieXUhQVYpItad5MKFjBcQ1/KqGaiby+e+Y0DfKT5h4CMEuAbK6XTkHd3W1l3LduzEvF7B3uLlSG+euO3myZCYcU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82960400001)(26005)(38100700002)(44832011)(9686003)(6512007)(6506007)(316002)(6486002)(478600001)(6636002)(6666004)(54906003)(66476007)(66556008)(66946007)(41300700001)(6862004)(8936002)(4326008)(2906002)(8676002)(33716001)(86362001)(7416002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gi3PSN+rnPGAqgFQVPU8YyS21GwyNTgY4aZwKpYIlaoSTZn9tRZFsSchVLD4?=
 =?us-ascii?Q?75aqVND+OMHYZYduKy7z1UCJ0+RDJli7vR2Q+vpp30j808vOFYNNDvNe2nEv?=
 =?us-ascii?Q?MN5mQeWMDXQW7xtp3rT/NITqP3/xrIS3oONX+Vm3YTwFSQydioT4Jqn2oIlv?=
 =?us-ascii?Q?Pv1ddpD3Z/A+vuHa9WJsyi9E0KuAd/5VVCa0w5WRc9/uaOcwxhbHvz7Gkctp?=
 =?us-ascii?Q?Y6LaYjkeiSc6VuCY9Ua5YozNMjfHm2XYDm+EA5O28ONRC/gvDJuyXm/8xwLh?=
 =?us-ascii?Q?r8wcd1BR1gA9arSGp19mmqaT6QJPoreAg+cHkVGxws1GL6QfsUoU9OpAw31u?=
 =?us-ascii?Q?0gSkacKzd4ENhL0LN75vqtIzMlD04I3KE7EruyjS+PKqAZ3rnQ+DT0Svh2iJ?=
 =?us-ascii?Q?JTr2r4203BBU9gXavzOb6uYWLvcZDoJdCiwJjerX/9LMW4c8Kmz8rdzEmXbj?=
 =?us-ascii?Q?z7dcYNpXDMAjrNhYt+Msr8yBVpt3LWMMgZa5izvSbK7G5SdeJPMyNRtjYUx7?=
 =?us-ascii?Q?WGzZFC27Z9XVK7ObbOabkjBhoBUULKi3QZv5JVJIJ6ZyEC4gsHYT9tH9klLr?=
 =?us-ascii?Q?JDnbgmRfru4zd2Kz5YFAYBeXqLa9ltdaYvBVz9qsxjlfe9ofTLzOwK9zoj/v?=
 =?us-ascii?Q?TxTR/pgk53yU98SQDJJaQsAS27g4Y0i5rT/227pZOvOMrXyhl9+XvOIPM03N?=
 =?us-ascii?Q?oHekYAfL0zM+BkG1SKl5zZ8TagkQZnCNf1A7TVqIRBIcOkDPQvno6Xndd6ej?=
 =?us-ascii?Q?N/kT/wwzLj1d10ZbBhflqX6TOQUiDqR541LeP1yD9Uqhfno10WOUB0ED5JMR?=
 =?us-ascii?Q?CqLt7awyTxCA1haNhjWKi5IS0HH5qgEsNpotEYAwhX/1Id5G35oCzHbnXGy4?=
 =?us-ascii?Q?XDoImOVseIXqX4vXi1uAL2a+rwJ3EVuwvcfMssTYnP+zWSuVCFjAheRwTfdT?=
 =?us-ascii?Q?9xrk5L4+BTMAIE3dq3/Ek0cUXQKzSRmiRnf3oJ0uDP65fHmnq5eJjC4EVLtT?=
 =?us-ascii?Q?isosWtdueCLeB5+1c69ybTa2bLOMyxVegOUIPfFgCANjRpOWaeD7Giec9okG?=
 =?us-ascii?Q?liiCHh5/EYZP1i5pbHfCiErwH4TMWiY71m52jqsVk3+g08vKp2eHixZRKSQu?=
 =?us-ascii?Q?+LUKOrW9z84f1f8W0cEi0ctw+GGGOPkkPK4MILBBke5PUvVdYGPdcL7fULfO?=
 =?us-ascii?Q?kMbT4LvBWHSd3LzGnjgFOv1kGMO8G499CrCtk1ty+Vm6+Pd/s/DxWMky4deT?=
 =?us-ascii?Q?4S8qdMC+I6yI1FitTAboDP+t3pFq15Umx+UoAKX4VAE11t5JdYr7JkIEZDCF?=
 =?us-ascii?Q?oGJHY4KcnyOr2CZe0bjwYQgLlrKd4W5Z06B/FEe+joKSKXNiiFm1YPYARVFE?=
 =?us-ascii?Q?0laH4NEuC6SKLfHsEvwNZV/u0KmVmUzO/qVvrdQ146G4mEWRTX7w8zccrmlj?=
 =?us-ascii?Q?JcO2YpFb/0tlM3BUNsbdDUhV+tYyrSarRL72gHnJ7XCnzik3Ew/pUuxvOT8J?=
 =?us-ascii?Q?wfu8lbNVoYffARiC++LcUR5g6Mb7F5l/WCqQPNtoccpXcHe72iCkdt5Bq9SY?=
 =?us-ascii?Q?SPIv9/VWGlu02dYf7K/n+x6i2j3h8encumq+D870?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b02dbee7-54c5-4baf-5075-08dbe4eff8b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:59:12.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhP1BU1T3LJs5uIsgf0IFgcirhi0n6z6JbPKgcVL2C2eI7/A/sp4sOL2ohJdWd+gjpjt6ecp9AYz9ZkZ+bd+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

On Tue, Nov 14, 2023 at 12:34:02PM +0800, Li, Xin3 wrote:
>> >+			else if (is_nm_fault(intr_info) &&
>> >+				 vcpu->arch.guest_fpu.fpstate->xfd)
>> 
>> does this necessarily mean the #NM is caused by XFD?
>
>Then the event data should be 0.  Or I missed something obvious? I.e.,
>it can be easily differentiated and we should just explicitly set it
>to 0.

vcpu->arch.guest_fpu.fpstate->xfd just means the guest is enabling XFD.
I don't think we can conclude that this #NM is caused by XFD only from
this.  i.e., there may be some false positives.

>> >+			u64 event_data = vmcs_read64(event_data_field);
>> >+
>> >+			switch (vector) {
>> >+			case DB_VECTOR:
>> >+				get_debugreg(vcpu->arch.dr6, 6);
>> >+				WARN_ON(vcpu->arch.dr6 != (event_data ^
>> DR6_RESERVED));
>> >+				vcpu->arch.dr6 = event_data ^ DR6_RESERVED;
>> >+				break;
>> >+			case NM_VECTOR:
>> >+				if (vcpu->arch.guest_fpu.fpstate->xfd) {
>> >+					rdmsrl(MSR_IA32_XFD_ERR, vcpu-
>> >arch.guest_fpu.xfd_err);
>> >+					WARN_ON(vcpu-
>> >arch.guest_fpu.xfd_err != event_data);
>> >+					vcpu->arch.guest_fpu.xfd_err =
>> event_data;
>> >+				} else {
>> >+					WARN_ON(event_data != 0);
>> >+				}
>> >+				break;
>> >+			case PF_VECTOR:
>> >+				WARN_ON(vcpu->arch.cr2 != event_data);
>> >+				vcpu->arch.cr2 = event_data;
>> >+				break;
>> >+			default:
>> >+				WARN_ON(event_data != 0);
>> 
>> I am not sure if this WARN_ON() can be triggeded by nested VMX. It is legitimate
>> for L1 VMM to inject any event w/ an event_data.
>> 
>> FRED spec says:
>> 
>> Section 5.2.1 specifies the event data that FRED event delivery of certain events
>> saves on the stack. When FRED event delivery is used for an event injected by VM
>> entry, the event data saved is the value of the injected-event-data field in the
>> VMCS. This value is used instead of what is specified in Section 5.2.1 and is done
>> for __ALL__ injected events using FRED event delivery
>
>5.2.1 Saving Information on the Regular Stack also says:
>- For any other event, the event data are not currently defined and will
>  be zero until they are.
>
>Or you mean something else?

IIUC, L1 KVM can inject a nested exception whose vector isn't #DB, or #NM or
#PF with a non-zero event_data to L2. If delivering the nested exception causes a
VM-exit to L0 KVM, the assertion that event_data is always 0 for vectors other
than #DB/#NM/#PF fails.

