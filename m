Return-Path: <linux-kselftest+bounces-189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBD7ED9AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136BC280FAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93D45960;
	Thu, 16 Nov 2023 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aam4S2i5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE6F199;
	Wed, 15 Nov 2023 18:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700102414; x=1731638414;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Acbu287cGNFa4Veg5EQbRck3FD71RskotUD3cW0+UE0=;
  b=Aam4S2i55C/WWx/u0/Cz8Ro2CZwpzUZmE1hW6HghXz/81UngB7FrE1x2
   JScy4s8CW2isVy5yH4dEjmM+cTZCZuLks7R5Ff+D/BceHoZH2NxGZU3U3
   d71+n/HHohgi6ITW1BY0FjTOEDeV9/HMQxalMrg2/OG8qGWNT7UC/GuNj
   rVxN37rol2vSj9tUoE0+Ra7wYPh1hsjm+KQFJ4NXqdUXCcTbQwWhZl3Py
   sJ9bIzLgE2qTD55CEOeICHObwwrI8Iyv8QuuRB/Tfaqoiumcz9xUw9wEZ
   GNOw1/f74zWsYabGAHe1IYPpwzk50TAplHh5i2jmvSIhjDVl14aB5us+R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371184558"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="371184558"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 18:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758687505"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="758687505"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 18:40:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:40:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 18:40:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 18:40:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOsgsIQCG9bcQHNAhF9i2MykMwbTX1tC7s4fOifrqHBzROQy1K/26ewoCfHQB/n1qmYuPfBbrOmRyd9/vk4/zFDbYghINSVfSpFUn3lDg4IV8J07jKHIgHCirzSnori70dewx8vQbg+2XRakOeL+iJfLTGkwdo/YLDM2h5eGjlyvB6UfN6waRVr5duuDLKo9cedPpb5hNutLgjaZIRLDPzvWrNRjxNeChuhUE71e6n3X9/zaDGqXKtAL9ckegMpzXFsI5oKE8/p0ki9lW3qVxUPe/Z7aaq7Y9mwarNJBtfy+eQDY2+SJuXXrUgwJXkvQU7cDAdc8mHYstt+hUBW0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PViMiwiCmH5Jy0gvBRDqH+yQyApO6SdEA/XqWb0vPto=;
 b=RKR7MWvkomgiJMnOF2rawDjsmu68lpBi9Uc5wjKgXig9NFu759sV3yKGlUOu7jbhN5HyinxYm7yfuRbyzlA/eyaeNHBrSRG9DBUj9f5o6ngN9l69Iwv0pRTSTFH7blAyZXOhJ9x7oJ2fSMiuNUZo0KNjI1hR8ajMcnxfaYopbnLQvxoRnRurE75442CmNuwAQUCeeuJSvROfhWsM0wVF7vuqEurBsEtJI5rDAegJDgV8lAsvPRuqQrnpTx6vrwZE8clpt4KZJzCzRXG7dDl5ImeNU/AFY+rkpdd4EupN+hWjr2dG8S5FawgaucHc2wmBoqN1D7opp6KoPhkNq10D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 02:40:08 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::66ec:5c08:f169:6038%3]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 02:40:08 +0000
Date: Thu, 16 Nov 2023 10:39:56 +0800
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
Message-ID: <ZVV/Rso4Rs4Hf8Df@chao-email>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-13-xin3.li@intel.com>
 <ZVH3IUsfvzuPaj6L@chao-email>
 <SA1PR11MB6734B2389911D76A4B95319AA8B2A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZVM203KI5D3o+ksS@chao-email>
 <SA1PR11MB6734FAD33CAC432ABB5EF7D5A8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734FAD33CAC432ABB5EF7D5A8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d700af-6460-45ab-1598-08dbe64d58a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6m9qEWZIqx9F7dS2NkPe+E8itjG1ZqqPonIMli7vD+eRmgUNB7WPMn0i/LPzZ576WvimU6qZxK875qSr3dHouOkqpFehx57BW+TsGIxVSCYjP3a1jw/kInCKv2qHSZHQ0kLqgThxqsKmN0noAdOMdIfUk9Kwti45BpuzCuTOBt2xCw+wmk2TLCnC2Bj39o44iMyd4PalEg5nvk824KQ94Y2mYVGSYX4q55c3CqZZfJ5EIexA2EhKs0InxeQlZdHGHaHWxLH16X61l8DcvXz4Xr6+EUGGyn0rPCgXsbVtgO8fhER5EnP7T87URh7BsDO6xIxIWafpFA7PhlwQ76tbESXrMv3i5P34Ric4BHaBAtqOEFHlVKRXRLX5mJm79tP9LgtbI6AYn2qsVBQxJMa1n+K/xRnSwcTHRP29ntUEKkVyFwyRdEXC+evkEKbxwhdsCHkJX7Oc1faCctlObP1tLLUhF4THUjROaesro4p4FwEFRWUCIrHmZHPJdw7yBAgECyCQ9gzfvx/TV/jnL3tEUNpgWB3GeF4rt108eUVpy1rJ2zFKqHFIpjFTYSMoT+Nv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(6512007)(6636002)(9686003)(8936002)(4326008)(8676002)(6862004)(26005)(82960400001)(478600001)(6486002)(33716001)(54906003)(6666004)(66476007)(66556008)(6506007)(38100700002)(7416002)(66946007)(5660300002)(2906002)(41300700001)(86362001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvtctVoxf1OCQhhVNWWgJG3ir0og4utoaAJ07ZYKcXo8haHtCTd2B0612Kf6?=
 =?us-ascii?Q?V9nkycT74XnjdK5WbpjMnCBjKhIbeQxp0VzISAesuc9sKLEPNvVDRb5Kliiz?=
 =?us-ascii?Q?eJxfcIBVoT/BooPYPvmw9rf5kzL/l1yhHpKlHV+7GwLxB6ldLMDjxSkmJKQd?=
 =?us-ascii?Q?zhVueF8JghJmguVPtznfg3pygFvz8wIKRFP+zOyHbgB4bB3tYrzUY1IvGcxA?=
 =?us-ascii?Q?4XmMZvyq2IHV4v8S7CMsF4+nOwP0yehLoISsF++HEhUl1TXRyD1lo4k1wLJO?=
 =?us-ascii?Q?1G8Fyl7buUeGNMD3heU2pAqImOj40893z9RxEr/xvyHXMLdz4yvUyQvRqV0i?=
 =?us-ascii?Q?lRQRMeh5Tb3MlCBWifvi4D+xFaVyOfEAHK5kYO8QLjYfgVviJb9Dy+z7SOev?=
 =?us-ascii?Q?Lm/+N8ryE0rqLlB9tOsftRckxaEFJiR6KLhWkEYp5FE0RylXhjYWznNex6Ti?=
 =?us-ascii?Q?85Y6ambqfbCDEelfE1B5cTv+hAhZk/7bwVUkaiieLIOun9niwcgZPbOlxWfJ?=
 =?us-ascii?Q?b/c0C9PUJiGRLuZIyF10wfJVkmrkfr6yPwbdLz0uoWaPA5UfgtqAYK7Irs7V?=
 =?us-ascii?Q?jMsr53G0ppMszbGsjKDQc4yVfbZhGhcp6fyz4TUZnNF3zNbkPv+42kSPwLWD?=
 =?us-ascii?Q?f4fOlkgUxWQsooOrQmZuot/RPQrFbXXTJBbYkCFe+HpxMlvYlYRLp3cb25kk?=
 =?us-ascii?Q?HrOJkD8iPCdUYbtWyWoK+CU8Fx0jpzGrWOH2QqC0bEo7LYlpTL+LUmc9wQhN?=
 =?us-ascii?Q?NJqkxc3uKLPYfqQ/8IC3RhXuEW3vbh2jzUivLTmJRBN8TdRm/B1LtMwXKQMe?=
 =?us-ascii?Q?Jhk19IuP7tqZV4eQJmGyL+vpwWfUlAZz1zng5pDkl3rxNtmJ74HvUwb2C27z?=
 =?us-ascii?Q?jUlAm7ByTV3NEr0otcWvcgjVvKiq7ttYcSXmYSKn4a2zKSjGV4z97xaQfHLM?=
 =?us-ascii?Q?anXV9D42gbwgz0qW9yPk+fyld/eGDOcrOI3sJ9Dlqaj9e+Ichg8YpqDq7RcO?=
 =?us-ascii?Q?C7B1i5uOP2G2qIRXmnQeCaEFFpjP9Dm8rpWIGS2DJF7q7/3c4nZy/BZDiD74?=
 =?us-ascii?Q?BJRDhAXRf4qW4QtqBASi8JGDqoyKy66K6Jtn7cZ+R/syIG5gogDGTihCEyVr?=
 =?us-ascii?Q?0iKviZKhJJ3PzVfKDCsa0xvn1dGQSry5deP1HUIj1UJXMOnlOrxTkBTclTzc?=
 =?us-ascii?Q?jUDv8/zz0jCQZnfveuuNbYB3MjjPDtvxXZK51Ogp+LA0J27sS+MQX5ciVhaS?=
 =?us-ascii?Q?whJCCrtDTkERAVrdb1scm0bzaiB6Yd2J3BRB6/UhInkO2auU9yvo2QR/QCC2?=
 =?us-ascii?Q?19TkN9R84HkuC/Cp1ixYDsqcV8FDVF1MMy3yTJWI/zdEp2RKeevO7xyH6XBj?=
 =?us-ascii?Q?3xbVwjzN8z1YLaKz0bPaXqD3VrFOiBjM1mE6PGA5qyT0MdP7Ac0/sqnHZiX3?=
 =?us-ascii?Q?oYsz6JkGM+jCOFSEPMQtt7OlHSe7HMWj4Gp6L69u0EWonjZnUXPzGNS7NXb0?=
 =?us-ascii?Q?BBi0AgW0rflreenT6Vgz7Q1ooFwW6w66grDyseQICjtuc6DgG4Z+32rytzGI?=
 =?us-ascii?Q?Ey4kT4n7TeNYS8xdKYQHA0mpGJYmNOrJusI+SQz9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d700af-6460-45ab-1598-08dbe64d58a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:40:08.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvQHwm2g1X9L8jOq0aBlBKo9oHn1v3vGFcGEVDPOBPFt/Og6ZT2ZFfQLlFwvkmCdFJyElA15CNFW7y4PIlOC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

>> >> >+			default:
>> >> >+				WARN_ON(event_data != 0);
>> >>
>> >> I am not sure if this WARN_ON() can be triggeded by nested VMX. It is
>> >> legitimate for L1 VMM to inject any event w/ an event_data.
>> >>
>> >> FRED spec says:
>> >>
>> >> Section 5.2.1 specifies the event data that FRED event delivery of
>> >> certain events saves on the stack. When FRED event delivery is used
>> >> for an event injected by VM entry, the event data saved is the value
>> >> of the injected-event-data field in the VMCS. This value is used
>> >> instead of what is specified in Section 5.2.1 and is done for __ALL__
>> >> injected events using FRED event delivery
>> >
>> >5.2.1 Saving Information on the Regular Stack also says:
>> >- For any other event, the event data are not currently defined and
>> >will
>> >  be zero until they are.
>> >
>> >Or you mean something else?
>> 
>> IIUC, L1 KVM can inject a nested exception whose vector isn't #DB, or #NM or #PF
>> with a non-zero event_data to L2.
>
>No, this is not allowed.

How do you interpret the last sentence:

	Section 5.2.1 specifies the event data that FRED event delivery of
	certain events saves on the stack. When FRED event delivery is used
	for an event injected by VM entry, the event data saved is the value
	of the injected-event-data field in the VMCS. This value is used
	instead of what is specified in Section 5.2.1 and is done for __ALL__
	injected events using FRED event delivery

