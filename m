Return-Path: <linux-kselftest+bounces-9039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A388B5D10
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F531F20F5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF8130482;
	Mon, 29 Apr 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ieLUpllq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6AE12F5BB
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403202; cv=none; b=k63vKMRNtO0E2ImuRLV61fp6QgnZaoTpmNAw8mmXi9hyMSZhOT46XqF/egviXdHoxR7ILGiTs0Udo8x+1L9qLqiRyxQz4c0lDY9hvSp1V2xwtDjRxnbN8Q8xjvqhLX6jtNkCdRtC/PhbXux/WzszUj3XNFuqcqNs/mV1K3B1SuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403202; c=relaxed/simple;
	bh=u6ulU0BPQmNSIcLbsuogo6WHzBJ6ZqZxhPCHBhuLYhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrWaGpwcM+pRVcQcWuHdl3kPyHXffQKf6KYzskZ1DTQjZDDfoUp4E+nflXVewJQB/sh9zM0NssAVQbvLBelIzYiFe96joO6nYpjhGt6LN3qI9NjsYoDcRRc+Nb8kPkd1oxYLyP+VFx1HVLo6XJjpwFr7ZbE6af0Jnbwp6QohvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ieLUpllq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34a42d6e216so1009538f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714403198; x=1715007998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO1pUvU0QFRoXzPxVhmpQLKjzbVC9RycGYDtZgzkuNE=;
        b=ieLUpllqsARfwt/7I7ww4PVq6V4fj512DDDiiNtBQYMKJ0pfEhUfQJpkZZRi0U9S90
         q7qaSK00zTLFkN5/PrsStN4/+0bjZTPqjP1Lui9fML18g9qa+z492lIZFSdRu5FZX5C8
         xYvIh6rW4bMkDWPjrz9wi1L1C8A/mRsT9rJx3dlPkziUh+pOth7BL6nxvlOMd5CuJJmG
         CQ3AUuqPNyipmYt1AldKBigKA0hDWu+XkhhX2cFJZXEjyO/DqKNHmnSY5cnIhG/gST6q
         Wk/Bm0tozjLMKXOUqZQ70kpZkUb3S+fOk1mPmw9jp5sTX16BKo54/4YVT8UwL+9xgcIk
         nj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403198; x=1715007998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO1pUvU0QFRoXzPxVhmpQLKjzbVC9RycGYDtZgzkuNE=;
        b=JHVtatEHGjovAzSQVSgfER95St9msElOTTa6Ge0IXL25ywuCjoc8pLwrxMakpt1JEx
         fzE6oYpZDE4Pnf4EvI0OvoRxoKHrLHLydOKESfXFg5rwYt4Y6oBT5UdXzHEfvJuFq4NL
         qn9Ks+KklTlgiiwNH6O8SS2ffZiRh/n3mawc8XHXImzqJwYaJHq3rMaItPNrxU4yj+kf
         3ikpqPkhfcWUpnIh2zSHv3xzOJ6NHoStWtg54iRpPfk29jAIMwBtXKVChGiLEzVIpHXK
         WAuHJ8W8+tPZXPf13556n2M02equuKHY3CSICTtLKo0atZGJZW8j4ye06kMnUz5xEJLz
         Pixg==
X-Forwarded-Encrypted: i=1; AJvYcCXf6B0p18E9PXuSAAuuSoe9BCaJZ2TFaipgxn69GuvHYxttOodUCR5881V+KHqYj97rl0FJKB78Cm4Rqs4aWhstxaA4UPpMi6DEzwwGXlPs
X-Gm-Message-State: AOJu0YxVU89JcGF3EhivDdGbTeotqxoo1y77S5819xFV93QXRjCUe9PM
	vG0CTp/zNAwVLnxsRuv5jKOYTPB5WrgpTTlXSmqZTMM6dPJADNTllYnewCopvYE=
X-Google-Smtp-Source: AGHT+IFiWS0wkp40gKDZAfxGi0j9Hx+FE3RcRH6ARajQSpFlwAjMjBZPph1zEUrLoQbUy23CTem/ew==
X-Received: by 2002:a05:600c:3b17:b0:418:2719:6b14 with SMTP id m23-20020a05600c3b1700b0041827196b14mr8083792wms.3.1714403198041;
        Mon, 29 Apr 2024 08:06:38 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2fec:d20:2b60:e334])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm39646638wms.32.2024.04.29.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:06:37 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 06/11] KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
Date: Mon, 29 Apr 2024 17:04:59 +0200
Message-ID: <20240429150553.625165-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429150553.625165-1-cleger@rivosinc.com>
References: <20240429150553.625165-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The KVM RISC-V allows Zca, Zcf, Zcd and Zcb extensions for Guest/VM so
add these extensions to get-reg-list test.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 40107bb61975..61cad4514197 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -55,6 +55,10 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCD:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
@@ -421,6 +425,10 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZCA),
+		KVM_ISA_EXT_ARR(ZCB),
+		KVM_ISA_EXT_ARR(ZCD),
+		KVM_ISA_EXT_ARR(ZCF),
 		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
@@ -945,6 +953,10 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
+KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
 KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
@@ -1001,6 +1013,10 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zca,
+	&config_zcb,
+	&config_zcd,
+	&config_zcf,
 	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
-- 
2.43.0


