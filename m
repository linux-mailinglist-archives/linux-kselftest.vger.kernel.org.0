Return-Path: <linux-kselftest+bounces-10211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F338C5EA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BE41F21C7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC05CB0;
	Wed, 15 May 2024 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIjV2Gj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A144C81;
	Wed, 15 May 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735306; cv=none; b=u8NXwtXA5oMvc1E54eHS0GHuTUYoED/dmwfVMYzTDUinwKo6GJKP95kjKeviWRgAXzVm3EGN9VrSODS0HB3s/OWKUs2owLSQfhNHKtqzMo8NkatVQc+zNFvd1Y31eArt/Kzqow5kbCPeBTlD1I2MQQ3zRGOcjIv29B/RCiiRQSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735306; c=relaxed/simple;
	bh=oyJWajRkLDqCw9oJG9U+0dlQmfxVnFzaN8r6oj7GOCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxRF/Iy5T0MlWiACM8gwEBhMNQjjAlB5PWFDVGSXf0bqqcllFVCYhS3mYloSnY2rLfCD0DoOfHXz4xRmVj9Ma8+ar6Iy2q7FQCwpdeHvBWdp1JgH/0phIKs3nfKe6bEvk4Cu7A4bJZFGnFRoykiTV4+4qbuGFlwCd+OX5gdoTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIjV2Gj6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1edfc57ac0cso52098065ad.3;
        Tue, 14 May 2024 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715735304; x=1716340104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ArnKmY2SNEE019PWvX0oi4RldbPZEm9aOqhpk2Km3M=;
        b=VIjV2Gj6S+E5d429Dy1NB+RmLJ79PRW+/l0OIPXYQxxCykTY2bESfhtXgBT/+mya7I
         nxHtCEg7yQmHOxiImvEp+nGHSh0niVYdnW7+kemXSZ8DCiQXa1bUqSVGSOH4aPOWLpGl
         aS26/+WqKooQ0Q1Y8sfO+8ukQKAhkLHFq5v1q/3ffBYbPMJ3Y18lAHVExbnrXtLxz008
         n48troy78mzIdAGV3YtSCu5cppRe8bn6qBl6OR7sw5Z1sbHmUu+xGBOwfrnVY+D+T8kQ
         PkQFxBiaikBVLdYlq+iDUxY/V3kUaIw/2q5QTLFf36B9LdAR33pMZxHzejkXvhSQVLLH
         gClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735304; x=1716340104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ArnKmY2SNEE019PWvX0oi4RldbPZEm9aOqhpk2Km3M=;
        b=BOEbDWBY15Bp231ODY00txdW8EWKQtXGic3dXp4P5x//FPXSRkdEJimWcuP3cWN9h0
         Ndw6xei93GxIkBI8CKf/9yuNQQzJ9i9yae4FFBDWWJy/OdrTRaDYoNXrDtIguvIHQqOk
         wg7pRhz3QBFJHW1uQjMHioy0e8jhPWuQBUZuwi5hlMXkZslOsYNrq19FwDMXOdm64FML
         8xTz3B/zCivIY83pcCi66uvxUVTHYrFs7IDBvmu6W6SRSSpk6mTkUjZNqjMN5yVUqbwr
         /vzF+prgtkX+TvV4h9W08Fz5Qv4b0VQQDSfLL1FhNVzttZGgAwRoJqAi9BmT67iLeEfa
         dv5A==
X-Forwarded-Encrypted: i=1; AJvYcCXeyuVP+nPEknlmR39zOwL8P/lLTROTQbZPHePs2bGEnLu0XaF2iApz2H6azZQTKrw8XcYpooCEhIiOUDMWdY/0QmhDUEoUqLmahlak
X-Gm-Message-State: AOJu0YyyGQ2/5Xq3Z7OFHhTksyysdQHnzVW6Ex5R+LHe0PNjkX112XYv
	neTKajnfig8pqXijlnab7S06WmA8t8mwflV0DszKt9iZtK8A8BiupZhLr3fHkrM=
X-Google-Smtp-Source: AGHT+IF135Fit2u4At4WSiYKdWhQq3a1gyLpgbaK6/+dOWZFE+pWu2CSdp35tRjLjy2zY6YVBFNOkA==
X-Received: by 2002:a17:903:11c4:b0:1e4:9c2f:d343 with SMTP id d9443c01a7336-1ef43c0fd9dmr166471975ad.7.1715735304007;
        Tue, 14 May 2024 18:08:24 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16cfsm104973325ad.18.2024.05.14.18.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:08:23 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 2/4] selftests/binderfs: Update close_prot_errno_disarm macro to do{...}while(false) structure for safety
Date: Wed, 15 May 2024 01:08:03 +0000
Message-Id: <20240515010805.605511-3-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515010805.605511-1-xandfury@gmail.com>
References: <20240515010805.605511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enclosing the close_prot_errno_disarm macro in do {...} while (false)
structure could prevent potential bugs and undefined behavior.

Example code:

    #define BINDERFUNC(x) f(x); g(x);
    if (condition)
	BINDERFUNC(x);

When BINDERFUNC(x) expands, g(x) would be executed outside of if
block. Enclosing the macro under do{...}while(false) adds a scope to
the macro, making it safer.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../filesystems/binderfs/binderfs_test.c         | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 447ec4296e69..4a149e3d4ba4 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -28,13 +28,15 @@
 #define PTR_TO_INT(p) ((int)((intptr_t)(p)))
 #define INT_TO_PTR(u) ((void *)((intptr_t)(u)))

-#define close_prot_errno_disarm(fd) \
-	if (fd >= 0) {              \
-		int _e_ = errno;    \
-		close(fd);          \
-		errno = _e_;        \
-		fd = -EBADF;        \
-	}
+#define close_prot_errno_disarm(fd)      \
+	do {				 \
+		if (fd >= 0) {		 \
+			int _e_ = errno; \
+			close(fd);	 \
+			errno = _e_;	 \
+			fd = -EBADF;	 \
+		}			 \
+	} while (false)

 static void change_mountns(struct __test_metadata *_metadata)
 {
--
2.34.1


