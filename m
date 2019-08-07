Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A805A84E0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2019 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfHGN6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Aug 2019 09:58:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfHGN6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Aug 2019 09:58:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so91473659wrf.11
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2019 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/q1A4PrAblYMBCQgI2N1FaerB81pHXKu9hE/Sa+XUXA=;
        b=vVIW9zlPe5Sze48sRoyXSlGRmh5x3AQpyelKbs+7nugJJ3s7eW40oTSh4LS+0TepSH
         H28kfwS3fIVk1nXC4oYrri7e/or/i1HcprEvxcR19ur7bYuBxlTnf2+zoeMhd0tFus+l
         dhPcWRwqjlNeh2qaEFHYIj99UE/75l3L45NgGD1JuYO7Rw9ffCQktznfRf+uLUg8XcZ5
         YCTqSUTBUzwI7fRA0nt1jA3AYY1NPvZ30qp5pr402FeeWyQKFBx4FQ8qvFNCGqWLva0l
         NgM8yXtvwZqYTopT2tRhnwuEau+wHMziDjEQlrSBPIRxAITECY+Zl3mBfANfcUvIx5h0
         MSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/q1A4PrAblYMBCQgI2N1FaerB81pHXKu9hE/Sa+XUXA=;
        b=lmu6/KZrjmMv8BJzn6dea8LHly46C3l6thZM4hx7Xxr03iLPuUTk0joeGKTsc/xl+5
         Rnt5GTUHnjf4dxjexJQ4ApKMqlcSA17ePLXXiaOY9jFOJO0OBzcDfETBXOb3NC3GeGGa
         EpAayEBdgnkpiHVwmWgGTM/57uyi5gcMtfRvaDwIq95xv7he50yjGhGnc8nqqiefn54m
         1bFpNZKXQo/aH/AQ+iuF7UZnlEwwGbSSmOj25Q+vy7m/AK61txfwg4EprdiplxdT7Qnw
         cgQt9PkSNtij/2UGDnySQQFWMbZxQdX08PbsdyUsL/Xlng/jTEbqAhLklCltkZZMV9Pb
         klLA==
X-Gm-Message-State: APjAAAWA0SzNdjdrH/2J4cwAQ7q0ZP1SsmU6/yfURvHBssbduonRmStN
        JPwJn/7HC1g+imGkDqizVbsWcg==
X-Google-Smtp-Source: APXvYqxZjoJ4iUF7J7s+ussP5b6+gLvzvOyEPFVQwRFhxv+xdTUkl3QcOk/Eg+A0DCXIq10UbctGYw==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr10524405wra.328.1565186297540;
        Wed, 07 Aug 2019 06:58:17 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id n12sm2912467wrw.25.2019.08.07.06.58.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 06:58:16 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v2] selftests: kvm: Adding config fragments
Date:   Wed,  7 Aug 2019 14:58:14 +0100
Message-Id: <20190807135814.12906-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftests kvm test cases need pre-required kernel configs for the test
to get pass.

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 tools/testing/selftests/kvm/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/config

diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
new file mode 100644
index 000000000000..63ed533f73d6
--- /dev/null
+++ b/tools/testing/selftests/kvm/config
@@ -0,0 +1,3 @@
+CONFIG_KVM=y
+CONFIG_KVM_INTEL=y
+CONFIG_KVM_AMD=y
-- 
2.17.1

