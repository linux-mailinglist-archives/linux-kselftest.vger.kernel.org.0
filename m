Return-Path: <linux-kselftest+bounces-2677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00B825EF3
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 09:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9561C21430
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA872522B;
	Sat,  6 Jan 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BURNqnRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qr0C+1pg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41963A8;
	Sat,  6 Jan 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4068o6qj008409;
	Sat, 6 Jan 2024 08:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=UaaMLgAHMcw3fpUZxWgDrI0pAaVnYHjE4vMjVkDsCvY=;
 b=BURNqnRcOP9q4ThqTlEfrPZGFRnzccQH0omYvDEmxcfLFPCkFRcmG/xwzoQ5pnEirRu7
 exXdjQYZXlg0NkDZes8imfYI8OoaHIV/6yogUS95Cm0XcCqAbG0KBKpmNBZUEsSnAafo
 tLEMb8/YFGYiLoQBq2kTicSAZ4buMOKJyknycrAtrYi+LalhosZ3NrTVbwWxT1vjxFcm
 CgmMeRhoCYb3oKNhWNd5+XnH4idIrazct29SgW1NqVLeBDAWdZ9RLAIu0OpopfscQRZz
 USBj6Fj9/75XzWSdnJA7tz3gaGwmAhHQ4c8QWGgjyP1oR1OfwCroqVBpZ25RGbNIYVq5 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vf3pjr017-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 08:51:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4066XhnP035025;
	Sat, 6 Jan 2024 08:35:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vewa3uft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Jan 2024 08:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goG2cHTXsp+zuUlVBujVcHvQ5vqklnP6VvqS6ZHix+2A4Lt/GDqf/I9Ey+1xG7yYsp6BCAlE8fpzKkzV5zs6PboeGs5E4iRljvyOmJK9pnZ8QyAFGkw7/OV2xs18d1/tH4L63M+DwE0gCHVlErNawWB/iOvEFFr/EJgdV01h1SvLdIn8wPcuZFCyxySsqdvYUHF4LECUeArD8ioF7nzY3KSFToTSBA85EN5jmYEsvrZtwWGOtlR4nEEF68Y+p+oatK6Tvc0xtLT1hgf3rk/PUPf3XJnUYDjtS6Q4DEzFE3H2XvFn/WItDEHu1gn3pan/D4zoIOso/2UGMbe4/t/O7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaaMLgAHMcw3fpUZxWgDrI0pAaVnYHjE4vMjVkDsCvY=;
 b=fVxfZIAXZ1U+DWDlXBgQQEsMbXqbsYbJKe2XnPLYvkpwRiMCakVlj/WLVmqrQISZWPu1R/5ATeYV2A3R2ik1CYYIwwS+snm7fHhTRYJXM3doDFqUqg9tYKlYnDCu6IxSnKEarkH/m663Ctuw3RbmH5L+yLVDRkcznyCHG1mMMdOu8BqJ2u5pLVI6c1+Vdhm5aZk0KO/H9qbAn6V2vI1jwGPhVi1cZVPABxQOeRKCqcsmGrl/sao7pT69YjC7yxCNoVFG+jolU0Q7ZtTC9BoeZvHhvcE7pFSttryc1Vk1bZoFuWr1Y1dadCcb5poGxKJOlJKnqCiSIFl7gV7AL1RviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaaMLgAHMcw3fpUZxWgDrI0pAaVnYHjE4vMjVkDsCvY=;
 b=qr0C+1pgab5TDGWoPSb9bzgtTn8c/2XdEa5JU2tMFNZNMlUq2RUKc1lXjzhBKVAAUu5eb48HpIn/UH4VggxZ0Fo/G0mShA7k7Vb2O2VhljMyF/PlC5Dm2Erek/Vk7wm8wIzn56hB8a5DqKRNSnn+eK5xfmnIdO1TkA2lq1CYVWI=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB5284.namprd10.prod.outlook.com (2603:10b6:208:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.19; Sat, 6 Jan
 2024 08:35:49 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a1c5:b1ad:2955:e7a6%4]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 08:35:49 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH 1/1] KVM: selftests: add kvmclock drift test
Date: Sat,  6 Jan 2024 00:33:46 -0800
Message-Id: <20240106083346.29180-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BLAPR10MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7b1e49-b72b-42d7-6a7e-08dc0e927c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fDY7SA5HZ3tiJQbpT62qrumjLxPXCI1y2GVwtpddlfJGH6sy77t62EvqikmkZ7+PJl/X51SXKsWFw2qAqWPVLvRohVliPYTynrjJgxoyOTlJ8bJajjr/LBBwIuCEWDcJXZRyWarSNvQoDmeYJIArtdEYjPudNvt8UwHmcD3J2VZnTnQt72PWpHd3e4+dinFQW88H2dWZAjhK+qWQ1YyKqZT+TSfWkIis3h8zo3WZwxPCuyL9JeepDStTI4Xr//ew5GPmA7ZPev4YFZvEY2d1ozLoH88hqFWPo9o/0EJdJ01TmFusrzljLPfA5uiFUtTeb1VpZdk/bQxs+tYTYQyqvkVmCUFEEVP9UYWlvx847cu7rRIDrQ2BWvZ6H3ocaKmnbvUg0vW4AFEhHtCzonSZm68bkg3oyzqujOTHzesoTpieCVvGsu7YnJMHo8dhiTUBRTc3cnvx00J4VjGbDPIJq6ygrHEbVwHnnO22VXJdWVGxd5NSKpCGupDR+crwJ7dxX8E0KfGZPto5UfZk/1ETU8gOYr2GCG9RC/R8U02ydpEkOcw3YkjnmhWUCI3znq83
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(107886003)(2616005)(6506007)(6512007)(83380400001)(26005)(1076003)(41300700001)(6486002)(86362001)(4326008)(316002)(8676002)(8936002)(5660300002)(2906002)(44832011)(36756003)(66946007)(66556008)(66476007)(6666004)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/bSuaWTKpRG72kpyWNBzVdh2mU3FwL+toNx6pbqucM3AiJ7bAdN3Az0WyVlt?=
 =?us-ascii?Q?rRyWrbfw753BtEPvu+EIL4x9XXuo98F0Dnf0ikSXpOMn8yAjBrUU1cVLmWMD?=
 =?us-ascii?Q?XI8iU7MOfBAYY5jkMSvNzEQ71ihc80JN/GgD6zgkRKyq041lae6d5rHmSxKj?=
 =?us-ascii?Q?Ku6Cg02PCkxhGEBDbkUVSceuF+xUt+IqVjvBLtHZlt1ldP1Eb1soV8xJy7K4?=
 =?us-ascii?Q?1tne7suMIeCR60LCQwMoglRNrv9jRtLaqySdKD6hhScBp8a+kZxdrHMdQGax?=
 =?us-ascii?Q?IFJA18ovsbE+lmG1gPc/6BX82doCQA2SCctdgoplbbUAC/DLSDfrQDGSL6zs?=
 =?us-ascii?Q?s5bJ9QJLnccjKLWgYxEskefw7YrgdTGJk8KD8eR1o+ePAEQYilGkFkHEQzb9?=
 =?us-ascii?Q?d2Gr4btO77sRfzXZcFZZTJ090Rg0AlFYPiFjAy+NHLpJvBds2cP8L35zqoxW?=
 =?us-ascii?Q?NcwZWDxGu6rljfwFvTxuWS0eyNvvEIo4BqlbC15lS6TRKyitBJ7+UyIaOYUN?=
 =?us-ascii?Q?LqlyAVsJsZy/1z+Ri05F6xoKEM9WwcHUwYnadEgv/sf+I6sYmY9gohFwy8W9?=
 =?us-ascii?Q?+77nhT2jVlJsq4aBwsx87CwsQLvdN4HiCiqW42ehUDfA9FtH7IwLJCzPUc2h?=
 =?us-ascii?Q?lWSopdZklHSv1mgKpOpIfVmEMd3JVO2HBNiXL7oaIFKFlZAF4bSwC2dZpZRi?=
 =?us-ascii?Q?qKDRD8sbaUrphzxqErEo2/Q7Rrye4sLh7oZewenw6AUvOHbgoUBLdfKUtx8Z?=
 =?us-ascii?Q?rpBw6V0do+F8yc7j1xuQOOanZ/V3D1QcdPVKeZ3yFNKmOFiyazZQd3DVqHGD?=
 =?us-ascii?Q?AXJUsvFjH2BL8OCMZT65TBiusRMzSYuJ2qWWCXovORSFToat1WNc+FUJbI8F?=
 =?us-ascii?Q?h/12h4RXtCiPd3Qxz40ZZuUZcUZhSL8HFtNiiTIj05r+mrorWY1saqctVjvy?=
 =?us-ascii?Q?ac3lq/+hfENKCSRKpKt5UWO7sUoXtxvYnFV/bvGoy+BTY7SB4OxDqi67FsM2?=
 =?us-ascii?Q?2FevE3Me7BNzxA/81Giz0rYj5aMcmIzqbpNC2To8fiPnAMy3xme3FLZDmXlB?=
 =?us-ascii?Q?le7VsYxyRhGoghnp8Wi1+0HGDzVqVr748DXD6sJDoL5scGPhqRlGh6HdGJ7y?=
 =?us-ascii?Q?hT18VC3qgJhZTihi9id/8f2EsEDU/SahHrqFnhjHAojltc35YxMt9Ar5WVji?=
 =?us-ascii?Q?qwVw6VeHDs8F/4X6aKfOdOBYY/PTD502tslhNd2vm7eXWV51JSpvdM3AGOMi?=
 =?us-ascii?Q?6xX+8K9kdJNJOmaC3achHfG8lWphR52WEKRdxvAwnAJrjnR5MJVvu+E9jstn?=
 =?us-ascii?Q?gXxkgscjEAmueZkQV1PZ+hPE5P2nHE4PTjKJg3V1eIYbtZA+NiUDM6pm9Ogg?=
 =?us-ascii?Q?yu8vAabAykD9OOqIeSkZ/7ESWjsQwytjrvstraKnXSc7qaOlGIC0b6vd2CqW?=
 =?us-ascii?Q?meTplGWGENQm3vCODJW+P5nBTEBbWIz2JGGzojHwPQdUsgtCINP7Y6Mcf6+y?=
 =?us-ascii?Q?F52SXERQdeFj0Vj65dlJTAyYlAkY5D0Puc/JAlB657VYWYmR0eshQLjwVVum?=
 =?us-ascii?Q?SRyX/R+QhzhpZtbJLp45AqSlWcHSGYLH6pP2SLW6qK7TL+z4Ga/moTO13z/m?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yvVobeyAk0CYpM00e4az67FycbHfA7IO2dmDCcvBhJlTFWaURC27g05Kl0awvZ1Cyst61xbyg3YkHGDDFUURz6Gm3dc4MDRMEHdKxlqS3iEe5ATFxBEqLOBsiroRJmck7CeDSFN/D35yzIsUL4YY4845Q53igl9vkjLlritfv6CNGZRTSODR23dnVFoj16x2EvaH0omba2atHkPZtzTOp+qqK8fgejv52rb6mtb14UCO6jYjfBCAdltfFIC4CX/hC+z3rgf23puSzX0vXf58yY8ij/yhlRc9KUQ+bv70l6JPq4ojTEfpi05nB0MVbKHQPcv2Ux0OHQU7jrFpZPnHAU8CPgIHiKgmoVAXqSJpvKIj7bsu2fbv5utGLTA/NXsZU6Lhpsg7prwOOGg4D6wGLBlR0Jh/CmZ3+pkCn+ghLiiFfQ/OpzpOUz+DsON3BcawuM/akGDY/k5quEGXtNXk7anHtmQTX5PUUy76oZMpGlel1vS88Qm08GZQXbgdqHKtX6JENerqFfoFPnRnShuESer9Zqxd7Vlcs/3WD92mndgsocqgAY3E+RKQCX6AsQRgoMqbephD1/Hyvus+fjTGFdS8M5rsSvzAAM4RRfuh4wY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7b1e49-b72b-42d7-6a7e-08dc0e927c0c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 08:35:49.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTiB0j4pq///0mNwZRStr3JQ13aynFgi0SlxYDw4NqpFQngnc06zjPubAdNXB6c26ifxCfn7uf6rt7fc1ua2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401060059
X-Proofpoint-GUID: iIFJsy4bjSUrYKr8QKe-TF8gH3e6JaPa
X-Proofpoint-ORIG-GUID: iIFJsy4bjSUrYKr8QKe-TF8gH3e6JaPa

There is kvmclock drift issue during the vCPU hotplug. It has been fixed by
the commit c52ffadc65e2 ("KVM: x86: Don't unnecessarily force masterclock
update on vCPU hotplug").

This is to add the test to verify if the master clock is updated when we
write 0 to MSR_IA32_TSC from the host side.

Here is the usage example on the KVM with the bugfix reverted.

$ ./kvm_clock_drift -v -p 5
kvmclock based on old pvclock_vcpu_time_info: 5012221999
  version:           2
  tsc_timestamp:     3277968
  system_time:       11849519
  tsc_to_system_mul: 2152530255
  tsc_shift:         0
  flags:             1

kvmclock based on new pvclock_vcpu_time_info: 5012222411
  version:           4
  tsc_timestamp:     9980576184
  system_time:       5012222411
  tsc_to_system_mul: 2152530255
  tsc_shift:         0
  flags:             1

==== Test Assertion Failure ====
  x86_64/kvm_clock_drift.c:216: clock_old == clock_new
  pid=14257 tid=14257 errno=4 - Interrupted system call
     1	0x000000000040277b: main at kvm_clock_drift.c:216
     2	0x00007f7766fa7e44: ?? ??:0
     3	0x000000000040286d: _start at ??:?
  kvmclock drift detected, old=5012221999, new=5012222411

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/kvm_clock_drift.c    | 223 ++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4412b42d95de..c665d0d8d348 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_ipi
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_tlb_flush
+TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_drift
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
 TEST_GEN_PROGS_x86_64 += x86_64/monitor_mwait_test
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
new file mode 100644
index 000000000000..324f0dbc5762
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/kvm_clock_drift.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The kvmclock drift test. Emulate vCPU hotplug and online to verify if
+ * there is kvmclock drift.
+ *
+ * Adapted from steal_time.c
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ * Copyright (C) 2024 Oracle and/or its affiliates.
+ */
+
+#include <asm/kvm_para.h>
+#include <asm/pvclock.h>
+#include <asm/pvclock-abi.h>
+#include <sys/stat.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+
+#define NR_VCPUS		2
+#define NR_SLOTS		2
+#define KVMCLOCK_SIZE		sizeof(struct pvclock_vcpu_time_info)
+/*
+ * KVMCLOCK_GPA is identity mapped
+ */
+#define KVMCLOCK_GPA		(1 << 30)
+
+static uint64_t kvmclock_gpa = KVMCLOCK_GPA;
+
+static void guest_code(int cpu)
+{
+	struct pvclock_vcpu_time_info *kvmclock;
+
+	/*
+	 * vCPU#0 is to detect the change of pvclock_vcpu_time_info
+	 */
+	if (cpu == 0) {
+		GUEST_SYNC(0);
+
+		kvmclock = (struct pvclock_vcpu_time_info *) kvmclock_gpa;
+		wrmsr(MSR_KVM_SYSTEM_TIME_NEW, kvmclock_gpa | KVM_MSR_ENABLED);
+
+		/*
+		 * Backup the pvclock_vcpu_time_info before vCPU#1 hotplug
+		 */
+		kvmclock[1] = kvmclock[0];
+
+		GUEST_SYNC(2);
+		/*
+		 * Enter the guest to update pvclock_vcpu_time_info
+		 */
+		GUEST_SYNC(4);
+	}
+
+	/*
+	 * vCPU#1 is to emulate the vCPU hotplug
+	 */
+	if (cpu == 1) {
+		GUEST_SYNC(1);
+		/*
+		 * This is after the host side MSR_IA32_TSC
+		 */
+		GUEST_SYNC(3);
+	}
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_ASSERT(false, "Unexpected exit: %s",
+			    exit_reason_str(vcpu->run->exit_reason));
+	}
+}
+
+static void kvmclock_dump(struct pvclock_vcpu_time_info *kvmclock)
+{
+	pr_info("  version:           %u\n", kvmclock->version);
+	pr_info("  tsc_timestamp:     %lu\n", kvmclock->tsc_timestamp);
+	pr_info("  system_time:       %lu\n", kvmclock->system_time);
+	pr_info("  tsc_to_system_mul: %u\n", kvmclock->tsc_to_system_mul);
+	pr_info("  tsc_shift:         %d\n", kvmclock->tsc_shift);
+	pr_info("  flags:             %u\n", kvmclock->flags);
+	pr_info("\n");
+}
+
+#define CLOCKSOURCE_PATH "/sys/devices/system/clocksource/clocksource0/current_clocksource"
+
+static void check_clocksource(void)
+{
+	char *clk_name;
+	struct stat st;
+	FILE *fp;
+
+	fp = fopen(CLOCKSOURCE_PATH, "r");
+	if (!fp) {
+		pr_info("failed to open clocksource file: %d; assuming TSC.\n",
+			errno);
+		return;
+	}
+
+	if (fstat(fileno(fp), &st)) {
+		pr_info("failed to stat clocksource file: %d; assuming TSC.\n",
+			errno);
+		goto out;
+	}
+
+	clk_name = malloc(st.st_size);
+	TEST_ASSERT(clk_name, "failed to allocate buffer to read file\n");
+
+	if (!fgets(clk_name, st.st_size, fp)) {
+		pr_info("failed to read clocksource file: %d; assuming TSC.\n",
+			ferror(fp));
+		goto out;
+	}
+
+	TEST_ASSERT(!strncmp(clk_name, "tsc\n", st.st_size),
+		    "clocksource not supported: %s", clk_name);
+out:
+	fclose(fp);
+}
+
+int main(int argc, char *argv[])
+{
+	struct pvclock_vcpu_time_info *kvmclock;
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	uint64_t clock_old, clock_new;
+	bool verbose = false;
+	unsigned int gpages;
+	struct kvm_vm *vm;
+	int period = 2;
+	uint64_t tsc;
+	int opt;
+
+	check_clocksource();
+
+	while ((opt = getopt(argc, argv, "p:vh")) != -1) {
+		switch (opt) {
+		case 'p':
+			period = atoi_positive("The period (seconds) between vCPU hotplug",
+					       optarg);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'h':
+		default:
+			pr_info("usage: %s [-p period (seconds)] [-v]\n", argv[0]);
+			exit(1);
+		}
+	}
+
+	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
+	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
+					 KVMCLOCK_SIZE * NR_SLOTS);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, gpages, 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, gpages);
+
+	vcpu_args_set(vcpus[0], 1, 0);
+	vcpu_args_set(vcpus[1], 1, 1);
+
+	/*
+	 * Run vCPU#0 and vCPU#1 to update both pvclock_vcpu_time_info and
+	 * master clock
+	 */
+	run_vcpu(vcpus[0]);
+	run_vcpu(vcpus[1]);
+
+	/*
+	 * Run vCPU#0 to backup the current pvclock_vcpu_time_info
+	 */
+	run_vcpu(vcpus[0]);
+
+	sleep(period);
+
+	/*
+	 * Emulate the hotplug of vCPU#1
+	 */
+	vcpu_set_msr(vcpus[1], MSR_IA32_TSC, 0);
+
+	/*
+	 * Emulate the online of vCPU#1
+	 */
+	run_vcpu(vcpus[1]);
+
+	/*
+	 * Run vCPU#0 to backup the new pvclock_vcpu_time_info to detect
+	 * if there is any change or kvmclock drift
+	 */
+	run_vcpu(vcpus[0]);
+
+	kvmclock = addr_gva2hva(vm, kvmclock_gpa);
+	tsc = kvmclock[0].tsc_timestamp;
+	clock_old = __pvclock_read_cycles(&kvmclock[1], tsc);
+	clock_new = __pvclock_read_cycles(&kvmclock[0], tsc);
+
+	if (verbose) {
+		pr_info("kvmclock based on old pvclock_vcpu_time_info: %lu\n",
+			clock_old);
+		kvmclock_dump(&kvmclock[1]);
+		pr_info("kvmclock based on new pvclock_vcpu_time_info: %lu\n",
+			clock_new);
+		kvmclock_dump(&kvmclock[0]);
+	}
+
+	TEST_ASSERT(clock_old == clock_new,
+		    "kvmclock drift detected, old=%lu, new=%lu",
+		    clock_old, clock_new);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}

base-commit: f2a3fb7234e52f72ff4a38364dbf639cf4c7d6c6
-- 
2.34.1


