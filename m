Return-Path: <linux-kselftest+bounces-17479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35139970F0B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E441F20EF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2A1AF4D8;
	Mon,  9 Sep 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GobHUOVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849F1AE02A;
	Mon,  9 Sep 2024 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865711; cv=none; b=UC+KhmighMneuoAvzP+BCykuEgCSrhC+0iwfnZRB16ukY9D76Q9jrm1cOrFQCgdnd2r2FKd/0W8B1Wu6iVkE5ax2zVut7eGY7wHRtcGrocabK2hqnMC1u2ogp2BsIOovP/S2/Rm5GAC8mFXTGhUI4o/iRv4Us5aD91yG4rsGKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865711; c=relaxed/simple;
	bh=NVz7zWvox9Ub9w3XHRPAAOTfOKsLrEprRMk+e9bPc4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbBc0JV0VD79F4AmfY6EvorrD1n21ex9HbXlKRdkb5aXfl28GxtF7OZ78Dlpk3dRedFO5GgTRRKZooH6zsBS0HBJByRsD0h0669Q80Xg9jAns0skBRNsPTepzK0ASrrbKnumrpip2znvH5z3u5jbNzFyGB0zf3+TJ/9e04eZhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GobHUOVt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so482375e9.3;
        Mon, 09 Sep 2024 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865708; x=1726470508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjWx0r6W+Y+t7FzaeoDZ7q2Fdghbi7J4Jwrj3xNRS3k=;
        b=GobHUOVtMpIazPvRGxsyCpjdGTdrOGiIkQ8Kbbxc6qSvG1Lo5oba8MB4W4r5CBCQuC
         ZOcIGqLAKZhWimWBr5anLr+43rLcgKV4eokirkHl2i0dK954Lijl7bhBWP4AQxVGdLuN
         1AVdDnJiDxpbs5nx+E/j8y2BL086WZj9MxeZ+T2+XagZ+OF7oQGfngXQUPU6zjb4N7+c
         6vuUw8ZV+o4hu0N30QoKWZPDaNJvBfPYFPuwDIHpzIfJqTTKtBgtC08wYAIE5Hsxqha0
         K8B4POOq1Of9VASanI9JCO+tLV4UvV5wRosQq0i6gboHYIrOZRfEkRhr2Uym/YnnY/Yf
         vZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865708; x=1726470508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjWx0r6W+Y+t7FzaeoDZ7q2Fdghbi7J4Jwrj3xNRS3k=;
        b=pZ1pwat5H0QHIPb9zVgIXQPo3WuuTy9JO+nWNTEzdPdZbxbz25hLDRJTGL2QPjhEFx
         4RsnsbG0ezHz7gJVRSwYJfHK1TRT1BtFZgCGSMCmKqK70ahTHrdOaLpEeU4YuWEUev9G
         TeOftyfgm3BB41VFYMcykLRNzoU1RdcYiJ+mv4TeoH7CWKaO1KXvgC1Ldc6DiMy5utEx
         ADPV6oEvFEvjn7sgLVeeP8JMeMTFgWVxYsZurw/t4TJD0R5Re1r8AAMirQ2A9UBNnsx2
         cyMoVB0EsDr5Di9nLLPeInf97QiRRN1yCSiA5xgWh9gAvFh+krq2jF6BjGqDiG+k3yqG
         qGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzf9GCwzvxbSGq9m70MJq4lHyq8iXoiMnjdL+TwIFsjQtffFEr1bAaknvEuPDmLzyFS4oG6ei7wt5IQG/uKhU@vger.kernel.org, AJvYcCVHY7F0He2I2vm0db8i7OCIzcJCiee6CiCWiK7LlHbetMFh6H8FFV3Y2vJwztXAlEkCkjFER+eEdCMTISI=@vger.kernel.org, AJvYcCVakOxURmQ/366q4GcbFWfqjIzvXZlOoH9AxalBSemnUFthuucwRqlP554s1YffBhhlV/LWWqjZwt7NVw==@vger.kernel.org, AJvYcCWH4HAi1aMd0Uwt8dyoUkUVFULcmNCLobSxi6X3anXQnB1A2Fzp5ty+gzcJ6zmrzw8BAs0=@vger.kernel.org, AJvYcCXsmDFOqb9wBQ0DtOzOonnf+5fJZnwRQjHD6wxFPWkuF36Q4+ZlCc6z3xtyOcyNmNQQGJ2vLBsQN57aPBP0UA==@vger.kernel.org, AJvYcCXy0mL5AHO4PWvkDzf4UjwRYyLMq+jNfKClZqLyPYgXGZgVaQFqp/zgs7BFo8GDRP8sgTSOOSHuyO45/6lB@vger.kernel.org
X-Gm-Message-State: AOJu0YyHe+xPy+UhqiRp0h36Qba4lTvpFkACxFCMhuDsNdLawLTcDLGM
	dbQw2X4hpKwnWPMfNioBtVTsbjngtB7Zv6LIuu+ChhCpVuobxg67
X-Google-Smtp-Source: AGHT+IEUtqMurgdDVKYp6Wy50/2d2bJzb900f0HbaSF3BqAdcqhbaOgpHL4RtjOgNMEwMLQjmxS32g==
X-Received: by 2002:a05:600c:b58:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42ca574652fmr62131005e9.29.1725865707608;
        Mon, 09 Sep 2024 00:08:27 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:25 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 07/19] fscrypt: Include <linux/once.h> in fs/crypto/keyring.c
Date: Mon,  9 Sep 2024 09:05:21 +0200
Message-ID: <20240909070742.75425-8-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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


