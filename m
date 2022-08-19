Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D17599497
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiHSFcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242718AbiHSFcr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:32:47 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E8AE0FD3;
        Thu, 18 Aug 2022 22:32:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id c3so3520317vsc.6;
        Thu, 18 Aug 2022 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qE8ldeDZbeBWiOSJi6Wf+0FR4IgNtJD4qyOpRvCfdkg=;
        b=HCDK0H1lXMe3YoJcBeBzlJPJYKLaQvvu2G/Z3OnMnp3czsEleHqwoT0eteLKL3BYeG
         8b/NmqfoIi7X3FrKWWCZ2SWBlD+W1lv3TnNQyTXcHsTwmxKHpkn/kk0+ssLux5vAKBvl
         /0Q14Ob3/Nr9w7AVfOtF7x0SCujI6qmLoTrfZ7QC2VxPVVbF4cw1kFH+Dx+aepfYd9dd
         bDegxIcLxwNdnsA+oQyw9OrOH9BRtJQivhbBTZEjkULREy1Pj9vutsBKKV2pd63bKpew
         A59BSUh2WHbiRD4U9F2zb02zQqu1XoawHiyV1aXxxBhU8oFN7UxV6WPdufwwHb0zWdF+
         HoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qE8ldeDZbeBWiOSJi6Wf+0FR4IgNtJD4qyOpRvCfdkg=;
        b=HbLSmZnx9gKq/SI6XWnXt5B1meFIqrNN/7RR3DHNwrIuJlnAoLd83W7KvZD2CsCZEb
         qQCO240pW0NjQm4aZQVxDdnSmXVLvk0N/4QNaBnH23GHcPFvYISlV9XSY1VEddp6Pzxd
         YL5HDYOkJjF5rJFhwAlh7O7P2ERAE0x1v1Fwt1G4pTCPcNMNtwf2OWvJFUt2EL91zOAI
         gkHB8cWZFw3D7awjMEEZiMlVC43R69Sy6Y7aa2o5PwwSwxva1DzXt0G0j6xKpfjoH+Mx
         lFUCU8vZBt65uwlTw9ft/GlEbtwnJSUh/1dTYrYUSJMS+Uelvnsf7H+KUzF4Npj7PCMZ
         N6hA==
X-Gm-Message-State: ACgBeo2ThsVYboInFGtokZvATB3Djz5NVzKATRwUrthsrdrDqt47dnMu
        addW4zr91zM4gG28nr75aFELtearbyrtuw==
X-Google-Smtp-Source: AA6agR5ltweq6MJ4EaOS7LN4erI6vtvfaT8vDhsRXGwx+VLUATz1QT6iWbto2lIqBRpaJGqHfrbrlA==
X-Received: by 2002:a67:e245:0:b0:388:59c7:f65a with SMTP id w5-20020a67e245000000b0038859c7f65amr2483871vse.23.1660887165578;
        Thu, 18 Aug 2022 22:32:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:32:44 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 0/8] Documentation: Kunit: clean kunit-tool.rst and start.rst
Date:   Fri, 19 Aug 2022 02:32:26 -0300
Message-Id: <20220819053234.241501-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Hi,

Continuing the documentation refactoring started by Harinder Singh[1],
removes kunit-tool.rst, which had its information rearranged into run_wrapper,
and employs further work in the index and the getting-started guide.

This series was written on top of another[2] that haven't got applied yet,
but the only dependency it has is the "kunit-on-qemu" anchor used in start.rst.

The patches working with the start.rst might be squashable, feel free to suggest so, if
you concur. Still about this file, I realize the note about "mrproper" was removed in
the recent refactoring, but having worked in the last months with people new to kunit,
it showed itself as a common occurrence, so I'm suggesting here to restore it.

Regarding the last two patches, I wasn't sure about either renaming run_wrapper to
kunit-tool to keep old references working or do as I did, updating the references I
could find.

Thanks in advance for your feedbacks,
Tales

[1] https://lore.kernel.org/r/20211217044911.798817-1-sharinder@google.com/
[2] https://lore.kernel.org/r/20220813042055.136832-1-tales.aparecida@gmail.com/

Tales Aparecida (8):
  Documentation: KUnit: remove duplicated docs for kunit_tool
  Documentation: KUnit: avoid repeating "kunit.py run" in start.rst
  Documentation: KUnit: restore note about mrproper in start.rst
  Documentation: KUnit: Reword start guide for selecting tests
  Documentation: KUnit: add intro to the getting-started page
  Documentation: KUnit: update links in the index page
  lib: overflow: update reference to kunit-tool
  lib: stackinit: update reference to kunit-tool

 Documentation/dev-tools/kunit/index.rst       |  16 +-
 Documentation/dev-tools/kunit/kunit-tool.rst  | 232 ------------------
 Documentation/dev-tools/kunit/run_wrapper.rst |   4 +-
 Documentation/dev-tools/kunit/start.rst       | 137 +++++++----
 lib/overflow_kunit.c                          |   2 +-
 lib/stackinit_kunit.c                         |   2 +-
 6 files changed, 103 insertions(+), 290 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
prerequisite-patch-id: b794218cd939a6644aaf5fb2a73997c56a624c80
prerequisite-patch-id: ccd24491ae99152ebdc6dcb8ddb9499d3456a4a0
prerequisite-patch-id: cc17b80d42fd5f5049e144da5c04e922036a33eb
prerequisite-patch-id: ba7edd270c6f285352e0e17bfe65ff6119192113
-- 
2.37.1

