Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A06460FCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbhK2IPa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 03:15:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2070 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhK2IN3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 03:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638173412; x=1669709412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uhSrUriLbyFQbTAeFs43ljEXTuTcyrvJpOMir/ZgVhs=;
  b=keUs9SnIxgV8qeuv9YBcGrBbn89HwQnSv20qiaw9uRUb/gKyxfj1w5Sq
   ji+H1/r1FLx9mbMN6m0tdbyjkSo9Dbv2wWrRXBy7lIHVKoUeC9re1c3ZS
   iJlsEnx92c/ooxGKdy+sB+td1NZVW+UiddBB4Q5KoSB0XbRQanp+mKNl2
   MCLONTpqnKDzUbXiXBA4LmBruxjzabKz9m3ujFGbh4ZL1CmpO4jploqZq
   r40bmsCEKmRwQY/gcotLMunqEXiFCLFH7ZgmzgY0RkL/3fQHvSMs6Jz8P
   wQWD2SgJ9vnAr0+Q1i0rNFZ3zWtH2ooUbW+FSSjlLIrtZZjRH9KK0oIJZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="290889291"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 16:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFS4CgAaKOAsCZ3qwpbqWGHz1vjskk6It48ZCnvqx2uBF3jxNmBbAocqvQHpcBHcBTJdOYhDecszYny4VX2LVaY7l9zadH2K1Z4uDLCPEXxxHCSQFFVrvCw1DMfvc7L/j10Unsopu1HXQRYjRAMI+eEJX35Kq1r+S5DD7xPYxDg3D+88L9Q5kKpHtvuB+u1CSf9Tym7Qg3WnHs5DYNrqaQZ8JkQeEFMV/qcIYoWKKsWCvqDIgG3EU+Hp99tPmci3djooXAjH6gT/tfk09ZZZNw88azSlfTbjnoavHjG9uqPO7QCZAOT5WRpr8oOhn0kpzrrtKjlENS/30GxMY18dNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e60AYznLdB7JPUqnWxw5ZdvosivO16WCESDdcX2+DYo=;
 b=OEPHbmuBPIa/Z+cGw+CpiBWfWMpkL55nKlM8yOb65AdwLC9hGuiTiUk+HLBf0kJUR5/6b7py9kDWsrwQrfWI6jZ7Niqz8Bu8SFHTA9xeVQ+S8i07liOQcLFHiFTt+KsyMA/YDQFfryWHKJn0m5hy5l/UCYfdwQbT+gatBpog7RxBLu2+arrcSCv8rKzD+78ohFp163eU/cfnVddTRFZjUrvfmDH9F7N8RTxbWD6+k5OHlRo9a4E9Myh3ST417glVKEYuRLMh5vaQNiNgJXrsz47nKURaN/RYh/AXQMzMW7d3vtLN/5jy1e1td92VqBemd5ibFR5kaUj2Ex2MSSjyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e60AYznLdB7JPUqnWxw5ZdvosivO16WCESDdcX2+DYo=;
 b=e2qOiA5vDFcuDgQ5If61IRWhZZpfirTstw/oXRvWwRfpdPL/syKA1gVo3Rhp/UMv0oPt5Xyw3narJV3MaIVPKy5PjeBUvL+QGDoZVCS41COSYqvNG1AbuNresnqaeVVoz64/Q9ipoQ+vwrUXSp99FLe5BrqgQn6yT6EK2reFs4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7796.namprd04.prod.outlook.com (2603:10b6:303:13b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 08:10:07 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:10:07 +0000
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
Subject: [PATCH v2 1/4] RISC-V: KVM: Forward SBI experimental and vendor extensions
Date:   Mon, 29 Nov 2021 13:24:48 +0530
Message-Id: <20211129075451.418122-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129075451.418122-1-anup.patel@wdc.com>
References: <20211129075451.418122-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.167.150.114) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 08:10:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc3ddd44-703a-48d4-3feb-08d9b30fa7c6
X-MS-TrafficTypeDiagnostic: CO6PR04MB7796:
X-Microsoft-Antispam-PRVS: <CO6PR04MB7796BE9C693664F275454A088D669@CO6PR04MB7796.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/wtt+0sUp/+arNw+wT44uRy4QcK8bj3KVpn8NiVIZv9zTgxliuEjUz6rxrHF6WV14bC4VAwLPqAAEhGjk5mZ2/Pngso0eUXy8IwGdwrekQGdZLk5xOf0gT6zBnSOHprLuKgV+Fq96pw1XIfYtB0wqaJ8yxvnkpy0osSb2rd8QG6sbCqIfoiWDKlHGoUj+STblWqd9g+ACtyQ5fa9mIbnOKJnW5Ml2xMIJ9FuKLkBFrPf9axXF5U/QhXhlp/Yl9qdZUwISsWty62Aos1ForzjBoWX+jch9zmUv7VkSr1jMc5S4qTmxAMWU/M4+NVgJeBeXwVYMewirAVU1F4c0pqhbUyKoRA9OpZPmyfSQFTIv6bLAx4+NHwy3xglS2/lRBPMlFw57J5x962QJFtYbuWTmokvHLBVGHCbl3B5OA/LZjHbirDVwYpVJfNZtd+BHIUviQcUYHSnPPYmLS3Y4JG4qFiS09Q2KBY7FN19+DvR85aQ2gFVHr9B/kPEP7y8zeCq5c9ZPaMY40ZFVhQ3RUTnrmBAEMuWxd7flipNdAmJAZPs2BjMT3FXzI+QEuJRS6hj3xH1nd9ch7CTWSwrgF1cj7aV3uwXeeugD6qNtk6TjWT2vUF+9HD3fHddWFLxbGhGFoDwXK1Nw72Mg2TkN1IkdDYY+PmuJ8BOA2Gw1eyIfoVVM5xpIta2tDo22H0XxfGZO0wO738tsupTgor+3X+Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2906002)(52116002)(66946007)(7416002)(508600001)(54906003)(55016003)(4326008)(36756003)(1076003)(44832011)(956004)(2616005)(8936002)(8676002)(7696005)(186003)(110136005)(316002)(8886007)(66556008)(66476007)(5660300002)(38350700002)(38100700002)(6666004)(82960400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCJIgHoaGIyIZqbxCgdmaKK9Xz8ZFxR2KVMH6Gq0KoUimjftG0pKMkO0yL3A?=
 =?us-ascii?Q?t/dc8ZljLuOx3mu0cOgzQ1ehS8rtx4qAHFTp7veSPw50aGI7v+cIr1J14Zk0?=
 =?us-ascii?Q?YFg4s2disxl1m4vDBfu/qg5fnapoLNlmHPOxnCiIMAdQdZVLQm0U3A/QLTz9?=
 =?us-ascii?Q?GAoyuhAfIucE6PQlLXq+9Da6XsPpKI9+rMhyLDWOrPDBXvoRM2vxT5MpMGll?=
 =?us-ascii?Q?lrCuUv11a/ZeFXg+av5FML+TvZp6/5XLCcaMCksGxrf5jwt1dE1pMnwn5nRf?=
 =?us-ascii?Q?F6q0T2t9lqMIbBX038XMn3X+yELVtMpCw27r7dIb3OpS2MSDqqjD5Ga8fITZ?=
 =?us-ascii?Q?3ujLXkuIUL8BaCYfeMIldBF4tR96Ea9QbAliJiy1U3m3+J4cVfrJl8ACCFWR?=
 =?us-ascii?Q?8/uuvnPkynKeMCstClU7sAQQL2LHDvYEeMZ62XRN1VxrB7pOxYLtIQ30p9JG?=
 =?us-ascii?Q?X1LtzQ9ghSAtHAczth9hGc4975XfyMMO5qTekgWY0yOEZ4FjRoE/cfRj6Wdu?=
 =?us-ascii?Q?9HT46YwHAkJSbNw7k0eff9Y0k92tkqWqY1TjXPfE8QFhoMiIiY03HtDAq3am?=
 =?us-ascii?Q?vTDYcKDlJHctpFHEVGZ3Bb+MhtYbab8yWivFNiaugrCLWVS9vJhNqQ2eIsgy?=
 =?us-ascii?Q?O/0hKixAi1z4PbLdOEoGCv+lxDTqKWxM3qSJDgJbcd61VaW6c1FfO2w8dHI/?=
 =?us-ascii?Q?15DfRMfAbbvLju1hnknE7xmuJ9ZOLWGgLoxvwoVwrCltTqpaaSBsTCVwXhXV?=
 =?us-ascii?Q?1b8YGLWOC7Rbc2CsxIvw4x31QDd0sahCQS2wXgLMbofTaqvMu/kyE4blqmnj?=
 =?us-ascii?Q?LYB0RMdTlJ+Qlnd9jy5KcErjSfgS2uyIb/VfRn+qpaTgkd3JL5bwke4L+AUH?=
 =?us-ascii?Q?uwXUzZwfSU+7CU9PwS7yzMV2uiDv0doXI3WndrN6W7n4Qse16i0Z89dSncFH?=
 =?us-ascii?Q?f2Nloa3nR97J6HZ4Hg1aD/23fu39qEmzMgmf5NNGV0uXe8j0d8cNqjcb7UzY?=
 =?us-ascii?Q?EW4hgVNqvkk8yDe4Zsxku4J70Y4zc1omg7l5Pr1Bu7qYc7vzdbZMHaO//2O1?=
 =?us-ascii?Q?NR43LNnCBq+yMa+OXWX6uOzXnjvRVfgE5WNVoVhaKj/WaD6kQvwVgRYz4ENf?=
 =?us-ascii?Q?KudW1y5PL2yeetFwII59pqhTSBnOMULDk2TSfZTUsn85g5FkjmhZXhwMb9Ub?=
 =?us-ascii?Q?1EB4XyLXAqbY4zu2I2IhjMt530aQcYNzbTl8ERrnLL65+hsBgq6XmqN1XCpA?=
 =?us-ascii?Q?Q9kUgh65p1aM94jfdEc9iZrN2LLN6uHv1GwG/4Ox+vNAXMDyW0tllT2XUeT9?=
 =?us-ascii?Q?ktlM1/F11n7Nkuc1eMPymtPRlWgN3WvlYbRPcmED437l4tTnY0r4JgLJgE7a?=
 =?us-ascii?Q?DtSBsPRp5A6vq7GN2pBAwvgyAiWWhYzPQYkw4indjQAiIQqTuODvVsWzvRXj?=
 =?us-ascii?Q?2Z5VRIcZtO/njaZHHvhKQas7yh5nySJ5MepbTsiBqS6y7KF7wMA88RHa99Qy?=
 =?us-ascii?Q?jLH938KsflxIAhyEnyyCpDYzxbgVdqCHNdg422HwIaFJuP1nlz7l2noLVh4U?=
 =?us-ascii?Q?UqTolEt3w6q5KGYomX3zaa7/QCufogn06Ej4i7Z6EwWN/2mOQ6sybAj+QITt?=
 =?us-ascii?Q?u/7ht37Kd9NDdDxWCINc+1Q=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3ddd44-703a-48d4-3feb-08d9b30fa7c6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:10:07.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlsX1Nmw2qXQvwYzzFSU2qWPEPAYX1QjEd25UTod7vhjyI3I7yZvTxalTbPSbkDQo4zUjJNjZ2rV+hkajrr1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7796
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
index 641015549d12..ac0537d479d8 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -68,3 +68,30 @@ const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_base = {
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

