Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083AD7669D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 12:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjG1KIR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 06:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjG1KIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 06:08:04 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36F187;
        Fri, 28 Jul 2023 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690538883; x=1722074883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=68T8Y7O+zbfh8zVzWlFvisQisqbE0AzMA58joMbYgfo=;
  b=jKE/rcUNyki8Ny2bDsg9RXOJiv7Dqfd3s1CT1TdgkPTz0LZ9FGb5chvV
   5p0hqcGLOiSzjqEUiREc3KUloFFZZuz+osgjF3yBNUXof8rPYob1fO8kG
   Fb+BLRuKg+UYfN3a2TQHNBydT+q/wAxytqTirCbnwuOU/cWI2gvqo+FE0
   0vuHRtqGexQzhKtH702D8FlssXrezvXdCwZIlO+BsuKscoNF+vtXqTlz9
   2fpHrGz+AucK+vmfOE4n9zAlrODg5dUpNBUv+qFAkgNzTaUZzDMYmjWmX
   edQi6Jl5L97q/bOtZvmZzkVPRjcTji4MhyeH94OPrDMPbakCS7jGhjtGn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372175675"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372175675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 03:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757115804"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="757115804"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 03:08:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 03:08:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 03:08:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 03:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfXadU87WBdWUNtrDsKZsfucxorx87C7N893C4MR7yBikCoJB9HBI1ZWGEIGpapo/kttBpPg2RGt1SpWTdvMGCTOweEr7pxxDpqYQ7XDqwxKuG1WRHDKvKOBOR77t6HIbaAV9PN/r9SCVH4XcMpv2dnpfQUkKdEBjGFFGyD+pBXxJYdQiMq4qfjDSpF/SxyxWHGLP9yyTWpoo27C5f2f7C8jEGK51iMO5/FyG0Zuw5bAtByNnirRqsTPMomGFcg4QYXPREq/dZnk9SW8Byt62IhLMozPW5WswikXQWnp70p7MyCXQUU9nu75GrOufmIRWwn6Iek9/nZcrxm8ebTQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68T8Y7O+zbfh8zVzWlFvisQisqbE0AzMA58joMbYgfo=;
 b=OKxcIOZnsDLO7M8reqqBLfr5i1kMEa70zGIgbsVaTYmFHKB932JBU3Wwt3aJa372sxNC8sBO7jXOMRb0CMh5jXSGw40mMPPFv1SR/Qlg+T6R8syCzaAh1FFxF1ph35t+Nsqv9yuq+gCTYJkZif2tsGTjCXfL7YFH22QGqF8gFp91SNMP+OGUWbcS3Bt7xKnGzIVxxXVaNW5nfEwf8B1qQnJ+F/r9r7QsDusvO7FtWZVoMINgaINt179RRQi9FKJx2RQew858/RMSuBsuAI0UmW0Tc3MWfW5L91HRgmgoOM7Prglr/kwo4TrUP5BXc52bzbbh0FX43QOgtHyXsyz/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 10:08:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:07:59 +0000
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
Thread-Index: AQHZvh6fEWZc+XbqW0m1tuFmM2sktq/O+arA
Date:   Fri, 28 Jul 2023 10:07:58 +0000
Message-ID: <BN9PR11MB5276AAD6B3785DC247E4F35F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
In-Reply-To: <20230724110406.107212-8-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5968:EE_
x-ms-office365-filtering-correlation-id: 89e23e03-5e17-441f-f5ba-08db8f528555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AKMwy1R+EigzN283u5SM3HrUZBTTOjwXS7biCs8g8Mklem5mM57Q8uaon135Ng4m05k351iFDK7Ea2FWlNUp4vG8AEHT19Aqh3/e1go292jBIluNw714UTWwcyLmKi/f2KJZcePY+j12Uv+JUCLSfXInItwHQAWAgrdJZTCSpQtYlx6tOEBvfnCcTUG+gGma1WYW26hd+4O1HjFXi5BInK7vTV+f2NUu+TtFUxStY+gFwI3/RRLDebSREnwI6M+qQxyq7D5cxl6Uea5ifEwZh8jQBQJgzdIESnaW+jLEuKlVVuXOnfdNPlDhuldL14FZ7350uD6jwpsLFj1Ou7pkbK2evA4jl188L3SUfVmQXtMpQI9AC/FopuIqJfuBYvGbDmcKNHOxv1fu+EgDMNmB622wU0zrkO1Bb5j/JYNixR1OZizc7YVhwaieWu//UE55vB3DxGn2RRj999l6EyTjV8WqOpOIgL+UBLIdvFmIH/D2LrCQ6IK5BfN7HWhkJa17vjpv1LelXz07hIBCucoqKMF5tZVBEZPNRsPdeVY+Xd5IQ4Z9hvWL4w2kyIQkbqNHm3vQ9zqTwJ3aigRYEToSOhfIfxGpjpLKTyGb339OlfGwuuHEyyGHEBIK1UUYsUlS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199021)(110136005)(7696005)(54906003)(9686003)(26005)(478600001)(55016003)(38070700005)(86362001)(33656002)(2906002)(4744005)(66476007)(66556008)(66446008)(186003)(6506007)(8936002)(71200400001)(64756008)(122000001)(82960400001)(38100700002)(4326008)(76116006)(8676002)(52536014)(66946007)(41300700001)(316002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vZ4MB5vLnb8YzTd0XW3U6yjzDSi2iVfQAmBp2Hi6lSMZIc/bx0iBkNfH6iNk?=
 =?us-ascii?Q?PHl6Si9SWvzpdv4j3nmTYXUhNIBdXnM5c9Hip897KpZpoZu15Y024la7UZ7G?=
 =?us-ascii?Q?9p1kLJdkiIbSJz0yePhk0zMTIJQtyG9dKYFnB2mJA1479Qm3jZXTAst58Kbl?=
 =?us-ascii?Q?6TG9EU7HCjaPULXKOjJuk452ZyTK+szSHa36tatlAcNhTg7IK9nbJFT1wCnA?=
 =?us-ascii?Q?kfy/Qt8fIFMZo2BktROnyqo78nj9Rrg8+UnQFcOEp9jdbknZYYQJJJH885AV?=
 =?us-ascii?Q?Eh/kV/bRlAxBlgWTR3vVUgZ6PKzPW7zM7DsLITnSN0YdIaMG5NR9LbLeWM1z?=
 =?us-ascii?Q?wt/YX7NzDVutbCXWn2ciegpACQ3BBTEYoE54obf+QmMF7u1FBDjX6MfhP9xM?=
 =?us-ascii?Q?5WI1NG0eHO+AHGzv2W+XkcokOCCrIsr3hQe6vJRrWls2+c0SYjd2e+2jvCzK?=
 =?us-ascii?Q?5d9Xq42vKJSc1V5eBJ0V12Bpx0OayVE6CzERtpXSQtzA/+I2kXf9qJvFStUn?=
 =?us-ascii?Q?hcXscA4XbID5QrDmmTio/zzJSl8zJH+0N6yx5bdDvtroXhnXo71RvOEw00kZ?=
 =?us-ascii?Q?9wCzwglfD76Lqw0xvPViBDIJvzX9DyVJMlaT+DAzoDWSY/nMuUi8n5tU4ETd?=
 =?us-ascii?Q?QrcpYA05N+q02UQXMcbHMCkAYQdzVGU4igbEC2iFc+2YozqaJlr7t6IW0l53?=
 =?us-ascii?Q?mB3FwuqELhV4OgBEgRhhbVxefGHslBMFd2XZtouOAt0D0eEgcgkrPPN6DFXT?=
 =?us-ascii?Q?ScZih7EXxsEXfq3q0FsMHtJw6tQf9SaaRU6+PoAJxyyvU4sWovaHm5HSSAsT?=
 =?us-ascii?Q?s6lD+Jki/qyvD4QO+AbvjLkNutwnG7xe86RYGXQEGn3c6/MQ9UdSjZb0cDMg?=
 =?us-ascii?Q?mLrgE4Z1j2D056wZn+Lhl1YwDNvZdJ+QDqKqu+W1B3D1SsQNxxKjDD9sUdWU?=
 =?us-ascii?Q?/m21ZyPAk3BpkJyS6RaSxhCkt1k8tFr/QLn+JqLubkpeo9POektDScs/huRA?=
 =?us-ascii?Q?aa+tpKXVJl7+zMsjtCbtJtFINe8d3rh+WieZB32Gqp5xbwfAMPwIQtS+QfYw?=
 =?us-ascii?Q?ckSGYHJmdnwX61/MNQ+I8Yx6J5cBwg29KZgmOZiNMwV5A/xsSSKMv9PQ2Dli?=
 =?us-ascii?Q?ba2Os0v2X3V5kZQ7NX01gJRMtgFL/dHhZET31zhE8996EJiC10vtiomhiLBH?=
 =?us-ascii?Q?BaRNg0zejYtPEjsLogSDkT+7UW9e00O1hWW4LILi/ccz6/Xe0Zj91P88F8UH?=
 =?us-ascii?Q?3RO8f3auMeSVvHYg7c2ZBVEHxUvHYQnB/tamKHniHPrgvjkubCbj3FBENt8E?=
 =?us-ascii?Q?5HboIs6Yb3kitSGYOQHJhZdqaU5kW6vJBYCUXBxqcohd69xFESbjfoV5ukQl?=
 =?us-ascii?Q?Id8PvaQHfRJZl6vyANf50W9MtRBcfuiHAznb2oZv0GxHzuT94B6AHHTnZVgV?=
 =?us-ascii?Q?khWZdodRnDv7sOTND8jv3cbEXyiEgwxgUo0GSoQyB/0frHTcHiBLqFqvZqnZ?=
 =?us-ascii?Q?lVPMmFbKKK408M9hBvsWVH6DkGAS+thX22qko9iqkRJiFE3y018IlvyOazcS?=
 =?us-ascii?Q?HvUQhpJ4oD24tPqv6a0eWcNuPsesmZ3yqMe/+89F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e23e03-5e17-441f-f5ba-08db8f528555
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 10:07:58.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SfdPZNXSzAjxdBlV2/ExV3yK0MlVwJ1VfKHZA/3k9AAA8vp2ndeTSZXT2SwPbhSnymnscIlsgiwtqplHeQAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Monday, July 24, 2023 7:04 PM
>=20
> This reports device's reserved IOVA regions to userspace. This is needed
> in the nested translation as userspace owns stage-1 HWPT, and userspace
> needs to exclude the reserved IOVA regions in the stage-1 HWPT hence
> exclude
> them in the device's DMA address space.
>=20
> This can also be used to figure out allowed IOVAs of an IOAS.

We may need a special type to mark SW_MSI since it requires identity
mapping in stage-1 instead of being reserved.

