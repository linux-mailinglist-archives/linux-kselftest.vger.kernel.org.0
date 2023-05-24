Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA21970ECE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbjEXFLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjEXFLs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:11:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D713E;
        Tue, 23 May 2023 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684905107; x=1716441107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=13krplGOETAMWQgrs0hR1KKxug/O/t7FBeQb+emVZFI=;
  b=QB7ymfwpFGOaIZxLVMAbH/2Aqnj1BU7PKtzNGX0e63b+ZZSRkarCLaH7
   Lbdskboki0CFN5xFRoUUvoWnOIbGC2H9B8zUBegNwnNhXjdAXrp8Wg7Tp
   ISO5DTPyWMZ5gIB4eUgD+1zRs7oCNzt8szFBDWUukyGy40JllWq/LnKim
   Jxp/rKoI9TPY/w6jBOUsVAlO80y6rN66NXOHze/m4GPG5zISzAcpg/JjH
   lX/GXuFDZXA9Nu0a4gytfuXv018nt2saZUg7CSOTG6Zjc8SX7YQqvkyBQ
   ZaAXnhkF4bZSOK7tvhkS8s4382sNiviXxdh6J3i0LyaawtxYogw+xtlPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="356684877"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="356684877"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="816431617"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="816431617"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 May 2023 22:11:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 22:11:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 22:11:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 22:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSYF3ZcHC+8X5d1cewxYaprmAAinVkGNdyHbVtdEftXizsLninqODGKlud2w3ARZafTmfBfFbx6oZ7jgo8N0Cz8lQqs5cHTeptsKZhtmpXZxhpLS9XYPJ/41EtpZrPW5T2oBZMY2/7W3w4PTHvcGz4QVSexz2VyjrI6pjylujVpMirvdhri1/pOjWeLVmAZpDe9MBNlu2pmH9GNQyDfCrhDlf1v2GtVfcVh5SSs9DPdk9itHvOtlvshP/Qvc/1IqPwd37JgecTNgJYdO1pYSaKcqgrEPgPku+1rb9AuV1VRx/NDheVMsEh71bumaHioS/ViqDcGQmWRWO0eueZK6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13krplGOETAMWQgrs0hR1KKxug/O/t7FBeQb+emVZFI=;
 b=Btzdfbx3Hkw9Ar7tVNdzefwskk6BJ0W9k3eo2WUaGFO8z/dcqg464OsGneUnOSNT0Z6a6pCq1Q+uSq81qIs1OKM1rkxq6guOC2PXx5pur1uB920M9aOVE/Dbf6ehN/RYo/nt3qSXVfao2OwaBJqMfwJFmRsUv5t6XSdyBLR5s06dSXzQMS4zdXWfQ6ZxljqliA+t5aV1e+HjaZxdaIOl4+ZcbiSa+OwuJTLtQNfbLbh4f701y/R4wUpzVUc+qXolFBT3QwVoVmLg791A11NII8dWEYbym4uWEeirZUBMutYPFOddRIMeUp5Yjbzr1flxtL+iFaUA6ZbITW41ap4cQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:11:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:11:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: RE: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Topic: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Thread-Index: AQHZhBZVjU0+oTnptEmcGUc2PW+bOK9hWOSwgACpvgCABu+1kA==
Date:   Wed, 24 May 2023 05:11:43 +0000
Message-ID: <BN9PR11MB5276AEDAFCAFF0884DD5D6DD8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
 <BN9PR11MB527662C871DD8351E9F507D18C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfJXFls5uNi3ziH@Asurada-Nvidia>
In-Reply-To: <ZGfJXFls5uNi3ziH@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB5976:EE_
x-ms-office365-filtering-correlation-id: 4b79ee9f-14b9-4011-23ce-08db5c155daa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3jcqfJ2SxCRZwpbaCdisx4vqfQR+xGaBFWU0gWGvej22kZBlbJAH+Bb/WuL5LmmwmwvRhk4s3fFSSvVAO3c+CYIsQZ2YetJe+/RTpsfDNJXAwMvUPxgJnjXuRRTYgwHUzeCVfmkvGIZ3x2bWynWkGNu+mpWYamMgfKhhr99f5KC/5uHaWliU8wxsd/BjzNNBFpsIXTAgI96fcS+qrTtNp0qMiEGVWzvqnNceXD2cKMItPLqE0vHq11znBui8Ox3OGbGfNL09LEuw6Uwdf0rdqwfBYgK73j3v1i55VIy6y6S4YNQQFDI76UsFKXZbQMI5qCXjD4E2iaRreQybCnq3YXXPI82MzZNP3j3dhBoolSEIP0GD3a4n4uLsoWR21cGmhDtgS3RFHAtHsp8J0DG6BdWmciIbmnaKWQ5H+rbgLYpib3teAKtWYRT4Pch+KpE9pDPJ1foID4wq+O7t8IJoUnnof3lok8HDMzMoXUNnDpH+wOLc62TpT9F4K7FABpWyPi0ev1gZkk+jEf/hHFK7qHdkFhka64YsL97BGFOLOgKtMwRTqSbDXb6XYeqh2LZVe6NxtjMGgQQVWU97hG5sg9t8udor0R/QSkWeCO/B6iUlS84IHx4Ylah677ZEcUQO5ljwG8VVfUOl5ASyjZA5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(8936002)(8676002)(7416002)(52536014)(5660300002)(83380400001)(9686003)(186003)(6506007)(122000001)(26005)(86362001)(82960400001)(38100700002)(38070700005)(66446008)(66946007)(71200400001)(55016003)(41300700001)(7696005)(478600001)(33656002)(64756008)(66476007)(76116006)(4326008)(6916009)(66556008)(316002)(54906003)(2906002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2tlTWFQYnQyNkg4c3JFamFDV0dSdWMrYmlvbjNjTnNwSmtiR0NWcm5yUVA5?=
 =?utf-8?B?d3QvRUVKUWVCci8zd1NCQ1B5eG15cVo4WksrNGxFNjdIV2ZDdGU5aGgvWURy?=
 =?utf-8?B?bE10WFV0OHFEV3ArejNkbUFxNUVKQ0Z0Mk51ajNUOEgwbmg3TENsa0xCakg0?=
 =?utf-8?B?ZWdYdkJBQ1YzNzN5K3FROGlrN0tZMU16U0p4eGVkMU9IOVN1WnlIMTQ4SjAv?=
 =?utf-8?B?Zk5GVUI4ZnBjR1I3ZHNnYm12K0dWRlR5WXhWUktXaWVnTDFRNlpTMWowR1Zj?=
 =?utf-8?B?TFZCMUc5cFk5TWV0SkNsWlYwdUtOVWdWNUVYMzFZN296ckttbWlxZ0Z3dmpx?=
 =?utf-8?B?L0lwSG9PVUczZkpKWGM1MWhFZXpDNjRQZ0VtcHoxRG5FQTlQbmV3K0g4KzJx?=
 =?utf-8?B?cEo3L0thamJqZCtCWVhLZFliV3VockcvYTByNTQ4MGlRc3B1MVVXQjdEbUp5?=
 =?utf-8?B?amFNaDJIV2I5cUswamF0UDVoYXlLdjJZYmpuU3ZTMW1LTHMyT3hUOC9PeWhr?=
 =?utf-8?B?aENsbVdxTGJNd1R1d3ZMK3d4TVBoNll2RG5CZE8xd0M2SWNJUitQRG1qOFp0?=
 =?utf-8?B?SWVsQVdiL1hXUlBwb3VhbHJaMFQ0WWhnOVBUc1VKL0d6aGpYVm9DS0s5MEha?=
 =?utf-8?B?eTJyUm9sNzlxOW1INThHWENuTTU2S1RRU1Y0OFRIcGxoMC8xZThUVnBtY295?=
 =?utf-8?B?TERtRnd0SlV4THhrOTA5Y3o1MG1KOW1td0NTM05TUzd0MW9HN3FSa2tQRldi?=
 =?utf-8?B?SEdLbmtvVytkOGdhM0VKYTdKQWNFOERLM2hud2oybjZwblZzQjBoV1JaM2FQ?=
 =?utf-8?B?QnZiMVUzRFZXdGY0Z0NhQWdpOGR6ZkVzMDk5dzJOTnk3VjBsT3VOQzZpTUMr?=
 =?utf-8?B?dXZJeVMxZXVxL1ZpcnF3Z0h6ZWdMTkdGSHpBQVhNL3lCaEdvWEh1czFmUkEy?=
 =?utf-8?B?UGtKWmVnODNRQmZ5UTBhVWlCeHlRSkdrYjFmd05WNW5CeGxiekgvL1dzalVZ?=
 =?utf-8?B?UnhSZmZsZkxkZVdsSW1TSXBHNC9RSExKcy91N1ZhUGt2Q0YxWEZpNHZJRWtv?=
 =?utf-8?B?UFNnVHB4ZEw3N081TVExSDhhTHo0RHpCYS80aFJ0Ti8rM2Y4dEFja01RK1Zs?=
 =?utf-8?B?S2RMWW1xYnhLWHVBU09iL1NJbDBVaXlKUXpKMHVwdUN4SVg3MlI1clZEM0dp?=
 =?utf-8?B?YmxmRnpjS0VhdHM1eVhwVWtsMjhFeDVkYzJ5YVlEdU5mUjZXbk1HcWRmc0ZY?=
 =?utf-8?B?L2ZVNGFlRzA5ZFl0VEsxbjJyQ3dvZmo3dGJ1aTZlV1hGNXBVRHFJcGQ5aGJG?=
 =?utf-8?B?eWZxNU5MbWcrUUM1NGNsVlQ1SjdYamVZanlCTHk0QTlLTGc3eVpKckVBaGxt?=
 =?utf-8?B?cnlERHAwUGYrWDB6Zk5MYmdqdlhlMFcrS2R1cEtOdU42OHg5OVhKL3ErTytU?=
 =?utf-8?B?SjBoMDVzbzRoZUpBSFM3bHZkVlUrOHpQWHVDQnU1RStzbnFHc2hxU2YreERX?=
 =?utf-8?B?NVM1OUVLR21jeTRtQUFKWGpZVmZoSDRLSm1DVmJCQzV4WG9ndTVHcnhmRnI4?=
 =?utf-8?B?S3RmRXYyS0ptUXJxcXY5T3FBR0NUOTY1aHMvMHI0STlObUxLTTZhZzU0aHFS?=
 =?utf-8?B?TnExSlBQaEhtd3VkM0NGamtUS1JFK04ybEtsbG5FNTdjUGJnTXExaHJBRjBI?=
 =?utf-8?B?UXh0SHlmdXB6VXhHaS9CZlY3Tk10VTRPR2FHWGVrNFNRY2pHS0VROFFmVUoz?=
 =?utf-8?B?MDV2V2lEYjBXR2JOdGhhamFuUmV6QjVldHNIbEV0NHVGOGpPMTNOYlJGQ0R6?=
 =?utf-8?B?R2JHUFI1ZkpzZjNkK3p0R0FZM0d0UTltS3RsQThKTnFhc3drR1pienBxZFl0?=
 =?utf-8?B?K2tDNVd1emtUUHBGWUVMcjFlQm1pVkVlZmNLbWE4Q0pNVHI3b2xxR3gvbG00?=
 =?utf-8?B?bFZtMm5EcUdKWlRwOCt2alNzWmkxUUJvRGtCaXhvczB3Z1RSZFN6dmMva0Qz?=
 =?utf-8?B?RW41T0YvNzR6QzRoWW9iYVMwejJneGdWMGpVelBtZWc4Rjd6UHBCMnZaNVdh?=
 =?utf-8?B?SG8rdHhjbG54ck42RU9zc05mcUt4MlV0VVZuTEJZRVlIdXFRcktrSjVkNmZX?=
 =?utf-8?Q?Dn2RgPMUkSoexMe4LzjrDGtSg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79ee9f-14b9-4011-23ce-08db5c155daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:11:43.8036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KU+aEgJOmJSO1NvKDgoUGLkGO1iu+5qOCGltgNmFLk7xMQsy2skRyQR4AWFW17mVC4k3Q2lNv2nMIa3c4Z7V2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
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

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFNhdHVy
ZGF5LCBNYXkgMjAsIDIwMjMgMzowOSBBTQ0KPiANCj4gT24gRnJpLCBNYXkgMTksIDIwMjMgYXQg
MDk6MDY6MjBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiA+ID4gQEAgLTczLDE0
ICs3NywyMiBAQCBpbnQgaW9tbXVmZF9od19wYWdldGFibGVfZW5mb3JjZV9jYyhzdHJ1Y3QNCj4g
PiA+IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpod3B0KQ0KPiA+ID4gICAqLw0KPiA+ID4gIHN0cnVj
dCBpb21tdWZkX2h3X3BhZ2V0YWJsZSAqDQo+ID4gPiAgaW9tbXVmZF9od19wYWdldGFibGVfYWxs
b2Moc3RydWN0IGlvbW11ZmRfY3R4ICppY3R4LCBzdHJ1Y3QNCj4gPiA+IGlvbW11ZmRfaW9hcyAq
aW9hcywNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9kZXZp
Y2UgKmlkZXYsIGJvb2wNCj4gPiA+IGltbWVkaWF0ZV9hdHRhY2gpDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGlvbW11ZmRfZGV2aWNlICppZGV2LA0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpb21tdWZkX2h3X3BhZ2V0YWJsZSAqcGFyZW50LA0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHVuaW9uIGlvbW11X2RvbWFpbl91c2VyX2Rh
dGEgKnVzZXJfZGF0YSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBib29sIGltbWVk
aWF0ZV9hdHRhY2gpDQo+ID4gPiAgew0KPiA+ID4gICAgICAgY29uc3Qgc3RydWN0IGlvbW11X29w
cyAqb3BzID0gZGV2X2lvbW11X29wcyhpZGV2LT5kZXYpOw0KPiA+ID4gKyAgICAgc3RydWN0IGlv
bW11X2RvbWFpbiAqcGFyZW50X2RvbWFpbiA9IE5VTEw7DQo+ID4gPiAgICAgICBzdHJ1Y3QgaW9t
bXVmZF9od19wYWdldGFibGUgKmh3cHQ7DQo+ID4gPiArICAgICBib29sIHR5cGVfdW5tYW5hZ2Vk
LCB0eXBlX25lc3RlZDsNCj4gPiA+ICAgICAgIGludCByYzsNCj4gPiA+DQo+ID4gPiAgICAgICBs
b2NrZGVwX2Fzc2VydF9oZWxkKCZpb2FzLT5tdXRleCk7DQo+ID4gPg0KPiA+ID4gKyAgICAgaWYg
KCh1c2VyX2RhdGEgfHwgcGFyZW50KSAmJiAhb3BzLT5kb21haW5fYWxsb2NfdXNlcikNCj4gPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPiA+DQo+ID4gRG8g
d2UgYWxsb3cgc3BlY2lmeWluZyBwYXJlbnQgdy9vIHVzZXJfZGF0YT8NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgc28uIFBlcmhhcHMgd2Ugc2hvdWxkIGRvIGEgZG91YmxlIGNoZWNrOg0KPiANCj4gKwlp
ZiAoISF1c2VyX2RhdGEgXiAhIXBhcmVudCkNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7
DQoNCkkgdGhpbmsgd2UgYWxsb3cgY3JlYXRpbmcgYSBzMiBod3B0IHdpdGggdXNlcl9kYXRhIHNv
IGl0DQpzaG91bGQgYmU6DQoNCglpZiAocGFyZW50ICYmICF1c2VyX2RhdGEpDQoJCXJldHVybiBF
UlJfUFRSKC1JTlZBTCk7DQoNCj4gPiA+IEBAIC05OSw2ICsxMTcsMTUgQEAgaW9tbXVmZF9od19w
YWdldGFibGVfYWxsb2Moc3RydWN0DQo+IGlvbW11ZmRfY3R4DQo+ID4gPiAqaWN0eCwgc3RydWN0
IGlvbW11ZmRfaW9hcyAqaW9hcywNCj4gPiA+ICAgICAgICAgICAgICAgZ290byBvdXRfYWJvcnQ7
DQo+ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICAgLyogSXQgbXVzdCBiZSBlaXRoZXIg
TkVTVEVEIG9yIFVOTUFOQUdFRCwgZGVwZW5kaW5nIG9uDQo+ID4gPiBwYXJlbnRfZG9tYWluICov
DQo+ID4gPiArICAgICAgIHR5cGVfbmVzdGVkID0gaHdwdC0+ZG9tYWluLT50eXBlID09IElPTU1V
X0RPTUFJTl9ORVNURUQ7DQo+ID4gPiArICAgICAgIHR5cGVfdW5tYW5hZ2VkID0gaHdwdC0+ZG9t
YWluLT50eXBlID09DQo+ID4gPiBJT01NVV9ET01BSU5fVU5NQU5BR0VEOw0KPiA+DQo+ID4gbm8g
bmVlZCBvZiBvbmUtdGltZSB1c2VkIHZhcmlhYmxlcy4gSnVzdCBwdXQgdGhlIGNvbmRpdGlvbnMg
ZGlyZWN0bHkNCj4gPiBpbiBXQVJOX09OLg0KPiANCj4gSXQgaXMgdG8gaW1wcm92ZSB0aGUgcmVh
ZGFiaWxpdHkuIE90aGVyd2lzZSwgd2UnZCBoYXZlOg0KPiANCj4gCWlmIChXQVJOX09OKChwYXJl
bnRfZG9tYWluICYmDQo+IAkJICAgICBod3B0LT5kb21haW4tPnR5cGUgIT0gSU9NTVVfRE9NQUlO
X05FU1RFRCkgfHwNCj4gCQkgICAgKCFwYXJlbnRfZG9tYWluICYmDQo+IAkJICAgICBod3B0LT5k
b21haW4tPnR5cGUgIT0NCj4gSU9NTVVfRE9NQUlOX1VOTUFOQUdFRCkpKQ0KDQpJTUhPIHRoaXMg
aXMgYWxyZWFkeSB2ZXJ5IGNsZWFyIHcvbyBkZWZpbmluZyBhZGRpdGlvbmFsIHZhcmlhYmxlcy4g
8J+Yig0KDQo=
