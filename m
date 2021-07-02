Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F23BA3BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGBRrb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 13:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGBRrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 13:47:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16683C061764
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jul 2021 10:44:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a6so12642808ioe.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jul 2021 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=KhUFjFc4PNJROyTJtUEcXg7AdBP9ZTbnL0e8ZbVJ8lM=;
        b=CRz5GvzJLoCYC5MJLb6yJac7CxQx1sUivQPd6A8txHOqsyGJcWTjTKBa9rCei5yWlP
         bsIt/2n3mhElerkUm7H23SR077aCtSwzqGMKJf/OHWhj6tq3shCWRd9S3TQsWgue1TkF
         e5agPx1QIrI0tMqC0nRk/6l6dd38d/a9ZJSKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=KhUFjFc4PNJROyTJtUEcXg7AdBP9ZTbnL0e8ZbVJ8lM=;
        b=PA3HgLiHoU9GGA49lUvl78lrAm41p9euXWGn6qmXXX+rMv7So9uGu0LJaTo8dvP3Sv
         ViYUegaL2tzJDlmEIVipGG6s327ez/NdCFFFErzXi70l5e/QfnnWPdtxyygqeKNUgnN7
         /6xmfutfcdCAutZjxlqVaVWAhq0PH/eobmaySMLeC6yoT5dxJAlBPOEIMwZNDa1SCaS3
         loCnAK0WBg8pWur9crITwjVnXogwDup803QhTmRNTGLJJh9+mW6Hl9V8RXG7S+gR1tHH
         GMCrH1ecrt/O+buiODaBvRcb53Esa0UfEBCUYMNifE9wxT9tkbIQLV1PEcBdGuZ1UExh
         4nbA==
X-Gm-Message-State: AOAM533AaNuwsZDKT9Pi8ZSewhWzVJsPR373n3B6PMVPnikUbY/itz9n
        VgnwxjXzS3a+96ozVrbiogvA8tym5a+n+Q==
X-Google-Smtp-Source: ABdhPJwSYtsS5he367KBuTdGGSIEbGSapp0wIAAD2ytchN5SO2URxMlEgCd0AS1q/ppxlsqKfYQxHg==
X-Received: by 2002:a02:3781:: with SMTP id r123mr579229jar.26.1625247897348;
        Fri, 02 Jul 2021 10:44:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i1sm1991932ilq.10.2021.07.02.10.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:44:56 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.14-rc1
Message-ID: <933f7ca8-71ae-6af3-64bb-b43795a98290@linuxfoundation.org>
Date:   Fri, 2 Jul 2021 11:44:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E64F399F8330183219BA06E5"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------E64F399F8330183219BA06E5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.14-rc1.

This Kselftest update for Linux 5.14-rc1 consists of fixes to

existing tests and framework:


-- migrate sgx test to kselftest harness

-- add new test cases to sgx test

-- ftrace test fix event-no-pid on 1-core machine

-- splice test adjust for handler fallback removal

diff is attached.

Apologies if this message appears to have double spacing. My email
client is at fault - I am trying to figure out what changed.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:



   Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)



are available in the Git repository at:



   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.14-rc1



for you to fetch changes up to 4896df9d53ae5521f3ce83751e828ad70bc65c80:



   selftests/sgx: remove checks for file execute permissions (2021-06-23 
18:38:04 -0600)



----------------------------------------------------------------

linux-kselftest-next-5.14-rc1



This Kselftest update for Linux 5.14-rc1 consists of fixes to

existing tests and framework:



-- migrate sgx test to kselftest harness

-- add new test cases to sgx test

-- ftrace test fix event-no-pid on 1-core machine

-- splice test adjust for handler fallback removal



----------------------------------------------------------------

Dave Hansen (1):

       selftests/sgx: remove checks for file execute permissions



Jarkko Sakkinen (5):

       selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'

       selftests/sgx: Migrate to kselftest harness

       selftests/sgx: Dump enclave memory map

       selftests/sgx: Add EXPECT_EEXIT() macro

       selftests/sgx: Refine the test enclave to have storage



Kees Cook (3):

       selftests/tls: Add {} to avoid static checker warning

       selftests: splice: Adjust for handler fallback removal

       selftests: lib.mk: Also install "config" and "settings"



Krzysztof Kozlowski (1):

       selftests/ftrace: fix event-no-pid on 1-core machine



Po-Hsu Lin (1):

       selftests: timers: rtcpie: skip test if default RTC device does 
not exist



Xiaochen Shen (1):

       selftests/resctrl: Fix incorrect parsing of option "-t"



  .../selftests/ftrace/test.d/event/event-no-pid.tc  |   7 +

  tools/testing/selftests/lib.mk                     |   1 +

  tools/testing/selftests/net/tls.c                  |   3 +-

  tools/testing/selftests/resctrl/README             |   2 +-

  tools/testing/selftests/resctrl/resctrl_tests.c    |   4 +-

  tools/testing/selftests/sgx/call.S                 |   6 +-

  tools/testing/selftests/sgx/defines.h              |  10 +

  tools/testing/selftests/sgx/load.c                 |  19 +-

  tools/testing/selftests/sgx/main.c                 | 239 
+++++++++++++--------

  tools/testing/selftests/sgx/main.h                 |   4 +-

  tools/testing/selftests/sgx/test_encl.c            |  19 +-

  tools/testing/selftests/sgx/test_encl.lds          |   3 +-

  .../testing/selftests/splice/short_splice_read.sh  | 119 ++++++++--

  tools/testing/selftests/timers/rtcpie.c            |  10 +-

  14 files changed, 308 insertions(+), 138 deletions(-)


----------------------------------------------------------------

--------------E64F399F8330183219BA06E5
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.14-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.14-rc1.diff"

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index e6eb78f0b954..9933ed24f901 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -57,6 +57,10 @@ enable_events() {
     echo 1 > tracing_on
 }
 
+other_task() {
+    sleep .001 || usleep 1 || sleep 1
+}
+
 echo 0 > options/event-fork
 
 do_reset
@@ -94,6 +98,9 @@ child=$!
 echo "child = $child"
 wait $child
 
+# Be sure some other events will happen for small systems (e.g. 1 core)
+other_task
+
 echo 0 > tracing_on
 
 cnt=`count_pid $mypid`
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 0af84ad48aa7..fa2ac0e56b43 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -100,6 +100,7 @@ define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
 endef
 
 install: all
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 426d07875a48..7119f8eb823b 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -418,8 +418,9 @@ TEST_F(tls, sendmsg_large)
 		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
 	}
 
-	while (recvs++ < sends)
+	while (recvs++ < sends) {
 		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+	}
 
 	free(mem);
 }
diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 4b36b25b6ac0..3d2bbd4fa3aa 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -47,7 +47,7 @@ Parameter '-h' shows usage information.
 
 usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
         -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT default benchmark is builtin fill_buf
-        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
+        -t test list: run tests specified in the test list, e.g. -t mbm,mba,cmt,cat
         -n no_of_bits: run cache tests using specified no of bits in cache bit mask
         -p cpu_no: specify CPU number to run the test. 1 is default
         -h: help
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f51b5fc066a3..973f09a66e1e 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -40,7 +40,7 @@ static void cmd_help(void)
 	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cmt, cat\n");
+	printf("e.g. -t mbm,mba,cmt,cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 
 					return -1;
 				}
-				token = strtok(NULL, ":\t");
+				token = strtok(NULL, ",");
 			}
 			break;
 		case 'p':
diff --git a/tools/testing/selftests/sgx/call.S b/tools/testing/selftests/sgx/call.S
index 4ecadc7490f4..b09a25890f3b 100644
--- a/tools/testing/selftests/sgx/call.S
+++ b/tools/testing/selftests/sgx/call.S
@@ -5,8 +5,8 @@
 
 	.text
 
-	.global sgx_call_vdso
-sgx_call_vdso:
+	.global sgx_enter_enclave
+sgx_enter_enclave:
 	.cfi_startproc
 	push	%r15
 	.cfi_adjust_cfa_offset	8
@@ -27,7 +27,7 @@ sgx_call_vdso:
 	.cfi_adjust_cfa_offset	8
 	push	0x38(%rsp)
 	.cfi_adjust_cfa_offset	8
-	call	*eenter(%rip)
+	call	*vdso_sgx_enter_enclave(%rip)
 	add	$0x10, %rsp
 	.cfi_adjust_cfa_offset	-0x10
 	pop	%rbx
diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 0bd73428d2f3..f88562afcaa0 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -18,4 +18,14 @@
 #include "../../../../arch/x86/include/asm/enclu.h"
 #include "../../../../arch/x86/include/uapi/asm/sgx.h"
 
+enum encl_op_type {
+	ENCL_OP_PUT,
+	ENCL_OP_GET,
+};
+
+struct encl_op {
+	uint64_t type;
+	uint64_t buffer;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index f441ac34b4d4..3ebe5d1fe337 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -150,16 +150,6 @@ bool encl_load(const char *path, struct encl *encl)
 		goto err;
 	}
 
-	/*
-	 * This just checks if the /dev file has these permission
-	 * bits set.  It does not check that the current user is
-	 * the owner or in the owning group.
-	 */
-	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
-		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
-		goto err;
-	}
-
 	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
 		perror("mmap for read");
@@ -169,13 +159,13 @@ bool encl_load(const char *path, struct encl *encl)
 
 #define ERR_MSG \
 "mmap() succeeded for PROT_READ, but failed for PROT_EXEC.\n" \
-" Check that current user has execute permissions on %s and \n" \
-" that /dev does not have noexec set: mount | grep \"/dev .*noexec\"\n" \
+" Check that /dev does not have noexec set:\n" \
+" \tmount | grep \"/dev .*noexec\"\n" \
 " If so, remount it executable: mount -o remount,exec /dev\n\n"
 
 	ptr = mmap(NULL, PAGE_SIZE, PROT_EXEC, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
-		fprintf(stderr, ERR_MSG, device_path);
+		fprintf(stderr, ERR_MSG);
 		goto err;
 	}
 	munmap(ptr, PAGE_SIZE);
@@ -239,9 +229,6 @@ bool encl_load(const char *path, struct encl *encl)
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
 
-		printf("0x%016lx 0x%016lx 0x%02x\n", seg->offset, seg->size,
-		       seg->prot);
-
 		j++;
 	}
 
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index d304a4044eb9..e252015e0c15 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -17,11 +17,11 @@
 #include <sys/types.h>
 #include <sys/auxv.h>
 #include "defines.h"
+#include "../kselftest_harness.h"
 #include "main.h"
-#include "../kselftest.h"
 
 static const uint64_t MAGIC = 0x1122334455667788ULL;
-vdso_sgx_enter_enclave_t eenter;
+vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
 struct vdso_symtab {
 	Elf64_Sym *elf_symtab;
@@ -107,85 +107,51 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
-bool report_results(struct sgx_enclave_run *run, int ret, uint64_t result,
-		  const char *test)
-{
-	bool valid = true;
-
-	if (ret) {
-		printf("FAIL: %s() returned: %d\n", test, ret);
-		valid = false;
-	}
-
-	if (run->function != EEXIT) {
-		printf("FAIL: %s() function, expected: %u, got: %u\n", test, EEXIT,
-		       run->function);
-		valid = false;
-	}
-
-	if (result != MAGIC) {
-		printf("FAIL: %s(), expected: 0x%lx, got: 0x%lx\n", test, MAGIC,
-		       result);
-		valid = false;
-	}
-
-	if (run->user_data) {
-		printf("FAIL: %s() user data, expected: 0x0, got: 0x%llx\n",
-		       test, run->user_data);
-		valid = false;
-	}
-
-	return valid;
-}
-
-static int user_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r9,
-			struct sgx_enclave_run *run)
-{
-	run->user_data = 0;
-	return 0;
-}
+FIXTURE(enclave) {
+	struct encl encl;
+	struct sgx_enclave_run run;
+};
 
-int main(int argc, char *argv[])
+FIXTURE_SETUP(enclave)
 {
-	struct sgx_enclave_run run;
+	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
-	Elf64_Sym *eenter_sym;
-	uint64_t result = 0;
-	struct encl encl;
+	struct encl_segment *seg;
+	char maps_line[256];
+	FILE *maps_file;
 	unsigned int i;
 	void *addr;
-	int ret;
 
-	memset(&run, 0, sizeof(run));
-
-	if (!encl_load("test_encl.elf", &encl)) {
-		encl_delete(&encl);
+	if (!encl_load("test_encl.elf", &self->encl)) {
+		encl_delete(&self->encl);
 		ksft_exit_skip("cannot load enclaves\n");
 	}
 
-	if (!encl_measure(&encl))
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		seg = &self->encl.segment_tbl[i];
+
+		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
+	}
+
+	if (!encl_measure(&self->encl))
 		goto err;
 
-	if (!encl_build(&encl))
+	if (!encl_build(&self->encl))
 		goto err;
 
 	/*
 	 * An enclave consumer only must do this.
 	 */
-	for (i = 0; i < encl.nr_segments; i++) {
-		struct encl_segment *seg = &encl.segment_tbl[i];
-
-		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
-			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
-		if (addr == MAP_FAILED) {
-			perror("mmap() segment failed");
-			exit(KSFT_FAIL);
-		}
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		addr = mmap((void *)self->encl.encl_base + seg->offset, seg->size,
+			    seg->prot, MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+		EXPECT_NE(addr, MAP_FAILED);
+		if (addr == MAP_FAILED)
+			goto err;
 	}
 
-	memset(&run, 0, sizeof(run));
-	run.tcs = encl.encl_base;
-
 	/* Get vDSO base address */
 	addr = (void *)getauxval(AT_SYSINFO_EHDR);
 	if (!addr)
@@ -194,37 +160,134 @@ int main(int argc, char *argv[])
 	if (!vdso_get_symtab(addr, &symtab))
 		goto err;
 
-	eenter_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
-	if (!eenter_sym)
+	sgx_enter_enclave_sym = vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave");
+	if (!sgx_enter_enclave_sym)
 		goto err;
 
-	eenter = addr + eenter_sym->st_value;
-
-	ret = sgx_call_vdso((void *)&MAGIC, &result, 0, EENTER, NULL, NULL, &run);
-	if (!report_results(&run, ret, result, "sgx_call_vdso"))
-		goto err;
+	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
 
-	/* Invoke the vDSO directly. */
-	result = 0;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
-	if (!report_results(&run, ret, result, "eenter"))
-		goto err;
+	maps_file = fopen("/proc/self/maps", "r");
+	if (maps_file != NULL)  {
+		while (fgets(maps_line, sizeof(maps_line), maps_file) != NULL) {
+			maps_line[strlen(maps_line) - 1] = '\0';
 
-	/* And with an exit handler. */
-	run.user_handler = (__u64)user_handler;
-	run.user_data = 0xdeadbeef;
-	ret = eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER,
-		     0, 0, &run);
-	if (!report_results(&run, ret, result, "user_handler"))
-		goto err;
+			if (strstr(maps_line, "/dev/sgx_enclave"))
+				TH_LOG("%s", maps_line);
+		}
 
-	printf("SUCCESS\n");
-	encl_delete(&encl);
-	exit(KSFT_PASS);
+		fclose(maps_file);
+	}
 
 err:
-	encl_delete(&encl);
-	exit(KSFT_FAIL);
+	if (!sgx_enter_enclave_sym)
+		encl_delete(&self->encl);
+
+	ASSERT_NE(sgx_enter_enclave_sym, NULL);
+}
+
+FIXTURE_TEARDOWN(enclave)
+{
+	encl_delete(&self->encl);
+}
+
+#define ENCL_CALL(op, run, clobbered) \
+	({ \
+		int ret; \
+		if ((clobbered)) \
+			ret = vdso_sgx_enter_enclave((unsigned long)(op), 0, 0, \
+						     EENTER, 0, 0, (run)); \
+		else \
+			ret = sgx_enter_enclave((void *)(op), NULL, 0, EENTER, NULL, NULL, \
+						(run)); \
+		ret; \
+	})
+
+#define EXPECT_EEXIT(run) \
+	do { \
+		EXPECT_EQ((run)->function, EEXIT); \
+		if ((run)->function != EEXIT) \
+			TH_LOG("0x%02x 0x%02x 0x%016llx", (run)->exception_vector, \
+			       (run)->exception_error_code, (run)->exception_addr); \
+	} while (0)
+
+TEST_F(enclave, unclobbered_vdso)
+{
+	struct encl_op op;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F(enclave, clobbered_vdso)
+{
+	struct encl_op op;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
 }
+
+static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r9,
+			struct sgx_enclave_run *run)
+{
+	run->user_data = 0;
+
+	return 0;
+}
+
+TEST_F(enclave, clobbered_vdso_and_user_function)
+{
+	struct encl_op op;
+
+	self->run.user_handler = (__u64)test_handler;
+	self->run.user_data = 0xdeadbeef;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 67211a708f04..68672fd86cf9 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -35,7 +35,7 @@ bool encl_load(const char *path, struct encl *encl);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 
-int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
-		  struct sgx_enclave_run *run);
+int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
+		      struct sgx_enclave_run *run);
 
 #endif /* MAIN_H */
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index cf25b5dc1e03..734ea52f9924 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -4,6 +4,8 @@
 #include <stddef.h>
 #include "defines.h"
 
+static uint8_t encl_buffer[8192] = { 1 };
+
 static void *memcpy(void *dest, const void *src, size_t n)
 {
 	size_t i;
@@ -14,7 +16,20 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-void encl_body(void *rdi, void *rsi)
+void encl_body(void *rdi,  void *rsi)
 {
-	memcpy(rsi, rdi, 8);
+	struct encl_op *op = (struct encl_op *)rdi;
+
+	switch (op->type) {
+	case ENCL_OP_PUT:
+		memcpy(&encl_buffer[0], &op->buffer, 8);
+		break;
+
+	case ENCL_OP_GET:
+		memcpy(&op->buffer, &encl_buffer[0], 8);
+		break;
+
+	default:
+		break;
+	}
 }
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index 0fbbda7e665e..a1ec64f7d91f 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -18,9 +18,10 @@ SECTIONS
 	.text : {
 		*(.text*)
 		*(.rodata*)
+		FILL(0xDEADBEEF);
+		. = ALIGN(4096);
 	} : text
 
-	. = ALIGN(4096);
 	.data : {
 		*(.data*)
 	} : data
diff --git a/tools/testing/selftests/splice/short_splice_read.sh b/tools/testing/selftests/splice/short_splice_read.sh
index 7810d3589d9a..22b6c8910b18 100755
--- a/tools/testing/selftests/splice/short_splice_read.sh
+++ b/tools/testing/selftests/splice/short_splice_read.sh
@@ -1,21 +1,87 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
+#
+# Test for mishandling of splice() on pseudofilesystems, which should catch
+# bugs like 11990a5bd7e5 ("module: Correctly truncate sysfs sections output")
+#
+# Since splice fallback was removed as part of the set_fs() rework, many of these
+# tests expect to fail now. See https://lore.kernel.org/lkml/202009181443.C2179FB@keescook/
 set -e
 
+DIR=$(dirname "$0")
+
 ret=0
 
+expect_success()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "ok: $title succeeded" >&2
+		;;
+	1)
+		echo "FAIL: $title should work" >&2
+		ret=$(( ret + 1 ))
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
+expect_failure()
+{
+	title="$1"
+	shift
+
+	echo "" >&2
+	echo "$title ..." >&2
+
+	set +e
+	"$@"
+	rc=$?
+	set -e
+
+	case "$rc" in
+	0)
+		echo "FAIL: $title unexpectedly worked" >&2
+		ret=$(( ret + 1 ))
+		;;
+	1)
+		echo "ok: $title correctly failed" >&2
+		;;
+	*)
+		echo "FAIL: something else went wrong" >&2
+		ret=$(( ret + 1 ))
+		;;
+	esac
+}
+
 do_splice()
 {
 	filename="$1"
 	bytes="$2"
 	expected="$3"
+	report="$4"
 
-	out=$(./splice_read "$filename" "$bytes" | cat)
+	out=$("$DIR"/splice_read "$filename" "$bytes" | cat)
 	if [ "$out" = "$expected" ] ; then
-		echo "ok: $filename $bytes"
+		echo "      matched $report" >&2
+		return 0
 	else
-		echo "FAIL: $filename $bytes"
-		ret=1
+		echo "      no match: '$out' vs $report" >&2
+		return 1
 	fi
 }
 
@@ -23,34 +89,45 @@ test_splice()
 {
 	filename="$1"
 
+	echo "  checking $filename ..." >&2
+
 	full=$(cat "$filename")
+	rc=$?
+	if [ $rc -ne 0 ] ; then
+		return 2
+	fi
+
 	two=$(echo "$full" | grep -m1 . | cut -c-2)
 
 	# Make sure full splice has the same contents as a standard read.
-	do_splice "$filename" 4096 "$full"
+	echo "    splicing 4096 bytes ..." >&2
+	if ! do_splice "$filename" 4096 "$full" "full read" ; then
+		return 1
+	fi
 
 	# Make sure a partial splice see the first two characters.
-	do_splice "$filename" 2 "$two"
+	echo "    splicing 2 bytes ..." >&2
+	if ! do_splice "$filename" 2 "$two" "'$two'" ; then
+		return 1
+	fi
+
+	return 0
 }
 
-# proc_single_open(), seq_read()
-test_splice /proc/$$/limits
-# special open, seq_read()
-test_splice /proc/$$/comm
+### /proc/$pid/ has no splice interface; these should all fail.
+expect_failure "proc_single_open(), seq_read() splice" test_splice /proc/$$/limits
+expect_failure "special open(), seq_read() splice" test_splice /proc/$$/comm
 
-# proc_handler, proc_dointvec_minmax
-test_splice /proc/sys/fs/nr_open
-# proc_handler, proc_dostring
-test_splice /proc/sys/kernel/modprobe
-# proc_handler, special read
-test_splice /proc/sys/kernel/version
+### /proc/sys/ has a splice interface; these should all succeed.
+expect_success "proc_handler: proc_dointvec_minmax() splice" test_splice /proc/sys/fs/nr_open
+expect_success "proc_handler: proc_dostring() splice" test_splice /proc/sys/kernel/modprobe
+expect_success "proc_handler: special read splice" test_splice /proc/sys/kernel/version
 
+### /sys/ has no splice interface; these should all fail.
 if ! [ -d /sys/module/test_module/sections ] ; then
-	modprobe test_module
+	expect_success "test_module kernel module load" modprobe test_module
 fi
-# kernfs, attr
-test_splice /sys/module/test_module/coresize
-# kernfs, binattr
-test_splice /sys/module/test_module/sections/.init.text
+expect_failure "kernfs attr splice" test_splice /sys/module/test_module/coresize
+expect_failure "kernfs binattr splice" test_splice /sys/module/test_module/sections/.init.text
 
 exit $ret
diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 47b5bad1b393..4ef2184f1558 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -18,6 +18,8 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#include "../kselftest.h"
+
 /*
  * This expects the new RTC class driver framework, working with
  * clocks that will often not be clones of what the PC-AT had.
@@ -35,8 +37,14 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 2:
 		rtc = argv[1];
-		/* FALLTHROUGH */
+		break;
 	case 1:
+		fd = open(default_rtc, O_RDONLY);
+		if (fd == -1) {
+			printf("Default RTC %s does not exist. Test Skipped!\n", default_rtc);
+			exit(KSFT_SKIP);
+		}
+		close(fd);
 		break;
 	default:
 		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");

--------------E64F399F8330183219BA06E5--
