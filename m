Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2138E1985AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgC3Una (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 16:43:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40402 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbgC3Una (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 16:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585601009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=G8YOlQo1+Lr+V/H5HcsRFkaQvjYFkEv0+2CE1fXiBGg=;
        b=PjXjYNTYL+ExvcdB5Hm40582D8Y7f/3mnEvbPUPeRhFoz1CnWUyjwuc7IuIf+ptX+fvOiq
        JrRF9zKDIbZMh2WXJeuQL3w+mjGQzqtpH6NI4PHu55K/LMe5lGaDUfSzR30uspQtFy/kAa
        uCrlaFqqKH8VhP+UGta1lYB/I/xkOnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-RvjVc_NNOZKBvwcuq9Ljgw-1; Mon, 30 Mar 2020 16:43:26 -0400
X-MC-Unique: RvjVc_NNOZKBvwcuq9Ljgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7F7108592C;
        Mon, 30 Mar 2020 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 384F819C58;
        Mon, 30 Mar 2020 20:43:14 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com, drjones@redhat.com
Subject: [PATCH 0/2] selftests: kvm: Introduce the mem_slot_test test
Date:   Mon, 30 Mar 2020 17:43:08 -0300
Message-Id: <20200330204310.21736-1-wainersm@redhat.com>
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

Finally, I hope it is useful test!

Wainer dos Santos Moschetta (2):
  selftests: kvm: Add vm_get_fd() in kvm_util
  selftests: kvm: Add mem_slot_test test

 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  3 +
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  5 +
 tools/testing/selftests/kvm/mem_slot_test.c   | 92 +++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c

-- 
2.17.2

