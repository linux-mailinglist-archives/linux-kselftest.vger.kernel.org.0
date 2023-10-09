Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6C27BD439
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 09:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJIHXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjJIHXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 03:23:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D7C6;
        Mon,  9 Oct 2023 00:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk2AA04953PMoTmZhAya6e93VMQmfbugJXChFgOSZWVE5kF3w+0JLwAj7pV+R8OhmpVr7fyZueAexe016cOoB2q0p3VFALL2k67X8/ESwYTkM2xb+QAzNHlv173uSXe9/f4W0+feP2r6JtQj/70FnbPt1l+WXe3Gi7EgkSzPLGF41JI+fiCaCdiin9huXK3kFjyWyRRlLtcUYPmLTVASp9w7HaWXZQ2Q3iljwsor9H1dy5KWbWWXQOd6Hs8NpqOd12TGEP/h36IorjcWBR9N+qsHDdW0ptBphczd1eSFTyMTATuaQg1NjItnL+XbVVFQFhDZG+Fh9l2RHkk0ucJ20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4edVxmqvOkOhNu9NAAGkaZCLvD6jzLXwO5I3FJhe5Y=;
 b=YC15bcAlvX+aGXrz33keQnI1Lwk5iO2AXMz92RL51DeGNnne5n6bKTrpHo1+8z+dgBa2vsiDHjJzUXECyXhoayU+j1HGII+jXMqwqrsI4vSurlY3KniXljjCISeK5w5cGgqw54zS+mW7qNgkzxprnNjMMFqarIeNOrj24BPSHsRL5MEaay0gp2TDwy9RK0Qm7SQl0K6w6/MOJc4sNGL6zghDlMA6/ZuHV5xtsgIpwUpyvw0gPbTod5xn6ze0mkwbo74yZIL9t9V8WneO8V+/TRYlUDd4AU/Exxo0bKqXpiKGWxv+z2jIyxvY5iS+hFJjUik13MHSCumnnD+tFcJeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4edVxmqvOkOhNu9NAAGkaZCLvD6jzLXwO5I3FJhe5Y=;
 b=VXtutwq+No+QwZCqSYikcMQIpMJ0b1uv3cASMh6Pz4IOZ9c6RUJZhCXiB8dsbp/Rr2VlpnDrW3JREXDXmuGiQLKzk0xlX4BlNYwKUvOBIjJRCXgpDfbMFZrTOo/CyoUrGcSx8W/AsyWBLyxPf/8fLjmN712RdAj9rPgx5H2r6GE=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 07:23:29 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 07:23:29 +0000
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
Subject: RE: [PATCH V8 0/7] amd-pstate preferred core
Thread-Topic: [PATCH V8 0/7] amd-pstate preferred core
Thread-Index: AQHZ+ltSB2+69LEZCEGeV5pqoLKpvbBBBjAAgAAGzmA=
Date:   Mon, 9 Oct 2023 07:23:29 +0000
Message-ID: <DM4PR12MB63512D20912A9F66561B9FA1F7CEA@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231009024932.2563622-1-li.meng@amd.com>
 <12301186.O9o76ZdvQC@natalenko.name>
In-Reply-To: <12301186.O9o76ZdvQC@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1d978db-5e59-433a-a2cd-270b5776e3b5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T07:18:51Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|IA0PR12MB8694:EE_
x-ms-office365-filtering-correlation-id: 1ce4a5c5-a542-47da-4bcb-08dbc898a28d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZaRncAVRLi0J3n76gIBlLDFeoDjpyhCgPKl2beUltZB7qhNo7zn0ldzRh48VCoPa4yhZVreGBSK+C6tjHIFhxg/zpqBv78zA7k8ioXptVzrLpcIvUSI/BcPrSP9XS/EQz7eox6tbIUxr9qD2V+flFOrq3ibdYBMfb/cQvwCNYkRmK2KWQdsarYLwODlLRYFQ5dxvTy9LL+jXUQF/ZWBj4smBsma8hqTeDpyHu6S5DbOXcrK4ViZCZVZoPUuLwiLeEXiA4JKZBUBAZWNtBVUsWKxBHjwRZAMwB3OYDKhLvuQTeQt964CMelMrMqVPCHEkqc44szZa/yg+nmJ9q0/qM0ickkP0tb22JGKDr0JN30zCm2MKRYYo5BoClv0Vckq4n83fqxpiCTAvrz7ymdAjast0jMDN9oJxdAsIMPohkn8mb3aGoNeunOXilhQ80/IyjSkRZ4xhDwwvajExaLzSRxqyVP8u3DAHcw4Gk5Xbjpb5U+Wmc3orp0kEy5ddmW5VO1xjPCRHocb+RRItB9JoJv1H/3mlOL9ilVZamzkpDjbnqKHj+RVahjUZRqdfaJwqaf3OQ/8+fhnMlb1godsE7C8H5JGGwhUYBdcB6or9OFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(9686003)(71200400001)(26005)(53546011)(55016003)(33656002)(38070700005)(86362001)(38100700002)(122000001)(83380400001)(8936002)(7416002)(4326008)(2906002)(6506007)(478600001)(7696005)(8676002)(66574015)(41300700001)(52536014)(966005)(5660300002)(6636002)(316002)(66556008)(66446008)(76116006)(54906003)(66476007)(66946007)(110136005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk9hNW5RNzVEdnliMlNGbkpmSVZsR0NGaGpZV3B6d1VKTnhUMkN1TnNnZmFJ?=
 =?utf-8?B?ejZralYwcXBQc1Q2ZnBuckVMdGNmU29BeExSanhoTWJwYzJFcHhIWFZTYUxD?=
 =?utf-8?B?OFFmR0dMSE15VS9uWGVoL3ZaSzhGSkZUNGI4c01LWk5lVkVUbXpxQVlBTVhr?=
 =?utf-8?B?ZFAwNXNsY0tzc2svd3UvaDc5KzBxU0xGd0tvZ3REMFBMR1dDckRub0VnejRs?=
 =?utf-8?B?Wk1rRHJQdm1oOUFIU3ZwTW5GeFRjYUFubWovdEJMVzVVNTY4T1NRNnhyOUpi?=
 =?utf-8?B?ME4xRVN1UXJmanpicmdEZTlYUkYrOXZMUVdiSFJIWWw3UzVFdEkyVUFRTFFX?=
 =?utf-8?B?WkNQV2htTmNzeWhNUnFPQ1MxK3l3RnNMWUVKUDUxZjA2ZEJPazdLaTNGMzNG?=
 =?utf-8?B?Q1lqbVUwbDE1TzJoSHRCL256MS91d1dFZzRzTVhOWkJUNDkxcXVTemtlZ1ht?=
 =?utf-8?B?SzJ5NjlQRVRHTUNXWHZWcUxSOWd6OHVJSWdLekFCdHVxRTBTV0ZuY1JOSm5B?=
 =?utf-8?B?NU12QkhxY1VCb1VuaGZIZk85VWRDa2dRMXNKTXBGVmpYR1hobks2bC9kYzc5?=
 =?utf-8?B?em4wUlNOVHlZRG8vWnpsL2tkUXhwZFgrOGJ6cEdHSzZyQmUvdU1hUXd0QThp?=
 =?utf-8?B?Vlo0YVYxL1pSMjZGOHhkQ0FPNUlINGljYkg5STRaSEZZcUVoQnVMaTV1Mk41?=
 =?utf-8?B?QnRZL2hPYTBqUkQrNzhMRGt5a2hKS211MTJ3M2NVU1gzV3ZXeTc5cEUwWC9v?=
 =?utf-8?B?dHd6cXprdDBjUkJLRGlZdVFVVm14dDBkUVZNMXlXNGtpWVFPb0M2ZkR4U2pS?=
 =?utf-8?B?OERlQm9VQUFxRFNKcHQzU2dHY0swNkZtVkw2UGw4cVk0U0lkRitjRnVELzZF?=
 =?utf-8?B?YklIdEFiTkhXdVF4ZmdzOVQ1eHBiYzE4M3gvcTdXbEpkUWgwdmdIMWhJc3N2?=
 =?utf-8?B?MGliTms1cGhIL05iNUs5UWV0bWRRZ1VpcXcxRHRqR3Y4UWFRWXk4U21TZTMx?=
 =?utf-8?B?clBxdnlndC9vd0ViUW9NeXVPZmRZUGNWM2lCVE9FMjZXU2FOcmpITml3eDlQ?=
 =?utf-8?B?VU9xSWlnU1U4SEpUVmVWdzE2SUFjUHYwS1B3eWNwZEMyU3U2c0JxUGwvakNB?=
 =?utf-8?B?YWpKRlc0ai9tSTh5bk5PNHRwRXZYRWdwTTZNODFXcG5UVS9IUmY2bW1QQVRr?=
 =?utf-8?B?UXJlY0Fod3lEM1F1UUNINDdiaTRnM25hVERWU2NUclJ3elRrQWN4aHRGVkhz?=
 =?utf-8?B?aGdGUHFqSTFGWFczcTFrSmhWWUlaalhmWlM4S3ZVRTVxWEdpcUo5c0lROUU1?=
 =?utf-8?B?VFphMGw2Mmt2WnNiRm5VUFNYUTcwM2FzaWpVQUZxNDBldWFRY3d1MFI3MTdx?=
 =?utf-8?B?M094MzFJemNHK2NrTVJLdG04d3QvNFUrYlZlejB0Rjh3SEtpL0NlSkFOYVR0?=
 =?utf-8?B?aVZJYm5LUDdLL3g3VERCYjBMOWxwcllZQStLUTdaLzBFQkdndTNveUIzazV4?=
 =?utf-8?B?emtwdmZHRXh2REVLaVZFV1R5aXo3eUhXbm1NUGtVZE43UllROXNXSjRLTENO?=
 =?utf-8?B?NjRBYmhqSUlpalp4UVlNSXl1YUwwa3lMZENpc3hRdFpxTnIraTZMKzY3TmYx?=
 =?utf-8?B?NjVqNlAyMVBTU1UvMmJZbmc0QzVhdjBVS3dsT1gvRVVRSnVLaUxYd1V0Tksv?=
 =?utf-8?B?b1ljWjZtcGpRejVSV28ybGVPQ0NNdFJqaDdPbGFmVDI5dFZXdEpxcExsVElq?=
 =?utf-8?B?YWZVeldQUG4wbUFnbUluZWpGQlNrN2xERE5zblM3cmFPbUFlWGxDL3EyL1o2?=
 =?utf-8?B?aFpiaHMzenVucWxFMklMVTRnbnNvWEtRRHJnb1VsUC9mcS82VFhLd2JwcGhW?=
 =?utf-8?B?Zk95OC9YNlI1aGVldjVSZzVUVnFXY0kvU210UExZeXJEOHRHR2haZnVLMFF5?=
 =?utf-8?B?MDlicHd6S3ViZEhRVUR6dUJHbVBMVndnSVkwOW5TeEVEZ0h2azZ1dkliY09a?=
 =?utf-8?B?UXZONXVhL2NuMzVIWktmNHlQb01JZkcrb2U2a1doZ2tmOElOMTE1dDZPaVRS?=
 =?utf-8?B?anlDMzJaM0NSOS9UVFN5TC9ycm1NSzczS2ZnbkJkVlhGY1hrZ1Ywd0F6R0ZW?=
 =?utf-8?Q?VY8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce4a5c5-a542-47da-4bcb-08dbc898a28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 07:23:29.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goGdpWDem45MJ/c5jnZbwTPc7RNtkeEEwd+XmNizeVXOsPDLAKs2/azsBl/X1MLxHaVfly0hwElEmwPXeB04lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
bGVrc2FuZHJAbmF0YWxlbmtvLm5hbWU+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDI6NTUgUE0NCj4gVG86IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IE1lbmcsIExpIChKYXNz
bWluZSkgPExpLk1lbmdAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4geDg2QGtlcm5lbC5vcmc7IGxpbnV4LWFj
cGlAdmdlci5rZXJuZWwub3JnOyBTaHVhaCBLaGFuDQo+IDxza2hhbkBsaW51eGZvdW5kYXRpb24u
b3JnPjsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgRm9udGVub3QsDQo+IE5hdGhh
biA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFrLlNo
YXJtYUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29t
PjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IFl1YW4sIFBlcnJ5
IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyBEdSwNCj4gWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPjsNCj4gQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjggMC83XSBhbWQtcHN0YXRlIHByZWZlcnJlZCBj
b3JlDQo+DQo+IEhlbGxvLg0KPg0KPiBPbiBwb25kxJtsw60gOS4gxZnDrWpuYSAyMDIzIDQ6NDk6
MjUgQ0VTVCBNZW5nIExpIHdyb3RlOg0KPiA+IEhpIGFsbDoNCj4gPg0KPiA+IFRoZSBjb3JlIGZy
ZXF1ZW5jeSBpcyBzdWJqZWN0ZWQgdG8gdGhlIHByb2Nlc3MgdmFyaWF0aW9uIGluIHNlbWljb25k
dWN0b3JzLg0KPiA+IE5vdCBhbGwgY29yZXMgYXJlIGFibGUgdG8gcmVhY2ggdGhlIG1heGltdW0g
ZnJlcXVlbmN5IHJlc3BlY3RpbmcgdGhlDQo+ID4gaW5mcmFzdHJ1Y3R1cmUgbGltaXRzLiBDb25z
ZXF1ZW50bHksIEFNRCBoYXMgcmVkZWZpbmVkIHRoZSBjb25jZXB0IG9mDQo+ID4gbWF4aW11bSBm
cmVxdWVuY3kgb2YgYSBwYXJ0LiBUaGlzIG1lYW5zIHRoYXQgYSBmcmFjdGlvbiBvZiBjb3JlcyBj
YW4NCj4gPiByZWFjaCBtYXhpbXVtIGZyZXF1ZW5jeS4gVG8gZmluZCB0aGUgYmVzdCBwcm9jZXNz
IHNjaGVkdWxpbmcgcG9saWN5DQo+ID4gZm9yIGEgZ2l2ZW4gc2NlbmFyaW8sIE9TIG5lZWRzIHRv
IGtub3cgdGhlIGNvcmUgb3JkZXJpbmcgaW5mb3JtZWQgYnkNCj4gPiB0aGUgcGxhdGZvcm0gdGhy
b3VnaCBoaWdoZXN0IHBlcmZvcm1hbmNlIGNhcGFiaWxpdHkgcmVnaXN0ZXIgb2YgdGhlIENQUEMN
Cj4gaW50ZXJmYWNlLg0KPiA+DQo+ID4gRWFybGllciBpbXBsZW1lbnRhdGlvbnMgb2YgYW1kLXBz
dGF0ZSBwcmVmZXJyZWQgY29yZSBvbmx5IHN1cHBvcnQgYQ0KPiA+IHN0YXRpYyBjb3JlIHJhbmtp
bmcgYW5kIHRhcmdldGVkIHBlcmZvcm1hbmNlLiBOb3cgaXQgaGFzIHRoZSBhYmlsaXR5DQo+ID4g
dG8gZHluYW1pY2FsbHkgY2hhbmdlIHRoZSBwcmVmZXJyZWQgY29yZSBiYXNlZCBvbiB0aGUgd29y
a2xvYWQgYW5kDQo+ID4gcGxhdGZvcm0gY29uZGl0aW9ucyBhbmQgYWNjb3VudGluZyBmb3IgdGhl
cm1hbHMgYW5kIGFnaW5nLg0KPiA+DQo+ID4gQW1kLXBzdGF0ZSBkcml2ZXIgdXRpbGl6ZXMgdGhl
IGZ1bmN0aW9ucyBhbmQgZGF0YSBzdHJ1Y3R1cmVzIHByb3ZpZGVkDQo+ID4gYnkgdGhlIElUTVQg
YXJjaGl0ZWN0dXJlIHRvIGVuYWJsZSB0aGUgc2NoZWR1bGVyIHRvIGZhdm9yIHNjaGVkdWxpbmcN
Cj4gPiBvbiBjb3JlcyB3aGljaCBjYW4gYmUgZ2V0IGEgaGlnaGVyIGZyZXF1ZW5jeSB3aXRoIGxv
d2VyIHZvbHRhZ2UuDQo+ID4gV2UgY2FsbCBpdCBhbWQtcHN0YXRlIHByZWZlcnJlZCBjb3JlLg0K
PiA+DQo+ID4gSGVyZSBzY2hlZF9zZXRfaXRtdF9jb3JlX3ByaW8oKSBpcyBjYWxsZWQgdG8gc2V0
IHByaW9yaXRpZXMgYW5kDQo+ID4gc2NoZWRfc2V0X2l0bXRfc3VwcG9ydCgpIGlzIGNhbGxlZCB0
byBlbmFibGUgSVRNVCBmZWF0dXJlLg0KPiA+IEFtZC1wc3RhdGUgZHJpdmVyIHVzZXMgdGhlIGhp
Z2hlc3QgcGVyZm9ybWFuY2UgdmFsdWUgdG8gaW5kaWNhdGUgdGhlDQo+ID4gcHJpb3JpdHkgb2Yg
Q1BVLiBUaGUgaGlnaGVyIHZhbHVlIGhhcyBhIGhpZ2hlciBwcmlvcml0eS4NCj4gPg0KPiA+IEFt
ZC1wc3RhdGUgZHJpdmVyIHdpbGwgcHJvdmlkZSBhbiBpbml0aWFsIGNvcmUgb3JkZXJpbmcgYXQg
Ym9vdCB0aW1lLg0KPiA+IEl0IHJlbGllcyBvbiB0aGUgQ1BQQyBpbnRlcmZhY2UgdG8gY29tbXVu
aWNhdGUgdGhlIGNvcmUgcmFua2luZyB0byB0aGUNCj4gPiBvcGVyYXRpbmcgc3lzdGVtIGFuZCBz
Y2hlZHVsZXIgdG8gbWFrZSBzdXJlIHRoYXQgT1MgaXMgY2hvb3NpbmcgdGhlDQo+ID4gY29yZXMg
d2l0aCBoaWdoZXN0IHBlcmZvcm1hbmNlIGZpcnN0bHkgZm9yIHNjaGVkdWxpbmcgdGhlIHByb2Nl
c3MuDQo+ID4gV2hlbiBhbWQtcHN0YXRlIGRyaXZlciByZWNlaXZlcyBhIG1lc3NhZ2Ugd2l0aCB0
aGUgaGlnaGVzdCBwZXJmb3JtYW5jZQ0KPiA+IGNoYW5nZSwgaXQgd2lsbCB1cGRhdGUgdGhlIGNv
cmUgcmFua2luZy4NCj4gPg0KPiA+IENoYW5nZXMgZm9ybSBWNy0+Vjg6DQo+ID4gLSBhbGw6DQo+
ID4gLSAtIHBpY2sgdXAgUmV2aWV3LUJ5IGZsYWcgYWRkZWQgYnkgTWFyaW8gYW5kIFJheS4NCj4g
PiAtIGNwdWZyZXE6IGFtZC1wc3RhdGU6DQo+ID4gLSAtIHVzZSBod19wcmVmY29yZSBlbWJlZHMg
aW50byBjcHVkYXRhIHN0cnVjdHVyZS4NCj4gPiAtIC0gZGVsZXRlIHByZWZlcnJlZCBjb3JlIGlu
aXQgZnJvbSBjcHUgb25saW5lL29mZi4NCj4NCj4gQ291bGQgeW91IHBsZWFzZSBsZXQgbWUga25v
dyBpZiB0aGlzIGNoYW5nZSBtZWFucyBhIGZpeCBmb3IgdGhlIHJlcG9ydCBJJ3ZlDQo+IHNlbnQg
cHJldmlvdXNseT8gWzFdDQo+DQpbTWVuZywgTGkgKEphc3NtaW5lKV0gWWVzLg0KSSBoYXZlIGRl
bGV0ZWQgb25saW5lIGhhbmRsZSBmdW5jdGlvbiBvZiBhbWQgcHN0YXRlIGRyaXZlci4NCkl0IGRv
ZXNuJ3QgcmUtaW5pdGlhbGl6ZSBwcmVmZXJyZWQgY29yZS4NClRoaXMgb25saW5lIGZ1bmN0aW9u
IHdpbGwgc2V0IGluY29ycmVjdCBkZXMgcGVyZiB2YWx1ZS4NCg0KPiBXb3VsZCB5b3UgYWxzbyBi
ZSBhYmxlIHRvIENjIG1lIG9uIHRoZSBuZXh0IGl0ZXJhdGlvbiBvZiB0aGlzIHBhdGNoc2V0Pw0K
W01lbmcsIExpIChKYXNzbWluZSldIE9LLg0KPg0KPiBUaGFuayB5b3UhDQo+DQo+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzU5NzM2MjgubE9WNFd4NWJGVEBuYXRhbGVua28ubmFt
ZS8NCj4NCj4gPg0KPiA+IENoYW5nZXMgZm9ybSBWNi0+Vjc6DQo+ID4gLSB4ODY6DQo+ID4gLSAt
IE1vZGlmeSBrY29uZmlnIGFib3V0IFg4Nl9BTURfUFNUQVRFLg0KPiA+IC0gY3B1ZnJlcTogYW1k
LXBzdGF0ZToNCj4gPiAtIC0gbW9kaWZ5IGluY29ycmVjdCBjb21tZW50cyBhYm91dCBzY2hlZHVs
ZXJfd29yaygpLg0KPiA+IC0gLSBjb252ZXJ0IGhpZ2hlc3RfcGVyZiBkYXRhIHR5cGUuDQo+ID4g
LSAtIG1vZGlmeSBwcmVmZXJyZWQgY29yZSBpbml0IHdoZW4gY3B1IGluaXQgYW5kIG9ubGluZS4N
Cj4gPiAtIGFjcGk6IGNwcGM6DQo+ID4gLSAtIG1vZGlmeSBsaW5rIG9mIENQUEMgaGlnaGVzdCBw
ZXJmb3JtYW5jZS4NCj4gPiAtIGNwdWZyZXE6DQo+ID4gLSAtIG1vZGlmeSBsaW5rIG9mIENQUEMg
aGlnaGVzdCBwZXJmb3JtYW5jZSBjaGFuZ2VkLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3JtIFY1LT5W
NjoNCj4gPiAtIGNwdWZyZXE6IGFtZC1wc3RhdGU6DQo+ID4gLSAtIG1vZGlmeSB0aGUgd3Jvbmcg
dGFnIG9yZGVyLg0KPiA+IC0gLSBtb2RpZnkgd2FybmluZyBhYm91dCBod19wcmVmY29yZSBzeXNm
cyBhdHRyaWJ1dGUuDQo+ID4gLSAtIGRlbGV0ZSBkdXBsaWNhdGUgY29tbWVudHMuDQo+ID4gLSAt
IG1vZGlmeSB0aGUgdmFyaWFibGUgbmFtZSBjcHBjX2hpZ2hlc3RfcGVyZiB0byBwcmVmY29yZV9y
YW5raW5nLg0KPiA+IC0gLSBtb2RpZnkganVkZ21lbnQgY29uZGl0aW9ucyBmb3Igc2V0dGluZyBo
aWdoZXN0X3BlcmYuDQo+ID4gLSAtIG1vZGlmeSBzeXNmcyBhdHRyaWJ1dGUgZm9yIENQUEMgaGln
aGVzdCBwZXJmIHRvIHByX2RlYnVnIG1lc3NhZ2UuDQo+ID4gLSBEb2N1bWVudGF0aW9uOiBhbWQt
cHN0YXRlOg0KPiA+IC0gLSBtb2RpZnkgd2FybmluZzogdGl0bGUgdW5kZXJsaW5lIHRvbyBzaG9y
dC4NCj4gPg0KPiA+IENoYW5nZXMgZm9ybSBWNC0+VjU6DQo+ID4gLSBjcHVmcmVxOiBhbWQtcHN0
YXRlOg0KPiA+IC0gLSBtb2RpZnkgc3lzZnMgYXR0cmlidXRlIGZvciBDUFBDIGhpZ2hlc3QgcGVy
Zi4NCj4gPiAtIC0gbW9kaWZ5IHdhcm5pbmcgYWJvdXQgY29tbWVudHMNCj4gPiAtIC0gcmViYXNl
IGxpbnV4LW5leHQNCj4gPiAtIGNwdWZyZXE6DQo+ID4gLSAtIE1vaWRmeSB3YXJuaW5nIGFib3V0
IGZ1bmN0aW9uIGRlY2xhcmF0aW9ucy4NCj4gPiAtIERvY3VtZW50YXRpb246IGFtZC1wc3RhdGU6
DQo+ID4gLSAtIGFsaWduIHdpdGggYGBhbWQtcHN0YXRgYA0KPiA+DQo+ID4gQ2hhbmdlcyBmb3Jt
IFYzLT5WNDoNCj4gPiAtIERvY3VtZW50YXRpb246IGFtZC1wc3RhdGU6DQo+ID4gLSAtIE1vZGlm
eSBpbmFwcHJvcHJpYXRlIGRlc2NyaXB0aW9ucy4NCj4gPg0KPiA+IENoYW5nZXMgZm9ybSBWMi0+
VjM6DQo+ID4gLSB4ODY6DQo+ID4gLSAtIE1vZGlmeSBrY29uZmlnIGFuZCBkZXNjcmlwdGlvbi4N
Cj4gPiAtIGNwdWZyZXE6IGFtZC1wc3RhdGU6DQo+ID4gLSAtIEFkZCBDby1kZXZlbG9wZWQtYnkg
dGFnIGluIGNvbW1pdCBtZXNzYWdlLg0KPiA+IC0gY3B1ZnJlcToNCj4gPiAtIC0gTW9kaWZ5IGNv
bW1pdCBtZXNzYWdlLg0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1kLXBzdGF0ZToNCj4gPiAtIC0g
TW9kaWZ5IGluYXBwcm9wcmlhdGUgZGVzY3JpcHRpb25zLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3Jt
IFYxLT5WMjoNCj4gPiAtIGFjcGk6IGNwcGM6DQo+ID4gLSAtIEFkZCByZWZlcmVuY2UgbGluay4N
Cj4gPiAtIGNwdWZyZXE6DQo+ID4gLSAtIE1vaWRmeSBsaW5rIGVycm9yLg0KPiA+IC0gY3B1ZnJl
cTogYW1kLXBzdGF0ZToNCj4gPiAtIC0gSW5pdCB0aGUgcHJpb3JpdGllcyBvZiBhbGwgb25saW5l
IENQVXMNCj4gPiAtIC0gVXNlIGEgc2luZ2xlIHZhcmlhYmxlIHRvIHJlcHJlc2VudCB0aGUgc3Rh
dHVzIG9mIHByZWZlcnJlZCBjb3JlLg0KPiA+IC0gRG9jdW1lbnRhdGlvbjoNCj4gPiAtIC0gRGVm
YXVsdCBlbmFibGVkIHByZWZlcnJlZCBjb3JlLg0KPiA+IC0gRG9jdW1lbnRhdGlvbjogYW1kLXBz
dGF0ZToNCj4gPiAtIC0gTW9kaWZ5IGluYXBwcm9wcmlhdGUgZGVzY3JpcHRpb25zLg0KPiA+IC0g
LSBEZWZhdWx0IGVuYWJsZWQgcHJlZmVycmVkIGNvcmUuDQo+ID4gLSAtIFVzZSBhIHNpbmdsZSB2
YXJpYWJsZSB0byByZXByZXNlbnQgdGhlIHN0YXR1cyBvZiBwcmVmZXJyZWQgY29yZS4NCj4gPg0K
PiA+IE1lbmcgTGkgKDcpOg0KPiA+ICAgeDg2OiBEcm9wIENQVV9TVVBfSU5URUwgZnJvbSBTQ0hF
RF9NQ19QUklPIGZvciB0aGUgZXhwYW5zaW9uLg0KPiA+ICAgYWNwaTogY3BwYzogQWRkIGdldCB0
aGUgaGlnaGVzdCBwZXJmb3JtYW5jZSBjcHBjIGNvbnRyb2wNCj4gPiAgIGNwdWZyZXE6IGFtZC1w
c3RhdGU6IEVuYWJsZSBhbWQtcHN0YXRlIHByZWZlcnJlZCBjb3JlIHN1cHBvcnRpbmcuDQo+ID4g
ICBjcHVmcmVxOiBBZGQgYSBub3RpZmljYXRpb24gbWVzc2FnZSB0aGF0IHRoZSBoaWdoZXN0IHBl
cmYgaGFzIGNoYW5nZWQNCj4gPiAgIGNwdWZyZXE6IGFtZC1wc3RhdGU6IFVwZGF0ZSBhbWQtcHN0
YXRlIHByZWZlcnJlZCBjb3JlIHJhbmtpbmcNCj4gPiAgICAgZHluYW1pY2FsbHkNCj4gPiAgIERv
Y3VtZW50YXRpb246IGFtZC1wc3RhdGU6IGludHJvZHVjZSBhbWQtcHN0YXRlIHByZWZlcnJlZCBj
b3JlDQo+ID4gICBEb2N1bWVudGF0aW9uOiBpbnRyb2R1Y2UgYW1kLXBzdGF0ZSBwcmVmZXJyZCBj
b3JlIG1vZGUga2VybmVsDQo+IGNvbW1hbmQNCj4gPiAgICAgbGluZSBvcHRpb25zDQo+ID4NCj4g
PiAgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgICA1ICsN
Cj4gPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0YXRlLnJzdCAgIHwgIDU5
ICsrKysrLQ0KPiA+ICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDUgKy0NCj4gPiAgZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jICAgICAgICAgICAgICAg
ICAgICAgIHwgIDEzICsrDQo+ID4gIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMgICAg
ICAgICAgICAgICB8ICAgNiArDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgICAg
ICAgICAgICAgICAgICB8IDE4NiArKysrKysrKysrKysrKysrLS0NCj4gPiAgZHJpdmVycy9jcHVm
cmVxL2NwdWZyZXEuYyAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsrDQo+ID4gIGluY2x1ZGUv
YWNwaS9jcHBjX2FjcGkuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+ID4gIGluY2x1
ZGUvbGludXgvYW1kLXBzdGF0ZS5oICAgICAgICAgICAgICAgICAgICB8ICAxMCArDQo+ID4gIGlu
Y2x1ZGUvbGludXgvY3B1ZnJlcS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+ID4g
IDEwIGZpbGVzIGNoYW5nZWQsIDI4NSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+DQo+DQo+DQo+IC0tDQo+IE9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQ0K
