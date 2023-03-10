Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABD46B3CAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCJKqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCJKqN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:46:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA365E2C57;
        Fri, 10 Mar 2023 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678445164; x=1709981164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0aemjHZx2ZJHhFZp/RzU9yo33ejYNWS470P6tj2BeN4=;
  b=fiK9RfsSuMQpxTYR/Q6F1CAZvUoq9me6v67sYTawiaRCOiEbBvedWZRw
   ++jqxXUWbjzLdQFJcE01dZbN6D4/sDmuTO7hS459751GL525RWtLOPU11
   DJ0NzZYDhr2hyb9KCWttIg8prozvUDptlGsNtffQ+clnXX0h43MPln00/
   Zp22bNWKE57ngEsp0H0oIh1etQahmAY8ffzOtGHZEB1nFGeJPG6KbsDFl
   BncIqUNAe7ydPtcv27hbeC4AlKxZS5mfhzqDQOzPJSqXfhgwqYXEQjnPT
   /r/sDTOVDBdElC5GMWs50rhXJhrgMgDcsahofMB3JodEOIx8otkLCvHKs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320554319"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="320554319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801537830"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801537830"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2023 02:46:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:46:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:46:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:46:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFmy0sdle4maaLjaIWbZYFtLJOQ/2sVrDbd2kchtdT1pTwJ5jm6WiMa7V7Du5qsbxGXwzAX28R0vOlnx0FeFy8NOezhI2BhbJQuE/VE2Ab1xekUehnJvyY1J445YnA3Smb4n8hG0NcRzLg69vP8gKZMGVXYqO0cL8YI+8H+JDuTah8P4dQSVgXI8IP8NDMAQ2Iqoi/bwTeWvYsykPYWVh1svc+oNPvUxZKhyjQlkAKWe34WJbKH15pBg5G/biVAHdeCMOTSc6n1rJb7SmFqfDZ000FPbBgfqHlx+hBAjx3WjhDfFFgLZwj+dG75SkFB8YUhnwCm/lIXk0GP3jxkQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aemjHZx2ZJHhFZp/RzU9yo33ejYNWS470P6tj2BeN4=;
 b=PEMXGlQcK+rrBIqQg1yT0CyXcPPO+JhK9InoA+BvT9KmdgcqjFBLj+Ti08zvNX//clmJzOePW9CKX0+e3jxSjAXf+rpxb9UU56idaYolYZUHN4d5hBOpXVOCDdSnIoid2B2akOEQ8euSiP708sxpHf1N3hrAWDfEv+Q0ClnjwE2rcDsesZZ/ZXriAq85ycqo5r6IEdgiLWHaCEBXYKcHa2yCoWZrFS2pZzF9eCvOVGubdOMFCOwuIy+Rps4bxIkJBqYuaf3ZLvZqzKmSToYOwmoV7977wV/HaGe+T5Vz8RA7+J30eaccnPIkjCzpBCzQcJ3XQAP5eZp8U23AN+0Ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 10:45:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:45:56 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 08/17] iommufd: Move putting a hwpt to a helper
 function
Thread-Topic: [PATCH v2 08/17] iommufd: Move putting a hwpt to a helper
 function
Thread-Index: AQHZUVYBSY07c7YU5keb5ETQLoTL+q7z2Cpg
Date:   Fri, 10 Mar 2023 10:45:56 +0000
Message-ID: <BN9PR11MB5276D9278DF651737474D5078CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <8-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <8-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6745:EE_
x-ms-office365-filtering-correlation-id: 5b020cf7-6da3-4d23-7dfb-08db2154a0e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BpUMWfuxe8FMo9cCd5Y6u6gAr2ayd5cJmOlFg5TICv/c+/G2Ty5h53kaGSH/jJHY8xyb7XLmHoJ49+KMT35ixWN8dx/RBvUJgDViajTbiKr3s09c8o7gwSG4ShuD+SznfI93M6vhwB3WWV5M/0722USkCygQDTxOc1pWBXFIskvV2KA16N9lAhcNTQnhpffBSu2DlP6dCGVQcn5wVNo0Swedw6rM/r/Y6/AiCbHuMxymfz/1xdOx3r49QnnZ3jwN+U8QeppyqCvSi4YrKHjdSZccE+t0T2BXGzW6to6Cr8u8r1qXHj5SXGHJrWljaciKiKTkn4dLlEpp99NxAffy2d+pigliSzJnCHIrFOLpKt5bOb2TRsqeeknICOimdvVFgxicfNihoNbP0/gP94tqnPFl8e3G1MtPZt73L7h+0cQ4P9mPeNZIOdH9JPgzuDeM1K2TI9mvGhXqZTikOlFwj+uO/vYTgVCZXaLfPMeLYqoKmmBtvNEqIqATbnthCoZjGR1w1T0VH54iK9MswYhFHuytZfAb40OPLlpGxP1usJW2A+X6XV5xJm/knCs0ZbVuaK5jWU9l0U5zAetnyScmySkXOwQR5YpBKwluD2B4iRi+KIRnk8riAlmWUino5tWhF5SnlVaQQSyErnzpRIDCQIk/GWBC7zlK5GLwI9Ul9/dQgMEhDAlVHzbu8gSSPgujIMJebzaBylPN/JK7RmfFPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(38070700005)(76116006)(2906002)(5660300002)(9686003)(26005)(8936002)(52536014)(4326008)(66946007)(558084003)(66556008)(66476007)(33656002)(66446008)(8676002)(110136005)(64756008)(316002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(478600001)(54906003)(38100700002)(107886003)(82960400001)(122000001)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YV4/sCG5STq82eCYPuTaXe3ZXW5L0N7kPlsbfReRVJOAqLWv9LtEh6F+4bIV?=
 =?us-ascii?Q?DXEXeeVOkee8FYj4tOBEJkwbLHMbzDoLU98W9CpJNTMpWPLcJDgH62qSE9fg?=
 =?us-ascii?Q?LwjlthyGu5e7WaLqUd8OZNcPlbGpbEIzSM4lzxK0pREGvui5n+ZJseFzId4A?=
 =?us-ascii?Q?5Pbb3tLgrfIk8KMoq+jQ8da8iy1RAZdM3ep+ZyN1Iv692LMUrq3YzwpwqGsT?=
 =?us-ascii?Q?QN3X+jRGAgnKPPNvcys46oXpgIsjYUK0o4WHG2UOt+NyPwWPN2wJLByF/Ege?=
 =?us-ascii?Q?oKA1hdiqVkq57LC2M2hqMq5A7hL9DZCZa2WpKTNgr533sG/qj/P7JdC6FZea?=
 =?us-ascii?Q?vpxpYAB015NwLEhqLYI1ak1vvKPovT1RuuYsC9jjwrPEzWCSap9gL5IOqEwn?=
 =?us-ascii?Q?sciNCHrRQQeQbj1yPZ+A8DXPkh5rbztENg8yMW4MrU/6wzWiMMOnO76DxsV3?=
 =?us-ascii?Q?O9np5zOeSMBMvzaW0u0RUXFjwpX1QZPSysxCLxnFxTnjGidjp/AzpGIXi5HG?=
 =?us-ascii?Q?vQf/W84xXYUtA4zfbrdFpePqjZIaCINvdCli/25lOVDP3MoRr1MbEK3NMXws?=
 =?us-ascii?Q?VS4Al9rncVFAyDuaXM8i9di1da+odrYOieaHe4CzHJmicaaIE2Jt8KNV/t3L?=
 =?us-ascii?Q?ZNgs6tkwxCGsIeZyRZermIbaGt7scIvHRKrP6VUcvPh9uUBIepgX5PCYACcK?=
 =?us-ascii?Q?edr/1H9UN3LvgnNZsH2frLGlWH+5IpdqyVlfQ7ozd+hGKRL+47wxGegNrF5h?=
 =?us-ascii?Q?fDdh/tx3omrLOBa4gY4BG5rbmdQs7ln8JFOtDlA0AffV3jzMAYdAJNxo4jRr?=
 =?us-ascii?Q?9QtKQHP76MOzAnI3Poo46rAnK7by+XlxTChPdtWNKXxeR+mVMpOy54ofUjsr?=
 =?us-ascii?Q?GntOa+iJU16Vp9OpzlAyYNRIS4sN54VcvUmCyx2HQwBhFKfGi4zE8gX4zXeG?=
 =?us-ascii?Q?1EmoZCWtxsVi4DU8dKlaJPCLBl8rC0fRwrvntW4DXyDtSwgaXu10bOHC8Cq7?=
 =?us-ascii?Q?ag5PF8JE0BBRf/NQBXIAI6mw3bAnVpIrRI0dOxlhiXlQ9uXpPir69xx+NWGC?=
 =?us-ascii?Q?4KHwjmYukffTUR8Va1DmN1aV5WYlVUKP4Uy+8SHxfM3sAtcGGxrcsKxVwmGr?=
 =?us-ascii?Q?uu0TkTEOW9NqigLz6n6G0AKWKLvIC5pyEZdh53B3ngYJzM3txpP0Gf6JXgSG?=
 =?us-ascii?Q?KdXkDEjKrkc4aHXK66xBWOxLPs+ivFxQMpADQG0eqnnG6xvmfg3+9g0hIsbC?=
 =?us-ascii?Q?J38/lQiwjdTw2NgaTpANVpTFCbtsptdJ59FgTIemf71+svsJGXduPrg6pz+x?=
 =?us-ascii?Q?rHlEq7tSJvbHqGxpdFmCPD7sqN8H6ooDz/e9rSfqvEh80u4YOEntpqdr/4kG?=
 =?us-ascii?Q?F4xni+zLANJvJWXg1W+MLNhu5kb44GSlCp4OKoEvSihO6MePzst8gN8LzrBS?=
 =?us-ascii?Q?mpfiWQecdLKB3pXjnRTyf6DyMhZkokX4q/4y8xn0CquBP6HkjcVvLgYMBya4?=
 =?us-ascii?Q?Lt86W2zh/FoBeqvZCnGiMu6VuFQnmceml8d9CZpC9FJqe/n0h4SrNdWZubLK?=
 =?us-ascii?Q?yVhkAthlDa7W9syzEteUEiXDozGgtLLMWA81uinY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b020cf7-6da3-4d23-7dfb-08db2154a0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:45:56.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkXs5XbD1vNAJfXUtn+/YeiIOwZ2V9/Q2tmu0ZU2GdJI3X4LfXdC542rsh/z/zjp4hWEKFitHHDOe93ThRxRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> Next patch will need to call this from two places.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
