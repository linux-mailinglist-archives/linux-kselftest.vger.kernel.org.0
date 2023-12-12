Return-Path: <linux-kselftest+bounces-1635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58A80E154
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 03:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3CB20F3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 02:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CFC15CC;
	Tue, 12 Dec 2023 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGND4d9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED93B5;
	Mon, 11 Dec 2023 18:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702347606; x=1733883606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3/kUIQijFEPktB4yf3avv7wJ9Q9hc+6Bc9DZfHtOst8=;
  b=eGND4d9G/tFo1omxsbs9UKG1g1ISFr8S+gcRyqjnwqqKmL6an3xQvXeM
   feJhw2oyrTysAkQdFEMGXxgoLseCqu/834SyVAQmpw1Xx0LcfKSVIULhl
   ORKFgzSAYe5Ap5mlcOULbsJYMrtG9kvef5L64hJno3aHtwPCWju0o/emY
   79O3dnqTzdiQPWLDG8QRojqSZZjdx+BV1VKc3lRY5R9THNXPMxDsjGyxH
   ZjMklLoHDm8TnA7wTd4WL0S2mbG6xjkoZWcTdia+ckHHgyeUUnfevfqch
   bQ/KuHE3ZzFhLABfx2AFZhM7h0LRO8zUBa34MFuPxhNGcUzv7mSQu9oJW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="385154572"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="385154572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="773340664"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="773340664"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 18:20:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 18:20:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 18:20:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 18:20:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE67nSW/ttqDWg1MpBziyFAMRg+7M4HcQIsS/t3ZGMcetorCKxyPENLbGGYBG1eKQH65GF/vxOuMwhiEPR2VkeKWnBpCHKcBnB+rwtabTPFH0Nmcz2VWdAdA/uzZgbTVSwrcN1xQJT/IjGPP8CaMz2CsgVW1aYRa61ZvZwAQcpWQ4yOSNUcQ6uSasCQP/mKy6cP/ZlMcx/19MTq/SB1FT9P0hFPhKpHDoFsGKNAPnQkrrGimaCgd4GP9GgYnHbB8QsUbtfa+lgHDx359HMZv29mAC8FHJOAbcy7VCMHbUYHhUud+WeD/GQKoZBwvetFpCzZLFGFddBbzZfvDp8ayBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/kUIQijFEPktB4yf3avv7wJ9Q9hc+6Bc9DZfHtOst8=;
 b=ZQOlF8209Dysv4UzLjomhBi7s1wm/ICoz8or5OIPCJAwD9lSzAHO2i/7SlfXw8/LPNri9NMNp27W4LNwHn63MiXYmTYcBsICoF5KIB+GGthjZitHffjOcFhtauOz6xUIXxwDRqA33E/VCjGNPJHso9J5IpeKLFoei5HUgCjOt8ulK30X3ynnSCoNehwSGrJXJ2c5dbdS7McV3K7eulkhLDGoXFKtoJma0S6LqEu6S8WcdksAzfUYoQ50O2diRwtUlaiW04q76gTf2D4aXfbLW7uL/P6UdoFJD3/R2fgG3EDebLMsuvQ4uRqDoh1+6lu7dbmcN6lE9X7efxxr9NGUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5877.namprd11.prod.outlook.com (2603:10b6:510:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 02:20:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 02:20:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2EKyfzMrBBEWzcc+IDcJP4bCdkKlggAY/u4CAATAaUA==
Date: Tue, 12 Dec 2023 02:20:01 +0000
Message-ID: <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
In-Reply-To: <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5877:EE_
x-ms-office365-filtering-correlation-id: 5a9f8fc5-85f0-49f6-38d7-08dbfab8d8c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWw1cAvsbVR/gqn8COXH1dScUdWtskUBaQtz6/j5/vM0pgq7Mlf/dTu5kSYphM5CxMPAuGFwDvPIwqXEDuIcvUTIbXGP3zMB646DcOqNfr/skUvl3WTFrtcqtZjw62WqSksfUVdyHCk+ROnRbyOyfy16H1GtTL1utlWvSKxesfwclIBzsrqaaMr+8VMwzq6vuqNaiHdws00739/bPMjP8UGmFN0GeOLEb0KoOuvDVMy+Ym41Hn/pkDm5grwYUIEeICazWQozU0TkyEvTQMklFZPjY2n4++jayHErdm9vV/UJ8gaWiLeOACrUuVWlzYQHiDGqP9JTysQ8mBTJXzWTvk+p856Fw8uUsa3Hj/0Piq7WR147OX0pGla9XOkcWZ3/00ucyb2geAAQ2OLgZPQjqmUdV8EDKK242wHp2F67BL6p7XltbgK3/D8XqLBRJkyfwmiZJzWn6dOeJ6de70Gc+eSVMMjxSbVX4qI3ahpEB4d5iM1Jc72ZAkA2162jiYzu2MFkndbHJpisJBuMBe+YY3/thiHhIO/2xF7d1XrZnFY/6TaOoeBnHP32N18Flg6H31w8th6JhQ0lzQL2Iu0YdvVbZDVFxrR4JiOAv5nRmPSyLGjKwvmEvwldsBlXf0pU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(26005)(82960400001)(38070700009)(86362001)(33656002)(38100700002)(122000001)(5660300002)(316002)(8936002)(4326008)(8676002)(2906002)(7416002)(6506007)(7696005)(53546011)(71200400001)(9686003)(66476007)(52536014)(54906003)(64756008)(66446008)(110136005)(66556008)(66946007)(478600001)(76116006)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0czR2ZPc3hhblc4cjIwa3Jhd2l0aGNSNnJBSm54UWkreEttbExoRlNmTVBP?=
 =?utf-8?B?dk01TTZvNXRld1lqeExJMWMwaGtvbytpTkQ2YjdHSFY1Z1N5ZmZ2NVloaTVT?=
 =?utf-8?B?WUdoUU8xTXZweFpVZnNzK2RNVHdVa1lIT1NraGd5Q05KYjA0Z1NJZUdyZGQy?=
 =?utf-8?B?YTNvK0QxaURrMWJuRUZNc1lPdzJGWCtTWHV6WU84YXBZV0taWENkbzRxVEUv?=
 =?utf-8?B?VDd5WVUvVjd3NTdCZ3FodzhHdDRybHNCS1g0RTZINFVBdEM4bTljQVFQSzMr?=
 =?utf-8?B?WWNHR2k3eFRQdzhWVjMzVDhhSE0xSEZjdndLRmFkQnZtMmxLSC8xUFhPcFJa?=
 =?utf-8?B?S2phSlJkN1JvRVNNWmRoUXJKVjJNV2xhd0ZZd1I1c3YwOFZSS2k2TGE4U1FJ?=
 =?utf-8?B?UDEyeCtqcGEvV0RIOE83dGUrSDAvVmoxb1VsQjE1cEdaenE1bW9hcUFRWHYz?=
 =?utf-8?B?ektxUnFLclMzZ3dBZVArU0E4aE1MNGxMN2h3a09vYk0zZUNUYXNoZ3lJWWFQ?=
 =?utf-8?B?blpaNlA5eTRpTHJpUlpDL3hDc3JRVUYrYjQvN2ZyZlFOQVh6NzZCaHFMQk5Q?=
 =?utf-8?B?MXFPbFZPRzBTaXpPaFEwbzdNZ0NQdFhlV212WXZLaE8vUUpYN3RIbVdESFFB?=
 =?utf-8?B?ZHduWWdzN0ZIM0I4ck1sYVRRaTFiY1IvUVlKTnJoMDlER2lLbFFpM0VpcWF2?=
 =?utf-8?B?RTI2dUV0VHhnaWErVkJpUHlRdWtDa3BwMytwL1Q1NFdpMFN2b0ZUTThJaVdC?=
 =?utf-8?B?UVVJWHQrMVVIaHhXZ25lbFo3cnpuOGZmeTl0SGZBaWI1NDNtQ3hmT0Q5UG1K?=
 =?utf-8?B?UExlNFgrcnBtNjNvTFovZWtOQUFndzBWVXpGcmw1YnArRm1aTm54Q1ZiS1pN?=
 =?utf-8?B?bkxnOEJyTytEV21xZGxlV0FCYVJkWEpPN0pxTy9RbmxqZ2FNMVhMVXdmZXdj?=
 =?utf-8?B?ZHFwdHFLU252UDE1b2VUZlNKeVhMeEZQck1LYXg4ZUY0ZVVDUTY4bFN0dFhM?=
 =?utf-8?B?T1p1ZzNKd1dpM3lRbmwvMFZlK0FKTE84Y25XSnd1YVQvT3ZsTU5PM2ZtQ1pR?=
 =?utf-8?B?bzUwSy9GMlJjR0VycjFkR2F0REhsZUhqdExBbEM4UHJuTnBBTnBSZEoyZFlk?=
 =?utf-8?B?cnNCNTRJZk82SFlrVVk1N0NiY0tNZ2tBdDFYZzN0TGtpOHVLNUZVNDJ3RHha?=
 =?utf-8?B?WXN2aFBwZDh2YzBwNEdTNlZSUVhlSEZybmFYRzBGL0R6VExJK3JSRGV3MHBH?=
 =?utf-8?B?WlZRYld1WjBtVUJXOWU1YjkvSFBDWGFkLzlnSnQrMC9zL0ZkNVdYV09OcUg3?=
 =?utf-8?B?N2dadzMxc3FBY242L2FtR1pmQmNLbVBVQzhwRERCS2Y1MXVvUSsvTjhqMWhC?=
 =?utf-8?B?Rjh5M1FHTmViNDJxbVlFQ09aMmduTVBISTE2cHJyWUh3QmFNajM3Q0JWNTRn?=
 =?utf-8?B?QmVXVU5PSzNGTnA5WG03VjMwRDdxTWE0K296bkV1SlBDK3RCRVg2M1lNNkZM?=
 =?utf-8?B?bVBEeVBRUEtDbVNzTjE2SDYvenkvL2czcjlVVWk1MVJuWTVCVEFNcVVDSXlX?=
 =?utf-8?B?ZVRqQS9la1VwVGV6OWJXeHR6dGRheGZoUGd3NTVOSlMxVVM1WjVsWFcvWW84?=
 =?utf-8?B?KzZ1MEZHQ3RNcXUxelFGRXkyWk1pUUFPZ0VUbkR0UWRmbU91S3lHV0RKQXov?=
 =?utf-8?B?ZDNMU00ycXlpSkcrWGRWbjNVWjluYzUvdDdjOHMrTVh0UlVBaUFBMkdrcWwz?=
 =?utf-8?B?cjJUVzJuZ1ZOVzhLQTFNUU9NcFZhWVdEMTM2WTJ0dzV5OUdOK3VCeDZ3Qjd2?=
 =?utf-8?B?WU5xeFJ6WHBCeTJJemprM01meFY2MlI0ZGdJK01peHhSR3Y0aGlwcXd0Q1Zl?=
 =?utf-8?B?YTVlNXoxRHVSbk5hQWxsMlg0amZTTUhyTlRreFU0cFl3R0k0WU5VZ0NobjRs?=
 =?utf-8?B?cHkrdW1YdmtHNTF6TXpCZURsK1hXSjJ5ODREWVBlUHE2SWs3VnR2dTd0NWg2?=
 =?utf-8?B?T3AxNFRoTG1WS0IvaFlxUU9GQ0hSR0JoN2hTMXV3L2ZrZFNVZUpTSE1SMHFF?=
 =?utf-8?B?TmxXNnI1RlVvekI5aWcrMVhFNUtpeURzYW4wL3FveTlEeTFuVHJQVWRSN0gy?=
 =?utf-8?Q?k+fegh6AmQJEJvrbZ3D+cWyKr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9f8fc5-85f0-49f6-38d7-08dbfab8d8c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 02:20:01.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbwSXMaKG9tyPz+TNuSeYCrQ9dRTnUjQrya9ghOcOkxrwzj7X1SQxsI+vpFSVGU2OAh1PLSSdOfd3o4gHDyhjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5877
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBE
ZWNlbWJlciAxMSwgMjAyMyA0OjA4IFBNDQo+IA0KPiBPbiAyMDIzLzEyLzcgMTY6NDcsIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gPj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyNywgMjAyMyAyOjM5IFBNDQo+ID4+DQo+ID4+
ICtzdGF0aWMgaW50IHZmaW9fcGNpX2NvcmVfZmVhdHVyZV9wYXNpZChzdHJ1Y3QgdmZpb19kZXZp
Y2UgKmRldmljZSwgdTMyDQo+IGZsYWdzLA0KPiA+PiArCQkJCSAgICAgICBzdHJ1Y3QgdmZpb19k
ZXZpY2VfZmVhdHVyZV9wYXNpZCBfX3VzZXINCj4gPj4gKmFyZywNCj4gPj4gKwkJCQkgICAgICAg
c2l6ZV90IGFyZ3N6KQ0KPiA+PiArew0KPiA+PiArCXN0cnVjdCB2ZmlvX3BjaV9jb3JlX2Rldmlj
ZSAqdmRldiA9DQo+ID4+ICsJCWNvbnRhaW5lcl9vZihkZXZpY2UsIHN0cnVjdCB2ZmlvX3BjaV9j
b3JlX2RldmljZSwgdmRldik7DQo+ID4+ICsJc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmVfcGFz
aWQgcGFzaWQgPSB7IDAgfTsNCj4gPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHZkZXYtPnBk
ZXY7DQo+ID4+ICsJdTMyIGNhcGFiaWxpdGllcyA9IDA7DQo+ID4+ICsJaW50IHJldDsNCj4gPj4g
Kw0KPiA+PiArCS8qIFdlIGRvIG5vdCBzdXBwb3J0IFNFVCBvZiB0aGUgUEFTSUQgY2FwYWJpbGl0
eSAqLw0KPiA+DQo+ID4gdGhpcyBsaW5lIGFsb25lIGlzIG1lYW5pbmdsZXNzLiBQbGVhc2UgZXhw
bGFpbiB0aGUgcmVhc29uIGUuZy4gZHVlIHRvDQo+ID4gbm8gUEFTSUQgY2FwYWJpbGl0eSBwZXIg
VkYuLi4NCj4gDQo+IHN1cmUuIEkgdGhpbmsgdGhlIG1ham9yIHJlYXNvbiBpcyB3ZSBkb24ndCBh
bGxvdyB1c2Vyc3BhY2UgdG8gY2hhbmdlIHRoZQ0KPiBQQVNJRCBjb25maWd1cmF0aW9uLiBpcyBp
dD8NCg0KaWYgb25seSBQRiBpdCdzIHN0aWxsIHBvc3NpYmxlIHRvIGRldmVsb3AgYSBtb2RlbCBh
bGxvd2luZyB1c2Vyc3BhY2UgdG8NCmNoYW5nZS4NCg0KYnV0IHdpdGggVkYgdGhpcyBpcyBub3Qg
cG9zc2libGUgaW4gY29uY2VwdC4NCg0KPiA+PiArCWlmIChwZGV2LT5pc192aXJ0Zm4pDQo+ID4+
ICsJCXBkZXYgPSBwY2lfcGh5c2ZuKHBkZXYpOw0KPiA+PiArDQo+ID4+ICsJaWYgKCFwZGV2LT5w
YXNpZF9lbmFibGVkKQ0KPiA+PiArCQlnb3RvIG91dDsNCj4gPj4gKw0KPiA+PiArI2lmZGVmIENP
TkZJR19QQ0lfUEFTSUQNCj4gPj4gKwlwY2lfcmVhZF9jb25maWdfZHdvcmQocGRldiwgcGRldi0+
cGFzaWRfY2FwICsgUENJX1BBU0lEX0NBUCwNCj4gPj4gKwkJCSAgICAgICZjYXBhYmlsaXRpZXMp
Ow0KPiA+PiArI2VuZGlmDQo+ID4NCj4gPiAjaWZkZWYgaXMgdW5uZWNlc3NhcnkuIElmIENPTkZJ
R19QQ0lfUEFTSUQgaXMgZmFsc2UgcGRldi0+cGFzaWRfZW5hYmxlZA0KPiA+IHdvbid0IGJlIHNl
dCBhbnl3YXkuDQo+IA0KPiBpdCdzIHNhZCB0aGF0IHRoZSBwZGV2LT5wYXNpZF9jYXAgaXMgZGVm
aW5lZCB1bmRlciAjaWYgQ09ORklHX1BDSV9QQVNJRC4NCj4gUGVyaGFwcyB3ZSBjYW4gaGF2ZSBh
IHdyYXBwZXIgZm9yIGl0Lg0KDQpvaCBJIGRpZG4ndCBub3RlIGl0Lg0KDQo+IA0KPiA+IGFuZCBp
dCBzaG91bGQgcmVhZCBmcm9tIFBDSV9QQVNJRF9DVFJMIHdoaWNoIGluZGljYXRlcyB3aGV0aGVy
IGENCj4gPiBjYXBhYmlsaXR5IGlzIGFjdHVhbGx5IGVuYWJsZWQuDQo+IA0KPiB5ZXMsIGZvciB0
aGUgRVhFQyBhbmQgUFJJViBjYXBhYmlsaXR5LCBuZWVkcyB0byBjaGVjayBpZiBpdCdzIGVuYWJs
ZWQgb3INCj4gbm90IGJlZm9yZSByZXBvcnRpbmcuDQo+IA0KPiA+DQo+ID4+ICsvKioNCj4gPj4g
KyAqIFVwb24gVkZJT19ERVZJQ0VfRkVBVFVSRV9HRVQsIHJldHVybiB0aGUgUEFTSUQgY2FwYWJp
bGl0eSBmb3IgdGhlDQo+ID4+IGRldmljZS4NCj4gPj4gKyAqIFplcm8gd2lkdGggbWVhbnMgbm8g
c3VwcG9ydCBmb3IgUEFTSUQuDQo+ID4NCj4gPiBhbHNvIG1lbnRpb24gdGhlIGVuY29kaW5nIG9m
IHRoaXMgZmllbGQgYWNjb3JkaW5nIHRvIFBDSWUgc3BlYy4NCj4gDQo+IHllcy4NCj4gDQo+ID4g
b3IgdHVybiBpdCB0byBhIHBsYWluIG51bWJlciBmaWVsZC4NCj4gDQo+IEl0IGlzIG5vdCBleGFj
dCB0aGUgc2FtZSBhcyB0aGUgc3BlYyBzaW5jZSBiaXQwIGlzIHJlc2VydmVkLiBCdXQNCj4gaGVy
ZSBiaXQwIGlzIHVzZWQgYXMgd2VsbC4NCj4gDQoNCndoYXQgaXMgYml0MCB1c2VkIGZvcj8NCg==

