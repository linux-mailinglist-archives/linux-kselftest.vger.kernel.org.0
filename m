Return-Path: <linux-kselftest+bounces-48049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8FCED2B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F553004C88
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9A2EE5F5;
	Thu,  1 Jan 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEz2aDyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BA2EDD76;
	Thu,  1 Jan 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285290; cv=fail; b=QNQh7AX0qVazpYID7OtiHjhLUbcxArheE2IAdowBY+gu5ILhvUeXT/kxchAwgh+/EtMMAu3sxoc5GfhKCbikSyU9kSFYykVFLBwqGH1JQd2Cxdn6elrNBzucOrLj109PQrT9pjaHhyNBFIDa5ORp177wY+Rcz625GIgtSIfteEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285290; c=relaxed/simple;
	bh=RA3yiJ2qYtLwIa/F6I9RBtxOBJERYumC7zocNCkLsOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teVlW42MysBZrIEDiGuNeCa5L7Lr1onBFNufExyEFHEISSajor1mNXWxyf1qoP6MEJ6Wv2y6/LqdfqcjXJnje+Y48kZWxMIRjJUEDFUNuN5mMHWD5yTtqlvkh09YawZ4huxPQQBU6OROs+z+yis3c5/BxyRV+v3qs7P//3hOgtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEz2aDyJ; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkJ4eJjTwl13iP7tP2JxcV4yj8AZmOEe6xihzXTjaVUW36u5QETQ+bIgYlpZFqOCjqhr8YMuRie+qFlHsnV3sc2y4rXRnLZgZxMstdM3Nj1XlTIxXZH23Ph/SGOGcNBfX5uegPPt++XZrZPteqcs9Sr4AlQIIXMJMxBsuNCz7ze0feuJLBezQc5DSApurLZNGOhZEwgExfOhUjUl3c5PS6s2porqJTGyf2PGz05XktXPE6ZBrOfZW5/siMJ2OLUdI/iOvo7nRrckSoY3lIlhGCwHlzCHIePhIYYMrXm4Dzy2yVDqA1X7P+T0Ku0MDozW5qeC1typAFlf/uNWePr7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w/Xii9SVflwtIJMwbvkeS0Tyvq9saaTwQ3xQHUOsxU=;
 b=VMOfSnBKAL8hNPC81lXbIb8fCFopw5V+LC2pYFIR06V/inWfPcU+fhGSsXz1TU1eBBQlBWjjmtMwcdXFG/Egz/DKYchLpervA4cn8i5e0BKgRH/de5/EUiVgrOxN9V/3fz1/5XYczBGBGGk+MDGWHPFI9hfjgp3v0UjQsvBJTw0O+zTzpCgysvOGHdzl3fOOd/0ypAr8aafXWFEPB3ARw0UfXcwpn6jpwhnw4TwhBX1X0B4ZGzBnCnUl9uc3BtErGVNkmacEKQXxvYHm7Xs4VW9q7fgXmZ1xMj/k2QZi/iJlg6B8XjUUtUf8bTGD2ZhpDoonrADWnw2NMU9RA1lxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w/Xii9SVflwtIJMwbvkeS0Tyvq9saaTwQ3xQHUOsxU=;
 b=AEz2aDyJWhxu30qTufaEgjyDs4VrLQVJslK7UOmuAdAhALnKes5d+d8xgaZod5baqcXW07wrA1PE7J/C7HbfM2pbACTcLtxm7hK1VtATOWom3mmH3+HYENDJntea1g9y9ITA20EJLbuoIREcIseGFVxYaDzPsGyxlhNiFT09ZbeCKxSounK5qP7pO8lB0X8PMdEHibPtNMUzb24lYvUCnM+mnXE2W3PncD/gEY3SKTOj6l+bZWurqJ3O0H9+iIyS6+y7f2bDchNIk7R0Hbyb6E8YfnwjVvyxNIiAq6XY4DhtnQBhwKRISBQA24hNxK/8Mjmm4+nhiWPahLdPzDnT8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH -next 7/8] rcutorture: Prevent concurrent kvm.sh runs on same source tree
Date: Thu,  1 Jan 2026 11:34:16 -0500
Message-Id: <20260101163417.1065705-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e208f3a-62f6-49ab-85a9-08de4953aa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3w21IqPLL7HdJBZ876pIcRjNEvY5IKw8PrvXeXFTyQ02Hmr566Hteq15aCi?=
 =?us-ascii?Q?qsBDWbq7Si7Jmmk8L5BwKGfOzSCZfGy1jXe7OrtBLyv6FB3bp03AceT4xEUc?=
 =?us-ascii?Q?w/y5mW3M5zFqtnQNSbT9MtIx4KQw4mkK2vFsSpvTTpTC9px/1VMNE98VkiT5?=
 =?us-ascii?Q?jakNRecSUr7SA4c3RYC2pBbM8gm3uQevcBOFkanAy2HTL2E0UnQzlpORTz+I?=
 =?us-ascii?Q?/lUMMW0EmO0LJ+dTp1jYVe4TB5nogCq3NJWLzopBerTHx581lj6G7KSEuVKe?=
 =?us-ascii?Q?DlISnJQl9+pTTEsHwwTD0EnuRpMe73h9LBYKzZLImhy0LN5pwFZ7X1UshCKD?=
 =?us-ascii?Q?Hz3XYcqSc/zacdRlVCBxSSmG3ERqcY1sg/8R2TVgdLBy09wSZpq0rAiNDuvq?=
 =?us-ascii?Q?9nlzJPXqtqUq4ZaavPPUJ+B+i/SeDZSrBJFpQ0sS7tGsDyTNejQYHgYlWcWc?=
 =?us-ascii?Q?8EEXR6geu0RKa21+ayUe9U3r/XJPDj7fqagLkctIt/RNQ0e9Vxh4EZxdZdAc?=
 =?us-ascii?Q?Ws8TJWHKEC6t+RrRzPmlZR9KDhcLZKCiGuprPL9/7+6TJ92oYomoz5BoiNRD?=
 =?us-ascii?Q?8EV/F7igROHWF9H7M+n5hsWRCupu9NexjxzyGql7dC/bW34GS5qq7v8CrFig?=
 =?us-ascii?Q?hkJ8EXTGArCXAAeCAthN0xVY+YIhCzRDQMuOxISXcrPAdhEkRAdvRpDCy5xx?=
 =?us-ascii?Q?oPVXtEVTO0zph/DBBVH5sf9EwwguGrnXJS5DkaceOHL+Go42JTGkJ2b6E9bO?=
 =?us-ascii?Q?ZQKTi4tVROGKIWwCEoQV5rt+2SqIaw2MZwFJq225BTk8rqJsBUFrPIAZbxm3?=
 =?us-ascii?Q?+Zsyuqb9b+WNo5FbXUec3hSkWGUZnXAL8vCcnWNlj9aSpxD/bo/YQ1FN+Pab?=
 =?us-ascii?Q?lKXpxwo2GyXQoi9COfEuF/80C1lwX6Zhz2xBa5tnXRb7bX5yPI0IzmKwSvYq?=
 =?us-ascii?Q?hsl/EixWHOQ9qRn5OwFQG53oJmcwTkjEHXgwpGHKWb7YhMoAhAZaCmJKP8nB?=
 =?us-ascii?Q?yrDpfHyi5g9YS9loIOcaLyVBmRj6Idm41XRNObpxKq+yogtYPMXTTd/JnNVR?=
 =?us-ascii?Q?Al+2MtYNc6HLdTSPcxbgvLjKPvByOhYYZmfYdE8D4ri21GCD0h33vE/V4fRs?=
 =?us-ascii?Q?mMZXrnB6YelBCy0kBoO96UuZ4f8BqL5N7oRxFjfjCaCn65R04iKDdSXNbFck?=
 =?us-ascii?Q?jFdfXZeC78LhxOVZseVS9Fc/01CQUuXvz85kuHJ93DrFsqTnxFybGZr45Z3X?=
 =?us-ascii?Q?yRrOwqFa5xxcaUE8KbO0GSYP0i8g4WLHIvBdc93A8PF71gj8ewPbOaWfBWVA?=
 =?us-ascii?Q?XkebgeVR1C4sWLftKSbensYXnSz5zGGgqQwThByzhvSZRCxaIRSETO3p42VN?=
 =?us-ascii?Q?XL6MRTH2Za15wU0xahUVqdotFWwMviGnY+eiONQ7Azck/RFrT5kYJhVhY3oX?=
 =?us-ascii?Q?WPm7yg7KfMN+YQ7JL1zd/uSpBFfAzhSB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7e3uPR3N/S1KHbPWLEFyP5aZfcHFWvxArpQvGyYRuO5qrdsvn53GXyqUgSXj?=
 =?us-ascii?Q?QMHmjWNAH2mY5tl1CvUIt4+9FQ2hcKL1Xz8MhgldOzYKpw4aMbhaHS7+bYi6?=
 =?us-ascii?Q?dqtXWx8HbRmUBfwZv9GH3b6b7aX6gbsjigehqoyf4HBjjj0fVBfHWzjbuae4?=
 =?us-ascii?Q?KgmQJ217L1ALy3BTADVEd4S9koZfqoPqrnBVcGiC3+TaigKFdUDi2nOHD+tl?=
 =?us-ascii?Q?VYzfE0u215k9PmL1YtFpedrqRLOPmGLlOCkdgFxvQys9ajHlceRJxGWyEgf+?=
 =?us-ascii?Q?PtOiDL8Ig7NRVtcoKOxwgj7T17goYa1w38jZwrMlu+bWlM1LHjOO4S2A0Vy8?=
 =?us-ascii?Q?HEIyGLsfSR7IgBh4KGUSioENbSJDmnV9sbYwbXW106KfTLxsL81DA1zshmSN?=
 =?us-ascii?Q?zcPJQRu9KLC/YpQATz/vOELiwLhF9+pk1+RGiu93yifrpRXiBLGw9HCQRyfy?=
 =?us-ascii?Q?BmxotiLvyrHCMn0zRfa9ZtLGKiKXaAEMfyW5PcxqyZaBCocKrRoh9k13NGJM?=
 =?us-ascii?Q?PmiRzwi/r9+0hHdk3TShglyG/qVnJsrrXbsEgbJFAK6zbVvVPmBlUpjJlrOD?=
 =?us-ascii?Q?S6AAc296bxTPePWUOma5diIdK0geXBYxGIWvlUHupYENb4YsyNZGAI2Ezk0d?=
 =?us-ascii?Q?BBPjDCkM/BUqLgq4bjQAyG55Udh/e+xpP/UjvTiYT4BPBYAzvCZt5I6VuUvH?=
 =?us-ascii?Q?n4fXfpKxYvcQXxDT3L+3Y0hGkGEjZyfqQmWg9CIOFZUHjAuRBI6V5LysPrML?=
 =?us-ascii?Q?uNHQiafEiHHjKK9FLKf+YYkf10kuDiwdg2A8/+T2HvfCVAVDvi0OYcSE3Quh?=
 =?us-ascii?Q?3FTKm6poxbHUabZUe8JHb3UiKKLEZc0om7LLGtX/4MNjgeDAeoIaZqoV9P2p?=
 =?us-ascii?Q?N6sEjIxkg0yR0rjukX8upT86z7cqwUCv/Uz1pFME7AyPwQV7YBPPBFz3w+77?=
 =?us-ascii?Q?kPv1xvEhtoxFV7obVCQq/QpVdXU6LUz518sur1b1ndjouWi5TbWuuaz6I2LY?=
 =?us-ascii?Q?U+OTj+Ud0zAgyZvOEShkJVAQUvr5HVFiX34wEjR/t7gD1/NyIyp7R7TXIa+k?=
 =?us-ascii?Q?c3fGyV/oPnSY9DLUZDv6ldEuKzNe9Kp3G23d9AalKASpzAkOLV452ffwgTqk?=
 =?us-ascii?Q?s9wBlqrFEYrF41k4nZyTuFrQxmMk8Ab/Z78GCRhzSY/DhPlz9IFsBhXaw9iM?=
 =?us-ascii?Q?YfF+i64qmaa0J3qdmnR2EDxUvzW3oyA0w2iDfg27/9TLxEJzjF6Nph9FDt0Y?=
 =?us-ascii?Q?YrXZQZkHhGpRG7JnmnJ+i/PWsdszFiJpSy/o05qQMb4q30JlgeCEXihpzeSC?=
 =?us-ascii?Q?eqalbtF0gvzkfaSrr88IgQfXxi7LhgkoUtp9/m7RyWdmsFkPUGnCSJ9bZJos?=
 =?us-ascii?Q?V+CcOnxAH9MiC/aVnjazrFPoQqgrOSJ7psu5I0rL1LjdqUUQ1xcBsbgecbzU?=
 =?us-ascii?Q?kBeQ0wySDcsUHfhOrkye8wRLy7SixrgybE2iwyZBON3wy7v2+Qn9Qbeg+WDh?=
 =?us-ascii?Q?XFNiUR47tzPKINeA6H4xZXEF2Z21bNkbknLcLFGXAH/5QgImJNg8D9P5KPwt?=
 =?us-ascii?Q?oC1CWwfrPyAUQ/6fdnd5oQh87I+nwDUkY3XFWUmw+6QirqAhV6CQa2pP/Iog?=
 =?us-ascii?Q?zNi+tLZyGzwd79M1C29Hs3Upd73hYr6Afw/I3sqVP1UpOLOHz8i+6PvHFHq3?=
 =?us-ascii?Q?LGyw79/JMyYR3P9rPPayVtWk8QMWUHOtk+odgeKsgwIUbAXcvu4Srvl6pxJO?=
 =?us-ascii?Q?4tNYohZ6Ng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e208f3a-62f6-49ab-85a9-08de4953aa21
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:41.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAZc1YywwrIliihH4oRNRb4JKGL1GLHH3utkSvAGQdlQb7Wjl3S0pY0nDkdjwwWbtgfCDtpv84ZGQXiljiHAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

Add flock-based locking to kvm.sh to prevent multiple instances from
running concurrently on the same source tree. This prevents build
failures caused by one instance's "make clean" deleting generated files
while another instance is building causing build failures.

The lock file is placed in the rcutorture directory and added to
.gitignore.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/.gitignore |  1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/.gitignore b/tools/testing/selftests/rcutorture/.gitignore
index f6cbce77460b..b8fd42547a6e 100644
--- a/tools/testing/selftests/rcutorture/.gitignore
+++ b/tools/testing/selftests/rcutorture/.gitignore
@@ -3,3 +3,4 @@ initrd
 b[0-9]*
 res
 *.swp
+.kvm.sh.lock
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fff15821c44c..d1fbd092e22a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -275,6 +275,23 @@ do
 	shift
 done
 
+# Prevent concurrent kvm.sh runs on the same source tree.  The flock
+# is automatically released when the script exits, even if killed.
+TORTURE_LOCK="$RCUTORTURE/.kvm.sh.lock"
+if test -z "$dryrun"
+then
+	# Create a file descriptor and flock it, so that when kvm.sh (and its
+	# children) exit, the flock is released by the kernel automatically.
+	exec 9>"$TORTURE_LOCK"
+	if ! flock -n 9
+	then
+		echo "ERROR: Another kvm.sh instance is already running on this tree."
+		echo "       Lock file: $TORTURE_LOCK"
+		echo "       To run kvm.sh, kill all existing kvm.sh runs first."
+		exit 1
+	fi
+fi
+
 if test -n "$dryrun" || test -z "$TORTURE_INITRD" || tools/testing/selftests/rcutorture/bin/mkinitrd.sh
 then
 	:
-- 
2.34.1


