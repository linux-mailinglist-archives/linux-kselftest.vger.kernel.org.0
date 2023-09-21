Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6627A9605
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIUQ5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjIUQ5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 12:57:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C0CCE;
        Thu, 21 Sep 2023 09:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0T3SOlzYqYfgx+H+109JMl/46/rsLjaXZrQ1Wat/hZkrg+PYaGjQ+CeNc1lvWjGlWTu4Ke4U2VbKOOeuW+artkb7LppKfGco7zMhlcoiHmppBL2sAgFrggiR3ovxTr7qizQYWySOY6Ysj3RwDbF/2VNyvNlnRfmQOhMuqYpcDdY6HR2LpxebMR6JtRIDjsuP2RGzTDfvGwwwqBV/LIC+mrOtsFFdNJwNbZTA65T31mFE6i6oHgt7lagx+dLxfZhbGKXbD9SriH6QuwGThpmWrOPASPZgKAwuFJ+7jXhyMvA/DtOHKvYGqzdL3RyTd8lTzYAPu4h4hTJUx3jcdN00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQJ9lAj9aOZkVuctjS8VFfB4Jvf/7BDATMUe6OdWFgM=;
 b=I9e94qb9dRP8M/Vjcpkj4SgUwT4+0Dw+XHAKA91fFVJNSCIjkBmmKmqxlf35mMF8DxCAMVdCVKyGlOWlFoEEo/MaV7b72YWBStQoGavRcyyIanM3KMANWhoXl7nKrRSZamTGwaQGW2Ugwhb7UweQy603yspomk7jhLu7ntJeL704bDvZoxzYpAVcYAZGi5YkV9PstFwSCknUSzxgVEKu433b+3q303mJrLHYmun63SB00I0b7i7PGIEVzxfXmgIYMCmJB4r5jNaua0YGrVpx+pGh4FAMJonpkvnC0LiFzFbvhYrH/qOcJlo3ls1NeCvM5Mpi31PlS2Ol6o8KIykqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQJ9lAj9aOZkVuctjS8VFfB4Jvf/7BDATMUe6OdWFgM=;
 b=Q0GUiTA/jIGNbo7/Dcedur+EYKCTxEw4om3LkV5CxzqFPJ9hBV2X7DW90vXzixPnhUqR9l8ycUD+GsaMxEG21jG8CS3WjPQ30/hhX7V5StxVU4VeL7d0c/7EY2IRoNADYWi7bu1J0ouCUXyqxDXCCpmM4DmZAL8IiWQzR+7+7es=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 05:51:16 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 05:51:16 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
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
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH V7 0/7] amd-pstate preferred core
Thread-Topic: [PATCH V7 0/7] amd-pstate preferred core
Thread-Index: AQHZ6ggoqrVAOAnUeE2IZUd7OYKx57Aig0kAgAFvW4CAACwugIAACoMAgAChpHA=
Date:   Thu, 21 Sep 2023 05:51:16 +0000
Message-ID: <DM4PR12MB63515E0A07B9CC0FCC5DAC91F7F8A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20230918081407.756858-1-li.meng@amd.com>
 <5973628.lOV4Wx5bFT@natalenko.name>
 <ce377dda-e1ce-4553-b9b8-125620b8b2d7@amd.com>
 <12290212.O9o76ZdvQC@natalenko.name>
 <d981aa59-8aec-4929-9633-9ec7af81b099@amd.com>
In-Reply-To: <d981aa59-8aec-4929-9633-9ec7af81b099@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=756d6459-d0e7-43d8-8157-ed1e0708f7e0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-21T05:50:26Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|PH0PR12MB5678:EE_
x-ms-office365-filtering-correlation-id: 4ea38008-e643-47a4-d214-08dbba66c589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz+uIhIPh1hVmAJCzI2GE8d3nP95qH1SJtPqXpSz+gZJJ9rNhqlOA0IkMqmno4frbOxQqbYvaPenTjUmsJd+WE0GutRyfLbVPRAu3DeUjZ6FoS4z1KjAeR7JZrv0TlP9PhTJenxEyDdy3d/qc+adl+1JpK5lgfAp1qy4GIpxUKThAk84CLhSD94Pf1/U7t4qrCxhCBcJVAjG7RqfkNUdiYyd1WZjo8nFLmZZBVzuNAghWg1tRPOGZTUUAs01P16FiixYkW+YtQNOKGNDEc4tbDPqftvTU2ZhtdoYHzwNtabL7CvJ3fMWT+M3myiMw+kLWU7TkWrNeyAAk7yhjRdoYlJAUiqVLKQH4Wxbd5g0xf8r+zwtFi6ImBcY6h3MA9xH8bBbfVlv0PDk7HzV6eFWuEHezhQterP7hTFkrcz/OPduvWjOhgp6Dj7QOXaTLv6IDLTTc2BNkJ70GzN2R22xvRBzXOdOk6aKt8tH/LXAWW/6T9TQtc3K0tbXfKwrOiKXRXQb8Erm62qbT1CJQS87fGGIlh97OdDTFYTHpaoiEsw9iIU+sONrB9Z5gsmdNXkAMC3GQduur3mBwDlMbua2SYzFysJUfRWocfbk//M46gwUDWOYbsuRY+objvqT7SdX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(110136005)(55016003)(9686003)(26005)(38070700005)(38100700002)(6636002)(316002)(66946007)(76116006)(64756008)(54906003)(66556008)(66476007)(66446008)(41300700001)(71200400001)(478600001)(122000001)(53546011)(7696005)(6506007)(7416002)(33656002)(2906002)(83380400001)(86362001)(52536014)(8936002)(8676002)(4326008)(66574015)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjRtTUpjaFQzT0R4Wldad3BtVmFOc2xKR2RJWSsvMFdKMzd2QVdrVmhCT1lE?=
 =?utf-8?B?OHFicUNTRjY1dVFleWRGSEd1ZjRJVGFQTFBEdlhPTEd1SnNDSVJkRUswWG9w?=
 =?utf-8?B?cFYrd2x5aWc5Y2xseHgvOGk3NC9vdjhsc1RacVc2VDZSb2dwWVhjNFBXRWhS?=
 =?utf-8?B?NUlKbjZJZnprUC8yUVN3Q0RtZlRvUnZhbmFqOUVQbXE5TGpEdmxiUEJjRGVq?=
 =?utf-8?B?OUlVenlkMFBFLzRqN2VzeXJRSHhGMWR2Y0F2elcyUTZPZzREZzdmWWRjWmNm?=
 =?utf-8?B?d1J0NXFyVllMQ3hkbCtlaTlmMUx4M3NhS3lCR3daWnBnK0lIYVl1bFpjZVp2?=
 =?utf-8?B?Q2M3VjJESU40UFFPVk9Fam5ZcjFOd0xpSTBTcWE4UXVQbnkySTVnWDBPS2JK?=
 =?utf-8?B?em1NYysyUkN4YTNNU1F3TndkOG9uNUFETUl6akxCYzg2SFpiSkVnbmZSZVg5?=
 =?utf-8?B?VlFrUU5EQlgxck01VU5nbjVTWVZrUzVNUlE1WGxpd01hSVUyR0tzalVEOHFG?=
 =?utf-8?B?ZmRWQUVhRHlKZ2Zqdmo0L0NUcHpsd1N3Qk9ER0VJWjZPR1FVUUI5VXhzYmVB?=
 =?utf-8?B?SXNPNHhQUkZnM1NqalhlV041K3dDalFoeXFXRUdNd0dDL21CRkttNjFLY3B0?=
 =?utf-8?B?c080M0tDVVN5WWhtT2xBQUZ1SmxaRWd1NkxaUnFab3FzK1M1ZWtXbTdmTUp3?=
 =?utf-8?B?ZnVkdWEwWVJ6OThDUS9RaGJoaDljUkhsbmd6aEJNckl4dlByd085MVRPV2tG?=
 =?utf-8?B?ZUFGZmdqdjVjdjNWR2NIc3k0RGhQMUJ5V2xycDV2UzFGSVZCRkRXd2lzbWx2?=
 =?utf-8?B?SjdqUnlxdDFFbC9OMEVJNW03dmtwbEV0RTN1bEhMQUJ0QmxqRWdrNUFMaHlW?=
 =?utf-8?B?bUQzdXlQRmZwOXdSOXRkSHR3aXp2N2ltTjBBSENTSCtjdGhaeGpvOTlURzF2?=
 =?utf-8?B?SVpESmlNOHpGV21qN3VWMG5ZOC9MVHpuQ2FHTVpBdWQxNTJ1YVFWR2pwenZX?=
 =?utf-8?B?dUhYWWprOGQ0MkN5bG5LSDRxK2R2L01yTi81aG1tVXpMcUluaEpvUDBBQjBC?=
 =?utf-8?B?MkhVNGxHQVVyWWhldm9qSHVWZ2NkRE04N29MRkd2eld3eCsvUlZMc0tVYXJu?=
 =?utf-8?B?Z3FXdUUxeWgvTzBSYlgrZFlNS0dGNFBVQXFTRWJTYnhsTnQrRzV0N3V1ajJ2?=
 =?utf-8?B?QTFoUE9Hblhpc1c1b3lMSzI0R1E2ZUdkS3oyem5mOFZHbjY4dmtRQ2E0S3o4?=
 =?utf-8?B?S2VSUWZTNVY0VjZVc1dDTWJYTG5vN3JwTE5hZG9TZ3ZBNE5NN0ZZVFQxYzN0?=
 =?utf-8?B?cHYvcE92dWNVUFROZitOWmhXaER6Q3BJRU1EQ280NlZ2Ny9oS29hdW9oYkhR?=
 =?utf-8?B?Rjd2QktvMkZ5TWZPSU9UZ3hnOG1jZSt0SVFnK21LbTQzc3dIVlI3T3laVENB?=
 =?utf-8?B?VkJZcmdaRFc4WVdzMVRJWGNicGxBL3Bic2VpdzVGRnhLU2oxS09VaFhKNHpQ?=
 =?utf-8?B?cDFjMnc4Rk9sL3drWVBzalVISXN3MWdNRVQ1ZXA5QkxyNW52SkIxQk9GT1pF?=
 =?utf-8?B?NFh5cU1LNXlSOHRiWGNLb0ZzQ2RvVXpnVzI3ajl5dlhXQWNINEtyU1ZmZUhy?=
 =?utf-8?B?QU9MaDlPcksxaXJ3bGUvaFFIdk5GOTlZa3p5VndHUjlEMGorb0dwSm93c1FL?=
 =?utf-8?B?S2ZpSk44ZkswdUg2RlZNSnltbGFiV3FpdGpMMXp6Y2o3M2Y5WTkzeDhWUnNr?=
 =?utf-8?B?eW90bGQ0M1hFTVdpYlpyNWRRdGhobWt2Vk5iQ3Q4cUJBczJXSWx6ZTV5QnFn?=
 =?utf-8?B?MFZoQXBBS0hTZFNMOERHZGx6WGJlRW50Y0JGb1VqZm90M2k3MUZWQ2syNXlK?=
 =?utf-8?B?ZDBaYWV4YjQ1R1JNZXZPNXl2Mzc1REhNWStDdEZiNVFpMytCbEVFLzdaRFFF?=
 =?utf-8?B?dGU2VnJ0MWJkbXh6L2s0OXFtRlJTQnRmSTV1ckMvRjR6U3ZHckt4bnpYYmdL?=
 =?utf-8?B?UDhSUjY1Z3BNYTFiS05sMVBYVVBFK1d0UXd5dXZRWCtXd3A2emRnbUhtWGtX?=
 =?utf-8?B?NTZuV29LazRVYjhzOVRtNFRZcVB6WkpsTnRSNTZVWThKR2hQalJXOGFDV3NF?=
 =?utf-8?Q?T+tc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea38008-e643-47a4-d214-08dbba66c589
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 05:51:16.6166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRH+eR94X7jNJTor1h4FvOKQZi24vmYuSC4O9ZIe2FCqpbc2ec/snFyg+JX4sqw1hc9aCp/o5QDxVO3m2dFeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGFsZW5rbyBhbmQgTWFy
aW86DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8s
IE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2Vw
dGVtYmVyIDIxLCAyMDIzIDQ6MTIgQU0NCj4gVG86IE9sZWtzYW5kciBOYXRhbGVua28gPG9sZWtz
YW5kckBuYXRhbGVua28ubmFtZT47IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsg
TWVuZywgTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPg0KPiBDYzogbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiB4ODZAa2VybmVs
Lm9yZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFNodWFoIEtoYW4NCj4gPHNraGFuQGxp
bnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBGb250
ZW5vdCwNCj4gTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFNoYXJtYSwgRGVlcGFr
DQo+IDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IER1LA0KPiBYaWFvamlh
biA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFy
by5vcmc+Ow0KPiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IFJhZmFlbCBKIC4gV3lz
b2NraQ0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjcgMC83XSBhbWQtcHN0YXRlIHByZWZlcnJlZCBjb3JlDQo+DQo+IE9uIDkvMjAvMjAyMyAx
NDozNCwgT2xla3NhbmRyIE5hdGFsZW5rbyB3cm90ZToNCj4gPiBIZWxsby4NCj4gPg0KPiA+IE9u
IHN0xZllZGEgMjAuIHrDocWZw60gMjAyMyAxODo1NjowOSBDRVNUIE1hcmlvIExpbW9uY2llbGxv
IHdyb3RlOg0KPiA+Pj4gV2hlbiBhcHBsaWVkIG9uIHRvcCBvZiB2Ni41LjMgdGhpcyBicmVha3Mg
dHVyYm8gb24gbXkgNTk1MFggYWZ0ZXINCj4gc3VzcGVuZC9yZXN1bWUgY3ljbGUuIFBsZWFzZSBz
ZWUgdGhlIHNjZW5hcmlvIGRlc2NyaXB0aW9uIGJlbG93Lg0KPiA+Pj4NCj4gPj4+IElmIEkgYm9v
dCB2Ni41LjMgKyB0aGlzIHBhdGNoc2V0LCB0aGVuIGB0dXJib3N0YXRgIHJlcG9ydHMgfjQuOSBH
SHogb24gY29yZQ0KPiAwIHdoZXJlIGB0YXNrc2V0IC1jIDAgZGQgaWY9L2Rldi96ZXJvIG9mPS9k
ZXYvbnVsbGAgaXMgYmVpbmcgcnVuLg0KPiA+Pj4NCj4gPj4+IEFmdGVyIEkgc3VzcGVuZCB0aGUg
bWFjaGluZSBhbmQgdGhlbiByZXN1bWUgaXQsIGFuZCBydW4gYGRkYCBhZ2FpbiwNCj4gYHR1cmJv
c3RhdGAgcmVwb3J0cyB0aGUgY29yZSB0byBiZSBjYXBwZWQgdG8gYSBzdG9jayBmcmVxdWVuY3kg
b2YgfjMuNCBHSHouDQo+IFJlYm9vdGluZyB0aGUgbWFjaGluZSBmaXhlcyB0aGlzLCBhbmQgdGhl
IENQVSBjYW4gYm9vc3QgYWdhaW4uDQo+ID4+Pg0KPiA+Pj4gSWYgdGhpcyBwYXRjaHNldCBpcyBy
ZXZlcnRlZCwgdGhlbiB0aGUgQ1BVIGNhbiB0dXJibyBhZnRlcg0KPiBzdXNwZW5kL3Jlc3VtZSBj
eWNsZSBqdXN0IGZpbmUuDQo+ID4+Pg0KPiA+Pj4gSSdtIHVzaW5nIGBhbWRfcHN0YXRlPWd1aWRl
ZGAuDQo+ID4+Pg0KPiA+Pj4gSXMgdGhpcyBiZWhhdmlvdXIgZXhwZWN0ZWQ/DQo+ID4+DQo+ID4+
IFRvIGhlbHAgY29uZmlybSB3aGVyZSB0aGUgaXNzdWUgaXMsIGNhbiBJIGFzayB5b3UgdG8gZG8g
dGhyZWUNCj4gPj4gZXhwZXJpbWVudHMgd2l0aCB0aGUgcGF0Y2ggc2VyaWVzIGFwcGxpZWQ6DQo+
ID4+DQo+ID4+IDEpICdhbWRfcHN0YXRlPWFjdGl2ZScgb24geW91ciBrZXJuZWwgY29tbWFuZCBs
aW5lLg0KPiA+DQo+ID4gVGhlIGlzc3VlIGlzIHJlcHJvZHVjaWJsZS4gSWYgSSB0b2dnbGUgdGhl
IGdvdmVybm9yIGluIGNwdXBvd2VyIHRvDQo+IGBwb3dlcnNhdmVgIGFuZCBiYWNrIHRvIGBwZXJm
b3JtYW5jZWAsIGJvb3N0IGlzIHJlc3RvcmVkLg0KPiA+DQo+ID4+IDIpICdhbWRfcHN0YXRlPWFj
dGl2ZSBhbWRfcHJlZmNvcmU9ZGlzYWJsZScgb24geW91ciBrZXJuZWwgY29tbWFuZA0KPiBsaW5l
Lg0KPiA+DQo+ID4gVGhlIGlzc3VlIGlzIG5vdCByZXByb2R1Y2libGUuDQo+ID4NCj4gPj4gMykg
J2FtZF9wc3RhdGU9Z3VpZGVkIGFtZF9wcmVmY29yZT1kaXNhYmxlJyBvbiB5b3VyIGtlcm5lbCBj
b21tYW5kDQo+IGxpbmUuDQo+ID4NCj4gPiBUaGUgaXNzdWUgaXMgbm90IHJlcHJvZHVjaWJsZS4N
Cj4gPg0KPiA+IEkgc2hvdWxkIGFsc28gbWVudGlvbiB0aGF0IGluIG15IGluaXRpYWwgY29uZmln
dXJhdGlvbiBJIHVzZQ0KPiBgYW1kX3BzdGF0ZT1ndWlkZWRgIGFuZCBgc2NoZWR1dGlsYC4gSWYg
SSBzd2l0Y2ggdG8gYHBlcmZvcm1hbmNlYCBhZnRlcg0KPiBzdXNwZW5kLXJlc3VtZSBjeWNsZSwg
dGhlIGJvb3N0IGlzIHJlc3RvcmVkLiBIb3dldmVyLCBpZiBJIHN3aXRjaCBiYWNrIHRvDQo+IGBz
Y2hlZHV0aWxgLCB0aGUgZnJlcSBpcyBjYXBwZWQuDQo+ID4NCj4gPiBEb2VzIHRoaXMgaW5mbyBo
ZWxwPw0KPiA+DQo+DQo+IFllYWgsIGl0IG1hdGNoZXMgbXkgZXhwZWN0YXRpb25zIGZvciB0aGlz
IGlzc3VlIHlvdSByZXBvcnRlZC4NCj4gVGhhbmtzIQ0KPg0KPiBKYXNzbWluZSBjYW4gZGlnIGlu
dG8gYSBmaXggZm9yIGFub3RoZXIgc3BpbiBvZiB0aGlzIHNlcmllcy4NCltNZW5nLCBMaSAoSmFz
c21pbmUpXQ0KVGhhbmsgeW91IHZlcnkgbXVjaCENCkkgd2lsbCBmaXggdGhpcyBpc3N1ZSBpbiB0
aGUgbmV4dCBwYXRjaGVzLg0KPg0KPiA+PiBMb29raW5nIHRocm91Z2ggdGhlIGNvZGUsIEkgYW50
aWNpcGF0ZSBmcm9tIHlvdXIgcmVwb3J0IHRoYXQgaXQNCj4gPj4gcmVwcm9kdWNlcyBvbiAiMSIg
YnV0IG5vdCAiMiIgYW5kICIzIi4NCj4gPj4NCj4gPj4gTWVuZywNCj4gPj4NCj4gPj4gQ2FuIHlv
dSB0cnkgdG8gcmVwcm8/DQo+ID4+DQo+ID4+IEkgdGhpbmsgdGhhdCBpdCdzIHByb2JhYmx5IGEg
Y2FsbCB0byBhbWRfcHN0YXRlX2luaXRfcHJlZmNvcmUoKQ0KPiA+PiBtaXNzaW5nIGZyb20gYW1k
X3BzdGF0ZV9jcHVfcmVzdW1lKCkgYW5kIGFsc28NCj4gYW1kX3BzdGF0ZV9lcHBfcmVzdW1lKCku
DQo+ID4NCg0K
