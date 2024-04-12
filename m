Return-Path: <linux-kselftest+bounces-7840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A228A3469
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308C11F21AB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0E114EC60;
	Fri, 12 Apr 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hOdHo81Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A514D2A4;
	Fri, 12 Apr 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941593; cv=fail; b=eYOanYsEBfw9yN3gTDz/ULzZVXA7CFoy/Lp4E7wM+lIFw2BfD91iHjY8UxBtIfblg30zO0n4BzIs02OLNCGtMsx3hTVdPXva5QTFJNh6wU2nZKE6TZ5uhPiosrtrsU0XOc5TuPliWbQ8AY6ju+Ifukj5edPcNHmYpyslQj8SGP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941593; c=relaxed/simple;
	bh=UF4D/dNmMXr/G0lIZmLD4ORkClv2/jtS7qM9xNB2/KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6tTi7WAxMlC4lKQ68NceH0qV2+9ZhwJEYddZKIj1oswMPMTb5fI3e46fWleniT3PMKudglHF2H/fLA9C/kfQnFBNd6KXJkQwyGRtqnyalxTqN3s8q8Me8vefX0+zV4rTB4gT8lBp2ArzAn6RJjIkiNwvyMqXm+Y54mRWJvbfNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hOdHo81Q; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKI4YH0fU1r8QL3jA8tPjeOGWxQeuqp8gPH9Ve91SVyGQ0EHYaAMIBp4mh0haDy3OBRbx1I+awUlbDTZNB8wnn8k56d/y+7vbD7ous0XqOrl5RJ3BK1s/whzks/YxuXUY8eFWabPHIhXaVusz8OobsNOxRSexAv1Oa4BvbeupWe2IMpTgJCqfzUw3HsFqDYGa3YAXYU5BHiVRc+ScRoYGt28Xzf2GfJPavt09XPTPadpzA7z6pp9bu39I082gr0ULOB72YgsEcvjwAWrzc01gdW8NRo6P1D+bIYkK7stHXhGqBcvgQLdkRcAXLgnVHbyc0hJ+e/Ee8xQtuJdDERJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7jZkJpnbGcoFwE/4u8GBwK4QJwgJR2KhtSOk5ku+ns=;
 b=CWicL8aV5J4pH/JnwK1jm6ukXIJ0dre5PkoFhZ5zhWm5iZW9RQSemF7dB2i1DlboAKhYqWbH6ZU9DTzVQRttyU+GqTwX5Q/hQpTvSyW+JtqG+jI91jBhLGigOEEvZ0rbg6A4dnO3JqnAgmidHQSgP9YcGrKcmQkMuw38QWa08V2GCoVLulXxwtYiNzEFAyYX23uMAK52A5l74FpU67ZA4tbotRT06C137C9GMKJS/voQ7Y5dpCG4yQWofCSSS9Lvxv/oLEwkjFCAq1bUMFovg41wC93NM7eHe7K1lU7BfriFVrqT7UOjTbJiCBFCvTQqjOf2QlTRksF1zVOMjVCNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7jZkJpnbGcoFwE/4u8GBwK4QJwgJR2KhtSOk5ku+ns=;
 b=hOdHo81QPKRErVbcwINH8UOkCHqbW1JOiG7bMEjUgX9SEmyNxOCKHkZKenDb9qiKNQ/FUXz+ArFBGHwVQxD4q2fHqeaqJHdOk6/RZQlzefJYFOeSCKpYvn3wd6lWEso4vuPgFKbmCI9yZSaghQcIFIQ6/ODogjsgEcjneyzJtih2DHhhOlRM18Yw/sugjx7nUYadN9y8+XdVzKRyctV+XvJOz0Dx8lRfuMUNUk6XkoDtBQmAPRtQLQmdaclNel8PTZDtLg8M4bvwkg00fFrNIRS+BmV5vaR0r7zhTdThMM3gYg/iLBqhoDQ6iP8TOD++j7Ek5Q8es4VUwaa1srAukg==
Received: from MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:06:28 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::ec) by MW4PR03CA0139.outlook.office365.com
 (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:06:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:06:01 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/10] selftests: drivers: hw: Include tc_common.sh in hw_stats_l3
Date: Fri, 12 Apr 2024 19:03:09 +0200
Message-ID: <06544da1267ec8e6bacbf465838674a75190f958.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce02e18-5a69-4bf7-9a6f-08dc5b12e324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IeQYCN7ZKIJl4kQFL7zkNCz47WYkctXhzwoVF/YzsltQsa8cVXWSODiZDST++9VOB2YDfFkc8UBaNOoTNxiOiznFwqtI0eVyFHmg6TKIPQkmhIFiLahnE2WhDeit6/hoXgxMU7SNvIz3gBjZx8KbKaWC1z7Djt2My0mS1QD1nehb2nxejY0QhDR2Zawe5UYzSIYYUrne4R1msASih/UfpeA7vXHsObZ1q7Ip6GrUf3q/U1tb5V4o1/Astzjm/d8qtsmMMaLBqaHS3li4NhxTXB0eCrHyysbbRY1JXiFtpyc5rwonNIj+QcA6HNEXVgHCWEEiSsYRf/OhOoXmiLKf2lrAFOYItBcHNLib1qkCbD+S0kUGGkYY+0B8Ol/1yVT67F2i9gwvjfecpN5HA6u3jL9XTfYa0Y+qmifXIHK0JzWRGisKL2/re8URVLy3lPkeWmkqyzmGgXH87oGoGyiSFurf7KZJNZJtZQtx25Sbc7A8EUntgJjBjomJUfLy5xUAtDi+syuajbQtHii0oVrDU9Aan8f2ZlphJkZxrKKbiDBAkIYwaBbCrB5BejK0XaR6FO4Fx6mPd4n4Q/sIqemqq35XtxvP7mC4P+O4+VPDfCbq0PdIYxcPMX9ewy+NyE+ehiiDxN222Q+fASTss0JfVlVI1w0XDP/f1tltuHaO4cV1cEsS2XsHSn+UrnkEJbTuHCxeZddb2SKE6OTwf3UqbCPXn2BJ6MnC7kCCZhIz0aY8OCemOEcwRUs1dVIRQ8h9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:25.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce02e18-5a69-4bf7-9a6f-08dc5b12e324
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

The tests use the constant TC_HIT_TIMEOUT when waiting on the counter
values. However it does not include tc_common.sh where the counter is
specified. The test has been robust in our testing, which means the counter
is bumped quickly enough that the updated value is available already on the
first iteration. Nevertheless it's not correct. Include tc_common.sh as
appropriate.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh     | 1 +
 tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
index 7dfc50366c99..67fafefc80be 100755
--- a/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
@@ -50,6 +50,7 @@ ALL_TESTS="
 NUM_NETIFS=4
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/tc_common.sh
 
 h1_create()
 {
diff --git a/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
index ab8d04855af5..a94d92e1abce 100755
--- a/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
@@ -15,6 +15,7 @@ NUM_NETIFS=6
 lib_dir=$(dirname "$0")
 source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/../../../net/forwarding/ipip_lib.sh
+source "$lib_dir"/../../../net/forwarding/tc_common.sh
 
 setup_prepare()
 {
-- 
2.43.0


