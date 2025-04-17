Return-Path: <linux-kselftest+bounces-31049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416BA91BE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9401A7AF1E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5962451E0;
	Thu, 17 Apr 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YW0Pekvc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B423ED5B
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892661; cv=none; b=QNRt3IHFyCKV51/l1h3u6/nwzyMk7pkdERf07nrOYTeGR0OK8JoFJL8uncIBA5dvSS6hkR5pEgaTwqz6vnysBr7x/alaFFg4xUhtffufXH1RpNFSz3x4G/tEOwwbEOpXN+OSIrwX/8LWuQmRPlue0ZCvTRRIAlyNvJkzK5YoZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892661; c=relaxed/simple;
	bh=I8q3a/r8sIPwl9ULO4heNHCAxh6RA5hJvMvMHg5vqgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4TrIpboDmsGeTVDA8n8XgS1CNSUzqwPqMg7l8otttd5dk+Sp5cQKvamxa5EonKxHxGxv3kWKxoQNT4Io62RppjOE6ux6OQPuj+lWyXfloj4VsVkmw7CyWJ4otQ13S+rENVJz3xivWNXUD/o31A102onEZDl2tU47h7YORYsHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YW0Pekvc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso6785005ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744892658; x=1745497458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ5IZYf4f1NhGHvFycXXpF/34tAS76qwhFgvuPH97UQ=;
        b=YW0PekvcepDEL3CNBicFspmuytgnbXMVpYVkMaHix670fEShFT+lc/mMY0iZaPCPQ/
         yuULSJXL6H9WfDpXS56vKkOXAN4jcZcLjPzuK9xue0TvhToXId5IztsN0w2bwF76Lwx3
         QeEHZPVkkKogjpcIp4MybW89Vi1RQaz+2xvecAH19RpZWagG4Eq7HSoTomUxYB05Z3Pi
         6rcLlbwTKsOadpEq4J4yLGQYSYWMa/0yWkEd/lqrQu8tyJaLiWXAjgcR+ACWhkQXIDQ8
         p5zBgLCLZJZqGUbZPKgeUjC2pIMq27dMoJ1XtTQf6297sUp5umm3RoEEbl5L0XvNXeqr
         5ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892658; x=1745497458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ5IZYf4f1NhGHvFycXXpF/34tAS76qwhFgvuPH97UQ=;
        b=E8nRxdh3WEM0RvpAo4rZnTT1bB0Erj6IPn4IvziAygoPvIISTwDAOqyMi6szpq5iDG
         HDp8A2LMyFmxCzU7a3bTdbQ0aqW9z544OnPqU9XGfQN2LMpoHAStUvv479b6X9ALX4K6
         c2QB40jiribiY9BD1tdjByQXLLVQW1KeidA95g7DMVDUmYmrJlLMY49E2Q+mEWXkRsoW
         f2xNAq7WR6mW6qJhsvFbl/L5uH1NYuiflswvEzFlC59LaAJBCN6tAtUIDzjEkvyi9X3h
         IDDj7HO7+AIIrOna6ce2JJ59eOY4QBQ4EdCsJpAezjTpl9m8CoHpuraTw11ePTJ91z2o
         vIgA==
X-Forwarded-Encrypted: i=1; AJvYcCWD5r4eCjU9/gtlY51MCJDje8L2iLzq1lvwoee25zJOZPvNG9oVSitTvEGAhUW+/1/olgSkHK8QVqRW0BTnAXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+OuORZso9k40XzJPGc+KTYWlCKlz3weKZxgLoab40Is0lkyl
	KNW+W0DaCfG6P22lQdPJqt9wdkbz0xsiZsl6VL3QIgPInK0jsaMjb5QzADBk1T0=
X-Gm-Gg: ASbGnctdJdhYmh6rOiOaw5DyI1w6rezwRG8KTgd/ab+KBgwZVS0esUdlGGN9Qsuf/1y
	6LGBygOAwK1ms+J+s72UEbuMfNNO+KMFrcMAMgyJub08sU9zW3rmb28EraRfkv5Nq6l3OwdQelw
	JDZrXemohEbO6XaIiNvmAGaO4oZlW7lGiFSeJaBcBjEGnsE54HqA9zgY2Uid8BQtNTEbtgqd6CH
	Re4Un0zRsFp3OO05CSorFuAdPwUiHy2GsFW+APkkyu5S1iMT7KWCpQ/Mi9o0Xe8Mfk2o8cxntyw
	DL+x7c8h+QnohsS/fZdrNq6V2RzRm2ZOXIlZU0fUPw==
X-Google-Smtp-Source: AGHT+IE0XjCz5TtIm1U/KycHsULkn93MfV8ZJ4DCUOeKjh64BtT2X4MD7ZC1hijUVKkaUKvQHFj5ag==
X-Received: by 2002:a17:902:f642:b0:215:9eac:1857 with SMTP id d9443c01a7336-22c4196f564mr40963855ad.5.1744892657640;
        Thu, 17 Apr 2025 05:24:17 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3ee1a78dsm18489415ad.253.2025.04.17.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:24:16 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 02/13] riscv: sbi: add new SBI error mappings
Date: Thu, 17 Apr 2025 14:19:49 +0200
Message-ID: <20250417122337.547969-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417122337.547969-1-cleger@rivosinc.com>
References: <20250417122337.547969-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few new errors have been added with SBI V3.0, maps them as close as
possible to errno values.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bb077d0c912f..7ec249fea880 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -536,11 +536,21 @@ static inline int sbi_err_map_linux_errno(int err)
 	case SBI_SUCCESS:
 		return 0;
 	case SBI_ERR_DENIED:
+	case SBI_ERR_DENIED_LOCKED:
 		return -EPERM;
 	case SBI_ERR_INVALID_PARAM:
+	case SBI_ERR_INVALID_STATE:
 		return -EINVAL;
+	case SBI_ERR_BAD_RANGE:
+		return -ERANGE;
 	case SBI_ERR_INVALID_ADDRESS:
 		return -EFAULT;
+	case SBI_ERR_NO_SHMEM:
+		return -ENOMEM;
+	case SBI_ERR_TIMEOUT:
+		return -ETIME;
+	case SBI_ERR_IO:
+		return -EIO;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.49.0


