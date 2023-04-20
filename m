Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9F6E90CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjDTKsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjDTKr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 06:47:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFA59FB;
        Thu, 20 Apr 2023 03:46:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1a6715ee82fso10457275ad.1;
        Thu, 20 Apr 2023 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681987591; x=1684579591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sJLm2eZDLGyvgcqE6hU5/8akA+8FZvgsZbAI5V7+q8=;
        b=BREUkprKElekPshq95yFel0+NzSA4KDOwZHZPe7vvNAY3L1AQqV28YS4XwmImyhWry
         B1Zd7hv86yjcGARx0s+3jFI9KxJSgUSmxf5ly6VNz2W5ZnIQV642F2r35WV2HYeafJik
         EVFZ2oCWKRl+nAD/kObcQyIAoULfhJfZ+1ftoUlH1Wq+ccuq+r+aqtsjCuxw66na9Mly
         DuZEAyVqNTx/6cmqs3CVbgAFE5V5fmjbYe7SJlM2sLZZ3FnzzEKsUJhqnmb8Wbh7NGD4
         gRPE/POudezGEBqKXidlWoAXcnC7pc1hdUUYF8hpdd8cUvT83Cgj+2Rtpt4bt/8+AAVw
         o5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987591; x=1684579591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sJLm2eZDLGyvgcqE6hU5/8akA+8FZvgsZbAI5V7+q8=;
        b=OJqs4okI4bf0pUTcPabb+IAm3emqKsYWj2zqFHfCH53QEqoBkBhpkONSZNGGCoIIbB
         wYMqFTItXoMwGSx2MSTsnIPBzyc/Opqwfxtymos1mtnLGuqJ9hRmfnPKw63ztVwmJx/c
         SdWBoeUqGDJxNCfgwNUjNTYdFaNXIyjOR9AZ4CT39C7YbuATxlTo4AAHYVIxv/2WGG3a
         HgrzSmPXX69ApDmiwZP0ziKBvPEM++0b85DxHZLx1BZZxdpR8QPO2kYK81yfkLZeBGSg
         t9YbDXd9j21Mfq3tcWPgFBla+zf3yEonRcVBFBRbR6Psv1kN6kgulQokoNt+xgOdFdE2
         9QDw==
X-Gm-Message-State: AAQBX9eHd0dC5Cr35PSlZXIGAm16chwYwZn3VzHCWX2fHBWZ/ceFrTLW
        vXQIHRAonMD9Bg8eCOA2Y3I=
X-Google-Smtp-Source: AKy350YcGvKbHgIr9RG8fAMRfIMCduezmkcl9FWHyuLkRYL48/eiHCggGZFmAWls1eV9FOlQGKFsTQ==
X-Received: by 2002:a17:902:e5d1:b0:1a6:f0d5:3e21 with SMTP id u17-20020a170902e5d100b001a6f0d53e21mr1554174plf.32.1681987591105;
        Thu, 20 Apr 2023 03:46:31 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001a526805b86sm923735plb.191.2023.04.20.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:46:30 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <ljrcore@126.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] KVM: selftests: Add tests for pmu event filter
Date:   Thu, 20 Apr 2023 18:46:15 +0800
Message-Id: <20230420104622.12504-1-ljrcore@126.com>
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

Previous:
https://lore.kernel.org/kvm/20230414110056.19665-1-cloudliang@tencent.com

v2:
- Wrap the code from the documentation in a block of code; (Bagas Sanjaya)

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

