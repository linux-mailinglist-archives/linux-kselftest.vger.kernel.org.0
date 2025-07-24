Return-Path: <linux-kselftest+bounces-37956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2397B11150
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D41EAE4D58
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3142ED15C;
	Thu, 24 Jul 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDbbsQXz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6A2ED14F
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383602; cv=none; b=qUu7abZ0DzkUONaVIvBbP0QhT7NS/bAtv1VVXL9nFVvJ4X+k/tQ2FJ6aVOoOLMszeXUBeUYT/GBToTrV/gg5pFhC1EVp2WLCt6GNOhiaQ/vzPDKncyELIyUBbjPyuxnAO+EZAGS8IMV0feYckGc1SZnrWi6vgWbX10f78X+g3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383602; c=relaxed/simple;
	bh=w3B6eMOHBjLahJirDSZ+qk4aNUA7eTY19kZ8xkUuHVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ndNDs6XNewcFlMloIW15e3NfPRTtHAEu71DHA+h/HvXkvmrTAAF7lJO0S7R0scbpY/VnWAXlMWtu5NgL59mwxKgoXaqRCALPJzhjtyqz64+xLrAZmKaNCoXx1bT0ovNbJfqS3nuhuxr5Ya6HLFtRxiWiZ79bnr/B3CyEgTiA3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDbbsQXz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31cb5cc3edcso1233729a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jul 2025 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753383599; x=1753988399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=MDbbsQXz7SrhjWMZtLw+00dvixeovCdUXkMAdtUcPQ95XFzNEEa/3o///0vaxQ5VJ1
         X1NWrVjZPYnqDnD/pXyXhsJG7bJA+YkW9wYf2o4cJ2JLIB67pMTtylQt/pLYzugU8oMg
         yOlP9dyf4gOrKc/iY09qha1qK5NNjTXPf3uDOk9Rhaf1YwIgYqWo2n7i2Il5dmlDZlwJ
         7h0Nm5Woa9hMcbcWyrYVALMTT5ak1YTUJyxkblu5tdiT9SQ1vBcSB+BCR9WIeSj9ftrC
         lRMVlJzf97T0o+7NoIEYTN+uPiWcA2oLu9Bkt9vcNlq1ymCqRbH9gf5ia31xNlXc7emZ
         Rjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383599; x=1753988399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tolIyg+onFM/Vs+iMbCZXFo1uDxs6ZbvglnTYfZXx4=;
        b=PPCoxM8ekMTSkQ7M4thbGhVduYeraQ4Tlg+uahZHD90/pRcCVhAPtuONYGLtG2DkNO
         zMuoRqXzkZASzoG7T6jZDuv96RqGymZqs+tjK8PKWZliKM6+miQNvSV1vdBBIgJ0sxRY
         Tsxjx+iJmutlE5HT9XH4VRp6FnxxPgSBMAtrjQSOVBB67dcnCKFwnJ5KPwRJmjOU8mDs
         seUx4anBsSLRwRszEedjNT17h87B6FFY8MSswsZcK5ObEDsRe3AmbQ4jVtD3b6R2WarK
         gTSYMuiUF4Txt0SRDy248O1umVsitDgd9FK9NwcvoCJ2K6cHkyHbPvC7uQjywUTOkTud
         6GKg==
X-Forwarded-Encrypted: i=1; AJvYcCU/jsOrzle3te2nf6YApbmpajjDmv3nvdDVjgDyhJ/qo0dBsYV0158eQg9p+tFGtVXjCfDiLXFcpBQ0bH3DWTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95gCpkxR2F5IwaXMZM2adpsEWxAMOzRo3r+15p3TX2i2bXNxG
	LfYOBUU9aKY1BLoUuB4FLJePE0EyNnS2mGuKDkGB32ROIamUvISOeHrW6DsbfBN1IUnOsJ65kvX
	A3TKy9U3FhQbo9Q==
X-Google-Smtp-Source: AGHT+IHdSmYA7tBV+nhnrXBegpyUFMJCJUqsFgS7Y3VIienq0ec66CAODnssF5FCA5QAA0NO/7OfjfuiK5hPRw==
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:312:1af5:98c9])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e88:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31e507e916emr10640089a91.33.1753383599400;
 Thu, 24 Jul 2025 11:59:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:58:58 +0000
In-Reply-To: <20250724185922.486207-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724185922.486207-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724185922.486207-5-cmllamas@google.com>
Subject: [PATCH v18 4/5] binder: add transaction_report feature entry
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Li Li <dualli@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>, 
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


