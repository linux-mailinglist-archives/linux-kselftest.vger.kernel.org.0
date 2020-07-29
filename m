Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385D22317C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 04:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgG2Cm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbgG2Cm7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 22:42:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B870C061794;
        Tue, 28 Jul 2020 19:42:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so20860757qkg.9;
        Tue, 28 Jul 2020 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=26B7ruboEZL9ViEc74xT+oYS0yXOvUNjGMHs22DUHpE=;
        b=R6CueL81HUzXERp64SqHhwnEOaz9n1NDGfKHJdHYoKE9Cs7asgo2jl0RXfuj9dWkCI
         XCRhDZjk0RMcN9cDedfAUuJKmZ/JI26xUpzmpFExU5GRa5XUWFkzGDgjQdRLV3CmoxQv
         9dnbd5zDkEaQVtNVG3Q2uIzfY3OBsi4guYMux8YjOYjhVogBSZDM8kemSa5Y06z0GV+C
         MPNhS2oeaiT8SJbtFlQIRH5tSBNqyUTEMN4TsjhxFZxzyIzsG9RFMENfr1YgQqMwrpm0
         55Fg1cKeeBvi4tyRZRqYKNV+0qkR4xuDov92OotiIvIv5yTUfd2Xc2V/iqc2mcmudWbn
         V/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=26B7ruboEZL9ViEc74xT+oYS0yXOvUNjGMHs22DUHpE=;
        b=Y8JdbC0WZlfZJV3I4Qa1hCmUqlOPDYiZGVrnbwUzcKrpuppThXmRp9JhLPxTnfbFJ/
         IWlIxePZw4Xi1C1Dgz8aMAOkB7Uwsbi6RCpCRH6+eCcYWC7AE+n3BbAJhUFlNndAzSmu
         ve6nbrLy7p6urwh8QRZif/sTGnzkCEACNdYBkkBmbeWrshGtKvJ0hZ773l5vVD32X4gE
         PbBKTd0nh9sSf6XWG50XYo2+L+qywDdSZa4XMFtmMf68YciDPf43UTu3lLqbFwwvogQS
         pwjJVSTpWg530jGv5EgDBv1YyGtF/sBLNJR7GRegf14eZheNtfx9+kE29SECr37TV73d
         tIHg==
X-Gm-Message-State: AOAM530xXhqct4Cigd7QlZqjPzWq27kuRf6gLDftxRqjSXyIyKUowREN
        jlhRgBB5SB/FFgBFjTTHqPI=
X-Google-Smtp-Source: ABdhPJw0JGXZeJjRX5ajOzoxy3K2EXwr07Hgv6Yc3xZzaaW8Ls8IOOEwixKY/sDHE9DfFDI18JaOsQ==
X-Received: by 2002:a37:517:: with SMTP id 23mr31542167qkf.63.1595990578321;
        Tue, 28 Jul 2020 19:42:58 -0700 (PDT)
Received: from smtp.gmail.com ([2804:d57:1705:d900:6bd8:2f2e:b0:82e5])
        by smtp.gmail.com with ESMTPSA id z67sm462452qkb.27.2020.07.28.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 19:42:58 -0700 (PDT)
Date:   Tue, 28 Jul 2020 23:42:53 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     brendanhiggins@google.com, felixguoxiuping@gmail.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: tool: adjust parse regex
Message-ID: <3f437939521cea1157b6803acd312e1a04399474.1595990061.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit config subcommand terminates with error if .config has a
configuration assigned with a string, for instance:

CONFIG_CC_VERSION_TEXT="gcc (distro package version) ..."

This patch adjusts the parse regex to consider such string assignments.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 tools/testing/kunit/kunit_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index e75063d603b5..8e55693fe812 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -10,7 +10,7 @@ import collections
 import re
 
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
-CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+)$'
+CONFIG_PATTERN = r'^CONFIG_(\w+)=((\S+)|(".*"))$'
 
 KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
 
-- 
2.27.0

