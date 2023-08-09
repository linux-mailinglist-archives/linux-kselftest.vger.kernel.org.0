Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C792977600D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHIM7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjHIM7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:53 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4E1FF9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:52 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-TISae5ZfORu2KY0IuqbEdQ-1; Wed, 09 Aug 2023 08:59:30 -0400
X-MC-Unique: TISae5ZfORu2KY0IuqbEdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ADC8185A793;
        Wed,  9 Aug 2023 12:59:29 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50C792166B25;
        Wed,  9 Aug 2023 12:59:27 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH net-next v3 4/6] docs: tls: document TLS1.3 key updates
Date:   Wed,  9 Aug 2023 14:58:53 +0200
Message-Id: <9916d6a35c659d639f6f52488ceea227a523ab63.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v3: added following Jakub's comment

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/networking/tls.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 658ed3a71e1b..ea6a22eafe2b 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -200,6 +200,27 @@ received without a cmsg buffer set.
 
 recv will never return data from mixed types of TLS records.
 
+TLS 1.3 Key Updates
+-------------------
+
+In TLS 1.3, KeyUpdate handshake messages signal that the sender is
+updating its TX key. Any message sent after a KeyUpdate will be
+encrypted using the new key. The userspace library can pass the new
+key to the kernel using the TLS_TX and TLS_RX socket options, as for
+the initial keys. TLS version and cipher cannot be changed.
+
+To prevent attempting to decrypt incoming records using the wrong key,
+decryption will be paused when a KeyUpdate message is received by the
+kernel, until the new key has been provided using the TLS_RX socket
+option. Any read occurring after the KeyUpdate has been read and
+before the new key is provided will fail with EKEYEXPIRED. Poll()'ing
+the socket will also sleep until the new key is provided. There is no
+pausing on the transmit side.
+
+Userspace should make sure that the crypto_info provided has been set
+properly. In particular, the kernel will not check for key/nonce
+reuse.
+
 Integrating in to userspace TLS library
 ---------------------------------------
 
-- 
2.40.1

