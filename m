Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5C60C835
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJYJfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJYJfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 05:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BD100434
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/q3UGfmiDf1h8tQ4Dd1CX+bmTpe31w2kpXjkzLMiyFY=;
        b=AW3ebgshwi+kK/qNHPAbbbbh5jBBWsSFPgrDiKFMDIceELB91iN/hv/PPMRP1GgfXiFwJs
        npL8U5DIozwo/geZ51X07yUqMjM/SBemdDMXf9BPlACMEt3pkLRNPatYg9P8E8UtL5jeak
        j2KH6IjqIuY3DVekcbHqWrEkXKufnmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-QMRywEh2OGeERquzOUcgWg-1; Tue, 25 Oct 2022 05:35:03 -0400
X-MC-Unique: QMRywEh2OGeERquzOUcgWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48EDA833A0D;
        Tue, 25 Oct 2022 09:35:03 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79C5449BB60;
        Tue, 25 Oct 2022 09:35:01 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v11 00/14] Introduce eBPF support for HID devices
Date:   Tue, 25 Oct 2022 11:34:44 +0200
Message-Id: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

and here comes the v11 of the HID-BPF series.

Again, for a full explanation of HID-BPF, please refer to the last patch
in this series (14/14).

Now that the bpf-core changes are all merged in v6.1, it is
time to have that series entirely relying on HID, so it can get
merged into the HID tree.

Compared to v10, the most notable change is in the selftests and the
samples: they are now namespaced into hid, not bpf.

This means that HID-BPF has no more conflicts with the bpf tree.

One other interesting change is in patch 4/14. I managed to reduce
the scope of the embedded bpf programs, by tricking the refcount.
I am planning on submitting an RFC for embedding those changes in
bpf core (a map that doesn't increment refcount and a cleanup mechanism)
but this can come as a later improvement.
This new kind of maps and mechanisms might also be useful for other
subsystems.

Cheers,
Benjamin

Benjamin Tissoires (14):
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

 Documentation/hid/hid-bpf.rst                 | 513 +++++++++++
 Documentation/hid/index.rst                   |   1 +
 MAINTAINERS                                   |   3 +
 drivers/Makefile                              |   2 +-
 drivers/hid/Kconfig                           |  20 +-
 drivers/hid/Makefile                          |   2 +
 drivers/hid/bpf/Kconfig                       |  17 +
 drivers/hid/bpf/Makefile                      |  11 +
 drivers/hid/bpf/entrypoints/Makefile          |  93 ++
 drivers/hid/bpf/entrypoints/README            |   4 +
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c |  34 +
 .../hid/bpf/entrypoints/entrypoints.lskel.h   | 368 ++++++++
 drivers/hid/bpf/hid_bpf_dispatch.c            | 526 +++++++++++
 drivers/hid/bpf/hid_bpf_dispatch.h            |  28 +
 drivers/hid/bpf/hid_bpf_jmp_table.c           | 572 ++++++++++++
 drivers/hid/hid-core.c                        |  32 +-
 include/linux/hid.h                           |   5 +
 include/linux/hid_bpf.h                       | 148 +++
 include/uapi/linux/hid_bpf.h                  |  25 +
 samples/hid/.gitignore                        |   8 +
 samples/hid/Makefile                          | 246 +++++
 samples/hid/Makefile.target                   |  75 ++
 samples/hid/hid_mouse.bpf.c                   | 134 +++
 samples/hid/hid_mouse.c                       | 160 ++++
 samples/hid/hid_surface_dial.bpf.c            | 161 ++++
 samples/hid/hid_surface_dial.c                | 231 +++++
 tools/include/uapi/linux/hid.h                |  62 ++
 tools/include/uapi/linux/hid_bpf.h            |  25 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/hid/.gitignore        |   4 +
 tools/testing/selftests/hid/Makefile          | 242 +++++
 tools/testing/selftests/hid/config            |  20 +
 tools/testing/selftests/hid/hid_bpf.c         | 846 ++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c       | 206 +++++
 34 files changed, 4815 insertions(+), 10 deletions(-)
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
 create mode 100644 include/uapi/linux/hid_bpf.h
 create mode 100644 samples/hid/.gitignore
 create mode 100644 samples/hid/Makefile
 create mode 100644 samples/hid/Makefile.target
 create mode 100644 samples/hid/hid_mouse.bpf.c
 create mode 100644 samples/hid/hid_mouse.c
 create mode 100644 samples/hid/hid_surface_dial.bpf.c
 create mode 100644 samples/hid/hid_surface_dial.c
 create mode 100644 tools/include/uapi/linux/hid.h
 create mode 100644 tools/include/uapi/linux/hid_bpf.h
 create mode 100644 tools/testing/selftests/hid/.gitignore
 create mode 100644 tools/testing/selftests/hid/Makefile
 create mode 100644 tools/testing/selftests/hid/config
 create mode 100644 tools/testing/selftests/hid/hid_bpf.c
 create mode 100644 tools/testing/selftests/hid/progs/hid.c

-- 
2.36.1

