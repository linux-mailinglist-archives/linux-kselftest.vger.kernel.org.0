Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C387624F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGYV47 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGYV46 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:56:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6A62129;
        Tue, 25 Jul 2023 14:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0HQSbM1jp6eTavtAR0f2SxPaPqMlK2+2QXarxt7zVOR3YE+T30u8HNauRhrms3W9y5Be2NzGeSuLEsngSZe9UUahNGZpLPlLZMGknNAH3ZRfVCqpojE7t7t1ttkdfc3qa+K0jhlj5Dd83bxCB8lE5tHBCqb2QlE+MysBBm/af7Hgb538iGc/uG0GHZk2dtXMQhnzKfcNDSbjbbLcYDJB7RLyMQwiHL+/pJwLizY72nulPrer/pUxe1SGMF1/9fDXxnPYJ+KtjmgOSZ3WbH5ggFbcUfgUbkOOOjbJw5R4aVY6Bwj79svJNVUC8oQXF+LF9ZLKtaRSDuVb+SdVLJiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scznPg4HQj6dYuQHNFlPlVaM+Uevl8TAzLcdGhERrY4=;
 b=YSWQP/klVllfyccu3grHEhp/Uh4Z/3BgwFnIisnnYdgIh1Fydkyhd/eBTxQ4xMaMw25rPbf5pO+/Edk3rDU4uKPkkZVDqSwdYXG02YRP2VKQiMyxu7+JTtRL2Vy0Q0wONNOqSYegDehqGx1gFTjlY4ot4iLVsGPWFfHiMg4yfJkQLob85z17fetSBlQ5UT1z6dXuTldmdYw9OrVz6vFgDOt1aX5kJKAX+JCUa6+kHESVeB+ECp+7WML8YXimV0ofwMjCsNx77/BRtYy06RSntQ/RKXr/97JyynO/bwmOOfWV2kZKt3ap0l+Nt9xayoFYVpCyy28OG6DkgtKCwHp7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scznPg4HQj6dYuQHNFlPlVaM+Uevl8TAzLcdGhERrY4=;
 b=Oq6sv7rk8DI5MbqdxBQtpAGSwRZFzfKXxt7Pvkpf3GjhT+ljOoX/toz6dEDCQe+hy0FLo0O0Yw6d58elmFbSmhGZarHE/7u0+OUoxGlWMJmHjO4T/vU6J50vouvA7VwKWPIZE0WQSh5ipqR4eADe/RlJIo0j5F5ZNz8PmwqayJg=
Received: from DM6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:5:134::31)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 21:56:54 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::47) by DM6PR13CA0054.outlook.office365.com
 (2603:10b6:5:134::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Tue, 25 Jul 2023 21:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 21:56:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:56:52 -0500
Received: from XCB-AMAFTEI-L1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 16:56:51 -0500
From:   Alex Maftei <alex.maftei@amd.com>
To:     <richardcochran@gmail.com>, <shuah@kernel.org>,
        <rrameshbabu@nvidia.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     Alex Maftei <alex.maftei@amd.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
Date:   Tue, 25 Jul 2023 22:53:33 +0100
Message-ID: <04b1df6767e596306d029fa411b712d05ea98ded.1690321709.git.alex.maftei@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690321709.git.alex.maftei@amd.com>
References: <cover.1690321709.git.alex.maftei@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 61de2870-ceaf-49cd-95ab-08db8d5a0eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BSQ7n7OiFFBU+FDTmQm/zKIEGj9cjaj3cxWMuvIJk9HrjqzURDLIo1twONmxGsC+n/7ypIXPANS742IHk2EsJ6xTdScaVx0nk/OzaplIoyiQPi7+q2+ZQJsTPLkRqDYN7AvH57XyXuZr6Z1EI/NpGedV+pAevgnnb1D62Q832974E1P8ORtu0eC88NzOxvm4Jr3ImNOUE7Zu6Z5Ahq8ytyLzVGwZDyQPheHwOjulGXEa3CjKDg/ug2mmKYw/m3l0MpMe9d2oESLoZhP4h6H4zOXhLWIA0ZMlvRFSd1vzG4bI/Rt3ZqYNyEE+oFVqWpHV87GD4RWG5IGO8gFkw0OeLXX2g3uFu1b8tVJx9l7woJegjK7PQVeVeM25E0oNxklW3sVr/dtBH5nr6+/wG8g/yUChQt7S1zXHSEBHx+9vQbZEFI+0nU6kOVyKcxEjh+3zeQji/FMjw0TLQGyJMrY5UXJrI0EdNKygTLPM2Fgxt1DJL1MINWBdjQoLwCwh3kwlBxxJWaFWKSBNRy04kgQVLzCFi8+FOWm/WzJYPlkS0KsV66CnBL5ia+5qAL68E1uR8O0umPfpmRgpn+vgLmAmkQcE4eJoFtWG2nq+9OOSA2mysap6emYSvwW1g60p+AYDF6OMR+UQ4+sKNCVSr9gytHiuuXJvwrmxa9nQwneuh0hXiIenx/lCH7uaUDoS74NJ8UJY67S6fL4X8BGvs+9pdzsvym+zW6G9xqxl+TC7ZM9Nw7ObkpzSUyVlmOY1fSX3jefDJyCA7XkFCgbUaK+5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(8676002)(8936002)(44832011)(5660300002)(41300700001)(316002)(4326008)(2906002)(54906003)(70206006)(70586007)(7696005)(26005)(336012)(478600001)(110136005)(186003)(40460700003)(6666004)(40480700001)(86362001)(36756003)(426003)(2616005)(47076005)(36860700001)(83380400001)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:56:53.5368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61de2870-ceaf-49cd-95ab-08db8d5a0eb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The -x option (where 'x' stands for eXtended) takes an argument which
represents the number of samples to request from the PTP device.
The help message will display the maximum number of samples allowed.
Providing an invalid argument will also display the maximum number of
samples allowed.

Signed-off-by: Alex Maftei <alex.maftei@amd.com>
---
 tools/testing/selftests/ptp/testptp.c | 44 +++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index e9438a1862ad..71ceb6444af4 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -143,8 +143,9 @@ static void usage(char *progname)
 		" -S         set the system time from the ptp clock time\n"
 		" -t val     shift the ptp clock time by 'val' seconds\n"
 		" -T val     set the ptp clock time to 'val' seconds\n"
+		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
-		progname);
+		progname, PTP_MAX_SAMPLES);
 }
 
 int main(int argc, char *argv[])
@@ -158,6 +159,7 @@ int main(int argc, char *argv[])
 	struct timex tx;
 	struct ptp_clock_time *pct;
 	struct ptp_sys_offset *sysoff;
+	struct ptp_sys_offset_extended *soe;
 
 	char *progname;
 	unsigned int i;
@@ -176,6 +178,7 @@ int main(int argc, char *argv[])
 	int index = 0;
 	int list_pins = 0;
 	int pct_offset = 0;
+	int getextended = 0;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -190,7 +193,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -255,6 +258,15 @@ int main(int argc, char *argv[])
 		case 'w':
 			pulsewidth = atoi(optarg);
 			break;
+		case 'x':
+			getextended = atoi(optarg);
+			if (getextended < 1 || getextended > PTP_MAX_SAMPLES) {
+				fprintf(stderr,
+					"number of extended timestamp samples must be between 1 and %d; was asked for %d\n",
+					PTP_MAX_SAMPLES, getextended);
+				return -1;
+			}
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -535,6 +547,34 @@ int main(int argc, char *argv[])
 		free(sysoff);
 	}
 
+	if (getextended) {
+		soe = calloc(1, sizeof(*soe));
+		if (!soe) {
+			perror("calloc");
+			return -1;
+		}
+
+		soe->n_samples = getextended;
+
+		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, soe)) {
+			perror("PTP_SYS_OFFSET_EXTENDED");
+		} else {
+			printf("extended timestamp request returned %d samples\n",
+			       getextended);
+
+			for (i = 0; i < getextended; i++) {
+				printf("sample #%2d: system time before: %lld.%09u\n",
+				       i, soe->ts[i][0].sec, soe->ts[i][0].nsec);
+				printf("            phc time: %lld.%09u\n",
+				       soe->ts[i][1].sec, soe->ts[i][1].nsec);
+				printf("            system time after: %lld.%09u\n",
+				       soe->ts[i][2].sec, soe->ts[i][2].nsec);
+			}
+		}
+
+		free(soe);
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.25.1

