Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2D54E10E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiFPMry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 08:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181F109B;
        Thu, 16 Jun 2022 05:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41D426167F;
        Thu, 16 Jun 2022 12:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10851C3411C;
        Thu, 16 Jun 2022 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655383670;
        bh=qucNDYIYgVCGTJMJ3sdpzySUORGf8r9vijq4+kXU8K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nONDFAZ6lJCNL0rJaEqcl16s9H+EBiIVCKCGkvHL0GMuTUU02Silpb+lPSW7mPC9H
         DNTBXqTGxYd2TQulvaOKhyLV7bhsIVN9o9urQ8KuJ73SoPgslnPtK8x1XENw/R/dMY
         Wvgr8WSCRocW81DkWyF0pUq6q41DnA+DyqGUhEPKmk/22ma1kNvkp31SoNJLCwRZ5Q
         ZAMjSGRLCpAtillb8yxvnSi8fKBpmeUCct5pK/Yhe6cIVtNiMLysfY0x7QOsghif85
         1zQzBfqRR36xcVUPgFAFhxfGvwBx8oixkewrzP8BIMcKA9JQer0znrcX+Ytdl2mtVT
         Yw6wguuL7WZsA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 1/2] selftests/kexec: remove broken EFI_VARS secure boot fallback check
Date:   Thu, 16 Jun 2022 14:47:39 +0200
Message-Id: <20220616124740.580708-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616124740.580708-1-ardb@kernel.org>
References: <20220616124740.580708-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; h=from:subject; bh=qucNDYIYgVCGTJMJ3sdpzySUORGf8r9vijq4+kXU8K4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiqyZpW6zfkCpUOh5lc1fvD6RyRo84exIiLU17eQCU mwj1sMCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqsmaQAKCRDDTyI5ktmPJG6oDA CkzZu9dAxo/Ckimn6Vr6RtYcNSZKVxLuL0gv03nUQM+2J9oBdptezOFzZrKDg4srKgKWFvCnBtFjvd XMyG1sGeXeXnwif/J3iotvcq3fLHtnaJmJd+ykqrchMp07ydvm9m2Q347PnN0mOtmSfU1ax9nab/tY XToCWah1ZAuTn0iweOauiNkQEmWeXUuxxuF082KVYMfdJMAXu1OjfDweves12AELuA0Y5M/x4bCdVK gncoH780+uKWgRE/Dhg/M9PDP/XPYfg2PFu8jaMnJrE9JrY8bGHiesEfoqfHStsvITu5nYpO9s3S/0 dttZwCoElBt77jpSAYoKfYRV/UIDt5VAFu8xam2erZObYr5sz/6HLshXhJbjuOFWhPo50z6j5OFEpv U+e6kO/bKUjV/N4HbUOJzncNwULAbdZabmHKOnNF2KB5r979Fc6Ua6GtZpo7xf44KLkJ8V8/MeHDEo RqrkSDFYnP6h3lBsjaDvk8Ir2PuNyyZVGbZGA0dW2mtXU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit b433a52aa28733e0 ("selftests/kexec: update get_secureboot_mode")
refactored the code that discovers the EFI secure boot mode so it only
depends on either the efivars pseudo filesystem or the efivars sysfs
interface, but never both.

However, the latter version was not implemented correctly, given the
fact that the local 'efi_vars' variable never assumes a value. This
means the fallback has been dead code ever since it was introduced.

So let's drop the fallback altogether. The sysfs interface has been
deprecated for ~10 years now, and is only enabled on x86 to begin with,
so it is time to get rid of it entirely.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/testing/selftests/kexec/kexec_common_lib.sh | 36 ++------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 0e114b34d5d7..641ef05863b2 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -65,32 +65,6 @@ get_efivarfs_secureboot_mode()
 	return 0;
 }
 
-get_efi_var_secureboot_mode()
-{
-	local efi_vars
-	local secure_boot_file
-	local setup_mode_file
-	local secureboot_mode
-	local setup_mode
-
-	if [ ! -d "$efi_vars" ]; then
-		log_skip "efi_vars is not enabled\n"
-	fi
-	secure_boot_file=$(find "$efi_vars" -name SecureBoot-* 2>/dev/null)
-	setup_mode_file=$(find "$efi_vars" -name SetupMode-* 2>/dev/null)
-	if [ -f "$secure_boot_file/data" ] && \
-	   [ -f "$setup_mode_file/data" ]; then
-		secureboot_mode=`od -An -t u1 "$secure_boot_file/data"`
-		setup_mode=`od -An -t u1 "$setup_mode_file/data"`
-
-		if [ $secureboot_mode -eq 1 ] && [ $setup_mode -eq 0 ]; then
-			log_info "secure boot mode enabled (CONFIG_EFI_VARS)"
-			return 1;
-		fi
-	fi
-	return 0;
-}
-
 # On powerpc platform, check device-tree property
 # /proc/device-tree/ibm,secureboot/os-secureboot-enforcing
 # to detect secureboot state.
@@ -113,9 +87,8 @@ get_arch()
 }
 
 # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
-# The secure boot mode can be accessed either as the last integer
-# of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
-# "od -An -t u1 /sys/firmware/efi/vars/SecureBoot-*/data".  The efi
+# The secure boot mode can be accessed as the last integer of
+# "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*".  The efi
 # SetupMode can be similarly accessed.
 # Return 1 for SecureBoot mode enabled and SetupMode mode disabled.
 get_secureboot_mode()
@@ -129,11 +102,6 @@ get_secureboot_mode()
 	else
 		get_efivarfs_secureboot_mode
 		secureboot_mode=$?
-		# fallback to using the efi_var files
-		if [ $secureboot_mode -eq 0 ]; then
-			get_efi_var_secureboot_mode
-			secureboot_mode=$?
-		fi
 	fi
 
 	if [ $secureboot_mode -eq 0 ]; then
-- 
2.35.1

