Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D04972787A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjFHHPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjFHHPf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 03:15:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C91BEB;
        Thu,  8 Jun 2023 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686208532; x=1717744532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Upl3Ca9frr1Dtb38FF2hftVqVsyfLs75e1geZrVd/TU=;
  b=FWtxD0dRuNh9fodtHp5mF55B29JWxeDbug3WhL8O7GPt+3G4JHAilmLF
   WPB7hWCWW9EkK7lonDAAMO3QqbjsENyziMDzDurPhn4k1uQhI81NKSiAh
   QUzyDJ+rREgl69TqwrkAFFW0bQsfmbC6Sv+1MN9c7f/ob3oUPsQceBV9S
   op2lfxMkllFBnUjiAj5Xs5uE4pm7fzdiyZnvXu/EB4o1OfmSnRM7p8jgN
   uidnlbUZXSpnlhdGDbZCHbedxFLtaZQNMJR/O/kMFRdZSedQCUIAbLMXy
   spo9+ltl4AWU+RdYPuqfxJei7e6bojvgwngEwIQURBOMLtg9D+jQ9m/qe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346847524"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="346847524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739582436"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="739582436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2023 00:14:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 00:14:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 00:14:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 00:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTXAtIJWRDVVfSbWwxF+EapozeAbcC2b+lrXd9Q1K7TmB1iMotGQvQFw0WYbyFcxRQou0tqtVUFzmGNPuu7gakvW16L5Uy+mTmQ1gEbIuP54SQRVHiAVe5kYxqjXreGNRsyz2y4sg5cVTVgpAECa9NidNc+B/AE9gScCUlvAVhGIuqo+k0+C4fGva7yKwUxhACWkSa7qNbyf/MRf7arA2k8Of0F9f8oX0yrs/kJ40v1zmYdwVXXg3c5zgdmShm+Zoi+44SpNXAC3TYXbXA0Dx7kNYFZmlICqHMCwdR/ZLugyZNl/9YNnqABJe4DgM1dbvf6hQ7s/70SFLKXfsU27XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/REUPaBTfBZU3xwQILLwcuoMezlb/t9leOzzJEs1AQ=;
 b=DmEWR2Xam9yHZFD2re6Q2vwk0/3zGB9twpDcIWF3rFBvzFHgECDm7JtzLGI/kSUSN6qOTfNGyWumdNJUBk54eMavW+6bIqP4oF2w8G0LB5vUs3WPLO4ceuJVJvbBP6ZXX5DuDaWq6rmNJhEuXL5bkuQMwrxrU951r/X1k65391mIDKC95ZnRLGOWAL7zO68J1GqXWT9Zgs91cgc7rDYYixOTQr+vSDjJG+OVMfY5A4SyCAch3PVmFT5bj63FAdWx70ilwClds+JsGF43KqaPueij9SzQc3CFBhG19alJhaLvbI0j1v+gVKusG4q9WFIWR//oX0/uG+dkA712A5tDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 07:14:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:14:01 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: RE: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZhBgR7oRrGL/nhU610QGcca53Ma9pG/AAgBeLNCA=
Date:   Thu, 8 Jun 2023 07:14:01 +0000
Message-ID: <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-8-yi.l.liu@intel.com>
 <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SN7PR11MB8109:EE_
x-ms-office365-filtering-correlation-id: 50aa6f3e-9705-49b9-0b60-08db67efef41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEhLEqR6hbARdsFy3LROqdFo8X8pUy2STPEGjtJ2v+vD/OTtlJcyxrOaHbJMLWgVWsKqUMClwHWiy9665v6edIsBIj2Z7Ba+ItGjn4b1tO5KxixLerJB0Yjy7PutnSt7cHELtxBnQTZPbaBkFPDLwiPv9JaNOMHWe6sM5ahyhnDOQa4X0WmcItsXDAsMJmlgVz59uGJ/m2ApJHxMrJr/EurRublTTEEaX0meogYvKZg/ZP2Bneeau7G0ZkC/usG/VoFXJjXXPmWY0mIrf/Mw3VhDqzDTDqzsqwNPBWiRDCz0wnQbKL5s6bD+rHbeReBmFAUk31FnB7pgIVI59myJtD2MgsadEb5lkiG9tJphwZ0E0gVjZooEBa5cXjmuz23k0yy7RahG82rRaonGJ7i/Hm5llagFHrde3+ZLXijLQSW8VSR7f3D6Cagwo4i7mMoqT1takAR1zYU6iiOySksog94qMwTTND4NVxW7nNSvPELGS09jtfS4TGnaWwQGtJRm2sjy+uACuTPfcZqj4Bu0ovn2EKeoaPZCygX16qC/kSIgMRihDkMsp7fqMJdcaFNJPQmfQqe71H0o+DcO2MK7/v7k4udz6wie+OrcGDihLIl0VVFu93MIVZolKrDb255TMzx0FrPo5oLXwvAdUPZ26g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(2906002)(122000001)(55016003)(33656002)(82960400001)(38100700002)(38070700005)(110136005)(54906003)(71200400001)(64756008)(66476007)(478600001)(8936002)(52536014)(4326008)(7416002)(66946007)(316002)(66556008)(8676002)(41300700001)(83380400001)(66446008)(76116006)(7696005)(6506007)(9686003)(186003)(86362001)(26005)(5660300002)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S2l4QwpqTRboJDhAljjsavf6vG6ycdBYanPWzCdKHsSmUPqlezY+4ZPAgqeR?=
 =?us-ascii?Q?kYmBBpt5a72v5TGovkoCbzpsIQgwlvCMAuB7UoYYduK3gr/sHdOGwkgGjosC?=
 =?us-ascii?Q?qyFWe/1FykO6ijUCsizcyXhSyLB0vLTsVocTcRwJt1P+EytEtO2Z5VRA/exa?=
 =?us-ascii?Q?APPzcoRXbjqZabkv/QoLxS56D3iScN14FdfMI5YpDN0h9M1eI/09mD4byZQO?=
 =?us-ascii?Q?4P7NngTg0/WGpmV6zHIW1X6xSAmLZqhdxsJ6/CuEyN6MVQT6DnHL/UGQYiJ1?=
 =?us-ascii?Q?klKCATb/t0EEJbxSvjHQh/STyigFj4neERjPdmN/eAjCseS6XJqCXUhkZC6O?=
 =?us-ascii?Q?eBtPMR10CR2psX3OUZShWWrYoknHDYjPo4dAV9LOTofrtMySbzdaMQcRt6Q7?=
 =?us-ascii?Q?KRuTBE7cqpYbvNtdBiXkXh3k1RkKkWlZvMp+eheH3vNmsIq+uswn5CluKh1O?=
 =?us-ascii?Q?t3qQiDbvHaggH+pOpp3vGViMgMLVu/2Y7hPKLmaXjqz99KFLTLqASBt7VONw?=
 =?us-ascii?Q?ujvRhjzc1Sd81pla2f+8nzyerD58xTnNZqgrXrnOsrhWRQ0IJaOw/p+2RFgo?=
 =?us-ascii?Q?PJFAG6xk0D2X8gGv4An7tAOfzUkl3XludzzfxnuGLk14npC8psalt+DvGr8L?=
 =?us-ascii?Q?REkWPsVcvqyOBaNNdXSOCG15IJ8sie5PtLuNMssnE217C7NFCw2HKkaCj/4U?=
 =?us-ascii?Q?7QbvpP3kqnGbeNzLv9gWZ8m9ml9VdIWjJxZ17Zxby/JB5frN9wBg8bFeqdRC?=
 =?us-ascii?Q?pofRkYl0eEJf+ujyOLWByuA7s83xE/3HPZy+rM8BjeRIgUtLHJ0VoAS3SAb9?=
 =?us-ascii?Q?v0unQmnHgWWfYEUSv/1eqeE9URXcbi5ESIj9IgFuPfnn+BSgtMj73Obuj1H7?=
 =?us-ascii?Q?2cX/rQ7KD53Tu6aJMgDrWCNJ4mt3ZcegnqvC8UxzxMA2eL+tEk3Hkso6DkZm?=
 =?us-ascii?Q?7fSngeBPFAxKGIVl5RF05sF8QAqq5tvUBYkTtoEJvi3Kw4x62C65rWcwZr1l?=
 =?us-ascii?Q?3buRLQcFhMa/9VVcMk5ZXDStMrBunNyaNJydDOY0Lns+tOyXe5mxWtcgFk4V?=
 =?us-ascii?Q?mB68e6UwEe8nFnhuwHH2KX1k74fiF2Eb2p4fC3dEmM6Ke06DL5VDHyoex5dO?=
 =?us-ascii?Q?Y7DvrKEIT2mPtP0znE4hj6hd7H8uFRU6UIaVbUOU+j6VONrzKp17fW3vvbZR?=
 =?us-ascii?Q?dNdEzJ346lHZUCsad56CIgcDETSBbQNPWv7GuVxlhPisrYZ5dgI7CDIeW04F?=
 =?us-ascii?Q?jIet0DQdoUufKoVkg99eqU3y5KjHwEPhwgdku4FlKCJTz5kGKuX6HwP4bCqw?=
 =?us-ascii?Q?3j7gylrthMNOQ2ZwXmpJSstk5tIoN5LegwGgMX5OObKRu9eVqu9M7xCqJevI?=
 =?us-ascii?Q?KmzIDc+hoEFLHXNqZhjxDleWvlABxoOnNVtB6T9ikDni1Ebl4TPjb/FA8+P1?=
 =?us-ascii?Q?+QSzA9IvPXAtTeXjMW7CGCh3blT9Dxpw0M9+nHW+kV4ma2Yn8ons/YakmGF/?=
 =?us-ascii?Q?ss0hCoRND1BKyTGGlF3+vplyTqBi+V0F/9p1OFXAjGgf6hFg8s9seBfgWVeI?=
 =?us-ascii?Q?Zh+ya5bs6ZYZFRSkOjR4s7/iJ2JSxZX2COnxbrWu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa6f3e-9705-49b9-0b60-08db67efef41
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:14:01.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POoZYOsVuZqprZIGep1/W1Pv0grb/GxJ0u8/Z+fzoW4p67NoIGN2c91XaCb6Lbk45Afsrz49vRUI0m+Fm9fXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Wednesday, May 24, 2023 3:34 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:51 PM
> >
> > This is needed as the stage-1 page table of the nested domain is
> > maintained outside the iommu subsystem, hence, needs to support iotlb
> > flush requests.
> >
> > This adds the data structure for flushing iotlb for the nested domain
> > allocated with IOMMU_HWPT_TYPE_VTD_S1 type and the related callback
> > to accept iotlb flush request from IOMMUFD.
> >
> > This only exposes the interface for invalidating IOTLB, but no for
> > device-TLB as device-TLB invalidation will be covered automatically
> > in IOTLB invalidation if the affected device is ATS-capable.
> >
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>=20
> Following how you split patches in former part of the series this should
> be split into three patches: one to introduce the uAPI changes, the 2nd
> to export symbols and the last to actually add iotlb flush.

Will do.

> > +static int intel_nested_cache_invalidate_user(struct iommu_domain
> > *domain,
> > +					      void *user_data)
> > +{
> > +	struct iommu_hwpt_invalidate_request_intel_vtd *req =3D user_data;
> > +	struct iommu_hwpt_invalidate_intel_vtd *inv_info =3D user_data;
> > +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> > +	unsigned int entry_size =3D inv_info->entry_size;
> > +	u64 uptr =3D inv_info->inv_data_uptr;
> > +	u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > +	struct device_domain_info *info;
> > +	u32 entry_nr, index;
> > +	unsigned long flags;
> > +	int ret =3D 0;
> > +
> > +	if (WARN_ON(!user_data))
> > +		return 0;
>=20
> WARN_ON should lead to error returned.

Yes. or may just remove it. caller should provide a valid pointer anyhow.

> > +
> > +	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> > +		return -EFAULT;
> > +
> > +	if (!entry_nr)
> > +		return -EINVAL;
>=20
> Having zero number of entries is instead not an error. Just means no work
> to do.
>=20
> > +
> > +	for (index =3D 0; index < entry_nr; index++) {
> > +		ret =3D copy_struct_from_user(req, sizeof(*req),
> > +					    u64_to_user_ptr(uptr + index *
> > entry_size),
> > +					    entry_size);
> > +		if (ret) {
> > +			pr_err_ratelimited("Failed to fetch invalidation
> > request\n");
> > +			break;
> > +		}
> > +
> > +		if (req->__reserved || (req->flags &
> > ~IOMMU_VTD_QI_FLAGS_LEAF) ||
> > +		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
> > +			ret =3D -EINVAL;
> > +			break;
> > +		}
> > +
> > +		spin_lock_irqsave(&dmar_domain->lock, flags);
> > +		list_for_each_entry(info, &dmar_domain->devices, link)
> > +			intel_nested_invalidate(info->dev, dmar_domain,
> > +						req->addr, req->npages);
> > +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
> > +	}
> > +
> > +	if (ret && put_user(index, (uint32_t __user
> > *)u64_to_user_ptr(nr_uptr)))
> > +		return -EFAULT;
>=20
> You want to always update the nr no matter success or failure
>=20
> > diff --git a/drivers/iommu/iommufd/main.c
> > b/drivers/iommu/iommufd/main.c
> > index 39922f83ce34..b338b082950b 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -282,6 +282,12 @@ union ucmd_buffer {
> >  #ifdef CONFIG_IOMMUFD_TEST
> >  	struct iommu_test_cmd test;
> >  #endif
> > +	/*
> > +	 * hwpt_type specific structure used in the cache invalidation
> > +	 * path.
> > +	 */
> > +	struct iommu_hwpt_invalidate_intel_vtd vtd;
> > +	struct iommu_hwpt_invalidate_request_intel_vtd req_vtd;
> >  };
>=20
> Can you add some explanation in commit msg why such vendor
> specific structures must be put in the generic ucmd_buffer?
>=20
> >
> > +/**
> > + * enum iommu_hwpt_intel_vtd_invalidate_flags - Flags for Intel VT-d
>=20
> enum iommu_hwpt_vtd_s1_invalidate_flags
>=20
> > + *                                              stage-1 page table cac=
he
> > + *                                              invalidation
> > + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
> > + *                           leaf PTE caching needs to be invalidated
> > + *                           and other paging structure caches can be
> > + *                           preserved.
> > + */
>=20
> what about "Drain Reads" and "Drain Writes"? Is the user allowed/required
> to provide those hints?

All other comments got. For these two hints, the two flags are from the IOT=
LB
Invalidation descriptor. Per below description, the hardware that supports =
nested
should support drain and does not require software to ask for it. So it app=
ears no
need to define them in uapi.

"Hardware implementation with Major Version 2 or higher (VER_REG),
always performs required drain without software explicitly requesting
a drain in IOTLB invalidation. This field is deprecated and hardware
will always report it as 1 to maintain backward compatibility with
software"

Regards,
Yi Liu

> > +
> > +/**
> > + * struct iommu_hwpt_invalidate_request_intel_vtd - Intel VT-d cache
> > invalidation request
>=20
> here you put "intel_vtd" in the end of the name. let's follow the same or=
der
> as earlier definitions.
>=20
> struct iommu_hwpt_vtd_s1_invalidate_desc
>=20
> > + * @addr: The start address of the addresses to be invalidated.
> > + * @npages: Number of contiguous 4K pages to be invalidated.
> > + * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
> > + * @__reserved: Must be 0
> > + *
> > + * The Intel VT-d specific invalidation data for user-managed stage-1 =
cache
> > + * invalidation under nested translation. Userspace uses this structur=
e to
> > + * tell host about the impacted caches after modifying the stage-1 pag=
e
> > table.
> > + *
> > + * Invalidating all the caches related to the hw_pagetable by setting
> > + * @addr=3D=3D0 and @npages=3D=3D__u64(-1).
> > + */
> > +struct iommu_hwpt_invalidate_request_intel_vtd {
> > +	__u64 addr;
> > +	__u64 npages;
> > +	__u32 flags;
> > +	__u32 __reserved;
> > +};
> > +
> > +/**
> > + * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidat=
ion
> > info
>=20
> iommu_hwpt_vtd_s1_invalidate
>=20
> > + * @flags: Must be 0
> > + * @entry_size: Size in bytes of each cache invalidation request
> > + * @entry_nr_uptr: User pointer to the number of invalidation requests=
.
> > + *                 Kernel reads it to get the number of requests and
> > + *                 updates the buffer with the number of requests that
> > + *                 have been processed successfully. This pointer must
> > + *                 point to a __u32 type of memory location.
> > + * @inv_data_uptr: Pointer to the cache invalidation requests
> > + *
> > + * The Intel VT-d specific invalidation data for a set of cache invali=
dation
> > + * requests. Kernel loops the requests one-by-one and stops when failu=
re
> > + * is encountered. The number of handled requests is reported to user =
by
> > + * writing the buffer pointed by @entry_nr_uptr.
> > + */
> > +struct iommu_hwpt_invalidate_intel_vtd {
> > +	__u32 flags;
> > +	__u32 entry_size;
> > +	__u64 entry_nr_uptr;
> > +	__u64 inv_data_uptr;
> > +};
> > +
> >  /**
> >   * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> >   * @size: sizeof(struct iommu_hwpt_invalidate)
> > @@ -520,6 +577,8 @@ struct iommu_hw_info {
> >   *
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D+
> >   * | @hwpt_type                   |     Data structure in @data_uptr  =
     |
> >   * +------------------------------+-----------------------------------=
-----+
> > + * | IOMMU_HWPT_TYPE_VTD_S1       | struct
> > iommu_hwpt_invalidate_intel_vtd |
> > + * +------------------------------+-----------------------------------=
-----+
> >   */
> >  struct iommu_hwpt_invalidate {
> >  	__u32 size;
> > --
> > 2.34.1

