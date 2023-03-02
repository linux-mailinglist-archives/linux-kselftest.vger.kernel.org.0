Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7F56A78D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCBBYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:24:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B58236FFC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720287; x=1709256287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kP+WHr0VaCty1N5JxuFrybwiEVU30x8ZS8bkNkeTYYI=;
  b=hYnhlCUPa6qwXS8UdQEpCKmoRSyCC7J6NTfonlMfUrgTREWtb70Hyggn
   kSxgan8kg2qnmlTtrRF2hZm4ajJkkLGGGV4pVRrGYeWrfS05nBR9Grhgo
   gkZXFXXAHh+ACizeUnNLLnCJ96+0CsKISQy6oj0Q9OjC/q0k9QGPWO81m
   DCiuaZ/MZscZGj+a87qT+BFap6kRs7H3S7RxWxuBcqIlRdVtuK3HOC/AZ
   mwpxQQ97m1xBl3jqG0JEP6p1JUbgl0OcmbMp0q4gtAiH3BM1Cdkc6ZC5X
   1OCowXVtDWVXzjoftBED3sa0F6UUbhFiqVbg6Fu7jCpEQzSOu9eK+nNg3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334611488"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="334611488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="674772267"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="674772267"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Mar 2023 17:24:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:24:42 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:24:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:24:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:24:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK4goKbqf7VhItko+r64BEP9e7QZl9TDiIFK0BWamyqFgGWX9t56SUeyxS94ZXbAPY0pAj0xZZSZflOWjUvEmYCrd4doQDcvrqnE6DsKalD4FCaQLIfRNMkKOdlQr81ibwYdKOkL3SRsUN0NviTEXOmWTooOxOxt0xou5VsnUZJ2kfCfpZePzzzdZa8vy6sbKjdcMiK832q8XnDGx0vxP+qXE0USA/Tl2USw6NmFW2/OyrNIwlRuz6B2VgREKu120o66NI3GwDMuC3fBUg0tjHvIx+UtL1gz3oC6PA1Lo7dEAf3Muwys0Sd0TJIwD64nS5hooQ+7lfL2kjVGboucmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP+WHr0VaCty1N5JxuFrybwiEVU30x8ZS8bkNkeTYYI=;
 b=FWv7B6YymkU4lslQdKGMGUZHFmxTQDhp7OYggmZwJvKNr9eCXnb4AFtw4vc6Fsqbk2pqS8MNDNeXcgAvAvv3ff/CZ121Njvk1bAUzoz2aO1NVGc7MNzbdZsq00srLvGBLeR1glQ+gsT2Sh483rUOMQZRYFx4sIQc9PAZ9NmnKABeJqhKDTc62HC5DEkVo5607Q7YJmGxJKDxBsLnUm9r9vgYvch67zrTGqkI/jG0pJV934SzHx3Vj6TPPEly1mQuxDBLH1L8Rojs9Z+wmzJ+iCiq+fUmpr5Um5jE0NQ7BZPVF+vnVCYxvWXFKfc995BCzsJ/AKsCTWx+4HXPodoi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 2 Mar
 2023 01:24:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:24:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 09/12] iommufd/selftest: Rename domain_id to hwpt_id
 for FIXTURE iommufd_mock_domain
Thread-Topic: [PATCH v3 09/12] iommufd/selftest: Rename domain_id to hwpt_id
 for FIXTURE iommufd_mock_domain
Thread-Index: AQHZTHRibtGfOqO/3EuodzM57qV5qK7msoWw
Date:   Thu, 2 Mar 2023 01:24:38 +0000
Message-ID: <BN9PR11MB52760956211D44B1FE0D26CD8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <9-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <9-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6059:EE_
x-ms-office365-filtering-correlation-id: 9fb6bab5-086b-48bc-9da3-08db1abce451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M08amvzEERDnausPojVJURicOcLm4BNjmuK7+y6F52gpJ8vs959TzTT6C45WJxVvIGuWdMhZE4/DY1SdNDDwUmhlscRLthMeAYb4YD8C0dp4/mfg4pXFy6Es1FrepaH4CZNT6zSxvNA07ty5GracAnAtnfeSQelzUWXQKIr6k2zyrexn7KplDruSyjYUzEEcsRQdlNWfxl+x38IVRI7Pz1wD6gkIeuH6+BP7Kq5S7xBh4GQLsBJecy1uC4bFaDQcW6jlEUA4zdeCJtYG4B4ejBrjp0baYCQrxzDeeWSqKBZO9+IbBq5q2bY+WtgJMZdqrglJvG7khe2EVfTbaxJy/BSU8ZUmAEjl16gQZLnGsFh68ZDOAw5l1Vf0swJq2fboUhkznnJuhrIcVX/eiq3uaPCiO6e3QztK1VgqbR3V2UT8bpX1UeRgg3UweHJk+KS1J7oec216eMLbhjG/RvUd5ryJX2jT81icnTrAfBsIFsVi0qBhU1cqtX65rkpCzmvYCUUY0F6VhxMujJk/liyvoOQoNh1MBRR6RWvalrVy3+YlFFNCac97U/3kGEExC1/+4O7zogQIQUnVxxEG2OVCXxuZX/ZPLGLbKBZFFoohT/deCjn0NnoFTdf5mlF05T78uPiF5snkNV5QdhDuzAd4J4tzbZxEcuRPnJ5GPYSgr3NWW/qcdvUUvAcPnMxJZM47hV2SRoy4rcLpY+iMmhLiQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(86362001)(558084003)(33656002)(41300700001)(8676002)(54906003)(110136005)(2906002)(186003)(9686003)(5660300002)(66446008)(107886003)(64756008)(76116006)(6506007)(66946007)(66476007)(66556008)(8936002)(7696005)(26005)(4326008)(55016003)(478600001)(71200400001)(82960400001)(38070700005)(122000001)(316002)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ndeYir8gQ0QnWwJQWfK6uQ61iS+HioidNw+WpEsPRSYEP5DWQMxvELRZXLxE?=
 =?us-ascii?Q?395Ta26fCVjhsPs3ljDg0RnxwhPKQxyoJpkQKntaZWo7Y/HzRg7lLyB24bCH?=
 =?us-ascii?Q?GZkb1WbzW6l13NCEMlHJxAlSWDu3YXVwtsXzhQTvC4c2Pgct3+7hW5GiVYdL?=
 =?us-ascii?Q?k0JAvh3vOwHZzqfLhEHis1CrSgTqsoDWgCl0f1/gyuxCLUMTRbYojF6g2zId?=
 =?us-ascii?Q?6VczCR2apWh1stpprZlHtDksoMNWls2PqzPLVzgpD4TM1zib66Va36bbVX5c?=
 =?us-ascii?Q?Oq4lbQCq0qcin95Ry3JRnmbr8tYntwBX1eBaL1kZAzPoOevEVs8jp8CdcikA?=
 =?us-ascii?Q?tfiD8v0OI04C0hCLrO7xVNRotzds+yW4vO6hO2IpdxUZNbD9YLT/nJ/jCZfo?=
 =?us-ascii?Q?kIrQgor0z7K+4OAJLV/MLw6JREgH+svrivCxMJ/C5Oyvn+Wws4hmKky89edN?=
 =?us-ascii?Q?IhzRuTUHFFM5IKkODl5HI4RhKgp3MbsH/1e0pVka8zpb8jp2MR2nc1crbcEb?=
 =?us-ascii?Q?HdtN6yrOOz+Q0vfB6Iv203Z9dNA3osJAqPgOx3BFnk80PB07Wp6zpCWMz7RW?=
 =?us-ascii?Q?rlPOCbgTri7vPucyxWSTNfm4patbLAltoicgzdJ7GEDCaH7sWYZhQxvji7pA?=
 =?us-ascii?Q?uNy7NKWrehcndeOHUMJPaUnW6PrTFuUVmEpHzUZWLjcv6wPQXPg4IFnoz5xC?=
 =?us-ascii?Q?0512lCmGDj+zizKeAPGVT+z8Ze0fCQCR8KPPjYRV5/g3lWilhlQa6cJ/382C?=
 =?us-ascii?Q?Uv062clV/3i7DiAnbmVvdmVWyOBo8tUmuLdi4KU0k2RLv74Ht5JD7XSTeNAK?=
 =?us-ascii?Q?xWxsTZiAh4+G7zL6fgB/61j2KaMs3CynSMDnWvC1fvX9Wbstgn/vLO9EiGkB?=
 =?us-ascii?Q?ZnxXPW1EU9ZHkFY+KnPoeF3XsNyS7D+nHEc52wz3F24ggloPTFcVpaZrJFW0?=
 =?us-ascii?Q?sotM59X8EMVlCeXB9R5rplPBRNbtRDRBX2Muxtk5PfU3/97pS6YAD+UnQf7K?=
 =?us-ascii?Q?JTGnccrq3jUZf+tdtzCCTV4BnakL1cwyk4+XpnvZzUsAtZMehRnk06HqvKub?=
 =?us-ascii?Q?pgFtAzvUZs8bPA39VSSAPwJg5UrZWi7cGvvSeTFl7MO6px0qISnlMwa3lBjc?=
 =?us-ascii?Q?GhvlKyn/Nqt9H5DSgLTTSkr+lcKvHuMxG1XvbBTfqojyQygD34x1zbaAsM7P?=
 =?us-ascii?Q?Tyianj7JqDWjfCu27VVQ7hk1uva6/aSg29uNoCGwtiA8NT3I7BmDl1yLrjLi?=
 =?us-ascii?Q?nzQ522h34KytXuwEjuTc/yx0ZZxNpn7/Puf9fa7wgku7oa36i1zOBmUfMv3q?=
 =?us-ascii?Q?phglOuS1cIQqAhokme6OF2BRahBypP9KLjcESFG0s9x8OBA8kwvPQu8UoJCx?=
 =?us-ascii?Q?JKkhUVxioYcTigCfT03+wBQfnoeitcXTRk4CKYy8ZYxDmDlVp9ZCpBCcoVb6?=
 =?us-ascii?Q?EhkVD6j7BGr3Jx2tk5CJvK3BNTyiQyziHSJOK14sqwfnfIjVe5mb/FKNgEsd?=
 =?us-ascii?Q?ug9+5OoRmlOoIVND5ekFTOf1cXfyda0Snl834uP8zBYZ3iOaZeq6qjA82mMn?=
 =?us-ascii?Q?lRg4A2nEeIjzfKCmA6HQpkSGddbF4Q0IepB48aTp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb6bab5-086b-48bc-9da3-08db1abce451
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:24:38.9160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9x7OxtHwa0kdv3nEes3y+QRYl/qyuAOMhl7m83YNKQNsxnsDQR7uoKxi5oc94uIO5WnDt5Nnl1a+GDTRv0blww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
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
> Sent: Thursday, March 2, 2023 3:30 AM
>=20
> In this case the domain_id was acting as the hwpt_id, so be clearer.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
