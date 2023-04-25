Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930586EE6EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjDYRiD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:38:01 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5CC14466;
        Tue, 25 Apr 2023 10:37:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TVP5nkMz9v7GZ;
        Wed, 26 Apr 2023 01:28:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S2;
        Tue, 25 Apr 2023 18:37:28 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/6] KEYS: Introduce user mode key and signature parsers
Date:   Tue, 25 Apr 2023 19:35:51 +0200
Message-Id: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8Wr1xAFW7Zr1kCF18Grg_yoWxKF48pF
        ZYgryftFyktryIkan3Aw4xWw45Zr1kAw43Wwn3Jr1ruasIqr1xArWIkF43WF9xKryxZryY
        vr42q3W5twnYya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
        F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
        kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
        xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU0FdgtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBF1jj4iAFwAAs6
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Goals
=====

Support new key and signature formats with the same kernel component.

Verify the authenticity of system data with newly supported data formats.

Mitigate the risk of parsing arbitrary data in the kernel.


Motivation
==========

Adding new functionality to the kernel comes with an increased risk of
introducing new bugs which, once exploited, can lead to a partial or full
system compromise.

Parsing arbitrary data is particularly critical, since it allows an
attacker to send a malicious sequence of bytes to exploit vulnerabilities
in the parser code. The attacker might be able to overwrite kernel memory
to bypass kernel protections, and obtain more privileges.

User Mode Drivers (UMDs) can effectively mitigate this risk. If the parser
runs in user space, even if it has a bug, it won't allow the attacker to
overwrite kernel memory.

The communication protocol between the UMD and the kernel should be simple
enough, that the kernel can immediately recognize malformed data sent by an
attacker controlling the UMD, and discard it.


Solution
========

Register a new parser of the asymmetric key type which, instead of parsing
the key blob, forwards it to a UMD, and populates the key fields from the
UMD response. That response contains the data for each field of the public
key structure, defined in the kernel, and possibly a key description.

Supporting new data formats can be achieved by simply extending the UMD. As
long as the UMD recognizes them, and provides the crypto material to the
kernel Crypto API in the expected format, the kernel does not need to be
aware of the UMD changes.

Add a new API to verify the authenticity of system data, similar to the one
for PKCS#7 signatures. As for the key parser, send the signature to a UMD,
and fill the public_key_signature structure from the UMD response.

The API still supports a very basic trust model, it accepts a key for
signature verification if it is in the supplied keyring. The API can be
extended later to support more sophisticated models.


Use cases
=========

eBPF
----

The eBPF infrastructure already offers to eBPF programs the ability to
verify PKCS#7 signatures, through the bpf_verify_pkcs7_signature() kfunc.

Add the new bpf_verify_umd_signature() kfunc, to allow eBPF programs verify
signatures in a data format that is not PKCS#7 (for example PGP).


IMA Appraisal
-------------

An alternative to appraising each file with its signature (Fedora 38) is to
build a repository of reference file digests from signed RPM headers, and
lookup the calculated digest of files being accessed in that repository
(DIGLIM[1]).

With this patch set, the kernel can verify the authenticity of RPM headers
from their PGP signature against the Linux distribution GPG keys. Once
verified, RPM headers can be parsed with a UMD to build the repository of
reference file digests.

With DIGLIM, Linux distributions are not required to change anything in
their building infrastructure (no extra data in the RPM header, no new PKI
for IMA signatures).

[1]: https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/


UMD development
===============

The header file crypto/asymmetric_keys/umd_key_sig_umh.h contains the
details of the communication protocol between the kernel and the UMD
handler.

The UMD handler should implement the commands defined, CMD_KEY and CMD_SIG,
should set the result of the processing, and fill the key and
signature-specific structures umd_key_msg_out and umd_sig_msg_out.

The UMD handler should provide the key and signature blobs in a format that
is understood by the kernel. For example, for RSA keys, it should provide
them in ASN.1 format (SEQUENCE of INTEGER).

The auth IDs of the keys and signatures should match, for signature
verification. Auth ID matching can be partial.


Patch set dependencies
======================

This patch set depends on 'usermode_driver: Add management library and
API':

https://lore.kernel.org/bpf/20230317145240.363908-1-roberto.sassu@huaweicloud.com/


Patch set content
=================

Patch 1 introduces the new parser for the asymmetric key type.

Patch 2 introduces the parser for signatures and its API.

Patch 3 introduces the system-level API for signature verification.

Patch 4 extends eBPF to use the new system-level API.

Patch 5 adds a test for UMD-parser signatures (not executed until the UMD
supports PGP).

Patch 6 introduces the skeleton of the UMD handler.


PGP
===

A work in progress implementation of the PGP format (RFC 4880 and RFC 6637)
in the UMD handler is available at:

https://github.com/robertosassu/linux/commits/pgp-signatures-umd-v1-devel-v24

It is based on a previous work of David Howells, available at:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-modsign.git/log/?h=pgp-parser

The patches have been adapted for use in user space.

Roberto Sassu (6):
  KEYS: asymmetric: Introduce UMD-based asymmetric key parser
  KEYS: asymmetric: Introduce UMD-based asymmetric key signature parser
  verification: Introduce verify_umd_signature() and
    verify_umd_message_sig()
  bpf: Introduce bpf_verify_umd_signature() kfunc
  selftests/bpf: Prepare a test for UMD-parsed signatures
  KEYS: asymmetric: Add UMD handler

 .gitignore                                    |   3 +
 MAINTAINERS                                   |   1 +
 certs/system_keyring.c                        | 125 ++++++
 crypto/asymmetric_keys/Kconfig                |  32 ++
 crypto/asymmetric_keys/Makefile               |  23 +
 crypto/asymmetric_keys/asymmetric_type.c      |   3 +-
 crypto/asymmetric_keys/umd_key.h              |  28 ++
 crypto/asymmetric_keys/umd_key_parser.c       | 203 +++++++++
 crypto/asymmetric_keys/umd_key_sig_loader.c   |  32 ++
 crypto/asymmetric_keys/umd_key_sig_umh.h      |  71 +++
 crypto/asymmetric_keys/umd_key_sig_umh_blob.S |   7 +
 crypto/asymmetric_keys/umd_key_sig_umh_user.c |  84 ++++
 crypto/asymmetric_keys/umd_sig_parser.c       | 416 ++++++++++++++++++
 include/crypto/umd_sig.h                      |  71 +++
 include/keys/asymmetric-type.h                |   1 +
 include/linux/verification.h                  |  48 ++
 kernel/trace/bpf_trace.c                      |  69 ++-
 ...ify_pkcs7_sig.c => verify_pkcs7_umd_sig.c} | 109 +++--
 ...kcs7_sig.c => test_verify_pkcs7_umd_sig.c} |  18 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  82 +++-
 20 files changed, 1378 insertions(+), 48 deletions(-)
 create mode 100644 crypto/asymmetric_keys/umd_key.h
 create mode 100644 crypto/asymmetric_keys/umd_key_parser.c
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_loader.c
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh.h
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh_blob.S
 create mode 100644 crypto/asymmetric_keys/umd_key_sig_umh_user.c
 create mode 100644 crypto/asymmetric_keys/umd_sig_parser.c
 create mode 100644 include/crypto/umd_sig.h
 rename tools/testing/selftests/bpf/prog_tests/{verify_pkcs7_sig.c => verify_pkcs7_umd_sig.c} (75%)
 rename tools/testing/selftests/bpf/progs/{test_verify_pkcs7_sig.c => test_verify_pkcs7_umd_sig.c} (82%)

-- 
2.25.1

