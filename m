Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B371F7F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjFBBeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFBBeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76138F2;
        Thu,  1 Jun 2023 18:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8SRjcVBLe7bgo0IAohbUAtvBXWOcJIUjKDjX12EtmFac2LQAag11f7vWKEEGq1zrg6FcZOI89Fh4rdfYhAxW8b8jp6cY5O04YVFlEnwSrWJ26ObpXWzHwUSFfBrNGDemxBmJoZGATfT0v+l9xfdFKSmPJjmQAW/djIy3vm0Gy/0iVwC29N/MUG8KXVaNNdgu4dFxO+qnGVO0L/mP2oMfq02vzSeMO19H6ylIzTTQp2hF/zTbBdXqzCIzEyAM+mTkYACjS/2PGsEFQd66SxkaC4Sn+0H6LQ0rrDZtCbq073J47M1BbVelHmE9WQguj2xvCpLTZUjrvrw1bqI8+Asmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOB6h6NlmVpcehwBYy7nlOHDS8hc/dX6LTSzGmRC3Fk=;
 b=OGYYZUpQf9dC/kmS2QfNT3s8/0ExmJ7i2oC59HMOpxN2qnMfPimfNJHbxFF5xNhRQSNahsV2iY4FGXQp6f0iO6uVpBzbdpHNLSvL8ofLMbvjwtTJKPAVWjcup5LQp1XcCsGrs+7UMsfuL0c8IaKxf1rH4HUpDzzcMQLe++BlbxEbX4Fh5lqVay2aI7TbqnpQQDJ3wtM1I1fQRaQksMtkXPMP9ljECjVra7gI/rmAPMIOREjooNe56WyXjNKan+ydcDlCasQUqTEJFcOQrwoNzlSHAP78iS0zeI4hoL6Y8hha/fMoOaE34e9JsfQlC95ZZbVbqjeu8BfYnEMxyAyk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOB6h6NlmVpcehwBYy7nlOHDS8hc/dX6LTSzGmRC3Fk=;
 b=fq6UP2R+Gd1XpnNxbiE48hpZtq8HcED1pm7QQw77SruxbVgsAJIdo+YqQQ9BhVzkhdx9dRfMx+kEzWM85B36AUthGvEyRD5z6JHfDm2LWjEAyCM2XZemqERZQQGXQtN4myMKOizx8gctdtCnBZPQrrqKwy2YMmZGJeCDkj6VJ8HfGnPApq2i7auGjLUvqV7I/uvrqBi8cheTQNhLJJq06etwZO16BpIbeTqJUWjCKscAoSel5TI2q+SlvyZ5dNqmJtW+berdQKrBLxHo22qCsd5Z9B+q8qdof2+bkXBArNkoD/zuk1WAj/Cd0qNAp1Gt7Q7NkiukEV1h3Rap3olIoQ==
Received: from DM6PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:100::32)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Fri, 2 Jun 2023 01:34:33 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::dd) by DM6PR03CA0055.outlook.office365.com
 (2603:10b6:5:100::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 01:34:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:21 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:21 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 04/12] selftests/mm: fix a char* assignment in mlock2-tests.c
Date:   Thu, 1 Jun 2023 18:33:50 -0700
Message-ID: <20230602013358.900637-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: e2629734-a108-4852-d0c4-08db630984a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7QI7s/VUJjVqtJXqeDnusKSCtDwxsohYM6Dt0qsQ78w0vw/IBu+tfRxc6bJEISQRMwUhcQQa3E1oncnWxRrzD8WhFDBWslBGO+atroCXFjwa5u/6TkuXZkiUJCqBDlySA6JmM3ytVOPYqIFIGgLWSrlTr1e2JvSitRTerMiSSh2WKANhIvyEP5BbLJd4QA5pbWlHD+2dxPWksbrc1EmyKn+AVb25bMqDfzr2r6AFOB24Kx3zSC6OVvxeRY+vSUVQZJJLRpFLzMXDRf/d/qZepq4L/Sd+EsQzBLBxV0f8tzS1q8QawaMl6678o4V1cIbOm4MKVVrcEi4+cnVhTYXUus9DwmWiXffeP75cgRL3Cb30obb+NdZdIh6Q35IykRg5JA51EnwA/UBOPoINbgVEhhl/QuMeQeo5ZOOJvBxdUnRaPiPOoGmbTSe1EDaLaAfCdOd75HxvtzYgqiTP71S3WMiTB81mB6NH9gnBl2lgdVO9T7RAKz+JFRdTofbuHzNQC4oohESGYSb1tNPBznSCDXgRxEfOFH3hISBI1cQPMJfczC4ZUOlwKsUeNMkQ1O5bNG32k42mdOt+R8Ae8EXfhpTProqdEY2PekXZcv45JioN1ORL1+kE2RCst6k61vP8OMC1s2DeXC5nxfHAMalsPdry5ldaF+xP+xU6NWdOumh6wzRqlsfQPUhE61bKLqIxW9AYGTxzx6cXzdt0bumYbT6ccd0RTWOqnhmtrPpruCM9PEhbkWlDzzV6NGPPGqU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(82310400005)(356005)(7636003)(40460700003)(54906003)(86362001)(6916009)(70586007)(70206006)(4326008)(36756003)(40480700001)(478600001)(7696005)(6666004)(186003)(26005)(107886003)(1076003)(4744005)(316002)(8676002)(5660300002)(8936002)(2906002)(2616005)(47076005)(36860700001)(41300700001)(426003)(336012)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:33.3122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2629734-a108-4852-d0c4-08db630984a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The stop variable is a char*, so use "\0" when assigning to it, rather
than attempting to assign a character type. This was generating a
warning when compiling with clang.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mlock2-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 11b2301f3aa3..8ee95077dc25 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
 			printf("cannot parse /proc/self/maps\n");
 			goto out;
 		}
-		stop = '\0';
+		stop = "\0";
 
 		sscanf(line, "%lx", &start);
 		sscanf(end_addr, "%lx", &end);
-- 
2.40.1

