Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9932794FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Sep 2020 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgIYXra (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgIYXra (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:30 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A0C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:47:29 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id b12so1161124oop.13
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Sep 2020 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GSI4sitvN/PQsQRygkVbK/E0lWn0wSSF/SgQleFAew=;
        b=GlQFMXnTXTAOOylr3kYi+B0XVNO6JJj3Z6K0SonIh8lTAEh3WGSirGKBmo2BLng6AF
         3yEBAeoNOMsRq6+DKsqCsqSnst/dMAXCW4zQhp8/muiVrfCCwWvOViRLT6umAhCndrg6
         EZS6ZOXeF2OjOZzboXBPHXI40fRUC9kdW0PS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GSI4sitvN/PQsQRygkVbK/E0lWn0wSSF/SgQleFAew=;
        b=s3eh87Vm074xuhGlxxf7gpv7c8e8FwY61Ywf3BRqK1WGXd9pEI45YC0L3OcGB+qUvI
         m3oYFfJtdcCW2NAYVwt+1R+UZLLVDVJAp2oShe0oK5fizgqCWOs/UqZuzLpUjHLle4cV
         qudxJUB8XOtXy8RT+hWUVireLeB4oBbmhqqWbzwt+oqDs7KxHuhZ2R1Y8G3HfwoXt8y5
         zz3mTGygSvmKVYcHE386f8ykcv5zsaekrTL+Aa+QmTov0ZiSKF71++LtcropHBODkCkb
         J9wMinjLhyzcJZaSKHlXth/NCIIMLKnYH/9cJo3uKpw8J58cwNNKFO1h3P1r642EeZCz
         5cYg==
X-Gm-Message-State: AOAM532NvMsmTlGz9+ily5keyKbTVHzrbdaLZUgbZ6m+AxizGdSLXXrS
        7o/oLdCP2V+BYQTdOIxzY5yHYw==
X-Google-Smtp-Source: ABdhPJzG33LzQAtNWbjJrUe3e0Jp9VlAFB19KfXzKWwMfan8ZxMGXjGcjOylRwfV8HLI2ATW602JaQ==
X-Received: by 2002:a4a:9833:: with SMTP id y48mr2545664ooi.73.1601077649166;
        Fri, 25 Sep 2020 16:47:29 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:28 -0700 (PDT)
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
Subject: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
Date:   Fri, 25 Sep 2020 17:47:14 -0600
Message-Id: <cover.1601073127.git.skhan@linuxfoundation.org>
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
    
The purpose of these counters is twofold: 1. clearly differentiate
atomic_t counters from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors. It allows tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors. 2. provides
non-atomic counters for cases where atomic isn't necessary.
    
Simple atomic and non-atomic counters api provides interfaces for simple
atomic and non-atomic counters that just count, and don't guard resource
lifetimes. Counters will wrap around to 0 when it overflows and should
not be used to guard resource lifetimes, device usage and open counts
that control state changes, and pm states.
    
Using counter_atomic to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

This patch series introduces Simple atomic and non-atomic counters.
Counter atomic ops leverage atomic_t and provide a sub-set of atomic_t
ops.

In addition this patch series converts a few drivers to use the new api.
The following criteria is used for select variables for conversion:

1. Variable doesn't guard object lifetimes, manage state changes e.g:
   device usage counts, device open counts, and pm states.
2. Variable is used for stats and counters.
3. The conversion doesn't change the overflow behavior.

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
  counters: Introduce counter_simple* and counter_atomic* counters
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

 Documentation/core-api/counters.rst          | 174 +++++++++
 MAINTAINERS                                  |   8 +
 drivers/acpi/acpi_extlog.c                   |   5 +-
 drivers/acpi/apei/ghes.c                     |   5 +-
 drivers/android/binder.c                     |  41 +--
 drivers/android/binder_internal.h            |   3 +-
 drivers/base/dd.c                            |  19 +-
 drivers/base/devcoredump.c                   |   5 +-
 drivers/base/test/test_async_driver_probe.c  |  23 +-
 drivers/char/ipmi/ipmi_msghandler.c          |   9 +-
 drivers/char/ipmi/ipmi_si_intf.c             |   9 +-
 drivers/edac/edac_pci.h                      |   5 +-
 drivers/edac/edac_pci_sysfs.c                |  28 +-
 drivers/misc/vmw_vmci/vmci_guest.c           |   9 +-
 include/linux/counters.h                     | 350 +++++++++++++++++++
 lib/Kconfig                                  |  10 +
 lib/Makefile                                 |   1 +
 lib/test_counters.c                          | 276 +++++++++++++++
 tools/testing/selftests/lib/Makefile         |   1 +
 tools/testing/selftests/lib/config           |   1 +
 tools/testing/selftests/lib/test_counters.sh |   5 +
 21 files changed, 913 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c
 create mode 100755 tools/testing/selftests/lib/test_counters.sh

-- 
2.25.1

