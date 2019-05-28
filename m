Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E352CEE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfE1SrS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:47:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43774 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1SrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:47:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so11502081pgv.10
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cGc7AzHIWb52T88+bfjjefIMYH/WgJgz52/xY4DYYK8=;
        b=LdfwSAPBxBcJwmhMJQOxmloW3OxDFPmTupuWq8PqpCS31kUqpDSncrwkglC/PB2b9s
         EbAz7vik75nSZ6urGTsNx62NUGFwDr7i+S2FGdGvrA8NYTUaB7zqhNo6Va/lnfHChQxg
         JjzwqodY54W/b1C3rtSByXmDgvAHSgO6ndjQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cGc7AzHIWb52T88+bfjjefIMYH/WgJgz52/xY4DYYK8=;
        b=HQCNZ9RV0F6AoMgCLhNMYe2lF+4UZV+5WNesOe4YiEGyWEmIabFP6Ndj9kgk48FhVV
         wBFAA51gszJkMo1fhSngHhsP8oHEDyyQWCVWB1Hd9WhH8BliwDjMjuMPKQ387sBiSBHU
         OkKbi8td1bnOFKPmIYKGR3VukUIpyRjoA0+lYEmg/sqj8prrAj5AUde6F13xBdy5JYte
         bFiamla3sJ6NXmmaBBEbyPtmVi2cpxJcsQhEc1ia/9/VRioKyJNBXx1xA1ng7XBgmesk
         Dmedir5lDn+8ge0Lp3NVl+E/giJn/bP7nq3inQW3kWV1mlaCeMRvtPoclSCvhkaVwByT
         3sUg==
X-Gm-Message-State: APjAAAWjJdWGiImQ9QAPjJJYX37528c/Es/7JYH+eXlw/8BJiwvwt+Jw
        P1u4Mipib9h1cP20umMBpXUdfQ==
X-Google-Smtp-Source: APXvYqw6foEZcSu0UWBUGZHiUK+cl9+zdMn+NzRD3LctKUAqRLhJHaYeZX5TS6hknJ9xNgIx8lCO/Q==
X-Received: by 2002:a17:90a:2a85:: with SMTP id j5mr7726560pjd.107.1559069237397;
        Tue, 28 May 2019 11:47:17 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id m6sm3323766pjl.18.2019.05.28.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:47:16 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v2 0/3] UDP GSO audit tests
Date:   Tue, 28 May 2019 11:47:05 -0700
Message-Id: <20190528184708.16516-1-fklassen@appneta.com>
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

 tools/testing/selftests/net/udpgso_bench.sh   |  51 +++-
 tools/testing/selftests/net/udpgso_bench_tx.c | 324 ++++++++++++++++++++++++--
 2 files changed, 357 insertions(+), 18 deletions(-)

-- 
2.11.0

