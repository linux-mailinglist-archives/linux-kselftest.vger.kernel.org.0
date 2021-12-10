Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86946F932
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 03:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhLJCbg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 21:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbhLJCbf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 21:31:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858DC061746;
        Thu,  9 Dec 2021 18:28:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id k26so7152804pfp.10;
        Thu, 09 Dec 2021 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLFKEFmsq3SGmkOwN4l/i+bv2/Bc/K1S6JMbIUmp7Ck=;
        b=hoz2DZ2LKoVusNKhN8wWwbGbbyWrLLnhsYoCfDvvlLAyNJqpTBsXsnKXR+eeZ5ubmR
         ANl729GY4toot5pfQrSpa414UgnI62ZeAi81WYiRhP+rkdFdHf57cIkUHClolnBzxtue
         wDG22tNe4Bj00vmCM5Jg4TmxJAHN8X5bSTESnH86psJ9u6O3yhZ0CXpNVr521V8XzkbN
         0TDtZi/ap1eJJnhtQHHJSH1Hx7g4ToGI2uhwmGsNmwTDtIh+IMmLQQ77Lrl+G75uTREP
         +ZHoH0vlsrba0M1mE1m/Gluuc1g1YUkJVVCe3CaGX0s1JgFrc5kcgRNCOpgtFjVIUBqo
         iJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLFKEFmsq3SGmkOwN4l/i+bv2/Bc/K1S6JMbIUmp7Ck=;
        b=wY5lJJR866h4d7Ln2eMiRfdo6DjH7ldKMIDqsfMzK2tsfz+nZGUSMwitTucrQ4JNnv
         9piOjfrmrgSHbjOyXjEu5X7TQ3kDvC9oInOSyigPGK00ySDJGkh3aOo0cyNqJauoBwAX
         k3Xx3G+PJH6b7jpZ0U220PXip2GdIvmt8DS87SmVVs4JuGHHaojqFWZ0jF4yaBsuEb+J
         TUv29Rg3bbDAlheKbcYyJ90TOZhoEWfE/aNDsl97t1pe/IwAjnGM7kHJRbRrgVuFLjPY
         s/F7xOq1Jq8UdPtlC81cWUuM49wFEzF49lKaysL+rKFqIzl2pM5ayKSRgj8PQ0VetFUw
         L3Cg==
X-Gm-Message-State: AOAM533KsGaopWUCKJNmkfzW/3Tlwr7ljcOukcisBqJlwh26KnEG2KsC
        qMM/GkpCl7YZj1zxSkDFMmg=
X-Google-Smtp-Source: ABdhPJyBQ7dWzxG6EHcpP/IT0r/n7dUp/aJaiwV+9jMU7rctGoAjU0IDu0M+jMJRsOoV7GAfudWn+g==
X-Received: by 2002:a05:6a00:2d1:b0:4af:437c:5f50 with SMTP id b17-20020a056a0002d100b004af437c5f50mr15348205pft.32.1639103281108;
        Thu, 09 Dec 2021 18:28:01 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id mi14sm11044267pjb.6.2021.12.09.18.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:28:00 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     pbonzini@redhat.com
Cc:     shuah@kernel.org, seanjc@google.com, vkuznets@redhat.com,
        ricarkol@google.com, maz@kernel.org, aaronlewis@google.com,
        like.xu@linux.intel.com, dmatlack@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH kvm-next] selftests/kvm: remove unneeded variable
Date:   Fri, 10 Dec 2021 02:27:55 +0000
Message-Id: <20211210022755.424428-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 82c39db91369..80ab802aa8f8 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -931,15 +931,13 @@ int _vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid, uint64_t msr_index,
 		struct kvm_msrs header;
 		struct kvm_msr_entry entry;
 	} buffer = {};
-	int r;
 
 	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 	memset(&buffer, 0, sizeof(buffer));
 	buffer.header.nmsrs = 1;
 	buffer.entry.index = msr_index;
 	buffer.entry.data = msr_value;
-	r = ioctl(vcpu->fd, KVM_SET_MSRS, &buffer.header);
-	return r;
+	return ioctl(vcpu->fd, KVM_SET_MSRS, &buffer.header);
 }
 
 /*
-- 
2.25.1

