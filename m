Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816AB3F2568
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 05:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHTDjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 23:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhHTDjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 23:39:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A43C061760;
        Thu, 19 Aug 2021 20:38:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id az7so9548628qkb.5;
        Thu, 19 Aug 2021 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpuoSi/aq4gNa9Y1M9Ya1mlkUyTMEQflq2RRPqeW+68=;
        b=uaT893NDSqUkcMl32Yos8I5VoCaXqhc5MGa4oDFtd/SIv3wClOgVjyzePB4+UbotoL
         PrEMiqeeBRg6KcRMeS+6agPae5QzghvQbozGs/wft8NM6KHfAjvSFFJrZ8mCz/p0A9uR
         kqNoWaWnRDah+CBcxJzSk8auEy3IpiehHiY5KJ3z1zZVOSy9WiT5Fu+rbd1rsZ68KCKX
         L8OEEEsfaRqIEFGu73r/LqteU1E0g43ct3NgYqxvj9N8LERluwPD+5ml1BDbQeixG7FA
         EncE9ygzjg6kRVbyWfAtoQBqX4EGzdSOPSF7EuiPTbMujByv5y6NeggKM3gFwX/AyW/V
         FUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpuoSi/aq4gNa9Y1M9Ya1mlkUyTMEQflq2RRPqeW+68=;
        b=q2+Ktj9cPfCysFn5BbCuJN0HJP2ffToNXrTwHzRpOqK/lDxAk6qQdTpxXXPjZ91gfa
         AUthBQdKLERJeC1AyrAWmhwaeXr5ffs/5KaC21Me4llaYKdDCRXgFZ0bQz5swvUIcBjL
         297eQGBhnFcqqDk9NX9azyGbZU2VhNuKJaLQYtuV3vil71bO7MkaUACeyAO2RAanTb/f
         xsa5/xg1GHqyf6Ob14DOU8MdT3Qw3HoVyegK5KAFcDd3yHRQhNQ36nK17aCcUf2WiU6e
         Ul8xqDgnsq5hHxmKeIhMWMMos2oYuarM83pGp7x2mJaFp5SRshgqz+ab+68QVSzTiGl7
         Czfw==
X-Gm-Message-State: AOAM533YHfnX/s/3ernGjKnt2qcjAQXZLxzw7Cmv/IsXarAEh+ri4DyA
        LnnZSkUmFHnqhaVi89apBlY=
X-Google-Smtp-Source: ABdhPJyVH4s2VxHdBtpBJybnfmCfAIEOZPIHXfx7mijL7vtDMDAFaPfz+fMd2O/Z1UFvnvLAoJDOsg==
X-Received: by 2002:a05:620a:318f:: with SMTP id bi15mr3136506qkb.4.1629430721005;
        Thu, 19 Aug 2021 20:38:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y2sm2704851qkd.38.2021.08.19.20.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:38:40 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools: remove unneeded semicolon
Date:   Thu, 19 Aug 2021 20:38:31 -0700
Message-Id: <cf335b749549186343bcb8f73a17c38afe6c5bdd.1629196408.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Eliminate the following coccicheck warning:

./tools/testing/selftests/kvm/access_tracking_perf_test.c:234:3-4:Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 tools/testing/selftests/kvm/access_tracking_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 71e277c..02a1c0f 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -231,7 +231,7 @@ static void *vcpu_thread_main(void *arg)
 		case ITERATION_MARK_IDLE:
 			mark_vcpu_memory_idle(vm, vcpu_id);
 			break;
-		};
+		}
 
 		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
 	}
-- 
1.8.3.1


