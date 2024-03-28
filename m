Return-Path: <linux-kselftest+bounces-6752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBC88F5FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 04:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656EF295EDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 03:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE23611E;
	Thu, 28 Mar 2024 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRVS8fDH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989F20DF7;
	Thu, 28 Mar 2024 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596866; cv=fail; b=oeSZ/owsU1eCP7Zp1YoxroyYzsnf+GoqnA8WDMjzPmPhfQZBWtnN+gIkjU37t17MwIjxGfCgT+MgvK8nEN0cEBoK0mYg8k0wxXjgjpvF0lMEkynzTYV/yizW65RUStZKrba7HZ5pFzW8BFwU1d8rVhy+puaPLf0qO/BIbVsJpcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596866; c=relaxed/simple;
	bh=69VYpuRF98cGIQvzH0w4u+3DYCJmqW1tIOivGR3IwTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnYMtJC4TodUNGKV95kgdW9qZqGmhQ06DdQipTY9X4AQDP2dEasCrBCSz+8IHAEJ627G8V8wAK61Q/LZl2p9CfqQZbbM7Mzvj5PE1RWwzL4MYSNZCjR6dc4EyIdeBS5SQzmOYHQfFYXXYPN1+5ccxKFfhVTpoWoJfbj87zR584o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRVS8fDH; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inbfI2ny1XIeLgrGSs8vINGc1a25ZX9tC7+fPr+NqxKWwrxvRfy0ZffjsYnlOcBZlhuClznKnEDpeG2BSPf1j4wXo0ZfUSFgoiYvJ8iyK2iEO24CpcWXUR1vMqi3c2ZZYfoZItzlVALU+S8WbFicaFvkZiQhk0C8hJSbiTzvJ/PYSRr7Kbl4eERWkdr1ddorYElbDSpcx4LxtgD0wxmcJ+UErgEdZpu3PHsKPXQn/Ikv+XLz2v+nS5rjrMdMRng5VeNgc4dNcyHpJlROfj311MHLdOCHzzZQmPfsN1qx8ky9A3ifFnGV3YTaS6NVB6CbCgDeieI3DscrOMNt0lYmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7gxAAn7soYSg8z7cnnaL809zsycy9I6Yyatx8e6YGc=;
 b=OPRNOrneoFa7gTB6kE9eSJi9H26WwNFNJE8Ephp39iAeDmPii0VmleY/Qe9EmZU1kuhvrcmxciieXyCJr0WCkowsrSgebUqh8LsEH60Rww6c4xZ7V8HYgEv7Yeqtkc7OL+FwAm6+nAw7mzfLRzJl7LckdbbhCesBBJ6FMRpJiiqlrzRjjGCG7ip3SWTjjsYfgaQ927V2JK0xcdW1jnywalJsoTbIXZUvWTMDryPC6XRLVqUD5Qr1r7aJq7mYYlZN9qfdaCvPeE6tj134HWmJzK9W2u5/DDL2gMRH6f2aDoiw4NmF/ZQZfsXjyMF0FC912Gx0xFAY8XfjeYDll1Z5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7gxAAn7soYSg8z7cnnaL809zsycy9I6Yyatx8e6YGc=;
 b=kRVS8fDHEM49XQ2TqawJk/V6BHzX1NdWpf/6a8a4s6K2uM/TCMWL3t8+KNa5TYQdREbulP0YWonN49/0B1lPhxgfquSQct4R+iIhn+0B+RFQfrcpNP31olKT4e24z3QP2AENNm3sp479QYJfIY23mhf/LL12i21GxPBkopU0PgYrO7huCBHB4C5z0jaCVJ5WdVfCjHt9fLM96vgQfb7tNAQsdylXU+7Y9Vv8DXjFb3zglVSCTm8FxYw0/5mYLeSQJRIA8pcXHrZYrxFJwhtTgB5/ll578nC/XpDakGBXudKo1sWHTfOOq802rJQHN05MxRXObk3Cylv+dXOxcOtS1w==
Received: from CH0P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::6)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:34:21 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::9) by CH0P221CA0013.outlook.office365.com
 (2603:10b6:610:11c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 03:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 03:34:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 20:34:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 20:34:19 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 20:34:19 -0700
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, "Andrea
 Arcangeli" <aarcange@redhat.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "John
 Hubbard" <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Suren Baghdasaryan
	<surenb@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] Fix selftests/mm build without requiring "make headers"
Date: Wed, 27 Mar 2024 20:34:16 -0700
Message-ID: <20240328033418.203790-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0945e720-5ee2-4812-2e07-08dc4ed7f52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LsDwpfxkAGwuwgDVI9WVnr2omx8SiKP9eL3G7LK9JJrWphjZ1rMgaDQr+NS5nKflYmt/v2CpJ5TWlnyFPrQN4R1w/W2dlUKf43vgSJuhPGuu0xim6i7rdXnZIPo/55531/ezJkm4wOhqkyzsHoyIyJCHigq0/eXAyhio3SEdzBgDQyGr8y3Zb4ADT6Nv7J+oCz5cPuUBLDetB8qdIlGAt7vrlHiGrLUBlVjwPlBbIiLQQhlShJ8Eq4qDv5WEkppV55Q78T7kwA6MEiPeLTRJVa4d/OS6YPhmuYKhAQY/+Jl1KAwJiKfoQeYkegQncrlDNIqd7vP9CfivC1yaZMHhrSvVj9jIj5nqPWUQ4cUqS0UgW8sBOqHP5f2sHl3AId+1UC+OdpLGee97pzwod4lPMt8kd6hARm5MwnHJQov4/n1vDmIcKh+K2tynU9WKZ5wmUXqprC6+kbSTMRqhbCnrLa3Q5Ljy3Yjg5872meTmKbxlcRzhoy28kEvUZBMU5QaLMZz/K89h+JeS2WMcw2AlWdURELvJuxAT8scBUJTrc9L+waSDNzCw3v/+faYCk0tjPD4D/ndOyrJj5RCNWK9I/Ds3KH0BESjxXxQQ626F/L83yBvTH3l5C14SmYgI/IIebjLTl2VLSclKK/+GxRSY4mwiOyzIwSXb8DEd8RGiQS69mX4re52ipo/DMlXxj2Os6UUhSss4AxwyhexMtZLl3AarvX6aG5xJTa9/t8XTLTxB3ufc68KCO0knHCUR5oX3
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:34:21.6610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0945e720-5ee2-4812-2e07-08dc4ed7f52c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075

Hi,

As mentioned in each patch, this implements the solution that we discussed in
December 2023, in [1]. This turned out to be very clean and easy. It should also
be quite easy to maintain.

This should also make Peter Zijlstra happy, because it directly addresses the
root cause of his "NAK NAK NAK" reply [2]. :)

I haven't done much build testing, because selftests are not so easy to build
with a cross-compiler. So it's just tested on x86 64-bit so far.

[1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/
[2] https://lore.kernel.org/lkml/20231103121652.GA6217@noisy.programming.kicks-ass.net/

Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>

John Hubbard (2):
  selftests: break the dependency upon local header files
  selftests/mm: fix additional build errors for selftests

 tools/include/uapi/linux/memfd.h       |  39 +++
 tools/include/uapi/linux/userfaultfd.h | 386 +++++++++++++++++++++++++
 tools/testing/selftests/lib.mk         |   9 +
 tools/testing/selftests/mm/Makefile    |   2 +-
 4 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/uapi/linux/memfd.h
 create mode 100644 tools/include/uapi/linux/userfaultfd.h


base-commit: 98560e9019851bf55b8a4073978a623a3bcf98c0
-- 
2.44.0


