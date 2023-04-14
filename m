Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C436E2171
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 13:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNLBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNLBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5F59C5;
        Fri, 14 Apr 2023 04:01:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o2so17929301plg.4;
        Fri, 14 Apr 2023 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681470067; x=1684062067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXpcj70JoUaJaQ0NFshY48FX4MFUJATqGyPFJPRajLc=;
        b=EApi17XEoO7KVLD25sQ3EXFiWunGLgsXGTs5ZivpM9H0+tlXadOfm2LoeDTpiMvORF
         pS1IuXe0wT6hrCKl90O3/JeOM0dhKy7ACjlNIjElFe/RfEBGlDthJQhz+PIXaj8fm75z
         4pO6BaxQIYhKMjgtBfBmajBpoj99NOac/ryk2HZbZTugnV6gSlgWJng7knM7D4sXerD+
         EEBzPCNvTDXRvFQxnsbTehkoEPc1t7oXu8LO4NfpHT22hWTdm6fqqlylY+SvGgpmOpES
         DraSrGtOx/8K8XMdAPGtyMngsjXiTxkXOlwWYKBWId0xr3KJiibobtrxwsSL4HA8V8AA
         esog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470067; x=1684062067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXpcj70JoUaJaQ0NFshY48FX4MFUJATqGyPFJPRajLc=;
        b=P6qoUq1UcskdgaLrkWfSUKCVAKOlYQhYudwx0aW/PUHUbyZwJGWlUeAK2ty29JSHqh
         YCRQv8NvxYYvhRv5o8/cFaruEY5l/0Ny6P9TuWyvdLL+ofboRNohFxxWgCOJkoG8HWK2
         Cer7KrJRPsJOPLE4yjiZVJxugU47yi280WuQfVmjeJXrd8qD6gK13vqlnHL5tvnBGjl9
         7u3xwoWCyylBe2XsJG+lvRifte2/iFxwQt1FrRM6d5MxbPL3cLkSy716XQ3EVo0j7Lx1
         VaD8VJopbmHbhOqJx0iFgBbpsHF/qo/gv9BjfxfauZ8/lKSD84jfG+AN7aHcaiTSPAZt
         abeg==
X-Gm-Message-State: AAQBX9eZixw4fq41adtdyxWKmAXLM3u+Du0WvzFPxsNMD8Dx7ag1m94h
        IY0aHD+N5UZp7otx1fxd7xT9jhcIZdfU2yssbvY=
X-Google-Smtp-Source: AKy350ZW1b+1o62lbe6i9sQhHNGwG+haYfV47teIXXPHheQIdmgf7PdehSxkOUkwSyi3HrXGIoYZZQ==
X-Received: by 2002:a17:902:ecc4:b0:19a:9880:175f with SMTP id a4-20020a170902ecc400b0019a9880175fmr2733094plh.51.1681470067189;
        Fri, 14 Apr 2023 04:01:07 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b00194caf3e975sm2835821plg.208.2023.04.14.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:06 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] KVM: selftests: Add tests for pmu event filter
Date:   Fri, 14 Apr 2023 19:00:49 +0800
Message-Id: <20230414110056.19665-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Hi,

This patch set adds some tests to ensure consistent PMU performance event
filter behavior. Specifically, the patches aim to improve KVM's PMU event
filter by strengthening the test coverage, adding documentation, and making
other small changes. 

The first patch replaces int with uint32_t for nevents to ensure consistency
and readability in the code. The second patch adds fixed_counter_bitmap to
create_pmu_event_filter() to support the use of the same creator to control
the use of guest fixed counters. The third patch adds test cases for
unsupported input values in PMU filter, including unsupported "action"
values, unsupported "flags" values, and unsupported "nevents" values. Also,
it tests setting non-existent fixed counters in the fixed bitmap doesn't
fail.

The fourth patch updates the documentation for KVM_SET_PMU_EVENT_FILTER ioctl
to include a detailed description of how fixed performance events are handled
in the pmu filter. The fifth patch adds tests to cover that pmu_event_filter
works as expected when applied to fixed performance counters, even if there
is no fixed counter exists. The sixth patch adds a test to ensure that setting
both generic and fixed performance event filters does not affect the consistency
of the fixed performance filter behavior in KVM. The seventh patch adds a test
to verify the behavior of the pmu event filter when an incomplete
kvm_pmu_event_filter structure is used.

These changes help to ensure that KVM's PMU event filter functions as expected
in all supported use cases. These patches have been tested and verified to
function properly.

Thanks for your review and feedback.

Sincerely,

Jinrong Liang

Jinrong Liang (7):
  KVM: selftests: Replace int with uint32_t for nevents
  KVM: selftests: Apply create_pmu_event_filter() to fixed ctrs
  KVM: selftests: Test unavailable event filters are rejected
  KVM: x86/pmu: Add documentation for fixed ctr on PMU filter
  KVM: selftests: Check if pmu_event_filter meets expectations on fixed
    ctrs
  KVM: selftests: Check gp event filters without affecting fixed event
    filters
  KVM: selftests: Test pmu event filter with incompatible
    kvm_pmu_event_filter

 Documentation/virt/kvm/api.rst                |  21 ++
 .../kvm/x86_64/pmu_event_filter_test.c        | 239 ++++++++++++++++--
 2 files changed, 243 insertions(+), 17 deletions(-)


base-commit: a25497a280bbd7bbcc08c87ddb2b3909affc8402
-- 
2.31.1

