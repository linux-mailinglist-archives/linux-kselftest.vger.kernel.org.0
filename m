Return-Path: <linux-kselftest+bounces-43576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92ABF3607
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EDF134711A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7E2E11CB;
	Mon, 20 Oct 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bx8csSAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F42620FC
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991761; cv=none; b=daiKxZ+G1nCyMOk5GajCnu3VUopvsyP1NnCTg3vdajDzgZE9TCSo9lBRckXTF8QCoT9tg3qTsHpOPS5J4kBOu8qWBjLu5bjJX2uB7CkxgcwgMTjH+hPELi7sGW40rHLsdheGmqwoTBf/yrdkaOKwUhDZEV4AcZAgxga0+oQ2ujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991761; c=relaxed/simple;
	bh=h7+45OcDo8mC8F+qfVwlj7BDk87UYY0zWzUeH8BF0jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYb9kH8ksvaUJO3K/l1tpxcrmSDrAgCUyYu7bLw+R+jncNACwIMgyCbaeQ/XbqaW9Aj8Mg4OGKoCzAXdXkTLNUA3BbqZgpcO0Y7BSyetOn9GTeE80sNjZggj+da2WDPsvzuaI01N7NY5xvSA1rWbFwv83YCA5t9/iII5cs/Am+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bx8csSAb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3944422a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991759; x=1761596559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJyf5Mfx2dyzbSqpH6VID/K8048gVV4D981NLyY4E6w=;
        b=bx8csSAbXrK+UDpKw6v9spD5zMeYyOdQn8Jv5XQkT9tjnraW8Zhq3xuHZb11POFPGS
         YxF09kM+TgeTxx+9HG/ulytpQBGd0NrODrH3BRF5/NU6FAX/0kgXZvbQEIYrDQTjsrOg
         aH/qS5bfzUZrsgHiaLoSC2lPn0xjoB5/LjSutwXdluwjdBABXsDturE+uqPnKyEhNRH/
         L6wiUiYFE1xaeJhQcoJm9gdWtHQsJsSbCjp0KVD3x2AukjN7nHpnkvkp2AXAGNipakhi
         TNnOrXetApfQryvGSXJuZ0QKJW/DTgy05Teotcmj3n0nfJxxx3UZKy1LMK/3SqRXCt3/
         w8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991759; x=1761596559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJyf5Mfx2dyzbSqpH6VID/K8048gVV4D981NLyY4E6w=;
        b=n5ULyMhWn0vn6oPqNyZ/gJ5PiIWm/Q6VqU2vBjm7rvJNPtQMcnNMhxFYXtv4tRzKU5
         /siV4+0/4lwp3hBqMI08BANmn+cVBhZKPK4Skbjq6vZclhOHsfBVNOMIhBKu92gOw4G7
         fu4zWO5xUOmZDhrSWoacwR5XaeB+eC6Nwh7iaBADKQaMRlczO2G2JhNzGjs4UT1CIYpi
         kHERocRVz6I9iFW3yCoXkhNzfvLWU7ImbE6xo+WlqQeAqevZglt0UCZYoGoAepd4t+TT
         10/icwFLWvDGn7ugUzu3OyuqMKjzpd60enNEZAHHn6MCfh/VZQg2KH6B30joaN+Ykhqg
         sx0g==
X-Forwarded-Encrypted: i=1; AJvYcCX3AIRnFp6CZfXlUbuG2z99pNqWUA0O7K/dHM2pLznT4+Yu5/G/lNez0fwNdM7AjoWWwp7xJHOSWMMDjfQ3aac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKQe7E/9AcU5bjNXliZlLFocYW9ZzV0M2qTQ1BLq72jbuIenq
	7Th9q6Can590jHMcun68PJZAxYpRDGCpB7ImRnHpbA0qL1lCRfloCd66jzt5JlvNlLI=
X-Gm-Gg: ASbGncvj9oSb6PGnSOWb+P16LnUocQpXKhijSonpkyHdjkyiMiLWJeJ49Sorv1vEf2+
	VJiU/FXQvV6FFhv8qAk8XcbCr6rCz/6qHSNXdN+rgWw3CxjgeyqjhyPMn71z0AaiNC8TXDWwEcl
	SAOus5OcLIjZmv7oHgOovWArG0a0MuGmT2Rrc8o20xqRbcYYrm3R8drnXnPxvac8d4FRE6kWSGp
	ktu6t5m9FxK5sPhHbt/l/sScjDYGjIvZqy9Ia/Es2VLwBCUD+0mpm8tAFjS2PUB+hKqH5QxI6kQ
	pmYdwvn4umv3Fgbluivyr6srcGjnCycEOnfj6CMCuBDdR0bIS3jrz3d78fRy2JYeCUP0bniw9z6
	MBOnNCxzDvO3G1hcq4apadEHAaXSb+UZr4aQ18dpTr93vaI6EhLwmL1YChdoN9naKkKgi/EfUW1
	ysJ4l2u1jdBw==
X-Google-Smtp-Source: AGHT+IG6TVxooarevlSjW8zrVFT+uyU8PdreEG2r0xgjTATLXR8OeKKNJ35yKTRzDmtjqbRnxjjd+w==
X-Received: by 2002:a17:902:d4c4:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290ca121e99mr205845775ad.36.1760991759471;
        Mon, 20 Oct 2025 13:22:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:30 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-1-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
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
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.45.0


