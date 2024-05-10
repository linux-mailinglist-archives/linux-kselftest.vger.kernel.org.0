Return-Path: <linux-kselftest+bounces-10053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0738C2B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6169EB22EA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235904E1DA;
	Fri, 10 May 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JBHSB80w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133D4CE05;
	Fri, 10 May 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374350; cv=fail; b=LS0HZHd1u3MaRCZ2EQbatIu3YDQIHR1LD7R/wdl6QzH3qTfYtCvSTSAFyW+lTR+u3mFJjl/I512Fs/aHGfc0X4ZvFze6Yupj6x2fH/Fr7EIxL0AdxtV9YVZWlN6gBgFUqo8Vp741vHcsu6JGb6lhYEvzH88h/CdTx+dnsblx3+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374350; c=relaxed/simple;
	bh=4RxBTlP3vkVPxYjWbcDPue4HcP6NhjNCKEqUyGWCO6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bUakfBuj8wD9EIrTHU+q4rNs/Uvbf4JfXZMAG9vnSAsnhrXpeiQr+Xff/lPi7WGVJ9wxoj3SCbne/XftRtJZyTI0t7x0O3U+ix9buuajpLSRLfqyOGsEpWo5hKBav/uOM2F0c7dZ0rjxV81+QNXGOzrcpmua9azbUlZweMk6eFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JBHSB80w; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hs7EzgV95ijzNcsJTfmo0XGUwb55HQmzDEWaMbYPRe9HDhzWVs4vcROD+InGo4SnUs3ErTAmjsEkRfEPuw2L8ISWnf9HHdfzurB3d6yuECr8X1EfUilVOxejlC0Iq0oKflmiiPwouwDDdtji5/B9XNOTBhKWy4s/eP6It2jG5h/ltp3RjcBRj9s9oFlOL8QbvO8LsqSK348G9VZTqE+mGsIuDH+BXYpwaKTxp7eXGEQi+pmOrGCgZTFq8+96vf2VWSvkzrLwGg76LGtNoIFSw3hiUgMo0SZcGY7i6dx25g2IbJlWwUUyZ5bQGTGoT4Jw+/qyQ+AnuYrsoy4XzUwZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lcWRLUuRGUZgiMFYby1sNEhICC3GFqhiiTUyXYTtXY=;
 b=e/FyzqpXksWbK4LA+dAT2psx6elAL8gMHdbvzhajKPEjT+TX1ngqdgUlLACmdrcae/TwFnXyByIlrKhaH8FjMRjRpsOGgSnrEtcZx3ahPy/Q8zY2trKuasqBgQoS2x5QjEfZ6E8YRMK17D7zSzbZYcOeNiRUp8VPGAOJKLo5DjCAOnnm3xuFhX7zmJEW5W5UwLGd3i7CvxfOGQj+tFgBRvvXjcbx4r7UxaGutF70O5edA1uuKm6tzGSYaZxCFWu/Qsad0JedHNM2ffK3NkjQ1ivniFmJaeJO8BWOxNCaG2bPO2JVri718zlnsp2A4Kt0I/beRIDqaB38BV+sBHYTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lcWRLUuRGUZgiMFYby1sNEhICC3GFqhiiTUyXYTtXY=;
 b=JBHSB80wgi8qu2tc8TvKXGKR0L/hLzLrGGcTBUBNQ2qLQL0xLOi48SVJpNLN9pKtCK1LCTMNOy47FN96koVNPwbBQ5Ld2KX1iTgNUJpQQDJ9mv0IOEUcP6up+1do+sX3+fkqAc0WsaQSYplgp+dW965tMrZp1LhT6Ki3c6aZnOvzLVSCA/gIejg7rA635b3mZOurvjZoOhmya5VhGWu9YW7pVo5THlRSXdjpIGa4H3twi+gVKB/TntO3qmljn0LJ2GdHOC3PFtCcvnw+ZBLxK2DB9uvRnDLJznmaG8r0YZzNUTwlinQF0o+yceQUtoC4Hcpl8IVEpSVZ7rbdRsJCrA==
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Fri, 10 May
 2024 20:52:24 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::54) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Fri, 10 May 2024 20:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 20:52:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:52:10 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:52:09 -0700
Message-ID: <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
Date: Fri, 10 May 2024 13:52:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
To: Mirsad Todorovac <mtodorovac69@gmail.com>,
	<linux-kselftest@vger.kernel.org>
CC: Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Shuah Khan <shuah@kernel.org>,
	<linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Edward Liaw
	<edliaw@google.com>
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 04877da6-cb2b-49b4-a24d-08dc71331829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEZ1MTJzaktzbFhjY0RSMy9qaTF0ZU5McCsyNHRZYTIyZ3NrRllOSFE2b0NO?=
 =?utf-8?B?bVE4UCtBbTc1YVdZL25xTm9rbTRKZURQbG1sd3VNQkdKRHkyY3JFWG9SSWcw?=
 =?utf-8?B?aVZwd0kxUW9xUVlVS3A5a2hhNDBabk85SnZiU3o4ZWpidkhJZjZrTDBqaVpv?=
 =?utf-8?B?RWVVQUVwM3NwUUhWSHVrQzVSUE1xcDF6WWM3MFdHd3p1U3p3ZnZleXRWeUVP?=
 =?utf-8?B?cnh1ekpLRHhHaVB0VkJCVW9SWisvWW1LdHc1VVNIVU1XS3Zud1RNTTZjZnhP?=
 =?utf-8?B?N1YxNmRVV2QzcXEwVlpvZUhXQVM5M00vVjN5K29QU2M4TG9sS0ZIZ3BReWxD?=
 =?utf-8?B?NFVlRzZuWFFLUWxQSmlqb0ZkSmtZdWx1STJlVjlGdzRDc2NKK3NVV0E4ZytV?=
 =?utf-8?B?SDRUVjVnRlZQdWxQcDFYVEoyWml2QXRwQnJjeXBrdUJqbFlLT3NEZ0hqVC92?=
 =?utf-8?B?bDBnR2c4eXhOL2xCWEZ3RllWTEJ1Si9xaUU0YktjRXNWTm9sYk4vY2EzZTF1?=
 =?utf-8?B?L2VQN0VuM05VdWtVTmR6K09iY2pOL3VPZThiWSs3UlZVejNncWFTSkJuNnZM?=
 =?utf-8?B?Tnc1MFNQTlFOMEZYSDRodFlPQlFSKy8rNjVNRWFvZ3dnTmdqa3VBTzYzOW1y?=
 =?utf-8?B?WWQ0ejBxeGNmclpJT1JzdmE1MTJ0czg2KzZHRzdGdDJQOXJnTjRseDhlcjFy?=
 =?utf-8?B?NGRmME5CQlc1cnlhenE5bTk0ZG5hTWdHQnlzQklTRFlSenRqMW9GMFB4Q0kv?=
 =?utf-8?B?YXBFamZ6WHF2RUZWQ2htdlJpdmNISXNYZ3lBOS8vUkoxUkVXZlZ0UHNyR3BX?=
 =?utf-8?B?M3hyS1FHbUlycGtIbzQvSUV3WlFLak94OWV4OEpTdTVSYVEwTTlRNXQrQ3lE?=
 =?utf-8?B?YmIzL0ZoRDJyaHJZMW5jN1F3QXM0NFd4M0hJS25rdnZ4bFIwYkhwaFRvV1cy?=
 =?utf-8?B?RHlaVXMvcHEvUXkrV0FtN1ZXZVhISUZzZW5XVEs0L2k1NXRoR3pFcy9FQVJC?=
 =?utf-8?B?SWwweTRQQWJqbGVxdlZQanpaZGZ6QnBXbzVnVXZ4T211MGtiSE5TVmpJeEYv?=
 =?utf-8?B?V3VJaktsT3BvUFVFU3BtMHpiQk9MMmtvY21YV3A5TVkwK3F4SmZ2S1Q2R0Iy?=
 =?utf-8?B?OGFjUkRvRUY2SmRJSHJ0SHlkQStIaE03TmF4RG1mYUdzRWVJS2VHdUhodVkz?=
 =?utf-8?B?SjhjUERtTk5TUVU2NFdEOENVbEo3cVpOcHNFaEEwMlNhQUtmQVB2cjlia0Nm?=
 =?utf-8?B?RUlHQ2UzSnRZYlVQdWhFSVRJR0Fxc24yaVVWMlNVNTBUWkUvTStWRXdzd0lo?=
 =?utf-8?B?WGcwTnV0YXZ1Smx0Wkx6MHV2b1I0U1VsK0l2cU9iMUhZT3BMUG5QMk91U0tV?=
 =?utf-8?B?U0JQZm1ic3JaTW9DZWhmaTE3NUxGRVphMWtvbUJXa3I0V0FGekh3cG13NVg1?=
 =?utf-8?B?eWhVc1hCVjFWOFpGWXlHMnd0bE5tdWVUc011Q0pNTUhvTmdrdi9VWGQrbmt3?=
 =?utf-8?B?RlJ0MUFlaUNKSUlDVGYxY1lsak5wNlk3SlN4cGxibDdXeUFlcUxZc3QrUjV0?=
 =?utf-8?B?U2dNU0dBQjVQbDVkYjFQQ3dxN0F2Y2ZIa3hQUWxxZDFQUHd4cWd1Z2ZmRzlj?=
 =?utf-8?B?RG1ONUViOGJLTnlEL1JLQ3ZzQkZEMVlnbWdvQnJ0WkZia2xnUWRvcHMzWDA2?=
 =?utf-8?B?OE5NdVhQZXJ4dlpiTEd5MmQ4bWowaWFNMEpaMXV0MFJBdzlWSnBqMEd0ZkpJ?=
 =?utf-8?B?L0htN21GV3FsOGxlcTRDTnpVWnJPMUNDL1R5NWN2YU1kS3BwUWcvTy9IN3Iw?=
 =?utf-8?B?VXZ4dTRiaDdhREIrKzZnVDU3YzIxbXIyWEQxZU9UNkRKREVMdGZ2UURQT3lW?=
 =?utf-8?Q?tQu5XaMj8rMhq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 20:52:24.0701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04877da6-cb2b-49b4-a24d-08dc71331829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

On 5/10/24 1:37 PM, Mirsad Todorovac wrote:
...
> The fix defines __USE_GNU before including <stdio.h> in case it isn't already
> defined. After this intervention the module compiles OK.

Instead of interventions, I believe the standard way to do this is to simply
define _GNU_SOURCE before including the header file(s). For example, the
following also fixes the compilation failure on Ubuntu:

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 9820b3809c69..bb6e795d06e2 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1,6 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0
  /*  Copyright(c) 2016-20 Intel Corporation. */
  
+#define _GNU_SOURCE
  #include <cpuid.h>
  #include <elf.h>
  #include <errno.h>


However, that's not required, because Edward Liaw is already on v4 of
a patchset[1] that fixes up the _GNU_SOURCE problem for all selftests.

[1] https://lore.kernel.org/all/20240510000842.410729-2-edliaw@google.com/

thanks,
-- 
John Hubbard
NVIDIA

