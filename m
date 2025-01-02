Return-Path: <linux-kselftest+bounces-23837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DAA001CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 00:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2D1885EEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23D1BEF6A;
	Thu,  2 Jan 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afrt3Pj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A221BE23E
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735860785; cv=none; b=gMwa8PkLcFiPRWv6yllzpNxSuyXUlGDbu8VqsX75I8IjxmXJNdpalS/6kaVsI5HOTkrF9tKnOABgQoO/67jOBIDRdu3MlhoQ3XGRKVlqNchxOLxsARHJujS9w5Yrf/TmP8Dj8T9+9dpXuUmD5dF5JHkp+TKySqHLEW5rC/AR5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735860785; c=relaxed/simple;
	bh=M2C2mYblq5WwfPR3JTQ7zjObWujAbnG0RbSo75nAPyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIGkgbebD5Ezs7XVcRP5Aa6WWsyIxINDbeOg6TzoylmdDtJ8a9B3HnA1Ge3kdJx1qn0nZR0co/3lge3msvryZuad59MjF31E2GN0HSuwdBBtEgZHe/Cl8FMp0rmkhdLREZkdV5Xo7v0AYe81suczGGls6TgCL7EHq3ZUr5xPf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afrt3Pj+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so16413987a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735860783; x=1736465583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=afrt3Pj+qMvwiduV+CMhNRkpJveCRqWYEhRflesnOfLAjG3/W1OBxR0FSxTEpJD5J4
         HqiSv3TSU6TSv/LB871LyRR08+GWVoKAHlcC61HVtYjAZQ6bUVv8bNhe/7DxCmF3lkyH
         Ilkg9oG8L4llk+B9Jb/ONhR6MTxjGIuyGO3tXz3J3uxEwpIFSsXZAx2NeGLsh9VXYQ3t
         HCvF1Fsz1FUSpBqeLa9Rvn5J7RQ9P48FffIGfA5jF2NBh6Zn7Jplmc6R+9+eMe9Yj26g
         VZTTGGSPnaqGuhabcxsLzEcjTil88+J1VqAtNEnb1OQ54JJOzoh9tzinsFlJm96kZhX0
         W+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735860783; x=1736465583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6yaTDfkaNJVYvN9IEtl+N1Z6cSe/++H2abnIIHWux0=;
        b=l4BLBV0rjpJMgse9eE1veiZqLhj6sPuVPDaWf7ncAggI1R0iTjlN7J8FLLsgSPIgnx
         1kDLTWKRpe5gmYjQa6qbgSHnbuB+uVRdftqtgHtWWqrYX7MkFeECFZhWOq8UV3HWxskn
         cj65A93GBq1BUUCk+GbdsO5jVgqf5SnFFWXjQl8/INPmQlh8ixjU6B5SqJhMCR2L+XJq
         YL4y5AQDI10mAYqrtBVHxqmMg5zCCISm9ul/VTbho4rz+BUrGILtoFOgqUfAHQIyhCpf
         p6NHwwmbZEAOZF6R4FaA7Wk/d0KjQ3aFAmjTWHnlBoL+U+YU/bzZgSjv5FptVvgG3uBN
         0Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCV3RZ6hNJSVw9j2d2dLumE9ryVWYyUObdRHRli07sbhiKC2HVTHxcYVW2JHL59Z8W1JE4R5EEcmTIMIqySiOMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxlKgmcsOgCYlfIAqkERd2YRxRa8KCYi1cgkMFuvXCcIpMYkJ
	8bZcc0jG7CI+E4OYB2mYVXdtjKjSjcBrfGnm2g02b8P9eXbng3sDSf/GvmsuwC/7+3TrFlf3yXt
	oENncoIyQSAO+oP5uOhy2o3NtFG79w0pUDg==
X-Google-Smtp-Source: AGHT+IEHpT1wneDx2QefehHIafdQKlpZShR73+0EcuaPDdyhvMMTjby5J8JbVEp815hnmiWSln6qPCmr4ccXbyU/1PWS/A==
X-Received: from pfbbw10.prod.google.com ([2002:a05:6a00:408a:b0:725:e84a:dd51])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:92a4:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72abdd7ac89mr65635875b3a.6.1735860782779;
 Thu, 02 Jan 2025 15:33:02 -0800 (PST)
Date: Thu,  2 Jan 2025 15:32:50 -0800
In-Reply-To: <20250102233255.1180524-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250102233255.1180524-2-isaacmanjarres@google.com>
Subject: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
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


