Return-Path: <linux-kselftest+bounces-12266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBB90F77F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A24A281ACA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBA7828B;
	Wed, 19 Jun 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbDkk76X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82079FC0C;
	Wed, 19 Jun 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828821; cv=none; b=h7aQXeGapA4UaUZPDAA0K3wLzaTQRFI55BMH/NfEOc+PCOM3f0KFzbFcHKvjzCTOk59k7cUKaPWZ8AeVGmtbA8vk3Eidls50UwOdLDL3pRUOD4OSMjqA1goES5rkyjgNdm3Wh4wUBvNDjUZAbkLI2kiwOJHP8941kd+HfSppHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828821; c=relaxed/simple;
	bh=g4F+MdqT/MVUcXKtNQAJg5HautTBfqFGsh7S/zXMJbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p6WvFISjryGkl3+IKsUCdr0oIKehXsHhccRNAgaqefsDmHqJEEsLLJEJzgShl41yOgGCyr/pKtbHdE1u0ksbosiI6w+KfUc39XwB+2PWvzM3udpGXQG9MrQyyx/et8E0NvP93LiQBL0TVLnKKDiPFTJ/vWeCWccISd69TF8oLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbDkk76X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177FAC2BBFC;
	Wed, 19 Jun 2024 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718828821;
	bh=g4F+MdqT/MVUcXKtNQAJg5HautTBfqFGsh7S/zXMJbg=;
	h=From:To:Cc:Subject:Date:From;
	b=lbDkk76XiVd3RQP2mZdFcK/b/3jG1KOgZE4qE5BJARZKzG885i4U7SUrYOdPSuUV+
	 ZyP8Tb/rczN3iWQ+XlGybVllyCXWutfdf/14nDMqLj4wWDbQ6sPxE4XaIn9oRibqTK
	 PiEyEunu5VyZDiA4uEyC0LT+LsVQ0h7BTK9AXSLSw1RKrXkcJL8nrRS2szwXnXxwEW
	 Q0OZJl9b0T9oqRFZ4t4urkQsS/farPGb74OqUVSKMQfuPkPy64my905iIWM77muZsa
	 DBgmarNlltQNCpGuue8ZJML8DJ1EbY4Y0GtbM9WklRThBs0xt5Qib8ttM3UUIIhOVi
	 1LrB5lbvzKjnw==
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/usercopy: Add missing MODULE_DESCRIPTION()
Date: Wed, 19 Jun 2024 13:26:59 -0700
Message-Id: <20240619202659.work.532-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=kees@kernel.org; h=from:subject:message-id; bh=TR+mnu+Vp3aO0Se1dthLMkaeQZNFS625VczsCknmmGU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmcz8TrS0NSRUqHvFAWAg35v8Vjkmd2YmjdFSJV K16Fe6uB0aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnM/EwAKCRCJcvTf3G3A JrU8D/95zyNv4qF5byvmaZbz8z8Y51857vLgHut7nNBsJoK1ksYWhf2TvONsuglT6Afq02lZKh+ taA4AM/nYxi/qT7v2vJk7joKANRsxRxKmO/3fQ1RSBujsKcIfZpQKYRztuxPGeGWId5nyE82+ra /srOP28M+wJaqSNpejTdwNoLayBjTvszodIrK2obJFTwNaQ15Xkm+lIwP4do5Wnc+jtQePQf9so HPuNoaYXelpLUrDLSzwCd048KDfyTzvCnYFG7pXA0eBNTM/YFGDkys3Da7MK4buG72n0egXr8kE QmSkN8QZWvuukMyvsXs1JKLII2d4ArGsM1huUfd3IGM9OEMKAYXoDXiw0Rh9SCOHlZ2cJbFPTfj IExFAt79/EjG7qEacM4PpIkZTOOJ9n52hXmoNNr8oA382+27VvNOKaHMNiymZcTs98he0TJKcvD 3DCs0pNzL0yatRbRmXATqBhwWjvimMrjZ9oAN4H+utSHuWqal2f88nmaCCxikozrBBKFc59e2rz KXyz8dqwj62WQnMUGTD7tukqXVEkz6yhhlbt5jsq8R0kbFcE8Bzb3txuzRhelrqZIxJvUsM6xfI ufy3Tw8VRIEsUketF05CLT+ZxJi9Bv7pRe5Dx1B2h8JeWmLPJKCDv6zC0W+XMQRFwNpLqorsjR/ DeitX033XPPVo
 6g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix warning seen with:

$ make allmodconfig && make W=1 C=1 lib/usercopy_kunit.ko
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/usercopy_kunit.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
At Jeff's reminder, I've split this out of:
https://lore.kernel.org/all/20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com/
since the file got renamed.
---
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
Cc: linux-mm@kvack.org
---
 lib/usercopy_kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
index e819561a540d..77fa00a13df7 100644
--- a/lib/usercopy_kunit.c
+++ b/lib/usercopy_kunit.c
@@ -331,4 +331,5 @@ static struct kunit_suite usercopy_test_suite = {
 
 kunit_test_suites(&usercopy_test_suite);
 MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
+MODULE_DESCRIPTION("Kernel module for testing copy_to/from_user infrastructure");
 MODULE_LICENSE("GPL");
-- 
2.34.1


