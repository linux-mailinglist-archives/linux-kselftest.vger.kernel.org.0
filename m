Return-Path: <linux-kselftest+bounces-13157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB463926DA2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB611F23293
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F850101D5;
	Thu,  4 Jul 2024 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="La9P3h6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAD17557;
	Thu,  4 Jul 2024 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061575; cv=fail; b=bMx/1ucDhoZw2B+Okk734KYHVihMKSOfUival5KsVQ6EmL2ZsUk5AJbHJEp/kmZiG8IopFYPB1M3jyGGwdqrPZabdSVllLb6H3oxFoOYJIzLvTZ9KmIBMpOLlWlwHAifb7Pxb0h7H5DWJrQYoKV5HGN75HQWj0MwrTE3hhPnPOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061575; c=relaxed/simple;
	bh=A5gbGnjCpNdXDcQbAmcXhWTMt6389q1Y0WcXBwAB+Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A/5uMiG3LPcLNtHwEycgOejb5WLCb5k0YgLbvU9VtLO3EyX6dATrNdyNzhExBeoQbupkcU25NvZUZkMpwJpy05+frot9MpWNNTMTx4DxfoIt4cDk1Ze1JdEmsbAnNnyYq3YT56SNfO9PaQDTZT0emt+7Y5aXBbdUxCIS0XXiAyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=La9P3h6U; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZszjT0+dE5QVIUcD3kxsv1vQMUY4c/aE7uNy7nXN0XKGyk0k2bLPhD5TLd82eQIElAII/2XvvkCtwUPm9UYN8qRajCJGiYS2yWnUuRefj1pFKSp34KlCHibJC+YKHb1hBhdLTNGXWi2LvqouDdVLXOtBIL1ybr58TDwY4nA4p0pVeVSe265wPvfVR34QZNeL3jQyylbK2EUcWdG8O0tbuphdIrQq17Bm5nn2zfouqL8OsYg1GyN8y6FbT6zIyHdzBQ+VfS3YUGMQi9PtNqG6yqk/HuOYHRgHo4ISYohGqde45Ro9EOFbu5ZzAn2ygczYkvoE9SZjVj45A/Gd8IQsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpCHTw7L5RN7QvZzoewH0xvuhWzfuhRutV/FnvsFveM=;
 b=H8RkFNsW3dRk8XDcOqPyppqxT/xduyU4AgqUOHXl8dh+9Jx8WT4f2JYTlZk0GyMDi1yhj8Z3kFOmLP1B8PicTpXhh8n7+sREMk7iZq6rZm5doXbip2chU43yE3DB3uJxVo/3uzzDA69O9kV6ttsB51uBlNFoVH0kzq9H5SO0ZKAYoJ4uhvN2h1IExrVBhek+9fNxiNEzGVrJUuKf3i8y+vUkKIxyJiLWhrapjP6yy/oAPplMVlmMYAWDQWM/Wrpzk2OkmbBmGzRmzJ7i/z5VvowTiJpZEuceAujPXHFEb/0saZIqp84e0hpuDuQYkywQN1u+bDULqb0UTsifRD7HTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpCHTw7L5RN7QvZzoewH0xvuhWzfuhRutV/FnvsFveM=;
 b=La9P3h6UE7lTOOhpaca3irIQX1ZFriJ3LWZ3TUuq4RbU2kUeBWkjG9C7QFf73j3NZlxm3Vzp2oHXqJnD/H6R3LqqUnNVhOwUPNkQME9OTf8kyL0ssGypCsFV+CUIH6t58titRQZ0vxPv7Zay8VSi6BAN1GynaDq69xoBrggyy5diMADUSP20FX2wmEpzAHR+YS458LgJF2SDsK56CeX7lsBwT/rd1arJMJ+lLH4c6zcNqj0WyFjaOD5YceUItl1OInbscbbHB7VSAwsBJcP16I1J3tu31mIN+vCGgbDKFECgWIeD3K9yvPQ463Z0yReVmrSzlgNbxURAzEt5Rcm7dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 02:52:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 02:52:49 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@openvz.org>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3] selftest/timerns: fix clang build failures for abs() calls
Date: Wed,  3 Jul 2024 19:52:47 -0700
Message-ID: <20240704025247.86418-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ef90ae-6b90-45d0-31e7-08dc9bd46415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?laFI9FSud0dLK88qbF3/DEq8MRg4k5iUFImhfpyLZBQMpHwCLV5RYJTopoYC?=
 =?us-ascii?Q?KpBN6kWEyAOfEIzN9XGlVLeo7dcHSH1pLa1kZOlmInO6lJxlXZk+Iryo3b05?=
 =?us-ascii?Q?J4ECAAc/oJC3cE/FKNUK0Zr362xvBDjLtcCMEPMAk7JmM2t/Hd1nu0h4vczF?=
 =?us-ascii?Q?5GGVJ/bWwlYdcIOcRS+ld0PyFl9DFijE6FUJzjCgjiCSqkxirnl4jeQExVaJ?=
 =?us-ascii?Q?10Y79L9ClgbdgLcuy7njETJ/+Q1yhnsjMn5e1LP57mDE93DC4Sk9o3aTL2oG?=
 =?us-ascii?Q?c1Aqr5HZPOKL19H6n+a41NW7WOJBzTK9gKDKEkCsZGfj9afy3ZvdnEe9Ns/M?=
 =?us-ascii?Q?zvHuT3a1XGvNYjWl411NLxJp6LG9kZg+yxjBKvnmMwGXASToWKpPUXeCcMpK?=
 =?us-ascii?Q?1ImkyOWOYDopK0ovo8RSFuNDCDdKdBISHdsSNqCeFUUaYtcj+0bRi3lcJLs7?=
 =?us-ascii?Q?elU54hNzYsU4an+aRNuu+l0rS64NIBaMXLTsHg0SZAiD9O2HnUZDUcy/5V2g?=
 =?us-ascii?Q?s63cA1nJ/q48CYkBK7D9wwvFFkyxWHRYCKmX5Hy3IaA/Z5GgaE5c/Lol2aVV?=
 =?us-ascii?Q?InAaJx8Ac/93N639nzY67Qh81cu+EnKXNDpIvVz73tCTgWbH7YnMnKjhM+PS?=
 =?us-ascii?Q?KdQXYhAX2BZJQRvoL6D/H9jES4pvTN8hnQkSjhePYsku/K1VED6VJQQS1/SM?=
 =?us-ascii?Q?9nrEvLR1PdiR01UiLqZkVUAaIiYgASrtRprkc3TD/pY+57c3xhhyhJLwePH+?=
 =?us-ascii?Q?K+JcVAYchKj3ukMt1c2mxOYYUKEUaI/9vtzYUXDbNEPXVsJH8jQA3SAzL+jz?=
 =?us-ascii?Q?Uqkc8T7ReWi9jvF/ZC6ZNSGdmuYXPRFpALMDUPcBvmxGTpR+o2nTc9kFIbuH?=
 =?us-ascii?Q?QbhHzG4SFRhgWoxHXH/VueacbZVazJ29zFBccnJ8oKGjOmrCqEV8WSzeVELA?=
 =?us-ascii?Q?NSPdi7MjJtgkNuC5ia293Zyo+M8nlW8EhOLMbTnaPI7fs6/E8T1A9oOMKLoT?=
 =?us-ascii?Q?P53yxS0cU1M1S3XzVmuVqoOSc/mnXApo2ItvC+FxVf6cl/fmiv0/2u5Dkr8C?=
 =?us-ascii?Q?c0+U8VExZkluCQds9RLt0bxj9wb7ZXfDhqc4AK5sxn9x5picBj+SRp9UMmcM?=
 =?us-ascii?Q?aQp+uavTGtdxXOxLNHnmcT6nPHA9hwYSN8FLOpVN/MxwG4JVjIJSs/qUcAnX?=
 =?us-ascii?Q?V9t3RgAP1yE1vSO6hkIW4azODeiJ1S84lxJUIeFfEd0CccwfD3fUp8xo0ZWs?=
 =?us-ascii?Q?fAjOLi8YohIDAym9oS1Tj32Ju8Uw8Xw80NG7Emj0Pff0VW5oCYBw3p7prB0j?=
 =?us-ascii?Q?UOyMIo7fXwurf43VlEHBlzTltoAI8kAOUy/821UJc4kq3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imMgbcbZ3lReb6jdIj7TMY8tvAZ4eQtfFLpW2H+Fhj0ehaXb1bKYVuyX8FtU?=
 =?us-ascii?Q?9YWZcwx/lfCmxh8Cb5tSgfhXj+MUA7B49iOfKsjy5NbXlY5tAuUdSKRGRGae?=
 =?us-ascii?Q?5v+1JFy8IOZbMqZnxySWwrLJVzaLWiTNlzotxtS5piVgX2LysllGRmesZXHY?=
 =?us-ascii?Q?nLSGnkc/7HecvvjQzYKzf02GkhcuUszbpjN6j/FY4lHALQ+OKvT60gNrV+w9?=
 =?us-ascii?Q?WkHeSpUivC1yt0O/F0GNOg7yxt+sKyZ7n/WMRsbM96rfI8LBK5dxw+xh6Uj8?=
 =?us-ascii?Q?69HYzqgS0QWlizQvxtCYjqiLALgqLaYEjZcfP5k2dbd1926bv1Wbn9CSN8qo?=
 =?us-ascii?Q?81FS6r1IxlaH3dKJEfWl8PYD5/qweuzazTxwR+BURRpen3vJs2IWdI/F5otX?=
 =?us-ascii?Q?iK5Ht3qlrkOW7zgFG3sf4ie5rGLszu2klHYjF5VjbQADzeXHytfAWih21g/5?=
 =?us-ascii?Q?n+n6BKcJCYdcct3y+CpJtMYk57nBZDhzuDR04LNusL8WPfdEyc+bEwUmT0qZ?=
 =?us-ascii?Q?qguwdMf8MmtbM86I8reZ86Tou0fkBsDYpT3htaYPfxuE1/OwN2sRONWyftDj?=
 =?us-ascii?Q?4UTZIvUxLcWj4pzfaMFeI+z+86vONg/Ul88zSHUUBj+UgON+2omLMqp0iGmo?=
 =?us-ascii?Q?o1ym0xxy/jczRGL/rpytclip12C31o6NAhEuHb/HYQLtOfl2mW9HIQ4kENdk?=
 =?us-ascii?Q?6CDBcc2sC6lvKGzV5fbhtk+K06wjHLrpFxL8rfZiB4n5yQE+hms3XpFTCgMR?=
 =?us-ascii?Q?4qXMLcxnt0HyRRT2TytuxVwypaOYZyfEOFk6N0oaqk2dRIRLZybT4jrtFgzE?=
 =?us-ascii?Q?/tmt+jVJQQeyNqBxSumc5my59szmKR0UM15ZzRyt7YNMkML+SOT/FrUtnBw6?=
 =?us-ascii?Q?72vHMVVwPcxoRLCM0ISAAiVrTA01wlJN7q/mZEf1lcysp/RAIHZzsF2ymXST?=
 =?us-ascii?Q?CEpeu1nfJmVRXuIUXrf623wafkSdyExRLE37uCvfEhPjZnCP+1zDqjtBNA/S?=
 =?us-ascii?Q?ZDqeYEw/nNDClVpG7Q6/V1M2x617gDj6qKPRsZOyNu2wI9GplVVNYnwor7O0?=
 =?us-ascii?Q?15Sar6W3D6yB7D6FZO89UlA8N1dA0OXsvoS4wsYi661jklsIUTnR/phuh3Xs?=
 =?us-ascii?Q?GdCyuS1CdJeSDbcPgzRPd18lXQ80oAuRPJqD6LmIFTs5atUb6LEtwDMKtJFU?=
 =?us-ascii?Q?+vun5EE3tzmN95QMAkUUj5t3dqyTwj8s2uMDUbrLU8OuxvJtcGdNo85USJry?=
 =?us-ascii?Q?5QexDGTK6O6pW/vBt/SzEeC284onoyCm4Xbtce4yHvJ7AEPDyJdhymsJf/TE?=
 =?us-ascii?Q?qZFP5SC1My15b8TTn+c2a61KwHKm5ej1iHduE13anLirPiScZ/tL7l+yp+tL?=
 =?us-ascii?Q?09R2IMoh3hke+mdAG9TYI5TgqgP1dzST/Vkk/+hC0R0jnr2lRqvkPkrNqjRO?=
 =?us-ascii?Q?Eu01MlXdXhZIdpaecPOcJzzSlZ/OkIIan5Mk6DBPUJjCNhdHL/eu8WGnAZ2G?=
 =?us-ascii?Q?JYppvsFS/7TL+gk+JnG9A72EZ1ejIT+rym27NF5slSNtKEwN3vEl+dY6kgJ2?=
 =?us-ascii?Q?AIViVNjVENXBQUGB9/d9nZAQ/OkHCjI5f0eNLVRm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ef90ae-6b90-45d0-31e7-08dc9bd46415
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:52:49.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eoLQ/FbDICxhP6UNPIksm38Cp9C7aj88KEctmFjSUQ4xXTBHfpxgD2g6ITWuGxJioXXshdzs3mo5rN6GalOvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns about mismatches between the expected and required
integer length being supplied to abs(3).

Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
these cases.

Reviewed-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Changes since v2:

1) Commit description: removed the reference to Valentin Obst's patch
   being a prerequisite, now that that has been merged.

2) Rebased on Linux 6.10-rc6+.

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

2) Reviewed-by's added.

thanks,
John Hubbard


 tools/testing/selftests/timens/exec.c       | 6 +++---
 tools/testing/selftests/timens/timer.c      | 2 +-
 tools/testing/selftests/timens/timerfd.c    | 2 +-
 tools/testing/selftests/timens/vfork_exec.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
index e40dc5be2f66..d12ff955de0d 100644
--- a/tools/testing/selftests/timens/exec.c
+++ b/tools/testing/selftests/timens/exec.c
@@ -30,7 +30,7 @@ int main(int argc, char *argv[])
 
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec) > 5)
+			if (labs(tst.tv_sec - now.tv_sec) > 5)
 				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
 		}
 		return 0;
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now.tv_sec) > 5)
+		if (labs(tst.tv_sec - now.tv_sec) > 5)
 			return pr_fail("%ld %ld\n",
 					now.tv_sec, tst.tv_sec);
 	}
@@ -70,7 +70,7 @@ int main(int argc, char *argv[])
 		/* Check that a child process is in the new timens. */
 		for (i = 0; i < 2; i++) {
 			_gettime(CLOCK_MONOTONIC, &tst, i);
-			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
 				return pr_fail("%ld %ld\n",
 						now.tv_sec + OFFSET, tst.tv_sec);
 		}
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
index 5e7f0051bd7b..5b939f59dfa4 100644
--- a/tools/testing/selftests/timens/timer.c
+++ b/tools/testing/selftests/timens/timer.c
@@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime");
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
index 9edd43d6b2c1..a4196bbd6e33 100644
--- a/tools/testing/selftests/timens/timerfd.c
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
 			return pr_perror("timerfd_gettime(%d)", clockid);
 
 		elapsed = new_value.it_value.tv_sec;
-		if (abs(elapsed - 3600) > 60) {
+		if (llabs(elapsed - 3600) > 60) {
 			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
 					      clockid, elapsed);
 			return 1;
diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
index beb7614941fb..5b8907bf451d 100644
--- a/tools/testing/selftests/timens/vfork_exec.c
+++ b/tools/testing/selftests/timens/vfork_exec.c
@@ -32,7 +32,7 @@ static void *tcheck(void *_args)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5) {
+		if (labs(tst.tv_sec - now->tv_sec) > 5) {
 			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
 				args->tst_name, tst.tv_sec, now->tv_sec);
 			return (void *)1UL;
@@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
 
 	for (i = 0; i < 2; i++) {
 		_gettime(CLOCK_MONOTONIC, &tst, i);
-		if (abs(tst.tv_sec - now->tv_sec) > 5)
+		if (labs(tst.tv_sec - now->tv_sec) > 5)
 			return pr_fail("%s: unexpected value: %ld (%ld)\n",
 					tst_name, tst.tv_sec, now->tv_sec);
 	}

base-commit: 8a9c6c40432e265600232b864f97d7c675e8be52
-- 
2.45.2


