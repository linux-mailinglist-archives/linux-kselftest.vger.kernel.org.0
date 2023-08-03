Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91176DEB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjHCDHv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHCDHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:07:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBEDED;
        Wed,  2 Aug 2023 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691032069; x=1722568069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=USpgfgK/Yah060SWXYKoN1ncgYN7vPzVMUJ12TLAp0o=;
  b=SHxBGcOArUtXRdObHiEkKZcgq155/QvfZcEkMhTI0xLtjMHFe9gSmXRP
   0J/L5nh+rYs70k52WBHh9d8g/KP+BxuVcfiIlY9sVD48eF0v7liU5R42Z
   dsMlL4J4kc4yqdfWrcgy3U/FSv3/tyHGhpZLuKuZ3kQzbW4qOPy6QKBeS
   ToyZ5iCcRY0CeNmmlClKHkp4RaYXCmWw338SGy84iEW/Fe43nzh+rO3/Q
   IZXDf1ECVYK8jqzfOVZVxCP4KazX6t2aCODs0ki3QCZ5nacV5BG2R+9CJ
   niu6fYdhu8mY8icD884vstXRVUnkU/DeaoLe7NV8lWzZJ3c2Q+tZhDgpt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354671083"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="354671083"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872754849"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 20:07:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:07:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 20:07:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 20:07:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEI1fR6TTF/FPBq1Tpolf8dJ4KoObcRnpP4fO0Svsl+xBSyarIQjOOO8ge+mizHSXWlqxCdb9XWzcjrnKhxVPA7yU3N3dSc1uP6GySKwAYD1Enjsvfa2RXfaODr4IbnyeXLiiP+IlNDkxkCEInipIpGOXFTM+NxQ7C2n5EyFFNHSvLPkAXqheVlKeNel2bEX1EfhEyIhtqO/uUMBbe/CguFxJgkUjzhNEDVJc6So56NyfwUr6lt7+WtYHFhFMyr/+NJP96VKsxPwFVnWU96oumJR4fcZzSei6gEMJSUgFuI8Ps4qq2NLgUvBzn8Cwh154l/EQslmNOdzPqvp5lpIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A+o7mP7N4+PJJtlwXsTIMs0ZsDTDhWFlGbGzv7FakM=;
 b=TSM0O+ATfRg57oSZsnTpFPqAF3aMQ7E3FOW480gEOxyRXkVa7S92bc+QBoaxorUJY18uwU5whcDjS786iRsGBqdjyKoKib9Zh+uNQkOAhQkZzxsqit34QEev0G+JShr8d1WeNj+Dw+Czjjgbmv6M5ZpAJfixsAzy4eB2r/yF79ROOku/WJJnqCoQIz+9xSgvRHRMTHi/L/PztwiLJXV4uVDZHtKXlVGCCTM0ljVYyEMvUBxyr7iyyPaYCcWoqdIMIKqjy34PqLyIk0z13O52tQt9qr6g1ftSn/IV+KYu0sK4c68ZlbFUKSKlgWm/2SupyCOH5ZAvD3AKSyQE6HJRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB6080.namprd11.prod.outlook.com (2603:10b6:8:84::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 03:07:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Thu, 3 Aug 2023
 03:07:23 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: RE: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHZvh6oi+POLB7tyEyJT6RvyneQWq/PfyuAgAQvXCCAADhpgIAD/d8AgAAMHNA=
Date:   Thu, 3 Aug 2023 03:07:23 +0000
Message-ID: <DS0PR11MB7529EA8256BD06A96C8D1A85C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com> <ZMQCw2iiIqa4CXNG@nvidia.com>
 <DS0PR11MB7529696366A4447EF0945E87C305A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZMe0zQ/29/gLGBwZ@nvidia.com> <ZMsOAv9PjZpLaf4z@Asurada-Nvidia>
In-Reply-To: <ZMsOAv9PjZpLaf4z@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS7PR11MB6080:EE_
x-ms-office365-filtering-correlation-id: 8ed64e2c-182b-4294-84a6-08db93cec24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j8s0+y6MCbC9EVKcaF40YQ1vKuPmWEhCFC1MDLVGoS19vR6GlcmKqgIEGCepxtk+VPtQZEn3WWIyNRdPD/awuxAhndTHoHfXWgKwRIry/WMiPvT0v75mgU/nPcNfDk+hOLpEC34A20u8Y44ygG7C8k8QGv3mcdM5Gty8tdwQbN5htgFSubYadXUmUYq7/ANrLB32K5QoQCts4UcSq9F/93KsN+jOtZnwA7LMWD1GUBBL9ZMxpZegDJ9o2TRvYcPnztnRUjZe1Lod76ZnEBTr+4Y/drzw7t0SBqI8D+hJHKq5ny2XKwUncvKvdpWcoXbDEnI60C5pDbmHJR5cAPeAendBdHlm0NNj3+Db160LKkWBLRtbT/iWcxjFlCLQiaQc4W4PIGMMnxdM8ex/V9tKccYmk/w5jfMWkOsZ1woO9VaTo4/52slUtruv3Hx59RGIG/G5sJn3hyGzSMqqZInpjazNUNHSp1ofYFlzAxxJ/kuCnrNlrDDqKAb+l96eNEe68vPwwmmPq4wmtzDMmAOehZrzKaKtAqBxJC7g+Nrb+RRdH6t7q6j5QoES4MnEvQpWfYNXAZd2fIRcBInJEDsI1DRUBMoLkHIM8cBpqY6a21cgLIlEq7WgHh0o6MZL69Dy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(38070700005)(33656002)(86362001)(54906003)(478600001)(110136005)(38100700002)(82960400001)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(41300700001)(8676002)(8936002)(52536014)(7416002)(9686003)(71200400001)(7696005)(316002)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J0LfOiodcjyGZWxt+Ez9/gozXJYJphOcoaGHRq+4eQcN7q+R8thf3WT6KySh?=
 =?us-ascii?Q?TWb3niXKrj4basPUlSVSuxQO0qDetmlTPqUUm9PX8+s0mxdG1kJ9MJ5tCGh0?=
 =?us-ascii?Q?CPm3WwGm2/l3gWdJCmBUjl/dG2lssmCK2v9lBWrD/tdPjG0hMnGA+3etUmFy?=
 =?us-ascii?Q?y6GFyuSKGIb6GppGJhuEWOld/+27iBIVSi+MB3NJ7hWRo6JsUvpodJKCTMoJ?=
 =?us-ascii?Q?mAky20Qo5lJZsAWRFn4t8LY9xQBk4ZvCtGPjQHrxfV31UiWjrCmchp1sUjg1?=
 =?us-ascii?Q?HctG/ucKkJD6LDVpIfK7t7LoAsOgjsKF7nVQh8G4iPMNlDmydSMs+2PBk276?=
 =?us-ascii?Q?McB93PGSC7SbJsDSTPUiFMqHlbh5US/xfunl0TpEI64dlAdZA/UQ9UdUCCW0?=
 =?us-ascii?Q?aS6lRe1dYGZgRgl1y5y6GP1DPGo15BRliRX40DOuPJs2dYEQ2kjtV9Y9v/Vd?=
 =?us-ascii?Q?LVMLts5LH7KUPKrLL0n2dJYfdycifgCag6EB+GSXJuIR+D6lhNVpCVBvDsLF?=
 =?us-ascii?Q?03E8HxGTmKEWrZpS6Bd0OAORmv1X8/qRo4dwvOebDvDi7Qu82fpo7HsgSiZA?=
 =?us-ascii?Q?rM/N8L7384F7t32QvW07Ig/3z114xosdD7X/lCCh5lj1rzp2UjUO9hadtNxj?=
 =?us-ascii?Q?TdG9pg4osjR2czqWXLkMwBn9kBfaivaEsUBkKZPfRnFstCfFoSBgEp02pdAa?=
 =?us-ascii?Q?++2h/PXxw9m8cyG8VZXbA2yFt8YKKPvGjJlkbdNiGqtEc5dF966+ONlc4fus?=
 =?us-ascii?Q?rEdz+WcE7p2uPm1jhIIXgVfDv6fvUfivgv7SLQZMAJ2TfKYzMsWThQoRBdsV?=
 =?us-ascii?Q?5ZyWgf2VbZUTYXcX4rSAXqu0thiT/Lh2qs5GR3AcwoOUlShDXH9vNMIZIiMU?=
 =?us-ascii?Q?NjYoRpTTOqFqaTn18wwAXOAwj0X6r28Avx/ZAqObi/4eY/Cf7SsL4Mscnu4M?=
 =?us-ascii?Q?xFDJ/nKIuhdgFFjTtudfgeQUod4FUBXFZfLtq4BujySSAu90jn90iNiqIsec?=
 =?us-ascii?Q?hzm5cKNh+Gm361bpL+fsvuVMqfIC05vxFQTYWpe2HU8hbi6Eum1DIIqNuaES?=
 =?us-ascii?Q?BAE4KQ3V6964Z8SmhTfF/FRx02s3NsApV8EGVvr+pGgetxmvY4tPtwtEjMCl?=
 =?us-ascii?Q?Qxa2usz+uNIi3EAWVusbbG/6n5l8+L8WUgwYO6ZzTTfxG5w0/udBVmrxmEMR?=
 =?us-ascii?Q?gHz03SPHj+PIOC7hFuaLel08Rk3QxQoGWpURIPy2yo6AaxzwtYSP+cqNZeO8?=
 =?us-ascii?Q?+3yrHGIIzGUwqhLLMd/mi0gGulsbQFP+txUXrjGt8lBmdWBziPPBltWAWS4k?=
 =?us-ascii?Q?oSphZYdqnpxbQ4wtaNbvmOfh5vwfcrEwZ32pcRTQUCu2+MiBhUQ8JxwcN4Nk?=
 =?us-ascii?Q?5Iown7Hha2etqRntiyIPI09Se15jDpszeU4qjTTffGeDslSxuUkgULNKiyjN?=
 =?us-ascii?Q?BPQvhQQX1aMSsyRSbZxiwY+2e6zfU0FLIC1A6JNexoAm9rmDYpx8WUMUFGwx?=
 =?us-ascii?Q?4XJBWmEggHfxQAhri8UfKak00+qydrZzcYYBLuWIezRtFVNFVRhDPcc/G0Zx?=
 =?us-ascii?Q?XKjbANHqJAjLn4E1oBU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed64e2c-182b-4294-84a6-08db93cec24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:07:23.5269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFZ9btHCXmE2kGa8Kdih5pJVmeimkOe0QZTx63TLFnxMG/e1/1SfqdgtmbyTqi9rZ5C8qBPcX7z2avz5tKKr1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, August 3, 2023 10:17 AM
>=20
> On Mon, Jul 31, 2023 at 10:19:09AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 10:07:32AM +0000, Liu, Yi L wrote:
> > > > > +		goto out_put_hwpt;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Copy the needed fields before reusing the ucmd buffer, this
> > > > > +	 * avoids memory allocation in this path.
> > > > > +	 */
> > > > > +	user_ptr =3D cmd->data_uptr;
> > > > > +	user_data_len =3D cmd->data_len;
> > > >
> > > > Uhh, who checks that klen < the temporary stack struct?
> > >
> > > Take vtd as an example. The invalidate structure is struct
> iommu_hwpt_vtd_s1_invalidate[1].
> > > The klen is sizeof(struct iommu_hwpt_vtd_s1_invalidate)[2].
> iommu_hwpt_vtd_s1_invalidate
> > > is also placed in the temporary stack struct (actually it is a union)=
[1]. So the klen
> should
> > > be <=3D temporary stack.
> >
> > Ohh, I think I would add a few comments noting that the invalidate
> > structs need to be added to that union. Easy to miss.
>=20
> Added here:
>=20
> -        * Copy the needed fields before reusing the ucmd buffer, this
> -        * avoids memory allocation in this path.
> +        * Copy the needed fields before reusing the ucmd buffer, this av=
oids
> +        * memory allocation in this path. Again, user invalidate data st=
ruct
> +        * must be added to the union ucmd_buffer.
>=20
> > > It's not so explicit though. Perhaps worth to have a check like below=
 in this patch?
> > >
> > > if (unlikely(klen > sizeof(union ucmd_buffer)))
> > > 	return -EINVAL;
> >
> > Yes, stick this in the domain allocate path with a WARN_ON. The driver
> > is broken to allocate a domain with an invalid size.
>=20
> And here too with a WARN_ON_ONCE.
>=20
> +       /*
> +        * Either the driver is broken by having an invalid size, or the =
user
> +        * invalidate data struct used by the driver is missing in the un=
ion.
> +        */
> +       if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user &&
> +                        (!hwpt->domain->ops->cache_invalidate_user_data_=
len ||
> +                         hwpt->domain->ops->cache_invalidate_user_data_l=
en >
> +                         sizeof(union ucmd_buffer)))) {
> +               rc =3D -EINVAL;
> +               goto out_abort;
> +
> +       }
>=20
> Though I am making this cache_invalidate_user optional here, I
> wonder if there actually could be a case that a user-managed
> domain doesn't need a cache_invalidate_user op...

If user-managed domain is the stage-1 domain in nested, then seems not
possible as cache invalidate is a must. But I think this logic is fine as n=
ot
all the domains allocated by the user is user-managed. It may be kernel
managed like the s2 domains.

Regards,
Yi Liu
