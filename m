Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82FAF91E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 15:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfKLOVX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 09:21:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727549AbfKLOVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 09:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573568479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=l888mZumwB9sUbXe+Otg+6BZArqn24A8WoDV+FXXsG4=;
        b=ibxTOEjjCaJNCpMAOjuBuL21ajRzX65QxQJXiSnGyL+Pg7S/iLzVemv/S8XF3hI+jzKJ45
        QILLP/YGWndotRXtvHQ2EI3uHQtsTtHRWmB27nUZQarflU/5+C1B59ymeYEf8i91eAJKr4
        yyp9LN7dxwwmRaT0EgvIRoUoHyP4Ys4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-z3MrLAg7M_mdgQ6R2J2Pqg-1; Tue, 12 Nov 2019 09:21:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30694107ACC4;
        Tue, 12 Nov 2019 14:21:15 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1EB0101E59D;
        Tue, 12 Nov 2019 14:21:11 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: Simplify loop in kvm_create_max_vcpus test
Date:   Tue, 12 Nov 2019 09:21:11 -0500
Message-Id: <20191112142111.13528-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: z3MrLAg7M_mdgQ6R2J2Pqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On kvm_create_max_vcpus test remove unneeded local
variable in the loop that add vcpus to the VM.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/tes=
ting/selftests/kvm/kvm_create_max_vcpus.c
index 231d79e57774..6f38c3dc0d56 100644
--- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
+++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
@@ -29,12 +29,9 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus=
)
=20
 =09vm =3D vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
=20
-=09for (i =3D 0; i < num_vcpus; i++) {
-=09=09int vcpu_id =3D first_vcpu_id + i;
-
+=09for (i =3D first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
 =09=09/* This asserts that the vCPU was created. */
-=09=09vm_vcpu_add(vm, vcpu_id);
-=09}
+=09=09vm_vcpu_add(vm, i);
=20
 =09kvm_vm_free(vm);
 }
--=20
2.18.1

