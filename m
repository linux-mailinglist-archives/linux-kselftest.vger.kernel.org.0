Return-Path: <linux-kselftest+bounces-8723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579518AF681
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897691C22B63
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4131013E881;
	Tue, 23 Apr 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbMzznh1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2013E03F;
	Tue, 23 Apr 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896841; cv=none; b=tlDvCAIZwdreu4nAsJ4vj+xMdwdumnruyWEkB33R2AJ9MrBbjmaCWatyUQHIo8pYsk6QGFB6r0dxaQWbveKkGpnxwUXSr6U1rFL20XaU8rknILpiIgckNBmFlVo9f+oo/RJ8kSwJJVHgOxoYZZI6XkDxvTmmFmtJnrnrb/8ueQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896841; c=relaxed/simple;
	bh=MUhKyRYXyetdQxJjp1fJdiGhO6ynyEnnzqak81R4+Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CA1Sn08Fm9Pr97M+Y3eKZUFttZB6hhg8m6BtlwZICB+4P69EOGfuepa43PTe2FhUv2oTwpeaOrN34I/w3WPRnQQ13mPCN1ZGyI8X6wkx98ATd/EsbqE8rGcdOCvkj5oqXH38ninEdx+9YZkFuZluZ+ZAUzzMVyW+OK+Dtf2mWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbMzznh1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-347c6d6fc02so953933f8f.1;
        Tue, 23 Apr 2024 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896838; x=1714501638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRREGXZ9LGwcYWVEeF7p0krK+m5v21ptFkL/WS+1sYc=;
        b=FbMzznh1zcD8gHMSWnp9zuA6ndwgieqMY0YzILOI2HkMuOYZDMa+ri2Zem3LpcqVnb
         qOcvepAZB9tIaim8EqEjHIDgqXk1+40VaCfdI5eOa2Ge179Q+6yHqxIhx6dYt4qy3Mp/
         Md+P0BOKcpxR67hpyte1G202Uaotx5xcRtw4Vvf9Jyblw/tTpj+1wgg2IIF1jTPIlrSR
         Lt9jH7KeMl90BNH5xFu/VyuC3fM/Def4x7l7EurmhXh86q1w/js9d52qFbEq/tZG/Jvl
         fIZP/VL39Y/WLyFMhih78JVKdvDjAosomOSTK6eIAotOxwUUBlTOEpsS2Y5VMpPMYvtb
         Eg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896838; x=1714501638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRREGXZ9LGwcYWVEeF7p0krK+m5v21ptFkL/WS+1sYc=;
        b=W5mhqROW/3zuI+r7w2Z3QnGftYok88BDEqX4BlmcgY1NznslNFlLGuhBiWxfevj/12
         +orIJBGCOt8z+YR9M38OBotL9VTfsts2al8kNyk9tGqjn6iBLumRNhCeiHdMyL2GhOYr
         njto1yUvWbRLxZlv3VBCs10QuhPjWbOxRvSxtR/pUYhtWB87lpMLgcFGSRdekRIUKnXO
         d7HJkiSHIm5tS3Wua5+2mYvhI8nXIngOXqzmdz1Yio43DjxcxTUZkXtRAMEcOQmDYcxz
         hipl4AZMXy023Wcx2vs2lJ9/SvpktQV/ldHwUykFVdxcrIYT85c6EWp1ui1hWBXV8n9g
         tQtw==
X-Forwarded-Encrypted: i=1; AJvYcCWXEAcZPnvqmAZs0ZO6ni1fkBSFHVxMTxqlThiHtLmyFknRTbW0xJkos2IhZyxqsUM1bvi+3tnQvU9vBVSBuK/OucGacRkSgHjHS6LXHnhXCQim318Y8vi8vc5gGRhzBsL0QRYrjU8Lz0mZZ0rD
X-Gm-Message-State: AOJu0YypemXWJEyV5xMd1fiTmIQ7Gm8d2ksLURpQca9g+MsHnkZRFx5H
	mlm8LSM6FKFRZz5M8cqoQxcyQyzMl7wq+X1+2HI96RHGIbxfLokE
X-Google-Smtp-Source: AGHT+IHZSW8cbaE8cUJtodpeB6lgrzhLWztPZHhQ0NTdQRmHr6aIpK5pncFskfZ4VRDIH0FqAEXlcQ==
X-Received: by 2002:a05:600c:1c24:b0:41a:c04a:8021 with SMTP id j36-20020a05600c1c2400b0041ac04a8021mr105680wms.0.1713896837699;
        Tue, 23 Apr 2024 11:27:17 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:648d:95d1:ce77:2eb8])
        by smtp.gmail.com with ESMTPSA id s15-20020adfe00f000000b0034b03d0b94csm6557878wrh.74.2024.04.23.11.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:27:17 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	rmoar@google.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: string-stream-test: use KUNIT_DEFINE_ACTION_WRAPPER
Date: Tue, 23 Apr 2024 19:27:01 +0100
Message-Id: <20240423182701.38359-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use KUNIT_DEFINE_ACTION_WRAPPER macro to define the 'kfree' and
'string_stream_destroy' wrappers for kunit_add_action.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/string-stream-test.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 03fb511826f7..7511442ea98f 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -22,18 +22,10 @@ struct string_stream_test_priv {
 };
 
 /* Avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
-static void kfree_wrapper(void *p)
-{
-	kfree(p);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
 
 /* Avoids a cast warning if string_stream_destroy() is passed direct to kunit_add_action(). */
-static void cleanup_raw_stream(void *p)
-{
-	struct string_stream *stream = p;
-
-	string_stream_destroy(stream);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(cleanup_raw_stream, string_stream_destroy, struct string_stream *);
 
 static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
 {
-- 
2.34.1


