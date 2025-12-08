Return-Path: <linux-kselftest+bounces-47246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A67CABE56
	for <lists+linux-kselftest@lfdr.de>; Mon, 08 Dec 2025 04:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5702300A352
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Dec 2025 03:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF412DC795;
	Mon,  8 Dec 2025 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="addqnOSM";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="F7TmOW1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428962DA756;
	Mon,  8 Dec 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162891; cv=none; b=iJHC6aWdRs4+AxBc0WPIeCL8Hx008HHTpFGTFJrWNOEEbMgP9gJ19Vekcxk6+ADyfAozmaRVpSOWVEhIvoRBCokgBJM+usBQMIIpWFsMrvBlO/wTlG7IANDhvpFOU4p5sY2epMPkewSE0U/Ui9UQub59nJ8yKxvG4b3Zxyp0z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162891; c=relaxed/simple;
	bh=69f0no6crvKhMEd+JiQv8rn2UCxYW5/d6S8UNzaKXr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCuJDvIQUXGNeldI33IlijDWXKkzL8DYTFMYxPkZEdkRfXoyjAAC3X3VHtKibFO1HNieISkjnvliQvcbsjhnrMkQT103qFDml3X0v3BYfHDa+en1iFwzH7U8xMnli4dyNlNwc/AdonpO/IaF39YCw70ookqHlZfE/8XanzeK0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=addqnOSM; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=F7TmOW1X; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162877; bh=exw2fblN+oBTCKLIjuHLn7L
	2MsrPArZyIEbi3CO/DyA=; b=addqnOSMoxjSov4fgpqL33puiPq6+e3Sobb4BX8BeEQ4QDE40O
	UfZlRO1fyqBLyo4E9KF1t1N3Al0oQ+yChYzdfCaAKtx5sA6+KbWFc4TJZDS3WYAwpS76BiBaQtc
	KyW94lTlvU/v8Q18KUdT6Xz3LSDQIffniaLK+Sw6R2mKIx6DMK9UwoMiGmobiwZTt6D5/rXXVj0
	8SEJqROAiXmy5i2hij9eNNSelPK/ESvZQNcxtcmpXe2MdDpFw1hFJtrBJXI8wfmzQEbojGI3BQW
	SlzCuItHBjBMvT/WYIYFZnHuVNlvMb+pdQCBdn0W5tse+X/bZyV5Wdmpb7VlawATzyw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1765162877; bh=exw2fblN+oBTCKLIjuHLn7L
	2MsrPArZyIEbi3CO/DyA=; b=F7TmOW1XSksjKwwWuDgNJxsXPuCGO0H1+VSMc5qMkjT4NCo5Dl
	phAKYwM2/dTHzcZD09xYwlHKgy4vXCczXoAw==;
From: Daniel Hodges <git@danielhodges.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	vadim.fedorenko@linux.dev,
	song@kernel.org,
	yatsenko@meta.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH bpf-next v3 1/6] bpf: Extend bpf_crypto_type with hash operations
Date: Sun,  7 Dec 2025 22:01:12 -0500
Message-ID: <20251208030117.18892-2-git@danielhodges.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208030117.18892-1-git@danielhodges.dev>
References: <20251208030117.18892-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hash operation callbacks to bpf_crypto_type structure:
 - hash(): Performs hashing operation on input data
 - digestsize(): Returns the output size for the hash algorithm

These additions enable BPF programs to use cryptographic hash functions
through the unified bpf_crypto_type interface, supporting use cases such
as content verification, integrity checking, and data authentication.

Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 include/linux/bpf_crypto.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
index a41e71d4e2d9..c84371cc4e47 100644
--- a/include/linux/bpf_crypto.h
+++ b/include/linux/bpf_crypto.h
@@ -11,8 +11,10 @@ struct bpf_crypto_type {
 	int (*setauthsize)(void *tfm, unsigned int authsize);
 	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
 	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
+	int (*hash)(void *tfm, const u8 *data, u8 *out, unsigned int len);
 	unsigned int (*ivsize)(void *tfm);
 	unsigned int (*statesize)(void *tfm);
+	unsigned int (*digestsize)(void *tfm);
 	u32 (*get_flags)(void *tfm);
 	struct module *owner;
 	char name[14];
-- 
2.51.0


