Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B226C6B8954
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCNEM6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCNEM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:12:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9125FDA;
        Mon, 13 Mar 2023 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678767175; x=1710303175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LRPGPx+7I3dbYA1n+/mIKo610RayWe4WPfJCU8k7q2U=;
  b=diNEJWFUSUrhIoUfseRSdjLmDuPsGvbM+B/oxeDfmin4wOy8zDIWDOkf
   si8LnicYDxl5cErxrWrM77DsHx5DgpsJb7BmBfwu6tkSJF9d3/QLdCz7N
   DTjhGgnRP9amkTjTD8AV3RThJtcY6/m1LQmIcF1VlTb01c/tSAB+C/gXH
   jYKvQJ7MWBG7agESWpYvPXYk/P7KpQIgQKE+2r6qa+Oi8ryAlIlLeL1ZR
   I/HKzQArxbMvKJ8byLu7mMaKFRBfm68NEVvvcR5u7GXKwz9hGYIVv/f+0
   MfGaiPMRP9DEQ+Uj4Q+XF/xD1dvs6zoN0ADoqxWVTdMa9QIc9ch5ZXphv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="339693668"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="339693668"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 21:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="681273782"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="681273782"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2023 21:12:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 21:12:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 21:12:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 21:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXRmQeZzLYP4YcswpXQI1EIacfIeiiScgpcCfre9dXXeMz3pDDUbWFQHaFHlly6WgNPzkzfAY/p7Y+SmlB1Nqf9DPNry28wgyn63PyJne7hCYxur9xrAJ6K5byXVJT6KoR3Iyk35SZ0f1MKVtpIrS34HbeNQNP7NiM1xApRjvCnu36ClYXN4u13puypKFcH+tswHVX7a4ASpyPir4rOgM/acCObK4QuKy/trm+GFmPBanC7QYR2EUOA8/TfmGjVmbmWjUp5uEe10NwLnoY9yGj5EMXCXNk4ra+/heaYjzLHDOC5D1i7YQUtcL1RJAusbKPTCjf3i8GM0a+EPwk1Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRPGPx+7I3dbYA1n+/mIKo610RayWe4WPfJCU8k7q2U=;
 b=jgVin08nBc4c0Hx5ArqN1Qa9OEKIX73p3wEPVirm5we1Vdz1OrK7RQcveQIuIWm7mXmu/DfCPFz99DVIG3xthm9JcmfEDtr97xd28nDIEmxa1kNx4iaWVgbMnEKEPeUG63mQXPTSh0hj+EmwNV5/zssVDQjaTLkr5Hu3NADZSD8ws/VKILIXBlzeHbwl1bzxXIT3O49B74JUqvVQT9eBlX3WgsGVZYLqFZx5ILP2da5FBGxxpWrymydgaBaCBPdkV2DkqGowZMKXjRHmmiBZOgM7oGRKBnTgvPXy/wMPr3P6fGLdsqET83qipXwMPGOetOO3m4SFrTbI99YvHiAczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25; Tue, 14 Mar
 2023 04:12:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 04:12:52 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHZUl6BWo8K/M9cuUy0397Pqa8aG67zWIGAgAZX+RA=
Date:   Tue, 14 Mar 2023 04:12:51 +0000
Message-ID: <DS0PR11MB752958454D0620BCDD8A64C4C3BE9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com>
 <8a8f35e7-b0c7-b9e3-3f9a-f7a427781799@linux.intel.com>
In-Reply-To: <8a8f35e7-b0c7-b9e3-3f9a-f7a427781799@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DM4PR11MB5469:EE_
x-ms-office365-filtering-correlation-id: 91749a4f-aaba-4649-0c1e-08db244260d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVijN1fzcxcP6MmVocZrDuiE/5paPvvF4lHZ9U5/q7tLwMnQXjlwLR5oQi69uCt99jF56Km2jWE86/guK0pXEQ+kPtzxjKwMdb2cNx/Q77veDboQCEA5dMnEwIFIxfufuOYfuA9MYIjnrwyJf2Dv7OY4dnkjtqDOFeF43m4e2ThhyTsD99ITNCl/rRugxDUF3J785cFKAa5kN7hdgT/VvSCobVE5z3yiOka/E20vNsjyE0ohX/Q+/EZUIAcgRIWQ6k47DQ1csOJhY48gXVzTdZ/4sq95KGNmWgfjptjyPyVo6UD7y9oIR5DITlxLnLlqUDgEmUSdBaYHx1Vtp+315SkEmaaC2OW5mH65wwECitC2wWMRcyMGeDgrD8bn0zOuN5OgYK2B4W4w6/eXnLBXlvqB6Y+73zpZyw/GQvQW212QoUKFP7XXkq/I0bO9fdlNVac6924j6uuUzzwO40DLaEQhl25ayaQlNRbEu3e2nlDvnKXUQ6m1zhC6e5a3019PuMtSJmwzC95bEe6M8KJOGceCTfkigeJJfNt0TnMfBg+DGFHa9mDGpKubio6de/tf/Ano+xpw3RqcTx7zXC/xR7qAJH5DllW0rJ1Z5Ao8SjX5LZJDAkAOGddEjpGgGZWNaf7uOW/jhB/d947gpsF+ZmQGzEptJzaEM8eGbqrJGGIZOrepBWGkyHE3/WcDAwRK/piZQ32Fo9Vkd3gSDxpK1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199018)(82960400001)(122000001)(2906002)(83380400001)(7416002)(5660300002)(52536014)(66556008)(64756008)(66946007)(41300700001)(8936002)(76116006)(33656002)(4326008)(54906003)(8676002)(66476007)(38070700005)(38100700002)(55016003)(86362001)(316002)(110136005)(478600001)(186003)(66446008)(9686003)(53546011)(26005)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWpydXlMd0M4eGJuTUUwRU9wUmFHcW9TWWEzdkZkNFYrelhnUVZCQkoyRC9J?=
 =?utf-8?B?cWNWdEVkRnJERlFRTldUbWxJQ2doTDRSTDIrc0pBVXhmRjlZY1k2RDJXZlpi?=
 =?utf-8?B?RkFMK1l2bk9GSGczcEFGWlI2dGd5K2JpVkdQeXA4SStFY2tXNnREcndSRndY?=
 =?utf-8?B?NndBL1RvNkc4bUl3UEV0TGVSS3BjOTlHdGpKUDFmRURtQmtlUlM5REdyVmdR?=
 =?utf-8?B?elVTckNwNDVJcFJOL3dUZnk2eEFWZmFtUm8yYWFuWm9UY1hQT2hRUXFlOVlB?=
 =?utf-8?B?aFlxWllsa3hTUWdpdm5nWmt1Y2NycCtIVW1PNE9DdHl6NG42WlpJOGFTbm1Q?=
 =?utf-8?B?Y0JsRlBRL3R3L2RWM0MzMENUeFlmeW9QZFRFbFlaVlQrNThmNlR3NzNKdXdK?=
 =?utf-8?B?dDk5NWdyTDVPalFTb0lQKytRM3Y4ZFVCcmRhU2FDYmtDQWZ1bWxSM0pTUVk2?=
 =?utf-8?B?Q3BETVlpdFRiTVl3TGsyaGV3bGY3SnMxdDhtL1RrR2NtRmxIZEV1V1EwbUJ5?=
 =?utf-8?B?b2lOZkhKd3k1THF6RXFrVFBEUU4ycUNRdUNQUERZcHRKY25KUkdiSVd0ZkQ3?=
 =?utf-8?B?SHM3VlBwNW90UFhwWE9YNFplU3ZxQzBtT3pJTTZqVy9uNVR5Z3JPbytzOUhr?=
 =?utf-8?B?bGF4S1JMK2UxdGVrVHBIQ0djc3Z5dzFyb25CUzhzODR5UGt0VDRNVE1IT01D?=
 =?utf-8?B?SFVOU1dZZ1BteWtwdzRVWEt0YWlCWTJtYTB1b3hwRU5BQjhleUk2QmU1RUpI?=
 =?utf-8?B?andETnBQL29TUTRibDEwVGhBWmFOMmdvR3FQN1YrYWtuTlJ3U1grWDUySVZI?=
 =?utf-8?B?Z3hmVGl5ZFN4ZFRXS0lJVzVKS0ZXSGhlSFNlV094bEVXQkdwdDdUdmRsa09i?=
 =?utf-8?B?NDlZRWM2dVBySHFIZ0N4aWptT1lvWnFMODVHWndEc00xb25ELzFFbGhTK0RQ?=
 =?utf-8?B?V0xzTTMwaEdCOThjekdFQTMwN2pzL3VBLy9NakdIc0tHMFgvdVF5MG9RZWE1?=
 =?utf-8?B?L0dEb2VqR09MYXB5MFVEWmFxT2JuM1RYOWw4UUxvZFF2QXEwbDlYUjdzV3U4?=
 =?utf-8?B?Ym9Xemk4dngwUFJjSkM1eHhPRnZXb2xDOHJkSU9PVk5nOE5nQ3dHL3lZN2ll?=
 =?utf-8?B?Z256c2xvYUdVWGUzS3BZNlRMVHpZZk9wT1JFZ281QStjZDh5VEZJdmJNbGRa?=
 =?utf-8?B?ZTdydFVHMmNIYnhBVVV1SDVpcFJjdXBCNzFCbGI5cm5wd041OEw0dHFpUkpp?=
 =?utf-8?B?bjZKT3oyZ1lESU9RUDR2ZURTMDQ5bDBHMXFUSW0yUW9iR3VqZCtCR2lIbVhQ?=
 =?utf-8?B?ZGMrUU15SlFzaU9SdUpsSzJSUmhkVm9wR1BvY3Rtamg4TnNJdUsrenM5Z0NB?=
 =?utf-8?B?ZE9YV0N6b2hITzNnckZnLy9SQjdab0svRUJlRTR2NUxXaWhFUHJTQmh2VlNa?=
 =?utf-8?B?OTVrWkVyNGVvK3lla1Q1UUVyb3ZJSzFWMktVa2V2dG1FbjN5T0JqRWxPblNR?=
 =?utf-8?B?WmwzTGRlNGxYZjNseTRIYnJBVHFMTHRsRGhEKzlST0hmbm96OGhMaFBxTjI3?=
 =?utf-8?B?T2d4UmJlR3NrcmtkNEY2OEQxbS9ORTN0aGxqNTVwa3hBTXowcENUbWh4dGkx?=
 =?utf-8?B?bTFIVllpMDErWTdVWHdYYXpSRlRIcFk0N3Z0NVZsa0tGUTJCV0I0Yk5EeitI?=
 =?utf-8?B?dTFueVIwOC9jemFTUWgrM1hoMWxGcmtEWGdrU1RQOVJXSnpva1d1Sm5DT0Fj?=
 =?utf-8?B?SkIycGZSR1NWMWVIWldwQjJDU2pCVkxHdlo1Q3EvK1UvTnEwbGhVeE5jV0dm?=
 =?utf-8?B?MGlpNFNBQW5yNVNvc2RjVnozQytpSWdoSTFISU9lTUN2MnJlNE1YYis3bGJr?=
 =?utf-8?B?U0FqWXBTcE1FUWtzNW5OUnQ2SC9LUGo4RVp6c0grelg3Nmg1TFcvbnpiS2p3?=
 =?utf-8?B?OENlcGxmQUxwOEwxcldrU2lKYWo4dFVibjN2MFZIT01pbnkrOE91YVBlbXcw?=
 =?utf-8?B?dXlMRTlMdnNLNVNSTE5WenVFOTk2M1poaGtZMVRVNnNOWkgvWFpLSjhUTVY0?=
 =?utf-8?B?dWx5ZHNaWCtKWjJYanozb212WEQyQ2FLVGhYelFUbmhpU3c2Z3F1cmhoYU5P?=
 =?utf-8?Q?vu+gV2LGgrooj11QupcoHqdLw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91749a4f-aaba-4649-0c1e-08db244260d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 04:12:51.3710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4ooIF7bQWCrzZ1IKgc8fqgkWZe2wPhTdJodjnZDA+OBR36Mz9RYy9pmneWAuE4gsdpCD7D926+1N3CUETDw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1hcmNoIDEwLCAyMDIzIDExOjE2IEFNDQo+IA0KPiBPbiAzLzkvMjMgNDowOSBQTSwgWWkg
TGl1IHdyb3RlOg0KPiA+IEluIG5lc3RlZCB0cmFuc2xhdGlvbiwgdGhlIHN0YWdlLTEgcGFnZSB0
YWJsZSBpcyB1c2VyLW1hbmFnZWQgYW5kIHVzZWQNCj4gPiBieSBJT01NVSBoYXJkd2FyZSwgc28g
ZGVzdHJveWluZyBtYXBwaW5ncyBpbiB0aGUgc3RhZ2UtMSBwYWdlIHRhYmxlDQo+IHNob3VsZA0K
PiA+IGJlIGZvbGxvd2VkIHdpdGggYW4gSU9UTEIgaW52YWxpZGF0aW9uLg0KPiANCj4gcy9kZXN0
cm95aW5nIG1hcHBpbmdzL3VwZGF0ZSBvZiBhbnkgcHJlc2VudCBwYWdlIHRhYmxlIGVudHJ5Lw0K
DQpSaWdodC4gTm90IG9ubHkgZGVzdHJveWluZy4NCg0KPiA+IFRoaXMgYWRkcyBJT01NVV9IV1BU
X0lOVkFMSURBVEUgZm9yIElPVExCIGludmFsaWRhdGlvbi4NCj4gPg0KPiA+IENvLWRldmVsb3Bl
ZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9t
bXUvaW9tbXVmZC9od19wYWdldGFibGUuYyAgICB8IDU2DQo+ICsrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9pb21tdWZkX3ByaXZhdGUuaCB8ICA5
ICsrKysNCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW9tbXVmZC9tYWluLmMgICAgICAgICAgICB8ICAz
ICsrDQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvaW9tbXVmZC5oICAgICAgICAgICAgfCAyNyAr
KysrKysrKysrKysNCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9od19wYWdldGFibGUuYw0K
PiBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9od19wYWdldGFibGUuYw0KPiA+IGluZGV4IDY0ZTdj
ZjcxNDJlMS4uNjdmYWNjYTk4ZGUxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9t
bXVmZC9od19wYWdldGFibGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9od19w
YWdldGFibGUuYw0KPiA+IEBAIC0yODQsMyArMjg0LDU5IEBAIGludCBpb21tdWZkX2h3cHRfYWxs
b2Moc3RydWN0IGlvbW11ZmRfdWNtZA0KPiAqdWNtZCkNCj4gPiAgIAlpb21tdWZkX3B1dF9vYmpl
Y3QoJmlkZXYtPm9iaik7DQo+ID4gICAJcmV0dXJuIHJjOw0KPiA+ICAgfQ0KPiA+ICsNCj4gPiAr
LyoNCj4gPiArICogc2l6ZSBvZiBwYWdlIHRhYmxlIHR5cGUgc3BlY2lmaWMgaW52YWxpZGF0ZV9p
bmZvLCBpbmRleGVkIGJ5DQo+ID4gKyAqIGVudW0gaW9tbXVfaHdwdF90eXBlLg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGNvbnN0IHNpemVfdCBpb21tdWZkX2h3cHRfaW52YWxpZGF0ZV9pbmZvX3Np
emVbXSA9IHt9Ow0KPiA+ICsNCj4gPiAraW50IGlvbW11ZmRfaHdwdF9pbnZhbGlkYXRlKHN0cnVj
dCBpb21tdWZkX3VjbWQgKnVjbWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBpb21tdV9od3B0X2lu
dmFsaWRhdGUgKmNtZCA9IHVjbWQtPmNtZDsNCj4gPiArCXN0cnVjdCBpb21tdWZkX2h3X3BhZ2V0
YWJsZSAqaHdwdDsNCj4gPiArCXU2NCB1c2VyX3B0cjsNCj4gPiArCXUzMiB1c2VyX2RhdGFfbGVu
LCBrbGVuOw0KPiA+ICsJaW50IHJjID0gMDsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogRm9y
IGEgdXNlci1tYW5hZ2VkIEhXUFQsIHR5cGUgc2hvdWxkIG5vdCBiZQ0KPiBJT01NVV9IV1BUX1RZ
UEVfREVGQVVMVC4NCj4gPiArCSAqIGRhdGFfbGVuIHNob3VsZCBub3QgZXhjZWVkIHRoZSBzaXpl
IG9mDQo+IGlvbW11ZmRfaW52YWxpZGF0ZV9idWZmZXIuDQo+ID4gKwkgKi8NCj4gPiArCWlmIChj
bWQtPmRhdGFfdHlwZSA9PSBJT01NVV9IV1BUX1RZUEVfREVGQVVMVCB8fCAhY21kLQ0KPiA+ZGF0
YV9sZW4gfHwNCj4gPiArCSAgICBjbWQtPmRhdGFfdHlwZSA+PQ0KPiBBUlJBWV9TSVpFKGlvbW11
ZmRfaHdwdF9pbnZhbGlkYXRlX2luZm9fc2l6ZSkpDQo+IA0KPiAiZGF0YV9sZW4gc2hvdWxkIG5v
dCBleGNlZWQgdGhlIHNpemUgb2YgaW9tbXVmZF9pbnZhbGlkYXRlX2J1ZmZlci4iDQo+IA0KPiBI
b3cgaXMgdGhpcyBjaGVja2VkPw0KDQpIbW1tLCB0aGlzIGlzIGEgc3RhbGUgY29tbWVudCBJIHN1
cHBvc2UuDQoNCj4gDQo+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICsNCj4gPiArCWh3
cHQgPSBpb21tdWZkX2dldF9od3B0KHVjbWQsIGNtZC0+aHdwdF9pZCk7DQo+ID4gKwlpZiAoSVNf
RVJSKGh3cHQpKQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKGh3cHQpOw0KPiA+ICsNCj4gPiArCS8q
IERvIG5vdCBhbGxvdyBhbnkga2VybmVsLW1hbmFnZWQgaHdfcGFnZXRhYmxlICovDQo+ID4gKwlp
ZiAoIWh3cHQtPnBhcmVudCkgew0KPiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiArCQlnb3RvIG91
dF9wdXRfaHdwdDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlrbGVuID0gaW9tbXVmZF9od3B0X2lu
dmFsaWRhdGVfaW5mb19zaXplW2NtZC0+ZGF0YV90eXBlXTsNCj4gPiArCWlmICgha2xlbikgew0K
PiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiArCQlnb3RvIG91dF9wdXRfaHdwdDsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogQ29weSB0aGUgbmVlZGVkIGZpZWxkcyBiZWZvcmUg
cmV1c2luZyB0aGUgdWNtZCBidWZmZXIsIHRoaXMNCj4gPiArCSAqIGF2b2lkcyBtZW1vcnkgYWxs
b2NhdGlvbiBpbiB0aGlzIHBhdGguDQo+ID4gKwkgKi8NCj4gPiArCXVzZXJfcHRyID0gY21kLT5k
YXRhX3VwdHI7DQo+ID4gKwl1c2VyX2RhdGFfbGVuID0gY21kLT5kYXRhX2xlbjsNCj4gDQo+IElz
IGl0IGEgdmFsaWQgY2FzZSBpZiAidXNlcl9kYXRhX2xlbiA8IGtsZW4iPw0KDQpZZXMuIGUuZy4g
YW4gb2xkIHFlbXUgcnVubmluZyBvbiBhIG5ldyBrZXJuZWwgd2hpY2ggaGFzIG5ldyBmaWVsZA0K
YWRkZWQgaW4gdGhlIGVuZCBvZiB0aGUgZGF0YSBzdHJ1Y3R1cmUuDQoNClJlZ2FyZHMsDQpZaSBM
aXUNCg==
