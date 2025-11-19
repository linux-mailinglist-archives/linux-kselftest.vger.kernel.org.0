Return-Path: <linux-kselftest+bounces-45967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FCC6E1E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3E9D352B07
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACD350A0B;
	Wed, 19 Nov 2025 10:58:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6241734E755;
	Wed, 19 Nov 2025 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549902; cv=none; b=i7gt8POmsQjWYcEJB9OI6UcUVd7uO1d87ZBjpNmIp66u6wJCDHgVGP/l+V6DpKZhPoCVjAVI9oefCfQ7lFtJieIdKOXcqsMXnPpjTpIWUQrQTUSWl+0BoCEnat/H/XRv/baHrifgzmG1PAyJTm1Eywk2VS4duwUeHIguGD9WdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549902; c=relaxed/simple;
	bh=CeU81LLGlZ6CDZRyQl96Y8suPJNX8DPx1zPa+B+6t+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pefu1z3wNpTohLwPUtkyOz29XQX9UjKf31Gv4YV9XUQAPTsMg4bRJLuv9VBfH5VsD0gr0v/NsRwutklhp4ws88XzhqvTZc/e4ZUpZp+PSqov/h2xUeD8PGZ0rDPB6vfOiklEZ6LhWnp9+mtEVScqkhgHb5wM/5U/EursQLTkRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a180b5e4c53611f0a38c85956e01ac42-20251119
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2c365470-5278-4800-a7d5-f858a04cb37d,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:2c365470-5278-4800-a7d5-f858a04cb37d,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:0189cd17adbb51c032b757a3026b236d,BulkI
	D:251119185809M5OBGMRX,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a180b5e4c53611f0a38c85956e01ac42-20251119
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1605019668; Wed, 19 Nov 2025 18:58:07 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tj@kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>
Subject: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Wed, 19 Nov 2025 18:57:49 +0800
Message-Id: <20251119105749.1385946-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
with its sibling partition, the sibling's partition state becomes invalid.
However, this invalidation is often unnecessary. If the cpuset being
modified is exclusive, it should invalidate itself upon conflict.

This patch applies only to the following two cases：

Assume the machine has 4 CPUs (0-3).

   root cgroup
      /    \
    A1      B1

Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus

 Table 1.1: Before applying this patch
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |

After step #3, A1 changes from "root" to "root invalid" because its CPUs
(0-1) overlap with those requested by B1 (0). However, B1 can actually
use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
remain as "root."

 Table 1.2: After applying this patch
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "0" > B1/cpuset.cpus              | root         | member       |

Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus

 Table 2.1: Before applying this patch
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "2" > B1/cpuset.cpus              | root         | member       |
 #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
 #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |

After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
regardless of what conflicting value B1 writes to cpuset.cpus, it will
always have at least CPU 2 available. This makes it unnecessary to mark
A1 as "root invalid".

 Table 2.2: After applying this patch
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "2" > B1/cpuset.cpus              | root         | member       |
 #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
 #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |

In summary, regardless of how B1 configures its cpuset.cpus, there will
always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
is no need to change A1 from "root" to "root invalid".

All other cases remain unaffected. For example, cgroup-v1.

Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
---
 kernel/cgroup/cpuset.c                        | 19 +------------------
 .../selftests/cgroup/test_cpuset_prs.sh       |  7 ++++---
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..f6a834335ebf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2411,34 +2411,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
 					struct tmpmasks *tmp)
 {
 	int retval;
-	struct cpuset *parent = parent_cs(cs);
 
 	retval = validate_change(cs, trialcs);
 
 	if ((retval == -EINVAL) && cpuset_v2()) {
-		struct cgroup_subsys_state *css;
-		struct cpuset *cp;
-
 		/*
 		 * The -EINVAL error code indicates that partition sibling
 		 * CPU exclusivity rule has been violated. We still allow
 		 * the cpumask change to proceed while invalidating the
-		 * partition. However, any conflicting sibling partitions
-		 * have to be marked as invalid too.
+		 * partition.
 		 */
 		trialcs->prs_err = PERR_NOTEXCL;
-		rcu_read_lock();
-		cpuset_for_each_child(cp, css, parent) {
-			struct cpumask *xcpus = user_xcpus(trialcs);
-
-			if (is_partition_valid(cp) &&
-			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
-				rcu_read_unlock();
-				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
-				rcu_read_lock();
-			}
-		}
-		rcu_read_unlock();
 		retval = 0;
 	}
 	return retval;
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..7d8941f65d84 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -388,10 +388,11 @@ TEST_MATRIX=(
 	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
 	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
-	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
+	# A non-exclusive cpuset.cpus change will not invalidate its siblings partition.
+	# An exclusive cpuset.cpus change will invalidate itself.
 	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
-	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
-	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P-1|B1:P1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
 
 	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
 	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"
-- 
2.25.1


