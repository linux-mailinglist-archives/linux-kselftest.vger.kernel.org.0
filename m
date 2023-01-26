Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2767D23C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAZQ5K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 11:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjAZQ5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 11:57:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F1ECA28
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 08:57:08 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1AD6B3FFED
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674752227;
        bh=AqdG7g/ZZSZ4pNA8kNsOLtm4cZ2nj059acclO2QHloQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DclGZmfeAPz6NdPSTdjaoTnOHdAEMhU8ymwJKe4dVhqKTbNpq6/CVGpCG0TcFUx03
         1kWAakKEpUqev/VKc23Q6+ZQMM0d+xIzTbtkfUzk5VRK/WZAYcwDLabyrkSCpMbOrK
         MZ/ObcgZLGHWr7CIah1tvdy4cCI0tInZZeg0ojCFEcDS/xeYQgwkb3bh9K/Hwe8WE5
         YIFnTuxnpTOA2wkGu65urwlcKsh/Yk4tZWZEzUmUt14OZ1RRt9+32u+Mw4vlFFK2l+
         Gw4Ih2JusAHeFEUod/B61r1PfZD1awIDhJjvx+fjJgDvAynKMHbSlkVP2tsjb2OSs4
         LjcAgL3qQX5Mw==
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so3121620wmb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 08:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqdG7g/ZZSZ4pNA8kNsOLtm4cZ2nj059acclO2QHloQ=;
        b=Rv9k+S1DL9JZaBA0ngFgz+DvjlX8/DPWC+sxCPkHjshXa3EHIgAyYZ7Kfp45h9j/Zq
         9bzSkyGR6EmGteyVgMkZzy70KbHAyed+TTHhU+ztBX7Z8sVwdndd6PDP+0jypiWeQiI1
         g1xVKAvr62IBl4zr9iS9oLZw+8y+jQUN+zef9fpug7AVQphi3cpCfgW+FG62F8RVktT8
         Qd2JO5gEPDxi1IrUjbId4r6rRNe+I7sIhwU7DIgJn+SYFT1sa8BI0sYmr9fWQZNFzZOq
         62garzF5a9zfBe1kNOyA5muwsHpGpZlz4PVXaC+pHw5a5Y/Jnz7nt5IoP+jwjfs/ec21
         cltw==
X-Gm-Message-State: AO0yUKXcBKduiXC4QCe9TjThiCoVZ1uw0ubD/LuBemNK2U28YqkbytKr
        9Lb18JGwZIYiwPhn/Wx+C4AXoCZ/p+U3mARyCKpOlkUJmkWBlodmnOoYPD1qYuDNAgQPovLI9i2
        mYiPBVrlBUPXxsB0PRdoAaCV61Mtg17GjNQSqJ9GGD/orPg==
X-Received: by 2002:a5d:4578:0:b0:2bf:c725:85 with SMTP id a24-20020a5d4578000000b002bfc7250085mr2088197wrc.12.1674752226311;
        Thu, 26 Jan 2023 08:57:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+6H2kfXMT7ftWtKu40YIJWufbyLiNwAPLxiuN+FJ6q9L1RwkmEUjFPqgtZSaO3tmoiBUHB5w==
X-Received: by 2002:a5d:4578:0:b0:2bf:c725:85 with SMTP id a24-20020a5d4578000000b002bfc7250085mr2088187wrc.12.1674752226168;
        Thu, 26 Jan 2023 08:57:06 -0800 (PST)
Received: from qwirkle.internal ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002bdc39849d1sm1701946wrx.44.2023.01.26.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:57:05 -0800 (PST)
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Andrei Gherzan <andrei.gherzan@canonical.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: Improve IPV6_TCLASS/IPV6_HOPLIMIT tests apparmor compatibility
Date:   Thu, 26 Jan 2023 16:55:48 +0000
Message-Id: <20230126165548.230453-1-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"tcpdump" is used to capture traffic in these tests while using a random,
temporary and not suffixed file for it. This can interfere with apparmor
configuration where the tool is only allowed to read from files with
'known' extensions.

The MINE type application/vnd.tcpdump.pcap was registered with IANA for
pcap files and .pcap is the extension that is both most common but also
aligned with standard apparmor configurations. See TCPDUMP(8) for more
details.

This improves compatibility with standard apparmor configurations by
using ".pcap" as the file extension for the tests' temporary files.

Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 tools/testing/selftests/net/cmsg_ipv6.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index 2d89cb0ad288..330d0b1ceced 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -6,7 +6,7 @@ ksft_skip=4
 NS=ns
 IP6=2001:db8:1::1/64
 TGT6=2001:db8:1::2
-TMPF=`mktemp`
+TMPF=$(mktemp --suffix ".pcap")
 
 cleanup()
 {
-- 
2.34.1

