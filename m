Return-Path: <linux-kselftest+bounces-33050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849ECAB8065
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6461BA7ABB
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54C28C840;
	Thu, 15 May 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CkTwN0U+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729A28AB12
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297430; cv=none; b=uE4GgN5t6EirutYf1VeACZV2yzhhKKhckWqc5otRMm1F6VD1BHVQeKs+6jA8KRzBLUDwekZStmk6SpkrKjAzTrhOVqZbP2VODgBoUnVe9kbZ1Ft45dK4gaGqp67cRg8dsdGmuGuW1LVJPSejZXXshsXcTr5eanB8pPak90VCk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297430; c=relaxed/simple;
	bh=wAx2RrhJgfovv+Ew3KxgsAkzj9v4q4meKm9RpW51ts8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH7mDZVBX44i+oxSKilaJ/sr/dlTv0x9n6FWuW43xdjf6QTsKlSGWYL2mcMLwFV/03GeuWllaqH42rjaawhQaAQbDQi9zsEs/m4C88Oc+DgzCnN4b9gQsFpuVc7cthtqXn4Kr68pCjzvmUgvIiItnaQWLb2a6YNZBSRDeeZcpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CkTwN0U+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so4636815e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297427; x=1747902227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z13A9Xmh4hlNXDYVsXBjasLvO/5IjxZE5WiJJRlkS1s=;
        b=CkTwN0U+wXFIJP36JouWLff3HSYTCenGXDrB8sdRCoW2HMGRfA/xk2WKMSkaEXfhjZ
         agxuaLcwiDOsCX+V8iKW38ZOPFBY7sqYk4kBxkuVwestpDMHV5hwAoiYL6AjK+CskL8S
         5/4lr9k+NYHyOwClgtRZbS+CUUw0UAsK4CsiTo4TYRjSN/Ike9pJ3Svrbp3xWZ+fReak
         XcAjtwvavcxJ2fBo0504LTtxAZckRQqtJdMVi6EyggqCEU2vKOzFNx1b6qLI/Q7EXf8W
         vof0r8GhvLc/3j+ps12B81PUzTmqL+7eklowf2szelKr93uGFomLwZScdnpP46zGxVdg
         89Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297427; x=1747902227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z13A9Xmh4hlNXDYVsXBjasLvO/5IjxZE5WiJJRlkS1s=;
        b=TQeD4Y/ZAcC+3gjkZGSCygqfG+gERpRVXtKMCmnsPcCaeQzT9b+XX9EKDTfZvG7NHP
         4LlqNVMOT25Q2QIR+cBxPIkM3oE9b6PDRp8SmtrkjwL1RfOhUkUdpB6RdCdZtlMj2kyF
         i4nU0X3LwVagR4a9OEURyHPxgDLsnTHEdcT6vL9HoEo7Fu7/TtSAsWRG+zu28JzdBp9c
         sdhYffNIQjeg5d8lXj4lDQWtxl5xHzFjGGIY32KDm6l6BVRCwPVTHRyGEfTXkiIc+zIH
         qAuHZlPwk7xQW3cnZeiW6z9rZ1tS9IHJUe46yAJV1/UZ5prXxUBS1FxSrSU4XmMBLGUR
         tzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRswLjsPPI1pFclVZiB1gD0K99FPc9Gg/mxzB3uuB2Uj4ke0hm1V804AI6wPw3vQ05ZpLFnlN0Fgf3YEVxkyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQS2tT0oWwJBvp3V6bFKWglLlect90xAGX4B3eNhCNVtyPI9E
	TRRA8OjZ1W8HuL4Z5EJLaEI5wC33uAPBYlcnxIAG9HqlzKEBjy9TRzGInMxHh5k=
X-Gm-Gg: ASbGnctBzUvygEL4YNMaFS39YOFcJ8MO8yXbohXNhAnLkNZn00b0/dVJ3caXkfAxiUd
	XzGRj5vspGOyawv+h4LqNivk8LNy+fLUccWn6d5t6ftrG+rcCY6/fWtVLqVBF5rZo7sqJZGOMtj
	N1XZ/OZSJIbZH9HZ5ub6oQJB9s93d02cMSphuLhLMsyt+vnGxZLpTfi+g7Hd4gon3MryY79Y8Vn
	YYc0jiMBfept7n9c9x7zOK2anWGSN9iepggol0dd6Swo4sQKNLDqf2NIWwvSYTGoa8K9IuXdCnQ
	0Bft2RgrOFObkulxxYio2fH9iy5McIeXTTJv1AKbhJZHMZKW2ug=
X-Google-Smtp-Source: AGHT+IHkZNQbpAw1wphnseKXwk4yMRcZGss2iiWcC12RxGFa4TAsYttDPas1NVsjc2nqofvNADAfDw==
X-Received: by 2002:a05:600c:828e:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-442f850c4f5mr24840985e9.13.1747297427334;
        Thu, 15 May 2025 01:23:47 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:46 -0700 (PDT)
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
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v7 03/14] riscv: sbi: add new SBI error mappings
Date: Thu, 15 May 2025 10:22:04 +0200
Message-ID: <20250515082217.433227-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
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
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index bb077d0c912f..0938f2a8d01b 100644
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
+		return -ETIMEDOUT;
+	case SBI_ERR_IO:
+		return -EIO;
 	case SBI_ERR_NOT_SUPPORTED:
 	case SBI_ERR_FAILURE:
 	default:
-- 
2.49.0


