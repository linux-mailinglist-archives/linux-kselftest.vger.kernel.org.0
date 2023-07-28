Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28791766304
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjG1ESm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1ESl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:18:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C008213A;
        Thu, 27 Jul 2023 21:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690517918; x=1722053918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpWYSE74GWAfjgJ2Kbc17cDcf9eBjGXFmNbvWOBU9q8=;
  b=YAPvbbOReqSFWVwSkBcb6suHa8qJCuGZ+TzXP4/lfHYS4nx0jROfAE4+
   eLvUaNqPLPM4HHPHBaiuDiP09UA4QGJEvYqS36sTavf1iKQr4dRI86OOD
   LovuSq/nbL9oC53hjqTeeKxGYcNi4tySZrH1TEoSCJN2mDihy9LKMd5UB
   KRo9aA7ig1boQQXqhxIkL4Xj/AlZeAfgXsd2ERGMcJ3cN2YaJcvZ7ZVZL
   Liq2rpUtaa0fq7NAtzakEO7p9cnrfwPg15VP7wzmiPOD6vGJ2A2O/+fbo
   djOH+LUZcwDopVTPxMC467v7T9krGBh0MEVKsS5UMfzVlIxQRDWearVyo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348104405"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348104405"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 21:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797276766"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="797276766"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2023 21:18:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 21:18:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 21:18:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 21:18:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz12s4YEZ44lmQt9T5eK4NYVbiQsOeG7kU0jCe3uz4sgFXlsSLmueG4dy6jnQsODJiNn5ouNzlFcuNrhaHNXrMkD/DNbtN1Q+WvPr7hym1N2ro43lWbnzFgZlJVlBxaWm4awOQiAPXhb621q4SmMZV712fGTPyEh7JdBDt1HaPSuWgvkzakLOxQsXaYVlRjr2gT/vIvMk+eIbO6pwruRhDmA1+rYDJHdkq8YjFYrITqyejNTSEeJ7lQXKgxciThXY1WlhWFEFv9KaSzLna+Z6qQPnD8GM4H6XiGVUCNrBqk0qFvNySUmznqvjPqk4OzoVgRs/I7f2e4Lhv4vo87Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpWYSE74GWAfjgJ2Kbc17cDcf9eBjGXFmNbvWOBU9q8=;
 b=bJAUlHA/8mL2fYV5TNN2QwxFa5vPDmKwRcVZs2ktY2cfdKFKxyFYEVrpUJyfTkqOERqvlvIjtN4FoyNiIwAZ6+xJmXFHfv6MLXWTYSctajEEMmDdRZu/C2/kmwRA2AW7xOtwTbYSFByyZdifYPxErTeKy2oSqRXGGJsFlaRGLm6M+oQ5mY6U7DtYG8/xGJWNlNBQ2eTDtcJ9Uigj7NZ8UYI6i0sQpJm/YpE8Wj84/nLLslCdBbCoZSdg2nZ6pXXoWerB9QkDB2+UFiqfrViHjkeEnkbyEDTBQ8Yvemccu7MdotVdJWaSawR0vfG5GFrEAjIFVg+0UxHfIuVN+3+GUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:18:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 04:18:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v10 2/6] iommufd: Allow passing in iopt_access_list_id to
 iopt_remove_access()
Thread-Topic: [PATCH v10 2/6] iommufd: Allow passing in iopt_access_list_id to
 iopt_remove_access()
Thread-Index: AQHZwMh6GOXZ38TX9kW7IqJBpSnBsK/Okysw
Date:   Fri, 28 Jul 2023 04:18:29 +0000
Message-ID: <BN9PR11MB5276401B0BEC142A502755BA8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <9cf230e73d40b1458dcbb116d1fcfe8c62058bfe.1690488745.git.nicolinc@nvidia.com>
In-Reply-To: <9cf230e73d40b1458dcbb116d1fcfe8c62058bfe.1690488745.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7820:EE_
x-ms-office365-filtering-correlation-id: 4e2c0752-01b4-475c-ddbc-08db8f21b2d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 00t1zPey80sbZBdrOx8WeHyxMKUZyXAzUr1xZg9kNtYgAVd58MoTRTbCo6cbcB8XNa6LM/XJOFDdFqrzhtY4AS+T1MZWvLxtG8MD+4jeP1eJXpdMROAVwQhdaeuN457UV9yJjNvcUVD+hMY2PduIESmCctN2+uCCPV914t9kbewOjdx2DWIDimh6wHjQe6iffdJL1xzl4sgjf3q8fVGmhY2rSORy4W81nwTllfSi7K3njDEZEz645I9rbL3qChLT1ahrPLx9nicV6ag2Hyq4h9kU6C1SR4diL/uhXZbsqlMpAricr1Ct4dsgivQjWJUl7By85FwAy8YKFwRrkYeJqeenkH/7j/53SQoZwdoLjStbBHsAEU68zmkI9m++DcdMT+HuNPYn6U5NsvONGhuIzoW8AIG/moIMmtbJUODv9b3z4lmi9Gju1jxLWoDFAY5gMuZ/07965AoIo2YY3Z5Y27H8AsziEaARlJEhItwJE1j9YyMgdaPedUJMBhlRhXF2BBAkbwRF2ycRlqWQRG8ZuSdxeEOyZSq4xSU+jdFoFmLAA0/6QhXuwtvb1pubsU2PxRfxpOV9Mjyize2NKBIpMkZxcgEz3CT8SiPyy2JhHUp5Pj4KcNOzoRKFj8VDxWRX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(2906002)(316002)(8936002)(8676002)(52536014)(7416002)(5660300002)(4744005)(41300700001)(38070700005)(33656002)(55016003)(86362001)(7696005)(71200400001)(122000001)(54906003)(478600001)(82960400001)(26005)(6506007)(186003)(110136005)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(4326008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D32BrLnyZf9/WcYwBfkSjuvcSPytTJ3nONak3NMak/rEuY03TPQtdGfPJ6Sa?=
 =?us-ascii?Q?w2I4WAfU5e0fAYKHxGCkm7zUbxc/ud9Vshv5S6TqfnhNHBe7sEQot9VJtpNl?=
 =?us-ascii?Q?sDg2AOijoXsRxW7mBb1BLRP+qu8Fp7vQjK6/w2aX7px2h7xHJuRQ+MseZqE9?=
 =?us-ascii?Q?bNsKZwEoP5gWxtug1bGwmJywUo6fCAZ14yWIyj2ZX4jQ6XySvy1A8mQFZsET?=
 =?us-ascii?Q?uS1CoA3+QZyfoe4G/sNmY0PfAMftdl2PND/FlvyK2CP2CJrwf+M5n1cAtOHj?=
 =?us-ascii?Q?gK50sFJcNSGzhKuS57U4JXTf681giDc3UqN0pFlEbQ01U+aMWWhPyo1FQiin?=
 =?us-ascii?Q?xviqrQdkQbxliENexMI/hhdA9fo+nj3HVfgeLZrWpnIE3I8Z8mhHVkTYzLnt?=
 =?us-ascii?Q?eDIvVDc9jrP2+obSMiC8SO1Dz74/fP7H/JU+XaclNZWz0mYymf9azQ/ehpK5?=
 =?us-ascii?Q?scY6+NuCi4b8x/aHl90Y7WlTP6OhWqyFLkjEiTerXa9GuZf7aqAo71ARfaRZ?=
 =?us-ascii?Q?42M1d8LSBOcuCJmkRiULn13f9/+TjEMTvxI+Hny8fC8Sw+LXBX/3P7aa67Aj?=
 =?us-ascii?Q?6qftQs4yWLza/Takjk4ptBQRRPS0IQY2EhbjyMBGXpKmJAku1SCifBeJC9mS?=
 =?us-ascii?Q?gF/iBFR5D255IUBfxgfoJ39noNwl/NUJW4swmw9bRaMiNjhZ/jhHa35s1F36?=
 =?us-ascii?Q?Xp2lyiSUMdimHlUvP6sOStMYj6RwMMQW6itVbvQPgjnO4edETvgrvXO/nDSD?=
 =?us-ascii?Q?3n3GjUAnyXp1BzK5G8J4uboXVktHFCd32u4uKAeuYsp/bIq8I5065LyhsWY4?=
 =?us-ascii?Q?JIhnkB+xDiZUMuXhWMEF1j+tgUHiaMvzroHg7vvqPMbj9kU6NMv2i74+ciii?=
 =?us-ascii?Q?6m4jzQvNx9ghuSb4KFHw4gz2xGUNbW3eMW3Cb1fl7Algc1vJWQeA8iYNxf9k?=
 =?us-ascii?Q?tTzeF84fv2LniT6Y/UBcW6GWKFnAhsDx1BCNb9FikM6MDUYuKoNvoSkxlOaq?=
 =?us-ascii?Q?5EmP88UI0WLwIibGWJ1uVdDP1QwzAAsbQjOrHuIsJp4to4zfh0Pi9TO7QhHi?=
 =?us-ascii?Q?p1ecLLecvgmdR6ajD2WpB3vzfdsdXeDz+x+psZS+kvpVdJgRUcuZNEv28UPn?=
 =?us-ascii?Q?CK77ZX0IEXfEUgPUTsS9prHaVyO8oimSWa41dTAx8QEL95xXLDsmG7KSHJJY?=
 =?us-ascii?Q?Nuhci6wGilIpZcp/qMtLpFnzkUbsRZ4K5rK+6p2v/AEFeJIDOUauTl77WEvB?=
 =?us-ascii?Q?ZG+b2Ulxwseriz3W+1Ltfp0+UYRxO/TOEVuFDVpibWLzitByD18V3Yk+S4tu?=
 =?us-ascii?Q?ohHt1U+wx9RYv3kovutOylURiloy/VMaZR778bEouqDstrdDCN8Pu2DIB4CS?=
 =?us-ascii?Q?QQdjat8IqlILNzlLFLQAyVsJG5V0T38zSe8HwzMGu9rISEbV4v556F1Cyv58?=
 =?us-ascii?Q?qzAFK++Nh5MSQZT5Rxh0HBKc6kufANTpkcbXoOk1dXhT7v8/8dhnFyqvzI2B?=
 =?us-ascii?Q?b8oV4nAmGdAM+nJMHMUlAXKiGdIIuKpgObWfQZp5skTqAQy9Y4NWztZ3MzAV?=
 =?us-ascii?Q?16tDfWl4GLPGrXdFJbbuXmkm0b72aLut1w6/UFTT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c0752-01b4-475c-ddbc-08db8f21b2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 04:18:29.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFnew6R+JUfPU2RpTd0FDeivrMlpCjHGf3xthtK/Fv6PLE7p585ZbInT7Etu4JprJmNvsPSs4fSc3oVTbF1L3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, July 28, 2023 4:25 AM
>=20
> This is a preparatory change for ioas replacement support for access.
> The replacement routine does an iopt_add_access() at a new IOAS first
> and then iopt_remove_access() at the old IOAS upon the success of the
> first call. However, the first call overrides the iopt_access_list_id
> in the access struct, resulting in that id un-erased in the xarray.
>=20
> Add an iopt_access_list_id in iopt_remove_access, so the replacement
> routine can save the id before it gets overwritten, and pass the id
> in iopt_remove_access() for a proper cleanup.
>=20
> The existing callers should just pass in access->iopt_access_list_id.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
