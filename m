Return-Path: <linux-kselftest+bounces-21665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F49C1AC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B925B2552B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66A1E25FE;
	Fri,  8 Nov 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc4JnE9b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50481E1C16;
	Fri,  8 Nov 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062209; cv=fail; b=qyjsxnnCFUckukAM4lM0qWbK7Olz9wl8m6BJzFMCgkWC9v2bCDVf3MrP5DNOug86vHso1GyVS+huJXKCxXb7eQ4etGEVHDay+zZRleQiUi5mSB+NEO56J6zsbyYavvhLTGgdoisqidlQT1Afau4Gn/omy/MlcSlCtLqfVzlF4sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062209; c=relaxed/simple;
	bh=6LguJ8ZvOKph6sFm3jNXfhLcHZ18Yqwltu01LJj4YhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0j0t5eN68CODwxawlgi06dm9GtATpV7VUMcJ1TklWNyznSyhqXF989iOVcMmALzmynlvv0/UeVfOSPNhYmmVG96rfa8c4hI7Bd9oF8nuOU519/hpM/Q7KHbJD7aB+6ExD9nDMWdQh3jR3VgSDJiaxrwt8giFVvCI4l4VcGTYOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc4JnE9b; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731062207; x=1762598207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6LguJ8ZvOKph6sFm3jNXfhLcHZ18Yqwltu01LJj4YhI=;
  b=Tc4JnE9bNE1csyyYHyXNddVQsSX9hEpYDNorXwzmulHdhklXQLTAq6/8
   E569NtCDHgvzlE6rQ2oq62tI+3GtWxQrh2hDwrn/szvGyL6ElULHYG0sY
   DuetpC1hyyg43+iC1c2uuDyHQwDd2Lte0JInqNUMj50p/uUKAlkCH25xy
   tdsE+ai/VGAblFszUVvjw8Y0MoI2MFG/avEzsCsT7/EEzW2Cnx9BvtgLA
   lV56DnMgq0v9PtzGp0QYsw+wCAQD4NzcOwev967oni+1ydK0fUpPl9ssv
   GccyKvpLsLA3Ygff2jyrQsjx0L/jWL2eazeD+8df8tN5QMsTx5agCL/Pu
   A==;
X-CSE-ConnectionGUID: 16lIg6JBRiCTALiU9ixsAA==
X-CSE-MsgGUID: 6mXh1m5wQbKoUROVd75SMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53501694"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53501694"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:36:46 -0800
X-CSE-ConnectionGUID: fViin7tRTsyPCNZW7ykFTw==
X-CSE-MsgGUID: WSVWTlQjQnu95eOVVR+bRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85603010"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 02:36:46 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 02:36:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 02:36:45 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 02:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdCjm8yhYFHQMEvee+x5c9aCskFIF0fYs3b4vQ+veVZTYCgN8c5rvLSE5jzWHWu8XkKCX5vyWA9EUywPoFDgex6Bc6AacxcIgItQ7BlZ6cTCdZvu43bgGCg0qA4sF/2FOvdWAZ+hKPGeqiLqitBxsC5CVqWz60kgXTNMTEh3dmF3KrGhPOwPOAjJdqV7HxfV24JhXyz7kKLirwxFo4rBPfIqk31OJC9Bpu+TSbEmUWzrTFWZqEm7i3pyanAy/8gjn/JoUyf2gP/xXm4WHfeULCM+jpXluJaRKJ2WIeY+P59i/VU1sydfNpMqVtEZoQdbBKOdvvQ/Ms882jU9W60tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LguJ8ZvOKph6sFm3jNXfhLcHZ18Yqwltu01LJj4YhI=;
 b=Rlnoh7K+Ln/9NpLoBOj+XMZaqgWbBdi5GjJ+IjpQhkVki6n3P3YJrRsfSuUGiwz1P1TvUhYrVgo99ErnBWaFZDk552HZwXTeTqu5p3bMEEk9NL9eoDDEK7vAUolzAQDIL16Py66ifAWFV73uBAw8K7flkf5CKaZt+3Dr0UPmBpiEmAL9vUtVmB6m+q1Dh4TTXLRbtu+Xawzjxhkh4rcSj4l5cS/3gg09xKALxXV6Gx+UBv0j7tfOtOuA20O+e1eScw3bamuYaEfWrtVHli4GzBMjXJwro6CWs41p7uqSWc07qR7Vif89jeQzFjhgq8vWm2nLleu8Uee8rzO9gGWVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:36:42 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:36:42 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Manwaring, Derek" <derekmn@amazon.com>
CC: "ackerleytng@google.com" <ackerleytng@google.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>,
	"canellac@amazon.at" <canellac@amazon.at>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"Graf, Alexander" <graf@amazon.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "jgowans@amazon.com" <jgowans@amazon.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "kalyazin@amazon.com"
	<kalyazin@amazon.com>, "kernel@xen0n.name" <kernel@xen0n.name>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "luto@kernel.org"
	<luto@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mlipp@amazon.at" <mlipp@amazon.at>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "quic_eberman@quicinc.com"
	<quic_eberman@quicinc.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"roypat@amazon.co.uk" <roypat@amazon.co.uk>, "rppt@kernel.org"
	<rppt@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "svens@linux.ibm.com"
	<svens@linux.ibm.com>, "tabba@google.com" <tabba@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Annapurve, Vishal"
	<vannapurve@google.com>, "will@kernel.org" <will@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "xmarcalx@amazon.com"
	<xmarcalx@amazon.com>
Subject: RE: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Thread-Topic: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Thread-Index: AQHbKtKhCUbJUgt2lUeVsVW+MLeJCbKgnuYAgAAOfACAAOHOgIABC0kAgAANywCABCeKsIADtmyAgAKzXuA=
Date: Fri, 8 Nov 2024 10:36:42 +0000
Message-ID: <DM8PR11MB57505F62D149EF153F89B8BAE75D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57509ED04CB0730680735AC9E7512@DM8PR11MB5750.namprd11.prod.outlook.com>
 <7ad5d114-3d19-4c33-bb3c-7f8940ad114e@amazon.com>
In-Reply-To: <7ad5d114-3d19-4c33-bb3c-7f8940ad114e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|MN2PR11MB4712:EE_
x-ms-office365-filtering-correlation-id: 31b4480e-d272-47ce-5f38-08dcffe13c52
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WG9hV3oxdFdNazZmNVBHODZleGJlUG95UVhaeXdVRVlmZXlGUys0dVJkRDdm?=
 =?utf-8?B?aTlvWS9ZZFMrWXZ4cFh2dDlmOUo3NEsxc1NPckVTUlRyQ1pWWUJzZzZta0ky?=
 =?utf-8?B?VmhYWnl2K3lYdS9nbHlONTZRaTg2T3VKNVJSa1FrMzA5c0d0cTN4T1pXZFNu?=
 =?utf-8?B?RkNzMUs4QXk1UE1XOTJiZmJaeW5wNlRnZm5RNGtMbzhoWERXNTBTQTF6NWEy?=
 =?utf-8?B?MExyeGRucFovbTh2Q2hBYkkyQlp5WGM3bTU5VzdRcVc2cjlXVCtsSXoxVlZC?=
 =?utf-8?B?RkNWTnhzMlRvQ3dEMmFmZDhlSHhhZCtGOXRJU3JsY09kbGJXRkloWWhCSEI5?=
 =?utf-8?B?T3d1U0o2ckFiekZJek9ZbXpXM3ZWSlcvOHBZRVJEdy9wL3k5MGdPOXBMTEIw?=
 =?utf-8?B?L2QzandXeFgwK3Eybncvc1JWS04vbGhZT3VnNHJJaE5GWWIraTB2K0U3VlZ5?=
 =?utf-8?B?TVJEbGhHOGZJcGxQYzVKMlZpcG9IbVpZZGR6M1JMWEJBblFsMVdnczVjWXpD?=
 =?utf-8?B?eFhpS280R2VDNFh3Q3ZiS0Y3S3lTUS9mYWNjaFlocDEvMHAvTm9wWjFmUzN1?=
 =?utf-8?B?QlMxT05XNmlLcGlyN01SU2ZQYU5VejJnQjNaUy91MVJXYkx3d3p4SXd1UjFk?=
 =?utf-8?B?d2tFMEhiSmVoM3NvY1J0SUVqdGdLa0ZJRzN1aFJmYWg3NWRMU2hGWUhBWVNs?=
 =?utf-8?B?Q3JYOVAvUjd4UXByZUFtOVRRMjY2bGdQNkZ4aHJJQ3pUOVRjdEVVL1NIRHdS?=
 =?utf-8?B?NjRUTkt6Y3BaRFR2SkZadmJPQ0o5U2pIQ2dER2x1Vkt0VjZnV3c1SjdVUkZo?=
 =?utf-8?B?Q21ETmNhWTJ0Q2RlNzRhNEpGOWdwT1ZFTEhWVktWZ0tMZTJTS1ZrZ0Z3L241?=
 =?utf-8?B?eW1RcFJ0UzJjK2lxWGY1Wmd3bi9qSHYrK2E4MGJaUkRBbGg3OXpDa25iMjJx?=
 =?utf-8?B?R3poV3Eza0hPSDBLSUYxaldReFFiQktsVXppd01vN1lxbkRKS2JFS05yQzRv?=
 =?utf-8?B?TXR4SE5vT09mcTVpWjEyWEZDeTdzYk5ObDh2YW1jQ2xVaFRlS3lGRDMwalha?=
 =?utf-8?B?Zis0Wnk3YXd0M0RpanJSa3VQTmJiTHMzUjZiS3NyRDIvaTFPczB1emlpcHBw?=
 =?utf-8?B?dFl0MzJHWVFITWZBV3hWUlpwR0svY1lTRU5UNTZZMytxcmZyY1M0NHFUczVp?=
 =?utf-8?B?bTNNamFOSkk2cTQyQjBOaXk3bUdGdlJOSGNvV3hxdkplM29vbWtuT0FCZU1E?=
 =?utf-8?B?WFRRV0tQQkM3d1pWU1R2SGFYaXpHLzFwcE9xSExWWFdSZXNOOFVBcE4zaUtB?=
 =?utf-8?B?RW03THMrZFA2U2QwY3NUclFrR3dsYmZ6UEtSMFVYREY0MWg1V0RrOVBCaFpj?=
 =?utf-8?B?dWs0dWhWc2Fnamw2Y3RkR3lnNFJrRTQxUGs5OFN1Z1pFOVY3Vm9MaFNra3kv?=
 =?utf-8?B?bU1HcUtZaDM2OFBYQ0FLdVBlamJja3VjenQyU0pFRGY2MEU0MlFPa3NFSlBC?=
 =?utf-8?B?VHhEdXkxaGgydzIzOStaRVp3VmtBVURkVUNORTNkcG93YWFNcVVRQXNaRkty?=
 =?utf-8?B?YU8rMDJMWGEvaFJlV2ZIbXRGai9uNzZMQ0M2YnBscUZnejBzU0lKbHFZa2ZY?=
 =?utf-8?B?Z3lwMFI0RG13aTFjYTJFdGtkWkNWWkJtaTRPK0ZuM3BOVWllbDA4R1lIU1JR?=
 =?utf-8?B?TUhHbFZsT2RwZmJOaXEzdHdmcUl3WVM0b3M5ZzRFRHpiK2lkdXZ3Q2ZYVXVr?=
 =?utf-8?B?SjJPV0FnN3F3OW42U2RJaGpTckFGZUREUjc2NkZ5U0hLMlpPUFoxL0o2Z0Er?=
 =?utf-8?Q?NBbUAJP0Ka7RL3tUqXykhB7126i8cxUdMNHIg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlFhaWIrc0t6UzBrZ3hVVmNDd1R6bUtHczNzRnUvaVo4R1E3SGdvdmlzVnFr?=
 =?utf-8?B?Z0ZyTm5YQU9Ga1Y0Y2JmWC9iNGFYWXNFVFVXai96VmtmUURyRzJaM1lGRlJ3?=
 =?utf-8?B?dlhMKzZneVZUWTU0d2Exbng4OUtoNWZ5MmZZdjc3andobzlTYnFTN1JQczMw?=
 =?utf-8?B?WXY4MWJXNU5IWS9HQ1lDem5oYmJTZkczeERhRE1OOXlaVGZFTWZYVEFVRDZx?=
 =?utf-8?B?cnVBQitobDQ2WkhBQnRVN0hzY1VpcE4xWXdtR2h4azE3U3JxTGY2aExXM1FH?=
 =?utf-8?B?MWRlZWVsZjlzVU16YzIxV0QwQVFqeG54QXBlODlUcHFvemtoblpIM2R3MFp3?=
 =?utf-8?B?TTNmQ2l2K3gzbDVtRXIxY0dlQ2Y5V2dEK3FQNjg4QURpQUhnZzNxa1ZvUktE?=
 =?utf-8?B?MkhqVVEwQkpVc1VGNWFzZXdkVDVabDZwMlgwN29RVUpQWVZpaXNORVJodGUx?=
 =?utf-8?B?Sjh3Y1J6bVpLakQrcXpBeWxRNEY5SEZZUTB6Y2lOclQvazdtb3FmdnNiSVpT?=
 =?utf-8?B?cWRtK0trSHVFOVRIdi8yQmxFZDZXbWFjamNjbklnWU9IdWozZVZ1RzEraS9w?=
 =?utf-8?B?ZW9KTEpHVkRrOWhDSmtFbUJ6MkRUYk9DbVQ5eDZSRWQ5VmdqN2NHMkppa2Iv?=
 =?utf-8?B?L0pDaVY2UTJrTnJNY3lpcTNQSm9KOGovWDMvRVNRc0RKYkdaMUdKNzJ3d3NZ?=
 =?utf-8?B?ZWZnNkxpTUpmZEpLN2VZcjM3WTMrakQrY1VsSThLZnR5S2VPdmNVS01VNnRp?=
 =?utf-8?B?a0dra0IyRitmQlB4TkFHVFBIR1c0ZzZsMkxJekZJMU5tUGdCV3JyTVRFV1NN?=
 =?utf-8?B?dXZaTVJTcEhNMWVNOEV1UzNHWm5rRVJsTm4zVjYxUFNjaEd3QjFjUUhXU3R0?=
 =?utf-8?B?Z1kwaktaSGZsNmNKd3hvNGRuRXNONzZocldrSGtsdXZWWTIrNU53andLUngz?=
 =?utf-8?B?NFlmb25vdGVoYXdXajA4d0c2cDFEL3AyUGsrLzVESk1SaG4yRWJmem94emFL?=
 =?utf-8?B?amFyakh6V3VrUVhrNGQ2UkdqN01QR1R2T0UvUXh1VG9lbjhtL3U5K1pBMVND?=
 =?utf-8?B?YlRpKzhrYmJRZkFsekU5b1QrS0Y1UGQ4aXlHT0dOaGVDZmlQRWtnUmV6TlA1?=
 =?utf-8?B?aVdHakRITEZrRlQ5aVl1VVkzeEVWZE9NcWZoaTQ4ZUpLZG16cVJCYWNJKzNj?=
 =?utf-8?B?aHFhWGRleWZGdURhMFcvWU4wWkFISW52RGoyUzMvdzlLang3T1YzZmcvMCtF?=
 =?utf-8?B?cWh5TW9hREt0M0hQeHhvR29KN2F6RE51YTBSaXBJanE3bnFHMEJjTlY1Y3Jh?=
 =?utf-8?B?OTFPc09mVG02QnAyRklSaWRKZGg5SzVESFpINDJKMmUyYWtIWHc1cHFSLzl5?=
 =?utf-8?B?ejg5eWgwdVlEUkNRK0dzV3pyWGl0QkJnMUowNWFoU2YxUFhOUzZMOW55UXlh?=
 =?utf-8?B?WGJaRURrS1RZakx2cHRRQWMrVE9uRjFpaVArZXFZYkIzNlF0V2ZFWURHNDRU?=
 =?utf-8?B?VEhQUFBYZ1ZmL2xrcWRRaytSZ3ZPUjAyNWNIMmRnTktvTzZvUWpHa0ttWkll?=
 =?utf-8?B?bUZLK0VEQzA2WHFuRS9aaTk5WndhbDh3bXVnN0JNQ3FiQUtFRTlQcTA0dWk4?=
 =?utf-8?B?cVMxKytBTlk5WTFaZFAvRThFc2FYQm03K2VlZ1gvQWlIYjlzcW4xZ1JyNUJw?=
 =?utf-8?B?ekQzVEQyb3RJdE50VGJ2Zk1FUlpZdVVtVXpsb1N4ZzFjTTdPSnlTdjM4cXox?=
 =?utf-8?B?TDZ5SGkyUEovNENzN0Y5cnh1MWZKQ3o2MjRSTGkzYjAwcThVMnFVNU1zL0pw?=
 =?utf-8?B?OThCaktwYm5BeWJ2elk5N1FGWTNtRGhSVVdHVWtwWEMzeWR5Ry9HWTJhTm5C?=
 =?utf-8?B?RXpnbHJDWUZlQU8rWDJOVjc1NzhTSitYMDB2Szd5WndkeU9Lb1I4L2xFMzEr?=
 =?utf-8?B?ai9HMUlVOW5ETys2cjdGN3V0Z2tFdkxETmFocjZMMlExRmRKMFpiMDdYc3NU?=
 =?utf-8?B?cG40SFhIY3VJODlHQ0JWZUEzZ3FKZlRqZU5lZDNRTTZ4dTVpcGpNN0FMdWNQ?=
 =?utf-8?B?MGl5Y2dOMXhFR1lObXBIYjlXYkhWRnk1WVJtTUpmZnh3SEg0Rk91VzlvWk01?=
 =?utf-8?Q?/mJbJZi1a882GqaBOC49xWoAe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b4480e-d272-47ce-5f38-08dcffe13c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:36:42.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdeU0rWfKJjEK6sRbtlgux7fZUxqaOQ0JZRNc5zOESJmrNPqwO5x+Oj8Fr/W3cYjxE3d6XOq2ZwlWj2lX5QMgptwbEX5PL0GRyenZ375CvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com

IA0KPiBPbiAyMDI0LTExLTA0IGF0IDA4OjMzKzAwMDAsIEVsZW5hIFJlc2hldG92YSB3cm90ZToN
Cj4gPiBUaGlzIHN0YXRlbWVudCAqaXMqIGZvciBpbnRlZ3JpdHkgc2VjdGlvbi4gV2UgaGF2ZSBh
IHNlcGFyYXRlIFREWCBndWlkYW5jZQ0KPiA+IG9uIHNpZGUtY2hhbm5lbHMgKGluY2x1ZGluZyBz
cGVjdWxhdGl2ZSkgWzNdIGFuZCBzb21lIHNwZWN1bGF0aXZlIGF0dGFja3MNCj4gPiB0aGF0IGFm
ZmVjdCBjb25maWRlbnRpYWxpdHkgKGZvciBleGFtcGxlIHNwZWN0cmUgdjEpIGFyZSBsaXN0ZWQg
YXMgbm90IGNvdmVyZWQNCj4gPiBieSBURFggYnV0IHJlbWFpbmluZyBTVyByZXNwb25zaWJpbGl0
eSAoYXMgdGhleSBhcmUgbm93KS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGFkZGl0aW9uYWwgaW5m
bywgRWxlbmEuIEdpdmVuIHRoYXQgY2xhcmlmaWNhdGlvbiwgSQ0KPiBkZWZpbml0ZWx5IHNlZSBk
aXJlY3QgbWFwIHJlbW92YWwgYW5kIFREWCBhcyBjb21wbGVtZW50YXJ5Lg0KDQpKdXMgdG8gY2xh
cmlmeSB0byBtYWtlIHN1cmUgbXkgY29tbWVudCBpcyBub3QgbWlzdW5kZXJzdG9vZC4NCldoYXQg
SSBtZWFudCBpcyB0aGF0IHdlIGNhbm5vdCBnZW5lcmFsbHkgYXNzdW1lIHRoYXQgY29uZmlkZW50
aWFsaXR5DQpsZWFrcyBmcm9tIENvQ28gZ3Vlc3RzIHRvIGhvc3QvVk1NIHZpYSBzcGVjdWxhdGl2
ZSBjaGFubmVscw0KYXJlIGNvbXBsZXRlbHkgaW1wb3NzaWJsZS4gU3BlY3RyZSBWMSBpcyBhIHBy
aW1lIGV4YW1wbGUgb2Ygc3VjaCBhDQpwb3NzaWJsZSBsZWFrLiBEYXZlIGFsc28gZWxhYm9yYXRl
ZCBvbiBvdGhlciBwb3RlbnRpYWwgdmVjdG9ycyBlYXJsaWVyLg0KDQpUaGUgdXNlZnVsbmVzcyBv
ZiBkaXJlY3QgbWFwIHJlbW92YWwgZm9yIENvQ28gZ3Vlc3RzIGFzIGEgY29uY3JldGUNCm1pdGln
YXRpb24gZm9yIGNlcnRhaW4gdHlwZXMgb2YgbWVtb3J5IGF0dGFja3MgbXVzdCBiZSBwcmVjaXNl
bHkNCmV2YWx1YXRlZCBwZXIgZWFjaCBhdHRhY2sgdmVjdG9yLCBhdHRhY2sgdmVjdG9yIGRpcmVj
dGlvbiAoaG9zdCAtPiBndWVzdCwNCmd1ZXN0IC0+aG9zdCwgZXRjKSBhbmQgcGVyIGVhY2ggY291
bnRlcm1lYXN1cmUgdGhhdCBDb0NvIHZlbmRvcnMNCnByb3ZpZGUgZm9yIGVhY2ggc3VjaCBjYXNl
LiBJIGRvbid0IGtub3cgaWYgdGhlcmUgaXMgYW55IGV4aXN0aW5nIHN0dWR5DQp0aGF0IGV4YW1p
bmVzIHRoaXMgZm9yIG1ham9yIENvQ28gdmVuZG9ycy4gSSB0aGluayB0aGlzIGlzIHdoYXQgbXVz
dA0KYmUgZG9uZSBmb3IgdGhpcyB3b3JrIGluIG9yZGVyIHRvIGhhdmUgYSBzdHJvbmcgcmVhc29u
aW5nIGZvciBpdHMgdXNlZnVsbmVzcy4NCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNCg0K

