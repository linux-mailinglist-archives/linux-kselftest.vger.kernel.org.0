Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152387C9CFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJPBpj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 21:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPBpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 21:45:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A54C1;
        Sun, 15 Oct 2023 18:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+NdTKG/ORzlAKJLdY4uXCkSHabUiTy0KLIPFKJuWICIa3kiT+a29UEbPv1rrT8Ge3n4p65OhaVq7HbrHIjMB5MQUu5vnx9A874PUYD40JGfayKAiJmYGarUOE/ApuQvE0NWM6QPO62MKB6V9xvfzSeYvh4vgOqgRx1o9+Zb4dxcnkf3Us7bIf+mHWvGIT6TbAic/cNWSYUJZgGo032gQctfnWsVfR/6vc/ogeK60ZHhnasG3rNVhD9ebYQke/OExscOAmfAq/H3a6vTsc2UqIcWIP8uy5YnccTqF2LbayctCikLUb/iTN3U+n4uESGJX+oQDzX4f273GbOIBy5sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgyVAAbwJ3VjS/TeUthUzn+1KHYuqxdudGY+LIsaHFo=;
 b=QUcqZcpCuFVtbAWo3C5bqJznwHcqcrVAb/EhK6gi57Wb1DAl8xmb6rAjxUpNYMIKiXEHitohgvPHJiosD7qrhR6KHDNnUnoislzKb11YJPIhsj1JKJVswn4BMPW1DHSRuwo0o/JMhoa/QwSweE9vcGJZeRh/NCMHvfVpUzNBYihJu4aoQ4/kmIzS0bGonLu5j6XCAgSBmPA0WclelsIcOfvh2L3ynUAK5QMRH6c05gDjoRbDmFHWZNGoeEKO7WUGAGcwELPxJ7hdQgbgJrmGhIuX54OUSXhqgOOYUSoEdykFGo98KGgAlvIZbwIkpXWWwFlOIw3EkiTBz67f2anVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgyVAAbwJ3VjS/TeUthUzn+1KHYuqxdudGY+LIsaHFo=;
 b=0zcqkPcfMo8tDNiIV/0CwHZHk5ryulB7DSQqxz4bXJ9LpldprhbOdHNU4QLuwe2f3LI6X7A/fl05C1Fl2DeNxzZPfXLvvhjKgPLdxabXQLV5vmURoSL/s4hA+lreItJjIiCZMb5ViSe3aEEbnTVzmt8N0XEfZ1rQaZTmx7ehKVs=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 01:45:33 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 01:45:33 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
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
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RESEND PATCH V9 0/7] amd-pstate preferred core
Thread-Topic: [RESEND PATCH V9 0/7] amd-pstate preferred core
Thread-Index: AQHZ/YXOLpzM2HYVGUCj6xp+rhaUIrBH3XiAgAPLNkA=
Date:   Mon, 16 Oct 2023 01:45:33 +0000
Message-ID: <DM4PR12MB6351613D99791DAC1A573DFDF7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
 <12303526.O9o76ZdvQC@natalenko.name>
In-Reply-To: <12303526.O9o76ZdvQC@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=396ee658-ed72-4cc4-b8f6-d216dea10879;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-16T01:41:21Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB7294:EE_
x-ms-office365-filtering-correlation-id: 8b8cb01e-44d4-48e3-6a41-08dbcde99602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yk3h1yoaR2y+9VnQ4lP4jqze6W1ozXyIJrCj6aChnuvTapVGUQnAlTjJb7cQJpc2wmVFcua/w3WZkrIPRbYvf5SCFdeEylsLcPVwnNCYix/HclZCMhlas+BPhX26KL2njmKAdVcY08tX1dqeSFCwrH5Jvj81jaPfw0Cw1U9j3IkJi2LdfpOE7N5h2RzLNurRT3SIkZ5eHNi0GUXBJ8FZ8v158CN9efQO4rdPB4JgREG5frkHhGDALOAp/mhiDK4LJheIoHKfdWUyoDhkIpoPLhQlIxSdqCJgRq4Ruf6Uu4rl8kMtG5lYYPsA0ayqu+uMRtOb6iXHF7aUVZhIeUNqV6fSCMyIqkezofusAx7yA2QMePNtfQfbKH3GDup1BbLXd9e3ZLl4kuV0evznkf14+hBu/sOoq29NYqmHnpcHNot+KCy5dT6CWKTnM6bUSEQtjL65RkOU2wDYpv9XrvXQzwXtZORHTquIqLiVJgOIbwa8/i93Q3zdgIcZcOjar4dAvlZyxfI4JfiQQnybtUECgm+WuLAwRLn7cQciAkU6x15TEFEU46awJNmL0Kop/Mpvpzfb64DKYgnsDERejs7t0nnYQ6OsbDevw/uuac3DJPZ1TCJQ1xcmQriXsH1qvrWE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(478600001)(66574015)(26005)(53546011)(6506007)(9686003)(7696005)(71200400001)(41300700001)(5660300002)(316002)(64756008)(66446008)(66476007)(54906003)(66556008)(6636002)(66946007)(110136005)(76116006)(122000001)(86362001)(33656002)(38100700002)(38070700005)(83380400001)(4326008)(52536014)(8676002)(8936002)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXlDNURFM3BWWVExU0ZGdkNqTXhyNWdJTVhVT250TzFwdU1Kb2ZYcGJkbTdL?=
 =?utf-8?B?d0cvWnZ4LytzVUpSRENlZGpCM0RsZ3prcERud1dZN3BCTUMxcHpqUVIzYlF3?=
 =?utf-8?B?MW0wUzlidFJqSDZ2TUxpYWZQRDh1dzUzMnJySGM1aTYvS3JBZ0luelkrbVcx?=
 =?utf-8?B?RnhibXVybHJVeEw1cHVRYmpQZVl1UTJLUFdDVUprMURmVHRzaitRZWNzK1U3?=
 =?utf-8?B?aGJxK0Jrd0VZM2phSW5rOHhSU3dLME5EeW9SRzk4UEhOc1I2eVcyeG4wWk5E?=
 =?utf-8?B?cVZYUDdOajBlQ2JvQS9NeWsyaktYem90MGFONFd3ejRDV2RyNXlhTlkxY1V4?=
 =?utf-8?B?K1lCdEtMMVBuTXFiR1orcDlLdmVpaEw2YmJCV0ZtY0dOR25qSC80L2JET3lj?=
 =?utf-8?B?L3ZYM0VLaXVrZ1IyZm9zV2Jrci83UGYzTHlvVHBGejZrTEJTc3BzS3MvNE9l?=
 =?utf-8?B?OW5IaHM3dE5wVUlDYktXc1hNbnV2SitWLzRySXppWjc0bHl4K09NZU5CbzZp?=
 =?utf-8?B?NkRsRXRiMkpyM2o2V0VEZ0ZTNnl6WlRDUVBoZDgrM2tDN0JmRDJYTldkWXpj?=
 =?utf-8?B?cUREdWU0c1JxZWhRaHZZQmhVbWRsZ0xEeXlTUENhS0hoWklRZS9CYzlnaEIr?=
 =?utf-8?B?N2ZjMUpsTGZobnEwTnZpSXk4S0pLK2dWNG84VnJCUHhQTXNQRTNCUnFpUzZG?=
 =?utf-8?B?Y0Q1RGl4RktZRjNyRzBCaEErc0JjZTY3ZkMvM1NoYmNvWUh3QURzYUI3cG5k?=
 =?utf-8?B?VldtaExOSE1OUEdNUGdMRXRjSC9EWGUyQWhTSENXcEsyK3Z2cVRBRm91SzF2?=
 =?utf-8?B?WmIvQ0VFa0daRmNTY1FUeWNhekNXS0hyQllycmd0Vmc2MjFkR244MXpER2Rp?=
 =?utf-8?B?R1NYUjh6VEpHMlB1VGJVTERUYkh1SWMzZ1ZNZGxWdk1SZDlPNElkVHFwUXBQ?=
 =?utf-8?B?aEQ5a0JYd3V0V2lmKzJnOGYrZEZQcDUzV3pUOEtibUU1V0ZaSHUyWHJRQ2hY?=
 =?utf-8?B?bzZneUdUZk8rV3NRL1czbDRZZVJSZ0xyYTluclh6bHVBaU9SZVA4WVQ1eEhs?=
 =?utf-8?B?Qkw5Y0p6NUR3TkozS2JwY0k4T1lsc2VPbUpZYUl0b3ZkVEQ1ZHpaV0FhUmY4?=
 =?utf-8?B?YmtFbGNEU21GTksrVUVSblR4eE8wMFZWdU5UYlZ5aExvQlliOFVPakQrY2Jl?=
 =?utf-8?B?YzZzbFQ0aWVPMnhrZnc3QStML2hEQ2d3aHJ2WExBMHJJVFRQYjJaZ285RExy?=
 =?utf-8?B?QTZiRkVLbGlUMWFsRnVFVWo2VjUra2VVRFVoMEpmT1RLVG1mck1ld0RRTUJm?=
 =?utf-8?B?OE13UWdxNVAra1lCNzBiYWtqcys4VjcyVGRGdURqWGRkUjhpNStueGJXekN2?=
 =?utf-8?B?ZWw3ejJBSitqeW9DRFdMdktnSU14bUl5S0xnZGg5ckc4a3JwcXJ2ZTI4TWFi?=
 =?utf-8?B?RkVJa0FDV3VhS0VRSXNZWDZFYXlwaWNtYUFkMG5YR0N0TTBSejhyQmZWTERX?=
 =?utf-8?B?UXIrYWFPbEwvUys5bU1QUkZHY1dKRStSZnNoQ0taZWhnSVVvcHp1dDhaYWNK?=
 =?utf-8?B?YUpMWkZtRVJGQ24rZ05kemNsQnV5WGJkTjF4L3dZVk1ta2hiMHpsMHhpcEJ6?=
 =?utf-8?B?ZURuSFB0a2NxV0xZRWV3dHdsYnA3Y1oxRmRQdzJqQ2xmT3dQUkhJTlRvSFdY?=
 =?utf-8?B?V3VrbmlnWElrOGorVjhEdER5dEh0WTY3RlRmZmMvNFN3bk9YU3Vobk5xK09o?=
 =?utf-8?B?cXQraDl0T1czeUdJSWthVytjZlVMQUZScVI3SDhOYVdCTnJwTmRnR0VtdlFv?=
 =?utf-8?B?QWtTZ095Ukx5cGNSSDV4b0dUWVlWU2dxclFrajM2Wk52b0h6L1ZKVHk3YXIv?=
 =?utf-8?B?VU4wckdGcFFnRVVBY3AyeXp6ajFvZ1l3ajlnNVppWVRXM0QxRnBNclVjMFpU?=
 =?utf-8?B?MVVVNWZaSUhudFZKYzRhNWhpZnJ1R3pWRkdLRExldEFiekpuK0drc3V3WjlP?=
 =?utf-8?B?bmphbVd2MHNUcnlKTEhzaWVuZDBMbnRGZmlyUEVLZUNnSWFPb1hOZ0Q4bGFs?=
 =?utf-8?B?Nk50YSsvdUl3eGkxRWNsdHNtN1NVSTNvOVBzVHRtdjgyRW5DbGpDUHBPREhi?=
 =?utf-8?Q?kw9s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8cb01e-44d4-48e3-6a41-08dbcde99602
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 01:45:33.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQtKO8IRYU3I9FyMm9swrPYMneOrhZN9tSoTI+VqW34eyFVMEluHfWdOFwQwDPKMB0pOA22td7bdwNW7hX6F1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE9sZWtzYW5kcjoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGVrc2FuZHIgTmF0YWxlbmtvIDxv
bGVrc2FuZHJAbmF0YWxlbmtvLm5hbWU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyAxMTo0NSBQTQ0KPiBUbzogUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGlu
dGVsLmNvbT47IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgTWVuZywgTGkgKEph
c3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPg0KPiBDYzogbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB4ODZAa2VybmVsLm9yZzsgbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFNodWFoIEtoYW4NCj4gPHNraGFuQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBGb250ZW5vdCwNCj4gTmF0
aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFNoYXJtYSwgRGVlcGFrDQo+IDxEZWVwYWsu
U2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgWXVhbiwgUGVy
cnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IER1LA0KPiBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Ow0KPiBCb3Jpc2xh
diBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IE1lbmcsIExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRVNFTkQgUEFUQ0ggVjkgMC83XSBhbWQtcHN0YXRlIHBy
ZWZlcnJlZCBjb3JlDQo+DQo+IEhlbGxvLg0KPg0KPiBPbiBww6F0ZWsgMTMuIMWZw61qbmEgMjAy
MyA1OjMxOjExIENFU1QgTWVuZyBMaSB3cm90ZToNCj4gPiBIaSBhbGw6DQo+ID4NCj4gPiBUaGUg
Y29yZSBmcmVxdWVuY3kgaXMgc3ViamVjdGVkIHRvIHRoZSBwcm9jZXNzIHZhcmlhdGlvbiBpbiBz
ZW1pY29uZHVjdG9ycy4NCj4gPiBOb3QgYWxsIGNvcmVzIGFyZSBhYmxlIHRvIHJlYWNoIHRoZSBt
YXhpbXVtIGZyZXF1ZW5jeSByZXNwZWN0aW5nIHRoZQ0KPiA+IGluZnJhc3RydWN0dXJlIGxpbWl0
cy4gQ29uc2VxdWVudGx5LCBBTUQgaGFzIHJlZGVmaW5lZCB0aGUgY29uY2VwdCBvZg0KPiA+IG1h
eGltdW0gZnJlcXVlbmN5IG9mIGEgcGFydC4gVGhpcyBtZWFucyB0aGF0IGEgZnJhY3Rpb24gb2Yg
Y29yZXMgY2FuDQo+ID4gcmVhY2ggbWF4aW11bSBmcmVxdWVuY3kuIFRvIGZpbmQgdGhlIGJlc3Qg
cHJvY2VzcyBzY2hlZHVsaW5nIHBvbGljeQ0KPiA+IGZvciBhIGdpdmVuIHNjZW5hcmlvLCBPUyBu
ZWVkcyB0byBrbm93IHRoZSBjb3JlIG9yZGVyaW5nIGluZm9ybWVkIGJ5DQo+ID4gdGhlIHBsYXRm
b3JtIHRocm91Z2ggaGlnaGVzdCBwZXJmb3JtYW5jZSBjYXBhYmlsaXR5IHJlZ2lzdGVyIG9mIHRo
ZSBDUFBDDQo+IGludGVyZmFjZS4NCj4gPg0KPiA+IEVhcmxpZXIgaW1wbGVtZW50YXRpb25zIG9m
IGFtZC1wc3RhdGUgcHJlZmVycmVkIGNvcmUgb25seSBzdXBwb3J0IGENCj4gPiBzdGF0aWMgY29y
ZSByYW5raW5nIGFuZCB0YXJnZXRlZCBwZXJmb3JtYW5jZS4gTm93IGl0IGhhcyB0aGUgYWJpbGl0
eQ0KPiA+IHRvIGR5bmFtaWNhbGx5IGNoYW5nZSB0aGUgcHJlZmVycmVkIGNvcmUgYmFzZWQgb24g
dGhlIHdvcmtsb2FkIGFuZA0KPiA+IHBsYXRmb3JtIGNvbmRpdGlvbnMgYW5kIGFjY291bnRpbmcg
Zm9yIHRoZXJtYWxzIGFuZCBhZ2luZy4NCj4gPg0KPiA+IEFtZC1wc3RhdGUgZHJpdmVyIHV0aWxp
emVzIHRoZSBmdW5jdGlvbnMgYW5kIGRhdGEgc3RydWN0dXJlcyBwcm92aWRlZA0KPiA+IGJ5IHRo
ZSBJVE1UIGFyY2hpdGVjdHVyZSB0byBlbmFibGUgdGhlIHNjaGVkdWxlciB0byBmYXZvciBzY2hl
ZHVsaW5nDQo+ID4gb24gY29yZXMgd2hpY2ggY2FuIGJlIGdldCBhIGhpZ2hlciBmcmVxdWVuY3kg
d2l0aCBsb3dlciB2b2x0YWdlLg0KPiA+IFdlIGNhbGwgaXQgYW1kLXBzdGF0ZSBwcmVmZXJyZWQg
Y29yZS4NCj4gPg0KPiA+IEhlcmUgc2NoZWRfc2V0X2l0bXRfY29yZV9wcmlvKCkgaXMgY2FsbGVk
IHRvIHNldCBwcmlvcml0aWVzIGFuZA0KPiA+IHNjaGVkX3NldF9pdG10X3N1cHBvcnQoKSBpcyBj
YWxsZWQgdG8gZW5hYmxlIElUTVQgZmVhdHVyZS4NCj4gPiBBbWQtcHN0YXRlIGRyaXZlciB1c2Vz
IHRoZSBoaWdoZXN0IHBlcmZvcm1hbmNlIHZhbHVlIHRvIGluZGljYXRlIHRoZQ0KPiA+IHByaW9y
aXR5IG9mIENQVS4gVGhlIGhpZ2hlciB2YWx1ZSBoYXMgYSBoaWdoZXIgcHJpb3JpdHkuDQo+ID4N
Cj4gPiBBbWQtcHN0YXRlIGRyaXZlciB3aWxsIHByb3ZpZGUgYW4gaW5pdGlhbCBjb3JlIG9yZGVy
aW5nIGF0IGJvb3QgdGltZS4NCj4gPiBJdCByZWxpZXMgb24gdGhlIENQUEMgaW50ZXJmYWNlIHRv
IGNvbW11bmljYXRlIHRoZSBjb3JlIHJhbmtpbmcgdG8gdGhlDQo+ID4gb3BlcmF0aW5nIHN5c3Rl
bSBhbmQgc2NoZWR1bGVyIHRvIG1ha2Ugc3VyZSB0aGF0IE9TIGlzIGNob29zaW5nIHRoZQ0KPiA+
IGNvcmVzIHdpdGggaGlnaGVzdCBwZXJmb3JtYW5jZSBmaXJzdGx5IGZvciBzY2hlZHVsaW5nIHRo
ZSBwcm9jZXNzLg0KPiA+IFdoZW4gYW1kLXBzdGF0ZSBkcml2ZXIgcmVjZWl2ZXMgYSBtZXNzYWdl
IHdpdGggdGhlIGhpZ2hlc3QgcGVyZm9ybWFuY2UNCj4gPiBjaGFuZ2UsIGl0IHdpbGwgdXBkYXRl
IHRoZSBjb3JlIHJhbmtpbmcuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvcm0gVjgtPlY5Og0KPiA+IC0g
YWxsOg0KPiA+IC0gLSBwaWNrIHVwIFRlc3RlZC1CeSBmbGFnIGFkZGVkIGJ5IE9sZWtzYW5kci4N
Cj4gPiAtIGNwdWZyZXE6IGFtZC1wc3RhdGU6DQo+ID4gLSAtIHBpY2sgdXAgUmV2aWV3LUJ5IGZs
YWcgYWRkZWQgYnkgV3llcy4NCj4gPiAtIC0gaWdub3JlIG1vZGlmaWNhdGlvbiBvZiBidWcuDQo+
DQo+IFRoYW5rcyBmb3IgdGhpcyBzdWJtaXNzaW9uLg0KPg0KPiBUaGUgYnVnIHlvdSByZWZlciB0
bywgSSBhc3N1bWUgaXQgc2hvdWxkIGhhdmUgYmVlbiBmaXhlZCBieSB0aGlzIGh1bms6DQo+DQo+
IGBgYA0KPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ICsrKyBiL2RyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gQEAgLTU0Miw3ICs1NDIsNyBAQCBzdGF0aWMgdm9p
ZCBhbWRfcHN0YXRlX2FkanVzdF9wZXJmKHVuc2lnbmVkIGludCBjcHUsDQo+ICAgICAgIGlmICh0
YXJnZXRfcGVyZiA8IGNhcGFjaXR5KQ0KPiAgICAgICAgICAgICAgIGRlc19wZXJmID0gRElWX1JP
VU5EX1VQKGNhcF9wZXJmICogdGFyZ2V0X3BlcmYsDQo+IGNhcGFjaXR5KTsNCj4NCj4gLSAgICAg
bWluX3BlcmYgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmKTsNCj4gKyAgICAgbWlu
X3BlcmYgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+bG93ZXN0X3BlcmYpOw0KPiAgICAgICBpZiAoX21p
bl9wZXJmIDwgY2FwYWNpdHkpDQo+ICAgICAgICAgICAgICAgbWluX3BlcmYgPSBESVZfUk9VTkRf
VVAoY2FwX3BlcmYgKiBfbWluX3BlcmYsIGNhcGFjaXR5KTsNCj4gYGBgDQo+DQo+IHdoaWNoIGlz
IG5vdyBtaXNzaW5nIGZyb20gdGhpcyBwYXRjaHNldCBhcyBpdCB3YXMgc3VnZ2VzdGVkIHRvIHNl
bmQgaXQgYXMgYQ0KPiBzZXBhcmF0ZSBwYXRjaC4NCj4NCj4gQW0gSSBjb3JyZWN0PyBJZiBzbywg
YXJlIHlvdSBnb2luZyB0byBzZW5kIGl0IGFzIGEgc2VwYXJhdGUgcGF0Y2ggd2l0aGluIHRoZQ0K
PiBuZXh0IHJvdW5kIG9mIHRoaXMgcGF0Y2hzZXQsIG9yIGl0IHdpbGwgYmUgc2VudCBzZXBhcmF0
ZWx5IChpZiBpdCBoYXNuJ3QgeWV0KT8NCj4NCltNZW5nLCBMaSAoSmFzc21pbmUpXSBUaGFuayB5
b3UhDQpJdCBpcyBub3cgbWlzc2luZyBmcm9tIHRoaXMgc2VyaWFsIHBhdGNoZXMuDQpBbmQgSSB3
aWxsIHNlbmQgYSBzZXBhcmF0ZWx5IHBhdGNoIGZvciB0aGlzIGlzc3VlLg0KDQo+ID4gLSAtIGFk
ZCBhIGF0dHJpYnV0ZSBvZiBwcmVmY29yZV9yYW5raW5nLg0KPiA+IC0gLSBtb2RpZnkgZGF0YSB0
eXBlIGNvbnZlcnNpb24gZnJvbSB1MzIgdG8gaW50Lg0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1k
LXBzdGF0ZToNCj4gPiAtIC0gcGljayB1cCBSZXZpZXctQnkgZmxhZyBhZGRlZCBieSBXeWVzLg0K
PiA+DQo+ID4gQ2hhbmdlcyBmb3JtIFY3LT5WODoNCj4gPiAtIGFsbDoNCj4gPiAtIC0gcGljayB1
cCBSZXZpZXctQnkgZmxhZyBhZGRlZCBieSBNYXJpbyBhbmQgUmF5Lg0KPiA+IC0gY3B1ZnJlcTog
YW1kLXBzdGF0ZToNCj4gPiAtIC0gdXNlIGh3X3ByZWZjb3JlIGVtYmVkcyBpbnRvIGNwdWRhdGEg
c3RydWN0dXJlLg0KPiA+IC0gLSBkZWxldGUgcHJlZmVycmVkIGNvcmUgaW5pdCBmcm9tIGNwdSBv
bmxpbmUvb2ZmLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3JtIFY2LT5WNzoNCj4gPiAtIHg4NjoNCj4g
PiAtIC0gTW9kaWZ5IGtjb25maWcgYWJvdXQgWDg2X0FNRF9QU1RBVEUuDQo+ID4gLSBjcHVmcmVx
OiBhbWQtcHN0YXRlOg0KPiA+IC0gLSBtb2RpZnkgaW5jb3JyZWN0IGNvbW1lbnRzIGFib3V0IHNj
aGVkdWxlcl93b3JrKCkuDQo+ID4gLSAtIGNvbnZlcnQgaGlnaGVzdF9wZXJmIGRhdGEgdHlwZS4N
Cj4gPiAtIC0gbW9kaWZ5IHByZWZlcnJlZCBjb3JlIGluaXQgd2hlbiBjcHUgaW5pdCBhbmQgb25s
aW5lLg0KPiA+IC0gYWNwaTogY3BwYzoNCj4gPiAtIC0gbW9kaWZ5IGxpbmsgb2YgQ1BQQyBoaWdo
ZXN0IHBlcmZvcm1hbmNlLg0KPiA+IC0gY3B1ZnJlcToNCj4gPiAtIC0gbW9kaWZ5IGxpbmsgb2Yg
Q1BQQyBoaWdoZXN0IHBlcmZvcm1hbmNlIGNoYW5nZWQuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvcm0g
VjUtPlY2Og0KPiA+IC0gY3B1ZnJlcTogYW1kLXBzdGF0ZToNCj4gPiAtIC0gbW9kaWZ5IHRoZSB3
cm9uZyB0YWcgb3JkZXIuDQo+ID4gLSAtIG1vZGlmeSB3YXJuaW5nIGFib3V0IGh3X3ByZWZjb3Jl
IHN5c2ZzIGF0dHJpYnV0ZS4NCj4gPiAtIC0gZGVsZXRlIGR1cGxpY2F0ZSBjb21tZW50cy4NCj4g
PiAtIC0gbW9kaWZ5IHRoZSB2YXJpYWJsZSBuYW1lIGNwcGNfaGlnaGVzdF9wZXJmIHRvIHByZWZj
b3JlX3JhbmtpbmcuDQo+ID4gLSAtIG1vZGlmeSBqdWRnbWVudCBjb25kaXRpb25zIGZvciBzZXR0
aW5nIGhpZ2hlc3RfcGVyZi4NCj4gPiAtIC0gbW9kaWZ5IHN5c2ZzIGF0dHJpYnV0ZSBmb3IgQ1BQ
QyBoaWdoZXN0IHBlcmYgdG8gcHJfZGVidWcgbWVzc2FnZS4NCj4gPiAtIERvY3VtZW50YXRpb246
IGFtZC1wc3RhdGU6DQo+ID4gLSAtIG1vZGlmeSB3YXJuaW5nOiB0aXRsZSB1bmRlcmxpbmUgdG9v
IHNob3J0Lg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3JtIFY0LT5WNToNCj4gPiAtIGNwdWZyZXE6IGFt
ZC1wc3RhdGU6DQo+ID4gLSAtIG1vZGlmeSBzeXNmcyBhdHRyaWJ1dGUgZm9yIENQUEMgaGlnaGVz
dCBwZXJmLg0KPiA+IC0gLSBtb2RpZnkgd2FybmluZyBhYm91dCBjb21tZW50cw0KPiA+IC0gLSBy
ZWJhc2UgbGludXgtbmV4dA0KPiA+IC0gY3B1ZnJlcToNCj4gPiAtIC0gTW9pZGZ5IHdhcm5pbmcg
YWJvdXQgZnVuY3Rpb24gZGVjbGFyYXRpb25zLg0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1kLXBz
dGF0ZToNCj4gPiAtIC0gYWxpZ24gd2l0aCBgYGFtZC1wc3RhdGBgDQo+ID4NCj4gPiBDaGFuZ2Vz
IGZvcm0gVjMtPlY0Og0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZToNCj4gPiAtIC0g
TW9kaWZ5IGluYXBwcm9wcmlhdGUgZGVzY3JpcHRpb25zLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3Jt
IFYyLT5WMzoNCj4gPiAtIHg4NjoNCj4gPiAtIC0gTW9kaWZ5IGtjb25maWcgYW5kIGRlc2NyaXB0
aW9uLg0KPiA+IC0gY3B1ZnJlcTogYW1kLXBzdGF0ZToNCj4gPiAtIC0gQWRkIENvLWRldmVsb3Bl
ZC1ieSB0YWcgaW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4gLSBjcHVmcmVxOg0KPiA+IC0gLSBNb2Rp
ZnkgY29tbWl0IG1lc3NhZ2UuDQo+ID4gLSBEb2N1bWVudGF0aW9uOiBhbWQtcHN0YXRlOg0KPiA+
IC0gLSBNb2RpZnkgaW5hcHByb3ByaWF0ZSBkZXNjcmlwdGlvbnMuDQo+ID4NCj4gPiBDaGFuZ2Vz
IGZvcm0gVjEtPlYyOg0KPiA+IC0gYWNwaTogY3BwYzoNCj4gPiAtIC0gQWRkIHJlZmVyZW5jZSBs
aW5rLg0KPiA+IC0gY3B1ZnJlcToNCj4gPiAtIC0gTW9pZGZ5IGxpbmsgZXJyb3IuDQo+ID4gLSBj
cHVmcmVxOiBhbWQtcHN0YXRlOg0KPiA+IC0gLSBJbml0IHRoZSBwcmlvcml0aWVzIG9mIGFsbCBv
bmxpbmUgQ1BVcw0KPiA+IC0gLSBVc2UgYSBzaW5nbGUgdmFyaWFibGUgdG8gcmVwcmVzZW50IHRo
ZSBzdGF0dXMgb2YgcHJlZmVycmVkIGNvcmUuDQo+ID4gLSBEb2N1bWVudGF0aW9uOg0KPiA+IC0g
LSBEZWZhdWx0IGVuYWJsZWQgcHJlZmVycmVkIGNvcmUuDQo+ID4gLSBEb2N1bWVudGF0aW9uOiBh
bWQtcHN0YXRlOg0KPiA+IC0gLSBNb2RpZnkgaW5hcHByb3ByaWF0ZSBkZXNjcmlwdGlvbnMuDQo+
ID4gLSAtIERlZmF1bHQgZW5hYmxlZCBwcmVmZXJyZWQgY29yZS4NCj4gPiAtIC0gVXNlIGEgc2lu
Z2xlIHZhcmlhYmxlIHRvIHJlcHJlc2VudCB0aGUgc3RhdHVzIG9mIHByZWZlcnJlZCBjb3JlLg0K
PiA+DQo+ID4gTWVuZyBMaSAoNyk6DQo+ID4gICB4ODY6IERyb3AgQ1BVX1NVUF9JTlRFTCBmcm9t
IFNDSEVEX01DX1BSSU8gZm9yIHRoZSBleHBhbnNpb24uDQo+ID4gICBhY3BpOiBjcHBjOiBBZGQg
Z2V0IHRoZSBoaWdoZXN0IHBlcmZvcm1hbmNlIGNwcGMgY29udHJvbA0KPiA+ICAgY3B1ZnJlcTog
YW1kLXBzdGF0ZTogRW5hYmxlIGFtZC1wc3RhdGUgcHJlZmVycmVkIGNvcmUgc3VwcG9ydGluZy4N
Cj4gPiAgIGNwdWZyZXE6IEFkZCBhIG5vdGlmaWNhdGlvbiBtZXNzYWdlIHRoYXQgdGhlIGhpZ2hl
c3QgcGVyZiBoYXMgY2hhbmdlZA0KPiA+ICAgY3B1ZnJlcTogYW1kLXBzdGF0ZTogVXBkYXRlIGFt
ZC1wc3RhdGUgcHJlZmVycmVkIGNvcmUgcmFua2luZw0KPiA+ICAgICBkeW5hbWljYWxseQ0KPiA+
ICAgRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZTogaW50cm9kdWNlIGFtZC1wc3RhdGUgcHJlZmVy
cmVkIGNvcmUNCj4gPiAgIERvY3VtZW50YXRpb246IGludHJvZHVjZSBhbWQtcHN0YXRlIHByZWZl
cnJkIGNvcmUgbW9kZSBrZXJuZWwNCj4gY29tbWFuZA0KPiA+ICAgICBsaW5lIG9wdGlvbnMNCj4g
Pg0KPiA+ICAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAg
IDUgKw0KPiA+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1wc3RhdGUucnN0ICAg
fCAgNTkgKysrKy0NCj4gPiAgYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA1ICstDQo+ID4gIGRyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYyAgICAgICAgICAg
ICAgICAgICAgICB8ICAxMyArKw0KPiA+ICBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZlci5j
ICAgICAgICAgICAgICAgfCAgIDYgKw0KPiA+ICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5j
ICAgICAgICAgICAgICAgICAgfCAyMDQgKysrKysrKysrKysrKysrKy0tDQo+ID4gIGRyaXZlcnMv
Y3B1ZnJlcS9jcHVmcmVxLmMgICAgICAgICAgICAgICAgICAgICB8ICAxMyArKw0KPiA+ICBpbmNs
dWRlL2FjcGkvY3BwY19hY3BpLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPiA+
ICBpbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0K
PiA+ICAxMCBmaWxlcyBjaGFuZ2VkLCAzMDUgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPg0KPg0KPg0KPiAtLQ0KPiBPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1
bSkNCg==
