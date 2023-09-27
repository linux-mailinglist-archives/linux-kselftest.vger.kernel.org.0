Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2457AF986
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjI0Egd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 00:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjI0Ef2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 00:35:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569C2D73;
        Tue, 26 Sep 2023 20:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695784342; x=1727320342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vbZUieT11H7EYLeateHtMhEk18VtayKdPT4T3i2eY74=;
  b=ByTjG2XKmpyuwGEDtBfGxDGJ2Fl7B8hJl4zfQPAJL7HcPMjVXcIfc123
   07q2J5FNAnDjVw/j8BAGBqFezRjPqcEKQP18kFjCcGhQ6a0Tj4eD1eOBx
   fvLmiwq2NofwSp1q1tBeproGf2WwX4Xp9Bbrxy7OxpuC0k+JR0LDXu0FU
   1r4CjEHKX65zb1aolwkKHj/s2jqhape93VQMe2Mq/YbSzwdM/RmWIOf1e
   xaRn/GOVJi8OZEA1+1u/4Y36k2BA7D7o1/3FDk7NB8MzD04hCYRFr1+wk
   IEj05Nn/GL73vdyElXAAWs/lCceTCvT5pnbZA09y2Ctq9Vd7M/JZOrz1W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384499093"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384499093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 20:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="839257473"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="839257473"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 20:12:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 20:12:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 20:12:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 20:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql8jJV5KKzY2J4D7WZpHD63e05Kw3zGdgs6KaeCL4Ni2XRBagZ8I27rtuP4LXteDziHGjTBQNKr4uxFydiNb+BfCESCO9JAMaamAWb6mVomF7J0LBaw4azZDX2LJ4oiM12BpnNeEoYm14WuoRJsoP71UUBjQ38OvspoDmQi98a8RsF7b2MttvwUw9nxqdm08eZt1EdtJ3SBfcEkAkSojGGnzUFHjhbb1dA1K0YOHwOCMpJ5AF09Xsdzv3qEVJk3dEGZMLOIBwaAPV7L4hB9IIO46E7oPp3kA0fxmPOJ1HNPQoAwcDfDjWyUo/5jmMIN0peC3ji47cMGj+9t8ds3igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbZUieT11H7EYLeateHtMhEk18VtayKdPT4T3i2eY74=;
 b=hwBylSeY02oDEcaKB2/u9KcXqdtpE492G/pX5DTA/2/PSSR07Gkd1IFJaL37QA5Aqdbfm0y21Y6Tq6r7IV4ArhcJ1yIh7JV887DSxAoq2I82grbTkprxeBnhxmlDIPp37I9m2YIvRMv6+Hz+L1L5CdYEqbE2JT9uk3WPXC992QmCQp/UuBveRnpmKPiiRfXpsKKPnQy8JDjDqInE1TOO1iDptTrUlZKOMz//dUNZJHBiGo1PfzFzkIswSWAJRWb5yiHH/bK/hILCIpxEKSKrHsSrQHxN4SB1CmjUHpFmuSfLpnlS5kBd4jXd5AVBthu4+g9amfCktpSR5YYQtWk9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 03:12:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 03:12:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Topic: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Thread-Index: AQHZ8Fuji0mclsZAxEygwByYUuBlHLAt+cCAgAAFx4A=
Date:   Wed, 27 Sep 2023 03:12:16 +0000
Message-ID: <BN9PR11MB5276517F572ACA4A926D44978CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-4-yi.l.liu@intel.com>
 <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
In-Reply-To: <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 34599ca6-0790-491b-33a8-08dbbf078d6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gW40me5ksj7+oIFlsoFqkKOPjGtDo4dgM8JxoG48O9Xh40DspYJfwHVMcM/I1a0QgSD14g0i44VP51uSQoshPTjKDX0a0xa2kSNBOv2WWe6h0YTOgDi64Grix2dVdt31Bbol9vdmJAS+xMTY45AZy/dP1BbF9DlShTamnV+pEWO3IyHoCOkqsenlitwx4Ep5Lq1JdS7wGOqEa1zjfjFDeqyn4WoeGvNa+yL4eHvLLLdqpR4onJdYNmEvpj/HOL7bdmNyTZS85gjlf5GORUwYaknEX/PLSdeDRURJVtPwV8ozPc/8n5B/uviJAsZieXSkdugjZd6+I4RwdZefgAJyb4uLSo9mmzUPsm1FNWChkSKVTO1YXr+as2TOVsl+qSvWXA+aP4ZbMt737xz8DlUYKiDbAz6WpEe4TzgtRai0wSIvUXjPKxHLoWlNrjHv2fIeSO2clgXbRAveRNBooI0K0VLm2+8gXyGb1/HKBGuG4l045NfgCMUSPc93Ta7kyflsBiVKBGUfxuQ0Z1eLchVWme8f3S46mYSuQ6Fn0kGJlb3xIkYzBVZLee1vjLnOGvy8qBSao+BflmZ5ZI5gWyd6l8Spc759By4CnTM6hQxbRJtcr7sG/U/bkk/xzyULrTD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(2906002)(54906003)(41300700001)(316002)(110136005)(8936002)(76116006)(7416002)(64756008)(66476007)(66446008)(66556008)(66946007)(8676002)(9686003)(4326008)(52536014)(478600001)(122000001)(26005)(71200400001)(5660300002)(38070700005)(33656002)(7696005)(38100700002)(6506007)(53546011)(55016003)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjdLZW9Genlkc0NseHkxTWJ5a3JNM0VQWGJyL1IxUE0rYXdwL0l3RmtlL0Nx?=
 =?utf-8?B?OVY2cnJoL2N2MkM3ZlF1NVl6Y2tVTUtWWGRCRlRFNGxNOFVRb0ZGK0s3OUNG?=
 =?utf-8?B?bGNEWTlHNGxyOHVJZHl1NW56YXpkLzdZT3lLTjJ2UlNMY0dRVnpuUjhkdjRS?=
 =?utf-8?B?NnM4NmFYMW55WlRpWHc4Njd3UWd5a1RCcW1WOUxrbGZLdFlGN0xaMzF6VzBH?=
 =?utf-8?B?UEduVEs3dnUySmQxbWFRbmVSZ1FueEJRL0E0N0tTY0JPREFyMW13SlpNMmxM?=
 =?utf-8?B?eE02U2F2dXF5VHB6K1lncXJjWnViUHA1a0tCN2FCZ28ySy9ybmNVTW00dThw?=
 =?utf-8?B?eFdaMWdoUTdueXFjWnRXNGpJVDAyc3MrTDV0K1VSYzJ6bUJYZzNreTZCbDJ1?=
 =?utf-8?B?SWN3Y2w0bEtBZTF5M1ZmSTFYOWE0RVp4K09KUGxYV2d2YmY0eUhhTkJQbnc1?=
 =?utf-8?B?aTZNQTlpVStwNjVaS1ZFYkNyUUxoOWt6YVhmcmlzbUZnRHpuTVp4VXhrZitq?=
 =?utf-8?B?d3Z5Mlk5SFNVMkRRM25tVElhS3FybFgrWHcxZnhyekVpSDFUbEVOdHhKMkQv?=
 =?utf-8?B?ODI4NUVzYUR5UmJOUWFabnF3R1pKN2U1R0JmMXNmeEg0NHlXc3JscjV0VUV1?=
 =?utf-8?B?ajdRb09GV0xUTXVOQXI4NHZPNzRQbnBXS2tJdmo4VEFUc2N3bFg5N2RwNlZi?=
 =?utf-8?B?SEtwZVVUby9oSlFVY2h2aEJ4c29qNEJvQVRGQVBoTk4yNmkwazduNHprT083?=
 =?utf-8?B?NFp6REhnd1AwaWk5cUxtaUtxOTFoVExWRlgrK2FrbDVhL3RVMTNGV0ZCcTRy?=
 =?utf-8?B?ZXpmLy9pTENqMjdCTEtZRWgzcVNvby85T0oxVnFWcFVCYlFjc0E3SkEwL3Vp?=
 =?utf-8?B?Z0JjWC9IYkwwRXZjb1ZPMUQ4eHZtUHZWcVlXT3JVK3l3VWZGajN1SzNKWWFi?=
 =?utf-8?B?VTgwZFpGNFJOc1pJWGZ1d1Y1SW01U284U2Y5OGxOM1R6OEVKeGhFTWdJZ1BB?=
 =?utf-8?B?VU9jSW1zR3JIbkJEamhuM2YydFZ4RkFqSnVSc2NTKzJSaUJlRDlCSnRFWTBo?=
 =?utf-8?B?NXp6aHVHdzFxZzJhU2w4NTRXUWp5SHdqdjFYa0QrYlBVT0xPNGZQcVVyUHJs?=
 =?utf-8?B?TEloYlhxRXM2V05yV0FIa1NFbFo2c3lEMGNCenY2Y2w2MlhHT2tCV3ZQeTlW?=
 =?utf-8?B?TExiTCtVM1ZUcmdlZmNQcGlzZDRRME1KTHVxaDEzU2VKL2ladTM3TVVGdVFu?=
 =?utf-8?B?eGtWMWhNNG1UQXdsLzZDZ1cxZjZTTWVESFdXTjJVcW1iZ0NXRHBTZ0dlUWJ2?=
 =?utf-8?B?MURrS1M4ait4QUp5a09uUkw4Q1o3S1RNbFM2VEg4cUxjMmhLbGttS2dObmZl?=
 =?utf-8?B?ZkgvY2gxVU1QQWRZTVJxL0xNRnFNdzE0anVXV3NCRFBhSnBLTk5NazhxU3do?=
 =?utf-8?B?bHBDY3RGNjMxcTRaVE9tTTZQMWZJa2FpR21MRHZjUHI1THdGRHE4aDVIdDZh?=
 =?utf-8?B?MU5NWndNUFF2Q3EvZGZLa0g4NDRTQUUwZTBqUVl3TjNTbC9ZdXV5S1g1MGZT?=
 =?utf-8?B?ZzFwelBxZ2N2ekNncVVTbGhKSXpyUG1KVjZPZ3hvUWl3NGFQZSsrUGhPVHZZ?=
 =?utf-8?B?RE1KMGIwQk1ndWtZc1dROVV6VjIySzZmWEFFbVlMV2xxekRiVmQ4a1IzZEN5?=
 =?utf-8?B?Q3V0Yi9RazZDQnRHSTR5U3I2QXR2VDJ3Z2FtODR3K2g3QzNlMDR1Qm84dExD?=
 =?utf-8?B?TW03U1I1WGlNMWxwUU5lZHJOK09KWUl0Yk50WklzR1lWZE5pZXdtbFIzZE5T?=
 =?utf-8?B?RDJvUW5VczFSc01jeHB4YUNSeVd1bmpCdkFzblBRclZickJnSm0xenBrK3BI?=
 =?utf-8?B?cXhzYXpteFBkN1JNVVNtc0pYNkRPSUJUSjUyUDJHMStSQ0hjazBWeVExUXk4?=
 =?utf-8?B?WUlwYUIvL1lFeFF1UjdKWm84VXdGdFJucjhJNVBTdGwvRHdncDduY3FsMUN1?=
 =?utf-8?B?c2VjSXcrd2FTblB5ZVNESVVqZ0FXbW5XZnNLYlk5c3dQTU9VWC9ETnMvWE55?=
 =?utf-8?B?elBoMzIwZkRlU3RDY1NvYkRIVnRFK0pLWEx2NGM2cjRBYi8vb21JZEVpUjRQ?=
 =?utf-8?Q?/iMigrzCvBbLe1ufqOQ6WcwF2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34599ca6-0790-491b-33a8-08dbbf078d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 03:12:16.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U27kAsVbda5EsrR8zFfWbjE9Qh5zlX9NR6ujkaGED+6qtcMNgl9OZCDdfLP2ugNO0QjCmlSQvDA5BpC4FvbfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAxMDo0OSBBTQ0KPiANCj4gT24gOS8yNi8yMyA1OjI2
IFBNLCBZaSBMaXUgd3JvdGU6DQo+ID4gRnJvbTogS2V2aW4gVGlhbjxrZXZpbi50aWFuQGludGVs
LmNvbT4NCj4gPg0KPiA+IFRoaXMgaW50cm9kdWNlcyB0aHJlZSBBUElzIGZvciBkZXZpY2UgZHJp
dmVycyB0byBtYW5hZ2UgcGFzaWQgYXR0YWNoLw0KPiA+IHJlcGxhY2UvZGV0YWNoLg0KPiA+DQo+
ID4gICAgICBpbnQgaW9tbXVmZF9kZXZpY2VfcGFzaWRfYXR0YWNoKHN0cnVjdCBpb21tdWZkX2Rl
dmljZSAqaWRldiwNCj4gPiAJCQkJICAgIHUzMiBwYXNpZCwgdTMyICpwdF9pZCk7DQo+ID4gICAg
ICBpbnQgaW9tbXVmZF9kZXZpY2VfcGFzaWRfcmVwbGFjZShzdHJ1Y3QgaW9tbXVmZF9kZXZpY2Ug
KmlkZXYsDQo+ID4gCQkJCSAgICAgdTMyIHBhc2lkLCB1MzIgKnB0X2lkKTsNCj4gPiAgICAgIHZv
aWQgaW9tbXVmZF9kZXZpY2VfcGFzaWRfZGV0YWNoKHN0cnVjdCBpb21tdWZkX2RldmljZSAqaWRl
diwNCj4gPiAJCQkJICAgICB1MzIgcGFzaWQpOw0KPiANCj4gSSBhbSBhIGJpdCBwdXp6bGVkLiBE
byB3ZSByZWFsbHkgbmVlZCBib3RoIGF0dGFjaCBhbmQgcmVwbGFjZSBpbnRlcmZhY2VzDQo+IHRv
IGluc3RhbGwgYSBod3B0IG9udG8gYSBwYXNpZCBvbiBkZXZpY2U/IFRoZSBJT01NVUZEIGFscmVh
ZHkgdHJhY2tzIHRoZQ0KPiBjb25uZWN0aW9ucyBiZXR3ZWVuIGh3cHQgYW5kIHtkZXZpY2UsIHBh
c2lkfSwgc28gaXQgY291bGQgZWFzaWx5IGNhbGwNCj4gdGhlIHJpZ2h0IGlvbW11IGludGVyZmFj
ZXMgKGF0dGFjaCB2cy4gcmVwbGFjZSkuIFBlcmhhcHMgSSBvdmVybG9va2VkDQo+IHByZXZpb3Vz
IGRpc2N1c3Npb24gb24gdGhpcy4NCj4gDQoNCmF0dGFjaCBtZWFucyBhIHRyYW5zaXRpb24gZnJv
bSBub24tcHJlc2VudCB0byBwcmVzZW50Lg0KDQpyZXBsYWNlIGNhbiBzdXBwb3J0IGNoYW5naW5n
IGEgcHJlc2VudCBlbnRyeSBhdG9taWNhbGx5IGlmIGlvbW11IGRyaXZlcg0Kc3VwcG9ydCBpdC4N
Cg0KdGhlIG5lY2Vzc2l0eSBvZiBzdXBwb3J0aW5nIGJvdGggYXBwbGllcyB0byBib3RoIFJJRCBh
bmQgUklEK1BBU0lELg0K
