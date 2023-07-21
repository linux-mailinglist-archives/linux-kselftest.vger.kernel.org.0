Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F219F75D076
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGURR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGURR2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 13:17:28 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D1B171B;
        Fri, 21 Jul 2023 10:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDAMdxFCa1Ln8WnoscYZZW4fHkJEIalDfM+e2NhfsohpWpIDYoJJg9rBmYyAuRtLdp85DdiSRVo3AMcclYqkfM4yaO3AtLyHZoQoL8zD2aGHapD34XJF8geFLl5MlDXdzEQHAT2LS7bcp/TWYbppqZ8s+FrsO23RxCqVdrYiO/P4wiMOuZY1ozhTpgbw9DK5iwIQa6aq+uX7IH8ekTuu0krIyieBRFznJHvOw3PNsyclhiIMlauNqVF1DodYXhAx9HRmo+2DBvSzoky5L0rU/yuReFCVtP4NMi43TrXowdldU6xDAfD7LxKnu6n8/RjPdhSgs0wKTlhCA8k/7mudjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5IZ+Mm9i35me7YulmeyFLNU4bcRilpzeBu5OiuZ5U0=;
 b=DMWV/cMHxk3hRpKxwb38qWG7zJZ+joN1eOwGR14C+3uuemwHIJsj67r0+lxpxImzuJ/5pEHasH40hSfL2OUmC70k1uEKXRy7vzd1ZB22rzFpeuYpySySeFceSISXGOORmk0NEa31O8hC+yj430V+LWZPI6QzjILjjjEL1gCuuOnfWhqTAHhsc5oJnXuDqISWzKYl5BGj7xkNVXTZaT8X/RVn3cxLfyrb7VoWAVGr9IGs+diqADqvE0LQ1+KBqzqW0CCV7xZQZVZpG0gVw1zBSWv8lPw8xgVUbLUqCKLcq62Grksye6TzAmFlbTho3BIzk5EkoIq8KU1d2J2XkAhbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5IZ+Mm9i35me7YulmeyFLNU4bcRilpzeBu5OiuZ5U0=;
 b=WebWJo3D5YId72BgRgpNBzdWUAKSPLPCHECn/F9hk4A3wTX3FuwfzJoUtpVK820COQvnLMVVDLCyFZVFUq5CP9MpifQyifFi4EV0TQXavuQ0ckN70dfHu2k1dKJd8N9nIklxvMC66R0bk7fMDvbhkobffjMKcsWJcX3Vg1+peu0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8912.namprd05.prod.outlook.com (2603:10b6:a03:3b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 17:17:24 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::92ad:8382:ae15:59a9]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::92ad:8382:ae15:59a9%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 17:17:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ajay Kaher <akaher@vmware.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v4 00/10] tracing: introducing eventfs
Thread-Index: AQHZtX3rSWM00NLVKESp1/lFUshOV6+54mYAgALJooCAAuO0gIABW/QAgABCagCAAEb6AIAAAP8AgALCSICAAAizgIAAQleA
Date:   Fri, 21 Jul 2023 17:17:24 +0000
Message-ID: <66DACCE8-1C57-4A30-8ACF-D88179CA6381@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <20230714185824.62556254@gandalf.local.home>
 <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
 <20230718094005.32516161@gandalf.local.home>
 <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
 <20230719102310.552d3356@gandalf.local.home>
 <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
 <20230719144046.746af82e@gandalf.local.home>
 <20230721084839.4a97a595@gandalf.local.home>
 <20230721091947.0df9fd73@gandalf.local.home>
In-Reply-To: <20230721091947.0df9fd73@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BY3PR05MB8912:EE_
x-ms-office365-filtering-correlation-id: dc4426c2-b29d-4ebb-d3f5-08db8a0e59d7
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emo0wRH4imBUx02hIIBWWOA8j9F7IwtKyAgqWdYYjKN8iSfMkzkCBFiox1KqqB2mBdKjstUtPaFPP0l4aS7FdruSzAM55sE5b88Q9Fe5RtDlWqFhnBBksx5BIVMA7ZOxNRtNQBVG9yzQy7VmOfhQlAZjqp93VFKcZG9hdHTqAeYZYCPPqfKxWCBqLrkoMBT7+nkjyUtGs1JKrIpLROPgmb3UoRm8hHlGCnBq9XRV7tpy/bqi//UZtn5T8OL1Rv6UgtX/qws+bQ0SyKgLeOdgqNSCSjPdG4AB/VWW8iV0OMidY3HG75IoCClArZQwcsvYUBDt8OxDtqMJ3jweC9VaTLt2MIJ+KJLovpWcTBUZuzChT1YrRclzJoQ5l2GCg6L1EePqLvfq1s1czC3jW4qHpWFCbRaZCzVLP8mqNWmo+i59gKG35qJuDNmFBo+GdzvvzH8KgOKO8RQh6y65PqpRAk4xj6+as5sLTZ1QxJM4WU4PD+ipBGDxXmLLSoKVOpv09IPrapVb1Ga4mD1S8CR7QruqS0bhAA30GLHAkmkJIxhpg5lNrZ/AoH2sLYttygvOLbFWtZReg9Sc/Gv1myq7synmDtv6PHy/8ovRs3L2IIN6X7Z/bvPYwpIxTJ+aN4IGTOEQda4mbg3GlfV2QxBBU21f6DwKv1txvM0sky1Iobw4jypll9KvJslW3gu+jkr5Bllkjxw9wySC0iwo/ezTng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(6512007)(38100700002)(6506007)(53546011)(122000001)(186003)(2616005)(26005)(107886003)(7416002)(5660300002)(33656002)(41300700001)(8676002)(8936002)(36756003)(2906002)(6486002)(66476007)(71200400001)(38070700005)(6916009)(66946007)(66446008)(64756008)(66556008)(4326008)(316002)(478600001)(54906003)(86362001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0UzZDUvSlBnVzl1ZVJ3Y1ZHNm16dG1ubTBOcFZFS3oxeVg1M0E1WElZcEVw?=
 =?utf-8?B?VFdaVHZYN2MrcHladUZVWHpZNW82V1dRZTB4aTUwMXBySTNWd1NyRzk4UTg0?=
 =?utf-8?B?eDB6ZkMwOFV6bDBLNVpYdHo5V3VaOTdvcUxYNUtGdnYyeG9QeGp6TG5qeVdR?=
 =?utf-8?B?QXlrYWtWcUV3MWZ5UWpGSEc4N3REYWxpZ21CZU5xQ0tRd0kxa2t2aURpcnRj?=
 =?utf-8?B?cVI1NUMxcEtyM3lnUEF3Y3pmZDRGVXVtd21jeDFmOGtYUzFVczhlNzBPS2dL?=
 =?utf-8?B?NEJaclNnYjdRbFdDUDJiWkVqT08waGRzMHREQ3cwRGtSYS91cC9YNjR1Rm9V?=
 =?utf-8?B?Qy8vRk5uUlY0bVJkc2QwcnJIeG9mdy85bFlVZTdnSU9xN2tHZkVxbzB4cUVy?=
 =?utf-8?B?VWg0Mjkwd3l5QkpvOHBzZEdCaDZNUWlvNUhTdEZFazdLRGdUR2k0cWZ6ZFdI?=
 =?utf-8?B?ekJCdHJwZFNGZnNWNjVSbnMrRHZ6VGI1QVdpam1nKy9PdW56MTNOZnBCUUYx?=
 =?utf-8?B?WHVCbTNDYlI4TEgyRkw0VzRwQ3JSQ3BPK2VIdE5rbTZVK1p6MTdsMktpbisy?=
 =?utf-8?B?dTlUSnFsVVhaUlgySlZIQ0hpY20xVHlwb2RqM0Y1anI4SUIrSVZVQ0x1Mk9r?=
 =?utf-8?B?SXpNWWlyZERRdGJDNHdGaGxOSVAvN3E4R2RjRkx4YTBweENjaUMxWi84T3pK?=
 =?utf-8?B?aEZ4Q2N6TmVrMEJWdzFGcWk3VGRHNWdOWUYwdHY0ZWE2ZzBaSFRvZysrTlBh?=
 =?utf-8?B?VFVGTC95OW1Eb2Zvb2h2Z0llYndvR3FDVTc4MzFEQVNscm5YSHhuRVhCeGY3?=
 =?utf-8?B?bU1ZVjloRDRVOG4zUUtqRHk3RWZxaWk3ZGJJeHBJS1g5RHhpN1ZVS2gzY3Fv?=
 =?utf-8?B?QkhmWEpwTDlFL1cxVlh5djAvVGJzckJRRnRodEZKZUlZZU1XZjBzWXVRWmdD?=
 =?utf-8?B?OU0zM0Ezem1hb2hqbWpPRUtsNnFYdDlxaFVqRXN4bCtXblBYbFJocHl3Q0lm?=
 =?utf-8?B?QTNTYi90aDkrSWliMVhrM0NCdmhVeTllNTRwUEZaMFF1NjdaalJ0eE5VVmdH?=
 =?utf-8?B?ZzFIV2kzcnUzN1RTa01FSm1rZ3pBb0lrV085djZIaElPWUpDRDFHbExKNENZ?=
 =?utf-8?B?WGd4M2RSSXJKU2pKbGZieFBEbHl2YWNGR296UGdxUGtFd2lhQ0ZZamYzQm1T?=
 =?utf-8?B?THdYTmZCdDU0eXJyTVQwY05MZy9sTWdTVVJtSjlkTFVOOVNWYURMeTlRNTRW?=
 =?utf-8?B?c1l5Nld5QXlXYzU5VGgwQlVYNzFUQXZnV3IxdE01b1ZjeDZ6QWMwTFloSkZE?=
 =?utf-8?B?REZITzJDZkpCQ1pnWFEvQUZ4Tlh6MUhrcnZwNHNHbVYycGdQZWNuNTZxbEU0?=
 =?utf-8?B?SzUyUGZnNG9Db0J6R1Q4ZlZPNVVmeDBmdFJPVjgzZ2swRE5tdkU0SEo1NHNR?=
 =?utf-8?B?ZXFzWEdIR3Q4YmhaZEhiblo1akhNUnp0OUwrUS9xRVBuNlgxazZWbjNkR3FG?=
 =?utf-8?B?WXlpSERBM0xVRE8zaXhlQ0hNSDc5NzZTcVNTTGhzZzROVWc1MmZEZVR6K0Ru?=
 =?utf-8?B?K0tLV053ajZ5TDBkOHp3VGhYTUtKSVVqbzZaL3RhQTlBOVlBZDNUbWNGM0xp?=
 =?utf-8?B?YlIxaGxWaU0yOWRCYUU5UFc1N3dVUml4Y2Yrbk9JZzRGMXJMOE80ZlNTOGxB?=
 =?utf-8?B?YWVHblJsa1owc2RSSkMvWk9Mckt0c2ZwTzRCa1RLMWFHbXZMQ0kzUFM2eW5D?=
 =?utf-8?B?RXViN3VnSytsUWZWa1VuVmJVVG5Qa3MzYmlKdWNXN2kvQ2NTcVJ5MzY4dndx?=
 =?utf-8?B?RWt6K2p6S2dSSll3d3Y2UFltQ2psSERiM0NwTy9XTXFIZEdKdWR6N09NR0Jj?=
 =?utf-8?B?Y2lnZXZaTW1FRlE2YVc4ZkNWYjFmamdxZDBqSHM1ZkJwejlqREc5aGdNcTF6?=
 =?utf-8?B?NUxzbEN5NHUwMGtDSUdBNEl5UlU1OUhtcUYrQWtYUlhsdzBTYTFsdkt2VW5H?=
 =?utf-8?B?dTJKVVFTMHFPME1mSTIwV2RPcGorVE5BaGpWcU1wTXNtNXNtNkRkNGxveVgz?=
 =?utf-8?B?cmVCcXloSnUrOHNEbUR4NFRVOW9TclViWTAzUDJ4aVUwdlVNRXQ4aSs3cHVr?=
 =?utf-8?Q?VHpiiUpUvUl5gr7LTy3tRyFnC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDF99E6D2DCABD4B85E69216581C69FF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4426c2-b29d-4ebb-d3f5-08db8a0e59d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 17:17:24.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ps6ZiXuXVrCiYGVYflhe9cf55rgbahTtsy2ckCbtfd0q74CyERnvc+fxPSB+cRteXJpuLpUvxmCYCAWQvqiODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIEp1bCAyMSwgMjAyMywgYXQgNjoxOSBBTSwgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+IHdyb3RlOg0KPiANCj4+ICAgICAgdW5pb24gew0KPj4gKyAgICAgICAgICAg
ICBzdHJ1Y3QgbGlzdF9oZWFkICAgICAgICBkZWxfbGlzdDsNCj4+ICAgICAgICAgICAgICBzdHJ1
Y3QgcmN1X2hlYWQgICAgICAgICByY3U7DQo+PiAtICAgICAgICAgICAgIHN0cnVjdCBsbGlzdF9u
b2RlICAgICAgIGxsaXN0OyAgLyogRm9yIGZyZWVpbmcgYWZ0ZXIgUkNVICovDQo+PiArICAgICAg
ICAgICAgIHVuc2lnbmVkIGxvbmcgICAgICAgICAgIGlzX2ZyZWVkOyAvKiBGcmVlZCBpZiBvbmUg
b2YgdGhlIGFib3ZlIGlzIHNldCAqLw0KPiANCj4gSSBjaGFuZ2VkIHRoZSBmcmVlaW5nIGFyb3Vu
ZC4gVGhlIGRlbnRyaWVzIGFyZSBmcmVlZCBiZWZvcmUgcmV0dXJuaW5nIGZyb20NCj4gZXZlbnRm
c19yZW1vdmVfZGlyKCkuDQo+IA0KPiBJIGFsc28gYWRkZWQgYSAiaXNfZnJlZWQiIGZpZWxkIHRo
YXQgaXMgcGFydCBvZiB0aGUgdW5pb24gYW5kIGlzIHNldCBpZg0KPiBsaXN0IGVsZW1lbnRzIGhh
dmUgY29udGVudC4gTm90ZSwgc2luY2UgdGhlIHVuaW9uIHdhcyBjcml0aWNpemVkIGJlZm9yZSwg
SQ0KPiB3aWxsIHN0YXRlIHRoZSBlbnRpcmUgcHVycG9zZSBvZiBkb2luZyB0aGlzIHBhdGNoIHNl
dCBpcyB0byBzYXZlIG1lbW9yeS4NCj4gVGhpcyBzdHJ1Y3R1cmUgd2lsbCBiZSB1c2VkIGZvciBl
dmVyeSBldmVudCBmaWxlLiBXaGF0J3MgdGhlIHBvaW50IG9mDQo+IGdldHRpbmcgcmlkIG9mIGRl
bnRyaWVzIGlmIHdlIGFyZSByZXBsYWNpbmcgaXQgd2l0aCBzb21ldGhpbmcganVzdCBhcyBiaWc/
DQo+IEFueXdheSwgc3RydWN0IGRlbnRyeSBkb2VzIHRoZSBleGFjdCBzYW1lIHRoaW5nIQ0KDQpI
ZXksIGRvbuKAmXQgc2hvb3QgbWXigKYNCg0KW0FuZCBhZG1pdHRlZGx5LCBJIGRpZG7igJl0IHJl
dmlldyB0aGUgd2hvbGUgc2VyaWVzIGFmdGVyIHYxLl0NCg0KSSB1bmRlcnN0YW5kIHlvdXIgcG9z
aXRpb24sIGJ1dCBJIHRoaW5rIHRoYXQgYXQgbGVhc3QgaXNfZnJlZWQgc2hvdWxkIG5vdA0KYmUg
aW4gdGhlIHVuaW9uLCBhbmQgeW91IGNhbiBqdXN0IHB1dCBpdCBhZnRlciB1bW9kZV90Lg0KDQpF
dmVuIGZvciB0aGUgbWF0dGVyIG9mIHNpemUsIGl0IHNob3VsZCBub3QgbWF0dGVyIGluIG1vc3Qg
YXJjaGl0ZWN0dXJlcw0Kc2luY2UgdW1vZGVfdCBpcyAxNi1iaXQsIGFzIG5hdHVyYWwgYWxpZ25t
ZW50IGlzIGF0IGxlYXN0IDMyLWJpdHMuDQoNClsgQW5kIOKAnGJvb2wiIGlzIGNsZWFyZXIgdHlw
ZSBmb3IgaXNfZnJlZWQuIF0NCg0K
