Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD516DB8AD
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Apr 2023 06:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDHEAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Apr 2023 00:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDHEAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Apr 2023 00:00:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FD7BDD2;
        Fri,  7 Apr 2023 21:00:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63262355155so62275b3a.2;
        Fri, 07 Apr 2023 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926433; x=1683518433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFK/uIeYUfNZgY3kc6tIDnKhLwPMBiZB1vwA9Lwjqqg=;
        b=lo4L3iiRNDDU2WG5Oyft1uGTxdd+en0f6gBlF9K+1fCLSEPtZqXdbii0ZhRPMde/sZ
         yJK4ECwe/qhbsmUMXn3xnLaC0gz8bigr77AU05Vc+v7V71VHG+2DQH27ABbv7tMR0yIi
         IKGPjP/vABOrEO/yLbCOnEs6nnVU1y7xutm/Wk5UzI9GQB1pF/P7pnm+hOPTAuX8A/60
         NZHDO3NOGGUUl3GSlWU5q+Iyq3xpQ3NWEDr0zP73sM6/Xb43jAfRQfB8QzRQsLCmK3kB
         nF0nyzuuSEb6A9mwlncGRX5iBeDy3l7rEPlzfCNae6sXRHH3HGGINeN+ufgNwFrjyq7N
         UoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926433; x=1683518433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFK/uIeYUfNZgY3kc6tIDnKhLwPMBiZB1vwA9Lwjqqg=;
        b=bcVNPU7xETA8dv9ZuVTj468HBn+L3BkPQ1Z6mpPR+7DzlLNM2aDmnrbtrHUS37SSeI
         k3v4IkBauGJB8nwTxpEAqHf57itwsNcyuy6mGMwNtL13AY9Sa0x3CmE6z4HwgS07N/mZ
         VlCUkl9fDosPsDb+43Nyh1foyRsq0ZopDWvDyU8sRMFC0E4vm2/YoPx1/t8VPtF8fG1g
         eGhR+7I59aZADIDzpctVrotxdeI+3Lx3e3hMyOQQ9aO6nHOJExmNNDILuTkr+a0Fcmqg
         Ks7KthXA1KYumceP0EFDW8nYFOCfAFONcbIF/4SYC7Kkl6K+XkTuHmSo1bk/jt89PdeD
         J9Fg==
X-Gm-Message-State: AAQBX9e91pBVC8/GE2ywkn2cTYAWyetoaVDH8zYS43q6e0qHAVi6ly59
        aTGPpu7O6XJ/KAmLmGgY5pE=
X-Google-Smtp-Source: AKy350YnVfJEM/FMhIJogyGN04Oud2l94lQExA1WBe94RmF4hdhfyrX6Ms2zhUQzYiw+xgt1Bjrz4Q==
X-Received: by 2002:aa7:8434:0:b0:62d:e966:ffc7 with SMTP id q20-20020aa78434000000b0062de966ffc7mr903505pfn.21.1680926433137;
        Fri, 07 Apr 2023 21:00:33 -0700 (PDT)
Received: from wheely.local0.net ([203.59.189.25])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b006328ee1e56csm263872pfw.2.2023.04.07.21.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 21:00:32 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] KVM: selftests: add powerpc support
Date:   Sat,  8 Apr 2023 14:00:16 +1000
Message-Id: <20230408040020.868929-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.0
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

This series adds initial KVM selftests support for powerpc
(64-bit, BookS, radix MMU).

Since v1:
- Update MAINTAINERS KVM PPC entry to include kvm selftests.
- Fixes and cleanups from Sean's review including new patch 1.
- Add 4K guest page support requiring new patch 2.

Thanks,
Nick

Nicholas Piggin (4):
  KVM: selftests: Move pgd_created check into virt_pgd_alloc
  KVM: selftests: Add aligned guest physical page allocator
  KVM: PPC: selftests: add support for powerpc
  KVM: PPC: selftests: add selftests sanity tests

 MAINTAINERS                                   |   2 +
 tools/testing/selftests/kvm/Makefile          |  15 +
 .../selftests/kvm/include/kvm_util_base.h     |  27 ++
 .../selftests/kvm/include/powerpc/hcall.h     |  21 +
 .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
 .../selftests/kvm/include/powerpc/processor.h |  33 ++
 .../selftests/kvm/lib/aarch64/processor.c     |   4 -
 tools/testing/selftests/kvm/lib/guest_modes.c |   3 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  56 ++-
 .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
 .../selftests/kvm/lib/powerpc/processor.c     | 429 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 .../selftests/kvm/lib/riscv/processor.c       |   4 -
 .../selftests/kvm/lib/s390x/processor.c       |   4 -
 .../selftests/kvm/lib/x86_64/processor.c      |   7 +-
 tools/testing/selftests/kvm/powerpc/helpers.h |  46 ++
 .../testing/selftests/kvm/powerpc/null_test.c | 166 +++++++
 .../selftests/kvm/powerpc/rtas_hcall.c        | 146 ++++++
 19 files changed, 1129 insertions(+), 34 deletions(-)
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
2.40.0

