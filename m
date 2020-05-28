Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE31E62B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbgE1NtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 09:49:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390496AbgE1NtA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 09:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=docU54Z44EYvjTKr2BiYzPJ6Vv4MWlo9zXCnKcCtIlE=;
        b=KwPvhG6mqxiJdhuRL8VhssRLWK0noZGcvnOGuFSD5a89Gx3rYaVAjtAtceOu4EMIuatkVz
        eKXqdyjUtl6vYkIXwkkKqpA6av59xJxrc5St1UQ4D4ncl4VW5/mpvXaNR54+t6Vk/zp2eD
        pKBRnvC87Eo2LFkCu87kkxjsKpQQccw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-uPRjyl1rOJeN2k6arjp9nA-1; Thu, 28 May 2020 09:48:56 -0400
X-MC-Unique: uPRjyl1rOJeN2k6arjp9nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A372B18FF660;
        Thu, 28 May 2020 13:48:55 +0000 (UTC)
Received: from dm.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84BB2797EB;
        Thu, 28 May 2020 13:48:52 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
Subject: [PATCH 0/4] selftests/livepatch: rework of test-klp-{callbacks,shadow_vars}
Date:   Thu, 28 May 2020 09:48:45 -0400
Message-Id: <20200528134849.7890-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test-klp-callbacks change implement a synchronization replacement of
initial code to use completion variables instead of delays. The
completion variable interlocks the busy module with the concurrent
loading of the target livepatch patches which works with the execution
flow instead of estimated time delays.

The test-klp-shadow-vars changes first refactors the code to be more of
a readable example as well as continuing to verify the component code.
The patch is broken in two to display the renaming and restructuring in
part 1 and the addition and change of logic in part 2. The last change
frees memory before bailing in case of errors.

Patchset to be merged via the livepatching tree is against: livepatching/for-next

Joe Lawrence (1):
  selftests/livepatch: rework test-klp-callbacks to use completion
    variables

Yannick Cote (3):
  selftests/livepatch: rework test-klp-shadow-vars
  selftests/livepatch: more verification in test-klp-shadow-vars
  selftests/livepatch: fix mem leaks in test-klp-shadow-vars

 lib/livepatch/test_klp_callbacks_busy.c       |  42 +++-
 lib/livepatch/test_klp_shadow_vars.c          | 222 +++++++++---------
 .../selftests/livepatch/test-callbacks.sh     |  29 ++-
 .../selftests/livepatch/test-shadow-vars.sh   |  85 ++++---
 4 files changed, 214 insertions(+), 164 deletions(-)

-- 
2.25.4

