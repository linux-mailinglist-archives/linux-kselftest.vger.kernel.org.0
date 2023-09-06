Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CA7935E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjIFHHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjIFHHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 03:07:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844CBCFD
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Sep 2023 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693984030; x=1725520030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=1ENyRUcBNc0aAKyKDMJVUHIXWqyvWHwY2ij1+dH7t80=;
  b=mUi0OKq84y0dBd6uJJzZ8nc4VhdlYS3watsFAuzKkzM9VeJInMMvAK3J
   TTsECEXY7FXk8NnBJN+zqRkyEF3YcuGYscwwm+ExMUzqTtGeOfQdD7uiR
   KEIKFFttNRsXCDjWqM3TDn+MzOnqeof4FF1yasMNaxMk89NnAK+mTGI7E
   Cz+ga2sf1e75A2XaWI2t7TO/aROksULVE7t0PXuE3Ao0eyMO1V2TZ+URa
   S+YIZHDcCkJl4ajUcdyxdvOMde3kNeLlRiC4PfDsznSy+wSijpIosBa0V
   Un2xp8+Z/Mb5dlpuCUTPn005sOyFIfLUMx0Qi3jB9sIBh6OUFLxhH24h/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374383850"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374383850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="915156819"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915156819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 00:04:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 00:04:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 00:04:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 00:04:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 00:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enxDONegXkxwNKMZ5Y0NQTxWRWti1S/OvAaPc/2b5wK8BQQDzTHJcRAE5XcCVdhb8KrNQB/Qtq1odh5UVbVyDk4vRgqcFSJZ69G12Yt2rwk5U1OAhdYw2sCBoxH8uAi+jtSfspAtHQ2CE6xCHA/d1HtjfXt6fHLUfxTcwkQEFSnuIE+ku+Ad2eCbuD49KrCG+CxhlmHPt502LxKW2WrLx8B7PGNur0iswcW8jQrWLweAgIixlegj/b6Dbb0NtD/5r9CQyGOI2Of0RbUdaLodjcJy7FrNlwtEQgBSD7i9igx2X4r8Ux9++6C5HYSA3rdtHnwuCoalLH9umWQtJz7NYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46/pGoVt6OG/K9uzXI7Y0fwIPgGh2ItbQOnBmffG+to=;
 b=NtsAZtsvlOgCoYs6mWi6CvbLwOuGfgSRhbqG/XBWbS14a3YLkuyM4vfXIpyFUTxls+xlr4aos1BE9u7gw0qeHa5fNSlxmjbwhfouMXF4d+uJM2zoDgBDSBV/R3WN7bdtxJstNJ2l48JdzmIaAX5BHRQ83U8hDeESvs0XMVIpnGqZirX6YJFz9J0+T1iP3aW+PuKvJZhnoT1ENT8KLcmJucLAlmlSCDNVgJmkC+n/SBhV6628NyfEnEHPKpQ0MBBSjzURgQ0D/NeuKoGruNpqczHyI5zai5dlW9qbNYVwCP1wJ5QQR8lZvodneflpwiX473G2u3DbtSdTnzmLq7EsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9)
 by SA2PR11MB5001.namprd11.prod.outlook.com (2603:10b6:806:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 07:04:56 +0000
Received: from PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::6087:c00f:948:4522]) by PH7PR11MB7964.namprd11.prod.outlook.com
 ([fe80::6087:c00f:948:4522%2]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 07:04:56 +0000
From:   "Berg, Benjamin" <benjamin.berg@intel.com>
To:     "davidgow@google.com" <davidgow@google.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Subject: Re: [PATCH 1/2] kunit: add parameter generation macro using
 description from array
Thread-Topic: [PATCH 1/2] kunit: add parameter generation macro using
 description from array
Thread-Index: AQHZ3zLXIB2LyiCDlkOmUXlcJV4o0bANXRUAgAAFZAA=
Date:   Wed, 6 Sep 2023 07:04:56 +0000
Message-ID: <fb555599ae74a52d4b4ef59c9fbd8214179be5d6.camel@intel.com>
References: <20230904132139.103140-1-benjamin@sipsolutions.net>
         <CABVgOSkvVX3D-fgmO-w6eJm7fxQL1T-tVJ6oMVQVhEn98Bmdqw@mail.gmail.com>
In-Reply-To: <CABVgOSkvVX3D-fgmO-w6eJm7fxQL1T-tVJ6oMVQVhEn98Bmdqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7964:EE_|SA2PR11MB5001:EE_
x-ms-office365-filtering-correlation-id: 066cee06-aa25-4fe4-e8a4-08dbaea793b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zgpx0YGcye8i0CQXH7RXoL6kzlPlpeNiKWue+ugF/0ePPt8MkMuaQ6H4SgtxcQJMmYvEIBq7UNmsDguA7/PXE+mJuRu/Ig2ScoqsSHU+tBKM8UTL/kKTZyyXBzEHqf5iw/zTeRF9USVRGsM3cKw9mSLpqKot3imWZLIdflth3OZ4tPvzrX0BexxMSuhexkiUJPSx62+D4vijV8BC9l1IbgPQubR82LD4Nx00PM4a/+AAG5mXn4dfm6cPPCfPZIQ/ZNEhPQgkOuFFou4oFVJ70x/tlVc2Ust5aPNO86Ut+JUBQPZWruQ44R7Djxjx8gicXlfWSRo34/gZpFYtmqtT7UU6yv4UVyioASxYZL+9ybClT4NSS3WvFsSndVH50j+zOWW1hfD9ivjCLwWboyUA5dyLymuNMIQjHsJMblHqf5N6PP0r531WcO3ptjFrY2TBNQN/Y7c85pjX+aXyQNF70vEZd3QcUWIKSbO/saeAVlrVDWQ4KKwaOdAYWDt545Al6OkhwG5O4zV2pwdtBRqga/1JWwvcMTdPjY7NfIpLl5wVl2xvsHoXP9w2UwK/NCvagaicWTlzJ1tbl4cC6ExfBmrvnh7zX6ssNy8axRpY7LE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(966005)(478600001)(66946007)(66556008)(76116006)(91956017)(66476007)(6916009)(66446008)(54906003)(64756008)(2616005)(6486002)(6506007)(71200400001)(6512007)(41300700001)(2906002)(316002)(38070700005)(38100700002)(122000001)(82960400001)(5660300002)(86362001)(36756003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2hud0dFVUErMkZBSy9iOVFEVUkyZ1gzZ3duQmRjWk93QU5jMnJsWkZWYi81?=
 =?utf-8?B?M08rbTNielBNbFd1MGlwOGQvSjdBQUNOMDhja21uZjBTZG5kSXlJeWZEOTVn?=
 =?utf-8?B?YUtlUXlRelJLNml3ZzJDUTdMdDMvQW54Rk5wbGh1UUQvOTc3S2tzTStGTi9t?=
 =?utf-8?B?cjVKRUdpUk1LOUhlSHBOSmxtbUZZTzdNa2YwUFJhWFFLQWt0L2diV3dkLzl2?=
 =?utf-8?B?MUppY01GVVpaTTNxRmx2RS81aHByTXB6M0NRdjhjSUYyOU51eWFDd1ZnQTlv?=
 =?utf-8?B?bDFCbjNRT3h3cDVRbUo1UitycjA2NllCd3BWTHZteW5QY2tKdEdpRjh4bHNQ?=
 =?utf-8?B?OEJsTENYTk5ObTFEWTRnSFBhTlp0bnB2YnJRNU1ld2ZsaXhCSm1DYzFndldz?=
 =?utf-8?B?aXJXMXhJWGdXTno0VUVMakpaaWZXaXlDb21YakE5cVN3bGlSRXhFRmVrUHoy?=
 =?utf-8?B?Nm5RcGUvakJ2U0c2WitFVGQrVHdHc09OWTFwcTYxLzFtT3dnZWt4bTdLRmhj?=
 =?utf-8?B?ZHZxVWJpVFh4a1JNOXlZTUlxQjkvMkM5L2hrNlBYL3BSVzJweTlBelIrQnk2?=
 =?utf-8?B?Yk5CN2JqWk02OXI3UkFmWXlLNU1ySCsrZHBkdTdncTkwSzFleDdYeVp1Z2Mw?=
 =?utf-8?B?eVJ5R0NXT1U0cURRYUI3d1hyQ1VSTzIwbDI1dnlkRmUrU0VxSnFPRGxDU0Ir?=
 =?utf-8?B?L2lCSVkwMjNUb3pRNU16Tno3ZDJsUTM5LzVEU1lVVDE2K3NKVHlLK1QxUS9S?=
 =?utf-8?B?dzR2NDcyOXNtc1U4THRFNWVhYnNReDJrNkNqMHR3SkhadjZkU0dmQXdpUVdq?=
 =?utf-8?B?dmpvdnN5M3VJaVRFK3kvTkJvMHJaek1KeXNwRnNpS0JJQmRhb3pWRlNLOWRC?=
 =?utf-8?B?ZlJFSlo1ckVsUzRHVGVmN3hnTExIc0IxMHdERndiNjBtYXBPQXlTSTNTakZ1?=
 =?utf-8?B?OVBYL3pxVm9lSHpBYmQxd2xjRzRXNXl2WHNJd0RpNjRNMHdjV3A1QVcyWSti?=
 =?utf-8?B?NXIzSlRCQTRoeXRxTWFQczNjUEpmSVY3RXhGZVFPZ3NoT3FXbitpK3UvL3o3?=
 =?utf-8?B?bTZtK2ZBeUVIbmZUcFIzeFYzSlZHY1VDQ3p6V29DdVZBbzBhNWRPdnB2Ylds?=
 =?utf-8?B?TzZCbDNmcHdpUXA3MndLQlhyMkJFVWQxbXU3aVBXNk5WNjdEc1hHbm8wMis3?=
 =?utf-8?B?Q245ZlBWMVk1MWlUcGhYZWUxVkQ4Y2NOQndVWTd1cVN3SmlRcWV3Tythc3lp?=
 =?utf-8?B?WnZVZjEvWjNQcVByMWNSRmI4SFpIWFlQMEt2MTVWTnlzRW9ldUlTRGVjcFRm?=
 =?utf-8?B?MU5aZjdRVjBZaWlVd0VYbk1IeU5IZHh1MzBod09uQ2FsK0taTS9jZjVYMWtV?=
 =?utf-8?B?bFdobzhtU1NHMk55cHhVT0NyakhkM2pHQkxxcEVnWkRldTNpNmFOaVNDT2Vm?=
 =?utf-8?B?UVBpZlBSOHFoVEUvQzBNTEJ6cUxCYzFOelhPckYrU0tYQzA2WHdNYU4zcG5v?=
 =?utf-8?B?dWFkTnpGQnVBNkNvcUVzR3NCdk45VXpjb0trdkM1M0lObE9lVFhYVERENzc1?=
 =?utf-8?B?U0QxL0ZrYXd6am5MbUxXWkwwSEJNVnVZQmxlYVNQS0VDdWRuUEd3ZkhYV0FK?=
 =?utf-8?B?eUxZZGY5TE5SN1VVeW1rQlh1OCtYQVNCMTZEQ1F3SFlpVjU2V1hHK0RFMDBh?=
 =?utf-8?B?cU9UZjlNbUhmNVFpQmlrWi9pcHZzVFFtejIrMVdvRnliRitLaFZjVG1FdFVx?=
 =?utf-8?B?OTQ3Q3R5OVM2amtVQzdSQmY4WHI2SjFMbVE5dFJzWUtBMXNFUkJUTTBrcVhQ?=
 =?utf-8?B?bmlQdjlrM0Y0blUzanpGSG9uZm1zeVBDcmRKK0RSUVV4dkxwYXJjcTI2U2hY?=
 =?utf-8?B?NmZ2ZGg0WXRnUWFqR2xML3ZjYkw1RnFYelMvczc4RUhQL1BXUkRKZVB5RlJ3?=
 =?utf-8?B?bXg4TUhtd1V0VUxsR0xEdVM2UThuVXB1ZDRLVUFTOWxXbXAxNElUa25tZU5D?=
 =?utf-8?B?RVpOSHZhMFZJMTRYVGd1bytYSDZSeE4rWkRrWUZnWlp0MkJ5NXdldndjQmJL?=
 =?utf-8?B?cjZZM3RBaXg0STliMVhlaExZSnNaR054U1FPcmE0Z0lUMVZwc3ZZb3NUc0Vk?=
 =?utf-8?B?RzIwY0d2a3hUUWpvRlhyckpzOUZMTWtZNUM0dnFHcmh6cXdLVk5lUVJncXRm?=
 =?utf-8?B?RUUrZ2w5a1lBV1FwSzhXZ2dkOHpuTGtPSW9NZGpqWThqZkFkcDNqUTJMS0tP?=
 =?utf-8?B?a3FGQWlFMzEzanQrNlpFRFozNmNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1506A115DF2F1041BA23F43C1AA971DA@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066cee06-aa25-4fe4-e8a4-08dbaea793b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 07:04:56.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mup4iVfVYd7OmFGTmpXaPoN/eNnp9FQzvoyVJpOI16WSTfdQK9gru4yV7+nSKbJmpskGJlKbTEw5nl/xFyFAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5001
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGksCgpPbiBXZWQsIDIwMjMtMDktMDYgYXQgMTQ6NDUgKzA4MDAsIERhdmlkIEdvdyB3cm90ZToK
PiBPbiBNb24sIDQgU2VwdCAyMDIzIGF0IDIxOjIyLCA8YmVuamFtaW5Ac2lwc29sdXRpb25zLm5l
dD4gd3JvdGU6Cj4gPiAKPiA+IEZyb206IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50
ZWwuY29tPgo+ID4gCj4gPiBUaGUgZXhpc3RpbmcgS1VOSVRfQVJSQVlfUEFSQU0gbWFjcm8gcmVx
dWlyZXMgYSBzZXBhcmF0ZSBmdW5jdGlvbgo+ID4gdG8KPiA+IGdldCB0aGUgZGVzY3JpcHRpb24u
IEhvd2V2ZXIsIGluIGEgbG90IG9mIGNhc2VzIHRoZSBkZXNjcmlwdGlvbiBjYW4KPiA+IGp1c3Qg
YmUgY29waWVkIGRpcmVjdGx5IGZyb20gdGhlIGFycmF5LiBBZGQgYSBzZWNvbmQgbWFjcm8gdGhh
dAo+ID4gYXZvaWRzIGhhdmluZyB0byB3cml0ZSBhIHN0YXRpYyBmdW5jdGlvbiBqdXN0IGZvciBh
IHNpbmdsZSBzdHJzY3B5Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBCZXJnIDxi
ZW5qYW1pbi5iZXJnQGludGVsLmNvbT4KPiA+IC0tLQo+IAo+IExvb2tzIGdvb2QgdG8gbWU6IHRo
aXMgd2lsbCBiZSBtdWNoIG1vcmUgY29udmVuaWVudC4gVGhlIGFjdHVhbAo+IGltcGxlbWVudGF0
aW9uIGxvb2tzIHNwb3Qgb24sIGp1c3QgYSBzbWFsbCBjb21tZW50IGFib3V0IHRoZQo+IGRvY3Vt
ZW50YXRpb24gY2hhbmdlLgo+IAo+IEl0IG1heSBtYWtlIHNlbnNlIHRvIHdyaXRlIHNvbWUgdGVz
dHMgYW5kL29yIHNvbWUgZm9sbG93LXVwIHBhdGNoZXMgdG8KPiBleGlzdGluZyB0ZXN0cyB0byB1
c2UgdGhpcyBtYWNybywgdG9vLiBJJ20ganVzdCBhIGxpdHRsZSB3YXJ5IG9mCj4gaW50cm9kdWNp
bmcgc29tZXRoaW5nIHRvdGFsbHkgdW51c2VkLiAoSSdtIGhhcHB5IHRvIGRvIHRoZXNlIG15c2Vs
ZiBpZgo+IHlvdSBkb24ndCBoYXZlIHRpbWUsIHRob3VnaC4pCgpJIGFncmVlLiBJIGFtIGhhcHB5
IHRvIHN1Ym1pdCBvbmUgb3IgbW9yZSBwYXRjaGVzIHRvIGNoYW5nZSB0aGUKZXhpc3RpbmcgdXNl
cnMuIFRoZSBxdWVzdGlvbiB3b3VsZCBiZSBob3cgd2UgcHVsbCBzdWNoIGEgY2hhbmdlIGluLgpT
aG91bGQgaXQgYmUgc3VibWl0dGVkIHNlcGFyYXRlbHkgZm9yIGVhY2ggc3VidHJlZSBvciBjYW4g
d2UgcHVsbCB0aGVtCmFsbCBpbiBhdCB0aGUgc2FtZSB0aW1lIGhlcmU/CgpCZW5qYW1pbgoKPiAK
PiBSZWdhcmRsZXNzLCB3aXRoIHRoZSBkb2N1bWVudGF0aW9uIGZpeCwgdGhpcyBpczoKPiBSZXZp
ZXdlZC1ieTogRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUuY29tPgo+IAo+IENoZWVycywKPiAt
LSBEYXZpZAo+IAo+ID4gwqBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC91c2FnZS5yc3Qg
fMKgIDcgKysrKy0tLQo+ID4gwqBpbmNsdWRlL2t1bml0L3Rlc3QuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+ID4gwqAyIGZp
bGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC91c2FnZS5yc3QKPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvdXNhZ2UucnN0Cj4gPiBpbmRleCBjMjdlMTY0
NmVjZDkuLmZlOGMyOGQ2NmRmZSAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRv
b2xzL2t1bml0L3VzYWdlLnJzdAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3Vu
aXQvdXNhZ2UucnN0Cj4gPiBAQCAtNTcxLDggKzU3MSw5IEBAIEJ5IHJldXNpbmcgdGhlIHNhbWUg
YGBjYXNlc2BgIGFycmF5IGZyb20gYWJvdmUsCj4gPiB3ZSBjYW4gd3JpdGUgdGhlIHRlc3QgYXMg
YQo+ID4gwqDCoMKgwqDCoMKgwqAgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cmNweShkZXNjLCB0LT5zdHIpOwo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gLcKgwqDCoMKg
wqDCoCAvLyBDcmVhdGVzIGBzaGExX2dlbl9wYXJhbXMoKWAgdG8gaXRlcmF0ZSBvdmVyIGBjYXNl
c2AuCj4gPiAtwqDCoMKgwqDCoMKgIEtVTklUX0FSUkFZX1BBUkFNKHNoYTEsIGNhc2VzLCBjYXNl
X3RvX2Rlc2MpOwo+ID4gK8KgwqDCoMKgwqDCoCAvLyBDcmVhdGVzIGBzaGExX2dlbl9wYXJhbXMo
KWAgdG8gaXRlcmF0ZSBvdmVyIGBjYXNlc2AKPiA+IHdoaWxlIHVzaW5nCj4gPiArwqDCoMKgwqDC
oMKgIC8vIHRoZSBzdHJ1Y3QgbWVtYmVyIGBzdHJgIGZvciB0aGUgY2FzZSBkZXNjcmlwdGlvbi4K
PiA+ICvCoMKgwqDCoMKgwqAgS1VOSVRfQVJSQVlfUEFSQU1fREVTQyhzaGExLCBjYXNlcywgc3Ry
KTsKPiAKPiBJJ2Qgc3VnZ2VzdCBlaXRoZXIgZ2V0dGluZyByaWQgb2YgdGhlIGNhc2VfdG9fZGVz
YyBmdW5jdGlvbiB0b3RhbGx5Cj4gaGVyZSwgb3Igc2hvdyBib3RoIHRoZSBtYW51YWwgS1VOSVRf
QVJSQVlfUEFSQU0oKSBleGFtcGxlLCBhbmQgdGhlbgo+IHBvaW50IG91dCBleHBsaWNpdGx5IHRo
YXQgS1VOSVRfQVJSQVlfUEFSQU1fREVTQygpIGNhbiByZXBsYWNlIGl0Lgo+IAo+IE90aGVyd2lz
ZSB3ZSBlbmQgdXAgd2l0aCBhIHZlc3RpZ2lhbCBmdW5jdGlvbiB3aGljaCBkb2Vzbid0IGRvCj4g
YW55dGhpbmcgYW5kIGlzIGNvbmZ1c2luZy4KPiAKPiAKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAg
Ly8gTG9va3Mgbm8gZGlmZmVyZW50IGZyb20gYSBub3JtYWwgdGVzdC4KPiA+IMKgwqDCoMKgwqDC
oMKgIHN0YXRpYyB2b2lkIHNoYTFfdGVzdChzdHJ1Y3Qga3VuaXQgKnRlc3QpCj4gPiBAQCAtNTg4
LDcgKzU4OSw3IEBAIEJ5IHJldXNpbmcgdGhlIHNhbWUgYGBjYXNlc2BgIGFycmF5IGZyb20gYWJv
dmUsCj4gPiB3ZSBjYW4gd3JpdGUgdGhlIHRlc3QgYXMgYQo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+
ID4gCj4gPiDCoMKgwqDCoMKgwqDCoCAvLyBJbnN0ZWFkIG9mIEtVTklUX0NBU0UsIHdlIHVzZSBL
VU5JVF9DQVNFX1BBUkFNIGFuZCBwYXNzCj4gPiBpbiB0aGUKPiA+IC3CoMKgwqDCoMKgwqAgLy8g
ZnVuY3Rpb24gZGVjbGFyZWQgYnkgS1VOSVRfQVJSQVlfUEFSQU0uCj4gPiArwqDCoMKgwqDCoMKg
IC8vIGZ1bmN0aW9uIGRlY2xhcmVkIGJ5IEtVTklUX0FSUkFZX1BBUkFNIG9yCj4gPiBLVU5JVF9B
UlJBWV9QQVJBTV9ERVNDLgo+ID4gwqDCoMKgwqDCoMKgwqAgc3RhdGljIHN0cnVjdCBrdW5pdF9j
YXNlIHNoYTFfdGVzdF9jYXNlc1tdID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEtVTklUX0NBU0VfUEFSQU0oc2hhMV90ZXN0LCBzaGExX2dlbl9wYXJhbXMpLAo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHt9Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9r
dW5pdC90ZXN0LmggYi9pbmNsdWRlL2t1bml0L3Rlc3QuaAo+ID4gaW5kZXggNjhmZjAxYWVlMjQ0
Li5mNjBkMTFlNDE4NTUgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2t1bml0L3Rlc3QuaAo+ID4g
KysrIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgKPiA+IEBAIC0xNTE2LDYgKzE1MTYsMjUgQEAgZG8K
PiA+IHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuCj4gPiBOVUxMO8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+
IMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gCj4gPiArLyoqCj4gPiArICog
S1VOSVRfQVJSQVlfUEFSQU1fREVTQygpIC0gRGVmaW5lIHRlc3QgcGFyYW1ldGVyIGdlbmVyYXRv
ciBmcm9tCj4gPiBhbiBhcnJheS4KPiA+ICsgKiBAbmFtZTrCoCBwcmVmaXggZm9yIHRoZSB0ZXN0
IHBhcmFtZXRlciBnZW5lcmF0b3IgZnVuY3Rpb24uCj4gPiArICogQGFycmF5OiBhcnJheSBvZiB0
ZXN0IHBhcmFtZXRlcnMuCj4gPiArICogQGRlc2NfbWVtYmVyOiBzdHJ1Y3R1cmUgbWVtYmVyIGZy
b20gYXJyYXkgZWxlbWVudCB0byB1c2UgYXMKPiA+IGRlc2NyaXB0aW9uCj4gPiArICoKPiA+ICsg
KiBEZWZpbmUgZnVuY3Rpb24gQG5hbWVfZ2VuX3BhcmFtcyB3aGljaCB1c2VzIEBhcnJheSB0byBn
ZW5lcmF0ZQo+ID4gcGFyYW1ldGVycy4KPiA+ICsgKi8KPiA+ICsjZGVmaW5lIEtVTklUX0FSUkFZ
X1BBUkFNX0RFU0MobmFtZSwgYXJyYXksCj4gPiBkZXNjX21lbWJlcinCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiA+ICvCoMKgwqDCoMKgwqAgc3RhdGljIGNvbnN0IHZvaWQgKm5hbWUjI19nZW5fcGFy
YW1zKGNvbnN0IHZvaWQgKnByZXYsIGNoYXIKPiA+ICpkZXNjKcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgCj4gPiB7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5cGVvZigoYXJyYXkpWzBdKSAqX19u
ZXh0ID0gcHJldiA/Cj4gPiAoKHR5cGVvZihfX25leHQpKSBwcmV2KSArIDEgOiAoYXJyYXkpO8Kg
wqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKF9fbmV4dCAt
IChhcnJheSkgPCBBUlJBWV9TSVpFKChhcnJheSkpKQo+ID4ge8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJzY3B5KGRlc2Ms
IF9fbmV4dC0+ZGVzY19tZW1iZXIsCj4gPiBLVU5JVF9QQVJBTV9ERVNDX1NJWkUpO8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4KPiA+IF9fbmV4dDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+IH3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4KPiA+IE5V
TEw7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsK
PiA+IMKgLy8gVE9ETyhkbGF0eXBvdkBnb29nbGUuY29tKTogY29uc2lkZXIgZXZlbnR1YWxseSBt
aWdyYXRpbmcgdXNlcnMKPiA+IHRvIGV4cGxpY2l0bHkKPiA+IMKgLy8gaW5jbHVkZSByZXNvdXJj
ZS5oIHRoZW1zZWx2ZXMgaWYgdGhleSBuZWVkIGl0Lgo+ID4gwqAjaW5jbHVkZSA8a3VuaXQvcmVz
b3VyY2UuaD4KPiA+IC0tCj4gPiAyLjQxLjAKPiA+IAo+ID4gLS0KPiA+IFlvdSByZWNlaXZlZCB0
aGlzIG1lc3NhZ2UgYmVjYXVzZSB5b3UgYXJlIHN1YnNjcmliZWQgdG8gdGhlIEdvb2dsZQo+ID4g
R3JvdXBzICJLVW5pdCBEZXZlbG9wbWVudCIgZ3JvdXAuCj4gPiBUbyB1bnN1YnNjcmliZSBmcm9t
IHRoaXMgZ3JvdXAgYW5kIHN0b3AgcmVjZWl2aW5nIGVtYWlscyBmcm9tIGl0LAo+ID4gc2VuZCBh
biBlbWFpbCB0byBrdW5pdC1kZXYrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4KPiA+IFRv
IHZpZXcgdGhpcyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQKPiA+IGh0dHBzOi8vZ3JvdXBz
Lmdvb2dsZS5jb20vZC9tc2dpZC9rdW5pdC1kZXYvMjAyMzA5MDQxMzIxMzkuMTAzMTQwLTEtYmVu
amFtaW4lNDBzaXBzb2x1dGlvbnMubmV0Cj4gPiAuCgpJbnRlbCBEZXV0c2NobGFuZCBHbWJIClJl
Z2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55
ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRwOi8vd3d3LmludGVsLmRl
PgpNYW5hZ2luZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBTaGFyb24gSGVjaywg
VGlmZmFueSBEb29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJk
OiBOaWNvbGUgTGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVyY2lhbCBSZWdpc3Rl
cjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=

