Return-Path: <linux-kselftest+bounces-47983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5ADCE57C4
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44A5930026AD
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Dec 2025 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A11F9ECB;
	Sun, 28 Dec 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TIb2/wgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0140855;
	Sun, 28 Dec 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766959531; cv=fail; b=OZStVRqigO1Oz87n1gxL4wIfadFhbOr7e6xAxEv70uPOn4NNph+nz5CmdbR1csA5Z+HjA84T00igiZV1AhZfBuMntp0czsbPO19DXKpYEpCuIG/xvwFfkfBJA0+NmtkahxnMEXRbeXwtjPy0aosxCBN/c/tzXQqgSWS4UA3q6og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766959531; c=relaxed/simple;
	bh=Ge1m6oTYAfufBHehUGwMnyngt3wN83r7Q4FfKOxVRsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l70FEnWAO9Xy0QriCIxGNT/XEklGjKFF8Qyx8FQhYYOZEfFjcvqRpCrOjwyZXMRNKYbqr9DptSgHdLeWN7IaZQQTOo79hm0vbjskEGOkGa3/bXIZWGwv6cI4db7PsoF+ap/Zofhs+VGxPCKnMoCe/QXzWAvZsfsjexPMZpYNqBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TIb2/wgl; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ry6aTeCue/8IC0TDjln4GwPRh614mU7cVLIHOUAuTYrMgq6K5Hnyexa9IV808QZUOqG3+rRMDDIVWb1yxaQzItB5I2y0rDxt0uNnJoOCsmm594NNmmAfMx3A3FZhaZGY9DRfeNY6EDcEnm7hEq91Fvb5fDC2Crpw2e8m4dInc8F8yjwotKA+kvT2opTncKJuRqmkYNgmxolkD/PdqDXoBXGnSR2WTKoB7LaELLSazU0R9FI3C0AQFul8PxMSwl1NumqwjavS4tySdhEYbIScBXDvwW4TmVE5834ZIcISxdbZhakq9p7bCMjQOM2d+DQS/Z+yhAJnVID+azmzXbXXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2fhcbfBbZqvLrNo372HHlWrX36aX12jw2K6IEZv8Zg=;
 b=PqEI5dmTo+HP01LOaZnQETY1R4CD3uo+l/CUoQXBQPC9QkqDjcMeJdF7RYDUQtyJFRZ6rA32/DIQWBfuN+/ceREQM4adbzKnurjSBW1ug4dnxSHYUNUPM/5HY09vZ3GNjnT2uQSBmuNHdhjAoafaDvadLNbhM/Q2GuXMnNxezrESp0HU+gZDukusNLhCBeAQH32fjreWluEZP/J/oDFGiJ3lhP58Qe5OxHuZIy3X0ttUhvG5fN5BbbnU1OYXyYTmati9g8djgiAhmdq7KF8+9sDDjjCgr6Dtu5sLEiRsvYpKuOcnZhB6XP4GHgIqrZB4YAoGctqpBr7p+1jRFPZB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2fhcbfBbZqvLrNo372HHlWrX36aX12jw2K6IEZv8Zg=;
 b=TIb2/wglwO2fo2KTlxOE7NP5CGFxypZLYlY1fS1g+dfhnkt/lXJtKz7OlJov9vKz+3cmg57onOiVrzH8oY62tTVIWOlzeHr8VwD2XZwpkJLhfrDvRtMDNWtcrOyr8e+UHhlBR3/R1TRL5ASIf9cxHwvfCnxb5wboc6eLLxyDeH5hTrih32/0n1hHVco21DX4L5Kgn86Cby7G8RAKXVLsX/sCAlCFhE4DntXBsKCdnWUhoimoJGTCgLR6rZ5+riVnT0v1qS67w0WPs6OQgb16JDFFiAV25STcmraXS4CS1wJF5yQMHmyHMldySNcKz5gbICqLlgB/fF4Fblg7aeGjyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 28 Dec
 2025 22:05:26 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9456.008; Sun, 28 Dec 2025
 22:05:26 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 2/2] rcutorture: Add --kill-previous option to terminate previous kvm.sh runs
Date: Sun, 28 Dec 2025 17:05:19 -0500
Message-Id: <20251228220519.150179-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228220519.150179-1-joelagnelf@nvidia.com>
References: <20251228220519.150179-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0059.namprd20.prod.outlook.com
 (2603:10b6:208:235::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fb9d7d-bc5e-4ec0-d687-08de465d34cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9yZUOhZPWlrPjioL8XupGKeQM4eIsuAKYq9v0DXY3SU6/eE5hYQ+l3eCLA1?=
 =?us-ascii?Q?beJxeUsVLtNN0o3i/jIBZbrdhwAkk4dejmS4cyL8UFgenB/1Br9j+a2feJ1l?=
 =?us-ascii?Q?3XoJGnNk0W6xeDYTUfEPzRVAMah3xyd3j/vdvHQjuGs4baQSlrHiSnyi2Viv?=
 =?us-ascii?Q?jQTcuVMB/wR+VKiY7eHo2YFone87voTm3z669hJ0GSzJcST+igkzPBdWdjwJ?=
 =?us-ascii?Q?sYjDH3xSbmvEFUNfgGdq6DZNX2k5GL1RvC3wfDiwO/ALXX9SM0LrrKTiFkn3?=
 =?us-ascii?Q?IncnDhlFRNzkURrgz3jnZ9AXrNDShlphgQ1Unba5WaCkDYq62iATPwFTtbvC?=
 =?us-ascii?Q?6Ri1+ZFRplABlEZwVp/knncUm3BvExgjc2w5UwUSbZA+ucFFX6EML/nGMoH0?=
 =?us-ascii?Q?LadVwGH1OOBgGK4npia8ZIjZaY6XKOtKwQzrGU4TQt/TFymzc29dbOtWaCj9?=
 =?us-ascii?Q?PtJAn+lOCwRHI8JA9AWmCG+3eeKX8RJq/4BfBWpkruV/o/xw5IOL47M9bowE?=
 =?us-ascii?Q?ySES9GFI8iGTxl12ZBfP8YsbhzP5T4GpG+3dKHByFwPx9WkX099JHiJEwF4p?=
 =?us-ascii?Q?35m+6QHemzcctbLmi3OlN3nDApTxPJpKLll8vy3OpI4iYoWPpt1Tjg1iY26I?=
 =?us-ascii?Q?0Cbt7F6HJUcq0fIwkLT/0+0VcOQE4j3qOHkjUOCR0KJSqy3BRXlxW8qLPB9S?=
 =?us-ascii?Q?Ux5edgqhMYoOeNLj/Coy6TJA2x+IrmLD0zj0PUXbbUBI5taDjW0WSCklnkPS?=
 =?us-ascii?Q?t+bRHqR1tcujLed/kV9f6Oyr20/qhXrt97RHtTZLXPIBxjD5RaaFAHnCJNKA?=
 =?us-ascii?Q?hjOaDwZ7Nd4RsA905EiLskh0oBza2+FtRfdarE1oNmajamjSRZytX4H5xko5?=
 =?us-ascii?Q?9oCW/3M9fyVLoCx3BDUtg/vcylWmZFFYPZih4J0yPe1qkFsJhsGi5ykmyXcS?=
 =?us-ascii?Q?aMIdSmbWrYvhRvYMcdhPbq1SnapkHUHi54MlMIYY12nF9YQ0xXL6iV055uvF?=
 =?us-ascii?Q?mj1Z3vwgT+UG5u25U2BLZEFAQybFQ4pQHuYe6BQUtjLr7IJTFOcOBm2n0M1K?=
 =?us-ascii?Q?EuZ/v9B7kQLK4fO0CZZrDBVXxoJFdjjPfVtugN/CLOWwdUiO0CutWJyGD0Rw?=
 =?us-ascii?Q?hLEdcbewm5j7hIeHaoH5fevqPbVRl1Ft+UipELnhgh6JIHWG1Rs07w4akBDq?=
 =?us-ascii?Q?3iTrAbwFxCyEeMFzXqdq7pSZg/WnmWV0guji1SPijK80640VPXU5Zl0Mgea4?=
 =?us-ascii?Q?J0/CUuF+ngIQPViQ3SyOqVA5fnh4CY2i2g5Bbl/Fk11KG2o6oz3DbKyveGkS?=
 =?us-ascii?Q?CtRL3eDN2R57u7DZTuGOs+7H7A5fxrmCToN2n2AHkcH4WgIu5A6F07B4eDdq?=
 =?us-ascii?Q?fDHgG/iwv5m+EImTcRE3v0dPkAwp36R0J3WSiXzW4dWEqZqzFxeYWSWWa7dU?=
 =?us-ascii?Q?ii/utlozenovv13jSjAR9R3bT4szpW9n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKPruZZnS6joh1pW3GZW656LeLo+e2WOozbhPia0v8ZxQSQZR66jMqT4GRUm?=
 =?us-ascii?Q?qpKjp2gaat9NqJhUpkWDIMSSCLFaQPH51O6eAfmoRCQLiJFwFEExIjkv0sEO?=
 =?us-ascii?Q?LZzFopdQpkQzVkoz+kKqKrXhdrXQqu6E8jzeEY7MO/8vAvkNkU/bBJtuRlPP?=
 =?us-ascii?Q?Pvms1QvcZXw2FwVliT/P2xhq4G4Zv1nrhFjkzO960jzLgPi3cKHMR8AA702Z?=
 =?us-ascii?Q?Ih6Kv/5vHp0q4gM5cxpY9GeNKQHowxuMTUAQXePOM06CwQ747zkQteLBOg4y?=
 =?us-ascii?Q?QnK25LuiMvpZNilXyziN8y4kpzQei4W+4vqLULVuWtvaz8GJ/0Y6Z6/GZizj?=
 =?us-ascii?Q?pznH/aXxi7ccWsU+pYHVMse7BxByzGP0k/L1oioQ7x8opZ65e+78quKxolAL?=
 =?us-ascii?Q?DcdStG/v7mhKd2IG96jcHRY+e7L1WpOIHV9MQBEuwuDwLZquJ+pyCcoJS+IM?=
 =?us-ascii?Q?aWDDJoRvT2b1VGGy/l1Dv5T5llUNNWqm1oXEcYyxry5XZgnQNrR41dCav/yE?=
 =?us-ascii?Q?TmgC6kFwh9CGfYhmO+rnFX540VN/lktcEojPhbyUqUTsRrCCrWOHkw5AQN3G?=
 =?us-ascii?Q?H+0G2T3orqWZ8jL3V5rjOApXXWz2tY/AXci2AKZySH7+CXXZgXskwv49lKce?=
 =?us-ascii?Q?3Y8CD80mOdmUwEjY3qibUctLHeyfVxgqXy5wEUOrprASwdQ6BN47/JXu2Kh9?=
 =?us-ascii?Q?tHXcINy8AucfJ1gF0WQApzKUH8sDVDODvedXFhyvZRG4rIXNRdmg9H6is50w?=
 =?us-ascii?Q?nzApQy6E6hKxgGBg+vjGi2gKv+XEpsPSJrXuRRaeWWG+OfSI3GP3rYhJXWml?=
 =?us-ascii?Q?TIVyGCPOGIQ3+vIl2pI7CZTnxF0No8vo7+LvbQyK94rvQ9+RxnoMy1gNYFLs?=
 =?us-ascii?Q?5QrnDfomKg8zkdn48UROGo2QvAKxXFCOaiyRabdOWfXLvWdWzWg54MnJ+vLJ?=
 =?us-ascii?Q?8dVvP6xBEnlzLyb0AQZvuYVxJfR6zB21reQrKXe72WB/tGJR7U58LpFB2wus?=
 =?us-ascii?Q?zlc/UKRHkKxLNYQNGwhT5ghvZdkLca7ZWODIlOfXv3EDPD1dbLRUnADKz8sn?=
 =?us-ascii?Q?MJEbcLnlGD187VrKzLpYNe/NwgBJ3ZD/qiL8F0tfe6Xh7s8kdBPpgTuJvu6I?=
 =?us-ascii?Q?GiMN3txDdf9pK6RkNgWMw5G0nWj9Cdnk9/6SC9GaAae0SvKNv0BBm8MvF0JB?=
 =?us-ascii?Q?F/2VF0PR54g8WsJjFkrFc6JKMGCABoXrQgHbHTnP9PHNA0+o8nQw4w3cuzv7?=
 =?us-ascii?Q?FrSKznMbeuPQoEzIr5r8jWiQ6VuS7Fzt+xi7Aql96BOKCDW5y9p/3IV9eEU6?=
 =?us-ascii?Q?9cbIGedtqBlNmtX14A0AW+mfgM3832rhz8tDp4lHDx8lsApWQ9Ah2eHIJ056?=
 =?us-ascii?Q?s4fsLX+eGU6qIkLuzo3cat6TJPe49gPeKH1MLt2AbE/8QPrCEbVbpIK1g07W?=
 =?us-ascii?Q?FKt6QMzTNTDv+vNc+mJPosipaMybs1CGmuk8wWFShCyg/ymrMJ+CtHEUsgGQ?=
 =?us-ascii?Q?fVzwdnTTpp/tKQSvaSk3x7nDdCBP5fL2PKcO12HpiTZNW6X75omp4QJjnz/V?=
 =?us-ascii?Q?44ZMo87CY7Rbg8AOPIeCWIdtBlGjNx8dNguFrS2z2Q9CBXXNOig5NimTobb3?=
 =?us-ascii?Q?wcooZ9GN1N+5EujC+XkOcMq3B83NWNOp9NgkwB6SRKxFvnxNX+xxxOLVhppM?=
 =?us-ascii?Q?Nr+Iafdn9qSsVYIk80ZNJoRsOXpEttOWgMEQVRmWMmdYMKsK99YAQ564G7iS?=
 =?us-ascii?Q?6Zss6FOcRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb9d7d-bc5e-4ec0-d687-08de465d34cd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 22:05:26.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y07I6KVxVUjQdvrO3U6oEZfF/gqQwZPI/F5DlO6ODqTzwbYPCjcxu7/BmY4SnXMy8q6H2/ohhnPHlE3bSfWt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0

When kvm.sh is killed, its child processes (make, gcc, qemu, etc.) may
continue running. This prevents new kvm.sh instances from starting even
though the parent is gone.

Add a --kill-previous option that uses fuser(1) to terminate all
processes holding the flock file before attempting to acquire it. This
provides a clean way to recover from stale/zombie kvm.sh runs.
4. Proceed with normal kvm.sh operation

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index d1fbd092e22a..65b04b832733 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -80,6 +80,7 @@ usage () {
 	echo "       --kasan"
 	echo "       --kconfig Kconfig-options"
 	echo "       --kcsan"
+	echo "       --kill-previous"
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
 	echo "       --memory megabytes|nnnG"
@@ -206,6 +207,9 @@ do
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="$debuginfo CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
+	--kill-previous)
+		TORTURE_KILL_PREVIOUS=1
+		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		TORTURE_KMAKE_ARG="`echo "$TORTURE_KMAKE_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
@@ -278,6 +282,25 @@ done
 # Prevent concurrent kvm.sh runs on the same source tree.  The flock
 # is automatically released when the script exits, even if killed.
 TORTURE_LOCK="$RCUTORTURE/.kvm.sh.lock"
+
+# Terminate any processes holding the lock file, if requested.
+if test -n "$TORTURE_KILL_PREVIOUS"
+then
+	if test -e "$TORTURE_LOCK"
+	then
+		echo "Killing processes holding $TORTURE_LOCK..."
+		if fuser -k "$TORTURE_LOCK" >/dev/null 2>&1
+		then
+			sleep 2
+			echo "Previous kvm.sh processes killed."
+		else
+			echo "No processes were holding the lock."
+		fi
+	else
+		echo "No lock file exists, nothing to kill."
+	fi
+fi
+
 if test -z "$dryrun"
 then
 	# Create a file descriptor and flock it, so that when kvm.sh (and its
@@ -287,7 +310,7 @@ then
 	then
 		echo "ERROR: Another kvm.sh instance is already running on this tree."
 		echo "       Lock file: $TORTURE_LOCK"
-		echo "       To run kvm.sh, kill all existing kvm.sh runs first."
+		echo "       To run kvm.sh, kill all existing kvm.sh runs first (--kill-previous)."
 		exit 1
 	fi
 fi
-- 
2.34.1


