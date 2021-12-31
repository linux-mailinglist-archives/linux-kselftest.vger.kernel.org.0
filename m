Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71F482306
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Dec 2021 10:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhLaJnE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Dec 2021 04:43:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:21586 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229555AbhLaJnE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Dec 2021 04:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640943783; x=1672479783;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SxCfcahAN4WmdsHDoE4X1Pg11D7TWNDqTXmasM84Rok=;
  b=E0yyi7aXaISP0gY8Th5YmiJh0+/L1mvPz3gZp3/dslaAkvPYI9ihgHYj
   g1rVuJV4JCX+ztAhbjavKLE8ivkOpMkApcXAnZTx9xHymHuccACK+xKUf
   tlbqqZTlYd3DBv5+g5ip9Pwuj03UUjkaaBDtO/R9LoGFJ5K0X7PyttGRF
   EtBDzaH2hcdNAzozB+rbkF29hFIlVo8NTX8u09HpqpTvpy4BwRuDJlw1a
   aVBcbzs07fgvKvkhAg7kORi65E0W5urfyWUWE+Zs1ADHCLNlD/kfnVp1a
   tlaFo4btcLoD1xiOOVDBg5BdkMVRNccDc7SaI/Wjn4oq4WMz88DGXvUmt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="302545898"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="302545898"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 01:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="525301544"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 31 Dec 2021 01:43:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 01:43:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 01:43:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 31 Dec 2021 01:43:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 31 Dec 2021 01:43:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGZR6UN31xU76mvhkVPtrs4xp1vMGlZIuGgwunUzx1qa3DsUt43VqydV6T5XOLY2ff+fMWafNGzdbBjTDoe7T7C0X9lVhJhLEYuT5gGDHBP2SxdnrnNtgPHcjAgEBq8d5PND05a8G456n5l1Fmml8yneFLImkM+zav5LeVSmR61OXbHK7UBdlLGKBY1+36x44b7gAS+B/Iu2B3oFg1eLTRIcUioFkwFPMBakOYbVHkPUia81CgJNAmdlEBZgPW9MJQV2S2zM8su6JKmoX6PM3rJnFBQedoPYZKtNLqqTtd7lB9WkyUrhQo2jvHG4b5v9wOSWdzOVpYdF2WAzPT17yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxCfcahAN4WmdsHDoE4X1Pg11D7TWNDqTXmasM84Rok=;
 b=JL+BFm3DnXhyAXmL4YpzLuU/Fdl6Gs8AVu+zCYLELLNVLLiBp6QRNHIqC7AIevfWRviOxZnzYmCmtTJ0hz1Y1I1XlGq7Jo1T8eYwrpym0BbSOx5xtWAoFoF9tUwY+YbVUeyBa1G7ZofTuyxTlwn12yKORrZma43i81m81VcT9MT6Pol2sX/5CM2DmtNUKYTV+hLdPOWDSpzVW3MycHGSIqzIB6qRfDgBWAX3QosXbLFaXrJj6fhF8yMzkqPlzdlSzdCpUEBfUUW2Gn3HSV2eSRh96DL5rQucvRE56rv/a7zH+pwjLfwAAGeY0UpGSmtVnMghkgh0jsHNZzY0eJXsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3810.namprd11.prod.outlook.com (2603:10b6:408:8f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 09:42:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 09:42:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgAAjG3CAAD2qsIAAsXqAgAB7lVCAAFxUMIABxwoQ
Date:   Fri, 31 Dec 2021 09:42:58 +0000
Message-ID: <BN9PR11MB52767789D59239DF5DD524758C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
 <BN9PR11MB5276CE5635898CE13BFC57FC8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YcyaN7V4wwGI7wDV@google.com>  
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edddb2e6-04ce-4e17-e686-08d9cc41edab
x-ms-traffictypediagnostic: BN8PR11MB3810:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB38106692F28F906D05021EE48C469@BN8PR11MB3810.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHxKFg1phx3+3It+2Sp7zBHexRYUvcZMwgFNpB+kde8jHNBBS0vzyK7a2uVGq56KNnFNYp+otXq6r/eUnqxCIl5mt0S1uc43yW/KbNHzbEDTQm0g1PzzckM3M3bl/b6kNP/I/OiKEzcdYUEh6bHTpG+s73NIsV01p162cqDIeWggijVBdFJe/1rizZbhG1j/nMuRkY2c7SC5fsDFe1a+O/xeDPzsbmudHi2j4LIeYm0ZmQ2B/OS922Im0wftBDq0DnEjhy1+KwhZQ1RWI7qTJzA8AlLxiF1phDqk7b4exrCI7uReyzbZ4G39qKdE+Yzj0e8nxeynksJvdPooScwiIxSlhU+WDYIYfWVplPHVoUgTNXp5VKrbs6SXnsxqjTcpeWATFBiJ7psqYwEnePtgJG7JKT2v/a4cj6GeNlxzJyiDrwoBVgGBwdWQEV8F7LUejXAiQ5RTmPsMeuPvPYN6fuUwZoORrDrQDlSCm7SEHpejX369Ku429l2sdciBV5P9a2h3zY7HyULASat4oexVQ9Yc1tx9J15mCjj3UXbn+MdiWo5NhMJvUuxpR5FtUdM+JxkeqlhP2YmFHUCWUb2Z9rfgXsI7F1KbTet0rwMNh8JsEqhr/b2VIaIOPQhEwB9Fl4OiREz49yoYadIZVbE3oi6bAnnmbDcvVFQOLFh4OQonqkBTHppFTAVuEmjLu4XCRob0Bq/lg/ZXlHldqQf06Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(83380400001)(66476007)(186003)(76116006)(2906002)(66556008)(54906003)(4326008)(9686003)(71200400001)(38100700002)(82960400001)(86362001)(122000001)(8676002)(8936002)(7696005)(66446008)(52536014)(64756008)(26005)(38070700005)(7416002)(33656002)(66946007)(6506007)(5660300002)(508600001)(55016003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHF2dWxOZjlRc3NiR0JxNWc4dDkraGdqeXhrN1ZmbU5iOTlWbW9HZm4vaEZo?=
 =?utf-8?B?M0J0c3VOSU53UUhkS1Z4YVJROGs4b0o0RmVVVEFwUE54Wm1EbmFmRGtDcmdZ?=
 =?utf-8?B?Q1J0Yjl1eEhQYWdOR2NrT3R0R2g3aW1pSkpOSG11NktqbDRjZWlzRmJiUTZJ?=
 =?utf-8?B?YmNBNy9UOHJqNi85WGtkSWd4TVU4TEgzVnNxWElPU08xRjZUUVpCcHFNellW?=
 =?utf-8?B?ZHpqak1wMkFRc1NmenFTajFIcjNENFBKcnlodzQzbk9PeDduTE92Zm1XYWdq?=
 =?utf-8?B?Zk95NWtrOFVvOGNVM2dkalpBS2tCTXlzVFVNcmxqQTVCVjJrcGkvWFZqTTZT?=
 =?utf-8?B?RzBONG96NFM5MmRuU0lkakpOaG1aQWhCemF4Sk52NWs4ODJ0MWFuWmJmT3l6?=
 =?utf-8?B?b3F1a3c2TzBHcjhsRVkxMk9qN0dTZU5GdHhMRFp5S0YrSFh4c1FqZGpWS0R0?=
 =?utf-8?B?SFAzODBIbUNpVDRHN0FQR3NQTU1TOGVyTHFHV1YvKy9NZGJ4amlBQ21oN0R5?=
 =?utf-8?B?M0FMbU5jVUh5bUtmaUVrdVpGSHZmVWt0bGdIeERvL2p2d3c5MHVKN2x6dkRC?=
 =?utf-8?B?dG8vczlEaittSU5xazhZMXdNOW9mM2Q4bFlRQjdHcVRDM202Y0t1STFoRXhY?=
 =?utf-8?B?MVRJd00xZkt6SUVMdGNRMUlSUmRWZDlQY2cxbnRKLzkybWU5V0VJMHRVaXIz?=
 =?utf-8?B?bS93UjRzYkhBcGRtRHJ2Um5zd1czb2Q2Qi9mOFlPNmRpZnhncm5Jb25TbzZ1?=
 =?utf-8?B?RGR2SDkzMjQrbW5ubDZ5VnBKam9PUktDWnBRL3hnM0lRRlhwb1Mzc3ZxekR0?=
 =?utf-8?B?VU9PQ3NZVXlld0RCS2VONnJYMnhDdnpTVEc0dWNxTnU0L2Y4SnBGMmRDWWlq?=
 =?utf-8?B?RlZNZTQ2SjF1c1BnYktsRTRpbFhRVFlQNURDa3dXa3pGVUs3b3BacitWNHVp?=
 =?utf-8?B?NVJESHVweTMvTC8vdmd4L0ZUY1BUVC9JN2N5b0d5bTI5WGN4NlhpOVR3V1R2?=
 =?utf-8?B?RHBKQ3FzMXNoYmFLK0VjTHRoZFNRUGZMZmttWm5zSFQ4VGYxcnlkM050R0dC?=
 =?utf-8?B?YWVYWHdJLzFPQ0FyN3pGVzYrRVdrcjQxczRRRGpIVGdqdHVMcDF3QVBwUEwr?=
 =?utf-8?B?aVZYQlJjYnJBYnF0UTNnREtueCtvRnBuWEJ1UnBGTlViSkptS2g2S1BTNm9C?=
 =?utf-8?B?cHpLZXlVWG1LZzNlZTI2Mzk1YkRIWDJOTnhvOVp0S3luYmphaHBRMUhxanZi?=
 =?utf-8?B?T25kdnMvL0VHR3pWaDBvLzRHWXFNRXcxUEdSckZPT0N6WlJ4RVczSjFQd1No?=
 =?utf-8?B?SkVCdWx5dHlORFU5RzczUlhpaFg4VDJ5d2E1Tk9DVjZ2aFVaMzFLRHdBNDhI?=
 =?utf-8?B?dlEyWURaZGRnczVpQWhCSDZLQmZZNXFGTHdqZ25YM2EyWmYyTmV4cHZjVGky?=
 =?utf-8?B?U1lBc0lzTk51R2V5dDRTaVBWalo0bDdvOW8ra3lBZkk2T2F6Yi8wa24rNHE4?=
 =?utf-8?B?Y0ViRHVrbUh2cTVFT0ZHdEtvNHc3V0JsV1QwNTArQjdoUzVNL3FiQ1RlRXhF?=
 =?utf-8?B?TkpFNXNrZUZkVmRXRVpsVGlFaTdpRzNDL3cvaHNXTll1LzJtYTBoMU4rNWhO?=
 =?utf-8?B?eGJPeFAyOSs4UzNNWGU2Qm45YWtyLzFjeUtaZ0x0M254ci9EbFFYLzdvUUdN?=
 =?utf-8?B?VXdsWDN3ZVhkb2UvRmZ0UzhGcnZQTW1rSVlVWWVkZXd1T2ZSbEJVZXFrMmVM?=
 =?utf-8?B?cE9CMVluYjJtdnRmc1l4UWdZeTZIbXU1Z1U1UjF0bUdGdmFQTm9NcVNZckhT?=
 =?utf-8?B?U2hRbVJkUUR5L3FZTmtsSTg0RmZvVnlzb2RsUkJ4VGZrRFoxOGhBZ0J3enpQ?=
 =?utf-8?B?U3FPY3RLNDZRNFJtNFJ6ejYwdTRnWUViQWQ1bzRpQWxzeHdGUGdZOVlMb3Ew?=
 =?utf-8?B?N1UwbHlYT2hmVld6cVgrZ1AzTUZBNDQzU1I2ekRhMkpCZ250cno2NlBJRDh1?=
 =?utf-8?B?N2FPRFRhSzFTV3U5TGN1eUxxbm1nclRMTnErSTRYMERKeFRMNlJWZTh4Nzhk?=
 =?utf-8?B?QnJEb1hoczJqTm84bEZFQlBqZlNIUVlDL1RtMjNWTnk0TUpSeitCWXNHQk9o?=
 =?utf-8?B?OXFWUS9nYk1WcGIyc0lFVTU1ZFRYaVE0M0dQT2M0cGdobjdGS3ZlZjUrQmRO?=
 =?utf-8?Q?6lIkEIZpfZBQ66I5tG2SpMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edddb2e6-04ce-4e17-e686-08d9cc41edab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 09:42:58.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUaaCZxYd0KYe3amQSOmU/4+K5nn5vZcG4z5J1hzItzdUPCv+QjAkQSZmna4etqRznDfQm3cY/2yb1Koh34hCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3810
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMzAsIDIwMjEg
MzowNSBQTQ0KPiANCj4gdGhlIG5ldyBjaGFuZ2UgaXMgbGlrZSBiZWxvdy4NCj4gDQo+IHN0YXRp
YyB2b2lkIGhhbmRsZV9ubV9mYXVsdF9pcnFvZmYoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiAg
ew0KPiAJLyoNCj4gCSAqIFNhdmUgeGZkX2VyciB0byBndWVzdF9mcHUgYmVmb3JlIGludGVycnVw
dCBpcyBlbmFibGVkLCBzbyB0aGUNCj4gCSAqIGd1ZXN0IHZhbHVlIGlzIG5vdCBjbG9iYmVyZWQg
YnkgdGhlIGhvc3QgYWN0aXZpdHkgYmVmb3JlIHRoZSBndWVzdA0KPiAJICogaGFzIGNoYW5jZSB0
byBjb25zdW1lIGl0Lg0KPiAJICoNCj4gCSAqIFNpbmNlIHRyYXBwaW5nICNOTSBpcyBzdGFydGVk
IHdoZW4geGZkIHdyaXRlIGludGVyY2VwdGlvbiBpcw0KPiAJICogZGlzYWJsZWQsIHVzaW5nIHRo
aXMgZmxhZyB0byBndWFyZCB0aGUgc2F2aW5nIG9wZXJhdGlvbi4gVGhpcw0KPiAJICogaW1wbGll
cyBuby1vcCBmb3IgYSBub24teGZkICNOTSBkdWUgdG8gTDEgaW50ZXJjZXB0aW9uLg0KPiAJICoN
Cj4gCSAqIFF1ZXVpbmcgZXhjZXB0aW9uIGlzIGRvbmUgaW4gdm14X2hhbmRsZV9leGl0Lg0KPiAJ
ICovDQo+IAlpZiAodmNwdS0+YXJjaC54ZmRfbm9fd3JpdGVfaW50ZXJjZXB0KQ0KPiAJCXJkbXNy
bChNU1JfSUEzMl9YRkRfRVJSLCB2Y3B1LT5hcmNoLmd1ZXN0X2ZwdS54ZmRfZXJyKTsNCj4gfQ0K
PiANCj4gaW4gdGhlIGZpbmFsIHNlcmllcyBpdCB3aWxsIGZpcnN0IGNoZWNrIHZjcHUtPmFyY2gu
Z3Vlc3RfZnB1LmZwc3RhdGUtPnhmZA0KPiBiZWZvcmUgdGhlIGRpc2FibGUgaW50ZXJjZXB0aW9u
IHBhdGNoIGlzIGFwcGxpZWQgYW5kIHRoZW4gYmVjb21lcw0KPiB0aGUgYWJvdmUgZm9ybSwgc2lt
aWxhciB0byB5b3VyIHN1Z2dlc3Rpb24gb24NCj4gdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFw
KCkuDQo+IA0KPiB3aGV0aGVyIHRvIGNoZWNrIG1zcl9iaXRtYXAgdnMuIGFuIGV4dHJhIGZsYWcg
aXMgYW4gb3J0aG9nb25hbCBvcGVuLg0KPiANCj4gVGhlbjoNCj4gDQo+IGhhbmRsZV9leGNlcHRp
b25fbm1pKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gew0KPiAJLi4uDQo+IAlpZiAoaXNfbWFj
aGluZV9jaGVjayhpbnRyX2luZm8pIHx8IGlzX25taShpbnRyX2luZm8pKQ0KPiAJCXJldHVybiAx
OyAvKiBoYW5kbGVkIGJ5IGhhbmRsZV9leGNlcHRpb25fbm1pX2lycW9mZigpICovDQo+IA0KPiAJ
LyoNCj4gCSAqIFF1ZXVlIHRoZSBleGNlcHRpb24gaGVyZSBpbnN0ZWFkIG9mIGluIGhhbmRsZV9u
bV9mYXVsdF9pcnFvZmYoKS4NCj4gCSAqIFRoaXMgZW5zdXJlcyB0aGUgbmVzdGVkX3ZteCBjaGVj
ayBpcyBub3Qgc2tpcHBlZCBzbyB2bWV4aXQgY2FuDQo+IAkgKiBiZSByZWZsZWN0ZWQgdG8gTDEg
KHdoZW4gaXQgaW50ZXJjZXB0cyAjTk0pIGJlZm9yZSByZWFjaGluZyB0aGlzDQo+IAkgKiBwb2lu
dC4NCj4gCSAqLw0KPiAJaWYgKGlzX25tX2ZhdWx0KGludHJfaW5mbykpIHsNCj4gCQlrdm1fcXVl
dWVfZXhjZXB0aW9uKHZjcHUsIE5NX1ZFQ1RPUik7DQo+IAkJcmV0dXJuIDE7DQo+IAl9DQo+IA0K
PiAJLi4uDQo+IH0NCj4gDQo+IFRoZW4gcmVnYXJkaW5nIHRvIHRlc3Qgbm9uLUFNWCBuZXN0ZWQg
I05NIHVzYWdlLCBpdCBtaWdodCBiZSBkaWZmaWN1bHQNCj4gdG8gdHJpZ2dlciBpdCBmcm9tIG1v
ZGVybiBPUy4gQXMgY29tbWVudGVkIGJ5IExpbnV4ICNOTSBoYW5kbGVyLCBpdCdzDQo+IGV4cGVj
dGVkIG9ubHkgZm9yIFhGRCBvciBtYXRoIGVtdWxhdGlvbiB3aGVuIGZwdSBpcyBtaXNzaW5nLiBT
byB3ZSBwbGFuDQo+IHRvIHJ1biBhIHNlbGZ0ZXN0IGluIEwxIHdoaWNoIHNldHMgQ1IwLlRTIGFu
ZCB0aGVuIHRvdWNoIGZwdSByZWdpc3RlcnMuIGFuZA0KPiBmb3IgTDEga2VybmVsIHdlIHdpbGwg
cnVuIHR3byBiaW5hcmllcyB3aXRoIG9uZSB0cmFwcGluZyAjTk0gYW5kIHRoZSBvdGhlcg0KPiBu
b3QuDQo+IA0KDQpXZSBoYXZlIHZlcmlmaWVkIHRoaXMgc2NlbmFyaW8gYW5kIGRpZG4ndCBmaW5k
IHByb2JsZW0uDQoNCkJhc2ljYWxseSB0aGUgc2VsZnRlc3QgaXMgbGlrZSBiZWxvdzoNCg0KCWd1
ZXN0X2NvZGUoKQ0KCXsNCgkJY3IwID0gcmVhZF9jcjAoKTsNCgkJY3IwIHw9IFg4Nl9DUjBfVFM7
DQoJCXdyaXRlX2NyMChjcjApOw0KDQoJCWFzbSB2b2xhdGlsZSgiZm5vcCIpOw0KCX0NCg0KCWd1
ZXN0X25tX2hhbmRsZXIoKQ0KCXsNCgkJY3IwID0gcmVhZF9jcjAoKTsNCgkJY3IwICY9IH5YODZf
Q1IwX1RTOw0KCQl3cml0ZV9jcjAoY3IwKTsNCgl9DQoNCldlIHJ1biB0aGUgc2VsZnRlc3QgaW4g
TDEgdG8gY3JlYXRlIGEgbmVzdGVkIHNjZW5hcmlvLg0KDQpXaGVuIEwxIGludGVyY2VwdHMgI05N
Og0KDQoJKEwyKSBmbm9wDQoJKEwwKSAjTk0gdm1leGl0DQoJKEwwKSByZWZsZWN0IGEgdmlydHVh
bCB2bWV4aXQgKHJlYXNvbiAjTk0pIHRvIEwxDQoJKEwxKSAjTk0gdm1leGl0DQoJKEwxKSBxdWV1
ZSAjTk0gZXhjZXB0aW9uIHRvIEwyDQoJKEwyKSBndWVzdF9ubV9oYW5kbGVyKCkNCgkoTDIpIGZu
b3AgKHN1Y2NlZWQpDQoNCldoZW4gTDEgZG9lc24ndCBpbnRlcmNlcHQgI05NOg0KCShMMikgZm5v
cA0KCShMMCkgI05NIHZtZXhpdA0KCShMMCkgcXVldWUgI05NIGV4Y2VwdGlvbiB0byBMMg0KCShM
MikgZ3Vlc3Rfbm1faGFuZGxlcigpDQoJKEwyKSBmbm9wIChzdWNjZWVkKQ0KDQpQbGVhc2Ugc3Vn
Z2VzdCBpZiBhbnkgbW9yZSB0ZXN0IGlzIG5lY2Vzc2FyeSBoZXJlLg0KDQpUaGFua3MNCktldmlu
DQo=
