Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E66402371
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhIGG31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 02:29:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:49413 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhIGG30 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 02:29:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="216953135"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="216953135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 23:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="523615062"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2021 23:28:20 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Sep 2021 23:28:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Sep 2021 23:28:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 6 Sep 2021 23:28:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 6 Sep 2021 23:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm/HnJ2shBeTuVv6gNmMLpfEHjZtgDXK2DUMS4/KLTq0YOp9JB3IcGi19QQmS68J9aYbfPwzM6atWSNVbrZt7hbR0nBkuFiaZb4mhfAc4kiwSqzxooKzWffBSnsyhaVZOqHLjMi4OXWOZf86ybkp+X660u8SD4BkJd0Qk7co4cHvAqr49SLvBp0K+e6jlhh0a7jXoHTazYjnzIv5vk4PShyf+hUurAIw6Qekj5XHvlp+UrV2E1WwIr/oBx8dE47tGEc60P6cNllheyA8stB7rFzF2Cau2G4KmHmiDOQtOdcJHuvtuod0CsBr1o5+jXxGXY+hibuwkz/dvGOkgF/tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bkYcmZFifkwmUY/U+iw4xLuBq+lnw533Dm23XvaGc9M=;
 b=ZL89FKBcQTaKSWH5GRteuUjCh2nn4kB0RGLgxnaE+8M5UXI7i+qUEpPQPN8mkSz50drUjYUs1+nSDZb4Ub/uC8L6tQxZ/Dd1dn4qT0NutRtF2oxnvQ8ux6CLG24l4Gnb93/jWyDDdrmFOrVGmfI/iBw7OhIMp27kWYTL3Dt3QN+3aKpkVvSRSOgtf/9O6if6pFspSadWDh7tPK2ibb4OzqT7YmBK6MO1toFVxoFjNAgBPTGDHstOBwtfk+RDVj12UJ4izkxJEOoKnPaRodotwmv1a16QlYcGoMcex2UHyFwZmi96Bt4phaBtwra0CVyAY0/t7figrKneQ+hb55vVVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkYcmZFifkwmUY/U+iw4xLuBq+lnw533Dm23XvaGc9M=;
 b=gV8U0sUeZzxTsSZ9GIz8M5+npkynpRBN2nQNzSOF0NaocVfVhA/7gnvZECHnvbuu2qowE+oiyXejxpDPE7fzDgPuxabGXnfp/Nd+j/lQMdqQh0K2xWYKKkuT7LylR2zmyP9ONXUloqMWvF8/ShbQOZibrjBxeKq0wDznarG4s9Q=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2696.namprd11.prod.outlook.com (2603:10b6:a02:c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 06:28:18 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::bc8c:80c0:1c01:94bf]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::bc8c:80c0:1c01:94bf%7]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 06:28:18 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>
CC:     "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: Fixing up at least some fallout from '-Werror'
Thread-Topic: Fixing up at least some fallout from '-Werror'
Thread-Index: AQHXo1n1rpUxJqWPMEi8n8thPU0SCauYHGKA
Date:   Tue, 7 Sep 2021 06:28:18 +0000
Message-ID: <89b533e1be3b2f42700d018bf35503ffb024e3f7.camel@intel.com>
References: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
In-Reply-To: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93579591-59a5-425c-00ba-08d971c8ae68
x-ms-traffictypediagnostic: BYAPR11MB2696:
x-microsoft-antispam-prvs: <BYAPR11MB2696291A3E43386DF849DF4C90D39@BYAPR11MB2696.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GabD2V0vFTH4vP80cbEpPx8NixNUP4PEIHppNeTYmWqJJ8kPQ62erQ7CCuCAAPs5oRNkGx1Yc692ATel2Kcc8+LyHdEHNdITOC4+d5i8cJ8kJfkZlo8DhhKyxdDlhhT+pZsCMAYr92apPtTUk7VbPcCpeDXBol6QE9RhkEpqHWh7CCuwaLNhAj4+armtq6dKEw4KXrpMYBL8k80aBJxFu4XBzNDL2sGtRt7fadBT3gKcMs4Xm9zqIjyla4oWzXRHcMjINTPxBOLBj6h/GjDjZmNM+w8V5gNSoXbSm71ya5AH4WP9UQRFMdcdAQ0g7lZStB4osaG0CBF0Xu70ndtZk5NmkryhAUQ4BZpNdZNLoNKflV7QLTVn/DxuLq/bzpxn0OH6ElfP5fRya6qSLt+RL2qnWx9m/e5+RnMh09M/xa6D7Z7pe/h5OLW+IuIlpmvaZMPNyAsNV0LAWC3oEe2r+BlXJHcsEtev2Q9GnzriReW1zBMIQiftj+U+BvMlEAGLbzRT/Ru1/Zr5/d8SEIWktZ3DAI1Z6GfpkUAerdWl7x2VpH2ULCKzLZzyigrLZHRc/I0a4hkfZKidsN6lr32nf25JKF75eufz3LZusvv2Z2WZIq3yfndphWdVs9HwTLYn7+SCotO6xpD15d3aOzXl84oW5M+Q/1fkAzxJT/sWpvt07lKgbgAhLy79a3N6sQcv6di90x5I56rNgzFl/KldfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(36756003)(38100700002)(122000001)(86362001)(8936002)(4744005)(54906003)(6512007)(6486002)(5660300002)(2906002)(110136005)(4326008)(316002)(66476007)(186003)(66446008)(64756008)(76116006)(38070700005)(91956017)(66556008)(478600001)(66946007)(71200400001)(26005)(8676002)(2616005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3dVMFl3dHQrZDRXL1A4akphOG1jZXE4aGJ4c0tlbmQ5dC8vRlRCYjJic2Fq?=
 =?utf-8?B?YzkydU02U0p0Tm1ld1Mzd0l4Qm5iTWJ3bEh0bVV1dUVIWFpsbXBkckMyaVov?=
 =?utf-8?B?YzNVWUo2c0tJVE5FU0JjTmdQZFpXazMwcWhCcnAvN3I5cktaR3RmcjB5WVdh?=
 =?utf-8?B?UXQ4Y3JKS2FWS2FDOFZMQ1FXczdrdjlZR2FnZFFWWkplWnhJOXVjcW1GdlBM?=
 =?utf-8?B?K2FWcEhLMmMyem1WNnhSSmlEa25pVkNtdkxoNUZMRG1Pck10TkVTSDlmdXBL?=
 =?utf-8?B?TnI2UUNPQXJsKzdOa2hnTGlIWWVmSEE3SGZIbzNYK1R1ZEFEY1kxQ2tkZkFH?=
 =?utf-8?B?N0dQRlYxekRFWU85M2dkampveVlqcittaWcybXFmeWRoenUwZVhrMW5XdEg0?=
 =?utf-8?B?Y0E1N0ZCV2JxMUptYWRZdjBMT0t4ejhCQnRsVjdZcExlWHRLVXF6U0hZcUhF?=
 =?utf-8?B?aFlUMXZiODhJVUhIbStrcGVyVnI2UjM5TlN5RlZ0UjhLOGRXclcrbkQrM0VJ?=
 =?utf-8?B?NGYrRGNOUCtqZDZQdFgxTlZrRnQwZS9McE9Xa1BjLzZXWjk1VEhmeUlMS2l4?=
 =?utf-8?B?WnJsb1pvek5vTXZzYytQVmxmaTlDMi9XQTZqNFZmcVU0bWN1OFpXL0tnQXl4?=
 =?utf-8?B?M1VTTXdDNkl4clVkNDZZclZ0bTJLamdrZk5FaTV6VCtzcWdwNmJzeHJBRjF6?=
 =?utf-8?B?dWROdWlGUUNWZURjd0h1Qnova25udnRvNnZ1RnBWcWJuM0dSbmp0dVVneHl2?=
 =?utf-8?B?WktmUFkxUFhkaGptaDc5ZzdlYkxMc2swS0JVSW14SkZydnVDdnRCSW1xWG1h?=
 =?utf-8?B?UUF5Y2hBRHZ3dVcrV2lkL1FSVXZEbWZGYytFSGtha09OaVNLY3NFRWRGNVdC?=
 =?utf-8?B?RUlHWjBaczBuTEVvQ2tLVGJiZ05mc2szUXU2cmdwNTR2Z3NoMHd5RHRhdlJq?=
 =?utf-8?B?L0tCV1F6cndzRTN0NUhSU2Z0OS91TWU0ZFBUeUZzYnlySmpTN1lZaWV3UUx0?=
 =?utf-8?B?bGVRY1FkUWRnVDNYWjgxdDc2VHJRMkkzNjAzQ00xYXFwdFNYL2VaNXQ4M1NJ?=
 =?utf-8?B?amhGZ3JZY3lpK3Nnb2N0bjcyZmt2aERVNHZZWmpKbGhlOG9lbnhocEIvMThn?=
 =?utf-8?B?ZzBkeVR2SEZWOXUyRWJqWkV3c3ozb08rcDBTRGc5bWJoS2tXMGh3QWtjK29t?=
 =?utf-8?B?ckQ0aHFaYXQ1K2hLdnBNOHMxSFhuZjZrK01pRU5DSXVUMUZYVXdLRm85bm5j?=
 =?utf-8?B?WERVbWFzU0pyRWswZ0JYSjBUcTJ3bGRmWU83K2U2UEJEK1JqdVEwNzY0TXI0?=
 =?utf-8?B?NU9XMkEyUkdOOUN4cHhUWmczdU5SUGVJN25hVU9oMDNpejJlREo4VzVwdkx3?=
 =?utf-8?B?SHhndGF0d0EvQWdlc3NNVzFXZUdKdHhHSncvZlNsZzdKbXI0QmFVK1lyNUUw?=
 =?utf-8?B?MW00N1JZeHErOTJMUmFsdThpZ1RCU1ZOQ0t4VFVnRytRNmQ2bUh4c292RXBm?=
 =?utf-8?B?aytGUzhQY0NXVTUxRG04dWVYNXJiSkJ0QXFXVWhLWWhyaDZ0THNhMEhZSEE3?=
 =?utf-8?B?MTB4WHRrbjh0TGMxTERaQ2tTTGUvS3k5RW8raGMzdGN0alZ6WkU4d0gvVTZE?=
 =?utf-8?B?dUZOcXJhc2VuNzdnLzVuT1lXWmVYazI5aDZsa1UrNHRMV0tPbnRWNldDV0w0?=
 =?utf-8?B?U1pmUFdtOUtzSE5RTWl4cnVXdVg3N1J5OTFZVEtlRG9zZW5wMXBaeWRxaUs1?=
 =?utf-8?Q?3K9dU7jmHDM6Up7WJmRrdeWNWd66440oVdaxIo/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <685A974A13BD144BAC0AF12E4CBFC2C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93579591-59a5-425c-00ba-08d971c8ae68
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 06:28:18.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkvI6BR4/rMjig7w7eQw9BF8PFs5EplRC4f0D7IykcXmRTaanAtvBj8jvIatZHocqFestIKiXFAcKdLiYQyWY01ITtXjhQ8bHBibfywzQug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2696
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTA2IGF0IDEzOjAwIC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gU28gSSBqdXN0IGNvbW1pdHRlZCB0aGVzZSB0aHJlZSBmaXhlczoNCj4gDQo+IMKgwqDCoDRi
OTNjNTQ0ZTkwZSAoInRodW5kZXJib2x0OiB0ZXN0OiBzcGxpdCB1cCB0ZXN0IGNhc2VzIGluDQo+
IHRiX3Rlc3RfY3JlZGl0X2FsbG9jX2FsbCIpDQo+IMKgwqDCoGJhN2IxZjg2MTA4NiAoImxpYi90
ZXN0X3NjYW5mOiBzcGxpdCB1cCBudW1iZXIgcGFyc2luZyB0ZXN0IHJvdXRpbmVzIikNCj4gwqDC
oMKgMTQ3NmZmMjFhYmI0ICgiaXdsOiBmaXggZGVidWcgcHJpbnRmIGZvcm1hdCBzdHJpbmdzIikN
Cg0KVGhhbmtzLCBMaW51cyEgV2UgYWxyZWFkeSBoYWQgdGhlIHNhbWUgZml4IGluIGl3bHdpZmkg
b24gdGhlIHdheSwgaXQNCndhcyBhbHJlYWR5IGluIHRoZSB3aXJlbGVzcy1kcml2ZXJzIHRyZWUu
DQoNCkx1Y2tpbHkgdGhlIGNoYW5nIHdhcyBpZGVudGljYWwgdCB5b3Vycywgc28gdGhlcmUgc2hv
dWxkbid0IGJlIGFueQ0KY29uZmxpY3RzIGluIHRoZSBpd2x3aWZpIHBhcnQuDQoNCi0tDQpDaGVl
cnMsDQpMdWNhLg0K
