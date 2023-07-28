Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC4766909
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 11:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjG1Jha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 05:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjG1Jh3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 05:37:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1449110D2;
        Fri, 28 Jul 2023 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690537048; x=1722073048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lolFefl5CB1q5DPuH8NZho8GrXoTa8LHU3NICdhNC6s=;
  b=lxn/qnVOKLBYU1FKi9JSu6gey3wjwA9EU05Rs2/j+LnKjW/1dWoAo1Zg
   PmSY0Et5V9OF+1KuhEDRL8+9uYJXrP4jRGyHc77gcG9aFbwou8pOY1jXd
   qJpLfKpZDM+H1tSzZTz2DEdedNqrkG0PE97qASOngYJRG1HaUx50Yfigv
   8CfIjvSMvkqFzXnYkrN/FtGNriX7cTvqYOskL7tpsDXMQ7exUoCg7pTmd
   U5cbrSRV/1k8AnQ3xa2hOhG18bvnALWvjCbMZrte5vEUGkkTFGnq8CEdn
   ZP/fTtw1VvVwitpge97nLf9UZ5T+maEzLjBzE62tLZhv/UcPwsfqGwa25
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348154212"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="348154212"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 02:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841249129"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="841249129"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 02:37:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:37:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 02:37:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 02:37:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 02:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ham88E0wQyjphtzezt/B+nOrKzjd5ATT87obALTSGIKThx0ZoE3g2E11PB3CjG/yCUZTrstSCskMIJ1HitM4a7IvMll7qweaZCnKa1Jz1KkhqFYOIrUT3SKWs/9/8oZFLs1dy6Qp7K5WyXFk+BjV5d+n6mHkEGfTPUBcwFM3wUarYtn73nebh9hDD8iiv3rDsPQvyp2Js+Y5jJR0Jc12BOjM42DpVir7crmjvwoTf0KK9tRsgANXP47NUtF5wsYJQVXzt8h2Vq43gH2vgqvLJBgqU2HnjtGQT8tDvBlx6+40Zp5u0P0hHes4GLKC/EYUvlmfedn3xjxPOX0Iw20aSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwGS3mBXHzeSyDdAeUFjjaMnXIAqgys85CNOzpfx4fs=;
 b=GYj5MbOlJSd4lKgncff0tjRowyTJWBwtiM5VPchlNYD8R16EX+sEYhH/1VMOMO46t+eWyVXUgYMPNpTmB7YqzhrpBMzyGrTKfNtY7+Fghh3/gtZF2eUKuRKkYxku5KdDKv9f/fnBKHyrgc81wJbCEAMie8O9o4BjBNSPMHVhVUPVzl4X+EsCgM+GXKKHV2URp5tUZ5DfPifWCfKuFSqJ6EzC/9V97igUn4r2lFCxZBlm1iLulvFA7kaUuTphaf6lsxLL4b5DSpHqYpsKWWrBMDrJAoF1rzzXAFjmy+O99K/tVC1btfv7jAEw38KOJg/FHTRxdfCzM6aHBBXuSzwXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:37:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:37:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Topic: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Thread-Index: AQHZvh6YwXgyoEyAEkGeAK12Y7aYv6/O8T8w
Date:   Fri, 28 Jul 2023 09:37:21 +0000
Message-ID: <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-2-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 96ebbd46-6344-459d-b613-08db8f4e3e4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ge49689Q5C9CX354VOmXOBMglb9qsy++8It1I9ESpekm3qPS8RI5vhAv15yizCa4RlrWhUCcy+3oOj9rUTHHYom+b/5BNQAdTJmF/eEv/wqDu6sgYdZ1gpVFlIPNYuQ4JCV5zzR//EcwGU/dZgkGKr6TPyT/WRDCz2GT3/MWeOmOZtAk7WtP/qv05/p3sicQloufsn2yhhJZwLPeCwurNxb6KkYxl9TAgEwZmpSZ1E8d2dEt52QHRtQib7TXCEcr7S9+Yy+fvyTStFSDXSANcNdHqKKCOjML28Dk976pqI4PkKtmGnnDMyyze3i8k2Q7nwO1lYY2N4Ynhav3tGJ8xY3rN1TMuxQCxsErVs3uuMovj5BwKY9sv/mujOtdt9fV4UWofoJLcoKETf7xUu1XpMqS5+83UQPGXUE7LOChJ9GM4HyqH5lg3ttkK6rbi9me06B6RfsoTLDpqBnVW5QmHpXVKHP3Bu4wjBzZHoc3G+L97jt9izsi1LOQu3gREClj72KeGQOSdAZq8Y2F4qsTuKjuZP4ahz35O4HIYm+thQQVFAbVCIjtl5hAcj88+qii2wIOBbopJu3d+UIbj0pcDMjbvdbVJiKcJbGn1BcHc+03SydwQTgDRKjLU6Vejuy+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(52536014)(5660300002)(4744005)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(110136005)(54906003)(82960400001)(26005)(478600001)(6506007)(186003)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NoDpClOWDtT5bDxO0n5/TiYoyehOhpWbgRwr4s9dlud7+Gcz4ZoLpxbW1T6h?=
 =?us-ascii?Q?k+du677Vnhd9PWS+se5nWzLRN3C0pT1EdZUQ+dpSppmC+v1HR6739PHAzbzA?=
 =?us-ascii?Q?K3m5AS+VaD6pDncYHum9X0xsn3f9DFl9R7PR23my4CpQ/IR7leTPYSmoBuxb?=
 =?us-ascii?Q?p3yNRbjgrs5KmaEyW3oP4gHMDfDeqhfhjVQw60EsbZubLp74rX+Ck6XHchHX?=
 =?us-ascii?Q?zj0vyUggkXmV0dKqHX7DTwb/ZBNCRzYWSJsIfUESo3Zv8hUHHBX9Bj8/fcAS?=
 =?us-ascii?Q?LfUtxApf4EO6Ve9vx5l+61L0VMWJy9Tpxi4ykJhZwOBBs6F0pBUJtKcpCKzg?=
 =?us-ascii?Q?GX3f+VldRMS7hRGcW3BSeXs8DzRd+xbOYjN0Rn8mqmBwxf/6BNQE+ampbQzF?=
 =?us-ascii?Q?T77CBBe0Ri0Sk4zjlGiVqoPlKeZfTiu+zTXKHtm2XUOkyDwMU4VRCj0MgDF+?=
 =?us-ascii?Q?OuHDK/5VWcmhpe7EnGR65Qos3YNKiXnF7EXecm1S4+C/5c3yoVhYb0/EQIWL?=
 =?us-ascii?Q?zzgQLS1RfnFpwSkdExJn86Q6wObNdgRsHJoO6NS+hzYMkC2lJld7do0univC?=
 =?us-ascii?Q?27veHClj6OjwTx5+lxdD1+kL1Lbk5i4Ou71zQsJBDHwIrrJQyT5tils4QuSO?=
 =?us-ascii?Q?RLyQ1ufKf0IxOpVkDSjWTlvQWuFJcgpvs93U8ZRiTXVQtR+69FlWcEnHluZs?=
 =?us-ascii?Q?utjYAmfEH7amU2Y9yQk64s00YwIzsccLSUNIlaU0zGOI/eDQVW5F2HiKzbyU?=
 =?us-ascii?Q?iagROIZh+w9lipBMGWKsx0XvplC1Yu24nV7nHViIoIO3CWfNMFiKWzOTxcFY?=
 =?us-ascii?Q?nzZR+jbTUB08SCmPsV7Aerf6qb2Pz0wwK5FuqPgpwtAIXqGY8vmO6Hsvg1/t?=
 =?us-ascii?Q?1bG5ZgD5guPexTMgzBFeISA39P/m7T0N+RwP40OBtyb+bdztKUYscEKDpqKa?=
 =?us-ascii?Q?er1EhoaIfTZ++7OWF4j0rgIplj/GnRNKVNyxGhcguz4jKehK5P2tLd0WhA2i?=
 =?us-ascii?Q?9nxYdaN9NeF5pGZt7larFcBy7LEUqaWBGft0ktC70IWkgEw58HPpIZz41y3I?=
 =?us-ascii?Q?A2CqMXEMYD+fo0yI08DzVfKqxl1EjS7ij1QWrAzCXwMuBuwxpsHNgixyQUNp?=
 =?us-ascii?Q?3Ud4sC4fNxIO6+6eGw/eQht1kpToYNwDx2L/vLYrFcA0wjqWZvYdadFDt2qX?=
 =?us-ascii?Q?p9RrrNOjLTDM+mbTmexp9o3N5kX1VoOWD1dp2emm1sW6t/yGgj20n6y4g1y2?=
 =?us-ascii?Q?tiEzENsHDThFihpReKM3RcV78o8hO4j77z+2sJtl3Sfu0gUpqq4lgRH32dTC?=
 =?us-ascii?Q?U5rTIuj8IM9Ro8eXBXVhtiKAucy8OR11PloWxBUjkkLinMWvW7JNPtAGMksO?=
 =?us-ascii?Q?QYOElOjAyp7AZaRzN3oaFl1NmPEMb3pKTDyy0YtnbSMwLquF459fbASz1HAu?=
 =?us-ascii?Q?ltl+FT4OgTnUmocCxsROUQFdjsqoOpBHRsNfaIKDBwLFQa5ramNyBeF20sJ7?=
 =?us-ascii?Q?/vjLx1S23+POMWQ1K+yx616mPSawnDVS2bG2WajYGbT0CdNB3m4vmjNAHNBc?=
 =?us-ascii?Q?Z1bbSKFdOrqm0Pidg0/KD2mxtEleIIWs7qfsG+7a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ebbd46-6344-459d-b613-08db8f4e3e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:37:21.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNEwhiB9ry5cPpbC1tD+/GB0SP0LaiY/e7ktdoPMiKb5CEY6RhPndaV6TDM4dxfje5QxBK+DQW50fGvAmPBuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>
> + * @domain_alloc_user: allocate a user iommu domain corresponding to
> the input
> + *                     @hwpt_type that is defined as enum iommu_hwpt_typ=
e in the
> + *                     include/uapi/linux/iommufd.h. A returning domain =
will be
> + *                     set to an IOMMU_DOMAIN_NESTED type, upon valid
> @user_data
> + *                     and @parent that is a kernel-managed domain. Othe=
rwise,
> + *                     it will be set to an IOMMU_DOMAIN_UNMANAGED type.
> Return
> + *                     ERR_PTR on allocation failure.

"If @user_data is valid and @parent points to a kernel-managed domain,
the returning domain is set to IOMMU_DOMAIN_NESTED type. Otherwise
it is set to IOMMU_DOMAIN_UNMANAGED type."

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
