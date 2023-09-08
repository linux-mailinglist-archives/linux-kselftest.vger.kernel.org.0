Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94E798BA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbjIHR6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245200AbjIHR6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 13:58:06 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593D1FCD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 10:58:01 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-500b575b32dso2227827e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195880; x=1694800680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ErZ/9dohV3kfQDHS+ABptN0u7+XrtGJQodsGEJaInJ0=;
        b=5gZ88qh7pGh7FvvjtZCDaT3QTsWxCLzDQNH0/+RXjVR3V62Oo+ehy/A7wpU4yn+5V8
         0i+sKK8/L2IuKdQ+I/7naxAnl254bE52eFeNfmc8svD9oZOgISzWnEsKtucn74laGS9P
         +0DTI8/KOGNK+MF4BEXrfz1XCyfAwyLW1H9h0pJEjuifp3PWFx3qzZJVhAZTkil6+9dm
         y/tSnbJyRpjSwJtDyIXNq4h/w8gfB3C3QiwTwQOwlyqLA7fPhBswTiGYdhi4qiBYDiku
         MvSfZPNowb+oSDfRHJSHmfszaQCyl5hLpCKLVjszZ3B5YcmIOnmyVObgj7/NQnl5NA2t
         JoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195880; x=1694800680;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErZ/9dohV3kfQDHS+ABptN0u7+XrtGJQodsGEJaInJ0=;
        b=Jd4/Cn+sK91cBrDp8n5Rhs6vLjMxfCv2WZScyjYfachfin7WoYzdIthRjQZUQ5c21t
         /oN9KGEWuXoY/E69khEqZc3nJY10/aizq1EgkqqxWqFsbAr7yt8cVCM6VU/1VxztEBfe
         4UUltZr3FQp9OcO1St6wSo/hEMl67fWL71AXET7XmnRCkNICLte46r9viix4/dHNcL3e
         HtW5rDiAFEslo5Ndp0Dt1oUeIyYkIIfXRuRfTWKWbIO2ZvqSQSlvzN/jvr8y4X9oR0MX
         +4Fd/LZtorBDnfj83mg8w3ZHxl1LLoaWLl1KdZ+HDk+lt9V4cbvQ4RbSArADUrxwtO7M
         sg8w==
X-Gm-Message-State: AOJu0YxbhsXN2WJwZbFHnYGZx+4lPE32co0nX3Fn0fix0ukZKm3Ua3Zw
        4CzU8N2Kksnveu8Bpxd1XsFStL/eX5YM5N8r
X-Google-Smtp-Source: AGHT+IHIoFphFVujlKv0bW17vR3YnKxwcj2a41Lvx91RQMP11PbBJoLPxgodACZwwAjv+ntEO+ya/BHoHYpyXdwz
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:aa82:a90b:b76f:32b0])
 (user=mclapinski job=sendgmr) by 2002:ac2:5321:0:b0:502:9360:ca50 with SMTP
 id f1-20020ac25321000000b005029360ca50mr51728lfh.1.1694195879603; Fri, 08 Sep
 2023 10:57:59 -0700 (PDT)
Date:   Fri,  8 Sep 2023 19:57:36 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908175738.41895-1-mclapinski@google.com>
Subject: [PATCH v2 0/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This change introduces a way to check if an fd points to a memfd's
original open fd (the one created by memfd_create).

We encountered an issue with migrating memfds in CRIU (checkpoint
restore in userspace - it migrates running processes between
machines). Imagine a scenario:
1. Create a memfd. By default it's open with O_RDWR and yet one can
exec() to it (unlike with regular files, where one would get ETXTBSY).
2. Reopen that memfd with O_RDWR via /proc/self/fd/<fd>.

Now those 2 fds are indistinguishable from userspace. You can't exec()
to either of them (since the reopen incremented inode->i_writecount)
and their /proc/self/fdinfo/ are exactly the same. Unfortunately they
are not the same. If you close the second one, the first one becomes
exec()able again. If you close the first one, the other doesn't become
exec()able. Therefore during migration it does matter which is recreated
first and which is reopened but there is no way for CRIU to tell which
was first.

---
Changes since v1 at [1]:
  - Rewrote it from fcntl to ioctl. This was requested by filesystems
    maintainer.

Links:
  [1] https://lore.kernel.org/all/20230831203647.558079-1-mclapinski@google.com/

Michal Clapinski (2):
  mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
  selftests: test ioctl(MEMFD_CHECK_IF_ORIGINAL)

 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/hugetlbfs/inode.c                          |  9 ++++++
 include/linux/memfd.h                         | 12 +++++++
 mm/memfd.c                                    |  9 ++++++
 mm/shmem.c                                    |  9 ++++++
 tools/testing/selftests/memfd/memfd_test.c    | 32 +++++++++++++++++++
 6 files changed, 72 insertions(+)

-- 
2.42.0.283.g2d96d420d3-goog

