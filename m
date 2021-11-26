Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1845F0E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378210AbhKZPqH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:46:07 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58042 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377972AbhKZPoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637941253; x=1669477253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Tjwhc9vT9WwipkcblO9vU5OVOm5KngnEVoNyzcLRv7Q=;
  b=AES9DsQr9zw1KjxdrVbvv/20tZZyBgwwVAc39klhyhTjSU0AkaKgmYht
   gpIYfc0ugx5sua0rL/OdhkDeHI+/n4SOg8kmPADelCPMg0A2qJQsbtj5q
   xHNyzYagkchgd8+uPFZw+ZJiOuq/l6Ksg/cEZRtLRAo67Q6Q+02Uz7BxD
   lWDZ4lTcOB4Jz1dDj7Oi2SUZnfdxIqTxEgh99FW3ZN3wBr2ZLGxMa+IQD
   TnSQGCnaOw5DAYguNcmozSmS+qK6aC0ZZGxQwtaNzK4OIgqLBqMhnoxZ6
   kHTyGC5CVRsWyePyMJmW3fqFwuyRR3KsXdewFOpJ+QyIW5QsYv2+a/VRK
   w==;
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="191541491"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 23:40:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL31VKvtjRRCjN7coymTCBuNZNU3Y0LOd5NZa67IX+vHwQbHl/L8iZsMxZQEufyhIuVM+gOgkYiuHduy4cYKtQyPG13H4G5UjboZaZU924MloLqIphYLu/otqUHWacrR3Prknaf+YBCfrJxfk/SR8vg9BOtiFyI11ie87uYaO4sf6Npa5IIBmzKhxN/72v1BTTHYlpdiyJrfN170qGyi0yZcbKPmvdaG4NKMsFcEDHxivy93o+8tBITFWduQKvSw0/p9hf77L1qLm47lqKLJFOg6RzGJl083AJ2syg8USsErZtxyEhvBAQMZFVdiySTc3NsfBmDKjSf6+FUj/UTYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd9LQ6X6JNI7eUzbXun1o5KucUYoZhcWgu5E0Vf4qJI=;
 b=ADvcDtYVA4LtpzAO/fHmN/KKK6GOilyIWotg5H9Up4QsnWrF6r2jKD1ZQYJS04wutSX/sCghW9RJ22nnvGf9r+DxcELlNlM+NXpM0DanIseN8Odv3BhcdzhlWDKl3pNCNKNTfE299PxHSQ+MYbF/KPZsf35MoFAQGFH9y2kdUAUJM5v4fSm1I9OjQp96GwQQy10imfJ2vQFgB2PAUhdd1MGAsxg9w3eSTIhUpqFGJRu505o/Mmrwy7jA3TvjJnzg5dv9kUhLyOroV+Zj3iXzbW0I2rXUo3IpzEdWwoxoLg6GHWHrnXXEEI/oFWbYr4jnKtgNe3K0jOCpvUuBhMQELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd9LQ6X6JNI7eUzbXun1o5KucUYoZhcWgu5E0Vf4qJI=;
 b=oeHrddYFkRoVgHVwBZN2DlqBNKLg7TjGp0mKJVFYaSxxHwKl1+4udTTHrWu4PIr9Cm27rbp70C1HS+zDu6rxx2uuIt25VtgpP90vbgRICb3o70g9BKhtl0ga2q+zfPj7Rc6HJBWxH7FSzmDz4QgUzHrTnSXkBC/0aCmreSmXl3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 15:40:53 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:40:52 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
Date:   Fri, 26 Nov 2021 21:10:17 +0530
Message-Id: <20211126154020.342924-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126154020.342924-1-anup.patel@wdc.com>
References: <20211126154020.342924-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.118.153) by MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:40:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd523a92-3274-4070-64b6-08d9b0f320c3
X-MS-TrafficTypeDiagnostic: CO6PR04MB8330:
X-Microsoft-Antispam-PRVS: <CO6PR04MB8330A5459CB503E3F29B3B9C8D639@CO6PR04MB8330.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY+pjsUR7o1dbDgZtIvPy+0O0Bj16wH9BdvG3B+2mnv1hcPZm6WZiAJZwJPF1w2YIjLnH/DHa7P+n+Mv/vnwmt/l33UUznv0MUWY++0Eqf4sajJeljO3ejCYyKXnhVm2mLWVhsHuM70xWWa4LIG4fUPtdUBvqSrwzw7g+Qineetv1Uuf/9dBolVR3b/uBLH8WNXXfkp4bDv8RbU7+O6suz96OzbDJVYV9e+cJlR4I/iOJQzJTktvuoxPS+craliTf4qUV/s7Sf03g9xBZRLvBiWdIwZhDU3zUxyng2LT57hhuTaxB524JpjzzvazYqn/FRubPKleMlnotOJo4ARB7QHMiKiwgi8bNDAtfaYKCCuWzdcYxWweFigYVyyandXPSatmw4Um01SuhGi6+6AUm3/amQoFOLs+523eI8OCg9cgodYvt6d1AJBrHjpvbQ/NobnwI6AQtDd7sqr80S6fGZdYp0LWE0o4NHIQh9QgK+nQC0N5faMVG3UMh304/y1WqlwWYdZdCh0u/yW6sIgvt+yVTmC/aOdiQwbQRTDdyVqk7VgGmzeZCMfyUOHFR2qm9VBKqiFS9vM6GK/DFdQFykxHs7yyMfeYHFUq69Ogc9CLXMY0BwLECCOKzWIARuKznsFb/mJeCzSZK2att31h0GLkpPD3iosmB43BUo+VvCI16fnx1SclWjx3adywsQoJo4V/as67qXi+k3A1K3OAVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(54906003)(66946007)(110136005)(38350700002)(82960400001)(26005)(66556008)(186003)(44832011)(316002)(6666004)(86362001)(7696005)(956004)(2616005)(7416002)(52116002)(508600001)(2906002)(5660300002)(36756003)(55016003)(8886007)(38100700002)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wYXltuhYpUL6ZAYGznhd6K4MDYnbBAbJX6xoOQSJfgCF9zx5DjiN9YVxWtf?=
 =?us-ascii?Q?oBOG3EHAsy57RJq+wqQyOae/k8tDEdXfvX0/F74DBDBWyXiBrNUGzQIcN4Fe?=
 =?us-ascii?Q?L2NcFZu/qVALusxbxT+Osy/XJcUN6Oj81QBFkcv49OPStrFFP2Vl+Xj2pedH?=
 =?us-ascii?Q?acL3w8rMPRdppnJSXwQUpe0A9wRgBuCAcFFvY1Y5fKrPfcTU7D66nYnjX4Vu?=
 =?us-ascii?Q?VwcPXKMBeM6Mln8GCM5e5gkEa0tTHn4R6K8zaMN/dtMEXT3a99HYhohdtxt4?=
 =?us-ascii?Q?m0K5hD9NBXojXVvhV9AtlJE27gL2/sjifAYky1w8rRljiqzyPzFVz1Be8+eO?=
 =?us-ascii?Q?E21ONkX7hUTePPxQb05qVCDf/7pUwswEYhho/xzB1yVcwJs0b7traEcjYP4p?=
 =?us-ascii?Q?2zER3fCptJLUBQUudGscoRWY8m6TXiR8CChTFuZRkeXUtvysNoHzwotzC266?=
 =?us-ascii?Q?7LrdSN++dBtoNeHeiwONQh4163Ms7zlYZ/VQO8KdoQ4Hckbr9hTxnR1w3lne?=
 =?us-ascii?Q?uLofU86VQA/FJyy5JY00O8xpe9smgXMKmDV6Y4F0ZLCHBGbqCSETRYgArcQE?=
 =?us-ascii?Q?Y09Zd8qq/76WB02+IE+UjWwJxHrpJbWmK00NDBzQQ75KA19qeR5IUSdig8BT?=
 =?us-ascii?Q?A6nW25CL9gh2UE0jvV78qGcyiOXnJ+EE+H1aQIJbfQcKgSJuowTy7BbnPZ6H?=
 =?us-ascii?Q?SJIbL2tlCmurPKGsleqJeAWZVXpXUqYrIcafLS5/+LRCgo6B008YdPrBDUK4?=
 =?us-ascii?Q?JezMbcr/g0sKgysjFzohcRVHswXtIHw1Mkml83h2XS90qO/Uag2QeSYbFInY?=
 =?us-ascii?Q?On9p7jzWMT7QRDlNWyv/cQ0MYm+xq9mUnQBxrJxu0LvyQoCDE0MnQAw9Wggr?=
 =?us-ascii?Q?n3kLpxg7u+IaIrk4ubCjPFQrZuGqDKFEKvkcMK5isRP4rsmsH7oH9seeBgpf?=
 =?us-ascii?Q?6I/O7rq3BJA8rtQ8/swhsH8D5novvZQxSa++cr2bbhlMrNO6+HC2/r37jIna?=
 =?us-ascii?Q?azuF3jI5QqQksesjuXHvbdBUPKi3TjWIBPl0npy9CqMXCFaadx79VQmbxbRn?=
 =?us-ascii?Q?fhpt5GqdtYuVYIl9NihVPGXMrjZbbbwW49LHWfNF96DZ1sTMWGVoux9EhXdP?=
 =?us-ascii?Q?ElFAAhztaLJYZbwuPZs29PNqsFoPQwLkivnrwF/dl65Gx9cd6HCggj+9N9sr?=
 =?us-ascii?Q?8PQK0x1uDndy9U9sf8YC1wXZgwNCr3voNDyOHA5MZI3XcfGBpisbnvTOkD4d?=
 =?us-ascii?Q?meH1Gnwx8nI8piCnxP76N9/4xG8+BqfQjHsPJ4K7WNWVbCtzQDv/kPVvLPVO?=
 =?us-ascii?Q?9OUyrzy95IVDn7fplrQlIpkGjEHVGBhOZhyQQzIKiwzFM4nq+7nEYphapITb?=
 =?us-ascii?Q?HsVHZfYBd96hFaehntMYPSL0+FFvwVRX3y873dlt8d/ijwTaVmroGPL7oGhH?=
 =?us-ascii?Q?cS1KSPZ9VkeejSonnjnl7kV7iSDDhYcBxoHNGPN6/FtpnNdlZGfWxLDw2w8P?=
 =?us-ascii?Q?2zC5CwI8S3TF76XtdzBtZXx/bzdd3G1JwrH8u7lsgWt8u9N9yHjQCrDxYbWH?=
 =?us-ascii?Q?ZuPRsMG5cJFIa1Vv9HBb5sVJOzTuWho/3dnbf4WCFuzpmdAlY+4Skxw3z6X+?=
 =?us-ascii?Q?JrCRwgR/AxOuJEgvqwYd4uA=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd523a92-3274-4070-64b6-08d9b0f320c3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:40:52.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOEDVfuwnbwwDjBuapZT1Qh8DMcGm7XGub2+ydbM+fJbFQvwop2e9M0JEDlfBl/XGR4BKXJU6K3N9oJiDaq3Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The SBI experimental extension space is for temporary (or experimental)
stuff whereas SBI vendor extension space is for hardware vendor specific
stuff. Both these SBI extension spaces won't be standardized by the SBI
specification so let's blindly forward such SBI calls to the userspace.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/kvm/vcpu_sbi.c      |  4 ++++
 arch/riscv/kvm/vcpu_sbi_base.c | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index f62d25bc9733..78aa3db76225 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -46,6 +46,8 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_time;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_ipi;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_rfence;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_hsm;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
 
 static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
 	&vcpu_sbi_ext_v01,
@@ -54,6 +56,8 @@ static const struct kvm_vcpu_sbi_extension *sbi_ext[] = {
 	&vcpu_sbi_ext_ipi,
 	&vcpu_sbi_ext_rfence,
 	&vcpu_sbi_ext_hsm,
+	&vcpu_sbi_ext_experimental,
+	&vcpu_sbi_ext_vendor,
 };
 
 void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 641015549d12..2819c325f471 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -68,3 +68,30 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
 	.extid_end = SBI_EXT_BASE,
 	.handler = kvm_sbi_ext_base_handler,
 };
+
+static int kvm_sbi_ext_expevend_handler(struct kvm_vcpu *vcpu,
+					struct kvm_run *run,
+					unsigned long *out_val,
+					struct kvm_cpu_trap *utrap,
+					bool *exit)
+{
+	/*
+	 * Both SBI experimental and vendor extensions are
+	 * unconditionally forwarded to userspace.
+	 */
+	kvm_riscv_vcpu_sbi_forward(vcpu, run);
+	*exit = true;
+	return 0;
+}
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental = {
+	.extid_start = SBI_EXT_EXPERIMENTAL_START,
+	.extid_end = SBI_EXT_EXPERIMENTAL_END,
+	.handler = kvm_sbi_ext_expevend_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
+	.extid_start = SBI_EXT_VENDOR_START,
+	.extid_end = SBI_EXT_VENDOR_END,
+	.handler = kvm_sbi_ext_expevend_handler,
+};
-- 
2.25.1

