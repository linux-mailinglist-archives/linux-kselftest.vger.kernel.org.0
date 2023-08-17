Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E698977F136
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348475AbjHQHcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348465AbjHQHbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 03:31:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE01FCE;
        Thu, 17 Aug 2023 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692257506; x=1723793506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uDTDl4H86fokf5tngU708qpY4pg8K4/JbcovT8M5w7A=;
  b=K9qG/MniRLG6txOKMQnSScol8xNDUgTDs52zE2H9a6bKBajbtubK93nJ
   l9O18W4lBPrk4fXoqWeiKPkQftz8Ph61QOG1qd0/EJ0DwaEu0bsqF2Ucv
   L/4A/qtsujJb0IbLlhTFe7LPvQD5QPp6YdI3X1ui3whA/MTxR4HxIrLSw
   oHGXIzAjXPMF72Vj+eqZzZDey+xJb0iW3NsKOWdBZ/DETAhRH/ow1Z0Fn
   su5e5nZr+8X2d8arGJeIH+ADblbDzhYz2hilTL7caks4umE0gogsjKkbk
   TXGfCfetIfLfkGCpzQ2kU8Jxv7mOtIDMYCfUZvl1l/lYSbrTRot9ZAtrt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439092476"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="439092476"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="737596199"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="737596199"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 17 Aug 2023 00:31:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 00:31:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 00:31:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 00:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aebB7A09g2jaqFZ4z8TTo3/zhhZ1GM4ABjjxdx18M9XzvqJEJD8tfvlIpGiBJi6qGFViBwYkca4b0GEQiv7/UIM6/5tDVRMt5nLrPoNV/4eq/JR3uwGqSD70eO2vHZjp1yJ6k7tTL638mU3GG18Uir2ookmwg8rlnoJz8/I8W4uC1ycqcJp2Z0urXRY7be/CWQIytEFMJmpoiI7UN4eQD/fMFYDA4QM+AAyaumRUkVEiUF8ACzbWbxiQ0GfIvLoj6YIgk0mi/pG6Fsa5nLyO42rSOhtUa3m8uYI6kkOb3wpF0oZqLccvH/mnMYf07ypI0z3c0X14VwCbHmKXJljEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcbFc6rQJvGkqQZbm2WYvkSuCUqZzLR5+ZWIkKvWhE8=;
 b=l2inPbwfxzQhii3xY42hg1EM6X1QW1Kw8AXZbhzfUTtkwMbfpQUlGxXj4lrQ5BEE6rbYl4IJYAUxM3KfC84gAAXhQ3mSsT5iRG9dYha6bRTZrkouXmijHsvIc9StiywC28pIYX1x04HfS7dj6YwjaBj7+oZqDTQ/YLWpusmwVBXuzTAKhjYsz96KRlrfubzFi+zcCSQIuigvO6r6IjmwjRY1A9qg11rsKjONk1ONa+iSupL9f/nam1NSUo2LrXgMNu0zBVcHg1SFRgkfApgBPdh6YlIwPC7SlsSI9fnolzK49/xDvqNbRc4XijymRmQv7qbOCbgJZoN1Dip9rfUmew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 07:31:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 07:31:42 +0000
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
Subject: RE: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZ0DsufhSnFTBuEU+qdTIcrwxM36/uF17Q
Date:   Thu, 17 Aug 2023 07:31:42 +0000
Message-ID: <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
In-Reply-To: <20230816121349.104436-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7571:EE_
x-ms-office365-filtering-correlation-id: 759d5c6d-431c-49fe-b72e-08db9ef400c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53QRVmfnVBoW8BJdUPt4qnySXEScdsiEU7dMZcCUL06CTdAkJ1HFbMreZVxSWI/ULWmFDSlf/mIkfqo+Mg9lkVstpiLOh2NYD2jwKKjkWS9wylI1JzyUJfY2Kuqqy/JOf9Rdm2psE21yMmd03xHMf3YjvgzICuFy4lWZOI9oJp93hxC3J7/c9zDYoUjHQlHccva1vuUX+nMgG2ShZxQ+cZQjKBmifA/DBFKvzQ2sQHGbxhytb83IxcwSsxZ9FAwISul6wqS82XrHmynpLCKhV28gkDqhrETA9dB47cKKE/BGI+pQILmkvGj103PUUxO5frP7nP6LbDPm40cFHBnHY6eJ9YxRFv/7l9I6IIFd8uCrHjfECTIeb/IXQnY0unYo+mZr1mW8aF9guyIIIvrKIDw6RVL5eQ0gyeDModCp6ixApBlvFJMDhFWvSg2xruCbOafcCe9/osiXSnFz65lYHXpeEEDHCqFMKzcJCvJQjX2+JnWcWKOCAzNWwq/Iq3VuNJ3Gt8YiH6MgGLujK+Yt+dRpzfONjA2mnf/YOU3N60lJv6mp51U5tOXxVvagtSIL8ANNtKeoiN4np4itAIPOjUCpnsPiAmKCPMwRZemQMH340VTdyftq9iNBeUcsAP5o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(1800799009)(186009)(451199024)(55016003)(66556008)(64756008)(66476007)(38070700005)(38100700002)(76116006)(54906003)(66446008)(82960400001)(316002)(478600001)(122000001)(110136005)(66946007)(7416002)(83380400001)(2906002)(52536014)(41300700001)(4326008)(8676002)(8936002)(5660300002)(9686003)(71200400001)(7696005)(6506007)(26005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3QGyWwiRpmc3gEj8Kbjy7gmQizyQwts74IoM0ig4tJCtEk5mrf6hvUxuB11S?=
 =?us-ascii?Q?6YG301F++LqSZo9Zsg/rCkWZTydz5CmMJfYO0k3pFMeKGgdJ67G1ErOipyzW?=
 =?us-ascii?Q?nkK17jkwui06qZCzQD8nJKJxg6C3kCIDlFNN5hRPmLIrlu4fx6HMOPEEBw9Q?=
 =?us-ascii?Q?kDQ4y46jbfnjCF81c7MNdUO6T8DFjrzoMjZCBE0Valymn2bFVpQTXo/DgSIw?=
 =?us-ascii?Q?zJ8SlrIPr5WL81cS0SETkRfhpYaDTtyP/prYHNp+Mxa2JFaFR5hJiAQ92evz?=
 =?us-ascii?Q?QP/G6mWMf+R/HUXTJcwr4O3sYSAbh+tQdlYeH08Z787+fUnFv1TnCdvT3xnk?=
 =?us-ascii?Q?I4QtUSVfDRP4oBVLkHvXhAdnk/N/LZpzlruhkK/dSjuaiWLFf+ZL35KytGPE?=
 =?us-ascii?Q?epokQ8OZKmhDc7dqJpsPOe+FYBAEaYktgUCROHdw++HJ2RcHWWHbIH5H9aT5?=
 =?us-ascii?Q?P6P4XpbBWKaUXigtY+yRBT9P8e0P7xY2y0TPQ5aF8j85tG5gKy43X/Da8vaK?=
 =?us-ascii?Q?Lz4ssm5S02u3nu7x1mBL2qM13AEZEtkLiQYVsy1HRnNPj79WXsGBlTa8Kun4?=
 =?us-ascii?Q?XE5Dd/R1tNl0LzVINY85agfo4XB3KqhgcE0ySZsNBGrkK2yn7OxUSqpfNzx9?=
 =?us-ascii?Q?8QD8DJOIFTkLGi1V7m84fXu8R+mYPatHmpmcAA8V9fTCL8wlMTQ11N7vI4+Q?=
 =?us-ascii?Q?X6KPDMoWXdiqEYAjwfZtN0nuySnxaCRGDE2P7FJjlB/O37awbK3/PVXKt0pi?=
 =?us-ascii?Q?yLf3OX8HLoN178kxdMVQH9k9kHONNNARELM3yMjPkcPhuLgCSl5ByWcJP8/c?=
 =?us-ascii?Q?svc6ebYu8Kbp0rD4na7Wz3F5P0kPMzD3hFSahwblccMwxrUoq9jGEq8wiMrv?=
 =?us-ascii?Q?HXl6EhnZxjLfV7XKmZPVzfUSdjUb2Kp+njsUyryfgE1+y7LfPh37f8AQztgT?=
 =?us-ascii?Q?VLgqv7jG5ka0bueIavFmOTUtcovf1vxjTFvBnIkvlw/FKHEGVDSfnJoD4cQT?=
 =?us-ascii?Q?uFQDiBVsrGgRlBL0sOI9TbeRRUa9thBxps1vVDIwKIz88ZxFJ5tKd6hxwMSS?=
 =?us-ascii?Q?0DARzEJprjWD+crJhobEIbYypRQLNwSaiWrShfq139e6d8jFkMhGW9HVSlgS?=
 =?us-ascii?Q?U8rDT1Qb/8ehm30TTjTukd5O3OG2+gaLeTHQbeELeMW5PDUY+9PRoF+6tdrI?=
 =?us-ascii?Q?qTD5VA2omThCP2/o0r00FpXK9GHWJPDc9ZtvKVO3Tka+ALRH8xJirsikS5en?=
 =?us-ascii?Q?52eLwe8iNhFMKrKU4lM1fI1tgCk+2f5udVyZX02Kux3WBrPY8bLO/AYETNJ4?=
 =?us-ascii?Q?erNFz1llYAdWsRzUcNjFP9XdB6t4QNsd3G9dqI7CH85SKej1CkXnBtGPQd5w?=
 =?us-ascii?Q?4QYDeU8d1olud1/ec713eTeS0HO7wdyZ2a+I+6foZnsBurB2gyVcYZe86ix9?=
 =?us-ascii?Q?Jg95fCKHcKPkvdH7pZEHXcWQmxOZdRNi/d8uq+3ii9dsaVI53DhJRK3D3yn8?=
 =?us-ascii?Q?wFgFn7U7lJc6YP4qQVfiNDCkuguA1CdIjqOl2BH1RU+Wdd5qNVnQtFigARsq?=
 =?us-ascii?Q?BIHG34UWTMrpiN6FKoEYi1nFCqRSNXSXUYlvHoAZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759d5c6d-431c-49fe-b72e-08db9ef400c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 07:31:42.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfdKqWU8Q/r2q/nq0offFONSu3ga7d0sQ05B3CIufh6r66rXKZxybcsN88XSaSnHskdLp2pleiC5r/Un7mlQ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, August 16, 2023 8:14 PM
>=20
> Under nested IOMMU translation, userspace owns the stage-1 translation
> table (e.g. the stage-1 page table of Intel VT-d or the context table of
> ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific, an=
d
> need to be compatible with the underlying IOMMU hardware. Hence,
> userspace
> should know the IOMMU hardware capability before creating and
> configuring
> the stage-1 translation table to kernel.
>=20
> This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware
> information
> (a.k.a capability) for a given device. The returned data is vendor
> specific, userspace needs to decode it with the structure by the output
> @out_data_type field.

"The format of the returned data is vendor specific and must be decoded
according to @out_data_type field".

> +
> +int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd =3D ucmd->cmd;
> +	void __user *user_ptr =3D u64_to_user_ptr(cmd->data_uptr);
> +	const struct iommu_ops *ops;
> +	struct iommufd_device *idev;
> +	unsigned int data_len;
> +	unsigned int copy_len;
> +	void *data =3D NULL;
> +	int rc;
> +
> +	if (cmd->flags || cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops =3D dev_iommu_ops(idev->dev);
> +	if (ops->hw_info) {
> +		data =3D ops->hw_info(idev->dev, &data_len, &cmd-
> >out_data_type);
> +		if (IS_ERR(data)) {
> +			rc =3D PTR_ERR(data);
> +			goto err_put;
> +		}
> +
> +		/*
> +		 * drivers that have hw_info callback should have a unique
> +		 * iommu_hw_info_type.
> +		 */
> +		if (WARN_ON_ONCE(cmd->out_data_type =3D=3D
> +				 IOMMU_HW_INFO_TYPE_NONE)) {
> +			rc =3D -ENODEV;
> +			goto out;
> +		}
> +	} else {
> +		cmd->out_data_type =3D IOMMU_HW_INFO_TYPE_NONE;
> +		data_len =3D 0;
> +		data =3D NULL;

data is already initialized as NULL.

> +
> +	/*
> +	 * We return the length the kernel supports so userspace may know
> what
> +	 * the kernel capability is. It could be larger than the input buffer.
> +	 */
> +	cmd->data_len =3D data_len;
> +
> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out:

out_free:

> +	kfree(data);
> +err_put:

out_put: (since this is also used in the success path)

> + * To capture an iommu type specific hardware information data,
> @data_uptr and
> + * its length @data_len must be provided. Trailing bytes will be zeroed =
if the
> + * user buffer is larger than the data that kernel has. Otherwise, kerne=
l only
> + * fills the buffer using the given length in @data_len. If the ioctl su=
cceeds,
> + * @data_len will be updated to the length that kernel actually supports=
,
> + * @out_data_type will be filled to decode the data filled in the buffer
> + * pointed by @data_uptr. Input @data_len =3D=3D zero is allowed, no
> information
> + * data will be filled to user, but user space could get the
> iommu_hw_info_type
> + * filled in @out_data_type and the iommu hardware information data
> length
> + * supported by kernel filled in @data_len.

I'd just keep "Input @data_len =3D=3D zero is allowed" and remove all the
trailing words which just duplicate with the former context.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
