Return-Path: <linux-kselftest+bounces-20873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3339B3E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EA11F231CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BB51FF5F3;
	Mon, 28 Oct 2024 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYTIyDSi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A61FCF7D;
	Mon, 28 Oct 2024 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158268; cv=none; b=OzQzvj6AYfBe/0X8/rzMuohasZSYQpOxghyjv2qKqAd4hSHPvivB8ibupqG0LzsJqOBMRCCgGT+JKidCWc5shWt3b04rWxiEs5Daq/dMOdHefha8p9rLbBsy0GKB2oy7v1E2Vk5ShBiWxPLifQ47nYV2d1JJTuUQjMXW16I36Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158268; c=relaxed/simple;
	bh=idVdmUJpd0kKngTICLupdXkDOcOuKWqMVDyDAZgda68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXSDjDS68GEFQY+A3iQlPf2Lgjan+FddP/mPs9Y5cJDoJ/hxrjuATxcpXm+l2/4OXR53/X56YEFDWPWbe63RgznvuP1GGwj00//FJxg2VUtho8vNn2xrKlLQ3EgU72KSRJ/Z0Cx/RkJQlnFnoaMYi0be83YE+YIGmrsE5Vbrl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYTIyDSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D06C4CEE8;
	Mon, 28 Oct 2024 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158268;
	bh=idVdmUJpd0kKngTICLupdXkDOcOuKWqMVDyDAZgda68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYTIyDSi6xXgUW8HyyzmFDNShNtw1yPARHNH4+iwKE/ioypAD4Au97MUfw9t/f3wn
	 dqisBPpIwXaVZb8AssUCwu2/nv8KS913DqCXg+Gk+CVZAP/us4MGSO84A573tivlzH
	 aC21hEF53GSoRnTzeCJEuONfHBAuVcpf2xeZW4lIjKClH/EB6IwdorDKHvHlHzquoM
	 JKTeMs/DzLjkD3cYpkDvB3hi+KskrlR1rrkMr+P1LAvNVB27iEJVG84Ir3nn1Krq5D
	 /4pUSxYlO2gg6TrpETVbN2TIF3NGCH146rbbe4+Gx/nzc8eu6t/MmfDGd6as6qjdfd
	 +NG1uNGNAI/1A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] selftests/damon/_debugfs_common: hide expected error message from test_write_result()
Date: Mon, 28 Oct 2024 16:30:55 -0700
Message-Id: <20241028233058.283381-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028233058.283381-1-sj@kernel.org>
References: <20241028233058.283381-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface selftests use test_write_result() to check if
valid or invalid writes to files of the interface success or fail as
expected.  File write error messages from expected failures are only
making the output noisy.  Hide such expected error messages.

Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_debugfs_common.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
index aa995516870b..54d45791b0d9 100644
--- a/tools/testing/selftests/damon/_debugfs_common.sh
+++ b/tools/testing/selftests/damon/_debugfs_common.sh
@@ -8,7 +8,12 @@ test_write_result() {
 	expect_reason=$4
 	expected=$5
 
-	echo "$content" > "$file"
+	if [ "$expected" = "0" ]
+	then
+		echo "$content" > "$file"
+	else
+		echo "$content" > "$file" 2> /dev/null
+	fi
 	if [ $? -ne "$expected" ]
 	then
 		echo "writing $content to $file doesn't return $expected"
-- 
2.39.5


