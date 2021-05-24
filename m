Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC038E70E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 May 2021 15:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhEXNE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 09:04:56 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:27105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhEXNEz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 09:04:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJZvc+aSVXEtAde3N6ZeRkvwErp1ljoVnAq1iFNTodGKM6+BghuOSt6MGJ6Hwpn06FVP56C33eqHbr4+EGYX9FETjzogqyJpOOnH1Y2NBtwU5RV8bH0s22thOByY7opqb1invrR7LFpzQ0sryy9mmfr29ohe6MVoF88X2LVYdFzBag7Q9DTSNnSiIlEEjM4Wczgz1IbCCSx5rEIz89XCjGArXKA2c8evA6Jjz7R6wcBRMsqZ3dJIrYGIxT7iuE46UpXXkgU6TfGBdUDFQAiJex2OdApeWn4GHaJ07E5ktGJgBthEGPPC1wZF57si8C+KWu5XlTEd2+htjJ6VxbcxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snr/GxaJn/T/Hv0r5+prATGOclyfjGxhLwAOfjZukWE=;
 b=MfoN2nlzvs4LE2HNBgntz+Aly7h20lcvvZtTGWsBAUr+/PVtmrKPY4ruqq2aIgsRbmjOZeJ8aQ6vn1pMZXrN81K+f5YrgG9eiQMWseK1YXbDTYgGj3rc080a8ufl/lFJzrgDVbd8KL9vNeYTtFKj25pYW6NsZNzbx0utnKas5g6loDxYVHK7l2YnA+0uTVWQwrQ7yFCaenYo29yICF0tKjJ75ErVzs8+SpoEv8UVGS8EuYK/1bkjHaggPjRrytgJjNqq0FmttU94/krVplw5XMCKUVcWiHifPlVj+I2AozxYsNjnoPkif/OMKFX614RA/JjZ04r1NrIxH4qeSi0EmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=us.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snr/GxaJn/T/Hv0r5+prATGOclyfjGxhLwAOfjZukWE=;
 b=uoDlqhGDgq4kwVbE44Vh0FiPCp0CIB4s/dWLnnTSwCgPD3fy7cOEVv0scmzbFbbkgHqG80tWZ9MMzhUIrVKTEAROmkjlrJ3j+59biwk/cpEF+aYDWRA5mo+nYWVA2y/GfhD1CozhBC+TBxz/QbD6C4EQ/KQoqPcLdZDc/BX9rXEnztPjUaQBXqs6TI/ZsRtoAwt9mWgq99jHRdZ2BFSi4nAFLx1g8oQGPzmxJFTx7Tiozku2/g8pDPkcI8adXILlVYK4By/LSO/nS5crrc0GkLWyaPxOpE8kT6VAUwM99bv/hDn+P2wVSwq7jniIgLBA+wAy32g+stsYw3vdKbQKcw==
Received: from DM5PR18CA0081.namprd18.prod.outlook.com (2603:10b6:3:3::19) by
 DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.25; Mon, 24 May 2021 13:03:26 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::87) by DM5PR18CA0081.outlook.office365.com
 (2603:10b6:3:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 13:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; us.ibm.com; dkim=none (message not signed)
 header.d=none;us.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 13:03:25 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 13:03:24 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <shuah@kernel.org>, <akpm@linux-foundation.org>,
        <jhubbard@nvidia.com>, <sandipan@linux.ibm.com>,
        <linuxram@us.ibm.com>, <harish@linux.ibm.com>,
        <dave.hansen@intel.com>, <rcampbell@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 2/2] kselftest/vm: Add test_hmm.sh to TEST_FILES
Date:   Mon, 24 May 2021 23:03:08 +1000
Message-ID: <20210524130308.16343-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524130308.16343-1-apopple@nvidia.com>
References: <20210524130308.16343-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1403233f-aa17-432b-a623-08d91eb4517c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB135661D0FF8296F628710B6BDF269@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xNW5q6+Q2zkaCotv72EOi+RzDcQWSYFFjoNYTD7k6MGIghP9zk5UYC7RLYZqrhMbFHXub+QjqpRuKZ7WUYHJYXvKrXGKxwDijBgo+8feiaaWuY3JK67QnHYjeDe3jYhv1kCIuOHBxo94zzJ7mmtHTSh4y2DIiJ6L5ZTWJGyufW1eyp5cU7JaK2XJGgf3QrJd3LH9RhC4mA7F5/do/M57mf/xC7EACnd4hpf3PdFTqdaJ/9SiSF/iXZ8JgP4a/oRa9VuKETpqI0piNP3rZBLH4r8dNOX4Wn1VuBc6Z1U6Y1udpIBm1r5HGb8oyYpEc+MiT9LO9RjlAMJHVEazXNMGqE+aejMN39S0XeKcTkiGr/3/HnzXhCIZDOYh8brkIK5imCQeBNiX03ZkYWoYavAG6zhYsvhPRGLP6ST65O0OMdbApFr8SYq4gENW03E+JxnQCLY2fVGzulGHsYwu/V+R+n6gClfG8RVTkMZ/tq91y2ePAGkt5hbaFHxA2n36V1MBsVQ/OY++LdIfhB5yz/Gqs19KEhJFur9R1IDqHdwbDUC7DjvN601lCepTHKTvAK1VfaIlN0SdemLji2iAqxdi8/7OcSU1Jg3Bo4ACUBJIHMsXQIYy82hz9eqQByykWBzv8zckt3MYZr5p0UdrQ/kY5M4w8QNweZcAN+7Exl/iyA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(82740400003)(186003)(107886003)(356005)(83380400001)(478600001)(8676002)(36906005)(36756003)(70206006)(4326008)(316002)(26005)(47076005)(36860700001)(70586007)(1076003)(2616005)(7636003)(8936002)(16526019)(6666004)(5660300002)(426003)(2906002)(6916009)(336012)(4744005)(86362001)(54906003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 13:03:25.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1403233f-aa17-432b-a623-08d91eb4517c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This ensures targets such as 'make install' copy test_hmm.sh into the
target directoy.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 110751ce8701..202fc643de88 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -80,7 +80,7 @@ endif
 
 TEST_PROGS := run_vmtests.sh
 
-TEST_FILES := test_vmalloc.sh
+TEST_FILES := test_vmalloc.sh test_hmm.sh
 
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
-- 
2.20.1

