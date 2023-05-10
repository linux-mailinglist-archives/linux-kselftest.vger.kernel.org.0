Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A686FDC56
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjEJLLW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEJLLV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 07:11:21 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011006.outbound.protection.outlook.com [40.93.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA8B91;
        Wed, 10 May 2023 04:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfyS1n6DrdC/B8V5BLP4mepDw863HN3Dv/qcg+uIPy7fg/NKFwavsdjrR2YJMU4du11JrCYpJLsU+bXVeDkfNhmVSkIHIgE26p5LQz+rrk/LrEsv66a6jrc2TsUkT/J0ng5zpNAnPAamLMLg7rvcl+BE6lKCumew1ILTuzI69P7b9if8drPeBVXu3kCTNWypTn3F//I12F4bgKgFjQN2Wb7/K8iUJaDzh0B5odc1KNqpwAeUS/ahudWXFB4H8Vxo4atobABehxNsEzygD2XSCZcFyizOqCXb+eHHYF8EmH7ksjbkXkBH9N6JkCocbX9yiRnzZqwOYOtEUietOpRjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er3WA6U7Gs0roXtPWhjHlBlBIkfnJl2hhignr9ehuAc=;
 b=UoSzNEXsLG3kxBLQ/xzfyVNoKq02Jpgo4lqb1BMVUxjjEK+nfFuVMRF8VOV7qo60UbKszX5hE3+rV7DdRw5DZZTQyYvpaP46kWiB+pNwArBO1V7Bty5G9xC9DpvoDpvbduH1tugELYE34NqXCAjY8UDV9AJD3AgEuSHQALQgnkO8Fp9go/80DHQCpMhSFx8zPdRjOP1EcngT8STiK4Xzz9QDeIz24XVLq3pklaohM55O8D/fNY94DtRP/BCSMd1KaqPi/cAb3Bim6mScFRHcxqFcXssO4ps726EhXKCQo/dEZOZznraiIiqJb4Tpcz+armo+KP0YKc7vHKiqegp7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er3WA6U7Gs0roXtPWhjHlBlBIkfnJl2hhignr9ehuAc=;
 b=yi76OnPE14kKQXCePaXvCLp2noMhEHDC2sPmTptWuhZgR2TDvYMOVD2Kk5nW4OzaRx7fCSQ6J0ZOPLbg6zfI7X5GnnHzxjdtrI/EO6EgJ/FEV2SpmTuR0HPBo+ILNsfL6LTmDHsVS3tS719J9w/dgyoBDm9IFKs0oS0IAMuV0Sc=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BL0PR05MB5364.namprd05.prod.outlook.com (2603:10b6:208:6b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:11:16 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:11:15 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     kernel test robot <lkp@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Topic: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Index: AQHZfOilHbAIv3gBO0Sfrm8lUvOVTK9HSCgAgAr9/YD//+uAgIABNMGA
Date:   Wed, 10 May 2023 11:11:15 +0000
Message-ID: <400E4466-629C-4306-86B1-E8BA0CB5EF66@vmware.com>
References: <1683026600-13485-9-git-send-email-akaher@vmware.com>
 <202305030116.Gu6yyvKj-lkp@intel.com>
 <1CAC8265-A4F3-4AF6-80E4-8F264ED670A9@vmware.com>
 <20230509124559.0d5557ad@rorschach.local.home>
In-Reply-To: <20230509124559.0d5557ad@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|BL0PR05MB5364:EE_
x-ms-office365-filtering-correlation-id: d2acbed2-a497-4af9-6f37-08db514745ac
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlnwHS/9kL3vM6scHL8VdSA0rG4Z4jq/8a/t07dWbbKbPKgdBlx/nmfBbRU6qEZzvtCW1SnG8b0Dd3jtQjw4BYUc2+VuRblnHGkLEi1qfvj/35f3KNx82HBWdFJuzowsSS8h9XlP/v8JpbsYk2hX4f+Ph8b5YjbSvAl8VbMKihxQdwRJCwDpBeyCLWxmx4Tvv3uvfxAMuuF4yX4IE0QznWdm1xlpmS//0zVcqzpI6JVZ71bFERsi7SPShT0hme5TnPDfrBRR0yqxflWchQnYKDjAdPeJ83zp/pLSeRfF9sdPr7W+Z9FsIqswCm3vtuB83dckrcgC0TjpBYkfR084/ct7hWZi3lMU0gsIK5Dm7ah6FtxQ0bqCFibHYpseYC75/ISj4ql8qXnXBGn9/GCpomr1EAlmbu1pQu6aN11PNTMSM1ccWRwTtil+3JMzxXIjHPo128ae0zkgFUzad68cDhqYHK8e24ebt0Pi/AulmGtNCbfD6On2S6o1zt2wkCeiTKioO2lAwWMBsyZi1R7njQUL234kdtUS8Dwbg9jNhUeSlpjRBL19brY7/5jf6xBqyGxlDxCN2NoxuOS4au31gJJmDIO8ohMVeA35O6JD8eoh9yqqu0nrmkAEkT//fWcFDzg5ru4zT5G+9msckjgdyXpS3Q5EreGLynjgIpgsItXJW+hiBLoJZOLmaEhg7FKv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(478600001)(122000001)(83380400001)(54906003)(66946007)(76116006)(66556008)(66476007)(64756008)(86362001)(66446008)(91956017)(2616005)(316002)(6486002)(6916009)(4326008)(38100700002)(8936002)(71200400001)(8676002)(7416002)(36756003)(41300700001)(2906002)(5660300002)(53546011)(186003)(26005)(6506007)(6512007)(33656002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkdsY1FmVnFPNW5xRXNEVzc0Y2Jjc1hMTFhBYWRlMEtsZjlVcCtRbDZpRGhH?=
 =?utf-8?B?RDAwZDAyR2N5ckRvV0ltWncxV0JJTnR4ZEs3Z1RFclgwZlY0VVNYQkhIQ2tD?=
 =?utf-8?B?YzMvdFJzYzRWbWxidU16S2dpcW13UUl1ZHl3ZWRqanI2N0hYcWRUOEhyRU1o?=
 =?utf-8?B?UXBNNzZVL1ZKYlMzQkpDVTFvLzNBdnNXN0tyKzRDR0tRb042MWFpWHZXSnJk?=
 =?utf-8?B?ZEh0a3B0MTlMdk04NVQreG81NTArYmVYaDIxYU9kWW9jeDJGaDMxMHhpZ20x?=
 =?utf-8?B?SWoxTGFuMlVjQzV0Um1ITU8xMlZ4d09oYVIzejg1cDRCdElmM2FtRzk2a1po?=
 =?utf-8?B?cEpNK3BHQkJoMHMrOVk2bzBnL01sVUp4OHdjVTFZa1R1TnEyUTRSRG1XaXBq?=
 =?utf-8?B?bVk3Z3plUkNUTmtvNTYyQTN6MlRUWklway94Ymw3WjZKbmtsdGV3eXh1NHE1?=
 =?utf-8?B?L0VQZFZ4aThLVnVUVXlWYSs2c0xhMi9UcXIxUzQ4L2xobnZIbUd5OWFEcXFL?=
 =?utf-8?B?aW1QTmVUUUh3ek0rejVHZmxmcEc4M0tuOFRISzIvdkpJYlhFdmJsY1p2eCtu?=
 =?utf-8?B?VEltb1dpRmhVeHF0LzAzalNodUp0VnZXQklXUXZYYTZzWHN1N09SSFdDQzZK?=
 =?utf-8?B?Q1lYc24xRytuRGpzREdlVW5jMlJscTZ0U2xjaWdCMDBrcXVPZm9IQTlDN1py?=
 =?utf-8?B?eGpBYXlxV1dWUkZ4dm9aMzMxbzdkVzg0QWg2ZklzeHZVQXI1SmVPTlpUU0I1?=
 =?utf-8?B?Nm4yVllZY3JjQURmTU5Fb0NURWV0UXZoMW9YdE9JWVlyaG0yS0d3NjF0VU4v?=
 =?utf-8?B?dUVHVTlEWTVvNlZkTy9Wc3U2Vlk1V1N6NjBzR0hER1ZFUTM0L2s2LzJoYThk?=
 =?utf-8?B?V0FzY080eDVoSE1XVldLdUlHN3Q0cTlqcndGMEcyQmUrR3hUWGwweS9HNCtX?=
 =?utf-8?B?UG9iWkpQamtoUVJycWtqSFpkWDNsNjFaOG1Fb0pVR0RaUzk3ZytYMlVLWHRM?=
 =?utf-8?B?a2VhWWZUbEMxTTNQUVhjSTR4dklIeVRaU1UzTUttd0RrblU4c0h5aEMxaDhw?=
 =?utf-8?B?aHdWaERnbUx5QUVrZHpNYTVYL2RLN3FjWVNERUdpSmpjUmUzTnR3a2tHeUZE?=
 =?utf-8?B?VFpndG5rSlh0WllHQ0VIS3htV3JKd292andxMmJaSFcxVG82UGZWWGltRUhn?=
 =?utf-8?B?TUNHcDR6eWVlM0J6TmUzRERja0h0eW41UHpyZXZSMTVQMmwzcDcya2VPWldD?=
 =?utf-8?B?RU1HOHh2dkM4U3l6NFFrck9hSWExUkVwODNyTi9ZT2swR090N1FpVHg4eCtk?=
 =?utf-8?B?N05XVXY0OVhqT0M1YzBwZGZOYmd3NGgyN1NkbTdWQ00rYldRcEx3aGEvMzJk?=
 =?utf-8?B?TGVuamJOdFVsVk9vOElOWWZ4OUpKWGUxcGg2SW5QcFVKbEdMSllKTk1XR3dw?=
 =?utf-8?B?dHFqMjdKRmtVTzNwVkZ2MVlUdjByTjkwbU5UclQ1THRnT1ZsbHdHV0tPOGdR?=
 =?utf-8?B?NmZiYTcyZjVVSVE3VEN4WnZCVzRUaDFvTUxydXozbkZiTG9UdTNOWUNmL3ln?=
 =?utf-8?B?c1NYZExJN3hhUmFsNVNIbEpyZ1lFaXBvekQvZnpGOXduT2krcHV5Z3BSUXhB?=
 =?utf-8?B?QWZmMzVvZ24xN2d3VVpZNUpoYVNhN3lGdEFHZHBtcjZYQkZDUmprUUF4NnMx?=
 =?utf-8?B?VzlIUFk5WEdibVBnQlJqTFVINzcvLzlvUzdHSzVGRjQyeWlOMVQ3R1Bpa1Yy?=
 =?utf-8?B?TXBZTVBaOTFxM0ZLcXVCeldpb0RmWXF5VHZ1eFlnV0Z6azQ3NFRZSjFUSS9V?=
 =?utf-8?B?THNrNHowby82Q0R1YVAvbVEwTkhtYUtOeVVYOWdFVnhwK2kzK2pqSGRWalRO?=
 =?utf-8?B?YWJGVmVIclZtMGVCYkxVV3RLeGt5RWtHUmUvYWJoRlZxQlgvU1d1MlRJVHIr?=
 =?utf-8?B?RGxHZW1NWWJIWTVWRU50ZXhzcGtCOTVKUm5IV21vVytmNElHL1pjeCs2T2dD?=
 =?utf-8?B?UlFJbzFGUU1XU2dkd3FTTkdabE5FZGRnVDRKMkVnQko2WW9VVFdhOVJUM21G?=
 =?utf-8?B?OERqR05nejBPZXQrbU1Ta2lzcmNVbTJRWi8vYWhMOWswM2NINzViQUpRMks1?=
 =?utf-8?Q?wJ9rNVuOe3qK3mbDzu2A+alZf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A8F3B74BDC0E4096C1B60F8EF00139@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2acbed2-a497-4af9-6f37-08db514745ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 11:11:15.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqMvGKtdga6Kwmp/hUHnUabV18aDveHY7Gy6LcVVnyWO1WEVcKrGXuES2ASMabRy4OrIIWAhOfgS2+Gk4ZZc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gMDktTWF5LTIwMjMsIGF0IDEwOjE1IFBNLCBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVk
dEBnb29kbWlzLm9yZz4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24g
VHVlLCA5IE1heSAyMDIzIDEyOjI5OjIzICswMDAwDQo+IEFqYXkgS2FoZXIgPGFrYWhlckB2bXdh
cmUuY29tPiB3cm90ZToNCj4gDQo+PiDvu78+IE9uIDAyLzA1LzIzLCAxMTo0MiBQTSwgImtlcm5l
bCB0ZXN0IHJvYm90IiA8bGtwQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4+PiBrZXJuZWwvdHJhY2Uv
dHJhY2VfZXZlbnRzLmM6MjQyNDoxNzogd2FybmluZzogdmFyaWFibGUgJ2RfZXZlbnRzJyBzZXQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPj4+ICAgICAgICAgIHN0
cnVjdCBkZW50cnkgKmRfZXZlbnRzOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgIF4NCj4+PiAg
IDEgd2FybmluZyBnZW5lcmF0ZWQuDQo+Pj4gDQo+PiANCj4+IFN0ZXZlLCB3aXRoLWluIGV2ZW50
X2NyZWF0ZV9kaXIoKSwgZG8gd2UgaGF2ZSBhbnkgc2NlbmFyaW8gd2hlbiBmaWxlLT5ldmVudF9j
YWxsLT5jbGFzcy0+c3lzdGVtDQo+PiBkb2Vzbid0IGhhdmUgVFJBQ0VfU1lTVEVNPyBBbmQgbmVl
ZCB0byBleGVjdXRlIGZvbGxvd2luZzoNCj4+IA0KPj4gYWU2M2IzMWU0ZDBlMmUgU3RldmVuIFJv
c3RlZHQgICAgICAgICAgIDIwMTItMDUtMDMgIDI0MzcgICAgICAgICAgICAgICAgZF9ldmVudHMg
PSBwYXJlbnQ7DQo+PiANCj4+IGxvb2tpbmcgZm9yIHlvdXIgaW5wdXQgaWYgd2UgY291bGQgcmVt
b3ZlIGRfZXZlbnRzIGZyb20gZXZlbnRfY3JlYXRlX2RpcigpLg0KPj4gDQo+IA0KPiBJIGhhdmUg
aGl0IHRoaXMgaW4gdGhlIGJlZ2lubmluZywgYnV0IEkgZG9uJ3QgdGhpbmsgaXQncyBhbiBpc3N1
ZQ0KPiBhbnltb3JlLiBQZXJoYXBzIGp1c3QgaGF2ZSBpdCBiZToNCj4gDQo+ICAgICAgICBpZiAo
V0FSTl9PTl9PTkNFKHN0cmNtcChjYWxsLT5jbGFzcy0+c3lzdGVtLCBUUkFDRV9TWVNURU0pID09
IDApKQ0KPiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gDQo+ICAgICAgICBlZl9z
dWJzeXN0ZW0gPSBldmVudF9zdWJzeXN0ZW1fZGlyKHRyLCBjYWxsLT5jbGFzcy0+c3lzdGVtLCBm
aWxlLCBwYXJlbnQpOw0KPiANCj4gSG1tLCBob3cgYWJvdXQganVzdCBhZGQgdGhpcyBwYXRjaCBi
ZWZvcmUgeW91ciBwYXRjaCBzZXQ6DQo+IA0KDQpTb3VuZHMgZ29vZC4gVGhhbmtzIFN0ZXZlIDop
DQpPbmNlIHlvdSB3aWxsIG1lcmdlIGJlbG93IHBhdGNoLCBJIHdpbGwgcmViYXNlIHRoaXMgcGF0
Y2ggaW4gdjMuDQoNCi0gQWpheQ0KDQo+IA0KPiBGcm9tOiAiU3RldmVuIFJvc3RlZHQgKEdvb2ds
ZSkiIDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHRyYWNpbmc6IFJl
cXVpcmUgYWxsIHRyYWNlIGV2ZW50cyB0byBoYXZlIGEgVFJBQ0VfU1lTVEVNDQo+IA0KPiBUaGUg
Y3JlYXRpb24gb2YgdGhlIHRyYWNlIGV2ZW50IGRpcmVjdG9yeSByZXF1aXJlcyB0aGF0IGEgVFJB
Q0VfU1lTVEVNIGlzDQo+IGRlZmluZWQgdGhhdCB0aGUgdHJhY2UgZXZlbnQgZGlyZWN0b3J5IGlz
IGFkZGVkIHdpdGhpbiB0aGUgc3lzdGVtIGl0IHdhcw0KPiBkZWZpbmVkIGluLg0KPiANCj4gVGhl
IGNvZGUgaGFuZGxlZCB0aGUgY2FzZSB3aGVyZSBhIFRSQUNFX1NZU1RFTSB3YXMgbm90IGFkZGVk
LCBhbmQgd291bGQNCj4gdGhlbiBhZGQgdGhlIGV2ZW50IGF0IHRoZSBldmVudHMgZGlyZWN0b3J5
LiBCdXQgbm90aGluZyBzaG91bGQgYmUgZG9pbmcNCj4gdGhpcy4gVGhpcyBjb2RlIGFsc28gcHJl
dmVudHMgdGhlIGltcGxlbWVudGF0aW9uIG9mIGNyZWF0aW5nIGR5bmFtaWMNCj4gZGVudHJ5cyBm
b3IgdGhlIGV2ZW50ZnMgc3lzdGVtLg0KPiANCj4gQXMgdGhpcyBwYXRoIGhhcyBuZXZlciBiZWVu
IGhpdCBvbiBjb3JyZWN0IGNvZGUsIHJlbW92ZSBpdC4gSWYgaXQgZG9lcyBnZXQNCj4gaGl0LCBp
c3N1ZXMgYSBXQVJOX09OX09OQ0UoKSBhbmQgcmV0dXJuIEVOT0RFVi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFN0ZXZlbiBSb3N0ZWR0IChHb29nbGUpIDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KPiAt
LS0NCj4gDQo+ICAobGlnaHRseSB0ZXN0ZWQpDQo+IA0KPiBrZXJuZWwvdHJhY2UvdHJhY2VfZXZl
bnRzLmMgfCAxNSArKysrKysrKy0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJh
Y2VfZXZlbnRzLmMgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4gaW5kZXggNjU0ZmZh
NDA0NTdhLi4xNmJjNWJhNDU1MDcgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9l
dmVudHMuYw0KPiArKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCj4gQEAgLTI0MjQs
MTQgKzI0MjQsMTUgQEAgZXZlbnRfY3JlYXRlX2RpcihzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQsIHN0
cnVjdCB0cmFjZV9ldmVudF9maWxlICpmaWxlKQ0KPiANCj4gICAgICAgIC8qDQo+ICAgICAgICAg
KiBJZiB0aGUgdHJhY2UgcG9pbnQgaGVhZGVyIGRpZCBub3QgZGVmaW5lIFRSQUNFX1NZU1RFTQ0K
PiAtICAgICAgICAqIHRoZW4gdGhlIHN5c3RlbSB3b3VsZCBiZSBjYWxsZWQgIlRSQUNFX1NZU1RF
TSIuDQo+ICsgICAgICAgICogdGhlbiB0aGUgc3lzdGVtIHdvdWxkIGJlIGNhbGxlZCAiVFJBQ0Vf
U1lTVEVNIi4gVGhpcyBzaG91bGQNCj4gKyAgICAgICAgKiBuZXZlciBoYXBwZW4uDQo+ICAgICAg
ICAgKi8NCj4gLSAgICAgICBpZiAoc3RyY21wKGNhbGwtPmNsYXNzLT5zeXN0ZW0sIFRSQUNFX1NZ
U1RFTSkgIT0gMCkgew0KPiAtICAgICAgICAgICAgICAgZF9ldmVudHMgPSBldmVudF9zdWJzeXN0
ZW1fZGlyKHRyLCBjYWxsLT5jbGFzcy0+c3lzdGVtLCBmaWxlLCBwYXJlbnQpOw0KPiAtICAgICAg
ICAgICAgICAgaWYgKCFkX2V2ZW50cykNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQo+IC0gICAgICAgfSBlbHNlDQo+IC0gICAgICAgICAgICAgICBkX2V2ZW50cyA9
IHBhcmVudDsNCj4gKyAgICAgICBpZiAoV0FSTl9PTl9PTkNFKHN0cmNtcChjYWxsLT5jbGFzcy0+
c3lzdGVtLCBUUkFDRV9TWVNURU0pID09IDApKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9ERVY7DQo+ICsNCj4gKyAgICAgICBkX2V2ZW50cyA9IGV2ZW50X3N1YnN5c3RlbV9kaXIodHIs
IGNhbGwtPmNsYXNzLT5zeXN0ZW0sIGZpbGUsIHBhcmVudCk7DQo+ICsgICAgICAgaWYgKCFkX2V2
ZW50cykNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gICAgICAgIG5h
bWUgPSB0cmFjZV9ldmVudF9uYW1lKGNhbGwpOw0KPiAgICAgICAgZmlsZS0+ZGlyID0gdHJhY2Vm
c19jcmVhdGVfZGlyKG5hbWUsIGRfZXZlbnRzKTsNCj4gLS0NCj4gMi4zOS4yDQo+IA0KPiANCj4g
ISEgRXh0ZXJuYWwgRW1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2Yg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlci4NCg0KDQo=
