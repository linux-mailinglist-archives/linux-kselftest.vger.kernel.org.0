Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAAB6B000C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCHHkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 02:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCHHks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 02:40:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875599AA09;
        Tue,  7 Mar 2023 23:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678261222; x=1709797222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cQ4wLYX6VK9NyL6fAMKIcpVKJBp6M+L3qqi94q4fbWE=;
  b=O7nafdiFb07vn3YssRUp3XFcyFaJUbwHGAcXndClO0etS7cBxR/Vit0/
   kT7QvNollU7V2GMge9AwamYMXVc8cFfbq6UTerr2gmYDYL5ND9Q0x6Sep
   WhDHnoLVs9Nagdq0TGnHFoH2m976Hn4hMOOwLasciRenYJNdwIqR8PD2n
   Uueqkh5yUqeFm4jKbwEIiOQo6TQ7ZY5na3sQaVQ1kYwDHipTEHTR6tgxp
   0PqHxw6tbwwBldhJNFRSqWc+ogPyKAcdobE+q+CtHX9fOEcG+tcpKTmZx
   VcfvD4nclS97TdWJRmwEXl2EhIRZUN2bDwNsk4Tda5C+nXuWwO8JP9emn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324401677"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="324401677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="654248952"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="654248952"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2023 23:38:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:38:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 23:38:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 23:38:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 23:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ400AuKPJpqPCTeTKUgQT6xoII5e/E+CbKTqaOfFb9KT7Epqkb85KS9rPRal81BwurpwEkpqz9yhd5x7O0z/JB6yhybMR/ywr5eYgjMDHBfs9TszMa6k4z6bm3A2hmAmmM34gEAF7zIjSb8trcngNXy8vqr/7Q93TF+hAHj7EmwawUMKVz/9TmNfsPzRJvq/vjByC0W6l5ePMVXWjpCIZXVOLE//zibAiFfh8hXGqa7fh2T4Ds3JvzXqPXgTqKdbeJYjsE3SpM31cuR+cMJno4UExtWNPi1x1v7jCiMM1TC/IxrCXznTa5M4TvWdoxMoRrS0xy9dIWWDEfoTuyWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ4wLYX6VK9NyL6fAMKIcpVKJBp6M+L3qqi94q4fbWE=;
 b=dFTDIzeP0REPuB4Gk/Lbnb6brHlWWEH9XxfW4gYdt1in3VxAivhmzBZ2qEzBWW6vNXrnumu+C5dM/J2Bbi+husNqfjNYAcunhmcQAWj3RammZf2kOgGXJ9vkOCx7CFngsDGUGfo9EvODHggGopHOZyoRbn5DL2hmucRSN5ttT8GOSSMPFL7IscQyaUZE+pyX8CWBGQHDp5knR6uko3nm++/BhZloppYVaeR/kGB7kCecEi5Z9+XyYx48iVwtmJXJDTcFP3aErt7AqqSsS0KIetvGG30RWItjEDNSsWfTS+xYJpSt6G2DXzwGjLww9S7K14KxeLvgMZ7uVeB/x0BsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Wed, 8 Mar 2023 07:38:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 07:38:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Thread-Topic: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Thread-Index: AQHZSLASwwV5g7rlQUi/WXQEXqe0Tq7vCL8AgABLd4CAAOALAIAAWv1Q
Date:   Wed, 8 Mar 2023 07:38:38 +0000
Message-ID: <BN9PR11MB5276580F971F8C90A89F3AF38CB49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAcyEzN4102gPsWC@nvidia.com>
 <d441b9bb-e9b2-190d-981b-1fdc288b0a07@linux.intel.com>
In-Reply-To: <d441b9bb-e9b2-190d-981b-1fdc288b0a07@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6068:EE_
x-ms-office365-filtering-correlation-id: b66d360d-db1d-4695-7798-08db1fa821bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kseolUMhIMWEVpVmmkngi2TPF/O8cakWxdNHM85cRhqjIBHiwTXxgNY2qGWv3eSj0vOkJ+PTZm2tjZysPe8qkb60Kb2sVO67OIxsq09C1jTcT7FnxfgGKavmu3n3ysqq5/lNAroMTSoXPvQZ58glNi4uDLvLZTT4EXHa/NwA8yBRlRBGYE7RutK6aZcvdDu7bTT7+lwKCOV0BxQrE7EE+k8sUZJ7aw3CYOLHhEhD9i24oTB1xz/2ryztIzeg83plw7o8FpR0NZz/ng+HA3WplqaWFzzU7HdC2y621/1c3UVc1KjftV/BSt6I2WBXMqeiePdzirOb6/h4QKNkq+TF/rw3bcHtFq+wPZM8VNvIBnzCs/twIutZWVL1afiM0KMBdT7XJiSBmqK20CsYLFuBAyWC75tJmFLYy0fZpn6Ch7W5NpJjJ2o12ntg7YS7J7QE3g0yqXS98xRHaH7iRL7sXU79d43m+miFIQM3md9YsQ5+twUdTFCBwOOMik/2Hh/3yHzqqoLK109uMqWYVAfjBt+OzJkpKPFRzrQOcPQhrvxaXSUcVR2WKmwv0toKPswI/l3fiphOGtNMJXVTlCOvb+DPyaZ70DuZUnAoTZqj0xCyx49JDA4w706oePpscwV5Pox00eJvpbGC3LeXdHuFnwV3YUGM0C+EgMQpRRK5gZypxq7qzeO+UEeTkfv6E5LSm5iHkCeU+ya8WlfMbX8kpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(41300700001)(71200400001)(54906003)(7696005)(110136005)(83380400001)(316002)(86362001)(4326008)(33656002)(66446008)(76116006)(478600001)(8676002)(66476007)(66556008)(64756008)(8936002)(66946007)(52536014)(53546011)(55016003)(38100700002)(5660300002)(2906002)(122000001)(82960400001)(186003)(9686003)(6506007)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlF6QmVYUFN3b2htYkpodGJsVXkyLzk5VTdPSVZrM0dLTmpKNWp2aHZ0V2Vm?=
 =?utf-8?B?TnFkOHYvMFdWeU9lVFBMT0duVmVWYXBEZlVPR0ZwcS9RaktwYW03U1pKNy9R?=
 =?utf-8?B?SFFYaGRZZTFBb3pnQlc5YVdnMFY1SXM5SStQcHRpdTFuNG5NL01tSkNmb25G?=
 =?utf-8?B?UzJGOWZYWmlYSkhvRGJwTzBPcmlON3VpcWRDQXBQNmZueTgvR00yWDNpUVlE?=
 =?utf-8?B?UG5tMU9Nb1g4QVhTZDdLbVk2dm91ai81QkZTQ3kvb3dGMWlJT1Q2QWRtakZB?=
 =?utf-8?B?UVVHd0oyYVl1L3MvV3BuYUpJdzBkbHJnOHZPOEJyR0FlL3ArVm90VGxQTS9j?=
 =?utf-8?B?VEJma3E5QjNJelRuUzI4eEN1OWZVVXBsZHRkUGdrTzRqdWQyWTlQNk9tbjBT?=
 =?utf-8?B?Q0sxNTU1UnJKUFlOYmQrMG5mVjArWDRXbXlFellsZUZ0ZlVjem54QzhiWFJR?=
 =?utf-8?B?Skx5U08yTW9GMWwzUGdLbEp0M2RqSm5KTWl0UC94Ny84WjUyVkVqQVJBZ3hi?=
 =?utf-8?B?VGZMenBCa3lSTkpodGJ5K1QrREE1dDNJSmRwYVg2elV3VTlHN3Qrbkg3NzFw?=
 =?utf-8?B?WTBoenhVaS90TW0vcnY4eGJtQ0N6V2tRNTFqUlE5aW44WFVVVjVjWlo2aklQ?=
 =?utf-8?B?K0xsWXE0REg3Ukd3REdQbmtUZVZENmFhQlFtdDQ5RlpVS25panJaSlJrYWpz?=
 =?utf-8?B?bVdPdzF5LzBCQ2RKeG82dkVlaDE0U1kvbDVOejZZOXNEbitwUEVuT1ZZZzVi?=
 =?utf-8?B?QldRR2hXUmF6MGtqVVV2bW9zODRGdUlUN2JudDZvU2s4Y1I3QTBBTXBOejRw?=
 =?utf-8?B?K042UnJjV2xCeWJTbnhnaXpRMWtQM3lNcTNVZWEraDlCbFlmVXlqZklTN0I4?=
 =?utf-8?B?c014MzRCOVZCQzJ3OE5aVk9Nd0F5ZDQ2bEVSa1dpMUQwYzlCdW05V1dmTjlH?=
 =?utf-8?B?QnhFZzAzV29JbG90a2VkQzIyZXY3cWMxVVcyT2hMQVJsTE93emkxNGllQU93?=
 =?utf-8?B?dzV1TUR0TmtPdFVQdHU1b29MOUJ3UklQa1ZzUU1XWHJzRi9ROGtHNFFDVDV3?=
 =?utf-8?B?R0grNU82L1pncnFUOVRoNjk2Zm9hQmdYUml3NHUwLzRzTURvZ2ZrOExvV1hW?=
 =?utf-8?B?UUk5WFhNQkd3T0xLWDNUS1hURW1IWEU2SjIyOSthd0dFWEpLNDY3YlprSmxz?=
 =?utf-8?B?V04yOE8xQUV6Nm9jYnBQK01kdk5sVStIMXM2N2Ryb0xSZzkyWnB3NmNIVTVw?=
 =?utf-8?B?MzgwTGxES2JUTXFXc3lCRzZaWDRHay82YmdNZ2I3YzZTZWZCcXF4eCtlUjNi?=
 =?utf-8?B?R05UbmpLaEdoNi9QVWZ6b2xnTHJBMmxVWWRLbGFCek94VDlGRzV3cldMWkRH?=
 =?utf-8?B?SWlkWGpLdmVzTEJMNm82U0syYXliczlMWFlkZSs3RWRYTFVuWlRBSE1UVmZq?=
 =?utf-8?B?TG9wUXJpWFJOdUtMUzRmaDJnbnFCL2ZGbFFENWl2SE9MK1dBK2o3MG54VEQ1?=
 =?utf-8?B?dHVCekExdEpYVCtjaDBhdzgwdFFWbWJKNmxibGVTd01ubW12V2ZlNzhLdDJu?=
 =?utf-8?B?RlYza2svY0pub3Fad1dRQncwYjB5TlQ0Y2NYUzZJOHVyTEhCU3NSUDQvWmtH?=
 =?utf-8?B?NWt5WS9uVE1FNllXYkFxOTJZOTdWSzk2Ym1qZ2JseEFEVkFSR2Q4NmVXYVdS?=
 =?utf-8?B?Uk9leVVxSVFlUlRrZEpkcnhDN0RVbnJvZlhMTCtyaWxnS1FTR3VoNmlGWGhU?=
 =?utf-8?B?V3E3NEpiTVBXMGt2a2ZHT1hyTWJtaDRUT0dQaUdybzdYSy9OaTlwWFJxUjJT?=
 =?utf-8?B?cHNCQlA2MUF3YnJtRmNkczI4aEg1NWo3aHR2emlrYXFETjYxazJ0L1dXK0FL?=
 =?utf-8?B?RW4rb2k1K2dsOVhBYzBmaWx1OWZIWmNRVUZFLzZwMUZVV2ZicTdFY01SOGxm?=
 =?utf-8?B?aVJPUWNTYXQ2SC9qZG9PMWhYV0srL3cvTW1OQ0Z4UnRlakNKN0hybHl5QmFo?=
 =?utf-8?B?Q2p0NmlvN0M5eFkrS2p3Wk8vMExXemw2NEVZem5IelIwZkV6R1c3Q2tSbEpD?=
 =?utf-8?B?RFozb044Q2grV3Y0LzV6LzNsU3hWdUFxMlQzWThQZE5zb0FVOFk5UkIwRncr?=
 =?utf-8?Q?cp7RIwIv787xzoZHHUmU5tAHJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66d360d-db1d-4695-7798-08db1fa821bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 07:38:38.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgEX79r1iCfyll2uSmhLJU3ulOcE5ZWTazUcGita4a76NVGCLEE+ja1IodwsbyqHC5+OkxKH8P2xt2pAeXIlbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1hcmNoIDgsIDIwMjMgMTA6MDggQU0NCj4gDQo+IE9uIDMvNy8yMyA4OjQ2IFBNLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXIgMDcsIDIwMjMgYXQgMDg6NDI6
MDZBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBKYXNvbiBHdW50aG9y
cGU8amdnQG52aWRpYS5jb20+DQo+ID4+PiBTZW50OiBTYXR1cmRheSwgRmVicnVhcnkgMjUsIDIw
MjMgODoyOCBBTQ0KPiA+Pj4NCj4gPj4gWy4uLl0NCj4gPj4+IFRoZSBpbXBsZW1lbnRhdGlvbiBp
cyBjb21wbGljYXRlZCBiZWNhdXNlIHdlIGhhdmUgdG8gaW50cm9kdWNlIHNvbWUNCj4gPj4+IHBl
ci1pb21tdV9ncm91cCBtZW1vcnkgaW4gaW9tbXVmZCBhbmQgcmVkbyBob3cgd2UgdGhpbmsgYWJv
dXQNCj4gbXVsdGktDQo+ID4+PiBkZXZpY2UNCj4gPj4+IGdyb3VwcyB0byBiZSBtb3JlIGV4cGxp
Y2l0LiBUaGlzIHNvbHZlcyBhbGwgdGhlIGxvY2tpbmcgcHJvYmxlbXMgaW4gdGhlDQo+ID4+PiBw
cmlvciBhdHRlbXB0cy4NCj4gPj4+DQo+ID4+IE5vdyB0aGluayBhYm91dCB0aGUgcGFzaWQgY2Fz
ZS4NCj4gPj4NCj4gPj4gcGFzaWQgYXR0YWNoIGlzIG1hbmFnZWQgYXMgYSBkZXZpY2Ugb3BlcmF0
aW9uIHRvZGF5Og0KPiA+PiAJaW9tbXVfYXR0YWNoX2RldmljZV9wYXNpZCgpDQo+ID4+DQo+ID4+
IEZvbGxvd2luZyBpdCBuYXR1cmFsbHkgd2UnbGwgaGF2ZSBhIHBhc2lkIGFycmF5IHBlciBpb21t
dWZkX2RldmljZSB0bw0KPiA+PiB0cmFjayBhdHRhY2hlZCBIV1BUIHBlciBwYXNpZC4NCj4gPj4N
Cj4gPj4gQnV0IGludGVybmFsbHkgdGhlcmUgaXMgb25seSBvbmUgcGFzaWQgdGFibGUgcGVyIGlv
bW11IGdyb3VwLiBpLmUuIHNhbWUNCj4gPj4gc3RvcnkgYXMgUklEIGF0dGFjaCB0aGF0IG9uY2Ug
ZGV2MSByZXBsYWNlcyBod3B0IG9uIHBhc2lkMSB0aGVuIGl0IHRha2VzDQo+ID4+IGVmZmVjdCBv
biBhbGwgb3RoZXIgZGV2aWNlcyBpbiB0aGUgc2FtZSBncm91cC4NCj4gPiBJTUhPIEkgY2FuJ3Qg
YmVsaXZlIHRoYXQgYW55IGFjdHVhbCBzeXN0ZW1zIHRoYXQgc3VwcG9ydCBQQVNJRCBoYXZlIGEN
Cj4gPiBSSUQgYWxpYXNpbmcgcHJvYmxlbSB0b28uDQo+ID4NCj4gPiBJIHRoaW5rIHdlIHNob3Vs
ZCBmaXggdGhlIGlvbW11IGNvcmUgdG8gbWFrZSBQQVNJRCBwZXItZGV2aWNlIGFuZA0KPiA+IHJl
cXVpcmUgc3lzdGVtcyB0aGF0IGhhdmUgYSBSSUQgYWxpYXNpbmcgcHJvYmxlbSB0byBibG9jayBQ
QVNJRC4NCj4gPg0KPiA+IFRoaXMgaXMgYSBiaWdnZXIgcGljdHVyZSwgaWYgZHJpdmVycyBoYXZl
IHRvIG9wdGlvbmFsbHkgc2hhcmUgdGhlaXINCj4gPiBQQVNJRCB0YWJsZXMgd2l0aCBvdGhlciBk
cml2ZXJzIHRoZW4gd2UgY2FuJ3QgaGF2ZSBwZXItZHJpdmVyIFBBU0lEDQo+ID4gYWxsb2NhdG9y
cyBhdCBhbGwgZWl0aGVyLg0KPiANCj4gVGhpcyBpcyBhY3R1YWxseSByZXF1aXJlZCBpbiBQQ0kg
YW5kIElPTU1VIGNvcmUuIHBjaV9lbmFibGVfcGFzaWQoKQ0KPiByZXF1aXJlcyBmdWxsIEFDUyBz
dXBwb3J0IG9uIGRldmljZSdzIHVwc3RyZWFtIHBhdGg6DQo+IA0KPiAgICAgICAgIGlmICghcGNp
X2Fjc19wYXRoX2VuYWJsZWQocGRldiwgTlVMTCwgUENJX0FDU19SUiB8IFBDSV9BQ1NfVUYpKQ0K
PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiANCj4gYW5kLCBmb3Igc3VjaCBQ
Q0kgdG9wb2xvZ3ksIGlvbW11IGNvcmUgYWx3YXlzIGFsbG9jYXRlcyBhbiBleGNsdXNpdmUNCj4g
aW9tbXUgZ3JvdXAuDQo+IA0KPiBUaGUgb25seSBwbGFjZSB3aGVyZSBzZWVtcyB0byBiZSBhIGxp
dHRsZSBtZXNzeSBpcywNCj4gDQo+IHN0YXRpYyBpbnQgX19pb21tdV9zZXRfZ3JvdXBfcGFzaWQo
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLCBpb2FzaWRfdA0KPiBwYXNpZCkN
Cj4gew0KPiAgICAgICAgICBzdHJ1Y3QgZ3JvdXBfZGV2aWNlICpkZXZpY2U7DQo+ICAgICAgICAg
IGludCByZXQgPSAwOw0KPiANCj4gICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShkZXZpY2Us
ICZncm91cC0+ZGV2aWNlcywgbGlzdCkgew0KPiAgICAgICAgICAgICAgICAgIHJldCA9IGRvbWFp
bi0+b3BzLT5zZXRfZGV2X3Bhc2lkKGRvbWFpbiwgZGV2aWNlLT5kZXYsDQo+IHBhc2lkKTsNCj4g
ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgIHJldHVybiByZXQ7DQo+IH0NCj4NCg0K
eWVzLCB0aGlzIGlzIGV4YWN0bHkgd2hlcmUgbXkgY29uZnVzaW9uIGNvbWVzLiBJIHRob3VnaHQg
d2UgZXZlciBhZ3JlZWQNCnRoYXQgUEFTSUQgdXNhZ2Ugd29uJ3QgYmUgc3VwcG9ydGVkIG9uIG11
bHRpLWRldmljZXMgZ3JvdXAuIFRoZW4gSSBzYXcNCmFib3V0IGNvZGUgKGJ1dCBkaWRuJ3QgY2F0
Y2ggdGhlIGltcGxpY2F0aW9uIG9mIHBjaSBhY3MpIHdoaWNoIGxlZCBtZSB0bw0KdGhpbmsgYWJv
dXQgdGhlIGdyb3VwIG1lc3MuDQoNCnN0aWNraW5nIHRvIHBlci1kZXZpY2UgcGFzaWQgd291bGQg
Y2VydGFpbmx5IHNpbXBsaWZ5IHRoZSBsb2dpYyBpbiBpb21tdWZkLiDwn5iKDQogDQo+IFBlcmhh
cHMgd2UgbmVlZCBhIGNoZWNrIG9uIHNpbmdsZXRvbiBncm91cD8NCj4gDQoNCm9yIG1vdmUgdGhl
IHhhcnJheSB0byBkZXZpY2U/IFN0b3JpbmcgaXQgaW4gZ3JvdXAgd2hpbGUgYWRkaW5nIGEgc2lu
Z2xldG9uDQpyZXN0cmljdGlvbiBvbmx5IGNhdXNlcyBjb25mdXNpb24uDQo=
