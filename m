Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1028C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfEWVJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 17:09:02 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:34187 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbfEWVI4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 17:08:56 -0400
Received: by mail-pf1-f182.google.com with SMTP id n19so3937943pfa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2019 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wMax+lenzyUHPsKlaw2Xwz1J2fIjhyjCZs+l8WeZZIk=;
        b=UaMnrdv9kxUyUAoeV3obdkbGuhYqC5UwxazWF+3nuF1UF3pQcc1gr+roilgZcHYFp2
         bvy5U/V0Qg5qe2Vf8zvxxGxiM2RPdhg7SaQAWwaDSYiYW006jUvPXKh2pzgTXNEQqpEg
         lw0XlMmuZgMdv568WatuxBTKK0UtQYWf7pLN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wMax+lenzyUHPsKlaw2Xwz1J2fIjhyjCZs+l8WeZZIk=;
        b=lNfF8aTis0qsSn4Gkp03Jk0S/Vbvm0R6xQfhwqfqg8oB6ChuBoDiEkzO5yIwelzLMi
         FN2+/+sawI0NguyjtYemTYCtgc3UaeHlB4v33ul+OB5yeB7qXlIp6uA+BH38U4m0HPNJ
         4NjfMyIy99kFs20PqPVwOqe6fKo3U+3juLoas+w8JeMlkDWJn7gRUgsoeI/dTYKlyUtB
         5vN55gZYQf43Uuh/0Os31Y+AowQWro+fKYvUn9joC40NwFicFRVGsiosfFZya0Zr32nb
         euJWU0GuGcOKWhBz/VfHGdY59DvOcKCsEhTJRQmyqMMVqqyi8Fh7EuYqvULewijSDIJi
         0OQQ==
X-Gm-Message-State: APjAAAXiYbE/ps/0mGn5zYFwIfLTXD7IIP1kviNiFBv04zS6EDTl0rHz
        /sAT6lT1xNGuv3fXeUxXLXAGrQ==
X-Google-Smtp-Source: APXvYqyjISI5Ny9VN8A309FwPymfZ7VE0AtfDET3WweMMKUW9iebMfPJRFf0OgH8RwPdpvmO2ZLLZw==
X-Received: by 2002:a17:90a:350d:: with SMTP id q13mr4321522pjb.20.1558645735962;
        Thu, 23 May 2019 14:08:55 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y17sm333481pfn.79.2019.05.23.14.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:08:55 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net 0/4] Allow TX timestamp with UDP GSO
Date:   Thu, 23 May 2019 14:06:47 -0700
Message-Id: <20190523210651.80902-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

Also this updates the UDP GSO selftests to optionally stress test
this condition, and report the reliability and performance of both
TX Timestamping and ZEROCOPY messages.

Fred Klassen (4):
  net/udp_gso: Allow TX timestamp with UDP GSO
  net/udpgso_bench_tx: options to exercise TX CMSG
  net/udpgso_bench_tx: fix sendmmsg on unconnected socket
  net/udpgso_bench_tx: audit error queue

 net/ipv4/udp_offload.c                        |   4 +
 tools/testing/selftests/net/udpgso_bench_tx.c | 376 ++++++++++++++++++++++++--
 2 files changed, 358 insertions(+), 22 deletions(-)

-- 
2.11.0

