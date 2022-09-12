Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDA5B63DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 00:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILW4u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiILW4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 18:56:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA31182D;
        Mon, 12 Sep 2022 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663023408; x=1694559408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bOWz9netre4MGO2qn19svni3ow75Q/psxg4hx059d3I=;
  b=gItMbvs8vAzTQVL7KAAiAlfkzfFjj18k8NJ9EBz5vdgCo3Lk3LYOklmK
   osdw5Zo7HxEDBXjMQKR0o91D8/2jJIt+WLJFpb0dnRwgbdVSOolvE7oes
   QkKKVPwOgBbRHm0AnWmRoATEQbU2HoPg+xXZXTtXdfoKIPmT+C0S+nu27
   TewOsGTM2w8dBVW/BZJzIdocarPW2yzGogTwbB3tymtNLyAnC85vWPljC
   vnPZ+wYmzQYGhA5m+bMIRx99VvVTOEtUeoWuPBprIhwbA3rO736A6ThS8
   nFQlpV3E+IaQ34KF6l98I47P0lflpa7lbcq00HEYDz4ewjQGonzjAYdXS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277722208"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="277722208"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="944818046"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 15:56:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:56:47 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:56:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 15:56:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 15:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi4X4hs3erfOkT3cCMOAdnIuIUMj7I3mOEA2KAqKpK+qC5GbO6StzZ5bf6scOIRTSWeszKNmaNrFWoiGO/iw9d/c735MMm8d8z9WFazxrXep6Pr+xo+LQq2zguNaJfERSGmh9Nt0cJDucLgQddfa0g2SfZ+5ut89wXFoZO+L5udJRhTikAAnX4BEzaGeJDEsOSlxy5TxD3xVfgHcW2Clw/W6WE3j05VQF4jBxfmU2kUPrRwgN7SpgsqUmzAfrUGbsxHk6mGi7rczpGR7lqYcG/yPwDuk2hOrGeo6PbhCScbIcyX3nskxZocHOxoM3QnihTFHr4T+v8Eycdj1nfP5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOWz9netre4MGO2qn19svni3ow75Q/psxg4hx059d3I=;
 b=eSUkGUhNEHejx0KqBmO/XvrkOh0efoyAzmzVwOmmsJPDFHAwS545ndpX7G8sUtLPkESIclQmhWiunIoB7xNQ7Hx+kRTZk06ljT3chwEl92a6CNd2cscLc/D5Gmu42IlBz5W4mhpQK3LZus1927UaryJ/wWIz8WOh9UyJiml6F8u75rQSOQ/qI2n5Ivuw4+x+zlj+zzRurlh5sAd+BAitDlPU/A0L6EfjUpcfjPhbIVsGNm/SHnBZvwxYOt9OTNTXzmOIyE5qwFGhUxgWYNDr7cjHdPa8/5dxUvLjREh8NosdDBLTZyBak9vgUi+tQygl4pBVzvYWkmJDgAMFu1jg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 22:56:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 22:56:31 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Topic: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Index: AQHYxII0tYXIMKuy6U6cCAuVrVQNk63bZ3QAgADvloCAABW8AA==
Date:   Mon, 12 Sep 2022 22:56:30 +0000
Message-ID: <03818e9a85cdde638faf56b66a611ffca3377442.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <9983d33b59668cfa3bc1d36beaf13f5a4180bad3.camel@intel.com>
         <1cef159a-7827-47bc-639a-209521a337bf@linux.intel.com>
In-Reply-To: <1cef159a-7827-47bc-639a-209521a337bf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: ab342981-9c9d-4a94-9e8d-08da9512086e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrO6lf9JUDHR1VTjziRwY3m9QeBrwvpvQ34UXMX9NSUvzhvY8XjxMG9fiBsZigdR5h2Asng+KNUWlX0l7qRNRlka3QzHryUnpveLAxN9FP1gazp8TdoGD7ECmRjmpwMZ08kiD9C3UIq870oIl/Dn1Ow4ga1ot2tqLDpaJCw+fyse1l03Ox4jSBAtlmz1oUDQK/HK/Rnb+l3ndfQMeYptNfhWzcz7zb7CDi1QSevYr8+rR0svoQJgjYu/pdz++LHJKQ4ySOm+rC/8N/iGGz/m3jEvNP0EmRzU30dDiT7JVEqU+6OFmK5AR94bJlIdIb7kX/ZnmXsMMZGOf2hBxD8n2ZSiwmQzTmtKw9uQFGF3sd+6VCD3kiQi01hDRS3GoV7LKsK0bf29vuVQp1QIUZ8yBIeZ8Bgu+D8HuS87UC0RDoFADNZ4WvooVyDpcWRXZDBiA2Jii/nQlrfqPQMKAcNrReBBc7T8ky3B6dMLdoYQKT/n8n7wm1GsFAYaIEeIfKYUACkgwOdzAb+AYY0LRjD3KBq0b8ZvCp6JUv1HUZFJYB1SC4Y16+gUpv7NIts4ycp6cgWwzEqPhAZahPROKA6Rt0WQy+752xbVnY/O0MTMCVvMHPg6X3viQjueDedysN7ovNA8S48LHBXMu+UlsglxmsUm7BuHszhs3Q5e4mCUB068ZuUmIUhDI0bQRuO6gRJYXR6wGOtCY8YHPHIe2HfGLD+OuZNFfnICGcfrsUmvNoxar5NSVXrKvAzntxiK6QRIP7zF8Ak3ChmfFrCMaiyY4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(8936002)(6512007)(38070700005)(26005)(66476007)(86362001)(91956017)(66946007)(2906002)(82960400001)(38100700002)(2616005)(41300700001)(64756008)(478600001)(6506007)(66446008)(76116006)(122000001)(6486002)(8676002)(66556008)(71200400001)(186003)(4744005)(36756003)(110136005)(316002)(5660300002)(4326008)(7416002)(53546011)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHZyZnVJVGtjWG5wQS90SnpYUXBsK3FhWUZxS2w4ekM3UTFyVEJxYklIQkhl?=
 =?utf-8?B?WE51bFdBaG9XWEh0Y2RKaUVZd0JySWZJRTBvOVVxMHpKYldtUWtlQ2RobDNO?=
 =?utf-8?B?Mm5BbVY3T0ZsSGxDQVdmRnFPdkpGVjZkYXE4WldJYW5CbDBTTFJHUkpYVXpV?=
 =?utf-8?B?TUdDSFZXOFNsMmdPa2RtUkpHVGpRU0hLOE9RU0crYW5qeDRPc2VTbkcwV1JG?=
 =?utf-8?B?b0YrMXFWSFBsQW5DanZCanhvQWJrZzk4RmM2bUxGdHg1d0tCVDFWV1FlRy8x?=
 =?utf-8?B?bGMrYTJldjZMdjVSdlcxUnFzelNyUkJrWXEyQ0xBZmJaYk5xVU51NmR3a1VM?=
 =?utf-8?B?d3hFOFZnLzlQVjBOaU9lS1hlbHVqMXMrbG91ME5GdnVCRWh3bXpHRUhMRVJv?=
 =?utf-8?B?MUllTWp2bEJ2S25pSG16Q2cvYTdYenVVbVRLbEZPUWt2aEUwM2s5UkhtM3NJ?=
 =?utf-8?B?L0ZHSU9hNWR6SHduajBHei9wak12WUxGUGdUc0RpREg5TUtrcXFGT21DQzli?=
 =?utf-8?B?TTBVdHdwR2RDd081ZDlHaGRrclprOHlEZ25tYUNrazRoaXlEdktBZkZMVEpF?=
 =?utf-8?B?b1hqNUFMOGpNVlc3OUk3UjdKcE4rdmJCeHVlcys3M1JzVXovQlBveVZMQmM4?=
 =?utf-8?B?dFl2YzdIZ2NNSXpIK1VmMGlNS0E1VzZQbVAvbDdFeWV5OEJEZ2dQbUlzUEVK?=
 =?utf-8?B?TG9jYTNmU2UrVi9BVTlzODFsRTJERW1BRTZWQzlBSWdzV3BNZVJHRGFkWGdn?=
 =?utf-8?B?MUxUSTZqRVhkWmtRQVM4NDVUb0U0SXNFcktVTUxqdzdIdE11YVcvWjA2bTNZ?=
 =?utf-8?B?Q0R4eSs2dGxKRHkwc0k1bEhEYXdCYUFWazNDeFJmbVdGWjFjcWpSQ2tuMUIz?=
 =?utf-8?B?TGMrbi9mTmFaUlZDOEQreStDd2kxelBiZEtMbFZXYjB2R2tKRHZsdkp1dHZK?=
 =?utf-8?B?NDNmYVNwQUIvRkd1aWhRZEc5M3ZFZytRWDBtanRTY0pkbWt4RHVPMGdhbkpY?=
 =?utf-8?B?Rllhc2ZvTGdtQlpWQWVuZ3hsNmE4WTJFR0diTDg4enZjQ0l1Zm1EYkNDMTRa?=
 =?utf-8?B?YU1OV0ljTmZDWmh6RnNKcC8yR0VFbEZqZmx2ZUpJSEVMWnRHVkdJaTRZY2pP?=
 =?utf-8?B?bHFRbW9UbFhvT2tMd0kxbzJONzVZdVp1dlJhbitGeVM1UjVtMVB1Y3I0UG9i?=
 =?utf-8?B?MVNac0Z6bTFuUjZxSFl5cXNMNUpPQkFpQVJrcmVVV3VIT1JxeWZYRElSNzFS?=
 =?utf-8?B?M0ErTEIrRDlLY1Y2M3lSaUs0M3BzSy9jN3VyVUxCR1oxZk9CUXZOYzJDTWdR?=
 =?utf-8?B?OEFzODBhRWdjTlc0SUxWKzYyTDZ3Y0tzK0gveW04OE5KYUNJZEFsQkk1eGNr?=
 =?utf-8?B?UExpQ1Q3Z3o2ZWNXVUJEU0lKRWQ5UTBRZjg2b3lrTHJqbVZGaWw0ZE1UTVlV?=
 =?utf-8?B?V3VYM3FWdUJOd0Q1UnlXVzA0SUdHQzZRdHBHcFNvVnhZQXFtNnArMk1UNTQz?=
 =?utf-8?B?cWl2SFZOVTIrbEFwSk1jOEcvTlpxbDlQSEJRdHlDWlJZeHI0dlB5Q2JFT25M?=
 =?utf-8?B?TnY5RUFWL0d6SE5iTkxabGRneHBETThvWS9jWHdpak0wYkZleEhQenh5RTBw?=
 =?utf-8?B?UHRPV3hZMVN1RGU0UW1zdVBydDBJeHJNWm1zbVJuSVZmOFErYitZcnljWmpM?=
 =?utf-8?B?MkI1Y2xmKzNUTWE0cjh5TWVkQVUvNGFtQWhoZUVwK1NJNko0U2RYQUJWS2hk?=
 =?utf-8?B?dzhNSTdEVzdHQWlGK0JRUTBJejE5ZFJidjU2aUZ6QU1MQTJqeUp5SlBKRlFj?=
 =?utf-8?B?MXU0ZzZGN01IMk0vdzlreGg0TFNINGYycENFVnNmbEJOWmJ3T1YxTWJaMlg2?=
 =?utf-8?B?NmI4S0J0eHdhVDJ2dzVKVEYxdHhiVVBaTmt2WERqaVNtQWxsdW5FMHQyRStE?=
 =?utf-8?B?OVUrbE5NdWh4aTZNWDhCOFFmOGRFWExTMjd0NGk0SU1VZXNvbWxFNi82dVE5?=
 =?utf-8?B?aHNjMlFmWGtKNTdVdU1SOUhXb1NhVDRDZkg3L2pyNlBaWFZUWmtiMWdMMFZn?=
 =?utf-8?B?Tkt1M1JwZWRXTDMrYXdQQ1pGK0hMMmpsZUt1TkFOdGRwdHBiZjNWcHB2L1NS?=
 =?utf-8?B?SzFBN1MzSkJQSEwvYnEzQUNzTjN0Nkxja0krazJJTU85RmlDZndsUnUzRmFM?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <790B53A87FBF854E8F51263E5CB22321@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab342981-9c9d-4a94-9e8d-08da9512086e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 22:56:30.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hae9+XyYwr37SuGqPufHYtZnxPt7Q7L726xoh0s6QGx3pFEvXr6nrjkQxHbtL8WEguq03MBXH6piNvPHMHb2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDE0OjM4IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDkvMTIvMjIgMTI6MjEgQU0sIEh1YW5nLCBLYWkgd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDIyLTA5LTA5IGF0IDEyOjI3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5
YW5hcmF5YW5hbiB3cm90ZToNCj4gPiA+IEludGVsJ3MgVERYIGd1ZXN0IGRyaXZlciBleHBvc2Vz
IFREWF9DTURfR0VUX1JFUE9SVCBJT0NUTCBpbnRlcmZhY2UgdG8NCj4gPiA+IGdldCB0aGUgVERS
RVBPUlQgZnJvbSB0aGUgdXNlciBzcGFjZS4NCj4gPiANCj4gPiAoU29ycnkgbWlzc2VkIHRoaXMg
b25lIGluIHByZXZpb3VzIHJlcGx5KS4NCj4gPiANCj4gPiBBbHNvLCB0aGUgSU9DVEwgaXMgdG8g
cmV0dXJuIHRoZSBURFJFUE9SVCBfdG9fIHVzZXJzcGFjZSwgYnV0IG5vdCBnZXQgdGhlDQo+ID4g
VERSRVBPUlQgX2Zyb21fIHVzZXJzcGFjZS4NCj4gDQo+IEhvdyBhYm91dCBmb2xsb3dpbmc/DQo+
IA0KPiBJbnRlbCdzIFREWCBndWVzdCBkcml2ZXIgZXhwb3NlcyBURFhfQ01EX0dFVF9SRVBPUlQg
SU9DVEwgaW50ZXJmYWNlIHRvDQo+IA0KPiBlbmFibGUgZ3Vlc3QgdXNlciBzcGFjZSBnZXQgdGhl
IFREUkVQT1JULg0KPiANCj4gDQoJCQkgXg0KCQkJIHRvIGdldCA/DQoNClN1cmUgZmluZSB0byBt
ZSAoYXMgbG9uZyBhcyBubyBncmFtbWFyIGVycm9yKS4NCg==
