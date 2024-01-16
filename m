Return-Path: <linux-kselftest+bounces-3054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD27F82E7B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9EC1F23A4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091117EF;
	Tue, 16 Jan 2024 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs6cnVgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1565410FA;
	Tue, 16 Jan 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367898; x=1736903898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PBKx66yQx+CnH4POct3n8mpkvducQL9ePfJ+0KqNQBY=;
  b=Hs6cnVgoeVoHG4UE156HIx91VFvmJ/LHLa4EWxbAuXrQWwq5n3+bsG0u
   29X30nWYwk8gs7xD+BqGe/0T1Pb08gdSbyCPAstbiNjWxLF4zIizS7EZ5
   BsmeKlRQ/jVRAA+wlyD1tqQMSge+7QMSOzmi7Ey4jn3hzos6jF34+cYSd
   qWodl/u9fgsMXFOA3NGNrk4crQrBl1pPAx3EKKnrkyaHaD+hCDcHxlMff
   7xke0pUT6F3nSAb93e7UNB0wkBky2l5svKmF9qs7kpuM8pPoB3way8nak
   S9T+51pKXHLRy2RvjbKFE3fLjO49APXyUaqgsD285hMaCkZzPXaq5CA+3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13217693"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="13217693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="817984459"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="817984459"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 17:18:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 17:18:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 17:18:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 17:18:16 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 17:18:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpxnwVVfpeR1dt0uUn8w6kqi9iCaikT+71thm7wvgkBCFk/4SdSUyBZ7Z5zV6f0cDfqPDsrygEigNm103As6hagLSxKE5vhgIdePE1YsSRzQXq/6aHpfEKR2J0vq94/jJ5LB82AQsVc70iQ6Xu7JdGz5eJKsR3DFVvdT8pITjUXtBM61P+Mr6lZYEbNOTsDRZfY+g56HUaN3w3Od9BjcCFALQmDgX7cUNwja18hgVwjUSXDwhBHFSWf94q1/tNwUzX2Xtla9T2OcfVyvaokR6qbXX5Wvh6cI0BbItM2O9fNt5Kh/Bmu00WMhr26358Gsvmi/+nACAEsHzWaE5Q5HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBKx66yQx+CnH4POct3n8mpkvducQL9ePfJ+0KqNQBY=;
 b=X0ngvDfiM4TqsPdFjbB+vp8D9crPTxSiYioVA/uu53+Xmdz9Gw8hH7es5LLkIMUxE3ilt4Bh5HZmxXoJMEA8keQ7ZtUnHCYglUB7MasYIo0GrdTNIIW72cTjCnpnc5F92FlXiC/OWDJEkIci/8EjVV+rorjYNavHjuI+WvR97OR4aig6nwt12EQ/++NO3q2Uw3yf7nI61mVDYDnAMsun1IcDhk44vU+j8dit4JEN4uOymlOEBNxV6N819KJhAscgKzZqfdvy5rmAZ0EdWz3gOD3zggbxjEEEyfp6IELFzvLD5Bhl1aKIt2lbVkeZA7vlSMpQeuTaRM6AgLucYBWsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 01:18:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 01:18:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Topic: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Index: AQHaIPvOp5q2xzg/c0eyE+dkyLAmKbDbbW0AgACBx3A=
Date: Tue, 16 Jan 2024 01:18:12 +0000
Message-ID: <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
In-Reply-To: <20240115172430.GN734935@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6663:EE_
x-ms-office365-filtering-correlation-id: 006ee571-f9bb-4b5e-8ab1-08dc1631026b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVMuEYRbOR4zooSPefrwTM9lpwhzwHheQEFMqA4GWJNWg9arSWbPcozX6eAFtXRCv/+/V8dopdEw1IAIo3zo38oWhI9f1wPVHUjycIY+t4s9ifFM50d4lhhBN0ImYS1Bl/BjrLxaEcMyKEAarG4mgCl2RwqhDCW4pKADWmwkoc+CgqEUO2sBwq5XlVhzpdui8EZUayn39jJb9xUrU/v56N+17/1wODGvlfivVVqmZtOIVd5YdFjD8S3oz7IRNjscGweQXbNjqvQ57DY8J69ZMJhwAmICORdtbox2p1LQJKHK9botZYtWxquRo0mMPuBHj0+yxs4jlpEaquulLvs74uXWYanBilX7KZ0Dxmuj+SoOIAl8ImEREU6kik/ac6g9ovgUdpJ1vKRMN0sVh6IwRgswz3XquFFOUzpd0GUwKGYyWAg/Rb0/DfFE2YkcH0CDvD6KzHL+4rlhzqFQXZOx17FBFmCWkUyNYn5HTAtuR4DLRt+eQZRSA52cg0a2mU5Lvh1LLBI3QXCekbzgYFq0mIY63b4OtccI7LYezf75uUIx8E6t9s1eT9Xm/t5cGVhLYSSkZgEmuJ5A7PAQQarj8GMWGG4rLRQQBOXbbCrhjA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(122000001)(38100700002)(38070700009)(55016003)(86362001)(26005)(9686003)(54906003)(316002)(478600001)(110136005)(8676002)(52536014)(8936002)(7696005)(6506007)(71200400001)(6636002)(66946007)(83380400001)(64756008)(76116006)(66556008)(66446008)(66476007)(33656002)(41300700001)(4326008)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHljQ05QalRxbGxtU1huOGNldDdIa1FYWFFCaU9vNTB4Y2Y0VDJEMnZ5ZTdn?=
 =?utf-8?B?OXFLRGJnbFdQNkYvUGo5T3FyR1o0V2V2alQ4NzBrYUJZK1BLQzNLOGczNnZw?=
 =?utf-8?B?ZFkwMUxXQzdnbFdRUXZmMDdYQXBxaC9aL1hkd1ROYkQrRVR0dllTV1QxSVlM?=
 =?utf-8?B?K3I3Zms3TXR5U2pKVTh4UDJkTGRXejBjZXplS2VEU2RsSGlDdXVtaFZSUGlO?=
 =?utf-8?B?cmhYdUFodGlRQk8zMHdmczFjUzFYU1RXZHJ0UkR6cGJHYjBmeVlDcjBiSUF2?=
 =?utf-8?B?cjJDTStzSjB5TDNtZGdIckxmVUxkMUtCY3I5cytlckxINkdUcTE5MUQxMHpr?=
 =?utf-8?B?RzZVc1FzRUVQdW5sSkpPY0laUGt4R0ZNME9pVU5ONmFhM1VZelJPdkdERWFR?=
 =?utf-8?B?U2s1NysvZEFaL2huOHg3d0VwZlhKLzRNeHdtOFJzeTJpbnJlNkg2UFRPektj?=
 =?utf-8?B?V0M5VEtOUDBKd1hNQXk1UUZzVWxGc2tRdEE0S1VML3dJY01sUFhJa0hpYmkv?=
 =?utf-8?B?T3VyYzRNR3lENWpwOEVJUFlCN0htckpLVzYvU0lpM3FrbVF4QU1sVCtJbU8z?=
 =?utf-8?B?a3hOOFJ5U0E0QXFMWExKRDZhNGQ0dis1Wnl1UUs0dEY3TG02bkxqY1ZoYlI1?=
 =?utf-8?B?bSt0TUlRWXlUNUowU1pseGY5OVlLR3lTdTA2M2lnN05xQjhjU2p5ZGJmd1pn?=
 =?utf-8?B?OUxlclNOSzdjMXRHelFOdERZaVVUREY4b0tOZmVMaXhRQk94UlVkd2ZpTmIr?=
 =?utf-8?B?R1plVyt3eXRxSDhXTGY3RjY5Unppazc3cE4yVjBnYk5NcmtreHFvaVFXQzZr?=
 =?utf-8?B?aXhMcjVWb1B5ZkVhOXduREFnRjdNdWpsdHpxendMdU16SlJVV24rbUxrdnJz?=
 =?utf-8?B?aDBCVlVJOTRrb2cvZDZrMDJ5enErVHMwS1RWTFIvQmtTeGMzcnp0M1lKMEdR?=
 =?utf-8?B?bVRZbHd2TEc0dWtmUU5paVJZSkt0N2JmQnRla2NmMHN2WE1qZ1p3QU5RKzhM?=
 =?utf-8?B?OW1LejZGOGNzUTNQek9LeDBQcEhZaHE0UmpPYldSd21ET2dKWjkyK21KQlhz?=
 =?utf-8?B?MVQ5QTNRZDRGVy9neXNuMEUyM2JxVE8rTWFsQnRXKzdrNm5pakdNaS84VVBU?=
 =?utf-8?B?QTdES0k2bWNMOWovSHRRZWxRRFFKaWw5TlhldTh1V29RSEZKL2JYOVZBd09h?=
 =?utf-8?B?RURCc3dXSjcwY1ZEWDdPR0NQN1puY1lwd3ErUkhyNHNyMk1XZzlOc1cxUjgv?=
 =?utf-8?B?UmFTU1RpVEdGd2tkMFVnamtVekZ2SUQzYVlOaXRTUGYvb09RdE9rUzIzeXMx?=
 =?utf-8?B?K0kwTnVmODI3b24rSDl2aU5CM0IzWTlwMmlXd3BmTmRWcWZpZmNQTTBSU3pr?=
 =?utf-8?B?NWY5V3JhV2pMU1Vja3BNM0RYemROZ0NQRFd4OC9NcVlFT3VscVpTV2F5UVJz?=
 =?utf-8?B?eDNsRzBQY0tRWm5UV2g1bDM1Zmp3Unc3TU9ZZ1kxSE9VdTNkSWI3eDI3bnRH?=
 =?utf-8?B?QlpCdGpINDlIOGt3eS9wQ2dIR1ZPWVhQUUYyZG5wSDh6K2thNTArbWRYWTVr?=
 =?utf-8?B?SnJaZE9vR0FKUlZRL2F6UHcxM2RCY1gyTUJQbm5TdG9jK2RFc0JXUTlYbDhG?=
 =?utf-8?B?eUVzYUJvak5KMkN1NkRIdXloOGxiN3MzZDN5a0hCM0lPSGFLa2JmL1dUZmIw?=
 =?utf-8?B?cXZGT1lHZ0VjVTN6VmNiOU5LZUpRSW55NlZiUExmanBDdVVLUHB1QnBUQkRq?=
 =?utf-8?B?dTZiR21HdzFXUGFzSFVVNlBoRmllVU5QeitGN1djOUg5SHVvMGZUWDFDclVu?=
 =?utf-8?B?OHFBYmh3ckpOTTFVSjV6M0s4a3RmbnY2T0d5c2ZBaWZuUjJoQmVqRzhGeHo0?=
 =?utf-8?B?TG1qa3BJdU1wQUV2QXZ6TVA5cTVxMGFrd1lRN00rQkNTTmxTUGRqTng0Q05p?=
 =?utf-8?B?R0t5dmRIL2hDajdlam9iQnNuMlQ4TU4yV1dJY0l5NE9sTTZBZHkvL2xrS09h?=
 =?utf-8?B?RVZYTW1Pd1ZxdXFsK3BKcERhd1BJOUNMSjFiOXdFLy95Z3RHMzhsY25SUFNh?=
 =?utf-8?B?Z1lLTVUvQ2swZVpyaURrd3RtR0QyZlBsWWlRM09aWHlEeXUxdU94QVNJQXNX?=
 =?utf-8?Q?cHA7wF1eNQW79FftaBR+NSYNu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006ee571-f9bb-4b5e-8ab1-08dc1631026b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 01:18:12.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7l8yvYTmovBwriEN+orCbPTXEyZYnwsmA1h7hNcNsDaOiyMjt1RhER2uSuineD5VB6Zto+vZOXV/5cO3hMZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKYW51YXJ5IDE2LCAyMDI0IDE6MjUgQU0NCj4gDQo+IE9uIFN1biwgTm92IDI2LCAyMDIzIGF0
IDEwOjM0OjIzUE0gLTA4MDAsIFlpIExpdSB3cm90ZToNCj4gPiArLyoqDQo+ID4gKyAqIGlvbW11
ZmRfZGV2aWNlX3Bhc2lkX2RldGFjaCAtIERpc2Nvbm5lY3QgYSB7ZGV2aWNlLCBwYXNpZH0gdG8g
YW4NCj4gaW9tbXVfZG9tYWluDQo+ID4gKyAqIEBpZGV2OiBkZXZpY2UgdG8gZGV0YWNoDQo+ID4g
KyAqIEBwYXNpZDogcGFzaWQgdG8gZGV0YWNoDQo+ID4gKyAqDQo+ID4gKyAqIFVuZG8gaW9tbXVm
ZF9kZXZpY2VfcGFzaWRfYXR0YWNoKCkuIFRoaXMgZGlzY29ubmVjdHMgdGhlIGlkZXYvcGFzaWQN
Cj4gZnJvbQ0KPiA+ICsgKiB0aGUgcHJldmlvdXNseSBhdHRhY2hlZCBwdF9pZC4NCj4gPiArICov
DQo+ID4gK3ZvaWQgaW9tbXVmZF9kZXZpY2VfcGFzaWRfZGV0YWNoKHN0cnVjdCBpb21tdWZkX2Rl
dmljZSAqaWRldiwgdTMyDQo+IHBhc2lkKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaW9tbXVmZF9o
d19wYWdldGFibGUgKmh3cHQ7DQo+ID4gKw0KPiA+ICsJaHdwdCA9IHhhX2xvYWQoJmlkZXYtPnBh
c2lkX2h3cHRzLCBwYXNpZCk7DQo+ID4gKwlpZiAoIWh3cHQpDQo+ID4gKwkJcmV0dXJuOw0KPiA+
ICsJeGFfZXJhc2UoJmlkZXYtPnBhc2lkX2h3cHRzLCBwYXNpZCk7DQo+ID4gKwlpb21tdV9kZXRh
Y2hfZGV2aWNlX3Bhc2lkKGh3cHQtPmRvbWFpbiwgaWRldi0+ZGV2LCBwYXNpZCk7DQo+ID4gKwlp
b21tdWZkX2h3X3BhZ2V0YWJsZV9wdXQoaWRldi0+aWN0eCwgaHdwdCk7DQo+ID4gK30NCj4gDQo+
IE5vbmUgb2YgdGhpcyB4YXJyYXkgc3R1ZmYgbG9va3MgbG9ja2VkIHByb3Blcmx5DQo+IA0KDQpJ
IGhhZCBhbiBpbXByZXNzaW9uIGZyb20gcGFzdCBkaXNjdXNzaW9ucyB0aGF0IHRoZSBjYWxsZXIg
c2hvdWxkIG5vdA0KcmFjZSBhdHRhY2gvZGV0YWNoL3JlcGxhY2Ugb24gc2FtZSBkZXZpY2Ugb3Ig
cGFzaWQsIG90aGVyd2lzZSBpdCBpcw0KYWxyZWFkeSBhIHByb2JsZW0gaW4gYSBoaWdoZXIgbGV2
ZWwuDQoNCmFuZCB0aGUgb3JpZ2luYWwgaW50ZW50aW9uIG9mIHRoZSBncm91cCBsb2NrIHdhcyB0
byBlbnN1cmUgYWxsIGRldmljZXMNCmluIHRoZSBncm91cCBoYXZlIGEgc2FtZSB2aWV3LiBOb3Qg
ZXhhY3RseSB0byBndWFyZCBjb25jdXJyZW50DQphdHRhY2gvZGV0YWNoLg0KDQpJZiB0aGlzIHVu
ZGVyc3RhbmRpbmcgaXMgaW5jb3JyZWN0IHdlIGNhbiBhZGQgYSBsb2NrIGZvciBzdXJlLiDwn5iK
DQo=

