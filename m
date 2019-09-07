Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB78AC953
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406391AbfIGVBq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Sep 2019 17:01:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406293AbfIGVBq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Sep 2019 17:01:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so9896386wrt.13;
        Sat, 07 Sep 2019 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o8x3eRUjtNotyN3qNdYHAjBoBUngXxsekVKAd0J9yLE=;
        b=p3Qk4L6fEecGBNrb7lt5UX2TQkmot6B14LY6IhIa3ktPrJww9tDanzxf1ZzcqyKsZH
         IGNI+VpVbybrsbrjzg2nn13qQtu985QhhZy9cp5LhXLkPgz2M9aAhNdZOZEhjKhR2cLj
         S0piHrcV7LySLClgz2ckvePHz+UM1lO8/fbH6rl0GWdntsQrgqNJeSPEtQmchcSfbQL3
         zmjJKoa2YlbymgqqKQyXmGADStZ7IZZEHg6kNOUAwMyZOtkzjTulaGsXSaFuShy/4nKy
         MQN8f/WfZ+koRjU2ak1RntAvNzwTjw0YmXVtMa3s5g0ebldh3hyI/1REArRWLrjIeYwC
         IOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o8x3eRUjtNotyN3qNdYHAjBoBUngXxsekVKAd0J9yLE=;
        b=fbC1dmRW+Tp5wd0FlJY1NGWKnx9W76HY2KzbXu4AlqNed8WuJeVNOAdWBKCGaRm2IU
         RbOeZ0O/9QHWZgYwnF1Ju8FPpyVirf7bLNpiBnJOyUOIRy52aDRdSm8OZjEI+1yuWmhb
         VVyKEDIS5NeHDP93adr+pZWec6caFnKBbrLmnkELga63PLlqDxLigB3CcjotNHaMUAcZ
         ddQpp/mZesIDQ6FvPw59Rr0XvJyBtWi/p7sI+GkNZtTXso6SpWeTfp70vLhTTcsegn4n
         1UZCtFA3rKxxg90Mot/zCUzbfRrENcSf0QnSqPZ0lgVa4UacFmVAxu20/48kvjdNK7s8
         vdoQ==
X-Gm-Message-State: APjAAAVlmkkjwFmEakoBq/wmCbCIg7bl2xCrz7c/cSZS9d8SAYYx+M5u
        m3wUrEax1aqS6Q5lH/Dbe54=
X-Google-Smtp-Source: APXvYqxh/dVwpaq1pBGw4MZlIZx4+jxZZQhKhelsKN7+7qPQi74B01Ebn287A7lQQEVTMuT2w0oYTQ==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr12491638wrx.220.1567890103734;
        Sat, 07 Sep 2019 14:01:43 -0700 (PDT)
Received: from localhost.localdomain (bl9-156-38.dsl.telepac.pt. [85.242.156.38])
        by smtp.gmail.com with ESMTPSA id b3sm7381144wrw.4.2019.09.07.14.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Sep 2019 14:01:42 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah@kernel.org, brendanhiggins@google.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] Documentation: kunit: Fix verification command
Date:   Sun,  8 Sep 2019 06:01:31 +0900
Message-Id: <1567890091-9712-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit wrapper script ('kunit.py') receives a sub-command (only 'run' for
now) as its argument.  If no sub-command is given, it prints help
message and just quit.  However, an example command in the kunit
documentation for a verification of kunit is missing the sub-command.
This commit fixes the example.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 6dc229e..aeeddfa 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -43,7 +43,7 @@ wrapper from your kernel repo:
 
 .. code-block:: bash
 
-	./tools/testing/kunit/kunit.py
+	./tools/testing/kunit/kunit.py run
 
 .. note::
    You may want to run ``make mrproper`` first.
-- 
2.7.4

