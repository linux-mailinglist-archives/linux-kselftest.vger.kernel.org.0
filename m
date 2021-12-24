Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC747ECB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 08:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351858AbhLXHgn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 02:36:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38711 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351823AbhLXHgl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 02:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640331401; x=1671867401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WTVVmJ7Fv35pcURCNVQqzrFpOrmMdxl3YacS1RjJ8/8=;
  b=akvRCmWYxM9w/Y4I8/PAJzWDt2bXEYmeHpuKHCJ2bDAsTnHwACU3FiSw
   5dq3b691wonqvEndw0SiY1zemcN3wWmtAOJWcMW1bCo9j6C0/ItfyTl+x
   b+YylAfJyC761NeTlmk3fvk7o8ZjwOFeo21HnxyJTMAUqzGFCr0rT0sI+
   bpQ5JNzLeOKZZCqsx13MLOYfj9DW5dppr8+YYmbCy3kT0befnK6iIS31s
   D7yzh5BD1MSrWg0bpODpmu6HgbXN1URU7PG77juizrk7bH0cBXKFDlFQz
   NT5VvNOp2OMQihT6S6YbBwPGnKwbumaVV1gowuE4qCDbU0JwtjwVUuUDq
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="293035147"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 15:36:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl/GRpXq3hdZLJKsasCgVs0Vc8W7NrsJB55G5fkxYIv6mR+TknLCdw2X6SWrpyNAioabxpeq5/p0TKkfv2sb7lP9flTwAUndbnJP5/EmqpH9AXTgaP5he9izymz5O3R0Ne2bAZIS+gkQkVlTEx73Y5LCOkNT8yHxQmV20pds/ZSG/6j86DfSxjvmzUSGZMiavJvtvUoDei+sLudmCv6f4TCnYpW17jWq+rGlbTLUYJwi6+nCKcd5Rqt3ENd00YPiyF4j2bauq3l+kse4E3ns1LIN5Qa+GqwCor+SDUBT3+Ixqni3TAv6WcCae4Ti1K2WyUtEv4i5oW5QHHMlvdEUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cioEYUmoe4aKKbK0CKfKbKJQI220pk7UiRPLMCIbrBw=;
 b=K5UiAnox6XEwqLpO24yj+dAnm9gEldvxUkXAAJOPTxfiW+2PNIGN7G+GDMo3iKMZ85FOARNb8Qkn55xWFMGBpXvvtb+kqzTLm11DzyypWotPSRMGBKR36mmeqjBXJd0n9tQqFmuvTUu37aPf+tHhRYPqGeUUV7YVDaGXwpwf6UiNkCpqHU78qbjHJ45tfzR0rdrkcN8yi3xUrKTXXhnWHw4Q+wUtdgETFvwv/knwv/ceBIto+G0wTuf955IZnUJEdDNUxN0bhi/U+bZyv515zw6oReehpgTxC92HEbIEsVKk2+A8zeF2kIzPppmQpc3s7ocoKbRi1rmc6BdXLbNoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cioEYUmoe4aKKbK0CKfKbKJQI220pk7UiRPLMCIbrBw=;
 b=iE+rc5SR7KFqUvS1L0t03N7/BJ36IT+W1ExYovI032jGvv279o9EaFVAHIp1m3ajEvl7903Av0udwSrsihJCvHlAwFr2JisN53DIk0pWGnWrLXfSxMMsNDlf5TOifGyGKpR1Tn2y81aSUf3BobGUV+asVrTCwUxm5ijU88r0wDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7859.namprd04.prod.outlook.com (2603:10b6:5:35e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Fri, 24 Dec
 2021 07:36:39 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c%4]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 07:36:39 +0000
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
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
Date:   Fri, 24 Dec 2021 13:06:01 +0530
Message-Id: <20211224073604.1085464-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224073604.1085464-1-anup.patel@wdc.com>
References: <20211224073604.1085464-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::35) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f93057ca-5c10-42c0-0820-08d9c6b01f69
X-MS-TrafficTypeDiagnostic: CO6PR04MB7859:EE_
X-Microsoft-Antispam-PRVS: <CO6PR04MB78598F68F5511CC81BCCB6FD8D7F9@CO6PR04MB7859.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DucyfrL1TorgDX70/j1q11mTf6jjqTHT4jKE9nReEDVn2TP9of+PwoZHJRuut1sva0jtVfTJ0Ddvl1vr7SKxd/YbD9b1w8IN+ZCzdyR+J7al9kzku9Gt1/XEuViZevgsbxdbGvKqqLSjU88zdpBPMflJyvyokTIJ2tgAT7ELR5Oc0ltd8POLznOkxtb9ndvAqWVXeNVCmaQM7oJtG7Iu7o8Uso5xm9qsw62Cg9hBEU6fUBFZlqMX+rDE7prevHkEcnJFtRaIluYrLcXKUhr9pFxM5qitH7hAjxJMZccjAMQ0YJB8XAEDBO2Jxb+sUgZfqCdgJTTff0F3tlTq2iji2t+RO3dzccFJgM0Xn1yPKVgagZA5a9735hYScVj6s7ZjbB565dyg4Te3sv0rtD+KETAtVN7RGnXjhMb3sRAP9Khmg5lWLJ+un5Qopnv5xAIRQGVcB3b6Ue1QCfrulXvYluj/HZ1bxj51yM5IFW+rWClTz4/9G+4RC3NyNDzwQ5LzQIpAfIdCE582hSxl02qoCqNCf9FTsCSKUvxnVDfkDCTH1tb+6hMtIA7MWhRW/PNsxyjfZH+k2tOIDD2Xq/SBLE7mJMdb2beL2CdQb6vZZez9ODD+QQfOnOWq4SQ1Gv1v5AkVMVesFdFd+j99OIfmoXsPK0ncMuz6dBZ9DHkXbi3VOMiOpxBQDW03b/TJs0DDp7HnoI5iPBC461J4FBHQCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(7416002)(86362001)(186003)(5660300002)(2616005)(4326008)(82960400001)(8676002)(26005)(44832011)(2906002)(8936002)(6506007)(508600001)(316002)(38100700002)(110136005)(38350700002)(54906003)(6666004)(66946007)(6486002)(66476007)(1076003)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5oHMc9NFJIvBsm+0MFGegJfzo1i3GdvV4IvCxAYImvEM9ELGi5sFKIxki09?=
 =?us-ascii?Q?VAUYmb5+iY8gnEOvfLnLaFSmGNkvrRLybiHgdWeNIDIg4gu5NqDtn6tzQ0Vm?=
 =?us-ascii?Q?r6kJU5IwTOUvbNd/Ivwcrspv2DQgPpSi5k01EHIvMt3eJN/Anv67/LsZWvPg?=
 =?us-ascii?Q?fAASa+F5axcaiT8MglY32upAeIJNjoF01KMErMjsI5baD+AgPUIOYzZ6oBRB?=
 =?us-ascii?Q?vXy2f8MxSjpA1PA5C8Y+ZflIXjjUK0KsjPyBmFNHwbE7ilyYSg50A0B3O7Xy?=
 =?us-ascii?Q?KS7jdMYHrmVf7o2O7cCQAXMymyoZUmlwM22X13HWfL1q29Tg0HNou0Bx1Rfc?=
 =?us-ascii?Q?6M7TwzftnLwDmaap5lq3aGRZWYoigxpVcBTh2arUclhiecTiZanhzEdoIpKh?=
 =?us-ascii?Q?0MxG2SmshkDGyG95LdSU7Smpll4FbYZVVVNSMzh0qdRjHzZ2XiGfgI8wg9Qu?=
 =?us-ascii?Q?/t+xbhxIbMpesDhq7dvG1+z8/1fsS8TAXnihgVz1pLTbP2rrDiqsU4pTkMXs?=
 =?us-ascii?Q?SVLZXPRUjWdHnD5ZJ+d4RhkL7NjUjmrJ9Bu5iCDj6/cJHDXviRh2pzjNZgI2?=
 =?us-ascii?Q?9W36dQOA8Qu2ItDRKCZH9vUWvtM05gzjnLW/BB/WQRfiOQ+WkewEXIFHYvYJ?=
 =?us-ascii?Q?r6OnhkqB5f+iEmqUrgCOJNAt8qIKGd6BHLNs8/h3tOclFcwFbGQPZiFw/4X5?=
 =?us-ascii?Q?0q4K45N0oy17N8qNGePaL2Bsa2tw35fdWIIbbyQmGMpnnU8PZwJZVm5knCPb?=
 =?us-ascii?Q?gu4hSVRjdPeOwssmKf3E4bYx3VALybRiRFvzYgMCbjZQWWrZOp07ftW7IjrQ?=
 =?us-ascii?Q?w9zxhEwtSKsUL0bzdKvXJDYQ5zvUyqMO1vAgt44TN7cmwxL3lMM+qrvr3wO+?=
 =?us-ascii?Q?HQNKZK1VJvkp+JSV1+N1Uks/9ImBeF63/YsfwLZGZx9/6vJLaJJ5Q5h+0EV4?=
 =?us-ascii?Q?FB5+Q4hoMZTDIr2ZVh9Y7O11D3leNBFSVO3kmTuNHknFO9PYfN3jjMDXbzqi?=
 =?us-ascii?Q?sAvESeG5r+TyGKYG9N3cWwQStL0kkzXKigcZex+IMjIV+niCXhYTDRyr4GCk?=
 =?us-ascii?Q?LpFp8SIjFocEGOZR6tAEVnMYppLFKu/MXdyQAJPeZ69LnLlQMK84wjCoYy+3?=
 =?us-ascii?Q?fh2G8RyYyjawyOIR8qiOS3liofUu4UvNI2lpyT7m+l3y3PEO4adeUJ1naClT?=
 =?us-ascii?Q?dolPnt3ysc4eEsumOeHfxCH/nAy+kxQnO0rduSajIoeLkQOZJStOwjHNtebN?=
 =?us-ascii?Q?Qljy9lc9+3xGoFNX+3JqLOWmESBscWmRwBWBkUDVU5MTASNjNooPrtQs+6oi?=
 =?us-ascii?Q?wU7V7MSW5OjlQMB+rVywKSqvqd/ih8K1S48JHs3w6hj3dk6POsJypyfq8O+h?=
 =?us-ascii?Q?JXFig9ckrb91LJZdar3YiTW7heAbrXWGysggl6gfn9PEbTImGlRTnvcbVoYW?=
 =?us-ascii?Q?dRVqGBjoFxpf2Fe4MeXJZKim7J456mFMh4jA7X+XH4H8PFV6Vgjg+S/Z1ybI?=
 =?us-ascii?Q?YoUfCS5qkMXSdrtQHhBG1F3wlkuu7ddfBaVdKcC6xwNyXygEAlsCmQBJvBAw?=
 =?us-ascii?Q?mg2/KXsWrvlKJRXOG86qc49h5BkBbowqY9zh+/BouTu1sSGRXddbNCZfJ1LK?=
 =?us-ascii?Q?uMB0rgTjs+VoJxVv8jRBQ78=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93057ca-5c10-42c0-0820-08d9c6b01f69
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 07:36:39.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VSpHcRa0hE5j4esGyX9xxRlmVVJXW9Zt4lnvsP8Vat4HwQSdVIextqBJsYW6w+6wqjLtxGmgU0Ti/FtQsnTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7859
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The SBI experimental extension space is for temporary (or experimental)
stuff whereas SBI vendor extension space is for hardware vendor specific
stuff. Both these SBI extension spaces won't be standardized by the SBI
specification so let's blindly forward such SBI calls to the userspace.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-and-tested-by: Atish Patra <atishp@rivosinc.com>
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
index d1ec08fe7289..4ecf377f483b 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -70,3 +70,30 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
 	.extid_end = SBI_EXT_BASE,
 	.handler = kvm_sbi_ext_base_handler,
 };
+
+static int kvm_sbi_ext_forward_handler(struct kvm_vcpu *vcpu,
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
+	.handler = kvm_sbi_ext_forward_handler,
+};
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor = {
+	.extid_start = SBI_EXT_VENDOR_START,
+	.extid_end = SBI_EXT_VENDOR_END,
+	.handler = kvm_sbi_ext_forward_handler,
+};
-- 
2.25.1

