Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B53047A58D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 08:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhLTHz1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 02:55:27 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:31244 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232332AbhLTHz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 02:55:26 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2021 02:55:25 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1639986926; x=1671522926;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Z0fVRwJ9Eah6csm8WPXcYzuGIo6DTJzffMi8orzS7bc=;
  b=YnlMBieWPsHLEBPFwVhlhit/Cnb/ZjjZGMPPOpj7hJ7mNSnNl/FGAhFs
   nEWWrLWsTB9mzVjCbvJh1QehPrtERYkiA5W0qVZyrsGHH1L/u8DQphYOc
   46CXuWoFQZPfx6BQD0aM34rZ8ZUNJmW3fVUX6SfB5yrUOrsei83qt67/M
   c8COwlxLc9GgwlwxjX57BvO7Z6bzz7x4srIsJEelmikzX5qbn7z3HuQJW
   ZaSiHN0TjR2qFFtZm0c1PW7wUrYLYKOu9nso1aLS5klG9j+xwWGqtBGO0
   k7uPjBlJ7eYzlarXq2/C7/Ii39hnJ6SkAfX4r8gDPZKwBBnoWaDgn43kj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="46197859"
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="46197859"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 16:48:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N79revb11mqmtG46IypuA5P95t508V4WcSWfyXwK7vkpmzzN0sGVm31fHuwBAPg4nTqkgdSKDVdp0sxfoQEwBMM6kZe3siS0lHcVXNcc+3+g7OgY1rRis/nGGbjAacncoK0mUJc/LQMQnJ1gz0LMKsx0D5JY+BDDurtWI+wCJT0JGa60aVdT8qExlpSwdO2PRbXGea9leLF/jc5E3Y1o3EsYTfxYpzBsbeNA6xMOZX2nfqhUD1t1tSFOxl8s3DVwSealpTyZkNj/1NcmdfpyIykPdd7h+MIe3E1oMjhfTr+bmIT8fB5FQVC3MWAVr18h+Kh4adDaUy6Y8oqPhBHiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0fVRwJ9Eah6csm8WPXcYzuGIo6DTJzffMi8orzS7bc=;
 b=AngeyLRX6SkAnqcAKbh89AfnmZDs/Pi+4Kn+5aOpZRkdL5Sk52gxuJATmte1lZa18IPF+Xd5I6VNX8tuppqH/vWAihbZq76COIKb+Jhm5Ok99cy/gQjoWwpDmh6StCJAIjbE+7RUPkRIAd05PDDaxaFNKOzTtaX+IBcX2dGfcy6O27nq+yt2zIi6ABVb70BbJ/gsUTUIfqCTiVGqYNjY2KiH9TRYYRr359ihT2pPWNioY+PjrKJHLXRhRJFQWILq7hvJUZN3JDZSalxUpLU/IdUpgYBS8972kVM+CpuFbJgzTLxcBh79iIz2PIyflyFqVH+CZtcPBw580FNN5J7BkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0fVRwJ9Eah6csm8WPXcYzuGIo6DTJzffMi8orzS7bc=;
 b=GWqbIO+xZ68bjw2kgJhMHvrC48FKgUfccVyuArEH0AiRV9RjMitOq5C0s7jlqNuV97vYNdH8ieBru2oxo5XCimkXCaG3FlEzGqX1S7puNN7zqe6aEiJYHrTF9n6/+YD0afzUdFonQr/AMAkpP3+k5ZKmEyqFDbyFKW2bMkIbNEY=
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com (2603:1096:604:17b::10)
 by OSZPR01MB8749.jpnprd01.prod.outlook.com (2603:1096:604:157::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 07:48:09 +0000
Received: from OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26]) by OS3PR01MB7706.jpnprd01.prod.outlook.com
 ([fe80::e93c:fa4b:dda5:ff26%9]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:48:09 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Kees Cook <keescook@chromium.org>
CC:     kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        "zhoujie2011@fujitsu.com" <zhoujie2011@fujitsu.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>
Subject: ./kselftest/prefix.pl read from pipe will block until the front
 command and its child processes all exit
Thread-Topic: ./kselftest/prefix.pl read from pipe will block until the front
 command and its child processes all exit
Thread-Index: AQHX9XXuExeU2kRG2UiATf2fe9M6KQ==
Date:   Mon, 20 Dec 2021 07:48:09 +0000
Message-ID: <78c1131a-532f-313d-3823-40e34421ac87@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c4bd13e-9cc6-4d8e-1057-08d9c38d1142
x-ms-traffictypediagnostic: OSZPR01MB8749:EE_
x-microsoft-antispam-prvs: <OSZPR01MB87499DE2EE1A955F091D50B1A57B9@OSZPR01MB8749.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjGgqMeNcIEbYgQ3ETJE2SqwSCJkxrYr8g+OV5BgVwYms+L98/XEPWxuZG9bq7+ZM+p01ebWHd0PKJsnrcMeajBtarBtgvEBiW/hbnGzB2rzhrJHDlytDtVw4y4J3MtEF6diDnIz282vaU3s92+Z+j5eDyq4Uc50NnbpMVSLLmMU1lCzRT5lvefXu15uEKMI6RJfCIwK5bKT4JFnn4xm1R3gkXnnVEq+Mt8/W4fONO4wu8Ea7XWZaJjvRUURljvPlhlsWDUpXwDjl9L/vIbvck5NNA4x6YeZSPX8By8Az3CB0Bi4eTbAOz8VtDZmiL1cGkaTypPYATQHxCZWZ5ojQLIZ218o/kjNtNw/TM0BeESSUMSwJhzSSSsCe6hKb4bv88g1JngGzMa5McspFnacgnH/Nf9/htqwDGtklDApVxTE6cfYIebSX29ZV3NjOY8AVnct01hsh6T//Wt2qEaP4ovySN3Jszss9Jr0pATo3VY+H++yRTamnzSfsD5N0iYzJMAo7UPDXxZkcOPVy0AkkygUFe0EXr79uB2RGTfYgmPCVjD23adXbmV0Nnzzh+BAgWl0dcehgmy1H+mM5KRZsdLvXtJmkEtLOXbAqfMSV8GjPzPjjn/rLB6PElxM0FLShaBBljqX/oc0qlhnDH4ipzx6DJ8B+ncDc3rgiMS4l38caqJrUiN4wkGHfGXZ4vFauuPUadxsvi88clzM2Qu/4TeGfw184NHw1V49qxHafpzLt4o4OhtzVwitJIWBAvLou2e6el8lBnFGtGku8L/lQElA6o+AROEyUrq+SY/XR64PBluhCUJpk4EK/EtJ7KXFhxliNLIV6MRSSXxrERBP3FpnSTqC6CC4wa2bomHBDqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7706.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(66446008)(82960400001)(64756008)(66556008)(2906002)(966005)(66476007)(76116006)(508600001)(91956017)(66946007)(83380400001)(38100700002)(122000001)(6506007)(5660300002)(6486002)(6512007)(2616005)(31696002)(8676002)(26005)(8936002)(186003)(86362001)(4326008)(6916009)(71200400001)(38070700005)(36756003)(31686004)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3VBTkJrczIyUVZMbWdIY3RMZjFaRE9hNFZ3R1d1SlptL21LVE1jSHdXYnJa?=
 =?utf-8?B?ZjFUTDZuRG4xV1BGeVVZUzR6UnpnUm9nek1DRHVtWTZLOGppa1NQNHR2MkJi?=
 =?utf-8?B?V2NGd3Vxc2xvMno4bU5HK2VuZmkxVVhpd2xvdlcrS1NwNSsvanFmUFg3Y09q?=
 =?utf-8?B?elFuaDRKUFFCcHlOUFNKQXd1MGtkUnBFTFNHem0xTFlQUnBKcUpkR0FBcXVo?=
 =?utf-8?B?M1ZxcUJvaVZJR05RajVWTkRlRk9FMGVRTis3TFlmd3E0WGVNcmFuN1UxeXJ0?=
 =?utf-8?B?aWs2NU9TeWJkd255ZWx4Wjl0SUpQZms5emh4ckJOWmw0VGVqbW5ZQzRzL2N6?=
 =?utf-8?B?dmQwbytsSks0UzhoZk5Haks4VG9NVlBrSnppNmlwdU1zZmN4dDE2ZGJJWThV?=
 =?utf-8?B?YUIvamV5QXJoMXNhWFkraFVzZHpRVW5iQXpEdjlSQS9rbnZERVBjVk81eFgw?=
 =?utf-8?B?dkYzTCtNVllGUC82bmVPREIwaElxU2lMM1BRMFFZYmZkRTF0dTRkTjB6aWFl?=
 =?utf-8?B?bGFmRGRnSHBob1kzUk8xVlVzbnZML3E1QTlWMDZxanJvanJiVHA2TncwV3U0?=
 =?utf-8?B?UVpWN0M5MnRnbmdOZS8yOVJjYWNUVVlLZXF3OFpqTnF2TUdTS0dtTFRHMCtQ?=
 =?utf-8?B?aE1PaHBHbkxSWGJtQW16NzVmRXpNWmRkeDJIdjVGbFhuKzQrRWRXNk4yakpF?=
 =?utf-8?B?YWIwRE5ZNEpOeFNLVm9McnVXY1IxSmdKWjJGSklnRG94SzIvZnR0V2g1ZnpE?=
 =?utf-8?B?RHE0dHdLQzU2eXhPVEZ1L0tXQnFNNHh4UnM5MDhYNHZLaTJRZHU5UDlvL09E?=
 =?utf-8?B?Q3ZSM3dKeHpzOURFUjMvRkxLUHRoYldodGxiMWNiL0JSL3gyOUxVMHhJRTN3?=
 =?utf-8?B?S05EeFpSeDdTTmc1cjVSbnlndEhSdEU4Nm5uenhLZmswdTFxbE1Wd1RoZlF0?=
 =?utf-8?B?R2Fob01vOVBFdjgwTS9QMGRsT3N1bVdIcHV4TzhPOE93RUtwaXNwaUdldmlP?=
 =?utf-8?B?Mko0SW5oblgzR2V4dGtXZEkvUERqMEtLak1iRDJRdFpsNVhpNFpGNnhmOXRu?=
 =?utf-8?B?b01NaHVxYkRFTEVOaFJaZ0FIcThEWWpKN2RoR0JsOVNaQ3J0YnZLK0pmcVRL?=
 =?utf-8?B?aHVDVm1GVVV5bWVicmZqaXh2V1JHQ20raG1yOWo1Q3VYclUxRk5zM09pejE3?=
 =?utf-8?B?QXF5Q1dGZzhMU201eFJadVl2eXo5S2hMaXlIaGF0VGU3Y1lnWUhPTEJlRmsr?=
 =?utf-8?B?cjhzRkdvczhiR1l1NkJsK0xGN3hER2hackVmdHRPem1UcVA1aEI2WWowZWdS?=
 =?utf-8?B?RUNSdlNWSHlqRzk4c29DaTdwaVFQM2xEcWo0SlJWYkE1TkpXNWxvY1owdWM4?=
 =?utf-8?B?dy9QektoMUhlcmw2cFljaURubm1lWkNMYmptMmpWVGtNL0lrL0ZjUDJNQ0JK?=
 =?utf-8?B?YmhCUTZWRXNJdjlISFBzTVZrSCsvRkhaUnlQR2txb2Y5K2Y0eWVHSlliVGNQ?=
 =?utf-8?B?MTE2QVhobk1yTW5lRW1ObTF2TkNpOFlGOWNCbkZWUTlXTGxrbUNWc3RnTkRn?=
 =?utf-8?B?MGxYWi9ZcXhhWFg4TFVQQ3lJR3I0S1hETXdQK2xXQmRlK25GR0xyaUhyT21i?=
 =?utf-8?B?ZnBDdEVqUHF3N0wwT0xzZ0pYMW5LUWxCOWU5VmdrYjNHSVhrOGZoSE8xQVJT?=
 =?utf-8?B?R1dCZzVaZW9EMndaVHIvZFgrOVg0WDRGTHVYckxVUnN4cXZKdnFMcmMzNGho?=
 =?utf-8?B?amYvOFkwK3kvQ2ZzN0xDaE8yclJaRFoyQ3ZCU25HTmVOamsyb2Q1SjFoQW9t?=
 =?utf-8?B?cmZLYjczSTh2RE5rd3Y4WThURG1jODRyWWlYaGlLdWRXNWRmTFBkOEcxYUtz?=
 =?utf-8?B?YWNzRDd4QzFyUXBZcDlzZm1PdUkzWHZyNzFIWDJ5QXNWeDNqa1F1VzltdnRU?=
 =?utf-8?B?ZXhjRUNjdFZRQ3BrbGQ0dmt6ZTZnM0JxV2ZWWTdmN2xzMUVKU21kOFlzM3Z5?=
 =?utf-8?B?Qm1XZzQvZGhhdXBTZWpCdXJGdWRxYkJ5UlJOaGNYL2pPZVZkNGxDOUFKN0FF?=
 =?utf-8?B?em5sTGs5MlYrN3lCTkNQSWFsYkhQZVhPYzRKbGVLZGtpeGRYSHRxRWp1VGJo?=
 =?utf-8?B?WjdBN1JKYkdmcFpXaEVINS9JK2dZcjJnOFJ0eUU5NzFNcTNsNm1abElOMy9T?=
 =?utf-8?Q?DBfac+KglwrhzicEFKDMCbs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14EF94BBA27704CAF3E807B9EC490F6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7706.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4bd13e-9cc6-4d8e-1057-08d9c38d1142
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 07:48:09.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLptZhvTLBibT7Hd7ZmN7TjFEJ8M03PFdTsfGjbAek6OGesNBy0heObFIKQgLZT6j1ELasUr/6iK8yX1k4MpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8749
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgZm9sa3MsIEtlZXMNCg0KVGhpcyBpc3N1ZSBjb25mdXNlcyB0aGUgTEtQLzBEYXkgcm9ib3Qg
Zm9yIGEgbG9uZyB0aW1lLg0KVGFrZSBiZWxvdyBzY3JpcHQgYXMgYW4gZXhhbXBsZToNCg0KbGl6
akBGTlNUUEM6fi93b3Jrc3BhY2UvY29sby9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cyQg
Y2F0IGEuc2gNCiMhL2Jpbi9iYXNoDQpzbGVlcCAxMCAmDQplY2hvIDEwMDAwMDAwMDAwMDAwMDAN
Cg0KbGl6akBGTlNUUEM6fi93b3Jrc3BhY2UvY29sby9saW51eC90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cyQgdGltZSAuL2Euc2ggfCAuL2tzZWxmdGVzdC9wcmVmaXgucGwNCiMgMTAwMDAwMDAwMDAw
MDAwMA0KDQpyZWFswqDCoMKgIDBtMTAuMDA0cw0KdXNlcsKgwqDCoCAwbTAuMDEycw0Kc3lzwqDC
oMKgIDBtMC4wMDFzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KQWx0
aG91Z2ggdGhlIGZpcnN0IHNjcmlwdCBhbHJlYWR5IGV4aXRlZCzCoCAuL2tzZWxmdGVzdC9wcmVm
aXgucGwgd2lsbCBibG9jayB1bnRpbCAic2xlZXAgMTAgJiIgZXhpdC4NClRoYXQgbWVhbnMgb25j
ZSBzb21lIG9mIHRoZSBjaGlsZCBwcm9jZXNzIGNhbm5vdCBmaW5pc2gvZXhpdCBpdHNlbGYsIGZv
ciBleGFtcGxlLCBvbmUgdGVzdA0KYmVjb21lcyAqem9tYmllKiBmb3Igc29tZSByZWFzb25zLCB0
aGUgd2hvbGUga3NlZmx0ZXN0IGZyYW1ld29yayB3aWxsIGhhbmcgZm9yZXZlci4NCg0KSW4gYWRk
aXRpb24swqAgY3VycmVudGx5IGtzZWZsdGVzdCB0aW1lb3V0IHNjaGVtZVsxXVsyXSB3aWxsIG5v
dCBzaWduYWwva2lsIHRoZSBjaGlsZCBwcm9jZXNzZXMsIHRoYXQNCm1ha2UgdGhlIGJsb2NraW5n
IG9mdGVuIGhhcHBlbnMuDQoNClNpbmNlIGknbSBub3QgZmFtaWxpYXIgd2l0aCBwZXJsLCBub3Qg
c3VyZSB3aGV0aGVyIGl0IGNhbiBmaW5pc2ggaXRzZWxmICpkaXJlY3RseSogd2hlbiBmaXJzdC9m
cm9udA0KY29tbWFuZChleGNsdWRpbmcgY2hpbGQgcHJvY2Vzc2VzKSBleGl0cy4NCg0KDQpbMV06
IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIxLzEyLzE3LzE0MA0KWzJdOiBodHRwOi8vbGttbC5p
dS5lZHUvaHlwZXJtYWlsL2xpbnV4L2tlcm5lbC8yMDA0LjEvMDIzNzkuaHRtbA0KJCBtYW4gdGlt
ZW91dA0KIMKgwqDCoMKgwqDCoCAtLWZvcmVncm91bmQNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB3aGVuIG5vdCBydW5uaW5nIHRpbWVvdXQgZGlyZWN0bHkgZnJvbSBhIHNoZWxsIHByb21w
dCwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvdyBDT01NQU5EIHRvIHJlYWQgZnJv
bSB0aGUgVFRZIGFuZCBnZXQgVFRZIHNpZ25hbHM7IGluIHRoaXMgbW9kZSwgY2hpbGRyZW4gb2Yg
Q09NTUFORCB3aWxsIG5vdCBiZSB0aW1lZCBvdXQNCg0KDQpUaGFua3MNClpoaWppYW4=
