Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AA9612D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2019 15:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfHTNlm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Aug 2019 09:41:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42398 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbfHTNll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Aug 2019 09:41:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so5158212ljj.9
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2019 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNuDQYJVmflL/Wny4LHIdiHjJtChxjlf3zzR+P07bYQ=;
        b=ZDi1SFp8FXJaCjqmp4zm/ByzXqtJBaAQvabUX02QHSb6SDgYVNy5d57jcfvwyT0dA5
         8fzbFhHg9LRNWdJpl72dppeSuclNMByTBbZmU1xF7nAeqeBmQRvhlMYjmaiXLE4LV8wa
         zxoY/hF5DCBbdn3mRlsGF/QKdWdyYmxwOQPdPchKF8HLcZypJV/Ukw61WnY3PsnFAK6u
         Q+YJvglENuW+ieeSkGQnazSrxJiAcBHbB6uLYLGz1AJ9h/LaCq1SaT3QhJAAHmVF4Fz7
         Q2G5T+L+zrAQfW0/HE1GXl6UCt7EAtJC8GptIXHJXVjn/yaRqmlb/VYXAa36kix3OPE7
         AUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNuDQYJVmflL/Wny4LHIdiHjJtChxjlf3zzR+P07bYQ=;
        b=qKGvrVl/oxt8M0HEiSP+kRK38KLvSdnISlEDPs6WPejOQdKPipJ6RpsPoZ3+d6HrPM
         pu2QFoehGWYClY72nTp6gdaJCQ3BNxknGyvPYifpwKs/iHMt/DZn9GXHCyKZE1r4hDA5
         87IM2xClx1bJShtn+YcSrywntVMgzsbDSCsPQcjBfkWaGM4CJEnkbDa8LvM+OeXDh7XA
         FFdT951+94ImKppHgh8Aiu328qZBCCMrzk93lgzGVLZy4MZok5dMB5CmrtqJSOkx+yN4
         Tc3ogCzu2tYdpfnO0MupKanzAO8HEuBSpJ0sLza1UNCsYAHHBVhF6NZGxzRccEu6Nfkd
         JCyw==
X-Gm-Message-State: APjAAAX+Oo3vcG417d8VbN6DgGGVd0CMo+5eY+PFcF0aJmQAwOY1xtpJ
        npMmhdEDCxzGQJHYZSuUD8ZEIg==
X-Google-Smtp-Source: APXvYqxp8WgHlmWB1TJ1U6T1cdPC1f76z95rZGZ+Y6JhIi2z2/jagdLSnDlzo64tshfBrRxPu29rpQ==
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr15447861ljl.76.1566308499392;
        Tue, 20 Aug 2019 06:41:39 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id f22sm2820208ljh.22.2019.08.20.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:41:38 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: add config fragment BPF_JIT
Date:   Tue, 20 Aug 2019 15:41:34 +0200
Message-Id: <20190820134134.25818-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running test_kmod.sh the following shows up

 # sysctl cannot stat /proc/sys/net/core/bpf_jit_enable No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_enable #
 # sysctl cannot stat /proc/sys/net/core/bpf_jit_harden No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_harden #

Rework to enable CONFIG_BPF_JIT to solve "No such file or directory"

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f7a0744db31e..5dc109f4c097 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -34,3 +34,4 @@ CONFIG_NET_MPLS_GSO=m
 CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
+CONFIG_BPF_JIT=y
-- 
2.20.1

