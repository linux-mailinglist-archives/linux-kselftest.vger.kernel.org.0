Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99300625321
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKKFiE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 00:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiKKFh6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 00:37:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67D716CD;
        Thu, 10 Nov 2022 21:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668145066; x=1699681066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sX9Ja+Y926d7iZ5+akhiZVG21OURNYoPZmCwTijDzyE=;
  b=G+V7RmZLoe/2+/RYhVepPczpq3IrxhCqpGJXZntk5nmMjvMaEqoxdJ6i
   eYzI59zNWQuKChRF9gjCHE0b3D9DS0gVLF97xTQfnL6yrcSnadH6XCZq3
   dxb9WK4AugHG2ydoWwddtcaDsP9BUngk52St/UfTtOUJMdw1+tte9q8hJ
   Fu92kjLjrSgYly1+Q08y8cAQokSJznh/K8HTHXFJpRyCMRL559YNPVV+3
   d9M4zYMVwLgedtknCPTe5Xbv/2d2E7WVZ1MjT30z8y19VLJsIBkx3mDQb
   SpN5lgCnj1a+bLCgL4T4/qeRIsOJNJP+9Zbwh0Mhg+R1nn+OGhzUlZOgX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310243206"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310243206"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 21:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="631930016"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="631930016"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2022 21:37:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:37:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 21:37:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 21:37:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqGoXsqKP7WZvPkjGjscj8HWz1T+4BZgSvZVQtt1cXlBsACTkXtfqlSdfg+zgFI5kj4fzvEOU3pDuhyB6QYyZQ1JYWBuLfsNWsftRDkAhm1ZUJiq2NEb75vbBYZC17R4C3Rx2gJR9xDg0T8JMw4ktq1kOUB01Tx9ESZCmbqW6PKKwCrzibG7APnerxWCpus2zduvpK23gFBjs12qgASZfNZbukfWhyv2ao2zLEIoHnqu9m5J3F6yYHZIrC7Rd+bR4FFiEE3CQjdaFdW6k+lFdclFCR4L2ipzUKI2dn+msr0CNjKbdcXu97iyM0iLsbFbxGogChB2B1wQQXW0cDBvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISZlFgV4OxaS9OL242PMlqJNGAFE6cqmOEghE6wvkk0=;
 b=E0KMh0b0JwZUxYhRYK+Mr2Kg0KeV5xzqqoOWK2TFNBsYJPIMjExrcQ8KUDnroZmrp42r7MgLZwGB/LGxuuq/ZkEmeszdaQLsiT3VFgnft6R+NoFmi74DVNDBNLWIMD5ZjccvueePb3W+oDckEFu+G+opZyEokzUsRIrNuyBxtn2eP7FxUvQdm7LenZ5VEV1kgpHEa1rsMB6JR8Edo64ldM1BmKW6SIXY150Pf0rNLbIg5TfQmOIY30kTZ/AxRnfmqQxzysD+xnln3V3APmMBIiz29CrnJcFSAdGGHXJ/VHzr+pkLxXi3a6vye436u9NpxZ+LgBZSD50jkKdmbgxd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 05:37:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%6]) with mapi id 15.20.5813.012; Fri, 11 Nov 2022
 05:37:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
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
Subject: RE: [PATCH v4 02/17] iommu: Add device-centric DMA ownership
 interfaces
Thread-Topic: [PATCH v4 02/17] iommu: Add device-centric DMA ownership
 interfaces
Thread-Index: AQHY8wvzmTpnChrVskWqRIeYPNrPva45OL0Q
Date:   Fri, 11 Nov 2022 05:37:36 +0000
Message-ID: <BN9PR11MB5276FBFDC7C96C9EFB87D4FF8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <2-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <2-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5959:EE_
x-ms-office365-filtering-correlation-id: 8330a2fd-ff5b-455d-0910-08dac3a6d6f4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /153qBtMtrSZBvuw/tKCLMvjA86hxacpxK9+NUP+CIQp0BT+XZQymPa9F2HyDYmtLQLqk2TYY41oU5SD0F7ZgkjXILpKF9xXmFR180fw6k/xpW8Sg5hwJquILL//4xSSopdVKOfEeedyBtHXdXaImW1sw40KsTg857BesN7hT/3ImJmqOI7BDBDiYOSocOVQak6BMixvBDdzKogCG8jtmVMsSmKUyByTkKjcffPSLm2KQ6QGWXVEdTUQ4SnMCB7HlbMq3IJ/xMyEgtoWQCGuESWQKgMr8S/JZhuQhBDrygdI6RlckkT/TbOCfM7D+Weu6WaXV48IxiA2CjgSZWieVwnU6VI/v7/sTtX6cslJDrRjJWJnob9b7lb14ise+NbgdqXLV0m7+tQ7fQ1V+/kleL8Lnu+F2n3tl2L9cGtPuEPrBnN1aHmoJly6YmMEniXKhwYlat3beuUiM1gVY6i2nr29Cfk/Q3a0CiLRIuuqEoXrMheWrzcQNpEVqUZDCbEOEHFgkRFdgVfWDXjko5XdyBx/tD0cZrRlfWUYreqjIcEEEpmzTuEGE0tAzf/5QxZDDX470MygVl879l7t6nbh36WW8Bfyu4e1wd59HoLrvV7xjCeb805CTZ0S9fDTIadfKmI3btQITCDXRCa3+u4h/0/oqzyrNU8GIpDOu+bG9+pXZi28iG6JC/Zk98a1JwEyk2ZL2JVbDsvK0yyxilPSKBGBinSVVkOPD21NcF2maA6miOGpEgB0ZltQQSZG6GYpVpENhkfxgbYm3umYQgQx1HMKU3NtY7gHicZ5Cauqdfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(86362001)(122000001)(33656002)(921005)(38100700002)(38070700005)(52536014)(6506007)(55016003)(82960400001)(9686003)(2906002)(26005)(7696005)(478600001)(7406005)(186003)(110136005)(5660300002)(316002)(41300700001)(71200400001)(4744005)(8936002)(54906003)(76116006)(4326008)(66446008)(66476007)(7416002)(64756008)(66946007)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?26438Vd1T+eeKDPrGid9tLQiirVZD5e0m3WbqRnN5OMTO0P0kij1ZBTCpZTt?=
 =?us-ascii?Q?raBqjvPE1N/uZhX7YSpqsyxk6HgrN4B2PCjhK3zy3wZl0f0gUjiXkmnbCKJ1?=
 =?us-ascii?Q?k6fiv6HiUo4vLUQ2w2gDgBF27tJBCWKP5PlXlmADVbo46/NUpWVEQfuoVyik?=
 =?us-ascii?Q?4g3f4oYB7a58Jf8XBh9rAto2wsLuMlD7tYvHZfJfwRN6kPtWG3lFnku49VWp?=
 =?us-ascii?Q?x66VhFx9zS4bxtOvPDtFXFsi9Drvb7T/QXrtQD1L9TXztq7MFLrEQlZFSVo7?=
 =?us-ascii?Q?5uwqRTb1HXMyYAcqb/LMdoop6OvisuOMu/yM54yFLSE0EDvfTWv5Fefg1lyH?=
 =?us-ascii?Q?WG1j6zmyWFlGojcJ42/2IG6EQWapXSLbmY9GYhNt4GUU33g2741cuxWSQC0Z?=
 =?us-ascii?Q?hJ7jlLtYgUi1TBDZ1u9o0TWcWIb7gP3YKlFkadVo6aCU51kEOVjLDTgcuWJr?=
 =?us-ascii?Q?cP/152XU2eqeWiCwSwVjLEnyyJzHoT+6+oaAb1sg7fNVa9M1N6eQxxW2EFHX?=
 =?us-ascii?Q?8qariGvRiTI8e/CJOuKe4WazeyBcsChuNHYFm8AQ6+gfYgQ9Xn8IXxV8bJF4?=
 =?us-ascii?Q?jbeAidpaAypP4zGHjZK2mgSD8Ew8/M/O2U7+oSCZjwmnuLFQV1G3EP4vHv/6?=
 =?us-ascii?Q?HckQvA1TjFni1GsXPIoTTNxKpihEDNHjfizol7cVDJHlnAyQaIpTefMXSoEz?=
 =?us-ascii?Q?tW+NNX5zOnWnZ5O7ZBEFHSLcIRR5i7EcSnMm/m8sY9Ebt75mCscebsYsoY2o?=
 =?us-ascii?Q?eXbCQZlabRimOeLcX0WATiaoTXaSzXtKjCiWrs+EOd/V7HiW1O/ON4s/90XP?=
 =?us-ascii?Q?IxbxVc/ARwmPWyVB7+bFxj83DUk8+wbMwA8R+3hz0lB+xtd+qZIyXY0beDWs?=
 =?us-ascii?Q?Sv2CRuyXfRVYXfqReWwjY88GPvXWF4gr6GbpH1lBS+YXnkl6fkgUW5ha8og0?=
 =?us-ascii?Q?aPn4pq6S37AIa4x81Jv1UzKllZevZs/x0gWEu7XFGugs7bjnBUC0pL8RyNCd?=
 =?us-ascii?Q?+IoMfhQuptRuCshn0T0B62nIi1CnMTdCdlpWVNf2jQeSqIRwibSg4CFmwdu3?=
 =?us-ascii?Q?k0BHhZZkiAEC6qsNRU7t2C6XWxJkOnhN74q82RrZCktZzaa8ac7tL8RtECT7?=
 =?us-ascii?Q?1q7usKXiZxjPGL1nTUYlRaUJl/0Cin1meb5fweG3GpCAXZQXpyY3GOVDWear?=
 =?us-ascii?Q?SmiOqKDo/G5+6jNTLClcJeGm4qsBCUhq8DzBQE2v23jSeq44S474hF7FUmpm?=
 =?us-ascii?Q?7AMXftawBgW8jJRHgtX5VT9b4IEJlZy7ly7FowLHCoNGR6nxTO+Z9PoFfQG5?=
 =?us-ascii?Q?MtlnF70a1dFDf1i2bv2rMn/ybCFHUCIvMaxgcpSLr/ZHwG1oC0Ki+xTYgzWW?=
 =?us-ascii?Q?lQHhivxRLm8j+LoOQmXthjQP3diQPcoTTpww9cfCzswVWoy12yJb0zXqCjkK?=
 =?us-ascii?Q?0bS1e1ceE3bT81NgjrTl1jogtBcufLACgwPNkj3J9dohSYocRhloVhnyYTEn?=
 =?us-ascii?Q?BJGIa/fd93UbAjxvp5+kQebydAGXKc6dD+Y5JCTEwGK5u/SkLCfdVYR2/7C4?=
 =?us-ascii?Q?bjtwmNPYgi31ZC5T4ngeC5awDPwQVLlVUVOp+i0y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330a2fd-ff5b-455d-0910-08dac3a6d6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 05:37:36.4025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWw2AvBSxnz02GcJ/kTA8lSXt+XkXOUOC9xj55Gr5DxZtUu+OgJSxAqm+OaXZLRQgmYCRVOop7uJ/Jw25ta72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, November 8, 2022 8:49 AM
> +static int __iommu_take_dma_ownership(struct iommu_group *group, void
> *owner)
> +{
> +	int ret;
> +
> +	if (WARN_ON(!owner))
> +		return -EINVAL;

move to iommu_device_claim_dma_owner(). just like how it's checked
in the group version.

> +
> +	if ((group->domain && group->domain !=3D group->default_domain) ||
> +	    !xa_empty(&group->pasid_array))
> +		return -EBUSY;

the check of pasid_array is a new addition in this version. it's probably
worthy a comment here.

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
