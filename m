Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5348D8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfFQTIx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 15:08:53 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37546 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQTIx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 15:08:53 -0400
Received: by mail-pf1-f171.google.com with SMTP id 19so6191284pfa.4
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2019 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rnvedP+27FpjNnYtAjFGpiRqsnOOK2nmaRaeNdbtb1o=;
        b=vBsNL4xA75AArFv43xH/ZFWaTuVytMM6eqHpZ1tXM+VDVoEy5yMQripNDjto8EE4gy
         sLy8/DOabehrCXI85ff0a+D2MFJfY75cflKwRSSagC0yV0ctc+HzbxAa9ddgOJ1KFbz5
         xziO5rtypSlZ2XccylDBALkxodIipsANhVV2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rnvedP+27FpjNnYtAjFGpiRqsnOOK2nmaRaeNdbtb1o=;
        b=px054HvbRRXOix8i/0xmGGDfSsQmRAMsbuqzrUfplLj9D6PPAqBvR0AOHSBgISDcqH
         LOpdWePxMltwPgPcl62st0Dgu0O/3fiP2DoTOZ4YyfR9YXg313/+xZBK3tRZrNeg5sIQ
         1/5MtPh0TGNGOvyhYlvEm4/nph4SuR31NkePOWVIXbaLxc3zCrN5Jz9NEmac6oGRaPWm
         FeXLp3p5xi8L2beZzfLR0aAUKmV+ProPW/FhjnvmtYkSQEAGI6t2XjgIFCAcROrvEp0i
         psF00W5jACanFpjXy5KwDuRoFi0BIsvfKPhTRG1xBHGLyHKsgPcW9e58WJqJSIkzbKXk
         rPoQ==
X-Gm-Message-State: APjAAAWZah/FKpBCQmd2Vk4i9Y/h+T9zk/YRFKsJTsJL/UpUNi8t8dmQ
        MSilWK7qZJTRGoZ/EPB7hre4UQ==
X-Google-Smtp-Source: APXvYqwwGimRXjyilSR/k74EsjGUAgN/gKKO8YMsV/GXu+UiCTnuTOfgehMR7Sr7m7f0NsT6WX/TrA==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr428903pjr.64.1560798532555;
        Mon, 17 Jun 2019 12:08:52 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id p43sm111063pjp.4.2019.06.17.12.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:08:51 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 0/3] UDP GSO audit tests
Date:   Mon, 17 Jun 2019 12:08:34 -0700
Message-Id: <20190617190837.13186-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Updates to UDP GSO selftests ot optionally stress test CMSG
subsytem, and report the reliability and performance of both
TX Timestamping and ZEROCOPY messages.

Fred Klassen (3):
  net/udpgso_bench_tx: options to exercise TX CMSG
  net/udpgso_bench.sh add UDP GSO audit tests
  net/udpgso_bench.sh test fails on error

 tools/testing/selftests/net/udpgso_bench.sh   |  52 ++++-
 tools/testing/selftests/net/udpgso_bench_tx.c | 291 ++++++++++++++++++++++++--
 2 files changed, 327 insertions(+), 16 deletions(-)

-- 
2.11.0

