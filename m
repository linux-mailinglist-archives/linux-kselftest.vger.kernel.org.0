Return-Path: <linux-kselftest+bounces-30397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8DA81BEE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 06:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F957B5795
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 04:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF521ADC7E;
	Wed,  9 Apr 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B45mN0dL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F1259C;
	Wed,  9 Apr 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174018; cv=fail; b=TWzbAVTMo24Yt2IaIP/NWlpLX1bfXpzemoejkzYb11sTQVHBX3P6qwuZxfkz4tTC4KY/9HnoXft+h+nUOMJVxtIpqwNCOjDA9qmaKwSGGSdS83YuWEfTWOUo78d4Jz9Nbnnse56ph7SyxRJn6tv769MmwJZCd7Fbvup1KX9Knbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174018; c=relaxed/simple;
	bh=VQQM1fJ6c2J0J6fW9ZV1Z879+4kH5DLYrMFQAn2ujTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5zrhOlFq+jmWwk/oJuyqmgbIbPBoPoFfm70uyGWXtkuDuPoDtvGPAAxhV+yWEb18e53QMlakFVrGp4YzEFUtq3XWAx3fivG5dk5jqtZQRo5etRO3sJGn94HnM2oaPXB1qzadtz3XXC4rsfFvh2WBSOtfZHNiOZBQsb8FQFvwyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B45mN0dL; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHIKSyX4jvn9/7RbD/a+j3gv8TajkMx10mbVK7EflV+uMJiI/EBLmQ/4nOM5kCZPRYC9ZgwCb/wF4RxH+mlny6jqUOEpvX1lOzb/yX0QH8bGeEuODEtMnwRL5Fc35/RLCne4aPhAVJvdDLjVdj8Ng4wJ5L+tfNJo1Wz592f5WhSchkFIaT/l+AvD1c6fJWAuoRW+TOBQIp3hsZ7ghrYsuSeJbPHHyrapP0TTAXahL25/z4TeopyI4NP181bzfcR5kFSR2EJ2IrERiA3Y4+0XYjWb0KS4sxw0RFCAqBTisfaf6ctwv/LipPzvPSOLrHE8TpyBiQi0KCWXSAxMwAiYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPTaBtUbn4d+fDCbqvosbx/WF2lCxqCgAz1U+tWVQSI=;
 b=I0bN2PTOhYg/aK7IrmUbJkg5fx+HM0qShpLz4Lc6zMzk48p1+Oj20cKzFQH52tB8dwtWkEsG3qfZqeITo6P9G7Fwokj3r2TdoauB8tVYaZEjShbkLnquzFLjRui7NOKEkqTBiR+cC/M6McfWdcwK3I6tGOgOLNdeL0EWmUCBOGJOiWOU1cmNAW727TZDxtoxHIo8e7OmzXvZdWX5Mpzz/Mwu5m9rX57PYVOvyih1LwYYB4bwDHUeWlwN8FGuUkfrgP762ENp0N0lih+sxaurOnnuJ+tP8jftlKjXTEhunmvUE00bB5hUU1RIF7LVMGDSWpt7r8FHX4J0/XUfAM12/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=goodmis.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPTaBtUbn4d+fDCbqvosbx/WF2lCxqCgAz1U+tWVQSI=;
 b=B45mN0dLj6wPwBXbdzMSsG25I/fMVrp5JhbKsc3U+7+jewO7gPmHP78cQ6Aqn4Vn/3sbcMCAdBZrnCQkH33YwuP1/PZgSs3KUDnP4BACQz1Ba5X1lgdqRcN+x1Ay4ezU8slhSeDn24N68NyAYEwdsa+Y46vFRBSEvYY6P0NZifM=
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 04:46:52 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::d3) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 04:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 04:46:52 +0000
Received: from dellg853host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 23:46:50 -0500
From: Ayush Jain <Ayush.jain3@amd.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <Naveen.Rao@amd.com>, <Kalpana.Shetty@amd.com>, <Narasimhan.V@amd.com>,
	Ayush Jain <Ayush.jain3@amd.com>
Subject: [PATCH v2] selftests/ftrace: Convert poll to a gen_file
Date: Wed, 9 Apr 2025 04:46:32 +0000
Message-ID: <20250409044632.363285-1-Ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e49e43-fab2-4c04-e27b-08dd77218bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03nc5xIBz4Z1yZips5ccpk8I28+dZO/hWJFz48ocLGihLZGDWCOVan5eJOW+?=
 =?us-ascii?Q?NxxB7gcneJsqS4Iq6ORyT+lSTxV6rfJo9ua485PRSvsoF064THjcId+5kj9z?=
 =?us-ascii?Q?uUDNNMU/5c27Voibbx8ByReE3SqTEW0f7iaGfAkgzSjgZ238+cOUlyqWkB/B?=
 =?us-ascii?Q?W6+yVwL4K7f9waWDI7c4VXFY7UPwB3v7Tm8Qem8JmTYxjS1ObHweEDRSHdRW?=
 =?us-ascii?Q?cWrKlQ5yseYrUjrGvD4gNpta8IoJyhTt/mrRAMYgUI9Rty/AEevDPIi1WEVn?=
 =?us-ascii?Q?NIfoMRJfqk9LIONSPxjriXQy3dqWcMhTcaZLwiVDKW6tok5yNJ9MdtV2xWjm?=
 =?us-ascii?Q?9KrYWvBHm+v1JSz9osy0VeohztsRfrvuiSrrmPB9VM3XlPORmI4EFRyC8f0X?=
 =?us-ascii?Q?g7gOAIGQKJu8IZYclfwMV/WzrJtKIpxvzLf1pQNMGji/0Kfhw/Y4dTf7Lr8H?=
 =?us-ascii?Q?K5N2flZc5J7G0AhG5k/GTSfQowTjHXVCDrYUs70iAmDfTMpjgJW0l9BlcADe?=
 =?us-ascii?Q?kXBTVsBmDb/o6Vin1TauGCCBHjzJUpjDmYrwmPMuM2Iv1bePH9gYjdHa7Nzl?=
 =?us-ascii?Q?ejauwvq1j8XnyM/AatNOef4P91qcYFpyUtmSWZSGS65xilyksY1JZgI5dw1+?=
 =?us-ascii?Q?m9kzw1fFhaYcPdL7FRYn0flSKpDQn6f+vcfym0fdtYSia3U1tFkxQ49b3LHH?=
 =?us-ascii?Q?R1Sl48O4wQMfmflOHmeiGIR76NtuXaZKK5gqp3XBQK5J/FHowsJFHMHGkQFf?=
 =?us-ascii?Q?TXsvphR5MXOwRxQm7KnR7RjOcyBDj0mNT534zVYoT6s+PijgyS6FnU7LBgaG?=
 =?us-ascii?Q?FIRHcDhUV4LdCt8R7vWP8V9Z2gcoYinoMu8kpQ50x5iWy4vT70yBaElnS/aS?=
 =?us-ascii?Q?6WofYLtzE/UwWER2pkK6dOH4zlPj6voJOeny3NH8HFi/9CXuGu3GQFVqwTec?=
 =?us-ascii?Q?e8Y86CPjLW4rDZLFeIt/i7HLck5VeM5wSyORdARNe9ageQO/UazcJ5x2M3K6?=
 =?us-ascii?Q?aa7G5amIcjOrwbBPzVkkNmzHSXE3YchXx09fdA+3S8ggmAeekTDtgaSKQSbq?=
 =?us-ascii?Q?qoeFMBxdsbOn5AEq5glM3Zl6gtJMZNHXinlT3bjXwtYN8n0WeiE0F6vkkTHv?=
 =?us-ascii?Q?nWItI07vVt84KZAmqD7feAWjbpWOpcxYMmeTpeQfcSudbkwcvvJSPJSxP6pZ?=
 =?us-ascii?Q?UJOc6/guFgGpz3w0Ox3wZ/JnRJ2YcOeMd08nadtVCNUy3INgrURDPYaQhKu1?=
 =?us-ascii?Q?It4gjeOQS7d2YS1oVxdWxrFd/0rosoZICgO3bE7yjlgauxAXCfSvyf3LiPN2?=
 =?us-ascii?Q?vt0auEqq6rgEwXIWykUijMYIVhPzEUL44oQlNGXFT4I396KDm8gnNAmuWN6V?=
 =?us-ascii?Q?sHdoliG9ABQqg+lJ/2oqipk7ZjEFfjjywUW7A57odWu5T6hJVAWF9DzmxG3n?=
 =?us-ascii?Q?WhesfSvblBgX/XgZt8HjKoSMbQb9YXVogpsVeJQu6wN3cxuY3/AIexK2S95y?=
 =?us-ascii?Q?95t7cq1bNPg9wwzeN6K4B5AITi1eSK1FviFN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:46:52.1667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e49e43-fab2-4c04-e27b-08dd77218bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

Poll program is a helper to ftracetest, thus make it a
generic file and remove it from being run as a test.

Currently when executing tests using
    $ make run_tests
      CC       poll
    TAP version 13
    1..2
    # timeout set to 0
    # selftests: ftrace: poll
    # Error: Polling file is not specified
    not ok 1 selftests: ftrace: poll # exit=255

Fix this by using TEST_GEN_FILES to build the 'poll' binary as a helper
rather than as a test.

Fixes: 80c3e28528ff ("selftests/tracing: Add hist poll() support test")

Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
---
 tools/testing/selftests/ftrace/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index 49d96bb16355..7c12263f8260 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -6,6 +6,6 @@ TEST_PROGS := ftracetest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
-TEST_GEN_PROGS = poll
+TEST_GEN_FILES := poll
 
 include ../lib.mk
-- 
2.34.1


