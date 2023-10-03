Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C27B5F8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 05:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJCDwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJCDws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 23:52:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7CBF
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 20:52:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso331866b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 20:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696305165; x=1696909965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNMR0z51QCYQRxm83f6KHDy6IPGxun19enYMfTcEza0=;
        b=QkxkSBgU0yqr1xAK2FzOjLJYXVlFBVpvKCG4XIVqUKS6nyOfceCUxbMB/MWrM/ZTmd
         iFKl6a4sGUzd30xFqsnFRmZiexIPntiW/MLovHuymwFTbr741ChEiM30QqBYLUkhBpDr
         LnoMnq6nkZdzbtrSMXm2izGbunYhToDUxJYc5adRXLmz0YFnQ/JSFxZNzQ1o1W6dKwfm
         hgqQzs/u2vxojQsT8Su8xAiYhQlsRvZtnauTNvCiTP0vmyuH6pmn58Luus88ATxAAhXh
         c8d3ZblB2UcEgCPWZJCpPxsL6PF1Wws5rOFahxL6JSYdGm4n21S9cqHiDKS+Y9mnVRsv
         XIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696305165; x=1696909965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNMR0z51QCYQRxm83f6KHDy6IPGxun19enYMfTcEza0=;
        b=IZ/gM0dpKxGkOyavMjfo5IqkHhsBxFkpMo9NBX6mbfQ29m1/zmy5ks05l3OKXgqNnL
         tAL1uHE/aMb+PRAN5xiC0cKLe7i5MtBz/9Ca7RxSNesz85AV1AtXQehKyMGUGnX8R5WG
         C54UIO6kAr6vVJK/uNjYhIwLblwE3/yirQKAs2WDBpbJTehH6LZGa9O9RAFPpaiQNo9r
         YlbK1CuVocUw6RM0kUR/PnHRyWqi9C7kgMbQwVgtqM+9HQdF4N1FrqchEUPjk8ojal02
         bx2bKU3QWyHmFtq6E70AJ041mQNM7yKirZyxuWpZL2otDGMisBp0E1rQtXknBgFJC9Er
         UC2A==
X-Gm-Message-State: AOJu0YzRfv/e67IrF12dY4Kv1XrT+uX9Ps7P9M+IlW7I1mv5LyRPELkA
        qqzbsLVaGRB1HovcEzg17ZMqKQ==
X-Google-Smtp-Source: AGHT+IEXaDcHzxAlzMbKUPrZP+5G33t2w1p3iqVmidYV0CelUUVsWLM8+GU6BDI/ydkZJPXQ8ve69w==
X-Received: by 2002:a05:6a21:99a8:b0:161:76a4:4f79 with SMTP id ve40-20020a056a2199a800b0016176a44f79mr13310303pzb.23.1696305165279;
        Mon, 02 Oct 2023 20:52:45 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001bf846dd2d0sm277381plb.13.2023.10.02.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:52:44 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/6] dt-bindings: riscv: Add Zicond extension entry
Date:   Tue,  3 Oct 2023 09:22:21 +0530
Message-Id: <20231003035226.1945725-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an entry for the Zicond extension to the riscv,isa-extensions property.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 36ff6749fbba..c91ab0e46648 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -218,6 +218,12 @@ properties:
             ratified in the 20191213 version of the unprivileged ISA
             specification.
 
+        - const: zicond
+          description:
+            The standard Zicond extension for conditional arithmetic and
+            conditional-select/move operations as ratified in commit 95cf1f9
+            ("Add changes requested by Ved during signoff") of riscv-zicond.
+
         - const: zicsr
           description: |
             The standard Zicsr extension for control and status register
-- 
2.34.1

