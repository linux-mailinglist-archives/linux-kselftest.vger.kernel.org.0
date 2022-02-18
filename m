Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3B4BB3B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 08:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiBRH6c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 02:58:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiBRH6a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 02:58:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7DB1928F5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6d36ec646so2362267b3.23
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 23:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=URNN4JDAS2rJK/SsmuwfW0pd7j7Yza7iayBlpkhGFLc=;
        b=EBGQU4gek4jI2VHo57UusHs/wBde2oMRrnCtCmvYuBRGiig/b+r8mypTt+pMzb70F+
         eui57kZL0D/54jmqGjPrmsWd0gCCmIddw38zfF9pbmDCKJlhAdFSEiYaxzW6GmFO49Yu
         4RQaHEq87uRGZVdETZV+edy95vXUKC33J17G8BU6e3WahR+nFckwqtWorOj6MMQ/YOvZ
         gl2yOMRPf+OuLe+iUFLdgXX42Wt9q4ukxNsPwtPrcQkgE8bBuiANjsLn54dhHyW0HIeI
         DXlmWM+XgNzhDKEWkVKRqXrhzm++Sv6+QkC4DoMdzkdUGfb51BKxH9jR5kdWZcjQ0pa2
         EbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=URNN4JDAS2rJK/SsmuwfW0pd7j7Yza7iayBlpkhGFLc=;
        b=2554CPV0ZUg9TIv14Cdyf/06II20no9yo97RZfBh1g0RpJXUCV9k9UpfEhuRzw1QAO
         Hy0ZeZvmKmGFgtYJMokCG+tjjSHaloMEreLIal6wOUAnqqeOZ8c6lncVQus33MdR0IQh
         lI9APeXPs+JIU6jedrVvZN5Zy/nSC92iWvPEGd0VVsLGvdQoxeyoTzbiNrLmoYp66Pbt
         L9GbanaT9lSGhg8SnIsKmYyZTINDhAIfz2oIctx3gg45EzmVCBL7xr2Vz5cwAKj/eVpd
         nAPkrMgol0P5lMi9C8bIqL//IXBGQS+Vw1/HR+ry6ar45MDsV9bdbzN3uLxwlmPXgusI
         mx5w==
X-Gm-Message-State: AOAM532bjMBh+eJ3nTDoLGA5nH5aFeRWfieleTVNpslFAAsSccyJWJ2s
        cdVgLH5KKt8ENRYyESCwBvGACi0oJfK1UQ==
X-Google-Smtp-Source: ABdhPJzkXNI0mIB4QIL1eB63wzi9+92ViwlJdKnUh9PGSnuYSdteX3Ps478m374ivFv5Kh1qd98wF5JtWHxwTw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:f611:0:b0:2cf:aa3c:ab17 with SMTP id
 w17-20020a81f611000000b002cfaa3cab17mr658303ywm.410.1645171091604; Thu, 17
 Feb 2022 23:58:11 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:57:27 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-5-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a number of Kconfig options which break compilation under UML wit=
h
allyesconfig.  As kunit_tool's --alltests option is based on allyesconfig a=
nd
UML, we need to update the list of broken options to make --alltests build
again.

Note that, while this does build again, it still segfaults on startup,
so more work remains to be done.

They are:
- CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
- CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache
- CONFIG_BNXT: Failing under UML with -Werror
ERROR:root:../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function =
=E2=80=98bnxt_ptp_enable=E2=80=99:
../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:400:43: error: array subsc=
ript 255 is above array bounds of =E2=80=98struct pps_pin[4]=E2=80=99 [-Wer=
ror=3Darray-bounds]
  400 |                         ptp->pps_info.pins[pin_id].event =3D BNXT_P=
PS_EVENT_EXTERNAL;
      |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~
- CONFIG_PATA_CS5535: Needs MSR access (__tracepoint_{read,write}_msr)
- CONFIG_VDPA: Enables CONFIG_DMA_OPS, which is unimplemented. ('dma_ops' i=
s not defined)

These are all issues which should be investigated properly and the
corresponding options either fixed or disabled under UML. Having this
list of broken options should act as a good to-do list here, and will
allow these issues to be worked on independently, and other tests to
work in the meantime.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/configs/broken_on_uml.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testi=
ng/kunit/configs/broken_on_uml.config
index 690870043ac0..546482b0bc4d 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -42,3 +42,8 @@
 # CONFIG_ADI_AXI_ADC is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_PAGE_POISONING is not set
+# CONFIG_VFIO_PCI is not set
+# CONFIG_INFINIBAND_RDMAVT is not set
+# CONFIG_BNXT is not set
+# CONFIG_PATA_CS5535 is not set
+# CONFIG_VDPA is not set
--=20
2.35.1.265.g69c8d7142f-goog

