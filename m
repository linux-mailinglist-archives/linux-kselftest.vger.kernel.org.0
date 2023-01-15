Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5666B2D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjAORUU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAORUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D81041B;
        Sun, 15 Jan 2023 09:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC04F60D45;
        Sun, 15 Jan 2023 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD13FC433D2;
        Sun, 15 Jan 2023 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673803217;
        bh=TUClU7MhVIDzhudSWfpm5tVQkQhg3XRHR48H4v4+mOY=;
        h=Subject:From:To:Cc:Date:From;
        b=ZWJ76xLceaAfdhaMDqnuNzTOX6U/Z64Jcv5nxzwyR/dzSOZg3x/6rQ9e2/nKW3wsy
         ExgWAn6W181T2cSwGeeoyINTH3EcuMPzfhtoZxDamMHVxMDQdqFiXHeACHFIxhtcYF
         rvZkN5TUROzXPVuwMvHDZHk4yh655pZ08aKiCzIqI0PdYxCdQ8qTcVIXfKw/LWthXD
         ARDT8r1FD/SACnn+X5IS9vI+5Ov6h46yLsYNLpHYEbTeBfLim1ZRfqLqil2R+ileIK
         5Dr8D0Te1qPTI73t//+PxWnw9XMtQnHuYdFHwm90iSJYP3AdGy2sKOEfVoZ8Gdt6ty
         qdYyQ2WWGaK1g==
Subject: [PATCH v2 00/41] RPCSEC GSS krb5 enhancements
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com,
        linux-kselftest@vger.kernel.org
Date:   Sun, 15 Jan 2023 12:20:15 -0500
Message-ID: <167380196429.10651.4103075913257868035.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The purpose of this series is to improve/harden the security
provided by the Linux kernel's RPCSEC GSS Kerberos 5 mechanism.
There are lots of clean-ups in this series, but the pertinent
feature is the addition of a clean deprecation path for the DES-
and SHA1-based encryption types in accordance with Internet BCPs.

This series disables DES-based enctypes by default, provides a
mechanism for disabling SHA1-based enctypes, and introduces two
modern enctypes that do not use deprecated crypto algorithms.

Not only does that improve security for Kerberos 5 users, but it
also prepares SunRPC for eventually switching to a shared common
kernel Kerberos 5 implementation, which surely will not implement
any deprecated encryption types (in particular, DES-based ones).

Today, MIT supports both of the newly-introduced enctypes, but
Heimdal does not appear to. Thus distributions can enable and
disable kernel enctype support to match the set of enctypes
supported in their user space Kerberos libraries.

Scott has been kicking the tires -- we've found no regressions with
the current SHA1-based enctypes, while the new ones are disabled by
default until we have an opportunity for interop testing. The KUnit
tests for the new enctypes pass and this implementation successfully
interoperates with itself using these enctypes. Therefore I believe
it to be safe to merge.

When this series gets merged, the Linux NFS community should select
and announce a date-certain for removal of SunRPC's DES-based
enctype code.

---

Changes since v1:
- Addressed Simo's NAK on "SUNRPC: Improve Kerberos confounder generation"
- Added Cc: linux-kselftest@ for review of the KUnit-related patches


Chuck Lever (41):
      SUNRPC: Add header ifdefs to linux/sunrpc/gss_krb5.h
      SUNRPC: Remove .blocksize field from struct gss_krb5_enctype
      SUNRPC: Remove .conflen field from struct gss_krb5_enctype
      SUNRPC: Improve Kerberos confounder generation
      SUNRPC: Obscure Kerberos session key
      SUNRPC: Refactor set-up for aux_cipher
      SUNRPC: Obscure Kerberos encryption keys
      SUNRPC: Obscure Kerberos signing keys
      SUNRPC: Obscure Kerberos integrity keys
      SUNRPC: Refactor the GSS-API Per Message calls in the Kerberos mechanism
      SUNRPC: Remove another switch on ctx->enctype
      SUNRPC: Add /proc/net/rpc/gss_krb5_enctypes file
      NFSD: Replace /proc/fs/nfsd/supported_krb5_enctypes with a symlink
      SUNRPC: Replace KRB5_SUPPORTED_ENCTYPES macro
      SUNRPC: Enable rpcsec_gss_krb5.ko to be built without CRYPTO_DES
      SUNRPC: Remove ->encrypt and ->decrypt methods from struct gss_krb5_enctype
      SUNRPC: Rename .encrypt_v2 and .decrypt_v2 methods
      SUNRPC: Hoist KDF into struct gss_krb5_enctype
      SUNRPC: Clean up cipher set up for v1 encryption types
      SUNRPC: Parametrize the key length passed to context_v2_alloc_cipher()
      SUNRPC: Add new subkey length fields
      SUNRPC: Refactor CBC with CTS into helpers
      SUNRPC: Add gk5e definitions for RFC 8009 encryption types
      SUNRPC: Add KDF-HMAC-SHA2
      SUNRPC: Add RFC 8009 encryption and decryption functions
      SUNRPC: Advertise support for RFC 8009 encryption types
      SUNRPC: Support the Camellia enctypes
      SUNRPC: Add KDF_FEEDBACK_CMAC
      SUNRPC: Advertise support for the Camellia encryption types
      SUNRPC: Move remaining internal definitions to gss_krb5_internal.h
      SUNRPC: Add KUnit tests for rpcsec_krb5.ko
      SUNRPC: Export get_gss_krb5_enctype()
      SUNRPC: Add KUnit tests RFC 3961 Key Derivation
      SUNRPC: Add Kunit tests for RFC 3962-defined encryption/decryption
      SUNRPC: Add KDF KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add checksum KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add encryption KUnit tests for the RFC 6803 encryption types
      SUNRPC: Add KDF-HMAC-SHA2 Kunit tests
      SUNRPC: Add RFC 8009 checksum KUnit tests
      SUNRPC: Add RFC 8009 encryption KUnit tests
      SUNRPC: Add encryption self-tests


 fs/nfsd/nfsctl.c                         |   74 +-
 include/linux/sunrpc/gss_krb5.h          |  196 +--
 include/linux/sunrpc/gss_krb5_enctypes.h |   41 -
 net/sunrpc/.kunitconfig                  |   30 +
 net/sunrpc/Kconfig                       |   96 +-
 net/sunrpc/auth_gss/Makefile             |    2 +
 net/sunrpc/auth_gss/auth_gss.c           |   17 +
 net/sunrpc/auth_gss/gss_krb5_crypto.c    |  656 +++++--
 net/sunrpc/auth_gss/gss_krb5_internal.h  |  232 +++
 net/sunrpc/auth_gss/gss_krb5_keys.c      |  416 ++++-
 net/sunrpc/auth_gss/gss_krb5_mech.c      |  730 +++++---
 net/sunrpc/auth_gss/gss_krb5_seal.c      |  122 +-
 net/sunrpc/auth_gss/gss_krb5_seqnum.c    |    2 +
 net/sunrpc/auth_gss/gss_krb5_test.c      | 2040 ++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_unseal.c    |   63 +-
 net/sunrpc/auth_gss/gss_krb5_wrap.c      |  124 +-
 net/sunrpc/auth_gss/svcauth_gss.c        |   65 +
 17 files changed, 4001 insertions(+), 905 deletions(-)
 delete mode 100644 include/linux/sunrpc/gss_krb5_enctypes.h
 create mode 100644 net/sunrpc/.kunitconfig
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_test.c

--
Chuck Lever

