Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7633045681B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhKSCek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSCek (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 21:34:40 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EFC061574;
        Thu, 18 Nov 2021 18:31:39 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x131so7997332pfc.12;
        Thu, 18 Nov 2021 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj62xPtoj7u5fapw8icoG4rWd4S2VyV1qafsL9hBY0k=;
        b=Z9DmoDO9ef8ukaAz7mP320tZtIKx5nRmBKwH3quZr/J5Wb1xdu1VaxsDaQxQF+uR9e
         VhJ/mmkgoT3nDaHnf0qfN/FyY7bwaeGgZozU/IOXWJRaF1a3ulZ5jqBoZpJMuPftSeEs
         OHPVz9i9ZB1BTo1suio9ndu+IJAd/ycvvwQ6cov3V6BhLfVeJ3HzYBiZZLO+IuayF2iR
         IaUuP4eelS+l7BeDTmnptXlQzAeaOn6BgmxBEpvyztegwFYZSWmNFiT3byv66x2ssizH
         ch+PgaXtnAcryJGadFbNqoPX1GA0gFpz7s0UKCtjklYaG2Hucpx1Qv4Q6+8PbltizZ6R
         PPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj62xPtoj7u5fapw8icoG4rWd4S2VyV1qafsL9hBY0k=;
        b=EcWErEUDomnh9L+UoCGkL4UDa4DkXW/YSdEXfxyj0UUcbwYJ3LaJeez31UEGK0j5cN
         cfKMD/F50agOKWMT1UHI04ZVklkJSH2ZmxIQZGwTKy7EnFPd7br5ItcT7CSbxsGOuadx
         fuP8KNDlR4oumdC+1UcAsDb9hxQWq2RYsqWms+1Vnk81HzR02MuTh+rpQEytOY7PmRBv
         zvV5bdAb3m3uqX8LwTyY+UpxaWNHk5q74B2VLBDGluGeHgJW+RwUecl36B51EmJoc4ff
         WS+qlrpUusnKcJ3GwSQLew6GIRBkAT9wys2wHkekcbOQt4ouMG3w8wOfNF4GmQbMeI6q
         Ah9w==
X-Gm-Message-State: AOAM530c0Eswpy71LPF86D1HXvAM1IZLMSHh/+NeNMAFoEaKgV99SquN
        VOY8FFlKzfWNdnyxEXMGuv0=
X-Google-Smtp-Source: ABdhPJyurArxX1vefPVfb7nfSviSwdvQO88CSd/6272mE0zK+/2tbaBjoOnLtZq7vjJBsdKaAR8KyA==
X-Received: by 2002:a63:2b88:: with SMTP id r130mr14731167pgr.80.1637289098794;
        Thu, 18 Nov 2021 18:31:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h186sm897122pfg.59.2021.11.18.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:31:38 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     pbonzini@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] selftests:kvm: remove unneeded semicolon
Date:   Fri, 19 Nov 2021 02:31:33 +0000
Message-Id: <20211119023133.2027-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccicheck REVIEW:
./tools/testing/selftests/kvm/access_tracking_perf_test.c: REVIEW Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 tools/testing/selftests/kvm/access_tracking_perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 5d95113c7b7c..09bf6c6ca11a 100644
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
2.25.1

