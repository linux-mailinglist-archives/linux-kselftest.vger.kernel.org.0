Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E443F2C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhJ1Wee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 18:34:34 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55048 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhJ1Wec (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 18:34:32 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4HgKrj1ZWYzDrCk;
        Thu, 28 Oct 2021 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1635459941; bh=OX8mv7lrHWqRsF4lPKOR3ZoVpI/a6ZJqTO+IckJeZIU=;
        h=From:To:Cc:Subject:Date:From;
        b=JDtJK/6ETT1QisNvsJAuAhSu/8Hcty/jEx/eX1A47PdxUfuZnK4MuCae6O+XIlqvZ
         reOEsQZuEyzJ5qpnePjWIzBfrDgsqPKaw2K5XoRRr03xC3UN/P2SfC3gLkjXTfbwyf
         G3u/f7eb5RW7QfOvAEy0WW7p9dBfHVDACBnOi0F8=
X-Riseup-User-ID: 0547AF66CF2CAD13BBDD0B7881883D4BA43C2393E3AF23156733269F90C2FC29
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4HgKrd1W9lz5vvd;
        Thu, 28 Oct 2021 15:25:36 -0700 (PDT)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH v3 0/5] test_hash.c: refactor into KUnit
Date:   Thu, 28 Oct 2021 19:25:28 -0300
Message-Id: <20211028222533.432641-1-isabbasso@riseup.net>
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

Changes since v2:
- Added comments on struct elements.
- Removed unecessary __init bits from KUnit test functions.
- Change KUnit's "EXPECT_FALSE"s for "EXPECT_EQ"s.
Changes since v1:
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
 lib/Kconfig.debug          |  28 +++-
 lib/Makefile               |   3 +-
 lib/test_hash.c            | 259 +++++++++++++++++--------------------
 tools/include/linux/hash.h |   5 +-
 5 files changed, 147 insertions(+), 153 deletions(-)

--
2.33.1

