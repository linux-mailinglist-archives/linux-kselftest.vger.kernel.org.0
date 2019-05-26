Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457982AA6A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 May 2019 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEZPfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 May 2019 11:35:46 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:33023 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfEZPfq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 May 2019 11:35:46 -0400
Received: by mail-pg1-f181.google.com with SMTP id h17so7678976pgv.0
        for <linux-kselftest@vger.kernel.org>; Sun, 26 May 2019 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hPbxk4I14QvxRcb7WA6V+88SxxNIE6ziYaM9tmkpMDg=;
        b=NpHXUmMimASW5WMeq0/Y94Q93wqGGhtdw8koSAxTMVAR4f8SEwMKIGCcaiin5mJfRd
         oIyGZ4ibpkvN9ycb2H//XK1UE9UqL1LdR+eTUeKOkI10vraaLaIi4JU//faiKj4iAE4E
         lO11jrY8bgczmvLKG0cxmhR5GuFihL8+FNmHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hPbxk4I14QvxRcb7WA6V+88SxxNIE6ziYaM9tmkpMDg=;
        b=Rwjq5QjnnkHUKmjbV+K6hC30VkI16V08UJdPj+Ey4A4q1MgE2KIF6+qqOwFpSNyZYh
         l5idGGTpp/ocwy9UQPTZXeyWYPtR5kpXWuBorOj2UJymiGqgeZ3W3IbY6eafgacPORA8
         TNZl9vdGyrcUMLHJv4LUKzqA/gZFTMHnMOmASWqAOOPmGFH+KaMCb6aC2PEuqzTss2uj
         qffdHotPeMv/yr+boiogd2ZYuZ9+VL3fKIa+gO4toX+aJBHXg9H3/lSf/MyTytll8gCe
         lyEjlxZKdIbF2kj+Wp2NdIoVuhlXJMDMRZsFF3lX2FYw9vB7hc2/yCzfq42In/q21X7f
         Qt2A==
X-Gm-Message-State: APjAAAVT8BWOX7HDVm1eon5Clu8sWkTp2786N9xQts2xP0aYuGMo/iks
        TIsJ38/AAubqobAU7AvZHnja6A==
X-Google-Smtp-Source: APXvYqwDryZPFz2RYGrEUOHv1Uqf5aabrlyEgg5EUT9j5DhPlCgU1mErTECPXm5sDXmY9yBB7C8bnQ==
X-Received: by 2002:a63:246:: with SMTP id 67mr121965588pgc.145.1558884945548;
        Sun, 26 May 2019 08:35:45 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y25sm10523637pfp.182.2019.05.26.08.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:35:44 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net v2 0/1] Allow TX timestamp with UDP GSO
Date:   Sun, 26 May 2019 08:33:56 -0700
Message-Id: <20190526153357.82293-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

This is version 2 which moves the tests to net-next.

Fred Klassen (1):
  net/udp_gso: Allow TX timestamp with UDP GSO

 net/ipv4/udp_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.11.0

