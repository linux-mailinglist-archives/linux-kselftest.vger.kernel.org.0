Return-Path: <linux-kselftest+bounces-2365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7072881C98D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F61B2194E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0854A17989;
	Fri, 22 Dec 2023 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZukzZqvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB317985;
	Fri, 22 Dec 2023 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703246395; x=1734782395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xlzGsy2zLFFE4xWGnSgpBAySsmX5etaq6UAkksC7+7U=;
  b=ZukzZqvjRcqaXOfi3gXQffg1Les0BPnSciLn9fUHUqaUCLghAHZ6e8Ow
   8rFHQIYr4x8QrGCciufGjp3xyR9SVUZuuSlX/lhu8dfAX/nOR7Qwm/ofc
   M4B7zAicziQsPB/n5DQuywYzRfhLvW2gwoQnJro5tZdgVI2UgOHS3uVCI
   vUtLEi+h/Lstbnv8fcI5QhWWGnqujfJoE2vx7FnlztfXpOu3nSMZ69c3n
   IKXCwdZEuKe7XUH9xdpV0XwhjtK0kvMBSk8BA4S5iGinXzvlX1E6TRynD
   UusXW3dmCGsEsVJLBO2Vg1gnAr7Y0RW12+FgIsNQZ39hwOGAKMgWOLY/x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3351795"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3351795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:59:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895450427"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="895450427"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 03:59:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 03:59:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 03:59:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 03:59:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 03:59:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg5EpnzUKha3vo9OquQ/T81p+nlkocw5nFZ3XNfLWcGtyuVBC5i5y3JRFPwyiv/6urJzvC7FlvkFAJHxpWc7AUK2+Eo056E90l5KB/EmEeRxqkUoWDGPTZhXLNk3Un0rbuOLuBThABw3QeMMoyUSYwm1eGQVcTr81z5ieMj6zkN26pNoFZ+YJwoqWKAkZBFioQm4cxb30bKtULYOGxQ93L2n9uIFiXnlZVP2Tpmua1AOVEDAXmK68HymN6vzLrRsH0fAs5m0Ek57JQVgUYOLLNZxXHusMcWqtT2IOL9teI7sjvBd02CKbnZ6gHqcWz3spbNXweXMLF97DNiFik8YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlzGsy2zLFFE4xWGnSgpBAySsmX5etaq6UAkksC7+7U=;
 b=HkknTx+KeIKCtxehlODmMKKjayRFkC6rn5loZy4JGG3mqWg00CQNNBHJ+55mVgJ23xNFemzsYQkM0z7nhG6DyGoEYWMeoSNsM/PV0QnRbTtx/2C2VwrUzUhKoJwp8FrMZhNyD35cH1yYksxMRNoPrmh1uOLFSuPPBkpg5+vpfEFEXEYZmNYLgJ9I6s4a/kI3xB0ZchaLLhuugGehK/lCYOVuH0Fs9fg3ryXj1+KxLcaQ86thdDaantEb7UrWtRgvrIJDrb8hYuGrjslg1de+yqWdlMpyjjNHil3+4+kw0d27IYGc5q1wyF1j0ZnLxXK1KQbRNy1jYY1QysMEha6EaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Fri, 22 Dec
 2023 11:59:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 11:59:38 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Yang, Weijiang" <weijiang.yang@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4qRuDL+bDzEuyhcu89eXATrC0rU2AgAAv1gCAAAQBdoAAAw4AgABQMN0=
Date: Fri, 22 Dec 2023 11:59:38 +0000
Message-ID: <65B6D347-5C85-4CB0-9CD8-1C914045B62B@intel.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
 <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <D35102EE-F1E8-4888-8A5E-A1A723B3363D@intel.com>
 <BN9PR11MB527672402F30F701A5EA53028C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527672402F30F701A5EA53028C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: f6c4fc0f-33e3-4059-e022-08dc02e57900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UCnRalu1KZ30lx3Ssr0GBnBm1A4DCb8XP4RwDZ8QAk32Euf0jetMQSsWgzIodutMQFcEA3ia8szjFtc5cFnxWXKxURJiJIF/09AlqQbot91xXYQRPj9XhthwEem4ofnVnmJYDmAfv726XS0FxmK886GD6seYpEf4O0RVjOwUzO+O/phEy2BBC8bkRnLosJixK9yvXuf1mJTsi39IN95Nk8+SqptIgbsBqEjmnVznZk1nR2m02eGLc+3OScBO/GAvseaTURIyIc4XwLcnzZ7pbXLAvNDCFZ6XZ8WQ4om4qjXrZdMnuQGMqSybm6LDzEivYItxkMiXDz5ebT9Vn7iZMDHk4Z24qI5rJXrhI9c8ZLoaY0Ulu2+YHL2ptGIsIply/2Baf4jZc1+0vf3ydiQ0PPI1hcb5OsDHwDbHIkMnQ1H7FdCe1usfG5eZRcamlE7wEjO/nqj9eMMMa3gz/bMQORAq+bC1DxezkfiH9c4cQqu135zw0+M1MHIsTfg3XYrQbwTybL/+RyoY/262c/WpDKzYhGV1Hbw46z6Gt1pi0zfQZNA/xQPkjOrsbiQYnVE4IolnRe8mxfASZKY2RQsORF7Dp2/02bl4Ir9EB743erGBTNNGCHvDWMgc9rRhlZqEaEWOuutxaGferH7YPE9IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(478600001)(6486002)(4326008)(38100700002)(6862004)(122000001)(5660300002)(6636002)(66476007)(76116006)(316002)(66556008)(37006003)(66946007)(66446008)(54906003)(8676002)(8936002)(64756008)(2616005)(71200400001)(53546011)(6506007)(6512007)(36756003)(41300700001)(86362001)(33656002)(2906002)(82960400001)(38070700009)(7416002)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdsRHVUMVpMb1ByZk43NEIxYkhZUEUxNjBUNVFxZld2VitNR3RseFhrZnlu?=
 =?utf-8?B?VUNrYWFuM1ZGNlZ4WXZoa0pCQ3RHM1RoTkRVWjlCMmRrVmdzQmZpNktIMFly?=
 =?utf-8?B?NkU2Zml1OWEya2lxWFQ2cW85Y0dvUmlJTDlFZCtYOXY0bG01YmJqNlJBTTg2?=
 =?utf-8?B?ZXI2SzhlVGpUSURFNUJPc2xmNkdNbi9lTkZKTlVMUVo4OXhpdlZ1Vk4vSldB?=
 =?utf-8?B?NTM3czNPR3FITVhJa1RPZXhPLzREUVVKSUtqM05vblluSlFmVkx4aVg3VjBH?=
 =?utf-8?B?L010NzB6Mm1mZEZQZS9EMk9Zc0psVWdHVlBYSHVGek5ES0ZUaTNxdDJGOVBV?=
 =?utf-8?B?TkdtR3Vtd3lxTHhyREJTc1lRR3B6LzdIQ3ZTRDNZQVNnQ0ErVVMzVUMwek5u?=
 =?utf-8?B?bG5HZXJLOFY5RnBMR2UrRVRJc1FZbDl4OU5laTA0ZmJ5TlUzcFFiRXhOYVBx?=
 =?utf-8?B?U0xWMXBoSmxUMFhyaWwyYzdPa2docFZpSWtNVWNvNWxTbkdUTER1RUV6M2pv?=
 =?utf-8?B?cE9CRDdDMTNOSThIb2luOUNMSHhPRkNwRnhQTFd4RTA1b0Y3NWZPL3c5TjBm?=
 =?utf-8?B?TjhhU242Y2hkNVBYNGZjZ0hhTDc4My9CM1BubHplczVsMGZBVUVwSDJHY2xk?=
 =?utf-8?B?eXMrakpvRENIYmdXbDk4WFJtMURLT2hGRFRFTUVQUVpmTHMzMHhQLzVVRjFT?=
 =?utf-8?B?NStBS3ZOajArZHJmWXZjRWxTbTJGY21ieTNrMXpBVkd5YWlJbWFncjJaMUVv?=
 =?utf-8?B?Yld5SEovQmR4VkVmcW1TNnR5dkN5L2E4VWJZb09pZGg4ZHZHV2c1dmM3VjYv?=
 =?utf-8?B?TWNyWDZNWGNGbThPTTFmUnltWnB0RkdPc09PeHBONmkwZzZpYkdkUjZIbmtZ?=
 =?utf-8?B?ZmRucHNUU1NJdisvUUxIdThUeW5yeGRFcVU4ck4zaXg4WG5TVnVYQ1BiWGxr?=
 =?utf-8?B?Vi92SWdYdGN6Q2JYMjQvMDU0SEZCUTBzd2ozWjVlQWhJL3dMNFJ2QVQwOXNs?=
 =?utf-8?B?QlVBVnZ6S05kSU9LS0UweHVMZnpXUHdOdDYrQ0ZVNnUxSTRTMGR2QmxnWFE2?=
 =?utf-8?B?bXQrM2JDeExwU2tsTXZESExmVTZITDNUWVVDbTRmZWlPVStQZTZiQ2tqOUpi?=
 =?utf-8?B?UVRtbXdjT0x3VFhacjFtV3IzcnlRaWxObkpnclpTVy9MUi8vdkdqYjRjSE14?=
 =?utf-8?B?TlFsVjJxSHNwbTAxK0IvWnF0TGxocitGcjU4NUFwa0o2M3VKUWxrRURxMGVB?=
 =?utf-8?B?SjFwZVFDN1ExdlNWNnhlMFNJVG5wODFOeGZuVENSNWhjVElEWWFUa2Zwekox?=
 =?utf-8?B?WSt4c0J0V2FjKzl6akdFV1Q3czlPWnhuT3RnQjM5bmRCMHZIZmFLZTRiUTZ0?=
 =?utf-8?B?UlI3WUhhc0xRdktHZDY1SjhxTFdnYnRSSldzb2Fua3VhRlNGUVJrMTJ0bEtS?=
 =?utf-8?B?SlBTSjBHRnBuNHYyMldxdi9xanpraXB2ZGlaRTFZVVBRUlJaK0F3Sk0wS3pr?=
 =?utf-8?B?dGNpdzE5eXdoR1UxU01mRTVXVG1RR2cvWEpIaEJudy9Pb0JBbjViUS9ldUVm?=
 =?utf-8?B?SzIvR0QxWUhZTFFOeERmL3FUbkVaMUVWOUNjcGo4YWdXVTVsaXBRN0F2WVVs?=
 =?utf-8?B?Q3N3MkhKdHZ4RHhGQnZodHhWdkVidUtWSU0yYndsdHFaL1l5eGNRS2FKRUYx?=
 =?utf-8?B?ajNaMHZyanJUWjIzQk9hL01hL3BZeGxmREtQV0UxODcxZ2IzS1BpS0IzUGZN?=
 =?utf-8?B?Z0lXd0NrZFFYb1ltcTUycUhMbEQzOElsRGFyWDh1Rms2Q24yb1U1NVN3QUVM?=
 =?utf-8?B?VlJSZHBMYjFDOC9Lc1krU0syZ3JySEdVS3hFR0NINDVIOWxlSjY3eTlFa0t2?=
 =?utf-8?B?WktpMFJDTy9TeStxYUZHR3RmTkY3ZE5jcHE1UmFZZk5MY0d4L3FJMXF0U2ZF?=
 =?utf-8?B?R3lHcWJKMTg3TmtUVWxRdjFFSzg5ZU0vZ0cvdkdKaEVFZVhoSGJxUjNsNmtZ?=
 =?utf-8?B?VXN5aEFBT2lDQ3BTMFFTeU5JREwvZnI0a3pSam1ISS94YXRnSzZjVzMvaWxP?=
 =?utf-8?B?RGlXZmUzckx3ZzVveWpzYlkxNm9nT0I4RGxxUnRaaHptUEtjbDdid1BsbnBC?=
 =?utf-8?B?REdwMWZOREFtSG4rcGZkZUVUM0V5MVJ6dU4rVk5zOW9qUG91a1YraTZ0NlNw?=
 =?utf-8?Q?I58VbNcTB/4iQLo98CSsAwH9yL+91ByxYRhtu/jA8LIm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c4fc0f-33e3-4059-e022-08dc02e57900
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 11:59:38.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MAk/Ys/4okQGSYpAGjWsbK4cTw9eRCco00apvFkR7sKY+HcOmdt6cxi92dxBUrFtEX4Sarg8S5AUq7+W39n/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

DQo+IE9uIERlYyAyMiwgMjAyMywgYXQgMTU6MTIsIFRpYW4sIEtldmluIDxrZXZpbi50aWFuQGlu
dGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IA0KPj4gRnJvbTogTGl1LCBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDIyLCAyMDIzIDM6MDIg
UE0NCj4+IA0KPj4gDQo+Pj4+IE9uIERlYyAyMiwgMjAyMywgYXQgMTQ6NDcsIFRpYW4sIEtldmlu
IDxrZXZpbi50aWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4+IA0KPj4+PiBG
cm9tOiBZYW5nLCBXZWlqaWFuZyA8d2VpamlhbmcueWFuZ0BpbnRlbC5jb20+DQo+Pj4+IFNlbnQ6
IEZyaWRheSwgRGVjZW1iZXIgMjIsIDIwMjMgMTE6NTYgQU0NCj4+Pj4+ICsNCj4+Pj4+ICsgICAg
eGFfZm9yX2VhY2goJmRvbWFpbi0+aW9tbXVfYXJyYXksIGksIGluZm8pIHsNCj4+Pj4+ICsgICAg
ICAgIG5lc3RlZF9mbHVzaF9wYXNpZF9pb3RsYihpbmZvLT5pb21tdSwgZG9tYWluLCBhZGRyLA0K
Pj4+PiBucGFnZXMsIDApOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgICAgaWYgKGRvbWFpbi0+aGFz
X2lvdGxiX2RldmljZSkNCj4+Pj4+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4+Pj4gDQo+Pj4+
IFNob3VsZG4ndCB0aGlzIGJlIGlmICghZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlKT8NCj4+PiAN
Cj4+PiB5ZXMgdGhhdCBpcyB3cm9uZy4NCj4+PiANCj4+PiBhY3R1YWxseSBpdCdzIHdlaXJkIHRv
IHB1dCBkb21haW4gY2hlY2sgaW4gYSBsb29wIG9mIGRvbWFpbi0+aW9tbXVfYXJyYXkuDQo+Pj4g
DQo+Pj4gdGhhdCBjaGVjayBhbG9uZyB3aXRoIGRldnRsYiBmbHVzaCBzaG91bGQgYmUgZG9uZSBv
dXQgb2YgdGhhdCBsb29wLg0KPj4gDQo+PiBNYXliZSBhZGRpbmcgYSBib29sLCBzZXQgaXQgb3V0
IG9mIHRoZSBsb29wLCBjaGVjayB0aGUgYm9vbCBpbiB0aGUgbG9vcC4NCj4gDQo+IHRoZSBwb2lu
dCBpcyB0aGF0IGRldiBpb3RsYiBkb2Vzbid0IHJlbHkgb24gaW5mby0+aW9tbXU6DQo+IA0KPiAg
ICBuZXN0ZWRfZmx1c2hfZGV2X2lvdGxiKGRvbWFpbiwgYWRkciwgbWFzaywgJmZhdWx0KTsNCj4g
DQo+IHRoZW4gd2h5IGRvIGl0IGluIHRoZSBsb29wIG9mIGluZm8tPmlvbW11Pw0KDQp5ZXMuIEl0
IHNob3VsZCBoYXZlIGFub3RoZXIgZGV2aWNlIGxvb3AgaW5zdGVhZC4NCg==

