Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED7317EED4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 03:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgCJCvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 22:51:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31171 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726378AbgCJCvN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 22:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583808671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=R6peiWc+YqZetn/lw3+wRj0vYCDROkZKsrBmpaORfr4=;
        b=I10mjx8DOQjXevohny2+BbnqasunkNN3m3vb3LXsaS9ujbKPj+B6PVmwglCF5hKOF8HGeh
        tVw0SFz41ZQ+zjSpzntxp5LosUAmxBXDp2FyB+Un5PnAy5BYQGK6HSAe583WGyMW5s35DR
        cfn8YwIs2WyLHWkf+/et2DNvBKNE3GU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-DaKKvYlVNG2EElH1V4v2nw-1; Mon, 09 Mar 2020 22:51:08 -0400
X-MC-Unique: DaKKvYlVNG2EElH1V4v2nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FC0800D48;
        Tue, 10 Mar 2020 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-124.gru2.redhat.com [10.97.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E31235C1C3;
        Tue, 10 Mar 2020 02:51:02 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
Subject: [PATCH v2 0/2] kvm: selftests: Introduce TEST_FAIL and convert
Date:   Mon,  9 Mar 2020 23:50:57 -0300
Message-Id: <20200310025059.9301-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce the TEST_FAIL macro and change the tests/utilities
to use it.

v1 -> v2:
- Completed the conversion to TEST_FAIL.

v1:
- [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
  https://lore.kernel.org/kvm/20200305172532.9360-1-wainersm@redhat.com/

Wainer dos Santos Moschetta (2):
  selftests: kvm: Introduce the TEST_FAIL macro
  selftests: kvm: Uses TEST_FAIL in tests/utilities

 tools/testing/selftests/kvm/dirty_log_test.c  |  7 +++----
 .../testing/selftests/kvm/include/test_util.h |  3 +++
 .../selftests/kvm/lib/aarch64/processor.c     | 17 +++++++--------
 .../testing/selftests/kvm/lib/aarch64/ucall.c |  2 +-
 tools/testing/selftests/kvm/lib/io.c          | 12 +++++------
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++-----------
 .../selftests/kvm/lib/x86_64/processor.c      |  5 ++---
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  4 ++--
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  6 +++---
 .../testing/selftests/kvm/x86_64/state_test.c |  6 +++---
 .../selftests/kvm/x86_64/svm_vmcall_test.c    |  6 ++----
 .../kvm/x86_64/vmx_close_while_nested_test.c  |  4 ++--
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  6 +++---
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  4 ++--
 14 files changed, 49 insertions(+), 54 deletions(-)

-- 
2.17.2

