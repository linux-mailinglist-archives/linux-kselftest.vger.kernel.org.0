Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2323776004
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjHIM71 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjHIM70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:26 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D681FF5
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:25 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-VfHXE0NLNFKdLa8hkAYfpA-1; Wed, 09 Aug 2023 08:59:21 -0400
X-MC-Unique: VfHXE0NLNFKdLa8hkAYfpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B873F38008B4;
        Wed,  9 Aug 2023 12:59:20 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 561452166B25;
        Wed,  9 Aug 2023 12:59:18 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/6] tls: implement key updates for TLS1.3
Date:   Wed,  9 Aug 2023 14:58:49 +0200
Message-Id: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds support for receiving KeyUpdate messages (RFC 8446, 4.6.3
[1]). A sender transmits a KeyUpdate message and then changes its TX
key. The receiver should react by updating its RX key before
processing the next message.

This patchset implements key updates by:
 1. pausing decryption when a KeyUpdate message is received, to avoid
    attempting to use the old key to decrypt a record encrypted with
    the new key
 2. returning -EKEYEXPIRED to syscalls that cannot receive the
    KeyUpdate message, until the rekey has been performed by userspace
 3. passing the KeyUpdate message to userspace as a control message
 4. allowing updates of the crypto_info via the TLS_TX/TLS_RX
    setsockopts

This API has been tested with gnutls to make sure that it allows
userspace libraries to implement key updates [2]. Thanks to Frantisek
Krenzelok <fkrenzel@redhat.com> for providing the implementation in
gnutls and testing the kernel patches.


=======================================================================
Discussions around v2 of this patchset focused on how HW offload would
interact with rekey.

RX
 - The existing SW path will handle all records between the KeyUpdate
   message signaling the change of key and the new key becoming known
   to the kernel -- those will be queued encrypted, and decrypted in
   SW as they are read by userspace (once the key is provided, ie same
   as this patchset)
 - Call ->tls_dev_del + ->tls_dev_add immediately during
   setsockopt(TLS_RX)

TX
 - After setsockopt(TLS_TX), switch to the existing SW path (not the
   current device_fallback) until we're able to re-enable HW offload
   - tls_device_sendmsg will call into tls_sw_sendmsg under lock_sock
     to avoid changing socket ops during the rekey while another
     thread might be waiting on the lock
 - We only re-enable HW offload (call ->tls_dev_add to install the new
   key in HW) once all records sent with the old key have been
   ACKed. At this point, all unacked records are SW-encrypted with the
   new key, and the old key is unused by both HW and retransmissions.
   - If there are no unacked records when userspace does
     setsockopt(TLS_TX), we can (try to) install the new key in HW
     immediately.
   - If yet another key has been provided via setsockopt(TLS_TX), we
     don't install intermediate keys, only the latest.
   - TCP notifies ktls of ACKs via the icsk_clean_acked callback. In
     case of a rekey, tls_icsk_clean_acked will record when all data
     sent with the most recent past key has been sent. The next call
     to sendmsg will install the new key in HW.
   - We close and push the current SW record before reenabling
     offload.

If ->tls_dev_add fails to install the new key in HW, we stay in SW
mode. We can add a counter to keep track of this.


In addition:

Because we can't change socket ops during a rekey, we'll also have to
modify do_tls_setsockopt_conf to check ctx->tx_conf and only call
either tls_set_device_offload or tls_set_sw_offload. RX already uses
the same ops for both TLS_HW and TLS_SW, so we could switch between HW
and SW mode on rekey.

An alternative would be to have a common sendmsg which locks
the socket and then calls the correct implementation. We'll need that
anyway for the offload under rekey case, so that would only add a test
to the SW path's ops (compared to the current code). That should allow
us to simplify build_protos a bit, but might have a performance
impact - we'll need to check it if we want to go that route.
=======================================================================

Note: in a future series, I'll clean up tls_set_sw_offload and
eliminate the per-cipher copy-paste using tls_cipher_size_desc.

[1] https://www.rfc-editor.org/rfc/rfc8446#section-4.6.3
[2] https://gitlab.com/gnutls/gnutls/-/merge_requests/1625

Sabrina Dubroca (6):
  tls: remove tls_context argument from tls_set_sw_offload
  tls: block decryption when a rekey is pending
  tls: implement rekey for TLS1.3
  docs: tls: document TLS1.3 key updates
  selftests: tls: add key_generation argument to tls_crypto_info_init
  selftests: tls: add rekey tests

 Documentation/networking/tls.rst  |  21 ++
 include/net/tls.h                 |   3 +
 net/tls/tls.h                     |   3 +-
 net/tls/tls_device.c              |   2 +-
 net/tls/tls_main.c                |  47 ++-
 net/tls/tls_sw.c                  | 184 +++++++++---
 tools/testing/selftests/net/tls.c | 466 +++++++++++++++++++++++++++++-
 7 files changed, 661 insertions(+), 65 deletions(-)

-- 
2.40.1

