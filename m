Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7442718E19
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 00:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjEaWIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjEaWIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 18:08:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B321BF
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:20 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6260a2522d9so2167806d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570900; x=1688162900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVpzQtIDQfKWEqbseo+tZ+eEsBzkT6BTR9cKFnwSYiE=;
        b=UVc+juOdhvc+cdjx5ehHJJwwP68jGUuabxnGl2sSfw5+c3rM6PEEz7zmzj6t/Ykjlz
         IEsXCnKiFlo+h2JixjtD4OcEGGHRU/PJBz4uJQNMcO2ZId0sz4Pi773QRZBHIET4s7rS
         u0CUYL69ZSD7t8s8GCIDl4lvJdB5gvJ7I/eFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570900; x=1688162900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVpzQtIDQfKWEqbseo+tZ+eEsBzkT6BTR9cKFnwSYiE=;
        b=VfSmQvSd84GZO0JzHEOnpIsyiz7/h8iqwMROChI51PWjP7srJe5DAfhepZk6ljcymq
         7Pgic+jem950scO9FoB/mvpKzddSrQeGIJYxCn62bKbPGLa6OldUb5pjLG5j5JYBmLxu
         eKwiDa6uBybF6HiVYdqJNqvZCEiV5gYaCNT/UT7X3Of7IeodEsdLGSc+B+IjrlFIaUjS
         k6zWQJ8aM7/GRkhSc7hHZGAz+kP+j+Vai8KUoKvtiCfKuYVcYe6pZKTDoiT0U7fIlhgI
         3QVeDQXlaYvRVPlOfiO/ZgoyKESWGMr+B5dadpIbB0AR/C/8HUqpZ2xQsE188KVtKVUL
         lFWw==
X-Gm-Message-State: AC+VfDzlWy2xIi6zUQS6K+OTu5QQx5bLkPheYP7fIQrbpiZO8Oe9wT2S
        3r8mAesD6Fw6UAkocDTeAVzjzg==
X-Google-Smtp-Source: ACHHUZ6MK0NGbKvNzGTkIT5KQRbjPCfTItoxAs0WkJkwEfUWMktvJqSRp0xRq7Tiv2SENcLbvIsx6Q==
X-Received: by 2002:a05:6214:1ccc:b0:625:1c04:6761 with SMTP id g12-20020a0562141ccc00b006251c046761mr8116673qvd.27.1685570899912;
        Wed, 31 May 2023 15:08:19 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 3/7] selftests: mm: Fix failure case when new remap region was not found
Date:   Wed, 31 May 2023 22:08:03 +0000
Message-ID: <20230531220807.2048037-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a valid remap region could not be found, the source mapping is not
cleaned up. Fix the goto statement such that the clean up happens.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5c3773de9f0f..6822d657f589 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		if (addr + c.dest_alignment < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
-			goto out;
+			goto clean_up_src;
 		}
 		addr += c.dest_alignment;
 	}
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

