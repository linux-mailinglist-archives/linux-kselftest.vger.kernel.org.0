Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F9417E50
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Sep 2021 01:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhIXXf6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Sep 2021 19:35:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231531AbhIXXf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Sep 2021 19:35:57 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OMSsEB011666;
        Fri, 24 Sep 2021 23:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=0xzDHBJrh6P9nhtC5Zj3HquatvIz+K6pb9hOG5aGYb8=;
 b=hRWfVFGIIZ9ru3x3qqd+E02Sa+05FJZ7QubbEDCd3M8WFK7K2wGDkaXK3qyBDq7LtB04
 t6Uf2ANlT+u5nE4+UFf9NfgiyoBWJ83el+bwXhleM7FT1LaZs9qeHzSLTsU9OfpfACR4
 od09B0ZcNuoqOrWZr+L4SuRdxpAAEbyFQTfSkQTpsNjNkC5qkFRGHcAm4Qc+dQSa1pmw
 SUOPxucmqfnzsbN+5uwQK3hwygkJsrHKwJ2E8K9GHVDDShRtp7MG5cRV8LMDxpVLAB1z
 VUa66ZaUcXRw5kQfD/qiMOQWdan4DpDt/AgTG8w6FkLnfRjmyUbXSG9RRkKC0L82fgK2 mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93esxr63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 23:34:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ONUAbD038391;
        Fri, 24 Sep 2021 23:34:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3020.oracle.com with ESMTP id 3b93fcpkcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 23:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyVoMv1CEMHJn1J6A3GpzLKfbO/OPgm0RR9IcUc64sDq1gjeTufY64o8uu1/5741MLTV7eq5KB7Ux672TALCyBIvqerrxCw98OMl3V3yj7iPMq3KtauNqbHoZMCfWp2KlMtor8S9Z4rO6GRLZ7vLZfHVFqnNNyH8W6srzj8en1uzJtQhPBoZb5BdDBaWtQOZZB7TQuikS3n3fD4LS1eWRjTBbXt7mabFHcPv2VsI79VTlFgiBgprkaGBG74gf+FJ1T39+mDAF/9AlwRBdJ+10FHLREcKyOkeW5dU95NR03oEzK/PkhrTxMLvN6GjQxJ7Fhas8ZVqcwtOnlk7uW9hBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0xzDHBJrh6P9nhtC5Zj3HquatvIz+K6pb9hOG5aGYb8=;
 b=PXqygtD95WObODbOlMt0nemkhADXIbGvqu6oEG5z3v9RyaCioF2O70WtD8NmFd8gL1SPPc+mu4lxzhbvj2DPtjh/2IuW2fQ9Wi9yWZbDAQn3uRIPZcJZsMycM7uSRCSzsI+v++YLCItKYQdugAibW2GshwFNN17StgyxIJJmcI5FDqFNMkjhV8X0U5Je5pv/we4xVfF7DkZSL7S4QMSZN26xFILHCUxhIOWmkk6TeBn7U6tGXOyKROlZOA2UfC3ZjXeXKHCTv/0Hm0X/uTlkl7A0UrZFZDSPve5fRjAak+2TG7J2+qfXLwCS4vtFOL+hFaweII4dBrrX8KswZaVdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xzDHBJrh6P9nhtC5Zj3HquatvIz+K6pb9hOG5aGYb8=;
 b=AtXQKOi9UQfFYucs/TXFSFrMkT1x7JoI4a+6zRA/Z+CKEJyd50i7nZsJY7bLps32+744iKPDDxP9GlvPnuuiaOdQVm65O9YfN0XlPCcZiIC+rqryJycBbRve+F4Q1VzpuYA01FhPeG/VcnmOdHIZcjRWDc6qaZ7od0X97ZaoRbY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by SJ0PR10MB5456.namprd10.prod.outlook.com (2603:10b6:a03:3bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 23:34:16 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::39ae:71d3:1f4d:b4d%4]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 23:34:16 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] selftests: KVM: set affinity of VM to right CPUs
Date:   Fri, 24 Sep 2021 16:30:37 -0700
Message-Id: <20210924233037.4329-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.200.16) by SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Fri, 24 Sep 2021 23:34:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ecd6201-5488-48cf-d280-08d97fb3d303
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5456:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB545613EE821A4DE949CDBE7DF0A49@SJ0PR10MB5456.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmJpK22sVaLXXVhyciqHo4KniAzQE98HFlP8OfwXsoFNTnMhn6SnuleepBr2+Bo8jD3AocJkapp0phlzKFYmtrQd3M7FxZWMkx5MhS85pdxYFjLvoUEg0ZndQiKM0zEtOGSN5gkqQ6wuufS/d/u3iDppGwmSbvNKX24cdtbs4HlqYqwL/5otOLYnj58fAIQMB5xOHg/ABq2oFmtjG1/h+EVm6lotuUw55tHdBOchSp2GSPO3KgW8kwdn5MLU5bFd8SkUEO8za+NRkzHEShabv4Q8W+MLbmRHjzXXhtmdY0/UrkWAYfzxeKpPPvBwzoH0oJs+cHARdn1hxxXKI24i0e+j2S38N1qMzAPhdmHWhYtCFyc4XZTxiAo7j/WmA+jL2DC5EPMYI+pwnUGjkGgXolDXwXVXJ58choJjkew89Nf/j7QRNT3WcQmOpPt4OTzxLYsyVnHAu8HXA4uEokexfK900+IWkbffPJW/9qNTYvoQYigyvGQhTqdQI7TfBLYQ0RPCujcPHrV/ebNBAQwoVSTt4HX/CQXBFmtcOwNwYdn/NTZ1TCsrvbClX7dzfJstOiQNiL3J6zAGbF6iNWiiw/FvNOmZsYVJQDNGsk38oo6LybocL5rrJ8BOTI2wKeEGTT9AnJ9RCOSLt6H1FoJG+kl/B3LLWg/B7pIFTe1LzWSXhmBi9TMiBlqTAphYXrdrngIBBVadRNgGz/nw/vF4yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(83380400001)(38350700002)(38100700002)(8936002)(6506007)(44832011)(316002)(1076003)(956004)(508600001)(8676002)(6512007)(36756003)(4326008)(5660300002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(6666004)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihkg6UI4HwqWu+698uBlP1e/wAlUWgnJLqA7MdqEhPcTq+YwBS+1LMcTtJUS?=
 =?us-ascii?Q?pyVicBcqPKuBJrc6E5PorBUfKKmo9Lu0ix7LhIQ9VcDN2OIax8A07MFL7gjh?=
 =?us-ascii?Q?WAi7WV0qtwN3prxWs4eKzgRAJ6pN3bOZIrGeFZEc7xFpnwWz2WmjmqmMiPsg?=
 =?us-ascii?Q?oxQShtofzKTlO+SijXey2MOHHkuNQhigDb7bzynk+D6a1LQ1cRqBQrSd6qxb?=
 =?us-ascii?Q?AswDBbHIZIFaVNOjib/VduC6gy18z0lcLqxovl9x9cq3jUU4qbXkpF1/BEoY?=
 =?us-ascii?Q?gTUlye+jE0JaQHm82yyNpckWwzQAI9VKmUDDBmKWpY3pdaSPMgcj6Cfm5hHz?=
 =?us-ascii?Q?biyFEOn8fJ1t4kUI8ShSJudr6qrCv2GbxaVqUk3W0lVZVX1Ni3gdfmtiRShT?=
 =?us-ascii?Q?KJNc6+52Bm3Jmho6T9ORGN4rkNeC3MjbkDzADdKyzFIlFo3GIYIRAk4thDcL?=
 =?us-ascii?Q?0dXigBqIYDKulVYx7KJarRdx2S1p66wxn/1AOEuUP6rTifVI55HzKKJRhC7S?=
 =?us-ascii?Q?9oNShEJVV7huRqJzGa0cz3tngkG0mL2KyTMJUDPQkrixuX+LBjJBlSnXMGrK?=
 =?us-ascii?Q?tNaP7S8eqA2Q+ov6tNmtYHeyFqRRcCZnQw6n/Bne2Dq52d7Dk+2XWPa/jhyv?=
 =?us-ascii?Q?xnqiXjAoEO1GM7TNqYxoe4c3nRW5uZl7/gKxV4Bo/Z8rwoQw+8qeP6y5EoBb?=
 =?us-ascii?Q?mI8BDEYxwkSDE6HnxtTfkjPg3JfTnm4vUlJZ1m6093JL/yitUdYZJXLPHFxJ?=
 =?us-ascii?Q?KfjqE10uKUQoSFjPmNhJmizyzydO55WKj0xUJLvPBvsjixBCMxN+TFv+Pb5u?=
 =?us-ascii?Q?0qahkJZfPU/uU7RPJ6svtRv5h75KLhiC+gP6PljF1OrbLlfETwrKCt+Kljdb?=
 =?us-ascii?Q?Ph82Xfq8+C09K9AgMNRNxGEQ8mhlwMyViNQyFmUYnhJn1420secIGaUHl2af?=
 =?us-ascii?Q?rP5hKp6CbS8BDfo3QFNwbUJR2xnazMROOKLaadDeXnXgFc2YmhBkqvoEM1nm?=
 =?us-ascii?Q?MwBnKDIcg/aXnthjjC1D3Zz/GVbokPHnKAvXkSIrG2tO0z2w2CLVMW7Ib/5e?=
 =?us-ascii?Q?tND2CSDfiik7M48beB5L7+ovsPiMiZhCht2ORGTLjOL7oEak7zrZAF2SHI39?=
 =?us-ascii?Q?H6qAcYYIrRBEyGEWLQFZRhtDCsj9itFpoenEEtTr0QnL3wIfdEahcI5fpSHU?=
 =?us-ascii?Q?D7eZeDF8mLY4BGCptMKN9WXzcp4Kgk/+uPyWJy8a8T9U30wV3mN57l9gYfJx?=
 =?us-ascii?Q?a2vyNp9q46LkEhLZrpRngLSwEO07ujEIYc99/hg0NcNhHyAceG7948JZZnR2?=
 =?us-ascii?Q?sQBQjYuXCaIemdFPl8nWXxKc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecd6201-5488-48cf-d280-08d97fb3d303
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 23:34:16.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alamb9KEsLX2oX0ss4T6ozie7kDLgv0nweVQBBdBdlFcBl8EiZkUkg3R/9TCuvPxXc6dNZE9MJ+UHdz0UqLolg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5456
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10117 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=987 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109240143
X-Proofpoint-ORIG-GUID: cWH5M0cJzF-LVfGcjKsx2omx33n3rR_I
X-Proofpoint-GUID: cWH5M0cJzF-LVfGcjKsx2omx33n3rR_I
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The nr_cpus = CPU_COUNT(&possible_mask) is the number of available CPUs in
possible_mask. As a result, the "cpu = i % nr_cpus" may always return CPU
that is not available in possible_mask.

Suppose the server has 8 CPUs. The below Failure is encountered immediately
if the task is bound to CPU 5 and 6.

==== Test Assertion Failure ====
  rseq_test.c:228: i > (NR_TASK_MIGRATIONS / 2)
  pid=10127 tid=10127 errno=4 - Interrupted system call
     1	0x00000000004018e5: main at rseq_test.c:227
     2	0x00007fcc8fc66bf6: ?? ??:0
     3	0x0000000000401959: _start at ??:?
  Only performed 4 KVM_RUNs, task stalled too much?

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index c5e0dd664a7b..41df5173970c 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <syscall.h>
 #include <sys/ioctl.h>
+#include <sys/sysinfo.h>
 #include <asm/barrier.h>
 #include <linux/atomic.h>
 #include <linux/rseq.h>
@@ -43,6 +44,18 @@ static bool done;
 
 static atomic_t seq_cnt;
 
+static int get_max_cpu_idx(void)
+{
+	int nproc = get_nprocs_conf();
+	int i, max = -ENOENT;
+
+	for (i = 0; i < nproc; i++)
+		if (CPU_ISSET(i, &possible_mask))
+			max = i;
+
+	return max;
+}
+
 static void guest_code(void)
 {
 	for (;;)
@@ -61,10 +74,13 @@ static void *migration_worker(void *ign)
 {
 	cpu_set_t allowed_mask;
 	int r, i, nr_cpus, cpu;
+	int max_cpu_idx;
 
 	CPU_ZERO(&allowed_mask);
 
-	nr_cpus = CPU_COUNT(&possible_mask);
+	max_cpu_idx = get_max_cpu_idx();
+	TEST_ASSERT(max_cpu_idx >= 0, "Invalid possible_mask");
+	nr_cpus = max_cpu_idx + 1;
 
 	for (i = 0; i < NR_TASK_MIGRATIONS; i++) {
 		cpu = i % nr_cpus;
-- 
2.17.1

