Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA271A1053
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgDGPht (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 11:37:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729211AbgDGPht (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 11:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586273868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=YBQ+zxeaLD0yw/RzmwmvvS9Gvxa0mxHzlEt+c4z9U6U=;
        b=YQq2rpqqaeCRDML8KNfu+Uyslbmvoo63if7P/k+MCfOh30rMik058AJCDvxhRidF9Me1qj
        WYupyBOL8Nb/F+qXqbERmFYIAkp88efQm9yyYF67blrGxEb0jBLRrj6JMFNFZJ8AIlBSQG
        n1jgutc34NYOpJF82smkMtj5LDrK7vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-oqR3U8ezOiqn97kazvQiqA-1; Tue, 07 Apr 2020 11:37:45 -0400
X-MC-Unique: oqR3U8ezOiqn97kazvQiqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706AE18C43C2;
        Tue,  7 Apr 2020 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E1CE272A6;
        Tue,  7 Apr 2020 15:37:39 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
Date:   Tue,  7 Apr 2020 12:37:30 -0300
Message-Id: <20200407153731.3236-2-wainersm@redhat.com>
In-Reply-To: <20200407153731.3236-1-wainersm@redhat.com>
References: <20200407153731.3236-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduces the vm_get_fd() function in kvm_util which returns
the VM file descriptor.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a99b875f50d2..4e122819ee24 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -254,6 +254,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 unsigned int vm_get_page_size(struct kvm_vm *vm);
 unsigned int vm_get_page_shift(struct kvm_vm *vm);
 unsigned int vm_get_max_gfn(struct kvm_vm *vm);
+int vm_get_fd(struct kvm_vm *vm);
 
 unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
 unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8a3523d4434f..3e36a1eb8771 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1734,6 +1734,11 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
 	return vm->max_gfn;
 }
 
+int vm_get_fd(struct kvm_vm *vm)
+{
+        return vm->fd;
+}
+
 static unsigned int vm_calc_num_pages(unsigned int num_pages,
 				      unsigned int page_shift,
 				      unsigned int new_page_shift,
-- 
2.17.2

