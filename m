Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0C760D1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjGYIgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGYIgc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:36:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50410E5;
        Tue, 25 Jul 2023 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274191; x=1721810191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NwLmmjKl1l2MfnmGP5ndFqexOF8eG8HTnqVqUF4hZE=;
  b=P4Ga7PIBwseJd8C4DXFox353xs/Q4FrRxh4UzToFU8w11iJBEmzWTZSg
   o7pKrrgtxMXjupJYltZhfKvS12K0NFiY0GPK88+w3uNqJT8c81xVkso18
   qfbOC4Tuki2odIrWE9E6snIch90uAgitNyO4hxUOvc2GfmWPgavfLKaOw
   0w1zmxPRUFOf90UnXxqOeMiYh1ReIAhkzSKScejk/Cl8r+wvo/1SnDAxF
   3mshtEDgK8C8NIAi8V+VkkMf0LiKkbIInec4MKY6K/tFUZlwsb9HPyWJ8
   v62mNa6CrzGSUf6+eIluM5o4YhT4+VLqYTLHdxwInQcTe71xWQ1wnbnGh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371264343"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371264343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761130185"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761130185"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:36:21 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        maz@kernel.org, oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 02/13] KVM: arm64: selftests: Drop SVE cap check in print_reg
Date:   Tue, 25 Jul 2023 16:41:28 +0800
Message-Id: <6647e775594e44bf58a90564dc4312cdcb2d45e9.1690273969.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690273969.git.haibo1.xu@intel.com>
References: <cover.1690273969.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrew Jones <ajones@ventanamicro.com>

The check doesn't prove much anyway, as the reg lists could be
messed up too. Just drop the check to simplify making print_reg
more independent.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 .../testing/selftests/kvm/aarch64/get-reg-list.c  | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 52244de20dce..335bd5eb250a 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -129,16 +129,6 @@ static const char *config_name(struct vcpu_config *c)
 	return c->name;
 }
 
-static bool has_cap(struct vcpu_config *c, long capability)
-{
-	struct reg_sublist *s;
-
-	for_each_sublist(c, s)
-		if (s->capability == capability)
-			return true;
-	return false;
-}
-
 static bool filter_reg(__u64 reg)
 {
 	/*
@@ -335,10 +325,7 @@ static void print_reg(struct vcpu_config *c, __u64 id)
 		printf("\tKVM_REG_ARM_FW_FEAT_BMAP_REG(%lld),\n", id & 0xffff);
 		break;
 	case KVM_REG_ARM64_SVE:
-		if (has_cap(c, KVM_CAP_ARM_SVE))
-			printf("\t%s,\n", sve_id_to_str(c, id));
-		else
-			TEST_FAIL("%s: KVM_REG_ARM64_SVE is an unexpected coproc type in reg id: 0x%llx", config_name(c), id);
+		printf("\t%s,\n", sve_id_to_str(c, id));
 		break;
 	default:
 		TEST_FAIL("%s: Unexpected coproc type: 0x%llx in reg id: 0x%llx",
-- 
2.34.1

