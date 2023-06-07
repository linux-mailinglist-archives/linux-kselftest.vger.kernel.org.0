Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF03725F97
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjFGMhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbjFGMhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:16 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21EE6B;
        Wed,  7 Jun 2023 05:37:15 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so4149705ab.2;
        Wed, 07 Jun 2023 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686141435; x=1688733435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYpDm8AgCQ+Jjdrz0qWAN2s9cw9E+zpsCV8mVTUXM7c=;
        b=i5rFskEEOgyCq5QuYFWKv28gtEf10KrrK/2fQXblBJmEV0FN88vbBP3DcNSMNbbJ5n
         1baPoBt/MAUPX0UZ0rIcD7iAxP8eeAxS5efL7rWqyyxat4IhpN4mbRoFuMuj6Ez6iXPd
         mkPXNru6T7TaQ+VHJvnYBkGsqXU4kroiR8MxEvTPiUS3j0dS3PdsUJnJzEscHO2Prt8i
         e+JDEl9omKQ1Gz0mvk0MoGRYZDGT/+aX8mIvpRESv30CL21iWa4OcX/8y4A2iaCnNLbJ
         EtJpTAKc32s79S/MZtmwrSzbG95HIZBF8ii1gB5vBf0Wq75LnlkQaN9LwLtvBeTXLC+X
         FJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141435; x=1688733435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYpDm8AgCQ+Jjdrz0qWAN2s9cw9E+zpsCV8mVTUXM7c=;
        b=VD+NFqOU3Ly2zs19UjG0/bERCvLnbnaE1ylUTRXJfs9aQp5coBD1vrzxEFvHug/Vpj
         0Rc42H7B4MyFuTD0lpvTX4njV0Btcct5vuBw2LQe6zJ6vgiXgVoKzUOXnpiYY+Mu4neD
         YgV+SjeKouhUom9Ecu9W0nelhlK3TMvTL3W48wZUW6cJhCWw0/KR6gEtJu2DDxo9AwAR
         wH/nFOtkgnX0EiNs+trmZrBaSN6W/T3AAOokKrmdIE7LX9xC1xzhBAfU5EL91NzTd+Jz
         rV5Uubdnps7wqAzVaJZQT7yFz15opwlXUffV6p4jLLWd0rjO1w/QooAwoHsNPbA6HrSn
         /bdw==
X-Gm-Message-State: AC+VfDxc2hy7aGAVYpBNMRmOCYEJIpikx5YlJrkuxMWtA3t+gZ6JYXKX
        PT35rDzntUMst9ek8wthjSU=
X-Google-Smtp-Source: ACHHUZ4/jz8p/1GszGAyG4E08CuPfynTdlrVyhTG0zDtq89XUolUiiwtsjizzPdWOdqYd2LPOO+bnQ==
X-Received: by 2002:a92:d8c9:0:b0:33d:1072:361b with SMTP id l9-20020a92d8c9000000b0033d1072361bmr6859096ilo.21.1686141435110;
        Wed, 07 Jun 2023 05:37:15 -0700 (PDT)
Received: from CLOUDLIANG-MB2.tencent.com ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id k18-20020a635a52000000b00528db73ed70sm9038904pgm.3.2023.06.07.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:37:14 -0700 (PDT)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] KVM: selftests: Improve PMU event filter settings and add test cases
Date:   Wed,  7 Jun 2023 20:36:56 +0800
Message-Id: <20230607123700.40229-1-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
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

Hi,

This patch series aims to improve the PMU event filter settings with a cleaner
and more organized structure and adds several test cases related to PMU event
filters.

The first patch of this series introduces a custom "__kvm_pmu_event_filter"
structure that simplifies the event filter setup and improves overall code
readability and maintainability.

The second patch adds test cases to check that unsupported input values in the
PMU event filters are rejected, covering unsupported "action" values,
unsupported "flags" values, and unsupported "nevents" values, as well as the
setting of non-existent fixed counters in the fixed bitmap.

The third patch includes tests for the PMU event filter's behavior when applied
to fixed performance counters, ensuring the correct operation in cases where no
fixed counters exist (e.g., Intel guest PMU version=1 or AMD guest).

Finally, the fourth patch adds a test to verify that setting both generic and
fixed performance event filters does not impact the consistency of the fixed
performance filter behavior.

These changes help to ensure that KVM's PMU event filter functions as expected
in all supported use cases. These patches have been tested and verified to
function properly.

Any feedback or suggestions are greatly appreciated.

Please note that following patches should be applied before this patch series:

https://lore.kernel.org/kvm/20230530134248.23998-2-cloudliang@tencent.com
https://lore.kernel.org/kvm/20230530134248.23998-3-cloudliang@tencent.com

This will ensure that macro definitions such as X86_INTEL_MAX_FIXED_CTR_NUM,
INTEL_PMC_IDX_FIXED, etc. can be used.

Sincerely,
Jinrong Liang

Changes log:

v3:
- Rebased to 31b4fc3bc64a(tag: kvm-x86-next-2023.06.02).
- Dropped the patch "KVM: selftests: Replace int with uint32_t for nevents". (Sean)
- Dropped the patch "KVM: selftests: Test pmu event filter with incompatible
  kvm_pmu_event_filter". (Sean)
- Introduce __kvm_pmu_event_filter to replace the original method of creating
  PMU event filters. (Sean)
- Use the macro definition of kvm_cpu_property to find the number of supported
  fixed counters instead of calculating it via the vcpu's cpuid. (Sean)
- Remove the wrappers that are single line passthroughs. (Sean)
- Optimize function names and variable names. (Sean)
- Optimize comments to make them more rigorous. (Sean)

v2:
- Wrap the code from the documentation in a block of code. (Bagas Sanjaya)

v1:
https://lore.kernel.org/kvm/20230414110056.19665-1-cloudliang@tencent.com

Jinrong Liang (4):
  KVM: selftests: Introduce __kvm_pmu_event_filter to improved event
    filter settings
  KVM: selftests: Test unavailable event filters are rejected
  KVM: selftests: Check if event filter meets expectations on fixed
    counters
  KVM: selftests: Test gp event filters don't affect fixed event filters

 .../kvm/x86_64/pmu_event_filter_test.c        | 341 +++++++++++++-----
 1 file changed, 246 insertions(+), 95 deletions(-)


base-commit: 31b4fc3bc64aadd660c5bfa5178c86a7ba61e0f7
prerequisite-patch-id: 909d42f185f596d6e5c5b48b33231c89fa5236e4
prerequisite-patch-id: ba0dd0f97d8db0fb6cdf2c7f1e3a60c206fc9784
-- 
2.31.1

