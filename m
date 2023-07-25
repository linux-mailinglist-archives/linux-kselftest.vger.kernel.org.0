Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103007624FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGYV5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGYV5T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 17:57:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBD1FEC;
        Tue, 25 Jul 2023 14:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2aHZ5O70lXXTSQQ3bbN7/R1KSo2+WJdLSEPtZku2cMS6ZnvSFXiTzoHjOJT7WsGvmjREM7hVe1HfuGd+98idwr0JZw45fmu0yL5bae+CDLHX4SAltW7dHQC/isMYapgUHeFAj/5zSnMWnNnQy9j3Hx2CAob31rqGF9sYUHMVM8VfX0CrHQHjsnAr/KKyirYnVjhEeGLQfWbRE85rICj/ueYJlpv+FhnbbBRgNIKNedKBsGNL79cs568nz26z1OoeoqpOMYlKzfxU53ltJ2gPGFzcZT0RB28B3BIUs2GeeuNXqqOoh98Av0oXditBpai5QtuDqvHIM1h8r5xUuMpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7g1i0zBHTT6EbWjD0l+an81KzGcZ8jG6JLIqs8i20M=;
 b=gDZOdSeCrQLh02+WZi3NO3adu/vckQXRg+3gdNLOeuCG4gNNl2Osq+TkWhKWVfQstgf8IogAV6MjLW27+btSyIzCNchb3hx+pK88Lz/96gShUoUT7AZKrNNVzCIBq7ff4MuTOT7dI1nzlYbOvbUQEc3mreqsYii8U1XW1WwInDnGD69uNIcy2UIBg3xXPkww+dXAHaxFwnrElwoRp4c301QDWR2t3S0b93w4fOX9mFKLe4xN1/+4TKb9xZqt7w0VcYlzyye9PezXHITby6nmnTHjBTmwVU3ihhwIHLhXWjHlu/xHB221lujhcic1SvDyzx6ghpw6Sy1RlpnhMye1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7g1i0zBHTT6EbWjD0l+an81KzGcZ8jG6JLIqs8i20M=;
 b=gqTW33Qylpeu8e/EaNo5iSEa7J2cCfAoQDJZ4YTd+uS7XKSmYrRlfSW4FJ7VOtp4xVq+5uJEvRvs5GEPMoZBzO1Z4jg9L5bBLZkvqKrumJnK9I/tvxgGUYb0z3GpOzn668F3utS/tJViWuDhrwag8BEv3ddvPA57A9MwEJOZF2g=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 21:57:13 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::f1) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Tue, 25 Jul 2023 21:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 21:57:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:57:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 14:57:12 -0700
Received: from XCB-AMAFTEI-L1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 16:57:10 -0500
From:   Alex Maftei <alex.maftei@amd.com>
To:     <richardcochran@gmail.com>, <shuah@kernel.org>,
        <rrameshbabu@nvidia.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     Alex Maftei <alex.maftei@amd.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 2/2] selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE
Date:   Tue, 25 Jul 2023 22:53:34 +0100
Message-ID: <1faf03acc71617969de157770642978a3a1d7f44.1690321709.git.alex.maftei@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690321709.git.alex.maftei@amd.com>
References: <cover.1690321709.git.alex.maftei@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: f6320aa3-5595-4bf2-6795-08db8d5a1a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLZLbioPr1SXGvfbvE2Py/OS2ANDELWCovDR8rk2Du15w4995C198es92lKKhEe2DvdVu04lFRXUET0HHmUP/tkhCDeOhboguSj+WWCPWja1CC7gc8BS7N49TFjKIyNeRrIEqxAsaBX0/nTq5au84FwVPFyQwC+S6gJiQaxyoqsSn2HyLsSL2U4uW9W8sDmF+mIbCprS7pQv8Xp87ViEfjOYdNnaSrxH+psjy073iFT+PUpkfdw6h01vc3NFU1chV0Mr3PGa0iABLk7tDAea0liMBs/mAmO8GrBVwyu+rMRwAAG/mvY7XQ/kTfixMCpmW2KvjrFzm0nEV9mtx4qmJvsc/lj71LkXkrRmX+KlHsLFcWC9d+XXzkHi27xWq7ntmJcpM9aupraLEoE7lyR1W6mxIn7mkMXWCyNdLGxzyvvihFZIrKZd6rc6GOsEPf5BzdLQ0sV+ZJfATFcT6Xp4sf8j3Bw1FK8nDL6JTHfpUDKhuhsmrXEyHmeTNT17N5XOkZJxic/GP+InYf0mJs0ysVrO1XJDjRmm9nhE7/LGludZHQAgpGppFq6TdqjXvTw4sH+IkCAFN2Xl8/LWuDc8oZTYr+bgItVqxo8U3o92aRe7H2OQahvrm05bTJA+I0SlRttuIVn8H94goXRuYrQI3ic/8j2Bc04SGWKL4o/6zPD+24+N5AnAs40YE9u5g3JDevDSE88jR4WI99Qcr9YyuiMozVzvdXerbgC9JVPEDBUAIAQSxPIgqDmbyhAhlsuEZViXYHtIuqDuM2kQGdFqzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(316002)(44832011)(8936002)(8676002)(2906002)(40460700003)(40480700001)(86362001)(36756003)(5660300002)(26005)(186003)(82740400003)(356005)(478600001)(6666004)(7696005)(83380400001)(47076005)(36860700001)(2616005)(426003)(336012)(70586007)(70206006)(4326008)(81166007)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:57:13.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6320aa3-5595-4bf2-6795-08db8d5a1a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The -X option was chosen because X looks like a cross, and the underlying
callback is 'get cross timestamp'.

Signed-off-by: Alex Maftei <alex.maftei@amd.com>
---
 tools/testing/selftests/ptp/testptp.c | 31 ++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 71ceb6444af4..c9f6cca4feb4 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -144,6 +144,7 @@ static void usage(char *progname)
 		" -t val     shift the ptp clock time by 'val' seconds\n"
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
+		" -X         get a ptp clock cross timestamp\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
@@ -160,6 +161,7 @@ int main(int argc, char *argv[])
 	struct ptp_clock_time *pct;
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
+	struct ptp_sys_offset_precise *xts;
 
 	char *progname;
 	unsigned int i;
@@ -179,6 +181,7 @@ int main(int argc, char *argv[])
 	int list_pins = 0;
 	int pct_offset = 0;
 	int getextended = 0;
+	int getcross = 0;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -193,7 +196,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:z"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -267,6 +270,9 @@ int main(int argc, char *argv[])
 				return -1;
 			}
 			break;
+		case 'X':
+			getcross = 1;
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -575,6 +581,29 @@ int main(int argc, char *argv[])
 		free(soe);
 	}
 
+	if (getcross) {
+		xts = calloc(1, sizeof(*xts));
+		if (!xts) {
+			perror("calloc");
+			return -1;
+		}
+
+		if (ioctl(fd, PTP_SYS_OFFSET_PRECISE, xts)) {
+			perror("PTP_SYS_OFFSET_PRECISE");
+		} else {
+			puts("system and phc crosstimestamping request okay");
+
+			printf("device time: %lld.%09u\n",
+			       xts->device.sec, xts->device.nsec);
+			printf("system time: %lld.%09u\n",
+			       xts->sys_realtime.sec, xts->sys_realtime.nsec);
+			printf("monoraw time: %lld.%09u\n",
+			       xts->sys_monoraw.sec, xts->sys_monoraw.nsec);
+		}
+
+		free(xts);
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.25.1

