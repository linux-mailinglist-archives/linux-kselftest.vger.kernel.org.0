Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A806568863
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiGFMdU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGFMdT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 08:33:19 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 05:33:17 PDT
Received: from mailout-taastrup.gigahost.dk (mailout-taastrup.gigahost.dk [46.183.139.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBCA26ACC;
        Wed,  6 Jul 2022 05:33:17 -0700 (PDT)
Received: from mailout.gigahost.dk (mailout.gigahost.dk [89.186.169.112])
        by mailout-taastrup.gigahost.dk (Postfix) with ESMTP id 3165A18864BD;
        Wed,  6 Jul 2022 12:25:31 +0000 (UTC)
Received: from smtp.gigahost.dk (smtp.gigahost.dk [89.186.169.109])
        by mailout.gigahost.dk (Postfix) with ESMTP id 27ACE25032B8;
        Wed,  6 Jul 2022 12:25:31 +0000 (UTC)
Received: by smtp.gigahost.dk (Postfix, from userid 1000)
        id 1F97F9120FED; Wed,  6 Jul 2022 12:25:31 +0000 (UTC)
X-Screener-Id: 413d8c6ce5bf6eab4824d0abaab02863e8e3f662
Received: from wse-c0127.vestervang (unknown [208.127.141.28])
        by smtp.gigahost.dk (Postfix) with ESMTPSA id A337C9120FED;
        Wed,  6 Jul 2022 12:25:29 +0000 (UTC)
From:   Hans Schultz <netdev@kapio-technology.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Hans Schultz <netdev@kapio-technology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org, linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/1] net: dsa: mv88e6xxx: allow reading FID when handling ATU violations
Date:   Wed,  6 Jul 2022 14:25:02 +0200
Message-Id: <20220706122502.1521819-1-netdev@kapio-technology.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Westermo Network Technologies AB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For convenience the function mv88e6xxx_g1_atu_op() has been used to read
ATU violations, but the function has other purposes and does not enable
the possibility to read the FID when reading ATU violations.

The FID is needed to get hold of which VID was involved in the violation,
thus the need for future purposes to be able to read the FID.

Signed-off-by: Hans Schultz <netdev@kapio-technology.com>
---
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index 40bd67a5c8e9..5d120d53823c 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -114,6 +114,19 @@ static int mv88e6xxx_g1_atu_op_wait(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_ATU_OP, bit, 0);
 }
 
+static int mv88e6xxx_g1_read_atu_violation(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_ATU_OP,
+				 MV88E6XXX_G1_ATU_OP_BUSY |
+				 MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_atu_op_wait(chip);
+}
+
 static int mv88e6xxx_g1_atu_op(struct mv88e6xxx_chip *chip, u16 fid, u16 op)
 {
 	u16 val;
@@ -359,8 +372,7 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
 
 	mv88e6xxx_reg_lock(chip);
 
-	err = mv88e6xxx_g1_atu_op(chip, 0,
-				  MV88E6XXX_G1_ATU_OP_GET_CLR_VIOLATION);
+	err = mv88e6xxx_g1_read_atu_violation(chip);
 	if (err)
 		goto out;
 
-- 
2.30.2

