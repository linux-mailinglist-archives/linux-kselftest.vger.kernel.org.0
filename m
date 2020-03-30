Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F71985B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgC3Unt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 16:43:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31033 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbgC3Unt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 16:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585601028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8WcGc/uVHG7ylmz9BTpf5JgzJOmoF9uEr8u6eJ8H6Dk=;
        b=EK25I1nU+ShRY/cYSxSUsYu4Iy2aWNQMHx5h8FWev6tLZFDICBXLyB34LkW+2+86NcjoTK
        bVc1P61/0lIAgGyfXAR1tjhW94/GjI+i3dBF7oiGENquIpo59kpx7Hw5w85Atdi1XS2/W2
        tqm24OJsJUlUpikobEkGPDDeor1liJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-28sXCqmINh-LnPyBKYXAsw-1; Mon, 30 Mar 2020 16:43:43 -0400
X-MC-Unique: 28sXCqmINh-LnPyBKYXAsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C969E1922960;
        Mon, 30 Mar 2020 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC74519C58;
        Mon, 30 Mar 2020 20:43:26 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com, drjones@redhat.com
Subject: [PATCH 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
Date:   Mon, 30 Mar 2020 17:43:09 -0300
Message-Id: <20200330204310.21736-2-wainersm@redhat.com>
In-Reply-To: <20200330204310.21736-1-wainersm@redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduces the vm_get_fd() function in kvm_util which returns
the VM file descriptor.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index ae0d14c2540a..aa4a70f969ed 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -163,6 +163,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 unsigned int vm_get_page_size(struct kvm_vm *vm);
 unsigned int vm_get_page_shift(struct kvm_vm *vm);
 unsigned int vm_get_max_gfn(struct kvm_vm *vm);
+unsigned int vm_get_fd(struct kvm_vm *vm);
 
 struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a6dd0401eb50..0961986c0d74 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1703,3 +1703,8 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
 {
 	return vm->max_gfn;
 }
+
+unsigned int vm_get_fd(struct kvm_vm *vm)
+{
+	return vm->fd;
+}
-- 
2.17.2

