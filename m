Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0852619403
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 11:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiKDKAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKDKAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 06:00:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F22B253;
        Fri,  4 Nov 2022 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667556029; x=1699092029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gQwwB1X1/9G4/YYk46bj7YzOPQSmB5R7/HHWoyPMHxg=;
  b=UtZXALTMPwI01W3yNKJMYLEleNyJMlg4UPvpJglr0pwP7bb7MOdfj5Io
   kGzJOlgp3vtHR0gWR2xlC3yvsxOZRAL1dMrFmHoHOWgMTk2Zizn2RFFTQ
   NVZGUytEfHw2vJmLb4Wk7TOdy2tdl+6fcsKUkYjph1nlhD1S4ujIJziEM
   9buWhQ96wRjUCvcyLFm4LdGRafMwVztflu6DYgvRtZkUCAw+yzTjZsp5K
   LZr+cbR5vqRU6nes0pLnN3/KMHK+N34+qbyeNxITVPIvrgmEk4UIn1WN0
   lC0yep7ecwp9Ye/LPKwVpo9Xf2O4Ki3sAqomo3JY3ceU4OonF+V9nRGJ2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396230674"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="396230674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 03:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="629673077"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="629673077"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2022 03:00:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 03:00:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 03:00:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 03:00:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 03:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRgl9UZP9otpIKwcE8/mgFCceAoJEdlLVgxryjDb9qtXLB2rZvSuK0n/cdC2oVfU8lDdF39pbC715QE3M1amvClot0k5FpQN4rqjtrhbh8N28JY3EnovlQRsz6nyQIBhM9uxPXrFeGN23n97vx+ZVUKtxTJKUUUzUFym6r48bq+bjG0wiQmwKUqIquo6IqBr16bFEoMt1TWQX7zIAmxorDgb1QrcMekUHYjcKVkuTlEB1R9OAJfNIZfm1I4MiLLKO4+0sliAOciCeTEmi1rPPdtZo6RyodX8HZvok3yJuHb7AJNQdFOnEbOIPeZriEo4SbkA1MYiTF4RHkTALBCOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQwwB1X1/9G4/YYk46bj7YzOPQSmB5R7/HHWoyPMHxg=;
 b=LgrLn9Jh8FoWOUIGjadUCINqOjEGMgpX8ZqGgAgnHjZPEfqNexQWda3OTUGATttCV7hC4d3viV/9L+5MqoLUtKx19re0UECEYDpAlifwW2cn5rl7/ahxsAj5x7UYPUte5yLeSeMySKjCCesIdzQ6SvJlJfcz7HF/5S6T9cVymQA87endqgGngfUSmiyBk8zgBG9F8S6U0FRI2PkypB6qvsWO8C2aJDOYnm8o/X3VlSWSrlCzT8uYT/3G/NIK0dMsSnTK3ndsh2f30Fhjp5cg8y4zbqkoJwatsQLa1K3OR20tSJExe9ZRmSC53xSTxzmGa3+1SCeY9Lzy6T8IkAVYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 10:00:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 10:00:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 11/15] iommufd: Add a HW pagetable object
Thread-Topic: [PATCH v3 11/15] iommufd: Add a HW pagetable object
Thread-Index: AQHY6J1wkejA0Ad3VEK0+/DX7xfUhK4uljBA
Date:   Fri, 4 Nov 2022 10:00:23 +0000
Message-ID: <BN9PR11MB52762F734CF358C48FDFCB1C8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <11-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <11-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5863:EE_
x-ms-office365-filtering-correlation-id: 8c026233-2711-45e2-ffef-08dabe4b643e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaLT7W+s/gHqyF5mgiBbbLWNnsTRvI6E8hcZoRqfuIrLlGaHjeSmp4PK1EwDmV0u5aaCVoPGW1q+7m0eLnaSLkp7LB4rwegs/hByNQUK273nBJRpVLzoJRLKy4LEqx0juWs03I+Ne1IRvCdbZkP9Nz98LM3yMNJRM4dzTFF4Wp2yoBDhKm+Z5UjpHP4WiLW1/sS0LYQ2zFxxN+AuZ2cwWh3xUB6NGAgQS2GO+gDi1FDt7PSHB5DnQBpNQmFNJTwNrRzYBljXLtcBoYc/LnrhxZHQr4dgFOfKGFJD3Oc5Z3oUUZOLnrkLMyGBOKYmGwvKgNe69Pdj7TTmsEKkXrJH/NriNFxBBdxH8ohPfGEoo5KkALIVGZvYJIzu5SuwienIdNYJgn64j3AR27Oq0vkIJLU8hC+34e5vVILbPgW3fg3EbiD/Z/ROt+OqZssJeYNGeY/3bJOE21MBuQtc+oh4iZf+vBYWpYYLOTZtnzVuAuBpwKXKcfzOxMTl4HmEzHHMdYssliGZHgI8FPoJY5dZCPu3gQgNXQZHxkvMn0yu0Bi+85Z4jGTGnNKjxIco57+99xXCgA9aTNOeewW7M6Jmp8j6n8ADA1vuTEKCvwLjBsCZyx8XiO9jWdiBnTAThs5yv4U/vbrnuepsvpVi8nO6zYySo3CgLBCL+6qemWwlozICFU0veUX+UYcPR2i3QluMN388YH6ldH62J0SwVswIMxHn9H42VtOYd9fIlqPgx2fVSSwA82BcbM+mKdJ4s5NJc0tfUzunHJyq0ahycxprS5H2b/r90iwt1Jr0LeXgiNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(33656002)(7406005)(7416002)(55016003)(82960400001)(4326008)(8936002)(41300700001)(5660300002)(316002)(52536014)(54906003)(71200400001)(66446008)(7696005)(66476007)(2906002)(64756008)(38070700005)(76116006)(122000001)(38100700002)(6506007)(186003)(110136005)(26005)(66946007)(9686003)(86362001)(921005)(66556008)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a1uGAb0fbnRd/KtMZ6hobw3JX+A3MOUel8Y51edFHIS3yhxLnEPEGySP4Vzn?=
 =?us-ascii?Q?6fLB/vU/p7yZfCTph5rqfOu7nKezshlXLHQBOon/Qz/EJnb4DuQ5IIaNSUEV?=
 =?us-ascii?Q?vpDckZC8iYxrezpe7PiDPZU3GGQb46stY2G3/jBQGDSxB8Zu2bxytt+PZmcJ?=
 =?us-ascii?Q?7z0EzGgvhenpNL08RJp5seM1QAlH13g4kGfPSa6yo+nHCGGCgT9gedlnA/T+?=
 =?us-ascii?Q?rjunRq4FpPoyDwPFSdt0QskpqtzfM7jH9lwo4TRpluE0Qsdyov2WxsMn/VsU?=
 =?us-ascii?Q?ZcFb6gY1Y5a3WuhyvFsXHj90yXVybvq+YpuZaPzKLLU6lzcDufrInsvNWEbj?=
 =?us-ascii?Q?d2ec3pLpe7sQ6JQS2FUdagMRI2mz3rlz8qoGNKvY0LpZ9UlPhhB16rgqU0xC?=
 =?us-ascii?Q?54fwA+XD1drpeb/DM1EquITuqSusAGblA7qiGD/nHU1H3b4iaIXeXVyW/2PQ?=
 =?us-ascii?Q?L3F3xEpdRhBcLK9GWHybgk/8fC9XBgDPMtbgy88gAFwRW9dyaTlrRBYlw42R?=
 =?us-ascii?Q?slV8tMtf6fdoJ2QV4uJZTZ2Ay0rBrMoejX58LUeJ7p4mmZApW0eVfD1erMJr?=
 =?us-ascii?Q?MB9HgQQdbYYLL08VwaxJq0q4Z4tBRt/ZzGwNeBvXQUnXPwyKakRPi7tNMeHX?=
 =?us-ascii?Q?wqcpy88I/OLeVzxtVELJJjgGBjRkdlAcz1WTlu05k9qTfa2Jw9dMpsW1qRbX?=
 =?us-ascii?Q?j21fV2AOcwR4w+zcfsXuVejP2wGoXrlYgu8IVaJDEEI+5tbv6w5eh1vl3nE1?=
 =?us-ascii?Q?SyI+cdmVghH0B/WDuXa5IHZAspt8oCOUH4WdHX3ZbWQUuTnP89Bukq9NMEQE?=
 =?us-ascii?Q?7MGdOeRSWKwZnIrBTe4JyNola2DBPlccVNJkWK5RK5bi7zikpMEPV8tehOMf?=
 =?us-ascii?Q?hg9LZf/01qhz6VlHPwMFVxFaRtIzNwuBm04HyVtGZ/5GF4Ka7URtNlwGb0cX?=
 =?us-ascii?Q?V9Vfqv1z7J2b1edzXkaPIV5/8yjkq8LlYWrharTGfi9S7CdjktVJ3ucQNYc4?=
 =?us-ascii?Q?TyUVxKRJG3oybNiSzLUG3HLiFvDRCzr7Le9wDsJnd+dlU4TRkM2/Fob0uSDF?=
 =?us-ascii?Q?JoONOLkoponUnBnxgGeocZq1s45L5BNLyvm7xSgTC7pB2PX0TlkDWKssSqKj?=
 =?us-ascii?Q?qfg4DejLCGAOk8gZ3ARRWQBIdTaJzZ/58MbP6fbDFlqHK9po9hoatJspWm39?=
 =?us-ascii?Q?KcQH6g2q7HMf+sLao4oX/Cw/4uaF5951iANdCqZpVvYgkM6p36nGa5X02T83?=
 =?us-ascii?Q?7MzuU/vqwQ4YjvcKstqoU8o9bXOBdkFHBXNCBj9MePGzolXDY5aPqp2bwAZ8?=
 =?us-ascii?Q?sOUVLKWLTu3HeP4abAe2Gh0ZQVwPcO9JNaVzT4EGsVuKDX9LCmGWPwQSfr/b?=
 =?us-ascii?Q?HlAUMDysyn4RP31JN/AbzMDS6f+Ou3BSl5qDAW3bsIr/dt1UH/iijrXJWjUn?=
 =?us-ascii?Q?BeiGb4Cobxd9OlZs2RUu1qul7EvMXmZ5ypCgd2vflfKAP/6/7ChDOVNdWqad?=
 =?us-ascii?Q?CCLxUfzvYcBN23dq1o1+S5e2uZgzplxm8ct3n3J0NIKxxiAbZNCPL+uk4azJ?=
 =?us-ascii?Q?mvmbxkcXGyZ9hY7L728brVxkVO+CNaeCVCafs+3C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c026233-2711-45e2-ffef-08dabe4b643e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 10:00:23.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PO7ZNqkfCPnw51JGV8m0tJU59rKU3B4O+35oBd9hUsv+EiUaRZzQD7Kfy2hzCgpDiSpTpKTwEUdlhej91stmrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> The hw_pagetable object exposes the internal struct iommu_domain's to
> userspace. An iommu_domain is required when any DMA device attaches to
> an
> IOAS to control the io page table through the iommu driver.
>=20
> For compatibility with VFIO the hw_pagetable is automatically created whe=
n
> a DMA device is attached to the IOAS. If a compatible iommu_domain
> already
> exists then the hw_pagetable associated with it is used for the
> attachment.
>=20
> In the initial series there is no iommufd uAPI for the hw_pagetable
> object. The next patch provides driver facing APIs for IO page table
> attachment that allows drivers to accept either an IOAS or a hw_pagetable
> ID and for the driver to return the hw_pagetable ID that was auto-selecte=
d
> from an IOAS. The expectation is the driver will provide uAPI through its
> own FD for attaching its device to iommufd. This allows userspace to lear=
n
> the mapping of devices to iommu_domains and to override the automatic
> attachment.
>=20
> The future HW specific interface will allow userspace to create
> hw_pagetable objects using iommu_domains with IOMMU driver specific
> parameters. This infrastructure will allow linking those domains to IOAS'=
s
> and devices.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
