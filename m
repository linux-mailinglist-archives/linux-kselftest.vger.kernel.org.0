Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED1446686
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhKEP6O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 11:58:14 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56162
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233700AbhKEP6O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 11:58:14 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 290564001A
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127733;
        bh=bkK6gTfKiBQfKNtHU6pcGHzhWJk/mu2xTUMLvC1SmhU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=uaFilYUeN9rfFMUVYquRN1HDDxnXSGdp5rSoHLlg/xV0JhkAvnHNZwyDTS7iivB7B
         aVkAsjz98Yu9mv5hIFbaaIoiqxpWsvyFY2g23SUDdPVIJrvRXXzZ8sqaELeDc9q+wR
         kD5Yaudk27M5n3Zqcdd8kRVUlHW/nMIYzNk9MEjdkPF4fDdnc95g6vs++NG1sWQM3F
         hpxMylFRRVHwzMRyXYIzZmntJM4vZgZGk71tzSDWGKgIXNvd1oNskkaSq7vvJtNnMh
         v2wG+EGPB4ra22d/Hla8zuDskqLnC9NVkZNTnZLUtosc67CzrWGDc5lIi2MwCDxnmx
         kLV4YW0aNnxUw==
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso9303759edc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 08:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bkK6gTfKiBQfKNtHU6pcGHzhWJk/mu2xTUMLvC1SmhU=;
        b=1RVheem7y1WD4XUKiT/OPDQVpwkqUnjPZYByxT3lgjqhcydd1/K1wRo67nbHm+60Sj
         GpsOylewO/MbDoA4Ql3I93fmclyjPRay7hzbFcw0PFc3qoisaOSbabW9+OV+kerMZ/cx
         qT87zvsY3cy6pYe8myIkISDj1q/LHL51++MB78cWAZgpHSIy7Z7NW4sprzvH695zq+IC
         gpUpGuR0Uwj3NneoZX5qLzN1WRwaeVU41p8poeQkrROKuQotxnyJlmtZNQemeML62nen
         +rclRPDnNxMR4kSlC2jYY3BEb083pePenfXDYjiszc+11DlaYxcJGRpjdUYCpFva58P/
         bSzQ==
X-Gm-Message-State: AOAM533Z/myIB5wtVXt/lOqAncyuCA5vBVHH/yMNOn2T0+rqlePdxVsn
        4JbHLWZfOAyPGoMhovLz5Tr4+bkp4KWNqDmhf8+ua0xeXkLfH6MLcAtmAnPh1UVggyIMjRsVhur
        AbtBqy6CpN/0QQTUGjjUp2bqGOG+1XjpmZbkvtZyegO5+vg==
X-Received: by 2002:a05:6402:40c5:: with SMTP id z5mr6193837edb.185.1636127732796;
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZv4GqWbag+7ya5gdVD8gpmI5A28DpPxkcj0fSg+twxAqfGbAq4tIApC1T7p0IYdgyFS3uLA==
X-Received: by 2002:a05:6402:40c5:: with SMTP id z5mr6193797edb.185.1636127732493;
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id c22sm1611539edy.66.2021.11.05.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:55:32 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexis Bauvin <abauvin@scaleway.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: test_vxlan_under_vrf: fix HV connectivity test
Date:   Fri,  5 Nov 2021 16:55:29 +0100
Message-Id: <20211105155529.105545-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It looks like test_vxlan_under_vrf.sh is always failing to verify the
connectivity test during the ping between the two simulated VMs.

This is due to the fact that veth-hv in each VM should have a distinct
MAC address.

Fix by setting a unique MAC address on each simulated VM interface.

Without this fix:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [FAIL]

With this fix applied:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
 Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]

NOTE: the connectivity test with the underlay VRF is still failing; it
seems that ARP requests are blocked at the simulated hypervisor level,
probably due to some missing ARP forwarding rules. This requires more
investigation (in the meantime we may consider to set that test as
expected failure - XFAIL).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/test_vxlan_under_vrf.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
index 534c8b7699ab..ea5a7a808f12 100755
--- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
+++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
@@ -101,6 +101,8 @@ setup-vm() {
     ip -netns hv-$id link set veth-tap master br0
     ip -netns hv-$id link set veth-tap up
 
+    ip link set veth-hv address 02:1d:8d:dd:0c:6$id
+
     ip link set veth-hv netns vm-$id
     ip -netns vm-$id addr add 10.0.0.$id/24 dev veth-hv
     ip -netns vm-$id link set veth-hv up
-- 
2.32.0

