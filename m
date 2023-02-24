Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342FF6A1698
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Feb 2023 07:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBXG1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 01:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXG1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 01:27:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93765E854
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 22:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677220029; x=1708756029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y6OMO8nM90V/DDMVamiouqn29VdZathZiCc97X1HzZs=;
  b=Usv85Ib3krU41wyy7hex6TGcHmVdTQc3nHMohLP9wTwCeWwn/DMZbRob
   L5ATayCzFmou1PzJbg+vcrs+t9tTpMKiYW0HuZYiuebkz2fqjQc8TWmi0
   or94+3r/JyAsI4SepBNOx3beS0QMmf9Hwf91zgqqZItnUWyea9gp1QLXu
   DhQcrBB5nzfqwOX9LoasVA7f/8tW5fqJO0C9ctAcjui/PzDsI4QgXvQhp
   b/nIRn30EgOu+yS8dfLdN1Eezn6GNO7MIqXXReyPnpjJhXdTHZ6rsQAT5
   ogUyTEdvfcu3uYtQmjJv3sxJ27tTtKDlidU2hf13wwJk9NL7t6fn67VJS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="398142310"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="398142310"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="666059416"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="666059416"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2023 22:27:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 22:27:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 22:27:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 22:27:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuWIuUNOYphOActmyCvFJuW7QUL38jVOWk4ixvjHlTWX0K8FGnWEf+zczDQhnu0B2FwZ4XwH7HBgs8xYbi0DLlh8KWE8mMkIei+AJ8NHu83ZpwYuiMT6KvtApMppIPEjlr46baOL3OcU3R5h2OhjckQ62TXcodoUX5XjXOHNxTM5w6woCRKle8LgrcYXC7juBbFbzmndR8RgjlsIjPegC/SnooPHFdxDcMFH8ZggJGbJJh9UbqShRdbdxV26JBXKy3dx4J36ijq4BqUTljUStJd6OKrPUHW0FZQsSHLLG/mQO+YGOT4VaWtcbnuTgrWiUyJqfIiYJbcC94hYPNBEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6OMO8nM90V/DDMVamiouqn29VdZathZiCc97X1HzZs=;
 b=PZyUzMplbRv2qUjnjNcFEEGRH1plmUkiDZN/XUZCmDNrDDGg+BvJVUY11ZoUbIhNcondKFiaFiahxFFg46RX4/yWhi4OPOIfw0dn/HHahIjO5xyCO0l2tVfZhvCrinASibNoCyvfTDMN+j3/NqLL/pTedT3QOtXjsXqAc0HhjFjlJ+IUdX4FhUZ9+8Bf3SngfZ4nXlKpvoMg+pkUKFeMPvfkj4rUnkEeTXCUkkmGCVA0lR6fBhdvbmoyP+DRvNMPd1/WTxv1NzvV19+HY1PX9diKOFydf/aUqfT6DEjlx0bgOIrHyoTgi9LlCmxB00aYnFD/m6foT/C0xAspCRfzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Fri, 24 Feb
 2023 06:27:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 06:27:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 4/7] iommufd: Move iommufd_device to iommufd_private.h
Thread-Topic: [PATCH v2 4/7] iommufd: Move iommufd_device to iommufd_private.h
Thread-Index: AQHZRwEIr2CCNcknRU6k1KeIe3aM967do/Lg
Date:   Fri, 24 Feb 2023 06:27:06 +0000
Message-ID: <BN9PR11MB52761C0CF2A41C193EE8BD218CA89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
 <4-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <4-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: d58ec6e7-8c5a-4e74-6d02-08db1630269f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWVdl2SrtbfIcAqvo7b0ig4rLGtY5FZ7mRoszObMhtRbyWm09VRpNEIB74Kkb2EQryjaQjQDlz5mqhB2yK8mqg51xDupggm0cpog+7L44WV0crx+wuMJw1SlL9BQRWUgfgk7pE9vQDSeB8HFyZPbBk7zcPVbNMomR4A04AoUuHIYnDecKhOSD2J3UAFZ9AOPfUjkHDd8YYwfSs2/lecbPRIyDgJjh0jmlTZHiwUM4x6EicWi6pFbJSkH19RUAS57c/+TQ4HwCG0xcXoVwwFe4H8R3fhtA4n3W3MWdrpcbzheuS5raQ7Mcflgb+GzMAg+cEfwbIVw5R7EnBAKvEENTt/yNW4H26aFhs9ZZhHfjrBTVAwInIm6Vw2A8ft8kBcXEP+rWjSeQrIolN1b8EYU/DsdbJjoMZY/JUHQxHiD6ox5Kgax/W+lNo2gDQ0FBDX9HqKuHpirbPng8/qTHY4ydUAeIkBoil3FYwTSuK38Xc4WsH1ivIOIH8O9jAFtz+GCjDQ+H2GmcPVMwMXQe+mWuvfHHPP23m7e2VX8vzCPMPd64MdmcgNy0tyd5cBvj0TrZwlb9Y3IFr/VfYxZTsiBYFw7ucKizrc3RgUxEGbjZ3Soj5CbnmMYJf8AXJjrf5G/cdvICjTUBcYsLO/sgU0eka9/1D9gJdHnlLY9Q9qMV/2QQj2ZtPjaqOH00V7Aw3snasB/tYgLTDCYpHgRAjnbpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(107886003)(8676002)(316002)(2906002)(66446008)(66556008)(66946007)(110136005)(71200400001)(54906003)(66476007)(86362001)(33656002)(41300700001)(55016003)(478600001)(122000001)(64756008)(82960400001)(38070700005)(76116006)(558084003)(7696005)(4326008)(5660300002)(8936002)(52536014)(186003)(9686003)(26005)(38100700002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mz/S85Btg5tmv7JcRwvB/ciQnxl8qpmIhH9jhGZz70jDrJlFmsilJ07cIsrX?=
 =?us-ascii?Q?RIFFt6+G6izJtZXPNG5oWci4RhDU4utW9j5zYqwhx43KSK3eSurD43nE925z?=
 =?us-ascii?Q?HApQ770R1IsvyQxkqP6hHH8roDNKNxvTZBe2lrpjLUSPA3R36WiHgAglqcmc?=
 =?us-ascii?Q?SOh22polM8x9jUVy0hmi/vv3VvLjDD5ZcQyCfkVPMVjwank/jJS8PTolZTSd?=
 =?us-ascii?Q?nAaqwRCHTNu8YHd4uwiz4rcyMhKyxyUU12Z8t2dTQJgV60LsK2iqkraqzHGE?=
 =?us-ascii?Q?IIG3ny7nL2qOutNvx1hkz8SAIpzli5xCgDS2lsh6jMQ80dV+yK1sdpfOTsWj?=
 =?us-ascii?Q?xzfc2vyTu5WZ+KYzBJvQi1XJ3ebDb1rNUwz8nJXMw4HY6FCp5tzFAwZxAaqM?=
 =?us-ascii?Q?sUrQbr/NwaE3LD4YbKdzNYWal0T29XqX6eFaSxMlwiwY0F8CUur0cSg+O+9y?=
 =?us-ascii?Q?kez17+X2+ddENlfzxlEz4PSlvjCw+rapDr+PsWYJ3U3e12ZjSc9NZxkwF8MR?=
 =?us-ascii?Q?5fp81kAS/ACAsH4gNMs7sOuqQJSaiHVhCJoH9R2aQ5PTPWGPDf04Jpi49rW7?=
 =?us-ascii?Q?gLrfuM8bst7FcTelFRLAPk9wAaiiQeAivxYud75Fx25kg1aGX5ys74KDV6zr?=
 =?us-ascii?Q?Mzm1qIfnv5sMBMM4HCSC/1a327x5KapkJJfniMSqfkfZ0bu8kds2PQXcT6YO?=
 =?us-ascii?Q?PNStGswJkgYMfk3mp26p+zL0y9U6cJlzJP7zbbT9EehMc5OCMtw43PUjIJLN?=
 =?us-ascii?Q?WwYVVpH5G0pQen2hNeT9QMHa4PP8cRisiAlNJPkkhfTtjWpQRpvLQNYSBdKt?=
 =?us-ascii?Q?Fz+BOPL4/2Sb8z+eTH8Htfy0cyHmv41NS3BFY+oPLk8/KNxovjGaaCfTy1h9?=
 =?us-ascii?Q?9H5D7TkDzGKUJUkD3Yj9iqdOIsUyPk3iw811/z7oclwECEZO7KGPkXWutXS3?=
 =?us-ascii?Q?rJcIaJChPxVA4ZWIRxWheMAvyLUE3FGNxu0EuOwf9sxFHl9k5TeF6zAFyN2W?=
 =?us-ascii?Q?sUDoxKLKMRB5jlbpRUPulRS/g2c9Xkkau9H5wfzcmMnIBRl1zpIMPKV6uqkx?=
 =?us-ascii?Q?3MTzoY4OopxDQIakB1CEIl1vZ7YBrYTDiaUNsDS9udyD9mv+yycKhJHDQvgq?=
 =?us-ascii?Q?E5ZSPQ6V5EiTXxowVsmRbOhhG9gaHLP7VpS0gk7Ze1JRVVXrGke+4jAs8jZ9?=
 =?us-ascii?Q?aFPnijW15RNaMZTi3kD/j9vrykc2Z7mXhey6HksgYpAR0eBriVJZSDsXGSlI?=
 =?us-ascii?Q?O44gmUvopseHAXVLvTmEDPu2gE6XUfsoOXnPz+1KXc5ZmiAtk5e0OLOEcVcf?=
 =?us-ascii?Q?Ry9YoT7E1Z3wf28sYv1/eLHOuIHqIc/z3ev/z1OyX/v+dn1oMjrERpNgiLqE?=
 =?us-ascii?Q?xxQgcBFFug9ycd+JipenSs1eaFcYdQI5FNJcsXnXl+0eVdo6tFYrdTcJuY9/?=
 =?us-ascii?Q?wEQouY4fpzkd9EtrZesWKGqHjERgRfjQQNONWqQ9kM81qpB0OjzJ6RRNeFbL?=
 =?us-ascii?Q?n5SQ4z60BWducGsH8VHu1wxKLoKAgsVssDjwinOnYJ6hdbMQOHwrhU3R7Oub?=
 =?us-ascii?Q?8hLu83mf3vfaRYRNChRCYNi7/gQ9mUXF9wEcHJLt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58ec6e7-8c5a-4e74-6d02-08db1630269f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 06:27:06.4971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYoNynQK+Kj1brugkDfIKcC7TnQzR/fjFf4HkpS15ivWbDekGMZM6SpAi6E8LTs2ckJB7nH/W7/cay74bT8nVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
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
> Sent: Thursday, February 23, 2023 5:03 AM
>=20
> hw_pagetable.c will need this in the next patches.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
