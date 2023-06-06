Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633037238BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbjFFHRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjFFHRa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3002A1AD;
        Tue,  6 Jun 2023 00:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtD5DMcRtax3IhhQMIiE+vjeICL1EGPrTF6//Ttjq+NjVcqCvGP5DvjDXlk1pgUlgmpzhEYGqTTcjdlco2fQaE++QPgSuHAMlM91cKauLkEbvc1hhnXyzGk7wGUap6MxfAZduCopL2OGc4hY2Yj867oXaLFuRRGkk2lXJtZ03VtiXorUAVzwfkMWHTOcGCqmVwWrw/tHHXb16w0x8GPnGVTwjYBR5Xqqn3VWcE6B8049AVf8DqtaI8POBvk5H7JV5Wx7WTRAOk5TMU70PCm+OP4NUZ8R2RX6ApUXpWlhcC065c5hjbBJLhcmu3IjvvlxsBgib6jQgoWpp4IvWZpVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=OoAqg5tguFZ1vwtXW8FuZaE2JlIvRPT1vpl0EzfNtqkyx3yyxoEvBZZB/RYYtLzaUuA914TSGVc1k/A191Xa5qPVX0Zn3Q/PfG6oRCcvgX2cG+hKaGxARt3w5oCQWaYFqVbNCZ38yVTk35/u5umynqTbFFXUzYl63ej2kxEPcz1YaYUps5isAVI4Uqa1f1l8y83mN0/0/6uUu3w9a82CwfALELyiK5CmbHMQqID0Xo82/YmOYwZI8ITyl1VX8iR34W/txL2qoDwVzr5paYqWsokvYvHjslKXvhi3IfFFaBoB6tDTSx7TnUX7nH6YWX7eXt9anoEmIdU5wFmBzrMi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=EeVZOxCmS8sCB9O2Pdq8KGt2pnC9CWFWrapoL4tF3K44KB4t1FvaCS+9H/id1MA9hkbYUX3sajszSdoRRqYmnQmJN24V9zI3PZKrS3oUuPZ9oO+mlsvyEeO9ExSKajaNHMaAtjKihFQbOJ7gl55HrfPLzRe+Fu+0zWSl2iCXHN10pX0oQt+bsYHsRmStF/mkCgdmVjxrzANQuh+9aKcbLJte1wfzxHCbgNy8UqVFoBwNzXxLztEigeCKAw5hlVkegso2z8EfmY4CPg2aoVnT6lzfxijMZuzb81/dhqa7YT5oCvL5ogBXZwvyQrWMJKFy/YysSzLd++0HQVjggtc0pA==
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:17:24 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::11) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 07:17:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:10 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:10 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 07/11] selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
Date:   Tue, 6 Jun 2023 00:16:33 -0700
Message-ID: <20230606071637.267103-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ba35a6-be00-4893-8c59-08db665e133e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qct1Q3zBkNF5cbSrqByrHcstcilf9UxsoJTgPw+u31leZzzB3/6kvsfFfRK9Rx5KOh63TvqNOcKvdQGCptalV8oDsUaURjr17phQcW4DzAP+k0oG6vKlVC+ekVobFgeik0YLDY0v/LUIDdjbumEgVLEK/PF40ss/sKmSo6QnrRWiEakQ0L5PF8iFiljulJnxWPa19jS9wB2PPUljWDT7wIpoGCu3g1vi8EMJg3N9EAD0WmnEb0hbuhV6MjPAG08GAmPKRLK/D4uNsqMuuSCEWJ1pcaDS3nVvi4VJ3n1L3Xre+iyOcdUkyweryQSSvG9+eJwcoudhbFolb7G6ACOoTvzQ1d9FDeZXGF/5hwXtt0OttvStUrUr9BdsubWNVdWRF+NlLZFqHaBy/4ExSLAeCfT7FLw98IVdRnOzbIJxaVPAbZJT8qRC2ZiHLSCUpC48/ENcxNBKyu+gI0mK1BLlXBomfSmy/K+6+QDS/Mj/bpOmhOYxg9LbLPIq2CepMRdbISBPn35yhQUkxOQvZpNJ4gHRDdgrAOVEnJZQ4/Ppn31gdXoa7+4YujMQiUIjqHLzqHNvbDNS4V6cG03udjjvQV/feMV6kEbuNjfOKRylBn84tOF/Jk2OAoATjNwYcoYU392ovx31jkpi22k+qp/5cGH5iuyqUtfAGXjm4DFBzqMJvKFcz2/gWv2pCNMFNQJGcwjGS3yvN3zUFxqk02w70XwjsYUHXDe+lVGHdkRYfnJpX+VsZLNKI7pAdlVt7Om7
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(47076005)(83380400001)(336012)(426003)(54906003)(478600001)(40480700001)(82740400003)(8676002)(8936002)(316002)(70206006)(70586007)(4326008)(356005)(7636003)(5660300002)(6916009)(40460700003)(41300700001)(86362001)(36756003)(6666004)(4744005)(2906002)(7696005)(36860700001)(107886003)(186003)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:23.7319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ba35a6-be00-4893-8c59-08db665e133e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This fixes a real bug, too, because xstate_size()  was assuming that
the stack variable xstate_size was initialized to zero. That's not
guaranteed nor even especially likely.

Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/pkey-x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/pkey-x86.h b/tools/testing/selftests/mm/pkey-x86.h
index 72c14cd3ddc7..e32ae8a1cd99 100644
--- a/tools/testing/selftests/mm/pkey-x86.h
+++ b/tools/testing/selftests/mm/pkey-x86.h
@@ -132,7 +132,7 @@ int pkey_reg_xstate_offset(void)
 	unsigned int ecx;
 	unsigned int edx;
 	int xstate_offset;
-	int xstate_size;
+	int xstate_size = 0;
 	unsigned long XSTATE_CPUID = 0xd;
 	int leaf;
 
-- 
2.40.1

