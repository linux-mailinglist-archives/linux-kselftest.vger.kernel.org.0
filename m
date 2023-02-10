Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A21691932
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 08:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBJH3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 02:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBJH3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 02:29:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664F6F8F5;
        Thu,  9 Feb 2023 23:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676014130; x=1707550130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7eiEy/Cob1WKRWDdCtsX99ZVqWJmVv09IlP2Px4UvP0=;
  b=G1/s45+0FFachMd4DQ8VlYIAeXnulBSThrYG3lDXHzLZFxN1/NoMjxAl
   SMQsooc5OekhRQVKschZVcASONWbqyLjgTkQoTWhpgM+iN1yl9EQs4f23
   WmH/fn9S8NOJTD+phFadYHc+YaiVH56GIB47lOUbAB91F4F6yT0fGSwKx
   k14zj+XYXfDt2llPN122Pfd1awZsLgUcocRhABS4nEh/AMMyqO7JSgyVf
   hP2Ja+IxL8rma5qFjLpBj1dInkU2E4rwB4F8JJvoJNbBgbWXa8Q+1iNj3
   Z4VRSaWGKhwgFno5rc17gBjeA4Lc+Kc+aaY/0Ff7XG3Di/Cs7UCFtPNhZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331661993"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331661993"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="731641906"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="731641906"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2023 23:28:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 23:28:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 23:28:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 23:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+NZXAtsFk5YFYWZ47uAJcAwdVN/earParAB9XyQpKQn+CocrE61G794FMIQp5Nc+302rM0EDzl3Cgds+3GV6IPuueKvgPDXxUNPIqIux5uOBoILGftCQOERS0lug2aQSZu2q2S/m9uEfFbKANwaKUZXDB0ME1mg32TvG+RNDTfelR45lK2nnW8BYORl32xD/OyypLI68aoiyRNb05Q5KzrktiFbggy6G7yLOY2fGslZafUylRq1Exu5+/B2gE/dildeAfhnutexystZEA1sZmGgpAs7zR52yuTYFXrWZ8f/FgX6s4KgOekZR2gtYo8PyqoAWGjvUoDkk4+6KXkfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfkJFa6DF5gQMiEY1UP6ocfIg7gygzDzMnOptmoLLtA=;
 b=QUH/69UxxSLLxiozyGlKb/attgcRdLivgk1JBItKXl4/00D/Nu1/omEeynmpkcCLAriGJfXDCYvtRo8QtXbj9kFNfIxnxJraHf/fXYxdFLNENmC8yI3ccwnu3KIDexBvkoNfMhnhZ/tQdhLBAni+nWIe032YuMfS1Y1dk3N8X9a0v37SeONp4Mp8C6vf+10OXqpyZQ164rkbHpWkzytNXkpmsXDie71FTSExcFXznC6lfXlNJJNS0phqC9ZCi/Hg+vf7afXqNHaBvx0GT7YYWAMDorBhzH1MEffjsxiq1QccK9STwkFrdlPqQNiaBdH5CfyV7rbdu+jCVe7u1jAjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Fri, 10 Feb
 2023 07:28:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 07:28:30 +0000
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
Subject: RE: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Thread-Topic: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Thread-Index: AQHZPD1VEVujMOhMCUmoab2cFB5/6a7Hyazg
Date:   Fri, 10 Feb 2023 07:28:30 +0000
Message-ID: <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
In-Reply-To: <20230209041642.9346-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6109:EE_
x-ms-office365-filtering-correlation-id: 362b626b-fa9f-4a5d-f653-08db0b386883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gG8XCiJWJVsCtVGMzcQJLXYfy1UTc9ZOMsZIdwlxjCwLg3dwmRFjpdV/XmqiSfxXVxY3xzD1mZIkBH+ZA8vSee7Ey9xkCeOntdbS8cvFg8RlZKGba5xkMnDqzQRQjqZHL9xYUBDfJ2DmGW1DIbNf9qCHeRQsFosLFWnCboQdLti1K2G+I96m841TdcWr9IQZxA6/qJwnFwEzthfcdlmr7KlMiLmCLF3i17Ls9L20JN0FfujIPmfEHZp05TCrkImJ/qrzG1YN0Z+yj0g9SvktHB/zeBYLFtRcBf26C3MitEUfLkTKMCUEIW1HxXmgIQ6hGLb3kw8PBG5OTV+yq+R2q0X2Q6drZZ/OyHhBrrm6p5ZBoVpzBYorZwzT0yOfR86YN87yV0GhU8Cn5LBdEOMYRBeKyonPfXbUD9ljcl/tgYs+BPpd6wHnSCllotI9IHXhefcvCf0E0khhF9kxzBysB9xBpUVCcEk3W0RAFfth+lXrVVwp8KaMz2YUw87tITG+zb6bWX6DCYdbE0MLV/C6rvLpQ1feAcMlxiaI2yC/iuoLYC0SZc612yWFI6PcM72njN1rOSvHVcLT93MQIWuPfATj7xNboBSwCbF3yIyoB8uBtnjtflnYKbtRdyIcT1tlepsZsQ8SEjzQvJkPeWlJQcLtqYGJHrQdakjQTXQcI7szEqtAz9+tZnBrI4XZW2vzDK0scvquPBm5ijAFF9FlpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(52536014)(82960400001)(186003)(26005)(38070700005)(9686003)(38100700002)(6506007)(7416002)(86362001)(122000001)(33656002)(5660300002)(2906002)(478600001)(8936002)(71200400001)(7696005)(64756008)(8676002)(66446008)(76116006)(4326008)(66946007)(66556008)(66476007)(41300700001)(55016003)(316002)(83380400001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1HnNMi2isSF0yI/sorMCfpfaAl7yuQr3ZsJTSk1GTMYR7giJGlC+vMHpBOZx?=
 =?us-ascii?Q?k6Lww0qQoyoSZgRmOTSFVdFAlSKEjchs0yovrJUGzXDcwhQImSR7Jdhk/VdL?=
 =?us-ascii?Q?CXfD0hGhuzHB3zoS3Fc4GBSWXE8bp+yYfb48NoxL1jiIfzffTlYIZ1QAo6Dh?=
 =?us-ascii?Q?HOtmidjoggAHJiulK/8UEjql8xnQKYvKTwRk7lFevg+P04o+d/4EHzPxH/KR?=
 =?us-ascii?Q?YXVx9t2o2HxEdDeZKYYU0RLhrDRe2bm3F7Hnb9C0y/cLPcwrcEkEPXngWC8A?=
 =?us-ascii?Q?ZRP/E2iLACEJABARz8Z8gm5Xl5dLRzTRzMVD14i8TbPrnFxrLM5mVEBAp/n8?=
 =?us-ascii?Q?fzaGBDyB4zBekujZm57VfYnbB+kTbl58lABnTdZAQD7YmsgDT26DVLyb1vNH?=
 =?us-ascii?Q?hjlwVUpfSCGzn6hckjQYvv4hZXXX/AI/czH6O44xfmpvkqb8OebFAFeI4oxn?=
 =?us-ascii?Q?NxnoCfcpBqa/IdWbdTpwPKnZnEL7fgN+sNvv0lXsvD+TV0S00cjFUpNcVsH7?=
 =?us-ascii?Q?T9jO6Le5zwvUBMFH0mgE8eEtKeLfmOeTtKspcUmAGxVZ43SoBX4PwfidH9/O?=
 =?us-ascii?Q?RF3k3zhkq0sjYeqs0Yikas2IWMTXiAFvlkxW2oxQcm8aiXdhz24ee2zcFnWa?=
 =?us-ascii?Q?JEI5rr1uM1nngeqHfCP5OSWoBkgSRsSsN7ZbPuG/bZQFiY7gSgWE7U6sM87z?=
 =?us-ascii?Q?F+5CPAmaxUQXZXctfTmgvVD19v+TXkAN32xDAbFRe0c2XgVvR19Ku78/YnAm?=
 =?us-ascii?Q?HQpT0cPNa3ZKECNCYYYaIAIqjrkUhl6r1Lb14ehIXGzsrJp7XxLd6OiVfDf9?=
 =?us-ascii?Q?nnucD3cjmOy91LK1kBDt7atLGivz+RC+gRjKmSjbj1U/kjYdv8poSujHfQ/V?=
 =?us-ascii?Q?hhplkw4n3ubgs0iqO4JkP3nDMU79v9Fbem3BECMaRcoa20ezoU/YUR355gOS?=
 =?us-ascii?Q?SWCaAwretKPSrMmU15xbzcar7COG9LMLwJZaIn7ErE/WyY0IU7Uqo9Ns8AJg?=
 =?us-ascii?Q?6EWzXYx3MwO7oiwwkt0FT5xw1W7iGGgxOT/42bHrCwVEjXwf0cOQVU9UkgJ8?=
 =?us-ascii?Q?RNnQRYNADISZAOp1g1+rR18oXl3CJcu8xwKlKphqBTFJTRxqFUws9LpzqsiC?=
 =?us-ascii?Q?M9fvKB740y+WL9DUHJIXisHDA7bvCjzPsFJyImCLVFx7E7RFXFtKtpgGxaxD?=
 =?us-ascii?Q?+VjPBaN1eG8rX5Xi8wjG0TSaBp49E13g3ZiaZR5Co/BKZWQ5SROEQ/ZTXWGI?=
 =?us-ascii?Q?xRr0gUIf6RrH6Zux+yEjqyAsIG/1n9qKuxd/NnnZxpCLvSAoPa3LNd37jNzh?=
 =?us-ascii?Q?7045QSn7MJ47TF5seqvjga3UrFChgjF7J/DyKf45eGkVpC0HHCWl/2xPF7yS?=
 =?us-ascii?Q?hYKVL7POaA3kVF58C65IL3iyPnbJgN5wBtM8ine5CBMETlG4LdSkx9blX6oS?=
 =?us-ascii?Q?h5th9IWxktZR8+RvSDnHGzqeHmDlx+yz2EqfYuBbmM2q9lFCKx0zJeVGL+1W?=
 =?us-ascii?Q?AuXt4/uwpxHsfgTUhUvkMs4R0tGQeR5/vJsvmFFEfSb5UWOcA7ICG6eq9m9U?=
 =?us-ascii?Q?r6pXEH2GDqLjCeDcZfGAm9Pq+C9UCPjWRbLc/exo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362b626b-fa9f-4a5d-f653-08db0b386883
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 07:28:30.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfqlTVE0PCeMeLG3Exhnxr3iO6TgxsPSafqUON6ydlZqR4MQ3sT0bcAyIBxshNsd/KkdRB3fFYRPmvLdPXN/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, February 9, 2023 12:17 PM
> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>  /**
>   * struct iommu_ops - iommu ops and capabilities
>   * @capable: check capability
> + * @hw_info: IOMMU hardware capabilities. The type of the returned data
> is

is it 'info' or 'capability'?

> + *           defined in include/uapi/linux/iommufd.h. The data buffer is
> + *           allocated in the IOMMU driver and the caller should free it
> + *           after use. Return the data buffer if success, or ERR_PTR on
> + *	      failure.
>   * @domain_alloc: allocate iommu domain
>   * @probe_device: Add device to iommu driver handling
>   * @release_device: Remove device from iommu driver handling
> @@ -252,6 +258,7 @@ struct iommu_iotlb_gather {
>   */
>  struct iommu_ops {
>  	bool (*capable)(struct device *dev, enum iommu_cap);
> +	void *(*hw_info)(struct device *dev, u32 *length);
>=20
>  	/* Domain allocation and freeing by the iommu driver */
>  	struct iommu_domain *(*domain_alloc)(unsigned
> iommu_domain_type);
> @@ -280,6 +287,7 @@ struct iommu_ops {
>  	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
>=20
>  	const struct iommu_domain_ops *default_domain_ops;
> +	enum iommu_device_data_type driver_type;

the enum is called 'device_data_type' while the field is called 'driver_typ=
e'.

btw this new field is not documented above.
