Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905765779AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jul 2022 04:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiGRC6s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Jul 2022 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRC6r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Jul 2022 22:58:47 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F8216;
        Sun, 17 Jul 2022 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658113126; x=1689649126;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nWz9yqU65FqOTAAyCAFqZLellw9vcuTqNn7PtzRmbHE=;
  b=kDItVc1JGppTUAJ0kDOxgIioxcrn1l4npv7eWZ7UOvpQBtzivf/1ZPoy
   jmbrnjqKgaLMbVsE5ljTkuvts2827/o3B7XdS2HAzFPZ3wcTzX0Ds+z+1
   f4jGOuGLCphfMNv4M5egVC7v3SLTvZoyn4qaxvHP+IDG+yLlwIF0KgD4w
   d8Bde6rwwt2W9iIWwq4QIjIR3+0l/M91p8N1Vxz5dsog8OBnWRunwFdB0
   i9JvVgP8Y9ZgBfELYMIY5LTZYc2HiM1aI+7skSWn2QZTCJG3pBJKWNUUM
   GI6d6maULn+ZP7FS81hROseBe5fi2L+R+zYlK7KgkeBX4wCR7CroJhvOz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="68828619"
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="68828619"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:58:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe1KG80nkj+ShptGmilabnsPxXp+X16/qWQz3+RMviKQns+WnUWU7BvzVsRWuZxYjL4RwBz/Y2Pj4p1lQJAsJbBi541kkuByMMwx752Uvn7pcR/S7loE2PxNqvHs83Rp0wIiu10UJF5PLdq8cUPgCYyTkU8mgqbCwx8Ncx6IIkbF6pSSSw4FQqhvM19gF6/9UoUSzsZOBzLvNXyvEPWKkXmZAhOwUFkB5ik34CNJyo87N0hwsLqMtTVqNSkIBOCWMb+otY1qtf6lO+5XPs6agFfywn6mVf0rLoscDafpXL3GxY+ZRC2wQoK/OGwmPqneiPd7v3hZvbhW1MQZa9GE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWz9yqU65FqOTAAyCAFqZLellw9vcuTqNn7PtzRmbHE=;
 b=Va/p+PpiL+yoYAA1kufyrjg3O3B/degfp3bzfGUFQJjBOb4G0p+AG+/edaG/4NvFargad67IduhyISlWNI1Z/WCoLlS+Nm9TEAXtyzIBPEFJD51Ke9PRKEE7PzED82Sgz5JA1rsiEPd4o4K/7x0MUDa2kg6K2dwyt57w1E2inuTytUV3EZDMoXu7GyWs71s/ktMlNcnh29oOSSo+NIr868HqAzbfP0wOWuPVKi+ae80gL2TTVnkYcwa8XNGeYnaejujEi7IK6JdsulFQbHM8YQLduehJRZI3+TZjYIwlnvrGB6AkhaZ/e6AWGSaw4Vupzxp2TKpzrDCkGiUgUqdt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWz9yqU65FqOTAAyCAFqZLellw9vcuTqNn7PtzRmbHE=;
 b=H5MHjEDK0ktKDkChdGpjs+mQpi6YOtljZ+7Ti5mZpfLiERaMkcChA/y3tRjHx7iiH/tkhMslJttm3hcDQtAPoCTtr96shbonRjqLmNA89dqVLwYfP7ZgcDGcHc1WbVnBEkxk3UjgF51oDY5aBLKv4H5/BJHKwUZraY73Uyx/2SM=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB2901.jpnprd01.prod.outlook.com (2603:1096:604:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 18 Jul
 2022 02:58:39 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 02:58:39 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ksefltest: pidfd: Fix wait_states: Test terminated by timeout
Thread-Topic: [PATCH] ksefltest: pidfd: Fix wait_states: Test terminated by
 timeout
Thread-Index: AQHYmlJIC25sNz3jw0SpQWU1Pz6Prw==
Date:   Mon, 18 Jul 2022 02:58:39 +0000
Message-ID: <20220718025826.29148-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.36.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d928727-0198-4516-8fd4-08da68696a83
x-ms-traffictypediagnostic: OSBPR01MB2901:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBIdV98rSvclcXKruzr0Fe7xRsJ5y+8H0OPhgi/ZvaqWyA4DcR0bcOIN6Cz/DUMb+fWmF3T7p488kyVjJCyxg9FYWFm9srvIch9yUV5/60zaM+wtbhgCwI6ZFegh7K058NzHSqEwJR1Vdg6sDeLRy4MpRZPMmxVGBKtgVRmXiFcC3BZoSzCi8uV1bQuS1sy5mhrR+eQmInOmM/ZU6ddrl7q+15RnXqcNZKn7fT+ZYRz6msl/Ekyuq57CPKntFnfaVeMI9tbJOUIdRr0fg1yYerRWUyCN5Iz0d9fhT4LDTiFXaxSeguD5yKXC6m+TwYUNU/bkhcO+EKA7qk1QKBZUyJQnbYqIa0nIF9hc6zZ5zXwytEW8ipVjFsMGgJmQmgBeWa3UHrLqc8bNpJUg08uafYl9xFFqaJ7VNrnZi3rt7I3bOdMPHrSa+d2Jl9/UuXbBMPPIRCbClCVXLLZH5kp2InpegwyFjG7WWjKN3BSuR5DY1+bYkJzMYF/n7dRHipEeTZ/VrYXgqiWdbxW1i7y4lW2LzvPpVJ/eaigUnsuL1Y44R/5GhVN5LZopAEgCQqERciljSbsOJajLqRTRAmPfFATysXhGu4H3WYbvpqCRA8UIjfwlLA5rGMKgT048ISTPmZ5k2r1mQMuCDzJrHc7X94doIUUkDjFgupTdkQ18I1DeZJ5YZmhL4fUq2vz8FYF3c0Tp3l7MyoYDltiowNS1g/syRAfkQNCaFbd99PCewDuONaoTkoXQO8Sf5fewRWp6Wb+GUqSvmG0HrJLBt2v5/S0/D59EsKVRUeGHAAZR+5559Rt8oMyrVXB7GcGb57Tw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(1076003)(2616005)(186003)(6512007)(26005)(41300700001)(83380400001)(5660300002)(6486002)(122000001)(2906002)(478600001)(71200400001)(38070700005)(38100700002)(76116006)(4326008)(8676002)(66556008)(66946007)(66476007)(66446008)(64756008)(8936002)(86362001)(82960400001)(54906003)(316002)(36756003)(6506007)(85182001)(91956017)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dmIydlJNWUZNSHB1aWV0QkRMTC9GN3A3ZTdTcTB0bjkvVkR1czVyOHIyVjV0?=
 =?gb2312?B?dlZONmlGb0twRC9xUmhmNE45eGhzcHM3cS9XQkpXczhweTZsMmhxV1pzblli?=
 =?gb2312?B?UHplQTkvV1BsY1BvbUc5M0E5RVBFYkd6bXE1T0pxd3pNTDRQRk5jNmo3RXA3?=
 =?gb2312?B?NkhIZFRTcGdSLzZNMm1TUG84WFowcE83QWNyQXBDVGo1WWtUQVkwNjlxMTJQ?=
 =?gb2312?B?QnpJUzJMSk5UTjlpRDBxNTNCRnc2RzVWbitxVGVac1MvUlFFUk1nTklmaWFq?=
 =?gb2312?B?SCtQNk1FMkJJbUpkMWF3Mng2dkJsZFQxeEFFTXBVK0VydkorMHVTQzRkYjFr?=
 =?gb2312?B?eXYzN3o0ZEduSXREOTY2emhsd0ZiSjZVR2VmQjhRaEZBZFlyU0o5ZkY0aFV3?=
 =?gb2312?B?L290NEZvWEhXWXFEbnhJNHdDdWNXOFBRZ0N1SndOTm55cmQ0Y3JrcStsaWo3?=
 =?gb2312?B?ODRtUEorQXNOaHplc0lKL1BEN2V5RlJxRXVrZ2krTGVzemE3VG5JUkU2WHg1?=
 =?gb2312?B?aFNNTm1yOTA1MjdublMvMm1Fd3pGRVRPSU1hVjQ5SU9RNHVrRXQvOGtVYkoy?=
 =?gb2312?B?a0JUNG8xTjN2SWpEZHpFME1PNmFQK3IzSC9NSStETFh3d3AzUHI4U282WExO?=
 =?gb2312?B?V0tTc3NQMi9aMVR3V0l2QmNBODNNcy80RDlZZ3BjMnBLaHMwbWJNZmhwb0pQ?=
 =?gb2312?B?NmU2UXBJOHg5NG1XM1NLbzRzR05JTWhSSEF4UjdjWHJudTFjTGp5NjMzZFYz?=
 =?gb2312?B?M3ZIVHFQdGRzODNDRmdtRHlwdkxzZm0wVHBrWCtWRnRRc2l6cGNGeEFkT1FD?=
 =?gb2312?B?MVhvUXVZc1h5TG5hdGN0emtPYUwvVERVYWN2TlFnNFlITFlVQ3pDQUd2QUFT?=
 =?gb2312?B?WU1GZXFtNnlRS3NzazZzRGVyb2J2cVYxcXVyRGc2cVcyOHMvd0FkaWVqQlNG?=
 =?gb2312?B?M0lsblV3cmdMZ2JCU1N3ZnZoRDBUZWxMbm11Qy9ocG1ocDlrcllIMW1mdUpR?=
 =?gb2312?B?SGx1Uk5wOXk3TFFjY1EzYlU3dUhRWHRLVWM1aEVQazh5NFE0b1RCTlBRWHkr?=
 =?gb2312?B?b0JieFBqTFJFdUpDcXFwc2RJcnJZVVNpVVkvSHhWemZFSlU4c1VKQlNuRnBL?=
 =?gb2312?B?d2tOT3pIS0tUOHJwdEF4ekdYbnlHNGhEcXdpbGI1eHFQOUNZMy9QSTlNMzlG?=
 =?gb2312?B?SnpmK080MUtlZVNsK3puN3JSUGtaZXU2M3N5TTdKVGFrblByT2lRaVhTcVZm?=
 =?gb2312?B?U3BFWnpaZkJ0T3N1SXRVSXNvRERUdGVOdjY0Y2tDVzM3SHlaWDY2SzB2Tkpw?=
 =?gb2312?B?RnlldDh2MFQybTJNaXk2Nmh1RGlJWkw2OG1vaVVaZ1pTOTVFVEFncEhVRUdk?=
 =?gb2312?B?dnl3dWhkSDFadXBIc3F2UVYyWGpNeTBPaEltK3h3eVFicVYxN3BpajV4SER3?=
 =?gb2312?B?TVhBZlZSM1ZCbGxDVlpZbTBkQWhGRTJGRVIrVVU4UlBnVHlZRlNTTWFLWi9y?=
 =?gb2312?B?UEs4WTFBMFgwd0U4a2FFbi9KOWYwWms4QllXVmRDTVhkajFmZWhwNmpFWDdB?=
 =?gb2312?B?RHZOZWFoQ1FBUFkxa1NiWHlOUnpObW15MTYveFBxNDhEdURPWVZqNWRqMXNk?=
 =?gb2312?B?WFA0YmE4UURhNDI0cE5aTFBiMitGSmhIaVZnSmR2NjlJdHVvNUNuWHhETkV2?=
 =?gb2312?B?WUYxK0c0RHhSR01Cby9FRFpCb0R5cWxPUnlTdWo4bWZENFZjQlZiWVFPSkY1?=
 =?gb2312?B?YnA5T3JySzBFeGd0c2JRaGkxcWpGZC9kYldZUi9hTUFpcjduNHFuT2lJRGxl?=
 =?gb2312?B?UEwzZ1krWHlab2tNYitBdzZSN2luQnVKT3M1V0pURHBYWDk0UkFMY0ZaQ2tC?=
 =?gb2312?B?R3VRMVgrUDJQaUZmcnpRZDIvZnpWUHgzeGdnM245UGFNOEVza2x2U3U4T0xM?=
 =?gb2312?B?MlFEcEo2SWhSNy9ZbCtjTVFvcGRUQTA1anhjTVhON2ZOU2NxNzdIRGFmM2FH?=
 =?gb2312?B?Y2dvUVo0bE02Qlk5dE9La3ZsVExDRm9SY1ZpSUdscHlwekxCVEh0RFJCQ2gv?=
 =?gb2312?B?dFNETEt5Y21TUXc4Wm41VXNLcjFqMnNjdUFVdm94Y3ZPT0MvdDhRQWIxd01G?=
 =?gb2312?B?dGN2R3ZKeGhKRXBYNEc1WHJVTDU1Q0wwRHV5YnBVS0xLN0NvbFZ1UG04WCsv?=
 =?gb2312?B?QWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d928727-0198-4516-8fd4-08da68696a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 02:58:39.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0j/N6mwx/+N1JbVaFZiCpNzRaCGrKIk56naa6hr/D2pN3uQeC/B1PRyUPhOmaUTyDvIvrweM0YTNt8wGYf4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2901
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MERheS9MS1Agb2JzZXJ2ZWQgdGhhdCB0aGUga3NlbGZ0ZXN0IGJsb2NrcyBmb3JldmVyIHNpbmNl
IG9uZSBvZiB0aGUNCnBpZGZkX3dhaXQgZG9lc24ndCB0ZXJtaW5hdGUgaW4gMSBvZiAzMCBydW5z
LiBBZnRlciBkaWdnaW5nIGludG8NCnRoZSBzb3VyY2UsIHdlIGZvdW5kIHRoYXQgaXQgYmxvY2tz
IGF0Og0KQVNTRVJUX0VRKHN5c193YWl0aWQoUF9QSURGRCwgcGlkZmQsICZpbmZvLCBXQ09OVElO
VUVELCBOVUxMKSwgMCk7DQoNCndhaXRfc3RhdGVzIGhhcyBiZWxvdyB0ZXN0aW5nIGZsb3c6DQog
IENISUxEICAgICAgICAgICAgICAgICBQQVJFTlQNCiAgLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tDQoxIFNUT1AgaXRzZWxmDQoyICAgICAgICAgICAgICAgICAgIFdBSVQgZm9yIENISUxE
IFNUT1BQRUQNCjMgICAgICAgICAgICAgICAgICAgU0lHTkFMIENISUxEIHRvIENPTlQNCjQgQ09O
VA0KNSBTVE9QIGl0c2VsZg0KNScgICAgICAgICAgICAgICAgICBXQUlUIGZvciBDSElMRCBDT05U
DQo2ICAgICAgICAgICAgICAgICAgIFdBSVQgZm9yIENISUxEIFNUT1BQRUQNCg0KVGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGUga2VybmVsIGNhbm5vdCBlbnN1cmUgdGhlIG9yZGVyIG9mIDUgYW5kIDUn
LCBvbmNlDQo1J3MgZ29lcyBmaXJzdCwgdGhlIHRlc3Qgd2lsbCBmYWlsLg0KDQp3ZSBjYW4gcmVw
cm9kdWNlIGl0IGJ5Og0KJCB3aGlsZSB0cnVlOyBkbyBtYWtlIHJ1bl90ZXN0cyAtQyBwaWRmZDsg
ZG9uZQ0KDQpJbnRyb2R1Y2UgYSBibG9ja2luZyByZWFkIGluIGNoaWxkIHByb2Nlc3MgdG8gbWFr
ZSBzdXJlIHRoZSBwYXJlbnQgY2FuDQpjaGVjayBpdHMgV0NPTlRJTlVFRC4NCg0KQ0M6IFBoaWxp
cCBMaSA8cGhpbGlwLmxpQGludGVsLmNvbT4NClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NClNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBm
dWppdHN1LmNvbT4NCi0tLQ0KSSBoYXZlIGFsbW9zdCBmb3Jnb3R0ZW4gdGhpcyBwYXRjaCBzaW5j
ZSB0aGUgZm9ybWVyIHZlcnNpb24gcG9zdCBvdmVyIDYgbW9udGhzDQphZ28uIFRoaXMgdGltZSBJ
IGp1c3QgZG8gYSByZWJhc2UgYW5kIHVwZGF0ZSB0aGUgY29tbWVudHMuDQpWMjogcmV3cml0ZSB3
aXRoIHBpcGUgdG8gYXZvaWQgdXNsZWVwDQotLS0NCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9w
aWRmZC9waWRmZF93YWl0LmMgfCA5ICsrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3Bp
ZGZkX3dhaXQuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYw0K
aW5kZXggMDcwYzFjODc2ZGYxLi4zZjdiYzY1MTdkZWEgMTAwNjQ0DQotLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9waWRmZC9waWRmZF93YWl0LmMNCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3BpZGZkL3BpZGZkX3dhaXQuYw0KQEAgLTk1LDIwICs5NSwyNyBAQCBURVNUKHdhaXRf
c3RhdGVzKQ0KIAkJLmZsYWdzID0gQ0xPTkVfUElERkQgfCBDTE9ORV9QQVJFTlRfU0VUVElELA0K
IAkJLmV4aXRfc2lnbmFsID0gU0lHQ0hMRCwNCiAJfTsNCisJaW50IHJldCwgcGZkWzJdOw0KIAlw
aWRfdCBwaWQ7DQogCXNpZ2luZm9fdCBpbmZvID0gew0KIAkJLnNpX3NpZ25vID0gMCwNCiAJfTsN
CiANCisJQVNTRVJUX0VRKHBpcGUocGZkKSwgMCk7DQogCXBpZCA9IHN5c19jbG9uZTMoJmFyZ3Mp
Ow0KIAlBU1NFUlRfR0UocGlkLCAwKTsNCiANCiAJaWYgKHBpZCA9PSAwKSB7DQorCQljaGFyIGJ1
ZlsyXTsNCisJCWNsb3NlKHBmZFsxXSk7DQogCQlraWxsKGdldHBpZCgpLCBTSUdTVE9QKTsNCisJ
CUFTU0VSVF9FUShyZWFkKHBmZFswXSwgYnVmLCAxKSwgMSk7DQorCQljbG9zZShwZmRbMF0pOw0K
IAkJa2lsbChnZXRwaWQoKSwgU0lHU1RPUCk7DQogCQlleGl0KEVYSVRfU1VDQ0VTUyk7DQogCX0N
CiANCisJY2xvc2UocGZkWzBdKTsNCiAJQVNTRVJUX0VRKHN5c193YWl0aWQoUF9QSURGRCwgcGlk
ZmQsICZpbmZvLCBXU1RPUFBFRCwgTlVMTCksIDApOw0KIAlBU1NFUlRfRVEoaW5mby5zaV9zaWdu
bywgU0lHQ0hMRCk7DQogCUFTU0VSVF9FUShpbmZvLnNpX2NvZGUsIENMRF9TVE9QUEVEKTsNCkBA
IC0xMTcsNiArMTI0LDggQEAgVEVTVCh3YWl0X3N0YXRlcykNCiAJQVNTRVJUX0VRKHN5c19waWRm
ZF9zZW5kX3NpZ25hbChwaWRmZCwgU0lHQ09OVCwgTlVMTCwgMCksIDApOw0KIA0KIAlBU1NFUlRf
RVEoc3lzX3dhaXRpZChQX1BJREZELCBwaWRmZCwgJmluZm8sIFdDT05USU5VRUQsIE5VTEwpLCAw
KTsNCisJQVNTRVJUX0VRKHdyaXRlKHBmZFsxXSwgIkMiLCAxKSwgMSk7DQorCWNsb3NlKHBmZFsx
XSk7DQogCUFTU0VSVF9FUShpbmZvLnNpX3NpZ25vLCBTSUdDSExEKTsNCiAJQVNTRVJUX0VRKGlu
Zm8uc2lfY29kZSwgQ0xEX0NPTlRJTlVFRCk7DQogCUFTU0VSVF9FUShpbmZvLnNpX3BpZCwgcGFy
ZW50X3RpZCk7DQotLSANCjIuMzYuMA0K
