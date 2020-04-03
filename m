Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00419DCAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391158AbgDCRY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 13:24:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391127AbgDCRYr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 13:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585934686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TeNYEnMMfU3AiH0HRgQNWv1IhmQIdH3VbtTA4I/7zoQ=;
        b=Fki8HQR0STTDXI20u7bY8oCYF/PdS/ozLY2QUReJdm40yfW/9UoLa90cHmWLvww0x0M9h7
        PitlSLEXbfCO4Gg6PayfZ0ygXl04TYMth4G5xZQp/PAJUWbAykpITHgZ8/NS5IuFeQQXSr
        SJic80bN1fd7shHKx5KJLIkfCe0GYrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-AkRCr9DvPSGybudoVX-j4A-1; Fri, 03 Apr 2020 13:24:39 -0400
X-MC-Unique: AkRCr9DvPSGybudoVX-j4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 304B7100550D;
        Fri,  3 Apr 2020 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 135E05C1B0;
        Fri,  3 Apr 2020 17:24:30 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] selftests: kvm: Introduce the mem_slot_test test
Date:   Fri,  3 Apr 2020 14:24:26 -0300
Message-Id: <20200403172428.15574-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

v1: https://lore.kernel.org/kvm/20200330204310.21736-1-wainersm@redhat.com

Changes v1 -> v2:
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

