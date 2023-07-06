Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57563749FAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjGFOtm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGFOt1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:49:27 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25E26A9;
        Thu,  6 Jul 2023 07:48:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfJG0Rkpz9xFGh;
        Thu,  6 Jul 2023 22:37:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S13;
        Thu, 06 Jul 2023 15:47:47 +0100 (CET)
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
Subject: [RFC][GNUPG][PATCH 1/2] Convert PGP keys to the user asymmetric keys format
Date:   Thu,  6 Jul 2023 16:42:24 +0200
Message-Id: <20230706144225.1046544-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S13
X-Coremail-Antispam: 1UD129KBjvAXoWfJFyrJF4kCrW8Kr4rJF1fJFb_yoW8GF4fCo
        WfWa1rJw15GF47Zws09r17Xa47XrnagrZrJw4fArWDZa1vyry5ta47Aa4fJ3y5Cr4F9r13
        XFyftrWSkrs7tFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
        67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wr
        v_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZE
        Xa7IU0sqXPUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4vZ8QAAse
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

Introduce the new gpg command --conv-kernel, to convert PGP keys to the
user asymmetric keys format.

The --export command cannot be used, as it would not allow to convert
signatures from a file.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 configure.ac      |   7 ++
 doc/gpg.texi      |   4 +
 g10/Makefile.am   |   4 +
 g10/conv-packet.c | 287 ++++++++++++++++++++++++++++++++++++++++++++++
 g10/conv-packet.h |  37 ++++++
 g10/gpg.c         |  15 ++-
 g10/mainproc.c    |  17 ++-
 g10/options.h     |   2 +
 8 files changed, 371 insertions(+), 2 deletions(-)
 create mode 100644 g10/conv-packet.c
 create mode 100644 g10/conv-packet.h

diff --git a/configure.ac b/configure.ac
index fe7e821089b..6c867e6409e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,6 +105,7 @@ have_libusb=no
 have_libtss=no
 have_system_resolver=no
 gnupg_have_ldap="n/a"
+have_uasym_support=no
 
 use_zip=yes
 use_bzip2=yes
@@ -1817,6 +1818,11 @@ if test x"$use_run_gnupg_user_socket" = x"yes"; then
             [If defined try /run/gnupg/user before /run/user])
 fi
 
+AC_CHECK_HEADERS([linux/uasym_parser.h], [have_uasym_support=yes], [])
+AM_CONDITIONAL([UASYM_KEYS_SIGS], [test "$have_uasym_support" = yes])
+if test "$have_uasym_support" = yes; then
+  CFLAGS="$CFLAGS -DUASYM_KEYS_SIGS"
+fi
 
 #
 # Decide what to build
@@ -2158,6 +2164,7 @@ echo "
         TLS support:         $use_tls_library
         TOFU support:        $use_tofu
         Tor support:         $show_tor_support
+        Uasym support:       $have_uasym_support
 "
 if test "$have_libtss" != no -a -z "$TPMSERVER" -a -z "$SWTPM"; then
 cat <<G10EOF
diff --git a/doc/gpg.texi b/doc/gpg.texi
index 6b584a91306..e4d6f0adc59 100644
--- a/doc/gpg.texi
+++ b/doc/gpg.texi
@@ -652,6 +652,10 @@ Set the TOFU policy for all the bindings associated with the specified
 @pxref{trust-model-tofu}.  The @var{keys} may be specified either by their
 fingerprint (preferred) or their keyid.
 
+@item --conv-kernel
+@opindex conv-kernel
+Convert PGP keys into a format understood by the Linux kernel.
+
 @c @item --server
 @c @opindex server
 @c Run gpg in server mode.  This feature is not yet ready for use and
diff --git a/g10/Makefile.am b/g10/Makefile.am
index c5691f551b1..7e6f30dc0b5 100644
--- a/g10/Makefile.am
+++ b/g10/Makefile.am
@@ -130,6 +130,10 @@ common_source =  \
 	      objcache.c objcache.h \
 	      ecdh.c
 
+if UASYM_KEYS_SIGS
+common_source += conv-packet.c
+endif
+
 gpg_sources = server.c          \
 	      $(common_source)	\
 	      pkclist.c 	\
diff --git a/g10/conv-packet.c b/g10/conv-packet.c
new file mode 100644
index 00000000000..360db30eb8d
--- /dev/null
+++ b/g10/conv-packet.c
@@ -0,0 +1,287 @@
+/* conv-packet.c - convert packets
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This file is part of GnuPG.
+ *
+ * GnuPG is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * GnuPG is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#include <config.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/types.h>
+#include <linux/uasym_parser.h>
+#ifdef __BIG_ENDIAN__
+#include <linux/byteorder/big_endian.h>
+#else
+#include <linux/byteorder/little_endian.h>
+#endif
+#include <linux/pub_key_info.h>
+
+#include "gpg.h"
+#include "../common/util.h"
+#include "packet.h"
+#include "conv-packet.h"
+#include "options.h"
+#include "../common/i18n.h"
+
+static estream_t listfp;
+
+static void init_output(void)
+{
+  if (!listfp)
+    {
+      listfp = es_stdout;
+
+      if (opt.outfile) {
+        listfp = es_fopen (opt.outfile, "wb");
+        if (!listfp) {
+          log_error(_("cannot open %s for writing\n"), opt.outfile);
+          exit(1);
+        }
+      }
+    }
+}
+
+/*
+ * Simple encoder primitives for ASN.1 BER/DER/CER
+ *
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+static int asn1_encode_length(unsigned char *data, __u32 *data_len, __u32 len)
+{
+  if (len <= 0x7f) {
+    data[0] = len;
+    *data_len = 1;
+    return 0;
+  }
+
+  if (len <= 0xff) {
+    data[0] = 0x81;
+    data[1] = len & 0xff;
+    *data_len = 2;
+    return 0;
+  }
+
+  if (len <= 0xffff) {
+    data[0] = 0x82;
+    data[1] = (len >> 8) & 0xff;
+    data[2] = len & 0xff;
+    *data_len = 3;
+    return 0;
+  }
+
+  if (len > 0xffffff)
+    return -EINVAL;
+
+  data[0] = 0x83;
+  data[1] = (len >> 16) & 0xff;
+  data[2] = (len >> 8) & 0xff;
+  data[3] = len & 0xff;
+  *data_len = 4;
+
+  return 0;
+}
+
+static int mpis_to_asn1_sequence(gcry_mpi_t *pkey, int num_keys,
+                                 unsigned char **buffer, size_t *buffer_len)
+{
+  unsigned char asn1_key_len[PUBKEY_MAX_NSKEY][4];
+  unsigned char asn1_seq_len[4];
+  unsigned char *buffer_ptr;
+  __u32 asn1_key_len_len[PUBKEY_MAX_NSKEY];
+  __u32 asn1_seq_len_len;
+  __u32 asn1_seq_payload_len = 0;
+  size_t nbytes;
+  gpg_error_t err;
+  int ret, i;
+
+  for (i = 0, nbytes = 0; i < num_keys; i++) {
+    err = gcry_mpi_print (GCRYMPI_FMT_USG, NULL, 0, &nbytes, pkey[i]);
+    if (err)
+      return -EINVAL;
+
+    ret = asn1_encode_length(asn1_key_len[i], &asn1_key_len_len[i], nbytes);
+    if (ret < 0)
+      return ret;
+
+    asn1_seq_payload_len += 1 + asn1_key_len_len[i] + nbytes;
+  }
+
+  ret = asn1_encode_length(asn1_seq_len, &asn1_seq_len_len,
+                           asn1_seq_payload_len);
+  if (ret < 0)
+    return ret;
+
+  *buffer_len = 1 + asn1_seq_len_len + asn1_seq_payload_len;
+  *buffer = xmalloc_clear(*buffer_len);
+  if (!*buffer)
+    return -ENOMEM;
+
+  buffer_ptr = *buffer;
+
+  /* ASN1_SEQUENCE */
+  *buffer_ptr++ = 0x30;
+  memcpy(buffer_ptr, &asn1_seq_len, asn1_seq_len_len);
+  buffer_ptr += asn1_seq_len_len;
+
+  for (i = 0; i < num_keys; i++) {
+    /* ASN1_INTEGER */
+    *buffer_ptr++ = 0x02;
+    memcpy(buffer_ptr, &asn1_key_len[i], asn1_key_len_len[i]);
+    buffer_ptr += asn1_key_len_len[i];
+
+    err = gcry_mpi_print(GCRYMPI_FMT_USG, buffer_ptr,
+                         *buffer_len - (buffer_ptr - *buffer), &nbytes, pkey[i]);
+    if (err) {
+      xfree(*buffer);
+      return -EINVAL;
+    }
+
+    buffer_ptr += nbytes;
+  }
+
+  *buffer_len = buffer_ptr - *buffer;
+
+  return 0;
+}
+
+static int pgp_to_kernel_algo(int pgp_algorithm, gcry_mpi_t pkey, __u8 *algo)
+{
+  char *curve = NULL;
+  const char *name;
+  int ret = 0;
+
+  switch (pgp_algorithm) {
+  case PUBKEY_ALGO_RSA:
+  case PUBKEY_ALGO_RSA_S:
+    *algo = PKEY_ALGO_RSA;
+    break;
+  case PUBKEY_ALGO_ECDSA:
+    *algo = PKEY_ALGO_ECDSA;
+    if (!pkey)
+      break;
+
+    curve = openpgp_oid_to_str (pkey);
+    name = openpgp_oid_to_curve (curve, 0);
+    if (!strcmp(name, "nistp192"))
+      *algo = PKEY_ALGO_ECDSA_P192;
+    else if (!strcmp(name, "nistp256"))
+      *algo = PKEY_ALGO_ECDSA_P256;
+    else if (!strcmp(name, "nistp384"))
+      *algo = PKEY_ALGO_ECDSA_P384;
+    else
+      ret = -EOPNOTSUPP;
+    break;
+  default:
+    ret = -EOPNOTSUPP;
+    break;
+  }
+
+  xfree(curve);
+  return ret;
+}
+
+int write_kernel_key(PKT_public_key *pk)
+{
+  unsigned char *buffer = NULL;
+  size_t buffer_len = 0;
+  struct uasym_hdr hdr = { 0 };
+  struct uasym_entry e_algo = { 0 };
+  struct uasym_entry e_keyid = { 0 };
+  struct uasym_entry e_key_pub = { 0 };
+  struct uasym_entry e_key_desc = { 0 };
+  __u8 algo;
+  __u32 keyid[2], _keyid;
+  __u64 total_len = 0;
+  /* PGP: <keyid> */
+  char key_desc[4 + 1 + 8 + 1];
+  gpg_error_t err;
+  int ret = 0;
+
+  init_output();
+  keyid_from_pk (pk, keyid);
+
+  ret = pgp_to_kernel_algo(pk->pubkey_algo, pk->pkey[0], &algo);
+  if (ret < 0)
+    return ret;
+
+  /* algo */
+  e_algo.field = __cpu_to_be16(KEY_ALGO);
+  e_algo.length = __cpu_to_be32(sizeof(algo));
+  total_len += sizeof(e_algo) + sizeof(algo);
+
+  /* key id */
+  e_keyid.field = __cpu_to_be16(KEY_KID0);
+  e_keyid.length = __cpu_to_be32(sizeof(*pk->keyid) * 2);
+  total_len += sizeof(e_keyid) + sizeof(*pk->keyid) * 2;
+
+  /* key desc */
+  e_key_desc.field = __cpu_to_be16(KEY_DESC);
+  e_key_desc.length = __cpu_to_be32(sizeof(key_desc));
+  total_len += sizeof(e_key_desc) + sizeof(key_desc);
+
+  snprintf(key_desc, sizeof(key_desc), "PGP: %08x", pk->keyid[1]);
+
+  switch (pk->pubkey_algo) {
+  case PUBKEY_ALGO_RSA:
+  case PUBKEY_ALGO_RSA_S:
+    ret = mpis_to_asn1_sequence(pk->pkey, pubkey_get_npkey(pk->pubkey_algo),
+                                &buffer, &buffer_len);
+    break;
+  case PUBKEY_ALGO_ECDSA:
+    err = gcry_mpi_aprint(GCRYMPI_FMT_USG, &buffer, &buffer_len, pk->pkey[1]);
+    if (err)
+      ret = -EINVAL;
+    break;
+  default:
+    ret = -EOPNOTSUPP;
+    break;
+  }
+
+  if (ret < 0)
+    goto out;
+
+  /* key blob */
+  e_key_pub.field = __cpu_to_be16(KEY_PUB);
+  e_key_pub.length = __cpu_to_be32(buffer_len);
+  total_len += sizeof(e_key_pub) + buffer_len;
+
+  hdr.data_type = TYPE_KEY;
+  hdr.num_fields = __cpu_to_be16(4);
+  hdr.total_len = __cpu_to_be64(total_len);
+
+  es_write(listfp, &hdr, sizeof(hdr), NULL);
+
+  es_write(listfp, &e_algo, sizeof(e_algo), NULL);
+  es_write(listfp, &algo, sizeof(algo), NULL);
+
+  es_write(listfp, &e_keyid, sizeof(e_keyid), NULL);
+  _keyid = __cpu_to_be32(pk->keyid[0]);
+  es_write(listfp, &_keyid, sizeof(_keyid), NULL);
+  _keyid = __cpu_to_be32(pk->keyid[1]);
+  es_write(listfp, &_keyid, sizeof(_keyid), NULL);
+
+  es_write(listfp, &e_key_pub, sizeof(e_key_pub), NULL);
+  es_write(listfp, buffer, buffer_len, NULL);
+
+  es_write(listfp, &e_key_desc, sizeof(e_key_desc), NULL);
+  es_write(listfp, key_desc, sizeof(key_desc), NULL);
+out:
+  xfree(buffer);
+  return 0;
+}
diff --git a/g10/conv-packet.h b/g10/conv-packet.h
new file mode 100644
index 00000000000..d35acb985fc
--- /dev/null
+++ b/g10/conv-packet.h
@@ -0,0 +1,37 @@
+/* conv-packet.h - header of conv-packet.c
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This file is part of GnuPG.
+ *
+ * GnuPG is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * GnuPG is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef G10_CONV_PACKET_H
+#define G10_CONV_PACKET_H
+
+#include "../common/openpgpdefs.h"
+
+#ifdef UASYM_KEYS_SIGS
+int write_kernel_key(PKT_public_key *pk);
+#else
+static inline int write_kernel_key(PKT_public_key *pk)
+{
+   (void)pk;
+   return 0;
+}
+
+#endif /* UASYM_KEYS_SIGS */
+#endif /*G10_CONV_PACKET_H*/
diff --git a/g10/gpg.c b/g10/gpg.c
index 6e54aa7636c..410be8ab2ad 100644
--- a/g10/gpg.c
+++ b/g10/gpg.c
@@ -186,6 +186,7 @@ enum cmd_and_opt_values
     aPasswd,
     aServer,
     aTOFUPolicy,
+    aConvKernel,
 
     oMimemode,
     oTextmode,
@@ -583,6 +584,8 @@ static gpgrt_opt_t opts[] = {
   ARGPARSE_c (aListSigs, "list-sig", "@"),   /* alias */
   ARGPARSE_c (aCheckKeys, "check-sig", "@"), /* alias */
   ARGPARSE_c (aShowKeys,  "show-key", "@"), /* alias */
+  ARGPARSE_c (aConvKernel, "conv-kernel",
+              N_("convert to Linux kernel uasym format")),
 
 
 
@@ -2657,6 +2660,7 @@ main (int argc, char **argv)
 
 	  case aCheckKeys:
 	  case aListPackets:
+	  case aConvKernel:
 	  case aImport:
 	  case aFastImport:
 	  case aSendKeys:
@@ -5381,6 +5385,12 @@ main (int argc, char **argv)
           log_info (_("WARNING: no command supplied."
                       "  Trying to guess what you mean ...\n"));
         /*FALLTHRU*/
+      case aConvKernel:
+#ifndef UASYM_KEYS_SIGS
+        log_error(_("No support for user asymmetric keys and signatures\n"));
+        exit(1);
+#endif
+        /*FALLTHRU*/
       case aListPackets:
 	if( argc > 1 )
 	    wrong_args("[filename]");
@@ -5411,7 +5421,10 @@ main (int argc, char **argv)
 	    if( cmd == aListPackets ) {
 		opt.list_packets=1;
 		set_packet_list_mode(1);
-	    }
+	    } else if( cmd == aConvKernel ) {
+		opt.list_packets=1;
+		opt.conv_kernel=1;
+            }
 	    rc = proc_packets (ctrl, NULL, a );
 	    if( rc )
               {
diff --git a/g10/mainproc.c b/g10/mainproc.c
index 7dea4972894..edef9907127 100644
--- a/g10/mainproc.c
+++ b/g10/mainproc.c
@@ -496,6 +496,16 @@ proc_symkey_enc (CTX c, PACKET *pkt)
   free_packet (pkt, NULL);
 }
 
+static void
+proc_conv (PACKET *pkt)
+{
+  switch (pkt->pkttype)
+    {
+    case PKT_PUBLIC_KEY: write_kernel_key(pkt->pkt.public_key); break;
+    default: break;
+    }
+  free_packet(pkt, NULL);
+}
 
 static void
 proc_pubkey_enc (CTX c, PACKET *pkt)
@@ -1652,7 +1662,7 @@ do_proc_packets (CTX c, iobuf_t a)
           continue;
 	}
       newpkt = -1;
-      if (opt.list_packets)
+      if (opt.list_packets && !opt.conv_kernel)
         {
           switch (pkt->pkttype)
             {
@@ -1665,6 +1675,11 @@ do_proc_packets (CTX c, iobuf_t a)
             default: newpkt = 0; break;
 	    }
 	}
+      else if (opt.conv_kernel)
+        {
+            proc_conv(pkt);
+            newpkt = 0;
+        }
       else if (c->sigs_only)
         {
           switch (pkt->pkttype)
diff --git a/g10/options.h b/g10/options.h
index 914c24849f2..08125481511 100644
--- a/g10/options.h
+++ b/g10/options.h
@@ -26,6 +26,7 @@
 #include <stdint.h>
 #include "main.h"
 #include "packet.h"
+#include "conv-packet.h"
 #include "tofu.h"
 #include "../common/session-env.h"
 #include "../common/compliance.h"
@@ -91,6 +92,7 @@ struct
   int list_sigs;   /* list signatures */
   int no_armor;
   int list_packets; /* Option --list-packets active.  */
+  int conv_kernel; /* Option --conv-kernel active.  */
   int def_cipher_algo;
   int force_mdc;
   int disable_mdc;
-- 
2.34.1

