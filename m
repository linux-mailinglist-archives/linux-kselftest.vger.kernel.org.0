Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215D9741E10
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 04:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjF2CQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 22:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjF2CQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 22:16:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E461FF1;
        Wed, 28 Jun 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688004992; x=1719540992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eL2AyGlTwm4Ky5nDdkvhMoznITStyUzP0iC+WS0lPYY=;
  b=M0dDkSOuZY4y86mtfib9qVzJrAdDf5CMbwz8W/dZbfm+nKhlXp0YOnTr
   S2yhmpAlOHsEPEIwqmBlk4l9GY76IV98UC6VAyrUB3plOQaVvmcSzmc43
   mb8rpmQFsbrsJIZSrYnVafMmBCykxCht8KgR8Qj2BVTAbJzIZYZhDBSVz
   Q06j4Xc5cMMfN3+XD8x6QnaxZwC32NZ2sR5bAD0b6H8xiNmB58E+hmdHi
   psqqr3nEL6o/dov98lCGOPVH0REj+bSFaSQRqiyi08nvMjSRNpc1qu6TT
   3vuSywiCqyrT/4l1NSWCJBE9dOB7T34E9AYEZo+1Atixfq2bIP++j3KpP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="359494275"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="359494275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 19:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="711251266"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="711251266"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2023 19:16:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:16:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 19:16:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 19:16:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 19:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnMjtaDSIdzPOSPMCxF7qg9E+md+gnvoGj6M14bNIQ+6JCnjqzXa8nvvsd3rQ6Kd/HJaZaAD8Ja/fy6NbBxxFngirx900OdpFvgikbZMSiaZyBubmYotGlxRU6tmUMgLrS9nd1KObzSCLLxXLkqPfVPCQV6ymwOKBog4ml53bVsV/hr1xSKZIww1fA6a+9ED7JyoY2D3TM3b7tSisQR+7t6TJGvYrh2VICWvidU1eico/2eX9xoesPdswNC3UhuahJq+Th5YUeFk2UdYyKWVTMBDuVCEbQYcD9GpM6hzGLpoNrthhH4AvjyuJD5OHy6ECOGae8NqaVNjTt0izEhbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL2AyGlTwm4Ky5nDdkvhMoznITStyUzP0iC+WS0lPYY=;
 b=YrbXxB2AVj4fQUN2axI6PZDQczn3cN45KZ7bJVSyB2rV/PTCVpSZPQhyySqZMDWxD1D8ekXGFQ2TfZNLwmUm2SID965ZGmhQ6qG3ChjjXSIn1lMyw/KBLNZcot1MQPPp9ZoaLljeTevqpmEAsuDKn13C8bHKEB7Q7wunCII/YIf9rK1CcOVgjcXBPMci32amV2hDyEjkmgFqw3fzZ0K9ihjNBl04LvYGjjBzz8PhHwru2jZAn7nkiupfo1mEmN5NF2RUGT87X4zYYvWQbEcCaHhgRfMU2Ag15li6ktl7sNqjxD6RILWfErhpY/8q8mwCQhhpr+H78h3bUhGrcQGfNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5791.namprd11.prod.outlook.com (2603:10b6:a03:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 02:16:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:16:27 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EIAVLTqAgA7xydCABWBTgIAA1LOwgADAhgCAARBZAIAAzEsAgAcosiCAALdQAIAAz7YQgACqJwCAALFKoIAAp7yAgADk9vA=
Date:   Thu, 29 Jun 2023 02:16:27 +0000
Message-ID: <BN9PR11MB52764DF9D28571926E2441398C25A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJMvtMe5QHPM0OEJ@Asurada-Nvidia>
 <BN9PR11MB5276D6040E41595B929843168C26A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJnK2schtjrrwJ1L@Asurada-Nvidia>
 <BN9PR11MB5276AA174BBE2C4A91C5E5338C27A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJsH1NtUJIDfUthO@nvidia.com>
 <BN9PR11MB5276BA9BBAFB8BCC8B339AFA8C24A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJwpQV6oBBsIAtHD@nvidia.com>
In-Reply-To: <ZJwpQV6oBBsIAtHD@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5791:EE_
x-ms-office365-filtering-correlation-id: 6f1cafc0-71ad-4afd-41c7-08db7846d879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqHWjh06aLkuRDJ1RmSlyDiQM7ZNXjNYWcB2UOOgIGAO4ecZmOOszqTHO9JpKHrkMvFdJmKV+XwA7vcDa8HmXg39ZBjdTvpkQxorRR4DgByRRGtUeHQKnpW/Hsj7b8xEc44ga+XV0G4qZgmxi4deJNRipIt5koU8/vvgBgoPS+JGCaBK6KUXIu37UvLJfJwvOIBnyKVZEV1Ed+sET4VfVtvZVSDRdq9rpUhlWDCpaNXnI2jfKpK1rnhuaacjyixgaQ9mNtbBlOPtVi/n/6kSnLVQQpVUdqA+7LHEWAZv/UWPzdI57vg6xl+kvMpa3fTKYu0NtyUm97lx8vOKjRhQwsTv6Q17gaSJeuvK4dNtcwkkem7iP2YCHWWofDjVMWZjZMwGFuxPdKbn7Px0YFUuf+xHZmqr+b1hdkGHAx+auxfg76sTWWLdp2h30NG/lyNGpJh2sKjJY2KgJaeWQs7jpUBe8o75iu5euublwiOYyVGPI3ngGjMtQGJRD6yEyE7yQqZPGwsfGnVB+mzq2p/MyqePCZAgOCMn1tWBxpP8g9g5i1wXOtNcSl8r/yEqTyFHWXvNvBdirGdK0/S16aoB0d/3ShNN9rIrjPh3jYiehNyjIDhTRzyRJZtji5KSBlX1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(41300700001)(5660300002)(66946007)(52536014)(66556008)(64756008)(66476007)(76116006)(8936002)(66446008)(8676002)(6916009)(4326008)(316002)(7416002)(478600001)(55016003)(38070700005)(71200400001)(33656002)(2906002)(6506007)(26005)(9686003)(186003)(54906003)(122000001)(38100700002)(82960400001)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UC9McWZKcE8xdjVaV09uSEhEeFpiZVBvYUNvZHZEVVNDcXVwSWN2U2JTZ2hu?=
 =?utf-8?B?WFRYNE5wNmFtcGJyd2pEN05Tc2JpbnBMVDZMaXhOQStxdENocDF1dmJ5NWtN?=
 =?utf-8?B?ZXZJbURGcGxadldXbW9oaDE0UlN3eW1sNW5hdG1ORFg1SytvNTRJbGVRZTVY?=
 =?utf-8?B?OFVvNDZaMzBZT1ZnemZQaWhwdGRxOXJTT1RrL2RsRnFTWERkS2NPREk2b0JQ?=
 =?utf-8?B?L3NtVGFyNk5zYTRIVWlvMkJubFlvVEZtS1BlNittT2dTN29DVGNlaW4rVSt3?=
 =?utf-8?B?UjF6YTZtUzlSWmJ1dkd6Z2NRV21pMml5ck15aUgvTmZLdkY5RytDT1pQMnda?=
 =?utf-8?B?UGFnVTFTMGFuNkJhcUhlemNpZStBQjRPNDYvL3k0SVBNb0NMY2xOTm0vcng2?=
 =?utf-8?B?RFUrRmZzdmtDTStKNTlranU1eXYrUUkzZjl5TnJaWGp2OVNHMlV6cUVzMStz?=
 =?utf-8?B?V29LcHJGV3RqajNab0gxKzhkNlgwaGg1alF1Q25uMlorTlFkZk9RQm9oSWJS?=
 =?utf-8?B?V3JOSWJvSXZNWHJVVmUrQzNJNW81MHNKZy9FT2YrdVIzeXhEUkJVaFhiWS82?=
 =?utf-8?B?U3Z0ZGlZQWc4WkxEZGJ6RmhyS1U0ODRQNWhHTHpzYXR3VkxMWlYzZUhHT1dE?=
 =?utf-8?B?a3BabWFmOElrNi9HakdiVEJtdFI3Z3pYcmMyYzYrYkRDVHp4Tzc4alJENGxE?=
 =?utf-8?B?K3NJMENYa21vQ3RpUGlrVEVoOFJBdk9BanRxTm1DWVdmTkd0Y3Q3WTFPdkFu?=
 =?utf-8?B?VXJmWGdwRmV4VFdXc1RNNmVldjZLOUpMelRTZFJSMnc2SEZRMkk0Tm80RlNr?=
 =?utf-8?B?dGZsbVBBOUM0VFZ4NnkrMTF3dm03OHZqZC95Mm9FSC9vVWx4TzAwRW0vZ3N5?=
 =?utf-8?B?Ry9pakpmbzBMcU1YUHZRbmZVeDFYazNWbHl5M2k0czB4cTJYSkdUR3UvSkhk?=
 =?utf-8?B?alJGYW9kczVTTng5cW43cUpyVTlHamNYNmoxRngwMEZxcVI2Q2JERmZYYith?=
 =?utf-8?B?ZHE1QllCUUxHUDViUmp0ZmhndVMzTjZ6Q2xGVEdpTXRaYzk1WDZVNnQ0b2E0?=
 =?utf-8?B?WGk4VURzSDQ1bnVBY0daT0lnRmQ0ODREZnpUcUMzN2xIOGxwcEQ5WkJCdzJN?=
 =?utf-8?B?TVRsU1ZLWXJPOW9OaGQrUlEvZ3Q5NlhyeFM0QVdOKzdmVU5IZmQrQmpENFV1?=
 =?utf-8?B?Y0M2R0ZWa2xUci9rNVdVN3BDN016TGtuRmhOendSMGd4alEydmxtL2czSGNJ?=
 =?utf-8?B?T0xyQ1EwT1FUMyt0WnB6amRIcDYxa0g5cUxFTXpaTlkvQTd5K21iUGRzT0ZJ?=
 =?utf-8?B?T25qQXBMUEgxOG9SZzExYTl3aitxRDRDZWJZa2NycTQ5OWlzbENOY2xLOW55?=
 =?utf-8?B?UmU2bi9aa2F3KzNjZXhLNExwZk96UU9NNkIrU1VlMGtad2I0S0gwVHZVM2lZ?=
 =?utf-8?B?U1c3bXdhRUljVi9nSFJleDdwRm1pb2VhREFlMnZHVDM1VzhzVTN2Vi80d2lG?=
 =?utf-8?B?bjBQa21scmpUalNkSW00UE9QRERXR3FhUVNSSWZ5R1hFV2M1MmdnNVREbG4r?=
 =?utf-8?B?dFJoVzRqVXBJL2RSZW9qbW1FQTBTYkpaLzVTNVM2clNWZlVwMk0vMU9ZcHQ1?=
 =?utf-8?B?WEZtTGNFTHhCdmM0ZndLVXJxbjczd1Y0R1p2YzNqZnIvYjU0NndWbFExWG16?=
 =?utf-8?B?ZVZGeE5hQ2ZBcG1QV0xTM2JiSDZYMnNiSnJNOHF0ajVlRTFlMEp2M04wQXJ0?=
 =?utf-8?B?TFFnS1dqSW51b2RTUkd6OVo5Q0JiR21ySVhuSTUrS05Wa25ISFdzVm9aY25U?=
 =?utf-8?B?VUJ5aEZjdzFRMDVLMW9nSWY4NTFaVFJzVXZRNGFkbUtlN2c5UG1WLzVqK2c4?=
 =?utf-8?B?VHN5R2N6Zm9OWHI0NHEwWnZhZEJGS2I3Mng3d1dMY2JjTXcrSFFEK2JUODJG?=
 =?utf-8?B?UlBhckJRM3Z1MTZSeDBQNk9HTWFuSVhMUVdDamhSUEF2enN5MzBZZjVvdFlp?=
 =?utf-8?B?V0JJWlRydXA0cHk4eWIyaS9WcGp6ckM5SVIwRWlZVnUrM0x5Ri9QM0QvUFVr?=
 =?utf-8?B?ajQzdCt0YUZVc2xMZ0lBWE9uSnJYNUw2aDhQUlFiOHo3aXo3UEFnV1cybTZv?=
 =?utf-8?Q?Vjnm8pe9GKpFS4OzArtOR5rnQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1cafc0-71ad-4afd-41c7-08db7846d879
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 02:16:27.7847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWDhLu4VbRC+ylH5yvUo9Whe9nLwBQK+qGhjwz8mFX6cmyjSwdi3rI1qNmqThVdFHWTJla/ehn5ktNvgRf2kJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMjgsIDIwMjMgODozNiBQTQ0KPiANCj4gT24gV2VkLCBKdW4gMjgsIDIwMjMgYXQg
MDI6NDc6MDJBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI4
LCAyMDIzIDEyOjAxIEFNDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDY6
MDI6MTNBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1
bmUgMjcsIDIwMjMgMToyOSBBTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJJ20gbm90IHN1cmUg
d2hldGhlciB0aGUgTVNJIHJlZ2lvbiBuZWVkcyBhIHNwZWNpYWwgTVNJIHR5cGUgb3INCj4gPiA+
ID4gPiA+IGp1c3QgYSBnZW5lcmFsIFJFU1ZfRElSRUNUIHR5cGUgZm9yIDE6MSBtYXBwaW5nLCB0
aG91Z2guDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGRvbid0IHF1aXRlIGdldCB0aGlzIHBhcnQu
IElzbid0IE1TSSBoYXZpbmcgSU9NTVVfUkVTVl9NU0kNCj4gPiA+ID4gPiBhbmQgSU9NTVVfUkVT
Vl9TV19NU0k/IE9yIGRvZXMgaXQganVzZXQgbWVhbiB3ZSBzaG91bGQgcmVwb3J0DQo+ID4gPiA+
ID4gdGhlIGlvbW11X3Jlc3ZfdHlwZSBhbG9uZyB3aXRoIHJlc2VydmVkIHJlZ2lvbnMgaW4gbmV3
IGlvY3RsPw0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEN1cnJlbnRseSB0aG9zZSBhcmUg
aW9tbXUgaW50ZXJuYWwgdHlwZXMuIFdoZW4gZGVmaW5pbmcgdGhlIG5ldw0KPiA+ID4gPiBpb2N0
bCB3ZSBuZWVkIHRoaW5rIGFib3V0IHdoYXQgYXJlIG5lY2Vzc2FyeSBwcmVzZW50aW5nIHRvIHRo
ZSB1c2VyLg0KPiA+ID4gPg0KPiA+ID4gPiBQcm9iYWJseSBqdXN0IGEgbGlzdCBvZiByZXNlcnZl
ZCByZWdpb25zIHBsdXMgYSBmbGFnIHRvIG1hcmsgd2hpY2gNCj4gPiA+ID4gb25lIGlzIFNXX01T
ST8gRXhjZXB0IFNXX01TSSBhbGwgb3RoZXIgcmVzZXJ2ZWQgcmVnaW9uIHR5cGVzDQo+ID4gPiA+
IGp1c3QgbmVlZCB0aGUgdXNlciB0byByZXNlcnZlIHRoZW0gdy9vIGtub3dpbmcgbW9yZSBkZXRh
aWwuDQo+ID4gPg0KPiA+ID4gSSB0aGluayBJIHByZWZlciB0aGUgaWRlYSB3ZSBqdXN0IGltcG9y
dCB0aGUgcmVzZXJ2ZWQgcmVnaW9ucyBmcm9tIGENCj4gPiA+IGRldmlkIGFuZCBkbyBub3QgZXhw
b3NlIGFueSBvZiB0aGlzIGRldGFpbCB0byB1c2Vyc3BhY2UuDQo+ID4gPg0KPiA+ID4gS2VybmVs
IGNhbiBtYWtlIG9ubHkgdGhlIFNXX01TSSBhIG1hbmRhdG9yeSBjdXQgb3V0IHdoZW4gdGhlIFMy
IGlzDQo+ID4gPiBhdHRhY2hlZC4NCj4gPiA+DQo+ID4NCj4gPiBJJ20gY29uZnVzZWQuDQo+ID4N
Cj4gPiBUaGUgVk1NIG5lZWRzIHRvIGtub3cgcmVzZXJ2ZWQgcmVnaW9ucyBwZXIgZGV2X2lkIGFu
ZCByZXBvcnQgdGhlbQ0KPiA+IHRvIHRoZSBndWVzdC4NCj4gPg0KPiA+IEFuZCB3ZSBoYXZlIGFs
aWduZWQgb24gdGhhdCByZXNlcnZlZCByZWdpb25zIChleGNlcHQgU1dfTVNJKSBzaG91bGQNCj4g
PiBub3QgYmUgYXV0b21hdGljYWxseSBhZGRlZCB0byBTMiBpbiBuZXN0aW5nIGNhc2UuIFRoZW4g
dGhlIFZNTSBjYW5ub3QNCj4gPiByZWx5IG9uIElPQVNfSU9WQV9SQU5HRVMgdG8gaWRlbnRpZnkg
dGhlIHJlc2VydmVkIHJlZ2lvbnMuDQo+IA0KPiBXZSBhbHNvIHNhaWQgd2UgbmVlZCBhIHdheSB0
byBsb2FkIHRoZSByZXNlcnZlZCByZWdpb25zIHRvIGNyZWF0ZSBhbg0KPiBpZGVudGl0eSBjb21w
YXRpYmxlIHZlcnNpb24gb2YgdGhlIEhXUFQNCj4gDQo+IFNvIHdlIGhhdmUgYSBtb2RlbCB3aGVy
ZSB0aGUgVk1NIHdpbGwgd2FudCB0byBsb2FkIGluIHJlZ2lvbnMgYmV5b25kDQo+IHRoZSBjdXJy
ZW50bHkgYXR0YWNoZWQgZGV2aWNlIG5lZWRzDQoNCk5vIHF1ZXN0aW9uIG9uIHRoaXMuDQoNCj4g
DQo+ID4gU28gdGhlcmUgbmVlZHMgYSBuZXcgaW50ZXJmYWNlIGZvciB0aGUgdXNlciB0byBkaXNj
b3ZlciByZXNlcnZlZCByZWdpb25zDQo+ID4gcGVyIGRldl9pZCwgd2l0aGluIHdoaWNoIHRoZSBT
V19NU0kgcmVnaW9uIHNob3VsZCBiZSBtYXJrZWQgb3V0IHNvDQo+ID4gaWRlbnRpdHkgbWFwcGlu
ZyBjYW4gYmUgaW5zdGFsbGVkIHByb3Blcmx5IGZvciBpdCBpbiBTMS4NCj4gPg0KPiA+IERpZCBJ
IG1pc3VuZGVyc3RhbmQgeW91ciBwb2ludCBpbiBwcmV2aW91cyBkaXNjdXNzaW9uPw0KPiANCj4g
VGhpcyBpcyBhbm90aGVyIGRpc2N1c3Npb24sIGlmIHRoZSB2bW0gbmVlZHMgdGhpcyB0aGVuIHdl
IHByb2JhYmx5DQo+IG5lZWQgYSBuZXcgQVBJIHRvIGdldCBpdC4NCj4gDQoNClRoZW4gaXQncyBj
bGVhci4g8J+Yig0K
