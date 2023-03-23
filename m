Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090956C612A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCWHyk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWHyj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:54:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473722DDF;
        Thu, 23 Mar 2023 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679558079; x=1711094079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OXapVPOnU85TaRbRrxyH7snNNhHomk4pAYl6VW5r2Z0=;
  b=dLaw2An48LcYJWvwId5AlBmPpHJ43+GGOuWxEToaFAqlyU/UfqDj29+j
   vwIx6QsmK3Ir2BBQHvd3i7yWG2xM8W2uI8C2TaKW+SYmn49It0dopiJix
   WI5kk2QZMoRRK5iRRPr/qr+l0iTxI7t8Os/HEOaGC5b/mQ79LtPZXFNUj
   58YXmJbsk+DkqsPYz9uKX7e1pRN5ocgI262r+/bUoiMEo8Sfp3FeRr7E0
   HcwwlYZL29w+Svpaqki9ancyBUsPMJ8S8zrwqzvpgikH8/PqsK4guJlKG
   tDGlb30Ws9MitZahYIFENdE1nic/gysp8HcnfG2eRO8D40q4/6ZlgYlMQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="401991763"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="401991763"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682223465"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="682223465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2023 00:54:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:54:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:54:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:54:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJYZFWfEyBkxjH/7+bZbBgiOps/nUWnScxfy1G50/ui2GNQlPjwPFQfW+9fh2lxD5kEHKIQ+FjV/bp7d0udtCdb12sZoI3VtO61YRyYc6l4e1OvJc9069Z2Ei1dORE1+7CtHWgN7mCnsIf9OjVlyRFCtzMK7r1klYGAaC5OpUvJuPy1iRBG/XF0hI9ud/6JvwYKGoXBu6B0RQ8weic2SLC1GmWqh5hDviK7jKyqyjb+WKL8ps6jsI2T8Lq0WGUQ/F2UXELoi8D2a975/t3Qhy8Nx2QKVu0+/Zmo/xoJmHcGMHK/90EGuWX7pTmeptxF2w8Gfubc6Ml1hOa1/7/DlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXapVPOnU85TaRbRrxyH7snNNhHomk4pAYl6VW5r2Z0=;
 b=RcTp1Frr2j31oe2a3fSX9a9pAVNTCJSwg71bSWMYJSQc3bx5uARqmmE6+P7DRliy4Gxm9QL9wvuE9X1IAeleXmyrHvlQMX3FM8RrFAh/TfRbH4qfBXuVN41gGgI1sramu0r8tyeSQy3V4JngKJZWgTaYIXI9V2PsGSS97Ohgb5tJYSH7rrSzIDljN5mPdXv4TzbWNAgEAznrmQtkex3uESBKwEgEpUMdPM8YJkPJG4ORFEWQIe2pGv6cbEJAhLrateKXTVRrZZ8RHqWeXnMRVDh/KSU8aNJBouc8KW9UwOY93ve1pbTEY2iTiJKMcfMrR9OoGzOLr1xoZ1N3pNbxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:54:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:54:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 13/17] iommufd: Make destroy_rwsem use a lock class per
 object type
Thread-Topic: [PATCH v3 13/17] iommufd: Make destroy_rwsem use a lock class
 per object type
Thread-Index: AQHZXCmAt4fgy7U4Mk+W8RHrrZomDK8IAPag
Date:   Thu, 23 Mar 2023 07:54:27 +0000
Message-ID: <BN9PR11MB5276BA929A42949A85CD65648C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <13-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <13-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5208:EE_
x-ms-office365-filtering-correlation-id: 651f7530-6303-4214-2982-08db2b73d3a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6Hs9TLaGESSOb3R3wN1g7AhMo6MHfoiZD+GtZ2MtNu/CUlZezNXTYAyQSuyUdMjSc5o12MzCz9owzY4N8ovb3kQBGtQ4XdcELOknEzigU0gvkBQ9VY3N8TUjmw6mkDLHTEjNB2nHXxR7tTMrZ4ibRTGIRFlrgdPp5IT2gyeLCKI8xNhx97JZDICuIZ4A5KLL6Q1Kqyt2EZKwLgGvohPcBAfO/MMMeUC61NlvbICsGubihjUlz6UYOh8Jdq0GWHHbcgUyubj9IkJUx2r1R3K8B+Ke75wF+eKf5AWGiiG03S11OS67MiRRTUYTrxJq8vvwowpc/OA/tceteYjJn2OY74EOhcpySa9iRpY67EUlvpRxUzNQrzI71CFWsawZ5QEu9CqYFxLrG2xXPDa/BXRh6oT4r4EhpbRRtCrx2q57YEmMje6TpEsyUM4r2xSalX9TAXbPmvrwyH/J8I6QdmnF97dWcGOZ3K7V97OHaYB58Fev+iRmo1+ebHDD1vtf0nKQW0N9TI7tBzjimep/nbYNgQdndWqgdyrVEerlz3h/geQlQ27ZvgLMGCPeQcIulG0mSoLxy1K858/g3Xlo7buehvAogs5m2XxOeyUAxjcFBbq2zYvn+3fvuDo+MvaGytQphWCa1u70YCbZket9BHilYpj+TtbWAil8cFahXhOpHMMa9ynHfa97X0OTLaX+y8bSgU/3LggJdwkg05xLNE/oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(38100700002)(76116006)(52536014)(66946007)(66476007)(66446008)(64756008)(66556008)(8936002)(41300700001)(86362001)(8676002)(4326008)(33656002)(122000001)(9686003)(6506007)(26005)(38070700005)(55016003)(83380400001)(186003)(7696005)(316002)(71200400001)(478600001)(110136005)(54906003)(82960400001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q0B9lud4ck5HAc3KsuprLipVGIuh/dPK5ChpskvpF+bxwq46LZq4kmvimTvZ?=
 =?us-ascii?Q?aY8N0Az7hEA+0Cp44tjLxbYfvkbxF+kuvoI/iISvHVhqHCIZvURUw4EajAOW?=
 =?us-ascii?Q?KJWjMZvHwBO0/GkcR5GCnLRk0I7TjE0d6Gqpy5tTT+FH1/1kIVQbwq9P86Nh?=
 =?us-ascii?Q?xdl3imhUOkbk+8pXKV4jGI8hyskPq11xclKI8YG5srw1PvWkOiVY1MPvnm/F?=
 =?us-ascii?Q?pVL/SeSslfAZHpEiyGnIwwbropPysTslxhUE8Yp8zkh0F1UzotJbd97A26dn?=
 =?us-ascii?Q?86G9MKk+WApf38F59oJgKaDoZ+DX4i/36tTXoKs9ginX/2wDuH+cOksmXV/H?=
 =?us-ascii?Q?ZKJqy6bN4CnTCar40+2+kx0JItvqxNJNtvJhjvo5cYRgjtJwrL7dogZ7TDuB?=
 =?us-ascii?Q?XPi6WS+XHalJhnbgBDo+AzF9UZHsqx5o4aonbVqIAwnilCWbLmj9nven0MvX?=
 =?us-ascii?Q?xKPb2IvnyysPBj8zfZR0Yc/M0xhyfAMPRhwctsIWNC21wuoNfCZKPY7aeS2u?=
 =?us-ascii?Q?JvFKfQ+S9lmysgaAFw3542A5GAsyik2cjfWRichSR5u1JK5eCqhfMqCvTJFE?=
 =?us-ascii?Q?pkss8XX9oCDzSX3fwaceaeq7TUGhpRQVJLnuLGY9+lo1ABpu0OZ9eE/HM2RK?=
 =?us-ascii?Q?4B5hVmBvC8hMB/IZTPaxyhz4aV0O2glT9ljVjE+/MmSuFLr7AJVjzXWMP9sW?=
 =?us-ascii?Q?22U6Cqv9L1n6+d8xzryyDbezMG7FaPE2cA2Bi2DBW+ra1ubGw2FCOUBpCxMT?=
 =?us-ascii?Q?zDUsIXUupk6iLaDiMMbBRkfzn84VkB7HE4kv154WOqZh3k7UnGfaTqfdoJ0c?=
 =?us-ascii?Q?NmyapRdg109WHF0hG6iYe5t3cqOGKS3348GySixXZdlKqihjt6+5wY3z7NSq?=
 =?us-ascii?Q?Bi8gzVVydXu9q5BPAjuh7uVK9vTiZAR+/43G86etHmh8uRC1RVWGoxz5cVE8?=
 =?us-ascii?Q?MIfNDQ6yLk+c61ANi0lyV8SnHMB05RGmeTLpb4ngsaXeERo1uhK09zqNCnKW?=
 =?us-ascii?Q?ME+lYLGlAKmZ9phGNZh3EYr21Mb0TA1am/yE3aoyMv5gsghjth3un2mlkQzt?=
 =?us-ascii?Q?Iuovbk+BrgK4um40jqBHfnnyqoigooeBZx4iQh7JsnUO7wM3N0CpJAoBL2BV?=
 =?us-ascii?Q?DT/YFFbIjxNpwcMWxqB9a2TjH013qY5PbjbXlo8yODoG9SoFNuegw3sLOQJ+?=
 =?us-ascii?Q?YD8HpT2jJwjLKilnZm0TVmkwajyDuO6cfDF0z4CN/84p2iykjFgbjOyY2/5s?=
 =?us-ascii?Q?4MmfBomgNBRUUDpK2d4ddSet5mnU0mlGLIYO6gEiQwYONJ4HszwhkHy8K22R?=
 =?us-ascii?Q?Hf+cxJUbHrfMGYFZ+4dsaGaikAjXl6zUxZMU+auoZcyO1mc2DBNWXRhEqkFU?=
 =?us-ascii?Q?XJiEI+7aYlI7G7uIClPD7utAs2tODLqzGStdPdynZUUD75CXIwblEdqY7AFz?=
 =?us-ascii?Q?Bkdor9b1AcxfBbfDL6ySlgR1pvfU+zHZX4H049Au2447Hx+MFYyAvAFYd8C/?=
 =?us-ascii?Q?U3ucJZCDk3+zoKKlbnzB81BsJtUDTH73Kkzterng5Q9C14XLzX/9CrRwZZXe?=
 =?us-ascii?Q?7RJYjrOlJqhk/Djk4J6Gc2haIfTdlMWISHyJKH8i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651f7530-6303-4214-2982-08db2b73d3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:54:27.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PgZP85zmHL/3FTfMxIlK/vBHgp2RTV+Yc4JFmpjcpjfRAMS8IXEyVBWzryDB4Vpacl8XwK4ruRZQJK6CxVQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
>=20
> The selftest invokes things like replace under the object lock of its
> idev which protects the idev in a similar way to a real user.
> Unfortunately this triggers lockdep. A lock class per type will solve the
> problem.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
