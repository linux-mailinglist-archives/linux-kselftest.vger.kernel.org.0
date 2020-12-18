Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C42DE160
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 11:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgLRKoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 05:44:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:8878 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733203AbgLRKoC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 05:44:02 -0500
IronPort-SDR: hj8NBBJ4itUeosBvIlhKFXdU+PZkQzsUMrofJno/ybkW5HFHZDAZ09ruPdafjyHFdJnVJHmQpu
 WSQoJ7kglOZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="155219341"
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="155219341"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 02:43:21 -0800
IronPort-SDR: SliPYRcW6PO2xPex3YY3vRk24Nh4V/QO8Q+wElDTpYW26Zqo8859m3KvcsxxEFy/xLGgLPM3vk
 872yq74cCtGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,430,1599548400"; 
   d="scan'208";a="380410064"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2020 02:43:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Dec 2020 02:43:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Dec 2020 02:43:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 18 Dec 2020 02:43:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlWhLYM1qximnHuBXzQRW49QMc76DUlaCNANScR7z85OltNd7AE+OIPkj0y+FANsdX2ss6MjUeMXiRAU/s+VIJ368U1jFdQe5ZY/5ptqVpCpaADucoHccGKjypUIoULuLTik7Q7k/pKlwDN+Il6YVXSArNAAAsFAIM1LXCqHKRCQsrOwMFnkdO6IChuCQdWGmT1RFwnBM3Kmew3VuavWVSGNV60czuJGw5RPZxyMGRNOIJSe0p166Jvc5gupmciIS64ziNzpZTqui/HbQVpXrCLWN9H0WdIKtZ48VNQwuQTfy+62oaVqxLofR/C/KgTqdY6JFFcwUrcymVOVDOsOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRAQzUMQs5hpo5iBWORKRz/N3TR1Tbb3ZAz+wwg4XsY=;
 b=U/fUwJ7PLbPn3lJN4+BGeSCP09U5sIftPNNrMgD+gZBXAUVGOLjcZECUB/2qRZNYiFfSIMyPZNSRQ2bJEbCKtgmoFNPhOzoJZxUre/nxFYrCrAISp8J6ry1ZRrOrS3ToYB2vCw6EILV6LRuh9CjHKJfvMwxNNgrwUNbvVO0Yq1Ab7mh5YYScWnfwjMtxlDXvv9HJtBZLaYSXbsL1xetygHf0XbjRzQ8rQOkOGrtuxmuzZ0PtTiW17lgtIUsRZU19S7gUKKw7WST40cMTWUXi4wLVzsCI/PmvX8fEM25ObMvjVpDYDqNr2B7B0dh4jfbodyIRfcY2kOlrNLgqpFkclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRAQzUMQs5hpo5iBWORKRz/N3TR1Tbb3ZAz+wwg4XsY=;
 b=tQl+8drsGPbD91AyVUHIdxU36+AWai0WAruY26uZUbumnbGhxZ8TI0sNZyOWrY9F3uHfVL7A/B1so6PwHr0VkDDztXUCF1pN/l7tHLVHTdW7PB/CEmgSYq0+9KDAU2igOR9Acxc8CK8sKxmuCtUS/SRXOTogm8zXOtz2Yz2mn+0=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4209.namprd11.prod.outlook.com (2603:10b6:a03:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 10:43:18 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 10:43:18 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Sun, Ning" <ning.sun@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 6/8] selftests/x86: Test Key Locker internal key
 maintenance
Thread-Topic: [RFC PATCH 6/8] selftests/x86: Test Key Locker internal key
 maintenance
Thread-Index: AQHW09NgX2Hb4aAMg0azd+toSyT6zKn8oUqAgAAMOQA=
Date:   Fri, 18 Dec 2020 10:43:18 +0000
Message-ID: <8ED5F7C0-B224-42E5-AE15-1891732C1076@intel.com>
References: <20201216174146.10446-1-chang.seok.bae@intel.com>
 <20201216174146.10446-7-chang.seok.bae@intel.com>
 <20201218095927.GE3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201218095927.GE3021@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [112.148.21.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b367a51a-6fc3-4275-1241-08d8a341bb57
x-ms-traffictypediagnostic: BY5PR11MB4209:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4209F015B965C880C4DC24DED8C30@BY5PR11MB4209.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JXg3GeJrMLerTWFdTRQTrbTKNs++J87gIVSfsAHwsQVw+SO5eGpVEsrTI51Z7+h3vhShpiMQbMuZzNWv18An/ld/+Wmnr5WnR97cADbW9m4dbsELPkvf7+cBv/iAg+Kf+XAxiSj7DHPQVnPHarup5uEspThOB4ZlFcKU16BGfEkJOycW8NkLoCSSZKaJvxwIJ2jUOaquRzDJufghRzloi4dt9LX/s6Y4K10+uBiUQJO1D1lqwqlprK2NL15UBj0ewUcKfJfPo3svq5/oWDHe88yXEG/SVHb4frD+wEh9TIC/RWNpMeXnOqdm+/EmTtqTQA07HO86CAUppH/s/fh0/u2tGRH/TuxlB1aWuUTXEPpy1gDaech17EkG1HFDtD1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(7416002)(2616005)(76116006)(2906002)(4744005)(54906003)(5660300002)(66946007)(8936002)(36756003)(316002)(6486002)(91956017)(33656002)(8676002)(4326008)(26005)(71200400001)(86362001)(478600001)(66446008)(66556008)(64756008)(66476007)(6512007)(6506007)(6916009)(53546011)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BSZQhr738QG/1y3FjuaHEo8ayEWmnx6564kkFeadQnH2bGGRlZHNvbNsLkim?=
 =?us-ascii?Q?VfqPvdkTplq1jQin/loHwUp4h+TJhPZXqRBPafhapLVTOIQE8xuYZl8CMHud?=
 =?us-ascii?Q?8gHImHg6jK6TRxYg4VLtT1FCsAM+nGF3PBm5HeRQWJAQKhQaj4NLaoqJ3cqz?=
 =?us-ascii?Q?RUy9NhqnK2wYPUvwjVlWbR6nbiNvx+ZlNS3c9j/q8BaCegK19YqfW24XZBNP?=
 =?us-ascii?Q?DGFo5GCXe/OSXlQoOLbFv8cJRK8ibCyp0xERLjHdREGYVolY50UCgEQgvuDr?=
 =?us-ascii?Q?LfZKVZmfz8gEN8LDRSY1z29n2EZc9uWmB814QqEL5+VXN9unyMtqdgOlLw4y?=
 =?us-ascii?Q?u3OA977BY/t7pwm5lloGdyQTG6ZMbEJjOOecoTKJjmWU2jTEB7VxqZWFaRH3?=
 =?us-ascii?Q?vt2ZOUoNDzOBpFYUl3OUOCDWlMClLgRH7NhWsmpFkDCmvoyA4Ips+MKXR887?=
 =?us-ascii?Q?rs4kA3ZeqnxILpv6R/Z+6B2DhYWC3u6pAdepS7KdWuRCq2EIiLrJcpuQPLn2?=
 =?us-ascii?Q?iUbcuQWRG+TUkttQiqU3yetf4yoKAP6kSgIY9ZyyDz8RPUNXLBhpT2pOZlli?=
 =?us-ascii?Q?hqd1evZIw/cG7zjB+KxFQH1sPdPE87YRwGW6cQScx3dZstYXTv2ke3axnB1e?=
 =?us-ascii?Q?tDohYF/OBuyyPKD5iVCGnNQQjBBFoAEi6HFasVxPOJHBjplFqS9PX6H/5RMj?=
 =?us-ascii?Q?v4JzpKQGV1cdSG9eM1AuE2oKiq7FfoMRkFLRj9uHUaedTahr90qjIqqcIINk?=
 =?us-ascii?Q?u6GdNiiGKTf5KKF1lDQXeu6Jb7YQxqCQY4BLORTo9/UXHbIPhU6WKhqj1C0R?=
 =?us-ascii?Q?jFwvGc+9VoGABaNVOXTRKu2y/TKRPoV+PeVdQGKOfVp78Xm8A1m7r4gEEs20?=
 =?us-ascii?Q?/8ImuzGXESVbGIOygc14MlPYVwOyn0k+WbIlaDdDoJ3+lGGoNuhky5P49xEV?=
 =?us-ascii?Q?u65e+qCTWA7tVtlwcv5qnX+WC/BpJRTXjVWmbzX8DIUOo+eGY6WYUx1gxzhF?=
 =?us-ascii?Q?pHKf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <688F3AADED412E47B2BBB704871B7274@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b367a51a-6fc3-4275-1241-08d8a341bb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 10:43:18.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DC9gOL5fVLEYacnsfRPqkjAbRO/0U+yE0VnOPScWk92Omsi1lDwkR/Xt5BeHFnP3f5SMlXbzXlHvhOJmWC+5vZo8GqR6I8B9uV1VJ238zPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4209
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Dec 18, 2020, at 18:59, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Dec 16, 2020 at 09:41:44AM -0800, Chang S. Bae wrote:
>> +	/* ENCODEKEY128 %EAX */
>> +	asm volatile (".byte 0xf3, 0xf, 0x38, 0xfa, 0xc0");
>=20
> This is lacking a binutils version number.

I will add the version number when any new release begins to support
this.

Thanks,
Chang
