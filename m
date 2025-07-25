Return-Path: <linux-kselftest+bounces-38006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEEB1242C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2072D17FFDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D41252906;
	Fri, 25 Jul 2025 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo7pXPfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16A252286
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468733; cv=none; b=mBjGopdgCMJa1lYP3oQdK52StnBEiH1ZYSkO97l+ULLZAIY9o/gmMLno2ObSsVr5Dam0gfdicNI5GKRH0WYVcP4dJgMpRStnR/eY109fHAUup2pGC/Ef12zb0dCuBSLOpjRyDH4L7TbPzUM/cYITNM6Z3GiFLI7CwZ/6R3f0FQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468733; c=relaxed/simple;
	bh=w3B6eMOHBjLahJirDSZ+qk4aNUA7eTY19kZ8xkUuHVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQXunW7PCwogvf4krCoiSCwVQwT+A4mx3kD0ilNfV6ofQG1jvWnn0MCnFElAKWmHFVCLBy2ljQvvklunCdAfc1yk5ZOX0M/HFkrnuHU1ubBxlYcSzN1uNqPEqZIIyw87WC3X1dsu+q+4fUhBFCn745pJPGWLwH+/A4fVktroWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bo7pXPfT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so1827628a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468731; x=1754073531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=bo7pXPfTobvcrzBD3cgapZj5+D3Wngc1hLfOycdqLMGC/ZxLFvuxcm6txF2Y381sVv
         XMBNk2jqL9Jj7ah+LP9BUksnUTVHVmdxFzxRmhX98try20g6P+s2wb0wEqEzq22EQJ0+
         ReqcW6Ub6NqGSP2m7LP3HgpdLLqwS9BwKep3CbJ7wWwA0H3slUaZzYg+So6lxIUCawbP
         mX4/TiMvdG+g0B1LQdt/c1Ee4hGowyuE8bhLWT4NYFociJeJqWTbFB3A1FnZVwAlKb1l
         G7Eyv1EYgBeYcRRBV6ecS0yNYsQUXN3kheGBbMYTstGu0n6SrW1xNxUSJsTwhv1LryIq
         cifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468731; x=1754073531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=ICncJ5LBCSyTqkYgPSx7F+hzrf/DhJOYpmF5FF9EOBtfi9JeBf1G6I5W3zFwCIixuK
         kFAee98F1uKgkWb07ilx0zvef+McB7VT4v9kHixMIjj8e8MYZzTWxeXSnhJfx5brk2oH
         alFxlfHUBspMv0vJW1SCxi/OBsQ8JeQ55N7th8MM9gkiP5KS1E7SpRBJwA6aceEGHQvK
         92o1OI57C1IsH4Th6FiIUqcn/Pjnih+LLXHRML8TvW8qBARCVi7hlVnFoIXtEv2xJVCk
         XPYO2ezFm7vVj7CjYVpcotzksu5olC8bRE+FCILDW05l9D5/8VmOHP3GYtNJPm3OodR8
         V8zg==
X-Forwarded-Encrypted: i=1; AJvYcCVmXr7gLWgDWQnYPquzKeXYUccM3Lwym4L7QqXLGGWtsRSj4eWB2HkCzc0lkqRUESGoAYlpB5XBCzGgAWpn1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCg9q6OVyAs9lqaca/x2tf3YdkT32MtuHez1giTPa7/FS8lNK
	OWngBMTXvOJg/HZRyJcJnErGzHsFgwlql0kGdthOEqhCeKb0DLLcZ/5CCYSqhebl9qtUX+Nqh4K
	FVvFDMJtFhSfyyQ==
X-Google-Smtp-Source: AGHT+IFQW/i8kOUdRjsXpgwamCzbOi/bLorIQ5DSxgTzYw6hRRyy4AJJJQkz2Dq9WZFz5qrLnV3cEr6OV1P+8g==
X-Received: from pga13.prod.google.com ([2002:a05:6a02:4f8d:b0:b3b:cf3d:91f])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2445:b0:232:36e3:9a4e with SMTP id adf61e73a8af0-23d701f8204mr5451980637.40.1753468730810;
 Fri, 25 Jul 2025 11:38:50 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:37:47 +0000
In-Reply-To: <20250725183811.409580-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725183811.409580-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725183811.409580-5-cmllamas@google.com>
Subject: [PATCH v19 4/5] binder: add transaction_report feature entry
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Yu-Ting Tseng <yutingtseng@google.com>, Li Li <dualli@google.com>, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Li Li <dualli@google.com>

Add "transaction_report" to the binderfs feature list, to help userspace
determine if the "BINDER_CMD_REPORT" generic netlink api is supported by
the binder driver.

Signed-off-by: Li Li <dualli@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 4f827152d18e..f74a7e380261 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -616,6 +618,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..39a68078a79b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"transaction_report",
 	};
 
 	change_mountns(_metadata);
-- 
2.50.1.470.g6ba607880d-goog


