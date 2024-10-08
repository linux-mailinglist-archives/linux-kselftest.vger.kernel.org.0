Return-Path: <linux-kselftest+bounces-19195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0B993DDE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 06:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD031C23F85
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D0D7DA87;
	Tue,  8 Oct 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="alyBN47R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398933C0C
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361091; cv=none; b=eOqD5/5tG2jIPHbStbS1ZervcKXigCJ58bG5cWG31kPKsYdxgr5OD1nJKYpQAhYF5nFUlKc80GEyCQxqZmQkOw8jzJ2jzmS4KsrjfPw4Q1SG4LeAIRS8hFSYh3LlYKm9xOmMQO9iocTK2xhrhaM2NeS5Ea28FP/rtC4/tx1VL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361091; c=relaxed/simple;
	bh=VSZhSzhnbdu2NNszsJIrOuSYNRWmYaP3/73tTqZqx84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhZEcJGa+eTVhVRZkiYCPj7FnEWd5OnCK5RIkpIQei4rzclcBb/9JPlnLJJCfrnnkSJbLYPCryt0CtVd+MkAox9MwA6VB5b08FNiC6KVODGSxekxSu35lohzAtJb/fG/lWq15w+ouLz3XkoNItOQ7b4nTiaMSY5SS+NMzyccEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=alyBN47R; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so638681a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728361088; x=1728965888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=alyBN47RBaxB6GiJTR5sc5kqoidS0N9tcrk4Ypz1OsaKm9Q7FrBefq15hwVkzVNEiE
         LCdv8E4LhZbmIxKsnnWpGEzN2noH/SZtKzArHx/givDt6VEfcbK9fFRa18IFOXwndHVY
         /uP0XoEySMfjDnfkFmwT096TNhbJazNQCDMSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728361088; x=1728965888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vVQPrureiyHbwYAfJliFzmOeqMNDULWaSzE3MpLwxE=;
        b=bHfuS98khviafmSOOHIdKs1DC70UWiUoF0z68bAPNVmrTsPRg8fk1mhM0ZF37XPglC
         F9w3RbVKyW3mpXLt0XGIyTzXyHVn28POBabrBwQ0rmpHlwiSNC7X67Ef0TqBNgebkQnN
         BMPgSqrkLEZ8s12aJdnmnOrAnBcFf0QpN1JPrl/Mn2hwT0phg+qbGD9fXC5pSNPjrrLc
         z17ImJ4GFyf3H8oelI4LFw9CsIiuJXR5IXZEYNt3jWp5dsnldeODahunj/A73RBRhnRH
         1w2Mnl4p4SUKhWwp/33An2PNmbQfeYZbyxtuRggaEW3gDBTHRN2xyC7IS6fPLSoKXYp6
         Ch7g==
X-Forwarded-Encrypted: i=1; AJvYcCXmfg0DtAl094BAxKT53AF6xHlZpUfaRip0KViwT3Lo1dAko5D1eba9/tb+3ZodwGoq+h+kalzwrSw5KPyJpvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKMxJd3VSw+xhdNuQzs9abcg4xMQ1H9O8Lbodq9Df7icWCufi
	txntVoouI9EI5hOj9SsX8M2y8MaDJ8co6AK+callNFAGURqdCoaKFDhiRECWHg==
X-Google-Smtp-Source: AGHT+IETmZkdIfaU3KgL1a0e2OY78XhZ0gDO7l0Fn6ylun8F9SxSWEg+1I1jGGXk76KQfXMjITSOzA==
X-Received: by 2002:a17:903:2345:b0:20b:99cd:c27e with SMTP id d9443c01a7336-20bfe02ba29mr86787295ad.3.1728361088521;
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e1e85da3f0sm8049197a91.30.2024.10.07.21.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 21:18:08 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH] mseal.rst additional fix
Date: Tue,  8 Oct 2024 04:18:04 +0000
Message-ID: <20241008041804.1481453-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008040942.1478931-2-jeffxu@chromium.org>
References: <20241008040942.1478931-2-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Change "overwrite" to overwrites"

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 Documentation/userspace-api/mseal.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..54bbcce330ec 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
    The first set of syscalls to block is munmap, mremap, mmap. They can
    either leave an empty space in the address space, therefore allowing
    replacement with a new mapping with new set of attributes, or can
-   overwrite the existing mapping with another mapping.
+   overwrites the existing mapping with another mapping.
 
    mprotect and pkey_mprotect are blocked because they changes the
    protection bits (RWX) of the mapping.
-- 
2.47.0.rc0.187.ge670bccf7e-goog


