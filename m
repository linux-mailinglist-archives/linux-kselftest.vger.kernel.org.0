Return-Path: <linux-kselftest+bounces-2456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460381ED99
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8856B1C2236C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708EF134A2;
	Wed, 27 Dec 2023 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEW0zZdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8712C1AE;
	Wed, 27 Dec 2023 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703667984; x=1735203984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+nTTaAui4NUbpQNySmaCv/FewadJKpx4LVhZIiyV5yY=;
  b=fEW0zZdqjtx5UswLD2nASKUvE/mOY1naJBZSaYDrGAI4y3+ow0Ani42X
   dPuEGFS/zOOG15HxG2mKZ6P/bTW4jLW4ozF2mGRza0GKXvSWkaVR7FeYp
   in83HKfKU928aFqFma7vDx1mejlKmCyy/CbXG41M8qVZKA/wG7Yi3Xgtl
   J9l69fytrxIYMeJRxhISpBJgjZhHGTsEOO4mgnqIfnuUnLXmgSLJyXfEa
   0E6ZDMBeD8Fp6NMoEuPbI7DK8Qu9eXo9JLv2+pmLbA74bEYk/X3MFD0Wt
   BBu8mTF6wWRCxVaZdbgIW6xmI5RigPNxwgtrelFON8/xE3xKRZ89T4X2q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="376573479"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="376573479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 01:06:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="848634392"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="848634392"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 01:06:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 01:06:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 01:06:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 01:06:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 01:06:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INruS7PNM5uBniyGxcnR4OqbRVI8ycVyNYeZrVmMu3iCrP62Aandov+105s9bdRtkbZZUnXn8i6SYYDOSAMdBKhO2J2SBVUeyPSpzyU/XOmkBwaljaWsJlCFK+9H4Dl7U5xxxcSXOU5waRCTFhOW+WOXjJpIgyu2fHdDP0xRyuSTK6wd/HdKmPavHqCkn2h07d+Y2a6T7DZmaDK2/xSmcTXhYJ/8QnfjQh0p/0sc/crASrFqEuwaXa8K9TmyXdVjNdgofXH4cvrh8hlbHHTREHRXxhLJgmp5bHKX6tmPAv7YFcY2N5YuMsIoNFb8qKNqBxMe/CTg2Z7EfTQ4NDgvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nTTaAui4NUbpQNySmaCv/FewadJKpx4LVhZIiyV5yY=;
 b=j70+nsycV7WIf3M6wb5gVEYg7c0BpusU2+ZZqQwSdg3DndFCSuFTz5Qqmk5oPUB4AlQw7ygfeSm11XBz4vMIHWJ7OdP/GKAHs2xHtbDYjzAfxim9iAWfSXFGp2UWTl5WL79HFrrVF/tMYT3L8YkDTfStq6pmaczUHv1lacDUNx0JXgMGBrzc4j0a4V+9Ki252yE2ySYkqqvvn4PjlK2Adk/oIYow2kOwZjWX2aBQiDoZ7bdyaNLeoekPIlnaDOJyElPHHRbF7Qq5O/WI0VJfy4QFQzfnSg8SlLJdBhlFxLYto80FZ0T8xuQZzDKDhI3CKXYGAE7xvAf6cD2O9uK4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 09:06:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 09:06:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Index: AQHaNCP7HkCophUDzUmwNpia7PyNzrC0tOuAgAZDrICAAAMBAIAAIgmAgAApcoCAAUJ50A==
Date: Wed, 27 Dec 2023 09:06:19 +0000
Message-ID: <SJ0PR11MB67444BD4606F7A4014801B16929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
 <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
In-Reply-To: <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 4840dbb8-9048-44b7-ff7a-08dc06bb1742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOXZDKr1ERrTXxB6GgHfsth5wuRx0f+eal9NYz98iN7tUSgUHPlQMfIFXe6oCfUPiF2r6ZbiBT2TvZ5NbEb2f4+BV7fAA6OSxhi+81/cG94tXOyz0CyKpuXDGMjE0PJAJdT2FcvUIvAZimvzZXTav09zfM1cdIIu5ltdO1x6pJK2vdG/uxTieYAaLRpZVGK8u3ffq6DcDSKoSf4G8PbXdrAKWFP2OTwpP0lNssa1Mh4gc+trNhFGL9vZS7Bis0lDZ+gQ7AxeskVbYRRroi9ZpGI1YtgNLW3+GPJRMGxbU7w14eDd5sE4Xae0NPooj4RygXDf7tTyArlinhRSjzIe7lHUDpTdogbS9RvIiqu0iyWlrjllkW6lZhHvXibdeot89tDXge/VhoLpZYxSyky7a/uSqtfM/0KrjKEGL7ItXrHC1YP42jvqnGGF4XCwvmuWFBSnV1PctIv7ibFpG6qcmiLKvmzAR06ixbTIDSBztJanK83mzGA8W1+21MhnInbFmGNiAoo3Fi3gFc1YVScKgCoNJ0o8slvebJAbEzmClSVsyXCKthHDtOnLTx00PtacXZU8ft8ay394WU2H5o4phWBww8qIV7+Fsp27CtTBa4xuhezVJKb9GUJ7fQ2kb6GY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82960400001)(38070700009)(110136005)(83380400001)(64756008)(66446008)(66556008)(316002)(66476007)(66946007)(54906003)(76116006)(52536014)(8676002)(4326008)(8936002)(71200400001)(9686003)(6506007)(7696005)(53546011)(478600001)(38100700002)(26005)(41300700001)(122000001)(5660300002)(7416002)(2906002)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2pYSENhUmVzbFJKWDdlUFNDSmtZWGRTRWV4aUx5SytCbXlwdCtPNXNqT3dx?=
 =?utf-8?B?aUJqcUFwNzFYYWNhd1M4bkdza3AvMUxocWFGdHUrczVuTlB1NDFrb0JxYWI1?=
 =?utf-8?B?Njl4czlGYnBOcWVYUTloRmRKL1FHU28wWThPNEF5WHM5ZGtHd2FUdU92bXRr?=
 =?utf-8?B?bFliMGozQ1FxeUJPellmMVlTQVE1dGh4MnJybXJZY2dKWk9nTUNOQ0g1dCtv?=
 =?utf-8?B?VWQyUWpnbTluaTRLb0dqRjc0UnRTMmtmcWNqVG5heTNNd2pJUkdFY3ZmVnJl?=
 =?utf-8?B?ZTJNN1pyeVRReWxyY1lUbHFySlJDdEx5OVc3U1liSjQyVTJhdll3M0YveEwx?=
 =?utf-8?B?eHZlR050eGhObGF3TmR6UVNNa0FDOEUxRGhnUThtbnlBOVVMalh1bXluT2w4?=
 =?utf-8?B?MUtXWVI2cnVKdU5Edm9qR1BwNGY0Y1YwVXlsR0ZRUTZMS1dtSi96emNiaVIw?=
 =?utf-8?B?bGVZbjZRWmNEQ29OSFNPaWp5aUhiU0pPUXBGNmNvRWI4Y2kvYnRrWnVPN1hm?=
 =?utf-8?B?cEd1T3hYbTUxVXkwMlNKNjd1KzlsaFJUQWNZK1U1cDB4VHk4ZEhYYTc1U08z?=
 =?utf-8?B?Q05QOWFBVldlaS9iaGpIRzJWUkdzSDkrRXZYZDB1dkhVMFNPQTBIVjlVWUlu?=
 =?utf-8?B?MHdTYmdjYXF0Yy9zSi83NFNjVWxuRE4zUHdWaUFMQ0RMbzJNVEdabmswbFFs?=
 =?utf-8?B?N25IVXBSckYvbnJ5ZmVFUGhKaUhMZDNFVHBUMnBBdUtreExDYndRbFpjT1Uy?=
 =?utf-8?B?Si9ENlJJaHdwS2k5d0lDd2dydXlMNDJSenVndUZwR2l6dTNtc3FHVGNGb1da?=
 =?utf-8?B?c1VNS25JNUk4dXdpTTN0Y29JVzdnZEJtelhSSXpHYzBLbTgrSDlYZkUxUFZD?=
 =?utf-8?B?aktaMDdmSE1xUWxGTmJFNHcyNFgxQjZnMUFDckVEWDJHSnkrcWRVNzFWVXIz?=
 =?utf-8?B?aXN4OURNdElmd01salZTV2J1aG1lQUl0eDF2S0dJUUUwNmxDNEUrajFFVGd3?=
 =?utf-8?B?WFdCTENhblVucnlLZzBKVEE2ZE5iVldYR1ZuUWdzTlNBZTRvWERoenowTjdm?=
 =?utf-8?B?VDJwSEMxUVFDbzc2aUFzK054ZlZwcU5qMEx1dCtaZlBlN244cmI1Tm5lS3NR?=
 =?utf-8?B?aFpVK1ZZTVNVSVIzd1hHWk5idHFNUjVOdEtwYmdqRWpLV0pNa1pDMFp0WXg4?=
 =?utf-8?B?TVJ3TTgyUHh6LzE2MGwrdFBZUlRDcUpITDdJN2lFOUlXQmhrMDJjbEdwWDQr?=
 =?utf-8?B?MWZsY0JhOEEvS0E2aHgyeWhPYURIa1pyVG10UWI0NVhFUzU4ei9qbzZRVENZ?=
 =?utf-8?B?ZDhHSXRpelhuR2NObnl3V3pvd3dLdFZaN1lOd0sxQ2UzUThDMW9WQjQzOVhF?=
 =?utf-8?B?a2prLzBIQ043cVp5VmVkS20vSzJ1OVl2UGg3RTBING4ySVEzZUkvek1qU2gy?=
 =?utf-8?B?bjV1MGd2STh6Z2VsWnY0VmF5NnZqU2loMTVIZ0M1VlZ5T09jbVZjSjVRMy8x?=
 =?utf-8?B?Y3VPam1aZUZoM2p5Rm1Ja29FKzk0TVRjSnZCOWRrSzRVRjhOSllBN204VkNl?=
 =?utf-8?B?Wkx1NHhtREN6N1VDZW5HbnhUSTJ5MjQ4Q2ZYZkd6eU94RU9YWXNwMGZDQnRq?=
 =?utf-8?B?OTYramUvdEVXV3laeURzN2JZSzdRZm5JeVlaejNjUnNxTnJLa2NiZnFVUlZL?=
 =?utf-8?B?NERPZit5L0IxblFITmNFNzZqWk40OEhtZjdQMXpHUE5FSzVDQUpaZ1NFQzRG?=
 =?utf-8?B?L25RM09oZWVSbVFEQ21GTTRrNU5IR21FTUFZUTRyNzh2OUVXQXlsTlBxanVn?=
 =?utf-8?B?RW8yenJjSzRuSTdBQWFsUTQ1V0QxS2hqeEsrKzJ3NzNwRUpUektmNmdDdzZI?=
 =?utf-8?B?TDIreTNkVFp0QTJvYjN2ZXM5N2l0VHJJZ1pxeHV2M0ttZ3FzeXBhZFpQU2VQ?=
 =?utf-8?B?RUVqenFkeEJPRmEwMHhsSmR0dmI3V3U1dnBoN1krSUFLbzFuYmRKSWJwNzR2?=
 =?utf-8?B?R210djhxdHphdmZTZFQ0b3VUck1rVUtSekt0alBVUjZGR3o4a2JBcWRsa0E5?=
 =?utf-8?B?OFA3cjg3YUM5N2lET2xiMVVjaWIzNHBxbXFBdlFWbDBRMXFidGVNSkZCWW01?=
 =?utf-8?Q?xre4p3Nv/M6VEC9njXWKMjgpN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4840dbb8-9048-44b7-ff7a-08dc06bb1742
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 09:06:19.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDuFmNxIbrTC0A7UOqXvenijLppIb5yeEFAfYO5v/6Ed1pEIwjTu2ExC93l8j9XRtH6RrH0bhDhFwh3cDt04mabuuj80JehplVv60TmHfpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDI2LCAyMDIzIDQ6NDQgUE0N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDcvOV0gaW9tbXUvdnQtZDogQWxsb3cgcWlfc3VibWl0
X3N5bmMoKSB0byByZXR1cm4NCj50aGUgUUkgZmF1bHRzDQo+DQo+T24gMjAyMy8xMi8yNiAxNDox
NSwgWWkgTGl1IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAyMDIzLzEyLzI2IDEyOjEzLCBUaWFuLCBL
ZXZpbiB3cm90ZToNCj4+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDI2LCAyMDIzIDEyOjAzIFBNDQo+Pj4+DQo+Pj4+
IE9uIDIwMjMvMTIvMjIgMTI6MjMsIFRpYW4sIEtldmluIHdyb3RlOg0KPj4+Pj4+IEZyb206IExp
dSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBEZWNl
bWJlciAyMSwgMjAyMyAxMTo0MCBQTQ0KPj4+Pj4+DQo+Pj4+Pj4gK8KgwqDCoCBmYXVsdCAmPSBE
TUFfRlNUU19JUUUgfCBETUFfRlNUU19JVEUgfCBETUFfRlNUU19JQ0U7DQo+Pj4+Pj4gK8KgwqDC
oCBpZiAoZmF1bHQpIHsNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGZzdHMpDQo+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmZzdHMgfD0gZmF1bHQ7DQo+Pj4+Pg0KPj4+Pj4gZG8g
d2UgZXhwZWN0IHRoZSBmYXVsdCB0byBiZSBhY2N1bXVsYXRlZD8gb3RoZXJ3aXNlIGl0J3MgY2xl
YXJlciB0bw0KPj4+Pj4ganVzdCBkbyBkaXJlY3QgYXNzaWdubWVudCBpbnN0ZWFkIG9mIGFza2lu
ZyBmb3IgdGhlIGNhbGxlciB0byBjbGVhcg0KPj4+Pj4gdGhlIHZhcmlhYmxlIGJlZm9yZSBpbnZv
Y2F0aW9uLg0KPj4+Pg0KPj4+PiBub3QgcXVpdGUgZ2V0LiBkbyB5b3UgbWVhbiB0aGUgZmF1bHQg
c2hvdWxkIG5vdCBiZSBjbGVhcmVkIGluIHRoZSBjYWxsZXINCj4+Pj4gc2lkZT8NCj4+Pj4NCj4+
Pg0KPj4+IEkgbWVhbnQ6DQo+Pj4NCj4+PiDCoMKgwqDCoGlmIChmc3RzKQ0KPj4+IMKgwqDCoMKg
wqDCoMKgICpmc3RzID0gZmF1bHQ7DQo+Pj4NCj4+PiB1bmxlc3MgdGhlcmUgaXMgYSByZWFzb24g
dG8gKk9SKiB0aGUgb3JpZ2luYWwgdmFsdWUuDQo+Pg0KPj4gSSBndWVzcyBubyBzdWNoIGEgcmVh
c29uLiA6KSBsZXQgbWUgbW9kaWZ5IGl0Lg0KPg0KPmhtbW0sIHJlcGxpZWQgdG9vIHNvb24uIFRo
ZSBxaV9jaGVja19mYXVsdCgpIHdvdWxkIGJlIGNhbGxlZCBtdWx0aXBsZQ0KPnRpbWVzIGluIG9u
ZSBpbnZhbGlkYXRpb24gY2lyY2xlIGFzIHFpX3N1Ym1pdF9zeW5jKCkgbmVlZHMgdG8gc2VlIGlm
IGFueQ0KPmZhdWx0IGhhcHBlbmVkIGJlZm9yZSB0aGUgaHcgd3JpdGVzIGJhY2sgUUlfRE9ORSB0
byB0aGUgd2FpdCBkZXNjcmlwdG9yLg0KPlRoZXJlIGNhbiBiZSBJQ0Ugd2hpY2ggbWF5IGV2ZW50
dWFsbHkgcmVzdWx0IGluIElURS4gU28gY2FsbGVyIG9mDQo+cWlfY2hlY2tfZmF1bHQoKQ0KPndv
dWxkIGNvbnRpbnVlIHRvIHdhaXQgZm9yIFFJX0RPTkUuIFNvIHFpX2NoZWNrX2ZhdWx0KCkgcmV0
dXJucyAwIHRvIGxldA0KPnFpX3N1Ym1pdF9zeW5jKCkgZ28gb24gdGhvdWdoIElDRSBkZXRlY3Rl
ZC4gSWYgd2UgdXNlICcqZnN0cyA9IGZhdWx0OycsDQo+dGhlbiBJQ0Ugd291bGQgYmUgbWlzc2Vk
IHNpbmNlIHRoZSBpbnB1dCBmc3RzIHBvaW50ZXIgaXMgdGhlIHNhbWUgaW4NCj5vbmUgcWlfc3Vi
bWl0X3N5bmMoKSBjYWxsLg0KDQpJcyBpdCBuZWNlc3NhcnkgdG8gcmV0dXJuIGZhdWx0IHRvIHVz
ZXIgaWYgcWlfY2hlY2tfZmF1bHQoKSByZXR1cm4gLUVBR0FJTiBhbmQNCmEgcmVzdGFydCBydW4g
c3VjY2VlZHM/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

