Return-Path: <linux-kselftest+bounces-32851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D8BAB3553
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433657AE945
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936F26C3B3;
	Mon, 12 May 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HB27KsQS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62126A1B6;
	Mon, 12 May 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047210; cv=fail; b=dNWH5r/RFb/qB/Ke+NA7yhe48dGkmLzpnKytDhpOBaYsPwlmQNboev/EsLJut9tvZHMgIMfYMSDLK7ZonYDN3vvWqN2vdvWvyg/XvqxXWRdqK6wkuxcEIFOKLUPub1SXrh+UM0u+Foy/nzPjGxsiNmOw1FxnnrDIY0DMstcs7ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047210; c=relaxed/simple;
	bh=11GDX0nDrAnc2tEsgfJ0h4PzAyNRZXTBvRNzOxnLVOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBiwx5052t056L4xim0nMVGjHcjxRump3XJhSIu4qRnBs2cnLSi3jf/d65HRCsjstccICVoALCtVxPZVDRy8WGhW5UTXBPW7oZ5H5ZHnGI5MIK1kc5XHiVLOFhOYPA8fg3bUXGEyfvC4h13IrLyKMzvo95JgftwgiSZdry+rbP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HB27KsQS; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR6xcEDjb/Ce5zvPC+APDyPCZspUz1j04dRVJsgKuVBj/HPLDomWS0iuHTkCFIFv6FbnnRoLdS6KdPbQvYF+X64j1zvWFSNXUahJDugF9kBgy3tRAdlV2BIQLCge0xQsaww2Jvj4mS6JD5n/7RsRGYGnt1v7eG/UbrfGalTpxGpOJ99dUI8f31qC/MLqICI98BUjNTolg01tNnUzOHWiQ2jese0PXcgXDXXTAsjBbJivxx3Ab13ZYZC58wEQ25Wa2YWelhdW3SSjvk/DZ64HPXJoN/+9ufGiVAUh9gjd1g+79Uu0Wm3yjhmjJhsIUyH3t6/v8wJo1WPBC/abryKDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDBX9n25VVUabv326JYeYWyI4bJZJ5yE0NmcXzLeeVo=;
 b=IHsfHS/hkt3N7J3YtzX+HC33/Q4CXUAOW3I3Y8NHwF5g0n+gB3W995Ix036KZ69pjxRCrheQVJc1FH1C5DjlReYbr14b4+QlfRJazk9NwvMfgV6/CiOc3WEjfoAH7qenAjcVRlgNUlVkyvwg7AZrjDh+rLPoMA7IXLCtKU1ZjRAz1FhShHXtBhyshl9GHI9XcEe6UiSum/cE9buKdsitjeBAnYD4z2YPsEGlckdKVzNaUv+TkQPmQRMNq5Kb6RJplWmdanSHpcB1/27bYRALkYpomQQbDRirQsEfkALAWz6salzjx+kQqOPVwAA11j8a7Weh7nX5OQLwq+86d+jG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDBX9n25VVUabv326JYeYWyI4bJZJ5yE0NmcXzLeeVo=;
 b=HB27KsQS4GnDc/ZbffrY1Tdqc0+x7MgCYEhYOA7O8GcSXh3vSbl0Ksikdmu/etXzuWqidKi+G1PkQDS9+XIir81PlEqp7S6UCMeTWEupIPFeEkWqtkxUCcwSbroTGzbs7/yNO2SxjNrsq8tLficVDvrm6dd+V+sQrK3sLxGjKko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:20 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:20 +0000
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
Subject: [RFC PATCH v2 7/9] KVM: arm64: nv: selftests: Enable test to run in vEL2
Date: Mon, 12 May 2025 03:52:49 -0700
Message-ID: <20250512105251.577874-8-gankulkarni@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6dfe8a55-9709-4cb8-41a0-08dd91433540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXhkrYVGm4noZWxcAqwlF+9KhBqa0ZkHGsUzLDhjsB+XVY+ZkCc7GAZL3sw7?=
 =?us-ascii?Q?YRe+cpHcdx9vkUdC4Tyf/OoT2sikfE74FcJFMeedwVxdAI3r2kAtaBHm05vf?=
 =?us-ascii?Q?EeMsY5MdDRqhVMnE+qAwqoViTeA1K58wAPhLnfDXDnOi/IeWg8SvXgakkB3s?=
 =?us-ascii?Q?jPA3jmcZ12rYXa63ftiCBbsY7Drf7DJdHgcEqLoyvVkePPU31K/BO7eM3oBf?=
 =?us-ascii?Q?IPwBDqRqLZBsxvHlQo69D6Dh1Ksnmwa4eiEORafRNX+/PARqnL4mzVBDQ36o?=
 =?us-ascii?Q?MmMK2Gs6flj0cW3jFtjMZo6RZuMPCXC5HnSZFmxx6GdacNd2hEzmePKbLpky?=
 =?us-ascii?Q?Vd5Kdz0NWid1OA78g6c3EL/GzmyZPEFhzAOA+VltIQO5I3BoNcRmBoT6+PQ6?=
 =?us-ascii?Q?bPSCpnmmI+kskE5ZBFeVzcnwRa/QY/8P0vau8JXeDrBYp5WrWSe/W+fF9kZw?=
 =?us-ascii?Q?R+wWddo61vKUmt68LVlTSfMKpPqbd3aDBGkp40FHTdWdd7h9rw1BQ9JAFDKE?=
 =?us-ascii?Q?hjgRhgcWr+ykYUv8nzj9lDE7YD4es1adUxIR1B2sYDkYyVIVfr00xchm2dF8?=
 =?us-ascii?Q?dKWtuVgL1cQ0wfArAM17bkmz1nI4cOK5LLe0eHuByf93O0/fRfXDgu+OI6lb?=
 =?us-ascii?Q?YQl4rED1XtDnGLW20U+WHlf3WsmU0+aq+oOsXRkBFDBAWK+9bprFBfZlBzzM?=
 =?us-ascii?Q?/9NZnjuwl5qQtq2mFUiGVbBUGvkKbSc0n7RDa5QJQWof7t97z1IIWeWQyrwj?=
 =?us-ascii?Q?rL8PXmQ5kFhhSzJouS+tYwblz5BAf3ymhyYcfq0CMrw7LFkxFtqKbUh5d1Ee?=
 =?us-ascii?Q?Ht3GXS80w8pxrqXlBUf36hMdjwoWKjzqeLrvo2UDQrhY4Yf0m1ti2UcQqBjd?=
 =?us-ascii?Q?V7kynGOdalgO8GWLtlDg34c2eck9HEv/9H/rjKPdwzoADNJtdMN3/LunYgoL?=
 =?us-ascii?Q?52YuIQT84sVFVljyVpFVfUgrcTdaUS/oa+PWi2rBnohiP1dT97ftn4yZClkQ?=
 =?us-ascii?Q?FG3Jq1cJsETNkfU8gMijJ8zdraSqb4aN5qW33vsst1YVbVl7yhFB2jKxUd+k?=
 =?us-ascii?Q?01sOHcuOkOpFDBrgR0jIxqp6wf+oqhf/vDoWhWDzi5bPndVWVT0vn9bpqcaS?=
 =?us-ascii?Q?c8pauJHulurwgt5XPFZawgXAP1Hxp9SLp5+xdKnmqNJGiinZ5WxQcUEneA2x?=
 =?us-ascii?Q?DAj1EUO5xrDPz+YHV2hUcUZhacJvbIvnpzsCPHOul6qLXOWlI+sBVuEHEFO1?=
 =?us-ascii?Q?OUDzep+Z3lsNLlVuDPMUeg0xSqLNSf2Bro67y8ky/dsfZ6efTWf7qOb/kcLG?=
 =?us-ascii?Q?IpJuCFlu0ZKvfpP+iJt0kV1SVqafwVHhlV9GW2cQekQ9T8FkHaIZIWKpH7o4?=
 =?us-ascii?Q?XZ3RvDrLF29BObdGb7rJuPonRuLakKUobOT+Q026Ajf8I0Fqbp45vStJ0kG3?=
 =?us-ascii?Q?MJN3pG1sToz8jvRfW6rS7hGHU03L1yp9GcXFESAWXLPrka118frrug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiCgktqSep2wLYCZ90+OEt3FlGNWbf2i+jt2IXWzuU1k8+58rJkCouIGwyxW?=
 =?us-ascii?Q?+Sl5jIS5Hg/jtqAoZpv5/StSf+iEefGa2R3iKEoeMyW0O0TVITG1iI2+EIg8?=
 =?us-ascii?Q?GVNc0ORpZLltC0QKuZ6KyTcMn0NI7M+s0ZMCSBCmFNFiZQb9hk9lptLK84ZQ?=
 =?us-ascii?Q?WGRG82dnETNczSpUakSAjYiMpx3809XEAiFiBnUuupppHwOugRTPq7YwFWd6?=
 =?us-ascii?Q?GYminRWt41H+LdAd3CHt5IAmkgmrkPVHwhzhe2/mToZ6tKy9veg9fA5XBOn1?=
 =?us-ascii?Q?SWuZEJR6cA7yUH8V98llTGzplNkQJwtAzzycx+4v5uPnmMYlcexG2PQicPWw?=
 =?us-ascii?Q?jQ7Nney/BT76gWbYBH2mPfBE+0ZWPlRv6OKXFN8g67CfbB1M5mpCd8ZdvNKm?=
 =?us-ascii?Q?NVUzWksPtl5M8EROoIX5JvF6wBapO66zBOIxTZpF/vE6qHqSNWE3vzSCKWJr?=
 =?us-ascii?Q?H5/d7WkOTv8OBYK8KO6sZp0WdSN3zvhiBUUO5VVL2CCmv03fwMs733HGuyFS?=
 =?us-ascii?Q?jlAMULvb/LXGFuA1gPqOMm4/vPLk3Xa/L3KIw1OYr6zFvmI9REIGFemzQH3/?=
 =?us-ascii?Q?FB0Ou67S0MNuGSIoDYTY1p8jdqY6292Q8H7e+cCC+ITl+N5hufl5cFuOtout?=
 =?us-ascii?Q?V5zqdXB35cXztTuKPjWlxNR3uRwinyHLzS0SGRhnQRpjwcByLJX472oebhiE?=
 =?us-ascii?Q?nL/xijRQgGOvSaFjpAgLWqpS/vzHlUSIFPyC4ABXx+uhyzRxvi65LbVreyZf?=
 =?us-ascii?Q?+w5vQ9gixVihc76zAbJX2Vx/xRok5muv4WdsI6RirR1G8/L6/BCZ46RzAHce?=
 =?us-ascii?Q?MmyJitqe6ODgAmptpsIAxAgIqivDkWL84FGpeTfiJUS/YWt1m6Txi4LgrWHx?=
 =?us-ascii?Q?clNA4CTDt5quKgZgYgmIcbmQnejsWfpMdLSs8jm5nAY9Y7ZVw303eokUtxoP?=
 =?us-ascii?Q?CcrsLrifnXoOKJn0H31GzpSf9ReKUWhdbKr3hmYSDDN2KqHkl80XgCxzomTE?=
 =?us-ascii?Q?nX348KBtaFz7fSEFvJ5t7bZtJV0IKvbIOC0A2p5k/7+g0GmfVeP4+E3W1sN/?=
 =?us-ascii?Q?RxXnRmgx1hflI8eWvvhn8mYloUvkkxbBRQekEDdpKLl7HHQ2NllwsKBfafCD?=
 =?us-ascii?Q?lRUBVmejtp5txGejfpSm3mfeO999T9RcEUivjXitUrI80u2rHT9IwyKnVKXx?=
 =?us-ascii?Q?/wjfbgMmDJoxMZL8Bnif75nGeBoQPhFas/5WTHr3n8blKLLlcabI18zKtII6?=
 =?us-ascii?Q?xUM3aHFk5paqLqHNCU0yQkjkhyDB917T8krGaq7hxKhtxauht3eClpomxYGK?=
 =?us-ascii?Q?a3rnG/2MTyWFzISGg4e91SUQa8PQtVPp9cI/DHz4Bba14fGQyoRVyk0ddD0a?=
 =?us-ascii?Q?HJcfrort2cC3aizJDXbdUNtUbVhn9MCNx5PP+Yueh/2jpBMU3FO2nUijMBfs?=
 =?us-ascii?Q?/c39NC56Oy942mShMak5bfD1xx2YbD/L9tbBbLWCKLSaWYfZpmmJTYr1exli?=
 =?us-ascii?Q?swHodWBN/kJ03kYmJZzORI/aLeytoFG97kvTWhdXcIkRiT9bbsJKyvIpa5cG?=
 =?us-ascii?Q?zf8ncYevpKn83Cahjzybq5rdfZka9LBTFkgrVZIlfXdp+hdY7KVEdmu0G0/l?=
 =?us-ascii?Q?Y+Py1KPX14tnKjznoJnwRIpPCRPa+lSfyw0Yg8+LaUi2?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfe8a55-9709-4cb8-41a0-08dd91433540
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:20.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcNYSqWofyZMhnBuN/W7VlsTKSHKgps/eF0W4fLMmXTTIzQJVbZTRL7uhF5rrY0VdgyPeAoYSVo4O7mFl8Qw0x3TrZRkyO0wzlPBmxDyen6yzh+Th0GsZyVa3PEnp4Ue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

Modify the test to run the guest code with NV enabled.
Added code is only applicable to ARM64.

NV is enabled using command line argument and it is disabled by default.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../testing/selftests/kvm/guest_print_test.c  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_print_test.c b/tools/testing/selftests/kvm/guest_print_test.c
index bcf582852db9..4f786b88fdbe 100644
--- a/tools/testing/selftests/kvm/guest_print_test.c
+++ b/tools/testing/selftests/kvm/guest_print_test.c
@@ -15,6 +15,15 @@
 #include "processor.h"
 #include "ucall_common.h"
 
+#ifdef __aarch64__
+#include "nv_util.h"
+static void pr_usage(const char *name)
+{
+	pr_info("%s [-g nv] -h\n", name);
+	pr_info("  -g:\tEnable Nested Virtualization, run guest code as guest hypervisor (default: Disabled)\n");
+}
+#endif
+
 struct guest_vals {
 	uint64_t a;
 	uint64_t b;
@@ -192,7 +201,30 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
+#ifdef __aarch64__
+	int opt;
+	bool is_nested = false;
+	int gic_fd;
+
+	while ((opt = getopt(argc, argv, "g:")) != -1) {
+		switch (opt) {
+		case 'g':
+			is_nested = atoi_non_negative("Is Nested", optarg);
+			break;
+		case 'h':
+		default:
+			pr_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (is_nested)
+		vm = nv_vm_create_with_vcpus_gic(1, &vcpu, &gic_fd, guest_code);
+	else
+		vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+#else
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+#endif
 
 	test_type_i64(vcpu, -1, -1);
 	test_type_i64(vcpu, -1,  1);
-- 
2.48.1


