Return-Path: <linux-kselftest+bounces-33106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DDAB8F05
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8563B0ADB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D21269CF1;
	Thu, 15 May 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8OS3Ctg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAB2690E0;
	Thu, 15 May 2025 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333432; cv=fail; b=P7dD5pWSwNV2uHRw2vaGRvhetvHex8D2dhIJfyl01Fva2U42ESNOMVzdoVZYHH4W/q7FnrD201cZFjcR1nF8U66RHPQ/JnHhdZHn1o2151UU0YFrogPFjJuN0ncc7gYJSnLSj0r+0qtwa32OjcH2cxbFnJoxlHXHvqSogCmPh+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333432; c=relaxed/simple;
	bh=czCK0Xu6RDK3HbMlOrugI+oeZnHHxM4HA6722mvk7dU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=THmGiTxWsJRM0UNf3T7iQArOjsB8aBKuO22AIJIcFwMbU4E3Ch0onl+jvy1pZ0suat72QSA+lbpsLQbi5LqM9mQEYT8L7ly09KdP4MxYfTxGSsWl2xboTb9y91PYMo7QOuWwB1rGo4KRCFVtF9y5kLJga94KHwOVriQE8Nbmbmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8OS3Ctg; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6pQ1TfbC/S8BDocaf1L2VnFBOhEzyMChC2y6AF8lzkOKJA7qC2c8tqFDTj3YcBPu6p1RTaJNcjMa4yaKk+J4ks8zpfrnMAw9D/hq+JIk/1/3sUzUZ3vaoQ3GyRdBeBSfGtBV2fMlJE+opq9mOvCIynRq9AXpahMfIsjixnDjejVBT4AUAfCCMAcdV8R2W5s8wcq67rrjtBzGsbC2k/Wy3CWbUW5lxESZb6sE+wcOwp2ux370eMO0DWoQNYOaeqOh0IrIjCe06gTECRZ+6BdwPuKS+YdYYPMefSsMTvwuVR/5BF4NqPrk+gyExZ1EHzeqqtd2/y7WxBrrcPUXOqKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GftCIezhei8KSImkLcQ6tbJqQm8TqDLH8Y6mKOJtJj4=;
 b=AEtp3U0ZK4CkNFdjNCekLSTwyPUZz6cjAunF+kI3aACtDoHTohwQ/jTYci+SqSaXyqBSKYqzLc+Ng2OKYClzX5acmZ6b1IEJyH9nEHvcHxPjhKLQ3yJ7vrhS1gAPmsklei84+6B+RC1z6MJkuFa66gQGObM3EFb7OL5hrrBNfr18PQtSXsk4ZZ5NGMaTxG1zl/AixeGXX1F8QQ/8urGlmEL8GuKCLhtbR5Td2+e+5c5DliLxkWSpdPttAumeDHzw0GbB4CnMSGJefpMfq3A4ZEUCOokJANBrmAJd/7+Tk3WR5NK4dDPvf0GQv6aL4JmjlkgqHN/Bq1VoiBz481SUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GftCIezhei8KSImkLcQ6tbJqQm8TqDLH8Y6mKOJtJj4=;
 b=j8OS3CtgXxERQ9xZ/BooQi2euSgGokpzGzNDYHHUGI5hMhAkgEJgmbGCWvoy9zPMDLe/9lzxp7bUZ761WkfLS5sIOKx/IJk0llHSRKxRyKnpKQFTm73DnbudmDYHff6nusz4C+XC6QK9i4dNT2S1Mv21JYLoy+CRgjziJEPXa/EXiN/3W7Om49kAgerGTf+lVv48wO1bRn1wEq2pEAQdj+4csKCe6MYDPUCIdSeb1AzX0uWd7Wzy8ENNaXe7YkhYRE3yUZUYbE1dAULPqT/iuPXoP0TczRGF6kMMFE7VuLwT4l6HzYJDnEpwXun046G+2Ti3fBRaFsz6MLiS9YjEZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 18:23:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:23:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pedro Falcato <pfalcato@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adam Sindelar <adam@wowsignal.io>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd is not present.
Date: Thu, 15 May 2025 14:23:32 -0400
Message-ID: <20250515182333.346587-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bf193f-2100-4b90-acdd-08dd93dda037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/W15aQ4efgL3xlaIHX8KHn268rDvl+HU141fX6XG8t62/YMk/uy8a+l9w8T?=
 =?us-ascii?Q?0ot0nvRhBklkKmb57wThCtVSJs7AHnFoxe5mXabINxg3vnGZ7cJFMnOexF45?=
 =?us-ascii?Q?NwqZ/ETF7D63SpP4K8lZB8M1Fx06v1HWsS41tycl/wI6FNDvXTFpKSK2K6GW?=
 =?us-ascii?Q?Jw1+7Pw4awqyX1AEZpPNxqjsWQBRa0/vPBrFmzybtYRCDdRXwyRoIg+FGh2K?=
 =?us-ascii?Q?pd5N/QhHHZMFDc6L5NI2gNFVzIJovVAmlHtsIgQ84u1oi9Y2pWx1IcZpvGxb?=
 =?us-ascii?Q?5sKhZ/YvG52wpaylvsVErvGV1v5Xzvq2urCJBvAQK9HooOKQes7K3kr+XdJM?=
 =?us-ascii?Q?sI3wA9WsqwQWxF/pF47Qqy3Y3PVOi8R+xW51X9XQug2/ZPCyGhoCB3hAiQs3?=
 =?us-ascii?Q?SyyPSYhxYNGMBw/UaYaIaH0C5SK0FFFUhREi61NESytmoLfyB/GHHd5Zy33W?=
 =?us-ascii?Q?9IC0TZrTBvTj6V42skdAO5yoSmHhx86k3qZei6V+yYUiN9pfb/Se7JiL+KMQ?=
 =?us-ascii?Q?aVIkWVD2uep2M3irKp2+cN4Ww38JzED3yv4ODIlxu1ygUEmd4dFbye+stDCu?=
 =?us-ascii?Q?H5i8b06dFhaVAtUHP6jQsE/CXn4B67gQqhoSxGeJIF8NW5LKXP5PTf1tSw49?=
 =?us-ascii?Q?6BNMXrku7+/oJ7keULsSuQ/2PtTaPc+MdJM1h8OiSy9nvi86n9gIuml8P+Zk?=
 =?us-ascii?Q?N/AoZyA26YX5kzU+Q4ci9mNHB9+U+2KYCEpCQ7FNdTzMWuIhF647rE+5cKPS?=
 =?us-ascii?Q?zuw0RwnpiiR/G6fNazjCTwPJQsVuEz7O1SpI6e9KBNEYBXopj7afVv0ipNIc?=
 =?us-ascii?Q?tCmVxRUOsgWzFHWvJqxnIRbxdFxC6UA68HvLJo4/1GOKr+a+J6+C0ppE+Bqo?=
 =?us-ascii?Q?aSY9zgNCfnSfQeZ0r0A72Uk61a3qdnCHFybHH53uhdUF4JtMwaet+FLgfpVU?=
 =?us-ascii?Q?ueDRfrrlWep87ntKe3N5MpIyaSbVu3Pg3qUq4f73O0ZKMZ9EDs/dF7Pd8i5U?=
 =?us-ascii?Q?WIb35crFuKBgUIbu/hgwydUcCyILCifCmvchBxbJ7BGG5dAWQObVbhSAETWo?=
 =?us-ascii?Q?jyEEwInAy7b6CtORyqlAcg6MVza5X2pt4sbzdZ5rGY0V8C7UvXHq6DSVQlre?=
 =?us-ascii?Q?UHKvyCqBHgVJJ1iTDyaAE3NlEzNHsg6cDzB+fGMrTTnZLCG/7qwd4iSJmVG0?=
 =?us-ascii?Q?MFHuWWVSlglRHyoWdJGVEVSvgVagXHo84QeH2jTSTyhLBpDAZF/ZkOje/iP+?=
 =?us-ascii?Q?xvM90KRYjLuk1Zyv8ry/NHtfrd+IBxPE9oFurhkL+xYcZz9n3OkKSfF2ITqB?=
 =?us-ascii?Q?Pm/rqRTHo6K9eAcXuoBhVcnD5uuHxY1+FgObx9mogIAsiZjNoNaXyR0UJq6F?=
 =?us-ascii?Q?uGJxjHDozoUe6ZAVjcdCZSkzGeCSMJ7VzEwj9tpuegkqWlsqmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izx89IzdMfV6icido1h+LCinQyUpo9b18tUWF3AASVpUtDPEbh2hC5uH3FWT?=
 =?us-ascii?Q?bn7OaVY2gkyZfagLacUJWonpNiS1uYugyFCutYtYwC/iShMJQqcmtInS9di1?=
 =?us-ascii?Q?91oXxYPNGzW65BHvrsr/r6VWvTTHvPinDwJEJfKbbRI29zSD7Dz5TGPwTNl/?=
 =?us-ascii?Q?W3D65MkMOKn+QIs+zNNhvWxhIugUF2KsEgrPYIAgUpox1E0fI/NX+JuGZ7Tm?=
 =?us-ascii?Q?2DtJChCCMlDy3sQAZ6ZGYmygCIDYOkVffy7XnLYZ3178gtm8ZuQZ3BdNGXDb?=
 =?us-ascii?Q?71QcCwH8TLHFNB7gFV3OT49LH91Jc0Yd80HIIdW8GoCzlPA1GTezu5NGOtHP?=
 =?us-ascii?Q?8qkMDVZziyo5IStb7YfXRhSVXiZDd49sd4ya0/r2UAeKMmBC04NkB4InvxZU?=
 =?us-ascii?Q?5E0Gi4YUBz3id6Wwg/WRT9xnz5/mU+tva3pszftJaddcYDZuYZq1oPznvqzh?=
 =?us-ascii?Q?K0TaM8ivrEjDAfUkc3iqaK2Mo0sL1BgWP7oUGWjWOCWfKVlJ4rU+3MLHRMAq?=
 =?us-ascii?Q?sQfNmJZucisV+HqFhX5nCqRV87lLBi8QXMqRKF6Z0Rvbfeb9DlEvXlZu01j6?=
 =?us-ascii?Q?ZGyhRAv/YVQQuX2ObDB5hGtFKETjfUT9EjnvVB0eeS8BxmRRW6QeTuBK7wxT?=
 =?us-ascii?Q?XtlIbqgMD3e/Eev1NzRnMIfous303WxlqSnbOAAyi6MGEc0DYWdMCKe5uujk?=
 =?us-ascii?Q?seQF18oh5kKZS2XGcENqB+povE6x3oXk+Us5kGUskNajMLmP1UitU5BGj1zw?=
 =?us-ascii?Q?T6UO6xhY12SzScN/LAA1y0zrQwbWQl7P1oXnE3LqDql5MtwJSjfSLBfU+rot?=
 =?us-ascii?Q?42Rnkv+KtlOWDA1p8uhfRvXtmo2zyHU040mqLZv9JZPQEgoNsnWnWWPN2cSF?=
 =?us-ascii?Q?XcaeQVUl+hcZj+OJCxqNg5FQNHpw/AtUIduyVLZ5kG3XNUEU1wZ88KgFuDyC?=
 =?us-ascii?Q?QNep25c5x8I3U2wd9/YwqdfgdTtKoGZ4VJP6QG+ESbIm56fipbnI2a6iv2/X?=
 =?us-ascii?Q?u2KEbe2UP9KqgRQX4kYwQ+9lo2kPpM4CuOZq4JAUqKa6pmy/0BW/8vewWOtI?=
 =?us-ascii?Q?6HwEJUpD5Ixukg3nzWfkCn6Xk/hSa3k0aV6UTAOKcdu+MhOYKIyQtsZpKd+j?=
 =?us-ascii?Q?YKdPl22JQC8pZ6Yomh8lrx8UOCFakpUXKS6zdribY5vmOuz3iSRC6kRYde7T?=
 =?us-ascii?Q?nUMFe7jsZiZJGZhKXZNKl+ZE2Oj7tNatibGJcg3USlmPnKy9lI4xfgiicykr?=
 =?us-ascii?Q?PyyiUeCK4QVLqSLLPRzYGb2wqPqxj2gYIArOIiEJmmc8aQpdKZdwj6Al1L87?=
 =?us-ascii?Q?Mpoyl/mC9W586XNwaJ2GYM2wjXYo77UmrPgWDaNrXo/cr0+FJ+CCdlMPA4Q6?=
 =?us-ascii?Q?ANGmyVl0GJA7rGo5eWmmQ3k8SguZ8VUj2GAE8maixaHcERt4/oaqkg4sXPd0?=
 =?us-ascii?Q?uYz8a2HL6AlNpuS8O+ii1LCuOGs2n2u173zbNMTt7VW2IZkIHl+nTeW1Ea8z?=
 =?us-ascii?Q?V5In2Gkq1zJg8U4sIwX6G+Dyrmj6M29w5wneeshzgr8orsQluiHWkdSzGOoj?=
 =?us-ascii?Q?craMn7rgKmTDWcc84Fm0xgN7uaEuRaA/EN3dtIjh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bf193f-2100-4b90-acdd-08dd93dda037
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:23:44.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV2lT9+7Pmfb7xAEXwlbaOHSioJxCI/c+f8h0eHKKRSEpg/VceKzE+7lFZIBBpq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

When userfaultfd is not compiled into kernel, userfaultfd() returns -1,
causing uffd tests in madv_guard fail. Skip the tests instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0cd9d236649d..93af3d3760f9 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
 
 	/* Set up uffd. */
 	uffd = userfaultfd(0);
-	if (uffd == -1 && errno == EPERM)
-		ksft_exit_skip("No userfaultfd permissions, try running as root.\n");
+	if (uffd == -1) {
+		switch (errno) {
+		case EPERM:
+			SKIP(return, "No userfaultfd permissions, try running as root.");
+			break;
+		case ENOSYS:
+			SKIP(return, "userfaultfd is not supported/not enabled.");
+			break;
+		default:
+			ksft_exit_fail_msg("userfaultfd failed with %s\n",
+					   strerror(errno));
+			break;
+		}
+	}
+
 	ASSERT_NE(uffd, -1);
 
 	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
-- 
2.47.2


