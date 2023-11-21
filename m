Return-Path: <linux-kselftest+bounces-358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DB7F2469
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 03:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA82B21798
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DDE11736;
	Tue, 21 Nov 2023 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Szekib1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF1CB;
	Mon, 20 Nov 2023 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700535267; x=1732071267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aO4z6xLgagxWJaDIUfe43jdVZBBqa+TxE61X3Wlwcs8=;
  b=Szekib1I1nAoyBHkssFgvHHDtRAvVdpCGyx8nF2BIeaBz6EpA/Lz+VTi
   DvyxamhSee4RyUmy9QGWxjuv3SLNHq173YMoN/ZJ8AUnxMbD7J2KqHajv
   mZheLUTxsy0r4VbmddnE9Er9H4utcdyjsNWgbCROruYCy6wDE8525Tzfv
   AOokuxhrYP0jD9oaE6emE6Y8Gucx6Pyen53SzdAoUiEEUxovtfVcvjT9g
   V8aCdv/QLmrdDdP00yYNWBNEw7GUqD9YcVitA7yk0Eqw04HJSi8Ses7JC
   mxu89OLvXCH5/79gpSdMfUftN8Fue+3M8LD8PaKi8gLKbz7m5q0uCIPTV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395681569"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="395681569"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097920675"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097920675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:54:25 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:54:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:54:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:54:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqP8Fv2lSNneLk0nZ7SvthtuSXNq5+2YQZwQbt0G6KjXoESVVINcRWd4GIdHIfmkLa+oqUmHD2fNFShyACfTkHZugxBCFqgN23na4kU/hQo0J+lnYEqicBwD+eMo4UA/YzGxkoqruLn5oGgwhE07X0sEzflKqWkkn1sOAEqxxx3nC7qyEH2Q0hO4UeUeT9IOwjV43E1WAUTDHKLxgt/1eHlNcl32y31I/Shzf+gkM8K48cRAl2LblKIZUf2xWrTLYWNUkafmo4+mT7IwSz5S6OKCzhzGOagLnpDd4Od1BqK6UGgmkamsG043HqcFnWUf/F57ZKcxXO/gh0IW9USgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO4z6xLgagxWJaDIUfe43jdVZBBqa+TxE61X3Wlwcs8=;
 b=GTO5urHhyx5hdCEwyer0v2qGlsVEJIS0zgNeKe0Qy72Dv+tv0xqlKEjzMYyxQWLkgcjb7PXe9APs8SMRLbb3smkQK17Kq0oV+9ZLE/P7Y3YrhobNKnsvwg68bFyb3/fdJ8/cCn3ei0DZnjBfid3Nhzad/jwf2BYJpk/2M1M4Cwfu+9EECQV2RbEQdpHwIoRGv3/x2DT/8VEIoYGsh5PEdstXS9Hr81OU3cYS8sJhQJhfPmbOrnMKDadsYxeMDsOjlFHO/emsfCzRQBKp+sQiXWz9aIESg2zTLI+G6QSusPtmAcsGJ3Ebtn/7Pdapwao3D4BJJg4pVWlfFLQBUW8x5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:54:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:54:16 +0000
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
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCC4vaggAD2R4CAAD710A==
Date: Tue, 21 Nov 2023 02:54:15 +0000
Message-ID: <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
In-Reply-To: <20231120230451.GD6083@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4612:EE_
x-ms-office365-filtering-correlation-id: 9bdd3356-dd6c-4f08-3af9-08dbea3d2649
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vfa5ep4rScKLaHUGeYFIL01nDCrJhrFU438gGQlh9pZ1Fb103wxtjvQQTISNma0ulaIpdpwZaYpsHbgwbADJyG6Wi2fG3+k7coT4jEgfVWPpHpC+JF7l7y5CJKZVOF6tAFVrJUWT4MTSAK4/fhhAmrxQQbDZbk9/40V/GarxJabc3M0rl4xN4o0MnXBgy2Uf/kJ1u5zyXb7P7uVzS28JD2CEAbhrcIrPImNB67eSbcstxJf++O97ShssPmy79RCyoghBtvfiS48qJXOiclmsZgdZ6GGVsMzcw83vsN1bKn+bv58nyPqKGrMelojdBZemXrQTw3k1w+o7u8aAMN+m+4hp4vdB4MDRMdQeyoOZgKTKXu9AeKWSJlgPJfa69MN+5ieXTMxQso4aV2RLhXV9+nTsHV6zM0Kf0+ayZg+Kp6Bdq9mvuIv19e/bw+MbeqaEE+FzW8pQwkeBejH7KcehtGRmEVgANclOj9si6EgFmTqqmscLJPLFHM719RCmoqVSmGS0jdE2aOKa6LY+dsCMOwPA7+uSieS94LvzQL20Sj7IfoLdvOX0DNnks6eqMPkuPqsFl7Q1uk2nkYe6u418WH6ila3KubnetGuWWnTTEhyKUCl36pwx+sl0oEpsJGV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66946007)(66476007)(66556008)(76116006)(6916009)(64756008)(54906003)(316002)(7696005)(9686003)(71200400001)(6506007)(26005)(478600001)(38070700009)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(55016003)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6aFTU0BbghT4hbWSacSEp2IoE2SwhaM4WySzagbpRg053oJugcyDUd+B4b3A?=
 =?us-ascii?Q?kWsEPbdSoDqJD77ieQZ9R910/kQcmleugPPcWxaXi/ScUq0GcCP5y+AjBO1W?=
 =?us-ascii?Q?0h7/hNfzTYvv8UDnbHklmrQD34JOfQuwjhHnW81xQq1WtBHiHNeH71dVUOHS?=
 =?us-ascii?Q?afpom+Hh7go0G8cVg70UCXsmpP0bA0p/SnHhMJJpNmmYvg2K3NW4XSvb26oP?=
 =?us-ascii?Q?XovqaRjiR06YT+z/6xLZZeP9CaiSOmmb/Dh+f5iMYGaOjwfKAziGfpFe2W3t?=
 =?us-ascii?Q?RitIWZ9/trefUbOwvjdE+baAdG9mX3/3PpLdx4mLHsyrxeobPGwix16sUKt8?=
 =?us-ascii?Q?aNHXXPyPYJgzHk6gxdXBGR5daKe7QoFsBWSAShGtN4EfAKO0sQyZloGd8HDb?=
 =?us-ascii?Q?ahQ4TZbShnrQcHLc3HjheOXq6a0Vx+zbxnz8gu1WXkwnP+jCa70iGYoYaD0j?=
 =?us-ascii?Q?/oJLuAc/OzqMyJLEz0CMgGeYhMNp+gqoQzv6H7qCHqeV1s1mgoDyOZ5i6avM?=
 =?us-ascii?Q?pzQrqPQEEIiH4IZg92kbomX+Cd2jV8ceUygBHawPSymlsANJcxBIZtsg3Fgm?=
 =?us-ascii?Q?raEBYt6EsDjllXOyEmplE4yJYVS+8wOn4zII8c3ZhI8bZj+nP1+e8L6v6fvF?=
 =?us-ascii?Q?xhMmCPHhZoa4wHYyxMkzJJWNWrD2qYsmvBosECLfaQJaPDuEp4bdK5Fh6JDj?=
 =?us-ascii?Q?zeNxgjneGecZnKDb3aJGNnzhZvnX4Pvs1ojtP9YG8EVNIObVSTJHNw/y0SPU?=
 =?us-ascii?Q?QI50//WwQCVwyO/2+iLM6r6RkXp+MWcXXVfi4AL6oF7OApK1wCVNUcRnNZ9w?=
 =?us-ascii?Q?tXnvWHrrSwL0Onl0HDnJmw+DygaTXtrZBCE0NOXng8+jRFiOh9xfdfIZs9yE?=
 =?us-ascii?Q?GNsdyxQ7xoDXUJwhKrFoz3MjRA52gw8PBLuL4YrFjg5YOMxaGaki9Zbh7sw/?=
 =?us-ascii?Q?kN8CxlTSYGkylei8dAGVRiYm6SJCVwHOt0oFyye1Ax+4hgprin5Wv0+LIkzS?=
 =?us-ascii?Q?GJmTIrxla0A0lDFtbOYYR1qnwkbiD+W8OHV/t6L0Nr71qWYc28hRKP0fAeQN?=
 =?us-ascii?Q?Jx7V642djRh+43uiocQ8sc95w0rvYWFBtlA9WetCmh/YAOdGMwXXUqmggkj7?=
 =?us-ascii?Q?JvyL6tvAZDv1u64VRygLsYnPr19gpOfl0F060cfYxNeZvMYgzcAPFT3h2One?=
 =?us-ascii?Q?JuXTR4hD07WGU6fRNw9+XKEWlmEM4+rwCMi3VSXdMyvaecAhLEm4y9Z2MIFc?=
 =?us-ascii?Q?94rIRWePKDvp5z39N/D0UvAZUvW5YTegFCmk7x9RkYGP0SvfpqyDLr7QKvUR?=
 =?us-ascii?Q?sOBb/aB7/CzgaIqdcw/q49tGAptY+4kzE9awaeeUtYm+az7+83o6cu1apdvn?=
 =?us-ascii?Q?BBgN6880PJq2+4ou+s9bQ0quEAI3BPTxvLJz2pX7CfIlRwZEw0H0JNLIU2QN?=
 =?us-ascii?Q?4Hz7Pv4JneqpuB8bhKFvnZuM+YXoB+W9EmCTQX2ydIWhhpxsmoKMGZ8mU+vz?=
 =?us-ascii?Q?yU16KP0yxsk/6ToBd3+ibgTFbxXb0xs2U24nC4jrl/ea9eeqekzdId/5J7So?=
 =?us-ascii?Q?Q+kLj/Fk4TxtGmD+qhSo9KITipTIqaxh7piBL0EB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdd3356-dd6c-4f08-3af9-08dbea3d2649
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:54:15.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYLPao7YbX/GtBLF13MfnJOmG/tSL52sqC4Dh6vh8oAc5E0jV0fyIZZmPm7so0e2WNygOQeq9WeuxIkC9nO/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 21, 2023 7:05 AM
>=20
> On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Friday, November 17, 2023 9:18 PM
> > >
> > > This adds the data structure for flushing iotlb for the nested domain
> > > allocated with IOMMU_HWPT_DATA_VTD_S1 type.
> > >
> > > This only supports invalidating IOTLB, but no for device-TLB as devic=
e-TLB
> > > invalidation will be covered automatically in the IOTLB invalidation =
if the
> > > underlying IOMMU driver has enabled ATS for the affected device.
> >
> > "no for device-TLB" is misleading. Here just say that cache invalidatio=
n
> > request applies to both IOTLB and device TLB (if ATS is enabled ...)
>=20
> I think we should forward the ATS invalidation from the guest too?
> That is what ARM and AMD will have to do, can we keep them all
> consistent?
>=20
> I understand Intel keeps track of enough stuff to know what the RIDs
> are, but is it necessary to make it different?
>=20

probably ask the other way. Now intel-iommu driver always flushes
iotlb and device tlb together then is it necessary to separate them
in uAPI for no good (except doubled syscalls)? :)

anyway this is driver specific contract. I don't see a need to keep
it consistent for all.

