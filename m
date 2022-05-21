Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BBE52FA0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 10:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiEUIip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiEUIio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 04:38:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A442F68A7;
        Sat, 21 May 2022 01:38:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a9so7549761pgv.12;
        Sat, 21 May 2022 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7O2wpjvMqOXuMsh9+F2dVH/sd749gqvPGzcCSx+acTw=;
        b=CnCpoORJPVZDjtyyxQU6pU/NzkEOOlD2tJTgntpP/8YC18/JDoGs2LSeqF+c8QJRfY
         cownNxh6wKOKUhqJuSI2CEKZfNamPqZXaaKv90WBIf0C4TkVjXmiqYgokXwcLQaTPFsn
         E4JKildIUBnHKdngQZkABs7vblFr8683b+/p4RLvOGOYTw3j7DxrZBFgPnF/4NeboFA9
         OUTNhsvVf1mnxSQdw+DClfig68Ttyrbma4Box4SlbKbACf6JhFVR49iHIXrJqxpNu+3W
         jb1slDQtndJMAdP0vQqhk06vBTyC7Y96Nz9GigG4d7HqHKQ+w6yjypv0buuN9YiUElEd
         U/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7O2wpjvMqOXuMsh9+F2dVH/sd749gqvPGzcCSx+acTw=;
        b=RD20+lnK+inqE4mjO1AwWVgt5nFZlRTV5+qcIRC8zVWsojJicagmlquyqCEVUzvZxV
         btNAQm6SyR5tqmoftCeUtgredJVfCtyhSTfu1PeE1iWHYDU1urblknJcn+FrRUIXKKnK
         6wKNsIm61BbDobcXMESb3sMF4Q4UV9yuwGZy6oT97WSb3wQyLN6BCDmG+5gkbXQ66V4A
         4UiVp+hb7Cf0Jj9dS/Cgo4uUxDlPom3up9qineqj2tRcZKX9Q/1g7WfwvxEo5w4bojV+
         +OUM3FOSNPJJ4CV4Y7ywpQ6DUs44Vjk8mN+WyRLuT6eREybrnatabfWav77hJNN3hA3e
         b6Tw==
X-Gm-Message-State: AOAM530AkgCcxs4H87u34l3DGIPIPEMmibH2zksy2L7Eh1dzTdVKtVuJ
        VaXEFj5f1AMYYLrbyhJVvYK7monEPVCJzQ==
X-Google-Smtp-Source: ABdhPJw1AS8FNHP+Ven4B62vYCvORTQIStwUvYvdkH+WM54eFG1as98kP6ktjOZLQtFv//UJmo7QfQ==
X-Received: by 2002:a05:6a00:23ce:b0:518:4115:170c with SMTP id g14-20020a056a0023ce00b005184115170cmr12014444pfc.76.1653122323663;
        Sat, 21 May 2022 01:38:43 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a684700b001deb3cbd8f1sm3125776pjm.27.2022.05.21.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 01:38:43 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick.wang.shcn@gmail.com
Subject: [PATCH 0/3] selftests: vm: a few fixup patches
Date:   Sat, 21 May 2022 16:38:22 +0800
Message-Id: <20220521083825.319654-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series contains three fixup patches for vm selftests. They
are independent. Please see the patches.

Patrick Wang (3):
  selftests: vm: check numa_available() before operating
    "merge_across_nodes" in ksm_tests
  selftests: vm: add "test_hmm.sh" to TEST_FILES
  selftests: vm: add the "settings" file with timeout variable

 tools/testing/selftests/vm/Makefile    | 1 +
 tools/testing/selftests/vm/ksm_tests.c | 9 ++++++---
 tools/testing/selftests/vm/settings    | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/vm/settings

-- 
2.25.1

