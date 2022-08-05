Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7458B264
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiHEWVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbiHEWVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5E1AD90
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 15:21:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f3959ba41so31859387b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vA6JwiPIQ35idH1LwuHfAoXwWih02NenmEQERtaUlQk=;
        b=jhXFbm4GcOo7tzG+m2t/JAjwLoRiHbKfayX9CRJ+Z1nBjUfj/kt8Ulq1F0LhapnHWU
         vQlRbYT/RRAr/19sZxiy7+Gw5YKLAuSi4obedsMyt5ePFm2VbgAXa76LqWzI0gy3+k7G
         auoB2i1RLoWlA1oVdLXZeqvneSg9IDJwiQbvRGCr9hOj2w857WdGRB+BjlL6R4waJY4P
         UezKtbOhs+xqa+UUczDURSiB9HsJ+jdEiKKrN79HQVMKHizSOYPwBCpveob6fId8+EHN
         bXZmZjRBWoxEGFljMetZFd/jY81w8X/1pO15hW5wCu1fcpJu1QQ4WMOAumNIK4XDuGno
         KpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vA6JwiPIQ35idH1LwuHfAoXwWih02NenmEQERtaUlQk=;
        b=onjbzw9Yw/WLUzJznIGZPL8CMedMOhe37XWelTkIzoB8PaykxbNgHjb2c+BLij9Jvx
         aa9T4SJbWRWwPDmRs8c2CahtYZNNW5hJYog+Iy+YKAsIepWytX19+FMRVbU4nqsQ4GE3
         zXXjwt2JAsbtcq2XoWLwAnHiewdOnU7mCnHP4ARpt6xFuHPx4UTe2/f3KnO9jpABXw9u
         x4upHDTDmfP90vpAvAn8mh00TPM/sgIlcT1tvFPAVtBv0aCVpmK1gec8/GFe2UpNuUXF
         o6b31AB1dthWaBOx878Tfhuui2UmmU3HpeOzhYAQkemylQklaJwoSQLJW+5KCtUed6w5
         G4Ng==
X-Gm-Message-State: ACgBeo3ii9ccydARLZxiuVhPNjPziFRjDca8cJXBEzkqXw64eFQFatEg
        UpWRKd4IxxYuT3kVTsNgbuLU76hseAc=
X-Google-Smtp-Source: AA6agR5/FcLDV3dK7SdDaErdRpC2Y/obPbr0lLOpjjFPaMlZeqQoYgCKLv8ONTsUzWRhe9Uj92AsbR6yrYs=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a05:6902:13c7:b0:671:7cb2:9a82 with SMTP id
 y7-20020a05690213c700b006717cb29a82mr7285411ybu.334.1659738090124; Fri, 05
 Aug 2022 15:21:30 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:21 +0000
Message-Id: <20220805222126.142525-1-jeffxu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

Hi,

This v2 series MFD_NOEXEC, this series includes:
1> address comments in V1
2> add sysctl (vm.mfd_noexec) to change the default file permissions
    of memfd_create to be non-executable.

Below are cover-level for v1:

The default file permissions on a memfd include execute bits, which
means that such a memfd can be filled with a executable and passed to
the exec() family of functions. This is undesirable on systems where all
code is verified and all filesystems are intended to be mounted noexec,
since an attacker may be able to use a memfd to load unverified code and
execute it.

Additionally, execution via memfd is a common way to avoid scrutiny for
malicious code, since it allows execution of a program without a file
ever appearing on disk. This attack vector is not totally mitigated with
this new flag, since the default memfd file permissions must remain
executable to avoid breaking existing legitimate uses, but it should be
possible to use other security mechanisms to prevent memfd_create calls
without MFD_NOEXEC on systems where it is known that executable memfds
are not necessary.

This patch series adds a new MFD_NOEXEC flag for memfd_create(), which
allows creation of non-executable memfds, and as part of the
implementation of this new flag, it also adds a new F_SEAL_EXEC seal,
which will prevent modification of any of the execute bits of a sealed
memfd.

I am not sure if this is the best way to implement the desired behavior
(for example, the F_SEAL_EXEC seal is really more of an implementation
detail and feels a bit clunky to expose), so suggestions are welcome
for alternate approaches.

v1: https://lwn.net/Articles/890096/

Daniel Verkamp (4):
  mm/memfd: add F_SEAL_EXEC
  mm/memfd: add MFD_NOEXEC flag to memfd_create
  selftests/memfd: add tests for F_SEAL_EXEC
  selftests/memfd: add tests for MFD_NOEXEC

Jeff Xu (1):
  sysctl: add support for mfd_noexec

 include/linux/mm.h                         |   4 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   1 +
 kernel/sysctl.c                            |   9 ++
 mm/memfd.c                                 |  39 ++++-
 mm/shmem.c                                 |   6 +
 tools/testing/selftests/memfd/memfd_test.c | 163 ++++++++++++++++++++-
 7 files changed, 221 insertions(+), 2 deletions(-)


base-commit: 9e2f40233670c70c25e0681cb66d50d1e2742829
-- 
2.37.1.559.g78731f0fdb-goog

