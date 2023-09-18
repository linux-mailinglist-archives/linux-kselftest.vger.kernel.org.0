Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08287A51A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjIRSHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIRSHM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 14:07:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499F182
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf1935f6c2so34303945ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695060426; x=1695665226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i1eIcDaE0yWa5Js2PwK7z4plrujub6N9pwbwUycwvI=;
        b=n5WgOqxC/sD9AIOObnUBwHjxeweIK+5IApTUFl+PM6jHKTprvdAK++E38m4gimmR7f
         HZb9ECsoUHD4pu/JKmGM4tQr6ZyuJ23ZjhC/yVmgavAG+g11RqPcOxFBkFgmak+kNrzo
         JMaPejqa12loIEdKrjzGqSFXyEzYzEvkzR0f/WUcB0RgaE7iXYBxggQK1XeoL2hHMQwE
         VsXJ4mvPkxFNNfRLeByXWT+lhPeErl+B1gecBeQLlABs4Bc6jbxYpZ1n6tgpnlxusJCP
         FZAguQ7fgN9ewS96fIBHgUPwjL9xxaWtFXS4JSRXmUBqgwDIJZvFXiuD9mUUcpQCaC09
         aOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060426; x=1695665226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i1eIcDaE0yWa5Js2PwK7z4plrujub6N9pwbwUycwvI=;
        b=pyEnvM0arng7notcvj1LIaHGquExnoINPGvaHI3jFmjQp0dFU7fwLka2oI7oyVEBeg
         oMHE6z89coObg6CmKJ9615eZYxFNRU1GETb88fPito7toxzm8D63gFkweQLAD6PgpE4H
         1C4coh2u7e62vQXxdzI3hG9xV5nRcXQZlKqHTvihBliJFapDdqoLCHiOyTWIpebMhQNr
         8lWZ9OD8ugNs15LV8M/irSGM93iDNRRYNcLFlqnOioOl2TJuSro9JWoXdHEAkkuAu2KI
         5uLLpoVN+69M/huDSHc7lmz4ub7EFcAG1GEi7vNIF6J5YtzsCV38zowLqZ9wytkxXdJ7
         p0Vw==
X-Gm-Message-State: AOJu0YxqVfdhwWpOLVBbC54NgQd5OBrmZupvt5sz2DVvONov5MtjZu1G
        q74VYoBoSD8PvbqO9+gKBYFC0Q==
X-Google-Smtp-Source: AGHT+IETi36u/uUFnqQ3ujRXaYRtNA+dM21DQd6+dA5XB+7tI1/bMH90xqm0GwYq/Oq3VArOSjGyvA==
X-Received: by 2002:a17:903:41cb:b0:1bd:d510:78fb with SMTP id u11-20020a17090341cb00b001bdd51078fbmr529431ple.3.1695060426120;
        Mon, 18 Sep 2023 11:07:06 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902704700b001aaf2e8b1eesm8556720plt.248.2023.09.18.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:07:05 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/4] RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing extensions
Date:   Mon, 18 Sep 2023 23:36:44 +0530
Message-Id: <20230918180646.1398384-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918180646.1398384-1-apatel@ventanamicro.com>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The riscv_vcpu_get_isa_ext_single() should fail with -ENOENT error
when corresponding ISA extension is not available on the host.

Fixes: e98b1085be79 ("RISC-V: KVM: Factor-out ONE_REG related code to its own source file")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_onereg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index e7e833ced91b..b7e0e03c69b1 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -460,8 +460,11 @@ static int riscv_vcpu_get_isa_ext_single(struct kvm_vcpu *vcpu,
 	    reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
 		return -ENOENT;
 
-	*reg_val = 0;
 	host_isa_ext = kvm_isa_ext_arr[reg_num];
+	if (!__riscv_isa_extension_available(NULL, host_isa_ext))
+		return -ENOENT;
+
+	*reg_val = 0;
 	if (__riscv_isa_extension_available(vcpu->arch.isa, host_isa_ext))
 		*reg_val = 1; /* Mark the given extension as available */
 
-- 
2.34.1

