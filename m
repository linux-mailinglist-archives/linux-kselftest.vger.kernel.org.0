Return-Path: <linux-kselftest+bounces-45526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C53C56B13
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24747350D27
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514D22DF3D1;
	Thu, 13 Nov 2025 09:50:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCF2DEA68;
	Thu, 13 Nov 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027458; cv=none; b=FugmkR5nDCFGZBPpT2SlJtMUmT7FFWemNFq3ycjmMIlQZ+MC25dPZw4mAZbV/fs2DEWS6Dj6AeyXrwwLytAIGSQOYFpDkxLwGE+cP5ittWSGnhfmPkW9LufzMpESrxJiwbvZuuQtEuNElOpNKlmf7Mxv6Ly1+rmm5yvdVF+2xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027458; c=relaxed/simple;
	bh=q9mFL8RiAZj6RMExwmFVyoj5ShrrswYQK5SmpeJxjKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TLUQNny/htwtZO1igA7iL/4hqrKYQZs8Dv1doXQzQC3JJJMOrfjC2jxmCPlAZzyYmZHSDXUDuyEvruYwyzEb/iaccbUFbHnl0ca6ArnHMWsXHn2StF7NICqh/gvoGDxYTHmw4YBhJRmW5CTS6QHQOxL4j74+JAXuMcHWdHjJyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 389b3ddec07611f0a38c85956e01ac42-20251113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:bae591e1-cddb-4d2a-aadc-b87fd6a85652,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-INFO: VERSION:1.3.6,REQID:bae591e1-cddb-4d2a-aadc-b87fd6a85652,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:15
X-CID-META: VersionHash:a9d874c,CLOUDID:d1fd8e5c04717b0a002828b5f9deddca,BulkI
	D:2511131750462U230LTH,BulkQuantity:0,Recheck:0,SF:19|38|66|72|78|102|850,
	TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 389b3ddec07611f0a38c85956e01ac42-20251113
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 358271896; Thu, 13 Nov 2025 17:50:43 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	shuah@kernel.org,
	cgroups@vger.kernel.org
Cc: mkoutny@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] selftests/cgroup: conform test to TAP format output
Date: Thu, 13 Nov 2025 17:50:25 +0800
Message-Id: <20251113095025.2811205-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP.  No
functional change is intended other than the layout of output messages.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 tools/testing/selftests/cgroup/test_core.c       | 7 ++++---
 tools/testing/selftests/cgroup/test_cpu.c        | 7 ++++---
 tools/testing/selftests/cgroup/test_cpuset.c     | 7 ++++---
 tools/testing/selftests/cgroup/test_freezer.c    | 7 ++++---
 tools/testing/selftests/cgroup/test_kill.c       | 7 ++++---
 tools/testing/selftests/cgroup/test_kmem.c       | 7 ++++---
 tools/testing/selftests/cgroup/test_memcontrol.c | 7 ++++---
 tools/testing/selftests/cgroup/test_zswap.c      | 7 ++++---
 8 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 5e5b8c4b8c0e..102262555a59 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -923,8 +923,10 @@ struct corecg_test {
 int main(int argc, char *argv[])
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), &nsdelegate)) {
 		if (setup_named_v1_root(root, sizeof(root), CG_NAMED_NAME))
 			ksft_exit_skip("cgroup v2 isn't mounted and could not setup named v1 hierarchy\n");
@@ -946,12 +948,11 @@ int main(int argc, char *argv[])
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
 	cleanup_named_v1_root(root);
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 7d77d3d43c8e..c83f05438d7c 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -796,8 +796,10 @@ struct cpucg_test {
 int main(int argc, char *argv[])
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -814,11 +816,10 @@ int main(int argc, char *argv[])
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_cpuset.c b/tools/testing/selftests/cgroup/test_cpuset.c
index 8094091a5857..c5cf8b56ceb8 100644
--- a/tools/testing/selftests/cgroup/test_cpuset.c
+++ b/tools/testing/selftests/cgroup/test_cpuset.c
@@ -247,8 +247,10 @@ struct cpuset_test {
 int main(int argc, char *argv[])
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -265,11 +267,10 @@ int main(int argc, char *argv[])
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 714c963aa3f5..97fae92c8387 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -1488,8 +1488,10 @@ struct cgfreezer_test {
 int main(int argc, char *argv[])
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
@@ -1501,11 +1503,10 @@ int main(int argc, char *argv[])
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index a4dd326ced79..c8c9d306925b 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -274,8 +274,10 @@ struct cgkill_test {
 int main(int argc, char *argv[])
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
@@ -287,11 +289,10 @@ int main(int argc, char *argv[])
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 005a142f3492..ca38525484e3 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -421,8 +421,10 @@ struct kmem_test {
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -446,11 +448,10 @@ int main(int argc, char **argv)
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 2e9d78ab641c..4e1647568c5b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1650,8 +1650,10 @@ struct memcg_test {
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, proc_status, ret = EXIT_SUCCESS;
+	int i, proc_status;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -1685,11 +1687,10 @@ int main(int argc, char **argv)
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index ab865d900791..64ebc3f3f203 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -597,8 +597,10 @@ static bool zswap_configured(void)
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, ret = EXIT_SUCCESS;
+	int i;
 
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -625,11 +627,10 @@ int main(int argc, char **argv)
 			ksft_test_result_skip("%s\n", tests[i].name);
 			break;
 		default:
-			ret = EXIT_FAILURE;
 			ksft_test_result_fail("%s\n", tests[i].name);
 			break;
 		}
 	}
 
-	return ret;
+	ksft_finished();
 }
-- 
2.25.1


