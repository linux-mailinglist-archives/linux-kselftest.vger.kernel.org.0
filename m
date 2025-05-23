Return-Path: <linux-kselftest+bounces-33579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32144AC1BE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898B83A5742
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC7227B83;
	Fri, 23 May 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0PabruU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234512253EC
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978278; cv=none; b=Tvw0cUPCP77FlDEC0V33PZvYcu1pARn/aLX94tYQcdjFsiEnPnO4ZOCNvv5OP8p8WibFC+Hll3lUCKTwy4D9kssWl8g2ZvtoNelGVU4CXBRwjC3TWHZ6NzJQZkSd56earPfNgr17bGPNQQ3WRU82dFOxACHXzbCuk8HWF+EjYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978278; c=relaxed/simple;
	bh=uG4QPZVjl5gDK86VnIwXxVnXWRkca87HCRZHSL9+/F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RM/u5RjXCJv9VgHyVUfL/lAnoBSgYTxudY8svDXUhI7Ll5stok4Xfd0PkR2vkofYqMa4MtoKKTfW9iJoAwlUsFrVWEngN62wFbGkjNbolDZkLmyBsyc12HJKIcRUeQvLRfxfpEjS8CzWGHOXu/FN66e8tQ9k/0kfVP9WX/CWv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0PabruU1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c46611b6so7379642b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978276; x=1748583076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=0PabruU1pEq63JcyrIU/ZBCMwBcbYt8MmoKoYLZphhFPYTPDBk6j4eHxvi3TNKs+yn
         YnqenTl43cPKcTAodEZLwKVoAUvBQDQE8TrOqmgpcpxttghREZV/5+k7wVyOTTrTR+mr
         Hg3Nw59+Crd3t+PV4dpgz49nsyld+axHAhrtwI7CcD4dOahegJzBaeIz+tyv+J+QbwRO
         9qYGjs9lI7Y4Hn02dUP6BpN8UnA0qdk8t3hC/UFWNMdu7LTBhxqoEhazGhc6fI8tyLec
         fE0AKWvc9pGtS1IinSnI7NfNhtOycwg5Nby35IPae1JpBTaN6JZsbJHneu7cdE/+Thm2
         9H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978276; x=1748583076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=Kc4y2mTsz2Hd44t56nllWNUSQJrCkTRrJ7SJw/GMF6QnVUiLFuhq6ajibZ6qxIK8bq
         NkWMXSCll9IJrqzIlRL1LCsCuZN1YytFgy1r3idmkhZAhnu/JIe+FXzpr0+3j+TpBg0t
         VZm14xpyIPCyliL75U4Wy0XlQuqQVVYPSk3oHsvDQ1OWbcOxHEi6se5AgeQ9ME8wIucm
         +gLmRJXXCFrm+KWUMVTZmXzXz5W+BMgYmU2/nPy66x08hblfkkkwhmfkgqxv0iDE+fSN
         GjZbPTnbJaoniQdjuc4p2EFoPDlNYSeErQd0dsL1m8UL9ipo95i1gCaQ9hCx8h8Od1Px
         UfLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXj1LATsDKp0xujV2yaJe64da5Yb+IDbkDtX7reitlk+t/7WfD+E3LdEp0W/Bm4wjtZQ1zxCupA6pfdN7gUuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9WRVJ+x4DULft3SaE3h1viVoXF1Mrz1ti/HKCjXKI+y4DbOA
	aiRYbowxyUTyPzc4uHEYza4bs1v78pKZLH58dYqgiCDNIM2ZU9CmWK6KdH+QZzfyjEk=
X-Gm-Gg: ASbGnctwOGqoqp9H9vTWj6zufGI3p8aFDeCgU9F/LTFd6Ry3PkGuh5FryMyRGjqrM+P
	b9LaQadr5acIR6HMQm+vHg2pbCzCEKY7n8jVYFGn/E6qhmT6npQ2xxSgio04q5wleOx2Sdtkbw6
	hsfk3jQBaSQI/6MbgVnLFiVacSwdiKQ7S+jn99AKOwF/Hj3VYBCp/xkAD6Q0AtnlntqvejiL6gI
	MMJ9xMl2hPkgovAnYQT45N+CeVgJQ96xRxDNrF/fYgbVk+/IcKoAxeBar4DSisiSRye2WKlCT8P
	sthHefhgrExeF6ixD5a30A0wU2eGqI7PtRZb3hFW3CMfIeSW4N3ABISFlAgshQ==
X-Google-Smtp-Source: AGHT+IHuvJwexFOpqMWZgmqCHklA7GJFd11ULqc5C7xPX4e1BtVUWPbvc7kB7Fax2t5Kt7WHcMzvcQ==
X-Received: by 2002:a05:6a00:3492:b0:742:9bd3:cd1f with SMTP id d2e1a72fcca58-742acd728eamr36423560b3a.23.1747978276169;
        Thu, 22 May 2025 22:31:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:04 -0700
Subject: [PATCH v16 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-1-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954..3487f28fa0bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


