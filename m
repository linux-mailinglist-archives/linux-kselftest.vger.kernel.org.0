Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4657AFDAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjI0IJU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjI0IJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 04:09:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4436B3;
        Wed, 27 Sep 2023 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695802157; x=1727338157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3OofP9Latg6e9l2QfhKy4+NKbNk/c/8x84hXbBsxY0I=;
  b=drOkpxGlRh/W6ADuMEq6QtOvl1tiQhGtQOtdJqr97zrNKxFDHReebli6
   dQsDa/BUMgQo2k0VBvfCsq3uQlp3lGUFuK82Ioc/7p/n0/D6pt/PAam0Q
   zM6QV18jlOkH6NFNzBQ5Lj5nu+Xtv07XwHoHnoxiOieFwlsNW6gn9w25k
   p85nw6gkU40a51YcC4P5HtSsEOwG29+XbovbyNTS9NHrd0A8Dy5lkak7k
   KdZSbnqLQorhQRK/p5sRkceJMXIHrhCa8fbQwIPp6JyeWAA6tW37mC7yY
   p2QHUA6H67gooIvWtnC3BHwrl09e4OjZnfVMhyUPo+Lea/JrfWLbPFDaY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381663973"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381663973"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="458164"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:08:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:09:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:09:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:09:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbjFuE1jPkh91sQptm5ZKkV+E/tuAHvBXwOW4zBhIipYAc2uoqWcY2YgdKnyKj/9L3xYvmlASsCe0Jt1Prc1ZyKtFqX7XcLMpQOGsWkmLouoWiftSoOQZGHzR2NgdEPl0J3QCTCn0P5H8yCtSq249Egw5y6J9xK10so0YCh0k4iGvqhEi/A2n40NZ6KMBXbdUHtt/0jNI5AYT5D0VYYnoHlUVn/2r2ZnAzBH9vWvsxXwbTa2WFGS5AiL6CKFdOQLbv0b6hWR+WzFQkEucnSGGf7+MZ/fuECCJth1aXy5oI+5u4AzztX5IA4eeOstBoogx9HLL0SHyAtf2U3bAJdIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OofP9Latg6e9l2QfhKy4+NKbNk/c/8x84hXbBsxY0I=;
 b=eFnfLVcwynxLSyzl97m9zcPGPwFqr9gvOcvnkeTaNqy4PblDqXadqNNdyDbSdrkn9diKGDbFYXzJFlh8MkMCH61ATRn33GGT4+nTKiF1NZPj/zcq1fxUsh9m3J7mus9/MHNqPIk04Y2n/Sj8CdeR5JtHPArAjEzlmHIIsDe5lh//Y4zH4eqpeLO0NMGyhwoXt/WJcb8jOlvyV0eNL9JITfQvW/cz/5KXCpPS6Md4wjTosb9+kXd4IxgAXKyLEagpTo5EYNJsekOvcznZP6TXSuuP5bNnJ1QCoEkndsoID12rdNI1JKuuRB7ULD/c9VqOw6qm5IKH1jQGOpVAJyG9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 08:09:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 08:09:12 +0000
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
Subject: RE: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Topic: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Index: AQHZ8FugfyIGJa74hEWHVr2uRxtb/LAuTgKggAAB24CAAAL8sA==
Date:   Wed, 27 Sep 2023 08:09:12 +0000
Message-ID: <BN9PR11MB5276CD4C47B3833BAC8B30588CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-9-yi.l.liu@intel.com>
 <BN9PR11MB52766E649727842C98B7396B8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04af40a3-1675-4b1c-27de-39d261dcb1cf@linux.intel.com>
In-Reply-To: <04af40a3-1675-4b1c-27de-39d261dcb1cf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4518:EE_
x-ms-office365-filtering-correlation-id: 2531fcd8-529d-40fa-4d21-08dbbf3108e3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUYx454N8MoldXSD8MeZSWOZBYLEw+b8uQ/ArakzbnAVz6AW9VmUK/a+ElhpiDRrk1ytp4TLxZpqjm8ctf3ykEc3XBu97OOrYsQXHLlwD2bY4kZV2Y/2DWPzeftlBWHJ0eL2BIaStnvKfcu+Uu88y9yLCrioGMd96JuPVzymly54Y12I58yOpIh2zG7rZhVe2DH7Q+uRfcHGS/8Q0y9pWPkWKUuh7qGNNYFwbodRcGyz0efSokOLSbL6lhH9GuwjoTrCRw0/KOXYrH0PEQxPwGiizPlsYz1d5NVtGSWFTtc2X9do26YsaVaEeDw+bVT96ir7I4AytI7vrkMqsBa9Ep1GuEkel0oL655HJQrbYHXK66qgju/ohNoS1cFRBjtNpDdlkW96k+rwKUdkIrk204ViRHFQme5slGbQOPJLb8fnPnKDtFN5XIvevl3+3Z2MQb4PbjAAGTMNdMi2GoW+a0ZkyaEVibpJhzA1581C/5DVQEyEk/CakxQevOP5Bx40/LyS0J/78Knr9APDKFVBTQtYAMcT5tJKp4IZBm+0wQ2wqgqXXKZKjC6RYN0/kwnJsvCKZiC0FtAm4XnCQzCDe2vuyZDKLGPvgCN0jgt+l1yWKTiu+0+mw0Sm3aChTHp5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(66946007)(7696005)(26005)(6506007)(53546011)(9686003)(82960400001)(38100700002)(86362001)(38070700005)(55016003)(33656002)(122000001)(41300700001)(83380400001)(316002)(8676002)(8936002)(4326008)(66556008)(66446008)(66476007)(54906003)(5660300002)(110136005)(52536014)(76116006)(7416002)(2906002)(4744005)(64756008)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnNFby81WEhzaWd1aHlIN3U3dVBWNk0yVktyc2lkUWJlUXJuL3B4a214QjJ5?=
 =?utf-8?B?dXV3eU9WM3ZGb1I2WFZZTlFDOXdQaFVaeGZBTTNtT1FHelVWUDZhanY1SUJo?=
 =?utf-8?B?M1ljVGJNc2xVYk1VNHU2aFkzYktUSDlRR3phODVjVzc0ZlBRRmJZbTBrRU1r?=
 =?utf-8?B?Y2lPcjF4MlBjZ3IzeHFlYUlRandKMkRCOElxRWhqUkYvUVYyeVRBRGpZWDBo?=
 =?utf-8?B?ZHQway9XWk1ZZnBxaWpzYTFLOGpNak40ZGwzaVdjZW5DZU9aZjBSZ0RTWjh2?=
 =?utf-8?B?YzNYTWR2SHVsNmhpUkZadHB5ZWxJTWhaUjhpRXhVVFNqdGt0a01la2MyTGdS?=
 =?utf-8?B?cXBDQVRDcHEyazBLVFp4S1E4UStXdWMrTWUvd3lzdVVpa0NMd2UwQzVtOW16?=
 =?utf-8?B?dk1nZ0d1ZnVkMWhXeE4xWEk1L1liVlBrQXdZQThxYnllalF3enZCUmtVTnJS?=
 =?utf-8?B?eWNYb1IxRVYwUWEwcXZhWUFCOEgxcTlIYzJyMWxOZk4rdHFpcTFXVFl1TkdL?=
 =?utf-8?B?Nll2N0t3M204dG03eXRpREJ6cHBjdkN4bit0U1pyaHhjckFIV3g5Qk5mbGU2?=
 =?utf-8?B?SFdsYlozeXNObmc4M3lVVmhiazhKaXcwWUNncGc4d0ZPdWVsMFhqcDF0Y2cw?=
 =?utf-8?B?T3RtakFuditBYjdQeWNwVUVObEp4aFFqMTVpL0NmZll4SVhMdldPdmZrZHdY?=
 =?utf-8?B?c01kL0I1bTB0VUhqR1VjQ21yNzN3V3o2SXUwMGhFQzAybUV6Ym85eENYRHZt?=
 =?utf-8?B?MHhuY3lUTGxmd1F4cDN0Nlpudis1S25RWWM5TnJubi9NSGh6YjZyNDFWQmcr?=
 =?utf-8?B?R1ArN2dFRVJEdCtvSUhrejhHT1F1MTQrWllCOHhQS3N5NDFtaXhlL205Q1Mr?=
 =?utf-8?B?bjEzWm12MDEwUTZhdDFtL2tKM2hzYVM5aGZjdGxUQVpkaHJoaG5CeUNwS09D?=
 =?utf-8?B?Nk9GbmtwbDJaM1FNbU51MnR5bG12VkFvdERCWVU3S0JJN2l1NUVDWk1CMzBY?=
 =?utf-8?B?ak9ORlN5cCt1c1FhSjFxeStqZFgzSGRlblNzNnZPc0pUU3FlSnphRkdzYlNk?=
 =?utf-8?B?RDNxalRINDBuYjhMMjhRUjZJZ3kvdjA4L0tPcmRIek9EOENOVnBPZEpyOWZL?=
 =?utf-8?B?YnhvcUJHRlkyTkVqSHRIR0FuR2VIVUk0VjNjS2xwQnJiY2Q5SEVrS1pINWdv?=
 =?utf-8?B?N0oyODdJWmoyVFM1cnZvcDNKSFJNRUxCc1VxNlo5cmtETVR3SjFtekZOd2xa?=
 =?utf-8?B?TXVZOUJ5M2s5Ky8xWmFkcmFQc1pINFdrR25xZDVmVk9ONHB6azFmR09sK0Zh?=
 =?utf-8?B?eDNLc0E2RWNkSzRjSlJDZndXeUFZS2hZc1ZucURvV2crOGhVQXE2QS9rTXlp?=
 =?utf-8?B?Y0VHTUQ3djNwVFNac2NEc1lTSHhsbDJvZHMxNis4eEM1QmFJa2g0NTNSRDlM?=
 =?utf-8?B?TWVmWHR3TTVNck1jcW14VjNjeW1YTUs5QSs2ZnJwbDN5Rk40UUpqd1V5WW1p?=
 =?utf-8?B?U2hPR0lUdTJIenN2d1AvdzlUck5xeTBoL1pjVU5XT0REWkRwNkJaNVY2dXpF?=
 =?utf-8?B?MHc0ZHJ2UzYySW9LWW91VmVhSkZaeVk3Y3FuMmdjN1VaV25MRVNEWmFEVWZK?=
 =?utf-8?B?c2VGQkFJV1JpajBlY0JBeUQwMTRIMFdkQ050TWYralZlZ3cvRHNzeVFUM2dB?=
 =?utf-8?B?bmF0TCtJNUJjaXFYREdqdEVNeXZZbkZYUVNBbEJycHFnZXRseFRRTUFtTG1a?=
 =?utf-8?B?ZVhVVlBGWlZ4UnNxb1EwdkhtZFdrTjZ0V3FveGI5aFFQY2t5WWpjVUY1eUV4?=
 =?utf-8?B?ZElVZGlndm1lR0licmRLWXdOTUUyOG1kSzNlcHNQbEJoV2RQenM2YjM3alc3?=
 =?utf-8?B?OUFzdlIxTnNGL0R6dmtROGpHVlNGc1ljeWVXU2lPSmdHdEpjSnV3LzNRWHQv?=
 =?utf-8?B?ZGM3SWl0MTBQckJVbHdIYTlNVWM0b2YzK1JaYTY0ekNFK2MvOHdScXd5ZWJi?=
 =?utf-8?B?bHpBdzB2UWFBR2pMTFVBN2NtSW16d1JvZ2J5YUxibGdDQ3dqdWE2NDRxWFl4?=
 =?utf-8?B?NmVwTFNwdThGSmpxbHJWQ3pSdTJUVURKTXFtRzdWVkJWYzYzSGpxT1Vqa2JL?=
 =?utf-8?Q?blZkwQ3JXOhrHNhdtzbrX4c3J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2531fcd8-529d-40fa-4d21-08dbbf3108e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 08:09:12.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe8293agyQMqMeODF8auN0wHxxKWgR9YNbjA/RW/e3bg8xidnzhCrBo5uBPXVUqVo1+1kHEw8EZNX7W6thZRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyAzOjU4IFBNDQo+IA0KPiBPbiAyMDIzLzkvMjcgMTU6
NTIsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMaXUsIFlpIEw8eWkubC5saXVAaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjMgNToyNyBQTQ0K
PiA+Pg0KPiA+PiBGcm9tOiBMdSBCYW9sdTxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4+
DQo+ID4+IFRoaXMgYWxsb3dzIHRoZSB1cHBlciBsYXllcnMgdG8gc2V0IGEgbmVzdGVkIHR5cGUg
ZG9tYWluIHRvIGEgUEFTSUQgb2YgYQ0KPiA+PiBkZXZpY2UgaWYgdGhlIFBBU0lEIGZlYXR1cmUg
aXMgc3VwcG9ydGVkIGJ5IHRoZSBJT01NVSBoYXJkd2FyZS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBZaSBMaXU8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJz
L2lvbW11L2ludGVsL25lc3RlZC5jIHwgNDcNCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykNCj4g
PiBwYXNpZCBjYW4gYmUgYXR0YWNoZWQgdG8gZWl0aGVyIHVzZXIgaHdwdCBvciBrZXJuZWwgaHdw
dC4NCj4gPg0KPiA+IFdlIHNob3VsZCBhbHNvIGludHJvZHVjZSBhIHNldF9kZXZfcGFzaWQgY2Fs
bGJhY2sgZm9yIG5vbi1uZXN0IGRvbWFpbg0KPiBvcHMuDQo+IA0KPiBXZSBhbHJlYWR5IGhhdmUg
dGhlIGNvZGUgaW4gTGludXMnIHRyZWUuIFRoZSBpZHhkIGRyaXZlciB1c2VzIGl0IGZvcg0KPiBr
ZXJuZWwgRE1BIHdpdGggcGFzaWQuDQo+IA0KDQphaCwgSSBmb3Jnb3QuIPCfmIogcHJvYmFibHkg
Y2FuIG1lbnRpb24gaXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
