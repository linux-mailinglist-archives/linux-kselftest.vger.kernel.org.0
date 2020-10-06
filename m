Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D62285352
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgJFUox (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgJFUox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 16:44:53 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E5C0613D5
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Oct 2020 13:44:53 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o18so145969ill.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Oct 2020 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAVTd4/uhiW60aPw+XvSmqORkXupHL87bPyGbV0HsYw=;
        b=U8RRNn9buGpyfeQW5lvmH3Wmzq2YD8O1mN7x0FY+53p4cXKgvqPJy505TkImeSvG5u
         vPqk7VPNdpjJ6qSCnY+aBFwsvl58Pzzg7PMB9AE+AL+AfTUxXgRReKKC4MwkcYRN5fQj
         kFbcmpk7KiSko4YptwdL9RjK32FM9VmUFsc+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAVTd4/uhiW60aPw+XvSmqORkXupHL87bPyGbV0HsYw=;
        b=H4N3rdjOtUXi2E7+9hkCfmxU38WEn4VLRNdvDk9aAsQ70Yo3cd+509S0HUzNvdpqRn
         B7CO8AFNrN3oP8MQBNxvS/ZV5zOKjyxLS+rloLOYK8+ZTGKAfiJ/a2QCzP/WYTvMP7Wf
         tsNLdsJT+9U2KVsYVu4J1aDmq9Uu7VYbe4fp4WpouLiMNOBW6LeIAPUBM43scrHZoBwu
         nGOQMtih9aRoh9Ru6sojsHx39QhQgBQcjJKLqUHyf6iwCV0CHbcx6rFx5ikv74jOk4l+
         ErnYm+W0cugzxDbn+66XQlu52i2ojE7VEGWgEcTDMEsI0qxtcOMWTUs6eNSFdeKkpIw4
         H9aA==
X-Gm-Message-State: AOAM533ECXd570gohdwWLqzB9l/7p3aogPDzYB+Kx0yOyd+ZvZKNGhnW
        VFFTCvLn6mTpjuGWtuLwZ8AA1Q==
X-Google-Smtp-Source: ABdhPJyYiB/m/jo1bQRIrsuVzVlWXVEm/AoM5jDHZ7E+dxaOLQnEmcXEJ+hfYOVO3MBQ5PqFH2fXzQ==
X-Received: by 2002:a92:b30c:: with SMTP id p12mr9703ilh.35.1602017092051;
        Tue, 06 Oct 2020 13:44:52 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:44:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        shuah@kernel.org, rafael@kernel.org, johannes@sipsolutions.net,
        lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, minyard@acm.org,
        arnd@arndb.de, mchehab@kernel.org, rric@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org
Subject: [PATCH v2 00/11] Introduce Simple atomic counters
Date:   Tue,  6 Oct 2020 14:44:31 -0600
Message-Id: <cover.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series is a result of discussion at the refcount_t BOF
the Linux Plumbers Conference. In this discussion, we identified
a need for looking closely and investigating atomic_t usages in
the kernel when it is used strictly as a counter without it
controlling object lifetimes and state changes.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting and not for managing object lifetime. In
some cases, atomic_t might not even be needed.

The purpose of these counters is to clearly differentiate atomic_t
counters from atomic_t usages that guard object lifetimes, hence prone
to overflow and underflow errors. It allows tools that scan for underflow
and overflow on atomic_t usages to detect overflow and underflows to scan
just the cases that are prone to errors.

Simple atomic counters api provides interfaces for simple atomic counters
that just count, and don't guard resource lifetimes. Counter will wrap
around to 0 when it overflows and should not be used to guard resource
lifetimes, device usage and open counts that control state changes, and
pm states.

Using counter_atomic* to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

This patch series introduces Simple atomic counters. Counter atomic ops
leverage atomic_t and provide a sub-set of atomic_t ops.

In addition this patch series converts a few drivers to use the new api.
The following criteria is used for select variables for conversion:

1. Variable doesn't guard object lifetimes, manage state changes e.g:
   device usage counts, device open counts, and pm states.
2. Variable is used for stats and counters.
3. The conversion doesn't change the overflow behavior.

Changes since Patch v1
-- Thanks for reviews and reviewed-by, and Acked-by tags. Updated
   the patches with the tags.
-- Addressed Kees's  and Joel's comments:
   1. Removed dec_return interfaces (Patch 1/11)
   2. Removed counter_simple interfaces to be added later with changes
      to drivers that use them (if any) (Patch 1/11)
   3. Comment and Changelogs updates to Patch 2/11

Kees, if this series is good, would you like to take this through your
tree or would you like to take this through mine?

Changes since RFC:
-- Thanks for reviews and reviewed-by, and Acked-by tags. Updated
   the patches with the tags.
-- Addressed Kees's comments:
   1. Non-atomic counters renamed to counter_simple32 and counter_simple64
      to clearly indicate size.
   2. Added warning for counter_simple* usage and it should be used only
      when there is no need for atomicity.
   3. Renamed counter_atomic to counter_atomic32 to clearly indicate size.
   4. Renamed counter_atomic_long to counter_atomic64 and it now uses
      atomic64_t ops and indicates size.
   5. Test updated for the API renames.
   6. Added helper functions for test results printing
   7. Verified that the test module compiles in kunit env. and test
      module can be loaded to run the test.
   8. Updated Documentation to reflect the intent to make the API
      restricted so it can never be used to guard object lifetimes
      and state management. I left _return ops for now, inc_return
      is necessary for now as per the discussion we had on this topic.
-- Updated driver patches with API name changes.
-- We discussed if binder counters can be non-atomic. For now I left
   them the same as the RFC patch - using counter_atomic32
-- Unrelated to this patch series:
   The patch series review uncovered improvements could be made to
   test_async_driver_probe and vmw_vmci/vmci_guest. I will track
   these for fixing later.

Shuah Khan (11):
  counters: Introduce counter_atomic* counters
  selftests:lib:test_counters: add new test for counters
  drivers/base: convert deferred_trigger_count and probe_count to
    counter_atomic32
  drivers/base/devcoredump: convert devcd_count to counter_atomic32
  drivers/acpi: convert seqno counter_atomic32
  drivers/acpi/apei: convert seqno counter_atomic32
  drivers/android/binder: convert stats, transaction_log to
    counter_atomic32
  drivers/base/test/test_async_driver_probe: convert to use
    counter_atomic32
  drivers/char/ipmi: convert stats to use counter_atomic32
  drivers/misc/vmw_vmci: convert num guest devices counter to
    counter_atomic32
  drivers/edac: convert pci counters to counter_atomic32

 Documentation/core-api/counters.rst          | 103 +++++++++++
 MAINTAINERS                                  |   8 +
 drivers/acpi/acpi_extlog.c                   |   5 +-
 drivers/acpi/apei/ghes.c                     |   5 +-
 drivers/android/binder.c                     |  41 ++---
 drivers/android/binder_internal.h            |   3 +-
 drivers/base/dd.c                            |  19 +-
 drivers/base/devcoredump.c                   |   5 +-
 drivers/base/test/test_async_driver_probe.c  |  23 +--
 drivers/char/ipmi/ipmi_msghandler.c          |   9 +-
 drivers/char/ipmi/ipmi_si_intf.c             |   9 +-
 drivers/edac/edac_pci.h                      |   5 +-
 drivers/edac/edac_pci_sysfs.c                |  28 +--
 drivers/misc/vmw_vmci/vmci_guest.c           |   9 +-
 include/linux/counters.h                     | 173 +++++++++++++++++++
 lib/Kconfig                                  |  10 ++
 lib/Makefile                                 |   1 +
 lib/test_counters.c                          | 157 +++++++++++++++++
 tools/testing/selftests/lib/Makefile         |   1 +
 tools/testing/selftests/lib/config           |   1 +
 tools/testing/selftests/lib/test_counters.sh |   5 +
 21 files changed, 546 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c
 create mode 100755 tools/testing/selftests/lib/test_counters.sh

-- 
2.25.1

