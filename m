Return-Path: <linux-kselftest+bounces-9734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBD8C0550
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42697B23DFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A302130A7E;
	Wed,  8 May 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJX5+xeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7512D75D;
	Wed,  8 May 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198437; cv=fail; b=r7+cUvr5TknYF4Hc85VCvKEWIg41TrXI9uaQYWt8FMPbg/MJbslbfJ0SKEzkUIT9Abw70RaNkOcnLE0vE0Czwr3dwbwjDi9kM/oFOQ+wAmQDYft0GhsEQHQONdL9gwEzX9h+743QuyMNudtpl7dF/SV9+1npHmRnvZC/mt/W6Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198437; c=relaxed/simple;
	bh=mPSc5/BtlZufZA/nj9kWrOnuX/d7CLNxJdb5ldZntD8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tDFwdvf9qr9kv68vrTUEncrreHIditgw9vz7qZF+TGgb13wb518hzidCo87KSOqEC1NdhY4rQOPskAjUYxEmPJRmuL1sFm2KscmXJOFchTYBGCHMgvstBWW3n0iCs/oysEcbcFhd8X/aB5xBJlKbohHmzJ3rxCO+Itfz6M703AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DJX5+xeu; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZZmtv6W/JDot46jzukQc+uEWFxpIVqsVpzOYebEbJSpiQAQ6ma6YLolwba00xBuj1o/i/PBDFBNHd6WhJBFdaU+JlBAPWTesawfchzvfdrkG6RGa22tD5nIboiSSV28YjDXcGvrY/7QlQ8gn/qKghjN1MaiD7gYq1eTf56wnc/WndC8qzVA9Rw8dyOm+EcxNv9eF3nelUFho3R9WRHJNIY7kHMb/mTkcJoA3whtyIWhZpQDlPdmiFE2N7wE47EnyeMdiewzyVb3cx/OMKZ7rwQP3YqDgbYIi3mZfVq/W4MnAMxzIEqjCZMTeClI9DDI8PAhOITF7G+/BNdveAnqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qY9Ge3IWdyGCxk1DS0mIbIieNKg3bCNs9UQ7IpR7AA=;
 b=foXtC3dJ6f35KvnixNa3KUqxUZDcB7wizqze8urfeCnHldEXfneQ8UTp8DfF+5bmQ5Hl55rlciFPOzWawrKWY+InmrZ0y5rBgoB/jw4xKkBpb3uozMlPiZ56vCx12hU/vtNw4a2zmsoAXm6i0r5cyxRYzJK2uVDlEIG0ti/U5plEDsa16C0OVCg4tBRTkcYSrOz4aW9QJ3xrtTHSHTNKH8qFrWjUoZRB55wObx34RJNqo3dSYOxSgssQzU/QqKtX+DfpK611IXnz9LXdcd/Hbs9Ot2MYVcRcFWqzFF35JmelUjyTyQlfCErdEC7qoTZF8Y7ToR/CObbfwnRxyw7/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qY9Ge3IWdyGCxk1DS0mIbIieNKg3bCNs9UQ7IpR7AA=;
 b=DJX5+xeuYNW7c+6iF58YdxxSxvM58k3FU7Xk27GasgknGZ9tEnvTLgLsabxviAWI6qr9oegahQNc+xyeHIDTbpj1BWG4hpJGae7GtxUlXTtEMlMdRS9JKgDodEwO0OBDA3CT64l5rtSxc+BUG8ndE8nKqkiq04KBdwHSbSQ5LS/A4jM9lrK95bYaPfYZUV2QQwXtgo/A3BbqRumIGfhrdFghfuErq9vd1zGY19eYskeQucQP4d6CGWneRD/O8MQeRLkE75cxJZfWsPnaqs21ui8jcvzppoaZmCWs2dxdnjnUPJPeNP9LDN8lkHrIDaoPv1tB/hWA4fdsEH0ap4uHVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 20:00:30 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 20:00:30 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	SeongJae Park <sj@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/mqueue: fix 5 warnings about signed/unsigned mismatches
Date: Wed,  8 May 2024 13:00:28 -0700
Message-ID: <20240508200028.272513-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: c82f0666-3190-4859-e3b3-08dc6f998381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVlIZSkAWp3QhO+ehLCAiEG6E4dfktv0cs6Gg1/mjsT5wTb5ooHcypCKLh7Y?=
 =?us-ascii?Q?KwTb7+Pn7ICqM3O0PTWwHw7OGnZO9ky59ivrHwdmTlH+EM1EbLqZZsextDl9?=
 =?us-ascii?Q?b7FLOjkhGvG1/EiRMseGCR0H9vme1KkLTX477u7GAyhYzHizy6CZ94H8Aust?=
 =?us-ascii?Q?spPrrdr2yFoQBP5zXuX1jGksx3rLNGfiL+kvDsVoLcCRfeZeMZvjUT19bqGm?=
 =?us-ascii?Q?mD2miIzZRtz8PdLXg9Pc3K/F5YlSqtkiAgkrR05uWam8u4/K/n0I6vm5IlcF?=
 =?us-ascii?Q?ibDa86hl8aA+pPy4qN7tRX3JWiZceB8rVKm28+dul+6Wo+fkU1CUHCltvgwv?=
 =?us-ascii?Q?6fXEv8Mvz4y6FF45nvpmVw3Yg2qwa1F9TASahcgjXYhQAiAunE6WDsIMkiwh?=
 =?us-ascii?Q?kzdLrsHLQ6OIU9z5i64LV3VrhFjql0JsoCYAzYTXXlO6Ip6fExlU9JQgoMt+?=
 =?us-ascii?Q?XNhRsz9NtxslnU4vkj2v654FTER6N/JCJXFBCSg0uQoL22vDH2qa9uaHN3V4?=
 =?us-ascii?Q?XNU3wgM99s2exRXvLQ+aHCRuIM6ix0LGW7nwKGNAN0/vgc6NE+ksLeFd2Fs4?=
 =?us-ascii?Q?TqejD5kJR9gFX/msOQRtWsq2aj76ZNYwwASZKz6wyK0VXcWl9CrfVMRk5Jd5?=
 =?us-ascii?Q?2CnM8BW+WGw/MskC+yFK8sV7Kxts0ygs9MKz7qNJPfx6g4HayRCa8GuMPcQF?=
 =?us-ascii?Q?v4LDvfoshIEKZHfnKClqjjX+YgLl9UCL3pXCVFXK6gvubNoj7nrXjkbc1S6L?=
 =?us-ascii?Q?ynR7toUAu7Th1Lauu2eXmUgfYkHtO+I/4vaeqDq7fgkGvE4XITAc2I/7M1wB?=
 =?us-ascii?Q?4/xuDzdGSJd2kEvJMW1qr9yOUQ2tqYjbvbK68TgIGrIwTBmehptssfr6kDFa?=
 =?us-ascii?Q?iNAKjdr8hEX1UAaOVJQLr6hu0zMayOi/iArMhRY8RlC2xYbtfbs8aiRD0OkJ?=
 =?us-ascii?Q?FY6nngVJk11OpfbCg0ydSxMn1Rk/t1MOaCxQI7sZrlJsU6IVyqUHvnsM2WQ6?=
 =?us-ascii?Q?MF7kblilClBOEov8YAefNxfih5Yhzj68L0lJ1YkGjOR8EUhmLgl5FCNH29Ow?=
 =?us-ascii?Q?x0G7sSjTtdXOLSKhXsmQaKHkvEBdP641fR4Q2RhmZj8BxYqeSOAIuyI+vNoo?=
 =?us-ascii?Q?e44B8gdL3iTPfdHDcSpnoQli6oXeaC/+wSmKEAxCHYvTKsjaYVCrh2hgvTJT?=
 =?us-ascii?Q?R+CYJcJiv+w+IyKCUv3zIIELKg/q9HsjDcLR9rMw24+2AUW26JyTEYWtfP43?=
 =?us-ascii?Q?TMpjczc+5HoZ2t9FzOKN7nYH+28kFRwCasF9wFQ1Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mKm1tkX77Fv3B4yt/rg66qFg2uRUvYI/7Opf965IqCACVzyE8UwFSqXqjkj?=
 =?us-ascii?Q?pq+j3lNnijj+nvH7V7WHFO3DysfPxj3H/ie8eED3lGF4tOUA1vFHAEQikxaX?=
 =?us-ascii?Q?Xb5SZHFAznmWUPQN4hAggNBcuaqZebCxWC7oO6OioL6Fi59hmsu4ZaJff8FG?=
 =?us-ascii?Q?t2mjKsCN4y4tkfyR5Ui/yyC+05jo1xvYK0QPLYE9D82HRAOj9fTM/Edpbdbj?=
 =?us-ascii?Q?t0mMOWbps7AWsvfsL6r/Koj51yKRIfvGyQsXtGa7OrGbLImOEzBTj8eITna/?=
 =?us-ascii?Q?1YoTYidSyNT2EyLid5V/MSw43/3ew+xGb7BjYzSwkkhm9ktQHW5aycVfk0xX?=
 =?us-ascii?Q?Ifjy2eXG+JEpbY5YW/RxlHJUfnj7Pm1xMz/pXcq3gkx1Y1K8uzf9ofkXhTvG?=
 =?us-ascii?Q?sz377EID8RztIQ19BU9YAH6VyHMTiF623sgCiCyLnuxilFTa/DibHT+5vIWb?=
 =?us-ascii?Q?zPPPqzAXFdhuKJfnGtP49iYjoaHciJreMy0FlDQfIOAvTNoeCZZCUcZJDLCg?=
 =?us-ascii?Q?A31qZJOOujZ/2qV4j1u1y3IKz0isr9RYW/F5PuleJyT+ecqm6a7AZlTNPwEi?=
 =?us-ascii?Q?Ki7ARYi5rTuZwTmLAlLf5hUSV31nByg8SDdEw7r16xZyqGL9DyeIV8l610EO?=
 =?us-ascii?Q?h/P55U9ntKRlBiI9xIzRpEyycND38bxbAOWBPgrGfJoWqhiQluUO/SWMAfkX?=
 =?us-ascii?Q?V6vt309cTgL6GaIAkujumhwpceqTAh3J7Vh9GSTQEwrJhJMuJJAgpi9etN/+?=
 =?us-ascii?Q?9x9FcSNriOUNFApJrPlNM03WltHc/IA3DUAPw1SgJFsxcelDNwSjFuORzzry?=
 =?us-ascii?Q?8Wf3Gg0Qy9ZECN4vWgsP5oJHIwANlMCw7kx8UFz/P2LMSm3ApPPMR/KhI+8y?=
 =?us-ascii?Q?K8xvkieetAfs0it4aE45g6choNSmw3aabcM4cXaWbFm8kcfRsWJXnvB/4mbM?=
 =?us-ascii?Q?wLEwCF9lZ1iBE34TxjzXPCQvhfr88s23wMHk6YE/0wRpPjtCbrIBvHTMvYuH?=
 =?us-ascii?Q?mtLN+vWcI+6jFR74h/Z3G+SW9E7tf/nRlcGqsVuX/arho5pyxKzmP79zwlJn?=
 =?us-ascii?Q?j0aeKE3T+NDZuN8TcDrAiRvntLBuTYNOD5N/IfI3ADn+zt8SnGYT6ahDcEnM?=
 =?us-ascii?Q?HgS8CYolGo4YpXua1dXv3BdkveY0N1orL+kM3HoG+FaJ78EQSzJnBrQCM5Rf?=
 =?us-ascii?Q?aGCUlm7xcwd8hTrtaSeGrAyfPbXOQylBDZULjn+/n/pIobI/qRDzC+QLb80S?=
 =?us-ascii?Q?IVKsrE+5+VsXOvdL3vsOZO7Q9r9wgNcAIs1qxFVUMUiIbUQb6BHKIGzoetFv?=
 =?us-ascii?Q?x1MYknIFBn8eeThR7tKcQ93ZOqL/ixbT4ZwceLZ/akjkm/+6VDjKEuG54ckU?=
 =?us-ascii?Q?/NkebqUSqD2xrazgrIVy5s4Gzsfi5JocvfbLGqwZ9fR/wBLjA2IdukKkh0hg?=
 =?us-ascii?Q?mjSFCXLHFT+p2SrPv4mJN8xMM5IOTJiTBS8mkz47Q2lTxsznXzarGkeVkcDF?=
 =?us-ascii?Q?c3NLHuSZd/Y6U3k1dgOsTSSZMAktge6iJFsvRGJ15b+hceKb83mTQA/5PPtH?=
 =?us-ascii?Q?i9hY9KqQ2a3v0jIH7xoliHNzWlfnYrZ76+NTmkWG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f0666-3190-4859-e3b3-08dc6f998381
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:00:30.7798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV5TWWhf/+x1nI81Pc55WgGzylG7rkzBqAbKp1ytYx2jtTU68ugU1sUxWAA5UGzlE9f+JmclsIIYyvgbziphCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about several cases of using a signed integer for the
priority argument to mq_receive(3), which expects an unsigned int.

Fix this by declaring the type as unsigned int in all cases.

Also, both input and output priority are unsigned, per the man pages, so
let's change the type of both priorities throughout, even though clang
did not warn about the prio_out variable.

Also, add an argument name to test->func(), in order to address another
warning from clang.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mqueue/mq_perf_tests.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
index 5c16159d0bcd..9380c656581f 100644
--- a/tools/testing/selftests/mqueue/mq_perf_tests.c
+++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
@@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
 void *cont_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int i, priority;
+	int i;
+	unsigned int priority;
 
 	for (i = 0; i < num_cpus_to_pin; i++)
 		if (cpu_threads[i] == pthread_self())
@@ -373,27 +374,27 @@ void *cont_thread(void *arg)
 
 struct test {
 	char *desc;
-	void (*func)(int *);
+	void (*func)(unsigned int *prio);
 };
 
-void const_prio(int *prio)
+void const_prio(unsigned int *prio)
 {
 	return;
 }
 
-void inc_prio(int *prio)
+void inc_prio(unsigned int *prio)
 {
 	if (++*prio == mq_prio_max)
 		*prio = 0;
 }
 
-void dec_prio(int *prio)
+void dec_prio(unsigned int *prio)
 {
 	if (--*prio < 0)
 		*prio = mq_prio_max - 1;
 }
 
-void random_prio(int *prio)
+void random_prio(unsigned int *prio)
 {
 	*prio = random() % mq_prio_max;
 }
@@ -425,7 +426,7 @@ struct test test2[] = {
 void *perf_test_thread(void *arg)
 {
 	char buff[MSG_SIZE];
-	int prio_out, prio_in;
+	unsigned int prio_out, prio_in;
 	int i;
 	clockid_t clock;
 	pthread_t *t;

base-commit: 45db3ab70092637967967bfd8e6144017638563c
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


