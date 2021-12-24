Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01D747ECB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 08:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351837AbhLXHgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 02:36:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38711 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351823AbhLXHgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 02:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640331397; x=1671867397;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=okWixbzXzUx9k4JoQsJrKqF0jfluDWANxV1M9uKke4c=;
  b=KFeGbNOXz/CwjHY08b7z1KcX+1aAC393UIPV8yD+RMdTE4yl3ff9Rq0Z
   Qt5q7NKouOoxs61OZNA5IPxRsRAX6nDu10BZyZrIupPRLoDc9rFieHMh+
   wvmfCO7YlbKODxsKZj3z97u9+7kEL2GM7cIA5XPS0DVhJBZBVv3Zu2H4K
   ZeJg6TbUuiftikJW+4hY6LA4Z5RPCHbeZl/iB5IGfn4BAb4yP8ndnyBMw
   WGhsaoJEQhO11/u75iF0H4s4HxVD9LOnnuCyKOtj+GuTF67TArZvewJoe
   7ABVU4ywQJ+ZvD8ilXWf7z7alEckW8Dsev5+sA7gO7j92VyuM0om1kPe1
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="293035137"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 15:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEUb5PnQnoK//EjD+E9uoWACUaeKJlW/JQDdcHv/U++Ekad4iX+jejzkGfaIWrLnJPQ8WBRgU2kp5CSUctuuXFIhCS3eIN+JNg/zDhIJR/pgU7WaG5dgEHYs/41NoI3pBJ1NXx7gcDDLuH3OsEIGf1Zc/KKD26X8i4daUCDQBfVPGY9BsrDzwaEdEWRcdJdMd4pmFWsKn9KNsI4bb435yKWjyoebSPUiHtmr+h+D8HNL7IFCejstlQ6PJ459d5Ai8FTlizdkduygjjF14MdNaS2kMPtbQNLNDdDevSGZeKoapDr+lvrBvnvzJ6uX7DB4VGq402qJHjjOFbzSz1Dx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fCwtv3XMmxGmZinL3C3KePJkBFVnovVhTrtuAIW6jE=;
 b=ElqRFD+JO9n54RGkDsyCOQ3qM2HDnEqyVJk+xqUVYiO/9tma01o0hkz2cUOPtvAVMmCcy2ZnFhA0NCkNtddHVE5TFHaXqhX1eHtASP11v/elh+iysRhnvT0HwGN29yEEH1XyvxieMW6Ewlml6A4QhMUFlPb0P16dgjUrpT8I2kcbHXD31HYNwdxUKsOhaQjEwAd/GSzIn5394awlRiTy2E4qOIu5Yd/6K8q4hQWfd4r0yArA74z2vZU86MQdZi+O0CzNY1OsvNtrJHtx/yUfn5havlXUMJvzP9506pPPXvt1TLfzXzMvwMivEW1sEF62CU2rqynrC/PceftOQ67nyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fCwtv3XMmxGmZinL3C3KePJkBFVnovVhTrtuAIW6jE=;
 b=IUv4jVetTI5zzorI2DCGX5QWSMgkwB6qOBc/2GbNuPZxyZnD3esD9/oKuYOAvNvFTxAfDL7zwo3ixHbOj4lg2sdV2sBVywd3x/sei/5qSFxw6oQWn/syLSIAnfdrrAjp8qUzJTHlY9Cc09ixLQwyoL8hMst/ZZbwNGaGWUF/q7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7859.namprd04.prod.outlook.com (2603:10b6:5:35e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Fri, 24 Dec
 2021 07:36:35 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c%4]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 07:36:35 +0000
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
Subject: [PATCH v4 0/4] KVM RISC-V 64-bit selftests support
Date:   Fri, 24 Dec 2021 13:06:00 +0530
Message-Id: <20211224073604.1085464-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::35) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f596ff20-7fca-4414-8a4f-08d9c6b01cd6
X-MS-TrafficTypeDiagnostic: CO6PR04MB7859:EE_
X-Microsoft-Antispam-PRVS: <CO6PR04MB7859A6303EEAAE51668182498D7F9@CO6PR04MB7859.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYhwLARY1JBLX4oo02uVBI0YKkqyY5P9at49gf1HgMRJkf4V5VIQnb55Tgwqr5RzlC2/2HTZDxxLy5MEM7VaSmrtL1PJmq//N/qD46b6PD2uwhc6suJWUU02FBbRQ5z78er+uSNSOueTLEUitqfkbgMMAD+ly4N0apKKQATkusLRP/jN5YyVwwC2mYQdkQHHj/CsycUdjgGMzuu9ZJpP8ypV7z3VxQv8L/2M0nziNpZ8/f/RekUHQVbruYLt0LIBlLNatdla0kDHw6rWREca9VmvoxVO9LSBjQ6weV4D7uW1PiOQ3PTkt07IUuRrI1bLGksn5YxVlB8rss5MP6wCumW/477T/yv8TrxuUUGMUzc0resZ3tJ5jwHWC+837w9QWIosznbsj7LGdmYWNCGZgH8caZMhuH4emKQkDjeoQjuUMHfcg652QSzFNSJtcW9xuENu+UUOecMnXOSVnbSvQRUso/KawzwguVB+sSbIaGXu9Pto8V7DjD+YdnulByZhR3d0r9pkTkKNFk4oFqait89D3RNDdXANVsPLhrc/bzyuQLf2uVcDXAd2aAFD0CYK1uGt4DLVXV4dFUzitD2L+UAmO5zgLsu0CSlZgRRNYST9w1QFz3ypBDhIcoTeP8eQjVP4QRS785GSmVMNxz9Pi3aYMUz4/u8jmI+WQQd5fgOVJ877J37GtAFeqHGWiJjRfXG4MWHVehcUHPHxy4V+iBlf4AqkJg+ZcP/CQzp96fOv5DCPytUloy1KVHRPXUf5ubu4NXXtrsImJJDFlQ+YI/ugNfagQh2o+sDjMEI7YTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(7416002)(86362001)(966005)(186003)(5660300002)(2616005)(4326008)(82960400001)(8676002)(26005)(44832011)(2906002)(8936002)(6506007)(508600001)(316002)(83380400001)(38100700002)(110136005)(38350700002)(54906003)(6666004)(66946007)(6486002)(66476007)(1076003)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8VqP15YdBhF3pBQ2ZcCD3lxnD8bK64H0VWhknSmoW6ucZ0plZRsKr1V2U6Lb?=
 =?us-ascii?Q?OhheEQRgiHJHcZtdixMu5HgI/VozC86pDiRzzE6+H3fKNb1HIcTgZWyl2URe?=
 =?us-ascii?Q?KkLGozSAK2lbvNToycHAep0cbcXkw9qJDIQjjbkvZJ00OTZIsnY2+j3FkVPk?=
 =?us-ascii?Q?lliL77sZxd3Tj2RtgeK6p8vnnMqv5SIyBXhSvgeyQlaXFlmreEXeaI9nsx9U?=
 =?us-ascii?Q?00KKw7L97fBf4nyTDjJYfnvOlMHrgadlH3FrMSSCMhw7arsNJ8L6SU5EbVf+?=
 =?us-ascii?Q?Ub2VbeVnhYjvrlwE3D8I9LmrVw1swHzm4Pm8iUqPrL1U98blACqpUHMp7q6T?=
 =?us-ascii?Q?7I4mRCTHxt0jrVbBurOYHiF1N1wCZpaQ0HYACMJjxp9QO6Rh8frVTWFfgMP1?=
 =?us-ascii?Q?B54Ptl4VV+H6xBoPR4s9jLqou2iITte0S+ePxlBJKfDYLyILiVJh4thzpFhv?=
 =?us-ascii?Q?x6qVvVEfvADR5cXdKUEnk+eYbYHsvachEB3SjJeEeSx+H4AuXToOvHUEOPsW?=
 =?us-ascii?Q?aB+zrD/VUsVfEY0KbYXvga3Kcmr9J7gXd9ysgdvthRgMLsvgVso4E9tuxOGf?=
 =?us-ascii?Q?V4ggYzst1K3lrQM3cS87RnANmS/mYGTS0fsvUE1+KxRMt/7RGVanAelEzvo/?=
 =?us-ascii?Q?3kA6AMnXq+5pliDPPwpxZZ7FlqZ4WPIm3PY+TcoRbDQjA4lBkdmHdU8gMBJm?=
 =?us-ascii?Q?4DZVmF63vcsmoGUrGZnYyK8KALnmSMj2RUhxLNlclBth+CiJA+MBcYi38hZz?=
 =?us-ascii?Q?h3VE5FMcaQQvlDlpzdt6oocUgHEuHba6U0iqjFomUYP9KiUMaDdz7SPAYmpy?=
 =?us-ascii?Q?+b9KeGqkpXjLDKv1E8gbiKPz33jpJ1ntIDFSWWveuAQquoyt4uC2g4cm4KA3?=
 =?us-ascii?Q?tr/frNMUt/Xfe6qF8PfjdjWRj/U0bbsAqWGO6y64efEtoPxUiFoPC+5VQjfO?=
 =?us-ascii?Q?r2O+LXeux5C3JTaoNylZJeqYiXLQr3vbE/j/QCuq94ivVGTJkeMegb1Ls4wN?=
 =?us-ascii?Q?ReOaXxq4cIev9JfduCMnWVMqITYnXayvnxIWMkDXP1OuyE1Vt0yWnHqBb7ob?=
 =?us-ascii?Q?pCjLAe3B75pgAWOVpu8BSrEgErMf4W40NzGohZgpSOfoKVa339jFjMUU7clW?=
 =?us-ascii?Q?PDcydUHU3XnlTLJzBcyMd3NPblmIjup2gbBPv3MHrcWQ+vXDtomdi2Hpjbmp?=
 =?us-ascii?Q?7JaIP3N86u6nsX/sMYDvdIXpHrfDZf3obtU9y3B/bfF6sD7j+4ym5dxbYz+H?=
 =?us-ascii?Q?Cx3x9pKnW8eV/u9RKUI8qXDGML7hPaBE/0OOoxO1+ZXvHuz3OT4yHn0G0M5P?=
 =?us-ascii?Q?2fJg2sLcASw/ztEZgBddJNh4VOCyPQM8y0rV8siahnzLmCC0JZRWihJgPr/3?=
 =?us-ascii?Q?5fCVZHqHO2qcarpi8bvea1ybUejwUlV+uzo4mZA8s7RFTncYAB4Ra+4RIL+l?=
 =?us-ascii?Q?9G0pm3B7A7Fq5+nJi06AKOjX9hbd7u2Egfbpq9elQZ0KkzJ/7eans8pcLf1Q?=
 =?us-ascii?Q?yVAYIMkiaz2qe2Qw+DrgkkTPuTvE6NOBAo/1QV4kXoR527meCKJFTQWIh7i7?=
 =?us-ascii?Q?xLv4n8FiQ9pIXQ0nUm8kg0YBUzmmCRSonnzFgsysTkHnL/ZZpAjn1D3v9PoP?=
 =?us-ascii?Q?nQoe6ZAiR2eN9UBjLIOeJS4=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f596ff20-7fca-4414-8a4f-08d9c6b01cd6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 07:36:35.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7M0fW8bYyvsSnuSI8NrUk7CggTRKeGXIXIjvBmm+2HnLKu75oUPmXwDJX4+VWExyhLoQebOQvqrWdj7tjiWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7859
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds initial support for testing KVM RISC-V 64-bit using
kernel selftests framework. The PATCH1 & PATCH2 of this series does
some ground work in KVM RISC-V to implement RISC-V support in the KVM
selftests whereas remaining patches does required changes in the KVM
selftests.

These patches can be found in riscv_kvm_selftests_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebased series on Linux-5.16-rc6
 - Renamed kvm_riscv_stage2_gpa_size() to kvm_riscv_stage2_gpa_bits()
   in PATCH2

Changes since v1:
 - Renamed kvm_sbi_ext_expevend_handler() to kvm_sbi_ext_forward_handler()
   in PATCH1
 - Renamed KVM_CAP_RISCV_VM_GPA_SIZE to KVM_CAP_VM_GPA_BITS in PATCH2
   and PATCH4

Anup Patel (4):
  RISC-V: KVM: Forward SBI experimental and vendor extensions
  RISC-V: KVM: Add VM capability to allow userspace get GPA bits
  KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
  KVM: selftests: Add initial support for RISC-V 64-bit

 arch/riscv/include/asm/kvm_host.h             |   1 +
 arch/riscv/kvm/mmu.c                          |   5 +
 arch/riscv/kvm/vcpu_sbi.c                     |   4 +
 arch/riscv/kvm/vcpu_sbi_base.c                |  27 ++
 arch/riscv/kvm/vm.c                           |   3 +
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile          |  14 +-
 .../testing/selftests/kvm/include/kvm_util.h  |  10 +
 .../selftests/kvm/include/riscv/processor.h   | 135 +++++++
 tools/testing/selftests/kvm/lib/guest_modes.c |  10 +
 .../selftests/kvm/lib/riscv/processor.c       | 362 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  87 +++++
 12 files changed, 658 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/ucall.c

-- 
2.25.1

