Return-Path: <linux-kselftest+bounces-495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D317F6AC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 04:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C411AB20E24
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 03:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47585635;
	Fri, 24 Nov 2023 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlNtKC7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B2CB;
	Thu, 23 Nov 2023 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700794851; x=1732330851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=odA2AS4GZrnNZ/boXLINk7ax9m3ecF0sSynlO0A0r1I=;
  b=ZlNtKC7SIn2/Z7oIyQHzYdifCfmXEyrjwSV9asmHxNmhJsEhyo3bp59C
   SlQimUXzC+IxFqSC22hfK/pWOt6tAhv/nGgpbriblcqlvr1M81q7RGQJf
   Piy1eYO9Uv1bWgMRRm/v+2LmIhRKEJ30xCoBggv2DDEaXHwVg8ihgfI4m
   S8hfb+IrBf0rgE7USVdwZYeDKxQOp58grJVe6lkVWlHSAeo+PYfzmqRy6
   0cgR39a6pidDwg9E+SVd+2fKXpUIqZV4AcYR0CJjshukXXyM8am8Wel4x
   YxndUtMfWyWUfo+PzZ9xkz0FRd2eN5SVc0haPNM6OPvAphTeZqT6Su6gR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456697141"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456697141"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 19:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="8834140"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 19:00:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 19:00:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 19:00:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 19:00:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 19:00:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSE1Wnlv6HfnVQ06nLX/Tq0nSWci4kSNNvWHosF7VIj+N4yQiZT/QQslQqlCQga7XKEaYkqURwL+eZtxdshOm/yutp2Ie1Pq6WibqrmOEuNTr8+aU8rdZTxRexc3kzby6rxFJGIcNmqqFoFAX4HTMIctACnHAF+bJlIz1sg9NBpNcu3uoRGR7TYaL88/Wfc+zS41z9J/QZV1PhlpbCiG1BqcVZg04QceWmaOUVrYa0Q8QtiwZQfw743SK+y8oEW9TnGLTwjSL9L1kajZukbtCQ5o4Bhp/QZ+xvGmtlWdaWzO7yJXg41Wlt8dnS+TKPlxleZUQBxELKJ4G9RNRzQyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odA2AS4GZrnNZ/boXLINk7ax9m3ecF0sSynlO0A0r1I=;
 b=TjnA7IwN8JWW8R3XavMO36k6nhZDMJ7kN7KE4UqS4cJ4fBBP82DZtShBdsyAjbTxLbwPMy1dZJnzVUzJ6Evl/JlDXXdb5YLa2XItOQKd2cWrPjljty2SY7LDzVkso2ILod9aE9b9rEkl7esxIXdOQQ+CG6zduAkVJ+Xtkcg/A0uf2KVTnrh3p7gSZQy0M88VvUHfFGqz1SDIlgNyO4a4a6b2N5JITtscxxfEnAGI0yTNKz+Ud8K7qyOFJTOkuUxyn6FHNbxrTtlAXD0uiqc+PlGCuU+armoBsSGTe9AsP7+y1pzMeg0/oWc1RaSpAntUnCpGV4JJLkwxsrvDY9iBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 03:00:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 03:00:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCC4vaggAD2R4CAAD710IAAnmMAgAEUIFCAAJFiAIACb73g
Date: Fri, 24 Nov 2023 03:00:45 +0000
Message-ID: <BN9PR11MB52764F692E78C1B396D175DD8CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
 <BN9PR11MB5276BC5DD9824923C8A3ACC18CBAA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231122132542.GM6083@nvidia.com>
In-Reply-To: <20231122132542.GM6083@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5008:EE_
x-ms-office365-filtering-correlation-id: 31282b9d-065e-4318-e0a2-08dbec998df6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YvRtwwwjBHLyDrFAksNbY+XINfohmUPIf5CVF/gKFxwiORLWXUv2LuE4ml1RfMny4q5VKHG3FdFFiqUXG+HjrndyaQ7a5Ar8JEiidDLfhwNXSF2UvhNBLkufeP7ZXoBN1LwzNcmz7hz8p8/+UP/IBnyBWrSF6H0frI1hZFi/yX6ghbPbtlBQWl9R5IgaEQkE6406f9VOMarg6WHiBpfnl73pJKbkcaZpt0e4fUCgiK7ne/jzfSZ5ChRpGbimw57gv90Yl7uXLYFvBf9q3Z6x3ne4R5JAOztJMxT3D2PJIZgLJtZ9VhqysP3gtljsooXXPkfTFk/kJgZGZ4z3BSubc+JdMNryul9I75qal2LEcunEb88Z26X1kv45RIG/VFWvqHwBFW00amAQw+q3YeuRUECzsk3bQywfROWDANRIm/2al29E4Gn+rawQmRr6ucNkbxBDlTnxMmWzbNCpwy5zSui0yeCmq1TP6F8eaN4xBYLWFwMWVQsiHdmCL3HuX9BiCPU5t2Obt/ol3pW0w+x6C/toPU2mCIxWVYPe4LtbWXSplfpElVtCLun3K05hsRaJ9javeIJwwXNSmF+2ZcC/xEOffMK+TrYMPU2xpwj1UPo6mzS8jFWRT7xuUZCzDTSD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(52536014)(7416002)(5660300002)(122000001)(38100700002)(55016003)(26005)(83380400001)(82960400001)(316002)(54906003)(6506007)(7696005)(9686003)(76116006)(6916009)(4326008)(66476007)(66556008)(66446008)(64756008)(66946007)(8936002)(8676002)(41300700001)(38070700009)(33656002)(71200400001)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFc2TVJESnZqMjdyNmp1T2NhdTZoUjlHaU1YZlBsOXNhbXU5K0JNeEtJV2xx?=
 =?utf-8?B?bEcxVUZiVzJjeVdrdFhleHJYS2NrNUpoK1laYkVyRmVxcHl6aEU0RzlKU0R4?=
 =?utf-8?B?SEoxelNSOHlhbFhlbUV4WFFkMldnUkFTaUxlL3c1bjh3STZYSHllZXZVTU03?=
 =?utf-8?B?dGZFNTNLUTVnU3ZJYm42YnZndVBTVWkrZ2lHbUhQOFF6TkljMEVaTmJyWE1P?=
 =?utf-8?B?M1JydlhMdU5qejNSQjJBdXNEQTA1bS9kUUFxS2d3a2oyRk13VDRCa2twZFJl?=
 =?utf-8?B?V2xKQjBSckIrMnVVVjBSb0xtc3dzS0ZxNE1iOUkrUHRSNzlqR2tYQ2haWjhI?=
 =?utf-8?B?SWJzRU9KRS94aTJSaGRPTzA4ZUU4T3A0QlIvTkREUWM5NnFNS0w3Mm5XcjBp?=
 =?utf-8?B?WDF1RmR6Qk4xMGFNK3RUanZzcERHZjlVeVB0VndnYkRIdEpVdUtQZEZ2VDJr?=
 =?utf-8?B?SCtIQnV2OEZXV0pQa2VoWDBIQVpPZyt2YXA2MXpMSGRCall6OEhUbkdCbDQv?=
 =?utf-8?B?c3pyOUhCTjFiS1Z3U2NtUTlzMmYraVVYZnhUSmxNMnVtdmZTdXdyQ0hRalBI?=
 =?utf-8?B?cnovVkhURnBFMmJvZ2ZrWHJKN2xFRUNxZW9icSt4WFB2bXYrTzBaaVV0aUFq?=
 =?utf-8?B?cFBOR3NMUEtHb1dXZUp6WkJkVFJKbVpRNkNwZnZwbFVOR2xKZHdwZjFkSmx2?=
 =?utf-8?B?Q2NnZzJJVHFnNUpVRW9JSmNFcm0zdkNzMUx5cE1aaE1xNDdhQXBndXdIUlBN?=
 =?utf-8?B?RXJ1WWdWQm1xbzBKODVUNjRHVmRKVXJMUW1ZRHVCV201TE1RV3ptSkFTQjFX?=
 =?utf-8?B?VW95ODJscHl4YU1WOE5NM25va2FlZkxSQWdCTWdhY2NHUzVjVWFVNzFZQnpO?=
 =?utf-8?B?WjEwREVjQ2VJc1RIbzFuU2ZzZ2paVzloYXdKTUdFVWg0MUJ1a2E3K2dLYXZQ?=
 =?utf-8?B?WFVSbHVwaUk3ak9hNVZ0SjB3dXRLK1JTWFMvaVNod0tYNG9zUWZ3bVBOYWxJ?=
 =?utf-8?B?ellzdythbkViTkc5Y2Yxckc3RFJkTWM5dVZMTmVSR3JodWtQWkNIQTZSOUcw?=
 =?utf-8?B?KzRQOG5BbWNFQk9zUjE2YSt2T202TUVORlh1QnF3N2IxWnlZUkltYVhISUJI?=
 =?utf-8?B?L3lRMDRjWDJOOFdVeTJqdy9rd3dKQ2drWGdWalNQWndsMGxWSXZPN2xVNFJJ?=
 =?utf-8?B?c1JFMDB6WG41NFFxUXlzVTNOUFpTN0hCajhlTGl0dndpVjVaKy9GaUh2Szdz?=
 =?utf-8?B?cnZDSERtaUFpR2dMRXFNNnBka2NhaytiOTR4U0FJK0ZyUEJQNEVoTnoyODRk?=
 =?utf-8?B?VWlaVzJVVmxyMHdoc1BDM0V2TEhEQXphVzFOQzlQd1o3VEh2YjcxVkEyUGN1?=
 =?utf-8?B?ZFdEejlJcHdZZTRqMjNiQUlBU0RRTFAxKzlFTkRwaG5KTEhiMTRLSVEzRWNj?=
 =?utf-8?B?OG55T2dJZFVSUFc0RGtidGdxd0xhMEJESmxDWmVTRHZzZ3FTYTFlWldSWDdz?=
 =?utf-8?B?MFl2K3hOOFhEbm9WZVNQVnovSzAyVG10TFVHZm9na2pjeDNmTEJ1MmpKc2dS?=
 =?utf-8?B?ajRPWGI1bmhLYmhRNG1mNUNDMndtOVJRNEJJNExtQ3doSlQ2KzVvWnJ0Q1p2?=
 =?utf-8?B?bk5UenU1ZFNHa2lNTUpnRVdFR0FhTDg0RjloaEVic3dmNVNFREZzSkNpcm5I?=
 =?utf-8?B?dk1aRTJYYWkvZVhYcGk3WG9UNXdGdVg3d2lzd0NuNzYzbXE2aCtUQ0tNSldo?=
 =?utf-8?B?bEtsdjJjL2J2MFZLaDhuOTF6bXlTR2tJRTVHME5rY3pxZGQ4QWdqcmUyQ1Iz?=
 =?utf-8?B?N3JFb3NGLzI2b0VSc1BMWlZDRXN2M0dpWi9QRDlWNndKRm1WWkEwUzBnUXNz?=
 =?utf-8?B?VEVNUWdLaWtJemt0ajYvMHFWbllFN0Z2Z2xOM2gvK3FEQVVUSHBvWnphQm4x?=
 =?utf-8?B?aWZiT0E4WGlET0NOb05QRkZCd2pJTldBY203dzZDNnQ2Nk93RFlkYmVlKzN1?=
 =?utf-8?B?ZXJGSytPTUdBczJpZlBsU3F5Y3gzM1RVZW45cWxzbU9Cb3BzWCtNRE9heXBh?=
 =?utf-8?B?YnRSTys0Z2NaWmZLQlB5NjVTYnZDYk9UbEpncExvejN2SEJhc3poY09wRUU3?=
 =?utf-8?Q?bEiupa0OeXM4cqTuHA4N9ilZm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31282b9d-065e-4318-e0a2-08dbec998df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 03:00:45.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xntWWV5oRMHRlq5tH3D54IwvMnMjp/VKYmm/1Ghon3nzmKSIqHJ1Dsr9SE0733XRgkVgKdHnV0tRnI/P7N20A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDIyLCAyMDIzIDk6MjYgUE0NCj4gDQo+IE9uIFdlZCwgTm92IDIyLCAyMDIz
IGF0IDA0OjU4OjI0QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+IHRoZW4gd2UganVz
dCBkZWZpbmUgaHdwdCAnY2FjaGUnIGludmFsaWRhdGlvbiBpbiB2dGQgYWx3YXlzIHJlZmVycyB0
bw0KPiA+IGJvdGggaW90bGIgYW5kIGRldnRsYi4gVGhlbiB2aW9tbXUganVzdCBuZWVkcyB0byBj
YWxsIGludmFsaWRhdGlvbg0KPiA+IHVhcGkgb25jZSB3aGVuIGVtdWxhdGluZyB2aXJ0dWFsIGlv
dGxiIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yDQo+ID4gd2hpbGUgZW11bGF0aW5nIHRoZSBmb2xs
b3dpbmcgZGV2dGxiIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yDQo+ID4gYXMgYSBub3AuDQo+IA0K
PiBJbiBwcmluY2lwbGUgQVRDIGFuZCBJT01NVSBUTEIgaW52YWxpZGF0aW9ucyBzaG91bGQgbm90
IGFsd2F5cyBiZQ0KPiBsaW5rZWQuDQo+IA0KPiBBbnkgc2NlbmFyaW8gdGhhdCBhbGxvd3MgZGV2
aWNlcyB0byBzaGFyZSBhbiBJT1RMQiBjYWNoZSB0YWcgcmVxdWlyZXMNCj4gZmV3ZXIgSU9NTVUg
VExCIGludmFsaWRhdGlvbnMgdGhhbiBBVEMgaW52YWxpZGF0aW9ucy4NCg0KYXMgbG9uZyBhcyB0
aGUgaG9zdCBpb21tdSBkcml2ZXIgaGFzIHRoZSBzYW1lIGtub3dsZWRnZSB0aGVuIGl0IHdpbGwN
CmFsd2F5cyBkbyB0aGUgcmlnaHQgdGhpbmcuDQoNCmUuZy4gb25lIGlvdGxiIGVudHJ5IHNoYXJl
ZCBieSA0IGRldmljZXMuDQoNCmd1ZXN0IGlzc3VlczoNCgkxKSBpb3RsYiBpbnZhbGlkYXRpb24N
CgkyKSBkZXZ0bGIgaW52YWxpZGF0aW9uIGZvciBkZXYxDQoJMykgZGV2dGxiIGludmFsaWRhdGlv
biBmb3IgZGV2Mg0KCTQpIGRldnRsYiBpbnZhbGlkYXRpb24gZm9yIGRldjMNCgk1KSBkZXZ0bGIg
aW52YWxpZGF0aW9uIGZvciBkZXY0DQoNCmludGVsLXZpb21tdSBjYWxscyBIV1BUIGNhY2hlIGlu
dmFsaWRhdGlvbiBmb3IgMSkgYW5kIHRyZWF0cyAyLTUpIGFzIG5vcC4NCg0KaW50ZWwtaW9tbXUg
ZHJpdmVyIGludGVybmFsbHkga25vd3MgdGhlIGlvdGxiIGlzIHNoYXJlZCBieSA0IGRldmljZXMg
KGdpdmVuDQp0aGUgc2FtZSBkb21haW4gaXMgYXR0YWNoZWQgdG8gdGhvc2UgZGV2aWNlcykgdG8g
aGFuZGxlIEhXUFQNCmNhY2hlIGludmFsaWRhdGlvbjoNCg0KCTEpIGlvdGxiIGludmFsaWRhdGlv
bg0KCTIpIGRldnRsYiBpbnZhbGlkYXRpb24gZm9yIGRldjENCgkzKSBkZXZ0bGIgaW52YWxpZGF0
aW9uIGZvciBkZXYyDQoJNCkgZGV2dGxiIGludmFsaWRhdGlvbiBmb3IgZGV2Mw0KCTUpIGRldnRs
YiBpbnZhbGlkYXRpb24gZm9yIGRldjQNCg0KdGhpcyBpcyBhIGdvb2Qgb3B0aW1pemF0aW9uIGJ5
IHJlZHVjaW5nIDUgc3lzY2FsbHMgdG8gMSwgd2l0aCB0aGUgDQphc3N1bXB0aW9uIHRoYXQgdGhl
IGd1ZXN0IHNob3VsZG4ndCBleHBlY3QgYW55IGRldGVybWluaXN0aWMNCmJlaGF2aW9yIGJlZm9y
ZSA1KSBpcyBjb21wbGV0ZWQgdG8gYnJpbmcgaW90bGIvZGV2dGxicyBpbiBzeW5jLg0KDQphbm90
aGVyIGFsdGVybmF0aXZlIGlzIHRvIGhhdmUgZ3Vlc3QgYmF0Y2ggMS01KSBpbiBvbmUgcmVxdWVz
dCB3aGljaA0KYWxsb3dzIHZpb21tdSB0byBiYXRjaCB0aGVtIGluIG9uZSBpbnZhbGlkYXRpb24g
Y2FsbCB0b28uIEJ1dA0KdGhpcyBpcyBhbiBvcnRob2dvbmFsIG9wdGltaXphdGlvbiBpbiBndWVz
dCB3aGljaCB3ZSBkb24ndCB3YW50DQp0byByZWx5IG9uLg0KDQo+IA0KPiBJIGxpa2UgdGhlIHZp
ZXcgb2YgdGhpcyBpbnZhbGlkYXRpb24gaW50ZXJmYWNlIGFzIHJlZmxlY3RpbmcgdGhlDQo+IGFj
dHVhbCBIVyBhbmQgbm90IHRyeWluZyB0byBiZSBzbWFydGVyIGFuIHJlYWwgSFcuDQoNCnRoZSBn
dWVzdC1vcmllbnRlZCBpbnRlcmZhY2UgZS5nLiB2aW9tbXUgcmVmbGVjdHMgdGhlIEhXLg0KDQp1
QVBJIGlzIGtpbmQgb2YgdmlvbW11IGludGVybmFsIGltcGxlbWVudGF0aW9uLiBJTUhPIGl0J3Mg
bm90DQphIGJhZCB0aGluZyB0byBtYWtlIGl0IHNtYXJ0ZXIgYXMgbG9uZyBhcyBubyBndWVzdCBv
YnNlcnZhYmxlDQpicmVha2FnZS4NCg0KPiANCj4gSSdtIGZ1bGx5IGV4cGVjdGluZyB0aGF0IElu
dGVsIHdpbGwgYWRvcHQgYW4gZGlyZWN0LURNQSBmbHVzaCBxdWV1ZQ0KPiBsaWtlIFNNTVUgYW5k
IEFNRCBoYXZlIGFscmVhZHkgZG9uZSBhcyBhIHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbi4gSW4N
Cj4gdGhpcyB3b3JsZCBpdCBtYWtlcyBubyBzZW5zZSB0aGF0IHRoZSBiZWhhdmlvciBvZiB0aGUg
ZGlyZWN0IERNQSBxdWV1ZQ0KPiBhbmQgZHJpdmVyIG1lZGlhdGVkIHF1ZXVlIHdvdWxkIGJlIGRp
ZmZlcmVudC4NCj4gDQoNCnRoYXQncyBhIG9ydGhvZ29uYWwgdG9waWMuIEkgZG9uJ3QgdGhpbmsg
dGhlIHZhbHVlIG9mIGRpcmVjdC1ETUEgZmx1c2gNCnF1ZXVlIHNob3VsZCBwcmV2ZW50IHBvc3Np
YmxlIG9wdGltaXphdGlvbiBpbiB0aGUgbWVkaWF0aW9uIHBhdGgNCihhcyBsb25nIGFzIGd1ZXN0
LWV4cGVjdGVkIGRldGVybWluaXN0aWMgYmVoYXZpb3IgaXMgc3VzdGFpbmVkKS4NCg==

