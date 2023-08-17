Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D277FB69
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbjHQQAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353417AbjHQQAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 12:00:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF0F2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 09:00:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6887c3aac15so1970130b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Aug 2023 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692288038; x=1692892838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlT9fFwxzSwTM1kaYJgDOCQu0UvIzKLj9qZMmOR6x28=;
        b=VmNUeJRQXAVcshDfrSK3Et1LD6PprjNbVNeGttwgD+xwqPFRoSJiXV01a/6kluD9I+
         qRytK1na28nWsFpvtf2Th9yg9VI9aY+xddy856SeQyHAmS7Pn5YZd6d/soyTyTnk7WAw
         +5uIgH9MEcHinqYXrTCmkmGrkBK/dXuP/vrYAP+rOfJmEudxia9o73P9cwDKq0nErq5A
         GVWrQHGqkJETkGsiHFGLFJZoIcNFHgzm7Ma2oBaiPjLF0mmHAOZKkjhkMfBFJ8XfTiLk
         8Txue3l0eRnHlah7YJAo4+8nXL/DsAAUE8Sw1+StyynHrx9pIuEsBBHRTfgF8IFfBkHu
         YcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692288038; x=1692892838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlT9fFwxzSwTM1kaYJgDOCQu0UvIzKLj9qZMmOR6x28=;
        b=RKWUVlXFfL4Vq4gFZCs2j5f/68l3kLxup1Mkq6efHU24I5e2B5VLZ9LjtmgsqHLGGR
         iwEO1KWhV6AedaeZZh2PfLqc9RrUAViF6tOwEPV86ePWDcnMkDsXbRrITtKzteFPw+WS
         swF8LdACdNFoDNDzn5Nr4LcbonXtvMdzcMHW/dzkMsGnTaWHZ7yNPCAbgE6r1IrevjQB
         3Vb5Np27ppN/nOLS2zz+klX6lEaSTSaXH9hYQPLpUCuG88mero4Af/t9J9dqC9jDAKTn
         3u2GdNj4iBnz2xFnuKahLPIv1YQ//IcjDa0SVMRol2kE5VpJxn4e9yxR8Vvkpr7/4ksT
         y3xA==
X-Gm-Message-State: AOJu0Ywkipfg3Zz1AobXIQinXd1saGUwODWZxhi2VM8VrOn6kpfCfLe3
        NldfrtIrF/gkU+edmN76tFE=
X-Google-Smtp-Source: AGHT+IFbJG9KVcf0ORQF/w7iO7Nxg7X/MOZC4YGa5PCrSmP+GBVynwoW31tJgL6Bs6PF1VubX6ZEtw==
X-Received: by 2002:a05:6a00:850:b0:689:f586:4add with SMTP id q16-20020a056a00085000b00689f5864addmr810149pfk.31.1692288038267;
        Thu, 17 Aug 2023 09:00:38 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b00666b3706be6sm13018779pfm.107.2023.08.17.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:00:37 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] selftests/mm: Fix WARNING comparing pointer to 0
Date:   Thu, 17 Aug 2023 23:00:33 +0700
Message-Id: <20230817160033.90079-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove comparing pointer to 0 to avoid this warning from coccinelle:

./tools/testing/selftests/mm/map_populate.c:80:16-17: WARNING comparing pointer to 0, suggest !E
./tools/testing/selftests/mm/map_populate.c:80:16-17: WARNING comparing pointer to 0

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 tools/testing/selftests/mm/map_populate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 240f2d9dae7a..7945d0754875 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -77,7 +77,7 @@ int main(int argc, char **argv)
 	unsigned long *smap;
 
 	ftmp = tmpfile();
-	BUG_ON(ftmp == 0, "tmpfile()");
+	BUG_ON(!ftmp, "tmpfile()");
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
 	BUG_ON(ret, "ftruncate()");
-- 
2.34.1

