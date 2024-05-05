Return-Path: <linux-kselftest+bounces-9488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437068BC3FF
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66217B21122
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA917C6CE;
	Sun,  5 May 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bFsOtiiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E12574F;
	Sun,  5 May 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714945655; cv=fail; b=szPC/LVYOkcFBf6uxjK/pnT7mVMUhmly2Vf7oieurH5HlS8AYZDp3NnVFPer45AjcUfVp9/iXMrjFZBNQKLUMkAfzqhRb/ObNAuApbuFch+ErRZ7cxGShe7zMO0+12t5F+tZCHqINjeQT8qF8qE9MCxbPlHy6zymU5Egr9CpKLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714945655; c=relaxed/simple;
	bh=Ea+GXEiKX754wvjeuSRKYo33w+yxtWNA7JPLjsE2N5A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I6B89vTD24szRPMoXh5zqeUZiBq5iJpdZm12wNbHCJcsyQS/rptTJrHygwBzrJH+9eUov1xJmjUy50mx+E2joQoXjT7HxveD3u4wGUyXoOGtCTWTKXulH+URpMuob9b8VMKTvZPn3pEqFDxebMggm4NQFHq/F6peCNDkRQSTrlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bFsOtiiv; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyE9FXukBeTcj0vu9FTwgwwxpTmTPFI79kDCaLpMf7hh/iTCYmxsGTdcp4oLNMsPkt+IZq9Qadg9ExMyKtR9gfIDVRWIuOD0dmgBCrbYaDsR7HFt+xxoPVqLnK87KYfVxSwoBF8U1X/VadD+c7fQe8xizE5gQj83aduWK2VIWnryjrmCl9P1QzmoABGZZHeATXAFyNIcDfWBe13MwUrs5uaKrsgMmPZxqjvBh7L0mmRIYDZCy+XxsYPqvl7+4Vr2RtDVHnVAYBiKWA5a4lSZJpn+KwkNwoF31fTERILcuWFMYHVZfKWIovwuxg+lUBWmkPdhHaG0+T9yzCIgaybilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=393r2bX2/530z4aLiF8+IUnJsBOX2Xh5HFLGkuUKOQ8=;
 b=jsb9HSwiHCa2lnF/Tbz8CwYw0420Pv9W4/rri51sC3IwwYzoSJvKZGssM1S653wdm4rXIgViDlLG+HraaVmS3aE4QH+UDkl6eEPEAutLqsbf0O5umQgFOObCRnTr0V1G/ZMZe2NVx36VNEuhdC2Dxi/iCka286pYd47kRTkb5fk3M5HOIvZ6R+cea8p6UyM51HTeGvT4bGuGAVFS4H+EPRi8ou5HWpJ7OOO4DUaTLb+DN1yx/tXgbym8ygLyWKX9bSQPnLGekmk0x3CFygLPQffb+7hUHpv5PrRHDFyrQDZZwn2wHofnT5nu23+8WfdNSq0Vp7PRxDJtTgpLjOUWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=393r2bX2/530z4aLiF8+IUnJsBOX2Xh5HFLGkuUKOQ8=;
 b=bFsOtiivScS1TgF1NgnQVF0VycDLiD9oesQ3dN/Xvk8H7E8YURKKWuXmyjUC+3O30OhD3jXu5DUWA7NkzTaveK0vbpifbeBvJw9orudO8sw11wifE78MV4HqSQ+nX/iHgpXr8hAK6EgbESaLOYHbDahcy5UK2roj+S6YWzcJSuZPInEo9U+vPVoyJ6S9II41MX1GnvZG3wAXt2gDZATKhFVrixBSOKNuCvrtuF4RDGV8vXZm+EvaMtTJ5zPFgYVT1letxirDV8jBtkvmjJdiNYklb56BGBXLBrfs6PIppOMTzmn3JK1U9PSaqL8MMuKwV9R0jDARnA/h6kyrYkRqig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 21:47:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:47:29 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Max Lamprecht <max.lamprecht@mail.schwarz>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] selftests/netfilter: use socklen_t, not a signed int, for len
Date: Sun,  5 May 2024 14:47:15 -0700
Message-ID: <20240505214716.62304-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2029e349-6352-4fff-0602-08dc6d4cf62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nqieq+CodbMvQwJ9XBTeymFiq5ozBR+snQa5xrUdQ4IsXY4YsH7+ZEaV2lk3?=
 =?us-ascii?Q?YMyE545fPFpR6fT52q6VabsvRDHI9HKfBB9EeKEhFt1UP8G28d7Iy+vL8rfU?=
 =?us-ascii?Q?woWg0nYcPByQFexfmBe8LV6BMOMO3iFLyYmPkh2L1uEi4M06s/rDo6SZTrKo?=
 =?us-ascii?Q?I49pJ9uInWzT23qcXf7VkuIjWjm23/B4dRWKyO0SyfIeBi8kXZgwrt2rFhJ+?=
 =?us-ascii?Q?QYW+fbOjDdCcwfZDVB/D1IPNjZzh/CuvS7Ys1kbZAE57KGo18YXerrFWDrwe?=
 =?us-ascii?Q?jHb9Strj/YRiAqFz9RAnEBaKkocjNgzlipwn0E8/hzaNgPruqYUOmrZAvkIn?=
 =?us-ascii?Q?fv2uP2qR23Vx23l8qADsfDWOu22UOatLaO5u+w4JfC1Yr9rnH2lcc9ZTVrFm?=
 =?us-ascii?Q?HVNCWHMt3G3sPcrVFhi1ZdBJ3KHA/l7qjl8aH5unIhfEIEhD4sh707werLe5?=
 =?us-ascii?Q?2kXKhKvBJTDP1IrCmnbELo7/NaxJPc6HKsD181kGPeh+zed3YonFKRfgc2Cn?=
 =?us-ascii?Q?LsFla5OgOKKyTGqImfQJc4dClVFAhuVGd+BxLpzaSVm+3Qn9CLHZ5NWzeRro?=
 =?us-ascii?Q?83sMR4Vfcv5oH3Hu5aoKZamOlMQqC4raQvMCAaimw8GU9MHiEmG4vNQQ6uVQ?=
 =?us-ascii?Q?ozpXLEzBxlS52O8yNQprP+NaZZlZBKYBs3CxWGzA1XkT/yMAqYg2cp9coe8w?=
 =?us-ascii?Q?oER7ficfj9+ii8+VguWDy2JLEX7eONHFQP0uhjgy2sHIV2IQeTw2MKnIw2Ee?=
 =?us-ascii?Q?RuTykfrTfkHUd/qUCvCGkm1sHAdn2J21Ai1dk2lbhMT/Jx7UARc93BDONvEG?=
 =?us-ascii?Q?LTPtmltDZUsCUfMTH1y/i6KU5NJ0u5SoeLJK1llHMNyMvm4XqSDRRD8OGvL+?=
 =?us-ascii?Q?OAaALxjW+XB/JXgmSEZLnjGZaEV0l7+dj7qf4VxycHm8ARD8TacKLcmKCwtU?=
 =?us-ascii?Q?b2MhEn5Ex+suSwZs2Cxts6fmbU7ff2jN5O2mW7bfNxI0Cw86nCoOM33RYIYg?=
 =?us-ascii?Q?+hkFDJrBOWYWPBTWI9eiH8v7mS3ugjrAbLo84pLgbN6iauci0g3UwMF3wLM9?=
 =?us-ascii?Q?cAElKquXtdp20P8AgORMIVXuVNX28RKe7UQoC0RkbN9Y8qhQX8Rd3Nq4nQ5s?=
 =?us-ascii?Q?NYbMnNjzLsrvK3LeIozyfD1PyoyL47u0eIJSRvxT85k8j1gKyyyK9PLQwmzq?=
 =?us-ascii?Q?Gtg1kuEhEx3x9ZpzQ1YbogBuftqGHwWxhd9e+7blvfONMK0Yjz8w665pQiPZ?=
 =?us-ascii?Q?WcZ/eL3jAyfNa4iaytM0Kl0sHKJ36OAfLeMMVN62pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MVDzA+myrF4EYS++6OIV48YslxI0m0F4A/mPMYIl+eQkNt1ImWSvTnLBZ1At?=
 =?us-ascii?Q?ep0/GShVo6HFt/LFJqSsHuLGoJk4zCO7+4oqOIzN7adaht2P5oLfx5aNTIBG?=
 =?us-ascii?Q?inDOB8Nm23BVZXBHxXL4stKZvqVP5LjNhybS0G7PkrbCqwZ6p5crTvLeqiOS?=
 =?us-ascii?Q?ErPPujLYrQDZM0FbgLIX3H0gsTEU+oppZSjrrwwYV4nh+dAOlVcEVDmMCIEn?=
 =?us-ascii?Q?dWhfl3S0J3lv4ski4SR6wrT0b4SI56bpVtzvctC39X+p24tLTXIYoltTbIeb?=
 =?us-ascii?Q?5Y5qHvDtxwQRxjVE3n1JqH0qxznZhbBgxmHIb8YrzndZ73/Spr6WbtCiFXVu?=
 =?us-ascii?Q?KPG3DNEnXFt0LrpmBRLwSRy9ibnMkqe/vmry+Rbq95o1GYQAOIH3h5M0TJSY?=
 =?us-ascii?Q?6H6l9hdrXzYxSFqxy63M4q4Cgiaec2rwDy5DQ9GFWVHDjuuwC3s+qc8nIuyu?=
 =?us-ascii?Q?xIWNOA/zWOsEo5eKPjr8FYDVJl+vmqN91cS1YjszJLaKBftNAo7xc+GGM2gn?=
 =?us-ascii?Q?hijuSjujw6bZCFAF7/hMosMZMZBjNIOKgrEQATmksDhWxRsxkq4cflnBW61A?=
 =?us-ascii?Q?R862ZP3KpqJzCN7xAUtE14XGUdnNhLqebuYMjUv8sfYwepIK93S1EWaf7KcL?=
 =?us-ascii?Q?L/ylzq5GBsjX7ldmazle9HxJ0Jwo35Mo9y0kJRa+wWnnUQCzAAegf/zz8lYI?=
 =?us-ascii?Q?Qs9QKhOSaUK2zrOFhzLAs5JDKA6XnYAFnAtykU7DofpvRljqGYOaWxUlSlY2?=
 =?us-ascii?Q?YM7x2k9KJrIQ/n+hEJhhoqksfUvn/2CAcM7eCE7/wKTBQzItHGeAdHxnNTNh?=
 =?us-ascii?Q?VJcewOooHnOEdzLEkiDhXe0fe20L6hVp+McChSIlwUTXYlqxUeE69cABgnr+?=
 =?us-ascii?Q?EOWmdgw3M6zSsUg4H6u5VFBTxkA6FvL/bHEQKCvEi4L4xU4FNiFZTBpa6GFq?=
 =?us-ascii?Q?pmxZbnK/bERT0+bpL6lPY6eIMKcsWUVDHHFbHsiiXi5Q/fNFfKg+SJKiNzR/?=
 =?us-ascii?Q?FshlTWZsrm1x7AQd9OsvK8sNnHHMJCWuuogzV5C/n/ehuHiSa8frevPzKgV+?=
 =?us-ascii?Q?Uzd0Tn0uhKUj4Qc280jDubdwwvksWbM8wFsnGsWL+XFCTVG2gjejpPj/Oiox?=
 =?us-ascii?Q?Qz5Fjjd3rURIXaUL9iS4T4q5zj4371zmqNCLXu5aOTbenCaws4iDIjZexmCJ?=
 =?us-ascii?Q?c280Ggz8I3wvay6ihUiuEuxYfMdpmPsloqprAl6VX0DnGCCA0IYG9ek/kPYD?=
 =?us-ascii?Q?Ocv3qvQ9SHf6pORAi7PDvHRrCel83bkIqKfX4KHn06XQkjHdug2jrE8Mo1ae?=
 =?us-ascii?Q?uFL6XVy3u0O4wsX9JFQC24Qn/wu8Zb+I1tark2S/3vp4DniVN9erdBIh/yqW?=
 =?us-ascii?Q?xFMOR5vv3QwgQ8jTu3qUw8ibx/ZbOiNq7vr1RnqgkotuW6C19vLdSXrpS9TR?=
 =?us-ascii?Q?QvxR17UYdWbv6fK+VCA9pz32PEcEFQcIvOjcIiJPxPPPEmKYY8iFFNgy3KwQ?=
 =?us-ascii?Q?wI95kRhwpIfVy8HIILMy/yOl6f6rJq1aGZHRQyg2cfO1Ev/FYIT/ePMI1giT?=
 =?us-ascii?Q?7CzbXh8yM7bwAansXM3rLa5V5n4y+gjNHkhD0B3eioLCOxjNPH3f+ZZNFVqo?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2029e349-6352-4fff-0602-08dc6d4cf62b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:47:29.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+RC6JLr/YG0rTNd32nAqaZBZDzhfBcooAA5aTiqLTfOoOX0xGDuFkrq0d6Vh8yn/UyYHCW3xHH/VtJyJFeByQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about using "int *" interchangeably with "socklen_t *".

clang is correct, so fix this by declaring len as a socklen_t, instead
of as an int.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/sctp_collision.c b/tools/testing/selftests/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	int sd, ret;
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
 

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


