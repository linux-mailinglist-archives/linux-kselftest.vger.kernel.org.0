Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A37F216A0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGKWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 06:22:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50699 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbgGGKTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 06:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594117180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L5i9FWpD9Zgl0JvxdcvOzY3HPLnPsYeLh9ngabyc97k=;
        b=JcXwvdl72bZo5HYkbmI5HlRem2zRBLFsYQova3JZQ6T14LpnEhqvWN5pZHndI36I5AaRAG
        sYcn/abVJEs+H3SCU/BXioEtuRHYl5lEmlVsXSrCvnT16b1g13PTlblGh5+xdw9t9ZdYXC
        QY11+1bqD77jqR+sRj6I66xAHa/1srU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-uCrdFrQCOdaozMbOFzfh9A-1; Tue, 07 Jul 2020 06:19:39 -0400
X-MC-Unique: uCrdFrQCOdaozMbOFzfh9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AD6107ACCD;
        Tue,  7 Jul 2020 10:19:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28A82275E47;
        Tue,  7 Jul 2020 10:19:37 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     christian@brauner.io, shuah@kernel.org
Subject: [PATCH v3 0/2] selftests: pidfd: prefer ksft_test_result_skip to ksft_exit_*
Date:   Tue,  7 Jul 2020 06:19:34 -0400
Message-Id: <20200707101936.12052-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Paolo Bonzini (2):
  selftests: pidfd: do not use ksft_exit_skip after ksft_set_plan
  selftests: pidfd: skip test if unshare fails with EPERM

 tools/testing/selftests/pidfd/pidfd_test.c | 55 ++++++++++++++++++----
 1 file changed, 46 insertions(+), 9 deletions(-)

-- 
2.26.2

