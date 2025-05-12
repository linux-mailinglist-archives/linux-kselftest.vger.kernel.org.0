Return-Path: <linux-kselftest+bounces-32846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC7AB355C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BE016A0FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8D26981E;
	Mon, 12 May 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pMqTuYeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023112.outbound.protection.outlook.com [40.93.201.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AD2690C0;
	Mon, 12 May 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047204; cv=fail; b=V+LiNYyuCwV0P8Xp6kK5DHg+KbZVjKdBTTlAp+dHJcr7tjvWmaqCPr0nF0wlYvg+wdr4lpsRSM5YDYmtZBJ6IiPg5i3oo8vGUp+Hl8qQeUT2OGyjTXub4dORP6TKf+YQiZCf3rfBmElRUnWR32eUg9KvZ8bN3Q37zSlfvmOX2sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047204; c=relaxed/simple;
	bh=PqksUTGG30LrLMfQMA+O1RYRH16slCUbqzapDKaFCkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i6O8hZMLLabVEYsEjaVbDKSAX9QHfdgFz2jHl+Wuete+JJbNzaRjY6Q6xC2BI8OVQ/dZIdFyRBNIh6RjvybuZDdApx5mNOOmKTUJVpUsNYwuSRpkDJ/hMZ/qRhHV+TPuylhwyEntYapcErJ8XIpdv6tPLaAptwccxtFKZjrwwCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pMqTuYeL; arc=fail smtp.client-ip=40.93.201.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhL5WA4wKtoJAM8Gd6S8OTZztGAnJ2ra6vcll6PfxuTvRDINZfquFkmK8Ca4kBnGs8WEKDGqyapOKxCPgKuVz3afCufclm8DrPZuP6ig6qZYlVHH6qgOAKDlzj10jqRHL/M5hVZWITnEi3tQW11KrHnfa/Cxs1omuykQfDTHn1oEPnqc2vGvttzjmRfCnvnAZWV1xtpWV0Dt5nM/gWIfUMnZPlbzPg40Ghp5urz6Kwu1T14NVnhVk0N6Zw6J7BcQuwoKa7YnhE2w7EGlQO+KViK2UxQ+83C9FznTPBs61fAZKjkFKpyTuQUMS8F5VIIRhHmpA8GQu91vUy5tPck4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L05xc3yqBYa/yx4IrMdswRl4wmLviOLP33WWphRodaw=;
 b=h1LJKcfMpRqr6Cz9U/VL8rRIb0+ynI2JtPMPxv9Glfv+5C9Yv/rETqKfw5lARVpHwCx1IkMoeb9mjJ0Ohzis2NSGYfwWwAph7dPyt9mv+XjHtnXWe6DnY6KVupVWL30s1dlpj1asxRj0TFVC97GvNO0+q+v7kgWKrDDm1d7Klfq8nCBstl0B36ufYKEbEIN2qChYYtRXl5aRadctOovXuOBoUH/4+bFygCENmVALlR8JVxfPMCEw3sb5eRAozmGXtAXCJ9cQhhvQ2n4PNMmaBFkqQEYU0GiM1bGTNMnhWRO/S/gtbOvjnzQCl8UKF4L7Y7rFnGgdTg+pyJaf0jMGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L05xc3yqBYa/yx4IrMdswRl4wmLviOLP33WWphRodaw=;
 b=pMqTuYeL38Pvyoot4Iza4zjuMZ9Mh+DGoF5OlJpJ18uf9ppQfdZ8QgDc8dh8Hh6VFnwfL1bpOVLEraVt09tDkDBgBLOvIEZroMjtq/AmnMxGsX1fwvLUzw6YPZu4syVrqujOeXPoV94AQCx7ZNzO9tH8fjt/Iruwpa/Q4tB4k0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:16 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:16 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	seanjc@google.com,
	darren@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH v2 3/9] KVM: arm64: nv: selftests: Enable hypervisor timer tests to run in vEL2
Date: Mon, 12 May 2025 03:52:45 -0700
Message-ID: <20250512105251.577874-4-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:930:6::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d75353a-eb32-451d-ab72-08dd914332ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H8KgIbNLMN18eJXB5qTOkovsXGARIWSPHjmQ+klzk9n/olS1OJvkzeKraAOh?=
 =?us-ascii?Q?iaoEzG04tTEoC2QsbIIi0gK4ujeLdSu1BLgB+W4tiRFdsNQw2UCYfQXlA38v?=
 =?us-ascii?Q?o8LciDVONnKRhqPBlFBhhUKlpzdAhxw71e7+rwYcDs6QMZ4xhTOHLpAM8FEB?=
 =?us-ascii?Q?jxZeP1asnMG1qU0NikoaHbps9Dl7tzAyvUKpyBXNsExijJV24J9VHHdaBk95?=
 =?us-ascii?Q?Ponv0Qti6P34J/kZnNqdDnGw4ldNpXKxd9Ixn3aWzAIcI2gG4fBPzTJM7B7Q?=
 =?us-ascii?Q?5AQ83g5NbH2sh6Z4AmybffDMBo7zq+GdaKIf1tfdktqKnnwf0967M2+++cdj?=
 =?us-ascii?Q?aUUk4TL7cVNWfx+p9dpEieKE0gLSRa5p/hCcDkCQ3eb6f+0Hl/Hz+6GbVLhV?=
 =?us-ascii?Q?+4jTw6kp02zJvlUoG7xUSSq/2h7Fi2UUTNmTsLD+vWq1JLTNZmqRRVVmBP7H?=
 =?us-ascii?Q?xWlnxF22CSYhavnNHsH22hOxW0CjVIaWnh8oX+WUCqR8LcQulGxC/JqlWjip?=
 =?us-ascii?Q?syqAe27yghQsF00WvuFdbvgmyshaGtC6Njt9LszXKXP+vw4Iy+ZO+dWFSmIa?=
 =?us-ascii?Q?rXMHw/04E5AlWkY00ZD6GEDfT33eQ0vzTisRKySMt+NHr0G8bErdudNrzGlr?=
 =?us-ascii?Q?U3m+EZXXZyCYxKuoQ5U2mOkRbhe4qWDHyQ2SCxCtxRuNVPZY76IhrQQYJQAs?=
 =?us-ascii?Q?mEVB2hXY6apbzBX9YWez5ihozhwpo01x8xberz5A8Q9Hjk7Msdc3Ogjr1PIa?=
 =?us-ascii?Q?QCCJ2mgJrFHEBgRnf4nNoLaNy2+SA2pT4GUNg0k03qg4hrKYPAR2knqtP3Q+?=
 =?us-ascii?Q?UgKRTuO9OP8WoIoa3ApSDArF9KA8qfmEtKbPqK2wwNg8g4eewncrSnab0Lko?=
 =?us-ascii?Q?wvZ6hUnWsm2X4RpPZTSh4lgsITj6YccX8/zohzAgKoL0A8dkAD1E/uYKu4Ds?=
 =?us-ascii?Q?sY1UpbesXXYZ3wyEwJ1X/VgxsV+CfZx2pyvDFRDYqdx9fK3EwxzY52EcxtF/?=
 =?us-ascii?Q?1TsdMS3Qwaf6T/3xaMSs3jFPYG0FVadAu+0RTCRp5Fohsx8dAyu/k2LllXDH?=
 =?us-ascii?Q?gUjXlolqJYRwfYd8e1ipHFWCJga6Sfkep5Q6TkXOrFHFNmoYpe38NzXKGFjP?=
 =?us-ascii?Q?AAvoZuQSGn5Np6hgcc6sl+mumNCL4ziqb5LbnGqxaVzxO9C8bZgZ/kWJDXDu?=
 =?us-ascii?Q?aM4LigVs8zX31bjN72rO62FHJ2Favs99FrbN6xh+b5h9n0yPSIlU1yygvtiL?=
 =?us-ascii?Q?NyMjrKFnStU5iQ85kWgsFuNLys/zPCuJVzE+xOlCfeaa0eR/sW4Bc7j3XNAQ?=
 =?us-ascii?Q?CAEVwKwyNHOijlTzVV5QytkOiLy/7rA6rYn10NSSxNto0ME4FSVpx5e70hXo?=
 =?us-ascii?Q?f3hF5L27xkUCRhA/qCnkONcWMhSCHDdLIEZqO1G96a+cFzy3W7zyWwnxAAwI?=
 =?us-ascii?Q?NE8S5N7GC7dL7gxRiJ2lw+Jd1+zXykn7TSQU4j/uus+ptIUSkjERCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7N/OAVYm1puxFodpSZCK4V6nbdEOxnzXFxvuaWnFZaTIMKxVl9O6PoeroDt?=
 =?us-ascii?Q?5DuT/rFhE8RJUgMFzJWKmBaQ/Ud0DwULViDvwV9cJlE12IaiGOi4d3Lw3RTg?=
 =?us-ascii?Q?pxjgeo+CcC7FOh8eJW02/Xs56Qike/X5ZZBD9ryB5kmEWn7PgRQJPT0tRAHN?=
 =?us-ascii?Q?O2Okl8CdFZ3Q56BPNpxFPbJ0469/ZuKeM9SCU3Oc2rU/RrbeGXcgT58lHKJT?=
 =?us-ascii?Q?fdUZ7mVYmESNF/BzP1UqUTbCDRsNA4mSJ5wYf/K1VJeWM9c94Oli1k8DUyhs?=
 =?us-ascii?Q?otCQmtRrAxka6vGbqxPQZM6zWxb1WOHlTseioqmPgvnUlSdXxvjvJSs8uvNb?=
 =?us-ascii?Q?4nX72GjeBQaYSwGcX+59pRY3nxbTqcN+QLU1AKy/UmuO9U53wEZCejuZekVn?=
 =?us-ascii?Q?+LyaL3JJAr3qkKpjrkaPXNMiPyV8ngp4J25D0IObcQV4swrLvyDkQk2ymqNI?=
 =?us-ascii?Q?Jy0MTQAk3VvPBcNoHd3RkZKvdFeg8qWOUbAN+dyhl4Mos27BNALcmc5Ae1jd?=
 =?us-ascii?Q?38sNlztiaOnHEyEdVnQj4GKmerYnN3nzJPl7PfBWDuVAT1iu6ukprFnomlRg?=
 =?us-ascii?Q?ouC5lxkvpiaMjp4Lk8TItYZdJBze5v7q5MJNAvs9GGVKlB/UZJpur5ok+DmW?=
 =?us-ascii?Q?emBp5NZUINTin8Mb4+r24uvj0eIsr1259QYrY6tEt403/aMw0GIAqsCmSF0u?=
 =?us-ascii?Q?bX4nmcnufpPvFL2TsoIVNUnn5kpiZV6XvgxwUBTB2ivOT1u1VueQGIZAgT7M?=
 =?us-ascii?Q?so6/9Kp9IEhZvmg7513Lsuvy/E/oxB2h6zl26TnX74NBGTodX7XXWd0387P+?=
 =?us-ascii?Q?SxulqC4c5wOr0KKrwPDnsR3e/NDgfP9/hiiUxIBboLkNB+ASaIxCaw+H9G4z?=
 =?us-ascii?Q?3xWNcnOfXkWt7iaYHY89YJpZKLqGP08J2c682xJA6PVRPrNGHjZp5pvdm9Jm?=
 =?us-ascii?Q?YeeJH+aRbKvhOEWtp6Ol9gPE397xxO+zAqicBLjjgx9t2L/TXrmTcIuKLMlJ?=
 =?us-ascii?Q?sTKssWkGgG+OlRskYIY09Gndz8QHC1yFJuwAB3EpwW2Vjgo/9VfDS/pjRqbD?=
 =?us-ascii?Q?goIxc+c5fbgU/fdNe1N3C6JLxStEtnT04eG3Gcp5KbwopkSZNOHHkk6l+uo9?=
 =?us-ascii?Q?PP+m6BIXn/dn+cdwM5FXt9S/9+4pK79pdlpk+lmttWYPhkXyNMZ0CahQfWhj?=
 =?us-ascii?Q?YoImEsVnokkrTbPvBfgfFMQYc8sYbIxIvPkwThcHrZPbSzsA/JBhkSSxfIMs?=
 =?us-ascii?Q?zQajw9uBXjgMo4E6tBg3so1N6S2rgBqZjuLZXx1NIjnnudmIW4W4n2+ZLSoh?=
 =?us-ascii?Q?zOiGb/bFwId6G66NkqjlHrCCOgv8l7ZDC/lGzNgVS1Hpa/mspr0AidkV15Da?=
 =?us-ascii?Q?T+sf4QgkKMZm52+oUorCT/uRc6Vg/LoRqBWkaWnX29odCugPFj+0V8jgCGly?=
 =?us-ascii?Q?pvjqITqC1rYF18X6LQ/It7nR13GQY1YtaUu10Sc2pGezS5JkgmkHbI1M0k8s?=
 =?us-ascii?Q?ayGgRJb9qqvf54dycF1JUl8t9ItA11nm87B2swttWkD7aDmE+/ChEozyXlIK?=
 =?us-ascii?Q?vswe/UP4l7Bwnwhnzy3a1F6ITXLybtO/ueBKD0tVqSNeHyADQJJRi5sMEer/?=
 =?us-ascii?Q?oAM91uUdWwZg5r1LbK31v1FI6dECyyMEoFocVyPoJ396?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d75353a-eb32-451d-ab72-08dd914332ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:16.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwdTL1HmKtwbhsqtI/+Kb1o2l/G7jZNvZHlwxB74UvoMEDidOquQWUSdqdDR2/4q53ZQZNCvk8D2BC7+ScCO90Qi8iTfEx9h8K4i4OY5dI9HJ0nSW8a9gFrdHVQIoNJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Adding required changes to enable and test HVTIMER and HPTIMER
in vEL2. In default case, PTIMER and VTIMER are validated and with
NV enabled (with argument "-g 1"), HPTIMER and HVTIMER are validated
by injecting respective timer interrupts.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 tools/testing/selftests/kvm/arch_timer.c      |   8 +-
 .../testing/selftests/kvm/arm64/arch_timer.c  | 118 +++++++++++++++---
 .../selftests/kvm/include/arm64/arch_timer.h  |  16 +++
 .../selftests/kvm/include/timer_test.h        |   1 +
 4 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index acb2cb596332..5c30bda0462b 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -35,6 +35,7 @@ struct test_args test_args = {
 	.migration_freq_ms = TIMER_TEST_MIGRATION_FREQ_MS,
 	.timer_err_margin_us = TIMER_TEST_ERR_MARGIN_US,
 	.reserved = 1,
+	.is_nested = false,
 };
 
 struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
@@ -43,6 +44,7 @@ struct test_vcpu_shared_data vcpu_shared_data[KVM_MAX_VCPUS];
 static pthread_t pt_vcpu_run[KVM_MAX_VCPUS];
 static unsigned long *vcpu_done_map;
 static pthread_mutex_t vcpu_done_map_lock;
+bool is_nested;
 
 static void *test_vcpu_run(void *arg)
 {
@@ -193,6 +195,7 @@ static void test_print_help(char *name)
 	pr_info("\t-o: Counter offset (in counter cycles, default: 0) [aarch64-only]\n");
 	pr_info("\t-e: Interrupt arrival error margin (in us) of the guest timer (default: %u)\n",
 		TIMER_TEST_ERR_MARGIN_US);
+	pr_info("\t-g: Enable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
 	pr_info("\t-h: print this help screen\n");
 }
 
@@ -200,7 +203,7 @@ static bool parse_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:")) != -1) {
+	while ((opt = getopt(argc, argv, "hn:i:p:m:o:e:g:")) != -1) {
 		switch (opt) {
 		case 'n':
 			test_args.nr_vcpus = atoi_positive("Number of vCPUs", optarg);
@@ -226,6 +229,9 @@ static bool parse_args(int argc, char *argv[])
 			test_args.counter_offset = strtol(optarg, NULL, 0);
 			test_args.reserved = 0;
 			break;
+		case 'g':
+			test_args.is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
 		case 'h':
 		default:
 			goto err;
diff --git a/tools/testing/selftests/kvm/arm64/arch_timer.c b/tools/testing/selftests/kvm/arm64/arch_timer.c
index eeba1cc87ff8..50bf05bb6f85 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer.c
@@ -12,16 +12,22 @@
 #include "timer_test.h"
 #include "ucall_common.h"
 #include "vgic.h"
+#include <nv_util.h>
 
 enum guest_stage {
 	GUEST_STAGE_VTIMER_CVAL = 1,
 	GUEST_STAGE_VTIMER_TVAL,
 	GUEST_STAGE_PTIMER_CVAL,
 	GUEST_STAGE_PTIMER_TVAL,
+	GUEST_STAGE_HVTIMER_CVAL,
+	GUEST_STAGE_HVTIMER_TVAL,
+	GUEST_STAGE_HPTIMER_CVAL,
+	GUEST_STAGE_HPTIMER_TVAL,
 	GUEST_STAGE_MAX,
 };
 
 static int vtimer_irq, ptimer_irq;
+static int hvtimer_irq, hptimer_irq;
 
 static void
 guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
@@ -47,6 +53,26 @@ guest_configure_timer_action(struct test_vcpu_shared_data *shared_data)
 		shared_data->xcnt = timer_get_cntct(PHYSICAL);
 		timer_set_ctl(PHYSICAL, CTL_ENABLE);
 		break;
+	case GUEST_STAGE_HVTIMER_CVAL:
+		timer_set_next_cval_ms(HVIRTUAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(HVIRTUAL);
+		timer_set_ctl(HVIRTUAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_HVTIMER_TVAL:
+		timer_set_next_tval_ms(HVIRTUAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(HVIRTUAL);
+		timer_set_ctl(HVIRTUAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_HPTIMER_CVAL:
+		timer_set_next_cval_ms(HPHYSICAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(HPHYSICAL);
+		timer_set_ctl(HPHYSICAL, CTL_ENABLE);
+		break;
+	case GUEST_STAGE_HPTIMER_TVAL:
+		timer_set_next_tval_ms(HPHYSICAL, test_args.timer_period_ms);
+		shared_data->xcnt = timer_get_cntct(HPHYSICAL);
+		timer_set_ctl(HPHYSICAL, CTL_ENABLE);
+		break;
 	default:
 		GUEST_ASSERT(0);
 	}
@@ -75,6 +101,16 @@ static void guest_validate_irq(unsigned int intid,
 		accessor = PHYSICAL;
 		timer_irq = ptimer_irq;
 		break;
+	case GUEST_STAGE_HVTIMER_CVAL:
+	case GUEST_STAGE_HVTIMER_TVAL:
+		accessor = HVIRTUAL;
+		timer_irq = hvtimer_irq;
+		break;
+	case GUEST_STAGE_HPTIMER_CVAL:
+	case GUEST_STAGE_HPTIMER_TVAL:
+		accessor = HPHYSICAL;
+		timer_irq = hptimer_irq;
+		break;
 	default:
 		GUEST_ASSERT(0);
 		return;
@@ -142,38 +178,79 @@ static void guest_code(void)
 {
 	uint32_t cpu = guest_get_vcpuid();
 	struct test_vcpu_shared_data *shared_data = &vcpu_shared_data[cpu];
+	bool is_nested = false;
+	enum arch_timer vtimer, ptimer;
+	int vtmr_irq, ptmr_irq;
+	enum guest_stage stage_vtimer_cval, stage_vtimer_tval;
+	enum guest_stage stage_ptimer_cval, stage_ptimer_tval;
 
-	local_irq_disable();
+	if (read_sysreg(CurrentEL) == CurrentEL_EL2)
+		is_nested = true;
 
+	local_irq_disable();
 	gic_init(GIC_V3, test_args.nr_vcpus);
 
-	timer_set_ctl(VIRTUAL, CTL_IMASK);
-	timer_set_ctl(PHYSICAL, CTL_IMASK);
+	if (is_nested) {
+
+		vtimer = HVIRTUAL;
+		ptimer = HPHYSICAL;
+		vtmr_irq = hvtimer_irq;
+		ptmr_irq = hptimer_irq;
+		stage_vtimer_cval = GUEST_STAGE_HVTIMER_CVAL;
+		stage_vtimer_tval = GUEST_STAGE_HVTIMER_TVAL;
+		stage_ptimer_cval = GUEST_STAGE_HPTIMER_CVAL;
+		stage_ptimer_tval = GUEST_STAGE_HPTIMER_TVAL;
+	} else {
+		vtimer = VIRTUAL;
+		ptimer = PHYSICAL;
+		vtmr_irq = vtimer_irq;
+		ptmr_irq = ptimer_irq;
+		stage_vtimer_cval = GUEST_STAGE_VTIMER_CVAL;
+		stage_vtimer_tval = GUEST_STAGE_VTIMER_TVAL;
+		stage_ptimer_cval = GUEST_STAGE_PTIMER_CVAL;
+		stage_ptimer_tval = GUEST_STAGE_PTIMER_TVAL;
+	}
+
+	timer_set_ctl(vtimer, CTL_IMASK);
+	timer_set_ctl(ptimer, CTL_IMASK);
+	gic_irq_enable(vtmr_irq);
+	gic_irq_enable(ptmr_irq);
 
-	gic_irq_enable(vtimer_irq);
-	gic_irq_enable(ptimer_irq);
 	local_irq_enable();
 
-	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_CVAL);
-	guest_run_stage(shared_data, GUEST_STAGE_VTIMER_TVAL);
-	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_CVAL);
-	guest_run_stage(shared_data, GUEST_STAGE_PTIMER_TVAL);
+	guest_run_stage(shared_data, stage_vtimer_cval);
+	guest_run_stage(shared_data, stage_vtimer_tval);
+	guest_run_stage(shared_data, stage_ptimer_cval);
+	guest_run_stage(shared_data, stage_ptimer_tval);
 
 	GUEST_DONE();
 }
 
 static void test_init_timer_irq(struct kvm_vm *vm)
 {
-	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
-	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
-			     KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
-	vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
-			     KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
 
-	sync_global_to_guest(vm, ptimer_irq);
-	sync_global_to_guest(vm, vtimer_irq);
-
-	pr_debug("ptimer_irq: %d; vtimer_irq: %d\n", ptimer_irq, vtimer_irq);
+	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
+	if (is_vcpu_nested(vcpus[0])) {
+		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_HPTIMER, &hptimer_irq);
+		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_HVTIMER, &hvtimer_irq);
+
+		sync_global_to_guest(vm, hptimer_irq);
+		sync_global_to_guest(vm, hvtimer_irq);
+
+		pr_debug("hptimer_irq: %d; hvtimer_irq: %d\n", hptimer_irq, hvtimer_irq);
+	} else {
+		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq);
+		vcpu_device_attr_get(vcpus[0], KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq);
+
+		sync_global_to_guest(vm, ptimer_irq);
+		sync_global_to_guest(vm, vtimer_irq);
+
+		pr_debug("ptimer_irq: %d; vtimer_irq: %d\n", ptimer_irq, vtimer_irq);
+	}
 }
 
 static int gic_fd;
@@ -184,7 +261,10 @@ struct kvm_vm *test_vm_create(void)
 	unsigned int i;
 	int nr_vcpus = test_args.nr_vcpus;
 
-	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	if (test_args.is_nested)
+		vm = nv_vm_create_with_vcpus_gic(nr_vcpus, vcpus, NULL, guest_code);
+	else
+		vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 
 	vm_init_descriptor_tables(vm);
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
diff --git a/tools/testing/selftests/kvm/include/arm64/arch_timer.h b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
index bf461de34785..82ba908fba8b 100644
--- a/tools/testing/selftests/kvm/include/arm64/arch_timer.h
+++ b/tools/testing/selftests/kvm/include/arm64/arch_timer.h
@@ -11,6 +11,8 @@
 enum arch_timer {
 	VIRTUAL,
 	PHYSICAL,
+	HVIRTUAL,
+	HPHYSICAL,
 };
 
 #define CTL_ENABLE	(1 << 0)
@@ -37,8 +39,10 @@ static inline uint64_t timer_get_cntct(enum arch_timer timer)
 
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		return read_sysreg(cntvct_el0);
 	case PHYSICAL:
+	case HPHYSICAL:
 		return read_sysreg(cntpct_el0);
 	default:
 		GUEST_FAIL("Unexpected timer type = %u", timer);
@@ -52,9 +56,11 @@ static inline void timer_set_cval(enum arch_timer timer, uint64_t cval)
 {
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		write_sysreg(cval, cntv_cval_el0);
 		break;
 	case PHYSICAL:
+	case HPHYSICAL:
 		write_sysreg(cval, cntp_cval_el0);
 		break;
 	default:
@@ -68,8 +74,10 @@ static inline uint64_t timer_get_cval(enum arch_timer timer)
 {
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		return read_sysreg(cntv_cval_el0);
 	case PHYSICAL:
+	case HPHYSICAL:
 		return read_sysreg(cntp_cval_el0);
 	default:
 		GUEST_FAIL("Unexpected timer type = %u", timer);
@@ -83,9 +91,11 @@ static inline void timer_set_tval(enum arch_timer timer, int32_t tval)
 {
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		write_sysreg(tval, cntv_tval_el0);
 		break;
 	case PHYSICAL:
+	case HPHYSICAL:
 		write_sysreg(tval, cntp_tval_el0);
 		break;
 	default:
@@ -100,8 +110,10 @@ static inline int32_t timer_get_tval(enum arch_timer timer)
 	isb();
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		return read_sysreg(cntv_tval_el0);
 	case PHYSICAL:
+	case HPHYSICAL:
 		return read_sysreg(cntp_tval_el0);
 	default:
 		GUEST_FAIL("Could not get timer %d\n", timer);
@@ -115,9 +127,11 @@ static inline void timer_set_ctl(enum arch_timer timer, uint32_t ctl)
 {
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		write_sysreg(ctl, cntv_ctl_el0);
 		break;
 	case PHYSICAL:
+	case HPHYSICAL:
 		write_sysreg(ctl, cntp_ctl_el0);
 		break;
 	default:
@@ -131,8 +145,10 @@ static inline uint32_t timer_get_ctl(enum arch_timer timer)
 {
 	switch (timer) {
 	case VIRTUAL:
+	case HVIRTUAL:
 		return read_sysreg(cntv_ctl_el0);
 	case PHYSICAL:
+	case HPHYSICAL:
 		return read_sysreg(cntp_ctl_el0);
 	default:
 		GUEST_FAIL("Unexpected timer type = %u", timer);
diff --git a/tools/testing/selftests/kvm/include/timer_test.h b/tools/testing/selftests/kvm/include/timer_test.h
index 9b6edaafe6d4..95f61c4a8a80 100644
--- a/tools/testing/selftests/kvm/include/timer_test.h
+++ b/tools/testing/selftests/kvm/include/timer_test.h
@@ -26,6 +26,7 @@ struct test_args {
 	/* Members of struct kvm_arm_counter_offset */
 	uint64_t counter_offset;
 	uint64_t reserved;
+	bool is_nested;
 };
 
 /* Shared variables between host and guest */
-- 
2.48.1


