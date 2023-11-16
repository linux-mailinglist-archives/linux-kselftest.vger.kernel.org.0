Return-Path: <linux-kselftest+bounces-190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDF7ED9E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697E2B20C88
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87B63BD;
	Thu, 16 Nov 2023 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="di1eErC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2093.outbound.protection.outlook.com [40.92.74.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3257199;
	Wed, 15 Nov 2023 19:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAZ5PmXX9jQ72BT4FkaA7XE80UVjxcc329YuMsJaJuqRxVvFg9AWuGDrrG9q5Uijp4KMn9lN6wDL8RfUk0iA86KQBzQVop6mdZHwfN203BXoPyiBsmOApxsvHLpS1nEB2dBPburbZPLYG4NjxuuoblvvmbelAQGUg3RNpqLhHoZsyyj3qQOsOz8yXLvKBhk5UI7KSYTfljDeJbACbAHrd5s7nLRVcIpvKCZZFLarSrng1ndk87b4B4NSSZ7SinrrB5NXjpSkjqYejxi/1iVLed+VoOLecUWOgFkx4IMJXE66H0MBhhXDIqTeBm7iTWF2jZ32fU3eMvgn9F04jYXDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ItYPg33DmUFNe2euMC6cf/7ytVgkAoH8Lpbj5FWP4U=;
 b=D3fnUuhslIAkgX8vanVhby66n/PvmydAC3ZXIFGLi99bkzQRybil1bFlW5OuUFMi9o5glBhqTKxTki5aUxEVwGzRu2E+/Vx6oi6sHCXts3h+THeabStUpSEjZB/XcTZ21PXipD9NbWSvGv5u4qg7zrH/2E1K2vTR2J+bXoY5kQOT/AkiQS/TtOlmvsTGeFrJITq3geetnumq8iytsssqvx/fceVHmEGjwJwVqj6uxc1C0bip29GxlFWS+5S2pq1zTVm42HGWRo6uSyE/AphDAclC0EVoTAHNbxmdiyeQ+ELPp/nse3XyddFS3fdNpqw6N/uyY8UOni6ebICgv4m4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ItYPg33DmUFNe2euMC6cf/7ytVgkAoH8Lpbj5FWP4U=;
 b=di1eErC3dAVzhGTChtOD0HYUwYVcGj8hZ98oovpr+3Ra5dlfQWjbvr84RIbbTvrPvpFZXZRPBxqnOONH6QhEqvyilyLyRDOkifrQnLIvx+hgdecbzgEOGy5pMkHd/d4zeqHTHv8lqjTlq/2ayj+N3VLGxp0egeRZjhV+kP8h1U4+RRXUK3IkqJ8K5WcU4IKKT78XwyPx6zFL2C//DhEEg1CakKvSD6Jd3QxWhtQq8wZHLpph/g1NaqFRHU+xZ713rzyg2RbaJiSVKTXoh0co3hg7xKJ+saRTsMXIo1oCdUn8FRf6M71SdTEfPzQZ+5p0ie1kJ6TSUbSBhI4PKfSmWA==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS2PR10MB7227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:609::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 03:14:47 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 03:14:47 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next 0/4] selftests/bpf: Update multiple prog_tests to use ASSERT_ macros
Date: Thu, 16 Nov 2023 08:44:15 +0530
Message-ID:
 <GV1PR10MB6563FCFF1C5DEBE84FEA985FE8B0A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [O0aQZ4dmxRJVg2vVkhqN9kEitbWQ+Z+u]
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231116031415.70401-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS2PR10MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee0e384-e2c6-40b8-9e23-08dbe6522f67
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rxFQO+tAlWq6vJiXq2A3ETqb+UJi2xefcEfT22Zy5Lro3i37ws800iEGnHL2BGXFH0cxKE4gpgSpUUxzvlpK2YyvAKDVbx56hiSgdtN1B1tqkzixihZOqvdDNpj6vmCBS5R8wYxREveZTN+g9Lpv4J4JacbZZiR49HxkyjZCDC8BJI4brPpFH/B4dnWkUiO0SwUEOGv5CmhmZQgGan1vzkfXyOnOd6wIAavDXM2vE+gzJXLc6FlpE+PA0Q+c61FFyvoTpY1gBGFh5FidaifVQ3HZ6m1Y/504xuUnOCPf2Fi9xU9epwVg9rpOBViBNVt8gEsapwtwUuqdMVKtA6nZsBupVTDu5qwb4KgnP/q3KqiIMCmggJ2fNMmhPKBghQpopmxlKskO8aufd0l3R8/AuOv2In2e0BvOrsFfBKuKyQYh5sosAU4xaacuHbaWaJ2Gicgpg5+7DWnSV8wbnBjW4BFYeTizgQ0/dOmIBaT1kOjzyAToUpPtlT+2XABdggV/Fna6oPfT26crrm6Kc+/zzBbC5SN3h3Ycmf+se7ub7G5bszGnkLLmshj8w7RhT00hdc6L7x0suosXFWsYBAViKTVr1SwSlxF202pGXK4Tu5v3SOrzgzijiSnDK1K124I1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tI/FnxaC+DO95UcbcN1zQ4r/3VmGjMbmxxpLMQzqk4tIFR2Nd0bwvqSpoA8H?=
 =?us-ascii?Q?I3V5a+qkc9+zeYD2ESGdndyz8PiGxbqA8WJQloj0ubqX//raMuycz65761oM?=
 =?us-ascii?Q?3GQyRKxJOGGeiN50MqQBSGoLuflZ4efKixiCqVDl9KE/QKyPliiUC+JUuj7n?=
 =?us-ascii?Q?6vS/FVbjkrprrrLBZah1QuV67daQ3qnQbh9PBWZu0K77HQGNc1dtWSsIdjKr?=
 =?us-ascii?Q?9k3G5W4uEjdT3kophV6XYPAMNKIEfhzMdl3JZmNrjNpxkWNO/IfLdL4XBQVF?=
 =?us-ascii?Q?0S4iYvmBr5GYPsiKoV5U/2xx+2vO+rsjgM/7X/58zpW29aj/qjPyiFXCAJxV?=
 =?us-ascii?Q?M4tsJJPDWwD1mH74E7PHix4elmau1iY9qPIGZdoLIh5dhGlhSUMIWeloa3vp?=
 =?us-ascii?Q?Kvn1tSXySxgSBwJir3lyLVzvhoMWnsTe2ag7RDvg9COCM3BilSuAA6z7Cewe?=
 =?us-ascii?Q?b+M1OZgXr71k/z/hCkQx13sfgqi9C4lrED3mNxO/Ere41Y3DPnL3WqMrITJL?=
 =?us-ascii?Q?e0hYTiOrQVD5ouVqIrUZ6nRbXqtM3WSlyQOjCoI6JcwvCfUnt7bRWH3JR4hX?=
 =?us-ascii?Q?9IIHEYvIpyvC/PgAMUW9n3NG9QtOGUa7b1dvSoosMeE6P8WHR1T7sqE2tPRk?=
 =?us-ascii?Q?dsySbXihZtiKQ76ShDShUxoiPh9E4oQIpOXPks0W1h06+SRZZmKPrw7kgurp?=
 =?us-ascii?Q?ibVOMNl7Gh+j5g3vxjouMetS6cVE7QY8XL9BmaERSaLY9wqP6oEOGw0EV1fc?=
 =?us-ascii?Q?wBkhV59Y73Au6EEQYiv6Za2piwIdc1Z3fcDHVsKXM/FP+6z2LP11FHJMeHf/?=
 =?us-ascii?Q?K/PdnybpuIuWD0vmufNv5JIU/ZHrlpXdMRj58rpfXW0tG49zxEa1Xg6fl6Gg?=
 =?us-ascii?Q?pGazNAzEOIt66CsaFz32MNsdxxyBuFPSlHr1PmrNy8VcJYp9a36ht4hOgwgA?=
 =?us-ascii?Q?r+wqwBOCMt1PDTns1X773AhypNaznfXJEGJCXNrGEcKV192vFmU897qaIS7v?=
 =?us-ascii?Q?ls3HA+CbWzLKu2wQPreYFmvo+aYrIPHL6ZFivTsEOqazKCgvBuMveZP9BZam?=
 =?us-ascii?Q?mkDip4ppjwWy5qiBHAtjHcF/34SJ4ArT0PzgZFst6H+y2khvg4MZADcCSc8m?=
 =?us-ascii?Q?KdAkiV6FYgr6oc1SNJPUVL0t8gkoFLzn5lgoNM7Gcb25Lk7RWMtjG3dQ66TX?=
 =?us-ascii?Q?w49dLNnyEpaSoESNWyLTqrOafx1uUOe8a4HX0YB0cV07N/pdPB4OVWaRvwQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee0e384-e2c6-40b8-9e23-08dbe6522f67
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:14:47.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7227

Multiple files/programs in `tools/testing/selftests/bpf/prog_tests/` still
heavily use the `CHECK` macro, even when better `ASSERT_` alternatives are
available.

As it was already pointed out by Yonghong Song [1] in the bpf selftests the use
of the ASSERT_* series of macros is preferred over the CHECK macro.

This patchset replaces the usage of `CHECK(` macros to the equivalent `ASSERT_`
family of macros in the following prog_tests:
- bind_perm.c
- bpf_obj_id.c
- bpf_tcp_ca.c
- vmlinux.c

[1] https://lore.kernel.org/lkml/0a142924-633c-44e6-9a92-2dc019656bf2@linux.dev

Yuran Pereira (4):
  Replaces the usage of CHECK calls for ASSERTs in bpf_tcp_ca
  Replaces the usage of CHECK calls for ASSERTs in bind_perm
  Replaces the usage of CHECK calls for ASSERTs in bpf_obj_id
  selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in
    vmlinux

 .../selftests/bpf/prog_tests/bind_perm.c      |   6 +-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 204 +++++++-----------
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  48 ++---
 .../selftests/bpf/prog_tests/vmlinux.c        |  16 +-
 4 files changed, 105 insertions(+), 169 deletions(-)

-- 
2.25.1


