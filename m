Return-Path: <linux-kselftest+bounces-32853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5BAB356E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FC13B0AF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEF26FDA6;
	Mon, 12 May 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fm6UxiBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544126C3B5;
	Mon, 12 May 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047212; cv=fail; b=m0gdZCeXAix7zR8VrMyxxEUqLSrXKsoa5PyRP5NDQSvmp+uAD98y5dC46PbYcGrNVUmFwc+9018UsWerkUyzmIuyHOcZe9U1nrkPdRAJuul+1icpPaZ8iKZfTUY6rUZu54GFtalDUZblv0SYhjSoPQ3jQXVCy7Me1xF6Vcbqoqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047212; c=relaxed/simple;
	bh=jh/f0pqggVcvzgdvQHFd7xHG9FTfF9S1mmbcIW6Dcsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pnirXWX4q5u6z0RHnThkF8PlnCBZh7Wivg1aB5ZxQviqMEIWKWmEgcURgjqvyYfFKRJnbOfEIqlE3TPv4BmWlsVpoGMw7DJsqRrgf3iNW4yvvSU5DxVFhaSWotkYdGSh9Q7E6OSNM5bcM9lVbj/KCunHQWrddL6yZUCRdfEyRpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fm6UxiBH; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUNBI6QQptOTfPkBSUtvSZYoDFi21SIluHOBXMcMHDU4rB/WkcEepoqBBxqCaDcZOnvAK/hwKvL42nwj3RdT8ei7TNFaCMnneAzPz/VErsQoytkca2VJHqsntMcEAv98tEGlJV5yaPLHDDsndjv6als3/QaQTYm5S0uGGkRN7ewUFCy7OTAl/nEa9+iJPAeQwHgTXPIy+41KiRMYuJVuVvDEaFSDMLQZJP4BXBaMT8RGSrPACa6LE3gfU/gEzZHsOmA/ZFVZPPCUlgRLMktc3iqdBhqG6btqZjKFmaWMBKYVXCwrj/vxNXWL9/+jh8+P+tjPdtfPdxiI5BpuVJANhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HDIk1ETvLD0KpSPCCnfbrZz2cnO8BCYDGkUVPam3Zo=;
 b=CTm5fU0aK+D0Uk4hkWuQ1+9TVydX7Ge5nGMvDJrU3qrVzqf1TdZWb68TMWoPvxZOLpX+ymSP4ngLF56ZCQNOIkmgzOcCEe1pGqi1XE4ULQubYZLAk5WsDsgN2NGQyVGCyWm06D5kHhZbzfs0VltiVwnM5RlbLAmp1eLjFq7LfeEA/Chv3HvBIpYAamrkfr4JGlHtZQHUDO73JuocsfGZ1sQIkQ+SMv/5tbIHlNfE//eAcRavSYaUygQbZVI09wce29d+FWTiqDdE+ZUcv3nzKsD5PHDqcaBDkFryDfEyA6fh86AvRKgHUsIcueYjCNgVzxEB0Zck0fmCF7t2gkJXYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDIk1ETvLD0KpSPCCnfbrZz2cnO8BCYDGkUVPam3Zo=;
 b=fm6UxiBHQFyEs8pJwrHmnaWvTZfZtrfFrEuliCG7/rbi7EjTbjzdceoRvl8jYkZyWgnUbDnfmxpPunblKIt09qD9IJ0WgMum8opvNAt7FnN2PRgn16tRenz5MZXtd0miNZfktrzVpChUCGuwZaJpmpKzm8jsD3i/ekGCtpDGBuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:22 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:22 +0000
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
Subject: [RFC PATCH v2 9/9] KVM: arm64: nv: selftests: Enable page_fault_test test to run in vEL2
Date: Mon, 12 May 2025 03:52:51 -0700
Message-ID: <20250512105251.577874-10-gankulkarni@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6069b83f-e10c-43a5-7b15-08dd914336e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8vC6caMhyCZTu5fn7rjwxQnNp+8xMeEGe2qiW79pjc1mZCCE9yeUGINJ9NH?=
 =?us-ascii?Q?0H4SFoz6yveSK+SN7fQmZSYJeloJhqYi7SmUs8w2M5/8G9pi06TJRx7t0oio?=
 =?us-ascii?Q?MD8F6zfE1KFmSl1a3CsjxvrppDIiJzkMeS/94G0imUU5J1EV0F4fvjnMGi7X?=
 =?us-ascii?Q?eF4vHwuSxCJWBOsst81ULHn9w9Ubzbhq4FfZ4f/Gl9JVZiWOIyjX/DkzUOwk?=
 =?us-ascii?Q?ZlhDTh1hvAQ357Pnlc5VTWQGqQoatlf86jTZHUlSfychwZC7OJDA0srvPcr4?=
 =?us-ascii?Q?LyO2QBLwtqqGQEXlDF2RpBzXEQe4IARqIM7GTMByGfizs2k2KwbkfJm+CuLy?=
 =?us-ascii?Q?Srwq4jcL2tSFyaEWkgjp82CWfXkqql1wnopMdWoJx4qbj4XU4fds5+TAV64X?=
 =?us-ascii?Q?aDrh0dQgxxnqlHEL0ehlz5+5CEtW52cnoNXMM1OXqfe05VNq1LjB/MoX72lk?=
 =?us-ascii?Q?rMwK/2IiWO6XoImrSQYkKv9xW/6f/nfunQsGU71fS3wBNaKoV6mnE16tHQBR?=
 =?us-ascii?Q?GcbCN2AJx6XppKWbiSUJpuThNxGYaTBXFfTaWCOuTIwZ3zXvg2sVW8aLX9Pv?=
 =?us-ascii?Q?AqCDq9yljWjCUmDdF1p9FsUvdU0gDXkg46A2OrqxK0GifHYk7xCBgHe544qG?=
 =?us-ascii?Q?oFnG8FJAylUXoWMYG6Kn9v2OqeJYC0p9QxliigmaaKAV1QRnXErQYKc7MOKP?=
 =?us-ascii?Q?d7J1L8zr30ny+f9bYTwtSFnZHN+bTsfFZ/iIa824oSOTR7FzxcR0LS8RVAHn?=
 =?us-ascii?Q?HG6BKvLDnPe2c33JsUZOrmBT2Jqgg548sC5yszT90+YVZ8qNCP8T6GdGPuBM?=
 =?us-ascii?Q?Cc6c6lB6EVI4cEjzyXTcr23OrSMaqUhwooqzY0E2kxoW0jLT03uaNS1oSEfV?=
 =?us-ascii?Q?wRRjlbeZsa2LLfsqHvjoiv7/p/g2Ba0/60UOf4jwwLNn4zDMt4WOeov2Ig9R?=
 =?us-ascii?Q?2gju65iRGm1EBOMNtwii2pzGLD6Q4VQQURRmhf6uHDTzgIgvoUPbBzgr+eQ7?=
 =?us-ascii?Q?V1gxSGxNFoZb6UlXelCadIGqzymetNPIFl1ZVK3xtxpeYkiR7Yc0nk9h8pEy?=
 =?us-ascii?Q?Kp+qf7ZbsHv4uBnui3eg3DREYsLMgLT0do3nQ4f4eKhiHyokDj5svh91NdaU?=
 =?us-ascii?Q?L3Hf8+KjX2q3Pf/eHgLff008o+I7dlrDh3NFIge8L9HVh83siKQWWVLPULmD?=
 =?us-ascii?Q?cIBPQjKbPyMeA/3raCKFjxhpPijXlBIQyNkxeJh2tF48X6FtS91oVOvfEOuY?=
 =?us-ascii?Q?LZeFIEzFE0lV5PkiRcqXE8R2/nAbzETOelZd49jO4nKKsrHqfaj+Mly26kOA?=
 =?us-ascii?Q?mwWEcWTHY8J1u1omhmbUEooZAWxBSLTqz/53uDRPJ84mEIoWR95W2d7EA/xs?=
 =?us-ascii?Q?PAgX1JAKH0VF9E8lx4iRd+qxZxoQ8rQMAfk7lAGQ8WPBWGjvwfmiK0SNpjuL?=
 =?us-ascii?Q?b9U36CkFJ0VtvwavrRQUGsuxdgS2Ph/3nriNxtaSwDn56WuDioebkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1MFLfbgt+io5ILSQVmv3yII1IRafFtmZs6k0wSJrZZMRPqmSiYIwDiNnQ5d?=
 =?us-ascii?Q?4YMS0jjALWdkazbjzoV6oloW8lhcx7X4M6a4cmIiSy9KvuFj/8mJqlepfjU7?=
 =?us-ascii?Q?xbQCqV7ZcZ56X7wjYXRU7vQdgDNjHivmh36zdhTWJ/f8yFi/rgjD9as2KKVg?=
 =?us-ascii?Q?4nCVDVT1/xidygEfQlwW4W8WFVPeL9nhEE27U5hztKz4/MweGgbfSYZBzfbb?=
 =?us-ascii?Q?EZoEQRVwmdSquVyvnJWugFXkSBS61zia8ob16fz4gT8UTzXHNzfaWeg0js0m?=
 =?us-ascii?Q?0qIbDFx8admqHwRrh1tmwCEjKgq4PTtWNZQ99a1qhOox46k3ztClQzrkPTup?=
 =?us-ascii?Q?VyfakTF9CQd7RHHa03NglT8IoAKkC+rSn2LHYwZsw6flEdaUvuY+uWkmXBW+?=
 =?us-ascii?Q?i/ESyoKq44n5Czam8gs66WZqW6yUbZkDse6Q7SKxH9CoRf1HJTG/+cw2isSk?=
 =?us-ascii?Q?5/vK9EgyBZPzFR/rgZEni7Wp4lkqydkuv/Xq1N5SOd03QrTXMxaBQudNCjC4?=
 =?us-ascii?Q?Z3whKGdxGX5OMLb06oXn17aA5Mx4lGc8soEMPWsW/XpC++AdXfprzAH0VHU8?=
 =?us-ascii?Q?g7T6G/uWXA0YSbgEWGFSlRRAxKEhQpFjt1AExp/1EduLNj1aScN+h5ohn76n?=
 =?us-ascii?Q?Uj0Rne66SpxQ7J1nRe/DtkrffNvcfZdB2oa5w5Ksub97xZuqUrlGWURhJ5DL?=
 =?us-ascii?Q?vSJ+TbFiP0lktBgHhYNepZxkqjuzr+y0mOfvB5BZ0478bV1CHWC1V89t8luk?=
 =?us-ascii?Q?6YKSKoL9utbExau6VE59X02BqnqXuWdytWDH7+ENl+zJLKR8obIosTY9C2tI?=
 =?us-ascii?Q?prputDJW8NPnnjIY0voMJ0SQRtjLcyfM/WINIxKWi5E5zUt2XptYmSqmcOuO?=
 =?us-ascii?Q?JsKhhy/5YTsU1U9boFghS05VTshnzOAy+Y6HIg+PllRBhaGM0Hnjdjbzztti?=
 =?us-ascii?Q?lSnECcMgQZOggQfiQ7teJskJ0RkW2Lmx/P8TTrsJNcAcR3gsgDn6Nn14YfZH?=
 =?us-ascii?Q?3ROlBNRArf2LR4Yu7fZBs2gbyUKFr2dD1ZQRx0Yiya+9pONnW2ElCWRNiho7?=
 =?us-ascii?Q?KvbjscgqiG28g7XCTYSJKyJ+m+0cGmQJSCvb4vQSFdlo7ra88vAqadWbRnie?=
 =?us-ascii?Q?30gxTi6GPN6LUgoMqbxFm+1kj9G1ovACcuz47EW/TJudyvZAHgiYl6tuYSJv?=
 =?us-ascii?Q?kMXDeIZGrFHlWb701dTrspfDL2Zc42n1J4l443/rS7QZnr37armkD+JoRL1k?=
 =?us-ascii?Q?QmcW6jN5++deWvDb8Pg51b76ZKI0JDsI38NJ/H0+pVG6YyjSs1ly5EeT3JXh?=
 =?us-ascii?Q?OGkSEHnSr51eU2sQf51dQ+lJyUwOqBUyShCMbvby4DOnE1dVmj+fCgGZ8QwE?=
 =?us-ascii?Q?XLldn6Vi6uGTrgQ6K8zdsoTefk3R8Efm8VOU/bGuehpx1CGKcknMib0+RyAO?=
 =?us-ascii?Q?php2z340Vgs4T9X+I3bHhK818HKJStfdTWZ6Kq8OEvq4Gz1nuSjkKIdCwxXy?=
 =?us-ascii?Q?ZIx/fp2sG3fwtSatro5wJ3ZiX0ZOczSZAoCA5Y+kkhUx1Fr+33RqSH3u0B7r?=
 =?us-ascii?Q?DoMdhvjfG75Xt04kMrDTa4WrDwhr0VXkAJPQ5sCHTho0dtOY5WN8I3Fqbh97?=
 =?us-ascii?Q?Y9ZUkWky9SeBaj954IYjdQU9Q1JmpKD3GyeCEoFIeDO+?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069b83f-e10c-43a5-7b15-08dd914336e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:22.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQ9YmeBYobgzL8rPU3Op1G75cyygYlrTx62c+5/RwUpdfjsJXgcgSybcOuTF1RGh6kE//R0TRk60ZhGEgCY54UoH6uB2IlDg+gisY/4yKst5ihzsd3u7q2tP9wxKSuSt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Extend page_fault_test to run guest code with NV enabled.
NV is enabled using command line argument and it is disabled by default.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../selftests/kvm/arm64/page_fault_test.c     | 35 ++++++++++++++++---
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/page_fault_test.c b/tools/testing/selftests/kvm/arm64/page_fault_test.c
index ec33a8f9c908..e3d91cb68a71 100644
--- a/tools/testing/selftests/kvm/arm64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/arm64/page_fault_test.c
@@ -11,6 +11,7 @@
 #include <fcntl.h>
 #include <test_util.h>
 #include <kvm_util.h>
+#include <nv_util.h>
 #include <processor.h>
 #include <asm/sysreg.h>
 #include <linux/bitfield.h>
@@ -70,6 +71,8 @@ struct test_params {
 	struct test_desc *test_desc;
 };
 
+static bool is_nested;
+
 static inline void flush_tlb_page(uint64_t vaddr)
 {
 	uint64_t page = vaddr >> 12;
@@ -701,14 +704,27 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 	struct uffd_desc *pt_uffd, *data_uffd;
+	int gic_fd = -1;
 
 	print_test_banner(mode, p);
 
-	vm = ____vm_create(VM_SHAPE(mode));
-	setup_memslots(vm, p);
+	if (is_nested) {
+		struct kvm_vcpu_init init;
+
+		vm = ____vm_create(VM_SHAPE(mode));
+		setup_memslots(vm, p);
+		vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
+		init_vcpu_nested(&init);
+		vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
+		gic_fd = vgic_v3_setup(vm, 1, 64);
+	} else {
+		vm = ____vm_create(VM_SHAPE(mode));
+		setup_memslots(vm, p);
+		vcpu = vm_vcpu_add(vm, 0, guest_code);
+	}
+
 	kvm_vm_elf_load(vm, program_invocation_name);
 	setup_ucall(vm);
-	vcpu = vm_vcpu_add(vm, 0, guest_code);
 
 	setup_gva_maps(vm);
 
@@ -728,6 +744,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	vcpu_run_loop(vm, vcpu, test);
 
+	if (is_nested)
+		close(gic_fd);
+
 	kvm_vm_free(vm);
 	free_uffd(test, pt_uffd, data_uffd);
 
@@ -742,7 +761,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-s mem-type]\n", name);
+	printf("usage: %s [-h] [-s mem-type] [-g nested]\n", name);
 	puts("");
 	guest_modes_help();
 	backing_src_help("-s");
@@ -1115,7 +1134,7 @@ int main(int argc, char *argv[])
 
 	src_type = DEFAULT_VM_MEM_SRC;
 
-	while ((opt = getopt(argc, argv, "hm:s:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:s:g:")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -1123,6 +1142,9 @@ int main(int argc, char *argv[])
 		case 's':
 			src_type = parse_backing_src_type(optarg);
 			break;
+		case 'g':
+			is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -1130,6 +1152,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (is_nested)
+		TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_EL2));
+
 	for_each_test_and_guest_mode(src_type);
 	return 0;
 }
-- 
2.48.1


