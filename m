Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CC745A097
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Nov 2021 11:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKWKpg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 05:45:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:48542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKWKpg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 05:45:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321230638"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="321230638"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 02:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="571024794"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2021 02:42:26 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 23 Nov 2021 02:42:26 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 23 Nov 2021 02:42:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 23 Nov 2021 02:42:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 23 Nov 2021 02:42:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezrj6zE9ztrHTQ64JiElYQXxsdbuMI1vKLbxTUM0h8vV50aahHydI0NO66DZZy+9w9uVkLutPWXy6+vUFz5RTz/o/WVWk/dfAo03C9quxOMj4ipe+3xFD2NvV5yvWlGPrG5WeKB4RnKSRElEI9bmDoftGAIqseGefjUWTYwDiPZG+GA97+F5hjcnlljfd5j/Qcvf0ZACEox1vK9mN+vq8voc/xoNiOKjDqBQ/mFig/IyKQbDtoJuVcFZE01NMzTP6bfhxt8CdriPTCxkpH7ZF9OMt3SUu0zxMv81bL0RLndwFVg7xD8PVdq8Q3M7UTfwBpeXdj/XM7H+FrFfEFs0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojpEdpMITaYh/XWYQspADFd3gYSnepLual3+mmXg8rw=;
 b=DbF7EhDHzmPXcmMCod2OD5j/0zst7S4kJ/yZnpIABaAsghwaxfitvTKBDKtPZLPh0hSh5m33j7TuOrhiMwt0C9q7USBVHDAK643bbB+eiukO4R8Ms1YAhJPvRuCoTuAIXZqhHzXBZOuPlMyvF8+112Gm+gzmt6CDiWhZ/J6+f4YeIAO7DP5+n0nGLmvBaTs9ufbGRZ/XK3ijHbGzi79sqttDc51n5mW4d+0NdhGe3LRiqVJTBY1gimxb8hgWFvc669xLY4dwyKVnLEvBgIFshC3tt9NzgHkuS3KHygQiGxab9+2T+lAXlIAu9xjlJGM83GgxKqAeegdtwAg7GmBArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojpEdpMITaYh/XWYQspADFd3gYSnepLual3+mmXg8rw=;
 b=rL+qNQgsE5revzwmqV6XVnKC0xCVzNH1w7QPZL6B41YDdlGElMWfY24mKRUMBZWcF1h1EiwJ+PDz0jXJCJCBng9MvWc6ZT9YJtRJLcn2MYRQdytriBip4ZSShPoYlTjTgq+Zb0XQr4WIzHSSERzVNUGYXv75jyWs41E51btME6A=
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 23 Nov
 2021 10:42:18 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420%3]) with mapi id 15.20.4690.027; Tue, 23 Nov 2021
 10:42:18 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "pbonzini@redhat.com" <pbonzini@redhat.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "ricarkol@google.com" <ricarkol@google.com>,
        "drjones@redhat.com" <drjones@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        "Li, ZhijianX" <zhijianx.li@intel.com>
Subject: kernel-selftests/kvm: kvm.tsc_msrs_test.fail
Thread-Topic: kernel-selftests/kvm: kvm.tsc_msrs_test.fail
Thread-Index: AQHX4FK/jX90mdtgsE+Jjfu+VJsJjw==
Date:   Tue, 23 Nov 2021 10:42:18 +0000
Message-ID: <PH0PR11MB479200F51894E640BCE6F27CC5609@PH0PR11MB4792.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 419f4d6c-84c0-c504-7b31-4f880b0159e1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73cfd5d5-5a52-4e26-12c3-08d9ae6debfa
x-ms-traffictypediagnostic: PH0PR11MB4965:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB4965E94FCD5A95AF22FE0E8EC5609@PH0PR11MB4965.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlXl6jtmJtRXggimNOxMBYbX0Ukx8F6w+eXPmp7kuRpsJ1XJWEXMRq6Z+JEGU/5y/58jSQHNHZ641NtuStQOBBtIpJABKFggBxweYrQlSyMcyVnc0VogK9Os/Afxb5hM7hwXvxzQd7A4Pmher584raM5jh4J1Fxmk3YGF0aHGymEio9/qc0Cg2wMkVXgbbGH1XhBh2fYiwloL3zql1+RFLdMwA9IITj2/mkdOoi1YdVI0ztZflRsfPBfroeQEmjV8ttgt5BIXXJUhGVPBqNgdHaBF9p0pe1CFe3h6jGyTfFcfFJ/Z55N68Yrkr4tLMBOHYAmzoiUjXWluYSDNcbLpJY3p2sEajtGeCcyD70XCxoBGtUs984jc6+MmQFFk26UFJCzVigtTNBuB3oX92rWO0GWpCRwxWNY4fZE5tFd3++vJcKcKEorFqAr1dqnnjKKb2VNxKvfm10Xsf8Rv2hZxHP+5lbPTudIAppXQJLITMbrVqlR4gZi/0QzvZGbDx2WFHvCrwStMEremolwaVR/6MAuUkoS9HQ1YAmmVCmMbJGwMF0vAQYCK6TaR0Miw65/6aXUXDPNNiV/LBg199Two769+DPl7bmZ2OnMTGUO/OD7qpnkH6W1ICWueCZ8totanHTsE7tVxwR5PyXd98hYra/79009enjMtx7hB2oizps6XeQUjNL1zPpHW+Knv/HDfYFxjX7xPewLKQen4VrLKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(52536014)(4326008)(107886003)(38070700005)(82960400001)(54906003)(186003)(55016003)(33656002)(316002)(26005)(91956017)(76116006)(7696005)(2906002)(66476007)(8936002)(508600001)(6506007)(5660300002)(83380400001)(66556008)(38100700002)(122000001)(71200400001)(6916009)(9686003)(8676002)(64756008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P+tT5xT9Mbb558v/MKcrIrC8fCeETXlv7+voem3xFcc3MTP9bkQdThBzpD?=
 =?iso-8859-1?Q?oL5FSjxFM2HfWkGE3/OHEJRfs0Hr/1TbxK8d97JeSkG9T9L93SChuwfe7D?=
 =?iso-8859-1?Q?ouH7gCYfpOPXO4EF/Fdggcdohd8KSQMPVGiw4cXwEzfP8uik8fitBgWV6y?=
 =?iso-8859-1?Q?+UJX8OuYCBuOrmT8tmzGQ4/8Agq/DThbK5RbPxAgNt2GgMcWBS+Rp5U42F?=
 =?iso-8859-1?Q?W7laDskamaXB1osl9W6maAiLEOOtok3UzlwX/0JpaiSpIqiQL7EOWfTkYG?=
 =?iso-8859-1?Q?XP9dTDMUp8rAKlbg6KRi+Ia5T4qMSdUy/e12iyobXBKuL71JoY0RuMPtt+?=
 =?iso-8859-1?Q?67wbp4MZ64g887LT/XC7l4wDxljS4KLeEImjL8GqqzbK0kTZs539HL5VGr?=
 =?iso-8859-1?Q?/FaEiDIllQTyfquSk/kB5dzxHnZZFE7hBAdr3kBZzYuP5OPyxqpkolBIeT?=
 =?iso-8859-1?Q?q1kSj9ClDCR4+OXaM6s+oflJ8hKv+oG9XMfLB8mGzoK2m8U0HaA/Eew3cd?=
 =?iso-8859-1?Q?tKYMQlbr5Hv+xcDcKt9xqlmMMdTxjftC4K5cZ1SkvG5Nwv/bOVD/7UZeQT?=
 =?iso-8859-1?Q?Bz5yp5SrziO0WlXnzbai5+F/KmfYlnuvLqugom4cdZIQPcjPZimFpr9Zh5?=
 =?iso-8859-1?Q?wn6Kiwu8my41W592bLCrYEIMhHBZyZu5pac+OGKu1eknNlbZF8zEy2lA3U?=
 =?iso-8859-1?Q?WlLwF3MyOWurwSAcl3CTPru9YM1FLNRjPTo8Xlrp5iIwF+BFwUnzBcNcD8?=
 =?iso-8859-1?Q?gdhc5uzOHJAAibsG5ItsZBajkePOX0/wCFpTWNgDO6vuMbarIqBVGdukD4?=
 =?iso-8859-1?Q?iWNdp5MuLkvv7cyYy/wW4MKNfk2i9kRetpQ+UTbSLbrSJTAdxRw2AbuBbP?=
 =?iso-8859-1?Q?Huf0DRW7HBs4oh8d4vYd5Px9y10zv0HgJe3luyud38PsLRI+ldj88qoR1D?=
 =?iso-8859-1?Q?BXnqfCnOgiDwTHYsw69rHduPOOeMfTVkAVzXYGkAvMliFGGqnlmul8nMRg?=
 =?iso-8859-1?Q?pj8oKhdlms1lof3MsNtacDY4MuOu3oX61Fab56hi6qLHfdYhipoj/RmK6l?=
 =?iso-8859-1?Q?WC2u2FRHepFQ0foB2WEXjmc7J8idQbO4sbx04crVHbQTsccrPkmHZC3vQL?=
 =?iso-8859-1?Q?1YVfTb4zkA55w6hfAYWwG2BNtucFwwJ6h7kEir0bIqzIJpg5v/RBATU8u+?=
 =?iso-8859-1?Q?x4kATawMqrE6NYV0sz9975jBXwo3HyL2K89MHG7Oqd5a62JRcWqmV4HiZf?=
 =?iso-8859-1?Q?jz8/ozaaOUee/e2l1ddGWu4CCDiunTepOPK6WqiR6YQrWKMLj0qa4FZkhD?=
 =?iso-8859-1?Q?GSapya1mfSg27CAbBS3Y/XdXB8RHQ2WI1ZCkJ45ca5nAblpzieGMIQmrJF?=
 =?iso-8859-1?Q?TazJptMB67NMitBaPB5lRfe8r9kpXwCGJG/G9iZpHtJ3Mp6F2F3nZVfCks?=
 =?iso-8859-1?Q?k5qZDjVey51IHiD4uXKqQO9mSIywHydeY4kMmiDkSQgA5ZgT3RnQ0SXZQr?=
 =?iso-8859-1?Q?T0gUR2w2WgfH4NUNykYY1MwFA/uIq5EBwy7858rhSwsNTeW+qcCT5+ZcQ8?=
 =?iso-8859-1?Q?gfAK7h3p5VPdSpshKGup9Cj+IOyndtCLhR3YhLQ+UG/P2KYriSfQJEJf+8?=
 =?iso-8859-1?Q?llHOiQt15MI6crGqG9jOpIdxtu71TseBPWkxfoV7zfwCc1e7AUHSuKxg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cfd5d5-5a52-4e26-12c3-08d9ae6debfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 10:42:18.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sCPibO5OigTpyBUEVm7KUvm8a9yEf71PzzFSpzumLxWeuQkCMZMWgA6+GIcd7jfNdAzhMIFKzBhR9pPtcAb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi,=0A=
=0A=
When I do the kvm test in kernel v5.15 by "make run_tests -C tools/testing/=
selftests/kvm" get following error.=0A=
# selftests: kvm: tsc_msrs_test=0A=
# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D=0A=
#   x86_64/tsc_msrs_test.c:88: false=0A=
#   pid=3D10432 tid=3D10432 errno=3D4 - Interrupted system call=0A=
#      1        0x0000000000403168: run_vcpu at tsc_msrs_test.c:86=0A=
#      2        0x000000000040297a: main at tsc_msrs_test.c:150=0A=
#      3        0x00007f064f88509a: ?? ??:0=0A=
#      4        0x0000000000402a89: _start at ??:?=0A=
#   Failed guest assert: rounded_rdmsr(MSR_IA32_TSC) =3D=3D val at x86_64/t=
sc_msrs_test.c:63=0A=
#       values: 0x1200000000, 0x400000000=0A=
=0A=
The MSR_IA32_TSC register can not be set correctly in guest mode in some ma=
chine.=0A=
But MSR_IA32_TSC register can be set correctly in host mode in that machine=
.=0A=
=0A=
Although there are two CPU mode machines both support following function.=
=0A=
IA32_TSC_ADJUST MSR supported =3D true=0A=
TSC: time stamp counter =3D true =0A=
=0A=
Test passed in cpu mode: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz=0A=
Test failed in cpu mode: Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz.=0A=
=0A=
Add print code to check MSR_IA32_TSC value.=0A=
tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c=0A=
@@ -151,6 +151,7 @@ int main(void)=0A=
        val =3D 4ull * GUEST_STEP;=0A=
-        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);=0A=
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUS=
T);=0A=
+       printf("MSR_IA32_TSC: %llx, MSR_IA32_TSC_ADJUST: %llx, TSC_val: %ll=
x, ADJUST_val: %llx\n\n", rounded_host_rdmsr(MSR_IA32_TSC), rounded_host_rd=
msr(MSR_IA32_TSC_ADJUST), val, val - HOST_ADJUST);=0A=
=0A=
In test passed machine(i7-6700) set MSR_IA32_TSC to 0x400000000 and get 0x4=
00000000.=0A=
./kvm/x86_64/tsc_msrs_test=0A=
MSR_IA32_TSC: 400000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 40=
0000000, ADJUST_val: fffffff400000000=0A=
=0A=
In test failed machine(i7-6770HQ) set MSR_IA32_TSC to 0x400000000 but get 0=
x1200000000.=0A=
./kvm/x86_64/tsc_msrs_test=0A=
MSR_IA32_TSC: 1200000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 4=
00000000, ADJUST_val: fffffff400000000=0A=
=0A=
Try to set MSR_IA32_TSC in host mode in test failed machine(i7-6770HQ).=0A=
tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c=0A=
@@ -151,6 +151,7 @@ int main(void)=0A=
        val =3D 4ull * GUEST_STEP;=0A=
+        vcpu_set_msr(vm, 0, MSR_IA32_TSC, val);=0A=
+        vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, val - HOST_ADJUST);=0A=
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);=0A=
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUS=
T);=0A=
+       printf("MSR_IA32_TSC: %llx, MSR_IA32_TSC_ADJUST: %llx, TSC_val: %ll=
x, ADJUST_val: %llx\n\n", rounded_host_rdmsr(MSR_IA32_TSC), rounded_host_rd=
msr(MSR_IA32_TSC_ADJUST), val, val - HOST_ADJUST);=0A=
=0A=
The output show MSR_IA32_TSC value is set correctly.=0A=
MSR_IA32_TSC: 400000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 40=
0000000, ADJUST_val: fffffff400000000=0A=
=0A=
Why the MSR_IA32_TSC register can not be set correctly in guest mode in tes=
t failed machine(i7-6770HQ)?=0A=
=0A=
best regards,=
