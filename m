Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553516CF349
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjC2Tku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjC2Tkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:36 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC2B61AB;
        Wed, 29 Mar 2023 12:40:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CDF553200970;
        Wed, 29 Mar 2023 15:40:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 Mar 2023 15:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1680118823; x=
        1680205223; bh=2f5rYYd0tlnULsG95qckYDb8lBBCrzn8vdFiBpBskrI=; b=N
        DjnjQioxravOwTiq91yztIm1lN0V9CX2/jADRcbJ0ZBkr1M3tjp4dX2usXG0fqqO
        iE3NCrxJo9xTBxLpPz5Q8fu/JAvKIW6qh1MyRpgHq3Qb8I62YYWvmDUAb9ppl/Tr
        da2o0XYqOHVspIWsEIhxvsKzS2sbD9aNWZRXa9aXDGOMLXH0Xg9vjhds8XyzvOvz
        4b3QZPpEHmEzDK9TX+7oZk2TkiieeZtpKvO9WYHQkryrhfsP37nckakRoJm1mA5z
        il1gpuaVrkav/wX8FiKyKs2BW3M/0guY13wWu+0NrEmTz2pYHw8Yd8Y0Gz9g6kmW
        lMRTzkFZ2IbPNwF+alGrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680118823; x=1680205223; bh=2
        f5rYYd0tlnULsG95qckYDb8lBBCrzn8vdFiBpBskrI=; b=uyB+3G5WVug9wiQJ3
        wBmGqvwq1Y0nG2zLdy4Z3EIeQihQQOAgDKTDzX3RjCUzV0VKfe54cb+B6mAS1Am7
        ZG8ZVDgtSX6gwpb5lsg5llXoSOoq7USDKl/pV6ERmaRCjEMzRjCAbbH405I1FktX
        rp8IxJBak3RTt+urxRVtP3Siq2fcpHPB7/rzvfwsTW0mTg0ZnHpeAQNa8d66zPjT
        gSC/lVFbxqfgtJfIyad9Jb7LBk++DJe9WG8xL6HhZ5Az79fHRRbANyfjJ9aTSuRV
        rafkyUyyPsdQ9EvSqZBbmB6QBsFhq1V7gZz/96lKsMuVTqBdPg9S2I0Yn5HWGQ4L
        bGHaA==
X-ME-Sender: <xms:JpQkZGzyIa-0p9vkfrKzBA7g35Hqhmj9O6e5mcLDQOt0y2HTL9So3A>
    <xme:JpQkZCRcx3yAR-BIjSWTYAXUv-GuYxAT5wA-zFOQtCJ-c17ZQPsZZ1iSqN7F9bMsF
    dY9IA5BF2zeCEm6NTM>
X-ME-Received: <xmr:JpQkZIXrOl5Wmd2JYt_pK7e-mksVS6NOWOH3RxjaPVPCbRU0rMW4LFT0Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefguedtjedvieehffevteeijedthfelkeelffehjedthfekheefkeegvdeg
    iedttdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:J5QkZMgxL8izbKF8nGUmKh1mt7hbfsQJgL2AYiOl8es9yHR3chcacA>
    <xmx:J5QkZICmdTNUYyx1xSbgIhzBBQqfdIhgC05SdK9IU5pECanLpnHrcA>
    <xmx:J5QkZNKAlZvITFUF3RZkoxbjvkSCE8fs7j_Yz0oeZww03kNySKjITA>
    <xmx:J5QkZK3K4L_UabzWMmU4eVFjyjYQenu99BwPWpdtEDnCYxnVwcc_fg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:40:22 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Date:   Wed, 29 Mar 2023 20:38:30 +0100
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALaTJGQC/x3NwQ6CMBCE4Vche3aTUoJGX8V4KO0oG3Ex3UJIC
 O9u4/Gfwzc7GbLA6NbslLGKyaw12lNDcQz6AkuqTd75znX+yu9FpXDC+mHROKuJFWisBhdY4R5
 9uCTX4uwSVWUIBh5y0DhWR5dpquM34ynb//b+OI4fTB2fkoYAAAA=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=JFmIiuIgbQg8/mhZab8A/LJP1D9dGdFGvbtghkhMhpU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCkqk3dtrFtfvGp912q5/0vkI/UYvZ5utz1z7nXwo9r3T
 GsidetrOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCRShWGn4yJqmYmgmHMDaLX
 Q59V1x/4KHmE/ZHxHbXw+jOM+x4/Oc7I0NtytSArOXHlYwc7xUNxq39a8d95b1MszJ63Qlc6f90
 eBgA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This follows the discussion here:
https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/

This shows a couple of inconsistencies with regard to how device-managed
resources are cleaned up. Basically, devm resources will only be cleaned up
if the device is attached to a bus and bound to a driver. Failing any of
these cases, a call to device_unregister will not end up in the devm
resources being released.

We had to work around it in DRM to provide helpers to create a device for
kunit tests, but the current discussion around creating similar, generic,
helpers for kunit resumed interest in fixing this.

This can be tested using the command:
./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
Maxime Ripard (2):
      drivers: base: Add basic devm tests for root devices
      drivers: base: Add basic devm tests for platform devices

 drivers/base/test/.kunitconfig           |   2 +
 drivers/base/test/Kconfig                |   4 +
 drivers/base/test/Makefile               |   3 +
 drivers/base/test/platform-device-test.c | 278 +++++++++++++++++++++++++++++++
 drivers/base/test/root-device-test.c     | 120 +++++++++++++
 5 files changed, 407 insertions(+)
---
base-commit: a6faf7ea9fcb7267d06116d4188947f26e00e57e
change-id: 20230329-kunit-devm-inconsistencies-test-5e5a7d01e60d

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>

