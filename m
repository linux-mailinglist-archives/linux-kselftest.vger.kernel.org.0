Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC14605FE
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Nov 2021 12:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357316AbhK1MBY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Nov 2021 07:01:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:47352 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344408AbhK1L7W (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Nov 2021 06:59:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="322059177"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="322059177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 03:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="652636094"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2021 03:56:06 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 03:56:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 28 Nov 2021 03:56:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 28 Nov 2021 03:56:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 28 Nov 2021 03:56:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRIf5Lv4qkhM7efZ+63WDf7MU79d4c6MCqCNZal1C6XGYdv2n4C+d+m4QZ5SH0PCJS4FAcoJiKeNVN+iqv/0okdO6pYOtG6yvE4xasQ6bFnTq78qjsBJm272+FewQ1w1lVaR1tOjEl63GIvYtimuBlBtskIqlP3w++wBc4Pa+NALaFU64IZ7z0/AjABSI/2CdOjEm4L8awaEflPQDWzKTGJEwQehIhslvL4uW7YrvbA+yUrblHkGA7TvqDOD41aFwvg7agiXLrgRPl5PCR5UGEKxH05eXG659qsOoV3JzQxdQVq/Uwb0/h9E8o2r0iHg/roPih6q22I8sj+0dOaOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZuRd1UKRkIaOAegsymZeohpvi78tcFecDr6/KV1hiI=;
 b=KZ2gqhlrZhukoO5HxvkbBWwc0xPT6w0dRSwuqAG4AaGujyTGZKOedEdEe5sm4F5h8l9FfHUeej+FuGYO/13jExxnM8I/+9srwCWRj1B3mVwYHBI6ngV0AwK8b3v5PRQf9EWLOZmmDKErxe92UcxWs7LngZSKvLpZTiFWpKDt1TKaH2PlOeLvcSHBsPDtkzHHnzPzoqH4MAe3VP77eOLQMptbZR9NBg3hzU+h3v/kP4aua2YNO/drvlvMXzE/cJNGglMOvd72k63IohstFPRiCnLnASLMPh9s0OgYXc9VpapN4HihPRLhA0loZbhUsyw3aqZJbrJmX5RZNN0+SPg2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZuRd1UKRkIaOAegsymZeohpvi78tcFecDr6/KV1hiI=;
 b=dSZ6iguO/z0YGqMm/mssYB3k2PXKCWydqicDAXUju/0kx6NX4BX25YUfHGA03du8wjlj77LhYrqqjCEe7ereD//I1dHP/anduc9mXsumhYWGl9XQ4k3r5+fRQbOotopn6uWWX/YqhZFeLeDNhPlzKRxfxfVDSN3elp/F4Q/u0ao=
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 11:55:39 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::a8e2:9065:84e2:2420%3]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 11:55:39 +0000
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
Subject: Re: kernel-selftests/kvm: kvm.tsc_msrs_test.fail
Thread-Topic: kernel-selftests/kvm: kvm.tsc_msrs_test.fail
Thread-Index: AQHX4FK/jX90mdtgsE+Jjfu+VJsJj6wY3Qc+
Date:   Sun, 28 Nov 2021 11:55:39 +0000
Message-ID: <PH0PR11MB4792A18466859A327DE68A6EC5659@PH0PR11MB4792.namprd11.prod.outlook.com>
References: <PH0PR11MB479200F51894E640BCE6F27CC5609@PH0PR11MB4792.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB479200F51894E640BCE6F27CC5609@PH0PR11MB4792.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 2c422346-2928-9437-b012-1161de238d76
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 855a1a8d-bcd7-4c04-622a-08d9b265ff81
x-ms-traffictypediagnostic: PH0PR11MB4997:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB4997EBE1A2E800E350D58E81C5659@PH0PR11MB4997.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvCh92IRM/i9KkWqMnvjvSRr7oe1GURc2VtKiMuGWmscD4UXVzl95VMbqYSximEjgCE48RD65cXyTc1CNRZw5HclzXDZuKUqtDGBwEXDEXKv69t+0aPtNEj6N+dtXWoqwB/snHVcIpGVymouDzvjCrIC2JZPcJsuLX5H+lMYbV0XysQGqh288VqGAEFrIzX0cZGZFacwewAfz8ZFa0kweB1VdbiTgakHhqDmU2/gftDhHiCpxuZz7EyS0qzoixJqywSo+2Wa/jEBze9RialRbq9hEp7ar8M9dhSN+GECm5xlOIP4JvFRogKlUWt8XjlmbtHaf2fUBa2y/SoGYbUDgr2l9AatfR6ksrGWsDVx/vos17ZEMC1wn6D0luxqDobUbtnfgFWR8UPflWw6TQgMll1+X7ZyWLSl/QoZ8aEexAKPXtDYBMXJhjgfyTzSeu4oXOOjzcaQPIKy4gEx2sc+obrcLTfL3J6i/9kksolvRQhdq7CViwpqcXqUx4IOJz4IPtDWUvZnM37zRGOjeHmXBQdophSzrABNdbEdADfbN8iZ8Y/NmEBrcdswL0AJlvaPWFnvuoZVMxP8VVoQDrsF5BVCtbI20ieayR+4tEhSvVFmbSZg2Z9nrcbCU003ko3UU4ys4Ez2lr/9WHUxSlHhr36e5v4jgRPSfEgBw8OEozsiB3PkkEPSCE1Afo1Jen9eNnrIA+v6uDta4I8/QlvRHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7696005)(6506007)(122000001)(66556008)(54906003)(76116006)(66946007)(91956017)(38100700002)(64756008)(66476007)(66446008)(52536014)(26005)(5660300002)(4326008)(8936002)(107886003)(38070700005)(82960400001)(8676002)(186003)(9686003)(316002)(55016003)(53546011)(83380400001)(6916009)(71200400001)(86362001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G37l761cmXLQB8nHfd53t2+pf8M5Kbki4gxBjSt/v8O3Ff6NNxNU00RUQfhx?=
 =?us-ascii?Q?4B8IyAsKyYO5s3CH3cxggGbupAGCaFY0Xf5h+sLQF8K7GZ3uNoGrwUJ/3z3/?=
 =?us-ascii?Q?C3gwB4TjRsS9E2FwJkRMYG8dnTNwerHb7Hrc/ZdGbNKibIv+N0vJiECSyDQ1?=
 =?us-ascii?Q?R7st+VCQ0r2TxjIxfk0cmuRWl2lp4B0FZhbzM85BGqlLJRopKjGQ3NU89JJy?=
 =?us-ascii?Q?JytgIUeKT0dIZMLOggFU2nikrohXrs4dFmCCek50MOgmbgRcU0aFZKrD+Pxe?=
 =?us-ascii?Q?OI1l6kQtdQyH7Zbov1bmvh4MxJdNADqgob0Rz/4f07mJHVPgrBD2AYKRhX48?=
 =?us-ascii?Q?9E6/NYdclmHkd64PnIui82yr1xSM0W1v9gZKT/nsOWdHBu79PcsqMmhziWEj?=
 =?us-ascii?Q?kwEZq8kpBLhhpU5y7rejDAOOo07w6ijcjOY941jXPwXfTku4iwTCfegf5S9c?=
 =?us-ascii?Q?UEke+8FMdo+8dQHo3fXzJ+7mDNmnKOODBMhtWrEJLpnceE0O30IQcjmT7HHb?=
 =?us-ascii?Q?pWdZTwmTRq4MjX9GP6NxwsNCYD3AWczC/rvnmSTGsXV0x4mngbbgdHz1lKeq?=
 =?us-ascii?Q?4ItdQUaPguuYXi5F4/IEgZ3XEFLiYMrgYNjIN1SZ1+ZxrUr52NJLpBRYg4Sd?=
 =?us-ascii?Q?vMotRkkTslbjTh23yGQaTk8EImWPRpoGhdrWj47VwsI2d/UIUNmKswVuoU/G?=
 =?us-ascii?Q?gUbYBKyie47Y2ZwzWqHB4UTeK5wuBpLgelFn2ayYbyZw/QLcLZMy0eG26QUy?=
 =?us-ascii?Q?CwS06rOOzC6tK1Sek8UkwHd99tCdgI+anYv7ZdToTKeh3/ybY3OWyNWabjv9?=
 =?us-ascii?Q?aAubZo604nv1inKKgSFqFgOzf0Ck53z3JoXN3bA1EM3N+/d1rb16pkgdGnM8?=
 =?us-ascii?Q?yTKJ/1+NyI5GMX1H/EPd4KaEFv38a5fGVhHRKP5it+8n/T9wzIkM693XrmR8?=
 =?us-ascii?Q?CyBEVp7+DyqmBDdGi0X4dpO8YzGLvTg48Yfd6FPsR2mg6fketR15EOfliSpH?=
 =?us-ascii?Q?9WmtkRuh5Pw8OAYiT/0oHT9QebjlfikoiLVp6PvGReZjIUfft+wMTUW9VqNX?=
 =?us-ascii?Q?gJetFiCxFBor3pO7b/o349s2EBykxFHbwiVfPjauJWOQmqfalhPHtNlNjLik?=
 =?us-ascii?Q?P6qC8poL4w4vY+s6U293CkKWGqY7PeES+S8eOBbwbf3jAWmVdGK0/B+lUN8U?=
 =?us-ascii?Q?MTTsgLMnq7JHuczg1xFrpAaHOXcwF7dn5qrZlRMR1zabF/HlQuqCE5ofUlBH?=
 =?us-ascii?Q?0lh9udwogVVUjieVNWYXGGDvH8BgiRX5o6aVlzG0+bTjU/rZOf+u1xj1gmGt?=
 =?us-ascii?Q?Hyp6kpQ9nNRDYGvLwhNHYuDONXU4eTdnwRcaC0WdWVycGSh7QHg8Jf239RxW?=
 =?us-ascii?Q?+KtHmP6d1FFP4RFTSYUGdwaNxuiv3DUlllNHbpN5Wx122nlIvTSrV9jzoAuO?=
 =?us-ascii?Q?/S7Q2fvYwpc/iN4kP16dluSkIwqyUbqIG8UQMs3w/Nlkc4eSw0d9OdAOnPIg?=
 =?us-ascii?Q?Nggapfgplx6qjFxGFExnuBaW8M+sygjy6rebENmQYg6Pm2/th/FLIf6Aaqc0?=
 =?us-ascii?Q?cus8QQf0XFztwFAi/r135Pfy2MYcfyL8PwYRubeRLYnq4i4D2mBI3OMgocu2?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855a1a8d-bcd7-4c04-622a-08d9b265ff81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2021 11:55:39.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQLcxiq7gSJgkyGrKUOHdWJBT1lzgsMZbozIK3y/4xhxIUkw+Xj0K3T1AdToMbXjRLOiMBedM457WaTAntDRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping

________________________________________
From: Zhou, Jie2X
Sent: Tuesday, November 23, 2021 6:42 PM
To: pbonzini@redhat.com
Cc: shuah@kernel.org; maz@kernel.org; ricarkol@google.com; drjones@redhat.c=
om; kvm@vger.kernel.org; linux-kselftest@vger.kernel.org; linux-kernel@vger=
.kernel.org; Li, Philip; Li, ZhijianX
Subject: kernel-selftests/kvm: kvm.tsc_msrs_test.fail

hi,

When I do the kvm test in kernel v5.15 by "make run_tests -C tools/testing/=
selftests/kvm" get following error.
# selftests: kvm: tsc_msrs_test
# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
#   x86_64/tsc_msrs_test.c:88: false
#   pid=3D10432 tid=3D10432 errno=3D4 - Interrupted system call
#      1        0x0000000000403168: run_vcpu at tsc_msrs_test.c:86
#      2        0x000000000040297a: main at tsc_msrs_test.c:150
#      3        0x00007f064f88509a: ?? ??:0
#      4        0x0000000000402a89: _start at ??:?
#   Failed guest assert: rounded_rdmsr(MSR_IA32_TSC) =3D=3D val at x86_64/t=
sc_msrs_test.c:63
#       values: 0x1200000000, 0x400000000

The MSR_IA32_TSC register can not be set correctly in guest mode in some ma=
chine.
But MSR_IA32_TSC register can be set correctly in host mode in that machine=
.

Although there are two CPU mode machines both support following function.
IA32_TSC_ADJUST MSR supported =3D true
TSC: time stamp counter =3D true

Test passed in cpu mode: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
Test failed in cpu mode: Intel(R) Core(TM) i7-6770HQ CPU @ 2.60GHz.

Add print code to check MSR_IA32_TSC value.
tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -151,6 +151,7 @@ int main(void)
        val =3D 4ull * GUEST_STEP;
-        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUS=
T);
+       printf("MSR_IA32_TSC: %llx, MSR_IA32_TSC_ADJUST: %llx, TSC_val: %ll=
x, ADJUST_val: %llx\n\n", rounded_host_rdmsr(MSR_IA32_TSC), rounded_host_rd=
msr(MSR_IA32_TSC_ADJUST), val, val - HOST_ADJUST);

In test passed machine(i7-6700) set MSR_IA32_TSC to 0x400000000 and get 0x4=
00000000.
./kvm/x86_64/tsc_msrs_test
MSR_IA32_TSC: 400000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 40=
0000000, ADJUST_val: fffffff400000000

In test failed machine(i7-6770HQ) set MSR_IA32_TSC to 0x400000000 but get 0=
x1200000000.
./kvm/x86_64/tsc_msrs_test
MSR_IA32_TSC: 1200000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 4=
00000000, ADJUST_val: fffffff400000000

Try to set MSR_IA32_TSC in host mode in test failed machine(i7-6770HQ).
tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
@@ -151,6 +151,7 @@ int main(void)
        val =3D 4ull * GUEST_STEP;
+        vcpu_set_msr(vm, 0, MSR_IA32_TSC, val);
+        vcpu_set_msr(vm, 0, MSR_IA32_TSC_ADJUST, val - HOST_ADJUST);
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC), val);
        ASSERT_EQ(rounded_host_rdmsr(MSR_IA32_TSC_ADJUST), val - HOST_ADJUS=
T);
+       printf("MSR_IA32_TSC: %llx, MSR_IA32_TSC_ADJUST: %llx, TSC_val: %ll=
x, ADJUST_val: %llx\n\n", rounded_host_rdmsr(MSR_IA32_TSC), rounded_host_rd=
msr(MSR_IA32_TSC_ADJUST), val, val - HOST_ADJUST);

The output show MSR_IA32_TSC value is set correctly.
MSR_IA32_TSC: 400000000, MSR_IA32_TSC_ADJUST: fffffff400000000, TSC_val: 40=
0000000, ADJUST_val: fffffff400000000

Why the MSR_IA32_TSC register can not be set correctly in guest mode in tes=
t failed machine(i7-6770HQ)?

best regards,
