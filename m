Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B99702D7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbjEONGn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbjEONGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:06:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BF3580
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aad5245571so87265235ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155960; x=1686747960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8d5WHH7LCFe26MinsbsZnyby5kr64LG/XJK9V0WNKg=;
        b=NaHgRv2bUNBZrF0o+5C3FTpheRmJqZQFaOSP8QzMXPq7WqJETIhWEOKc2lqj4Nm5T5
         a32pCCSQx3QIgMU9tHmNWc24LCETh4+iOmKh8vrKudEVT2S+1tbvRWw9LG+/FQnfDIYd
         tKTg4DVijbBMGL0PW9Mno6mGxd/JJ4F4NkV9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155960; x=1686747960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8d5WHH7LCFe26MinsbsZnyby5kr64LG/XJK9V0WNKg=;
        b=R6oJHt/pELlOqvpzwzOR20qP//EUoizZUmtk0zbH4gSAYbpSBoxqY48NYRyJD+JjUX
         Mw3xI5V/nZcJ2vbh+lN4WekTjr7Y6cq5s4VARBq+Bsj9fBwYYY71kw3BrySns1GJwGZ4
         PY47lp4GbkpIhQBTLO4A2sO2r+/Knd39vSIHGpclRWdlZ6m/ri+yLOWDg1ijU1CEarhu
         PCmHWK/8sJ7Hff5mGea0N6dPj1aWkPm2vOaZ5cm2INhIoaoVxT4RRbat2Z1B4BTseArH
         95sRrfva8EnKd73t3sReluDcUXiT2ouiDtKXw9NRJLHoO2UMoj5a69AAEC/4jH6QguoN
         F23Q==
X-Gm-Message-State: AC+VfDzWIi9oRCd6FRNGxa8FCm7SV8uEYcDffewhwv9LxCIv8cMMoiVD
        8ehZH0ItZkgIv4kSmQdxmlsDEw==
X-Google-Smtp-Source: ACHHUZ5TQiYvEA3rPzvQv/lZBIMaILwMcV3Xu9P4Ckghl/s+uNjurYMNj1KtT/hqR4tacuNKKlahcA==
X-Received: by 2002:a17:902:dace:b0:1ac:6e1f:d1bd with SMTP id q14-20020a170902dace00b001ac6e1fd1bdmr37375631plx.19.1684155960357;
        Mon, 15 May 2023 06:06:00 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id ji1-20020a170903324100b001a9b7584824sm13461277plb.159.2023.05.15.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:05:59 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Date:   Mon, 15 May 2023 13:05:46 +0000
Message-ID: <20230515130553.2311248-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This is the first set of Memory mapping (VMA) protection patches using PKU.

* * * 

Background:

As discussed previously in the kernel mailing list [1], V8 CFI [2] uses 
PKU to protect memory, and Stephen Röttger proposes to extend the PKU to 
memory mapping [3].

We're using PKU for in-process isolation to enforce control-flow integrity
for a JIT compiler. In our threat model, an attacker exploits a 
vulnerability and has arbitrary read/write access to the whole process
space concurrently to other threads being executed. This attacker can
manipulate some arguments to syscalls from some threads.

Under such a powerful attack, we want to create a “safe/isolated”
thread environment. We assign dedicated PKUs to this thread, 
and use those PKUs to protect the threads’ runtime environment.
The thread has exclusive access to its run-time memory. This
includes modifying the protection of the memory mapping, or
munmap the memory mapping after use. And the other threads
won’t be able to access the memory or modify the memory mapping
(VMA) belonging to the thread.

* * * 

Proposed changes:

This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
function. When a PKEY is created with this flag, it is enforced that any
thread that wants to make changes to the memory mapping (such as mprotect)
of the memory must have write access to the PKEY. PKEYs created without
this flag will continue to work as they do now, for backwards 
compatibility.

Only PKEY created from user space can have the new flag set, the PKEY
allocated by the kernel internally will not have it. In other words,
ARCH_DEFAULT_PKEY(0) and execute_only_pkey won’t have this flag set,
and continue work as today.

This flag is checked only at syscall entry, such as mprotect/munmap in
this set of patches. It will not apply to other call paths. In other
words, if the kernel want to change attributes of VMA for some reasons,
the kernel is free to do that and not affected by this new flag.

This set of patch covers mprotect/munmap, I plan to work on other 
syscalls after this. 

* * * 

Testing:

I have tested this patch on a Linux kernel 5.15, 6,1, and 6.4-rc1,
new selftest is added in: pkey_enforce_api.c 

* * * 

Discussion:

We believe that this patch provides a valuable security feature. 
It allows us to create “safe/isolated” thread environments that are 
protected from attackers with arbitrary read/write access to 
the process space.

We believe that the interface change and the patch don't 
introduce backwards compatibility risk.

We would like to disucss this patch in Linux kernel community
for feedback and support. 

* * * 

Reference:

[1]https://lore.kernel.org/all/202208221331.71C50A6F@keescook/
[2]https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit?usp=sharing
[3]https://docs.google.com/document/d/1qqVoVfRiF2nRylL3yjZyCQvzQaej1HRPh3f5wj1AS9I/edit


Best Regards,
-Jeff Xu

Jeff Xu (6):
  PKEY: Introduce PKEY_ENFORCE_API flag
  PKEY: Add arch_check_pkey_enforce_api()
  PKEY: Apply PKEY_ENFORCE_API to mprotect
  PKEY:selftest pkey_enforce_api for mprotect
  KEY: Apply PKEY_ENFORCE_API to munmap
  PKEY:selftest pkey_enforce_api for munmap

 arch/powerpc/include/asm/pkeys.h              |   19 +-
 arch/x86/include/asm/mmu.h                    |    7 +
 arch/x86/include/asm/pkeys.h                  |   92 +-
 arch/x86/mm/pkeys.c                           |    2 +-
 include/linux/mm.h                            |    2 +-
 include/linux/pkeys.h                         |   18 +-
 include/uapi/linux/mman.h                     |    5 +
 mm/mmap.c                                     |   34 +-
 mm/mprotect.c                                 |   31 +-
 mm/mremap.c                                   |    6 +-
 tools/testing/selftests/mm/Makefile           |    1 +
 tools/testing/selftests/mm/pkey_enforce_api.c | 1312 +++++++++++++++++
 12 files changed, 1507 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_enforce_api.c


base-commit: ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
-- 
2.40.1.606.ga4b1b128d6-goog

