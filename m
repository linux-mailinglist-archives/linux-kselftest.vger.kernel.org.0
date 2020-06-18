Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8395C1FFACF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 20:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFRSK5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 14:10:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726882AbgFRSK4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 14:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592503854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LHGyp6CYIKGOqwxes/zzCO/ZvJIZQruxra7ZLeYTBQU=;
        b=KAAOQfDVQYMSGLM+3xbF7wPiEY0xX+gCRY6tci3hy3FQtl1L4FhzSVgx03/t+W4gF/IlQ9
        aIfJYfgq/XzdAsCYGmortwCIxnVTTM7Klv31zSFUNRPwf4OY6lCWOGvCzfuh5g7HkgGNY2
        i6bPrdY3VU5H+TWQ+Igv2kGLmAKX/aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-u01PmpGkOlmYIPKnLHNA5A-1; Thu, 18 Jun 2020 14:10:53 -0400
X-MC-Unique: u01PmpGkOlmYIPKnLHNA5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04348107BEF5;
        Thu, 18 Jun 2020 18:10:52 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE701E2261;
        Thu, 18 Jun 2020 18:10:51 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Yannick Cote <ycote@redhat.com>
Subject: [PATCH v3 0/3] selftests/livepatch: small script cleanups
Date:   Thu, 18 Jun 2020 14:10:37 -0400
Message-Id: <20200618181040.21132-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Petr,

Given the realization about kernel log timestamps and partial log
comparison with v2, I respun a final version dropping the dmesg --notime
patch, fixed any rebase conflicts, and added a comment per your
suggestion.

I copied all the ack and review tags from v2 since the patchset is
unchanged otherwise.  Hopefully this v3 minimizes any maintainer
fiddling on your end.

I did iterate through the patches and verified that I could run each
multiple times without the dmesg comparison getting confused.

Thanks,

-- Joe


v3:

- when modifying the dmesg comparision to select only new messages in
  patch 1, add a comment explaining the importance of timestamps to
  accurately pick from where the log left off at start_test [pmladek]

- since Petr determined that the timestamps were in fact very important
  to maintain for the dmesg / diff comparision, drop the patch which
  added --notime to dmesg invocations [pmladek]

- update the comparision regex filter for 'livepatch:' now that it's
  going to be prefixed by '[timestamp] ' and no longer at the start of
  the buffer line.  This part of the log comparison should now be
  unmodified by the patchset.

Joe Lawrence (3):
  selftests/livepatch: Don't clear dmesg when running tests
  selftests/livepatch: refine dmesg 'taints' in dmesg comparison
  selftests/livepatch: add test delimiter to dmesg

 tools/testing/selftests/livepatch/README      | 16 +++---
 .../testing/selftests/livepatch/functions.sh  | 37 ++++++++++++-
 .../selftests/livepatch/test-callbacks.sh     | 55 ++++---------------
 .../selftests/livepatch/test-ftrace.sh        |  4 +-
 .../selftests/livepatch/test-livepatch.sh     | 12 +---
 .../selftests/livepatch/test-shadow-vars.sh   |  4 +-
 .../testing/selftests/livepatch/test-state.sh | 21 +++----
 7 files changed, 68 insertions(+), 81 deletions(-)

-- 
2.21.3

