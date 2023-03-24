Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704AF6C76DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 06:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjCXFNP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 01:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCXFNO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 01:13:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FA26192;
        Thu, 23 Mar 2023 22:13:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w4so843342plg.9;
        Thu, 23 Mar 2023 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679634793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8AmdIH0RIUbdvBWMctyo17vOjMWtp9V8i3guH1aIQ=;
        b=H+be9FYDHOxafWM2eX0/k19L63LcHLF3A5R8FfG6v+obDbBoFGG5LzNL0NpjWNVDJj
         Crp5moKYSeVt/cXhguk+gOQVfuMU44i8pIbuHGGKGg1AE5gwTAebA4xr8JgMQ+OKXvf7
         7g/hxOaDeHdx2bNb2jFu2CsQxg8CgwP7H/rMAX15xIxwCIIzv5ZlxJx8/uX3BPjo/DFY
         dzmwcXcgyXkOjmrmHx2Ezd7ilJNILxp0cZmoqoOW/MtgHZCCeTl/fU6WPu0ZdmL+x5Mq
         Ncw2aetRme9mzVynx23PSTK2oT6NqJOmSsKZKfCfy5Sh4pcOzqcT02yfj2SNmkDbVFGA
         zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679634793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE8AmdIH0RIUbdvBWMctyo17vOjMWtp9V8i3guH1aIQ=;
        b=VABUfe/8V+lzpWctg1TN5L7Tn3h9qnPBHe1eV4F8nhiRgizicBuhUz1IaBO6cA8hzM
         /jsJG05UbCkDjAJCw+lAL3gNCMKT3aKraTpLySr9udn5xptmN/stMPCPb+OHqdRE44CD
         XOTmWVcplHfLo9DdkGHKkTU20MN1eYWZgLBRcU0Tc+MicvhehtQlQxl916tUdHpuaJlY
         MrN6Sr48cSJ9csc/kZqPvqgqjlNVnumGP4KEIrybutI4p5VGmIdWtYrWB7hOHOfOXi8S
         MOqiNtcIAZPqtRfHnlygF+AbBlZtyS9f6UwhwQaAw3xZUyG3CtsYNJ+SCB1PpJ02TWlz
         Y7dg==
X-Gm-Message-State: AAQBX9doi2IugOCADP/slA+6UUvcNf8o1gqdOxe22K3o8/CjHNqrrKUZ
        Lpuv0TfbjnD69LvxGZVbSDU=
X-Google-Smtp-Source: AKy350brwNXbQOUcBCaI180uX2CvuZz5FKM4HJJ3a5ViJY/BcZrMkAx+yP7owsoXMTJCPvOjXW/EQQ==
X-Received: by 2002:a17:902:e5c7:b0:1a1:be45:9857 with SMTP id u7-20020a170902e5c700b001a1be459857mr1545573plf.1.1679634792964;
        Thu, 23 Mar 2023 22:13:12 -0700 (PDT)
Received: from bobo.ibm.com ([124.170.18.191])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b0019a70a85e8fsm13169774plb.220.2023.03.23.22.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:13:12 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: PPC: selftests: powerpc support
Date:   Fri, 24 Mar 2023 15:12:52 +1000
Message-Id: <20230324051254.1894918-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This series adds initial KVM selftests support for powerpc
(64-bit, BookS). It spans 3 maintainers but it does not really
affect arch/powerpc, and it is well contained in selftests
code, just touches some makefiles and a tiny bit headers so
conflicts should be unlikely and trivial.

Hey Paolo and KVM group, if you didn't take the v1 series yet, could
you please take this instead. Otherwise I can send an incremental
fixup.

Since v1:
- r2 (TOC) was not being set for guest code
- MSR[VSX] was not being set for guest code
- Proper guest interrupt handling instead of quick hack that
  just made a ucall out to host.
- Adjust subject to better match kvm selftests convention.

Thanks,
Nick


Nicholas Piggin (2):
  KVM: PPC: selftests: implement support for powerpc
  KVM: PPC: selftests: basic sanity tests

 tools/testing/selftests/kvm/Makefile          |  15 +
 .../selftests/kvm/include/kvm_util_base.h     |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  22 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  17 +
 .../selftests/kvm/include/powerpc/processor.h |  32 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +
 .../selftests/kvm/lib/powerpc/handlers.S      |  96 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 411 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 tools/testing/selftests/kvm/powerpc/helpers.h |  46 ++
 .../testing/selftests/kvm/powerpc/null_test.c | 166 +++++++
 .../selftests/kvm/powerpc/rtas_hcall.c        | 146 +++++++
 13 files changed, 1049 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/helpers.h
 create mode 100644 tools/testing/selftests/kvm/powerpc/null_test.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/rtas_hcall.c

-- 
2.37.2

