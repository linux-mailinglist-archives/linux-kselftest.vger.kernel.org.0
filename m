Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB851CA273
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgEHE4Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 00:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHE4Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 00:56:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121CC05BD43
        for <linux-kselftest@vger.kernel.org>; Thu,  7 May 2020 21:56:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 207so315610pgc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 07 May 2020 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4CNZy247ICcFx3HCeAu3lFAco0E9gMG+0QdnsbzPiRo=;
        b=YongsVUNpHD9pyODgLUWb/61UgHn39x8OVioXsqsF8t1wwG89KBDqSL6gSxorgd9k/
         g5T8jWEiH3DSGv7acmuQXIGGzN7sTXF3NStQ2YTee6G0PEbK67HSSVAtPAHU9XybTN1M
         aQ49zkZht+DgamSC1QAGbZEfnNrfzBGWhEB/FJGNrkzwzZtGdLWQFuz02wCT9TT6IvwC
         JdFrTlS8NmCdS1cvcoyFmjapEa4vx4HKpdpKrw8Z0ql2EQG1ZMEzABuFIgLN6U99b9Ta
         gUYdOvR0cOs+31NukcL5XHWI8vGgztzelE+KIPZ0szEB++UYVvFk1gbHMIiKxJMQQh+u
         GA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4CNZy247ICcFx3HCeAu3lFAco0E9gMG+0QdnsbzPiRo=;
        b=i0VU7NZwox7G/DiDdGeje6marBmRkFdyZRSB+aVraC7nCkQtpMum2HwMvJYFEs+wNv
         IRhgDtPHf3KrNoShnxyRAujE5ja49kNoH9dCMvOuAG82YiasrCs1ik9YhjF+6017EHq/
         q22SzKDSQBrqcrnjq6AkO2L+CZzsio+9ip+45R91mzwBwSVaAgpz5uCZidRr++FGIDXX
         qj7v3u7If6H7oakkxZGZKrioqc8Lopbtj5TZXgKrbvdP+aInIDrh07F3D2uGDmVKPs5n
         UwbAs+Y+GhdRLb6YjoN8x/OKbrKtDsAvX7OV+bHULvnsIh9FWZqhPZ2R5tToCVHahCm8
         iXqA==
X-Gm-Message-State: AGi0PubDgCM1Hlc/cGxY2ka/WgqwMKvl9oEtCFgW5Ze1+xQyVLtvgB37
        m5kS9/Z0YTUwM9XncuA+YOH+Ug==
X-Google-Smtp-Source: APiQypKH7PmGUi/XHWEExL2pZ4ExfPw8tZVjceK5ZGdxg/94ViJwHsuu88DxdsCvzqKaPIiI68ArGA==
X-Received: by 2002:a63:5824:: with SMTP id m36mr588890pgb.439.1588913775577;
        Thu, 07 May 2020 21:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d124sm426812pfa.98.2020.05.07.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 21:56:14 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftests: dmabuf-heaps: Fix confused return value on expected error testing
Date:   Fri,  8 May 2020 04:56:10 +0000
Message-Id: <20200508045610.80522-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When I added the expected error testing, I forgot I need to set
the return to zero when we successfully see an error.

Without this change we only end up testing a single heap
before the test quits.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index cd5e1f602ac9..909da9cdda97 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -351,6 +351,7 @@ static int test_alloc_errors(char *heap_name)
 	}
 
 	printf("Expected error checking passed\n");
+	ret = 0;
 out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
-- 
2.17.1

