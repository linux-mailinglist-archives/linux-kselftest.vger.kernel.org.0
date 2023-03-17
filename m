Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C216BE67F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 11:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCQKUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCQKUj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 06:20:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172E30EBF;
        Fri, 17 Mar 2023 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048425; x=1710584425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y/WnYQaJ8iuiqiv7nxMT9oRSw56+HDpai9KwKif/Ahs=;
  b=RXB8wxZmkeCajjEAn2xh5plIz+XwceeSd+wOF1t5hlZq4Aw2oqTJqaWz
   Y8F6UDH25WLJJBGwRkuKo99qt87R0j/ZnT+EY3SEuclCvFbMEr88skroV
   QavB5gASwrA51J8yX2nle7/c92KXE66DEFUFB1Q7QfjdPfUEsKk20l7PY
   UwoT5HgDv8Je4kECrY4A8zOAMKdUIGJXsczmsba1g9ZgyiqrfSs6+ZtGt
   ujcnmixJ7ULuOMvR1sSxAJ4x4YPSj2mMPQ9jsnm4FdrWLIzSFEMbGrEE9
   rylShjE9LjOYyXmY7a7dANVzJDGlBQjiBpUbZVCaphtb8ci3YoKwznVVh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="322078612"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="322078612"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823625928"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823625928"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2023 03:20:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:20:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:20:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqYZSFZ+31Ytx7L8BKKf591eptphz1uczl1Q+iKEM6gn798q/207mmiRI85z0PAn7yI4BvDtVPDk2Lhbz5YCXC9uAp1YyTS/77jneCc6Al3MAt4POrXQOa1TWkRi+LTNpoB6WiSD8wj8+YLmUnQ9xyA0lJ8I14rC48pqiR9n+Z+aIPi9ll4O8D/noWNeHa3XmDn3IK9tU6XiaVrYYaFrBGDH+tv365jFxwLbRaPbDxzemr2BG3TxsaQvU2KmGDtnqDQEF+ifmwTsLy+naBl0cYc3hPBUv02nvqA76D52VIMrz0u6Tx8iDtXSL06d7A7zXWmbcALzjg29zPTlkfxAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/WnYQaJ8iuiqiv7nxMT9oRSw56+HDpai9KwKif/Ahs=;
 b=YUvE/mQDwAPJDeXkB5C9el6aeGe5dvn+enb3bVzoBo4sJBPU6PjAQt0FPHL4GfmzBQ0ZRqRRXGdyPGedaB+Bc1zF5rGaPEOHBw219PW0cACLS28uRY8iljd+O8QOpZPXB3HZd17mc4XvebMXGRJf5j9QyRDnZ7t2L0P4AyvVM0vgSB8n/irN4BpVdPV7Sq/TsTFyS5DroNeLJIAjSXTkU5B4Kd5JgmcdfGWLhGONjOW0Cae+K0qO6l+Px9rt7uaqmFAZOZmUjmhAwktXrJMpOMcxbk8rBZAqslVtCsGMz6NW3qKQi7EbgWzRgiVPwBZQPDugN/r6uj8opvnzHdRMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:20:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:20:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Topic: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Thread-Index: AQHZSLANXhC73ppY102GjnYoeeDveq7+aCgAgAAQ7wCAAGl3sA==
Date:   Fri, 17 Mar 2023 10:20:21 +0000
Message-ID: <BN9PR11MB52765B85EF8C4608786B068C8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBPmPODkv72aDQ4R@Asurada-Nvidia>
In-Reply-To: <ZBPmPODkv72aDQ4R@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7090:EE_
x-ms-office365-filtering-correlation-id: d8f655dc-2891-48a7-5362-08db26d136e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLTEgzGINL7rqhS3kYRmlPOXX5AE6geJovZkKZE+2d67K8vYBwLvz/MPouubwLPkxyO2Z9MF7K2bynaQAdrjxLUbExGVKBh5l6UHdXNiySW01OV73qPabHbF8ZAJBn9ndmYL+jF6Ks8RRWKtTyXG6bGZQ8nJmdv83214eyqZhwd85i1xNfQ2C3hGndGDhYKTGLCik8y8bMHpQXfUyr2e7edzynzx6oLc1AnPxUx+LEhdwCLM/oJGZ+UGs4a1mAQV2V4K53usvZs6Vfw+UYrtN4vy8LhCFdPD8aD75/uUKnyIOMQfo6FdWNDluivlz/LRIgTC021maK9WIC8jLMdJGC4VzLD8agFYf5Rxg392uArFCTmyo+KTRus8n64h5abu6h7a93tnb/TprwQ/iERBtJea46WuVkfmkTj4MbPTgj4avhlNBdrSQ8hgl7TYakkGdfhTeqHBr/gurSq/uYdv2peTpYSVYKahUREZuG9yCgSa99sJJhHmge1OiNIDjhOC+Qd5OcVDv4WzANpyAXsToMQHXnzyKigJwD7PSYB0Hg1tWl7baOsPyMJro2KcOAmkV37u/rmNnKKV7ClwZnkFa2GrFi5LaiD++ToeNUPBfgiyUzdwC92eDdcb4J6AYZMOII0I5Gnmg3wLN9E9gtVRan3VflYMYKvacgvtS21gkPCy6C84G5OR0Atev67DJj9L2FO1RsDGNkl4dKU2hFH4zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(38100700002)(86362001)(38070700005)(82960400001)(122000001)(33656002)(2906002)(52536014)(41300700001)(8936002)(5660300002)(55016003)(26005)(9686003)(6506007)(186003)(316002)(54906003)(110136005)(66446008)(64756008)(8676002)(7696005)(66946007)(66476007)(66556008)(76116006)(107886003)(4326008)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aExGdzQ5UDNkRmRkcXZMYWZLQkhlaWM1eXh5d2F6aTR3bEFibmMyVUE2eC9j?=
 =?utf-8?B?dUFuTlhsUTI2SUxsdFdSakRWQzJ2ejJyVjFvYk5qRGFsKzR5RHJYeEdqV0xm?=
 =?utf-8?B?SUlFdldXakpHTVlTNkpENUtYNlA2bzVjc01EZ3V5K2dxemp1R2wyNlVVYzdH?=
 =?utf-8?B?MTBOU3BpTFJZMVJHdjBaVGNNeGUzTGhkdE5kL09aZ25WV1R6d3BJbGVPeVNh?=
 =?utf-8?B?bzVZZmlvR0hPWU1XU0liRXNtV0YrZytTbnAwMWdBYmFObVVlcE13K2pLdnRu?=
 =?utf-8?B?aXdFbFpUT1dnckRYRG9va0ZobHRQcHNFcFRlckQrVFZDemgwUlFRcXNDVnBw?=
 =?utf-8?B?TEdodHppMUxzUXUxTWtFcHhkbk5FUGNaN2VMOWRubzVMMVJrbzhRVnk0Nm5i?=
 =?utf-8?B?YUgvR2YxS3hSYjB1WUFHcWdTRTZPRlh3UHRTUStkT2h2a0psUlhtY282dTM3?=
 =?utf-8?B?eVhvZW50eVZMUW91VkVpMjhsOUcyVkFMZm53M0haYkR5b0plTXIxdEExQTZa?=
 =?utf-8?B?NHFSZFhmRk45UmNvdXlBaW1wZXJLTlNhVzJtU1BIbEJONTBvZmRxOFA2c1hq?=
 =?utf-8?B?UUNlaWNIOHU5aE4xdHJ3cW9uRzhsN3loblZicUdPZkRvRUpVVnZWMm9JOW5l?=
 =?utf-8?B?c0V5VG1nak5QRTBNVElBM2NDVnh1Qnh4R25CNEZicytkMXRQZ0U0QUFDQTJq?=
 =?utf-8?B?dHRZZ0ZuS25nNVNibHloUG5rWFdBUmFpQUxkMitEa0lIUTdnaTJHZGpIbCtJ?=
 =?utf-8?B?T2NpMk56MkRBUW9iVDJoVjVSWkZOeThTTUxXMTZVN1REM2o3VHBDYXBqM0Yz?=
 =?utf-8?B?bjhIRUR0dHp4ZkE5Wm1jNHhpblFUdjJzbTNWbDM5U0Nlc2tZUi9GYjh1QWdM?=
 =?utf-8?B?d2dpK0JxeTBHWVZaQ3lLK3VkM0ZxeEhzQTZZNi81cmNvU293YzdvRFlLNStn?=
 =?utf-8?B?RjFUSlE3QkZmeElUUkN5eHBYMlI5Ujk5V2lXNXlXSXJlTzVmcGpEQ0I3aitF?=
 =?utf-8?B?TjNiZkRzV1k5YjM3bnlhVHAzM3V0UTYvdUVYcDRTdVBWMUtGMkNKQnVNY1VM?=
 =?utf-8?B?MVdSNVZlOGd5MkpMOGxCdXVNZ1R0akMzWWFWV0N6Q1d2cTN5YXRqYmRIdFZU?=
 =?utf-8?B?bnpiWVRHZCtVY3MrSm1pcVVCRDk4RFZpSE5xTm9wMlVHMUx5Q2pTMm40alFn?=
 =?utf-8?B?WVFhT3hrTis1YktHOU43WU1zNUpPQkc2eGd2eEdmcG91LzZrd1RrMm1zQ3VW?=
 =?utf-8?B?L0lTcXU3OVdiQVA3dENTRHNiODNLRlJJL040RTVDdS9lQTB5YUoyT0V6VGdv?=
 =?utf-8?B?ZHZ5UG00dGtsQ3RlOXNiZFdubHRkYXY5Y0UwQjZJMVJIVVZqUkZUOHl4VHIz?=
 =?utf-8?B?YWJaR1FQTm5nYlR6UHo5SklybzQ5NVlZNStSWWt2SkZ2SGNRR1JlUnNoMElS?=
 =?utf-8?B?RkxrN2xGemMrS3prWUE5K0NBMHEzOU5zaCtRL2xGOXhKNkc2YytvdlhpaXRW?=
 =?utf-8?B?R3ExYWwzckppTE5aNG9aQm56bmF5clc0Q3VEMGtqNklrOG5GOG9rZTJHTU01?=
 =?utf-8?B?SEswSUFRTDJRbUN2S1RBZGdEWmNBdnJsT0IzSE1nOVAyWUFZYTNlb25iaU9p?=
 =?utf-8?B?UmhvU1dxTTNQMWZRZERuOEhBWnFyaEVBOWR1eWJrU0lLczdoMkthVTArdUdn?=
 =?utf-8?B?dVBpUktkdGJ3ZFloLzduVVM0ZFdrRlBGVitTRERkbEVJYVVjaTBOaXhoM3FM?=
 =?utf-8?B?bXdkRlp4VnlFTUJ0ZjVoSWRhR3F2Q01hTjBtWE5xSHdyS2t3VDhGVkd5cG5o?=
 =?utf-8?B?K2FHTyt5dmhHT3UwRWV1Q3g1Tm44Uk1Oc3hCNzkxSVVla0Zadnd4OTlkdU1J?=
 =?utf-8?B?UFVNaUNoQXdmZW1MMjlSMjdQNmprbEk5UFRITEFSVlZVWm92dE5UZXdYTmFU?=
 =?utf-8?B?WHJDckRNTEpMUFRUa1FmWjZMTmVNSmU5QnFzZTdCMVJmQUx6SzBocUtPMnkv?=
 =?utf-8?B?UDlVZUtZb2hnSVFHSWIwSTg2S3NyZXRFdStMdHJlelJlV2lOM1A5UjRCUzVD?=
 =?utf-8?B?MTdRaUFaZ1lueGxVUVc1TkZmQkIrWUZHYVRDR3B5TzNDTnFQcmtEVHdOdFpr?=
 =?utf-8?Q?O2P/yXpK3Vkijba01/ULHSrRk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f655dc-2891-48a7-5362-08db26d136e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:20:21.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOmMMmH5DEUD8cKINx1Yk4alOjatfhuBxGQ4588CUxi3GfrONhv/ZeYQWXcnrj92L02G4G93K09yNxexadGgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgTWFyY2ggMTcsIDIwMjMgMTI6MDIgUE0NCj4gDQo+IE9uIEZyaSwgTWFyIDE3LCAyMDIzIGF0
IDAzOjAyOjI2QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiANCj4gPiA+ICsvKioNCj4g
PiA+ICsgKiBzdHJ1Y3QgaW9tbXVfaHdwdF9hbGxvYyAtIGlvY3RsKElPTU1VX0hXUFRfQUxMT0Mp
DQo+ID4gPiArICogQHNpemU6IHNpemVvZihzdHJ1Y3QgaW9tbXVfaHdwdF9hbGxvYykNCj4gPiA+
ICsgKiBAZmxhZ3M6IE11c3QgYmUgMA0KPiA+ID4gKyAqIEBkZXZfaWQ6IFRoZSBkZXZpY2UgdG8g
YWxsb2NhdGUgdGhpcyBIV1BUIGZvcg0KPiA+ID4gKyAqIEBwdF9pZDogVGhlIElPQVMgdG8gY29u
bmVjdCB0aGlzIEhXUFQgdG8NCj4gPiA+ICsgKiBAb3V0X2h3cHRfaWQ6IFRoZSBJRCBvZiB0aGUg
bmV3IEhXUFQNCj4gPiA+ICsgKiBAX19yZXNlcnZlZDogTXVzdCBiZSAwDQo+ID4gPiArICoNCj4g
PiA+ICsgKiBFeHBsaWNpdGx5IGFsbG9jYXRlIGEgaGFyZHdhcmUgcGFnZSB0YWJsZSBvYmplY3Qu
IFRoaXMgaXMgdGhlIHNhbWUNCj4gb2JqZWN0DQo+ID4gPiArICogdHlwZSB0aGF0IGlzIHJldHVy
bmVkIGJ5IGlvbW11ZmRfZGV2aWNlX2F0dGFjaCgpIGFuZCByZXByZXNlbnRzIHRoZQ0KPiA+ID4g
KyAqIHVuZGVybHlpbmcgaW9tbXUgZHJpdmVyJ3MgaW9tbXVfZG9tYWluIGtlcm5lbCBvYmplY3Qu
DQo+ID4gPiArICoNCj4gPiA+ICsgKiBBIG5vcm1hbCBIV1BUIHdpbGwgYmUgY3JlYXRlZCB3aXRo
IHRoZSBtYXBwaW5ncyBmcm9tIHRoZSBnaXZlbg0KPiBJT0FTLg0KPiA+ID4gKyAqLw0KPiA+DQo+
ID4gJ25vcm1hbCcgaXMgYSBjb25mdXNpbmcgd29yZCBpbiB0aGlzIGNvbnRleHQuDQo+IA0KPiBZ
ZWEsIEVyaWMgd2FzIGFza2luZyBhYm91dCBhIHJlbGF0ZWQgcXVlc3Rpb24gaW4gYW5vdGhlciB0
aHJlYWQsDQo+IGJlY2F1c2UgaGUgY291bGRuJ3QgZ2V0IHRoaXMgcGFydC4gSSB0aGluayB3ZSBj
b3VsZCByZXBsYWNlIHRoaXMNCj4gIm5vcm1hbCIgd2l0aCBqdXN0ICJrZXJuZWwtbWFuYWdlZCIs
IHNvIGV2ZW50dWFsbHkgaXQgd291bGQgbG9vaw0KPiBsaWtlIHRoZSBmb2xsb3dpbmcgbmFycmF0
aXZlIGFmdGVyIGFkZGluZyB1c2VyX2RhdGEgYW5kIG5lc3Rpbmc6DQo+IA0KPiAgKiBBIGtlcm5l
bC1tYW5hZ2VkIEhXUFQgd2lsbCBiZSBjcmVhdGVkIHdpdGggdGhlIG1hcHBpbmdzIGZyb20gdGhl
IGdpdmVuDQo+IElPQVMuDQo+ICAqIFRoZSBAZGF0YV90eXBlIGZvciBpdHMgYWxsb2NhdGlvbiBj
YW4gYmUgc2V0IHRvDQo+IElPTU1VX0hXUFRfVFlQRV9ERUZBVUxULCBvcg0KPiAgKiBhbm90aGVy
IHR5cGUgKGJlaW5nIGxpc3RlZCBiZWxvdykgdG8gY3VzdG9taXplIHRoZSBhbGxvY2F0aW9uLg0K
PiAgKg0KPiAgKiBBIHVzZXItbWFuYWdlZCBIV1BUIHdpbGwgYmUgY3JlYXRlZCBmcm9tIGEgZ2l2
ZW4gcGFyZW50IEhXUFQgdmlhDQo+IEBwdF9pZCwgaW4NCj4gICogd2hpY2ggdGhlIHBhcmVudCBI
V1BUIG11c3QgYmUgYWxsb2NhdGVkIHByZXZpb3VzbHkgdmlhIHRoZSBzYW1lIGlvY3RsDQo+IGZy
b20gYQ0KPiAgKiBnaXZlbiBJT0FTLiBUaGUgQGRhdGFfdHlwZSBtdXN0IG5vdCBiZSBzZXQgdG8N
Cj4gSU9NTVVfSFdQVF9UWVBFX0RFRkFVTFQgYnV0IGENCj4gICogcHJlLWRlZmluZWQgdHlwZSBj
b3JyZXNwb25kaW5nIHRvIHRoZSB1bmRlcmx5aW5nIElPTU1VIGhhcmR3YXJlLg0KDQp0aGF0IGlz
IGZpbmUuIEJ1dCBhdCB0aGlzIHBvaW50IGl0J3MgY2xlYXJlciB0byBzaW1wbHkgcmVtb3ZlICdu
b3JtYWwnLiDwn5iKDQo=
