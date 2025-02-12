Return-Path: <linux-kselftest+bounces-26481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14109A32DC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82CA7A1B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266F25D52D;
	Wed, 12 Feb 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxzR0TVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D525D522;
	Wed, 12 Feb 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382350; cv=none; b=W0rXWQXSrzbAxTa4x71ouyKLsYG6uei4wo3yEKiROLrZBzl29zW93palizm0zZlbCiCpxFm7cD7l1m6K7Yyuk/6zxJY4nQB2HyesZu0H5f2Fo8BhnWopM0367f/l8VBPunsmpkCWO0F5eQXzSqnlNdNJri4T+BI/lzyIb6uYE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382350; c=relaxed/simple;
	bh=i+ImuvsxORMr/sR+be1Pph9bvunPitRZvD6hqlNBEDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etvsPHy42jLy/ztsGFgBViw/Hq3rU58QLboUfsVt6O8hECFHoz6eCb7Ju6nuOOxAtPmzg2YOPHkA46z8nhnRNsL29SpZVaNcj0c2is1ryX4sNI3GLoxH5do/4e+Ev3lsa0VGZ4N91vOIrDPOmI5OzXHBhXcNbw+gNpCfgX965k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxzR0TVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2391C4CEE4;
	Wed, 12 Feb 2025 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739382349;
	bh=i+ImuvsxORMr/sR+be1Pph9bvunPitRZvD6hqlNBEDc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AxzR0TVMTWyh7xnme+LP3aCMji8bjWSFBzALs5tg8UnbVBKsq2PQ1Ona5m/IAhNoZ
	 QRhGuk4k1TGgC/0UNnLN5CJh2+StUeUYr3QQyRnIKneHc3HELKpImgcGE9hlp/vUoy
	 MXY1WBustxHpoRrKjgrvzuc8TG7PmlpKNY/9EV7VbJbN777CmuUJ3TQR/De3pZZ+h9
	 yvASm51NVg1e32ubpwElq98lTnfOKBEqST7g8gW4Pi1jaeV64umfFaVBnoGstZNRg8
	 z2eXdmw14zdc0mmlvVQ9F632TXqdbpMY6TSFGMYAarNTLsD+Cq6ydEPFE18VmQDO+s
	 imb23PLFpROyA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 12 Feb 2025 17:44:25 +0000
Subject: [PATCH 1/2] selftests/mm: Fix check for running THP tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-kselftest-mm-no-hugepages-v1-1-44702f538522@kernel.org>
References: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org>
In-Reply-To: <20250212-kselftest-mm-no-hugepages-v1-0-44702f538522@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=broonie@kernel.org;
 h=from:subject:message-id; bh=i+ImuvsxORMr/sR+be1Pph9bvunPitRZvD6hqlNBEDc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrN5IUrvy3XDSqCWlJNoAoldjlOInN9p/4/cpcJIZ
 Y9o6aq2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6zeSAAKCRAk1otyXVSH0JjuB/
 9DgRF7lxnlHn9mSwi0nb59wQR/eez2gNc3inHbieualr91tybkbV0y8Cpe1SWLVlq/7jK/rgEHpyLR
 ebFumJRsjPwdmvzTymL46uBAb58j00Gn2w4egP5T2pSEc65iseDUH8WfwjUf9CRLJx6IDUCpOXxx58
 AFfbcw8iHN3lpVsaBqYmQ7Uo/i2qefQjvNXJ61hNkSqgt0XL1C+pAQ79L3ddx5A1Ek4uLl2XMvx8Cb
 ryFKehJBJaIAHkbTXkYfrPKqfTogBCDBQFNCHjXsDIftRSqq45VySEi77k2BJCFqg0THXV9Ah582oC
 HzdAPRTB+sesizmKW7o7WpPG09Skeo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When testing if we should try to compact memory or drop caches before we
run the THP or HugeTLB tests we use | as an or operator. This doesn't work
since run_vmtests.sh is written in shell where this is used to pipe the
output of the first argument into the second. Instead use the shell's -o
operator.

Fixes: b433ffa8dbac ("selftests: mm: perform some system cleanup before using hugepages")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 333c468c26991421cd8f9ce6d995f9b64b0643c7..da7e266681031d2772fb0c4139648904a18e0bf9 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -220,7 +220,7 @@ run_test() {
 	if test_selected ${CATEGORY}; then
 		# On memory constrainted systems some tests can fail to allocate hugepages.
 		# perform some cleanup before the test for a higher success rate.
-		if [ ${CATEGORY} == "thp" ] | [ ${CATEGORY} == "hugetlb" ]; then
+		if [ ${CATEGORY} == "thp" -o ${CATEGORY} == "hugetlb" ]; then
 			echo 3 > /proc/sys/vm/drop_caches
 			sleep 2
 			echo 1 > /proc/sys/vm/compact_memory

-- 
2.39.5


