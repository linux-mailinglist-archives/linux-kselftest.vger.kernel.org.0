Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3E3693F94
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBMI1w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 03:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBMI1v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 03:27:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E630E8;
        Mon, 13 Feb 2023 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676276870; x=1707812870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gtSH4k7xXyY9b9utUK7q19aM5ZUYIV1t3PX1xdu4qLU=;
  b=HFsbv8yxSEXzhcr8xEFuqwdnWWrQFFScsQhtXhcru3xL+yKRec7qoRZr
   nmeaJlKaF8aLh8JYRDOAJW2GU/bE3YYUw2897KIVO2APBcVrbJ5Rkzvjo
   mK1dahSyNwADo2VLGg0RYEzUkuTHWoaEP+3MYQgCoxUsf53qS16yHRkin
   qBrfK0iI1WWpO2YKkxemJPqdPqhipN040mi7aXoV6shCvpqGROsUz5V5v
   3efIkhlPCFZW99K3Ee3gVVzNAaZ5tHTO66Tt8LtTM8K5Y0kjlY+dXc033
   CatrSUqnT5fe3+2ByCZYC0WoHfBsn7gf5jx1V3GL6f18RcEBTelUfipAq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="393238323"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="393238323"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="668732518"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="668732518"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 00:27:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 00:27:48 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 00:27:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 00:27:48 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 00:27:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8sVbxq0ZNchbp6RmBv7LU3SF152lJ69ZC7dIFHwFabbgBWCeucFZ7/2V4LNHA+9OueLNRuyfJpbnGXGsd9Krq/E8MV1O2rpWTsP5Ok9AdhOyCFx/KajtXCGOlnQ9A3b7h7RjqDINjLQsZXr4Y9pAag6AsAJU9xe4U3fPrKmZVa8n1LGxZOCPaIwZAZy4rZAc9x09DN52b6y3Hi/DEgCIAek4pZnvQljFRP0NNHbkftpmNfLJxsvmW2bIx3QAYcO5LmsEYMev1qCx+GbcrykJwwVWVu19VSBpG29rSuyJ5NgFN9XyFGAPyJTdmcWrZZTguYZzhTKMi49ngaZ3rZdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtSH4k7xXyY9b9utUK7q19aM5ZUYIV1t3PX1xdu4qLU=;
 b=PPKmooK6Dzg++0qkH0eC83o7EUGehprCvdyxRf/xg5+Mds8bAmJPTMMKtOP8INaAqHmm0uSLKY7zDdWucmvc0rzSVMFgp1ugKnS5NuDH6NOL0IHO6TCYieN0RfIWKmmQBaG/WceriD8wC++LEPMht6If+fOupTmNvS7DnSFcqhYvwKQOU2kfPsgNMxC4eazv+CrnFWr3+UQ0oyMnXKFkVKHpxlx3XqFDAMsjDkkP3DwUgjWKTV5KEt6kKwXCU7aBJpb8CGTd1P/cX2m7qt1ItbW6zBfMdwP7r9GzQoS4/eZdb667VuSu4gO5yjbr2N/gJ4zCBuaRZqIRozKQNhNkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 08:27:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 08:27:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIABdh8AgANLy2CAAFjcAIAACHxw
Date:   Mon, 13 Feb 2023 08:27:46 +0000
Message-ID: <BN9PR11MB5276203D3FF185C9F19034838CDD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
In-Reply-To: <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6085:EE_
x-ms-office365-filtering-correlation-id: 689abf27-84a9-4792-d1cf-08db0d9c2f38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6iXg7cOkF7AinRN37VNqeNtfM8VXjT0oMuiNkUMECIEqp9BSOFMvlhWcoNBhwYXVIghildpW7dYlCfJCfhgzzDkXH8HLGsE+u9hA3gjCQMmisTNHCSHVLDrcl9hrqSEFRl1r4Wm0uJBd6HqKeTSD/HhXcr6phI/OZgDDFCNgdlHUYR0GrYPiedX4nDPjB3xQSDefhl5jqYdFaGSLnlAFH8VUDwHRITZyjiMYY79FYNo9lfl3Ig42OqQIB8dFnaJb7GqH+yQklnSH4OJDWSXAKcDdsrNLviDU+axDpHAFzuEHaoYump25aOb2Pk0ke8BDi1w+VgNZ6/V168qoHQIoQPX21KzNp11f2h7uXYmGZPBGO/kjWJXmWRvIO3Md7U1XcD0Q8CkkfBzpi967LrXx03NGO7vNYcON1DhtWPnBVtdQNfhjWss9ec8WkM2LjksOP9yq+yoDfn/lQChJhfd26WsFWxjjYXMDEfL4GgIed4ZatRenGTtkJNaMBr68Axn/6aV2JdHvYKNjO5lx9LeEH79t2tuB8W2DcPuAYsNq8rsjhun4d1zLHiIdMEkYJZdtta/nxUfQpViKlwMlq/7YfbmZ+tMB/KhAUU4hQhb2axXLG6TgRqvhS5ivB5gS8Ak3IUs/wcqWLWhpyRUUJ0c76BOzTdTPwwtl8PZywPbCCLuMWqz/TP4WSdVcRkxHGTEcKda13Ab5/R+R77foWKmhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(76116006)(66946007)(8676002)(4326008)(71200400001)(122000001)(54906003)(316002)(86362001)(33656002)(26005)(186003)(9686003)(6506007)(38070700005)(55016003)(38100700002)(41300700001)(7416002)(66556008)(478600001)(7696005)(2906002)(6916009)(82960400001)(66476007)(5660300002)(64756008)(8936002)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a29Hb0hEd0JhM0dMdzVTdXVFSHd6MmdkNzdXMU95am54RnpQYkNCZkdCTnZD?=
 =?utf-8?B?RTY1alg4TC9sU0x4anJaMHI0VzEzSFdONWY4TGhCeEU0VnM2OUZRQkRENGNB?=
 =?utf-8?B?S25qVit5RVBUV0kvVUdST09wMy9HR0h6Zjh2VUZvL3IrbG83bHlGclY4MWpm?=
 =?utf-8?B?dGNZTDVIc25vRmkxTGlGVmlDMi8wUWYzbW9ZSndjNlB2bEJ0V3kxdW1rbGtW?=
 =?utf-8?B?dTVMUEpmSzF4REpqaWxnaXdEeXNIRWozK1hBdU5Ha2tkbjIwK3ZQTUE0Q3dS?=
 =?utf-8?B?cGhtVDB2TVJPRUpYRjMwWEs5Wlo4TlhuakxtMWh3K09MNzVCTWNNZjZlc0Zu?=
 =?utf-8?B?UitPd0Exc2pWd29mMlVtM05XV0kzanhaLzdkcTFhQTNuRjZneGJEL0ZYcU5k?=
 =?utf-8?B?RnQzQkt0UG4wVW94S0lPd1VpWlJJQ0RCZkVsaUU1MEtBK0dKbFRGWVpSMUtH?=
 =?utf-8?B?YXBkTnRLdzJYVXFhZ01YeFBLNlJaWk50U05Na3pXMmtIRHpxWlhKM2s3MWRr?=
 =?utf-8?B?MGJJS2s3Unh4akJtNTVYU2x3YzBaeVJ1RDFuYkVUS1F3bUp0UTZCMzhrQkNy?=
 =?utf-8?B?VXRQMXp3YTNZNmQ1MW5XcmdnSTZMSFBZRk5hSWs5K3o3YW9qQ3J2NENzeTBs?=
 =?utf-8?B?TTNHb1RTR0tyWGZmNG43M3ZpRmxTMU4veXVNeVd3a1VZWmJNYkVESFJoSWF0?=
 =?utf-8?B?aUoxVEhkZE9yK05lRldxdGdvNk83ZlhaYWk5RzZMelk2dGUzc0tWcGVDdWUv?=
 =?utf-8?B?N21XMVYyM2oxWS9MT2xEWWU2VFdKOWlOTHhCeG5ScFBGVUxONG5ZZG15YjZO?=
 =?utf-8?B?UDAxY01mTjVGTnMzbWxCL1UzZE1VSDFBL1gvbThHd1hVeWxpbS83UHYzcVRH?=
 =?utf-8?B?U0F5RGJuZ0RvRTNTN05YOGoxcFZ2Q1k5c0dOSU1vMFRkZ08yaU05V0NTNWhQ?=
 =?utf-8?B?dDNjRlhKQjFJNUpjVVozWUc0bnBXOWNsQ0VQNllqWklmK0REeUFCbjVsWG4y?=
 =?utf-8?B?K0pGQWpnSTk4b01INENVdEJDQ1ZhNC9Zbk5ESFJwbUpIRU9QZzZURWkxbm0v?=
 =?utf-8?B?b2VmbXNUQjZEalJkMXdiSTBab2ZRVkpYWndUVjZpQTg4QkFRUFlQVGtlS2Rh?=
 =?utf-8?B?T1FPOTkrdVhZMnl4YWl5TXgzczgxNWp5eHRYTnhqWDJjdDVhbEZENGs5K0tB?=
 =?utf-8?B?QTJ6ZCtSSEVsamowZCtXMW5JRURVbGE5ZUZ6dXZpVUFwWVdZdG5EZzdlb2Za?=
 =?utf-8?B?VlhaUnJMWWZRUWNRRmpzeitiU3Izd0tRUWV5OFBWd05GN2xYM2RFUUhjeTUz?=
 =?utf-8?B?ZGg2RGIyZWxJSGlzS3pSM2Y3eFY4TDNSU0I1ajh4eXJQS1JGc3Zra3g4OEJZ?=
 =?utf-8?B?WStGeWtmV2pGTlo4T3oxSXlaQ0tHMzVYWFVHRzJyS0ovd0hHalZKSVpqYXdH?=
 =?utf-8?B?cFBzdktIdE9nM3Zlbmd1RExvdmlZUE5ST0tuOEcwbGlzNEI4azF2Mm5jV2pC?=
 =?utf-8?B?VnhXWUY2UGRXTTc5elYyQVRrZ3RoYWJyWE5wQWhVSmVHemFLMGtMTkFRVmgv?=
 =?utf-8?B?Y1ZvWVhta3NlZXE0NUZuN0JOTXMzV1UrOVV5Q3NLSVJ6Rm03S3Yzc0pHdTZN?=
 =?utf-8?B?cDNWYlJzWldLUWVrWmU5WUNuK3pyVUtqTUJQcjZPeHFmQlcxdExJRVowRER3?=
 =?utf-8?B?dUFxQmpOellVLzJXeFlyQmxReVAvRlVZRVluM3JsWkpSWElGN252M0hHT1FO?=
 =?utf-8?B?UUI4ZGxnS1BMbWZYeWpBTVpjTi9oS3JCYnpHY3JmQkJMNFV6YnhUeUsxTDV2?=
 =?utf-8?B?YWdaZ21IcXJGSXAwTHhZV0VTWVNUVVNzMUlpaFI1OVdNUFNTS2x4NEg3N3dC?=
 =?utf-8?B?eDliNG9Qa0NPQjZSQmxPY0ZqYWxNWWJVM05hUGhNQld2cjR6ajN3SEVlZWtR?=
 =?utf-8?B?MWt0VlVQMC9RVTk2Wi93L2NOS2xUZTVCOFdXNE1EcU9xMGE1S1RKQnp4UWpN?=
 =?utf-8?B?eGI3c2IvVHlLRnJORldFSGpiNERoM1hvR3pWRnJLeDAwK09MSVYwcXdxdGVE?=
 =?utf-8?B?dTU3UWVSWUFwNGRFa05kV1doUXZrZUVsZjh6T0M4WUMwdTV5YXJ2SUdhZmho?=
 =?utf-8?Q?Lxukb5Y3METTGQ6OLV/m5R/92?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689abf27-84a9-4792-d1cf-08db0d9c2f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 08:27:46.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psQFZtfvWqrxGSYvGQZeG9HEzCyrrBdLj/I+22wmj48QTJypUK0PIX0s3KRkfl/hz5uFCW9v5JaH7PR8v6jBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgRmVicnVhcnkgMTMsIDIwMjMgMzo0OSBQTQ0KPiANCj4gT24gTW9uLCBGZWIgMTMsIDIwMjMg
YXQgMDI6MzQ6MThBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPg0KPiA+DQo+
ID4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50
OiBTYXR1cmRheSwgRmVicnVhcnkgMTEsIDIwMjMgODoxMCBBTQ0KPiA+ID4NCj4gPiA+IE9uIEZy
aSwgRmViIDEwLCAyMDIzIGF0IDAyOjExOjIzQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0K
PiA+ID4NCj4gPiA+ID4gPiA+ID4gKyAgICAgaWYgKCFpb21tdWZkX2h3X3BhZ2V0YWJsZV9oYXNf
Z3JvdXAoaHdwdCwgaWRldi0+Z3JvdXApKSB7DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAg
aWYgKGxpc3RfZW1wdHkoJmh3cHQtPmRldmljZXMpKSB7DQo+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBpb3B0X3RhYmxlX3JlbW92ZV9kb21haW4oJmh3cHQtPmlvYXMtPmlvcHQs
DQo+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaHdwdC0+ZG9tYWluKTsNCj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
IGxpc3RfZGVsKCZod3B0LT5od3B0X2l0ZW0pOw0KPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAg
IH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJJ20gbm90IHN1cmUgaG93IHRoaXMgY2FuIGJl
IGZ1bGx5IHNoYXJlZCBiZXR3ZWVuIGRldGFjaCBhbmQNCj4gcmVwbGFjZS4NCj4gPiA+ID4gPiA+
IEhlcmUgc29tZSB3b3JrIGUuZy4gYWJvdmUgbmVlZHMgdG8gYmUgZG9uZSBiZWZvcmUgY2FsbGlu
Zw0KPiA+ID4gPiA+ID4gaW9tbXVfZ3JvdXBfcmVwbGFjZV9kb21haW4oKSB3aGlsZSBvdGhlcnMg
Y2FuIGJlIGRvbmUNCj4gYWZ0ZXJ3YXJkcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgaW9w
dF90YWJsZV9yZW1vdmVfZG9tYWluL2xpc3RfZGVsIGlzIHN1cHBvc2VkIHRvIGJlIGRvbmUgaW4N
Cj4gPiA+ID4gPiB0aGUgaHdwdCdzIGRlc3Ryb3koKSBhY3R1YWxseS4gV2UgY291bGRuJ3QgbW92
ZSBpdCBiZWNhdXNlIGl0J2QNCj4gPiA+ID4gPiBuZWVkIHRoZSBuZXcgZG9tYWluX2FsbG9jX3Vz
ZXIgb3AgYW5kIGl0cyBpbXBsZW1lbnRhdGlvbiBpbiBBUk0NCj4gPiA+ID4gPiBkcml2ZXIuIE92
ZXJhbGwsIEkgdGhpbmsgaXQgc2hvdWxkIGJlIHNhZmUgdG8gcHV0IGl0IGJlaGluZCB0aGUNCj4g
PiA+ID4gPiBpb21tdV9ncm91cF9yZXBsYWNlX2RvbWFpbigpLg0KPiA+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IE15IGNvbmZ1c2lvbiBpcyB0aGF0IHdlIGhhdmUgZGlmZmVyZW50IGZsb3dzIGJl
dHdlZW4gZGV0YWNoL2F0dGFjaA0KPiA+ID4gPiBhbmQgcmVwbGFjZS4NCj4gPiA+ID4NCj4gPiA+
ID4gdG9kYXkgd2l0aCBzZXBhcmF0ZSBkZXRhY2grYXR0YWNoIHdlIGhhdmUgZm9sbG93aW5nIGZs
b3c6DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgUmVtb3ZlIGRldmljZSBmcm9tIGN1cnJlbnQg
aHdwdDsNCj4gPiA+ID4gICAgICAgICBpZiAobGFzdF9kZXZpY2UgaW4gaHdwdCkgew0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgUmVtb3ZlIGh3cHQgZG9tYWluIGZyb20gY3VycmVudCBpb3B0Ow0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGxhc3RfZGV2aWNlIGluIGdyb3VwKQ0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBkZXRhY2ggZ3JvdXAgZnJvbSBod3B0IGRvbWFpbjsN
Cj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgaWYgKGZpcnN0IGRl
dmljZSBpbiBncm91cCkgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgYXR0YWNoIGdyb3VwIHRv
IG5ldyBod3B0IGRvbWFpbjsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGlmIChmaXJzdF9kZXZp
Y2UgaW4gaHdwdCkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQWRkIGh3cHQgZG9t
YWluIHRvIG5ldyBpb3B0Ow0KPiA+ID4gPiAgICAgICAgIEFkZCBkZXZpY2UgdG8gbmV3IGh3cHQ7
DQo+ID4gPiA+DQo+ID4gPiA+IGJ1dCByZXBsYWNlIGZsb3cgaXMgZGlmZmVyZW50IG9uIHRoZSBk
ZXRhY2ggcGFydDoNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBpZiAoZmlyc3QgZGV2aWNlIGlu
IGdyb3VwKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICByZXBsYWNlIGdyb3VwJ3MgZG9tYWlu
IGZyb20gY3VycmVudCBod3B0IHRvIG5ldyBod3B0Ow0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
aWYgKGZpcnN0X2RldmljZSBpbiBod3B0KQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBBZGQgaHdwdCBkb21haW4gdG8gbmV3IGlvcHQ7DQo+ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4g
Pg0KPiA+ID4gPiAgICAgICAgIFJlbW92ZSBkZXZpY2UgZnJvbSBvbGQgaHdwdDsNCj4gPiA+ID4g
ICAgICAgICBpZiAobGFzdF9kZXZpY2UgaW4gb2xkIGh3cHQpDQo+ID4gPiA+ICAgICAgICAgICAg
ICAgICBSZW1vdmUgaHdwdCBkb21haW4gZnJvbSBvbGQgaW9wdDsNCj4gPiA+ID4NCj4gPiA+ID4g
ICAgICAgICBBZGQgZGV2aWNlIHRvIG5ldyBod3B0Ow0KPiA+ID4NCj4gPiA+IE9oLi4uIHRoaW5r
aW5nIGl0IGNhcmVmdWxseSwgSSBzZWUgdGhlIGZsb3cgZG9lcyBsb29rIGEgYml0IG9mZi4NCj4g
PiA+IFBlcmhhcHMgaXQncyBiZXR0ZXIgdG8gaGF2ZSBhIHNpbWlsYXIgZmxvdyBmb3IgcmVwbGFj
ZS4NCj4gPiA+DQo+ID4gPiBIb3dldmVyLCBJIHRoaW5rIHNvbWV0aGluZyB3b3VsZCBiZSBzdGls
bCBkaWZmZXJlbnQgZHVlIHRvIGl0cw0KPiA+ID4gdHJpY2t5IG5hdHVyZSwgZXNwZWNpYWxseSBm
b3IgYSBtdWx0aS1kZXZpY2UgaW9tbXVfZ3JvdXAuDQo+ID4gPg0KPiA+ID4gQW4gaW9tbXVfZ3Jv
dXBfZGV0YWNoIGhhcHBlbnMgb25seSB3aGVuIGEgZGV2aWNlIGlzIHRoZSBsYXN0IG9uZQ0KPiA+
ID4gaW4gaXRzIGdyb3VwIHRvIGdvIHRocm91Z2ggdGhlIHJvdXRpbmUgdmlhIGEgREVUQUNIIGlv
Y3RsLCB3aGlsZQ0KPiA+ID4gYW4gaW9tbXVfZ3JvdXBfcmVwbGFjZV9kb21haW4oKSBoYXBwZW5z
IG9ubHkgd2hlbiB0aGUgZGV2aWNlIGlzDQo+ID4gPiB0aGUgZmlyc3Qgb25lIGluIGl0cyBncm91
cCB0byBnbyB0aHJvdWdoIHRoZSByb3V0aW5lIHZpYSBhbm90aGVyDQo+ID4gPiBBVFRBQ0ggaW9j
dGwuIEhvd2V2ZXIsIHdoZW4gdGhlIGZpcnN0IGRldmljZSBkb2VzIGEgcmVwbGFjZSwgdGhlDQo+
ID4gPiBjbGVhbnVwIHJvdXRpbmUgb2YgdGhlIG9sZCBod3B0IGlzIGEgTk9QLCBzaW5jZSB0aGVy
ZSBhcmUgc3RpbGwNCj4gPiA+IG90aGVyIGRldmljZXMgKHNhbWUgZ3JvdXApIGluIHRoZSBvbGQg
aHdwdC4gQW5kIHR3byBpbXBsaWNhdGlvbnMNCj4gPiA+IGhlcmU6DQo+ID4gPiAxKSBBbnkgb3Ro
ZXIgZGV2aWNlIGluIHRoZSBzYW1lIGdyb3VwIGhhcyB0byBmb3JjaWJseSBzd2l0Y2ggdG8NCj4g
PiA+ICAgIHRoZSBuZXcgZG9tYWluLCB3aGVuIHRoZSBmaXJzdCBkZXZpY2UgZG9lcyBhIHJlcGxh
Y2UuDQo+ID4gPiAyKSBUaGUgYWN0dWFsIGh3cHQgY2xlYW51cCBjYW4gb25seSBoYXBwZW4gYXQg
dGhlIGxhc3QgZGV2aWNlJ3MNCj4gPiA+ICAgIHJlcGxhY2UgY2FsbC4NCj4gPiA+DQo+ID4gPiBU
aGlzIGFsc28gbWVhbnMgdGhhdCBrZXJuZWwgaGFzIHRvIHJlbHkgb24gdGhlIGludGVncml0eSBv
ZiB0aGUNCj4gPiA+IHVzZXIgc3BhY2UgdGhhdCBpdCBtdXN0IHJlcGxhY2UgYWxsIGFjdGl2ZSBk
ZXZpY2VzIGluIHRoZSBncm91cDoNCj4gPiA+DQo+ID4NCj4gPiBKYXNvbiBzdWdnZXN0ZWQgdG8g
bW92ZSBod3B0IGNsZWFudXAgb3V0IG9mIHRoZSBkZXRhY2ggcGF0aA0KPiA+IGluIGhpcyByZXBs
eSB0byBwYXRjaDcuIFByZXN1bWFibHkgd2l0aCB0aGF0IGZpeCB0aGUgbWFqb3IgdHJpY2t5DQo+
ID4gcG9pbnQgYWJvdXQgaHdwdCBpbiBmb2xsb3dpbmcgc2NlbmFyaW9zIHdvdWxkIGRpc2FwcGVh
ci4gTGV0J3MNCj4gPiBzZWUgaG93IGl0IHdpbGwgd29yayBvdXQgdGhlbi4g8J+Yig0KPiANCj4g
V2hhdCBhYm91dCBwb2ludCAxPyBJZiBkZXYyIGFuZCBkZXYzIGFyZSBhbHJlYWR5IHJlcGxhY2Vk
IHdoZW4NCj4gZG9pbmcgaW9tbXVfZ3JvdXBfcmVwbGFjZV9kb21haW4oKSBvbiBkZXYxLCB0aGVp
ciBpZGV2IG9iamVjdHMNCj4gc3RpbGwgaGF2ZSB0aGUgb2xkIGh3cHQvaW9wdCB1bnRpbCB1c2Vy
IHNwYWNlIGRvZXMgYW5vdGhlciB0d28NCj4gSU9DVExzIG9uIHRoZW0sIHJpZ2h0Pw0KPiANCj4g
U2hvdWxkIHdlIG9ubHkgY2FsbCBpb21tdV9ncm91cF9yZXBsYWNlX2RvbWFpbigpIHdoZW4gdGhl
IGxhc3QNCj4gZGV2aWNlIGluIHRoZSBncm91cCBnZXRzIGEgcmVwbGFjZSBJT0NUTD8NCj4gDQoN
CldpdGggSmFzb24ncyBwcm9wb3NhbCBub3cgdGhlIGF0dGFjaC9kZXRhY2ggcGF0aHMgb25seSBo
YW5kbGUNCnRoZSBjb25uZWN0aW9uIGJldHdlZW4gZGV2aWNlIGFuZCBod3B0LiBJIGRvbid0IHNl
ZSBhIHByb2JsZW0NCmhlcmUgd2l0aCBkZXZpY2VzIGluIGEgZ3JvdXAgYXR0YWNoZWQgdG8gZGlm
ZmVyZW50IGh3cHQncyBpbiB0aGlzDQpzaG9ydCB0cmFuc2l0aW9uIHdpbmRvdy4NCg0KVGhlcmUg
aXMgbm8gaW1wYWN0IHRvIGlvYXMvaW9wdCBvcGVyYXRpb25zICh0aG91Z2ggdGhlIHVzZXIgaXMg
bm90DQpleHBlY3RlZCB0byBjaGFuZ2UgaXQgYmVmb3JlIHRoZSBncm91cCB0cmFuc2l0aW9uIGlz
IGZ1bGx5IGNvbXBsZXRlZCkuDQpKdXN0IHRoYXQgdGhlIG9sZCBod3B0IGNhbm5vdCBiZSBkZXN0
cm95ZWQgdW50aWwgdGhlIGxhc3QgZGV2DQpkZXRhY2hlcyBmcm9tIGl0Lg0K
