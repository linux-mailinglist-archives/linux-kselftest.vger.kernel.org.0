Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E427CBD40
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjJQIWN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIWM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:22:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD6A93;
        Tue, 17 Oct 2023 01:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxzhN6tMPZ1551oGmS89/pC/Z+KN/6xtWEshieG/kSrYrZcOz2ImIAl1e+qqeANEmhThuPwuwyIPP6n0nWGuUZm9Eu16zY5W+vZtATJDsH1sA9wSFzNf5Msk02mYjzcZbkaak58XS6wnqfSuqaDL7vit19NUgmAHvGXlonIqBK3zV2mnzNgd+F3iMrthmrrkSGX5lUvepeOLpE6IvSeKNnzgNrAJJaAvwOYO9JmF/ewPrEGhwH3wEglce6sFcv16cFctdFasRCtnt/cDgatn0yzvMExfcIOUfWigrZaN7/cEsHncwMIm9jQF12UUMwngBBYCrUSHlCJHYe6jfEriOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/S4CKHJI1l4NrxW7U9ahbZawjUCq2IpdYpse3kbl1tM=;
 b=VPf690+aAWajvxI0o7harfMOi61VERclKOJGMAZoesO3IbM/zHpkI/d5StjVD3+T+6Ff+bsKYAY83lVL9CboiEpGE1bakZ7Q7T2X1Dct5wrnOxk7OhMjBpSYsxfomrGgbMoLL68TnisfKZgh11Uoz2CAu2bBV+3lCqHT4GLx62kuE20AeM+8AXyr8wiXuY2QyB0cN0xekE7sNMmozl4zwBpztN2v2Pj+CZM+6BvcnKPEQ45XLaoJ4WWZpb3yDX3TjvJ5s/ATvCtCm3xF1EbebC2iYvSNv5H893kdsW+y8/sY9bSNWr0Gtnt4omBhhkmalov99ecCW+LZflcmTppsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/S4CKHJI1l4NrxW7U9ahbZawjUCq2IpdYpse3kbl1tM=;
 b=oU/Pv+cLB9m0E8SjaxJHjvpGomzsu6B44lyABWEzR+S1GZsmZjfjSqXn3Dl5TObb3hogNP9pSa0JEq7+8mnCLMxrINktx26ltDdjizMDsk6Xs6c0Z80vN5VMx+Kt+LFt+G2uAXUXW1UcfNI1ikOWLtPYY8L9uf8BchdmdgmH+7c=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 08:22:06 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:22:06 +0000
From:   "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Huang, Ray" <Ray.Huang@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
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
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Thread-Topic: [RESEND PATCH V9 3/7] cpufreq: amd-pstate: Enable amd-pstate
 preferred core supporting.
Thread-Index: AQHZ/YXbRWpJHuQ860GMQa8yy6kr3rBH4gAAgAQJJqCAAFlFgIAAbH2AgAAXVgCAAN4vkA==
Date:   Tue, 17 Oct 2023 08:22:05 +0000
Message-ID: <DM4PR12MB6351CDA8135CC7A4E18E430BF7D6A@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <20231013033118.3759311-1-li.meng@amd.com>
         <20231013033118.3759311-4-li.meng@amd.com>
         <20231013160128.GB36211@noisy.programming.kicks-ass.net>
         <DM4PR12MB6351E2E9504B57BD40DAE985F7D7A@DM4PR12MB6351.namprd12.prod.outlook.com>
         <20231016105845.GA33217@noisy.programming.kicks-ass.net>
         <e82fc689-5cc3-d799-6e5f-a9e4ac98e26f@intel.com>
 <eeb77ec34d2002e507c09949aac9110d8b8eff4a.camel@linux.intel.com>
In-Reply-To: <eeb77ec34d2002e507c09949aac9110d8b8eff4a.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6aa6c6aa-2b80-4fc4-a09a-b01d4089efdb;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T08:05:47Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB6798:EE_
x-ms-office365-filtering-correlation-id: e2c56ea2-1018-4659-dcba-08dbceea2613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNBqS+gVhQD5bEQRwK2FQtMpC7aeO41fJpnGCONQX44DtsshejZrosXTAMSPHhgllcNdiBsrzcdJviFy41m6bxVGRbTPbWG8F2bfdsLPBDHpCfhEB8mWrBwT5EqEO05fuKewedqhSqinQ3hsh6gMustOvvyYOZKYbLrW/ANyObLlbviYcDHUwHh0SNl2WJ1SOJOgiUcE2Bmbm79XACqU68yW+iqovzcP7JceZoLyo/t2HHO24CfqwKesfKGN6pj9uFTUsw+J0IFYibLj7FgcomNOC206aqqRTcYrFgTPxEG8WczqtGDDLZGzW55NZ3JK3NX87w0lN+uybdGnfSJEu/43Y+ch4htWrUboA32CN+xviAyhQ+SVMTO19ZH2YHcexrkSZBvz9SmDkMPt2fGa6S3ht2ZY+d66LJg+eO2IENrGlabrKs4/XjJUnu4xK2iM9mfZCdKbEX7YcEd8oZJccIzxi+gtia2ZagtBFhOWE+0R5iH3oBAOiDunZ882FWeITcuJrxXvzQXCcLOA+QPM/ABzPni9gUH8LBH8ZNOvPgPMJZ2Q+Zg7P9f79jKncNUWXmTFMmmIUzBHcufXRfjuRNvbLiG5+1W0VMor+i61VdFS1jrM4xrWMjo2ZRBgs2TM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(55016003)(66946007)(478600001)(71200400001)(110136005)(64756008)(76116006)(66446008)(54906003)(66476007)(66556008)(83380400001)(86362001)(38100700002)(316002)(9686003)(7696005)(53546011)(26005)(6506007)(41300700001)(5660300002)(7416002)(38070700005)(4001150100001)(122000001)(52536014)(2906002)(4326008)(33656002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJzcS92SVp5S0IySHZlYzladjlqQ0JmNklFZ0lTWXkvdXByeXdxeE8raEl6?=
 =?utf-8?B?WEhEaFlVOFVnNHVoTDFtYjI0SEkwN2RFTUlKMWhrN24xT0NVMzc2V3dFa2xk?=
 =?utf-8?B?YVpxSWVKNzJLNTdWdy9wTFlZZVRMM1dHMERYQ0E5K3VKNWNzTzQzMjJWNXoy?=
 =?utf-8?B?bjhFK0M4OWZoVFVPSWlSTDBzaUlEeXZYVjBLOXVSNEpOYWdDbHYyS201VXZY?=
 =?utf-8?B?bXRvWjJPS3NFOUJnRUo3dHBDTDdvMWEyZlFvaFZ0RTdQSXF3T2sybEZ1cmRy?=
 =?utf-8?B?VjZlc3RzaU1jbXplR3B3eUxOVnBMdkNjdE5TSTVWTy9QZ1ladGVOU3RrVzNQ?=
 =?utf-8?B?SGRleU1LMHNXQUZyaVQvNldzWG9CWlNoaU9uZk9zOXI2Sjk1S1lDRnhyOFFr?=
 =?utf-8?B?YldlNE9VN0ZkS1hrZHRxNENqQW0vOEFUZVROU3hzS1MrL3hka09KQ3g4QXVS?=
 =?utf-8?B?ZVN3SUlXcjgwTVVJN2VLU1ZuZnZkTmxKaU5EaUxWWlpnVS93MmFDMUxPUXBM?=
 =?utf-8?B?eDQxeDhYcm1VdFpBSU9Ic1lNajNaQTZZZWQwVWlGU05YOHZsT2poU1E5czhD?=
 =?utf-8?B?VEJaSU10WUFFa0ViSTZXVDhTOTl6dTRHYk0xS08yaDc0WjF0Sk5pcVVrYktP?=
 =?utf-8?B?U2R2cmpJRGlEVk1vVUFGRmMycGhtd2I2RGY0Q2FLMzhSUDBxcEVSYkMzM2lC?=
 =?utf-8?B?THFWYW5tRklzSGg5aDFUMVdWQVVPaU9pbjZieUp0RFZCbnl5SFVjSTFIL1pL?=
 =?utf-8?B?TE9Db1FHaGJFbE56SG5pWjc2Ujg4M0xUS2p1WHVrU3c4bjg1N0FvMHNRQ1ZU?=
 =?utf-8?B?QzBrOFIwbWRvVlhDcWZSUU1PK2liRGVGUHh6SjlVU05pQ0drUWN6bnBOZjdk?=
 =?utf-8?B?ZGVuRXBJUDdBMENtaVhkM0N1NXNPWEphWk5KQXJMNUpGbVpUSlBBYXlLS2N1?=
 =?utf-8?B?c1FsaU5TSXpUazd1Rm9Yb2s3R1oxT2w2RHNobzZuMkhXR2tvL1Z5akttbUNj?=
 =?utf-8?B?b1hRNWZ3ajJNc1pNcTlBYnMwSHBnSkZYRkgyMFNSSGZwRWcvbG5mK2F0VTIr?=
 =?utf-8?B?Slg0SUtZaStkV0ZjYTF4Q3BKU0dWQnZGVUxMZTZXdzFtQmg2S1AwdkNVdnlB?=
 =?utf-8?B?by9ndFB1NTFhaDBKYTk5OFFMRTRCekNWNnZpMzRMWlIyRDEvaGJMYUhoVkZl?=
 =?utf-8?B?enBvMEowZVRId0JPQ0ZobFI2OVMzcE5NWW1jWXcvUWsvTmFabXFMNHFXYTRO?=
 =?utf-8?B?ekV4RFU0TlM1SXB0NHpmNVBodXM3b0k0UVZyaWZuRDlGeTJmR3lMSmF5Q2tE?=
 =?utf-8?B?MHpUcnFCV3BDczdrZXd3bGcrbGNyTzhPRytoQXlpbFFwdkxpdWtoUzRqS0p1?=
 =?utf-8?B?MWxXN3ZMYVZ6b3FXaGd2Zm50Vjl4YnB3UHh5MVVzeGhWeWd0Tk1sTlVUUU82?=
 =?utf-8?B?R3RXVW5ZNWM1cXNaRW51emRQYUR5bHNNck0vQkFUQ1BsSis5VnZ5d1JIRWpz?=
 =?utf-8?B?WU1iZ0crT1l3V1JsTmt5UjNqYjYvcGFvSkdTME5iSURzQkUxSm8zY2I5QVdp?=
 =?utf-8?B?T2JTNTZsS2VMRFNISENYUkVVNW5UbUl3RDJWMVpMbTNQOVZ0ZlM4NGcyZnZp?=
 =?utf-8?B?Rnc0K2pINzJaSDl0Y3g0MlVXWmdVbG9aYXRCVTNXR1BndDc5Q3NZUjRyaWtj?=
 =?utf-8?B?bXp0SU9YWUZadW15TTR3UkpJQTVKRHdyYWdrOTR0YXErSkhHbUNwdFh4V3VE?=
 =?utf-8?B?RUh4RXoxYWppQnlIRFNza1dTSXBWcTkwcmJuT0hVTEJYTnFxTm9rb1RRRHcw?=
 =?utf-8?B?c3VUa1RYTys1M3VuNTVxVHB4dW5IVy82dSsvNW96L1c2RXJWSVVFbUUyYyt1?=
 =?utf-8?B?S0VnaDJTemVOTmd3ZDFMeFhPbnlKSktTTVdyYmlxcTBxazZCUjJyUm45UW5i?=
 =?utf-8?B?N09jNkFvT2NYR2pjME1iTnA1NXBUemxxT0dhK3ZOUkErSmVQUW9HVW5YdVJV?=
 =?utf-8?B?ZzJJaDZCMUN2cFZPUnJ5N25KRjNuUG1RMmNoUCszNWNGTFBnSzM2WDNZblBx?=
 =?utf-8?B?aFhsdVZ4MXV0N2RRbytLVjNBL0doQmwyejZKK2E3Nm5rdU43R3I4T0RtaDd3?=
 =?utf-8?Q?RqSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c56ea2-1018-4659-dcba-08dbceea2613
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:22:05.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEbHIy+V/W6D8J+zPjpEfDKbk/ohvPQd1gayzqmxcxTbej7W1ACie93lyVQj43QKXQc/YHlf8pZuxGXbYmXCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBldGVyOg0KDQpBZnRlciBv
dXIgaW50ZXJuYWwgZGlzY3Vzc2lvbiwgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb25zIHdpbGwg
YmUgbWFkZS4NCkRvIHlvdSB0aGluayB0aGV5IGFyZSBmZWFzaWJsZT8NCiAgICAgICAgMS4gQWRk
IGp1ZGdlbWVudCBmb3IgImhpZ2hlc3RfcGVyZiIuICBXaGVuIGl0IGlzIGxlc3MgdGhhbiAyNTUs
IHRoZSBwcmVmZXJyZWQgY29yZSBmZWF0dXJlIGlzIGVuYWJsZWQuIEFuZCBpdCB3aWxsIHNldCB0
aGUgcHJpb3JpdHkuDQogICAgICAgIDIuIERlbGV0ZSAic3RhdGljIHUzMiBtYXhfaGlnaHNldF9w
ZXJmL21pbl9oaWdoZXN0X3BlcmYiLCBiZWNhdXNlIGFtZCBwLXN0YXRlIHByZWZlcnJlZCBjb3Jl
IGRvZXMgbm90IHJlcXVpcmUgc3BlY2lhbCBwcm9jZXNzaW5nIGZvciBob3RwbHVnLg0KDQorI2Rl
ZmluZSBDUFBDX01BWF9QRVJGICBVOF9NQVgNCisNCitzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX2lu
aXRfcHJlZmNvcmUoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KK3sNCisgICAgICAgaW50
IHJldCwgcHJpbzsNCisgICAgICAgdTMyIGhpZ2hlc3RfcGVyZjsNCisNCisgICAgICAgcmV0ID0g
YW1kX3BzdGF0ZV9nZXRfaGlnaGVzdF9wZXJmKGNwdWRhdGEtPmNwdSwgJmhpZ2hlc3RfcGVyZik7
DQorICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKw0KKyAgICAgICBj
cHVkYXRhLT5od19wcmVmY29yZSA9IHRydWU7DQorICAgICAgIC8qIGNoZWNrIGlmIENQUEMgcHJl
ZmVycmVkIGNvcmUgZmVhdHVyZSBpcyBlbmFibGVkKi8NCisgICAgICAgaWYgKGhpZ2hlc3RfcGVy
ZiA8IENQUENfTUFYX1BFUkYpDQorICAgICAgICAgICAgICAgcHJpbyA9IChpbnQpaGlnaGVzdF9w
ZXJmOw0KKyAgICAgICBlbHNlIHsNCisgICAgICAgICAgICAgICBwcl9kZWJ1ZygiQU1EIENQUEMg
cHJlZmVycmVkIGNvcmUgaXMgdW5zdXBwb3J0ZWQhXG4iKTsNCisgICAgICAgICAgICAgICBjcHVk
YXRhLT5od19wcmVmY29yZSA9IGZhbHNlOw0KKyAgICAgICAgICAgICAgIHJldHVybjsNCisgICAg
ICAgfQ0KKw0KKyAgICAgICBpZiAoIWFtZF9wc3RhdGVfcHJlZmNvcmUpDQorICAgICAgICAgICAg
ICAgcmV0dXJuOw0KKw0KKyAgICAgICAvKg0KKyAgICAgICAgKiBUaGUgcHJpb3JpdGllcyBjYW4g
YmUgc2V0IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBvciBub3QNCisgICAgICAgICogc2NoZWRfc2V0
X2l0bXRfc3VwcG9ydCh0cnVlKSBoYXMgYmVlbiBjYWxsZWQgYW5kIGl0IGlzIHZhbGlkIHRvDQor
ICAgICAgICAqIHVwZGF0ZSB0aGVtIGF0IGFueSB0aW1lIGFmdGVyIGl0IGhhcyBiZWVuIGNhbGxl
ZC4NCisgICAgICAgICovDQorICAgICAgIHNjaGVkX3NldF9pdG10X2NvcmVfcHJpbyhwcmlvLCBj
cHVkYXRhLT5jcHUpOw0KKw0KKyAgICAgICBzY2hlZHVsZV93b3JrKCZzY2hlZF9wcmVmY29yZV93
b3JrKTsNCit9DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc3Jpbml2
YXMgcGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTcsIDIwMjMgMjo1MSBBTQ0KPiBUbzogV3lzb2NraSwgUmFm
YWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgTWVuZywgTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29t
Pg0KPiBDYzogSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyB4ODZAa2VybmVsLm9y
ZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFNodWFoDQo+IEtoYW4gPHNraGFuQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOw0KPiBGb250
ZW5vdCwgTmF0aGFuIDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IFNoYXJtYSwgRGVlcGFrDQo+
IDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsg
WXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IER1LA0KPiBYaWFvamlhbiA8WGlhb2pp
YW4uRHVAYW1kLmNvbT47IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+Ow0K
PiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IE9sZWtzYW5kciBOYXRhbGVua28NCj4g
PG9sZWtzYW5kckBuYXRhbGVua28ubmFtZT47IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkVTRU5EIFBBVENIIFY5IDMvN10gY3B1ZnJlcTogYW1kLXBz
dGF0ZTogRW5hYmxlIGFtZC0NCj4gcHN0YXRlIHByZWZlcnJlZCBjb3JlIHN1cHBvcnRpbmcuDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gTW9uLCAyMDIzLTEwLTE2IGF0
IDE5OjI3ICswMjAwLCBXeXNvY2tpLCBSYWZhZWwgSiB3cm90ZToNCj4gPiBPbiAxMC8xNi8yMDIz
IDEyOjU4IFBNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgT2N0IDE2LCAy
MDIzIGF0IDA2OjIwOjUzQU0gKzAwMDAsIE1lbmcsIExpIChKYXNzbWluZSkNCj4gPiA+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIGFtZF9wc3RhdGVfaW5pdF9wcmVmY29yZShzdHJ1
Y3QgYW1kX2NwdWRhdGENCj4gPiA+ID4gPiA+ICpjcHVkYXRhKSB7DQo+ID4gPiA+ID4gPiArICAg
ICBpbnQgcmV0LCBwcmlvOw0KPiA+ID4gPiA+ID4gKyAgICAgdTMyIGhpZ2hlc3RfcGVyZjsNCj4g
PiA+ID4gPiA+ICsgICAgIHN0YXRpYyB1MzIgbWF4X2hpZ2hlc3RfcGVyZiA9IDAsIG1pbl9oaWdo
ZXN0X3BlcmYgPQ0KPiA+ID4gPiA+ID4gVTMyX01BWDsNCj4gPiA+ID4gPiBXaGF0IHNlcmlhbGl6
ZXMgdGhlc2UgdGhpbmdzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbywgKndoeSogYXJlIHlv
dSB1c2luZyB1MzIgaGVyZSwgd2hhdCdzIHdyb25nIHdpdGggc29tZXRoaW5nDQo+ID4gPiA+ID4g
bGlrZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAgICAgIGludCBtYXhfaHAgPSBJTlRfTUlO
LCBtaW5faHAgPSBJTlRfTUFYOw0KPiA+ID4gPiA+DQo+ID4gPiA+IFtNZW5nLCBMaSAoSmFzc21p
bmUpXQ0KPiA+ID4gPiBXZSB1c2UgSVRNVCBhcmNoaXRlY3R1cmUgdG8gdXRpbGl6ZSBwcmVmZXJy
ZWQgY29yZSBmZWF0dXJlcy4NCj4gPiA+ID4gVGhlcmVmb3JlLCB3ZSBuZWVkIHRvIHRyeSB0byBi
ZSBjb25zaXN0ZW50IHdpdGggSW50ZWwncw0KPiA+ID4gPiBpbXBsZW1lbnRhdGlvbiBhcyBtdWNo
IGFzIHBvc3NpYmxlLiAgRm9yIGRldGFpbHMsIHBsZWFzZSByZWZlciB0bw0KPiA+ID4gPiB0aGUg
aW50ZWxfcHN0YXRlX3NldF9pdG10X3ByaW8gZnVuY3Rpb24gaW4gZmlsZSBpbnRlbF9wc3RhdGUu
Yy4NCj4gPiA+ID4gKExpbmUNCj4gPiA+ID4gMzU1KQ0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5r
IHVzaW5nIHRoZSBkYXRhIHR5cGUgb2YgdTMyIGlzIGNvbnNpc3RlbnQgd2l0aCB0aGUgZGF0YQ0K
PiA+ID4gPiBzdHJ1Y3R1cmVzIG9mIGNwcGNfcGVyZl9jdHJscyBhbmQgYW1kX2NwdWRhdGEgZXRj
Lg0KPiA+ID4gUmFmYWVsLCBzaG91bGQgd2UgZml4IGludGVsX3BzdGF0ZSB0b28/DQo+ID4NCj4g
PiBTcmluaXZhcyBzaG91bGQgYmUgbW9yZSBmYW1pbGlhciB3aXRoIHRoaXMgY29kZSB0aGFuIEkg
YW0sIHNvIGFkZGluZw0KPiA+IGhpbS4NCj4gPg0KPiBJZiB3ZSBtYWtlDQo+ICAgICAgICAgc3Rh
dGljIHUzMiBtYXhfaGlnaGVzdF9wZXJmID0gMCwgbWluX2hpZ2hlc3RfcGVyZiA9IFUzMl9NQVg7
IHRvDQo+ICAgICAgICAgc3RhdGljIGludCBtYXhfaGlnaGVzdF9wZXJmID0gSU5UX01JTiwgbWlu
X2hpZ2hlc3RfcGVyZiA9IElOVF9NQVg7DQo+DQo+IFRoZW4gaW4gaW50ZWxfcHN0YXRlIHdlIHdp
bGwgY29tcGFyZSBzaWduZWQgdnMgdW5zaWduZWQgY29tcGFyaXNvbiBhcw0KPiBjcHBjX3BlcmYu
aGlnaGVzdF9wZXJmIGlzIHUzMi4NCj4NCj4NCj4gSW4gcmVhbGl0eSB0aGlzIHdpbGwgYmUgZmlu
ZSB0byBjaGFuZ2UgdG8gImludCIgYXMgd2Ugd2lsbCBuZXZlciByZWFjaA0KPiB1MzIgbWF4IGFz
IHBlcmZvcm1hbmNlIG9uIGFueSBJbnRlbCBwbGF0Zm9ybS4NCj4NCj4gPg0KPiA+ID4gVGhlIHBv
aW50IGlzLCB0aGF0IHNjaGVkX2FzeW1fcHJlZmVyKCksIHRoZSBmaW5hbCBjb25zdW1lciBvZiB0
aGVzZQ0KPiA+ID4gdmFsdWVzIHVzZXMgaW50IGFuZCB0aHVzIGFuIGV4cGxpY2l0bHkgc2lnbmVk
IGNvbXBhcmUuDQo+ID4gPg0KPiA+ID4gVXNpbmcgdTMyIGFuZCBVMzJfTUFYIGFueXdoZXJlIG5l
YXIgdGhlIHNldHRpbmcgdGhlIHByaW9yaXR5IG1ha2VzDQo+ID4gPiBhYnNvbHV0ZWx5IG5vIHNl
bnNlLg0KPiA+ID4NCj4gPiA+IElmIHlvdSB3ZXJlIHRvIGhhdmUgdGhlIGhpZ2ggYml0IHNldCwg
dGhpbmdzIGRvIG5vdCBiZWhhdmUgYXMNCj4gPiA+IGV4cGVjdGVkLg0KPiA+DQo+ID4gUmlnaHQs
IGJ1dCBpbiBwcmFjdGljZSB0aGVzZSB2YWx1ZXMgYXJlIGFsd2F5cyBiZXR3ZWVuIDAgYW5kIDI1
NQ0KPiA+IGluY2x1c2l2ZSBBRkFJQ1MuDQo+ID4NCj4gPiBJdCB3b3VsZCBoYXZlIGJlZW4gYmV0
dGVyIHRvIHVzZSB1OCBJIHN1cHBvc2UuDQo+IFNob3VsZCBiZSBmaW5lIGFzIG92ZXIgY2xvY2tl
ZCBwYXJ0cyB3aWxsIHNldCB0byBtYXggMHhmZi4NCj4NCj4gPg0KPiA+DQo+ID4gPiBBbHNvLCBz
YW1lIHF1ZXN0aW9uIGFzIHRvIHRoZSBhbWQgZm9sa3M7IHdoYXQgc2VyaWFsaXplcyB0aG9zZQ0K
PiA+ID4gc3RhdGljIHZhcmlhYmxlcz8NCj4gPg0KPiA+IFRoYXQncyBhIGdvb2Qgb25lLg0KPg0K
PiBUaGlzIGZ1bmN0aW9uIHdoaWNoIGlzIGNoZWNraW5nIHN0YXRpYyB2YXJpYWJsZXMgaXMgY2Fs
bGVkIGZyb20gY3B1ZnJlcQ0KPiAtPmluaXQgY2FsbGJhY2suIFdoaWNoIGluIHR1cm4gaXMgY2Fs
bGVkIGZyb20gYSBmdW5jdGlvbiB3aGljaCBpcw0KPiBwYXNzZWQgYXMgc3RhcnR1cCgpIGZ1bmN0
aW9uIHBvaW50ZXIgdG8NCj4gY3B1aHBfc2V0dXBfc3RhdGVfbm9jYWxsc19jcHVzbG9ja2VkKCku
DQo+DQo+IEkgc2VlIHRoYXQgc3RhcnR1cCgpIGNhbGxiYWNrcyBhcmUgY2FsbGVkIHVuZGVyIGEg
bXV0ZXggY3B1aHBfc3RhdGVfbXV0ZXgNCj4gZm9yIGVhY2ggcHJlc2VudCBDUFVzLiBTbyBpZiBz
b21lIHRlYXIgZG93biBoYXBwZW4sIHRoYXQgaXMgYWxzbyBwcm90ZWN0ZWQNCj4gYnkgdGhlIHNh
bWUgbXV0ZXguIFRoZSBhc3N1bXB0aW9uIGlzIGhlcmUgaXMgdGhhdCBjcHVocF9pbnZva2VfY2Fs
bGJhY2soKQ0KPiBpbiBob3RwbHVnIHN0YXRlIG1hY2hpbmUgaXMgbm90IGNhbGxlZCBpbiBwYXJh
bGxlbCBvbiB0d28gQ1BVcyBieSB0aGUgaG90cGx1Zw0KPiBzdGF0ZSBtYWNoaW5lLiBCdXQgSSBz
ZWUgYWN0aXZpdHkgb24gcGFyYWxsZWwgYnJpbmd1cCwgc28gdGhpcyBpcyBxdWVzdGlvbmFibGUN
Cj4gbm93Lg0KPg0KPiBUaGFua3MsDQo+IFNyaW5pdmFzDQo+DQo+ID4NCj4gPg0KDQo=
