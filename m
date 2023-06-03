Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7504A720D34
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbjFCCQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjFCCQc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22FE51;
        Fri,  2 Jun 2023 19:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GctmxXwc1KzrMcPKtC4bFBdF18Tq8Fvx3XIXqfWL7bszbUxHTDMHtOYGQkXWx2K89H2l5xVjWP91GkwZev40myuNktu3q4Ey9KnKWIyoUbR27PU/ChBm8VU3jJAxrvqlyG0vVRRKE1dSiiUO+jTX0xeXqumfuYKsGDKqXDKT8noMlGO225cjMqgB3LWEv2KXf6YHcNv85Kp+xv/q//l61nz2V/tt2uZSQsBJesODBRZ+m99EuYxt7YC8C/6HqpK39QfShlpSdBch1M1G0ztaAAAJryRN2f9yVFFUqAUMqaeGdMHR1D3k6GHsseTfDMw5aran/uwdCljGRcUQMNH5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=EG3WIBkfd9R/MpUDztYzE00rJQqPz1NxWMYlsKDptFOzpHaF5tZQhz2nrVJqacsdC0K8jVUhAJ63fWng/tpOi2zruhkuA1LxkgAUghclpkgB3DJbR1eQE8x2yY6Hi2dPa/RjCt+w9p9IwNHDijKOraJUbytX4m0eFTTK3iat6nVJBecMXWd/hI/b/sS2XOZfzOEnphwdEzWyzqX5KurRs25hNcSgYhG+KdNsZwCHH5TTIBLDCSBseghHfugjq97FUTYfplb2qXlDRaCGZFbirg3/M2fTI4Ska89N6EGMYkhGhwnpGWk1H0Jxyr5lZvW+u1wsCJuFZKS16tUlZK3o2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAgHsicGbXE7/y+61Ec/TG4fp5QK6NCUPay76C4Qy/s=;
 b=oUKZRpkGyLvMoK3wAqp2OJFWuSZTx5/59zOGYWSRblw9ZQpAo4pc7Pw7KY2zEZUKC9kR/L/Jd0p+TbGt/6U+TnpFCxjaXDbLtGEK4e09EDmDvgmLoxzy2C5cgyBksjUzW69k6eeR+ymKHhqXAIdaKJKindYfGeBOhZj/TilYPL3dUu3vXHlgsegapg4rdcCIRkBRFdM0Auhu3QbQ33j43ULE1iUcjaxVSICzUZGNKZUMv6YVo5hDqQnMS6A+5nfivdNMu68lyzpmx4alwASkIqWyXyDZ+HV+zfKV7AQlTjaeD7PtDAO3BQEZZTDJ54vI6ZUnbmNQ246RFb6BFqaKhg==
Received: from BN9PR03CA0604.namprd03.prod.outlook.com (2603:10b6:408:106::9)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Sat, 3 Jun
 2023 02:16:22 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::5c) by BN9PR03CA0604.outlook.office365.com
 (2603:10b6:408:106::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:08 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 07/11] selftests/mm: fix a "possibly uninitialized" warning in pkey-x86.h
Date:   Fri, 2 Jun 2023 19:15:54 -0700
Message-ID: <20230603021558.95299-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ca2b62-876b-40f5-5b85-08db63d8862e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S90U94XXVLZ/TLsq4/SAX5i0GfONXKsvYdY1089LwZLkJVp4Is12igWRP36EaUskKwJIM7qVTGE7r+2jsHCWuSv/g3yYIANX+I2HjoJfp2b5mJKH0hWwo5miRz+97/ksJhTInwnEEsiBf/egsS1YF26LUNaHdUt8FSPnJkr+Qb226tfxaxTNFj62OICQ1n7E9u1P8LP65x7xw3jGunm4PkUHls5Ic2bL//VEas59vMhznRsF5cVaiG+xtuwwo1qPX9rpU+K52ABF9ia9jC5aHqQxwlukagWDT/9JAZtlauqBDneebow5Pr6B/xCZ8SiyUuGzKdh1qEPlc1TueIH1Hxg3pzHHeqGWE02vVKEuY9LcWCUq1Ol+++RLlg2v8V7hqF555Q8D9bu91/Uprdrjidf+yEyrzmCOUci1+xxcNTQ9I/e37CVIHLfBGsoqrme4mZ6vqoFVdNhDKbg6rtgNL0TNxremBNq0eNn2OV6qeE0tt/z507soxXjEkNUUPFhRKLBg4PLChvDVg/je3xQFRjPdQ0Exw4k3+lmmkLQ01eT70Go8EY3Ox0l2dCFXGNvDZRkvLPAH2cMUwkVbokK6ewJOOe4Z3cZ3T/Rz7C0EcUGoIp4WwPbjesVZ4Y5iCztFvfa0PtCPgqz8hWl9fTW/IpnC3rU3RW5VdYXKOrvFdMGL7bujsd4y2Vy/JtsCJido4BgZC44k6bmps0802qCPWVTLvp2nLoLbKRLZ+JH3FYdQNQYmTAjdIDLCf/4e1At+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(186003)(478600001)(82310400005)(86362001)(316002)(7696005)(6916009)(70206006)(70586007)(4326008)(41300700001)(36756003)(54906003)(6666004)(40460700003)(107886003)(40480700001)(36860700001)(5660300002)(47076005)(82740400003)(2906002)(26005)(83380400001)(2616005)(4744005)(356005)(7636003)(8936002)(426003)(336012)(8676002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:21.6296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ca2b62-876b-40f5-5b85-08db63d8862e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

