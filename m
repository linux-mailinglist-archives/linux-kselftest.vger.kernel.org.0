Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073F025925C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgIAPKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 11:10:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51569 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgIAPJh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 11:09:37 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kD7ug-00048g-9J
        for linux-kselftest@vger.kernel.org; Tue, 01 Sep 2020 15:09:34 +0000
Received: by mail-pl1-f199.google.com with SMTP id b14so764890pls.12
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Sep 2020 08:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWz4w/tKyZ/PP+PlUCJ8+eDDTwAKqJWDoeBWELU6jAM=;
        b=PaQF6FG+NzsooowKMGjcQVwqAmZyo7a9Y/B6VYV3OZdBlBycVzbuO4oNCSuFRpt+1W
         uKO2tAakvNZKTGJVpbJHi1jlT0I50ZSB1AlPVD4uOKK49AoycpSuRxJcGFZuSzScc7V6
         1UOQD2HJW8V2dPXaFTLclQ/HVtyeSxJ0qRSEGOqu4Nj8r4roduOQm1f+hmadQ+iQAoyW
         xW9kQxVrit2g+/tO0ewOrM7syuAMu85hp0i62RTYAZIpozFxEtwePKaxpwbMY4xT2qum
         Dclbg0rLWhFIYB01o9rxeH15icWQyPvbPB4FGjXDyx6EMAcMjD2sE1MZo8lusycqBA+R
         9Wgw==
X-Gm-Message-State: AOAM531e9d23ps91VnWlZQwX4P2AA0sEm1XvxUDbNcuxXD8IUXhvAs32
        ajhTgWP6tesjTo+vcc1ubel9jajliXALWht2UblevX8yd2/jdZSWlm7Qb5MHqarr/2G9xY5olTj
        jMn6+Zpbok1LyGBUgRBM5WDWDeaGdGoJq5zNcG2BboJMh
X-Received: by 2002:a05:6a00:15d0:: with SMTP id o16mr1610233pfu.231.1598972972771;
        Tue, 01 Sep 2020 08:09:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNSfUNALPQS+9nTX7oFc7jV43D9g7tlXj9ZJWwL0ajWGT5buiowf8haAL9Usk5V2m8MfmNqA==
X-Received: by 2002:a05:6a00:15d0:: with SMTP id o16mr1610207pfu.231.1598972972424;
        Tue, 01 Sep 2020 08:09:32 -0700 (PDT)
Received: from localhost.localdomain (114-136-253-112.emome-ip.hinet.net. [114.136.253.112])
        by smtp.gmail.com with ESMTPSA id y4sm2391098pfr.46.2020.09.01.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:09:31 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     po-hsu.lin@canonical.com, davem@davemloft.net, kuba@kernel.org,
        skhan@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: improve descriptions for XFAIL cases in psock_snd.sh
Date:   Tue,  1 Sep 2020 23:09:23 +0800
Message-Id: <20200901150923.36083-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before changing this it's a bit confusing to read test output:
  raw csum_off with bad offset (fails)
  ./psock_snd: write: Invalid argument

Change "fails" in the test case description to "expected to fail", so
that the test output can be more understandable.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/psock_snd.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.sh b/tools/testing/selftests/net/psock_snd.sh
index 6331d91..170be65 100755
--- a/tools/testing/selftests/net/psock_snd.sh
+++ b/tools/testing/selftests/net/psock_snd.sh
@@ -45,7 +45,7 @@ echo "raw vnet hdr"
 echo "raw csum_off"
 ./in_netns.sh ./psock_snd -v -c
 
-echo "raw csum_off with bad offset (fails)"
+echo "raw csum_off with bad offset (expected to fail)"
 (! ./in_netns.sh ./psock_snd -v -c -C)
 
 
@@ -57,7 +57,7 @@ echo "raw min size"
 echo "raw mtu size"
 ./in_netns.sh ./psock_snd -l "${mss}"
 
-echo "raw mtu size + 1 (fails)"
+echo "raw mtu size + 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -l "${mss_exceeds}")
 
 # fails due to ARPHRD_ETHER check in packet_extra_vlan_len_allowed
@@ -65,19 +65,19 @@ echo "raw mtu size + 1 (fails)"
 # echo "raw vlan mtu size"
 # ./in_netns.sh ./psock_snd -V -l "${mss}"
 
-echo "raw vlan mtu size + 1 (fails)"
+echo "raw vlan mtu size + 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -V -l "${mss_exceeds}")
 
 echo "dgram mtu size"
 ./in_netns.sh ./psock_snd -d -l "${mss}"
 
-echo "dgram mtu size + 1 (fails)"
+echo "dgram mtu size + 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -d -l "${mss_exceeds}")
 
-echo "raw truncate hlen (fails: does not arrive)"
+echo "raw truncate hlen (expected to fail: does not arrive)"
 (! ./in_netns.sh ./psock_snd -t "$((${vnet_hlen} + ${eth_hlen}))")
 
-echo "raw truncate hlen - 1 (fails: EINVAL)"
+echo "raw truncate hlen - 1 (expected to fail: EINVAL)"
 (! ./in_netns.sh ./psock_snd -t "$((${vnet_hlen} + ${eth_hlen} - 1))")
 
 
@@ -86,13 +86,13 @@ echo "raw truncate hlen - 1 (fails: EINVAL)"
 echo "raw gso min size"
 ./in_netns.sh ./psock_snd -v -c -g -l "${mss_exceeds}"
 
-echo "raw gso min size - 1 (fails)"
+echo "raw gso min size - 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -v -c -g -l "${mss}")
 
 echo "raw gso max size"
 ./in_netns.sh ./psock_snd -v -c -g -l "${max_mss}"
 
-echo "raw gso max size + 1 (fails)"
+echo "raw gso max size + 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -v -c -g -l "${max_mss_exceeds}")
 
 echo "OK. All tests passed"
-- 
2.7.4

