Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECE658661
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Dec 2022 20:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiL1TYs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Dec 2022 14:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiL1TYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Dec 2022 14:24:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A913EB6
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r17-20020a17090aa09100b0021903e75f14so7090114pjp.9
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Dec 2022 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bCqKzNO/sV1xA0tw8G4wlXIPUU+2YxbZOWSs6DXXIHU=;
        b=AyzeTyN2Jl9A+vgxF5pIBGLPh1T0qKh2Yl02a8PYsQJwpVgZMhKKulr2k2ivswTPcF
         KN4PFwjw1InW7UVfkB8fYtgvWObRTmfT5PHmlZ7U/lbB+AtSq7fgtjwVEs3s17+ixP2q
         /70AQjNqjhMFgIjsfb7wv8XKPRf4b+bi+//zJ9I/15wv52uspPxtwQhqsG5RfcRn6bZR
         uUh66NmH0EBsVB0SEfAif5TNEzSz2EusU/+q04Lx731PrULE46E0gskMNkpw8x/zEsUf
         /qc0mLaGHrE617ecyqsALZx/28rl7y38x4Hof7URzPEQS5FZA89NKHuNxb+tSuto8hL/
         zkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCqKzNO/sV1xA0tw8G4wlXIPUU+2YxbZOWSs6DXXIHU=;
        b=GVdKMgDnSv/7K+amEHH4wcjjcWxHd1i8jkQWRdfNwChcldoj2EQt3SASy+muQyWDTA
         Ad7bULbLZX8YVUpKSvG+9RydybEy8orlrqbRvKIF7tpgIYWKHOcLuIoqJSN/2CHGSpRK
         4IYkcM9TbhysS0R/bDR4bPFpaLOFQHyvT5uUtRYvLmreEVoqw/ss8Kdj11OM9mfnI7wR
         wYP28gHGU6MJwbRj4n7AQiAuI7T24oMdTYKjKRUjrFGOL8QDKvav3LnyoE4TkH/Q+GWt
         CsujZR3oocvcgKlx0dj8uTr2LrORpJWLupYFUbONNcjeJC3DaWxgetOj33yfxnuTNW1I
         7tew==
X-Gm-Message-State: AFqh2kpNPxHKLKY3UG3WcbCltqDwK8YS4/pkk+JGGFQGukfHBuAfXUx3
        tOIAoNgjp9OXUuiq5IPGAgcRyzA4I+6nh2hR
X-Google-Smtp-Source: AMrXdXtczBbC4gOkuY8fyj8GLvFBw8u5fcJQAsmg8+Zk5BRzu9WEfhCZBLEomwBgIFoDCOwFTtz8lKRDNBukVY2M
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:aa7:9d11:0:b0:56b:676e:1815 with SMTP
 id k17-20020aa79d11000000b0056b676e1815mr1678776pfp.66.1672255482753; Wed, 28
 Dec 2022 11:24:42 -0800 (PST)
Date:   Wed, 28 Dec 2022 19:24:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228192438.2835203-1-vannapurve@google.com>
Subject: [V4 PATCH 0/4] Execute hypercalls according to host cpu
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Confidential VMs(CVMs) need to execute hypercall instruction as per the CPU
type. Normally KVM emulates the vmcall/vmmcall instruction by patching
the guest code at runtime. Such a guest memory manipulation by KVM is
not allowed with CVMs and is also undesirable in general.

This series adds support of executing hypercall as per the host cpu
type queried using cpuid instruction. CPU vendor type is stored early
during selftest setup and guest setup to be reused later.

Changes in v4:
1) Incoporated suggestions from Sean -
  * Added APIs to query host cpu type
  * Shared the host cpu type with guests to avoid querying the cpu type
    again
  * Modified kvm_hypercall to execute vmcall/vmmcall according to host
    cpu type.
2) Dropped the separate API for kvm_hypercall.

v3:
https://lore.kernel.org/lkml/20221222230458.3828342-1-vannapurve@google.com/

Vishal Annapurve (4):
  KVM: selftests: x86: use this_cpu_* helpers
  KVM: selftests: x86: Add variables to store cpu type
  KVM: sefltests: x86: Replace is_*cpu with is_host_*cpu
  KVM: selftests: x86: Invoke kvm hypercall as per host cpu

 .../selftests/kvm/include/x86_64/processor.h  | 26 ++++++++++-
 .../selftests/kvm/lib/x86_64/processor.c      | 44 ++++++++++---------
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  4 +-
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  2 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |  4 +-
 .../vmx_exception_with_invalid_guest_state.c  |  2 +-
 6 files changed, 54 insertions(+), 28 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

