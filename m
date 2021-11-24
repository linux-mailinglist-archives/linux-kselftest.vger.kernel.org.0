Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2B45B758
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhKXJ0N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 04:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhKXJ0N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 04:26:13 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C22AC061574;
        Wed, 24 Nov 2021 01:23:04 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t34so1993547qtc.7;
        Wed, 24 Nov 2021 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/w/BAm75oCe1oJZIyKpKpGeS171winU9ruQCCqyDVI=;
        b=GtkUfA+M0K8cDcEzVi2dzOLjXYO+j70OjYUtC3PCvvM60PtytB+1Jm+hR2MjLbc3j5
         zlilh2yqe81c4QDEG18R9u4aqVjuAfXV/djRMkBh2cKYMYENhZGDQDNM+h27XatKuzUC
         3DICtACnxjszME/d1uZqtoKIknz/PQwz2usE0jIAxmw2j6N85G43gW3J5VX0oUk448VM
         aYCZQWXl91SRbs9mMKSuZ5dU5Pf8lxbqWqFhM7EKEwOHpLrPsiAJGQFT/B9PRoVg3ckT
         JOUZwkZSmaWwMgV7nDEkHZ+KlVIXHFaSpPYICx2bnGZltj1m9JTtTHqmPPh17gJtQCzv
         IGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/w/BAm75oCe1oJZIyKpKpGeS171winU9ruQCCqyDVI=;
        b=xP/kMasz0IBP2n2ZgdR0ruWZUabc3WEUsuv+NO1c+vH+PE88BOSox9P+eQXRREKp3g
         fO5pbScrR2F1YMXSRIWqpMi8IjbCoz6DbobE9xlmgUx6Hwx8B10E+bGoco9jvbjrPIUU
         /CNZTOmR5xKU8iDTSs2DB/ROCafAkK/prTLALL/LhULLoBcCjEdhVg5bzXnQzM1twjoh
         /Mvx97T0qPkIhycZhk151U0LePBPcWNKqzEdmmqgE5cYCjOeyxmPevLsf3raq7LzL6d0
         VT0BxK9c5V1KYSX0bw1vWxvzEG2zD8JC3wDCNg295SV8PykPzIGnfw6bU4t/BiOHYfKF
         LQvw==
X-Gm-Message-State: AOAM533rhV736+iZmNizz5xVx/OGkTGeQ0JW9nAFeQDp0ALiOj4flOlv
        9NpQOZK85UJ0sj5ykFBWOjU=
X-Google-Smtp-Source: ABdhPJzffUQp293nzZSpCXkGwjKHSWcDys5SRrNbVyLLLbMmiv9vh1YL9XLfrRdmPxH4PUUxPVUcCg==
X-Received: by 2002:ac8:20f:: with SMTP id k15mr5168908qtg.173.1637745783468;
        Wed, 24 Nov 2021 01:23:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s126sm6682235qkf.7.2021.11.24.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 01:23:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     pbonzini@redhat.com
Cc:     shuah@kernel.org, deng.changcheng@zte.com.cn, mlevitsk@redhat.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] KVM: selftests: use ARRAY_SIZE
Date:   Wed, 24 Nov 2021 09:22:56 +0000
Message-Id: <20211124092256.37966-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/testing/selftests/kvm/x86_64/debug_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 5f078db1bcba..ef24ad62d36a 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -168,7 +168,7 @@ int main(void)
 	target_rip = CAST_TO_RIP(ss_start);
 	target_dr6 = 0xffff4ff0ULL;
 	vcpu_regs_get(vm, VCPU_ID, &regs);
-	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(ss_size); i++) {
 		target_rip += ss_size[i];
 		CLEAR_DEBUG();
 		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
-- 
2.25.1

