Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BB47C030
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhLUM47 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 07:56:59 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47076 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhLUM46 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 07:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640091416; x=1671627416;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vCDR08EkVWCyfREMZVRbpXQ96JyqSJUHc5EuPrIA77U=;
  b=Hwuisf9cfXk3y3QfXO39lCgH1TGG4nrZAZ6Yf+iIq+hP71xCkpXLhDeb
   yx1ZeW4JlioiBZuq6cJIr6HZyatHoXTr9SMYT9n++8dH+yAvrdOJarEPb
   XrKGSfw2o8XyMUptxaowT6/lJbV/oPY94sN1MzG6QdCTkfvDcdAoiuQBo
   y2aCyroLRui/xtjwIWA3/Jd5s2QNFc/vCjA2w3mXw26O8MMARpa6Ff/BY
   Hx93TX0rHA9mgOUT4EGwt0NlvKMlqBDpIHJJ/5OoJ41Vgh5lNU990E/wG
   luwAWnEcJDvvP2pPl0fOyWDViqPoYPKrW656ZO4y+7fkSCa+n3C0Ehaa7
   A==;
X-IronPort-AV: E=Sophos;i="5.88,223,1635177600"; 
   d="scan'208";a="188760856"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2021 20:56:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdDyD5iRuqBlrhTnBa55O4R5dyR+aIHp76No1PKC/9SGYD9d3ZBA1YLBv02wlfM2iZt87/HJuxLJi9LW3WKHkGqfCOzstPkyWJ4P0ssNyeXkom3yMxOFS+D0D91VKdlfxmWDA9dGohVDpcDoW7NVnsL7423GgTQSFFeDcOh0+M+kOwe//eO8Ps7IwwAjUujdf8wXDtrs8z3w/G+Eih0FSXU8xK9cligyBkyLB7+EdALHdwPvmn8YKlvGPyXnnq64vzyH4zrvB7DNFwTkuuPljbyQj63zemK67DyuZdszWySzXZQj+F8JX1i7qZ5PNojeMY+k6x4a7wy8qvmYN+cNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ9bck7R1BjHfbQAj/TtWLXvHofTe1xHXbVQBDizXDU=;
 b=PSA8U8P/7KguTMEmf7G8R9mssRW109xAjw62UDdTzb4nLIG3bHoSBt8iiiPYdXEWaJe9YZhKzcovKuOFCf+EXo0X0Bvc7sLnz4Lu2DDRfM8JQQNO4cYILsrpjMFX/uVnSzZAjptqWlWHeNmHC/UDN33LhSGJhuHR9YVuHt+/Ow4FA0hh9zcQZb+7x0JeFe1fRpQ/xk2+tyBAS6i6LTxVnLqai8RIP2gBjHYb22JLyAka7QGpkJ5ho8dsVL8OIMRtaMoltHrfNCzMepTHZIB5pDKthv52lDLpay0m3C1YSnn5zXmQQtBuoPOTsa5IfsuI7Jh3u2hyl8+BPP1jfhhWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ9bck7R1BjHfbQAj/TtWLXvHofTe1xHXbVQBDizXDU=;
 b=BKLmpvWm0MjLttlhGN/LNTQFotE8YLvqBX/pG6+jukKLdbkMqGLa8L1+dpa52HKL6LeCkE7TrHbH/1f3RT+FZlStStNpxPu/5LfLUSs4i6/iK755Ks8E3Se18EE4jH4tt/WiKi7pNxKbH914VMfayJjQZWXHEpXIw41hJuN3gEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO1PR04MB8266.namprd04.prod.outlook.com (2603:10b6:303:151::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 12:56:51 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c%4]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 12:56:51 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] KVM: selftests: Fix compile error for non-x86 vm_compute_max_gfn()
Date:   Tue, 21 Dec 2021 18:26:17 +0530
Message-Id: <20211221125617.932371-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e5e9112-57dc-4a53-5e6c-08d9c4815b07
X-MS-TrafficTypeDiagnostic: CO1PR04MB8266:EE_
X-Microsoft-Antispam-PRVS: <CO1PR04MB8266A952D52FF08AA10ECBAC8D7C9@CO1PR04MB8266.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oUsnXsKWzpQLO7oO9KeURsqcx+5pwj+82MxQfePFytTkvXdhAIS2UwmwzezBQEYl3Uwy6ddiUC9CdvONcczVQbLzLM/06BKyHJ4rAAEnXgkKUKtpYbbxfC/vDpCWZB61Uops5n8/GHEqi67N4WsEgcnvyv2YJgyHdh2ZnyYoAsiipGHehcnCkJ/l25pMBGqOnL8BUwpaTZLxrL4vBNkRFieObbG2Nyil52BjsmVBqYf+3UKlJ/Qzd6i4mtUNYvu+h7dihcU/oqCp420CAf+OLaV55s2+3WYbsi2FkBQQvDXXU5uVSr3OO28MT9pk2gbAuU47zRmtYVeCuzabKMpWG2VmmSXNItQmr668o6/Utax85XmR2dOxPq7okz05gXrQXgqqKXHAZfh5KlY7X2giJmEnAFoXM45lK80O6r9Qih26PRJNkp1MCpfyDAnieFpyHq8c1o5EMymO1EnweZgreQH57x0fnbToAHxLihq/nv4qHX7p2DiDlHm+0ds08jU0vgJXe9zKJK1WnJoDg3i7U0jd/6eBeE/urUG/YMA+RLCgAHLCj4XcEDQqE1PV6zFNvYLmeYAjJAW87lHipoMwPX52CW3JpVVkyCiyPp4Bakb0TERx7RYhnIF7NFThq+ZsgRTWdrdNTP+4R+p13vxtOq4pwOWFNQSZOfrOUIkYbCv1Y0O7AYuCUYBA9pPaUY4kQGEkQupc48Hf55lNBcr3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(44832011)(110136005)(6486002)(1076003)(4326008)(316002)(26005)(2616005)(83380400001)(8936002)(7416002)(82960400001)(6512007)(186003)(5660300002)(6506007)(508600001)(8676002)(36756003)(66946007)(52116002)(38100700002)(38350700002)(2906002)(66556008)(66476007)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rug1//6RS0KglDChVEQzJuYKRyJEwwss1OBqh7c/FzblA25iy1f+Zs7lapBT?=
 =?us-ascii?Q?oBy/5uJ+Aj7e7PU2cb/RBmS+SIAyqE/0f2RXg72IcZNomXXnKJTK6UXzhLgw?=
 =?us-ascii?Q?V53mAbDC+Jd7dnt7Og79RfCz3+QunI1w4kfD+iH8GjBLap2NHSDx9pNNmuY7?=
 =?us-ascii?Q?Zed67u3Urb89e7hYxFKaLgR6HRnX05IbcSkODgg2OqYWNWgtDF6F1V36j2RZ?=
 =?us-ascii?Q?QU/TdwksZd5nlR3nuh/fBznvMsin1Pg9GgOPOKcbEzOk4V3visgbB5YDoewj?=
 =?us-ascii?Q?Fre+vEsXK8sTFceywildxTaqsptuRvufT7HYJSZofneuFURMNNKTXhkh9bLo?=
 =?us-ascii?Q?mD30KG4n60pBZyyTyt/6+Qq7eBp0D2AqSbGOh44xCroZ5jrjkc9m+b+B+LmD?=
 =?us-ascii?Q?ZsiI3qP2Q3mBJ+L8+KMKGA8ZM3IdLzIJXY87+DShqxmXnygAo63NESlngHt1?=
 =?us-ascii?Q?pUKFoaMH00QYptoETg8aRsh3aGwi0fVk3bVI6Pfh0rEvAt60b49j1oC8rLIM?=
 =?us-ascii?Q?jpfw1Pu7WDIINcGMO+gElWkHgsDZgBEuQ1Xoba1jVqiuQ3n4tgiH22M208ts?=
 =?us-ascii?Q?10T171Ufysz1x8ea/pt3ek23zFIZ54OSMvuzl8SbdIFOpueLStsG/psR3xUg?=
 =?us-ascii?Q?8HDa2NWP2tyKWvqvR2XYwU+Qwe2Efruu/SZFB/NCFAkeOFpJhF/QNsNDtlgm?=
 =?us-ascii?Q?+b8hoY6Kk/DS0cbZI9vmDIzs75svPzxunaGMTOyi6Yewv+BjBCtBtn8HgMZR?=
 =?us-ascii?Q?un7Fuw3iYHxWLurY+AZgw1StC4yXMVV2t9+BUu/zgo3HPa/sfDr4rIhRQBPN?=
 =?us-ascii?Q?QkmlwJGo1KHh0YydcEhY6nYGXFkyE6gNBMzxIR+CdRnuYCvnsxjx0u40Y2Xa?=
 =?us-ascii?Q?h1CxH8IB3g8N3bvE33PagmvPD8Je6WbRqyMpdPKBgg6Um1/XpxWiG3iJYZQE?=
 =?us-ascii?Q?Vne6Qt9lq4s1gPX1IxoZqVqMEddY9gx2woga4XTO/N/eU72e1DbilYmiozg0?=
 =?us-ascii?Q?PyGAXPqp1siGFA64jx0Ev26UmYHo6sW+0zdieqLomlknNCrQim+j26WYIfxw?=
 =?us-ascii?Q?kUQB19tVNuBGd4VECpupgkpFfJYgEKEbQpZRYzEtWxYRIH0xL5ytVjZcozu4?=
 =?us-ascii?Q?Gcmp5WcKR3D6tFysDa0ZGkrWtp50baDiZIYD+3miM6NYlzZ4KDp7AOyl70uP?=
 =?us-ascii?Q?06oBiorn4uZH/eenhV7zrvADF2rsyXTpO7pHKVwjLjLzydGSKVkwADAxByn/?=
 =?us-ascii?Q?7VeH2oNZogRnpFnN9wYiT9LNd4iG24PK23wjpq9fhrNCAyRJdtekFPOYluWu?=
 =?us-ascii?Q?0BNqYgHXiJqSlZwVo/nYXt7t9mRBisQqgh/PO3pPJ/IT+29X9S14ZgYcJJR9?=
 =?us-ascii?Q?15IXLCi0myIhskNzmq3cxqkl/h1kjwD0F5sL0ZJJunOwTu+TxkYglN6PdtZL?=
 =?us-ascii?Q?qH54BrOwjkeS/+bFZGyNFL69E/ELAPm7EL24iarCi+aQjjyURtie4FLK5nDO?=
 =?us-ascii?Q?wCNxDaO9XzNGv3JQ+Pj4OPHHlXmWJTLUMhBsIbsiYifmruVIMeQ4zRnxKwcB?=
 =?us-ascii?Q?YvsIB8lmCjkOXy0X6QbbKDng3aCUHF+7O+5K6OP6aSYhC7x8Xe5CExz6g6j5?=
 =?us-ascii?Q?q9wQ/J2QA9jO9qvn2+L9j70=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e9112-57dc-4a53-5e6c-08d9c4815b07
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:56:51.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Yl5l6TK+zn0mVHDrzRjqzlyJbaBFxvKW1d7LVrcaEzxCFOC58saKY4eAfCwwdgvmLoLnWzY/tPhyc95+q8LmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8266
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The inline version of vm_compute_max_gfn() in kvm_util.h directly
access members of "struct kvm_vm" which causes compile errors for
non-x86 architectures because lib/elf.c includes "kvm_util.h" before
"kvm_util_internal.h".

This patch fixes above described compile error by converting inline
version of vm_compute_max_gfn() into a macro.

Fixes: c8cc43c1eae2 ("selftests: KVM: avoid failures due to reserved
HyperTransport region")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index da2b702da71a..2279e340ca58 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -74,10 +74,8 @@ enum vm_guest_mode {
 #if defined(__x86_64__)
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
 #else
-static inline unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
-{
-	return ((1ULL << vm->pa_bits) >> vm->page_shift) - 1;
-}
+#define vm_compute_max_gfn(vm) \
+	((unsigned long)(((1ULL << (vm)->pa_bits) >> (vm)->page_shift) - 1))
 #endif
 
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
-- 
2.25.1

