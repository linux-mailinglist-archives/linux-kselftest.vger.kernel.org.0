Return-Path: <linux-kselftest+bounces-38350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF82B1BEB1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 04:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083E3623175
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 02:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA51D7995;
	Wed,  6 Aug 2025 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKB8n/s2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD81C8631;
	Wed,  6 Aug 2025 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446865; cv=fail; b=PQOACs8iSk/ssRNPhJ2XWA6P73Yapm1gC5hlP9h2NcRS3xaaXMa8YM7EJsSGPkV4eLgD6WRdkD9FO6Yx31Vv1CMQJeScfsnmgVNwNW2aGSNzLXWVHCIPvOGioHv86S5gRsFUXeoqKCmFNvlZOFl8+hbGThGQKvINnRlt5VIPAvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446865; c=relaxed/simple;
	bh=9MR0b1GsI0yj2YmkVe1uiw2aYrkN5hyAgSCyMyoEdVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcBuQR852xDie3Kq7wQ40EVqNlz8cKp9Bj077U77YTvn20ubO+CyiRoHBIZE76sDZEW2ksbn/xL4Gxn+AzVHZKoLsJQK5yHkzUKwN0/LuulcJ/LnSq0z0V6vTRjtcyuJpCBH1tnfyNJfqekFT4DoLZKzAtsdeU0QnU1m8dRMVSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKB8n/s2; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIIYkF786udflU6oPFTsS88Xrhawo7BwHVsMHquJ5YtY6pg0zVfAFVOJ7N7q+LWAIAIw/iKnYZ+jNmJFRrV/QO44QqPGU49TnW2P3yD21Ha9W+lh3jgdkSIQdJ82Obm7BIhpli7PVmvXc+OVZm+LoXvsgbmQgnx1uPJUAecEg3Jb2H7KV+jcnfl4v6DbpffmEBCw05OMcI3NmUsn/yMsWdM2B+IfnM5zkQ6Xw8RDdQsy7IHCt8LnA9AIdT2s66KTArFFd2ulSLBPlQJ2+kFEesoN9z5anbxXYkqNPV7cse5g3gNG1sV6CkB/dcFqhfLcPhgey2OwoW76ppcHkmv4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWmhnZ+9epgiDWsBjwLNkFEzIqTfQeZavRdDx5Nt9Y8=;
 b=AXVF3Z925c7mOmTh887kMfElAIhwdFPoTylm58VzOuiGmFLYkJJemBzEsW6eaUqhkWWiZtYjjFp2/pdGhUlBtBf9aeLFao++95pHRHY3/3LI8Q4pbIIIkgAj0hm4e9RUS319dHS9yAvu6bR2fYAsCjF74XvyWdbtrFawYZ4jJxafXFAmT8zqrBxaZ5HK5Zih8MOjhYOI2VzQtQUaGbCF2gq1BPhvjDnzUCjpQcyrtyeOHXByQAe+sMwVI4Yg3ciMW8De/nPqbLle1SCXGfCPS7DoCUPlW0udHj7ObktQ6LB9c5wHBHRN545Z1n6HZQfIkm+rVCWbPbtApXKgonSV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWmhnZ+9epgiDWsBjwLNkFEzIqTfQeZavRdDx5Nt9Y8=;
 b=QKB8n/s27SlWIdoy1iaaapknaFm8MrP5EmFhGejqS+Sjyi1klUsG5HnjxyZNP5bT4Fli3HWC+Cb5uW/TfPUXU2qY8TSoyUYhADD/2sF+rdDi1nXaBBlJtHQZdGncXecryj6PnPMb+B5ybO0LbRMoC+4Ox9vXo3AUBqWwEJ8UieCFVCmMB0q+EwnnSFq+SlG6bHVrJjCzTRvHoqcldtDWtm0+Rb+8VrfU6JAXdp9O21xV8Jp1Ob1CZe53DVPk3JW6unoCofqPyXVoqfIH2k2WToxopHiGQznWwyeHQ/lXgl6FIpPsnCUFM191M0wG4eRe66muNJezOif6dm5z7T4PPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 02:21:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 02:21:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] selftests/mm: check after-split folio orders in split_huge_page_test.
Date: Tue,  5 Aug 2025 22:20:45 -0400
Message-ID: <20250806022045.342824-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806022045.342824-1-ziy@nvidia.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:208:32a::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: af2d9972-5b12-4eab-fd4d-08ddd48fe25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzECw4q7dBBS7oY1n7LgHomoBpbnFrBMJ5FRqC3LhR6scrbMj4r3yEGP+z4q?=
 =?us-ascii?Q?fnXb685Rd60B6vWLS/f6hxbwazoFg/2GWfTt2Tio2VpnMk59VqBL1H98X3eI?=
 =?us-ascii?Q?YxqVpBTxV4lwxr7J3xAD8QUDHr9F6W4dZtkfn53nvL38ZpxDHeRdpSM5cP3Y?=
 =?us-ascii?Q?o2T5kmld+aQxGyp19j+wzKXUcPlOXYZ9X9/kkQ/2ehyCBZNkB33UVv4UhT+H?=
 =?us-ascii?Q?g3iJ7dGq7U7VJX3lN30tDNMO3jZptW1ZSSdE08CQwQ7YZOz0GieQkcn/NF+y?=
 =?us-ascii?Q?SFlomwRIuLmzpp0UdZpvplkZniTJEwNHC+ZDO7UVG+Rw5SmVXIHFdVSa/cRG?=
 =?us-ascii?Q?O7IFYYt8UWsntM3+NH/RZbSFFPFe90AHDFTlsfUmNlBofBAQz+03Divy4bC1?=
 =?us-ascii?Q?AiCL9EKjb56W8KKu4j840UFYz+H0YVGuTIRwKmmVN1+jzdzy0Uwb3k1MvpFE?=
 =?us-ascii?Q?AiBj9aERns/uHiRTak1yTpGCb6dQroRVqvDFmTp3tafugmbJPgQ1U10skDeK?=
 =?us-ascii?Q?M9pam1s+tEsu8t9dhzAj78y7H4TZkhIAAJZBdd/n16jZm4GIsYixGhD9VEk/?=
 =?us-ascii?Q?tFzpxPZ6bHO4dxNT+2XLplHhhO1deuK9rmi+1kKFObvK9h2XAi2QlcMjx+0m?=
 =?us-ascii?Q?0Ti6N5DkUrayPBloPIbgUO80NMQyuoif1HqZWpmEFtpbrzVxl8CRZX9T7zwa?=
 =?us-ascii?Q?redid8b8YwmjR9/Ywwj4I8obH1qku9IOR2Ee+MMEh5XqVc0iGgqlzW9P9Sxo?=
 =?us-ascii?Q?Y7MFtCW19DYUuiji/J2o8TR82XJIT4mPSiFrXZF5545op39JnyQhiC2bOBtm?=
 =?us-ascii?Q?bJljZrMkDtcH9iCfH+fuKxKLtu9kPr4Km0wuvVAQObcTy7c/B2NtWNmEPfKs?=
 =?us-ascii?Q?TPvT5oqDF9eSfnaVbN4hQ8RkOFgQVd5RAddQLIqUvidQjEAeRQBAUm3J9aTZ?=
 =?us-ascii?Q?0CkEQ+Qje6xAmO5h2rEaibl4dRrxu0HJh1HeOIY0ipMJYWvOKtxxBAuFRsFX?=
 =?us-ascii?Q?DKtgAvzBhNOeLs96FzVnjUBFV7Mqjjrb/9onX9q7g4jzlKejIF9zOWbPDVrF?=
 =?us-ascii?Q?NOTKsFACVIeWBOx8Hva0TvdcH14oxGSA/0c4nZPGZmnEyPV0z9qt2efGU5lQ?=
 =?us-ascii?Q?RXubJAIO8RLO9PI5+4yfaFOQpoiJr/plMCLV21TR5tJHrVk3S+3+Wftk/R+W?=
 =?us-ascii?Q?ETI2dVedCxizbwjhyJYnW4l6eqD818LlvNA80Uen4Ct/CGMxxjiBbR29IG9H?=
 =?us-ascii?Q?zI31ukn+pLvw1NxosFItO/Cy/8p9BioXyPkT4Ehc0kB1aVGtB9zidVVDPDOj?=
 =?us-ascii?Q?+WXGbzARmbO+BtryHtOkgvjH5DyBunqKu6Ckbk6yGLQrmp9W60oWbAiXBIUh?=
 =?us-ascii?Q?KMSVB4u9qn8D/CDHVeNkzOSIMnLXNAZbaK/Qcrum6EXfUpqlNGuiDJSQt78S?=
 =?us-ascii?Q?mt5HPe05xmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EaPBK17W+OaJEu7QOzox/KuOgZ5OEASf9hy77yacXBlZDpmdvgRGRqklj23j?=
 =?us-ascii?Q?zSmVTTbDWAs847ZfaCern7d7BLhW6hwg6vIusHA6ficvH2G7cQI1qPFxUPr9?=
 =?us-ascii?Q?LRyCUa3pf7iGkDDAkJh4/LsR7KUKxQcus/GhlABgv0UuZubFbY99kGe+PqeU?=
 =?us-ascii?Q?4tRhB0Ob0JfritHT20OMHybgIykomcYRZ/3BTwWVT4kQhy/YQU7aRaFB7vU/?=
 =?us-ascii?Q?Q+6RM5DWE4Mvp+gKRM5QGiu69LJeMId7GL8+828UrwN7UoCXhsAfvIXaFGUC?=
 =?us-ascii?Q?BOsquKKnu15h0c8DuB2BBxSZwIptZuwr3D6QBtcAxi34Q46kTRYrjclyiMjr?=
 =?us-ascii?Q?UKY6zXVSQm9s/Ca4E2LAvFzbDm3RvCAX20Gi+/2LY9r4CE/rwAKskti1mlu5?=
 =?us-ascii?Q?J41y7HLq0kI3n0R0mGtpMM4Kfl4ltlqtrGXXz/E+EtxAtF+w8h6jHTLjMxbD?=
 =?us-ascii?Q?0Qv0RWDVxCEH4WAe5F5vGBmTAOfv8vy24NyZcAhNy4tK6nLTMpIO8Z1YhH+V?=
 =?us-ascii?Q?nt26Y2c/e1lZJZMtA8u0AADZCoHore12Bd76pUxF6P28KZzUPjrQYHS1otrL?=
 =?us-ascii?Q?mwKdbbG1VMvXmEzgPdngS4owmHBLXZ9aiUC52V0ncu/vfe4wve3YEa1xd/q3?=
 =?us-ascii?Q?bDcUbDwkCrRCPmaj0Vv2E2XOwAqWzfawfekOD2yXc6QLGQXVUdmcBfzzEMXa?=
 =?us-ascii?Q?kMgVc3nt/NYsnWpv2snITWCOvH60Ab1+V8KjxfSt3XIUtZ/GOAdcpMScpL9m?=
 =?us-ascii?Q?ENSlLUKq9eVgJyUtYWqw6b72xip9yBLjFmDTKQE4JOE0XZXAcbq6W9JInKY2?=
 =?us-ascii?Q?NHzyLUobPcif9/tT5DaXQSVi3fPtnQwskl64sRNo2dhiAPAFfMqwDZ/Ao69X?=
 =?us-ascii?Q?Ty5JvSSBD56RbeE5uaf3Jk7Y3FFHdsVTdluC1WSrVDHJr/hciCiPqFcS+Lbg?=
 =?us-ascii?Q?qnUgL10xBoh21QAFG4sH6BqPQEZYkSgzNDuStsuR4dNzD7LaJtFyLR3Ze7tD?=
 =?us-ascii?Q?HdFwfMTXhL7qKUixTXwXI80e4Lp1+2cYcjcejQy6LxCXjoi9Qxnib8dLQB6b?=
 =?us-ascii?Q?ok40MyokA7AChzwD6eMNSgeiZFZdB2+TkOgsQdJFYfE6fhwEg0AW8NIY6dFt?=
 =?us-ascii?Q?EH1RHsSQR53Dy4KVSblBd1vi/r7YJefeEmIEBo2iRP3UaOr4hJhc2JFjUqxh?=
 =?us-ascii?Q?1vURdALH81rXUlsevwdFZoyGPaTpa+GwJ2xMrDOFijHOthJsXk3+RWOAXsFY?=
 =?us-ascii?Q?KR5r3YYL3mKJQwe1ChLSFfdmDQnTRryQbhySbP0ZL3e9SksXG/ZLWheEF2Hc?=
 =?us-ascii?Q?Bp/cxzFdgllhwf9ov2qVodez9RTUiG3MiGqkwwD73hJ4z6MUy+s4JSvTKN74?=
 =?us-ascii?Q?kWbQIDqgvBbQqZ6eNDKzNwxOXOTbqyq8M+EaZUTlt3batI0FQOJGSBYIVSqs?=
 =?us-ascii?Q?fEFCwzmHsVsw2E1O8OUSfDBTClaIfK4Bg1uS/F4tQHZYg1VAUvZE88Q8w5eF?=
 =?us-ascii?Q?BwhaG4/quZ2u33qkHdhCOBNgAo5Cj088Rhc7PmguXdK4uKhaCv/855rIqU/R?=
 =?us-ascii?Q?j8ihcgeV9DkiHKxbfMxF0+lxKy7qHLwWXjHf4Qp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2d9972-5b12-4eab-fd4d-08ddd48fe25e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:21:00.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPK9qZLaMr6XB+ef+Rg5E88qGzllFcNl825z9CEzbwIxv0HhWjgsOeN/RNtLJ8Te
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678

Instead of just checking the existence of PMD folios before and after folio
split tests, use check_folio_orders() to check after-split folio orders.

The following tests are not changed:
1. split_pte_mapped_thp: the test already uses kpageflags to check;
2. split_file_backed_thp: no vaddr available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 .../selftests/mm/split_huge_page_test.c       | 67 +++++++++++++------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3c761228e451..cd34000279fe 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -25,6 +25,10 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+unsigned int pmd_order;
+unsigned int max_order;
+
+#define NR_ORDERS (max_order + 1)
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -38,6 +42,11 @@ uint64_t pmd_pagesize;
 #define KPF_THP      (1UL<<22)
 #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
 
+const char *pagemap_proc = "/proc/self/pagemap";
+const char *kpageflags_proc = "/proc/kpageflags";
+int pagemap_fd;
+int kpageflags_fd;
+
 int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 {
 	uint64_t paddr;
@@ -153,6 +162,7 @@ void split_pmd_thp_to_order(int order)
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
 	size_t i;
+	int orders[NR_ORDERS];
 
 	one_page = memalign(pmd_pagesize, len);
 	if (!one_page)
@@ -174,6 +184,12 @@ void split_pmd_thp_to_order(int order)
 		if (one_page[i] != (char)i)
 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
 
+	memset(orders, 0, sizeof(int) * NR_ORDERS);
+	orders[order] = 4 << (pmd_order - order);
+	if (check_folio_orders((uint64_t)one_page >> pageshift,
+			       len >> pageshift, pagemap_fd, kpageflags_fd,
+			       orders, NR_ORDERS))
+		ksft_exit_fail_msg("Unexpected THP split\n");
 
 	if (!check_huge_anon(one_page, 0, pmd_pagesize))
 		ksft_exit_fail_msg("Still AnonHugePages not split\n");
@@ -188,22 +204,6 @@ void split_pte_mapped_thp(void)
 	size_t len = 4 * pmd_pagesize;
 	uint64_t thp_size;
 	size_t i;
-	const char *pagemap_template = "/proc/%d/pagemap";
-	const char *kpageflags_proc = "/proc/kpageflags";
-	char pagemap_proc[255];
-	int pagemap_fd;
-	int kpageflags_fd;
-
-	if (snprintf(pagemap_proc, 255, pagemap_template, getpid()) < 0)
-		ksft_exit_fail_msg("get pagemap proc error: %s\n", strerror(errno));
-
-	pagemap_fd = open(pagemap_proc, O_RDONLY);
-	if (pagemap_fd == -1)
-		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
-
-	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
-	if (kpageflags_fd == -1)
-		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
 
 	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -261,8 +261,6 @@ void split_pte_mapped_thp(void)
 
 	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
 	munmap(one_page, len);
-	close(pagemap_fd);
-	close(kpageflags_fd);
 }
 
 void split_file_backed_thp(int order)
@@ -471,6 +469,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 	size_t i;
 	char testfile[INPUT_MAX];
 	int err = 0;
+	int orders[NR_ORDERS];
 
 	err = snprintf(testfile, INPUT_MAX, "%s/test", fs_loc);
 
@@ -482,12 +481,21 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 		return;
 	err = 0;
 
-	if (offset == -1)
+	memset(orders, 0, sizeof(int) * NR_ORDERS);
+	if (offset == -1) {
 		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order);
-	else
+		orders[order] = fd_size / (pagesize << order);
+	} else {
+		int times = fd_size / pmd_pagesize;
+
 		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
 			      (uint64_t)addr + fd_size, order, offset);
+		for (i = order + 1; i < pmd_order; i++)
+			orders[i] = times;
+
+		orders[order] = 2 * times;
+	}
 
 	for (i = 0; i < fd_size; i++)
 		if (*(addr + i) != (char)i) {
@@ -496,6 +504,12 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
 			goto out;
 		}
 
+	if (check_folio_orders((uint64_t)addr >> pageshift,
+				fd_size >> pageshift, pagemap_fd, kpageflags_fd,
+				orders, NR_ORDERS))
+		ksft_exit_fail_msg("Unexpected THP split\n");
+
+
 	if (!check_huge_file(addr, 0, pmd_pagesize)) {
 		ksft_print_msg("Still FilePmdMapped not split\n");
 		err = EXIT_FAILURE;
@@ -526,7 +540,6 @@ int main(int argc, char **argv)
 	const char *fs_loc;
 	bool created_tmp;
 	int offset;
-	unsigned int max_order;
 	unsigned int nr_pages;
 	unsigned int tests;
 
@@ -543,6 +556,7 @@ int main(int argc, char **argv)
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
+	pmd_order = GET_ORDER(pmd_pagesize / pagesize);
 	if (!pmd_pagesize)
 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
 
@@ -551,6 +565,14 @@ int main(int argc, char **argv)
 	tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 1) * 4 + 2;
 	ksft_set_plan(tests);
 
+	pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (pagemap_fd == -1)
+		ksft_exit_fail_msg("read pagemap: %s\n", strerror(errno));
+
+	kpageflags_fd = open(kpageflags_proc, O_RDONLY);
+	if (kpageflags_fd == -1)
+		ksft_exit_fail_msg("read kpageflags: %s\n", strerror(errno));
+
 	fd_size = 2 * pmd_pagesize;
 
 	split_pmd_zero_pages();
@@ -575,6 +597,9 @@ int main(int argc, char **argv)
 			split_thp_in_pagecache_to_order_at(fd_size, fs_loc, i, offset);
 	cleanup_thp_fs(fs_loc, created_tmp);
 
+	close(pagemap_fd);
+	close(kpageflags_fd);
+
 	ksft_finished();
 
 	return 0;
-- 
2.47.2


