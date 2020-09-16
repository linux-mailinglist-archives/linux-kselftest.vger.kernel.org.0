Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27226C847
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgIPSn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Sep 2020 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgIPSW4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Sep 2020 14:22:56 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBFC014DF6
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Sep 2020 06:14:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t16so6236792edw.7
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Sep 2020 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9VqfpNCj0MSyiJOj8cou5kDvPvXrecq9WKcceNDp5Q=;
        b=hWbLla41yjx7vVEITV+EPi+Ayks1q3blrSO4z5Sy2PROXR6ozrgmywAefAZeNh2ARP
         3ku+bZbKZnXb3cIsH2nFmV1Vw7VH9eRdcZj67g3vDR2XubZ3HcPT/PymxtcH8nOsxk86
         BzIsYIg6sTUk1bq0wy0gWd20je59ztK32g1wCYlCoCnnpzf6VQj0ZDPFAUVrqOOtPtKN
         mpYef6hNgBbbLgS13n50PVmr+wfM3GB4q7hlgrCt0mOE5ll8DI1xQ7+pZW346T6dvmzQ
         8Yw//O8IYYG9UfDo5gi0ocpt3xhEySgoLtArCSzjvopPs86sGBlfaEpbVFRPwggkI1q9
         uwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9VqfpNCj0MSyiJOj8cou5kDvPvXrecq9WKcceNDp5Q=;
        b=kQoiW+CeG9ebt9rQF+UJKq4TG/3tBTMtSBZeLvfDU37yrSkINh2ZRdCRV5YDCJ2mWn
         cr9W4dnZsOOi73JlAt8EU1k+ZzDqicRsiM2P6gzmHxqO/+cQju05+RfOZJ99tl6c3d75
         Npy4Chx/Rir83SN77SGgp1r/r1vK3SknV4TDfp4+NYwXrBnHY3bAvfRzEjHNEijHfjXh
         YX0HkhywHKe8Qz3x5+A/nxZ69WQdpUrg7pxaDsKg4ANkD9rRFZFXvfh14kKJNrAkOiX1
         Y3MJBnCFYHnppu35ZhgZPcp+k3Mr6MXTqaVBzD1DIjd7UtzxAjMtnRhaS/ocxBOhz7Ko
         i/ww==
X-Gm-Message-State: AOAM532K/CaHlfrx0nMJb0vQ09gpznT9AUZFULYSfjGd1oW4kiUgmOs7
        7IGRlAkPjWjhI79zHCgslbbSVQ==
X-Google-Smtp-Source: ABdhPJzNzf1HOn2IBAdX5MK2PjeksZXhGz4klv1LeR3D7lg57J8cmDaNg8/+1vya7CMDTh4rk6MofQ==
X-Received: by 2002:a50:da84:: with SMTP id q4mr26780039edj.238.1600262061835;
        Wed, 16 Sep 2020 06:14:21 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y9sm14031441edo.37.2020.09.16.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:14:21 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: mptcp: interpret \n as a new line
Date:   Wed, 16 Sep 2020 15:13:51 +0200
Message-Id: <20200916131352.3072764-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In case of errors, this message was printed:

  (...)
  # read: Resource temporarily unavailable
  #  client exit code 0, server 3
  # \nnetns ns1-0-BJlt5D socket stat for 10003:
  (...)

Obviously, the idea was to add a new line before the socket stat and not
print "\nnetns".

Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    This commit improves the output in selftests in case of errors, mostly
    seen when modifying MPTCP code. The selftests behaviour is not changed.
    That's why this patch is proposed only for net-next.

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e4df9ba64824..2cfd87d94db8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -443,9 +443,9 @@ do_transfer()
 	duration=$(printf "(duration %05sms)" $duration)
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo "$duration [ FAIL ] client exit code $retc, server $rets" 1>&2
-		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport = :$port"
-		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport = :$port"
 
 		cat "$capout"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f39c1129ce5f..c2943e4dfcfe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -176,9 +176,9 @@ do_transfer()
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
-		echo "\nnetns ${listener_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -nita 1>&2 -o "sport = :$port"
-		echo "\nnetns ${connector_ns} socket stat for $port:" 1>&2
+		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -nita 1>&2 -o "dport = :$port"
 
 		cat "$capout"
-- 
2.27.0

