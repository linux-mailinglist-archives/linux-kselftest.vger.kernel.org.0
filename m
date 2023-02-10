Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9712C69196A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 08:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjBJHzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 02:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBJHzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 02:55:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3819C7AE22;
        Thu,  9 Feb 2023 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676015750; x=1707551750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GlmpaTt5SXOwWuyopBTgV9rz7/lm9+uUpWZYbClviBg=;
  b=RFd6GvhRknfyVsleWtlj2RtebqFVJxHNpqsHqPgtHqna7DSJ+In2TYmw
   lH8zFPBbtphm3XkBE9l/lXsj+xsBU5MV6m68+AHnbpimdCsexY3P/Yd5/
   qhUVLfDA4W9UCypFIoA0G97KDvxCvtG4FubP+UAP5SmG94LcQP39fe7WB
   I9Zo8o0ebdLf6yXTamca3nlzSFWjY6+ZClZhAV78vRqelFeF8z/1jHNef
   psQbB81kMqr4KhEYfngopApgRP26oBZ9eWmZxQcIZkysSgbAa4+y2p8yF
   KckF0T80TmBz/ht6lCb8pLyOaAyjFmKiPGrae0sNhTETTfx3iT0OXayaw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328991410"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328991410"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669915586"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669915586"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2023 23:55:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:55:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:55:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 23:55:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 23:55:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9lyFjF/taxUBWMR7C3Yqmfq6dg4SBMz9IcalfGSxLxDiDhbyS5Du4BqbfIDhG3caH9Ky7RixrOcX28lY5/sptbr593yVwUfOH841wklp3NXUQMpFvyzr5N6yYs30RHtnlY1Ngx8sFOclZ9zmLSrpWlJUS34OKGZj9vqaXz/552fLoJ3wV+M0POaBoV27N8GlBe23Yr4YtEngvp98nybgvaygE4mFFaFdwjP0+URsHX+z2T1zFggO//gP5+6Wd020DgW+3q2Hu/sqj+mo4RvWRPYNApL6dXwre3qS/phNGB1Lj4qxIa2DvkfKLeb5aqqbYHhIZbZbgKjZMuaz3ppCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh+Dwc/gL4tRtnBexC028vPAJrJ8vumwkp/cKAqGvMQ=;
 b=XFhDpEUZ9X3UID5soU4W1eVOTkhzfSJ7roPutYXt7zCRC3QTCyX1IJFP9IjZdqez6tiTNgfZHOnIfnyrZZptODnqtiy2xFQ6yoMwaru0fIsVHvuDh40mVP9BudQJFR327zGyfC9h3CYl0VpKcLFnJ+QOz8VUH54bPTFLsn23W9UqqEfKTYJkMvjD/ZWtUjElLNBJB3sxREMhnXGttVYKS4RcqpwnxMxLuq9i1YHbV0fxhJWtFOPTi7ykscU3575xPhWVu6Pb4jlGw7yHPMp/F2UMUCR5D5mkV0+UIfecUTIMUa13PEHzLCS3v1oTT8j62G0wWRrslObGQrCWiPI8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6413.namprd11.prod.outlook.com (2603:10b6:930:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 07:55:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 07:55:42 +0000
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
Subject: RE: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [PATCH 3/6] iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHZPD1Z97vAUws+KUSa8kZdlVER8q7Hy2Ow
Date:   Fri, 10 Feb 2023 07:55:42 +0000
Message-ID: <BN9PR11MB5276F92ABD5998FDD74D510A8CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-4-yi.l.liu@intel.com>
In-Reply-To: <20230209041642.9346-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6413:EE_
x-ms-office365-filtering-correlation-id: 121589e3-7730-478f-3067-08db0b3c3534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlL90a/8tc/1lVBl6o2ccUqHqGJdHhPaZ+zkaL4+57ujzHUG4b9dPz+rWsxWvFiC6Pu3YJrBhAeGd1tVc7G/pE4vX4oq+gVNed9kwOang2dovKT20vL4/zSKUg/2dm3h9LIUXisMKGHqGSOy1BzfrSL6iCzw1qaXt3NjfiwXCwyjYiQHOjgPv+v55PEHC53jfma56eXR4ZWYU0QdbgeVm617IHsq9WXfRGWdJDLx12AWTyfLhimJ5Fj3pE1LrlM4i/bmmmFeE8qOpL+WNMGj53u75h3rydyYQQFKy/5/7NN4uGZHOQRD3CS2g83FyJs3teceb8nPoxVTtrDxI3IimZojAEpNDUZNLj2dc2GHUeR1npfqhpWE7IHXJIcayeLPJ74R2XQQg6X8gOa06eTHoKFGZGlKHDCtC6n+9ROjC+C224D+zLSayBWSELzVdKawvR5IGZj+YKiv7wlaIHEhHDHCHj+5sb6Pe4OsbVT6j/JxVx8T54RVZqlDowykCqW9634K7pcV9rigxX0VsDbAaS4lgSt+6B0fe9Jja/vKCRX0lyI0NAqZpU8IXzqrNlGT5cNCK91pixwU4ht9vRHQVduFQBAQjQcIBpUwo4J37BQsMn6JF8+AyesWFyUUq3arVhY2CChfAd5ui5M6y7Nzi8dg/Br+J7g6ebf51Xz4Dfj7MtRoz0y5pnWsEmSpqS1Vamsvrev5YEx5H2zLk2wRgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(71200400001)(478600001)(7696005)(6506007)(9686003)(26005)(186003)(33656002)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(66446008)(55016003)(66556008)(76116006)(4326008)(8676002)(66946007)(52536014)(41300700001)(54906003)(5660300002)(7416002)(316002)(8936002)(110136005)(66476007)(2906002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kdyItfkweaZl6OdfDg1hId3yPXecElYSc2hK3+Sl2kXJVBPDUY6NeN3aFrb9?=
 =?us-ascii?Q?Ig2+btCjiXiS1sEUfBGJDXGRc3qUsooU0BN96zeMZPOb8lot/Y95/4SIXAdI?=
 =?us-ascii?Q?2OVzYTArlfS7K4/vBLNxtJc60UFshyEdQami33Z6l9NElxYg7ncBPlA74xKa?=
 =?us-ascii?Q?gbWtCKbA3U3GhsgSPmEgcmhGQFvfDIqWHhCP+arPXLB0Z47Y2+sjpA4xUyUR?=
 =?us-ascii?Q?vWsfOgrBBqM5In2sFP0jlh8N6UFsVtEZSN5JPgQo71CzzaOEQidflHBT4YnG?=
 =?us-ascii?Q?LZDhJR70bybAjYl+kC1Y52rUj3Orjjm8dLKzcCrmafExkSdPSEHdKcpswy3i?=
 =?us-ascii?Q?vdfAO0Ai+Jukcuwoc9hGhFv1flfdelYDgrQWtBYCpoMHn+Br+Dil1XFWyAaH?=
 =?us-ascii?Q?mcgB3DxaoPh8nDMECly0G0/c8N7+T9l5CuPv1jCeCuER2fnQoCCWdDIhpu0M?=
 =?us-ascii?Q?xbOkOBc/fam5TteF4FgMupf0DHdGW+neamJMN/LojQJuwDGb97D504FEhJjv?=
 =?us-ascii?Q?RPpgtpmstuFuqAzzBEma0lKMj+Xwq8JLStDl1mr2oQ4RIgzv96EcC7HD/Yst?=
 =?us-ascii?Q?nRQKwZoUWTg17CFUsxKJJwot8zA2DjOqV4SxfqY9NVGGcZQa1MtWzHilPZY1?=
 =?us-ascii?Q?R6Kykh9adxxyxiJhAD51n9ZgG+rLnH4uyH0c1nKU4339CP9YAIe6dEo0oRhO?=
 =?us-ascii?Q?zX/3fWTjCHORs1gp7TRjwnOQPpSqCmaRe75gC1nvn8I+n3KW9b1Pl1zrSv9Z?=
 =?us-ascii?Q?LB8/xAIdxIjBM0tQMqgQ1zIOi3DCVLbuLhKNsR28nzrwPyvaYoDVGxBZhVpS?=
 =?us-ascii?Q?H1SU8zpbssdpU3cYkEc+yVGyuoku0MH0YMfldr11lZMekoMa4EuoT+MGKZNX?=
 =?us-ascii?Q?J24r3ficGPOCL0Avft2TTjZWlRvdZ2NZL8rNbflpCGZPfIDGRcMPdDUpdmt+?=
 =?us-ascii?Q?uewFexx2cNvQIe63I/ISw3RuwPUrJH5g6KjuEhTbI8iJOm1zpR1GU8ZryiC+?=
 =?us-ascii?Q?eRy1rihXbiA0k0gMPUGAjiFSXwygOzNZIthDsjY3KAPmmAIw7e/TI6NToRpG?=
 =?us-ascii?Q?mhUulb1l+C8IvWQIlZ7kCAg6Z6PH4GhL5UF0K2ycDm9RBMYQPRj5vrySG4Z7?=
 =?us-ascii?Q?MPmN8jot82weSGYzTsrGQsfcGhG+sEBAMjPtTpDPKuUfzd3QMpUh2RPen0m0?=
 =?us-ascii?Q?gnWOU0bSc1tY1F0e5cKhaxguYfMeircfnXF7ymFl+mNQ21oPe/su8oc5j2Tc?=
 =?us-ascii?Q?UERwkmke0KDybr8e/K4qLDcm1cBt6cwIylJB6cRKE8gskpzZeQ9zPyKlh0iw?=
 =?us-ascii?Q?YXhRm7WkhTHFXgoD7pkzbQ1pMGoihHKb0ojvAUUI5DGycIlc6lOSnOXeLIxe?=
 =?us-ascii?Q?OUasc0ZTYvKE9SrWYagDlIAoe1idPtVW2Uzlvd5qWdJBnBYA53sySRDB0zXC?=
 =?us-ascii?Q?jCl3He/kCC3pniOSYgB2mUhaeBb5oNWGy1acn2BEHKLZP06omE+rIu2WeYvS?=
 =?us-ascii?Q?3KT3bC8yDCfqv4/JQTuiYR/fk6U/S5j0oc2L3awE/Xf0n0NL21qkjxiA7VIg?=
 =?us-ascii?Q?6m2WSKSOP+n9GVjnJHHhECC6Vq6cKRN/oZLccHVS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121589e3-7730-478f-3067-08db0b3c3534
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 07:55:42.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hchj8c2G1qFwjMxVqOCDsUPsn5W2iXQP3XosL+yMF/ulMI6wTh8bzT1pAQ8Iahd60LoACzHVl07eo7xd6P/c9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 9, 2023 12:17 PM
>=20
> +int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_device_info *cmd =3D ucmd->cmd;
> +	struct iommufd_object *dev_obj;
> +	struct device *dev;
> +	const struct iommu_ops *ops;
> +	void *data;
> +	unsigned int length, data_len;
> +	int rc;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;

do we want !cmd->data_len being a way to check how many bytes are
required in a following call to get the vendor info?

> +
> +	/*
> +	 * Zero the trailing bytes for userspace if the buffer is bigger
> +	 * than the data size kernel actually has.
> +	 */

"Zero the trailing bytes if the user buffer ..."

> +
> +/**
> + * struct iommu_device_info - ioctl(IOMMU_DEVICE_GET_INFO)
> + * @size: sizeof(struct iommu_device_info)
> + * @flags: Must be 0
> + * @dev_id: The device being attached to the IOMMU

iommufd

> + * @data_len: Input the type specific data buffer length in bytes

also is an output field

> + *
> + * Query the hardware iommu capability for given device which has been
> + * bound to iommufd. @data_len is set to be the size of the buffer to
> + * type specific data and the data will be filled. Trailing bytes are

"@data_len is the size of the buffer which captures iommu type specific dat=
a"

> + * zeroed if the user buffer is larger than the data kernel has.
> + *
> + * The type specific data would be used to sync capability between the
> + * vIOMMU and the hardware IOMMU, also for the availabillity checking of
> + * iommu hardware features like dirty page tracking in I/O page table.

It's fine to report format information related to stage-1 page table
which userspace manages.

but IMHO this should not be an interface to report which capability is
supported by iommufd. Having hardware supporting dirty bit=20
doesn't mean the underlying iommu driver provides necessary support
to iommufd dirty tracking.

We either don't state this way if following what this series does which
simply dumps all raw iommu hw info to userspace, or explicitly require
iommu driver to only report information as required when a feature
is supported by iommufd.

> + *
> + * The @out_device_type will be filled if the ioctl succeeds. It would

s/will be/is/

> + * be used to decode the data filled in the buffer pointed by @data_ptr.

s/would be/is/

> + */
> +struct iommu_device_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 data_len;
> +	__aligned_u64 data_ptr;

moving forward iommu hw cap is not the only information reported
via this interface, e.g. it can be also used to report pasid mode.

from this angle it's better to rename above two fields to be iommu
specific, e.g.:

	__u32 iommu_data_len;
	__aligned_u64 iommu_data_ptr;

> +	__u32 out_device_type;
> +	__u32 __reserved;
> +};
> +#define IOMMU_DEVICE_GET_INFO _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_DEVICE_GET_INFO)
>  #endif
> --
> 2.34.1

