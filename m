Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EE61D846
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 08:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKEHRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 03:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEHRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 03:17:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4931348;
        Sat,  5 Nov 2022 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667632663; x=1699168663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tmKTSbwVmn4Cm+O6n8yBrro7aOathqIHGePsSxIf6b8=;
  b=j7CjwSbaDQ4gToiNTcpVVq7l/C5xNEVxsoU2h8hMvtc7lNHwYIUnB8ad
   z8Z/odZ4CmEQwWnLBdydl2nAQ6mjuc38gfuEFZbOX6wly9rWNaDy+JKto
   8IgG+Dkp1OGA0s2GH1llHlGeydoociZKySFggxapahiMuD/gPpqfZggEc
   J+mqlizfcza+UnyS98HmDP5K3zDg+8RQYVGEYMnIN3ubw6xJZYHzv7ftD
   jHYi1ygivhVm76/SP7IuDPPpgdb1Ph11F0odtDuC76IUUzs1+HutVIbiB
   IMUre+2MRgQ+4BZv6YWOLh1nJU77uTfz4GYW5wOsVM+ARvOMzq0o49rQs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293470794"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="293470794"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 00:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668601000"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="668601000"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 05 Nov 2022 00:17:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 00:17:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 00:17:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 5 Nov 2022 00:17:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 5 Nov 2022 00:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVuc6sT8lwjVO3u32OjZRjYNmvjj1TBPeQ6Fkh/OonhUb6yxCbFltc+W6HkcWALaR3jy4EzqyopLwBr+FoUmtW3Fuz59ZRX4JNpvZRVV0Ql0sFfR7QOeseKgoaSwmiDeUfk30pVQdAnwKm1yu9V9B1Uxui0nfMuZIDUzdroaAz1inokTL+6QoZwRtg/sKDX2fdSBpnQXu16bXDwFfxjd7yZwgfO6eXsfaV7ZZo+ULdgcZWymaNIBEB2Dfcoovtd5TCb/BlyjeyPDzbGTageZ7zPmhrKppQCLukvihGDOkL3UDUAsGTCFnyPagv+BqQwqRugR0W3RY0nMj4NK2OKSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epU3y1s/IxppHTkTaFeWjnEA+Pqa0a9xeQKztzB39zU=;
 b=aPx+vXgkhJD1+Dhm5YoECyiPSbGEXxskAOYW/uJacR4jDcymDbVBkniU1WnFLizxB5iCvkBa4PM3fL4OiPKHsEhmmDs2KTcfoG9WzmxOJbXN7rGasDzYrK22/gWzrgq14puPdkrVIKrpdzgGB0H2eScA6GfqywgTJtQdN2lcfmxv9LBdQQN/BbjuVteq3NlWgivFMKmOiUCeazPR87dD42V7ijFjGonzesMb/2YqXLnBy9I50XnJImxmRcU6fP7PMkcS2Iz6tx2pRjYVrdA55q/zhwfZGbiy/F6MHlFyuUvmUAx0ZHMs4TJjuAA/WF06TguZRLoGUXwopBA5/fMtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 07:17:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 07:17:38 +0000
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
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Topic: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Thread-Index: AQHY6J1oarnsuDEKTkWD4LgWN5EHf64vnT0A
Date:   Sat, 5 Nov 2022 07:17:38 +0000
Message-ID: <BN9PR11MB527617D35DE59BD0EF10F7098C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6900:EE_
x-ms-office365-filtering-correlation-id: 07715aee-6e71-40f7-2f8b-08dabefdd1b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2dax/HB4fGwohHVxEFFrUxevBM05N2SuSIIMoEBiQiQH+aBm3WmY2c0SbbAtce8wBPEmZTly/MghCbr1p2+SRfBkpqoVYjl7TGMGEWrXeYIM2PGUp0MotaUYPEKZgQY5ALh153ty2OV9lWAQu01aiv1frACXdY6Pe0mawwnZ9D53CleYrnuhJMtDJVy1PnG0O+JMliWNbehBJljbXvmBRLludwZsAmgswlsJeqo2ZRo6Y3+DDwMc3M2fl0U+cnW0aCsJtRWNXMNRDND+8+EAHus7O+u0NJnZ85tlP9h/W2d94lnaVRSKm5BUG74Yu1Rr4cvoV9sYXRz2/yKhBKiIdS2CK4u8/1W61zLld4hAMKy7NGwr5zKyQdlBhHmRWJNhyQdUPFqKGRpDV+Ry8Oo/EPgFANa/ExqEonhbnU9Qf0yWaNaY8JKuimczhAyLZCsTOU9NLeB3YsjncZK7Pdb+LsAMZ/dhaGRQXVehxKwQYZqoKe1uOUO3mZ+tIZTxQpgzN0IS5rP4h2HvjEFkkESumjdcf1Ht4s/pM/6I0w5lSP1GuWVI6clOvJ+isj4BrVU0e1n5bHneCRYQLfyFnUAOTsEVCrmqxx5jEbeqZOWV7vNkqkGFO6J7/lyJGdHMWcKSU4zcU17MSTy3/Cs3IwdAvm07GpN/ytu6xVgZkXhCjM4kvvDuTmBHMj8ZsVgBB2lTyzmS9b5AplqpR5qIUgGOYKksbUh+lA6uc+WwnVDiLjuZALXcVvqFv+HFMbwi4O5XvT7CPQ6BIBPo4CwV3R5SpsLeQHKmZaTCjlaLsQ2qtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(66946007)(64756008)(66446008)(4326008)(66556008)(66476007)(76116006)(2906002)(83380400001)(55016003)(71200400001)(8676002)(38070700005)(110136005)(86362001)(316002)(7696005)(33656002)(6506007)(82960400001)(54906003)(122000001)(38100700002)(921005)(26005)(5660300002)(7416002)(7406005)(8936002)(478600001)(52536014)(9686003)(41300700001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PWlSDExll0lJdbgjJk/ULLzSE5qJ2cujbJQwNaSm3qL4e2TVNQZxesL8MJKv?=
 =?us-ascii?Q?yLaNuNipqBEg5vBUm35/M+/8Lo5JRBtuTZI2Hfkt+/43uIgeLZFI1EtBwUPP?=
 =?us-ascii?Q?OoVUfPqtxEfXHTqp7MHmpiZtNHWs1gOzQtHaHmHxqrNm4hbqAY/Km5Z5hJqU?=
 =?us-ascii?Q?oLQH3LYtgXzmP+gNtP9AJ4/BTpIEclAH0U/aSMWCni9DAh1axjvsGZWMXNzU?=
 =?us-ascii?Q?mNjyPTMxoiU7cNcst2WrJG3ILxF/A7Gw8vlxnLAYi7PqJrIn4jn8/sw8k81Z?=
 =?us-ascii?Q?75DM8pzANE3LM2ECmzx5SLlYRcdaKFcxnFoC8uSiOkuJQdH3HPBL8jSAmrJ6?=
 =?us-ascii?Q?AhDDiBrSyRRSZvDjp4eIXDTOkGFRFtZwe1zdjW3JrtFFe439q80xYBeyS01H?=
 =?us-ascii?Q?0RQOTlNifE3PipXiFwckAwZiXXIOtJqQsiqP60nbyccVysIkFuflTzj3ws/X?=
 =?us-ascii?Q?GhtUdS/g5S7boBVaIqOaKaBhbJCYBZY5zRmL3vzQKKWVdJZnY13EUTpyOkJE?=
 =?us-ascii?Q?C47oAqL06ElbjilpgJCZWGow96R+hsQSLfME0MgzNIhW+JakmG8IDn7NwEqZ?=
 =?us-ascii?Q?RGcmc+sAs+1da+y1sL+KH1cFzOocB2OZ1LgqBUf3KrcxAbsCsHaqStnLKIyC?=
 =?us-ascii?Q?2hIIcILWW2XdvNXnKK9nzh1bb7rgLWOFaPiv8j27xFn/8XnsXoC+gd7opJwn?=
 =?us-ascii?Q?HQuPiM7W0j4F4Y11y1qNV44fMAjamf8MbzbueTj/1D52w9Z0/o0lcZv2CtHV?=
 =?us-ascii?Q?KUPDIAz0U+KmO94CFhBqECKmbbHcr3XDBlqD56BeHTC9wgbBch80o2W26Zpw?=
 =?us-ascii?Q?E8t/i/Qp21hEjjxeoWpr11stvkI569dLsedfJ13OaxhaTnuKLMn6gax9KiuB?=
 =?us-ascii?Q?7BtYesGCKWSvhOmyC4k00oRB97XwGSVPW2IpdHvGgLvR68HXo5GcVRD8OZMq?=
 =?us-ascii?Q?l7giT3vSBaaAc9GnHBUyjV1hY4OAPZ9ZnSq86dRnXTLZJyJLt3M16HaR0pA3?=
 =?us-ascii?Q?6ObkCUdgfoCGt3pe8KJl9hIGitybp1neazUWEIZhKxrDUjZ9AXGcmuWgkczZ?=
 =?us-ascii?Q?JIIOA6hKgnUsKhrNfMyyVgXGGwWrNFB+daUaW2QZTP2a3SrWW1GA1k3Pbrn7?=
 =?us-ascii?Q?nPdu7uwrsRuZz+MUkbqiduAga2zKJDq3fYTu2Ncrr/4rEf045rC+UGg7GKHk?=
 =?us-ascii?Q?/3OlslYgn7PwU7cTI5Dkb++VQg2qphz/jKugyxzLMTMwi7jX5tpHFK902uHX?=
 =?us-ascii?Q?2DHswGNtrlGEJfvb8eAsqH/oPAlXvfO1jHiEoEte3Ryndk+KBKu46PIfmAvd?=
 =?us-ascii?Q?pfTNo+YS+L+LFpbZFOB8yQ7PedW/bjo7RaPP0+uE/k5Ja1fhmmDQPulwcvm9?=
 =?us-ascii?Q?bj/ETqXydOdZaskv8rpURucWSg6uZNTEf91ZtWEvPw4kpTC91dhST3Jg1l+A?=
 =?us-ascii?Q?kooIrpHOdq6Bf7W5xQI8yBf1Cag47dYgApaaJwzz0NZ5VdPdWFU2iSc5CzCI?=
 =?us-ascii?Q?yAjETGnQMzRj5DOylRzmuGRLpRzldgpCFRSdmrx/Oj9A5LwzdZjs/HAiYYkm?=
 =?us-ascii?Q?s0LClUA/iw69rPPfYSUtZL1nz1vd0kIoVEcMGENm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07715aee-6e71-40f7-2f8b-08dabefdd1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 07:17:38.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyT8RegBLj7bKQ/KxE42PDrAmkkGSgefaAKPNxX+0pJ14eUBQPdFIe3ScPBYE5bDGx+SOHLv8PKynkf2nqhfqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical PCI device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and return=
s
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touc=
h
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *

Then what about non-PCI device? clearer to say that calling this interface
just places the entire physical device under iommufd control

> +	 * FIXME: This is conceptually broken for iommufd since we want to
> allow
> +	 * userspace to change the domains, eg switch from an identity IOAS
> to a
> +	 * DMA IOAs. There is currently no way to create a MSI window that

IOAs -> IOAS

> +		rc =3D iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> +		if (rc && rc !=3D -ENODEV)
> +			return rc;

I know this is copied from VFIO but a comment is appreciated why
-ENODEV is considered sane to move forward.

> +	/*
> +	 * Otherwise the platform has a MSI window that is not isolated. For
> +	 * historical compat with VFIO allow a module parameter to ignore
> the
> +	 * insecurity.
> +	 */
> +	if (!(flags &
> IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
> +		return -EPERM;

Throw out a warning similar to vfio.

> +
> +	rc =3D iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt,
> idev->dev,
> +						   idev->group,
> &sw_msi_start);
> +	if (rc)
> +		goto out_iova;

goto out_unlock since the function internally already called
__iopt_remove_reserved_iova() upon error.

> +	/*
> +	 * There is no differentiation when domains are allocated, so any
> domain
> +	 * that is willing to attach to the device is interchangeable with any
> +	 * other.
> +	 */
> +	mutex_lock(&ioas->mutex);
> +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> +		if (!hwpt->auto_domain ||
> +		    !refcount_inc_not_zero(&hwpt->obj.users))

users cannot be zero at this point.

a new hwpt is added to the list with users=3D=3D1 in attach.

detach first removes the hwpt and then decrement users.

Both are conducted by holding ioas->mutex.

> +			continue;
> +
> +		rc =3D iommufd_device_do_attach(idev, hwpt, flags);
> +		refcount_dec(&hwpt->obj.users);

with above I also wonder whether refcount_inc/dec are just
redundant here...

> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
> +			  unsigned int flags)
> +{
> +	struct iommufd_object *pt_obj;
> +	int rc;
> +
> +	pt_obj =3D iommufd_get_object(idev->ictx, *pt_id,
> IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(pt_obj))
> +		return PTR_ERR(pt_obj);

Is there a reason why get_object() is not required for idev?

concurrent attach/unbind could lead to use-after-free here given users
for idev is added only in the end of the function.

> +
> +	switch (pt_obj->type) {
> +	case IOMMUFD_OBJ_HW_PAGETABLE: {
> +		struct iommufd_hw_pagetable *hwpt =3D
> +			container_of(pt_obj, struct iommufd_hw_pagetable,
> obj);
> +
> +		rc =3D iommufd_device_do_attach(idev, hwpt, flags);
> +		if (rc)
> +			goto out_put_pt_obj;
> +
> +		mutex_lock(&hwpt->ioas->mutex);
> +		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> +		mutex_unlock(&hwpt->ioas->mutex);
> +		break;
> +	}
> +	case IOMMUFD_OBJ_IOAS: {
> +		struct iommufd_ioas *ioas =3D
> +			container_of(pt_obj, struct iommufd_ioas, obj);
> +
> +		rc =3D iommufd_device_auto_get_domain(idev, ioas, flags);
> +		if (rc)
> +			goto out_put_pt_obj;
> +		break;
> +	}
> +	default:
> +		rc =3D -EINVAL;
> +		goto out_put_pt_obj;
> +	}
> +
> +	refcount_inc(&idev->obj.users);
> +	*pt_id =3D idev->hwpt->obj.id;

What is the value of returning hwpt id of auto domain to user?

IMHO this will add more complexity to the life cycle of auto domain.

w/o allowing it the life cycle is simple i.e. the first attach which doesn'=
t
find a matching domain creates a new auto domain then the last detach
frees it.

now if allowing user to populate auto domain similar to user-created
hwpt then detach also need get_object() to wait for concurrent
ioctls similar to iommufd_destroy() does and more trick on destroying
the object.

If no big gain probably hiding it from userspace is simpler?

> +void iommufd_device_detach(struct iommufd_device *idev)
> +{
> +	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> +
> +	mutex_lock(&hwpt->ioas->mutex);
> +	mutex_lock(&hwpt->devices_lock);
> +	list_del(&idev->devices_item);
> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		if (list_empty(&hwpt->devices)) {
> +			iopt_table_remove_domain(&hwpt->ioas->iopt,
> +						 hwpt->domain);
> +			list_del(&hwpt->hwpt_item);
> +		}
> +		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);

this is always required. not just for last device in a group.

