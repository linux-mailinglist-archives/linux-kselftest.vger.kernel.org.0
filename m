Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167576A718
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 04:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHAClA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjHACk6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 22:40:58 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC71BFD;
        Mon, 31 Jul 2023 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690857652; x=1722393652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w6JFJhLsTUFsQChv+ZUpcLm85e2feWLHrNbyXbZlzh4=;
  b=fuSUBCe37KVM9sk0zQxcarlK24ui97XFtinLbEX5fBjw9PGVVnJwnkGe
   gAJSxpFMhcxBa1cX8oEwUVRORioUs2ThdQYM4oUM6eEMHHPb43ExlgAM0
   Qb5mHqB5v/YHQDr075kJv6/HJzFSdFsI+JT6qIB96nFsc0bNxCHcYa3gH
   cNSUm7I8UI9IxKgrswC31Cgu4C3LA+AzMp/3Z703B0fctvkJj0qZ2fyFb
   Lcm2cdErJjwFQ5dflXjJXUAf9hAcL85Rl3K2B/UOyeE0eyU9ZlVdhYxcU
   SuGVDT2NDjwf+2gfCbjRtROQsF9B1YEQcOPNKLBy7uf8Tb8vrN1LRtPck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354106275"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="354106275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 19:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="793964270"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="793964270"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2023 19:40:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:40:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 19:40:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 19:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3VR3vpCdevfvkvgNaQvS7mV2IcAufolzj78tW3lDXv7ENYuFbac0ANSeFkYSVfknfk0QNIjc0g8ancSj6E11cEQrdK1VCUsGjkn8ZvlJrKoskMt/hoUMwhH92FiYhzunQyxNzPqfyiQAVZQ2rGXym24OyASZNHIdVt/4IKOmOrUqpSMgAkZMGpB6Lmq16ejEZf43ueYAyhv/fAMuum4QOXbn8ChCoynkgPWf3CoYKbfr1mE1Hy8N7UbtMhaozDcnDMNsxiJ+c47Nh1IGPDTdMlshS/NTYVHeQniSJgiffcZ2Le34T6d8T5TxaF4J49zOyXPbTY24Xqy7iu9niMn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6JFJhLsTUFsQChv+ZUpcLm85e2feWLHrNbyXbZlzh4=;
 b=LI46vtxusRloF/yoD7yRLtS0oS90OxFe5VRDh5mUHC1IDdnfpGCcE4mo9CX5gvB09UK+KkUAX31mDxX3OGp/f0E8XGj9GOe7EXjRtdqeqAFdIFj9qNTr7VMQGmxDmygm85BoYPXpVak2DKnRMK8bD2lEyM6ZNKDs/g2ADGytVKitXxn/ozlViTEv/v5R7/LVB9tnbZRYVzKqmQHmvT7/PfrsbrIwnQQCQZH22YaqCmAGCeqT06wch5pkQTmfyDeHmrQFaLWB/xNqH4uS4E8RXufBjbVNrMEMLefm+9buplDu9dWNRiIh4F+sXaSIHiTYhxM42ihjJOnOOswAmDfSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 02:40:44 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4a3e:51f9:8a29:afe5]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4a3e:51f9:8a29:afe5%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 02:40:44 +0000
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
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/PejEAgAP2ODCAAHfRAIAA3SWA
Date:   Tue, 1 Aug 2023 02:40:44 +0000
Message-ID: <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com> <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
In-Reply-To: <ZMe14r37YkdOKulU@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH0PR11MB4968:EE_
x-ms-office365-filtering-correlation-id: 815c2653-db0c-4dbb-73b1-08db9238b470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEYe6iCm0hMa22gRXCoXqh5jY6/7VKnbTnBbxW5qC4LC8n24xDOmHPaB2mBuTwbLuKGKbvBO9olbP5L4CX9zVDetm1a63DL6WTYhVaQVBR45OSPYyp27AodBCF0Wt0qWNqdbVSDFDXrDeOwkuHkGXv2QvejWtPwYflfaUF3/9WNeGsByLrt/WjFMnJPKCgcK9jaOr5AZlwfnqHJyKW/aEV4GbKC+iXK097wMuaYYJH0n6Q8h2XJhckaPfDjT9BKXZysPHQ95In3OHmcL0gVKEq6AcvDDoYgG6DxEx/+Baa3jAJynEP8Zo7QjE6hs5dw3fTb5IahVFxZL5lNrPMArk9tIIUlQsQT6dvTRpavPSAirv2proEJJdIlaJUm84BFk5zF8ZUQjemKv7dTzVdClLbMeDPtfKTCFnAn4oDlrIQCiLGCKJKsXUV57Bhxs4s/iJn3ZtLN8oFeYK8zSvjff5nLUD8EUwKWnSp10fhWcYEkcbhQj/nuvvWZBhoL8mhMYJ7MsvkZWx1zj19JomQcVEvuLSV11R46qHlDyCjVVrqHf9aTdjgmkdLwLx7LBbsb+ISYO6FONjYA8LqvPuVTNC0xx3aDneYM2SsfmOtw3pdWvBqSKo+cqX9zDjzipsSY5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(4326008)(64756008)(66556008)(41300700001)(8676002)(66946007)(6916009)(8936002)(76116006)(5660300002)(122000001)(82960400001)(52536014)(54906003)(478600001)(316002)(7416002)(66446008)(66476007)(66899021)(2906002)(9686003)(86362001)(71200400001)(7696005)(38070700005)(38100700002)(83380400001)(6506007)(33656002)(55016003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w9VQ8zADXewMPCQ8TeXQvxqDVcmAjYAbkqgVMZcdYcTJc6LmjvUJuAAgy2VH?=
 =?us-ascii?Q?x5+O+P0uZPg89LAeIinNR7h056E6IpCE23ObOkJMScWASlRvEYow9sZlmZck?=
 =?us-ascii?Q?ZqDVmO8u0cQx3LIpNw2ZapxBEY3JqOzACY7cz9twkIcCW2eAxvgkzcdvBxVn?=
 =?us-ascii?Q?I++AjKfXx1w+Cc6HzxolZeaLgm3DkCubjH5126zLE532sVx2fX4IQWkYryds?=
 =?us-ascii?Q?7Sj5I2b+zOfi3mavuN25Roj/pwU+xJGUZ/ZmZZit4dQKS7Ofh0RJaHw4UQVe?=
 =?us-ascii?Q?2JNrUVZHFCiDQhdVANQ1ZTQz6iidno3TXjBT0n0nqPQY/ITtyds+YJN707HE?=
 =?us-ascii?Q?22LE8VtgXRwEM8lP6/6j/e24BPQ5hqfzhYse+NCfnUAjJoN6ag92XFegDu/v?=
 =?us-ascii?Q?UVuh5YEy2uUTocX11Z0iweHU2zSy9cuGnYZ3rVt6mgaovEn6d/7/RoUV5bzW?=
 =?us-ascii?Q?KqOuHMcEyYVcRQtfaThPfvqYmvrYykx0mUvh65brDCQ/crVM/m18uTwP/3Wr?=
 =?us-ascii?Q?CgC4WO8E0fHpnatAEwpnyH9yXq53pKlGHs4Yk0Xr3k/+KJD00dMcoNABKKup?=
 =?us-ascii?Q?5efS28NpbhXqBW+UlZHbuqYY4pRLaci1cd4hdX5zmLzN/FLL/QbxqO3nQg6A?=
 =?us-ascii?Q?DNFXr+3Sk6WrKI4eV+8S+AfidRUsUVXgq9AVTCjNQyynzdSUdUakCTmOpnOA?=
 =?us-ascii?Q?oEoiZQSHLBJxmuC0nLSeRUp6VRoHWSfYPuLmbz2U0rTmlzg+rdNkif/MT/6F?=
 =?us-ascii?Q?XqNJ82Cc94WIveNHJnLue2An64ipyMthgZg8KmtJkUZ0TABxwQ3Q250wroBh?=
 =?us-ascii?Q?IfW88etEVbbqYIImEZ1C01dm6A6WMPo4HYMBEXGSyxGSgU2ybFJyHBBkTSFy?=
 =?us-ascii?Q?fcPikY+P+UEhhhjry42zKKhS5nF3EfZWfpokln3TkqH+U4+e68j5MRNGi4I+?=
 =?us-ascii?Q?uDi2vpixfwHwiypNhRW8pxWZjo37v28d9FslgGbA09tGsKItpCRUW78c1o14?=
 =?us-ascii?Q?0ynTbq0pdT0ffymkbd3q6i8a/yQ5p/Rp0P6ZlI20+Z2rBN58tRCIGIfWGzIf?=
 =?us-ascii?Q?m9gqTWT8EEfVGB5cxF2r6PPGifccTTTx9yG2RyxgWymHlL9FMNeHRbuQu9pK?=
 =?us-ascii?Q?8DV48gMbzV6VIUNaW47TlmSf9W89t+WPeCQbpmufT342l7JhazakK8LzVu3/?=
 =?us-ascii?Q?sHd714nkdCv33omRtU0iqNMYbfR3TAhFITbgpR21s85oTx88v9wHF80Sprxf?=
 =?us-ascii?Q?lwcPFnqILJTwENHYy8H2m7Y9PptglvrUZB/ImN6+DOUPzgz4WnWpypzaU5zO?=
 =?us-ascii?Q?uAN0ZGH6JWfqVwJdGrHzgnXAcCVbKpiOV3bSdV0ueDCB6+DJHQ7R2JaJQze8?=
 =?us-ascii?Q?MkCMeAjWvyWkLp4VZK6TaB6fWKmNKKkG+NBQV8Qfwak/Xfxv5K9mPU5oHeJT?=
 =?us-ascii?Q?q4Gop3OuiqGJE56EfyUOVGpaIQfhcXZU3TTPIVKK6hH4Tl70WsxbHv4JFj7v?=
 =?us-ascii?Q?2e/dMiqSyE5SlzUwrZVisrCqDP+UViV4JN1tUcYl2v6f5owRqjosQR1o/9vb?=
 =?us-ascii?Q?67LxMk5KvbUq0Q3k6Fs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815c2653-db0c-4dbb-73b1-08db9238b470
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 02:40:44.5801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpbQfjCYHNXZHUVc+uSRbf1lbV0/Qn3UpjvdVOmyIoHldOU1a6DDVGkO0p+GnBrTobEvA7DKLagkwPwsQSOxAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, July 31, 2023 9:24 PM
>=20
> On Mon, Jul 31, 2023 at 06:21:44AM +0000, Tian, Kevin wrote:
>=20
> > > As it is, userspace will have to aggregate the list, sort it, merge
> > > adjacent overlapping reserved ranges then invert the list to get an
> > > allowed list. This is not entirely simple..
> > >
> > > Did you already write an algorithm to do this in qemu someplace?
> >
> > Qemu is optional to aggregate it for S2 given IOMMU_IOAS_IOVA_RANGES
> > is still being used. If the only purpose of using this new cmd is to re=
port
> > per-device reserved ranges to the guest then aggregation is not require=
d.
>=20
> I don't think it is entirely optional.. If qmeu doesn't track this,
> then it will have failures when attaching the S2 to the device. It
> needs to make sure it punches the right holes in the guest memory map
> to be compatible with the VFIO HW.
>=20
> I suppose in reality the reserved regions are fairly predictable and
> probably always match the existing qemu memory map so you can ignore
> this and still work.
>=20
> Plus most qemu cases don't deal with hotplug so you can build up the
> identity ioas with all the devices and then use IOMMU_IOAS_IOVA_RANGES
> as you say and still work.
>=20
> > Arguably IOMMU_IOAS_IOVA_RANGES becomes redundant with this
> > new cmd. But it's already there and as you said it's actually more
> > convenient to be used if the user doesn't care about per-device
> > reserved ranges...
>=20
> Yes and yes
>=20
> So, I guess we should leave it like this?
>=20

Yes. Along with this discussion (including what you explained for sw_msi)
let's abandon this new cmd and leave it as today.
