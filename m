Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB153F7FD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhHZB1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbhHZB1Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B19C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a66so1677011qkc.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/+ETMCvbJBF2kohpmxCA7DIb230kdyeY9CvSskcveo=;
        b=mbn7Dr7SqTOJyHCl9NpWmF0kI50k169O48pv6Geya+tbhVRMiYCH9raqLHgs6QSH9S
         J4IDzNl7Gtv9/zeqAKQnxnQGF37aRzb11SmCvbYwtSpjr7msz5WTNlcOKXPPuBwBNCT1
         nFcqh4H6nCikUS24WoXPRgCzdytJCd8Nif84wZqVS/DV4XdQXbUEkC6tHz0GjYHc2bXX
         cVbOdkKCeFIa77oGCUjycyUW05wCS6kh6AusgmzXlzao4f3pdUNREaXkold+7/KtodG0
         MywtMtsYM03J7ujcHzwUa96Cd6M4HKpcgmAY+qovBNLqqN6BGkkGo2PGQqXgThO1MhXr
         vI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/+ETMCvbJBF2kohpmxCA7DIb230kdyeY9CvSskcveo=;
        b=AlEC5Z4iPBZgj3d0oG4IwFACGMwhOuZPgiykGfbQbFJwcprazHLOy86SeYFZn+hj/u
         sosonXq+QSwOJ32wNUSjoVqMLmVw4qwo4rEfrTGqrs3Py9ZWHw2cNEaQJv1SY84ViTZr
         JnJApRAKB1TeQhzhrOOuAGWN08o4/kHVLxky/38WmIvsm2Y+WH6p7X5TvV/UGNuoJQRi
         y0CuvKmx4gGRXU5YIztagshbcO0j4IGUW5FL2FOox7rXnLew6YPPRcizH9mg5cPtuEqH
         yFwHyedJaxSlhFwY9Nhh+i3OG+sE5x6yKNMXriBZnvAQLXFRp9vAGL6jEGqtNjOZ6x1T
         +3Mw==
X-Gm-Message-State: AOAM532QMewS4qZyDGDk5Rt7/JU7eC+nJe9scbrHWjE5lOEo8C8CZULo
        jG7fd9UiHs4rNlsFFjDdCHRX8A==
X-Google-Smtp-Source: ABdhPJwgbMXFrtYSoJx40VoexI1KhC6zlWHw/VAig+AVeHK4gPd/as5aWW+Btdr75zXE55BfStq1Iw==
X-Received: by 2002:a37:bf47:: with SMTP id p68mr1519662qkf.202.1629941195453;
        Wed, 25 Aug 2021 18:26:35 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:34 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 0/6] test_hash.c: refactor into KUnit
Date:   Wed, 25 Aug 2021 22:26:20 -0300
Message-Id: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
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

- In patch 1/6 we noticed that there was an unused define directive that
  could be removed.
- In patch 5/6 we noticed how stringhash and hash tests are all under
  the lib/test_hash.c file, which might cause some confusion, and we
  also broke those kernel config entries up.

Overall KUnit developments have been made in the other patches in this
series:

In patches 2/6 through 4/6 and 6/6 we refactored the lib/test_hash.c
file so as to make it more compatible with the KUnit style, whilst
preserving the original idea of the maintainer who designed it (i.e.
George Spelvin), which might be undesirable for unit tests, but we
assume it is enough for a first patch.

This is our first patch series so we hope our contributions are
interesting and also hope to get some useful criticism from the
community :)

[1] - https://lkcamp.dev/
[2] - https://lore.kernel.org/linux-kselftest/CAGS_qxojszgM19u=3HLwFgKX5bm5KhywvsSunuBAt5RtR+GyxQ@mail.gmail.com/

Isabella Basso (6):
  hash.h: remove unused define directive
  test_hash.c: move common definitions to top of file
  test_hash.c: split test_int_hash into arch-specific functions
  test_hash.c: split test_hash_init
  lib/Kconfig.debug: properly split hash test kernel entries
  test_hash.c: refactor into kunit

 include/linux/hash.h       |   5 +-
 lib/Kconfig.debug          |  28 ++++-
 lib/Makefile               |   3 +-
 lib/test_hash.c            | 249 ++++++++++++++++---------------------
 tools/include/linux/hash.h |   5 +-
 5 files changed, 136 insertions(+), 154 deletions(-)

--
2.33.0

