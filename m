Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1C7CA253
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjJPIsy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjJPIsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 04:48:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4FA1;
        Mon, 16 Oct 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697446128; x=1728982128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHnFSOPYHVs8dc9MIC4twWbOTvo1lyxesEjErklEJFM=;
  b=fDRPA7qk5hg0wcwZMGioa0WPe2l5xBbO6JtK9UX/RqdWBXwnWvNyudy+
   IVKv9zDe/tmJIVr+lCElO5BpA+0BqPM+45rjjx3OwWdaCrRC5DGzs6pmn
   20Osgqlk3IwJj7kHvaJlvzB3r086JLS9eJMeDTpK9QSu/x+/dsKV04iLl
   yo7c4jCKWsrnzHBtmf/1GHmSxEk76JgUGqEMsbFResvjGJ8wyuPrGtUYY
   pKVw7jzLVfxgjdDxpkpf+O+wOUV+Cmo+DR10eqQR7ySqaNF0eNO7dIQ16
   NzIAxRF6dCnjDD8aA0SvdcGoFxlEsgjqLw+2hym2pMz+BqSz0Ajhy5Rca
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384351943"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384351943"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 01:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705530923"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="705530923"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 01:48:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 01:48:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 01:48:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 01:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXcuwJ/w1GUqAl2wI6PfnkbzXjyL/cVYdy99nnKuSaAiMQRcNwTZ/JS4RLAx7j84KVdkD9JMP4OooqdoYDlttIQZGPItuTbUTnb+917TLXNYw4dV6OAgHxae1epAVyvf5L4pJ0F3RDqOmukMCd17UD72hrX+WrY6CGtwUHfByd1eGsc6Qq3Rn4NZxwNoiB7XWuY+pX/CIyT8wP1fDQ+OCsqHCt1Br5MlZPPI8dK7MOgqdbw7sU84cYi1YPVJ1+9w6//sXaEgHBZ1wMJVovj/cGcRpoVfjsTxDAszGLjRlfl3LmE/H8KjObfhWFDdR5lu0GRqFpcQ/PcxYazp7rN5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHnFSOPYHVs8dc9MIC4twWbOTvo1lyxesEjErklEJFM=;
 b=MzGflL6nAUvOmGyzBGw378GeeRJCgI+cyMFA5o0GoBGhE/jhTfTCPzTEfk04sAcLDOgn0Z93RfnnEDO0O7v5DM8zNdcYiotvbitgaQ0wcZ0z3XOyGeURAErcRi3A5utPFeKg3sGs74amZgyTeARQtpH1sJ4aPn32v1CsJtZ4SvsdH6rntPhbZL5Mktwcf3hLJGbu7aA21zrzEl0P9cAp0h4+XMq8VvD7gPxxyQF9YoGXzCOPc+CMnneAdbIiDqC5DpfY6JiVWqPqGBXzU2HKr62PALSl+7wMjC0RS4UjPis9tif1/dGBuBHSWGKqNAED14z72ll/27dTOD4JISFYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:48:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:48:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8A==
Date:   Mon, 16 Oct 2023 08:48:03 +0000
Message-ID: <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
In-Reply-To: <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6862:EE_
x-ms-office365-filtering-correlation-id: f4bb1ef6-c223-481f-ae1a-08dbce249c0b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1r6uUAjiUQi9oPEJKaWOZsgA1Jsn0bYmmhKXweoppY26MUp9lrXF0PyyGpPRuiwhd0iVxO5H2nx2+sqHKhhhI6Huag1ovyhFM3ouCcQCtOOGjD/nu8eRwu9CS5nRtXI/TUMegkZ4M7ry8TFiFKSZmfW1DveCl9PGr/UMcig2WuN6wO1i3GviPGfKfvWE565EUXMKtO8GQNhGOx4h5iR4MdAIcGAldWJmydfyM1+Mg68gIhcyXC/0nRLn0za2rM1G6PpuG/iSsOyegseE0eTR/357SgUwfSZPQHYRnXh3PwIsw9RnYF4uHctoAwiQ5l709/3yWPKrxmvLEF5eAXQFkWxCixYN0NhSILA5/BlpgEVjcNE3rVaMCS19HEvZwgvtkIn1EAuKaqmgECyucYQdVSCkmCZnZbQjfxqmUa7ZvWfqcJuufuS3aHEdEKBou2//ZFTEj3f4zx6LK3o5KvNpNIlJey5BCNOyoHm3hwpVJJBXeBZ0h/rckeeGA351j5cRUMJ9YKo0tZ7177HhVfa3w0YwqVNhQlYv042TabOdgAbPlpvbEtKjU9BdCqVLpGpn1Iu44MaFjcnE523zh2K3e2Y+2g+5HJkEJ45pLyOy9hopwKgFD28We8ZCoi+qyMX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(316002)(6916009)(66446008)(26005)(7696005)(6506007)(71200400001)(9686003)(4326008)(8676002)(8936002)(5660300002)(52536014)(7416002)(2906002)(41300700001)(33656002)(86362001)(82960400001)(122000001)(38070700005)(83380400001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kJbYRwptZd7WGm7NJLJlanwWPBGO5LRyy+6RfWHS3I+8jw8SuiPOgok82wEW?=
 =?us-ascii?Q?2P0gzsVNovWZxFidQuhCtzXpSro+faSyp1KTyRETN/Gi8NXfZAs+AjkXBUpe?=
 =?us-ascii?Q?D3adMTmzAHJlXs93bcNn0END97lbNrE/CcTxyPaGYV1uZZtXcG1Mxtj2ypho?=
 =?us-ascii?Q?KEzN92XktL9yZaXms4Qk3whecFaG++DJwBNvDqKwS/xhxTFZeQ90opwcowhH?=
 =?us-ascii?Q?24OSfM9ljBNhCdbDmqZJAuyPorQNLW6CaImfIBKkdH1yqllQm6L5Ie3DIZtS?=
 =?us-ascii?Q?riHLa+C5J0f0Iy4CfM7OiPoN7pTdI9rFlOlnKhkfxFrU55QdFPxVGVUSnQl8?=
 =?us-ascii?Q?Ll6yRbpnC7ZuKjVCm5jbASzcYtVDotYevFnWLAW5t4+TRhwgSkXVdwe24Bda?=
 =?us-ascii?Q?0i1xSuXs2dLxJpqufoigTD+a+kCn3h/wUwVbkvhk1DxYBCul72A0lKqfDQ2Q?=
 =?us-ascii?Q?e5v1tn9eQMsCqp971X622aYRR1BmUZ3cNVQKWVL6xLMI5Bf9DSGTzR/NwOym?=
 =?us-ascii?Q?8cF9BoNe1smIhfTLL++pglzYEb62kEH5Wa1LlkQXLbeXR3zM8U86FJwO+3CQ?=
 =?us-ascii?Q?CrZ8u/uL3GQ+ji5epcbb5TehldR79fGCpgtQvzWrEoGsFZKzbPH4oMetedHG?=
 =?us-ascii?Q?xoWacIyDT5qH9IFyu4jClDU7GL0CvcCC75KdBemshT5vZcFhQrDdR4JAhdHl?=
 =?us-ascii?Q?C32KMOUOpGTZg8DTwPsFFeylo0GjZzRNBhOrpgq9tfiiVQP9Jv5jxzVhw9aY?=
 =?us-ascii?Q?voeqRcQsKhzM1ttlntK4YUeNUdsqN0lpoKp3tjEgFGtGQE2GOIQds0QnEfmt?=
 =?us-ascii?Q?kRcO+Nh/7uA+JMGNmaW6DnFY5lpsh9V5NDioMYMLE2SEdXUIKfnyHUU5Wuli?=
 =?us-ascii?Q?daMV0Z5S7AiIRK1tOZb0APrTRDPz8LEfHr2Gj3Q8MzI7/59+EWdsKRK4Vthm?=
 =?us-ascii?Q?PX7+wUJXvcvF/zBwxWBYXTUxmta80dQKIGMlhDxgvbkoSGTkWVZrfWXZidKJ?=
 =?us-ascii?Q?HIo2PTE44qCUWiIRzj9RUXouVVY+DeADUKY+gUdHfvDFZYTaxwuiMVQlFcra?=
 =?us-ascii?Q?MEipdVfa0LX6U47kgSYFFIwTX1eHe0SWZ9cEC0hHguWjqQHlh3SRXU0S+zHC?=
 =?us-ascii?Q?0MzFimeRITWCT3XRoRS3/fnWUucgLxnoIyDsN+0nzAasR2BTobwbQjnueo8m?=
 =?us-ascii?Q?y6D+1J1pnCw+263MISIsOWx0Xq/rsDAOfnU1JuUiab26UMiHj5XG8Wl7yxdx?=
 =?us-ascii?Q?Br057zvXf9ohT4kE/Dcux85lGQauZvEYBplPMoOZo3MSc7Njo2F+YFURgmJF?=
 =?us-ascii?Q?c4wJasP277ygSISk5xbcuy94HNKtIrjkTvqc156w/qPurjTOy1ZsQPyQr/VY?=
 =?us-ascii?Q?sIVpjeA3hMzcHQYjSuv3UV5BH97UM0XcUGynYFFv8kmFgDOAYkUuZctb1KdK?=
 =?us-ascii?Q?Dx0nKJVpziId2aoczA0m67YSEXECcCDWaAbCW/XJ8N8RQBomT7Cb0QiKiOV/?=
 =?us-ascii?Q?+xwNGtQMcIMRjKuZpzC34zYYv8KK5ep3eUSPxIFwr31lVieddHRCJ58H/Gf+?=
 =?us-ascii?Q?+LF6uU2CGcZGOsaS9dy2qAzF+KTIqqtCefoQYHJm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bb1ef6-c223-481f-ae1a-08dbce249c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 08:48:03.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7KivQLoLjz7pLYIiT+7f6+3xnh8laDT9VMcqCJXnq/XZFxhZha98nb4RvQTzmfhlio2P0V3w1Xnf3gWRSBZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, October 14, 2023 8:45 AM
>=20
> On Tue, Sep 26, 2023 at 01:16:35AM -0700, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, September 21, 2023 3:51 PM
> > >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > >
> > > Now enforce_cache_coherency and msi_cookie are kernel-managed hwpt
> > > things.
> > > So, they should be only setup on kernel-managed domains. If the
> attaching
> > > domain is a user-managed domain, redirect the hwpt to hwpt->parent to
> do
> > > it correctly.
> > >
> >
> > No redirection. The parent should already have the configuration done
> > when it's created. It shouldn't be triggered in the nesting path.
>=20
> iommufd_hw_pagetable_enforce_cc() is not only called in alloc(),
> but also in hwpt_attach/replace() if cc is not enforced by the
> alloc() because the idev that initiates the hwpt_alloc() might
> not have idev->enforce_cache_coherency. Only when another idev
> that has idev->enforce_cache_coherency attaches to the shared
> hwpt, the cc configuration would be done.
>=20

is this a bug already? If the 1st device doesn't have enforce_cc in its
iommu, setting the snp bit in the hwpt would lead to reserved
bit violation.

another problem is that intel_iommu_enforce_cache_coherency()
doesn't update existing entries. It only sets a domain flag to affect
future mappings. so it means the 2nd idev is also broken.

The simplest option is to follow vfio type1 i.e. don't mix devices
with different enforce_cc in one domain.
