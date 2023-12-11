Return-Path: <linux-kselftest+bounces-1493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA880BF1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 03:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F7A1F20F25
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCF633;
	Mon, 11 Dec 2023 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnYdcjE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF4390;
	Sun, 10 Dec 2023 18:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702261812; x=1733797812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJLxE9ua4sukd89jxifKYz0r5650TeqBYFF2rmN/TX4=;
  b=WnYdcjE1pK0lbLSls+07tLav2jP/50JCV2nPXHmk/58Qb5WaRNsu24Lp
   e4V5ESe+JJn70r0bSzLlGlriNSQicTpmqtv8yVYcmONTB57/zXTCDz0Li
   19KWVyKTqJd8jq3YdTKVI41QVKqnSedaiNdWQA8hDdiM+AqWxvyxYZd7K
   EHFxnBUVm0dDJtWICjdLxJ4lE2tgs9ebzbbJKAiiljTeeLVsoyDS6Jpck
   DWDDN6sKKQmksTu40yT8zE5aHPbFxJhAtSfck7YoY2WEo+P5vtna98qYw
   euxwwQ2R9zvIijiTnfO0Uvc0/av6qDNZTDsFOtmejXw4DjeZhrtiAwfo4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393447990"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="393447990"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 18:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="766189340"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="766189340"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 18:30:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 18:30:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 18:30:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 18:30:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 18:30:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3+oHHy+g7z/tumBmaN16WcHaQi11BoGjwex88xQaYtpn1cKHbzk5GoPTLmVK6DmS7QO+tIwLQRk0AWFVddmLcqbXBxF1NrxE7GnGrCwcIidQHItMfh/zprTUd7p9FQZEz1nuHr7yzzSv7pYwytRgeEMtJsRA1m8M6om5LDl/MVycVGtzM0UTU/scQBOLOr6gnr2w8OcTODYSvqhQ8EHX6bSs/WO6WY42zuHlx8dpPccbFsqwDZItjhpkuthhIP3CY94Cl/LIOrCN7Zv7EMPwxh+QO1tCS4hdX5ea43HCxe693dXdWmlGNX76imjdLkCAuoBjGpDi0KUIgLLLFEDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rddNAA6n51KKJk1Y9oJeU75OSc97YWVa2CocOkbiHyU=;
 b=Y4lu/DUIXAWr7n9lIpmM373xI1T2Nq2LXNYo9PzfL7wVl6lIfwDOAei8O7Leq1ioRyltiB/lRYQHWzf3UVMAVed9rIJ0w3plWWfOtUUiDni/9YdWOedx8DRkUq4/7AP+ZUvCHlzzMDZVjF7nVzQfzExZq0CzGL85r3WaHVSLZBDtWGpJed9GUlrlQF3w0Wixi9im61vmKDuew9FEavb1TBqRC8U+s6a7HURxyPatAdz6MTOO+r8tYjMWR4YqDza3blGXXWW+ab9JOgMLNNNm/5cfAPN7lRC2Me78D73XmHz7FgIFisvd9EHGSzrZuNiWgicx5KZffKCUDX4d8eoXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:29:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 02:29:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"Giani, Dhaval" <Dhaval.Giani@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
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
Subject: RE: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Thread-Topic: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Thread-Index: AQHaGVcGB9517zktWkq6XlvDSMgylbCgUKQAgAMup4A=
Date: Mon, 11 Dec 2023 02:29:55 +0000
Message-ID: <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
In-Reply-To: <20231209014726.GA2945299@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7485:EE_
x-ms-office365-filtering-correlation-id: e4dbc62f-fe5f-49c6-82ea-08dbf9f1104e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IvSsszgN5HUHsgSampEMthvqcl+mMpIEz+YE6/Uj1fCjFIQsf7Nq5FFiNmKyWhn80shm4KxvfZKZqM0DTV+Wk4xl2wJby2YiqdXdJNLl88ADm449GKz+o+tS8Y9CYilDOrqs9SqK4trcZaI/FewqgbdmQLFb8AoSt9S1z/mpgzCoy86D9Iv8OZb1ZUrs376ccIFLvI6e+mqLrQxvaM0I027bifMVb0CtpWLD02g2Lbca7544WxhYf1LB1RHPLV5DfqRpmqZ5gh5A+9w+P+Yqv/AlCEYClxmOQ+0wF9kN2NR9TDhS07Q8nQjYpO0vKiWo0uZEvmHhNAvHqSrECtsQlCHxPuI+KrIXxfd2c2fa+9+I0gf10gzXvC9884WOYCvArvHm1E6R0YSc6hXOsRlj55uuz/sy+rWYAKokGRzizJGy7qwJA68qGnl69boN2Wy339oTSgtCpHt/kEPJGyffWwuZ7hyVR2IUceFMj5vMhxUQkwNGxr3v4ZP63Av44jRBuCnpXGXUPMidY4nnbaTQCXVNAJJBGM78OyMlZr+Eo6TQl06UUoVRsKKOgUDMkfSOtHldofVbJhwgBbZ/Oo7Pnc8N501QIj8FdDVQeyiIjk4tIFVUdOTGxHeeipv1J0zz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(26005)(82960400001)(38070700009)(33656002)(86362001)(38100700002)(122000001)(5660300002)(316002)(8936002)(4326008)(8676002)(52536014)(7416002)(4744005)(2906002)(7696005)(6506007)(9686003)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(110136005)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NT/LxjK0Idknn0MJYd88eGyizDtcquQVRkA4OUjDBBM0xPycWrpDkThcGOv5?=
 =?us-ascii?Q?fcSDsGVjiWhujk09JHzblaGkbcdKKFSrjys/ldOAEbfEC5dM3igWd2cekp9G?=
 =?us-ascii?Q?kWG4Ts5CN6MLZtfdhhbYsPi+cTMlMPXguACzputp8tkbqi1tX8dAQc50OCUq?=
 =?us-ascii?Q?4DUO4UeSXaUddzgTgRa0pYYUs5rG1iVuIErpCih1bHVSHesKZnSPLIvcOKOJ?=
 =?us-ascii?Q?0fuoBdUNQp2IkTDSquxOqm2gb5pRzIfJ8rzBFAi/Ywbq5NVa21tCpqVmCbI1?=
 =?us-ascii?Q?LHR272qzda1PgW6HGdYvWDmJ0w8HlbdJn7Qoxc/NPHUmauMXHzAHumwvpVtG?=
 =?us-ascii?Q?U1A+qibSbtkMDTgR9aHZT3Oh/unxOiPVSMbLCCBWWhBLzhcg2dnpMaL8ZoWy?=
 =?us-ascii?Q?G5cZJ0COZwNISlVbKXM58LbJRgK1A/8wDiuok1eIG1oGJFFNdWX9YHBbc2cc?=
 =?us-ascii?Q?cDDdDvsFOtfvxwAtyoMjkoRT8KTQbNEtFDJkIFULDKSm0Fyis4rcVwsGStxt?=
 =?us-ascii?Q?p8Z/nWiLbKmt/PvAHBifSGwS72p5RSpuRI+YqxPC3vCJ71ejYb1ennYnWgJ2?=
 =?us-ascii?Q?kd6JYgcl2MPvKLk26xDmieAlEl8+fZSuJdGkoXIRF1KzdZZfi26tvurUowff?=
 =?us-ascii?Q?I5maqSnjXUenOqdVV7hMfxj6745ZmLegStjEh0A+AqiGkWAgC6WctKKkQhpk?=
 =?us-ascii?Q?LxEbv/2ZyfteRQXR4WYquHzL5/2bOe+wqFdmxlPSB6TZHNajgxJqtEivemwA?=
 =?us-ascii?Q?kFqVzfcLQezalKujp1hD7DE5giI9GoGtumZFMPxH8aWRA9Dk99aMZdnoKwoM?=
 =?us-ascii?Q?loMCCFtoHt20tyz7EHdbTX9YDDGXBWpod6pXo0j/CaEh2Zgc+4MdG3hURc0a?=
 =?us-ascii?Q?jiHx8B+YojKMOBlzfAVHZLbQ8WKPOWg60RnkBNdDfGoR3Z/EC3VCvN8vE4nA?=
 =?us-ascii?Q?8Tvu7eguXyRhj31fFUiA+Im0YJeNvEvAfskomLepgm2GeNqOZy7uPLjP09j/?=
 =?us-ascii?Q?Bh4AFf04nnpftIyK5wPftPxLofdxDuhpkd7VciVUnAm5TkswRdmjFfhYiQRr?=
 =?us-ascii?Q?FaVgZNuh9ZmekdXUZ0b7MtpQ0nArojy6umaMt81lWQjDBi9QspFZcGosxSA6?=
 =?us-ascii?Q?GPbzlGRyeKD5MdzviBF/H9bB6j7ocf/LIUjSRRsUieETRxsG1NEdogaLzR6b?=
 =?us-ascii?Q?KA090bg1Ztq1U1p9S9+Hz3JECqk+Maik6uSexbRCN8sxORahaEPfeQbXlH/N?=
 =?us-ascii?Q?qmkkk3gwJ0q/dt/2QyfvU7+rBkscERiIEIJ3kQ6AR4wclI2mcpwheA9w661S?=
 =?us-ascii?Q?75IbycPebzuQO5FsjBHWqqoKyx1bl+A8dpKskCi5YqIIwMR3XRxzMpwukt95?=
 =?us-ascii?Q?cVdf5OYHv+Y4uEYETjPzSSKVLmQBZSnixLJbGsE8TKUgCpN6PD36D0zqtNPS?=
 =?us-ascii?Q?JE8G/rs+pgIAuca6pGp0deOyLn8JwQUGvPK0Tl6hR4YbnkTmM5Mz6N3Ubjgf?=
 =?us-ascii?Q?3vUXyNfgZ50hKBNOPM8zpLuRGO788dKPinp31ZXJQK4YYYAAY+g+d6OP2gbx?=
 =?us-ascii?Q?RJQlVYddhe/ijlAjXuYOZmxRL6BB+lTf8JPw+nLB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dbc62f-fe5f-49c6-82ea-08dbf9f1104e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 02:29:55.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVhxBFfSUtvPPofFRMlilgdgNxjt5b6MYq3dFtTkai+Fs7BHTAVBiVELkv9LybQidI14rMkjKH/NnHDb1tNX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, December 9, 2023 9:47 AM
>=20
> What is in a Nested domain:
>  Intel: A single IO page table refereed to by a PASID entry
>         Each vDomain-ID,PASID allocates a unique nesting domain
>  AMD: A GCR3 table pointer
>       Nesting domains are created for every unique GCR3 pointer.
>       vDomain-ID can possibly refer to multiple Nesting domains :(
>  ARM: A CD table pointer
>       Nesting domains are created for every unique CD table top pointer.

this AMD/ARM difference is not very clear to me.

How could a vDomain-ID refer to multiple GCR3 pointers? Wouldn't it
lead to cache tag conflict when a same PASID entry in multiple GCR3 tables
points to different I/O page tables?

