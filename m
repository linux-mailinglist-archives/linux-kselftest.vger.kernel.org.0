Return-Path: <linux-kselftest+bounces-7994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D9B8A567A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F47E1F215BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7BC78C9E;
	Mon, 15 Apr 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5gnfBC1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801676046;
	Mon, 15 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195162; cv=none; b=Q8ADlvQnv4sbEZho9TX1fFxajld0E+K8aLhalu6bF8RkYVKY+BHu2aob1Wq7vzGCoR68gcK4FKLjD8vFdwzU3aAHd3G3kTLhV7aNjj6w+qMgyTte5j6x1vK0f5ysqOW4f/h1Zro7PcHRrjsi6PN4cCG7dVLu+qIeZCBOrTqqZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195162; c=relaxed/simple;
	bh=ZmC3OjWZl0q+3gq57+LF79x4Ow5OJd8ovTuxBP0F6yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFYLTMRqv2rzyvdrEFXNt1zNIfERDRW8oWFqFKroZFrcccV4AVTn6QEg2ItYYa8YA9dzTlUr0EE2ZD46sIybxrfdoDytIm2rVuHlBrEY7En+uJeoYo8BFLfqeckNaQi0Zbf5HtLAeSh/lr1hYOj1seYYIxSv+nnEAHeKmUm/izE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5gnfBC1/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713195157;
	bh=ZmC3OjWZl0q+3gq57+LF79x4Ow5OJd8ovTuxBP0F6yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=5gnfBC1/qS0oUUqGutXeniQButimzUNYErSz4pcxV+Ti+OMwlBdyNgGAnfGjYgYJx
	 z60yu1BX/dR5adTW7PytjoHmCynODiDyO+P72g0rUey0wUX5jSs2TGC3GnI5Emb4qI
	 rK6XcjKEsuamb4ZgZ7qpmJTo3qLk66qlcT+rLoVWgRYmomCkkvy/DbSsMaSdD+/qZ8
	 4yoYAtUfMCbCfox+aRkPOotZHjujhfXNU4Ke4MFJGT3jYVe79aEHFb3IBwGkfHVt6D
	 Y05xiv25i1I3cyT265BE4QkuymaiGXPMtaAh+vF6mSgXAixUgzaznUx2aVxpD5qeqL
	 mNJbGG0Al4J9Q==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B7498378042B;
	Mon, 15 Apr 2024 15:32:36 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Apr 2024 11:32:15 -0400
Subject: [PATCH 1/2] selftests: ktap_helpers: Make it POSIX-compliant
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240415-supply-selftest-posix-sh-v1-1-328f008d698d@collabora.com>
References: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
In-Reply-To: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Mike Looijmans <mike.looijmans@topic.nl>, kernel@collabora.com, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

There are a couple uses of bash specific syntax in the script. Change
them to the equivalent POSIX syntax. This doesn't change functionality
and allows non-bash test scripts to make use of these helpers.

Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
Closes: https://lore.kernel.org/all/efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl/
Fixes: 2dd0b5a8fcc4 ("selftests: ktap_helpers: Add a helper to finish the test")
Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index f2fbb914e058..79a125eb24c2 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -43,7 +43,7 @@ __ktap_test() {
 	directive="$3" # optional
 
 	local directive_str=
-	[[ ! -z "$directive" ]] && directive_str="# $directive"
+	[ ! -z "$directive" ] && directive_str="# $directive"
 
 	echo $result $KTAP_TESTNO $description $directive_str
 
@@ -99,7 +99,7 @@ ktap_exit_fail_msg() {
 ktap_finished() {
 	ktap_print_totals
 
-	if [ $(("$KTAP_CNT_PASS" + "$KTAP_CNT_SKIP")) -eq "$KSFT_NUM_TESTS" ]; then
+	if [ $((KTAP_CNT_PASS + KTAP_CNT_SKIP)) -eq "$KSFT_NUM_TESTS" ]; then
 		exit "$KSFT_PASS"
 	else
 		exit "$KSFT_FAIL"

-- 
2.44.0


