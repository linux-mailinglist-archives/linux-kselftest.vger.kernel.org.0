Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C74D6D5C52
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjDDJsw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjDDJsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:48:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA341BCD
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601729; x=1712137729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JpsL+NRCRkiKEc2iuYtL1h2KoMQw9SMiCS2XHWAvkKQ=;
  b=nyIfvIfjYn5QkyTKeAthlMmMtVzJtFY0HaVhexpGQGZ2WASITMmQr+XG
   /OiqPd2bcnB30XxzsuSP90ZrKX26I6+OcVvPFCu/xeHv0GmvPiSPGcPRs
   NBEkIMTUDPi1Fzo1M6iqdCnQKy18qxsrrIbHZzgq5+hAA/lFCuaVYXVSp
   caV4DcOnQSlnV4APTOrVrplwS2PiDjRjAPuf4DM6F4wOHdmhhZbuB3t/v
   SpRAR/AmXqI0m4knI2NopUTOVm1JYGpH+vTp9SuHCZxxKMTKjCRmtKvFz
   duOsrdq9x6a1ypq5BRP1thV04LFj/l7DOWmf5ut8I6YaKy+XiXzubnFGh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404900981"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="404900981"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="718882323"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="718882323"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2023 02:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:48:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:48:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:48:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHd986BdESc8uIHVbGRRQQGq/BciZaoILDDnBCgZzUB9wRUF9xseV82mm0aXfO/RpsQB6F/LyGo7mNbc6TjHWkfs/9KzWVRSlHBSvP3uuUfXGFARt2Uco6tF6r4WB3zEqgMeNOhjF4ZBtNb6biIc6iMf6DApsw4KTNS3o0Vs34xPDIO6r6/Bkz94ZE2L9K/9ETRA9ZfhK8Xw0e32k16BtHVxOmOGMWBELqrVTxz7lPU7h9nF3i3dNJgLbfDROkYoEw/Dl37IibAOEedOnXroU91heBv3cPi5NSMqG8498A+0/ZJaGskU3Ve1QywIjwNCjJd4eXhm98hZ5YGYoiON6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpsL+NRCRkiKEc2iuYtL1h2KoMQw9SMiCS2XHWAvkKQ=;
 b=BgWUaHRbf4rF+EMZGoedw1NVH0LnQYX2KZlE1wKEsiGITdpZ9+hiIsiWRLHr7eKXfqCp2qy5Izy1F/KSqwh/M5n31qTuKIUTlMzQVSqvPOSdVZmBVm1xmJoIGUp8/AIsdbLA9sUzarZ63rkkDfrZDYFoE1aEhz612zvS/8aCfzPQKvTNe2uuCaA4j3voidTs5qufUxL31TpujMoYGsf70M3oA0l40Ap3zjNBxtMUggZ5PhXX/0V9Og51zDg4O1ea6A8srYtyRxoi94UT+BqqAkmcS1nqEl4us+t8FlfEtGOX60n53GP4gyG/cUGRXl1NlypOZeRKY+p8KNqbQrJCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 09:48:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:48:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 4/4] iommufd/selftest: Cover domain unmap with huge pages
 and access
Thread-Topic: [PATCH 4/4] iommufd/selftest: Cover domain unmap with huge pages
 and access
Thread-Index: AQHZY+YKB8rPlPjlnUqQg3GV3lWuP68a7WiQ
Date:   Tue, 4 Apr 2023 09:48:46 +0000
Message-ID: <BN9PR11MB5276C10604E55E7E812B6CDB8C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <4-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <4-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB7940:EE_
x-ms-office365-filtering-correlation-id: e68ac336-424f-4b1e-c853-08db34f1c8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LzboDsBjht0G83oeBtDMIcxC6Z6gQmX9KS8owMKttteB8Aku5uVxkyF+rHw27hUK5dIqe859TUkAPhhTKZu74/3RwEdkTIz6IvUPEupGSs9aUnK/AXyr89AEvIQ2UJIsLA9kCiwh5e9FAbDDbckPtmq4a6VDnvhswh0lJ8UvA3AYpBz3rSOcgmG8BUmLqCvZHjLhfZcw5VuZGoQDcX/JtJhheub/dGpOgQD1k7pUbCTceQPBe/D18gtnwMRlSmG2ZsZgPuQ2slSX26ctwZ6uc48331L4scsbAdaaQNwVGxnSeJ+zzKu923+F0mcK4ttleTubJpbMT4U92/Xwqf7Y5bJtb7q378FHYwj6nLFlJfiQFKcjm9+PWPl8d6kIXHI4jq1AIOaRBdnR33wcefii2TyfziTFKVUgU7L5wpSltbwB2VvLPrJeBNzNcSph3dw8tGOqr8McHO6FecAQRM3lKEAtteIkMCGRvgjTi8yf2oFUS/PU8IJxlciWCpYORdcDTub7U0Dc15nrVtI8tTdtTlS+xkx9gLRAMWXUmiroNrYMWYyof8LAOKa2p71qw3eOmWr+yGzJ9bN+R0yw7QLpwazet4dHi3cYLDyBrl4fEQD0McGgzT6lHyUdqJ7sxNZ9k3xfcYzfriEbGaqcbf+pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(33656002)(558084003)(38100700002)(122000001)(5660300002)(38070700005)(52536014)(55016003)(66476007)(66446008)(82960400001)(76116006)(66946007)(66556008)(41300700001)(86362001)(8936002)(8676002)(4326008)(64756008)(54906003)(107886003)(26005)(110136005)(6506007)(2906002)(9686003)(478600001)(71200400001)(7696005)(316002)(186003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3g0gcE3DsDEV7M2cY+qm6FYo9GTx0i/lUyuUMIO0KbyQmbY9Ux6TzkuEuhyc?=
 =?us-ascii?Q?Z5vcLoBALQYRkcsSwmY2pRJORKuyScXNc4v7pFm233TLs729/WDdcV9Z6bz4?=
 =?us-ascii?Q?sg3T6r754i/UtxTAGP4//Hdr1Rqnq2Vk9VA2zuInHpCtPfh/x/eLH/YpKkSJ?=
 =?us-ascii?Q?r4qPxreEclDYKujEd4nU1Gdl2RlbUrhkfk2VTyZfA0Xys0nUsjJ63jiMmBWV?=
 =?us-ascii?Q?0GdhaMeEfgdbshI3/VOYqsBO0R4eG/nkSS+Yf2jS62V6G6GrKfpgatIRtgG1?=
 =?us-ascii?Q?hlygum+BlJR3meUpbyyNR96kb0FRbI7Meiu+WjIdBPbi8itMM5EbPe4FoYPj?=
 =?us-ascii?Q?5b+lWZ7RUsAa1REgR3riMno8iZATuQ0l7AtqVE4vlLqqdt+IfHq/dzy6H5jS?=
 =?us-ascii?Q?rZeuMMnrDUkVJH+zePHZ4Ih3jYPyH8w/FoRi+FYXBA42kSNCPvkX8AeFmMHA?=
 =?us-ascii?Q?kTUNmxIyr3Zuw+okXc7BI06wor1y1HzlCVWmYLsNhzDxtnWFTcz/dsF0gaJm?=
 =?us-ascii?Q?JzAMvL05yI7RuFZXAYJASRsdL+K/OgqmR+pIfQO0GMFw6fSzLVaqRaPA6voP?=
 =?us-ascii?Q?i0y81FqknBwpiqt8cSLRYQjDFkm5Jv9BwQbUT0Wg0bxx4ug36rAKPKXyScUK?=
 =?us-ascii?Q?unwJiXEQJoaWzZ6i9VWJjX1arwpdJ9hVrwOqhSRMf1nx1y+7AtIZRqjxCqSw?=
 =?us-ascii?Q?u9J6a1gcYmeH2+7h4b2K4R49YeUQDOE7+vg5/05LaMlvkvrras+XAubQbpmf?=
 =?us-ascii?Q?XeCuaT2RtiASbmDPPzJM6YZeIS/uAOYUk93uLzsulwEVvd91+oyYAJ90bTVv?=
 =?us-ascii?Q?yBX91gRN4L4s8kUw5cdYxGgVtavbvoct15FxTW+B0HWm3G1PpGozELuumptP?=
 =?us-ascii?Q?Mph2RyZf42bkeSq1gB7ZwbZUzj1cEeO6rXtzlimUsph6UirJTgQPE7klsEzo?=
 =?us-ascii?Q?oBAlyk/l9XN1XAcTxIb/mvh7JXrMRelgPRG45WOIghWzIxGKp2fT6Ya0nAdS?=
 =?us-ascii?Q?Vq3B8bTLMJnG1Yyte6XKsTdipmcxDoo1ChrU1LXG43S6/3wg8/X10fzAHj3U?=
 =?us-ascii?Q?AdaqB3WajJCSAUBb6Wwu9aCrrfbqXqXOxpP3YHFOXcY+q5rIWLnyB5d9eZT4?=
 =?us-ascii?Q?p7cTcIZjqMojtNdUm4KCneINNA5K9ICgzNY0YIu5IGtFi0S9IrW02POVY3f+?=
 =?us-ascii?Q?rYzBQV09xt1UaMwYXd8+jaQEswFlQETi1z7U3ufthugEYlEXe6Vr8MrqzneT?=
 =?us-ascii?Q?/iaqak4bYAyzKUsdZrKucguRFRvc40NeHt+QWzHlItcSYapktvX74+A0fyye?=
 =?us-ascii?Q?L1/A3qccPizMdAzPMTuuSDuAut/FXrUn9ncDqqXJFHKaO57zsBP1Ktgc1slg?=
 =?us-ascii?Q?uO7khKPMpyXsG9KGp0bFa1vOEq1r+7FTCt05alRkPGvvwu+1N/vqRsCeg2bE?=
 =?us-ascii?Q?jwUbGFtJzFfqfNjkUipDTVw0HcbcoM2QcHOuU9Xe+mlEiGPWLuft0dLfWiHd?=
 =?us-ascii?Q?+0X8d8n9mGt9io3UIemh/xW8nyMc8wJBtHXZI+ZEPFNoBQBZnmOx0VmNfMU2?=
 =?us-ascii?Q?l7E3LRaO9nGMkjVMbSOvEjhJ7ECEdf+xr7MMH/XX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68ac336-424f-4b1e-c853-08db34f1c8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:48:46.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cQTwCy9O4f+qZderRcpB6jEHvnZEE6+Vs6uVeRoznlVEwGtWLviNRCSPGCFxntSgrVqExdtc4fktEbkqYf/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
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
> Sent: Friday, March 31, 2023 11:32 PM
>=20
> Inspired by the syzkaller reproducer check the batch carry path with a
> simple test.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
