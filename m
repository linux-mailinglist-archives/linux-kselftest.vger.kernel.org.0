Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3204618357
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKCP7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiKCP7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 11:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FB13E29
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667491095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q2b5W/w/tXDV6Z2W1azf8qIv49f0j543FW6H53v6JOY=;
        b=KdwSj5lWlGtV62FcLz+2d/3Mq3wr+olKM9qsavr1BxH7dbXjx2VZ6EXvmb5rOv5/xppeV5
        afpzYCgBtMpgFMuZ+WSDyk69aE1ENSZzzoSjyWDXmqiRCqs26rOGLM6aXZ2xREwYedNCr+
        UVGaGp828LzdSTIU2C2URkDP1YdqZsc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-Y7vjV2S3ORCVQS0f2d6gdQ-1; Thu, 03 Nov 2022 11:58:13 -0400
X-MC-Unique: Y7vjV2S3ORCVQS0f2d6gdQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FF633816EAD;
        Thu,  3 Nov 2022 15:58:13 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F9DB492CA5;
        Thu,  3 Nov 2022 15:58:11 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v12 00/15] Introduce eBPF support for HID devices
Date:   Thu,  3 Nov 2022 16:57:41 +0100
Message-Id: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

and here comes the v12 of the HID-BPF series.

Again, for a full explanation of HID-BPF, please refer to the last patch
in this series (15/15).

This revision contains most notably few fixes from the various kernel CI
bots. I also took Alexei's review into account, and we do not pollute
tools/include with useless hid headers.

I also removed most of the last checkpatch complains about adding
external kfunc declarations in C files. And this led me to also show in
samples/ how we can link together 2 BPF object files. Impressive how
easy it is :)

Cheers,
Benjamin

Benjamin Tissoires (15):
  HID: fix I2C_HID not selected when I2C_HID_OF_ELAN is
  HID: Kconfig: split HID support and hid-core compilation
  HID: initial BPF implementation
  selftests: add tests for the HID-bpf initial implementation
  HID: bpf jmp table: simplify the logic of cleaning up programs
  HID: bpf: allocate data memory for device_event BPF programs
  selftests/hid: add test to change the report size
  HID: bpf: introduce hid_hw_request()
  selftests/hid: add tests for bpf_hid_hw_request
  HID: bpf: allow to change the report descriptor
  selftests/hid: add report descriptor fixup tests
  selftests/hid: Add a test for BPF_F_INSERT_HEAD
  samples/hid: add new hid BPF example
  samples/hid: add Surface Dial example
  Documentation: add HID-BPF docs

 Documentation/hid/hid-bpf.rst                 | 512 +++++++++++
 Documentation/hid/index.rst                   |   1 +
 MAINTAINERS                                   |   3 +
 drivers/Makefile                              |   2 +-
 drivers/hid/Kconfig                           |  18 +-
 drivers/hid/Makefile                          |   2 +
 drivers/hid/amd-sfh-hid/Kconfig               |   2 +-
 drivers/hid/bpf/Kconfig                       |  17 +
 drivers/hid/bpf/Makefile                      |  11 +
 drivers/hid/bpf/entrypoints/Makefile          |  93 ++
 drivers/hid/bpf/entrypoints/README            |   4 +
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c |  34 +
 .../hid/bpf/entrypoints/entrypoints.lskel.h   | 330 +++++++
 drivers/hid/bpf/hid_bpf_dispatch.c            | 531 +++++++++++
 drivers/hid/bpf/hid_bpf_dispatch.h            |  28 +
 drivers/hid/bpf/hid_bpf_jmp_table.c           | 565 ++++++++++++
 drivers/hid/hid-core.c                        |  34 +-
 drivers/hid/i2c-hid/Kconfig                   |   4 +-
 include/linux/hid.h                           |   5 +
 include/linux/hid_bpf.h                       | 163 ++++
 samples/hid/.gitignore                        |   8 +
 samples/hid/Makefile                          | 250 ++++++
 samples/hid/Makefile.target                   |  75 ++
 samples/hid/hid_bpf_attach.bpf.c              |  18 +
 samples/hid/hid_bpf_attach.h                  |  14 +
 samples/hid/hid_bpf_helpers.h                 |  21 +
 samples/hid/hid_mouse.bpf.c                   | 112 +++
 samples/hid/hid_mouse.c                       | 155 ++++
 samples/hid/hid_surface_dial.bpf.c            | 134 +++
 samples/hid/hid_surface_dial.c                | 226 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/hid/.gitignore        |   4 +
 tools/testing/selftests/hid/Makefile          | 233 +++++
 tools/testing/selftests/hid/config            |  20 +
 tools/testing/selftests/hid/hid_bpf.c         | 845 ++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c       | 196 ++++
 .../selftests/hid/progs/hid_bpf_helpers.h     |  21 +
 37 files changed, 4682 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/hid/hid-bpf.rst
 create mode 100644 drivers/hid/bpf/Kconfig
 create mode 100644 drivers/hid/bpf/Makefile
 create mode 100644 drivers/hid/bpf/entrypoints/Makefile
 create mode 100644 drivers/hid/bpf/entrypoints/README
 create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.bpf.c
 create mode 100644 drivers/hid/bpf/entrypoints/entrypoints.lskel.h
 create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.c
 create mode 100644 drivers/hid/bpf/hid_bpf_dispatch.h
 create mode 100644 drivers/hid/bpf/hid_bpf_jmp_table.c
 create mode 100644 include/linux/hid_bpf.h
 create mode 100644 samples/hid/.gitignore
 create mode 100644 samples/hid/Makefile
 create mode 100644 samples/hid/Makefile.target
 create mode 100644 samples/hid/hid_bpf_attach.bpf.c
 create mode 100644 samples/hid/hid_bpf_attach.h
 create mode 100644 samples/hid/hid_bpf_helpers.h
 create mode 100644 samples/hid/hid_mouse.bpf.c
 create mode 100644 samples/hid/hid_mouse.c
 create mode 100644 samples/hid/hid_surface_dial.bpf.c
 create mode 100644 samples/hid/hid_surface_dial.c
 create mode 100644 tools/testing/selftests/hid/.gitignore
 create mode 100644 tools/testing/selftests/hid/Makefile
 create mode 100644 tools/testing/selftests/hid/config
 create mode 100644 tools/testing/selftests/hid/hid_bpf.c
 create mode 100644 tools/testing/selftests/hid/progs/hid.c
 create mode 100644 tools/testing/selftests/hid/progs/hid_bpf_helpers.h

-- 
2.36.1

