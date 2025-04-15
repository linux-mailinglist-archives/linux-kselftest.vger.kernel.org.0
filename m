Return-Path: <linux-kselftest+bounces-30873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C493A89F99
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6375A4436D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3811531D5;
	Tue, 15 Apr 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lD54X55+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605C144304;
	Tue, 15 Apr 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724209; cv=fail; b=FZ6brl/vX64gOtNKhfh/e1bwXx08moL0A0SSQxAGihVtDkDKrffxRohryHMKq5ESFZhaxAlNN8FtlvZDxxcJcT4xvwRAGAwrJ6NxFp+6v1QGpojiCYWtP+tqEXS3kIQqtFP1GWmpuWgQjQ6lbOguYEFt0/Y3SVujDukqPadBWNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724209; c=relaxed/simple;
	bh=zRN3AAgYfZk5Md3GUNrojX4m3COTD452oHOlpQ+2YiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BS7LqkZotIg5hhnAPcQYVhafzqYdXXqIOiC6ewQtP41y/7HKklmoWzAY99snNfLIje5fFr/TWqW482QtpzITgg+62TsLg/ZhxXI3INVQ7gktbWgNg//8+2cPB11itfDNyvD6l9kYJCv203XWlMyQ/WbD8vsnc2CJ6gw9kJbNDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lD54X55+; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAGk2w1x3xjlbe0bgy8lnqKxEV1T4aC+VmZehO6m0ce2KFoWKaQRMYC6ufi9y2WCkhHWcv9wRenn4LlMv8juMTIb8rhKc1IPvUFaCVc9Scy0dICcUM2JNVxzWTrSt3B3NWpLOPrzRKviRdSl6z1S7hTvSwCkT7KbhI8x0/B9hM3DA/HEoRWIZrIIuubTPOD3s4P5RrpOBO+LbSkXMesizgkrRhpx4+Ushp8U2nbzCtyeGNYP5/0pPa6hDsisktbNUPAIHm/7MJU2tzbC6ARoHsL0OU7NJz61QpVS3Fp+yg5bvHxYU3t39d0QmcFKe3/KBms3zG8uu9aP8Od6oP1SkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUnprEcCPnSDifmar/p0T3SZHbnNh1eEY3zl5LYRp0c=;
 b=Cw1dkN0CLisiqHYwM2Z5pYLrFgpiVMurIlxlS5RTnCbNzsmeadp32NNKXyN4CBs78ttgUekrjRADzMCCI4nt2cUfJrbCdXGmTAOXIcxOIP9oGboT2o0nfb+H6azBj7LeNDfbwvjNdXm2F3+W9ixMktEqc1O4DIqO5rbR5BGdqcDX6EqT7dLyhGCa383PuVFJCUA1jWJHiAo3e78uSRjZnG7th0BpHoJjlSpNpRFyM9bzEGKQusYhiwlCA90OGfCHnLC398BofLvmi23ylZlvec7sd4hnYpmL9REdXMHslBfprJMicFI88BAc4LcU+L/3LZUMldotUPzjHLAqU9Oy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUnprEcCPnSDifmar/p0T3SZHbnNh1eEY3zl5LYRp0c=;
 b=lD54X55+ilSYglMtxu/NTAqKuuvgjKXenmXdbMwc57JWTV6kLEzj89ytZzhAC7tp3DZdkGOAnUjdm0wbJC4IUuxfMH0h0ZR/2eHY2eNni6ZJcy9XolB6v/SFNuJ0DNKpMOkjV9d4CLj9XneAXPG3a+eKx27QDTqJBmdOf2AGWXQMdGv1xO3vzzSTDQ/Aw3dJhpn1HKUbicv1dM6whBc/qqz3zK+pScyEyQiHfD+Dwg0hj1+N5ZVRKTus7/A7Td3VHKRuFk19UWffkoPgTklxCHBmIhPwV8AeomJ9FC3nzc4+oXmDs2Ytkdns0Fs3jLWj9ju1seKn/9jmeRrwMAL8Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 13:36:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 13:36:43 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/2] rcutorture: Fix issue with re-using old images on ARM64
Date: Tue, 15 Apr 2025 09:36:21 -0400
Message-ID: <20250415133622.1563137-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415133622.1563137-1-joelagnelf@nvidia.com>
References: <20250415133622.1563137-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0650.namprd03.prod.outlook.com
 (2603:10b6:408:13b::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 36be5fd8-a759-4001-4008-08dd7c228f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qx2+SdOMd3b3XAJyenQhbusTonR3BB2UKG2c9uJqaV4euCq2nuo4WexkPxeX?=
 =?us-ascii?Q?zJGgy06NAKC6CPYgjDVDnOIc6hKOrBSV7aRHadN73HmccIFRhUe1w7lMK1I+?=
 =?us-ascii?Q?a3qma908geKfBEk3TZnYwHudLxBzoTFsUqOlhHIWFN3DUAG0JRQal3WoaIUy?=
 =?us-ascii?Q?AAjLJjDV9PgFkYDzfGjvAZefRfHYladaeEGDoxEaXEmvPAJANUi2BpmliYiq?=
 =?us-ascii?Q?X8GCYL65l1Ahi60hkr+OMgSw9sTGWUSvRviaIiDw61jWWPIb9pFJl1cWPu2L?=
 =?us-ascii?Q?579sKGVCjZ5RUKwogQkRUYNv88a5ADhiPNmmQ0mVvF0e65/kbR7OrTR6e1/L?=
 =?us-ascii?Q?is1WEfTLKzpaDPavfPYH5YoADC1QvyLIAlQjfPnsnV+SxvpDoQBb7OCFjLdn?=
 =?us-ascii?Q?s2IZlDDjbiRWqc9WMtFtINXCSweme/5PJIESk7Dd7yJ5RYDbEwSbknZM4lYl?=
 =?us-ascii?Q?zu3iMpb7uvi4DXIrCthp+FwSSlD0mBipmGq5VmsV1NA4oq5aKOe+AugiZXCg?=
 =?us-ascii?Q?loNPPDp4rd7X0qVS1epVjFfmgHH6PGny+YVACItFZBCxsN7Q4X1cSGP8UYVs?=
 =?us-ascii?Q?LhN4VPRoEQyWKZeEvQGObyDw9F0vemphyqlIyjVNUoXcxclyd+1jkWbYiiXy?=
 =?us-ascii?Q?XrgPH0YJDjj5X6FeWeJ1RHyyqUYzvdJFHuX8M+pQvSNjUkbjH7gQArAeW7N0?=
 =?us-ascii?Q?bcwUSerAVx2Gb5N3pzz9dWwREfYWmDmGNJ/Ex4bSygEEQVKYAdx8h4oxtdC2?=
 =?us-ascii?Q?m46pXcxIfxf+NjwwQOKxFP24HwgOk2JdWcTqPxQyBj3et9gaEMsSQ55Nw92L?=
 =?us-ascii?Q?I+/1tLAwFnpuKKK06tJQbKzKwgJkorLQJYhY31IF0L5A3TtB7pf8J5iDp1gD?=
 =?us-ascii?Q?m+CbRHlDyZQqyRONb8SDs0+6k4959Uf/jhv+0xD3nCsX+NgCi8GHnLsn7NQM?=
 =?us-ascii?Q?DXFUp434dvBh3/M6CugpRXZRQdNjPtVvEjbduZ3XiS02kTOF0b5hIQO2GthG?=
 =?us-ascii?Q?i8AyxYktonywc/XQ+F8VuNAZa6JxxVul3sneiewPEZzD6cvYMOo9ZOLYg53+?=
 =?us-ascii?Q?DCSiXzUoAVtALt2TDoOthGTl1klIwZHNZGKlXLyKhZn28RNmqX9q7ZURyvhj?=
 =?us-ascii?Q?DuoKPplYrB3e7ybdWc19NIEpIxBSCJRkuOiuRUmkmhPOzkrbjGNVcjzeYo1P?=
 =?us-ascii?Q?QLmwucKjIY0WMO6ovSlFBPDqigdGRFL9KKdz03ObhbhI4uElXmUUpaz4hsgL?=
 =?us-ascii?Q?bs9pMEZ/90RTguBS8GgeOZJ4NmEVVNvjllApVzqL3Vgg2spVGPkzKAOU6DSx?=
 =?us-ascii?Q?7mv8SbkGslMnDOpnT1IJs8wnr/obsrVq0o2cqoHFfZO2xz5ZpPg4He/f3V6K?=
 =?us-ascii?Q?vUU9ScxjZMaESjF1II7FEN4DEmxUmsHBzZ1o+0ApP/gT5UjC0PuvtuI527O5?=
 =?us-ascii?Q?nmcpj801+HqHrLcMakvRwAPWz7mBQTVvA66IvmvFqOxf4K2tSt7I/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/E84LQ4U3O21HOQ6XiWGQXdRvpVWa5ViW08jB7bzpoMcD6rfmnKNOtKXJ6i?=
 =?us-ascii?Q?L4R679zQWk7z8/rCKKvXJMN3ZhUiMqSrg6dx9NWEEAMXn0cc7hSUIGaChRmm?=
 =?us-ascii?Q?K2mMQQzngAikXfL5hKGofk3iETnlRTl2/S/jfF2ZdHO53OP7YsznU0oHkeoB?=
 =?us-ascii?Q?KUaSmhKBXgssQ4Ym7ABGsqOP4HVrTeQXAnyFDa2kEDDlcadJ1EUMYltXd6Vz?=
 =?us-ascii?Q?Sb66YvikvEaWZ+WgXcSLauEN6p1A/NA+EYQT7kEHFqZhcmOeatfnsnhzgH0D?=
 =?us-ascii?Q?tyfFjvSfk4c8rYL5jT+fyc2BmNFFZXU4AxoKAiW7f2zTPKuM5vd++LwlxidG?=
 =?us-ascii?Q?CsCSH1yxMc8JqGCeU2PZX1DSWHx3I5JEZTdy1frN6hztLF4RAdJ/Jpc8CW7j?=
 =?us-ascii?Q?RdJ8eJKNSlXylewyUqkaovuwcwFJ/iHvWOHPlHJzotb2ilXTL+h8afnUPPi8?=
 =?us-ascii?Q?EVR/dyFfbg7kwDt3yL8N0PFf1yO+zVpJafYW+hdy6H3H4wFTI25Fi6IUYnAU?=
 =?us-ascii?Q?YCvn/aom/eVnkx9nH5J/M+Lm29rX6I3CzPcEmdJ+4wIgSznduJpQ+sXByj5f?=
 =?us-ascii?Q?7BWUdsj/6E/CAEdkf/7gIIIGut7Yk6PFSCqYuLOYXd3uCM4FIDToja0Fom3z?=
 =?us-ascii?Q?RZoKy3NOZHV2dk5cgoaxj1J5tUBRHd0HiMiFU4xTKoBx1Tmh5za9/dILsIPe?=
 =?us-ascii?Q?alXQsJdC/IT1RqVH3taargX6kpNu7I/YMvY34kcwPrCAKnIQWlTYzFEqqn4p?=
 =?us-ascii?Q?vtnPEbZwJY2p2/dGuBu86xzGuWNGJPm63A6skfpmEgb06i65VH+aV0K+eDNX?=
 =?us-ascii?Q?46D5SZUjYIKMxFMldC4ROP/RWcvdXq3IS2A9SM3MwQQWmpSVlaa5KG5e15A0?=
 =?us-ascii?Q?djz9EP001bcFVTFM6NfzxtBD1rYVaKza73hEPpg3pw2DbT7B4qIQMHFLIrFV?=
 =?us-ascii?Q?uVDHFGENg9IKN6pCZIawWsW7/KT/4RK+tQE1kJQ4LVdf5LvgSGFMicpKIAZq?=
 =?us-ascii?Q?yl67QKDxijOGczJZ7lua33x4aCTS16uvsrs1Vnd55UWz9/pjNCmS691EGWyk?=
 =?us-ascii?Q?iiPp82cB6aCZFKew2gAaDzRDjwqtJnudda0vEsjdVC6P/NG2HANKbxCxPDj+?=
 =?us-ascii?Q?PQLZ70z/1WnGZ/JsXK2Li6X0ToPOPFiUyTzzbT7yhjMUppEUbMVv9V7U1Mtu?=
 =?us-ascii?Q?E558P9IRRr5Bi/v9Oa3BzDvA3DDDQ7ielA2qR30EY/ckU/dY0L86XHiTLfUb?=
 =?us-ascii?Q?NgpN8XEo9Df28qpizDX0bBGlnAU83AbK/AIOvIE82ljXTRsPbUWU4tghc1Z1?=
 =?us-ascii?Q?auS6aHVBTyLjZJjf/FfxAV/XHKJHfGYfvP4I4UruJPpGfqw6oYYt4AIRJwZ6?=
 =?us-ascii?Q?ErWSodAcxjOQ0/N+Lnaw83rMRmGSP8l8OiRqArQzyGpQlnvjqp1sTrTtxl+E?=
 =?us-ascii?Q?LRETmEMhZUPIySgsLL8MmD8OTYh1Y4ux7BXdctZ+y1EUxWuFC51559KaBDUs?=
 =?us-ascii?Q?bGD012BTS7MhNfz9g60Ts1nrAzykku0Y9lEQdpX7ZQiUpauqv91rn9oCyElQ?=
 =?us-ascii?Q?cX05CucmRbLHn9AeDJG3JGTw+ubKVI2IJY9zOtI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be5fd8-a759-4001-4008-08dd7c228f75
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:36:43.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZeVieT5hglEgziCC6SHlxElF4JzNrk2rvYVDVUhbKeS8TpPyrOyX6Bx6xCIf8fUqKxuLBVbdrhBCylURQPpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

On ARM64, when running with --configs '36*SRCU-P', I noticed that only 1 instance
instead of 36 for starting.

Fix it by checking for Image files, instead of bzImage which ARM does
not seem to have. With this I see all 36 instances running at the same
time in the batch.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/rcutorture.c                                  | 3 ++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 74de92c3a9ab..df6504a855aa 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2412,7 +2412,8 @@ rcu_torture_stats_print(void)
 			pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count, cpu)[i]);
 			batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch, cpu)[i]);
 		}
-		n_gpwraps += cur_ops->get_gpwrap_count(cpu);
+		if (cur_ops->get_gpwrap_count)
+			n_gpwraps += cur_ops->get_gpwrap_count(cpu);
 	}
 	for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
 		if (pipesummary[i] != 0)
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index ad79784e552d..957800c9ffba 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -73,7 +73,7 @@ config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
-if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
+if test "$base_resdir" != "$resdir" && (test -f $base_resdir/bzImage || test -f $base_resdir/Image) && test -f $base_resdir/vmlinux
 then
 	# Rerunning previous test, so use that test's kernel.
 	QEMU="`identify_qemu $base_resdir/vmlinux`"
-- 
2.43.0


