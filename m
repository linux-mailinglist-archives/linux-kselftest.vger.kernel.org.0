Return-Path: <linux-kselftest+bounces-27960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4ABA4AAA1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4401727E1
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120AB1DE3CE;
	Sat,  1 Mar 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mc4sZAQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320991DDC3E;
	Sat,  1 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828259; cv=none; b=Eh5/lb1evBVQll8uX27+pTmp8r/K0uWv+8OjktzpVXt/ijcIYgM01bv3xkk/1C+FyGt9T6utW6Gl91zdRbbOPRhlXEKYU9bxsAvmpZBKg9jS3stUiI5dJ8Z4dULTswW/mIf/VVooDiSS6hTR46Pt44rVrqw8GdDIgnCBBZVMvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828259; c=relaxed/simple;
	bh=1JuS5zkZ2El7ErBN7hZsJKO4f4t9cEl5hlFQ3JjXUfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stCLPbr0UTre9X0NWo9YTzjj1JzKSAoakWq79pWw1O2M8DE6aC5DDDTc52MvyIGgylgEOkqGwJnefyzYSri/cE04bglZtRIF4uDOUApGN00eWx7WensdVbaQroORwImpe/y4bk1HLVkGWw8k1RDkTucL3D05Sqa0I7SBT+051nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mc4sZAQX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740828247;
	bh=1JuS5zkZ2El7ErBN7hZsJKO4f4t9cEl5hlFQ3JjXUfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mc4sZAQXIA4U2GXk9OEVTlpyWCGVJPvRhAbD9LTFFZh+ADsL2agkshTwuXQ3mzH6V
	 Cd8ZJ/pzdSse6mCQ4bnOJC4B743xgb9KMWb492k4Emda+UYRwpjBrGtkCxbBwm55EP
	 yJs4HdtiI29CwAMSSbfLjdEMvJNVYmCMpetXZOlM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 01 Mar 2025 12:23:59 +0100
Subject: [PATCH 1/2] selftests/nolibc: explicitly enable ARM mode
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250301-nolibc-armthumb-v1-1-d1f04abb5f6d@weissschuh.net>
References: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
In-Reply-To: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740828247; l=860;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1JuS5zkZ2El7ErBN7hZsJKO4f4t9cEl5hlFQ3JjXUfo=;
 b=B3ePB1i1gCN3841r+x+kY6ts/pt6RaCN9CsT5lWnJRXD8KsjYdK6Nc1kbH2XUKVfJLWSKIE0t
 ZM6fvhFhTn1DmPCSUkkeblSRi7Xtd4NdS+mayDRL2V60CdCdKOVgcDi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The default could also be -mthumb.

Explicitly use -marm to keep everything predictable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 14fc8c7e7c3067efddf0f729890fb78df731efb3..1dd2841a5fe781254a7f4b7b1ade677bd4bc0691 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -160,6 +160,7 @@ Q=@
 endif
 
 CFLAGS_i386 = $(call cc-option,-m32)
+CFLAGS_arm = -marm
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)

-- 
2.48.1


