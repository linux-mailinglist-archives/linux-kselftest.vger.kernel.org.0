Return-Path: <linux-kselftest+bounces-2429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6872181E4D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 05:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063B0B21B0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDCD1A29C;
	Tue, 26 Dec 2023 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To477pnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25B328C2;
	Tue, 26 Dec 2023 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703564041; x=1735100041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ExdtIMbPGHyjMUXcimXHe0xUTSweUzqBGGrBj1F7yhE=;
  b=To477pnXj9O4fzw86slNdST4SmvwWATrUURST/qXnzmZBMhA5BTphY8k
   aeBM+hNb3nt9DYQCEobRqwYmqO0+8QnLn/ttTWSqeUen6NDs3pzDXjCEY
   ZPd/l8Csc+CgRLbA8zNPei+ynLVgj83IMRlZkPFXW/+jzTKX+e/mQZ5Bc
   uLr+SlMrW8kw/KWCnheVgVywmKCtwy9qPTtZQz5C3sUTggKrznW2JVfZM
   1eEehKxqNudSa3q8pKLXdSGV/CYu/RcMcYGzjIGjun/5aGXeW3TmpP+tA
   ApGM8OXAzSww15GupdlYvo+YDCyCM9SyJ8Ohq4K5gerHedWofTmtgv4zx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="381294784"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="381294784"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="868514372"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="868514372"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 20:13:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:13:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:13:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 20:13:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 20:13:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeT8r/hxEZ/xLaDWiuMv5c5shnGjDXsgTtPQiNmlmqEWNxJA+nBncKqbVOym4tiQFoZsHePBdVUd/eha5GqEGmPhwTRCHFzCeGqynhUOxe3n4dqI/RgAVdbH88+BNqV22hc6Lr3fzIaCELKlrxMQqZC5YsQH+TAXfBeRP31rYX0EEQK24pRYL6rp7LiY/nDjQUYpgPk46dxi6eXu8ld78OP4Srul4bB4ncLBkAfaPp9mkGpIUBlnRhtX631cvPx+oSXggj6m9g4svt1RcbjpztdEmQaj3w/FSp3x/nkaubybRRlmNBHYxu4kx5UdFvJFphv09m2j/uXXkpQWxewOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExdtIMbPGHyjMUXcimXHe0xUTSweUzqBGGrBj1F7yhE=;
 b=nMj0aBRhd5LleCSZfsmsXyPy42O7AS9KOL7FX7fWmfmqs4bDaOkTt0kuFg4l8Ct/JUJc0cG9SQa0pcPvgJ9KnWTVtdlqdC5hlbS0PxB9LlvgRTobzAVSVcPbEJ+lU4qPOhs0771c3yWokg39P9+zJdjUyJQv+1Q0c7ku+zWe7BNU8dH0BJZeYQm6H8wLxKS2KV1FSyiuH9WZvLKLrUlqrizJFqDpyHa6JSEo/zRKPUEOGMoR99Zikw8hcMB+nG3r3NtLMDUwhGIkbltYTKBC6Dier2Yt46e9aA/ruUixOEm/UapaQVdCgDyJiOv5bqiTCvPuAi8561IQYOZ0Z/DitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.26; Tue, 26 Dec 2023 04:13:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 04:13:55 +0000
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
Subject: RE: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Index: AQHaNCP7GmW4equSLUGDinfwDm7MnLC0tG4AgAZEKYCAAAJa8A==
Date: Tue, 26 Dec 2023 04:13:54 +0000
Message-ID: <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
In-Reply-To: <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6019:EE_
x-ms-office365-filtering-correlation-id: 3fd5bb06-8d17-4a98-d62b-08dc05c91337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1RIyjyzIUm1qo/yr8Uun38uU7g8Nc8Je5CsNy5e1hJbxarFfKOzisCrHEi8pf9x8TjW8YPyRSsPPR88KT8SZ5kUtpv5ubG/IcvYA8A+Pi+62XKxYL5Vm5iXxtenb2txdBCt500PI13RZMgoZJE+wKO6CVYZ6VVvrSk89BW6aZtkyFqzDwK9uhho/slHYDVCXIPRgQmKcHOOh+YQaKBNCTviNmY31GfJx1M7709+yRsbawa6Tc1DcR2FWud04SbD59UFo4/2QYivMb77gwTPgLHqTCjkx/xxWHKPhf446S01q43e7xANypD9Bmg7bSAaXk12Qmac36/F5roST2DxTMu1vqlg13gCUGtKdOnuzmDjUWiETw/y7jxAYmpwDA2e9+sUug5JSS2S22DwKECJesO13F6p7LmwYYAXABawLY00mORwPWn5yOgjSifDNRJsNqdKELazdijNNIfRsr2PramggIA5NMO4ETq8sXm1R95fhGELCvIM2gTPB/DkxpnEBGVhAlCtytGO9/pFWmZ4jy4I9eGO4VgHYbUjnc9aPoeptbe2jm+dElwuAheyZOyfp/R46OKGW6h/YxyvEg+feuqj7Du8KN7kWX8qmEr2suV+TbSQuHU6MRg86CjwuD07
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(76116006)(52536014)(53546011)(86362001)(9686003)(6506007)(478600001)(71200400001)(26005)(7696005)(64756008)(66476007)(66446008)(66946007)(66556008)(8936002)(8676002)(316002)(54906003)(110136005)(4326008)(4744005)(2906002)(7416002)(5660300002)(122000001)(41300700001)(82960400001)(38100700002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME1RNmFCdGtNeGZxUW1FMDlaVGtEekY1c3NQVmhyWWhKMnhYU0N2VXI0eUFy?=
 =?utf-8?B?ckJyNi84QVRBOTFaaU1jSm9XWUsrNy8zQ2VmUGdzSkR3VmpyV1F1UzhHQStF?=
 =?utf-8?B?MXpnTjhyblYySjcyeHFrYkdwdE4yMzBFOURFamNWQ0FhR3dzUTQrMjBYaHI0?=
 =?utf-8?B?VXNvVDlXNGRWR1poSnJ4RlVKZHlhaVpKN0p5Ymo5RVBSL3A0MGIwUk50OFRT?=
 =?utf-8?B?dm5qOWtVc21yYU1CdEdRRFRnenYwb01UK2ttMnAzYS9EcXhhQXRZaDJETzJE?=
 =?utf-8?B?WG5Nbk1WZXlCUjB6TytoM1h6QXlaK1AyZFgxT1Y4RGUvb2RObDhid292dHZU?=
 =?utf-8?B?Zjl3N0gzYXljR2lUVnk3YXd4M0czUkZ1M3VtWUlhRGlYQVNhYTRXektkTWc3?=
 =?utf-8?B?TVJ3MytLYnY5N1BuSHhZTkUvNVh1Rkx0RTNtb1ZWbmN3NzFodWw5dGZseUFu?=
 =?utf-8?B?T0FwK1lhU3BYWEpWMnYzV01CMGR2dFpITU9NMWxTZVRwWkpvd3pWMlVxKzM2?=
 =?utf-8?B?ZjdGbUYxQmtkY1ltckRDK2VvVXNYVW5FVS9icUVhQTd2WnFQVjFWcWhYZGJC?=
 =?utf-8?B?UjkzMjgzOG5xM1ZieTZPci9CS283K1BMVGJvUzBFdVAxZHd5Y3BNSzF6VS9t?=
 =?utf-8?B?VWJhK0VWamJnakx3QUtjMVl3clNIajl3VjhFSHdqWHluaDhyK2JTdkxkSjBv?=
 =?utf-8?B?RXNPNXR6bE04YWlFb1FwRWFGU20zaE9HcE93N0owblpEVnNzck5mZ3hmK3h2?=
 =?utf-8?B?a3lPOFd3V2NJKzIydXJKRmhyVm1GUnVYeXZ2ZklHTFk0UTliTkpDbENNSVlm?=
 =?utf-8?B?TzJQNThLck11cGMxUVY3RzdYTWRtdEtGS1EyU2VVTWx6MlpTakFZVmU3ZzU3?=
 =?utf-8?B?Nk5nWHNuN2xlcHo5ZUxVNkpjRDlTb0VUMHhwOXVCeXQ2R1JnWk9zSUJFek94?=
 =?utf-8?B?aU44SnBFNDhZOFVocHNIUkRDTDdycFBiSUYrMWViT2JlTDR2S3lVQXE1QTB6?=
 =?utf-8?B?aDNrSXlMY01pLzJxMXpHWGNLSlNLV2I1cC9zTEd3bElIRlMyS3VpU0RYd2li?=
 =?utf-8?B?YkMzVnIrSFNPRndXcEhra1lyRnpteGY1RVVWbWtEK0xZcEcrZ1FEaDc2dGJG?=
 =?utf-8?B?Sm9MV3I2WjNic295MTRHSDBxVitDOEhEZXNJenF5TWNDUGdINDR2SitiRjMy?=
 =?utf-8?B?Y0htYjROWjJUYmFNbTcveE94TUdaVXFYRXMyN0grVU5tZDd4ZnZ4Q2Zub0Ix?=
 =?utf-8?B?VDQzZXRiV0FlK1BIR1MvOW0wR1ExeXBXTGJ4OTlWMjAzSzhuZzlsUi9jdHF2?=
 =?utf-8?B?eE5iUXJRK0NaMDJxNWpPZFZ1WTBpdis1Zms2dG1sM3EzVkpTN1d6MkVwSjZK?=
 =?utf-8?B?L1plM1p2eEcvN0ZiNTFOTmpMcWNTR2t2Q3dKWEF2RGhQa0g4NGE1Lys0clpj?=
 =?utf-8?B?dlpaOVBqcWlaeTdPS0VWL0hHZ3FZTS91SncrczhxcER2RTl2Um5Td0QzalRq?=
 =?utf-8?B?NkM5TDdsUEg4dUQzYU9TbTZoKzFpOXJxTlgrUGk4UnNyMW9PSW1Md2l1TjFZ?=
 =?utf-8?B?QXc4akdNVDRUZUpmZ3pjU1h3YjZGSVJ2QmxjeWNOU09zcG55RjdGc0FPMEZ0?=
 =?utf-8?B?bVlmeVNwUXN3V2VBSGlGVVZONVJFSUJqNEVHSUk5bGxLRytCcmxqWjVHMmZ4?=
 =?utf-8?B?WWRNaFJHMlFZcllrQUxHK04zMER5WHFBRGdXc1RDbllYYmhLV3B0QkwzeTlF?=
 =?utf-8?B?SytYd05MSSsvUW5DdzlzUzJxeXJZNW9ad1lOR1V1MDR6ekZxYjlPZWM5dHBH?=
 =?utf-8?B?Y0VSbzZtWDZwbEVWVWQ4RU1IL21NbzZUQzZZVjREbWF0VTMwaGs4MlV2d1Bl?=
 =?utf-8?B?NGdTWTVBSDhkMk8zNlBHcExmMUVWSkhqWUhsQnF4aG8vcTJCNnd6dGQyQTk0?=
 =?utf-8?B?NkVWK0JiWHkrSnFxdFpDdmhrSHg0TnZaaVFQRUx6eUNENzhqYS9uR2lNdjVX?=
 =?utf-8?B?NzNlRVdRdGRvNjZuRHFJckZEVGh5ZGl3OFIxMWlFMWhUUmRMUWhiaVFDK1BT?=
 =?utf-8?B?ZEw5ejlBOHJHTUR3MkwwaDRpcW1veXpZaldXQ3V6UXpMdmNvQ3VPVlM2eHZW?=
 =?utf-8?Q?3TXRD5f/knytpjXTpZbZzVBVZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd5bb06-8d17-4a98-d62b-08dc05c91337
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 04:13:54.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jiGjaTtHlRvuu+sZTcIDYIoZdyvEOR7dfyrDKeBrBhCYuVwXG32iSqk3mJChUQXdVu/+IV76EqHf0+moHICFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RGVjZW1iZXIgMjYsIDIwMjMgMTI6MDMgUE0NCj4gDQo+IE9uIDIwMjMvMTIvMjIgMTI6MjMsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gPj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIxLCAyMDIzIDExOjQwIFBNDQo+ID4+
DQo+ID4+ICsJZmF1bHQgJj0gRE1BX0ZTVFNfSVFFIHwgRE1BX0ZTVFNfSVRFIHwgRE1BX0ZTVFNf
SUNFOw0KPiA+PiArCWlmIChmYXVsdCkgew0KPiA+PiArCQlpZiAoZnN0cykNCj4gPj4gKwkJCSpm
c3RzIHw9IGZhdWx0Ow0KPiA+DQo+ID4gZG8gd2UgZXhwZWN0IHRoZSBmYXVsdCB0byBiZSBhY2N1
bXVsYXRlZD8gb3RoZXJ3aXNlIGl0J3MgY2xlYXJlciB0bw0KPiA+IGp1c3QgZG8gZGlyZWN0IGFz
c2lnbm1lbnQgaW5zdGVhZCBvZiBhc2tpbmcgZm9yIHRoZSBjYWxsZXIgdG8gY2xlYXINCj4gPiB0
aGUgdmFyaWFibGUgYmVmb3JlIGludm9jYXRpb24uDQo+IA0KPiBub3QgcXVpdGUgZ2V0LiBkbyB5
b3UgbWVhbiB0aGUgZmF1bHQgc2hvdWxkIG5vdCBiZSBjbGVhcmVkIGluIHRoZSBjYWxsZXINCj4g
c2lkZT8NCj4gDQoNCkkgbWVhbnQ6DQoNCglpZiAoZnN0cykNCgkJKmZzdHMgPSBmYXVsdDsNCg0K
dW5sZXNzIHRoZXJlIGlzIGEgcmVhc29uIHRvICpPUiogdGhlIG9yaWdpbmFsIHZhbHVlLg0K

