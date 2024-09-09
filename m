Return-Path: <linux-kselftest+bounces-17500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B059710AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08081C222E6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026811B375C;
	Mon,  9 Sep 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOuqIbI7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57C1B2EDB;
	Mon,  9 Sep 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868620; cv=none; b=ChD9zDrAI2VsfW3fgwbEVAvmzOowojNZQatuRJ+LPbfk1K4AiQEPaqZo7TTDxWPBvuoCmKbGWX5HVmaN8XMNYwmynehTllkBY2vc/RiC8xaHJCFk4llH4IzDxNqzGn7BU11XzmcyvTOuyC1FJ5KkDqUvaJmoNltNpXY0C9ZG0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868620; c=relaxed/simple;
	bh=NVz7zWvox9Ub9w3XHRPAAOTfOKsLrEprRMk+e9bPc4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foAI3i76cagE1ktevqqtR/I6bJbSL6kZ0J1gJ0F8X02vLMOEc6JR597Af/zegsT2uk/yJvRwR/UV1sgvR9dCHGdtUE7Cdj3UC1Si54acpfceP2apTUjwZKZvJpWvY8m1phQHpzDcAv4QJxvOjbOMj+5ht8WcWzTizfCGUJAEb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOuqIbI7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb806623eso6120845e9.2;
        Mon, 09 Sep 2024 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868617; x=1726473417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjWx0r6W+Y+t7FzaeoDZ7q2Fdghbi7J4Jwrj3xNRS3k=;
        b=FOuqIbI7dYfXLGg1XZMBZQ8ww02Ngm/Yi8twlcygDLNihEH1uORykdZ9FnWAaXkKOe
         EVdVLHbl1kuNIR+PlWAKw2annAOghmhNyhnzBhiX5EmbFEhXchWYBnvIJnTaPAOo/uRN
         b9XAmTBlCYiP2ewSQGulSTV5rHkfwVfIlyzlHIZqPmhSCxewdlQWFGVSxbmKCCQG+vUg
         wt4G9bejuT47pXDsKxbGQF1nm/UePRRqnWeQ/SoA5U7qeTtGhq6rljtJQCS7q07BrcPN
         Cd80z305q03QB6T0OJplfzBzQQPDdaGWSgGwJnUPUQzSyBbT2yXbJvKmFuBT5lkKySNZ
         NUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868617; x=1726473417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjWx0r6W+Y+t7FzaeoDZ7q2Fdghbi7J4Jwrj3xNRS3k=;
        b=JhWPUx4uh/1RtWlpMqmpVwIKJTYUoxmX0Ezqg78eVICGL2Qp1lf/9XHv+DY1bwAZGS
         2s1FH7qPUkNBqEayyq3q14PFWgpqZozeLVZ8HMslLaxNgDHdmI+2aJuEh/isbowS1K4o
         OSyXa+5nlDTMJ9fBzQKm+COjtqDFSrL6lk8NlJ/SDqtf9X3dI3Fp41P03HnfIHlM1mQx
         YPyRdqAPz5QMzctC2qeL1RBiR0JmR5Za/rfE+wiEmD14ia1oAoKgxM6M5hUezCaGdt8d
         rmMIKHFizabf7yTpfdtI45YPGoR0noI6mo0sf2K9DlgPC9POR8FCXK/Pk8SknScFhzfo
         jOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ks3U+TsnmZ2F2lwNxBYvOBqiZld/Rs6Qjt0o71gHHosYQdOQTaQ9tfXpQjSE5llkxuSroihmCw1KFTbG@vger.kernel.org, AJvYcCW/5RHtbAzE8qF3kFf4tymqanKnPa5DxmRo7x+M4y8CPEa356HRHnlDgxcj/b8nMzZkMi4+wHY7zJvUrCQYCt1l@vger.kernel.org, AJvYcCWX+pTidrXI8Sw+fsKb51ita/GpoCBnLvWoIHpffA0ZzimkRM7NR9mwz6K4BmTab6fPoF5ODtS2dVlvZgsRgQ==@vger.kernel.org, AJvYcCX3tFpumNNOarz5TOOsckreiaw5IefMBzL0jt5MwGYu4PBoIQaskwsCO4jAP3+VQH+uvnEXQmeDbJR1pQ==@vger.kernel.org, AJvYcCXGSqPJHHmLMyVd4nrdqYYKmBeczBF+fietgs4H38/m1ccY96+OlK4ytaswZvY/rJ+WFbU=@vger.kernel.org, AJvYcCXKiWa0rE25L/CkUMnbRCCmDV/wvfYnARvJALsndj5Tx8i70/vfk8MxX7quuvlFLN7UQGAE3j8KMoJHjzbf@vger.kernel.org, AJvYcCXe4GiSGpecLT8Aw49qZxezSnVig4ULYeZgQqVDkQ1IrjqHvL2L42tk8wjFf8y07vzVPEJnJg+3cAMhews=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvjCSbGEr5qRPCdaIFcLkEsC1rIe5p8/XWD8IqLYB9ueBcYiL
	/HHPGajINKiROhdAoQE5S0juoIQvDczoVSeq+JHyIrbkHwW9+Vi9fEgp7j5Ich4=
X-Google-Smtp-Source: AGHT+IGbp7ULiuTNUf7vRfm8ezmMj4Ynf6irlpbF3StQp/S9yZeLlgA3L9pUiafOY1eFXvpthfwEbw==
X-Received: by 2002:adf:f6c8:0:b0:374:c945:2569 with SMTP id ffacd0b85a97d-378895ca6f2mr7015316f8f.15.1725868617528;
        Mon, 09 Sep 2024 00:56:57 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:56 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH RESEND v2 07/19] fscrypt: Include <linux/once.h> in fs/crypto/keyring.c
Date: Mon,  9 Sep 2024 09:53:50 +0200
Message-ID: <20240909075641.258968-8-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <linux/once.h> header to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2: Include <linux/once.h> instead of <linux/prandom.h>
---
 fs/crypto/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 6681a71625f0..82fcc5683649 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -22,6 +22,7 @@
 #include <crypto/skcipher.h>
 #include <linux/key-type.h>
 #include <linux/random.h>
+#include <linux/once.h>
 #include <linux/seq_file.h>
 
 #include "fscrypt_private.h"
-- 
2.46.0


