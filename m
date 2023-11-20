Return-Path: <linux-kselftest+bounces-285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2B7F0D5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9528195B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA8DF65;
	Mon, 20 Nov 2023 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jk65OHQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5D95;
	Mon, 20 Nov 2023 00:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700468272; x=1732004272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKaDLHn8AD9OF03qy5v68wPG0OQOM7ezcp2wX5ey9es=;
  b=Jk65OHQsPd5pUIFcPgdgC4lsYmBjnIAycV5q1BJoyIrum3pZOm7H2ZJp
   tEurujLjXSuYo3OsaxhF31CeepxOoJZBzAj5o6kdNtEQnT6YLl1Kw+rn1
   MEBDCqpu4/W0HhweJgp+dzIChy5wX2wdqZgbF277rNdjDLTf43frjJ5pd
   tca/58D8WlFEwwghhktQr9lK0ljc60ioYpqzHJQJP5PpvpmIch+7vG6Br
   4AfzLhv0TPOOUnff2HOk9RbEfw3Tfr3PYw6Ti3PaIVTf8v8kd9Qz5HlQe
   7xCb7tHxtEqCU79kSupWjqzqQJZaKrzIwqSMGM20AjYe3Fj5JR/4eWL1G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13126244"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13126244"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097683540"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1097683540"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:17:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:17:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:17:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:17:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEXAifcBas8YbVrx0mWIDTgZQ4jmuF4bWsPO+bVD0NA59ltsOwO6IRTE94fT6tZzJ3ebtEboOv6AblIstGItwRRBcEs0lmRZi3MxmO+ohlnVD5eqbIMP1uGrOGMYyk9eEse3QDEvLZ/1LNmAms6PyO2i05Zj3txE523XurxmkRD2hUrWcrNxzcEmeP9FsJWWhCY26S0B+UR8EHKF1EOk7ko3bdWigLsNcacf1T5Y7s+aQhql3lWu5n7wOB5n7x1H8zqjnHZG640loEh9M3dQM7DVEm9hbYCk93CoXLjZUATXYpJ16OcuObEBvffuHT1lYaQR+gfrGoUd90BUxWtz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKaDLHn8AD9OF03qy5v68wPG0OQOM7ezcp2wX5ey9es=;
 b=D7Qq8coDiwk29XQA1Oh8dKI4mYYD0qGpdwlGgeZoXa1jL6VwyUztm5XhRZEwgGxdPD6PX2OP09GrTYUBRwwDWT7AKQkAf2oxdlyETFZDWy9IiMp8TaqSGS7HqFu64WiekjGj3v45RanXmT6ix4DF92XfWM9dPnZqoFPXaLSjHA+NruJbya5i/ZeQ4NmeV5nuYMeovmyq1Lwe1I/ZoDXekC1v+n30wgLj1jbHeqCh7ZiQRFJK7L327o9UMyLN1Y+/Kgm4KeXiwRHAaw2VzmhuQjm5WlnSJVzRLcVi/JZSk5y69e+fvcRD2VtCa8utAWhJGUn/Wyy/12q2WrC+TBL2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 08:17:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:17:48 +0000
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
Subject: RE: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Topic: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Index: AQHaGVcISf8BaZEQJUSSGRR/7aBQN7CC4RvA
Date: Mon, 20 Nov 2023 08:17:47 +0000
Message-ID: <BN9PR11MB52763299F886D4A534D6E0BA8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-4-yi.l.liu@intel.com>
In-Reply-To: <20231117130717.19875-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5995:EE_
x-ms-office365-filtering-correlation-id: 54ad1310-8d06-4c9c-04b9-08dbe9a12e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhs1GtQe6VXrXQwu1FXE2U4GloDu4HvKbUym0NONpYPHVE4dS0m8Iuk8M1zltM5/5VPfJxce0s0sO1j1ikiSp+yR30ByvGLlUyesVVNOCD9KriIXe2ngFqZC1zIikSyBdsbUpwKk4KWGLCf1KviBLHCH5cD9vJHZiccMKO+os8hLyZ7DAjCGKc48llGk8BVVaf9gvOrjTmntMj0wqSKW2GayLSb7vUwFKh0nphvzJWd0Xbrs4xnXvuTxrGVWXO95MecsrMGQ6FdYoi7y4XL2Pga+p5yzpkYwSAxuEUh+73YsRpgicyQU+luSWRHF77Is6hv7fwiJ4hj5IiQjwBvCiHks5mOGkEVXMFy1A2IQzUSJ+Fux7Lwgbn148yQrm9Jv78G88rDyEmdjJMeqQ83GWbSHZWtOEiDn98w/NdK9IE5DBdd3z5HqhPNnNpFE6AA+eweTevLxQFJktQuPFXdW2zIbalY1FiTIga5ybU16BTKQjsIWWKHpU3TlWsOnTCnKQVTTYWU7UvmtGKaI1y74zLqk+dI1UVfw4ubBYmnDaPfPnkxcQM3PdNk38iUcbYeSxuhfmfwFKvnQ1UBrT+oy/HNgPKzKQStlinPdAYybLcz2AEBFMt00rss4BE2rxLVw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(55016003)(2906002)(5660300002)(7416002)(52536014)(41300700001)(8936002)(4326008)(8676002)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(110136005)(76116006)(86362001)(26005)(38070700009)(478600001)(71200400001)(9686003)(7696005)(6506007)(122000001)(33656002)(558084003)(66946007)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pjn+MMgV++NyhreuVJQzJ+3nk4zmGTC6qKgQGu1suDmybe1cqg3+crgn/vku?=
 =?us-ascii?Q?S0c2Zx+gWxXpIBtiQ4KU0uB71GB2pcQH+KQhVql/EvAaQO+JlBZRqzfYorud?=
 =?us-ascii?Q?RErUSs09wjWOFCFfWBYDgT+cU5g3ot2FtwUvNAqsdMRfvaBKh7xcCXsEQbM2?=
 =?us-ascii?Q?6YFdHk1gmFQmmtlgexvfUYQmjSP/tPkhIzEGPYu2noeH4bbkyQ8yEJ97votk?=
 =?us-ascii?Q?pzW3ThhzFJwB0OiI+Zt3vkeom5G1Y+Rn75MjFgDG9yk1K60flrglB04a2bgS?=
 =?us-ascii?Q?4p8itmx0LHmekg/+gJ2Tv30ob9EgcsfTMduSrxjV/gCmWpsGZmBQLzBVePeJ?=
 =?us-ascii?Q?6CtbTX8eWXXN3vDRbbertRxIslPJ548Jgdjiw1DM3FqIDn9ALVqR1AAHvgca?=
 =?us-ascii?Q?1FHWTlXw12DoBwwpjNf3iLMqLKdHeA4+MDxwdhpw6sjkgAfI7vJHAUZV6q7f?=
 =?us-ascii?Q?VAxDQa9yCX8J+XlQNBoWaqlnC/4Vkt8PKm75iR11QPsN89vmVB/65gQ9aG9y?=
 =?us-ascii?Q?TwSaXZO0BhLR/X7aTLcgRZ/Ti1qxAhEgO3LXiHKXcWhmDDCgEzmX1KgYiJou?=
 =?us-ascii?Q?+OWcHifXkECG7eG1K8vccz3l3J5jA82lUWBCAyvgerQnxHA8X0FdIEEzQjHS?=
 =?us-ascii?Q?G1FKrDbEMzqqDlpsCDxgz3dw0CcRArgAkQ2u11CHt43AzY6w+O3v1jOK6skn?=
 =?us-ascii?Q?OzlopnEj3gbBv9fspJvA0rB52775F7tSj5cZXswd4UBJDkSJW7QaXtst255K?=
 =?us-ascii?Q?DxxrLhJdSrpfWm+9E+ht2Inz353fSgySbj34Ok4W35iuUHQsFfFqh9ffjtyk?=
 =?us-ascii?Q?xnen62AK6MvreDT5+mnF5kMBOkEspZzh/bTJ8OMRzx02M+tP7kI0gYUCKWkM?=
 =?us-ascii?Q?zB75JTz5BtLoOUn0L9kBBa3xm54lRsVamJxf/P+Jk3QoAl51DvMJzOSuP+ZO?=
 =?us-ascii?Q?sSW6HRxssdp+KJW6BT7Xpw0XrTH9TjzOVEG+ekp8RwLjWkCFviwVhmZTfR7h?=
 =?us-ascii?Q?XES3VujVPO9XvQvWU6KwUQlKXNTbG/olaTzKlPD0u6Stv9wY+9ggckOLtTpa?=
 =?us-ascii?Q?kXGrDXkGu4TR3XnFgmIF8zUe1y2jmYOh52RfDDcYORLz8I+LgkWJrQrFCJGO?=
 =?us-ascii?Q?i3T6U4HdrYbxQLFJgn5xFBd2CrAUQlsF4cUHYQjBDFqdMl2QJEt70yk9wSzi?=
 =?us-ascii?Q?+I/x7pkCTZIQuFrxnC/JLK4yPBoBeHi1G4apQrzsWpgqNqmLEXelhvrQxoKK?=
 =?us-ascii?Q?I0musd94vP3jzUvOjJn6D/+TAzMUO2WqsQjwgW4LGHlR57qV/cDN/7XURdl/?=
 =?us-ascii?Q?DA6rdd4hZHXP3RZhF0Hp+ATG+Vf1aEmdg7a9OGY1QcDn+4E8t96cZjh41Rrd?=
 =?us-ascii?Q?nhiRa8LSVTnx2C9Q72eaOLSeVnpgwhDnzvhGEAwHc27txIkrlwqM1mWw1mP4?=
 =?us-ascii?Q?nIDwuXVUWq4IPCynK1nwpHttgNZ9On/JvfEynziR1e6m/619lmzRGh9kPzcs?=
 =?us-ascii?Q?BJCaLoHcmiW45GJNMUwKCQd0YebpglvhE/cfHQOsFA7rHL9BKHURNDj0Fxiq?=
 =?us-ascii?Q?Lig9DPrgo985gu+TlOu+KwzHkElNduf5CvtdhZMC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ad1310-8d06-4c9c-04b9-08dbe9a12e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:17:48.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FCMQIwBj/Fe53UADV7Zqd5Z7OAiUjflTa89xo+Qzz7fxSZgRgRw6O14GweoTqzrb8xVMvmAP+zTZZRwBG+fAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, November 17, 2023 9:07 PM
>=20
> +/**
> + * __iommu_copy_struct_from_user_array - Copy iommu driver specific

__iommu_copy_entry_from_user_array?

