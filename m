Return-Path: <linux-kselftest+bounces-23762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E129FCF82
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 02:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924E0163A1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 01:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF63595A;
	Fri, 27 Dec 2024 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiYyyiS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF935957
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Dec 2024 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735264338; cv=none; b=a/AgZqNTE9UbX+TwxkZkFVpducI4eo0peVVSsfOkBxY2APUkHPY7MJbG8u4V95y7rl05yeKrPLoRgBYZEdiJsaBzr2cGFn5xG/kuf2VY61KLqxx5HD+/cRMmvpjOL4rEPBT0wXkAXlBXBSanWwQFHvbBS9HRrKi3hwuCt+RD+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735264338; c=relaxed/simple;
	bh=M2C2mYblq5WwfPR3JTQ7zjObWujAbnG0RbSo75nAPyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LzeEGef+POHLWCPLobWmgNw0p9ZFlXX5c3cZYgEbSBS6EEWbuRowTGe0NBBUXCV+P4qzqfBy3rlmg/8NDkb2Iiy82JydCaNGg/Jq3Ksq2etZVUZYp0I8YsQzxnWmMfhtTsBspt4qsLFTGWwX7+CVWHLsFGJxYiCDYBY09D65Vko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiYyyiS4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166464e236so152523885ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Dec 2024 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735264336; x=1735869136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=OiYyyiS4QJIGLPWwuz59mWA05dVmPpPuPJOPDm14cxV+pV/nouFlMbxV7WozTBJXzZ
         /7PYWlcadiVgopQjw7ZF6iaVmvR+CVLbbO+kMlwSe2rR+Tjm95XwQ+PREA8OQ7Cc1lxm
         +CF9h+PwAYSSshrkIFrx2czIsLbSz8RBrPAVnckItoUZEwbr3JXUUr3edt2uLVMV4iyY
         f1/gVei0U5wzKJBcIyj5DWpg68g7wlM/PVkx/g8ThIjZeAhuuu/Nu8Ch2mmbwR3IXj2I
         DYpbD9VMqzRTaJlzaLyCo29NKV18OlakNeW8PM7xTa0LklIipq5KFYkkntYyqj4B+nkC
         jGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735264336; x=1735869136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=TIXIC4+2GvRD2SEsIWLW7GR3YzDt3kW1pi2Nb+IHJ22rDHEAVycYq5NjvRqTLvLW1u
         vqjWfbQtR6hPBbyp6UyG3MxFHVMwFycZAYv9559ixDueTYa62Kdfm6lM+KIsuOFMSqlj
         ++1X4J2O6NUmzKN/YbePTSbwO8+SasNamArXgcPj99aCCSh6HXeoz24JWpglbLXjy9JE
         WlIWy0elF8oWjrm3Yvq+cCTGb+5E/ev4BwaT11NkXJD1DuRAFAzEY8t473t1rV+jPupq
         uk/QKBm2upNWwzPyAiBeQsZ/ypP+M0HtL2IOTNuDUc4wVUQlLbxMfdqIafUhSbtOqReR
         2U5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTtfpucYiUdiulCukb8i+TlcacZd6643bWhv4K5WJNrHx31CS/Z9/AbEP/47b3e+RmVSpeztuTskL4uDZ+Vq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94UwkeFsJNFuuowNkGjIbSja8rPO+Ga6/zedULGnr1pu5qkKn
	UU0Gun7FB+sVqPssMhakJ8uyDyUBCwjopRdJ+x1+GhV7R0YKqCzJdHRA/4NwuKTNbAoyq2VXWPx
	Q1mMpdQVtBdBgoi6oHFLAu/nSCF/Ia32ffQ==
X-Google-Smtp-Source: AGHT+IHse4XovH7OCFMIjVWOPD1SQgxTAQ/h5NRfnQWPd1gX69b7atGrDkgoCdZnGb8GfH754+jN0PTv1D/JC0qrH+J2xw==
X-Received: from pgjg7.prod.google.com ([2002:a63:dd47:0:b0:801:9858:ef95])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68f:b0:215:63a0:b58c with SMTP id d9443c01a7336-219e6f25f6bmr358562925ad.46.1735264335985;
 Thu, 26 Dec 2024 17:52:15 -0800 (PST)
Date: Thu, 26 Dec 2024 17:51:59 -0800
In-Reply-To: <20241227015205.1375680-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241227015205.1375680-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241227015205.1375680-2-isaacmanjarres@google.com>
Subject: [RFC PATCH v2 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Android currently uses the ashmem driver [1] for creating shared memory
regions between processes. Ashmem buffers can initially be mapped with
PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
permissions that the buffer can be mapped with.

Processes can remove the ability to map ashmem buffers as executable to
ensure that those buffers cannot be exploited to run unintended code.

For instance, suppose process A allocates a memfd that is meant to be
read and written by itself and another process, call it B.

Process A shares the buffer with process B, but process B injects code
into the buffer, and compromises process A, such that it makes A map
the buffer with PROT_EXEC. This provides an opportunity for process A
to run the code that process B injected into the buffer.

If process A had the ability to seal the buffer against future
executable mappings before sharing the buffer with process B, this
attack would not be possible.

Android is currently trying to replace ashmem with memfd. However, memfd
does not have a provision to permanently remove the ability to map a
buffer as executable, and leaves itself open to the type of attack
described earlier. However, this should be something that can be
achieved via a new file seal.

There are known usecases (e.g. CursorWindow [2]) where a process
maps a buffer with read/write permissions before restricting the buffer
to being mapped as read-only for future mappings.

The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
that mprotect() can change the mapping to be executable. Therefore,
implementing the seal similar to F_SEAL_WRITE would not be appropriate,
since it would not work with the CursorWindow usecase. This is because
the CursorWindow process restricts the mapping permissions to read-only
after the writable mapping is created. So, adding a file seal for
executable mappings that operates like F_SEAL_WRITE would fail.

Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
continue to create a writable mapping initially, and then restrict the
permissions on the buffer to be mappable as read-only by using both
F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
applied, any calls to mmap() with PROT_EXEC will fail.

[1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
[2] https://developer.android.com/reference/android/database/CursorWindow

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/uapi/linux/fcntl.h |  1 +
 mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6e6907e63bfc..ef066e524777 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -49,6 +49,7 @@
 #define F_SEAL_WRITE	0x0008	/* prevent writes */
 #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
 #define F_SEAL_EXEC	0x0020  /* prevent chmod modifying exec bits */
+#define F_SEAL_FUTURE_EXEC	0x0040 /* prevent future executable mappings */
 /* (1U << 31) is reserved for signed error codes */
 
 /*
diff --git a/mm/memfd.c b/mm/memfd.c
index 5f5a23c9051d..cfd62454df5e 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 }
 
 #define F_ALL_SEALS (F_SEAL_SEAL | \
+		     F_SEAL_FUTURE_EXEC |\
 		     F_SEAL_EXEC | \
 		     F_SEAL_SHRINK | \
 		     F_SEAL_GROW | \
@@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
 	return 0;
 }
 
+static inline bool is_exec_sealed(unsigned int seals)
+{
+	return seals & F_SEAL_FUTURE_EXEC;
+}
+
+static int check_exec_seal(unsigned long *vm_flags_ptr)
+{
+	unsigned long vm_flags = *vm_flags_ptr;
+	unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
+
+	/* Executability is not a concern for private mappings. */
+	if (!(mask & VM_SHARED))
+		return 0;
+
+	/*
+	 * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec seal
+	 * is active.
+	 */
+	if (mask & VM_EXEC)
+		return -EPERM;
+
+	/*
+	 * Prevent mprotect() from making an exec-sealed mapping executable in
+	 * the future.
+	 */
+	*vm_flags_ptr &= ~VM_MAYEXEC;
+
+	return 0;
+}
+
 int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
 {
 	int err = 0;
 	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
 	unsigned int seals = seals_ptr ? *seals_ptr : 0;
 
-	if (is_write_sealed(seals))
+	if (is_write_sealed(seals)) {
 		err = check_write_seal(vm_flags_ptr);
+		if (err)
+			return err;
+	}
+
+	if (is_exec_sealed(seals))
+		err = check_exec_seal(vm_flags_ptr);
 
 	return err;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


