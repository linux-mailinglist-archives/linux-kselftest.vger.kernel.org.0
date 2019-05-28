Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD192CED6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfE1Son (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:44:43 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36888 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfE1Son (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:44:43 -0400
Received: by mail-pl1-f182.google.com with SMTP id p15so8711359pll.4
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DFjPQf88/WEdwbAZuIhMdfy4wl7j7rHm9z/e0KQ/ick=;
        b=M7uebHrMZD2HFYCwXvvZYPGRo6TZmmPcaT61c1V+suPKNemNiMOv3XkQNEEEpt6Chc
         eJmV8ECUTE/nN2/z+7ayAwjyab9hS2gqTwmwbAAsHRBRLncIXHaj69WqAnInVSjftf9k
         Fdw+bSlBm5idQeiAkvrhLLc3PHUusTXgewlqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DFjPQf88/WEdwbAZuIhMdfy4wl7j7rHm9z/e0KQ/ick=;
        b=lETjSKgEmO1RJAlEZptAycSPYugM4wQov82Re40BHrmn5zffBF+VHKx7qttr+dL666
         l9WYTUUJ6hE+d89QFvPfQhttK5sW5xw3bynXit9OlvnABIHiT1RHVnmDkk7y7G3FYdI/
         h32BPEOZpxZRDw2+TXn2C1s2fNPLGBiJtUBPPQkBEFcEkWCmhmxasp0WayDsn5eaeZ6D
         NRBzGvhA//G7+ZLCehYAu3cuENcIBJP02dM1O/O+qxDU2qz6scfDBYVbK6IpO4VvkK2Q
         QXOa418UlrRzUX6B27Uegmi/GbZs1gZlrtnuTRxpw2wWyN4lQ+Bi+anMAk0hIy4WyUMO
         R/Pw==
X-Gm-Message-State: APjAAAU57gFMlVRoBtoN0K2G5T+9nzq5lzw7aiZorVLDl7lVWe08qDLc
        vEV/ac1li5JW6FfOMSrA1ZfIRQ==
X-Google-Smtp-Source: APXvYqwK8CwFA8GFX8OZgMGUz/uu9etWgEoQtN2jsuFurBEAh1VqlXKuwiXif0AXzRc+yEI1bFtYaw==
X-Received: by 2002:a17:902:8209:: with SMTP id x9mr9499883pln.327.1559069082854;
        Tue, 28 May 2019 11:44:42 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id j72sm3534085pje.12.2019.05.28.11.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:44:42 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 0/1] Allow TX timestamp with UDP GSO
Date:   Tue, 28 May 2019 11:44:14 -0700
Message-Id: <20190528184415.16020-1-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.

Fred Klassen (1):
  net/udp_gso: Allow TX timestamp with UDP GSO

 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.11.0

