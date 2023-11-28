Return-Path: <linux-kselftest+bounces-693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126427FB0E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 05:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EB9281B0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 04:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D9101E0;
	Tue, 28 Nov 2023 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwG1opZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784FF1A7;
	Mon, 27 Nov 2023 20:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701145403; x=1732681403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YMBOx3sjC+JJ13UUC68ag26ImRrtIJbo/Tg1GPDKuys=;
  b=CwG1opZHcSSJ2I8yBXWC7yjta9D04o/rlHtnRbMHxu0/HulFMtLGMYcq
   UalJZ0c0X0JdR9+1o+OuUpDamUSdQTvh5/PLjXpv35eQBMBEJhGwsu0y2
   AD+A9FW+4PwS8o0y8QHG7RQ/vDhy+AS0BMcu7aWrEWRpRdfEguQP2OOLK
   rXfkaIESVr7qRzivsdudwS0cns7og291I56Pm+6kJBG6XqHjBHxGTBDgb
   uR3Ue3Iabttjjjq9j0CXlNe7dxQcUxxUcDZmZsvfr5n6HmQov/zZNkgVu
   RfzAbtVQ9f9U749omikOIQTVL78ptdTB2Iw5xgw/M0n2LW7V/V7bHBCru
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6101425"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="6101425"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 20:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1015794101"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="1015794101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 20:23:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 20:23:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 20:23:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 20:23:21 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 20:23:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ7UwwaUu+Nwu+5vXO3s69W4F7QKGO3b9/ZpmdyG8XU67Bij2BQjBUlJ8+nBHQA8c2+QZfu25lX8yEptxgsYXDWb+6BseYAU194D2xZCGmmX391IYi1Rkc6eh1o/RjQMtqwbKw/tRhcYi9a37cY5qGlOJSvq0FS/y58bQjls1pl+Vst9nxeGyJBwxahIftPuFpmFVwsVCAC1SvzxTv/A/XtSGok+ursArr1q8DfNMsONZ8LyeZP2WehGhsz17mYe60EcgDClH0q7dvvBBKMFqezzyCgrtT8jpp4wKjeBgsntHk/FClJRw9jm/T+oDx8XDw+lPuJmQtQE3YvXfMILVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMBOx3sjC+JJ13UUC68ag26ImRrtIJbo/Tg1GPDKuys=;
 b=XrRJlKuh5AdziJeYgVKxJKkygJmnhsifMkhqTW0qsq4M/c0L1+RcVfa7bcDysUtVIlH6jjy3M/0zoG0SnYow0xdEU/m97TXCGLACvnjbuJ591SubZ/a8NMtiT6jfXzaJfOm99EMhkAxfTN3Nf7EHfizoDnuYKJex4KMZeAnGTQqRgHKXoh9hDXklJHEWMlvZGJKix3RE7/D+ubfOuCotx66Urjoiwyt/Fcyb7HCZIPz52gIaPRhaafkxvWswRk/t56Y7177xoYW1U3w/B2h94TlLuUhIE116nsT0uFyQbta9FpdS8EWbFrEFRGgXfl1KLOz3klU+5fGMnaRhgIP1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 04:23:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 04:23:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2oNLTxoUOTUKh4MiWO0yFiLCNv+UggAFPVICAABN7UA==
Date: Tue, 28 Nov 2023 04:23:18 +0000
Message-ID: <SJ0PR11MB6744980681B2DD67A3FF4A5092BCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <SJ0PR11MB6744DC9B7C7D0E4122F224FD92BDA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <88353789-6b37-44ca-aa21-23d27fab37ee@intel.com>
In-Reply-To: <88353789-6b37-44ca-aa21-23d27fab37ee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: a23b94e8-327e-40ad-5f56-08dbefc9bf83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TrxwDrkHKG1pWGALRtuisT+YT6c1QxstBjX0x+KdROOgcMol7U0/2fqPX7SHKlSoK3HoPeLP/e18hyIiMqJfNmuAjRLE49iw2p4P+LBlQVW0JzOu4JuWnrVF7597v53eUYCmi8jY6JBeY/Hz1AtJbR9T0aYluL+IFauRY9ldloWff2Av/icMJpAZCcyGzkTQDmPjdOIIIh7TDr3ka0cF2oxi2sY6XKs1qbU0qArKK8napWFxgf0pbLb9KER6RblY4XZejT7ZrAhGc+KgouKVYkCWhAyCX3/eA4Z/UsyiNXUnqP7b6DX6aUbbdHIN8skCOW9I8kZD/hNWLH3vxV3rL+qs4MCP0mZ5HqJnna/Ww2BS7L3eOC5Lt2vEcerCe6OulNfAqGuEArsO7nIV6vQaJXsGoYXnPyyPq7h9SeOPUNpeZNkM/h8JWcVbMVvBNsYcrIhGtKGtORA416B4ifcyye2pHpctTgiJhwwDAEDpLPuo6jK811oY9j0YkT7hFpFA8dFlBL1IXQI6Etkj7ilXu0kUAwIrnr2fPsrK8d0CRzBHawpP5DEBcv3nXeVBpVweUSC+VN3LcCiXu3PPPz3gtMC0ohUx/AM2+Kr9e5YHpeBYdSxN4/2+CkbpU2RWrSpi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(122000001)(82960400001)(55016003)(52536014)(9686003)(6506007)(7696005)(5660300002)(8936002)(4326008)(66946007)(316002)(66556008)(110136005)(76116006)(8676002)(64756008)(54906003)(53546011)(66476007)(66446008)(7416002)(478600001)(86362001)(38070700009)(41300700001)(33656002)(2906002)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWRqaHBheXlzMjhiRFQxRWhnRFRsUUFNWFgvL0daSC93TU9meW9vM01zSUg1?=
 =?utf-8?B?clQxdnR6ektBS3VTc0kvUysycFlSVkZsc1FHMWpGTC9uTnVmb2xzWXpya1dH?=
 =?utf-8?B?YVNWcGtIZW5GbGxnaTcrbmp2blNabFlqcXZBdEpIN1N6bWl2L2F3bjc5VDdy?=
 =?utf-8?B?eGg5OHg2Q2Z2RnU1cEJoVFBmczNTdGdiTTBheDE0V2hhWVlXRDNjalFnSDF0?=
 =?utf-8?B?QXV3OUV3cHpUVkZLREh3RnZvTUEweWhZUEVWVnBSUnR5S1FpY3hoRWdtZnJw?=
 =?utf-8?B?bGs1VkJ4NldqT3JzbGxxellGc3ExQ2tzVTJFaU1RSG4xOVJUSzRHM2J6VmlS?=
 =?utf-8?B?V0I4NzdnSERHMFhaMFY5dGRRekFsSUpMT1pEdmp2Q0dSV0NSNnhsdi9Nd2V5?=
 =?utf-8?B?YkJ6cXIvVHJwNDlFMFlMQVlMVHFhUHlJamV4ZzVYVWhEcGhoY1kwa1lHa09n?=
 =?utf-8?B?YjlZTzRxMFEwZlBRdTI0V0xaYW54dEVIS2xOcENFcjY4MkpDZ3lYMFo0c1RP?=
 =?utf-8?B?Y2Y2V1I2bjgrUVQyR1JiQ255Z2tEcEFrSEcvdE5TQkFlelFZREpvb05pdldl?=
 =?utf-8?B?dnVsTUJWbTNyVExWQ1JidmNxTGpQQlFaZHRXSlNvUExRZEI3K2ROb0tsNGpX?=
 =?utf-8?B?QjBKRGxTMHZDRVVKNU5rRkNiVmFsWU03S0w3U0ZIQ2NFY3gxTlB5clQ5M1E0?=
 =?utf-8?B?OHR1YkdFSTZPZ2E5REFXRnVzd2lRcGlLZWlpZzlhTTdiaW0vQ1A0RHRpSWZU?=
 =?utf-8?B?aysxRGFLSURoNFNBczVvcjJ2NS9tbGpUSmtkYmhoNHpEMGltQTNiSEFMeSsz?=
 =?utf-8?B?R01QWHVhK1FoYjc2MmRXTnl2d0NNMGt3R1B1MHQ2OFZMWkRWanJwdVZVMlZQ?=
 =?utf-8?B?VEk1TWdEOUFBdHkxd08vS0tmZW85WXVoL0Rra0JqMHRKUGFDZno0eWpRNXNE?=
 =?utf-8?B?RjJxd2RPWWR1OEtzanBKbmhTSTdoOGRUbmgyMVNmcEx1VmlQU1E0VEc3dkkv?=
 =?utf-8?B?MVhvbm0vckg2ZVA4TDVCUWtmVzRXd2QvU3o1T0tEczJCVzdmNERyc1lCcW1R?=
 =?utf-8?B?dlM4dFdIcE9yNm44dk1Gb0pYN0RRamZaMStpa3d6a2RaUzk1MGt0S0MrRFpn?=
 =?utf-8?B?USt4VEVGZndTN2VEblRTYnRBOE93bW1ZZGV2UjRWZEFSUE1ldHRvYVNZSFkv?=
 =?utf-8?B?V0hOZ2dUUExVa0pYVnFzdTYxN3dabkhYOXdPWTc3ZkxKQXhNT2VNVGV4djlB?=
 =?utf-8?B?RHpIdFhGc2kwZnlnc2ExYnFJbll0eDlXTFl5WXBVQ2M0ejJJTUR5eEY2Vng5?=
 =?utf-8?B?V285OVhRSGdaNjYyWU1RTzc1SENqaUhWbmNiRjlmMm0wUmY0bTNtTmxEY0pi?=
 =?utf-8?B?WnZNRW5FV1luTEFDK3FteStTcDhqV21aU1lrVjRiR0dsS0poTHZVR0xvc3V4?=
 =?utf-8?B?NG5Wd09tWFJwMGU0SElwS1lIVGR3SjhpcklQTXFpVW9ncGJVdUtSMlAyVUJN?=
 =?utf-8?B?ZGRXWEhwYVIrc0p4VkYzQVZUZzNQdGMyMVo3RCtQN1MwdTZvc3VuS1FMT280?=
 =?utf-8?B?RWhUYXdibFBrWUNHS29rai93WCsrdVJPWEdkNGpwbmpZMUhuTHpHUUNVcWg4?=
 =?utf-8?B?UlRQcWdEZW4vQVhhckJjd3A1SVNidWdpWU9ZY2UxTEp0S3k3b29vTGQxL2dx?=
 =?utf-8?B?STBWTXp4MG04ODdiUitVOWRSUVQ5ODNPOWZHZnVmQ2RxcXRndUVBUDRFLzds?=
 =?utf-8?B?Q2Vjemd1ZjJpWk1nTDl3cnJ3RytNWWVYaVYya1AwaWVzeGorRDB6dHhVaVJB?=
 =?utf-8?B?ajFDWGV1MHkwNElmeVpITUovQ0xxQUtoK0wzaFdudTIvRjgvdlkyOFlLY3ow?=
 =?utf-8?B?Q1Q5UTE2aG9TK1dCdnRVUlpYOXRkUFlSQ0IyZFdVYmtvL3I1QWN6TjU2Vm5O?=
 =?utf-8?B?emNiMG9nTFFvTkUxdFN2Z0UycElmb25OL1NvLzhqbGZXNnZOZHNsamVYeUg5?=
 =?utf-8?B?Y2JGZWFGckJwNWFoeGlSWWZVUHgxYTl0MkxTaEJGMHliR25lc1ZYeHduYWhp?=
 =?utf-8?B?Wi9URS9oNThKbUhaUzhCb3QrOUFiOWZJTEk0aEd3TVpMWE92SVpKczVuVFRu?=
 =?utf-8?Q?eWxRwltgDKg/nSvBRd4GWyynf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23b94e8-327e-40ad-5f56-08dbefc9bf83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 04:23:18.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMwr6aHm5EdNsLcjN7MEapSyfmZb4q97jXM4Jqbx6JIwj69WxwgxfUdJFxDu8CsboJjrWoy02ma0OJ8iEPiOO7N4OJOgTcrsodVXE0toZE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI4LCAyMDIzIDExOjEyIEFN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIHZmaW86IFJlcG9ydCBQQVNJRCBjYXBhYmlsaXR5
IHZpYSBWRklPX0RFVklDRV9GRUFUVVJFDQo+aW9jdGwNCj4NCj5PbiAyMDIzLzExLzI3IDE1OjI4
LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+IFNl
bnQ6IE1vbmRheSwgTm92ZW1iZXIgMjcsIDIwMjMgMjozOSBQTQ0KPj4+IFN1YmplY3Q6IFtQQVRD
SCAzLzNdIHZmaW86IFJlcG9ydCBQQVNJRCBjYXBhYmlsaXR5IHZpYSBWRklPX0RFVklDRV9GRUFU
VVJFDQo+Pj4gaW9jdGwNCj4+Pg0KPj4+IFRoaXMgcmVwb3J0cyB0aGUgUEFTSUQgY2FwYWJpbGl0
eSBkYXRhIHRvIHVzZXJzcGFjZSB2aWEgVkZJT19ERVZJQ0VfRkVBVFVSRSwNCj4+PiBoZW5jZSB1
c2Vyc3BhY2UgY291bGQgcHJvYmUgUEFTSUQgY2FwYWJpbGl0eSBieSBpdC4gVGhpcyBpcyBhIGJp
dCBkaWZmZXJlbnQNCj4+PiB3aXRoIG90aGVyIGNhcGFiaWxpdGllcyB3aGljaCBhcmUgcmVwb3J0
ZWQgdG8gdXNlcnNwYWNlIHdoZW4gdGhlIHVzZXIgcmVhZHMNCj4+PiB0aGUgZGV2aWNlJ3MgUENJ
IGNvbmZpZ3VyYXRpb24gc3BhY2UuIFRoZXJlIGFyZSB0d28gcmVhc29ucyBmb3IgdGhpcy4NCj4+
Pg0KPj4+IC0gRmlyc3QsIFFlbXUgYnkgZGVmYXVsdCBleHBvc2VzIGFsbCBhdmFpbGFibGUgUENJ
IGNhcGFiaWxpdGllcyBpbiB2ZmlvLXBjaQ0KPj4+ICAgIGNvbmZpZyBzcGFjZSB0byB0aGUgZ3Vl
c3QgYXMgcmVhZC1vbmx5LCBzbyBhZGRpbmcgUEFTSUQgY2FwYWJpbGl0eSBpbiB0aGUNCj4+PiAg
ICB2ZmlvLXBjaSBjb25maWcgc3BhY2Ugd2lsbCBtYWtlIGl0IGV4cG9zZWQgdG8gdGhlIGd1ZXN0
IGF1dG9tYXRpY2FsbHkgd2hpbGUNCj4+PiAgICBhbiBvbGQgUWVtdSBkb2Vzbid0IHJlYWxseSBz
dXBwb3J0IGl0Lg0KPj4+DQo+Pj4gLSBTZWNvbmQsIFBBU0lEIGNhcGFiaWxpdHkgZG9lcyBub3Qg
ZXhpdCBvbiBWRnMgKGluc3RlYWQgc2hhcmVzIHRoZSBjYXAgb2YNCj4+PiAgICB0aGUgUEYpLiBD
cmVhdGluZyBhIHZpcnR1YWwgUEFTSUQgY2FwYWJpbGl0eSBpbiB2ZmlvLXBjaSBjb25maWcgc3Bh
Y2UgbmVlZHMNCj4+PiAgICB0byBmaW5kIGEgaG9sZSB0byBwbGFjZSBpdCwgYnV0IGRvaW5nIHNv
IG1heSByZXF1aXJlIGRldmljZSBzcGVjaWZpYw0KPj4+ICAgIGtub3dsZWRnZSB0byBhdm9pZCBw
b3RlbnRpYWwgY29uZmxpY3Qgd2l0aCBkZXZpY2Ugc3BlY2lmaWMgcmVnaXN0ZXJzIGxpa2UNCj4+
PiAgICBoaWRlbiBiaXRzIGluIFZGIGNvbmZpZyBzcGFjZS4gSXQncyBzaW1wbGVyIGJ5IG1vdmlu
ZyB0aGlzIGJ1cmRlbiB0byB0aGUNCj4+PiAgICBWTU0gaW5zdGVhZCBvZiBtYWludGFpbmluZyBh
IHF1aXJrIHN5c3RlbSBpbiB0aGUga2VybmVsLg0KPj4+DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBBbGV4
IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+IGRyaXZlcnMvdmZp
by9wY2kvdmZpb19wY2lfY29yZS5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+PiBpbmNsdWRlL3VhcGkvbGludXgvdmZpby5oICAgICAgICB8IDEzICsrKysrKysrKw0K
Pj4+IDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jIGIvZHJpdmVycy92ZmlvL3BjaS92
ZmlvX3BjaV9jb3JlLmMNCj4+PiBpbmRleCAxOTI5MTAzZWU1OWEuLjgwMzhhYTQ1NTAwZSAxMDA2
NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3ZmaW8vcGNpL3ZmaW9fcGNpX2NvcmUuYw0KPj4+ICsrKyBi
L2RyaXZlcnMvdmZpby9wY2kvdmZpb19wY2lfY29yZS5jDQo+Pj4gQEAgLTE0OTUsNiArMTQ5NSw1
MSBAQCBzdGF0aWMgaW50IHZmaW9fcGNpX2NvcmVfZmVhdHVyZV90b2tlbihzdHJ1Y3QNCj4+PiB2
ZmlvX2RldmljZSAqZGV2aWNlLCB1MzIgZmxhZ3MsDQo+Pj4gCXJldHVybiAwOw0KPj4+IH0NCj4+
Pg0KPj4+ICtzdGF0aWMgaW50IHZmaW9fcGNpX2NvcmVfZmVhdHVyZV9wYXNpZChzdHJ1Y3QgdmZp
b19kZXZpY2UgKmRldmljZSwgdTMyIGZsYWdzLA0KPj4+ICsJCQkJICAgICAgIHN0cnVjdCB2Zmlv
X2RldmljZV9mZWF0dXJlX3Bhc2lkIF9fdXNlcg0KPj4+ICphcmcsDQo+Pj4gKwkJCQkgICAgICAg
c2l6ZV90IGFyZ3N6KQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3QgdmZpb19wY2lfY29yZV9kZXZpY2Ug
KnZkZXYgPQ0KPj4+ICsJCWNvbnRhaW5lcl9vZihkZXZpY2UsIHN0cnVjdCB2ZmlvX3BjaV9jb3Jl
X2RldmljZSwgdmRldik7DQo+Pj4gKwlzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9wYXNpZCBw
YXNpZCA9IHsgMCB9Ow0KPj4+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB2ZGV2LT5wZGV2Ow0K
Pj4+ICsJdTMyIGNhcGFiaWxpdGllcyA9IDA7DQo+Pj4gKwlpbnQgcmV0Ow0KPj4+ICsNCj4+PiAr
CS8qIFdlIGRvIG5vdCBzdXBwb3J0IFNFVCBvZiB0aGUgUEFTSUQgY2FwYWJpbGl0eSAqLw0KPj4+
ICsJcmV0ID0gdmZpb19jaGVja19mZWF0dXJlKGZsYWdzLCBhcmdzeiwgVkZJT19ERVZJQ0VfRkVB
VFVSRV9HRVQsDQo+Pj4gKwkJCQkgc2l6ZW9mKHBhc2lkKSk7DQo+Pj4gKwlpZiAocmV0ICE9IDEp
DQo+Pj4gKwkJcmV0dXJuIHJldDsNCj4+PiArDQo+Pj4gKwkvKg0KPj4+ICsJICogTmVlZHMgZ28g
dG8gUEYgaWYgdGhlIGRldmljZSBpcyBWRiBhcyBWRiBzaGFyZXMgaXRzIFBGJ3MNCj4+PiArCSAq
IFBBU0lEIENhcGFiaWxpdHkuDQo+Pj4gKwkgKi8NCj4+PiArCWlmIChwZGV2LT5pc192aXJ0Zm4p
DQo+Pj4gKwkJcGRldiA9IHBjaV9waHlzZm4ocGRldik7DQo+Pj4gKw0KPj4+ICsJaWYgKCFwZGV2
LT5wYXNpZF9lbmFibGVkKQ0KPj4+ICsJCWdvdG8gb3V0Ow0KPj4NCj4+IERvZXMgYSBQRiBib3Vu
ZCB0byBWRklPIGhhdmUgcGFzaWQgZW5hYmxlZCBieSBkZWZhdWx0Pw0KPg0KPlRvZGF5LCBob3N0
IGlvbW11IGRyaXZlciAoYXQgbGVhc3QgaW50ZWwgaW9tbXUgZHJpdmVyKSBlbmFibGVzIGl0IGlu
IHRoZQ0KPnRpbWUgb2YgZGV2aWNlIHByb2JlIGFuZCBzZWVtcyBub3QgY2hhbmdlZCBhZnRlcndh
cmQuIFNvIHllcywgVkZJTyBzaG91bGQNCj5zZWUgaXQgaWYgcGFzaWQgaXMgZW5hYmxlZC4NCj4N
Cj4+IElzbid0IHRoZSBndWVzdCBrZXJuZWwncyByZXNwb25zaWJpbGl0eSB0byBlbmFibGUgcGFz
aWQgY2FwIG9mIGFuIGFzc2lnbmVkIFBGPw0KPg0KPmd1ZXN0IGtlcm5lbCBzaG91bGQgbm90IGhh
dmUgdGhlIGNhcGFiaWxpdHkgdG8gY2hhbmdlIGhvc3QncyBwYXNpZA0KPmNvbmZpZ3VyYXRpb24u
IEl0IGNhbiBvbmx5IHdyaXRlIHRvIGl0cyBvd24gdmNvbmZpZyBlbXVsYXRlZCBieQ0KPmh5cGVy
dmlzb3IuDQoNClVuZGVyc3Rvb2QsIHRoYW5rcyBZaS4NCg0KQlJzLg0KWmhlbnpob25nDQo=

