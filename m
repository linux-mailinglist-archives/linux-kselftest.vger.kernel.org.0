Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E57A56B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjISAus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 20:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjISAur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 20:50:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB1115;
        Mon, 18 Sep 2023 17:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF5t+BkZGh0VWTQz0IXP5rv1PuiXvHRCc2YgfR8G3bntXgjDiIbjGkCaXTMt/ecHv3EIs65Dek6LE/1QwAOs5spfay94wKgl6Nk1GSJSkWi3INCoRu9gBGjtOv1dcskIOaCJR/0HLTOYaiZaG/KJhuwjFKrQuWeFYar0iYYKNt9WFRoyzjJi6x44sScw8LbWDV/aE845K17lAOefoGP92eUSOASFGqTMVs2R73aPoBe/CFz311h7F2TTk8F+ldkuWFNZ+QtuOuKEkuzHNFmI3jPqN3XYNnK+aGXeWBdN40JqRuCOIISI25UuYkWIPTbVHjztKEq3GIwaPNR3dFAGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEwXnzgmQ9/3sS8ni6ZKB0f4c/KJ22GVHlF7g+kcZiA=;
 b=LfDrmTfCxYFCJMQPtKnwupj4AWiXWaqzXLkfDy4qy5EthW+InLFlL7QPboUGxLEFcADHUfX4iw7EO57sJdVjPL4k1PQOM+bL10ZodYtmy7a8wm+tdcpifMI1qBF+okQ0hy+vb51StnQoLxxDz/ms1B0A1labQUIhECiQzC/bfD9sT6HXDJw48e+hkbSwXX4jWGYZ35mHdNSIAqbWwYfsU24yd7vPFYhbifU7WwZUNXmnR9VAAZ2x0VrNjnTvh3gu4KbRTTrBAyQUDUXeDC66HICCAtRUq4u+8HW3hhObuyBkS+1xDGM1DKSAD8nXIhYrfb97WoMngExMhNrabC9lpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEwXnzgmQ9/3sS8ni6ZKB0f4c/KJ22GVHlF7g+kcZiA=;
 b=utxw7+mhGxD09vXVHShSkXCA/NiEHRNRsC3WWEWhzyqQcoQYZTC9XgikPxQF+r3Zai2QFuRpxXOkN56irrbi7Dj+PKUcidpCBKNv1t2RG2yiiuddlPB1ijjizPnelGJc8yPCQOtOuCyWnjS4/l+mSxi1Ub1wdDXhG2TNa3qME4E=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 00:50:35 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 00:50:35 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH V7 0/7] amd-pstate preferred core
Thread-Topic: [PATCH V7 0/7] amd-pstate preferred core
Thread-Index: AQHZ6ggoqrVAOAnUeE2IZUd7OYKx57Ag2n0AgAB3brA=
Date:   Tue, 19 Sep 2023 00:50:34 +0000
Message-ID: <DM4PR12MB6351EEEF25AE6D5D8711F319F7FAA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230918081407.756858-1-li.meng@amd.com>
 <8010edd3-6eac-4f14-a4ed-ef69cca63906@amd.com>
In-Reply-To: <8010edd3-6eac-4f14-a4ed-ef69cca63906@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ea98e559-14a9-4551-a881-d59c051843b4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-19T00:48:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH0PR12MB7814:EE_
x-ms-office365-filtering-correlation-id: 9b3ca902-d26e-42c2-e5c4-08dbb8aa6f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/oVTtkkd9zuhxChd6RmoJrnfZgnAk5atAdz9xo3qb7GSqwLm66T34V5ADjbrMyFIjkyjCQqi/3a+ahHlkMiODSgekKM5RsSGLKUUbO17BqG8Ok6Kue7hAjtJ0RKuNCqJPfT3WGhDWs7ay204Ub/bjWRcWhVua1Hf2R9kkSgXjdIxBtfdgk8C8R/qaoeYxUrF2Q9Kd3NvaIHIZpF+gUmcEKbF7WUcdhP+nW/axkmGuuXCWpKG45pYeTcn5AscFPvU+2Y9YnMpPYd9cvcyoyc0nV7J2vNUnr/TcGe0Hi8nn/EClWecwqeXrMO64na5go6zOavjeZqWsdyEgMiMcydDF+4p7142MRMLVn17HaB4frLGa2eDm4Ef37rcpWgzj7JPQfub0v9BhqYG+ddvb/nWVa3V0fzIblY/BM9uppH2MnYjNoeJD+sGf1FCspb6y3hwa5TAGINkawC1wdtTcrDcWf+rwxqGlChoS2vJD2V1GXY16qWYiOmnzR7OvTVpBwm5So7h2nDU3Db3y6Lp+n9unl1eiNc/JgscRWaXoMj0jw7fFG0Q2BEunW1rx6bt/zrDTP3HcNvb7Q/mk5Ki9undsew9rtra/KRQFlOwICR/uNNiqva6ApIhw+mmhQW9W8q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(186009)(1800799009)(451199024)(9686003)(53546011)(6506007)(7696005)(71200400001)(83380400001)(122000001)(86362001)(33656002)(38070700005)(38100700002)(55016003)(26005)(110136005)(76116006)(66946007)(316002)(54906003)(64756008)(66476007)(66446008)(41300700001)(66556008)(6636002)(2906002)(52536014)(5660300002)(8676002)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlNlbDBzSXFDTWt5SVROZmhSRlhzb3BkMTlpRE1uMzlDYTgrZVpmQktXV0x4?=
 =?utf-8?B?NCsyREg5amk5RXR6RThmR28yWHJtbUR2Qnl6MndJbW0xTUVNQUVYUzNzSUhk?=
 =?utf-8?B?dmlkUVNTN1FXcEtTYXkrcVVNV21kTHdsVGVTVkZpWFpySSt4N0pYQUlDbnZT?=
 =?utf-8?B?dldDTW0xVkhqdnVWRFhSbm9kK0FGV0JrYkVKUlRSUnVHZXhsemJFc0hMcEhF?=
 =?utf-8?B?QzBZWGNPN2xTOWRFbnpwN25UalppbEZad201V3MwS3JpS2lOQWs5cEIzTWhq?=
 =?utf-8?B?b2xwNmkxbmFscnNaTjFRbmVVMVlYeXBRM0RtbjkxeDlzMU5obkJjQ0VpeTFx?=
 =?utf-8?B?NFA5ajRnUmI2WHJNRlN5dGExemR0eDY2dzNlMjEvUG1LUnlvbTJJUGtNL1Jv?=
 =?utf-8?B?MitmVkJQRmduRjN5anhFM2UwbVA4VStXaUhTTlk3NjUvWkdVWG0vNTNqWXIw?=
 =?utf-8?B?UFZmOW4vQkgxTy9XcDcyMEY4N3F0KzBwbWdGbEV5Q05CMlh5WjJGbHV0cyt1?=
 =?utf-8?B?V25vU0M2eUNOM09xWkRQZ3FsSE5kSTNTQkVMT3dVa0UyR0U0YW1pQzl1dytM?=
 =?utf-8?B?ME1CZUhSOGdxeU5wTHlUUEpEUEJoMGIrQ2tSNERvN0ZFZFowYmF1MUh6OXVO?=
 =?utf-8?B?OVZ5NkJiUWoyVnREZ0ttOTVrWStkOUlSNFp5Y2xaeU4wZzRuNDZVMWJabjFX?=
 =?utf-8?B?MDlCb2xpcDBDVHF3Q2ZhNGkwV2pROHl4S05ZeGFuZmRKV2hqeG1qZG1qdXFo?=
 =?utf-8?B?cUZTc3RqQllJTjdxMnJIN2tlV0RVOTZYYWgxTmg5UVVkcDdrMDRBNWFNTnVa?=
 =?utf-8?B?TUlKU2J2RkVWKzZHaTcyUlBxUEhDQm45aVYwUHJUU1NRdzMwNXlydVIzWmJk?=
 =?utf-8?B?R1BEZVBROVhRRk05cnpoc2lrYzA5Q0VVU3VaYnlFc3ZJRURNZUJ3SkkxT0lW?=
 =?utf-8?B?KzBIL1o5WElYZ0R5RmR1RklFTzlTNVlyTDNXYmxoYnROQ3Jub0tXcVZWM0ZR?=
 =?utf-8?B?U2U2UmRPRU1vaDlEbGwyTHlQMzdyVm9ZNzlzS2lUSHlxampLWlNWTXA2MGpi?=
 =?utf-8?B?bE9qM3B2anltV2o4UXVEbFlRRWZkdG9LMVlVY05DR2tGWXdIaGIvWS95M2JN?=
 =?utf-8?B?dkZBWTc0T1ZBS2RqaEg5ZlZjclpOajNJWUpMUllaam5wdVpjL1lHM0diWU94?=
 =?utf-8?B?Y2U4MnVIenJmSlpkRndzK1lwU2Y1elJxVDdQdFVtcGhGUllCOHdISisxMDlw?=
 =?utf-8?B?cWk5VThRTVZIb1ZoZjI2MDRSRjYveEZxaDBMTThGMDQwelRlaDJWN21oL0g2?=
 =?utf-8?B?UWEwRU1makhxZXRIRVpubGEzKy9LQ1hhVnIzUXNibzFObGhOYjRJNjBvekJx?=
 =?utf-8?B?SEJ6Y29xSEcxcXA1T0IzbjVKRnc0Sm4xYWwxUVRiV3Q3dkh0SlZsbmw0RmZ0?=
 =?utf-8?B?SGhtRGJ0V1U1NXFFa0pKZVFBL2RvYzd4OFNJM0RiU3RQQlAvTlIxdE9pRWtL?=
 =?utf-8?B?NFJJTXUxZlJmWkNKcmw1M1hYYU9rRzdVUkwxNVJSNlNZM01BZ1o1Z29IaXZM?=
 =?utf-8?B?T0FXamQ1YWhBRExyQUlrTjlkNE5HdVJmRGpJQ3VscDF3bEw0NXB3M0VEc1Bz?=
 =?utf-8?B?MFIzdXYyMExJVjJQbXdoNDZ2NHhMbUhnQi9tRkFUelYzMzc4WlllVld5T3lH?=
 =?utf-8?B?cUVlNklueDdGYmNjcCtkMENJQWd1WXgxSlNaZUpGQ2VuS3luR3ZwdHI0a2ow?=
 =?utf-8?B?cDZQdExZYjAwMTlSQU03SUd5TVF5cmlyZmpkcDhDMXVkQ3JxbFJaTW5NZk9R?=
 =?utf-8?B?T0J4NzlPV3ZkNk5DUDFLTFZrM3pJV0dLS3FFaG9MbDRneS9NVEs5MHo4RHpQ?=
 =?utf-8?B?UHh1QTlRZFAwd2k5QUJ6aUd2WHNMYVVtdW8wN2hPcFhKeWpmMnptSDF6QjIy?=
 =?utf-8?B?cVBhcTI2L2M2SXNRSnM3bUZvK21IQ2s3YlJ6M3V6WTVGVVcyaUNmRTF2ZVU0?=
 =?utf-8?B?UUtKT0pZSmQ4QWRwbUl1TTJuQzQxYnRpTGhCOWxJWFhIdnRpWUl4MnEzNCt5?=
 =?utf-8?B?Q2lZK1BXZ2lZQURDTjgyUzF3R09jZ29UTnJNSURNM2xrVytOVEtaYVpBRFNz?=
 =?utf-8?Q?58Bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3ca902-d26e-42c2-e5c4-08dbb8aa6f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 00:50:34.9280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRvZpooogQItx6rsM3HrOEIxOm7mxhlrpN6n362DfrEbFtQhf8bfjtewSIDVFNp1H4qDL22NrIBviue7OHQzNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvOg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAyMDIz
IDE6NDEgQU0NCj4gVG86IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IFJh
ZmFlbCBKIC4gV3lzb2NraQ0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBIdWFuZywg
UmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4geDg2QGtlcm5lbC5vcmc7IGxpbnV4LWFj
cGlAdmdlci5rZXJuZWwub3JnOyBTaHVhaCBLaGFuDQo+IDxza2hhbkBsaW51eGZvdW5kYXRpb24u
b3JnPjsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgRm9udGVub3QsDQo+IE5hdGhh
biA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFrLlNo
YXJtYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IFl1YW4s
IFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyBEdSwNCj4gWGlhb2ppYW4gPFhpYW9qaWFuLkR1
QGFtZC5jb20+OyBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPjsNCj4gQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjcgMC83
XSBhbWQtcHN0YXRlIHByZWZlcnJlZCBjb3JlDQo+DQo+IE9uIDkvMTgvMjAyMyAwMzoxNCwgTWVu
ZyBMaSB3cm90ZToNCj4gPiBIaSBhbGw6DQo+ID4NCj4gPiBUaGUgY29yZSBmcmVxdWVuY3kgaXMg
c3ViamVjdGVkIHRvIHRoZSBwcm9jZXNzIHZhcmlhdGlvbiBpbiBzZW1pY29uZHVjdG9ycy4NCj4g
PiBOb3QgYWxsIGNvcmVzIGFyZSBhYmxlIHRvIHJlYWNoIHRoZSBtYXhpbXVtIGZyZXF1ZW5jeSBy
ZXNwZWN0aW5nIHRoZQ0KPiA+IGluZnJhc3RydWN0dXJlIGxpbWl0cy4gQ29uc2VxdWVudGx5LCBB
TUQgaGFzIHJlZGVmaW5lZCB0aGUgY29uY2VwdCBvZg0KPiA+IG1heGltdW0gZnJlcXVlbmN5IG9m
IGEgcGFydC4gVGhpcyBtZWFucyB0aGF0IGEgZnJhY3Rpb24gb2YgY29yZXMgY2FuDQo+ID4gcmVh
Y2ggbWF4aW11bSBmcmVxdWVuY3kuIFRvIGZpbmQgdGhlIGJlc3QgcHJvY2VzcyBzY2hlZHVsaW5n
IHBvbGljeQ0KPiA+IGZvciBhIGdpdmVuIHNjZW5hcmlvLCBPUyBuZWVkcyB0byBrbm93IHRoZSBj
b3JlIG9yZGVyaW5nIGluZm9ybWVkIGJ5DQo+ID4gdGhlIHBsYXRmb3JtIHRocm91Z2ggaGlnaGVz
dCBwZXJmb3JtYW5jZSBjYXBhYmlsaXR5IHJlZ2lzdGVyIG9mIHRoZSBDUFBDDQo+IGludGVyZmFj
ZS4NCj4gPg0KPiA+IEVhcmxpZXIgaW1wbGVtZW50YXRpb25zIG9mIGFtZC1wc3RhdGUgcHJlZmVy
cmVkIGNvcmUgb25seSBzdXBwb3J0IGENCj4gPiBzdGF0aWMgY29yZSByYW5raW5nIGFuZCB0YXJn
ZXRlZCBwZXJmb3JtYW5jZS4gTm93IGl0IGhhcyB0aGUgYWJpbGl0eQ0KPiA+IHRvIGR5bmFtaWNh
bGx5IGNoYW5nZSB0aGUgcHJlZmVycmVkIGNvcmUgYmFzZWQgb24gdGhlIHdvcmtsb2FkIGFuZA0K
PiA+IHBsYXRmb3JtIGNvbmRpdGlvbnMgYW5kIGFjY291bnRpbmcgZm9yIHRoZXJtYWxzIGFuZCBh
Z2luZy4NCj4gPg0KPiA+IEFtZC1wc3RhdGUgZHJpdmVyIHV0aWxpemVzIHRoZSBmdW5jdGlvbnMg
YW5kIGRhdGEgc3RydWN0dXJlcyBwcm92aWRlZA0KPiA+IGJ5IHRoZSBJVE1UIGFyY2hpdGVjdHVy
ZSB0byBlbmFibGUgdGhlIHNjaGVkdWxlciB0byBmYXZvciBzY2hlZHVsaW5nDQo+ID4gb24gY29y
ZXMgd2hpY2ggY2FuIGJlIGdldCBhIGhpZ2hlciBmcmVxdWVuY3kgd2l0aCBsb3dlciB2b2x0YWdl
Lg0KPiA+IFdlIGNhbGwgaXQgYW1kLXBzdGF0ZSBwcmVmZXJyZWQgY29yZS4NCj4gPg0KPiA+IEhl
cmUgc2NoZWRfc2V0X2l0bXRfY29yZV9wcmlvKCkgaXMgY2FsbGVkIHRvIHNldCBwcmlvcml0aWVz
IGFuZA0KPiA+IHNjaGVkX3NldF9pdG10X3N1cHBvcnQoKSBpcyBjYWxsZWQgdG8gZW5hYmxlIElU
TVQgZmVhdHVyZS4NCj4gPiBBbWQtcHN0YXRlIGRyaXZlciB1c2VzIHRoZSBoaWdoZXN0IHBlcmZv
cm1hbmNlIHZhbHVlIHRvIGluZGljYXRlIHRoZQ0KPiA+IHByaW9yaXR5IG9mIENQVS4gVGhlIGhp
Z2hlciB2YWx1ZSBoYXMgYSBoaWdoZXIgcHJpb3JpdHkuDQo+ID4NCj4gPiBBbWQtcHN0YXRlIGRy
aXZlciB3aWxsIHByb3ZpZGUgYW4gaW5pdGlhbCBjb3JlIG9yZGVyaW5nIGF0IGJvb3QgdGltZS4N
Cj4gPiBJdCByZWxpZXMgb24gdGhlIENQUEMgaW50ZXJmYWNlIHRvIGNvbW11bmljYXRlIHRoZSBj
b3JlIHJhbmtpbmcgdG8gdGhlDQo+ID4gb3BlcmF0aW5nIHN5c3RlbSBhbmQgc2NoZWR1bGVyIHRv
IG1ha2Ugc3VyZSB0aGF0IE9TIGlzIGNob29zaW5nIHRoZQ0KPiA+IGNvcmVzIHdpdGggaGlnaGVz
dCBwZXJmb3JtYW5jZSBmaXJzdGx5IGZvciBzY2hlZHVsaW5nIHRoZSBwcm9jZXNzLg0KPiA+IFdo
ZW4gYW1kLXBzdGF0ZSBkcml2ZXIgcmVjZWl2ZXMgYSBtZXNzYWdlIHdpdGggdGhlIGhpZ2hlc3Qg
cGVyZm9ybWFuY2UNCj4gPiBjaGFuZ2UsIGl0IHdpbGwgdXBkYXRlIHRoZSBjb3JlIHJhbmtpbmcu
DQo+ID4NCj4NCj4gRm9yIHRoZSByZW1haW5pbmcgcGF0Y2hlcyBtaXNzaW5nIG15IHRhZzoNCj4N
Cj4gUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPg0KPg0KW01lbmcsIExpIChKYXNzbWluZSldDQpUaGFuayB5b3UgdmVyeSBtdWNoIQ0KSSB3
aWxsIGFkZCBSZXZpZXctYnkgZmxhZyBmb3IgdGhlIHJlbWFpbmluZyBwYXRjaGVzLg0KDQo+ID4g
Q2hhbmdlcyBmb3JtIFY2LT5WNzoNCj4gPiAtIHg4NjoNCj4gPiAtIC0gTW9kaWZ5IGtjb25maWcg
YWJvdXQgWDg2X0FNRF9QU1RBVEUuDQo+ID4gLSBjcHVmcmVxOiBhbWQtcHN0YXRlOg0KPiA+IC0g
LSBtb2RpZnkgaW5jb3JyZWN0IGNvbW1lbnRzIGFib3V0IHNjaGVkdWxlcl93b3JrKCkuDQo+ID4g
LSAtIGNvbnZlcnQgaGlnaGVzdF9wZXJmIGRhdGEgdHlwZS4NCj4gPiAtIC0gbW9kaWZ5IHByZWZl
cnJlZCBjb3JlIGluaXQgd2hlbiBjcHUgaW5pdCBhbmQgb25saW5lLg0KPiA+IC0gYWNwaTogY3Bw
YzoNCj4gPiAtIC0gbW9kaWZ5IGxpbmsgb2YgQ1BQQyBoaWdoZXN0IHBlcmZvcm1hbmNlLg0KPiA+
IC0gY3B1ZnJlcToNCj4gPiAtIC0gbW9kaWZ5IGxpbmsgb2YgQ1BQQyBoaWdoZXN0IHBlcmZvcm1h
bmNlIGNoYW5nZWQuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvcm0gVjUtPlY2Og0KPiA+IC0gY3B1ZnJl
cTogYW1kLXBzdGF0ZToNCj4gPiAtIC0gbW9kaWZ5IHRoZSB3cm9uZyB0YWcgb3JkZXIuDQo+ID4g
LSAtIG1vZGlmeSB3YXJuaW5nIGFib3V0IGh3X3ByZWZjb3JlIHN5c2ZzIGF0dHJpYnV0ZS4NCj4g
PiAtIC0gZGVsZXRlIGR1cGxpY2F0ZSBjb21tZW50cy4NCj4gPiAtIC0gbW9kaWZ5IHRoZSB2YXJp
YWJsZSBuYW1lIGNwcGNfaGlnaGVzdF9wZXJmIHRvIHByZWZjb3JlX3JhbmtpbmcuDQo+ID4gLSAt
IG1vZGlmeSBqdWRnbWVudCBjb25kaXRpb25zIGZvciBzZXR0aW5nIGhpZ2hlc3RfcGVyZi4NCj4g
PiAtIC0gbW9kaWZ5IHN5c2ZzIGF0dHJpYnV0ZSBmb3IgQ1BQQyBoaWdoZXN0IHBlcmYgdG8gcHJf
ZGVidWcgbWVzc2FnZS4NCj4gPiAtIERvY3VtZW50YXRpb246IGFtZC1wc3RhdGU6DQo+ID4gLSAt
IG1vZGlmeSB3YXJuaW5nOiB0aXRsZSB1bmRlcmxpbmUgdG9vIHNob3J0Lg0KPiA+DQo+ID4gQ2hh
bmdlcyBmb3JtIFY0LT5WNToNCj4gPiAtIGNwdWZyZXE6IGFtZC1wc3RhdGU6DQo+ID4gLSAtIG1v
ZGlmeSBzeXNmcyBhdHRyaWJ1dGUgZm9yIENQUEMgaGlnaGVzdCBwZXJmLg0KPiA+IC0gLSBtb2Rp
Znkgd2FybmluZyBhYm91dCBjb21tZW50cw0KPiA+IC0gLSByZWJhc2UgbGludXgtbmV4dA0KPiA+
IC0gY3B1ZnJlcToNCj4gPiAtIC0gTW9pZGZ5IHdhcm5pbmcgYWJvdXQgZnVuY3Rpb24gZGVjbGFy
YXRpb25zLg0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZToNCj4gPiAtIC0gYWxpZ24g
d2l0aCBgYGFtZC1wc3RhdGBgDQo+ID4NCj4gPiBDaGFuZ2VzIGZvcm0gVjMtPlY0Og0KPiA+IC0g
RG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZToNCj4gPiAtIC0gTW9kaWZ5IGluYXBwcm9wcmlhdGUg
ZGVzY3JpcHRpb25zLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3JtIFYyLT5WMzoNCj4gPiAtIHg4NjoN
Cj4gPiAtIC0gTW9kaWZ5IGtjb25maWcgYW5kIGRlc2NyaXB0aW9uLg0KPiA+IC0gY3B1ZnJlcTog
YW1kLXBzdGF0ZToNCj4gPiAtIC0gQWRkIENvLWRldmVsb3BlZC1ieSB0YWcgaW4gY29tbWl0IG1l
c3NhZ2UuDQo+ID4gLSBjcHVmcmVxOg0KPiA+IC0gLSBNb2RpZnkgY29tbWl0IG1lc3NhZ2UuDQo+
ID4gLSBEb2N1bWVudGF0aW9uOiBhbWQtcHN0YXRlOg0KPiA+IC0gLSBNb2RpZnkgaW5hcHByb3By
aWF0ZSBkZXNjcmlwdGlvbnMuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvcm0gVjEtPlYyOg0KPiA+IC0g
YWNwaTogY3BwYzoNCj4gPiAtIC0gQWRkIHJlZmVyZW5jZSBsaW5rLg0KPiA+IC0gY3B1ZnJlcToN
Cj4gPiAtIC0gTW9pZGZ5IGxpbmsgZXJyb3IuDQo+ID4gLSBjcHVmcmVxOiBhbWQtcHN0YXRlOg0K
PiA+IC0gLSBJbml0IHRoZSBwcmlvcml0aWVzIG9mIGFsbCBvbmxpbmUgQ1BVcw0KPiA+IC0gLSBV
c2UgYSBzaW5nbGUgdmFyaWFibGUgdG8gcmVwcmVzZW50IHRoZSBzdGF0dXMgb2YgcHJlZmVycmVk
IGNvcmUuDQo+ID4gLSBEb2N1bWVudGF0aW9uOg0KPiA+IC0gLSBEZWZhdWx0IGVuYWJsZWQgcHJl
ZmVycmVkIGNvcmUuDQo+ID4gLSBEb2N1bWVudGF0aW9uOiBhbWQtcHN0YXRlOg0KPiA+IC0gLSBN
b2RpZnkgaW5hcHByb3ByaWF0ZSBkZXNjcmlwdGlvbnMuDQo+ID4gLSAtIERlZmF1bHQgZW5hYmxl
ZCBwcmVmZXJyZWQgY29yZS4NCj4gPiAtIC0gVXNlIGEgc2luZ2xlIHZhcmlhYmxlIHRvIHJlcHJl
c2VudCB0aGUgc3RhdHVzIG9mIHByZWZlcnJlZCBjb3JlLg0KPiA+DQo+ID4gTWVuZyBMaSAoNyk6
DQo+ID4gICAgeDg2OiBEcm9wIENQVV9TVVBfSU5URUwgZnJvbSBTQ0hFRF9NQ19QUklPIGZvciB0
aGUgZXhwYW5zaW9uLg0KPiA+ICAgIGFjcGk6IGNwcGM6IEFkZCBnZXQgdGhlIGhpZ2hlc3QgcGVy
Zm9ybWFuY2UgY3BwYyBjb250cm9sDQo+ID4gICAgY3B1ZnJlcTogYW1kLXBzdGF0ZTogRW5hYmxl
IGFtZC1wc3RhdGUgcHJlZmVycmVkIGNvcmUgc3VwcG9ydGluZy4NCj4gPiAgICBjcHVmcmVxOiBB
ZGQgYSBub3RpZmljYXRpb24gbWVzc2FnZSB0aGF0IHRoZSBoaWdoZXN0IHBlcmYgaGFzIGNoYW5n
ZWQNCj4gPiAgICBjcHVmcmVxOiBhbWQtcHN0YXRlOiBVcGRhdGUgYW1kLXBzdGF0ZSBwcmVmZXJy
ZWQgY29yZSByYW5raW5nDQo+ID4gICAgICBkeW5hbWljYWxseQ0KPiA+ICAgIERvY3VtZW50YXRp
b246IGFtZC1wc3RhdGU6IGludHJvZHVjZSBhbWQtcHN0YXRlIHByZWZlcnJlZCBjb3JlDQo+ID4g
ICAgRG9jdW1lbnRhdGlvbjogaW50cm9kdWNlIGFtZC1wc3RhdGUgcHJlZmVycmQgY29yZSBtb2Rl
IGtlcm5lbA0KPiBjb21tYW5kDQo+ID4gICAgICBsaW5lIG9wdGlvbnMNCj4gPg0KPiA+ICAgLi4u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgICA1ICsNCj4gPiAg
IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QgICB8ICA1OCArKysr
Ky0NCj4gPiAgIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNSArLQ0KPiA+ICAgZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jICAgICAgICAgICAgICAgICAg
ICAgIHwgIDEzICsrDQo+ID4gICBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZlci5jICAgICAg
ICAgICAgICAgfCAgIDYgKw0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyAgICAg
ICAgICAgICAgICAgIHwgMTk3ICsrKysrKysrKysrKysrKystLQ0KPiA+ICAgZHJpdmVycy9jcHVm
cmVxL2NwdWZyZXEuYyAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsrDQo+ID4gICBpbmNsdWRl
L2FjcGkvY3BwY19hY3BpLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiA+ICAgaW5j
bHVkZS9saW51eC9hbWQtcHN0YXRlLmggICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAg
IGluY2x1ZGUvbGludXgvY3B1ZnJlcS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+
ID4gICAxMCBmaWxlcyBjaGFuZ2VkLCAyOTEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0p
DQo+ID4NCg0K
