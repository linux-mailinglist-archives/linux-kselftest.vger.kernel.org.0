Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4D768BBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGaGQQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGaGQO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:16:14 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC01172A;
        Sun, 30 Jul 2023 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690784149; x=1722320149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dj6HSngbO0/mtmHzfAV9RW6pbYVhkSeO7hzVS+Tc8jA=;
  b=GEOpO3jqxdlgcNYk+mV3VeptddswUwJRQbU4Wrtr6HTEP1Ehg/oWYU64
   smvEls1VZ3R54IHNYhr3LnqZLthrSBvUJaxaXSy621ZSmcQNom0JC8eXR
   6M6gVmk1aaoQ4o4Awt4DV8vXD/oYeOzOApORRKtD7ZlSKEHDvUDlckO/K
   DabmG9MpNqLxXR1SUJxIEhltcFuZxateWy5MVKxXJ8fraoWeP+7dRts5U
   OMhP9E4k31Z5PgIVvJdKa7CK99b5JXgwxElEgyGgBUxwMEhGU5jrzol9a
   5ExL2YtwaSeU22KXh+/ITSPHM0w415uBfTM2LgJVnI4UHN66Pz7W8Ku9o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435230831"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435230831"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 23:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="901983934"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="901983934"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2023 23:15:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 23:14:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 23:14:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 23:14:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 23:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjbzCi65e+TUM4jBVqFs9obIqS0maBEVu/ahzFJWV2EjGdEWShR85HKvLphFEe3WzvvowLzvdNa+0xkNFA8RpGxPqDDXtqNn8ERoiSacJ6K2cwb1LDGmGwr3/7n39P/cQcVM711SAh8I7D0jsD9HcRDKIj09P2GKq+7lsV/zRGYEz3d2nidZNR2WdThSNYJphdRXfK2kC1pAxVaQ4odC3zD+NnyFcJfv8PZimFyj+4URspzqCc4XG9wDb/0hve0jY2KGZL+XE4OL4b4BdnB2743mtKNuWSS4ws8rtt1vdwWwinh+KZvGkHbKmUnMrEMBTa1ObWPj5iveWURWC5yQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj6HSngbO0/mtmHzfAV9RW6pbYVhkSeO7hzVS+Tc8jA=;
 b=e4OYJ/GMPB+81RKyB0WZG07kNU9nSyxe9A52keY5bpKSD5Eno/lXTf/sseEORWH5NwngtZnt4Z3Dm0SE6hGfYv5F2emx1QyxKlYH5cBXt3xT2v3RFtC6glNeHZTe8B413hf7fHk0PiOoeiTotKZjiSCi+OV/a0pJawUDQ0+5X9xaXOM3M04IZGO1xi7W4SgwRtB4W9oN3DR4IzfKXopBxVT5YMtLJnlW9Rh/xGv1dNoJeN5HhCAy6tj0Va7YB3DfWCMjmUGzcVVtovbROjLppmN8EP2vyhYsywsNOOjY8EQyFVKqPAeS9S3mm3pBAOGBVhHsMH2k6G7IuOF9JiZO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5666.namprd11.prod.outlook.com (2603:10b6:303:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Mon, 31 Jul
 2023 06:14:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:14:50 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Topic: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/O+arAgAB4sACAA/x0wA==
Date:   Mon, 31 Jul 2023 06:14:50 +0000
Message-ID: <BN9PR11MB527629FFF470804809FFC2FC8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <BN9PR11MB5276AAD6B3785DC247E4F35F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMP4AhdE6RaXXgZH@nvidia.com>
In-Reply-To: <ZMP4AhdE6RaXXgZH@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO6PR11MB5666:EE_
x-ms-office365-filtering-correlation-id: 30c70f63-f790-435d-6453-08db918d72a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZukYT2UN2zf/71uFnIs+rhk3g87k1jVtMC3HLtI0a8RVXUJVSZJh1roDFWNXqIjDN6jIPARETfCvIVXz9U/mfbJYdvl1jZIsb3eMCiW5DuRfLS9mGky0hdlx+b81kbuzHTYrMNc0Xmyu2I0ilXi7qGrndJldjCNoupe/YP/34UBmcgtYCi9HainRFmH1uksqjGy3Gdgz0Bc6a6jjMP6Xcz4mJ/gB/+luuk66q+4paNJ61tGaBzS9YweUsdcOKy+XbS6U9OLM3qICd2kX5UwPs1VPPivfAF+pFlk839vXWuvxmSOOF4BO8BKiFfRKDHmnj/KAggJYYAAMOyWtxoMoZ9ae2Ug2KwoMbLKJ2EAxwrGIA+aHTEEqDlr+8ZWoR/8G7yq/99NmXE+ozwzWLlJof+vx9Kr9qZL3zDtl2pvZ4J/RjCru6xlY5OhsgfxbupKFLjdr3232eW8jn+jPSjAkfFle6Qi5g6KJJmQJj1TljyapW+uauKrnao/kV3cbyfz6eebt4l5hbeqsfIAVw2mHk1EAzrOHaBSksiAlcKqaMYPmQfFFb99F60ij64AyU2tl2723peEpbAS/NF/BCsBrlez5TFPdC/YqRwsZLKEoHvfdGMN4wIpANhmrvJRn5D8u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(26005)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(7416002)(38070700005)(122000001)(54906003)(82960400001)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(6916009)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUWc6gj8xYD8pybzgZ7LTYDaglGt75mlFUM5f87xjHgK08WUU70L3yggex/U?=
 =?us-ascii?Q?ceP3ZjMuVzcnCct1WEiqm3o9aU5UdIE/iy0oCG/ssZqRSzgUDKgedQ1b97Lw?=
 =?us-ascii?Q?3pA92ExjHNBejyAw+EXOX6wsYV9EH3sPmstIbBXWFEHun7HL2RNArubsTdQg?=
 =?us-ascii?Q?uERdR8ijPxuLUPadMkjhaHI7pE9+VMqGlpHNKFJANaxgwtZmRITOwMVFsWm8?=
 =?us-ascii?Q?ltiQvSfoDTAC65jb8bhO2vvIUbTmwFbHLFfo7fGppr/L5+Sawluyxut0qlt0?=
 =?us-ascii?Q?sXioFesySn7zDSTfgKlue0Y0+Zox7lKB8Rv7MsPD8MvR7DoG9MkgzTD+TSYc?=
 =?us-ascii?Q?Nqz/Y+N1zVNFA8m/dBmL8aN73vJhgt3EELTZVGJbAwtzBnhTjIhpEif4DiQJ?=
 =?us-ascii?Q?BBZ6dQPt98ex5K802zWVhhhR0JcB0qTof1fAw/FSWQvMA2mQLiLq7gz2p+M9?=
 =?us-ascii?Q?NSkhcRL9Gam9Pv4u4rL1XWmdwJYKM3ALYKA1kQFK7vixaaGz/XMZ7lHwdRDG?=
 =?us-ascii?Q?IvLbMHpZFB7fTG8qr3uKmsB+y/EEkr3DRF6Ryi9cMiHndTTcCekyeBj0iho6?=
 =?us-ascii?Q?uw8OnU96BKEw/pok4h2zdLWbLXhZsHML9h/rMsmih+LO63REd6ar53YixZBN?=
 =?us-ascii?Q?84c7Qtu5ZjCyv69Zeoo0WDiiIxOJooP0BgE5Ghb+QXST8xtzHj7c17XApVsQ?=
 =?us-ascii?Q?kwcH1CZ7TMtydYZjvP3NoUQ3Elah4RfisBqCSy61FmS7dSqGNeUlj7kCRkJT?=
 =?us-ascii?Q?mekPmZQ38RPm5yzy0ljKSRCIlVPsv9tngPW9s+ymkITyrSFtE6rYqljmezkD?=
 =?us-ascii?Q?xH67UeLmzKAWwXHA9u6Fa+d3xOCH7PS9ZXwNiiv0PpfQOlnfST3clHO8+AN/?=
 =?us-ascii?Q?GlMIoePgDUUOb2bMkgaCTQ8/7JkNxX4QIpCnbC2J8ql19/0A+nR7kJih/FeW?=
 =?us-ascii?Q?X3sfq1HBOkubjSYDSbFUCHtF61U7DkDCFe+XGum66YGH8iFtjigBLBZIAALU?=
 =?us-ascii?Q?rYG3tII59Ouu9XX1ezAmSxOuzO3kYeUT6OwO9o4LigM0hJTy+fKeG5wlTE8F?=
 =?us-ascii?Q?oPLUEFObf80H+AXAQau/IxneEfr9HmQaChFxESp7sH0fG7WXCLe3XXGqa07h?=
 =?us-ascii?Q?MjW2oo5mEwaBR87cQYyldbRamMBg5JnboGLXRIrF3q9iDfEP+Qdp6vSjqCdZ?=
 =?us-ascii?Q?buX8MglugsHzpQSmneVbK1UqzhfC0H8FxaA+xHnSOzH4V6xlst8cTE5tzMZo?=
 =?us-ascii?Q?VeXhoAYu32+MeZsy5HCR+wieArMeLlRisRUWeAQPegteTZ0jt7Y3komPiPjb?=
 =?us-ascii?Q?KUenwcufhPOU6qFYf3TU8pYpVbuq48zrLPXB2B8ABc1owkNnRbxvtTDsBAB1?=
 =?us-ascii?Q?TcUWr0UBmNho73PzA4tDWMgz1fECvPfUPC/k5draZmP9enoYCDDS8RkDGlFd?=
 =?us-ascii?Q?XXVW6xya1av1fgv1E03Q+csNFYQ4HbWT2HFFfrgTopHAtbcRAWPMSv4ejeLy?=
 =?us-ascii?Q?OVGWiCQTQKlJdJ6zOFtSpB0yUcwfUWXaobPW+fHbDsyHZE7gt/YKWOOGCLiL?=
 =?us-ascii?Q?8SzIiro1pm1ZXgtILR1Pbrk0VlgL9Tc7YL3BF4tQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c70f63-f790-435d-6453-08db918d72a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:14:50.2803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3/CvOAjzGhZAqgKQM6eMTww997tR/0yRktY/Gg1/j6Df7mMcaRh6pyVaDd5EUOe/xMEBVtdLaVrIHhfRGvw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5666
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, July 29, 2023 1:17 AM
>=20
> On Fri, Jul 28, 2023 at 10:07:58AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:04 PM
> > >
> > > This reports device's reserved IOVA regions to userspace. This is nee=
ded
> > > in the nested translation as userspace owns stage-1 HWPT, and
> userspace
> > > needs to exclude the reserved IOVA regions in the stage-1 HWPT hence
> > > exclude
> > > them in the device's DMA address space.
> > >
> > > This can also be used to figure out allowed IOVAs of an IOAS.
> >
> > We may need a special type to mark SW_MSI since it requires identity
> > mapping in stage-1 instead of being reserved.
>=20
> Only the kernel can do this, so there is no action for user space to
> take beyond knowing that is is not mappable IOVA.
>=20
> The merit for "SW_MSI" may be to inform the rest of the system about
> the IOVA of the ITS page, but with the current situation that isn't
> required since only the kernel needs that information.

IIUC guest kernel needs to know the "SW_MSI" region and then setup an
1:1 mapping for it in S1.

So Qemu needs to know and pass this information to the guest?

>=20
> I think the long term way forward is to somehow arrange for the SW_MSI
> to not become mapped when creating the parent HWPT and instead cause
> the ITS page to be mapped through some explicit IOCTL.
>=20

yes this is a cleaner approach. Qemu selects the intermediate address of
vITS page and maps it to physical ITS page in S2. Then the guest kernel
just pick whatever "SW_MSI" address in S1 to vITS as it does today on=20
bare metal.
