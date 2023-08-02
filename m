Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA4276C763
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjHBHuD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjHBHtm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 03:49:42 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E23A9C;
        Wed,  2 Aug 2023 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690962409; x=1722498409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l0rW/TqG+jugoha0aABxq/8XZywXag56QsVrB9tvk9I=;
  b=M2V5OKpRlFaC23wjyOLdQpDMSgk0t3E0ooFrHbI0qpP5vQAC+++1QJu4
   KsgEDRTXwQtgM42LT5GzUhCjO76rInFtOX7Jxxh7EnH2Og+jfxuko/mBw
   g1YaFpY8WH05A0kGywYCh08OcTGEfiEyslt3mm8AWXnfJ1FASt9H396Y4
   cRoXEFmLLMTM88xrXlMOwMZLb8di++0CvECUDGEywpo1c+sGLPvq58bHM
   ZtbqEhurNxctTD3PVocA53lQr7NZFky/0JjGSVZuuHBKRDc1Fnslb2FFS
   qITt8wbs31qS94t9DAVRdJ7ZlSPsmrow9QtCOpjDmFLn9D+u55uVVhTqZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433349560"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="433349560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 00:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="798986888"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="798986888"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2023 00:46:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:46:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 00:46:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 00:46:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 00:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2/km5icTrOy2RlkHj7V+vhPopJXUfiGtjW6jyQfgSCcUN+cMCY7hEwueUxfIWSD5r6gIRyZgFItx4ZhFsIQLDHL4fCjTKTSVKK0PKYRrVTqrZdTCOQmt1UnrAdsAO2Hb1qNaKhz5fZFk7Jt9gQ69mbKlTZ0e8AyDilA1VaNW59Uf+uWSdJW0LBQorNkJTg82V/UZKjQ516GDaHRdTuejwruOvFF9K1HuxD2WkBMTD6WKSiIc9VKSULmOKYIwURhk8PAmMQFPjYvZCMD9ljmERHhn4s+fIXkJUql/xB0f87oc2PP6f47B4WI4tT4njBrkiCnIVEZbHbIL7Z1Jo3gDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Logj42nPwfYXb0bDqdM4OjlfAD55yemhgmDPt9bpBU=;
 b=IzGBqgXca9+myZIkLTr215SFIZsDYs95+aFcbl0GULwyqoCNjSbhfIgCv9WruYm203oDOvQhRWfmcWegUvX7w32J3pfx5QWA/rmptAJBgmBc5xsOwXeSoQWolRhouY5devsE9OidS/1kqjjtKd8qAGgyv9At8/almjrJwZE4NN8VROkOuyiWrsGy0cw3+YiHqC89Dir8ZKQZC5qpgSSNZYDIsl0P/OfAQCmMRiYn+4/JEP4Uk01w8+dHtcFvust01yVfZjckifKA9uaQY2uFBQHVVyqNL+qPYwH/T/y9aSYs+5RZibff6Tj7JoDNSOEjjZULJQgvx0EZVzkKLPuZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 07:46:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 07:46:39 +0000
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
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQ
Date:   Wed, 2 Aug 2023 07:46:39 +0000
Message-ID: <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
In-Reply-To: <20230724111335.107427-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4957:EE_
x-ms-office365-filtering-correlation-id: a48cc4e4-41f5-4955-31fb-08db932c9b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o70pzgYqz+HX4yUQt3WmKeChfin/6y0EyZyTVrLaEtpyX+qELfgblVPjuBJcAISt+JJid9ozfuS0FHxHmr1PI4ISn6YDBLP6pXlnrS8Mt4ts82o6/7FBmDy3xP0riNJaebm5pHiQuk13lzyWM3g7Wi63nt4jDJz+qT/NbamK1vtc7P9HjK8tTvgydmiRwYwuFO7q2WSEpxjK6Gnsbq5NxhmIOTDhTXsuzhRnSlvu1/lLacmBDWLGvMVNeTKtPXl+sOWnM/A50xOyN2c0W2TaGXi7sG9fLGrsD4gbH/mBYPkL2VZUZgN4Pm679JOSyH40FsBrnnlNIDsI0n51TJVNM6ZqkmmAqep24278gRihJOFZLS7SBuVxAyCRkLZvK8s2U6oLL0W1mKkAeOHSY/eg/BdWYJqMErbZjd9L4FK2/DkDNVOeZ97pN5+SB9R9LYpViO5gQUaojKALon4ODNGXEBaD/mkRNlOsaXXCIAfIjSNp033gY1Gn0dswo7/R4EhQmLuiGikRCfA7qZ6LZmaxgbxg9HFEHltzlJWm8a1ZEWV5alHomnnBXuKXR74XBaO933h/x9NYfeQqIVEmF84ChJHgANMuB9x/RKQ/xwJKN/BrUuWUsVvykb6xRyrszlTz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(33656002)(4326008)(7696005)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(71200400001)(122000001)(478600001)(86362001)(55016003)(9686003)(110136005)(38100700002)(54906003)(2906002)(41300700001)(26005)(316002)(186003)(6506007)(52536014)(5660300002)(83380400001)(7416002)(38070700005)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gUygnrNI93GgXKlidP7N+aqBYxtGbusOQkpPGJAajzp0aUo5B9nYjDxSd2HY?=
 =?us-ascii?Q?yu2peixaEt6KhwknPoXXbvTdQ+APkfBcbn8jUxYbEip8Gac2Rd+9xNznzD9o?=
 =?us-ascii?Q?3lKNerkikeeeZt0LTjSyvqtObqqcRWyve1mRljHhdxS6g9T3juoBHQCmOqsi?=
 =?us-ascii?Q?pUXvJF0toEmTPc5CgrrAjlCsdW1QwBdWkNz7zqmfgvgDlusgpPGNk7rpG55N?=
 =?us-ascii?Q?QMaQ8MRxulbkVqH08ync9kY9UoboZQZIUf/6wA1psvRdB8zfYlniLe6FQkTs?=
 =?us-ascii?Q?zfeuthJcRwqmKT1CSjlTdtVsS1I5Wrdgh4hfzxAsIKBwHGmD2oInUOpvgSKF?=
 =?us-ascii?Q?i/+raVmL/jsUGyDCZPkaclCKZ94GXmUzQ87+XNcZ0hZvL9y33SXoGj8uYzUL?=
 =?us-ascii?Q?O0u+y3zYpqeHOVJq8X/j/+qRRiLC+tFcoW9SJgIf3r9CURoOnz6Yl1sLIqF3?=
 =?us-ascii?Q?u3u8wZOKmKj3iKOrsTvLh3sKuMOEycXRDrrU/SaFPGBmC0BjxUj3t7/eEC13?=
 =?us-ascii?Q?R0j0CNG5OEYBuB0+NWHVLQgNsatD1y47eEs7QVzHd7S7EjrQG70LR4zQ4/Gm?=
 =?us-ascii?Q?fHP/TRfJNWykxE1XKEPBCvzaLo72RjCPY3S2oB9cYDvO4yyUvJfWuvFf9Cp7?=
 =?us-ascii?Q?GNAyVd7ZjU8PNKaqHrbG+c4ssDhBTzTpMA7exxZJW3lNi7GsxmtNDls+xtcZ?=
 =?us-ascii?Q?8pfjauK/UzByEsnQDQafQAxyyKpHMj13ytqzIHrvoiIxJZQhJXTU9J/awVvU?=
 =?us-ascii?Q?4fNdRM14tt3px6YNFfWA+r/HIGQ7HcbwTlltjBu8uvn+KnBVdazaX1xMz1Pm?=
 =?us-ascii?Q?lingOwZya1kzkN1AisZjh2jbGjBPlBpKWbFPPeIMHLPwII2aTuxk1N/JW/WI?=
 =?us-ascii?Q?vOCo0Wt60YqXbo8Uju5JA3vI/KucjOafKa+srfzRgPf5wosw6q21NquL69bG?=
 =?us-ascii?Q?lvgAgQr9gOA4e8xhYENhuOQr+u2fMVCmnVJxh8eJPr3CHbpPcgMSw7JJvzcq?=
 =?us-ascii?Q?iEd8zIthgjPvbrb0krr1Pe4yapXv6P+ZWMuSd/VoCQ/mWWg4N/pRNBkNRkt4?=
 =?us-ascii?Q?iNftFpBXJhASJAYN8lRQizczhPZVr0dX/aZUaBoYOd3cU3JjamGk6CK6xxFi?=
 =?us-ascii?Q?xwDFg9M/hW2YoX7PsZVxQRlVnu9WuVYa2sbgpNQaXsO0rY2CUW7bHk13y04T?=
 =?us-ascii?Q?jmVZ7gZbZ/xejDmrS6g94co3GJ7/IcvZt+U9vgT0BKJwmJLMeoojrdtN5iym?=
 =?us-ascii?Q?pi5vREpIZknMhYq7PxLhaUpqRu3K1M2FNgJ4tR5tYBgPfvDkNunfj+SaEm1V?=
 =?us-ascii?Q?f6zMfNDy+P+x0jsNdIzQgXlmm9hz98HZBZXYIIzbuKnDOKRNVKXPX4lRM3Fg?=
 =?us-ascii?Q?0qjABQAQknUU5kG6C2mCLfHmFICPCJgqLEFOOqrlEvRTiQTAI5RfsDIRTkZm?=
 =?us-ascii?Q?LvEbuuF2dSm+RRU8DlnAtQO5KBcN6xBB9PlIkT10USoBRMeQQm2fA5wiy2TY?=
 =?us-ascii?Q?FzJWAhBX97p88MhOn54io9KdtEoMNSN3lZ1YX0hR02s5/LwqDUoDQUKvRzg8?=
 =?us-ascii?Q?Z9FXIb9TkovJReqPam9flhzgptoWvAetFnN83D4z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48cc4e4-41f5-4955-31fb-08db932c9b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 07:46:39.8127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvLaedf9tJlEuwcqDpBZLE7OtkEbL7r4BPW58ximGPdb4ZjPbedTxAqW/dsW7UsCY+bMNKN3J6S1qAV4Bk1v7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
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
> Sent: Monday, July 24, 2023 7:14 PM
>=20
> +static int intel_nested_cache_invalidate_user(struct iommu_domain
> *domain,
> +					      void *user_data)
> +{
> +	struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D user_data;
> +	struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D user_data;
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	unsigned int entry_size =3D inv_info->entry_size;
> +	u64 uptr =3D inv_info->inv_data_uptr;
> +	u64 nr_uptr =3D inv_info->entry_nr_uptr;
> +	struct device_domain_info *info;
> +	u32 entry_nr, index;
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> +		return -EFAULT;
> +
> +	for (index =3D 0; index < entry_nr; index++) {
> +		ret =3D copy_struct_from_user(req, sizeof(*req),
> +					    u64_to_user_ptr(uptr + index *
> entry_size),
> +					    entry_size);

If continuing this direction then the driver should also check minsz etc.
for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_de=
sc
since they are uAPI and subject to change.

> +		if (ret) {
> +			pr_err_ratelimited("Failed to fetch invalidation
> request\n");
> +			break;
> +		}
> +
> +		if (req->__reserved || (req->flags &
> ~IOMMU_VTD_QI_FLAGS_LEAF) ||
> +		    !IS_ALIGNED(req->addr, VTD_PAGE_SIZE)) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		spin_lock_irqsave(&dmar_domain->lock, flags);
> +		list_for_each_entry(info, &dmar_domain->devices, link)
> +			intel_nested_invalidate(info->dev, dmar_domain,
> +						req->addr, req->npages);
> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);

Disabling interrupt while invalidating iotlb is certainly unacceptable.

Actually there is no need to walk devices. Under dmar_domain there
is already a list of attached iommu's.=20
