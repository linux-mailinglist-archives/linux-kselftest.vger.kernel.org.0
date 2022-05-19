Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32BA52CF4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiESJYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiESJYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 05:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AB95A7744
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652952251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hrzM/tU7AW7fzp6ZTPFIPv0ZgmNmcU4f6OeaVEaoW64=;
        b=fxD5QHfHy3QlddNqbHnocCoBKr4sOA3rdE/zzfZ37gdImROipfVnk8tyYvc4OejAmYQ/Ow
        EXbhnZAOiEa6xIEYdbIEdOUdo/43Rw3iIdW7XVx7WWBVS1Mnuq/Vb/nag4lJ3//R2Wg/rD
        c94pmDLjMvjEMoGO9QgTZPEuRVfZlBI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-fBYaQBwbPsmVC7EuJlBDnw-1; Thu, 19 May 2022 05:24:10 -0400
X-MC-Unique: fBYaQBwbPsmVC7EuJlBDnw-1
Received: by mail-wr1-f72.google.com with SMTP id u17-20020a056000161100b0020cda98f292so1338219wrb.21
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 02:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrzM/tU7AW7fzp6ZTPFIPv0ZgmNmcU4f6OeaVEaoW64=;
        b=RgR3+3qdSWMY24B7bXnV6ilW1DwToqUM6+5bXVcTW76KuVVV7sm8ajWvQh2MERHJ2G
         j2XTha3kveRfIvs263qz59/pqTV89C+nDgCCr/+9XzqethVNTstAsPqyWb8n4Shi4ZiN
         9RldH6C1fWqAZsXwgkSMyVyHxXtXxeYsHSqRFjLluiowMTxnd9iBgKDtCSEhEfZ0+v0A
         RQ1ukjFBjvUTFWdJ0nGgEvKNqkwO8atQ0AIMHc74snRAlRCx0MSQOcbkHq0UwLExoVTM
         BjeeMw5cVWEPHlU4JRXl5Ui33GgI8Sy+DBSoD7Ul0Rz/ORobc/qn2Bb0CnPGGFNG7Vw0
         ZpPA==
X-Gm-Message-State: AOAM533pj+5XIFy+Zr0ut5tG1f/3yfcJQBLDWL/mD30Lv0kt8TyWGsiz
        LVwvpwr6odIcjbnXP0+INxSVfyiNKzR8bGYnn5F3kw/GpTURNlN3TYTM5K6MUW0V3Cr4LtdjOee
        79fR4wHFQa6w4CjIW8dofiezZ9x5U
X-Received: by 2002:adf:d1cd:0:b0:20c:51c6:5d9f with SMTP id b13-20020adfd1cd000000b0020c51c65d9fmr3228286wrd.244.1652952249454;
        Thu, 19 May 2022 02:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaHoONv38R2sfYbYYfdj55s184jaaTcZJjO0wlpMG3de/EGqr/Ap2E0apr1jSAW1ryJpW1qA==
X-Received: by 2002:adf:d1cd:0:b0:20c:51c6:5d9f with SMTP id b13-20020adfd1cd000000b0020c51c65d9fmr3228259wrd.244.1652952249207;
        Thu, 19 May 2022 02:24:09 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b0020c5253d8fasm4104647wrx.70.2022.05.19.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:24:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/3] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Thu, 19 May 2022 11:23:40 +0200
Message-Id: <20220519092343.2776414-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This series add support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support in patch #2 and finally patch #3 adds some kselftests to test it.

This is my first contribution to the fs/* subsystem, so I'm marking this
set as RFC, in case I got anything wrong with the patches. But they work
correctly on my local testing.

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649


Javier Martinez Canillas (3):
  fat: add a vfat_rename2() and make existing .rename callback a helper
  fat: add renameat2 RENAME_EXCHANGE flag support
  selftests/filesystems: add a vfat RENAME_EXCHANGE test

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 172 +++++++++++++++++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 ++++
 .../filesystems/fat/run_fat_tests.sh          |  80 ++++++++
 7 files changed, 293 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.35.1

