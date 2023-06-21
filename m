Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA6737AF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFUGCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUGCb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 02:02:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869310DC;
        Tue, 20 Jun 2023 23:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687327349; x=1718863349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7tNLAf7Q99Qa4kFL2rClhYUnLSprJtRWLCjD34U6D6A=;
  b=XVulXM6WfsujqqRWHb/0bQUFRihcIBLAR8LXAL38gLhuXZV9ejuCCYC2
   H4tdBjmPz1lyqh3lAlCxHIQEs0JzUOR1FLXLDTzfhMrLHSewHCT8K4U/M
   vSxCXYgPj54592HGCM9Q/+rfaWOpynP/IGJIKCERoIa+IZs/k9qguNdWL
   K0gd4mJBruF2btO9univ9K+seuqPnEyOW8NksB85BFt/+Zk3ag1Fldtjk
   Q/F3HLlOVsAUTGKFkp4rHO7/1vs7mJvrT75FUzj5mFLM1UUbGsRqetRSk
   h7NtKaD/2lGqHmFHRbHFOSf95a2F6YfcO2lYLO82vNzXH1t6LRXi5rqVz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363497945"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="363497945"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804233071"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="804233071"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 23:02:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:02:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:02:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 23:02:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 23:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auydzovJ9jPePPVQjRc51ScRDg7g08YJeZ751a4qXV2c5YrMG4+CwIWTc1vFU6wnJujePieUDf4ha483beAkqz1Mfh6wKQlQPTOiPEhu4snlMSFDbsFqzKT7tRlDgqLmoGpi4AtE8/C3bb4Zx8UfZg9Z4+Byp+AKetibs4rpKwEZVSDfTDNSMT/hHVigxns/8OSd7/7hC/GC29csCw0S/BcRHpFRshlYJ+9lN1ayVC0Ed8yenm49P1eqQRgsT7douVN+TW2D/ORcS5RvoE0iiXBk2StxMuJpFdFpR7iipqGQTCY8vRlWbkbgWjiTbGBgyJIsUa7ZrX5F3EWL2uU7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNBEr8/HdJR3oUwA9p9B9ce/rK0XXkVMNBx9zKtKzJs=;
 b=EQFtHudAQdAqwD+DeibXCbzQxpvV8/2xUCfjmDKc5I35bBf5uvN3psttxfD/z4GaAgKgGgVSg8l9YPqH8U/jpv0T8nzT9Bzg0Pol9TRjdojYO8g3pTogbOGKdF/R2998PDEI5Ul71P5A+EDPuR0ATmWHpT+prnkIhKfnCBUXyIjlJjOI89vFe8G+4olBo31E5hbrSKqwn+IjiDRNHwWkmwKMHmsnXCBhVW+gMCrxvavtOSiKYlm/K9WgiHfVZYtCFlGb42kMApUWWW9JBswOax0xUh216Ne8KroVP+Uz1aCCzEthVN3eThWPvk2h8BZbdzx66ejAyahNeBmGEnBO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 06:02:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 06:02:21 +0000
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
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAA==
Date:   Wed, 21 Jun 2023 06:02:21 +0000
Message-ID: <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
In-Reply-To: <ZJGf3sgLKr9HLZuE@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5865:EE_
x-ms-office365-filtering-correlation-id: 970d10f8-3bfa-4002-e10c-08db721d13fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3mmB+0Z8sO5H5w2nziOUu623MFEAAhIDSe7ndL/YCsByjjg6ohWiMwvL0pNaUKMVOFumeBROOvMMZ/ldNU1QwpeS589dvOMi9ENTmxX6ey/U1gRxWZJP1gOfKl8Wd8kftCWE8J3EhDK94+7xfC79bgw7r5YmIjaHhh18ZaZtZ+8KGEx1cNYMzPrXTzinmM3GpxnTuU5+26pjOe0UlAmNBKq0ETrFR12pgTQK+A/WJobxjdjSWqgHyoebvqQ2I/FJyirVEMXkc+ss+3MkKBspjI1hOS1QGQ7GsNF+dF7BWsmkI6DbLGv+c3Mkb8vcNFgwWQJeXRIAynI2e6dPwnu2K+9OznAk0oyZ5yo/8CJgHVh9G5H0FrjWcRADBoTTE0gwFA1JXRMAQ3UuicV6TedWre6BdBc4I13LtpwOt0qobPHS0cOWrl2NhPkuA/f3/tX/nzPRJlsGrHy5Y37a51HjOSyknR3f2a0qC8IhVgXxak2RkLYe/j3Ww8ld39msmdTO9uz0RD9y/M3n9lzcOdXKoMh/K3qAbWzL0QybMmudPdvpDDNZ7WSK0Cs/HcRvq3dOSebvmrCT611RSsKnuDVgej9ZoiMppUrJd2tTiAaFN/LfjY7h36Zw6PQXwpF7UuS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(7416002)(52536014)(82960400001)(83380400001)(86362001)(38070700005)(122000001)(2906002)(55016003)(5660300002)(54906003)(76116006)(66476007)(8676002)(8936002)(66446008)(64756008)(66556008)(66946007)(186003)(26005)(478600001)(41300700001)(4326008)(38100700002)(6916009)(9686003)(6506007)(7696005)(316002)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QrcfOR3CEbxcDQbsFJmf8mFve7Yo9UMIupjXH92MbJOTcfAGztYOdnhwIzYx?=
 =?us-ascii?Q?57jxA4WD6CPExV099ihik4MWUKkC+ytcbWrHPCGX/KmPW0NxspNn64nn7MsK?=
 =?us-ascii?Q?4PaewIJE/aie0g/DvTS2ebJkmWR/iMp6GVoVRNjsgwGoOS1rGvT+Wc3NJApm?=
 =?us-ascii?Q?VuNdRb8BSNfUn3ZicZXFlc2kbOISdiig6ZwsIXaj2iKGTZcMyr78E4eLhUnL?=
 =?us-ascii?Q?PNJpAXaUn1XgGL6PJybaGosACPAd6IVFZ+V4Vv1Xyv+Syb9iIL7yCmH+eWNW?=
 =?us-ascii?Q?eazr09PSA89CC2xKV5gOmjUdTVWHPRnHNyXjpMCNSTIG46ZQDHjJOM5yo46/?=
 =?us-ascii?Q?7yGPmGG9Pqx1N81Z27FBfHLq5U6wjZV72PxgF9crO4al4Jt6gYBY836Kd5Ly?=
 =?us-ascii?Q?afx9zDzEcl/da7uTcN/F1/JaW/cUGmzrC8Z0bspiAMWUNM56fjPg4Rvf7bkg?=
 =?us-ascii?Q?2gccdQdahuNSYS5A19bTdlRv31dPod+3cyWPogywPCcF8iVunCqi2HEpEzl/?=
 =?us-ascii?Q?qQ1lYZgM9SNg0YJzBBEWwDEQAdpfZWJUDhOkgTL2LkEJ744fH/Lu1rzOB8N0?=
 =?us-ascii?Q?LLnncGIDDz0Rg+qwI3Je/JCW4fwJr8BuQ84JauFiHX8vLXwzFn5xAHjiGpME?=
 =?us-ascii?Q?qiyNVztn6f4iyixkoAyrCmcRFjaoUEH1rXFi8htpYQc59Gi1vKVAptG129hv?=
 =?us-ascii?Q?y0CPYgcDBZ3GC74Uc0AETdRsLdLYgWjRPFRYPFxQ6igiTbyY1sv2OBL+YhNk?=
 =?us-ascii?Q?E5DjpN+1pip1AcKSBPKNuk8ydRao80X6e2KLA482k01O2M7eNk3dvRx4M3IG?=
 =?us-ascii?Q?ept9Djk2YfCtoQsTSG0r0e+T8tHOnLttfsPhDc3r8b/kzdB4I/MBBuzG05Mv?=
 =?us-ascii?Q?HYpX8WlPnJEmYKjvkWr9GyI7u6ddzfn5ZVocSM2Z5GHqyHOl78/DswRPCJ8e?=
 =?us-ascii?Q?yAUPzTMNRpBhA8HDMuD51aZAtUuAhBzlOdmRADq2tciHuqnjtHD/6mU7s84M?=
 =?us-ascii?Q?QQNuZUdGzs/MICevFE1r38U2dwFSc5K7L7xQ/63PhSklJpsC/Mjrj1Opt14g?=
 =?us-ascii?Q?SKx7x3wHbg95hGLyCSTyDb5Jy6j4ikuGYPsCBJlLNgg6WcZBN/jPWzkcD6O5?=
 =?us-ascii?Q?msrD2/LSr1JQQgt9o3XV4jW3XNGl8u3f8mMiTvah3llFoBbtcGJvQGQVIdPn?=
 =?us-ascii?Q?BObFRgY3T9q6TntkCaMzKDpGn48DPQRIspMQnuJ1MgAJdgLICNCvZ+ctOY8x?=
 =?us-ascii?Q?owc798aGLlIRhUboPHWn9WvVJrlhvgLzFPlW0SsaJY9HqwFWKPCB8ruPADRB?=
 =?us-ascii?Q?z1MCUqV9m+QjOioOODw0TVxrM2KIw0WpzYMLkdMhHFl7YDFnBqn8jVRS5OnQ?=
 =?us-ascii?Q?fPjs1VhzzEfqG4yLMOWetP5MiTahghEnOsRpJsoMShuMozfKQ+S70pM83V+w?=
 =?us-ascii?Q?hjpGeRaHo19cUOto4bNAM165KbGnsRyzDHdnot5zorUxm8KNPRmR27SrzEDX?=
 =?us-ascii?Q?NZCcB8spCZRVfZ3Y5nr3BPPhkg5VhxfrVOcvgrm5LKuFi99CcG6eOvTiXzll?=
 =?us-ascii?Q?FtqkoD2NqeM3mmZgT2rHyKYfZHGsDVPLnfG/71uJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970d10f8-3bfa-4002-e10c-08db721d13fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 06:02:21.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuulJxxEzCFRZUB8Q++0lwZL245ueO1pEzh3O4VLqoBJ+KOrB1qUzyvwYFYWobiqEqS6Td57HeUPieTq9ayAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, June 20, 2023 8:47 PM
>=20
> On Tue, Jun 20, 2023 at 01:43:42AM +0000, Tian, Kevin wrote:
> > I wonder whether we have argued passed each other.
> >
> > This series adds reserved regions to S2. I challenged the necessity as
> > S2 is not directly accessed by the device.
> >
> > Then you replied that doing so still made sense to support identity
> > S1.
>=20
> I think I said/ment if we attach the "s2" iommu domain as a direct
> attach for identity - eg at boot time, then the IOAS must gain the
> reserved regions. This is our normal protocol.
>=20
> But when we use the "s2" iommu domain as an actual nested S2 then we
> don't gain reserved regions.

Then we're aligned.

Yi/Nicolin, please update this series to not automatically add reserved
regions to S2 in the nesting configuration.

It also implies that the user cannot rely on IOAS_IOVA_RANGES to
learn reserved regions for arranging addresses in S1.

Then we also need a new ioctl to report reserved regions per dev_id.

>=20
> > Intel VT-d supports 4 configurations:
> >   - passthrough (i.e. identity mapped)
> >   - S1 only
> >   - S2 only
> >   - nested
> >
> > 'S2 only' is used when vIOMMU is configured in passthrough.
>=20
> S2 only is modeled as attaching an S2 format iommu domain to the RID,
> and when this is done the IOAS should gain the reserved regions
> because it is no different behavior than attaching any other iommu
> domain to a RID.
>=20
> When the S2 is replaced with a S1 nest then the IOAS should loose
> those reserved regions since it is no longer attached to a RID.

yes

>=20
> > My understanding of ARM SMMU is that from host p.o.v. the CD is the
> > S1 in the nested configuration. 'identity' is one configuration in the =
CD
> > then it's in the business of nesting.
>=20
> I think it is the same. A CD doesn't come into the picture until the
> guest installs a CD pointing STE. Until that time the S2 is being used
> as identity.
>=20
> It sounds like the same basic flow.

After a CD table is installed in a STE I assume the SMMU still allows to
configure an individual CD entry as identity? e.g. while vSVA is enabled
on a device the guest can continue to keep CD#0 as identity when the
default domain of the device is set as 'passthrough'. In this case the
IOAS still needs to gain reserved regions even though S2 is not directly
attached from host p.o.v.

>=20
> > My preference was that ALLOC_HWPT allows vIOMMU to opt whether
> > reserved regions of dev_id should be added to the IOAS of the parent
> > S2 hwpt.
>=20
> Having an API to explicitly load reserved regions of a specific device
> to an IOAS makes some sense to me.
>=20
> Jason
