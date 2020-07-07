Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA921729E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGGPje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgGGPjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594136373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sgRh0qhFo5Ydjex921fpgKOxpO35vzEeaYPLDabGjOY=;
        b=LkDQdquRXSf+2m6heFw8LarEcZYscdfHbfR4Jbay7oJrGyrITG3EM3Sgd6XvZeoATFZYZf
        tTsCx13bYQRf1VgV1No9nQFdwIGc3Z61HYoZ4HneW3TOesB529Uo3hzIpnE9VNHIhrRyWc
        5BBUiIhUskN8564DpMriovG2FIqlL/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-RBOaLge7PKK_5VFGLwZ8bw-1; Tue, 07 Jul 2020 11:39:29 -0400
X-MC-Unique: RBOaLge7PKK_5VFGLwZ8bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A3918A0760;
        Tue,  7 Jul 2020 15:39:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4F210013D7;
        Tue,  7 Jul 2020 15:39:27 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org
Subject: [PATCH v4 0/2] selftests: pidfd: prefer ksft_test_result_skip to ksft_exit_*
Date:   Tue,  7 Jul 2020 11:39:25 -0400
Message-Id: <20200707153927.12802-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Calling ksft_exit_* results in executing fewer tests than planned, which
is wrong for ksft_exit_skip or suboptimal (because it results in a bail
out) for ksft_exit_fail_msg.

Using ksft_test_result_skip instead skips only one test and lets the
test plan proceed as promised by ksft_set_plan.

Paolo

v3->v4: remove useless initialization

Paolo Bonzini (2):
  selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
  selftests: pidfd: skip test if unshare fails with EPERM

 tools/testing/selftests/pidfd/pidfd_test.c | 55 ++++++++++++++++++----
 1 file changed, 46 insertions(+), 9 deletions(-)

-- 
2.26.2

