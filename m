Return-Path: <linux-kselftest+bounces-2432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F681E56E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 07:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A361F2273C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0B84BAB9;
	Tue, 26 Dec 2023 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K40+g9/+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698484BAA3;
	Tue, 26 Dec 2023 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703571096; x=1735107096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gnr6XdVnenHD6rNSMXnyIrj7XnuG2qIP2o7DwrYUWds=;
  b=K40+g9/+YkqSwaM+0haMAC1/gwLZtpHccUsrNxSKx6j8Zhqbnsf7dsQv
   E/436jUK2bwB9cc7Sv1Lc03Bi1U8N9Yd+XqJ4dvlPtg3izLZg6FN6POXz
   iYZRmb3tvHdCmUYROAcV/E1jDiE9WtYisGiUQZ3FW2ktA56LHoWk8gnFI
   ri6kKkBmzLytQEC4fnHvHLrPIeBX9R/Kf77SGb5ZXNSflwqw33abPofCA
   LoPC/7p+ERk6F5+VxCc35kOStq/O78RvfcpRshujen38dvXWhKDKLE1Zv
   r3mPL8uVbkoshCuax7J7GN1aExPFxzRfvBk/8UARsFSNoA2O6uMZPvMF6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482502780"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482502780"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 22:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777869826"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="777869826"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 22:11:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:11:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 22:11:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 22:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQAmgLWwpb42GY3Twm0iFGCSzfaIr9/v2wr8JFGaBr46UAXfiRlZolgj4mHbm5wYbQFnp5A+uTB15yHjfpSRfbzcvdktFX4AOpOhnok4q8bF1DOeqAesy8XDMBY4K2FByQoxrrlvJs0H7prJsyM3zuSHQQuOXbBWJlHtlv0uBOzD9i/NHSVVZsxDCWakZkANjUDX+r7T3T/brqBGXobQrClzcNRBoKo9D1cJAA1GxEed2upLhSRjaS+gEqcGc2guMfAL7InUkuUWHIVYLb8Jlqz9GQTxEWDw729V29NFO5RwrnLpzpXvDu7q5BcfwDYoQ9tF4MmKvT6vWOeCL26JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnr6XdVnenHD6rNSMXnyIrj7XnuG2qIP2o7DwrYUWds=;
 b=TjSQ9uqcm4kiOdSele2oUx3vXBEDUpGC8v9Oaoz1R4FL1cg3817VV2nZop8qgNRPVkzG1EYBouBvsS50vK+AT1rNVUc7iHi8SnCNEigKcyUtoBwOLccm+/QKPObAmGqTL6tJ9B0CJU1xOjsvHY8X4uPqDbotDcOOqsRAjFOdU4jg/YjLrykBltLQ9LWkg9AmRhhtOQTcWz9otRzeenciTv/H94pz/bllxbnjdlj5SvJivVJjnxkfq0XUzxVTclsflDNgrfmaxMQY3z6WLzHmwFneW5iV4sQE+eaRE+WglrYYwUgBevJ/HNEqkypdYpxV1exTiz8x3Ev0zUiFMnQFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 06:11:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:11:31 +0000
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4zqzfCm0YG0WB/drS+mURdLC03SewgAYo/YCAABYdcA==
Date: Tue, 26 Dec 2023 06:11:31 +0000
Message-ID: <BN9PR11MB5276921496E7EBEC3BAC6EC88C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <BN9PR11MB5276A45F5355A6DAA8CBE5738C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbd97b49-37b5-4445-a8b5-717b8ce99f59@intel.com>
In-Reply-To: <cbd97b49-37b5-4445-a8b5-717b8ce99f59@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CYYPR11MB8429:EE_
x-ms-office365-filtering-correlation-id: d2808d7c-916e-4b20-681b-08dc05d9810a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zEOb7CZAtFAX0wWRl1q8dV7LonQcIDOo3v8p0I1MO8r4dTuHFpIeW+PJfMcdhhgq7YgosrObmvE6hwXNyYpvGjpBNzZn5UGGmXNBmauOirR6ijiW2aTgMLNZdjhgDX91yzoVYJEsrqkyx/uwL4X6i8U7HSLjZ2uAvlYjaThv38+cz7mdtd0i99FrnEoDyktZ3Zn1IrtJf0Zr9LtT1RZs4JJzGuGD9LdzZC0++iBXKqRKu1xcdScZJI1H6COmQEqVBBtcSfW0FurdTQEW4B+sukTf4cBFzNq3vrDBbFT3dZtPnEv6wf9dk/RoDqeLW5mjmADlB7Fef/G0U0VRMLHanY1RNEO97qiuOMFpOYx3UwKXgEJ7Sge2+V7P2B7wjViG8Xl8XxXA74AYUSVi99NObYXsAvNzPfB2qtnX7+FXVkWQ0dQ953g/1kZRzlxYO9Jw0MucJM34z413XZfDnGnZALpI1qKKCTUJ/QDGnsQ3DK/Jz4y/wwjIOSQkQdo6ZhrClEI0UOVWRWVj6GdgLCXi4Qusczq5nz7QxGAQs6FRyrnyc2oISoGHm/XrsevrgDwoqOe684hHntskNtpHbdBJ8yq5W/uRloiMl1p43gfA2sWtjcEjmrJv2cJZROHiG/NV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2906002)(4744005)(7416002)(5660300002)(76116006)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(478600001)(9686003)(6506007)(7696005)(122000001)(52536014)(8936002)(8676002)(4326008)(33656002)(55016003)(38070700009)(41300700001)(71200400001)(83380400001)(82960400001)(38100700002)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkVpejYrLys0Sy9JR3ZOd3p0ZlRXdjZWZmMyTE5uVlF4NDNPSUlEeGNoNGIx?=
 =?utf-8?B?Q1YvVXVxYk0wWmNZRzZzYm50QUdsR01Ea0h4ci9qTEZYNE5SbTgzUmg4Qmlq?=
 =?utf-8?B?TitJTmFWL2hKNzZQRG02MzFKbWduLy94MkM1V1kvbHFGakUwR0ZxOUxKQlpE?=
 =?utf-8?B?UmoxUm8vQVBBK2pqdDdHK2VEckQxbHpVWDFwejlIUDJxU2xjYU5FdVBzbkgw?=
 =?utf-8?B?WGMycFFRYnA2ZytBWWJKamdxT2tNUUEwdWY3N2hBNmhPKzc3U09tK2JHK1NG?=
 =?utf-8?B?RU5HLzFRdnVuRUxjY0Urb3UzdzVXZnc0UDhnRHNkR214aHNOd0NtblhVUTZZ?=
 =?utf-8?B?UmtPS1FNcXQ1UHRZYllEamZQY24rN0crdlRMby80c1ZNUG9jaVpNVS85VENJ?=
 =?utf-8?B?TXlZaGVzVS9kOXZuMFY1cTg0bHhWTTFJQkZOYmRTa2VTOFRJZ1JSeWoyZHRH?=
 =?utf-8?B?N1ZnRVpDdllXYmdYZEE2eHlwa0dacC93U3hLa25LeWdZcElIWVZtWUwxSWxL?=
 =?utf-8?B?MHlISERCNFdhekFvRXl4MGloS2VMK3NyR29hOEhCSVBxY0FZdnpoVkhYQVVJ?=
 =?utf-8?B?NVFYVkpWYTJEWmVpNkZoUTBBeVNadllDRnFIOEJPdnlqRnBBZi9LYnc4d3FK?=
 =?utf-8?B?eVNMMzEvOHBGOEdERTZ3WU5WQk5CNS83eWRtOWswQzRORDlpeTRwMUpPVnJL?=
 =?utf-8?B?VC9rL1YyKzdSc2JIVExyZUJNRDBLdGFvOHF4cklhSk9KUmRTVDhiZ2pJY2My?=
 =?utf-8?B?YXRpdjhlL0RrbWRQczIvZ1d0aUtma3AwU29STno0cHBJRGljc0dPWFhmamhl?=
 =?utf-8?B?QmZNYVZqK1RrQkRDVXAyTC9zTDZ2V2pEYnpXY282d3hWTllhczNZQkg2dTIy?=
 =?utf-8?B?NzJRMExzaVMxc0FBcHFQc0ErVFZYZGZiVHUzSE4rU0tNQk8wTU9QQXlWN1Bi?=
 =?utf-8?B?V2pOelhkaktKNEhLOUdDWndZZ3lGZTdmSTRhZENtdFRROWJkeDdUejMrTkVw?=
 =?utf-8?B?T3R2K2JvRHlIc1cyMzhoSC9McjVOY0ZITm1ZbEY5Rjg4MFpxbUI3bFJ6bXVF?=
 =?utf-8?B?ZWgrU0tHOFNBdjNnZDhGNVNSZk5wY3E4UXBBRDFkdXNHUDFyKzJpOU5XTThz?=
 =?utf-8?B?YjkvQ29QNXFuRWlaRUUxbldiWG1qVTdweDZ0WTJoU285ZFZXVXJ4NmdMTy9F?=
 =?utf-8?B?RUt1RFFuV2FSZm5QaHFVd3VPUmo5NTNaMmxqejJxUktNN3ZCbWx0emRqRGll?=
 =?utf-8?B?VW9pUUFWQnFzaXJxbkNucHRoYW5TaWV5Y0UxcDc4TUlHY3BlYWZidGVlbC8w?=
 =?utf-8?B?QzFUU1hhVEhMcXBsT1FqVUFZMHBWeTF0cFJwNTRKeVpQdDNxbE42bW5kVzJE?=
 =?utf-8?B?MEZyako1OGJFeWJBcjhGQmFBeFZqblJ5K0UySVpMR1JZV1BDODFSZlg2d0hV?=
 =?utf-8?B?UU5xUHIwMTFXZU1yK3l5amJhQkorZGxnQ1Zhd0I4VUN3WGUvTzBva3NnTWVp?=
 =?utf-8?B?ZkVWWlN6UHlxZG14MmtVd0RGdWdHOHJjL3hIWm5nZE5pdi9vcCtFMndZOVZx?=
 =?utf-8?B?WG5yWXNQWm5Yb0VzM1RxMWw3QktlaldyNEJIMk8zU0lnV0oxZ2ZTVmRQanNK?=
 =?utf-8?B?c29aOGhOckpZSWdsMDJoSzlNbk1VMWQ4RHh3NmtkRGIrMndHZWJvVUVLQk9J?=
 =?utf-8?B?dGVuN0RwNk9IeU1TNXpENkFWa1ZMZ1pzVWdVeTlGR3VSd0F0ZlN1aU0zTzRV?=
 =?utf-8?B?T3NoS1FrVzFCM0Y5QkZtT2lKRVFuSW80b2NWTkdXbW16ZEQyd0lMSXRFSFJW?=
 =?utf-8?B?SXJ2WEFyVEtnbVpUZU5YN0R1Z0t0b1hOSHRFSGF3QXVRU2U5NDlONzlPejYr?=
 =?utf-8?B?U2ZMVm5BWmlaa2JhNEVWam1NdXUxVEVaYlhlWEFiNVB4NGtiQWtpdi9OT2px?=
 =?utf-8?B?NFYxakZMVjdhYmlrOUhodFdUTThEekRGTHdVKzFsMnFINENBbTlSODhmSkFs?=
 =?utf-8?B?MXBzVWRaaUsrbnNLWDFYbzdtU0hzYjRaWkJUUFBWYU52NUZpK0UyUW5odVpT?=
 =?utf-8?B?d2pJekh0aW9XYy9tYlNsczliSjBoWnk0NTgxTndpRVlraWdKU1ZqZnpWVkM5?=
 =?utf-8?Q?JMlQjarUN+8q79D2qd5/+3ITh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2808d7c-916e-4b20-681b-08dc05d9810a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 06:11:31.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Gd5lv6KJz8L3u/tHA3momtc/afd3rLvVfCkIgAR43wzogeXtcM1WyMub4fIILTBRgAUOlsPtMyGNi4N0Xpd6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RGVjZW1iZXIgMjYsIDIwMjMgMTI6NTIgUE0NCj4gPj4gKw0KPiA+PiArCQlpZiAoIUlTX0FMSUdO
RUQoaW52X2VudHJ5LmFkZHIsIFZURF9QQUdFX1NJWkUpIHx8DQo+ID4+ICsJCSAgICAoKGludl9l
bnRyeS5ucGFnZXMgPT0gVTY0X01BWCkgJiYgaW52X2VudHJ5LmFkZHIpKSB7DQo+ID4+ICsJCQly
ZXQgPSAtRUlOVkFMOw0KPiA+PiArCQkJYnJlYWs7DQo+ID4+ICsJCX0NCj4gPj4gKw0KPiA+DQo+
ID4gd2h5IGlzIFtub24temVyby1hZGRyLCBVNjRfTUFYXSBhbiBlcnJvcj8gSXMgaXQgZXhwbGlj
aXRseSBzdGF0ZWQgdG8NCj4gPiBiZSBub3Qgc3VwcG9ydGVkIGJ5IHVuZGVybHlpbmcgaGVscGVy
cz8NCj4gDQo+IG5vIHN1Y2ggbGltaXRhdGlvbiBieSB1bmRlcmx5aW5nIGhlbHBlcnMuIEJ1dCBp
biBzdWNoIGNhc2UsIHRoZQ0KPiBhZGRyK25wYWdlcypQQUdFX1NJWkUgd291bGQgZXhjZWVkIFU2
NF9NQVgsIHRoaXMgc2VlbXMgYSBiaXQNCj4gc3RyYW5nZS4gQnV0IEknbSBmaW5lIHRvIHJlbGF4
IHRoZSBjaGVjayBzaW5jZSB0aGUgdW5kZXJseWluZyBoZWxwZXINCj4gb25seSBjaGVja3MgbnBh
Z2VzIHdoZW4gZGV0ZXJtaW5pbmcgcGFpZC1zZWxlY3RpdmUgb3Igbm90Lg0KPiANCg0KSSBvdmVy
bG9va2VkIG5wYWdlcyBhcyBlbmQuIGxldCdzIGtlZXAgdGhlIGNoZWNrLg0K

