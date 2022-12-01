Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBB63EC12
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLAJOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 04:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLAJOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 04:14:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022F70606;
        Thu,  1 Dec 2022 01:13:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx10so1698773wrb.0;
        Thu, 01 Dec 2022 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiFvV/PpI7Kv9Cj/ZD/4j9tmtDiYehJfyRtCeZv1mCc=;
        b=D+N7MLXEkYIUhMAL3zS0P4N6UGeA6VQYhiieMBLTkvz0ksZNrQu2+L9j+iwiIk0nRT
         khYLA6X44ZX006SsOgUhW2rLJrR1KtR9BhDzQYCOcJlZGx1ZGIUGRA6H18ttYRndjkXQ
         1Ae/LLGEC8skIrrN2w9z+zNRU85gRzQ2S2g+hvjFQ7oqym+Kn1jVagTjTo1x4JT6AaDK
         fAewYQP2fct4sdkDFbKuxawcdf1DL+9D4eYD8IgS57wixtAd1YXwn9AYol5rA4hrsin3
         0qdvabvgYNF67z2yqmfnOPEsrOhHjUd8XE9Ix9cNrlIR8+XoM6m+NUelSFgMHKl1D9xf
         WDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiFvV/PpI7Kv9Cj/ZD/4j9tmtDiYehJfyRtCeZv1mCc=;
        b=ieNYZO52gL4JOc6fiMIGqvEAfzS6X6lI8N/EYYw937WcbsmzuW8MmdsfRgMIoF2Kkp
         nIxN5qAEOnqGmfDKU+FPeUYG8Ks2U1r8df2m+1U73Wb2u+W6gnnN0JyWTgcOHUX1zCyT
         RIvnRgFXmitc/7pyEPo6hJ4UkeOBi7dKfKRJgCcSUAr7NaG/MDzzf3NsO8hneO1z+52g
         geCD9TpVYxqqToDzjyj8nuGSlCwEt1dM78u0bi+mhTEY3capFZOZjEWVvsppDJiemQK8
         yN3+c1yuzplvU+8BXdd2oe2GUWwTgHVXGy9ODK+UkGR0wRwjnnRXjqIguR0qT7xBPcws
         zZfA==
X-Gm-Message-State: ANoB5pkRYRpNx6Qubug/fNOicd3RY3oTACL9kId8qdwDaoLJ2n+Z9Pb4
        if1XFhQ+R1W2MacXz1BcTaFa+L3l/giwJUO5
X-Google-Smtp-Source: AA0mqf79ZR9ZaEyJme/QB9Ao8CfIB8KWk8K8LFC5813EmX4C9KBfJ1hkop11ZOszCAReflbGSCF7EA==
X-Received: by 2002:a05:6000:1a45:b0:242:1b69:786c with SMTP id t5-20020a0560001a4500b002421b69786cmr10738850wry.486.1669886036011;
        Thu, 01 Dec 2022 01:13:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i12-20020adffc0c000000b00241d21d4652sm3850499wrr.21.2022.12.01.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:13:55 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] KVM: selftests: Fix spelling mistake "probabalistic" -> "probabilistic"
Date:   Thu,  1 Dec 2022 09:13:54 +0000
Message-Id: <20221201091354.1613652-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in some help text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index c33e89012ae6..e9d6d1aecf89 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -398,7 +398,7 @@ static void help(char *name)
 	printf(" -x: Split the memory region into this number of memslots.\n"
 	       "     (default: 1)\n");
 	printf(" -w: specify the percentage of pages which should be written to\n"
-	       "     as an integer from 0-100 inclusive. This is probabalistic,\n"
+	       "     as an integer from 0-100 inclusive. This is probabilistic,\n"
 	       "     so -w X means each page has an X%% chance of writing\n"
 	       "     and a (100-X)%% chance of reading.\n"
 	       "     (default: 100 i.e. all pages are written to.)\n");
-- 
2.38.1

