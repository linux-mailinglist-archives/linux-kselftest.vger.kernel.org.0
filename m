Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7941F5A29
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFJRVH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 13:21:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727883AbgFJRVH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 13:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591809666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Nchs7giH9/7F+jYJ/Q/sPpycdHjWoC2ELbn/5DQJ2o=;
        b=dp4eQbeASMpyR0KYCCOBXNIK6RzHVYF7NJUZwVYwvX3DntgIEPpLr4oJ1yyjv9QQ8oLyZ4
        QWw0zIT1sL8RjPSytmWJ8/L0QW/nqT2rUtFgl7p15M+ebpXOVpVp5wiCWG0O3JVocv2SVk
        /Gmhr0PKEQIKqR+beFJNrFfn11v47lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Y1eX-00sO2eeV1GR3MKuLA-1; Wed, 10 Jun 2020 13:21:04 -0400
X-MC-Unique: Y1eX-00sO2eeV1GR3MKuLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E2CC100CCC0;
        Wed, 10 Jun 2020 17:21:03 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-117-142.rdu2.redhat.com [10.10.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCD267BFE2;
        Wed, 10 Jun 2020 17:21:02 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] selftests/livepatch: small script cleanups
Date:   Wed, 10 Jun 2020 13:20:58 -0400
Message-Id: <20200610172101.21910-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a small collection of tweaks for the shellscript side of the
livepatch tests.  If anyone else has a small cleanup (or even just a
suggestion for a low-hanging change) and would like to tack it onto the
set, let me know.

based-on: livepatching.git, for-5.9/selftests-cleanup
merge-thru: livepatching.git

Joe Lawrence (3):
  selftests/livepatch: Don't clear dmesg when running tests
  selftests/livepatch: use $(dmesg --notime) instead of manually
    filtering
  selftests/livepatch: filter 'taints' from dmesg comparison

 tools/testing/selftests/livepatch/README      | 16 +++---
 .../testing/selftests/livepatch/functions.sh  | 16 +++++-
 .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
 .../selftests/livepatch/test-ftrace.sh        |  5 +-
 .../selftests/livepatch/test-livepatch.sh     | 15 +----
 .../selftests/livepatch/test-shadow-vars.sh   |  5 +-
 .../testing/selftests/livepatch/test-state.sh | 20 ++-----
 7 files changed, 43 insertions(+), 89 deletions(-)

-- 
2.21.3

