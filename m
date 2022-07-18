Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DD5779B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGRDJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jul 2022 23:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRDJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jul 2022 23:09:14 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Jul 2022 20:09:13 PDT
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC16DF28
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Jul 2022 20:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658113755; x=1689649755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U5e2Fd3CvF4Z6YS2UjRvx6qN9eDNxQQBbTsMAIbO1sk=;
  b=BIlevOVwsNVot6ZWa6MnBKghnQ3eKmBgsOEylYvFRzYguvWnhbqNEfZs
   F4EYPy6uKoW2F+9pphF1DUm76wK/xDAiJHlPjvzy/iAL9YVeA+7OSUOwx
   QBZyniYx61yp3jMP2hTZgBKLjZeDIpNSP+DYbaW3YeWcRc5eFCjzKrpOD
   Zt/czJd01pQw/mZycE5lXFxJFwNYvzbC2jnmXc5qS5212zC0cvqaTlC8Q
   jyYOF+arluDngV8MckFkTzJx+2RGb++cwKvSuokR4KYd7sJsxY2/sA6G3
   HsOVldyi+S5qgZ26nu+mAtbIoYEe+cWo0P7phO91lQokXXvRYdZGkvjPm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="60223598"
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="60223598"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:08:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3CX9OleZlQM+a6sHT1R/k46gWB2D5cTU3O21Y4E8mhOt4R7DDbzXmM0lZJUnqZ9MjwKHzkTye4IFHkFuzRzpKkQQOj8ymI7pI7vr0/7xqJ6+1B8ZXs+p8NuNblsTqnIJ7tcuc9xSqjR3rbHDa8e5XPTDxcNFOk13hjQuG9NIlKGrsXZEW6Hy+iVlQXmBi4rUo4bsx0ZvxNbqRcnlplV5cHF5pkM7vFvewkB3FbwQ2JJPfbTkXSfpW7vfEAtbQe1boUIEWTQRemC/qYM1+7ju+/yl0y5o3vezrNgiGSTcRIZBjFhs9s9r5JGq+x4ZEenz1oKzORCKig5rNPsFCLedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5e2Fd3CvF4Z6YS2UjRvx6qN9eDNxQQBbTsMAIbO1sk=;
 b=eybgilyUItsDA9aRg2BnC8RF0e9FiE685TVFH6oiZivjFFgd11/82ao9KmimGASZ8/9AcnLSJXak/f689OLqvEs8cNjKJe7bYuak5d4QdnK5rRC2fGEQJmqsvnrH73+RRGk3uHTjzf89OKCWSP2CN5YoAymUTj/3n44afX8ipKKfgRDMcqXaoUwzeB526kZ0wWsbdBYXa6yCYuV38gqiMRIn/ugsoF6UQr9RSBK/A7BoNH5zkskSVfHT7n+6DWqwQvITj8vugXMieVG0gv0y/m8L0DvV4rljDhK+1VFVBJWs9XLsBowHQgGqVVYL4oNNo8GR6S48X1qzVJg3w+JUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5e2Fd3CvF4Z6YS2UjRvx6qN9eDNxQQBbTsMAIbO1sk=;
 b=fBmfZaOXrtN3qAMb6gBN9RoufsO+RqMZyd00zuEmY8qCSoc6VlywAOJftha0T344AXulxo+0ij1NCyFAJv3TUHCm6xnIynBHwprzJZbXZA8KlTfr0SconoC4JDMUJxN2QF0W6OdvRT77i2sT+pqsJYpVuhwFsoypYDhDSVuffZw=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSZPR01MB9533.jpnprd01.prod.outlook.com (2603:1096:604:1d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 03:08:01 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 03:08:01 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Thread-Topic: [PATCH] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Thread-Index: AQHYmlJIC25sNz3jw0SpQWU1Pz6Pr62DcoaA
Date:   Mon, 18 Jul 2022 03:08:01 +0000
Message-ID: <3b2846f3-5d90-afdb-5e18-c30120322ccb@fujitsu.com>
References: <20220718025826.29148-1-lizhijian@fujitsu.com>
In-Reply-To: <20220718025826.29148-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7c0444d-5bb6-4508-fd23-08da686ab9ae
x-ms-traffictypediagnostic: OSZPR01MB9533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAF+hqYR+XScVn9fR28t2IF17gHKHk7a1QpvwltFV2NTmFRn3BDammo2XI/gdIh5T+8JJbailPiceshtZNLlEdOiftk8qWH9bGLLQfrSi+KoCJEl0m8itB6rOpuZv1jJAm7HkZl5UKCePSHQ+cajN4XoIqcIFV0wNxqWMk/n8M472Fqguew+ONSldzSp2A4398ICopdLPkiDf7RUa86cIuOn4pmUEqtWGKZvsMEilksN7R5Y0DIMtPgfuUwQ4aNqQOLOnp60wEOcd2rvM+6EM6KBOMUbjKA0wD5yu27cHzSsAjVKgRx1iRs1z/8hytiTSsuo3zP6tvN6Ksfa2epZlLajxVLgoZnIB877LO48LRdnlS5geMyBhYs2kslAMui9cMPFlbhwUwSlIEBQUg1/J8Y/VEkft1q/QLrNCO+FmVhmom7FjRnEmKruhHgtb4JxyNvKldJ6O3HxinfBpUIuqpkiLH+i2J+MKZpnQNl55w8AVgR36qmtizvcmKvM0p3InSb1se3/vTCEt1Ndg9lKlg8XQPL40nTEyxAjkn3F4AdIlHEAWxepqXYOSn1cXSbLvXkQu+Ge9gLjrKw120iD1XttSaXmT+E6j75WLuCr4BR99g8ewhBSz72lgNdvuuzu6e7PL5dZRxcaANhqoFwZbzRbsOKRjQ+aC5mWagiYK/HDflUFRbwoZnIRrqHGwJs20vKB1ROPBuc5zHD1l5VBo5EcFZTd5BryEiAQgXKrFVnfdRsQV4ldA0FM+NfhKqohMQUzSdPOgr614BAllbB5KhQnpTSbzW5jEzxlcBU6aWmne8iR1C+50HCuMEH7mzLy/ULkt9cHKQOzW3boae44bXQFsqcYmXHz26MoJVOzmnbIuSd8gPoggusdwvl6RnjX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(54906003)(110136005)(6506007)(53546011)(6512007)(26005)(41300700001)(71200400001)(6486002)(2906002)(478600001)(66446008)(66476007)(66556008)(66946007)(64756008)(91956017)(4326008)(8676002)(316002)(8936002)(5660300002)(38100700002)(31686004)(82960400001)(122000001)(85182001)(36756003)(83380400001)(38070700005)(31696002)(86362001)(76116006)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2Y4SW9vNWtTcWtncW5nM3lFT29zckFhMUwzdS9qQXdjcEE4VkxScGk0U1Bp?=
 =?utf-8?B?L2JtZDRFc2JDL01ZZUJ0R1VDbjVMNktvQmYzUFRjeDhIcnBtQlRERTFXUTdS?=
 =?utf-8?B?V1lHUC9JeXhGL3RFYjhNRjN5TGNYVmdsUlhsTlB5K1VtdVdaYlJObFhqajU3?=
 =?utf-8?B?eUFBVG9EMDREa3lsdnJnMVJSRXhHUVV5Q09XNVBYbURGenBxTzE3dUxtdXR3?=
 =?utf-8?B?MDRZaGpUY2lWRXE4ZlU3Vy9RYUlnN2Z1YlBqM29ZTVY1SVFpY3U0eUFOQldo?=
 =?utf-8?B?OTB4RlZmaWdzYitIcGs2K0V6endZN1VwbnJQZXg0VlZ3MzUxNnFiSktGTlBi?=
 =?utf-8?B?azhSWHFzSEQzU0pCSG1JMUVWeDk3N1dVRnp2R2VKK05icE00ZTl1VVB1dGJp?=
 =?utf-8?B?cVpoZFlsVDFtTTBvakU4UTEyR3JLV3MrbFgxSSt2VFFqSXZ0OVoyWVU5ZDNw?=
 =?utf-8?B?WG9HNW42M1Z3SkFSR1hLaHBZeC9qZ1Q0U2lWdzNUUGVJSEpDbk0xNTVTOVNK?=
 =?utf-8?B?RjVIVXZrSXREYUIxTzh5d3VYOVp1eVF6TnYrTittelo5NTl2TzZ0OENSRnVI?=
 =?utf-8?B?Z21YZlpmK2Q5YURSSGtkcWN1eFAyaE5LbHpsYkFXMkk1ZjZDWkt4R2ZrQUNi?=
 =?utf-8?B?eWdDdDBQZUY3ckcrcVkwRndNaGFVbVFpRnZFM3k1cFgvYmR0R0hlMnFRNyt1?=
 =?utf-8?B?N3BOY0wvd2UyUzR1cTZFbnRFVmlNbXVSSDlhUjg4WUdLU0NUR2MrRlhOYXBZ?=
 =?utf-8?B?SUQ2c0lPcy9UcjZ0Z0h5ZnZQdVFzR0U5WUtxeG05MDV1S0lBdzgxL0hDamxL?=
 =?utf-8?B?S2ZuamdBTy9wK1orNHBjT1ZOR2IyRDJYTDI2OFJQMWY5WVdyQzlXNjRzcVh1?=
 =?utf-8?B?ZTNLS0VWK2hqSzZENXRkZWlvVGVmWW9CbnZuV0FQeTNOd0FIc0dzVWdDNi9Q?=
 =?utf-8?B?QnRycVRDb3pYTi9FQnVUTW1pQzFBMnlzTmNjZUJoTGQxT1MvZkRqWmlkRDVS?=
 =?utf-8?B?S00rZ1RrYm5Wa1kzdE9DYzU4dEtVSW9lRldaaEdPQm1zd3B2WU5iMnBsdXlC?=
 =?utf-8?B?Z3NWb2Z1dkY4c0Rvd3Nhelc4ZlROdDYwVXVlYlppL2lzVGtqWUl6L3NULzJu?=
 =?utf-8?B?L1VSZ0RNWFRPcWg5bFFQMDBTNVd6VjlGS3poN3BZUTFQc3F3NjBFSzBHSlZo?=
 =?utf-8?B?K01iUVp2SEdqZk1rWERBS2tCZWpPWVJZeFdPekFPUUFTbm91SEtRd3E4MStp?=
 =?utf-8?B?dEtXMG9ISmo1Sit3ZGhjZXRhRjM5Zy9ua1M4Y0RGejdOTXZ6TDM3dmtPWE0w?=
 =?utf-8?B?VTFMMUh0RjZSLy9nMHR4MHBKRmVzdmVkU2JJbG9XNmJNTFBtTUpKZlRJL0hS?=
 =?utf-8?B?SEVabU1rMVNObU0ydFBqMW53MFVRODN1M1RlSGYzQ0FWSVRCdnV1Ull2emhz?=
 =?utf-8?B?cFNBM0JQZFJtYTdrNUwyamMvc0hqR2FydzA3dCtpMkpHKzY4MU9MYi9uL3BZ?=
 =?utf-8?B?Z0tQN2RONEhxTDVmRVM4UXA3UnNYY1Yzb2tCekpha1c5TEUzS0RPT3JlOG81?=
 =?utf-8?B?R09XTFNNelZSeTdTY1VHQWtLZEp3bjl3enJ2dEJzeENiekVQamJ6bC85SDRv?=
 =?utf-8?B?bXdPWjFDbkI2SjlhQjlXc0l6UEppeVR2a3Yxd1k1K0ZoZkxFd3kxTHhhNWRj?=
 =?utf-8?B?b2FaQ3g1eVNTbFcrbVdtUzFMeHI1ZXhRNXBYZEE0WlAwOGFXT0dub28vRlp4?=
 =?utf-8?B?RDgzOWtNd0dncm13QVk1T0lzRHYvdkwxcTZ2QjRGVFE1MTJTRzJNVGRMZkFx?=
 =?utf-8?B?MjllZ3cxRlhDMHlWbFFYdG1RVDJ3R0tid2lhbzdEY1p6Qm9uWE1ydndGZFBk?=
 =?utf-8?B?SjBxcWZuQ2R1bnhyTEwySHFHbk42eUxPVWthOTRPc1h6TFEvYWtYeGthWUhQ?=
 =?utf-8?B?Z1hpSDFpVm5ZN2FwQW1acnVZbkdEOTVjbmJFcmU2YUIyNDB1MTNNeFBDdGIx?=
 =?utf-8?B?aFVNellDbHh5b0Y3QmJwdDRJRS9ZV241bUhlWU94QmNLUk4xTnFkbEsrWURI?=
 =?utf-8?B?UjF6aEZBMmVWNExhWTJ5bUl0NElLZ3I3VUJGTHE0WHFFSDBaaktxZkNZSUdq?=
 =?utf-8?B?TXZQdnlzc3ZaOHQ0VkFIcDZETmNHcTBvTjNWaHN3ZWxJc1FiSHJSaVcxRmhM?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693315A833A5204EA9F8520A909701C1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c0444d-5bb6-4508-fd23-08da686ab9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 03:08:01.7265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNRVObzazu+6grE6AotBtUCd8p1GFqgZ31DV9oH0fc/3PAgcily2IKf5HFdnV9HkGENF7bf9WQIGBVCSmg2ZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9533
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCk9uIDE4LzA3LzIwMjIgMTA6NTgsIExpLCBaaGlqaWFuL+adjiDmmbrlnZogd3JvdGU6DQo+
IDBEYXkvTEtQIG9ic2VydmVkIHRoYXQgdGhlIGtzZWxmdGVzdCBibG9ja3MgZm9yZXZlciBzaW5j
ZSBvbmUgb2YgdGhlDQo+IHBpZGZkX3dhaXQgZG9lc24ndCB0ZXJtaW5hdGUgaW4gMSBvZiAzMCBy
dW5zLiBBZnRlciBkaWdnaW5nIGludG8NCj4gdGhlIHNvdXJjZSwgd2UgZm91bmQgdGhhdCBpdCBi
bG9ja3MgYXQ6DQo+IEFTU0VSVF9FUShzeXNfd2FpdGlkKFBfUElERkQsIHBpZGZkLCAmaW5mbywg
V0NPTlRJTlVFRCwgTlVMTCksIDApOw0KPg0KPiB3YWl0X3N0YXRlcyBoYXMgYmVsb3cgdGVzdGlu
ZyBmbG93Og0KPiAgICBDSElMRCAgICAgICAgICAgICAgICAgUEFSRU5UDQo+ICAgIC0tLS0tLS0t
LS0tLS0tLSstLS0tLS0tLS0tLS0tLQ0KPiAxIFNUT1AgaXRzZWxmDQo+IDIgICAgICAgICAgICAg
ICAgICAgV0FJVCBmb3IgQ0hJTEQgU1RPUFBFRA0KPiAzICAgICAgICAgICAgICAgICAgIFNJR05B
TCBDSElMRCB0byBDT05UDQo+IDQgQ09OVA0KPiA1IFNUT1AgaXRzZWxmDQo+IDUnICAgICAgICAg
ICAgICAgICAgV0FJVCBmb3IgQ0hJTEQgQ09OVA0KPiA2ICAgICAgICAgICAgICAgICAgIFdBSVQg
Zm9yIENISUxEIFNUT1BQRUQNCj4NCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUga2VybmVsIGNh
bm5vdCBlbnN1cmUgdGhlIG9yZGVyIG9mIDUgYW5kIDUnLCBvbmNlDQo+IDUncyBnb2VzIGZpcnN0
LCB0aGUgdGVzdCB3aWxsIGZhaWwuDQpDb3JyZWN0Og0Kcy9vbmNlIDUncyBnb2VzIGZpcnN0L29u
Y2UgNSBnb2VzIGZpcnN0DQoNCg0KPg0KPiB3ZSBjYW4gcmVwcm9kdWNlIGl0IGJ5Og0KPiAkIHdo
aWxlIHRydWU7IGRvIG1ha2UgcnVuX3Rlc3RzIC1DIHBpZGZkOyBkb25lDQo+DQo+IEludHJvZHVj
ZSBhIGJsb2NraW5nIHJlYWQgaW4gY2hpbGQgcHJvY2VzcyB0byBtYWtlIHN1cmUgdGhlIHBhcmVu
dCBjYW4NCj4gY2hlY2sgaXRzIFdDT05USU5VRUQuDQo+DQo+IENDOiBQaGlsaXAgTGkgPHBoaWxp
cC5saUBpbnRlbC5jb20+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPiAtLS0NCj4gSSBoYXZlIGFsbW9zdCBmb3Jnb3R0ZW4gdGhpcyBwYXRjaCBzaW5jZSB0
aGUgZm9ybWVyIHZlcnNpb24gcG9zdCBvdmVyIDYgbW9udGhzDQo+IGFnby4gVGhpcyB0aW1lIEkg
anVzdCBkbyBhIHJlYmFzZSBhbmQgdXBkYXRlIHRoZSBjb21tZW50cy4NCj4gVjI6IHJld3JpdGUg
d2l0aCBwaXBlIHRvIGF2b2lkIHVzbGVlcA0KPiAtLS0NCj4gICB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9waWRmZC9waWRmZF93YWl0LmMgfCA5ICsrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3BpZGZkL3BpZGZkX3dhaXQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3Bp
ZGZkX3dhaXQuYw0KPiBpbmRleCAwNzBjMWM4NzZkZjEuLjNmN2JjNjUxN2RlYSAxMDA2NDQNCj4g
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcGlkZmQvcGlkZmRfd2FpdC5jDQo+ICsrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYw0KPiBAQCAtOTUsMjAg
Kzk1LDI3IEBAIFRFU1Qod2FpdF9zdGF0ZXMpDQo+ICAgCQkuZmxhZ3MgPSBDTE9ORV9QSURGRCB8
IENMT05FX1BBUkVOVF9TRVRUSUQsDQo+ICAgCQkuZXhpdF9zaWduYWwgPSBTSUdDSExELA0KPiAg
IAl9Ow0KPiArCWludCByZXQsIHBmZFsyXTsNCj4gICAJcGlkX3QgcGlkOw0KPiAgIAlzaWdpbmZv
X3QgaW5mbyA9IHsNCj4gICAJCS5zaV9zaWdubyA9IDAsDQo+ICAgCX07DQo+ICAgDQo+ICsJQVNT
RVJUX0VRKHBpcGUocGZkKSwgMCk7DQo+ICAgCXBpZCA9IHN5c19jbG9uZTMoJmFyZ3MpOw0KPiAg
IAlBU1NFUlRfR0UocGlkLCAwKTsNCj4gICANCj4gICAJaWYgKHBpZCA9PSAwKSB7DQo+ICsJCWNo
YXIgYnVmWzJdOw0KPiArCQljbG9zZShwZmRbMV0pOw0KPiAgIAkJa2lsbChnZXRwaWQoKSwgU0lH
U1RPUCk7DQo+ICsJCUFTU0VSVF9FUShyZWFkKHBmZFswXSwgYnVmLCAxKSwgMSk7DQo+ICsJCWNs
b3NlKHBmZFswXSk7DQo+ICAgCQlraWxsKGdldHBpZCgpLCBTSUdTVE9QKTsNCj4gICAJCWV4aXQo
RVhJVF9TVUNDRVNTKTsNCj4gICAJfQ0KPiAgIA0KPiArCWNsb3NlKHBmZFswXSk7DQo+ICAgCUFT
U0VSVF9FUShzeXNfd2FpdGlkKFBfUElERkQsIHBpZGZkLCAmaW5mbywgV1NUT1BQRUQsIE5VTEwp
LCAwKTsNCj4gICAJQVNTRVJUX0VRKGluZm8uc2lfc2lnbm8sIFNJR0NITEQpOw0KPiAgIAlBU1NF
UlRfRVEoaW5mby5zaV9jb2RlLCBDTERfU1RPUFBFRCk7DQo+IEBAIC0xMTcsNiArMTI0LDggQEAg
VEVTVCh3YWl0X3N0YXRlcykNCj4gICAJQVNTRVJUX0VRKHN5c19waWRmZF9zZW5kX3NpZ25hbChw
aWRmZCwgU0lHQ09OVCwgTlVMTCwgMCksIDApOw0KPiAgIA0KPiAgIAlBU1NFUlRfRVEoc3lzX3dh
aXRpZChQX1BJREZELCBwaWRmZCwgJmluZm8sIFdDT05USU5VRUQsIE5VTEwpLCAwKTsNCj4gKwlB
U1NFUlRfRVEod3JpdGUocGZkWzFdLCAiQyIsIDEpLCAxKTsNCj4gKwljbG9zZShwZmRbMV0pOw0K
PiAgIAlBU1NFUlRfRVEoaW5mby5zaV9zaWdubywgU0lHQ0hMRCk7DQo+ICAgCUFTU0VSVF9FUShp
bmZvLnNpX2NvZGUsIENMRF9DT05USU5VRUQpOw0KPiAgIAlBU1NFUlRfRVEoaW5mby5zaV9waWQs
IHBhcmVudF90aWQpOw0K
