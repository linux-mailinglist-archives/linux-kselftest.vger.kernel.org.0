Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2608945F0E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377923AbhKZPqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:46:04 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58030 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354201AbhKZPoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637941249; x=1669477249;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=i3NhJ2fRLGIPGjsyrtXQuz5j9uW840vbh1kbmsW24JQ=;
  b=Sd4uuJXNcHFE+5tsm17NOm3Mbhy0rrTrMMtpnWMFbmlxCK0+a2Km3peB
   Syf8CpcZTougOZeLBUzbjhqjM+UZ68aHj5Q/A9KdFolkAVBSyyF3l0lUT
   nQ5LR36Qe44mC+q1z+0XHzqrpKhf7b/ZYjXUjpQkRVLE2hZAdZR+2AFQU
   DvWrvgFYa5yY1tRxlFyFT32P9Qjst/JvSSxmZ9UAWvhi1fzI0mVqM5Vh6
   x8cTvagz9w89o3Mb7gxI/0CwExYN3cKDMeAD+szA/YJKuwIQatK2XF5Ae
   Pl+xAWZtwXWYTHvFXE1pBZb3MRfXZeAVvDtKJNGZVKvsyiZoTVIi7SA6q
   A==;
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="191541470"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 23:40:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g49S6Q83MzBJ/kCUEIHCM6sTck0qiEkwr39OoBCC9YCgjfPHwvukn/TXCELDtGE8f9DvlY0O21OfI4TiACtudKAF+qIKRPB1+bTb+gVhXwY68YlgnTQ0PS0jZ9LaWoFNXKmgL+nLwe9jUujDEPBHrCDWcYRdcJ0QI06nToahR8CsWqxSbqosTUH1NWFepeRrEAOezwzkueC7i1hcthkKCyWM307VqO8bKDIzqCoGWA+Ih+lLB7Hfv6AbGqTNJ8/XWojFbV7m1Bnmx9ETOl188S3Cuw0YT8ZvzGtmSEtKlaFvlB5aI0XvuuRG7pb24XAs3BIeoVvAPhOGyBwHpE9Qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCD6pjXxS6QedIGQXE1X4uQwEphdVxXSuFHg1o0SiRY=;
 b=Ml0rY/H47pXCKb+MoLTABSaBbcOG9n7IAa2tWfARU+6aqB2u+lra5tSevwXWYdaOdwzN/WYzTZdyXLz6M3LKpKX1NVKlGoeOfMkrAFq2q5hr1WmmPg8mvvbsljExMLrBZ11ooniamkTjgYg7kA8FIBMOsu/qncC6InAIE0aeJp8TEH7+JT+tnWMgFw2YCQ9zyTYXjCYcItTPsCTAXKWJiiN0bmqSKeGnIR31hhQXIKGP9ubOUExS85sHSV6UNK+Dgn+KBzDDN5d3SzTpGMqX9K8enmW5In6QNAJYSLrxeIXlY6DqVhsK9VYg80ktcfhtvjhkfewP/RD/L5TcpRPyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCD6pjXxS6QedIGQXE1X4uQwEphdVxXSuFHg1o0SiRY=;
 b=Nu1JDiLHuQxi54iiqJV5SPMVXCo9Wr8WsXUyKTiYAZB0gD5hQ4YBp6oMcy02QPF+wKMRv9EO7qJBqk7uMzqzCRXnJT+FPEPcH+TcXfqqfNG8nmz26fd3N6+V8aQ97hdVGZXeMY6EVcDgBlcOzlOV8Co4ZczX8xc7+Kkk4cHu0+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 15:40:48 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:40:48 +0000
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
Subject: [PATCH 0/4] KVM RISC-V 64-bit selftests support
Date:   Fri, 26 Nov 2021 21:10:16 +0530
Message-Id: <20211126154020.342924-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.118.153) by MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:40:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e226c34-a6b4-45c3-6609-08d9b0f31e0f
X-MS-TrafficTypeDiagnostic: CO6PR04MB8330:
X-Microsoft-Antispam-PRVS: <CO6PR04MB8330419C20C87A3752E867968D639@CO6PR04MB8330.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kqzteLRciZtzL+QPPdISBiCuLuHrpxBBmQoUwPI8CJuv5Y+vZuf3I0+xsYAHAEKVWVHYDrgzqsqAFWriFS7qFMABTPdp9cDx31vgGsoj6nOrwpQgsX3sEiqXvm7kRuznypkwsClC3ZWHYKqD1rBnUkMkCj+1yvjqymSo2adPq6azTtVGJg58SBsue/nom2fXNo+e0d5qXXGmh/R6aXso8KvggnQjE8MuCXA16uj/2dAHykgKhNwThvmwouwX17q/VbXyUz7Wlc8DEpsRu5ipeS10JUz4nPCtt192V2QEP8J9s4agprIVdBmMfbna/rUJUbZIyK/e9P6MCBSb902hjYyTsejAekU9jEFtJ+Vhd12KBcJ9yHmr0L666nWhwK+pKxmcfuti/FIislmrWkXR1ACp2Wo1fAreDitv5aExhPfmnnQ1l/gsuVVWAuHVKiXFUkPMULJBjZiNNjbgRlFRYb0/3K26psEtPnpPz/Gf30C7h7E7hGvAz9RToD9MRUHarQI4AeBjXgN1ItW+Eja5euCB5MPvo4/Q9PSWP9PZP3F3zW3zJVXTSBgN8Im44lIEdvE0zCbrUYIDP4G+S7ZWgs2Q9Dt1Z1lEowtfL+s/3zTzQjCycrkdadVzyMqufaKXN4Zh1/Rn7B+7PuR0i5e6O97qe1gIta+Ae8OOuls+6MPCcPkE/vB09p7rOWTPxDKrnK/ekvnjOlwRfnp5WXhWFQswn71P/p6+TXZQ77IGuiJAurLPY1+ngXc2s9nFVmsIFWqg2/N+KwpUkZ1Ea8I9g/ps6ZfLAI1zxiMjXSKYZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(54906003)(66946007)(110136005)(38350700002)(82960400001)(26005)(66556008)(186003)(44832011)(83380400001)(316002)(6666004)(86362001)(7696005)(956004)(2616005)(7416002)(52116002)(508600001)(2906002)(966005)(5660300002)(36756003)(55016003)(8886007)(38100700002)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvyLlNXO9rbz51jm1oGv9+B+hyxhaFOQgrCwe70P5uOEscBYpNvl9/PmTXBQ?=
 =?us-ascii?Q?TJdmi/fpTfUqaGSaG7WXcizbY2j48IGg9rWaYg1rV13RNyUCQRfXH6AVbSg1?=
 =?us-ascii?Q?1R/q7IalueBcwQcbhbgVpAWrIyUQboa4ksIGE23yTdnUfKR7P6zjrmOxifup?=
 =?us-ascii?Q?7ZD9OScJCM1M1+6YfJi9QwRPewdLSp+ppiGw9oO2ZcM9upGTDOl+SdYV6JYl?=
 =?us-ascii?Q?Bc89dclgeWdLgbGo7nVj4uqLkaHzco8hlosFjIw0aKThqRCEFhjl5Rm3PQKA?=
 =?us-ascii?Q?gavTeb37Gu3Eu0WByBy75AHS9k9f416cAwHxUoE7yQI8ZEkyRjM5VZlApiuT?=
 =?us-ascii?Q?oVTsIwu4WwM353Uui/KggCha49YtyNHXScyNqsQf6UxcZgVBwi7bREKi6vD8?=
 =?us-ascii?Q?QdE+cStXdj1n1N+wDO8aiZSYFjXHzoDlyG3jR4qJY4SwkslzGrzMYytU5MwV?=
 =?us-ascii?Q?sk6Z2lrpgeJ1+7iZpUCjaYm/h0aLkDjkwm/4AOgnLFJlY4QpHW5IVUYRTBYc?=
 =?us-ascii?Q?vU+ajN1WtC+NsB5JedlmWtWMByu4ZPIspcCrJGQf5ggDnv3yum777fUE2iPI?=
 =?us-ascii?Q?b8JnIr2mCUEFbxdFYxqeuSoY7xU+3EUejlPOJb7khkFitlZRUxLR+SnEBqsz?=
 =?us-ascii?Q?GBHNAuUa/oED3evQvu45ZAG/tdxWsjSthz/cHeQzmppbyQUYzJK78Gigaqdb?=
 =?us-ascii?Q?1OPG2RgTXtQvdLquAiJeNzN7NF7YJMXKiVrxTifRGK8z6vEaSHLSy1qsCUsg?=
 =?us-ascii?Q?TMn1GtOFqZyiCdDN/jXGeK+bNmtaOFw8jgbgF3JMn+3oEFO4+rhMcO34eFDc?=
 =?us-ascii?Q?g86RBhuLqGwwGZXfAqt8eUbKokH+GcLdH+ehfZTnYqBo5eowYoAv+f2k+1Bv?=
 =?us-ascii?Q?B5e3+f98Bz+gvMU8VXCafL9NfoIgoUtICPAnHQ6ifdKX6MA77vDdTnfk/4Xj?=
 =?us-ascii?Q?UwhaV74dvHJk32neCMtV1orBDNO7IPm/zoBRGfSk1JpiC00JaMzyR9WQflky?=
 =?us-ascii?Q?/Zq6cX34gEbTnLJLnmUoiQDny/Znx3QPubDHE2AUJQ5q87UYFen08nvmU5pz?=
 =?us-ascii?Q?gajO7544AahN8ZeAWatX7VALxUnbF+aXm8MpAZshHyhRmsZlI3EFemf2HP+p?=
 =?us-ascii?Q?cN/tUPuHSg74SbkJoBAZoglgLYIeC92eB6v4VXHryL5JFJ6luGTdWocxczyI?=
 =?us-ascii?Q?AI8B1cSeD4Ic0dzYP/jLJDqzDsaJiKDEG3jsF9EZPTTPoRKhFR1FgGg2aKU8?=
 =?us-ascii?Q?NZXBeh5UzDAH/KC0gzskMQbnihyI2Dh0TcYf7tfLRNRrvbA/j4yhqkBsd6Z+?=
 =?us-ascii?Q?QOzlzjPDSoOSJxTGJFc+4mWDjEg+RysD84YsCNlPqfnrt3WLyvu2Z9asFbmH?=
 =?us-ascii?Q?31JEK5vkjJM61QlsZsq7idi0ZPI92KebZv0N0rReS4+TgcSTpMDbpRLkPrho?=
 =?us-ascii?Q?Yd18EUNuvkKl0mdMiIshQW1WRqlEzCQtIKyAf3bBkaM17fYJWtqaK4t2R1gi?=
 =?us-ascii?Q?3w7slJZkcam4g2WZi93EqJMlORNst6IZhy64CPY9RJF3s1RNhWZahjE51AJh?=
 =?us-ascii?Q?QAtQa8ZTs35inPpxiLeaYvhQuWayDOKeRG3umTlPlf5mLodKZk2G5v5rI0rq?=
 =?us-ascii?Q?KOfx8xm68IWXKujMsE1NTWQ=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e226c34-a6b4-45c3-6609-08d9b0f31e0f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:40:48.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0/2aq8ByaX2FPbEgFcfhVJHR5PhBfApjctEXGILXtbv3PJLTGUjty31+1AE3eJwa7CW/pFRVWiYYTME+BT1fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds initial support for testing KVM RISC-V 64-bit using
kernel selftests framework. The PATCH1 & PATCH2 of this series does
some ground work in KVM RISC-V to implement RISC-V support in the KVM
selftests whereas remaining patches does required changes in the KVM
selftests.

These patches can be found in riscv_kvm_selftests_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (4):
  RISC-V: KVM: Forward SBI experimental and vendor extensions
  RISC-V: KVM: Add VM capability to allow userspace get GPA size
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

