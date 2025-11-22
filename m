Return-Path: <linux-kselftest+bounces-46315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD43C7CD9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 12:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E15953535E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 11:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89632FD692;
	Sat, 22 Nov 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SjNzTmsw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D02FD1D9;
	Sat, 22 Nov 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809325; cv=none; b=YXENxMqJWLNs0dWFesnPTWIty11NdQDPRmyqkjGWlCAdVUe1M3Fc4FETPhvZfoo32PYO//Pqf/nJRTqy4e1w6HPAIWRvMlS+mKA6CxhftmNC0PXovxa8anZ4FZkVdcaS6JsqAzxAP4UtmMDBf3WAwA2YWtbqhMAnlFqFbW4+iFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809325; c=relaxed/simple;
	bh=vBXafayDfLtVbeWuQ7B+H3LSwXhGNeqajXMnFisErIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enfL+wipHmiJcSsMv/RVQQ3exskQG7Dgs83zjKE4X7MUng1lNJNXBjWppZTJppqh2jOx5yIFxqhgSTSvwvKU7CmmNP9Hbxw8yY4/PZyXyqrx6RDe5pJIJpZhm/IFeR4ctUtJtho+F5mOB3I9GyIcvXufk4Te4nBbR7LIPSh0LpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SjNzTmsw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763809320;
	bh=vBXafayDfLtVbeWuQ7B+H3LSwXhGNeqajXMnFisErIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SjNzTmswjdz3QkUD0He+Qc/i6vgroUPKaj5f0dKYpa+/UdEY1BdZ7lwsigWmkhUYP
	 QqE8DsJfybDeDraf6/7MdprqJAQ3E7dLRugRYDxF/mBuMBnKgiATOO3Cj35VFsCWK8
	 rWuxti5STHwgm92A9vQh52akq9QBB2xlyVuC8+jE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 12:01:58 +0100
Subject: [PATCH 2/2] selftests/nolibc: error out on linker warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-lld-v1-2-5e181e228c6a@weissschuh.net>
References: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
In-Reply-To: <20251122-nolibc-lld-v1-0-5e181e228c6a@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763809320; l=1032;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vBXafayDfLtVbeWuQ7B+H3LSwXhGNeqajXMnFisErIw=;
 b=jiqRxgHUrnDiwJmC4lHc9nET/O1Rq3EX+eq4dCYiKrbtokIa9Oeb++KYsvtr9s3UqbkmCGJf5
 e8rzvWH4mdjD4GiMys4/rdyfV+1xAfRD2fIW/VG8wlQ2Z5ygyUtUql0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If the linker emits warnings these should abort the build.
Otherwise they will be swallowed by run-tests.sh and not shown.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e8af1fb505cf..bbe8afbabd3a 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -169,7 +169,7 @@ test_arch() {
 	cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
 	build_dir="${build_location}/${arch}"
 	if [ "$werror" -ne 0 ]; then
-		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
+		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror -Wl,--fatal-warnings"
 	fi
 	MAKE=(make -f Makefile.nolibc -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 

-- 
2.52.0


