Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAA6919F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 09:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjBJIZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 03:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBJIZB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 03:25:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C962596C;
        Fri, 10 Feb 2023 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676017498; x=1707553498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq93VuVjpGnRtTRzBIKZjnZP+1Ncs7PFWCY25PVBTiI=;
  b=KWuTtALiJxbLTmyV9EPG17FsZ7zaKcuhNBQsmvB2GqM6/i/iyFoYJNy/
   QOc6WWj55M9a3T4nf+Jo9b7MX/SyWPMOOHo+ofvm4zfDu3Rpmh7+NYtWG
   BR7YYGmzQYD5VLlt2adcpp45/8Xbvcfu/VMdXVO13I5yROmvpFB5ofr1i
   vnwNxsK4mHrpYtR3OvvLu4jd93DFzgDgYIyWsSHQAcokC9XvkvFJdeb4g
   MvydHGSGSztol8eYcNHUHcwGORVdBJ7HKniZlmyb19HL6Obkl9WmZfdo3
   NaheiOTHBW6JzCB5uhGwbgR0FqRwABXRlwWjl9P1nFd20VXYjj2KrnJjy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310000290"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="310000290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667968402"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="667968402"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 00:24:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 00:24:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 00:24:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 00:24:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcwVFyqwKYqSrGueF+ZIe9CjocMK4Rsc0rNv1/5ATwwnAS6cEUa2iuFqN2d8Qxz3TXkbw0TM64Vaw+2hwyHWceZnqzL3Shbd+Z9jv6gB5Ye8+ocVCo0Uf6y5JKg9H1vT7p8rAyIYulgNYgLfx3qVaq60oLUf4mqGrq9I0UN7NU9F2GAbTWGZSfC1VCUaxO1pJS1KAWe1+PlKcCW+CuWm2Lx9SXxvrMUH4yxMNF9wa+8jkmfX7P+P9DvJnPYDmHUBBiqCagx+Vp7B0Wqli/cCa5PeD0fNlcFkduoGY0BANc9F7nlwAKSh1f7VbH7Ia2ZCJAEuUS5qHIXX8plpOXg/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp2/kpWuNpIoPhdtJJCiUX8jbfqzE7BHkDGzcu163os=;
 b=RlNHNBcBM3b7zT4QviIPYrMtxlEV8C91/bXVrXQjMPg9mlP2pmhpq4UpxIfFVHIJxH/spH1H789bN9in2wGf4cMfbmZtiSvTEEnCkiAbsVN6L3QlWbxbTJ9JM1gSxnghiO8ZYu/qjpa3b2v0bsn3XnHcfmCxgfjNWlnYDPRS246WBNGiib2ENRKBt6V454+/Jrj3Ggc/9413a56yFNFOmKHkW4NP7h5zwE7mKslGpcmpi6XyBPkrjRa9frl/evC8PJgHDQUwjEkcrrG7eMpHxdkxm27r2+ns9qUmeINCMpieYGPMaG+Hk/mj1QqR2YQ7ier9U++mAOlqXwQCOz1bwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 08:24:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 08:24:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 01/17] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Topic: [PATCH 01/17] iommu: Add new iommu op to create domains owned by
 userspace
Thread-Index: AQHZPD92EfAdrrxgAUWnZjtfI5dYBK7H2SEg
Date:   Fri, 10 Feb 2023 08:24:00 +0000
Message-ID: <BN9PR11MB527618D7F1D260E7A90EDE658CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-2-yi.l.liu@intel.com>
In-Reply-To: <20230209043153.14964-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6664:EE_
x-ms-office365-filtering-correlation-id: 172b064e-a0a1-4097-fbea-08db0b40299d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Y8+r5RpU1yGF45nKM21zz5kI8Iktt+jTNvgDCzPwGsKJABWZa6A+utqUtydyEvdMo3tlPFxXd/HKByUT6/PritYBfUDBYNZvXmcZGS5JwBKyOp1t6t1invQQc5HgalRGJOBN85mpWPmJLDnLpv/kANGeqEHHQbL0IOh/ZBMpuPAuO9xc0QwstjK8c5cVTEwCapZoyceQRAeQiErrHyn4R5C1VOsHcuemAZzlsBho4Tfm8+nlj/Ke6XT6akV/sxOlGap2PFE6jVcgdJ+wy+EU9yUHPpLkkjPDukGth2X+4nBco5siCBiwIyetBHY0DfUvVbjFKOWOTq4NSObdEak6RP617U+7gqO0JNCN45YZPPrGCiH4LjhdskmKKKJgXXtchqyp8N9zGVtJYVnNip3Y3KFr5eGic2JIgiYP01BHoJH852JFm2cuP6R0RqoRpH9sv/UeyiJ6Lzsup9Y5yvU2X+5+3sCMpqJOpusAU9n0u+5zXpeblcmXojkfwdalrENTAVn7tvjp1Rc6aLZeUCOg4IZpBjyil2DcUrYfbQLebziBlAeWeTpJ9Rtr6keH7UWLByl29GbqwmZ1M15k2cGbRLIBpDD2xmhtx+6p6qyoCJ8r2xfl/DqZgpJfpgIyprUClZY0F9Lkh33m8Lp+HlLzacit/dMld4AwCVqQO5fhUhjXm+wGY7k3rmosaVCxbwvD8tcM/mNSHdpldgRYMsxUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(38100700002)(82960400001)(76116006)(26005)(186003)(9686003)(66556008)(316002)(54906003)(110136005)(6506007)(41300700001)(33656002)(2906002)(66946007)(8676002)(4326008)(64756008)(66476007)(66446008)(71200400001)(122000001)(7696005)(86362001)(38070700005)(55016003)(52536014)(5660300002)(4744005)(8936002)(478600001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L3jdLa5m5RI0PXPIrHKYlJkq/ayIdEMVBsW684o4SmWrVUfvC58eVZ5u+x0U?=
 =?us-ascii?Q?yWRw5UAYJBJ30wsNt4Jxh0hV6+wdvWcE59DoHfM+9+E5JKqpA3/K4QoqQVg6?=
 =?us-ascii?Q?gbuCFJh4wdxKj6oO6Uy9fBH6yUYUfuq/+3fJuJqiNCH+FZjdOh+uu4Mwiih3?=
 =?us-ascii?Q?2bflt06NnDLcYDikg4T8XeXzIrdAu0+An7LEMl/NS7oNo/sLfaP69QWEb9dB?=
 =?us-ascii?Q?J/2SDpNk5fgPQ03qRbINcb2H6wMm9Sc89AXUHR/NALxLUkV1+D1cswReFZSF?=
 =?us-ascii?Q?nh1APmmJN0o3cSfDjmDWAbmvr9uqFJPWGzDrVgB5bgkyOCPzJwZgo7xRFqfG?=
 =?us-ascii?Q?0TZLTCW9zt0GmlOeZyAShK7ClS4NR/EJn0ieV2m+vrxkLVnSvotrvb7zrk1w?=
 =?us-ascii?Q?fmWAUMTM9Y/0xfkJs0ReYtDbKFO9EBsFWlmIokXdf4cGdIWcBD6Q3o9u8kdA?=
 =?us-ascii?Q?axYrZkwA1BTMwgr7jGW9RxvEL03HeTOo2NVXQqVaJ0ycPhM3kT1262d4lVA3?=
 =?us-ascii?Q?o8N9XYl7NchfKc1tlmrHrtw9h80/SOikUJtJlrmyEfSwFiPaJgkz0QigGkxL?=
 =?us-ascii?Q?iqupbzMj7CRUVPyGPpnV8GmgiMCHkT5f+rI0GnMLDQqUY5uZlL0sRF+mnEQD?=
 =?us-ascii?Q?kzWfq83PVP6YMVRHnU5OnWOjh7YE68QXp6VK2EdGw/A7t2n/nm5zmNIXxRPg?=
 =?us-ascii?Q?wRekoKihdNjuyeEBmkYsV8aOgFvIsRRUYhwdLJ6w8hJAmkywPfjVCp//zQHQ?=
 =?us-ascii?Q?uNrkiQia0PrrvTGAWIqcCzQUroPXAigprAevWptVz8qACwkRAyyHnOkO2Y6m?=
 =?us-ascii?Q?NBwu/kGQXLoqQeuUQIzXNqqdwsX/LvBj/tYyCc2lwXVJ7dXdAC15cOxS2ZJh?=
 =?us-ascii?Q?6OoNsbNwt6/696Zle9hM7lW8f7uNvUdgFkFNw/dCnFelNwKvF4r3kELl2lRN?=
 =?us-ascii?Q?Y3kg1eO6fDMYmgXvyBmAFhBXmuUnJmXYsCOHBykKMsnfGKue2DVMFfmQ8Yyf?=
 =?us-ascii?Q?XzZxnFvMnLvmCqoaaEHocSMr4haNDh1bctzutlF4vkXCreDmejY1M+n/DK0n?=
 =?us-ascii?Q?yEAASh4jD1u6VIhNn7HScc2bfBQlBmncPaK1/XbWzloixjPWwZFjC5kHZf5D?=
 =?us-ascii?Q?uN02T9FWWQPwZCqMxV3untG+QWXtWR3jhKbQyXMPTHLrWvv8m1EJ5LejO/hr?=
 =?us-ascii?Q?bCFyypzmshoY7MZyfXhLCThTOqsTKGZfDPAixcOstyqV/BKZcGnV3EHZi4bO?=
 =?us-ascii?Q?6/zTil5FeI7PM03T0XG3KSKp41nnPk+JXKQ06crYnUuVE73C/+kWxtzpuXgj?=
 =?us-ascii?Q?Y0RkUnOGNRntyRlBKLPe2S3Gindqxinp9kQqWpNJoUKdvFa3d+/Uh3qj18zg?=
 =?us-ascii?Q?/DtUDacTOQ8CvtAfknHFqUzh4i8GEW8RGHI66bKtoppMKMaWJyCQkaZdU6rG?=
 =?us-ascii?Q?wyhsybwDW/SaarcR33vxquMwJwXkef7M8qBrve9pciuBm+NL58VbUCLl5KSH?=
 =?us-ascii?Q?xFXtHjVy7f2Y9QfLMpF64jggI7bmQwmkU1Fwrix1EB8/5EMhUHiwClBSAero?=
 =?us-ascii?Q?IHApsXpkm6kN1TSrUsJ0dKNk0QtkKYD3MTGuF4Vc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172b064e-a0a1-4097-fbea-08db0b40299d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:24:00.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2BQgtSgBf9LHEX4K1Iq8NDwu/8NZBT3IqbdCwqQipXNMTJEmlfVpGHPD+xGKgbDKier09ZwGOtuMYGJmrPM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 9, 2023 12:32 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Introduce a new iommu_domain op to create domains owned by userspace,
> e.g. through iommufd. These domains have a few different properties
> compares to kernel owned domains:
>=20
>  - They may be MANAGED domains, but created with special parameters.
>    For instance aperture size changes/number of levels, different
>    IOPTE formats, or other things necessary to make a vIOMMU work
>=20

what is *MANAGED* domain?

today we only have the separation between DMA domain and
UNMANAGED domain.

soon with Jason's cleanup all domains are called UNMANAGED.
