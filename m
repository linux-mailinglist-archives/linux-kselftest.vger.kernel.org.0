Return-Path: <linux-kselftest+bounces-32852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E21AB3567
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF12617AFA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C226D4F2;
	Mon, 12 May 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JcZJ0Mwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023112.outbound.protection.outlook.com [40.93.201.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFBB26A1D4;
	Mon, 12 May 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047210; cv=fail; b=QPHbS/nPvXHPYlSyR2eAkPBOQjuF5g6lxJGt8/uG0Re+429rSSjihYIbDpTalx2tfvJmlzxCfI7VCp1xexced4xCXq+UT7YKU3oQuhimAUJtLmvmRzNm9sn/SdOgaHOOci6xSYk6XK5171h7A/h1uF5Zasu8Biw5vkQgNjGlG5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047210; c=relaxed/simple;
	bh=+fGVL/BdEdvb8GdZySLhGSp0MqeDSEETfOa2F/a8Wzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juZnN+GfVngoyF/o8PM2i5wI2AT1IzhGbwVPTEEMRhNbFDHlOy3NJ0nKBLr0PtbST3J04ki4/mTnnKrAGpjdbK52/MKTvu3kyrfJdDmbWMmliiJEO4vgQOnweh48r3wjqB3GrfgZJXlFtB/6FNiuRwCMejfMc1MkChN7OzceSVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JcZJ0Mwx; arc=fail smtp.client-ip=40.93.201.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5MZ+EdYFPG6ezfTyxa0iH4pLGRSiJE/dPY1G4wqxFP6oYkpunIYrX0cUTpuaF+Lqha8qQ21AFJVsfGpTe7Dwq1MM7Em8lkCEQAQPi0fUYH/6wMrJE0SFVnqmhKxK4s2uSkUoLa90Ou0XCn64Jq0LpOTwffLElOivAZT6clHwjz9bEgbAt7Gs+830bCs3065Eaa9cdlM3DneZB8+DN3NfE3TnGFR85DfyekqCupEWXHIyQwuvXRESADfy7XBk/1/UVHPdhXbwZLEfzDPewRB1rWSWyhICApK2h+LTG7gtvdIv3PSwSeqDCCeDhRUtrlcELeb5Gi83wlBQpxW+iD46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4mqazdQp3Ca3QY+fJoZxFYxPhqwESH/NEf3Pivj5EQ=;
 b=a72CXQbL4gkfYYruXtf8wfI1oEH6TSZ2/TIflfdcleOYNKeqvKl7ri96MaBaGaONDt7T0aSAm1yHHjHCHWuV+eNevBVu6QLtWKslAC2jefynSVdDS45z/MZ6e6C8PviStFnUrf7IoXVSzVuAC8Cht9tnr2UVN16bSc2Pt2SJpc7Od5dxsKl9f9D8KtgJ8oUlQLkXGA+s8IOpHEZxQ2NxGeXlL8pPXzztsJqv7exo/QRcZvWYhua509erlc8nGRZrOA02zQmwBppKDJoCzFUTcmKKmpXVJbps5IDN/BdJo7FKMXvq75ED+7taJPmalUQtPoj/oVb0k/l5CTUyAU68Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4mqazdQp3Ca3QY+fJoZxFYxPhqwESH/NEf3Pivj5EQ=;
 b=JcZJ0MwxuxYBnknhQZpYBjiSgWyzFQhbFZg3d1OaLuLLMZfCjxLl87MD1u7VVvLYB9SdIFwNEpFbAPRhKir39cF9Y4Cdhbrjl1lJBOsbNCil5anGfEUax3txYqCL2VCby2BhI3ovSobwISrtCCd9pfYG9N/L3EyPd6LA4dmx4So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:21 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:21 +0000
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
Subject: [RFC PATCH v2 8/9] KVM: selftests: arm64: Extend kvm_page_table_test to run guest code in vEL2
Date: Mon, 12 May 2025 03:52:50 -0700
Message-ID: <20250512105251.577874-9-gankulkarni@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1dff5cb5-8961-4483-f14d-08dd91433608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Y1fqH5l5I4VXJCC1GeoMu9JmzUtYY2MtmCZ3hY/s9NetUhcAEoW9g1+Zr0a?=
 =?us-ascii?Q?WyAJ4oV1JtevSHbThVAo6Rb8yDqSgH67lnJ5NCkncouJQPlUizvGxfCC1V6u?=
 =?us-ascii?Q?u+mz77C/tglLGrhDXZR7IJ7X2D1BUqR1ai0G5I4ZwNuDlA5i5Y9okmexbzjT?=
 =?us-ascii?Q?AsnAIDu73VZfGMuAT9Szn0FDl2xTfN9uQgZVKyuOxrdd7SbP0lz9jLVTbVTy?=
 =?us-ascii?Q?v/p+QbbkIZYTCunmTWUGpCpMrfsKA071glwM833of/AvA0ibUl83GayEnmCO?=
 =?us-ascii?Q?WEtpPfu5mTbqRxEx7usS2JA45pIUGLtBK/SKRGPIbgw+Vl/mxraIQP1q+zcU?=
 =?us-ascii?Q?Av9c8VULQSwGgXTUhn10ROE625WRmIxR0YpPXwiV1ZVboPbUup9mFjRQwwKA?=
 =?us-ascii?Q?o0Obf2+z+ryLrzTfvV9NgEiNr8gdvVg1Kk+fSbun9F00aIDTzdSXHab/PXIu?=
 =?us-ascii?Q?QPbPlH3Sis9wyNEC+0tFMhQy29AWcAOZWjBmxJDJ3bPei7kdmnYtRtt3/gMr?=
 =?us-ascii?Q?GizAxM3Jyzg7546WZKvt00HDzG4MfhdxQjRYS+hdz4FTAyyoNtyq9/ogp4VS?=
 =?us-ascii?Q?EDGdymsfseqJTO9oDRzyHqyjAguZIITKy94Rx7UlRX/n2rDEdIdUQrDb8Ygl?=
 =?us-ascii?Q?yACPMgjRsyhxBiLdMyn7wMG6+or3DYR7GGMZ3vbWZ8QVyxQaQ3gtWIN/TCno?=
 =?us-ascii?Q?IQF4otSCXRNs5ObSHOxmh69VOiE4LRnDo2TgV6jp0cCaOSec7RXP4bf9HkPV?=
 =?us-ascii?Q?3F7x/d+B3NacpYC2VRAryTeYE252843rj7K1OtJ15fYeYxSxzxEPJNpbvtcM?=
 =?us-ascii?Q?2pLRVs2s0MaRmM7oCv7jATIVGToBZhoYI9uCMBoYoZUyFcfh3sxSEr4h5ITV?=
 =?us-ascii?Q?2WjRWSU0pvVf2cSorkq8UOIyAn0mnsO/8mKqC1hHI8rjbSasp+OqA8CeWU4k?=
 =?us-ascii?Q?4a6nz8zni7+ITlHKozDKzsBhTW5REvnPx+wobGWXVaEF9f889nLFMFA+gJcc?=
 =?us-ascii?Q?zMSbO/Jqhl9Z0J1weBkhVExAyA/IoOeX7Tq0cJsHKOLgxks5dUqD23Si4ymf?=
 =?us-ascii?Q?dlltH2/wdKFMBfKL8Tvm6wb7U/TMqCifI9NepEdjaK5asQ74aYU5uBuGM9f3?=
 =?us-ascii?Q?hK1I59bMIZ3g5oIujrPp7NVXlBlwGV1e4q6TyXQwzV5gibDp7PSQS93FZgck?=
 =?us-ascii?Q?S4ag8kt3ePzBQKtso7nk79CUMU+rEGUKZ9uTHvGUyQqlqUF0xBOOJBA9ytdK?=
 =?us-ascii?Q?I50gKBZPyBxVcEr0YW6QMJKJD8I4EseTYwFPJtU6cvq1301najn0bo2+f/gK?=
 =?us-ascii?Q?c/1c2e3AZv8cokPktyUvkmZ1mg5ui4ScuSO4zjvLHybqDMw2BhsLU2L3AQIt?=
 =?us-ascii?Q?qulrntSaHAy1JjqoezmqSDaQxgw8S63g4L6KokjwT8qp2ZuZmWYEQN9TZso/?=
 =?us-ascii?Q?kj4KWlNQ6Lp8s/SxFZVDyqD2F9kaAGvPKA9te3dg6Ctto+rgOAHuEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2Yy6hmGSm/Uh6MYlhGtFCGnOo+bZPHcIrNU8PhNp7sRx5Pl3l3nLzE0wgBo?=
 =?us-ascii?Q?qdN39jKqS9rV81NzWxeFv7UjYl5nWtvT06TJRNxQ4KNJrdIl2YkeJbLhAgvT?=
 =?us-ascii?Q?Tm7/VACBf83uHULcsOkQ0LZhGja27A2p8Z0I4QP6kb8OeWuC0CJRsf8sk7l7?=
 =?us-ascii?Q?vbfVaqcQNK4zFb7I6nLe37V1SZG9DMsPqoSX5RLCoDrjMYLrzSJBzb7NN0mK?=
 =?us-ascii?Q?YlTjMhQ4hscOY+DO/VV+b0um1agzdCKxG5nCOFnIpUGYlUvTd4Qspr6flDkE?=
 =?us-ascii?Q?RXykMyxN3rgmtfAsW+q+dDxKLiIoJf6Jf0U8C3NjimlATI84oPhlKT+AbF06?=
 =?us-ascii?Q?9kqKEvvplWDWMGjzMrJDvZ46SRRf0WA6Ra27qcNmqpES6a47bD0YpPXpXoex?=
 =?us-ascii?Q?ax/5aOyMfiFDbtmh4ldmfD4gr06n6roqq9z5TxhKHwSDyiDLCEtFqjqfMSCC?=
 =?us-ascii?Q?Hc/43vcyTOktQYQH2VEg91B4Xut2mdpJv0gi418lnwY9oVxgFc8dYw96HCkO?=
 =?us-ascii?Q?Iwd4/vA5OSFC283dWvEE32dYdoH30jLuH+QThFB3jZFgOkwL28N+yzF5MgNw?=
 =?us-ascii?Q?dD0oe1gpHDKvT4/dEwGZDGH2zRh7vMn5y5jbTVBomOc8jFJcrwZ8pEItlhzB?=
 =?us-ascii?Q?URxK/6SFQZ3uS1bzJbdhslnJJCZui5CQ+QnorIaTihKrOEYdDY9yUo7QQKLg?=
 =?us-ascii?Q?+CystVo718JlGcfPNgrCo2Z04lCreE75WDguZiI3Bgt7Vz4dYqCGywQQJmY2?=
 =?us-ascii?Q?ZNYX+O38YBu6Pk0ppGVzbKPk0vWm+po19onMFjVd1qPB1Ox5MeSasCoZ/G0c?=
 =?us-ascii?Q?U6RzYZK3PxdQjMpF9pYOAb85al1t6FnMqTcKrGLfyrX3NxPSbcx4sWsZ+1h2?=
 =?us-ascii?Q?Lc8SuLbUtQ6CPJBxGEmf+8sn7GFDzvMqtcP7v3RuCpzkdBALwJWrrseWWJd+?=
 =?us-ascii?Q?uWcThUoPqRn1bAm31keVBkqsAuaDiNOGFSiAo14y7oJ+gioO0LaoUgfWrfVf?=
 =?us-ascii?Q?G54UnFEmR3BjxpvI97h4Y8fAJFpZnENgB3egDLMM8re04UkHeA63N1aRGSPw?=
 =?us-ascii?Q?74m8S81Ql3PKKXt2nzA8JVRvfzrGLFcOfL/vgoOGwoaoEH+bnXxIcWqiZ8dQ?=
 =?us-ascii?Q?TV07GzXxPHwYZoIIDdBrBMGv1gwOe2EeI/7sq+p/mHnVr7fXcVNdLezJMh5N?=
 =?us-ascii?Q?34V4sOXoruYxdDwcT8i9anGUl1oOeQ6xJCAXmiiuYqpN0kAXBZKr0kdUdM9M?=
 =?us-ascii?Q?aUT3RBixiyggAl0/90Hovt4L6wHxXld5JeEc3l+tgSGYfNJQ105qT6kWqqNg?=
 =?us-ascii?Q?3YILYTPzgfq6mUtCRGMPVNKb9rcaZn6TMDZANuFocnSJNmZcJXAiseNa7zWb?=
 =?us-ascii?Q?Ovew48uu86y8tYzhu08EunEIBLPfTis4ZMiqfJLeZ4P00Afl69NVC48X7Loe?=
 =?us-ascii?Q?9bQrW0AyZJiY9bgdMWSjbuo9QpZXqk/VVOUZaL89CDx56yWPaqQt3dPv9BWp?=
 =?us-ascii?Q?ju+bMs3rCyJZhOBDJktrmwxq4UIOfbdg8c2iSiqg76oPxSq7gr54ERVfi6H7?=
 =?us-ascii?Q?cGKNUuBzoVyHUYYvr04UF7md1bnVBnhhyx/LbTR344BnfDHOKNUYJPhGE2JH?=
 =?us-ascii?Q?Ai+bMFcFG1XH31U9vR85Nu+mBtTUY44FESg03J4OQ+tZ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dff5cb5-8961-4483-f14d-08dd91433608
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:21.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q0jyIk8qJsggJaJ42bd3sYvYIq83J1cb+9E7Chh9geionAHcovK/JEIbWc51gG7zRxSKEVosU688DQao643QZPWE/de9Diumppq9ShfAPcr5sjf1MW9FL3SqN7f8L94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Adding code to run guest_code in vEL2.
NV is enabled using command line argument and it is disabled by default.

NV is only enabled on ARM64, for other architectures the test will exit
with an ASSERT, if tried to run with NV enabled.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../selftests/kvm/kvm_page_table_test.c       | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index dd8b12f626d3..383f9d134ecb 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -20,6 +20,10 @@
 #include "guest_modes.h"
 #include "ucall_common.h"
 
+#ifdef __aarch64__
+#include <nv_util.h>
+#endif
+
 #define TEST_MEM_SLOT_INDEX             1
 
 /* Default size(1GB) of the memory for testing */
@@ -229,7 +233,9 @@ static void *vcpu_worker(void *data)
 struct test_params {
 	uint64_t phys_offset;
 	uint64_t test_mem_size;
+	bool is_nested;
 	enum vm_mem_backing_src_type src_type;
+	int fd;
 };
 
 static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
@@ -252,8 +258,17 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
-	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus, guest_num_pages,
+	if (p->is_nested) {
+#ifdef __aarch64__
+		vm = __nv_vm_create_with_vcpus_gic(VM_SHAPE(mode), nr_vcpus,
+				test_args.vcpus, guest_num_pages, &p->fd, guest_code);
+#else
+		TEST_FAIL("Nested Not Supported");
+#endif
+	} else {
+		vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus, guest_num_pages,
 				    guest_code, test_args.vcpus);
+	}
 
 	/* Align down GPA of the testing memslot */
 	if (!p->phys_offset)
@@ -345,6 +360,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct timespec start;
 	struct timespec ts_diff;
 	int ret, i;
+	struct test_params *p =  (struct test_params *)arg;
 
 	/* Create VM with vCPUs and make some pre-initialization */
 	vm = pre_init_before_test(mode, arg);
@@ -414,6 +430,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	TEST_ASSERT(ret == 0, "Error in sem_destroy");
 
 	free(vcpu_threads);
+	if (p->is_nested)
+		close(p->fd);
 	kvm_vm_free(vm);
 }
 
@@ -421,7 +439,7 @@ static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-p offset] [-m mode] "
-	       "[-b mem-size] [-v vcpus] [-s mem-type]\n", name);
+	       "[-b mem-size] [-v vcpus] [-s mem-type] [-g nv]\n", name);
 	puts("");
 	printf(" -p: specify guest physical test memory offset\n"
 	       "     Warning: a low offset can conflict with the loaded test code.\n");
@@ -430,6 +448,8 @@ static void help(char *name)
 	       "     (default: 1G)\n");
 	printf(" -v: specify the number of vCPUs to run\n"
 	       "     (default: 1)\n");
+	printf(" -g: Enable Nested Virtualization, run guest code as guest hypervisor.\n"
+	       "     (default: Disabled)\n");
 	backing_src_help("-s");
 	puts("");
 }
@@ -440,12 +460,13 @@ int main(int argc, char *argv[])
 	struct test_params p = {
 		.test_mem_size = DEFAULT_TEST_MEM_SIZE,
 		.src_type = DEFAULT_VM_MEM_SRC,
+		.is_nested = false,
 	};
 	int opt;
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hp:m:b:v:s:")) != -1) {
+	while ((opt = getopt(argc, argv, "hp:m:b:v:s:g:")) != -1) {
 		switch (opt) {
 		case 'p':
 			p.phys_offset = strtoull(optarg, NULL, 0);
@@ -464,6 +485,9 @@ int main(int argc, char *argv[])
 		case 's':
 			p.src_type = parse_backing_src_type(optarg);
 			break;
+		case 'g':
+			p.is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.48.1


