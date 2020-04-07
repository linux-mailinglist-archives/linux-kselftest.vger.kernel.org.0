Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342651A1052
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgDGPhs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 11:37:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729183AbgDGPhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 11:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586273867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x4CHFC9TOF2vCml2TedFLaM/BhVt2666Y7Zsy2uCISM=;
        b=FQx1i8RRfCIziTw3kriTdn57bn6KMPCA4weasC+0+hPNajiSxcrgLZvNF29iCiMH2+EdlZ
        X51ImUmL5y6pgFSJzh4JYXBkXd6uFPAypbey9Ml1g4wjtA9f7fWhJgiS0PKnEQdl0hqHnV
        LsoHz5yT7lrR0R/YXIvDt9X8fIbFYnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-oDhq-eh8PCCpgKiXXtRKIQ-1; Tue, 07 Apr 2020 11:37:40 -0400
X-MC-Unique: oDhq-eh8PCCpgKiXXtRKIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489448017CE;
        Tue,  7 Apr 2020 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA6A5272A6;
        Tue,  7 Apr 2020 15:37:32 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/2] selftests: kvm: Introduce the mem_slot_test test
Date:   Tue,  7 Apr 2020 12:37:29 -0300
Message-Id: <20200407153731.3236-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series introduces a new KVM selftest (mem_slot_test) that goal
is to verify memory slots can be added up to the maximum allowed. An
extra slot is attempted which should occur on error.

The patch 01 is needed so that the VM fd can be accessed from the
test code (for the ioctl call attempting to add an extra slot).

I ran the test successfully on x86_64, aarch64, and s390x.  This
is why it is enabled to build on those arches.

- Changelog -

v2 -> v3:
 - Keep alphabetical order of .gitignore and Makefile [drjones]
 - Use memory region flags equals to zero [drjones]
 - Changed mmap() assert from 'mem != NULL' to 'mem != MAP_FAILED' [drjones]
 - kvm_region is declared along side other variables and malloc()'ed
   later [drjones]
 - Combined two asserts into a single 'ret == -1 && errno == EINVAL'
   [drjones]

v1 -> v2:
 - Rebased to queue
 - vm_get_fd() returns int instead of unsigned int (patch 01) [drjones]
 - Removed MEM_REG_FLAGS and GUEST_VM_MODE defines [drjones]
 - Replaced DEBUG() with pr_info() [drjones]
 - Calculate number of guest pages with vm_calc_num_guest_pages()
   [drjones]
 - Using memory region of 1 MB sized (matches mininum needed
   for s390x)
 - Removed the increment of guest_addr after the loop [drjones]
 - Added assert for the errno when adding a slot beyond-the-limit [drjones]
 - Prefer KVM_MEM_READONLY flag but on s390x it switch to KVM_MEM_LOG_DIRTY_PAGES,
   so ensure the coverage of both flags. Also somewhat tests the KVM_CAP_READONLY_MEM capability check [drjones]
 - Moved the test logic to test_add_max_slots(), this allows to more easily add new cases in the "suite".

v1: https://lore.kernel.org/kvm/20200330204310.21736-1-wainersm@redhat.com

Wainer dos Santos Moschetta (2):
  selftests: kvm: Add vm_get_fd() in kvm_util
  selftests: kvm: Add mem_slot_test test

 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  5 ++
 tools/testing/selftests/kvm/mem_slot_test.c   | 85 +++++++++++++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c

-- 
2.17.2

