Return-Path: <linux-kselftest+bounces-9450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9BF8BB934
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A04B21801
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B821AD49;
	Sat,  4 May 2024 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8h2nQZx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629411FA1;
	Sat,  4 May 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788819; cv=fail; b=OsyrSqSn4jRKUZvzay9wXiQu3kCGDdJ7kVCcw5cgasg2UMUnPSvK9DXNx45LJmZ4PXgN6izMiT1NDBMcrUTExetPYuBXOGR/uGF9lkrrFiRfSYVB7+/UzRJdr1cGKlXmc+Uzqgj5R564UxiQyVuFhebX1qkIXLrRUcDqbG26gZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788819; c=relaxed/simple;
	bh=EzWNV42aokbFwCb0Ps+kTsAr8JgD9UP7D5/MX2Yb8so=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vAhQYmpkwFCGCVkaSnI8bStMMAVlUlXt7ujBpad2rdifCmXd0L1CDMBYmPFFN8kjlpUz6JXW2sf334AQFoFTUklI29hysXFxW3X3y5FYyVfMJ8C7k0Wzf/XDBU2mATQ+UWjoCakDTjXUi4mAhUrFbEzWZTPxEnd3tAFrbJPUBMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8h2nQZx; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTRBiQkUPmSQjOa1GnygPp7xJ9mXfyAlxXqXdha+XHdyJQrMaG/YEsiX3Kp3mLw73RjA7ZFI73MzybcZnpvLAcf4ZAnaQJhIcHp0A+oVsettOcNw5Aqu5OwsjNw4PVoVx7YCQEPVfZAVWgWwKVRVyDiXTvrt1+SQGnJgkzNZ3pul3cfWsGfqq/cA30e8gh5CWwDBoqwP7VG81px8JVPAwz2D1BWLqpCc3A58pw+OVR+5R7K4VnwnANPf/1mKtgxzbXoswci4HCdGzUdZHUYeSHlvBwV3+lj9gNooJvp4uZamtIkUad3b/Gsaev/TNl0FZTjLrNlQQ9jspvyz1W9W9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6IW/AGyRyhorJNSS/w2he1Rb1GVFfaj9dnJ/50C+qU=;
 b=Vg2fkKxOq3Hz56BpnrLKpVRCrrbyOJtOA1Fdp0lhQMr//CpZlRQSHj2e7tm3b3zqq3LVMqqOGVWEsuzre3lYzeS5BitzuIbIHFv+phixSqlVDWLWvBMFuAO++EuCZF+z2CH/TGPqbZnSdJUz6cm9UbXNojkLX38/ZmzUKjbj+UFKRcCpBOyrM9sesZDAwC6RJknu7RQZ1sVkdJjA2KCXICa5A2naMguFaw809NdVuWIagUbS/zz6UH24COSVG3/hEEFcrd7CAamsgpgY4FKYYIglkVlO//+H4NHdYpKM04feJRYjLT8SzjkzEBsUeaUu9ZFwIptOjK6MxhK3hkSO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6IW/AGyRyhorJNSS/w2he1Rb1GVFfaj9dnJ/50C+qU=;
 b=Q8h2nQZxRTOyY+8UpEnrId+MKfAPDU+0sb7rxzpk+C5ZiFucQDxeeG4Qk9OucrtijrhIHGXJg6GEfQWrHFwwpRVVr3MXzNz7hm1SU1fkt5UA9QbfvOcHi2C76CG6i/SprxRP2UBQ3lEYgpMGzwIoUcKXjyaiMCUO99Cl25kGzlAGcZ4XBhd2ZOQA/RGB0jLHHI5IJY7+cj3j4xyT0qXK6s584AB1Je4OouGHmAHyQNMCllU1GhXooJs2ISETBHZ8ABhg9xBmOIkGvp1xJ5YhhepNL6F7TY5+hTLlYabbcml2GfIW2sMhLeNTtV4S5ObdAyJ2fVRZRALc35VW03+jlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Sat, 4 May
 2024 02:13:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Sat, 4 May 2024
 02:13:32 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/alsa: fix a build warning: return a value in all cases
Date: Fri,  3 May 2024 19:13:30 -0700
Message-ID: <20240504021330.33429-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: c30daede-0714-4b04-de27-08dc6bdfcbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sw+mFbGWAQS9XQpw1ipEjB5MMYyABJAXswgNnO+U2x7KL3I3eAdvcXMprM6+?=
 =?us-ascii?Q?fP1t04q3sUNJcGboCVTou4BOqFjyIHEs8FVzYYGG0SIhf0El1LXpbYDS3RPx?=
 =?us-ascii?Q?yX6YT5J+DUsAxa8/CqWafEC2K78cqIUjvs33b8QYB4OM0xdJ7BIBMxrLhUeJ?=
 =?us-ascii?Q?gmiMmACEgilp0L3nlH8uPHha+on/uIbS5XfpFWeL9aboRKR3JasI6NkVve2m?=
 =?us-ascii?Q?nyXiPL3SzrsxAqSuRVqllVQVQRRzoi4mA7clLZzKuB6mjRp67DkFGQJqtLPk?=
 =?us-ascii?Q?iYtzwL6F0f7iXY1oldTuvzZqQwUQuX5OIz0Nmmt6WV7KGdBHPWUwMtQPGYt8?=
 =?us-ascii?Q?ECcjiQn16+be5MPvx9aYK1h7uaHmayz8SYHEhw8U1fN/0Tt2Tl2XN0aMKhwZ?=
 =?us-ascii?Q?AyEOuvMaM75F+qruEPJqS6AwrN6gj3I/FvVzojl5gYdQQKWxTtYOIcyubAAn?=
 =?us-ascii?Q?QOPzIfEvAQhpCAGmEwfjPoH7CIl0b3Nw3vGrRhrv0QWqV/HTA0EQYj4a/eDL?=
 =?us-ascii?Q?FDhxkRd1VklL/EMgvH53k9oX6k3ax7khjGQYzt1hTwAHm66SkuL10LGhPe6w?=
 =?us-ascii?Q?mrm4f0zhwy3dZohPgy9PoAZLkkiOW/ci68I66vSKn5opQO0v7PU4RFGd+snt?=
 =?us-ascii?Q?qy4ha7CEQYSd/IsWmdG1zgnDeqvcT+AYlQLRlFhIPJlCb6oUSvPQnHt7gzt0?=
 =?us-ascii?Q?SIKIuUZYq63MXAhJjYiCClLmzUwG6nOlxSjQvifZpk0Bd0qbds9/Xow4YhAV?=
 =?us-ascii?Q?BlchvwMxhIkQZgHUr6h5QJtyyne/uV0WdK8BnfbTmy5s3YjZS0xaQNK9EQUL?=
 =?us-ascii?Q?3o0zeXRwF4aCLnWCuA+I4WVV8iUMD7Apsy27gDsvzl6TJaPAw11E6exbtXYG?=
 =?us-ascii?Q?Zg0G0QavSZzDmAT0osSAwXhRndmEOfSGlIjJ/a4NtQPw75RgkdxgQdYK+pMW?=
 =?us-ascii?Q?lFK3PmPR3/gJeLXeY5nIk+TQCWbIUzO3WhB9RFuz3w9CnMbpQLtJ1YFOnCGD?=
 =?us-ascii?Q?1OBG2wSZmtuIlyk9R7RkuaI6RnIEFjApieNrYqnjZs1ZVk8xeNovv7NASGs8?=
 =?us-ascii?Q?vh3cYjZ4CbsbwsWAY02aMqJly3jyYVllJwCi95HO4fIjxSwdtVqm04pfqAv2?=
 =?us-ascii?Q?l0zFTW5T7gjg9IsgZPqazUu+FsxhCxpqyUVUoN7G8SGM9cSPXw5JGJ0nDNwY?=
 =?us-ascii?Q?hYR4RQ3yBvLznolcIzDeD5aTukLg7Nj2RKiVdM1VNB9aQEcZSMiddeh4oH5J?=
 =?us-ascii?Q?XuE0hfYghKjqfnn9sa6VvR3Qw59lfN1rcJhtP4S9rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuAP99HG7XkCccMGahz+87uYOeeIhsH0fo6zfexOrWzsnyOBPe4iY50xU9QR?=
 =?us-ascii?Q?fECa4wB2908LLDxLKzytqpGBp9K48FrWYr9sRZGybwzDu4CLozenz7SGaTTt?=
 =?us-ascii?Q?AzMEuk9+tw+HiX9lvAux3XeTqw+Inh/tzqhNUZI/F5dRfHWyDCQgUv0yJed0?=
 =?us-ascii?Q?sNNMDYY8sFqjZdRxl2fjFitJCppYz7uPTjieiiawTtFwO0dmuLyNLSfGWWZ1?=
 =?us-ascii?Q?S5KOGRkG9p0vIGgyjeGgYSm6T+99kY4T/RxZuAu2q8b6uBccNJCzVaJJXiwD?=
 =?us-ascii?Q?8MH8E/FYdCrq0H+mddHsHrlrMJNnhyxqN5vp6o829gsgIA9m+dfqNa8JGM3D?=
 =?us-ascii?Q?lOnUcubxP1Ehe7QTrNVN04RHn5t87LWVNQvEKWa0fsh3OWslZuDOuT+U46rW?=
 =?us-ascii?Q?BuIT5I9YTFx38Ilqj7jhDHvO2B9Pyu9IAV57VDAECpvGCS42tAZPx5VQE6IZ?=
 =?us-ascii?Q?ad8guxkWKDETYRN+Q6uJY6yXH2PGQU6hKT8eOraCTnhi7zHsmtkVQV3NNl3A?=
 =?us-ascii?Q?2ddVNnC7S7W956jzbf5eLsEgPcU39Pzr9tOG4LqZRPOQc1wLpYzGE/F45IeH?=
 =?us-ascii?Q?LegsyY66+8eMLE7O2RbeXHOpmYPy8FcHSAljXymH5FL9OSxxHov/0JLXylPa?=
 =?us-ascii?Q?mfjQhxwKhbDnsFqoLh8CrKewoRCHGtBiOQJYU7JOzU7b6FFuG5MvAdM5gNzO?=
 =?us-ascii?Q?VMCVUJgDv1LN3D/C4S8wxN7TJTnfvq4+il+/zwJM9V+PeIIbb6MaLTbEWD0U?=
 =?us-ascii?Q?/q5leW1rA5emEWqrUH7nJBg2jqkbM1hmvWSK6sciGcQBbTtERCtAw7tGXSUw?=
 =?us-ascii?Q?ABYfgj8pxgDiTsRsvYrqziDkmZnVhaJ5/UNFGY7eseDYgDXgdjwtyCSX5z5Z?=
 =?us-ascii?Q?VVR3SN0eBGk036xATo+e2AW/TmE80j2ImLPphcK/XqCbq870iPTQYEJBMBgm?=
 =?us-ascii?Q?nkQN2Q2DKOC9SCo9HuTgGDo6NbSTXxmvtf8ZJ5YUTD5bbOSMmlOQfJD+qWMP?=
 =?us-ascii?Q?yOANq/1EqnxdlkwiYs1tTu8sPyg2+6a4ulzojUrG+VBxVajtp0fL4kvSCEjp?=
 =?us-ascii?Q?SbGWR08MVa+fOW3uLWl136qEpiP+cUB3mIkGFl3itjXJiHtLeM3Lfb0B8EPr?=
 =?us-ascii?Q?udwXI2TbvMTH1Od13F56qWJXbcRHyIA2ZU/iyN1/TUWRM6+a075KsXuxXb92?=
 =?us-ascii?Q?tUca0UzhvP3ORibyreP303yBM5ZdWZcxgojV7DwNgFX10ECDKEEnaVaS0uxL?=
 =?us-ascii?Q?1Qn+GoVVkUe2+pGyoJcr6bBI/zT0qcFAHSer3tH7Nd8bVrOzHE76JdCafjr5?=
 =?us-ascii?Q?YW5XeMKBY35NGAbae0O5EVSr42HN63Bx1Wf8VIC8xfBJuizdkwQYJLh9GAEX?=
 =?us-ascii?Q?y839UtXPFHSSgRZzoYFuTHRK9ayL7FUYR6OxZC3kMJosVPg6FVfJRhQnUv/U?=
 =?us-ascii?Q?6lCLVjktfCFupR+oOZ2tGTk/h3fygm2hdyzykOpcmA161GstNNcsrXBVNUP7?=
 =?us-ascii?Q?869zfsndsmL2qmW1CDU5w/zucFD6IhqAfPvWd/ThdycIhiZKFQsDRw7UQRG4?=
 =?us-ascii?Q?f9y3J9DTHBBi+/oEbG/pHmF40T4TApb6g1mWg8Sx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30daede-0714-4b04-de27-08dc6bdfcbdc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 02:13:32.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AiRmrEw6VfzHZDkDcunST584lN/OZvmrIsrGxmIpOQTmVBdwdav8PxTFYi8U1jCgsuXYB0Z5TM7pq//fTVSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

dump_config_tree() is declared to return an int, but the compiler cannot
prove that it always returns any value at all. This leads to a clang
warning, when building via:

    make LLVM=1 -C tools/testing/selftests

Fix this by unconditionally returning the "err" variable if the code
reaches the end of the function.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/alsa/conf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 89e3656a042d..0109fde53e6f 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -116,6 +116,8 @@ static int dump_config_tree(snd_config_t *top)
 	if (snd_config_save(top, out))
 		ksft_exit_fail_msg("config save\n");
 	snd_output_close(out);
+
+	return err;
 }
 
 snd_config_t *conf_load_from_file(const char *filename)

base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


