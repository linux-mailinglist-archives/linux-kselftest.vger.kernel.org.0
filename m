Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B226A7C54
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCBIP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBIPZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:15:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325132502;
        Thu,  2 Mar 2023 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744921; x=1709280921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ByWqs3UsMaobzruTsKLASG4BRsx11D4d4SzfbSEI6+8=;
  b=XsE/Z+anW4mFto0SSKZ7zmwHbtQ7aH+gWWSGVigY5pWy9w6iRTMukFUC
   BW5L/ymEstWilzVGDZ8tD0FLDcvp0pAL4RuNj5+3Xj97XKAAooTIO2vj3
   rxUGCrAA9BFY9vvVrKBkbd/PdKHb3fx+xRcszZvdsDSADxwaD77olo8nv
   TqEo/7/OZCsLrjjc+2z0glx4kc+vSflwDg2QNzXeH4zAZF7ck+eKR51lG
   8HfrRvpJZK/5T+q9GO7EpvKb6+J+rd4qwpjcCwXFdwL8UPvohCefN1CLf
   EDbr4h7RICOe6MXhXovoeH0yEKkwd1ktUbEqSH/XC3viJO0W9fbjFNlnV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="333379740"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="333379740"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738966381"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="738966381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 00:14:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:14:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:14:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:14:56 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:14:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeFEPNEQuop97rD2z8t81pYewNht6TIPeLtPPtNqlDTJYF/8vyYrxZ9dw9JRIhTDXfgJhf5zBRik5DQEOakjnUbDektP+jFMP0PnA80D5w9XzxpTWxlGgFAMFokLLW6zladY5jl1NOXQRtdW1Nh90whx+uuo2johlwIAANN8/vCgdVuTyUSIycNaWh2mf7q8qnd8YoYCENHBz6pIj6xMKu2ldBTrMVX0BQc3AGS2pQD1EDUbMQ1Rp374ACBtWny9xgBAZh9VTRr2gMIGPqbI3mApl9hOI5Na1nsGeNLA5f0Hm1ZYJtFpMTW4jQt3kCciQLEMEik2jwFuYz70VAjrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByWqs3UsMaobzruTsKLASG4BRsx11D4d4SzfbSEI6+8=;
 b=BPJ4AIrlGSv6iNbjHawLPFC1700Pbv5TpBQXnzjDabSp7qrcQUGhRKbRL+t1bi7yTyx9SfOf3NsYLEWmtCF2M4Vhmh13JIMHDxR3a40tMiK7ECx2Os67o6SQtG1DKav3U0CYOst9aKrfnqPUujmRr2bJiR9OvrcR6qv+MtzdQgYeRn3UOdek9yrZ+TxGn/Z3MoxTsM6zoWM1J7qGJs0Fh2dJ1hflNiCBHXdve/rwtKNILuSTsmXq/MyrotRkfevz+TTGqXzCaVhW/9LaVpYLFXUafEY7raqowR/bk5CFLOTDD2O1iEMQS+xWiouhPnYHk2X5X0uW6Vmr2glfsSsvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6208.namprd11.prod.outlook.com (2603:10b6:208:3c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:14:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:14:54 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 07/14] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH 07/14] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZSLAORZ+plNu5w0i4kZoLJeS0567nLK2g
Date:   Thu, 2 Mar 2023 08:14:54 +0000
Message-ID: <BN9PR11MB527643DB3C220F1D657953328CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <7-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <7-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6208:EE_
x-ms-office365-filtering-correlation-id: 784b10fd-6c55-451b-c217-08db1af63441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEYw1MAKHd8i/tFiZOhrUAvolbQkQtTnpxoSSBHTTtIV05dli3F90BrX0LZUGmT2VORvrUnB63jF+U1tg12fPpo++WnmJrcWYW79yRIWyla6kUIpw63HVgLeFcNDQz80ocL7//cU24D4t1lyYfnNSCn6lq9rgijBbFtHtQiWKsUaOl+FtC2/Jyzs1oga7vJ8pLtPAAlrToh9dYIob7eqqXpMCmIGUreS3pFLxLxlRVTp26G3Nr8tUE9qLFZ1luAMOON7G0ImDQjhou33v+NlpF4cjDEDecyvsLdl34gJCMpZNKI5+mPdBjbMJrw6A56dprG38yDRcwOyvAo9jqjvazJoGGyngvLY+Dp/WbqaEET6gi7u7w0BpyHWRb2vO8ztN5x2TVwBr1Gpc3N5USGUDBO4tD4/AUbM5oyBs/LtvgcBBpbHiKnBRHkIFZofwPBST8eNLsfzomO5+cwoL3QD4SRRgTvYCWvyTK75mGoPv7aEnOFy/dktaPElJixXEw5wMLmu8Pb4SInUWTKIH04d/5ow9409Xw1kt9tl3c0oIzpgNW7oIL7mpVZmO3D50cFUsH2hFjAAHmFQWWBXbXp0lRM6THT1/diL4dKaEIVEOLuVIi0+DdHuiklOqR4OlEt57yPyGGqHxesV6EceZ65GPlgb7olAtosXmEQRTS4o/uZ+KYUwSL5zWPlX2zyHx3Zx6jzYPA2NXyfEB4F/iwtUkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(86362001)(41300700001)(64756008)(55016003)(66446008)(66556008)(8936002)(52536014)(4326008)(5660300002)(66476007)(66946007)(4744005)(2906002)(82960400001)(38070700005)(8676002)(122000001)(38100700002)(7696005)(71200400001)(107886003)(54906003)(478600001)(316002)(33656002)(76116006)(110136005)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7IwpUnYfbQAHDaEWIPDT0KebKfMsGU7QjoBPi0De/6sblGZnZL63R9R2lwbb?=
 =?us-ascii?Q?UKmFfsarH3MuJ+Whfx/xWn7Zvy/CTT0ik0rna9Pkc7UgdcDxctxgkCcB2XdU?=
 =?us-ascii?Q?7z2OKYwur9cWdd44wyOHW1GuddO/bdQEePVP4tV5r+9pm38PZUEx1xvwiwiN?=
 =?us-ascii?Q?wQKu1ljH1acBo3jWG6EyeaDLVJL+khYf6vSf8BEOr5fjSxpfTaKX79aXzAsi?=
 =?us-ascii?Q?oM7WQIqKMLVN1v7plRgOA76JbUirlBELY1rhC/sGc8zsblRhqYI28/bVahk9?=
 =?us-ascii?Q?h1LulBJkgw+LumKFrI0x3v9EbVvgV5MZd7qD7vsExZ/Yv7sDCM553X3kcYtK?=
 =?us-ascii?Q?PGf8+xQZgvAHAJMnZDXaO5df/VVUNBwiVdWPTGZ1Ck/bUwLmEahiDgf36b22?=
 =?us-ascii?Q?ba8kF5z/8d7Zj85AxubAxjc94dlhCLINO0KlOJ2r2HVum5nOaIrVlF9ZwnA/?=
 =?us-ascii?Q?aT7pH3hBZCykp7s4z+iJhZOHuZ9rMv2RNI0+lFAAuQ7TJVsv2CMVHYT2YMFa?=
 =?us-ascii?Q?afd/xHlD7JEZSX/3ZU1kr64OoT8J900ZsN8dtyElxb6/ruxiA293ZFaoXfJg?=
 =?us-ascii?Q?9CL5q5F8HyLI6ZSu/GhnR4JqfkZ1VSQ1k55DAKXTGDgCIKiMDq8XlWJBr8VV?=
 =?us-ascii?Q?K0cntuhrbRHlPj7tMGKcW99+VD/OjxuduGss3tURBWJsBnVEkADOyT5fcEIU?=
 =?us-ascii?Q?zL7bKQteix5Z4eY7aDZsKIqCxIR0BkVcx+PPNf5ccmiMQjw9CSQx/MQ4a1Yi?=
 =?us-ascii?Q?6sHpp1sIzhZi+wT1/PEe2+Hu6PvAghzZ/aGgHRFSMCV4MGDvdu/HxPBBEfAQ?=
 =?us-ascii?Q?R7Q/7fddmawGOA7y2T2dud1HxBL2DnunA8/mcSQDJZopaffOqPV0HRo7RFI0?=
 =?us-ascii?Q?c+FtlhHfmGCtYgIpiO1ym60NVNGjcFfWrcOF08w1QuhpJks1r4kCLx5+WSoF?=
 =?us-ascii?Q?9kwv2P4CAowAa5hEo0GwdkesPlARRgKPYBreMnEq6QGuZf54YJTAeEf0X92/?=
 =?us-ascii?Q?CDsHyjpM2aJVuyVc2SGeXR/TmwqVa0xdvePF+ewCHHRprNYQXCcCg9TMVdgP?=
 =?us-ascii?Q?jf+cZGkh7eX7jmNHrZ0sM2aE8VQmwZmIrGUT3xEFztj4OG+ovVC0dyuPajVN?=
 =?us-ascii?Q?6sURAW88wGIP3/Pg3mdTp6rRYPx/ghjDIObZv3j6xrSXE7dXJLOn4fsdfaPU?=
 =?us-ascii?Q?u6anW+8TpzeHBtobEGjd0mX1o1Nu6XAsHW7DVwmoM2yQAC1UU9XwLdIO69Pz?=
 =?us-ascii?Q?BqpZtGUpFhrR7cHaSEnVk+0VNVHwPVSiew/nc/7Ug0Cxtqn0vqLAqF6mRS2H?=
 =?us-ascii?Q?Fg45SIQJ9cLfKMyIQ2l0T4Xp0htw5Og00Ak4vTpyxjfD+YIaIfW/78AlZfi5?=
 =?us-ascii?Q?ufpS7kC4UmFh7fZ2y/lZWVY0BtDeDoUq4o7lG6xObvqpYtTCdoOSmr+UhWUd?=
 =?us-ascii?Q?w1FOqNfqAlpvGpbQBYZMqxi3hGb5idfCc39OUiUOlQ7FAAcs2gA0Ikc9zsnG?=
 =?us-ascii?Q?sHUzh/3pbUl4tPdLWx/06vwXD2ZnDMvzKm71j16B4WvViElohDoJDTP0F0Nb?=
 =?us-ascii?Q?/SxmmnH+H6Q72rnD0tsCl2kebCP2W6Ix7f9+SDfv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784b10fd-6c55-451b-c217-08db1af63441
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:14:54.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/LKOIivcT0EV0INyH4L8N7UCcqNGb33mJh3IjEe6Sh+GsFCcPMvYIp+P4Uwm3Yz0iLnoDxr0roK/GGmXpBqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6208
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
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> Logically the HWPT should have the coherency set properly for the device
> that it is being created for when it is created.
>=20
> This was happening implicitly if the immediate_attach was set because
> iommufd_hw_pagetable_attach() does it as the first thing.
>=20
> Do it unconditionally so !immediate_attach works properly.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
