Return-Path: <linux-kselftest+bounces-48050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8BCED2CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 01 Jan 2026 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E7013037CC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jan 2026 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3622F0699;
	Thu,  1 Jan 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Srmdje51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312B2EFDA2;
	Thu,  1 Jan 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767285292; cv=fail; b=c8uuWBQBaXEUVTjzBm0rJ4astYKbjYQzyjGma7wbzjWyTFbYwB4HPAf7CKO8yemQV7oqpUSRqvCEMgmmHWqDHeEam2KwgB/DimT1hvDtTsGjmWZF9ZeqhOYaO7i5AWtR++s7D0vvbXe4ndkyxBxpQeBHhJJjr3tuMX9+WGnf2Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767285292; c=relaxed/simple;
	bh=gU8nNTl6otSO01jtaIR7HVYcgsxYAyhkmShfFTUlgfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upf0gZ4VyRMo4yl64lwJk4c3UExgvwx3rdsqHD0FBdoySNmL/13/W7XYWdb/rH7g6Qu5G1blqCZWayDbkoy5tLa83ePrDlhZEjobnc27BknFxZ3MbSdpvWhDRozVJ9/rx0tpRht0VcNPwCeHWx1xDDtb1MiN4FeSIi8xrYqhprA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Srmdje51; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHqJTdnh+PpyeXtf4Ze9RRoKnxkz1mTFpmTWBwHQnWo9V4nyph2j7EolX45widlu8gnzQ4VVTOFySOCd7vPoFjg/all6dFO4UKMWsFqKdVJ3CcuJDe/vt6tWKKQ1d7xmnZaWAkHccm/d7S7xt3AUNXtPzAOcdQ4T5b3NXYcoWy+9ZOe4/FxZp72YGzl9lgKenaqqNqtq/5myf9SaiYNpQmXUhWsCdVak0ycuJ4X/lfXE5ZH5OpIKvpKbqXAOtlGOo8hvAXqzDCMTW3GebfV2eMHx4JgC4se52rWXbOxFLmbEacARH4ThhZl1o4UL/6gjJz4DmAXE4xdOj59OzIYohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbzZ3fbh8LIIqL7Q95txlykDZ3KKGiep6qaDiQ1SYMs=;
 b=cwhEO6/XWRbGOSXLsjsYfgLIjYiiGDxaNvZ+FUJ1yfgzstF8bb4/K8Qn2DlexrKiecgnpLciQaeJUywp1vVnzmrFz9BuTGPyKcwu+hmPO4Vdrj0bLBREvvL0HNa/h4SrlhNqHCqjxvl6xt9QxgMLlmNBD0oaXcr0HAa6JLoRWquIK+5b3xwyJK+/Ac0OcUrOjMAMirzmndeqqhzCNo/3O8wpPhPhFgwaH8+2oiYbRpVXOBnQKi80h+Dsk7tpdhr8RcvuGLlRgkrkD/pEU/R0tvSyP/0kJRLRXyjmluh2PeYNDmhv8kGl2G+/KC1HXfdIabvtkIZvShAbNxnFwiDZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbzZ3fbh8LIIqL7Q95txlykDZ3KKGiep6qaDiQ1SYMs=;
 b=Srmdje51oYaR4I/6XjdV3j8cAThLNwlpB991qAkNL0B0nQSqcN+cXttRy00/T2kmOOS8i8KGEzGRI2Z9yIR4/1WEfOqPoIrmrAXmYRw1MjZ9+KuNHBDtYh4AQkmzfZeAk11BRAwIeICaQj4uGLve1WaCw/yG1kXTtIJtSSgdN6dOyiRY8uNtqZbbrZBtLS978OjWhaznVZZvM3dMUmCL0K7EVRMAeLJVQnEXl/u/U2WoupH08ct41FU0JKkm5u89zUOmTMYKd7P7IMC1hRQ7qyDUqLLGE6igNa3Ucsgbthlbkwlw6yBr2YBZ1UeRe76QX/uZ6rprOKIx/TZVUafInw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 16:34:43 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 16:34:43 +0000
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
Subject: [PATCH -next 8/8] rcutorture: Add --kill-previous option to terminate previous kvm.sh runs
Date: Thu,  1 Jan 2026 11:34:17 -0500
Message-Id: <20260101163417.1065705-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 923c83b8-fa01-4074-fd28-08de4953ab37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?icdgFN/sZiIEtGuAQ0FD4WuvzQOu1qvTEYGskraFIGgAw/Q1b71g/tifMhK3?=
 =?us-ascii?Q?fImh2x01xypo7FVntToYyB6rsvfN0v3FWmq0xsbmQlHYg7KqILjU/7XKEjKS?=
 =?us-ascii?Q?r1jnt5DPa7HPsSZp71UW/mDBAd+8YxqVdPZM5iARmcTaCS0SHw7zxF6H4u3W?=
 =?us-ascii?Q?G2ynq0Vue/QYJT4K0ZGsoutzLRpPTpsPZMXKCs02f1xEEZguXLrKR7cA0aqg?=
 =?us-ascii?Q?ntTWrwb3cSOViIyeoCrlZsisAvOv6YReEdCW4GcI7tcIe7h+Ji+W/6wOCANL?=
 =?us-ascii?Q?s5HZVFkwi8A5Lcqpgdbm7jXlVaYbipF3C8LgeJ6nXYvhWtmtSvIME3F4VBO0?=
 =?us-ascii?Q?QB0r8Kyn044K/zD0AfGUfeccKr4lwMpQyM/7RzUBnZuCN9ds4B2JGZvTJ+3y?=
 =?us-ascii?Q?mM6/Sc9o6gXi6UEODlPHgxf2fH0UtwmFwHCn7IrjECqCgDjhSpphBlBkqBTi?=
 =?us-ascii?Q?TGM2ZQusPUBoAnH941FMx6Mx+YSWkt+jmKWU+21A7ey/LjaELGdD1RACAXFR?=
 =?us-ascii?Q?MVM3ZAUvO7YOqRP8zOifQHSJAqxkRDMAFXMOhkiyAz/9x8t/teVlur3rtQW4?=
 =?us-ascii?Q?/SCGki4ghnhGoqZgs6ZQ7F8b7E3U+6r1zvvTOP91pWYrYW4804KXAySUZeKm?=
 =?us-ascii?Q?XWvjbmE66F+1MCQS4Jz4nUgPdCh+rm3Mme5WE8qv6j6J0A1agMHBnNu4Ojmu?=
 =?us-ascii?Q?dNssPGn7h9mbKLW4twTqclcMUf15HtlZXItFNXxircE/4c4nphqVnOqaIAVJ?=
 =?us-ascii?Q?bZHsnirUErfQs5lteUzs6J8gT2LwTWQwPP0zpwrP5Jv84VmsblMFNmNs4jnL?=
 =?us-ascii?Q?GoF3+P6gZWmFWij8LZECLQMBp2n3Ceu2Q6oBKiPPJ2pGdMFs0UnTkIW2MhE5?=
 =?us-ascii?Q?AOJolFm2CbVKSRZqiCPwgD+6NHLEihewXTOTq2dxeA3HFUFh4iphbVuhBSns?=
 =?us-ascii?Q?EaCoWSrUkeX4/dvJzZtZ+3jCwNxvlcXKw+6Bj3HvllOkZh9wJNBnpLcbImBG?=
 =?us-ascii?Q?v18dGHkW02NLE0uURnwvP6byjpQaI9H+JGe1jHqm83yodBvT74D/zfq3qXpZ?=
 =?us-ascii?Q?eAy3/OOlVQxwcMtnOR/47MmyGQdGHhWiOWTXSqyPpb2kGYXTxks9Yk0i+/sW?=
 =?us-ascii?Q?xHeMnBDZZuvLMcvqQiVlzCl3DZgoDfbOCtlBThXdC2NV5L6dUmfFqy1ZgR8f?=
 =?us-ascii?Q?drFFYNwD1+wla6oPKigJ8AUw2QGLxYhCznd7z/zI6Ln+VvpoX8oVsrXAGJbT?=
 =?us-ascii?Q?Mm3YWPwa05lUMafOhBrf7W2BtGxeyo09NtLwUfyz/hYVBYa+30PxjYXxepzD?=
 =?us-ascii?Q?cirR6szZWa6gfsClShOUZQQEUHughrlLm1vWlC/8RUu8IdiCveFvyZ/dDroq?=
 =?us-ascii?Q?aOeKLaPu1Bu8HAL+G1gvJZZCfw3n3C6WIGIPKH5WzU7NFIHvfC5t+f4QApza?=
 =?us-ascii?Q?fyXaZsKnqzFLhiTaKfIB9xwmg7CuQP2C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6NQobJW0tg25ffVxEmVKCVXLBSG8MkCqECe3Mt/neWVPtfRWwGTic1yRCSG?=
 =?us-ascii?Q?lkXxmwUfWDuE2/Ykd3oYFfVdszbSxy5TssoYpp/dln3kGQGUOaP2ctC+RxdR?=
 =?us-ascii?Q?Ou9pyP4UQAB4jABou0QgE7LoawLk76PrebVr4k2uaXadQI3eW4EXDH0Cq6qP?=
 =?us-ascii?Q?v0siwrt0t0MMIj7a6HdWO9voifMHOMEnPP0H0iv3ez35Gg8TnX6dnq1X5MWQ?=
 =?us-ascii?Q?WN8ZRIGpZxSUT02nBlCVrbln4/G0cFv4ZeRPzhZJgGr3OZef2DyIXn+e8O2g?=
 =?us-ascii?Q?jUG8pLR7yPyIl73FzrtJJ5kBdGiXhDG2AfHnlLiKjKm/q4InBILwtTLUKVMF?=
 =?us-ascii?Q?MhyZNqF4Ibt3z/bBNCA47xdRAtf+lFNBG0wI0zaGFBWJuztH9ad7LScb8CRO?=
 =?us-ascii?Q?ev0Lu8bnMF9LH6T2Ipb37hNtqL7qWgRKRwLnrmepPj5eFLrmkPz70iagOAqo?=
 =?us-ascii?Q?eOHALR1cI4qRFtUdXSprmngqXWodC0VWdV8f5iSadnBBOQPNgfIhiR8AUv6l?=
 =?us-ascii?Q?79Vx9VxC4+k93m3KEV00ZEC1om3/HmlrIhUV6kcGi+6irKrZFRM162EKER8n?=
 =?us-ascii?Q?JvbnNNH6MheBfr4XUxHAATkNHB1oSg9EyAyqBi3XpcR7xXRB7Pmo2Mpadz+s?=
 =?us-ascii?Q?ta+HMcyjApol4lrJMl7/Jsdrpcz18gHiVDpUDRBc2CbF97rX6jQGNO2KtPw5?=
 =?us-ascii?Q?+OD+D6M6FEmD5RH6zTbK3JlBHKQqN0fHy7qqp4CA0+lH7wjhW0wkjc5xzK5P?=
 =?us-ascii?Q?Fle1i0ltEdxScfKXNSkLBaT3Cjhg3uZfj9fnQluDVaL3m05pWS3racMUptdV?=
 =?us-ascii?Q?gw3SSKvwd756CfTZ8b2fkEdQfGkAz+RzvvICmNJ6hgWrfnVe2Mu4abfHM7zM?=
 =?us-ascii?Q?u6rSFCxsgTdp5kuxfd9c4I457YRX0WBmMgkL0jSh3kf+AE3fi9nG9faBeIBO?=
 =?us-ascii?Q?GzA+l5Ts3cWaR5rjiWqLIEJhM8vKGTgyap2+Bpb/yreQyj/ZFoVmGgOcKoYe?=
 =?us-ascii?Q?fxxe5m/sl4+X4Z7lyzua/Wej+xN7hj/jy04xQmFW215blVwIl7ExS1XEmtfE?=
 =?us-ascii?Q?u82ygTAsfYrBnYoJhmtbBpnvJXxePaF9KeOTDs3Qvn7uAYNcqSCJUq8SahJm?=
 =?us-ascii?Q?SgbiDwQR8QarUyLJW1PgIo02ZhCskNc2hTfFkEO1oDztvUqm6kXU+O5p9KaW?=
 =?us-ascii?Q?V6/lloouk7j3Dz9PPtw0csH2c8ESXrP5IkNiTj9pXK7Y82ezgZiSSSOz0tIo?=
 =?us-ascii?Q?zWBNzeuc+QkKQ0pV6YV9RZsxXTnHBfHDsctXmpVCo+BIskWKNm9cyHuVkwga?=
 =?us-ascii?Q?56gI9dn3E50N026fNORhWfN1uIxim/32meuDuJn1R32lb2bldgLZNWZnBjNe?=
 =?us-ascii?Q?LFMhnKlVtSjDhCxmBE1eF6QfCOPEYoqXqf5BHbIwACIFFw4bR4iCs75NTuB2?=
 =?us-ascii?Q?O3gZZ/EtU6EbUQRHnXKujz8KzesZFuKFxUY9k16AF5A1TtmKmSTL0wvKL9q1?=
 =?us-ascii?Q?UqhuB7RJZkQqVmXOfW8mKflaLf1yxWv4ZvlmDMqKJoMviF8cMTTS8MtStJKB?=
 =?us-ascii?Q?gQ5aTwU5saXx6x+qsbL3k/UFpaP9GiZhQbTErs6MgvLCJ9P633MJXQzVSfjz?=
 =?us-ascii?Q?EmP/PDyOsicmtR+wFmRaze09iA0sVSzOsjV1u5nYZDEI8nT9jpmd9uEXH0jO?=
 =?us-ascii?Q?OeREA8N+DUaf5FehANfKCp+X/ZzLNQy2o+MtllVDUxyejX86SO8uEwemiQj3?=
 =?us-ascii?Q?TwRIGfURLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923c83b8-fa01-4074-fd28-08de4953ab37
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 16:34:43.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsLagT2zZYnRRr/TOieHzUxNsw5uG1mZm+b85TxlNYTPKEBwUXbuQfCBAoPA2lzjK7d5waYITYSijZ/kQI1cGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

When kvm.sh is killed, its child processes (make, gcc, qemu, etc.) may
continue running. This prevents new kvm.sh instances from starting even
though the parent is gone.

Add a --kill-previous option that uses fuser(1) to terminate all
processes holding the flock file before attempting to acquire it. This
provides a clean way to recover from stale/zombie kvm.sh runs which
sometimes may have lots of qemu and compiler processes still disturbing.

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


