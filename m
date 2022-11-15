Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8662AF2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiKOXLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 18:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiKOXLc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 18:11:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7592E9D7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso616247pjc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ckjuguz6xE0eRfA8bVi0J3H4nsbDymh+GHZEWw5n08=;
        b=PLZmDsPzklxZ4b8mgS4haHWQSr/YfYPgxSkCXoTUJP9qno9EQvn69Pn5x1H6Dw0vKS
         bLf5pNvKrIDk7Rn+zhBCzV1h5xoBm6gkTiPqBUdpduCHFj2FaR3Q6oBZ7I1euKKvVpZF
         faocSd5vd1p8UELU5k7G4ZB/yEE6Ncr/RS83a9buGDdjsXGfFDzIhol7ziUpjlk3oCzm
         x8St2XsucdS05oDsXAze+HwZOfX4ApUqsXMni/hD3yOLG/VKmCmec5feMbQswdbedJb2
         7UxXjGd86kjyTacshQZ5X0ZEbhYzkcbFnFeMBdOANWRm8SopGGm6CKvbz/gzHfW59eqZ
         16Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ckjuguz6xE0eRfA8bVi0J3H4nsbDymh+GHZEWw5n08=;
        b=xgJgyk818spdYS0bgUeAcbjjWysyN9eixk6WEbp3Wq19K1RTanqjeKTFjN3LHtJdp3
         UbMF4AjhS3ozFkvWV+R/54SDuAQ2+cZx6WqGz4ZX4GmuBJnTwYJxcofqvWXiHW7TdFsh
         n6uorJl5uuWatnIX9JnpPGybKXplVFyhywOmAAR33JtFu+vkhDmUwnP1g+eRe1BAvGF0
         irLfBY73s5BmYyhr7F53oYvEyVJzGLuiVURVRo0xj9IqfDzjHMpy7BNPGwJc5iWiJzJI
         NWc8AC1McYWYX3JuQtA7PGWTIynG1skc5CY8R/Zn2yuNAYMFrRRA8J+4s1B9x5Bj527z
         35xA==
X-Gm-Message-State: ANoB5pnJtToGNaqkERHx1WsaZWPEz3211hWRWqPWiaD7yl4MP/SfcUcD
        Ppnulwal//Wv4tnUGt6GnLY7yg==
X-Google-Smtp-Source: AA0mqf4loq3vghc/jvj4xbQ6I9i7XWfAYQZ+V+taawPejYNuLVIGVfefp1KPKapqN0ctJtQ4ODggbw==
X-Received: by 2002:a17:90a:d145:b0:211:7e51:9d65 with SMTP id t5-20020a17090ad14500b002117e519d65mr592266pjw.220.1668553891109;
        Tue, 15 Nov 2022 15:11:31 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id f15-20020a62380f000000b0056c360af4e3sm9308372pfa.9.2022.11.15.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:11:30 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Subject: [PATCH v7 0/6] x86/fpu: Allow PKRU to be (once again) written by ptrace
Date:   Tue, 15 Nov 2022 15:09:26 -0800
Message-Id: <20221115230932.7126-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi.

Following last week's discussion I've reorganized this patch. The goal
remains to restore the pre-5.14 behavior of ptrace(PTRACE_SET_REGSET,
NT_X86_XSTATE) for the PKRU register (which was equivalent to a hardware
XRSTOR instruction).

There are three different kernel APIs that write PKRU:
1. sigreturn
2. PTRACE_SET_REGSET with NT_X86_XSTATE
3. KVM_SET_XSAVE

sigreturn restores PKRU from the fpstate and works as expected today.

PTRACE_SET_REGSET restores PKRU from the thread_struct's pkru member and
doesn't work at all.

KVM_SET_XSAVE restores PKRU from the vcpu's pkru member and honors
changes to the PKRU value in the XSAVE region but does not honor clearing
the PKRU bit in the xfeatures mask. The KVM maintainers do not want to
change the KVM behavior at the current time, however, so this quirk
survives after this patch set.

All three APIs ultimately call into copy_uabi_to_xstate(). Part 3 adds
an argument to that function that is used to pass in a pointer to either
the thread_struct's pkru or the vcpu's PKRU, for sigreturn/PTRACE_SET_REGSET
or KVM_SET_XSAVE respectively. While this isn't strictly necessary for
sigreturn, it makes part 5 easier. Parts 1 and 2 refactor the various
callers of copy_uabi_to_xstate() to make that possible.

Part 4 moves the existing KVM-specific PKRU handling in
fpu_copy_uabi_to_guest_fpstate() to copy_uabi_to_xstate() where it is now
shared amongst all three APIs. This is a no-op for sigreturn (which restores
PKRU from the fpstate anyways) and KVM but it changes the PTRACE_SET_REGSET
behavior to match KVM_SET_XSAVE.

Part 5 emulates the hardware XRSTOR behavior where PKRU is reset to the
hardware init value if the PKRU bit in the xfeatures mask is clear. KVM is
excluded from this emulation by passing a NULL pkru slot pointer to
copy_uabi_to_xstate() in this case. Passing in a pointer to the
thread_struct's PKRU slot for sigreturn (even though sigreturn won't restore
PKRU from that location) allows distinguishing KVM here. This changes
the PTRACE_SET_REGSET behavior to fully match sigreturn.

Part 6 is the self test that remains unchanged from v3 of this patchset.

At no point in this patch set is the user-visible behavior of sigreturn
or KVM_SET_XSAVE changed.

Changelog since v6:
- v6's part 1/2 is now split into parts 1 through 5.
- v6's part 2/2 is now part 6.
- Various style comments addressed.

Changelog since v5:
- Avoids a second copy from the uabi buffer as suggested.
- Preserves old KVM_SET_XSAVE behavior where leaving the PKRU bit in the
  XSTATE header results in PKRU remaining unchanged instead of
  reinitializing it.
- Fixed up patch metadata as requested.

Changelog since v4:
- Selftest additionally checks PKRU readbacks through ptrace.
- Selftest flips all PKRU bits (except the default key).

Changelog since v3:
- The v3 patch is now part 1 of 2.
- Adds a selftest in part 2 of 2.

Changelog since v2:
- Removed now unused variables in fpu_copy_uabi_to_guest_fpstate

Changelog since v1:
- Handles the error case of copy_to_buffer().


