Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53927418B74
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhIZWfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhIZWfG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A74C061575
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so15076082qtv.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihFPTFKKKq4JF63fFgU4S70k8fEeFkVZwaLA0o+0S1w=;
        b=dt6kBKPfhesz6dYT4wmTDIEwXlzaggBWLdWaQcYWSpLTvcbCrGkjSfZjOqBbK+rH5b
         arzqWzA7d9m89grrzH7dspeb5/5cfnQi+HzHvZNH0ejZmDYZ+FqlrKVJlrhONuFQ9mqD
         sTUpopnfFaYU7kVlQ4qVk0apIdL0cFL5m2msYcQXRaB/49F4hU9L0jJkko32yCEuDWDN
         GAk6Y5pgq9bQQheIQCFrPqIGkyFURYc+Kxr2qp7DydpaokM7l0yqPAPDMkXAclKz/MMa
         77QkLn2bSDCGG6XC51arCYAUw5uPGCWijIKT7SXsQIfAsZTyXerBMqEXMQJFGSlEBL+C
         9kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihFPTFKKKq4JF63fFgU4S70k8fEeFkVZwaLA0o+0S1w=;
        b=nVsdRtNteP4Jzo53WPZ2V5zgaxl5pY5Yx4knC4IDwGwuZDrPGAHorirpfrV7SvMQRZ
         v8Znuy9EaosiSV437knkSthLGy5H8l0dGx/vkK0pk7KmstTzqYth+/8oILhJ1oKrvgMm
         iiDKZvbQpttFknJFoaheF/RzZjBaBqdcMfNnzl05I/z6SL8YYDcVkli3VaJQk5nCak1e
         Qe7aeoZfJPX09SAf8Ac2lvvVDyBiN1cUKUhF+SPxqN7HvZYL8Q19J//Otwnxok9oGt+u
         3ZLYBlyHk1SnY1WDJevQN5kMblZ+Z67uulj9QpuFSBosHQVR99oOGeDY3vNty3Ak8F9X
         UHqA==
X-Gm-Message-State: AOAM533jdvWjmbHVcnMusUqGbYNIo8tFsS11Pag4upFfoLckxG8jPoh3
        A3Q4dKi81dcf7qBJfGIiETTCow==
X-Google-Smtp-Source: ABdhPJxe0bzrgVx21M0zs7TeiFoD4MQoDNbqqKqxUqdQ/rM3rf0ncylbP00xYCNDejGIO+FJWz8xNg==
X-Received: by 2002:ac8:d3:: with SMTP id d19mr13696347qtg.409.1632695608592;
        Sun, 26 Sep 2021 15:33:28 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:28 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 0/5] test_hash.c: refactor into KUnit
Date:   Sun, 26 Sep 2021 19:33:17 -0300
Message-Id: <20210926223322.848641-1-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We refactored the lib/test_hash.c file into KUnit as part of the student
group LKCAMP [1] introductory hackathon for kernel development.

This test was pointed to our group by Daniel Latypov [2], so its full
conversion into a pure KUnit test was our goal in this patch series, but
we ran into many problems relating to it not being split as unit tests,
which complicated matters a bit, as the reasoning behind the original
tests is quite cryptic for those unfamiliar with hash implementations.

Some interesting developments we'd like to highlight are:

- In patch 1/5 we noticed that there was an unused define directive that
  could be removed.
- In patch 4/5 we noticed how stringhash and hash tests are all under
  the lib/test_hash.c file, which might cause some confusion, and we
  also broke those kernel config entries up.

Overall KUnit developments have been made in the other patches in this
series:

In patches 2/5, 3/5 and 5/5 we refactored the lib/test_hash.c
file so as to make it more compatible with the KUnit style, whilst
preserving the original idea of the maintainer who designed it (i.e.
George Spelvin), which might be undesirable for unit tests, but we
assume it is enough for a first patch.

This is our first patch series so we hope our contributions are
interesting and also hope to get some useful criticism from the
community. :)

Changes since V1:
- Fixed compilation on parisc and m68k.
- Fixed whitespace mistakes.
- Renamed a few functions.
- Refactored globals into struct for test function params, thus removing
  a patch. 
- Reworded some commit messages.

[1] - https://lkcamp.dev/
[2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/

Isabella Basso (5):
  hash.h: remove unused define directive
  test_hash.c: split test_int_hash into arch-specific functions
  test_hash.c: split test_hash_init
  lib/Kconfig.debug: properly split hash test kernel entries
  test_hash.c: refactor into kunit

 include/linux/hash.h       |   5 +-
 lib/Kconfig.debug          |  28 ++++-
 lib/Makefile               |   3 +-
 lib/test_hash.c            | 247 +++++++++++++++++--------------------
 tools/include/linux/hash.h |   5 +-
 5 files changed, 139 insertions(+), 149 deletions(-)

-- 
2.33.0

