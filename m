Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39119756167
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 13:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGQLTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQLTi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 07:19:38 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234871B9;
        Mon, 17 Jul 2023 04:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ/8LxVLI6mxcnNY+2paWNQYFs5/4Habm94dPNtpUY4=;
 b=TwGec4GEkTE4u1BTHZNGuGt8uzjanOl/8JMpJQtHsZDO8MA7SdzDMf19finWkw3FO19PHyStvchKpD1KolUpZMlhcAeEqzTyM9U7RIIj5o7jUodk7w3QdLuPpufrUoh6MLqxNy1mkau7yGKlRssz+FM3eq3QnvyqkMKQgEcDels=
Received: from DUZPR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::16) by DU2PR08MB7341.eurprd08.prod.outlook.com
 (2603:10a6:10:2f0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Mon, 17 Jul
 2023 11:19:31 +0000
Received: from DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4bb:cafe::a4) by DUZPR01CA0105.outlook.office365.com
 (2603:10a6:10:4bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 11:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT051.mail.protection.outlook.com (100.127.142.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 11:19:31 +0000
Received: ("Tessian outbound d7adc65d10b4:v145"); Mon, 17 Jul 2023 11:19:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af17f1b744e4c190
X-CR-MTA-TID: 64aa7808
Received: from f757e94d04d8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8A934DD7-E2E4-48C5-8FEC-B3BCAB61F8AE.1;
        Mon, 17 Jul 2023 11:19:20 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f757e94d04d8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 17 Jul 2023 11:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Phe6BFL4dsOU/jRcXt4xrSKBXu/LN4SypBqFnEBxYX1kHg5wsA//EgT4ccktmdkV7dkXYeGfb+RkJbNIB1NE5vFNPu0T9fGjh06kOnsczz5AvCTVAXH6kOsBgJxRjV1e3bVQQbWZU8cDA9ycptAigEPC0wo9tZvP8e+Z5S7npYDHKOUEtOCCh4O0ZE3LwngS5cdPITOx8HcADEKlJ4x4yRwq2ghNOYzE1iO16biUfycA8qKzB0ZV9M9O0QdjcvcGYe02k00zszlJbrX30TfXgGIZOOV5L26Q9FWWop3Ic4lgCV6qtesaueHTRANWmtf/hoUqPaBd3tMajeck/tEQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ/8LxVLI6mxcnNY+2paWNQYFs5/4Habm94dPNtpUY4=;
 b=A4tsaXPkHSYILALDIFc3i5Q6ktF1xoAKu/YhDL+vkWQrvwYpRsImW10m4rc+5MucXNfFM33cIG/9q6yAMOIIqVJhiSMpoOgtUoY7XqiSm6A6xlhui/JK4YbISJ6vZRe0a3i8BYGfdrzre/sshupcd9tcZtr49w3U7ifxXC44lPCRAtCTB7DXgdvS93rLmIOzJ5pRAF6DbajmnKaNgutLpLI5z1uhWdPX49v00q9JGk9i2I8KOAH0MXQhWZ/trQ92QdjqyzagjwDciBUxI9te37hge95e+Xnr1JGZohHpVdZ0pn29l6o/W99wkRDSHSvF7GxOW1qe6VPjPgwYay0AVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ/8LxVLI6mxcnNY+2paWNQYFs5/4Habm94dPNtpUY4=;
 b=TwGec4GEkTE4u1BTHZNGuGt8uzjanOl/8JMpJQtHsZDO8MA7SdzDMf19finWkw3FO19PHyStvchKpD1KolUpZMlhcAeEqzTyM9U7RIIj5o7jUodk7w3QdLuPpufrUoh6MLqxNy1mkau7yGKlRssz+FM3eq3QnvyqkMKQgEcDels=
Received: from AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 by AM8PR08MB6369.eurprd08.prod.outlook.com (2603:10a6:20b:354::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 11:19:15 +0000
Received: from AM7PR08MB5511.eurprd08.prod.outlook.com
 ([fe80::7cbc:264c:4117:6a88]) by AM7PR08MB5511.eurprd08.prod.outlook.com
 ([fe80::7cbc:264c:4117:6a88%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 11:19:15 +0000
From:   David Spickett <David.Spickett@arm.com>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
Thread-Topic: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after
 SVE VL changes
Thread-Index: AQHZtcYpaNEcPWFzOk2rqQzUt4IivK+91Ua0
Date:   Mon, 17 Jul 2023 11:19:15 +0000
Message-ID: <AM7PR08MB551161F243297FCBBEC0C6249C3BA@AM7PR08MB5511.eurprd08.prod.outlook.com>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
 <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
In-Reply-To: <20230713-arm64-fix-sve-sme-vl-change-v1-1-129dd8611413@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM7PR08MB5511:EE_|AM8PR08MB6369:EE_|DBAEUR03FT051:EE_|DU2PR08MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 26920520-3584-451c-d9cd-08db86b7b14b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: tFXsb1rYentgrvRrUMhGNfcEMkL6cVtHWzrPxbg54U6szTNFXdoj245HNVPQg8YHhLIPrKw0NLWIJNyFqUIJ+1z/NoIXzRajMH2YNA0QLGkl9Wx717oSXP/JTcMm7hP9aWVPgqJf00ncHq6Fgt6JWNO0AW4gOYYbg4hnPQUuvum6OmGOu82ynEELLujR4mDq/ciKIk9hppm71HTkJ7SUu5T02RQbY0Cm1PAP88lreXBClaJ7alz83fUEkinIaq699X8GuLvS85q32ETa/N23b6L3yIh2H/3rhD8aatD3BTD7uIDVc6enejqT/wjUuDfmdtSg3uGfBHcmeyznQ1tTyqPfDtXVsTQt7CRPCwvTWmEz87rDK1oTLvzjU9x18DvJIjiSCzfu92qjxYW/yPuUCAMkoo7wD0XPwPfdhtlFNHHhWw9VgoBXi1FwVj43gmlTugEV249Q78ywHWOC1Y/scby1zG91I1428C+Yqxbn9X11JfCFxcnIIvNweAwHwTHGp6NqCJ5M4QLMD2Qh4lajChYlzxMZqUCLzEX2lmh7Z2j6IrnPxT0kwzU86mfugoIJpejg3JHUxInSCCxP4u+iP1HDlohHsTlKiwnFEX+4v40nltkgbOTdn4DdUIWeQzy0
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR08MB5511.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(55016003)(38070700005)(33656002)(122000001)(38100700002)(86362001)(2906002)(478600001)(7696005)(71200400001)(41300700001)(110136005)(53546011)(9686003)(6506007)(54906003)(26005)(8676002)(8936002)(316002)(76116006)(66946007)(91956017)(5660300002)(66556008)(52536014)(4326008)(66476007)(66446008)(64756008)(83380400001)(186003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6369
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: dcd9897a-a25f-468e-d14b-08db86b7a7a1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aF8NZCohbAIYbrvad7HFKVAhMANQOtp1lpfvMKc8oOjTqCjAE+R4Y8/SaGib6mFxS61P5F0W6eAw7RcGnfOhlRPHgHCIKNgvP8LMUXb6n4U3AcdIp30pVlltmn5btOl/jxNbIMbFPiJPKenhrIn8svhkEt3pTJWXOPqAZQn1qbI5889FbGaZ/MhZac4/HOWkjFpOD0pYNMIMvPZKL+mvMae02p9ptwy6uD4Kg201ZdcXKMeh7RV41FdAhfcBBE1ozI11lmdG3ZdRMzWSMudYKyAha5NKR6QXM1BW0KH2t8LwdZa17hjgrnFFBC5OLZboomHPlaDNR16HDlRvmvnYwwAbBHKvjgjj8CW32ueC227+2mAKkiSn02Ns1CpFh93TxCqg80XgPdyJCbfYs1K05VgEq1dhsShx/uCtVc9egS8lsl8cBR08NYWSyqG3Boya9mL/g0gxDal4O7gAoD99Lb/LVOU612zb3HgcxoHK0vbb+eh4sadN/V0MZ55K8qsjjNKPkYWFxWMzqJ3AhcPPw9XMtFjJuIdlIaHlVMD/DHpPdgJK7o7gAceZ5aHCAeYsfgo+4oC4m+awVbHCJ+34JkocngcZUedeRI2CjgTvsQy4PUzwq9a0vTlKGvB1om6uXEUv4nyZRmbNvz71BMfzmqH9oLc5QyosmswoNptt07wPVFN9HVvGYF1MTA5T/m2AHIIPWcwxonliHIVaQ0N/A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40480700001)(36860700001)(86362001)(33656002)(81166007)(356005)(55016003)(82740400003)(478600001)(110136005)(7696005)(54906003)(70586007)(5660300002)(52536014)(70206006)(316002)(4326008)(2906002)(450100002)(8676002)(8936002)(41300700001)(83380400001)(47076005)(336012)(53546011)(6506007)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 11:19:31.4576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26920520-3584-451c-d9cd-08db86b7b14b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7341
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I've confirmed on QEMU and Arm's FVP that this fixes the issue I was seeing=
.=0A=
=0A=
=0A=
From: Mark Brown <broonie@kernel.org>=0A=
Sent: 13 July 2023 21:06=0A=
To: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon <will@kernel.org=
>; Shuah Khan <shuah@kernel.org>=0A=
Cc: David Spickett <David.Spickett@arm.com>; linux-arm-kernel@lists.infrade=
ad.org <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; linux-kselftest@vger.kernel.org <linux-kse=
lftest@vger.kernel.org>; Mark Brown <broonie@kernel.org>; stable@vger.kerne=
l.org <stable@vger.kernel.org>=0A=
Subject: [PATCH 1/3] arm64/fpsimd: Ensure SME storage is allocated after SV=
E VL changes =0A=
=A0=0A=
When we reconfigure the SVE vector length we discard the backing storage=0A=
for the SVE vectors and then reallocate on next SVE use, leaving the SME=0A=
specific state alone. This means that we do not enable SME traps if they=0A=
were already disabled. That means that userspace code can enter streaming=
=0A=
mode without trapping, putting the task in a state where if we try to save=
=0A=
the state of the task we will fault.=0A=
=0A=
Since the ABI does not specify that changing the SVE vector length disturbs=
=0A=
SME state, and since SVE code may not be aware of SME code in the process,=
=0A=
we shouldn't simply discard any ZA state. Instead immediately reallocate=0A=
the storage for SVE if SME is active, and disable SME if we change the SVE=
=0A=
vector length while there is no SME state active.=0A=
=0A=
Disabling SME traps on SVE vector length changes would make the overall=0A=
code more complex since we would have a state where we have valid SME state=
=0A=
stored but might get a SME trap.=0A=
=0A=
Fixes: 9e4ab6c89109 ("arm64/sme: Implement vector length configuration prct=
l()s")=0A=
Reported-by: David Spickett <David.Spickett@arm.com>=0A=
Signed-off-by: Mark Brown <broonie@kernel.org>=0A=
Cc: stable@vger.kernel.org=0A=
---=0A=
=A0arch/arm64/kernel/fpsimd.c | 32 +++++++++++++++++++++++++-------=0A=
=A01 file changed, 25 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c=0A=
index 7a1aeb95d7c3..a527b95c06e7 100644=0A=
--- a/arch/arm64/kernel/fpsimd.c=0A=
+++ b/arch/arm64/kernel/fpsimd.c=0A=
@@ -847,6 +847,9 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *t=
ask)=0A=
=A0int vec_set_vector_length(struct task_struct *task, enum vec_type type,=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 unsigned long vl, unsigned long flags)=0A=
=A0{=0A=
+=A0=A0=A0=A0=A0=A0 bool free_sme =3D false;=0A=
+=A0=A0=A0=A0=A0=A0 bool alloc_sve =3D true;=0A=
+=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PR_SVE_SET_VL_ONEXEC))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
@@ -897,22 +900,37 @@ int vec_set_vector_length(struct task_struct *task, e=
num vec_type type,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 task->thread.fp_type =3D F=
P_STATE_FPSIMD;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (system_supports_sme() && type =3D=3D ARM64_VEC_SME)=
 {=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 task->thread.svcr &=3D ~(SVCR_S=
M_MASK |=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SVCR_ZA_MASK);=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_thread_flag(TIF_SME);=0A=
+=A0=A0=A0=A0=A0=A0 if (system_supports_sme()) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (type =3D=3D ARM64_VEC_SME |=
|=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(task->thread.svcr=
 & (SVCR_SM_MASK | SVCR_ZA_MASK))) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We=
 are changing the SME VL or weren't using=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * SM=
E anyway, discard the state and force a=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * re=
allocation.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 task->t=
hread.svcr &=3D ~(SVCR_SM_MASK |=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SVCR_ZA_MAS=
K);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_t=
hread_flag(TIF_SME);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 free_sm=
e =3D true;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 alloc_s=
ve =3D true;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (task =3D=3D current)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 put_cpu_fpsimd_context();=
=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
-=A0=A0=A0=A0=A0=A0=A0 * Force reallocation of task SVE and SME state to th=
e correct=0A=
-=A0=A0=A0=A0=A0=A0=A0 * size on next use:=0A=
+=A0=A0=A0=A0=A0=A0=A0 * Free the changed states if they are not in use, th=
ey will=0A=
+=A0=A0=A0=A0=A0=A0=A0 * be reallocated to the correct size on next use.=A0=
 If we need=0A=
+=A0=A0=A0=A0=A0=A0=A0 * SVE state due to having untouched SME state then r=
eallocate=0A=
+=A0=A0=A0=A0=A0=A0=A0 * it immediately.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 sve_free(task);=0A=
-=A0=A0=A0=A0=A0=A0 if (system_supports_sme() && type =3D=3D ARM64_VEC_SME)=
=0A=
+=A0=A0=A0=A0=A0=A0 if (free_sme)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sme_free(task);=0A=
+=A0=A0=A0=A0=A0=A0 if (alloc_sve)=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sve_alloc(task, true);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 task_set_vl(task, type, vl);=0A=
=A0=0A=
=0A=
-- =0A=
2.30.2=0A=
