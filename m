Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 851517C39C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfGaNcX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 09:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfGaNcX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 09:32:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 165B430C1340;
        Wed, 31 Jul 2019 13:32:23 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D78060852;
        Wed, 31 Jul 2019 13:32:21 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v2 0/3] KVM: selftests: Enable ucall and dirty_log_test on s390x
Date:   Wed, 31 Jul 2019 15:32:13 +0200
Message-Id: <20190731133216.5620-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 31 Jul 2019 13:32:23 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implement the ucall() interface on s390x to be able to use the
dirty_log_test KVM selftest on s390x, too.

v2:
 - Split up ucall.c into architecture specific files
 - Removed some #ifdef __s390x__  in the dirty_log patch

Thomas Huth (3):
  KVM: selftests: Split ucall.c into architecture specific files
  KVM: selftests: Implement ucall() for s390x
  KVM: selftests: Enable dirty_log_test on s390x

 tools/testing/selftests/kvm/Makefile          |   9 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  61 ++++++-
 .../testing/selftests/kvm/include/kvm_util.h  |   8 +-
 .../testing/selftests/kvm/lib/aarch64/ucall.c | 112 +++++++++++++
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  56 +++++++
 tools/testing/selftests/kvm/lib/ucall.c       | 157 ------------------
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  56 +++++++
 .../selftests/kvm/s390x/sync_regs_test.c      |   6 +-
 8 files changed, 287 insertions(+), 178 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c
 delete mode 100644 tools/testing/selftests/kvm/lib/ucall.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/ucall.c

-- 
2.21.0

