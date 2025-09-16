Return-Path: <linux-kselftest+bounces-41625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4FB5BFEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 00:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5343D3B5E73
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE332F5A2F;
	Tue, 16 Sep 2025 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Qa/OtKv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C873288504
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060373; cv=none; b=XndHuPzQlB6TD+46OofGQgtn2yYZRRyQpjaAklfF7ogZYrMQ2vdej0eX8OxswvxFcWUMMaIr8Os8qKwh2ooNYwhYWYouQPf1dyv6pMkCZEqNtitS0XogYZ4z3ZTbJogFzp5TN+g/ecDwnraJinCcCSWafrMJwGRql+lt/TWicL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060373; c=relaxed/simple;
	bh=SIKkpUuN+UMf7521jvtEXvNWyyT5bVbD3qrrehDOkvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOPKVA5uwGylDhmmI0ygmwCWtS7Wcso5KHaIfF38yvp9FdZSXaJgPrplpn0u/nCXNEn+2N3eQyWEZlFVtA7vmgang5pDl0V4xmcyafatT8dZPpkBeKXjlj4HRLPn08ttsgvw99dUEVh8v7tN1S3tQ59JG2J1XrbIR/sYAD6o6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Qa/OtKv4; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-8ddac4b8124so1201263241.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4wsBOfcY7SP6UfIj6tlKK4cAsDmDK/TmLfUs8mNZfw=;
        b=Qa/OtKv4I0T6S6fGPCaPaJZFvWytzOoXDnT7Q3nH11SuoW9lBlrccns3LRDVfTsrGE
         yCzfJ+pmIyh1dItShechWM4zUJ2UT5yJQcIsbDg289Gvj5+hDNQ3MGmr4RVcnMrPkKoJ
         +SN8oHTstQMYL5xHsKPkPr9bqAKrTEBygsxzzUXzy+5hF827qwQtL6Ul8fDFNUg+eax6
         FS5e5c+RJO6QQDMmJkTpJpXd7rJzPBVj+bfblBq1QiB9sTkk9rhkp5h7RoeR8mGIQLRw
         8ThhbyLjDA4By8EfwTn78mFf4qSL5ndrG5GoWzJBcxlhmhs/h+9+sZy3mLRuPLP77Dip
         D5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4wsBOfcY7SP6UfIj6tlKK4cAsDmDK/TmLfUs8mNZfw=;
        b=TMWei7Bc9xBKutCq8D+AklMl1Z0thP6Xk2wVu6dCysnhWOrqnRgqc0NeM0R9XzctzD
         z437fp0WK40fIFdVFc+Vj+zHlWwd+yJW5dAbzklI56aZsFQQMDeJ0Agm/EsjzagqZFgK
         M7zmOKYSPn61eXCXGmaBuVIzbV1P7f/Y/bHDDPkEGEHgKVsaWMt9LJL5/CokF+BxMNxv
         e7GCWKGpNGHJ5w2zm2lzJ4EA2vBlvmZQBMQKlm2wycR0h2L/abpRIsqXFoJZvl5b8bP4
         uD9weKPuCAS6Zd8WmKIuFgUY+GMg3B+Gj8jXyF4fQKqw4AH9wLkx9IE8gD4F6Lom5ews
         gfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVBgIH25VMloErSv0dtCEa7OCXRv5BXXRCwtCoFCIL94BBJBh1TuBw1GlGBtJ6n0GUqLnNcm1KA5tzdy0O0i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/pVosWm/IXcEhbmm6+NGXkBqliU2v/9AnqGfIKAQ4TLwWmIu
	EcIxgJDwCPTyylTCY450TZ7mlrw4gFFtE73UvUOIR9YmUPxw+8oGC27ozS4mMh8kAGPMePYTWcE
	07tQ9U2TOMa7pAUjcf1HcaFYKEFdT+9LIHXBxgoi9/ULXf86X+URf
X-Gm-Gg: ASbGnctqBgqDvEoKJqt7i+pQC3tW9O+PT5O6lvNHSBsBgLPBE+m0TJZ80yHxvkQqwjV
	biQ2B6WSqE5bKe1Uvkt0gj7wKyKvahyHwQayYNWlktJFply8A6ScOLPIw2KDY9DsxBCrA75o1OC
	IqoRJ2TRJmDj4wC9wHi3s5Yer1ZDEL84Ropzz073VuMl4Gg0S2DdV6tBsInBroTkpuiKZzGEY1d
	8plqYUHbkvgX5RBvcBrkMdF1NcJJXbAg2QbyS1UOM41hxBnhJAwarwNDLgtbMuvLxU5KqyJXEND
	qzHwMMiP52LW7BnftPzaaAPqwEvaoK9hz22oZZfwFZqom0N1ap/dsl69h1c=
X-Google-Smtp-Source: AGHT+IFugGzusLHKIrSZCStJj5Llvm4aQRrc73nKgf/iXkByRK+6zltAVsAANgINDHQF55kouKN5b5uW5P5c
X-Received: by 2002:a05:6102:5a92:b0:526:1e74:9548 with SMTP id ada2fe7eead31-55608ea0285mr7126569137.1.1758060370249;
        Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-557f9d4b892sm975973137.5.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C7E57340A4D;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C2794E40837; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:55 -0600
Subject: [PATCH 1/3] selftests: ublk: kublk: simplify feat_map definition
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-1-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Simplify the definition of feat_map by introducing a helper macro
FEAT_NAME to avoid having to type the feature name twice. As a side
effect, this changes the names in the feature list to be the full macro
name instead of the abbreviated names that were used before, but this is
a good change for clarity.

Using the full feature macro names ruins the alignment of the output, so
change the output format to put each feature's hex value before its
name, as this is easier to align nicely. The output now looks as
follows:

# ./kublk features
ublk_drv features: 0x7fff
0x1               : UBLK_F_SUPPORT_ZERO_COPY
0x2               : UBLK_F_URING_CMD_COMP_IN_TASK
0x4               : UBLK_F_NEED_GET_DATA
0x8               : UBLK_F_USER_RECOVERY
0x10              : UBLK_F_USER_RECOVERY_REISSUE
0x20              : UBLK_F_UNPRIVILEGED_DEV
0x40              : UBLK_F_CMD_IOCTL_ENCODE
0x80              : UBLK_F_USER_COPY
0x100             : UBLK_F_ZONED
0x200             : UBLK_F_USER_RECOVERY_FAIL_IO
0x400             : UBLK_F_UPDATE_SIZE
0x800             : UBLK_F_AUTO_BUF_REG
0x1000            : UBLK_F_QUIESCE
0x2000            : UBLK_F_PER_IO_DAEMON
0x4000            : unknown

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6512dfbdbce3a82f1202de17319ea593337427e6..4e5d82f2a14a01d9e56d31126eae2e26ec718b6c 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1363,21 +1363,22 @@ static int cmd_dev_list(struct dev_ctx *ctx)
 static int cmd_dev_get_features(void)
 {
 #define const_ilog2(x) (63 - __builtin_clzll(x))
+#define FEAT_NAME(f) [const_ilog2(f)] = #f
 	static const char *feat_map[] = {
-		[const_ilog2(UBLK_F_SUPPORT_ZERO_COPY)] = "ZERO_COPY",
-		[const_ilog2(UBLK_F_URING_CMD_COMP_IN_TASK)] = "COMP_IN_TASK",
-		[const_ilog2(UBLK_F_NEED_GET_DATA)] = "GET_DATA",
-		[const_ilog2(UBLK_F_USER_RECOVERY)] = "USER_RECOVERY",
-		[const_ilog2(UBLK_F_USER_RECOVERY_REISSUE)] = "RECOVERY_REISSUE",
-		[const_ilog2(UBLK_F_UNPRIVILEGED_DEV)] = "UNPRIVILEGED_DEV",
-		[const_ilog2(UBLK_F_CMD_IOCTL_ENCODE)] = "CMD_IOCTL_ENCODE",
-		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
-		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
-		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
-		[const_ilog2(UBLK_F_UPDATE_SIZE)] = "UPDATE_SIZE",
-		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
-		[const_ilog2(UBLK_F_QUIESCE)] = "QUIESCE",
-		[const_ilog2(UBLK_F_PER_IO_DAEMON)] = "PER_IO_DAEMON",
+		FEAT_NAME(UBLK_F_SUPPORT_ZERO_COPY),
+		FEAT_NAME(UBLK_F_URING_CMD_COMP_IN_TASK),
+		FEAT_NAME(UBLK_F_NEED_GET_DATA),
+		FEAT_NAME(UBLK_F_USER_RECOVERY),
+		FEAT_NAME(UBLK_F_USER_RECOVERY_REISSUE),
+		FEAT_NAME(UBLK_F_UNPRIVILEGED_DEV),
+		FEAT_NAME(UBLK_F_CMD_IOCTL_ENCODE),
+		FEAT_NAME(UBLK_F_USER_COPY),
+		FEAT_NAME(UBLK_F_ZONED),
+		FEAT_NAME(UBLK_F_USER_RECOVERY_FAIL_IO),
+		FEAT_NAME(UBLK_F_UPDATE_SIZE),
+		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
+		FEAT_NAME(UBLK_F_QUIESCE),
+		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1404,7 +1405,7 @@ static int cmd_dev_get_features(void)
 				feat = feat_map[i];
 			else
 				feat = "unknown";
-			printf("\t%-20s: 0x%llx\n", feat, 1ULL << i);
+			printf("0x%-16llx: %s\n", 1ULL << i, feat);
 		}
 	}
 

-- 
2.34.1


