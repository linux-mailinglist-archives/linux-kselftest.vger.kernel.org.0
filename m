Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577F7AFD9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjI0IIG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjI0IIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 04:08:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D14B3;
        Wed, 27 Sep 2023 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695802083; x=1727338083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rih9x4uKO7X2zbzxbyVhACcK28Wg1CQcOLHs6un1tZQ=;
  b=WKakc0e21qs+7FAedQHma5rRWU+CHExKDRw2v1Vrby17B7S3Ys8PVJDB
   mSeOyAOxKEIBgwiedE20B+fjl1KBTs9R/6PuiqirE+Qv4CftOIDw5FgOG
   1e++WbgP7UNlhP8I35TMU05NRRb8Wf6aJXLg8D9ql7GEGnZdn+HRU4cBx
   eRr48TYlVMrOEjM2NIoyQpuW/Sl9cN7r/aYUGyN19ijebTGe/DR9AXDLv
   C6cPyaN2YjID9h+aKITue8VM2/s+Hu2Jm3e3/wun6Cb5Q5oVvbnKe+GJy
   mMBp36Izlx9KkUHqxQeBuVUW8lYLD3QQfBCf1M1pHaPAVNGvQWTmUmFBN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385616476"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385616476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="839340385"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="839340385"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:07:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:07:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:07:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hht6u43fmjE3Ukcel3XUNYIkXJ5FnbbmZZUXPsYz5hYm2HbqT0a+ccMrQGbwaEPC0+1x2fBWpG67TcPM6nuVi+JVwsP9rRsDRZ21c+rKhmuPe10Gvopk3GOQw6C6PxL5QJgM+D0GHzu/7S8q13w8z6fN7ail7Ppin3KwEn7vi4FOdowOZ6AmOhLwp2TsaI+DHOz5bhNVr93OAlse7cnmzJNSVPAvrcGlfVey5aCPc3c+n6l+Y9QuvDoRF8JGwXk1zMQK+fF3wchBkBhLYcahXV+YFkfwS2kwLiR8t4bsG+hEpDRuRah7c2esicNQX42voQwNuJSsADlJWzgLYCZh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Kcg7mH4NG04NJ+nF+3+GE2tKiS35+QSsncIBOCiKIk=;
 b=WYTQfckU66RX01Q/Gg03QQoDvDnUb4uE0LE4VI9xn5qLYQqS0N6msXqqUHHhK9Wt4gs95GuCvX95pm87IyAh4w72cp9uxPgR7bZOCCCri9N6XBzRqh+3I05yuzK2jYRGLXwkCJZofP+IGJDaDUnUYWdLdw+L3LOHH+IqXnLNzpGL+lyZXVF8BPpyitqPLtARUYWcVBJsVfoXbysiLgw5V75aZoTGlxOcw1g7WKU9AvWse6bkThBTcwGJmENA86I0/00d3H4b3B1D2IHSOMZc8oSV7YVnEcyY2LkygZhswBsooxuBPs/RbHrG3WM3iHDEoQmF5IgKAwgH35EFId4zbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 08:07:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 08:07:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Thread-Topic: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Thread-Index: AQHZ8FxBOJ6q7SodUkevUoT08ZF/YrAuTq0g
Date:   Wed, 27 Sep 2023 08:07:54 +0000
Message-ID: <BN9PR11MB5276375C4BE33AC0632321A68CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
 <20230926093121.18676-4-yi.l.liu@intel.com>
In-Reply-To: <20230926093121.18676-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4518:EE_
x-ms-office365-filtering-correlation-id: 68febf0f-db79-48b4-7b29-08dbbf30da8b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVn1PvPh894LNAp0E6VlqvBTOhf77OTHg5jQLrRCkti4UJZELp0hfchcarja/2664By4gbG9c6iw0vuS71yhJf5XtGgvyRHWLR4xEVv3mGoHV9Ns5aKVfFLukKMaWfNrZS7dD96hlggWa0g391vFhmMmPTkHfc7HKTtgvYlycrxnjMrspnR/znX86RZETl6GYDRFJJsfSdEX0mX6jb40eenpBqPHBrFYbqI9nKJvJEaDTl0wn6touPnUfO2FUNBl74VVWfDZkrRfQ5FqXSE54elXW5sVGnsIcs68hy/9blXjP45kpDnJD7sc3veX1doNUKQ2bjkK0PL+cBfjP9COKloKoUz39vR95sDOwkPfPzar/ZIWH2Da8tnKXFaFA0zpwnQORjZri7lVkGPH3HhlHb4GaAf9jn3LKkOtO8K3FlEahBxPmWobc9YZKkMfl6gInOCNcGiQdhMm9o/lXIXhYdOLXfdh01tZ8KmVXZSHrtjj/mFjOnP+1SR6BAV/dHx6rdgOIu/q+JkJuT3Tl+uc/Tbf+sK25C4pLUYSbO7vYRmjNgZvih1mkbG47CyEDLbMFolvDR8sXd7sttSrGJlv7SnmikkVn1uFRpYIEZzNtkPIwfTiI5xlYih8M32/mqCYuUiso4027kP/ZF3FJNyGXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(66946007)(7696005)(26005)(6506007)(9686003)(82960400001)(38100700002)(86362001)(38070700005)(55016003)(33656002)(122000001)(41300700001)(316002)(8676002)(8936002)(4326008)(66556008)(66446008)(66476007)(54906003)(5660300002)(110136005)(52536014)(76116006)(7416002)(2906002)(64756008)(45080400002)(71200400001)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dho1NIsZ4hPazxZNzxDxlky3M5zPzyuTX6al1/aGgcAlmyMHhOnwNwq9kwwR?=
 =?us-ascii?Q?/3umITh7ZH2xwRG6MCTcmZOvB1uQpfU8LkwpTOf3U+jYPeqJNtUlGA86YFME?=
 =?us-ascii?Q?slG23MwjrZYTlvrYn8wa92/aLF7siDzqGjjvV2Ty9ty3Xd79uoK3ZVY7MkdW?=
 =?us-ascii?Q?ThLFRAlZ5HMilfxX2nnSBzlHMmWQitrJ2TLXylI6kx3aBc3Za9PnvLhW8IV4?=
 =?us-ascii?Q?ZVDaPyiLMT5OfuX5ZMVbHOM0dOIFQI3/Ezb8XKENx/9k07cQrSldx4/JEJyP?=
 =?us-ascii?Q?PRaj+M1Qguy84CL/S23FqZAgEQM+wD512aMhlG2lOLS7bTEef4G7M41IvSMr?=
 =?us-ascii?Q?sNzCgn5t3vchS4/jjzgAgTLomYGVLBsUx2NfgA/pLY2di0CkcUU9V4Ci5QN5?=
 =?us-ascii?Q?0Lw0yeupctckJejFbAEmE8TL3o1RFZwRcN/1/i67zuENlOrIudGe7kHn0IZm?=
 =?us-ascii?Q?MqWHeGnuWRUv67/udeQ1/DkEBzN7CD2i4B+yzEc4Cy/suP6CR8mk6lp2WFRp?=
 =?us-ascii?Q?uffXRDOzCCkwXLb0KanXVT65+wAALR/SJSesTTmop3f+DP6fKTCNkKfiC8tK?=
 =?us-ascii?Q?tzG2Wm3c+M4F4AM8avFZR81fbnhQxp886EkdY+NleZk/u+0+Nn/V8SUmKNV6?=
 =?us-ascii?Q?W6T5DzJZxsfpLE5G5ixO5Geeq9O4CAGTsSh9stXTZVtlrpXQQsxWsOLby1hm?=
 =?us-ascii?Q?sMHobHVhYITijSs2SqDADiXpjIWvuJ4AW9cDUOiAGXo1oNtSnuwI/9LUOMFJ?=
 =?us-ascii?Q?ukLR72RV6IzTlzcTPoVyv0I6XoQ0VdPQEl56m9yV9FD0XmmaP/vbFFacxy7e?=
 =?us-ascii?Q?dytQk1dsCpYkUbWQOahIrzBSPCJrMdnSfCwf8XxtuhDMUm4HyPC4NkvRKUMO?=
 =?us-ascii?Q?FY9D1UnalfCxAK/gBqPxgkNu+SYwyOmJJNQAjvqgSsPX/2/hqtufXAgKHe1x?=
 =?us-ascii?Q?O1uCOiZvIlmROFKJyGjil9Pgc/EO4gKGvI8rr89LoivLY4sCVx92ZEIPul1j?=
 =?us-ascii?Q?IZ3S7UyZcBAgdNvRE0D8/NFKzxHeZGSsVeN+Wst2I0DKlHzSF/QBLY/H9K0v?=
 =?us-ascii?Q?a4Hq5v3L/9ojBoQsotmzmfSrjhN3wxqQoQu3ic3gH4t464n3IMwjilVQg4GC?=
 =?us-ascii?Q?//B+MdFn4myNfcBGYdPIhqFJ9wcbUy4tFI8fJAugfz6ugz6iTmBQaIn62+sI?=
 =?us-ascii?Q?QQLNLEAK8Iz9oU4o3KYGef1V4fW9712FhidRi9m/VFmITD1SE9pkRadWnl1A?=
 =?us-ascii?Q?u69Fqv2drDhW+ZfQzDqwou8GLtefKxiphFAi3ltCH/rM07lu8h0Mx6QRpevj?=
 =?us-ascii?Q?f/ClrBSvqgSanumVr7Cso6sZzwvTBm6BtMto72VxK8sNM7No3AmHIwrHiiv3?=
 =?us-ascii?Q?d/j1MITg7x2W32cPylxceLe9THQrEYr4Z6a3gDOlQRCedJuM/FMQW5QMvRVh?=
 =?us-ascii?Q?gz4zcMIYlOdht0SeJ+Vl+MJWET6b0JVcYpDWpbtcmhOH5H6x6ogEuSslIK1F?=
 =?us-ascii?Q?UqycnIGwMCYTLDzf67VuHSrCGT+eX6Kdw7zen8qMVHIqrDAxKJBgI02vFoue?=
 =?us-ascii?Q?Iy4cptq+Qt+uS3U82+UuewSC6Nk0yGtn6hYpxGMQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68febf0f-db79-48b4-7b29-08dbbf30da8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 08:07:54.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJ6ES+5pzmIuCW9yKAx79nijgnU/NYq/p4udPCScdXKWHXevTkpORB0QIiniaiwmJJZ8D2dwOO5BLDdvLUp7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Tuesday, September 26, 2023 5:31 PM
>=20
> This exposes PCIe PASID capability to userspace and where to emulate this
> capability if wants to further expose it to VM.
>=20
> And this only exposes PASID capability for devices which has PCIe PASID
> extended struture in its configuration space. While for VFs, userspace
> is still unable to see this capability as SR-IOV spec forbides VF to
> implement PASID capability extended structure. It is a TODO in future.
> Related discussion can be found in below links:
>=20
> https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/
> https://lore.kernel.org/kvm/BL1PR11MB5271A60035EF591A5BE8AC878C01A
> @BL1PR11MB5271.namprd11.prod.outlook.com/
>=20

Yes, we need a decision for VF case.

If the consensus is to continue exposing the PASID capability in vfio-pci
config space by developing a kernel quirk mechanism to find offset for
VF, then this patch for PF is orthogonal to that VF work and can go as it i=
s.

But if the decision is to have a device feature for the user to enumerate
the vPASID capability and let the VMM take care of finding the vPASID
cap offset, then better we start doing that for PF too since it's not good
to have two enumeration interfaces for PF/VF respectively.

My preference is via device feature given Qemu already includes lots of
quirks for vfio-pci devices. Another reason is that when supporting vPASID
with SIOV there are some arch constraints which the driver needs to
report to the user to follow (e.g.  don't assign ENQCMD-capable sibling
vdev's to a same guest, etc.). A device feature interface can better
encapsulate everything related to vPASID in one place.

Thanks
Kevin
