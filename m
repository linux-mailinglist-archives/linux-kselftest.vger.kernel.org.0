Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F9617790
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 08:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKCHWU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 03:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKCHWS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 03:22:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADF616C;
        Thu,  3 Nov 2022 00:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667460136; x=1698996136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q/vi0srjax/069InbP/OmhPPNYUr1iRJPCb6F/mpI4A=;
  b=hPnMv4Fjo6o/YeQ6v+kXe+JxMPBM9J7VgWkSlG3PWr32w0nel5JtN87m
   +ICGO8n7JT+BUpjayLkQUScYhPT3eCw/mQk93fdRiVMWqzTHn7FEtPq3m
   4TP+atR21flE3TMu5TH0PyA0Eo97WJML90BvxWcBNnhKNkSjSjAR5KAoJ
   0ECBYlPO8xzwy6YdUJfFP8XXBXorhR9SYu1j8p9sWlRHqM71vCtGu9+dh
   xKpqEE9EWSBgFEodtNNefeA1qY1c5cYAJUFLs5zYKm+IDOOpVELingjbd
   oPVsX6eeHnY6hOSTD/Mef/QbIIW5KDxzJMV+3Twfui/jU+xVX0qZJ0s83
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289320247"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289320247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="740074393"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="740074393"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 00:22:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:22:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 00:22:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 00:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4+u6tgkwgJrMuKb3IgmJqBGiBlNExGY7wJFrlhHngr3ElXntfphw+aTiT7ElfAKZiU9M6jScJYNylZ1bxk+Yi32oTm+vQOibqh4UrXUVDO7aONyEucOPMeC5CJcZ5KVLxF5vdASruYcBrIePFXgdLWlKEVFuTS2HVP6fFNFYCC8ccrUk4o852atOQ2ROHwFJw6Oveu6fg7+HOnFA1+I7VX+ki9nrppLF2IEuX8eacPIJIVRT+IOoVo39uRujE0oxml4pSpBShH2mfRlqrQam2j/nG0TDDQreArllJXl+DwssnBOyi9R6yeYoTKEknjKscWks2s/pPB1fvOELaddMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zCVHs3bjSeWtaHntisJYYBvvhHeaVuyQu/d7+g7QCo=;
 b=i86mMRwrKU8qwGyG4elPwbvA8avj2pj2K4U+4LKpeawhyJuTFGRB84mBDdvL7+weLNgRT9M78HXP0ZEqgKVSrs4cUYsUZ95pmqOrl7F3ij/KxtpTAO2bafADz32TqJpf9UwoLzdi3PbySC2LtfDPq0L8BeZYvteLun8Tig+pSgU4ziKQghDHFNFzYwDUwb7N8wu5xzic5Rw+x4HpXa0W8+hgwYmv+o9vYTdVehP98tOqnwZ9F8D4vJtOAlFOtMPg7rPNtkGL7PKesQGwTlFahQqSIsCu3KrS4R0xXYG271SzOkFPMqssG2zb0o9P56zPDtaimi8pEwjz6GkFQCl/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 07:22:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 07:22:12 +0000
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
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
Thread-Topic: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
Thread-Index: AQHY6J1l+fzigYIKuES69TlzAN4Gb64sufHw
Date:   Thu, 3 Nov 2022 07:22:11 +0000
Message-ID: <BN9PR11MB527695C6CE5BEA4AFACF3DBB8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 633ba8d5-2f7a-4417-e2fa-08dabd6c202b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 068ssBVulA1Am8e5t6g/W0X/+A4SjM+VE+sPcCPC5PPyEBXZHcgHc0d+TybLb9x8ojMBHInUPQSlK6QSSloQVBYHZtaM6gX8ynRvyoOIxsTsThsMnqBARxakGdE52FjptdQ4sNxiqLSVIFaogwHotVZ2qGte86o/NYNaW6rMQhoBxqmyaCo9SLMH9uDNmf18jPnmC/wZnB1+yHV4U0jqvmcuMBlL7X3cF1kCGGZdyfROd+lkPEZKumGHmNmBufzxBZZZvcBG/a5CdDdLyMu+AnCzYQvNlaOsuu+opk4grtai2cowkGXLe9kwJvrxz2Haan9QKONxk3iqW90Yo4ZNq9yiWtOuYMft1l3+qMXZR60dRMDa24wyF9GBNOLvLb9Ozv1JUKgkBgFYRcnYSS25+UIFzJOa3J+TW1iOWTlbIVTObnaNIfwJ7xrxuI3LHeknh7q0vHluw9CjorGfs3IWR+sWnV4McBe2iGkPTGhatdev93dUXhCBrAJJksTti5k5nUuzIHqQLXtLRnJZ/hfXmMBhs7m0iIHVBKi/tw6qFfWC32j7/oAmxvemtw/1DgPf0qqzhlg1igu/RTf4pXTNGOnAZ6heKOsuen1Zh6iIgIZyHg9cnJVhu6h6T6q2k1xjx6DKD8kIlCC2tqUQAizbQxu0cGeZ4+LOmzntOPr438c6frt8YTXsaupmP9Afg8GUM5tqJ70KQEwh9TnSC/jnUmHqA7ADe3P1sk/8oCZnyXDyp7Nz58LDnSbPb6E7yq7vX+1b7ZEDC+RSG7OXVLa2KgQoHgeVHm7O2FrHa6Koqe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(110136005)(478600001)(54906003)(8936002)(66446008)(9686003)(66946007)(7696005)(76116006)(7406005)(66556008)(52536014)(26005)(8676002)(41300700001)(66476007)(4326008)(7416002)(5660300002)(186003)(83380400001)(64756008)(38070700005)(2906002)(55016003)(86362001)(71200400001)(6506007)(316002)(82960400001)(66899015)(33656002)(38100700002)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GcalxYBkK45F/q2P/U5Xt0pU0z7azzW/y9AAiHXYUWpO42yby1ZCfQa61lTU?=
 =?us-ascii?Q?4e/sVFslIQ/l4SV8pRbA4k8yj214LkOIC2k8aSfvdkw7MFp6Bxex72eFOjuJ?=
 =?us-ascii?Q?yDoF+lCIl9c9JhuVkNapZCEFPWIbPeNi32RwbqmMBJaohWu93ErgJqM1NsAS?=
 =?us-ascii?Q?WLVyYo3wcqSFUkDwwVmeLSmEW2jsksRPCVrjlyWmbm+Dlstf8XRHrwx2ZTuA?=
 =?us-ascii?Q?vpLhCu55CJEnGPbuvf+kmJ20Bi1qWr2R2Kjw2BeFOnkBO+zASbWGTxc9pNE7?=
 =?us-ascii?Q?12PYDZol7npdPJkT1zO89lvHlNkuOymO9/6qa2u8QcS9xIWUoelxJ14qenET?=
 =?us-ascii?Q?cjUn7cw56wyXJzzU9++d95fbh/DfqHTcbuc5+MHHWu82dbFO5AXkKyoxZ+ZP?=
 =?us-ascii?Q?9aF/8bTPaPrg6dFpXUKl15uP9+eGuNyvZpvh/PbtgbiE6GmKJdM22yFAKA1O?=
 =?us-ascii?Q?yC8zFmHzCacI4t9t/SiTMpTJl7AXwDicr4lEspichoPZC0CfbVCG65x0cQYP?=
 =?us-ascii?Q?qCIRGGyr9NbHqatz2YAsgpp3/z/qWkrM/gh7/NnLmfbYBIEFZ8gTMSPWGZn+?=
 =?us-ascii?Q?HQUW6nN55ADMU7AUIIop9U9uiI1+kR62sUdWzQ9WbTx5PhYZPImX7zIEiyz/?=
 =?us-ascii?Q?nGQVAVhQxUpmG/1pDDvLwJQMe0f9o1fhcSRRrijoucvDUQ/TsVAXHbcHnn1Z?=
 =?us-ascii?Q?SIkPL448z4in0kNsmZ1YRn3+b4I1lReAd48PWem6ZdTmMMKsb3SDUMozwhLN?=
 =?us-ascii?Q?B+WIMzkgWVOE4Udq6FJVyQBnrlhiGp1UHGFpLKjs0TKh8bcum9NiOUcaDqNs?=
 =?us-ascii?Q?lYGJmhE5kDiRhrLEGRHwSOqbjSAZKLKWdYEo4b8FqO29bE2/M0/q4MnV2zgR?=
 =?us-ascii?Q?3M2ocbIWnc0b1jYGFsKDKKx219wKWxwtWk1xlq06D2lf54G+pG2Hj7ZMLPwQ?=
 =?us-ascii?Q?/Fy6SxT6NCzEd0AvcJkjPiIM7Aykz/KN4VF8SgtGkB5NGOvbLFncWLYODRQv?=
 =?us-ascii?Q?CtJPIzzHIFYdXhZkjOpRA8QNlq2yPSnVGVCHIIfj0BiXGavRtWQZfbPpjXxD?=
 =?us-ascii?Q?vfnbOav8lCctsaOxyN5SUPeT6crecc1elNfPs0o5c7qNGpOXT202nEOagkho?=
 =?us-ascii?Q?Nxqp43N8B2RqtGQ/Sl4G8OBCO6Q1pMgt6yIR+4qWyPo01cBsXpXuUUaS+FNo?=
 =?us-ascii?Q?VIGV+2sgdRp8u0qlD4A2/6hJUZm3zAlYVuMT4DCKZdRLtJf4OmvsmfZ1HaG9?=
 =?us-ascii?Q?6AawAOSJlb2hiIDJE01Ee1h1Nw6MUuP5jveVqII282RwVIFYiAAwSuIegGw7?=
 =?us-ascii?Q?/q3cMATF+zEXDol4VcM3ZJPu/gGrGoxVrPNs0Nd6oms4CQAsAHWlJShPAHeN?=
 =?us-ascii?Q?G0PJgJ0aY2wQ4STE2oYxm4+XlGa1dQYZJU4pgJFAWYhCVfohvajGpYoZTH6+?=
 =?us-ascii?Q?8q8mPYyxTT+e9cBd9eg8ielX9OKqpr0YiGn6mUGdCuejbSFo5CKio8NNGl5n?=
 =?us-ascii?Q?cjgr1LbWHjn4Qb75XOt52qRucM4L6ZuB4LD+uQ7HBe1q24pMZZxi2D05hx7r?=
 =?us-ascii?Q?Q3oX366bP/FlXivfT+FVHrsexzzcOnFFsH5dKyqn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633ba8d5-2f7a-4417-e2fa-08dabd6c202b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:22:11.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtHAscA9AvDw+MHBiCASzUVZWnwMOnk7qteE3XHQrN5wv4NJRsWzyTG1XEx3Ksqzg0eJVFVqysB75TYgeqeUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10714,6 +10714,16 @@ F:	drivers/iommu/dma-iommu.h
>  F:	drivers/iommu/iova.c
>  F:	include/linux/iova.h
>=20
> +IOMMU FD

remove the space, i.e. IOMMUFD

> +config IOMMUFD
> +	tristate "IOMMU Userspace API"
> +	select INTERVAL_TREE
> +	select INTERVAL_TREE_SPAN_ITER
> +	select IOMMU_API
> +	default n
> +	help
> +	  Provides /dev/iommu the user API to control the IOMMU subsystem
> as
> +	  it relates to managing IO page tables that point at user space
> memory.
> +
> +	  This would commonly be used in combination with VFIO.

remove this line

> +/**
> + * iommufd_put_object_keep_user() - Release part of the refcount on obj

what does 'part of the refcount' mean?

> + * @obj - Object to release
> + *
> + * Objects have two protections to ensure that userspace has a consisten=
t
> + * experience with destruction. Normally objects are locked so that dest=
roy
> will
> + * block while there are concurrent users, and wait for the object to be
> + * unlocked.
> + *
> + * However, destroy can also be blocked by holding users reference count=
s
> on the
> + * objects, in that case destroy will immediately return EBUSY and will =
not
> wait
> + * for reference counts to go to zero.
> + *
> + * This function switches from blocking userspace to returning EBUSY.

Not sure where "switch from... to..." comes from. Also this function alone
doesn't deal anything with EBUSY. Probably it is clearer that this interfac=
e
is used for long-term refcounting which the destroy path should favor to
not block as it did for transient refcounting in concurrent ioctl paths.

> + *
> + * It should be used in places where the users will be held beyond a sin=
gle
> + * system call.

'users' or 'external drivers'? Do we ever allow userspace to hold the lock
of a kernel object for undefined time?

> +++ b/drivers/iommu/iommufd/main.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2021 Intel Corporation
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + *
> + * iommufd provides control over the IOMMU HW objects created by
> IOMMU kernel
> + * drivers. IOMMU HW objects revolve around IO page tables that map
> incoming DMA
> + * addresses (IOVA) to CPU addresses.

"to bus addresses".

> + *
> + * The API is divided into a general portion that is intended to work wi=
th any
> + * kernel IOMMU driver, and a device specific portion that  is intended =
to be
> + * used with a userspace HW driver paired with the specific kernel drive=
r.
> This
> + * mechanism allows all the unique functionalities in individual IOMMUs =
to
> be
> + * exposed to userspace control.

there is no device specific portion in this series.

> +/*
> + * Allow concurrent access to the object. This should only be done once =
the
> + * system call that created the object is guaranteed to succeed.

an object is not always created by a system call, e.g. iommufd_access

> + */
> +void iommufd_object_finalize(struct iommufd_ctx *ictx,
> +			     struct iommufd_object *obj)
> +{
...

> +static int iommufd_destroy(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_destroy *cmd =3D ucmd->cmd;
> +	struct iommufd_object *obj;
> +
> +	obj =3D iommufd_get_object(ucmd->ictx, cmd->id,
> IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(obj))
> +		return PTR_ERR(obj);
> +	iommufd_put_object_keep_user(obj);
> +	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
> +		return -EBUSY;

Add a comment that it implies a refcnt hold by external driver in a
long time so return error instead of blocking...

> +
> +static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	struct iommufd_ucmd ucmd =3D {};
> +	struct iommufd_ioctl_op *op;
> +	union ucmd_buffer buf;
> +	unsigned int nr;
> +	int ret;
> +
> +	ucmd.ictx =3D filp->private_data;
> +	ucmd.ubuffer =3D (void __user *)arg;
> +	ret =3D get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
> +	if (ret)
> +		return ret;
> +
> +	nr =3D _IOC_NR(cmd);
> +	if (nr < IOMMUFD_CMD_BASE ||
> +	    (nr - IOMMUFD_CMD_BASE) >=3D ARRAY_SIZE(iommufd_ioctl_ops))
> +		return -ENOIOCTLCMD;

According to the description in iommufd.h:

	*  - ENOTTY: The IOCTL number itself is not supported at all

> +	op =3D &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
> +	if (op->ioctl_num !=3D cmd)
> +		return -ENOIOCTLCMD;
> +	if (ucmd.user_size < op->min_size)
> +		return -EOPNOTSUPP;

-EINVAL?

> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl mechanims follows a general format to allow for extensibili=
ty.

mechanism

