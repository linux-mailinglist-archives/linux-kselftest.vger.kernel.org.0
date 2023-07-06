Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C6749F4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGFOpO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGFOpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:45:13 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62D199F;
        Thu,  6 Jul 2023 07:45:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfDL74Rpz9xFGL;
        Thu,  6 Jul 2023 22:34:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S2;
        Thu, 06 Jul 2023 15:44:25 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, song@kernel.org, jolsa@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 00/10] KEYS: Introduce user asymmetric keys and signatures
Date:   Thu,  6 Jul 2023 16:42:13 +0200
Message-Id: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyDJFyUWrW7XryxWF13CFg_yoW3Xw15pF
        Z5KrWrtryktr1xKayrAw4Iga1rZr1Fyay3Kwnakw15AasIqr18ArWIkF45ur9ayF48WF1F
        vrsav34UKw18t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
        6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V4AAAsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Define a new TLV-based format for keys and signatures, aiming to store and
use in the kernel the crypto material from other unsupported formats
(e.g. PGP).

TLV fields have been defined to fill the corresponding kernel structures
public_key, public_key_signature and key_preparsed_payload.

Keys:
                struct public_key {     struct key_preparsed_payload {
KEY_PUB       -->  void *key;
                   u32 keylen;         --> prep->payload.data[asym_crypto]
KEY_ALGO      -->  const char *pkey_algo;
KEY_KID0
KEY_KID1                               --> prep->payload.data[asym_key_ids]
KEY_KID2  
KEY_DESC                               --> prep->description


Signatures:
                struct public_key_signature {
SIG_S         -->  u8 *s;
                   u32 s_size;
SIG_KEY_ALGO  -->  const char *pkey_algo;
SIG_HASH_ALGO -->  const char *hash_algo;
                   u32 digest_size;
SIG_ENC       -->  const char *encoding;   
SIG_KID0
SIG_KID1      -->  struct asymmetric_key_id *auth_ids[3];
SIG_KID2  


For keys, since the format conversion has to be done in user space, user
space is assumed to be trusted, in this proposal. Without this assumption,
a malicious conversion tool could make a user load to the kernel a
different key than the one expected.

That should not be a particular problem for keys that are embedded in the
kernel image and loaded at boot, since the conversion happens in a trusted
environment such as the building infrastructure of the Linux distribution
vendor.

In the other cases, such as enrolling a key through the Machine Owner Key
(MOK) mechanism, the user is responsible to ensure that the crypto material
carried in the original format remains the same after the conversion.

For signatures, assuming the strength of the crypto algorithms, altering
the crypto material is simply a Denial-of-Service (DoS), as data can be
validated only with the right signature.


This patch set also offers the following contributions:

- An API similar to the PKCS#7 one, to verify the authenticity of system
  data through user asymmetric keys and signatures

- A mechanism to store a keyring blob in the kernel image and to extract
  and load the keys at system boot
  
- eBPF binding, so that data authenticity verification with user asymmetric
  keys and signatures can be carried out also with eBPF programs

- A new command for gnupg (in user space), to convert keys and signatures
  from PGP to the new kernel format


The primary use case for this patch set is to verify the authenticity of
RPM package headers with the PGP keys of the Linux distribution. Once their
authenticity is verified, file digests can be extracted from those RPM
headers and used as reference values for IMA Appraisal.


Compared to the previous patch set, the main difference is not relying on
User Mode Drivers (UMDs) for the conversion from the original format to the
kernel format, due to the concern that full isolation of the UMD process
cannot be achieved against a fully privileged system user (root).

The discussion is still ongoing here:

https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com/

This however does not prevent the goal mentioned above of verifying the
authenticity of RPM headers to be achieved. The fact that Linux
distribution vendors do the conversion in their infrastructure is a good
enough guarantee.


A very quick way to test the patch set is to execute:

# gpg --conv-kernel /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-rawhide-primary | keyctl padd asymmetric "" @u

# keyctl show @u
Keyring
 762357580 --alswrv      0 65534  keyring: _uid.0
 567216072 --als--v      0     0   \_ asymmetric: PGP: 18b8e74c


Patches 1-2 preliminarly export some definitions to user space so that
conversion tools can specify the right public key algorithms and signature
encodings (digest algorithms are already exported).

Patches 3-5 introduce the user asymmetric keys and signatures.

Patches 6 introduces a system API for verifying the authenticity of system
data through user asymmetric keys and signatures.

Patch 7-8 introduce a mechanism to store a keyring blob with user
asymmetric keys in the kernel image, and load them at system boot.

Patches 9-10 introduce the eBPF binding and corresponding test (which can
be enabled only after the gnupg patches are upstreamed).

Patches 1-2 [GNUPG] introduce the new gpg command --conv-kernel to convert
PGP keys and signatures to the new kernel format.

Changelog

v1:
- Remove useless check in validate_key() (suggested by Yonghong)
- Don't rely on User Mode Drivers for the conversion from the original
  format to the kernel format
- Use the more extensible TLV format, instead of a fixed structure

Roberto Sassu (10):
  crypto: Export public key algorithm information
  crypto: Export signature encoding information
  KEYS: asymmetric: Introduce a parser for user asymmetric keys and sigs
  KEYS: asymmetric: Introduce the user asymmetric key parser
  KEYS: asymmetric: Introduce the user asymmetric key signature parser
  verification: Add verify_uasym_signature() and
    verify_uasym_sig_message()
  KEYS: asymmetric: Preload user asymmetric keys from a keyring blob
  KEYS: Introduce load_uasym_keyring()
  bpf: Introduce bpf_verify_uasym_signature() kfunc
  selftests/bpf: Prepare a test for user asymmetric key signatures

 MAINTAINERS                                   |   1 +
 certs/Kconfig                                 |  11 +
 certs/Makefile                                |   7 +
 certs/system_certificates.S                   |  18 +
 certs/system_keyring.c                        | 166 +++++-
 crypto/Kconfig                                |   6 +
 crypto/Makefile                               |   2 +
 crypto/asymmetric_keys/Kconfig                |  14 +
 crypto/asymmetric_keys/Makefile               |  10 +
 crypto/asymmetric_keys/asymmetric_type.c      |   3 +-
 crypto/asymmetric_keys/uasym_key_parser.c     | 229 ++++++++
 crypto/asymmetric_keys/uasym_key_preload.c    |  99 ++++
 crypto/asymmetric_keys/uasym_parser.c         | 201 +++++++
 crypto/asymmetric_keys/uasym_parser.h         |  43 ++
 crypto/asymmetric_keys/uasym_sig_parser.c     | 491 ++++++++++++++++++
 crypto/pub_key_info.c                         |  20 +
 crypto/sig_enc_info.c                         |  16 +
 include/crypto/pub_key_info.h                 |  15 +
 include/crypto/sig_enc_info.h                 |  15 +
 include/crypto/uasym_keys_sigs.h              |  82 +++
 include/keys/asymmetric-type.h                |   1 +
 include/linux/verification.h                  |  50 ++
 include/uapi/linux/pub_key_info.h             |  22 +
 include/uapi/linux/sig_enc_info.h             |  18 +
 include/uapi/linux/uasym_parser.h             | 107 ++++
 kernel/trace/bpf_trace.c                      |  68 ++-
 ...y_pkcs7_sig.c => verify_pkcs7_uasym_sig.c} | 159 +++++-
 ...s7_sig.c => test_verify_pkcs7_uasym_sig.c} |  18 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  82 ++-
 29 files changed, 1924 insertions(+), 50 deletions(-)
 create mode 100644 crypto/asymmetric_keys/uasym_key_parser.c
 create mode 100644 crypto/asymmetric_keys/uasym_key_preload.c
 create mode 100644 crypto/asymmetric_keys/uasym_parser.c
 create mode 100644 crypto/asymmetric_keys/uasym_parser.h
 create mode 100644 crypto/asymmetric_keys/uasym_sig_parser.c
 create mode 100644 crypto/pub_key_info.c
 create mode 100644 crypto/sig_enc_info.c
 create mode 100644 include/crypto/pub_key_info.h
 create mode 100644 include/crypto/sig_enc_info.h
 create mode 100644 include/crypto/uasym_keys_sigs.h
 create mode 100644 include/uapi/linux/pub_key_info.h
 create mode 100644 include/uapi/linux/sig_enc_info.h
 create mode 100644 include/uapi/linux/uasym_parser.h
 rename tools/testing/selftests/bpf/prog_tests/{verify_pkcs7_sig.c => verify_pkcs7_uasym_sig.c} (69%)
 rename tools/testing/selftests/bpf/progs/{test_verify_pkcs7_sig.c => test_verify_pkcs7_uasym_sig.c} (82%)

-- 
2.34.1

