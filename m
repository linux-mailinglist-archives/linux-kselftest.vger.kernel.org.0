Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B934284F78
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFQGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQGi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 12:06:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ACDC0613D1
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Oct 2020 09:06:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id md26so18414126ejb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Oct 2020 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+y9F2HEpHR7lpSOgScZpt3aZTxZ1exfih7MMVF+3Hw=;
        b=jf88Ccrjz6JfstZvP1H6vKpUwaTbdYZQWbaqcorUPs55gtjmyI3fseCArUh1epVqS3
         4eYNRt440ub75D4QaXWpqP8ARoht8EmKsdCjpkhEIHbxaEiablFizXmgczRurfzefJaY
         zHLPbvcCYjtcnCnQUd+ADgEZcRIHNZrjL53518daGtLB6NDrV9XNi8ab5/Kmg7WBizOK
         egSWWtXN9UmDmdu/uHETlYZsUpP5g/rIPVYVi8wWudAApcmJy5zAxn1vKXvoMZ91HADg
         CH4TGBFnVr2ZxtiL9Dg1jVYUTLNPXugnvf+aOl77pBULkmJm+Zmahy+rlgX5ebxHRGwS
         xwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+y9F2HEpHR7lpSOgScZpt3aZTxZ1exfih7MMVF+3Hw=;
        b=svDBRzzfJkKAYnavGtQ+NN/UJiwAM7LyxLrrTz8ZHAD9wTH4DVUUKtyLkcW+BkAUtn
         I0Eyck5kCac5F9qEm061e24Q9kULD9hIbx0edSOnHDkK+6VIk7ZQp06xp4wq4WyZG14Q
         AGzfbqhYEmfl2qvjToObeRfXIy11yXMNGKG3hyfQmZAKMb6uX5+yxgCL9InlzOADoPA3
         ZHMLr81DTajnaKo5gC0rSCn3jg06NzRW1SXVyDyLILbAn/jerjj0vNJpd0ovxCt1Eq6E
         k762Odi2pVJU39D8VhXCyWDvguGbwONRg9+jwPT+Avma+4HCITirde2eDVd/IgvOans1
         geLA==
X-Gm-Message-State: AOAM533MC7KhpLErlT7iYScvZ1mEkrhP4GIIUSi95Ins7mI/7yPd7TS4
        XDEpUCL8/n3Zf0BlN02aSrI0eA==
X-Google-Smtp-Source: ABdhPJyzjVYRacyR1diWDrgUya8FodDmT9FCiesreDN+9KHyafL2720b1WgbdyuWdfsIk2q8a1ZJlw==
X-Received: by 2002:a17:906:441:: with SMTP id e1mr213966eja.396.1602000396693;
        Tue, 06 Oct 2020 09:06:36 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id jw9sm2412039ejb.33.2020.10.06.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:06:36 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: mptcp: interpret \n as a new line
Date:   Tue,  6 Oct 2020 18:06:30 +0200
Message-Id: <20201006160631.3987766-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In case of errors, this message was printed:

  (...)
  balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
  client exit code 0, server 0
  \nnetns ns3-0-EwnkPH socket stat for 10003:
  (...)

Obviously, the idea was to add a new line before the socket stat and not
print "\nnetns".

The commit 8b974778f998 ("selftests: mptcp: interpret \n as a new line")
is very similar to this one. But the modification in simult_flows.sh was
missed because this commit above was done in parallel to one here below.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 0d88225daa02..2f649b431456 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -200,9 +200,9 @@ do_transfer()
 
 	echo " [ fail ]"
 	echo "client exit code $retc, server $rets" 1>&2
-	echo "\nnetns ${ns3} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-	echo "\nnetns ${ns1} socket stat for $port:" 1>&2
+	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
 	ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
 	ls -l $sin $cout
 	ls -l $cin $sout
-- 
2.27.0

