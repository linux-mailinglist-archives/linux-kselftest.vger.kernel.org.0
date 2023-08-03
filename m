Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5F76DE8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHCCxp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHCCxo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:53:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC910A;
        Wed,  2 Aug 2023 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691031220; x=1722567220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t6gAxKZ8h7GuAYMK7fX1sBhNoNZIWNMBIzeVj4NG67A=;
  b=A+cMA3fxQNzPEI1zplDLLOZ/bfIZi/M1PP6DuS47VLBkc7Bejgwp5tzs
   5YZFoLu3zB09AGsm5Ps8hKjuAz+Txi1M1FGRMGQ+yfka1UU+PzwGrz6d7
   VScEcDZ59YhCzkhtIW4gokp+EvGf0kV4gsCvHi7Gdd7zGMzqDpqXiZmK+
   c9nPK+WkuQfaaHc24jUytyy2wSTr0mVCZXgavuPVmp5Va1H9lEMj1geyP
   Bb1GOT0wAA0ZiYPm3Z0f6VI7oUzqccUIEa7inHoWiwG2EV9sLZhR2qJeZ
   i+RklF4x4EJEdluOdeiyg8tla7MHm9yxCMDBir/a+jQCIMZV8OGiWoc//
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372490040"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372490040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 19:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764441759"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="764441759"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 19:53:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 19:53:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 19:53:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 19:53:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 19:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuocjZfBvEe+GCNlREKf4bQ2pN3t62gwL7R2I+GanbuLOdg7lbyMSFSbqyLtDpsh63ZYpPsBV8C2craGUyB7HsLVQWuXnbAroFYmIvs4cFKVzxEAQn0Pj+P8Vs3RozMrfeDhsNUvC9idUgLAJ2wolxK7oaqzfOiNmvKVxYyufrpRn/zFdJivyuExYqUdHboClWtiOS971xdwOj5PmXTrGB55nkkrsCfUizr0SUgFrXu9TmnHo2JgqvhCROwRGCO0dWfT8bmj++IT0zdbfnSnRsz7jyhUEZ2jTI8QLo+IjynvxchrNDur2/z56ar7tBdLcjdtMk4cbmhtATREVfC/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7ZyypcMqQzirI0yLO3RVRSspXBX1468qtwkveVjxxU=;
 b=EEd4n2pcQjjUkEfn3BPAGfCGARa5UPOMjnUMYP8KESx0fw/L3hLVIDTqKJsWgizKrfdIf0o+VdtP8y0gaSi9LvvbUkGT1vg+xganOwOxda2LFjKLG2YP9IkfAssYq6gOMZUWLbt3O8O9NbY3EOS1cAEvMa6WBLXnvScvvlxPj+9JJr+kTlODw1oxudqHqA5Xy5abG1zzZpwEzpjaNR8I/gs1+yHYx6RM4DzuREkQNMqEVN3V5daspdMWh/r3UR9gOYU+xnqj0mmvVj++78y+S88HtlgYgA6+jiorAeROQG0iE0VKSsJyGEPiv2DrKagTTvXeYikaSp4jr8amz7x1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Thu, 3 Aug
 2023 02:53:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6609.032; Thu, 3 Aug 2023
 02:53:35 +0000
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
Subject: RE: [PATCH v3 02/17] iommu: Add nested domain support
Thread-Topic: [PATCH v3 02/17] iommu: Add nested domain support
Thread-Index: AQHZvh6gHpCSYQLtaE2lWIIWEd6RNa/PbYAAgAh88QCAAAQ3sA==
Date:   Thu, 3 Aug 2023 02:53:34 +0000
Message-ID: <DS0PR11MB752948714F908244DABD27F9C308A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-3-yi.l.liu@intel.com> <ZMPz8MIevHBd6zsI@nvidia.com>
 <ZMsSvM/gC9016CS4@Asurada-Nvidia>
In-Reply-To: <ZMsSvM/gC9016CS4@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|PH7PR11MB8504:EE_
x-ms-office365-filtering-correlation-id: 7f66bc9f-c22c-4cc3-1737-08db93ccd471
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygn3lVhLPiNAe98mEp0me+bwhnD3mg+viro+zeS+xsYOXHdpjsogUH+wwczRGIAifpzDT2+9m2BhI2hWFQ+Q0GdFtxryypmxl3g01SIyEZQ2z2Rrj3XtSDqL+2S/POuJ1ZZ0UkPACcn/R7rFhVY+6VOq5q27JuqUbABFVHkL4g2B/TfA5Sq5U1v2emb8qvFQRCCUDstcpEZawRlZVozmER5+PZsnOaMaNXDdjIg+Hmp7x+D4xCtHshcfIEymj2HKDcM3NDt+dnoxY1a7EqOilENGDzC3PaMYtc+L0npxbmvcGFfuyC14SVSkhd4Sfey0WVOkCuCLeGKV2tZeKXpkG0v01Ko8so+7/nvxZLe80fK7UzCj7dc+PAd9/yrHNbuDUaZkIzqYtN7+t56fqSGNfYAxtsgsL7dHAt7u2qrNedlQWaqhMwH4teg1Moxut+zTQ72dA8U0xJUeGplP04tfpCW+t108ZX+bT0vAMn5W4xpJlxDAOgkp3DLtw6/XeS2tCkPlb4r/Z7nMmajL+ujJhXeGj13FX0N37lf1KbaFchuYC45nc2pppwqIm0OLSTq5sg52fZQGfHPWXoydjtucNBvz0RuaUagFfm5s3N9kpdgWy00zr84VaFh/WousEcWuI/yjrIdFUqnOOk062xLpuqq8m/keEWDR42ujUOCEGJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(52536014)(5660300002)(7416002)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(4326008)(2906002)(316002)(41300700001)(110136005)(54906003)(8676002)(8936002)(82960400001)(478600001)(86362001)(9686003)(38070700005)(38100700002)(71200400001)(7696005)(6506007)(26005)(33656002)(122000001)(55016003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DzWxh4qp4J+7w7UjsEZnxIbkTwTNlTYZ0+R8sjX+YNRc8/0RLc4XW16fMAP/?=
 =?us-ascii?Q?r4LoizDNTES+0Z/VmSW21IgfirCj/hEFkxL9Csi32RWlQAKlSxde9Y9Oo+XS?=
 =?us-ascii?Q?SnCO3Gvz6C7JADUxBC2QFhVl9Mg2otfjZb5fOL2BFUKPU0QhXafagXIfxcLK?=
 =?us-ascii?Q?cxJBUnsGW0Q67ijmESLpdGEtso3bxD3eC0oftTpCWA70f7uSKXGRANwU7klN?=
 =?us-ascii?Q?JdDTCFW+dWIJGSo0zTJ5kMqXfC16lWZFw9FnK1OaNqOmj14+vIi3DiW0C//u?=
 =?us-ascii?Q?Prn6PlSr8iow/dVZ27+vACT0k7tX2wqxn26BwQMK9VInzAn2zZIuTJnTJhes?=
 =?us-ascii?Q?dim/a5S+QfZZymXtdJpmFZhj7mhMdM9Ok1PznJV3rZMysHlkuqTIkwU/APrl?=
 =?us-ascii?Q?PA7voCLXsQg1SENkis2NeHlTFaCq0PRIIrXy4c8j5IYpI3FVLraAT16HzyFT?=
 =?us-ascii?Q?L29wQWuggoR0FRpzSvvJLQktQFQAhAtqeBDoIy4jPQCnS0HvUbJYqoFKetVo?=
 =?us-ascii?Q?cdnRj8eT3NIPXKNxWNzvxt/rwukY+sbguRDf6/eiyvwWXRLeJBVZrlWXqjof?=
 =?us-ascii?Q?ODlxjo5U84yNzQTt4/da7R9no1REGoR7yBYiGkKGA74iEF2OxBXrEo50JYQT?=
 =?us-ascii?Q?ZEOrBTQFZlVDa1BBK0BprpE3fMQZkUO6INEM6XeSIu0SqWXoJS3E/0NKMV/z?=
 =?us-ascii?Q?Lp/1krHtSwuRZ9bDidMzt9ENJtA6RDbXMMZqU9TTdLzli9J9QEIN9Y2Hc2Jx?=
 =?us-ascii?Q?D2g+K64Xj9y1trwqJ+mdw0HTkShdJmvf86DoJuyIgXG7dr2D5pAkx+mrFxW/?=
 =?us-ascii?Q?1sUIKP6WDYeMNG7VJBc4zglF6Tc4SkEwCGSCmvJpeaaS0NIDncaVCrNXMNXH?=
 =?us-ascii?Q?a/iOqEZysUmyEV7Xc72ANxc6utBP+AULIPTofVcNEs8Vu0brL5fuPhUKYMbn?=
 =?us-ascii?Q?73xnd1NcoFek1mmujcYqw6eKxLlgTxhxU7ne7DCRMDhlPTe1XuxcI3RVdfQe?=
 =?us-ascii?Q?qFLNHT6+RvYWfdu1ngwfgnJ+ZCbpjgUT3fq3iG3IoheBX/hTT8iMzN59zIFX?=
 =?us-ascii?Q?83Sw2WjEjuXw9z2MT9882EK/2gQPupa+1mIzpk60moIQI1ceEVVjVym7XlVn?=
 =?us-ascii?Q?M4128xpKdNGI9LLLrO8JBiDiSOf+1wysjnYxi/ezLvlpN8ixVgkRbwUgtg9c?=
 =?us-ascii?Q?Q3PAbX00NJxx6Ilw6sKisoP6qgfu4xezIZbczV70cPtYzDoFvRMTXM8vmCe6?=
 =?us-ascii?Q?Elp171nPMopVRNlw/gL3rEgxNTxqci0wVZBbuEAEh/+SdRBtWZkMnJ2CfiRm?=
 =?us-ascii?Q?NSA4D4eIhhiVAbF9CTfA/CejiSaXX4iyzBh+J1KOVxXlunjG4hswT32Z43zB?=
 =?us-ascii?Q?oKOIZkCoqXewIgYoszcIeovXatyElg+1/jsV+oq5CQ67X58dW2iW6x2ZMnHF?=
 =?us-ascii?Q?4CZztZNTAmxgSZGNDZqm+A9Yxvty5Ii4RQNZpP9Mb5+0++sdKmmW9YA4EBGo?=
 =?us-ascii?Q?dr2C/WgTiRbzg4Y5C+kxfRTzV5VCM439IA5ekBEcUr9BKaUhNWGPVSmYn8ep?=
 =?us-ascii?Q?wpUEKVkTE5yUgczxDGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66bc9f-c22c-4cc3-1737-08db93ccd471
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 02:53:34.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKQekHV+QbdRicO+HAAAD8Q7BIbA/BDo8NdJeJVOgQcUZN/+uFeo+aPHyNOyRF8BethgmbgpzZeU9szzUPQ0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, August 3, 2023 10:37 AM
>=20
> On Fri, Jul 28, 2023 at 01:59:28PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 24, 2023 at 04:03:51AM -0700, Yi Liu wrote:
> >
> > > @@ -350,6 +354,10 @@ struct iommu_ops {
> > >   * @iotlb_sync_map: Sync mappings created recently using @map to the=
 hardware
> > >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and e=
mpty flush
> > >   *            queue
> > > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO=
 mappings
> > > + * @cache_invalidate_user_data_len: Defined length of input user dat=
a for the
> > > + *                                  cache_invalidate_user op, being =
sizeof the
> > > + *                                  structure in include/uapi/linux/=
iommufd.h
> > >   * @iova_to_phys: translate iova to physical address
> > >   * @enforce_cache_coherency: Prevent any kind of DMA from bypassing
> IOMMU_CACHE,
> > >   *                           including no-snoop TLPs on PCIe or othe=
r platform
> > > @@ -379,6 +387,9 @@ struct iommu_domain_ops {
> > >  			       size_t size);
> > >  	void (*iotlb_sync)(struct iommu_domain *domain,
> > >  			   struct iommu_iotlb_gather *iotlb_gather);
> > > +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> > > +				     void *user_data);
> >
> > If we are doing const unions, then this void * should also be a const
> > union.
>=20
> Unlike iommu_domain_user_data is a union on its own, all invalidate
> user data structures are added to union ucmd_buffer. It feels a bit
> weird to cross reference "union ucmd_buffer" and to pass the naming
> "ucmd_buffer" in this cache_invalidate_user.
>=20
> Any suggestion?

I think we can have a union like iommu_user_cache_invalidate, every new
data structures should be put in this union, and this union is put in the
ucmd_buffer.

Regards,
Yi Liu
