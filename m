Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E22AE056
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 20:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKJTz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 14:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbgKJTyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:31 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D896C061A04
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 11:54:30 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n12so15594166ioc.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdba1It8LuruBRXATlGs5ogDOu37tb0jUQlcsfQ+i94=;
        b=erhpGeuR4YZoPxfbaOj6VRTo5qEDTaMnmy8kz3XZUQlHcvUC5PAMnd4vRUgcWhnCY4
         HmjHbSPgIj5umTnUKC8XvX1IvbsCFZxMBGUdUE7TrHhyO2iCd6OhgwKqfD97WQg1umxw
         JFTX/vqjOOD2aZVjcPXZOK3wm7m2rMYTBiYoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdba1It8LuruBRXATlGs5ogDOu37tb0jUQlcsfQ+i94=;
        b=faO8M//7GdnaYLsJxUNgu6YKdc1U0qIBVL5/ian38P/3+gO1Ia22gnCaB/jNwReQZ7
         Oz/pJCQVLxiWoTy1zgZWAha2k60/ozMq0wnK6wupoSOl5Msu1wkfJrFwUG0ocYc5CDdZ
         2NyoWerFjfAlao+j0mA/yC1bwOmnpBwyV2dtR3T9KpVFsXnIE/fn/TdRdH+alK8g0ddG
         ZpTNkrq7kvszBIIi7sYygDfUHiV2OUkC3wVGqaFouP534fgX2njiYQ1l/wkRdWL6Jknd
         LUfIZC/MEc/x8CstHeAgU+LG0uBsAq19ide4+KoKBN8Ns62h1lxGxMf3zkNTIj4f8OKm
         Xflg==
X-Gm-Message-State: AOAM533wRhWVOvBGFki+BF+5KHACWPIAnrlw/OaUEYY8yZirSK5Ji3bM
        ray230iIXWg1/WD2cTT1seZNAg==
X-Google-Smtp-Source: ABdhPJzSoGm8gSgvRaSBerc+sxmFJLhfNH27ldXelE/5n3b7bzL48Ie7m56QLtjKLU/yXqTHWYQj8w==
X-Received: by 2002:a6b:b30b:: with SMTP id c11mr15269551iof.175.1605038069386;
        Tue, 10 Nov 2020 11:54:29 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:28 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, valentina.manea.m@gmail.com, shuah@kernel.org,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 00/13] Introduce seqnum_ops 
Date:   Tue, 10 Nov 2020 12:53:26 -0700
Message-Id: <cover.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting sequence numbers and other statistical
counters and not for managing object lifetime.

The purpose of these Sequence Number Ops is to clearly differentiate
atomic_t counter usages from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors.

The atomic_t api provides a wide range of atomic operations as a base
api to implement atomic counters, bitops, spinlock interfaces. The usages
also evolved into being used for resource lifetimes and state management.
The refcount_t api was introduced to address resource lifetime problems
related to atomic_t wrapping. There is a large overlap between the
atomic_t api used for resource lifetimes and just counters, stats, and
sequence numbers. It has become difficult to differentiate between the
atomic_t usages that should be converted to refcount_t and the ones that
can be left alone. Introducing seqnum_ops to wrap the usages that are
stats, counters, sequence numbers makes it easier for tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors.

Sequence Number api provides interfaces for simple atomic_t counter usages
that just count, and don't guard resource lifetimes. The seqnum_ops are
built on top of atomic_t api, providing a smaller subset of atomic_t
interfaces necessary to support atomic_t usages as simple counters.
This api has init/set/inc/dec/read and doesn't support any other atomic_t
ops with the intent to restrict the use of these interfaces as simple
counting usages.

Sequence Numbers wrap around to INT_MIN when it overflows and should not
be used to guard resource lifetimes, device usage and open counts that
control state changes, and pm states. Overflowing to INT_MIN is consistent
with the atomic_t api, which it is built on top of.

Using seqnum to guard lifetimes could lead to use-after free when it
overflows and undefined behavior when used to manage state changes and
device usage/open states.

In addition this patch series converts a few drivers to use the new api.
The following criteria is used for select variables for conversion:

1. Variable doesn't guard object lifetimes, manage state changes e.g:
   device usage counts, device open counts, and pm states.
2. Variable is used for stats and counters.
3. The conversion doesn't change the overflow behavior.
4. Note: inc_return() usages are changed to _inc() followed by _read()
   Patches: 03/13, 04/13, 09/13, 10/13, 11/13
5. drivers/acpi and drivers/acpi/apei patches have been reviewed
   before the rename, however in addition to rename, inc_return()
   usages are changed to _inc() followed by _read()
6. test_async_driver_probe, char/ipmi, and edac patches have been
   reviewed and no changes other than the rename to seqnum_ops.
7. security/integrity/ima: Okay to depend on CONFIG_64BIT? 

The work for this is a follow-on to the discussion and review of
Introduce Simple atomic counters patch series:

//lore.kernel.org/lkml/cover.1602209970.git.skhan@linuxfoundation.org/

Based on the feedback to restrict and limit the scope:
- dropped inc_return()
- renamed interfaces to match the intent and also shorten the
  interface names.

Shuah Khan (13):
  seqnum_ops: Introduce Sequence Number Ops
  selftests: lib:test_seqnum_ops: add new test for seqnum_ops
  drivers/acpi: convert seqno seqnum_ops
  drivers/acpi/apei: convert seqno to seqnum_ops
  drivers/base/test/test_async_driver_probe: convert to use seqnum_ops
  drivers/char/ipmi: convert stats to use seqnum_ops
  drivers/edac: convert pci counters to seqnum_ops
  drivers/oprofile: convert stats to use seqnum_ops
  drivers/staging/rtl8723bs: convert stats to use seqnum_ops
  usb: usbip/vhci: convert seqno to seqnum_ops
  drivers/staging/rtl8188eu: convert stats to use seqnum_ops
  drivers/staging/unisys/visorhba: convert stats to use seqnum_ops
  security/integrity/ima: converts stats to seqnum_ops

 Documentation/core-api/atomic_ops.rst         |   4 +
 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/seqnum_ops.rst         | 126 ++++++++++++++
 MAINTAINERS                                   |   8 +
 drivers/acpi/acpi_extlog.c                    |   6 +-
 drivers/acpi/apei/ghes.c                      |   6 +-
 drivers/base/test/test_async_driver_probe.c   |  26 +--
 drivers/char/ipmi/ipmi_msghandler.c           |   9 +-
 drivers/char/ipmi/ipmi_si_intf.c              |   9 +-
 drivers/char/ipmi/ipmi_ssif.c                 |   9 +-
 drivers/edac/edac_pci.h                       |   5 +-
 drivers/edac/edac_pci_sysfs.c                 |  28 ++--
 drivers/oprofile/buffer_sync.c                |   9 +-
 drivers/oprofile/event_buffer.c               |   3 +-
 drivers/oprofile/oprof.c                      |   3 +-
 drivers/oprofile/oprofile_stats.c             |  11 +-
 drivers/oprofile/oprofile_stats.h             |  11 +-
 drivers/oprofile/oprofilefs.c                 |   3 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  23 ++-
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |   3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |   3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  33 ++--
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |   3 +-
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |   3 +-
 .../staging/unisys/visorhba/visorhba_main.c   |  37 +++--
 drivers/usb/usbip/vhci.h                      |   3 +-
 drivers/usb/usbip/vhci_hcd.c                  |   9 +-
 drivers/usb/usbip/vhci_rx.c                   |   3 +-
 include/linux/oprofile.h                      |   3 +-
 include/linux/seqnum_ops.h                    | 154 ++++++++++++++++++
 lib/Kconfig                                   |   9 +
 lib/Makefile                                  |   1 +
 lib/test_seqnum_ops.c                         | 154 ++++++++++++++++++
 security/integrity/ima/ima.h                  |   5 +-
 security/integrity/ima/ima_api.c              |   2 +-
 security/integrity/ima/ima_fs.c               |   4 +-
 security/integrity/ima/ima_queue.c            |   7 +-
 tools/testing/selftests/lib/Makefile          |   1 +
 tools/testing/selftests/lib/config            |   1 +
 .../testing/selftests/lib/test_seqnum_ops.sh  |  10 ++
 40 files changed, 637 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/core-api/seqnum_ops.rst
 create mode 100644 include/linux/seqnum_ops.h
 create mode 100644 lib/test_seqnum_ops.c
 create mode 100755 tools/testing/selftests/lib/test_seqnum_ops.sh

-- 
2.27.0

