Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18CA674EDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjATIEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 03:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjATIEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 03:04:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573B40D6;
        Fri, 20 Jan 2023 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674201854; x=1705737854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8trI9cfIBR6MCsdMqi/ZPKiDgY1RdyZgb5Z0pNKSbB8=;
  b=UbsaMuVS9SHlkXeyeWd7GwHQxb3nHJQWCPBDKPl97eYA6cV2mPLiLoI6
   JB3hPgNMh8tLyLyz0IWgKvnhqEIL4UO1M6NAYLKYLod8/Dh6R8iLts6n2
   D8RiROLD6H3xfpVMeeNndwJUvJDd2p05epCEEr2p8yfkSWrwvjQ3Z4Khk
   /Sv1w2wojUoYny5M22A8gZA2MS3Ri5PSiPLZoGRmB+0HACC4QQjAw9knm
   RFDao1Gi4T8J2E4FCdAvX97T3bfBKw9y58tv8q99ZKAykJuAxPTZoW5/j
   ytWlL2lE832mUt3c7uzmS1gPHdaudThjKfW0tZjf0G8fKMwT+mkctLiwo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305895239"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="305895239"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 00:04:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="834332842"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="834332842"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2023 00:04:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 00:04:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 00:04:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 00:04:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 00:04:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmbB8dPo9jIKKnuQQIZKd0tcFjXNJrH6xI0W9XmvKvnGFJcKJdRIIA1svKJKwMFambm8LdYKF/0duWmQxz6O04/67bDmO7+Cd3d0UMkehwR/kjtZkbDKXYb1hckyydIxiny93KT6N/X1WRwLZZl2tSPukF+YnMA45J6EPxigsFijDtTKssLR7uJ3drUwBFlbR2D9Nv25PZgazVc82lXiBA0fZer+4Gg5EA85KXJ7fv75LPwY7JSD2nx7UDxFQaWDzQ2h9JiQX/z+vSv06Xv8vXmRoToVJQobQ6jOlN8J9I9fKv9f5L/rif5Y3VVg04DjFjI++40ZbpqZzIYWZrlozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8trI9cfIBR6MCsdMqi/ZPKiDgY1RdyZgb5Z0pNKSbB8=;
 b=DZjFjsOGPt6maZAuvhqpkL8QFOe7hQ3ZFLDoHPATUuDqz3zw/IuLdEbRNoG1zrLweRcSYhiCzZwW2XGWxqagIkMu+QoMgvbVkOI351Tu6m9uKMttGP4ekdrF4pF0aIpLcX9VzJAL+dDNUfE8MXjWfGp/SNM2osIEzI5T6FWuiEgrhcWUmye1u/2MJKkFtDENFvo6yZUkMxQp3RhRFOwnJin1wGuptLaZLka5o7tl6wMoVmctGIfO9pLY8kA+iIx642ac0C5d8qUzwogoQnuicOBG1g8IXXWroCLTvd1lfieW45P9CZBfnYxpu4//RmcZIbZfSQOt3kyBqmG7+o0k+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 08:04:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 08:04:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] selftests: iommu: Fix test_cmd_destroy_access() call in
 user_copy
Thread-Topic: [PATCH] selftests: iommu: Fix test_cmd_destroy_access() call in
 user_copy
Thread-Index: AQHZLKLEbd6vY9EuRUyt8zSxkkCw2q6m8iQw
Date:   Fri, 20 Jan 2023 08:04:09 +0000
Message-ID: <BN9PR11MB5276D3F6AA7536D5CA08A3C68CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230120074204.1368-1-nicolinc@nvidia.com>
In-Reply-To: <20230120074204.1368-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6905:EE_
x-ms-office365-filtering-correlation-id: ea257803-22f9-4f35-9849-08dafabce90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TcnmfnIhEmMcyO0YtPmslZnOQLqpyNJi0VgVs50cYZ/nw5/1K9ynuC8Bhtxyj0Udw511QfQ760Bs0r4JtrT5iF8H8rhIerx0aSx2ib6hugxOedRJmjXs27NXgFD9AyNqzEwh95nMZiBwCLzNczh9MMHQyi9ncEmzLFOnW882Jhik0voA3cVVJLkfnB2FXeIQPwHymkksY/3Dm3+rBtNxx8aLqjwa134zdx2Wj7BD9QU/GPb5N/bs9jNxdv2wF/JR+bYlXR2rFsRrw2YEhvbGnAEkdeDFWEW58626EK2FozNtAv7fa0pUY3LfN0wdTClUGgjcoO2jkcqZysGY1t3i80+PDV9/QGrHdu2ChXcumORRfTimS8R2p/2plo138P09By090jst8cCDRE9MV+n9sBYfF6ExYB7Q1qm7ZWjl0LmRs5dYPj/U0l9wS01ynXhSjRiPvYv3OlWNAwmSjApWMd9Q00bfz8+SpUOLqBYFOtsAf5Xm92EFkHtSRBPQ/W/2HzR1kwLE+OM/S9M7biPwiryTCiRSJ9stMn1mVyDo93MiCLFmfdRG2fCM6UfklKx8dBk4u+SvpX57sy46d9JukQoJp0c4ht4VSONpeJ1Xi4sbuGPy6zmvSPz7qB0V3VDSorMm28hDFuB9EPvgq2EZdRxQPU//h12/fvTqJmJ8puu1rSg6as23xUUlZBrGKclPwOHn/fdRxbqCVdplIjdBCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(83380400001)(33656002)(55016003)(64756008)(4744005)(9686003)(4326008)(66946007)(41300700001)(66446008)(76116006)(66476007)(66556008)(8676002)(26005)(186003)(478600001)(6506007)(8936002)(5660300002)(52536014)(71200400001)(316002)(7696005)(110136005)(38070700005)(54906003)(86362001)(38100700002)(82960400001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzqoOuKTC6Lhit0f+g5Neg3c4V6MHhPSKDbK/W7DvbxxCiJpbEB7OHglGRj0?=
 =?us-ascii?Q?pBd2B3u8lU6j6UFS42u4KlBYSVeeAAxWHYVV0rfDzgf9mtLHlwfRMOTZPa8b?=
 =?us-ascii?Q?bjl+TyPlEkfkoSrMmuIpuOSIgMf/WrDceq6SbI0hnjrdDAdox5gJGZUzJE9R?=
 =?us-ascii?Q?lU3G2yYMasR8kJzat9d5hMe55O5azCKzftpp4sx/ruAVUt2zPJiIFg78Rkru?=
 =?us-ascii?Q?/BIP2YJTXyvmaHeJ0fImDdwy3gFxN8UjqcXsquXI5cyK/voBcXBIAcI7q5UN?=
 =?us-ascii?Q?kH0S9+jQO0TD1lujHrpZQy7onuabUAob/iJmHouybPTZU77wHIvnZsvHEOnq?=
 =?us-ascii?Q?cN7ionAg4syiafxpTUh6tV+Lv47Q1JwTAqMe+Pe2KzEK3RSHFy6XwPIk1FLI?=
 =?us-ascii?Q?cOE1PcIb+y6mJqnGeubf8UF9uPHYFDrLHYJzT2/nLPxfg0emTfBhHkoi3iCu?=
 =?us-ascii?Q?1j1dtbJKS3S303aZ2BJDW6X2bPRUrxrRqvZBHVCC4wmD+zdzyIGHZ/9iQLux?=
 =?us-ascii?Q?a0zsrKZhlnlEOtu8F/Gr37opsJjmwT4scxoStIhOQpgnJ9dx3VMxCLL1rIfX?=
 =?us-ascii?Q?k0/Vj/9M7fYWnObuc1/60R8UB4jYIvkHkPZcLF84ZlaU5Bn/hpOGuCj+gvnY?=
 =?us-ascii?Q?arRe2F9xE+HEtfrjw3N8Ip2wQ6+ZV+QSnO73ELB0V1wan9ObOldeW4UGXqTE?=
 =?us-ascii?Q?PH/grgk5RJAprgoqNnpohJ8lnC42I7OcT+tWrhGrdSxEYZHYHhIRQr5MwFKM?=
 =?us-ascii?Q?AR9NmrEWAV0n31ieXmhBHETssHNBuo991GhyvC0LOwwVLOdfFfMw91uXFI9T?=
 =?us-ascii?Q?/Wx1hnrbLa/0vNw70KWNn74/puiVNbRw5Gl6JmWsP7A4Dc6yEebtNT8Agj+c?=
 =?us-ascii?Q?Dc6lC6FT86Obo6su0FDBhg/wvlB1tlTRj+jMMDDNy8HjdVj91YkRa9iq5Qpa?=
 =?us-ascii?Q?tOtts3mMjQUxLHrykYoLKmVk6B75Q6X7rna6QvOrI8vlMoDzqd3zgAIyb4e9?=
 =?us-ascii?Q?2DJ3dK/Dh+ErIfREpRS1yQHD/+IOpgWJBBhT/+E8cFu5agV8ttbQEklab67X?=
 =?us-ascii?Q?Qfl6GXrLMjjiyA9keYE5YC7r+rG7I61itdntlCJZ65AxJx6GT0IGQG0SuyaK?=
 =?us-ascii?Q?k+G9ufGcUvc/yRTG9VHjs6z4L0KDqHWAWrYQq0K9vde2CrkWiKIlrZdO9+HK?=
 =?us-ascii?Q?DZtKdbWRhs+KFBJAcAtlsXut/BWTFo8o8XxiKpPdmY3HDBT9/jItP4Kn+MIv?=
 =?us-ascii?Q?xY+f1Up/0TwYjjO59QXHOWNhB5AQ01WE0bfFkLWTY1Xygb0n3KGT+cy26/VT?=
 =?us-ascii?Q?0TExd3OJ1ZaiEyndYe31GXAzHm6OV/WpBulkH0QfgShOEKH1yDBHh5qHP0Kj?=
 =?us-ascii?Q?poHk5ot391cObZGbJBc5D6LTwo0IfVxjdszOQW5gNgpKy/o/Wr8wwQh3TLyL?=
 =?us-ascii?Q?6X+xam4U89v+HNgKRYj7lOo8JhK01dKvsF+WIfC4q+f9Eg5CCRBbHKcsyrqp?=
 =?us-ascii?Q?CbdT9vB9sXuD6eC2Zr6eY6H6qkbLnQFqACwk33rzM85hM7yEURDcpUUhan7T?=
 =?us-ascii?Q?ti/9r/x6U2AMxMPvxrI4UQYxDvBhWohb6ScKpN/6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea257803-22f9-4f35-9849-08dafabce90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 08:04:09.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXvELDcfT4lpwsdrWOqCARgC1R2JiQ8BhqSwfxvXr7GOZa2ZynoL9lr+aHgzEVISE2WLQGopcLSdfu1Yh4jwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, January 20, 2023 3:42 PM
>=20
> The test_cmd_destroy_access() should end with a semicolon, so add one.
> There is a test_ioctl_destroy(ioas_id) following already, so drop one.
>=20
> Fixes: 57f0988706fe ("iommufd: Add a selftest")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
