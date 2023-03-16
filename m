Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBACC6BC44C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 04:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCPDRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCPDRr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7438DCC1;
        Wed, 15 Mar 2023 20:17:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rj10so358707pjb.4;
        Wed, 15 Mar 2023 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678936665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk2XSOGv1tFnFzi/N5I5mj+ohjjy8LZGSgaI5+dYqZs=;
        b=KRxOVu04sF2V9Howec67b4fbYWXX2ViS+zdfYR553RHPG7p64GJ2xo6Ka06XpL99UQ
         mSdk2DQxsnWh3UxJlw9T0kjZALmmVy/SpUfLRyZSMRT3rKpapyIQMnnh5sLqvJAoLrwm
         Ud5JOSerIGl7Yl0qZ2yRRha2VAkzaGucz+AqujqVxdPNZge+ZXAaLzfIMXxJfUIGMYv2
         NUNR1T9clBlJVB5UHPRioPcC1d22+hsLp674LKKjmsyphg3knlPynhMY+6RIVqoKufwH
         1QNcgQuz3NSAPggAPzAlp970BanGz82l9+1FHlkbaUu4+Uba6ORdSLKUgOitZOEu4KyV
         U0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678936665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tk2XSOGv1tFnFzi/N5I5mj+ohjjy8LZGSgaI5+dYqZs=;
        b=YvGhPNnb9TWF29yWiCU087Ht6f+9kc15lyoFv/lGe30ORIrFVgTl/DvDt+Hf74e7yZ
         L9wODFAAA1oqiPCd5svWKsNo+7eRvYFhb2fLEkU1OaR7B4nx9NfBz5wRXoVYROiMCt4s
         UV0Nut4Nki6bISbTK5ZwBDuhnPo5Z70XrsriYERaq9iV1Ik6hH/6f0+uoOIYSnb8+olF
         je51YyUEJ8JhQwfJjv9R6clZWj/1nk6RvOvjVH83+gc4xJCOnvlkdXXVWazSJQVuUQt4
         IMouapGpOiXlU63Uaot4wDzGY7OG33WSJaqiSBktDdgTt6xBtf3KQ58VORDrTjcA9AbS
         nang==
X-Gm-Message-State: AO0yUKVyFMvHD12a5PlgcGSFvZdSUfhZ5eWspVxS442TLBcrux5ePDsr
        INnpDvfZDGfzXae0rLjbaSY=
X-Google-Smtp-Source: AK7set+XCnTpKGt6nKM4igzd+EY9/RD9SvKrwisZAwLB6esqUD5zpJsPmDJ6z+zjy3DI4seRdbLi2g==
X-Received: by 2002:a17:902:ce85:b0:19e:dc0e:1269 with SMTP id f5-20020a170902ce8500b0019edc0e1269mr2196808plg.7.1678936664865;
        Wed, 15 Mar 2023 20:17:44 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0019a7bb18f98sm4331859plm.48.2023.03.15.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 20:17:44 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] KVM: PPC: support kvm selftests
Date:   Thu, 16 Mar 2023 13:17:30 +1000
Message-Id: <20230316031732.3591455-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

Hi,

This series adds initial KVM selftests support for powerpc
(64-bit, BookS). It spans 3 maintainers but it does not really
affect arch/powerpc, and it is well contained in selftests
code, just touches some makefiles and a tiny bit headers so
conflicts should be unlikely and trivial.

I guess Paolo is the best point to merge these, if no comments
or objections?

Thanks,
Nick

Nicholas Piggin (2):
  KVM: PPC: Add kvm selftests support for powerpc
  KVM: PPC: Add basic framework tests for kvm selftests

 tools/testing/selftests/kvm/Makefile          |  14 +
 .../selftests/kvm/include/kvm_util_base.h     |  13 +
 .../selftests/kvm/include/powerpc/hcall.h     |  22 ++
 .../selftests/kvm/include/powerpc/processor.h |  13 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 +++
 .../selftests/kvm/lib/powerpc/processor.c     | 355 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  30 ++
 .../testing/selftests/kvm/powerpc/null_test.c | 186 +++++++++
 .../selftests/kvm/powerpc/rtas_hcall.c        | 146 +++++++
 10 files changed, 834 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
 create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/null_test.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/rtas_hcall.c

-- 
2.37.2

