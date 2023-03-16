Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D08F6BC8F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCPIYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCPIYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 04:24:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE451C93;
        Thu, 16 Mar 2023 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678955038; x=1710491038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jVBdL0XFr1naU3IObSIrrAHbKdK8EouQ9dDqdd5/zRA=;
  b=kC/84JE19ev0mBjxnlHlTnTpuQ9Q3RFWXzfylkGJFqAM1BBu3FGW1igM
   OOVsh0w9C4P5OgwGXK0OMsUt1A9dam2pMofipKFedi2CLXQM1RTtt/cjQ
   GiPU6K322pGN5ECi0NHKzGEp+q6oPRQKkT0Jw0Eq6vXkDvjuYTss8FoPr
   zOuQSXkhEv8DywysKhwZGA9+7V3mAfaE77FiIrgZChPDB0FCE4kwQxwlO
   zxXPXM/LIO2dWlWVb9GlyREIuNN0jRZuxLEZSthZOJ3sdf5qzAgmLUZkJ
   +1+qR6swVJ/fW09WhH9+vCgt6RIE5A7xtYCqHahOyvxRUNPAJLlWQ7BrR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424196624"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424196624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="803627863"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="803627863"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2023 01:23:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 01:23:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 01:23:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 01:23:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 01:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF44wwUf2h3dMAPW5Iv2+yZDPuQeIhiposANT+CeSU0+7xQdNGvM2pnqogIrKyujk3muDs68rcr7dqSASU/eqPQwbAyO1Q1snPAPXGHjHoEuwTHqvwvNyjlxBZlXAyyBWrpF8l+sQZOwlpz7D0lVNZGsqK7ZrAU+kYsyLihP5fYumd9VmrptCNYd6UHkG9cMh7hsV3Lpm3wTU1YO8Ko6du5PIkb1uK4BTCS9Hs/uShVGuouLNyyXsaiOOFVSTtxoN9QCiSFqs34h4Eti9S1lJ6N3wgl9WuT7fdq2k3rp5bWLPJH7E4lT2YyM1QkHfW+idLfKYULdqfjkKZC32AKopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HknJftGCC2V+DdjUbHBOJsHKNSFr1lChbkJcm0Dgfsc=;
 b=bFj4j7L+oK7beOpoCtJ/Zmy7OXO5nieUMx2ngoTRvyN4H5iNmPHzka+NfhELXOu9IP3RnL/oowafRNyjqfrociyYQ4kX+mn4Lx6IghtT6Fkq/L4T6BsrcozbaY6n7A13neulzmdA61fQI7HRPaaLtatMFjNq+p6z2seNa2hELnslz2rmbjPtm9qWvwR1XsZRF7Pw3KuS+8XNU6wDhovSgABwlWexzGkCLwgu0wNbU6EgtljWW3pXgLj5paDqhgf8zlsPdcSMTzYGg8fooYbtHFRFSAKIXnZmM00T/uRpF7lwRn7mzNRzd9oTp/GxVpPDMNjwW6lDViEdPj05VyyWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8389.namprd11.prod.outlook.com (2603:10b6:303:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 08:23:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 08:23:53 +0000
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Topic: [PATCH v2 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Thread-Index: AQHZUlxVDkh8beMaI02zD0vtkEgra679GnGg
Date:   Thu, 16 Mar 2023 08:23:53 +0000
Message-ID: <BN9PR11MB52760328460ADDC9728637588CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-4-yi.l.liu@intel.com>
In-Reply-To: <20230309075358.571567-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8389:EE_
x-ms-office365-filtering-correlation-id: 5e4e5ec6-1506-42d1-ac9a-08db25f7c725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMd31nXuIMCJ8I4szGeWxK35zwF6IN2v11dIcMUlHrjtimd9ehTSjkbZ4Knpb2uiysEJySPscrdNznqDkTFyZOxK9JGmow9z8F6dg4jVUnIPe0CX0QlXJReAJchZadMOMrMb5ZgUEixs43zX7r/et3el43D1BYskm1IkbeDw6RbYvGVzCK/r4yAia58WiflY1fsYgBSKTHwHkXSN3Bi2oiK8IECg83tRQPZF6l6iQQCAaFye9I77wePBkVerrUmtNrRWN3jSaiN4P+wJ72SvjjCLdMelOkkbp1z7Tl/19O+7+elfAfE1AXHtfaaUo0cYNTNY8jN0LXPeikRfO8+XqOCrBeAFheqm10PnJ+Ebw2IzN8qQaioDey41kTeoYQOXUwrSgJaACz/BKWQmgtyTJN2+J5e3ADcyCD/wg2EaxX5XNT9S4RtYuUoccmp3HJ5ZN22UCNqB/09GdQmvMdcBYzCYGrExO4qwkHHMGb6qLc0aVsmdlaEi5uAvxK4gjuVQdH10sxq4hUtKgz487l5xLrTyws8J9DRUxh1IYz1UNcAM2+RoXHcGkTCcND6a7jo79rhbvzG+AQXOSUFiR9RWS9LPjyu4tTLI+4leLHJqqC13HMI0/tBrdfe0SzWhjtQBhTy0RbIK8P3G55yIDgj4/Ckr0jmLG2hfMtlCi5vvE+iY3nymk7NF8zb0eYoJBmlYL9zPQMiJrP72uA6HpEq1kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199018)(7416002)(5660300002)(4326008)(52536014)(8936002)(41300700001)(55016003)(86362001)(38070700005)(33656002)(38100700002)(122000001)(2906002)(82960400001)(8676002)(7696005)(71200400001)(478600001)(26005)(6506007)(9686003)(186003)(316002)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdRUs33/M5SnS73hclnDiU5kZlYoClUyChGvtbloeGXD949UPdTgo2opJSoo?=
 =?us-ascii?Q?jeYa/zx4UQQ4bsczru8n5+0abSTJ+Ji8VWqKCFFOUSmUL6Qx8WT4rZjpSPz5?=
 =?us-ascii?Q?YsjybkQRGlf4PBip/o0jz6493oxzhTUwROnIaAW7MGMVsWDYflrqDOtQXeOZ?=
 =?us-ascii?Q?9ICk3fLeSBLogWapn2ET5HXFXgBHRDRWMm8YBBG0iYaLEtJwnpfWlYMl5x6s?=
 =?us-ascii?Q?ujl/cOsB+DZrHlQMt/s3ei+SZBG3gxUP8Gr2Aal5p/X81GnIrx9VspZUPNKJ?=
 =?us-ascii?Q?W1wxL13CZ6V8gb1WI9C1FsWcP9SdQ3lz90wUE3qeDCE33tcG5QuQfdwXeSCr?=
 =?us-ascii?Q?XSwouc3JO/IqJQxELupgokl80sz68pT2dQG+WvwBAYohBo+f9uHGwnBrAIYb?=
 =?us-ascii?Q?qVAaxWGcfl1Y35SzJmxKf8HKKjZV0FaWyNfhMQXZp1VY58y87xgE0MWVArze?=
 =?us-ascii?Q?SY7xlQEygzI5ugX0NdUprVE4Nsh8SZorSTNPC07rzFizN9WpH0mRMbb5cuIG?=
 =?us-ascii?Q?AWCMOChTFgC4hCVVatouLgG+fZCW551LwRB2jEOAHoeCuO1KK4b2xoooo50V?=
 =?us-ascii?Q?FCyNvl0ZiWcOC1fndWSeKIWVmVYTm8JObSZ3mWlo6YvUociNGgcrkSnJoBFt?=
 =?us-ascii?Q?nZ9N8FGyW02Vc7oQ437oE1Md1nTd7EOrT1gx5Gd3nDZs4R5oqhagWSxXrgQa?=
 =?us-ascii?Q?ZaAqaQLsmGXzcv/L05W1zjza1JcS4Hewe9nHSu3ZOkxfBKI77KMuBb+kVci8?=
 =?us-ascii?Q?rsqhWewjCkvEYFx19NntCFQKfqaHuOPWfCsU3LX5oLCudAXBRg3eV8UnVgLq?=
 =?us-ascii?Q?ht2gUfCsi/c0Q1++tNnGLJ69z1ZfEbMELF6hAmQD9XfiXYMK0KLgoflw/zFc?=
 =?us-ascii?Q?syxI7WO8ugHEY4peeMOWq7rdSt1SRpPv2qbw2mOepepDpGRDLlRctFvZP/QN?=
 =?us-ascii?Q?lT00TlRjs6tRS3zwJt0dnqMIJjyoIWjTEYwwoPgzCcmVbuAYBnIPoI3j/lOo?=
 =?us-ascii?Q?aWIlJU1YGkykEOVEvNJtDN7ZKVOxJYncW30TXYDK/x+7dGmvWSMpCgIdxEL7?=
 =?us-ascii?Q?yFnKjq3BXbQ91tJ+3ngacg5TsaclZaROxQSeG6mffvvDq8alTF4NZhMaBl4y?=
 =?us-ascii?Q?y+7Oyy9oRHHWFVdoGB8JQEDc03/NlU90RjzFK7RQyIx23n389+hfsoRMmz6D?=
 =?us-ascii?Q?5NUcXmfBeX96UUW0JLaAe36BztWUNC9ekSbR6ngIzqgBggri4fb0bOUmnI3p?=
 =?us-ascii?Q?U0fHF+i4fzBL7GuPXF573OzRq+17P9eEvBLNWQmZ4aB+e3ZpJT93izi1i2TX?=
 =?us-ascii?Q?Y2mu3oPMy2M8yo7roabDDSh3GDgKbBRlAJAnipbKm/pFVfuvqucXLWXwDyns?=
 =?us-ascii?Q?arLRpKQgokz+7Vjs4CDuVd8PnO4cUP8Q/c6h42pKgzUMjaHeT4lDvWp3nC64?=
 =?us-ascii?Q?HWjSI7DLspeYbxSzYMnOXnTrXUYsFWLb/R7yd4sGQG+tUrh4W2ZmeGIGRNOl?=
 =?us-ascii?Q?wppRkrq/PIOdl2OLzREgxA4reiCJN2FkcmpQKV6lorqzRVqMH71j9j1vT2QO?=
 =?us-ascii?Q?3LOBJN8XCjudTFJA3HZj6OBA1pkOhLqV9K90VWSe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4e5ec6-1506-42d1-ac9a-08db25f7c725
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 08:23:53.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6P+Dj2n5U2HzHbfZvc/xVOaqrcRy1XbxFqMv6mRBoC2L2Aim9QJwtEeZgf94XnFMM1j/1p4ReSu1KFUBjo8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8389
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
> Sent: Thursday, March 9, 2023 3:54 PM
> +
> +int iommufd_device_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd =3D ucmd->cmd;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	void *data;
> +	unsigned int length, data_len;
> +	int rc;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;
> +
> +	idev =3D iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops =3D dev_iommu_ops(idev->dev);
> +	if (!ops || !ops->hw_info) {
> +		rc =3D -EOPNOTSUPP;
> +		goto out_put;
> +	}
> +
> +	/* driver has hw_info callback should have a unique driver_type */
> +	if (WARN_ON(ops->driver_type =3D=3D
> IOMMU_HW_INFO_TYPE_DEFAULT)) {
> +		rc =3D -EOPNOTSUPP;
> +		goto out_put;
> +	}

ok, here is where the check is done.

> +
> +	data =3D ops->hw_info(idev->dev, &data_len);

if we directly return type in @hw_info, this becomes:

	data =3D ops->hw_info(idev->dev, &data_len, &driver_type);

> +/**
> + * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
> + * @size: sizeof(struct iommu_hw_info)
> + * @flags: Must be 0
> + * @dev_id: The device being attached to the iommufd

"The device bound to the iommufd"

> + * @data_len: Input the length of the user buffer in bytes. Output the
> + *            length of data filled to the user buffer.

s/to/in/

> + * @data_ptr: Pointer to the type specific structure

"Pointer to the user buffer"

> + * @out_data_type: Output the iommu hardware info type, it is one of
> + *                 enum iommu_hw_info_type.

s/it is one of/as defined by/

> + * @__reserved: Must be 0
> + *
> + * Query the hardware iommu information for given device which has been
> + * bound to iommufd. @data_len is the size of the buffer which captures
> + * iommu type specific data and the data will be filled. Trailing bytes
> + * are zeroed if the user buffer is larger than the data kernel has.
> + *
> + * The type specific data would be used to sync capability between the
> + * vIOMMU and the hardware IOMMU. e.g. nested translation requires to

s/vIOMMU/virtual IOMMU/

> + * check the hardware IOMMU capability, since a stage-1 translation tabl=
e
> + * is owned by user but used by hardware IOMMU.

"check ... capability so guest stage-1 page table uses a format compatible
to the hardware IOMMU"

> + *
> + * The @out_data_type will be filled if the ioctl succeeds. It would
> + * be used to decode the data filled in the buffer pointed by @data_ptr.
> + *
> + * This is only available for the physical devices bound to iommufd as
> + * only physical devices can have hardware IOMMU.

not required. User doesn't know whether it's physical or emulated
device.
