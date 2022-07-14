Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5F574F31
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiGNNbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbiGNNbS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 09:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A1565E32A
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657805475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9FSo8XtzlTYanivvYEARXQax4+PoAE9EIoVCtOZ5gZk=;
        b=IYZv7YJdZIEPVJO3cNbvLTIGfy3d5KnhqaQZAF0io+c5/XELG+J6t4b9Slk3NDdJZctqvt
        GYsf+rCwn4GOdsJga9wkCmz2pFb568VN5XuZWxeU7jJBo3f30YwZLgAsgop4C75bCwofS/
        I5R/L+um/82iOh+YrK67vbCJHSlajN8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-h61UwmK8OaCQCfe2kiw6Ow-1; Thu, 14 Jul 2022 09:31:14 -0400
X-MC-Unique: h61UwmK8OaCQCfe2kiw6Ow-1
Received: by mail-qv1-f70.google.com with SMTP id p11-20020a0cfd8b000000b0047318870bdfso1228993qvr.14
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 06:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9FSo8XtzlTYanivvYEARXQax4+PoAE9EIoVCtOZ5gZk=;
        b=XqUM7KI80YL7l5LyIQLB6QZ5q+7xM7Jvaic8Gp7O4jtERd+29HKGUvb+qg5xeB41BA
         KQw22YXIufXCtP6NzM2rG2THN/BPviz9UQsQrbJzGYaKBFgEq+8cKtZPNIOh2QJ+79wI
         WQa1pOGhrTXZclO1BeiSzv4apzBc1o9P6ibiLQRAzBsVp4Rh0U57BG01wzdIkLeVlD8f
         zKpKXFOC5N2Kzbedp9okwZHvfuo4FTLChsRD9cf8fONdSofqn3xQukOQSRz4K+yQJ7mV
         KYozh5EXUEA8uAWVrBb87nshsWv9kAY41nwd8PnG/Xs7JXwJLsMYUUGHR3hMIibuuO3X
         8WQQ==
X-Gm-Message-State: AJIora84EyfgHv8StpcIEzSwIxuLLTES5C2ffvsm7Vq2VUDu0LQYTC+h
        7hqgI6PbkSJN3DXAmG6d4+GEjWhUqZjmYzA2HPMEf0e/oF2Dhd4qB+IjsCdHxq9rr6XHXpfHMeC
        /ah+fz44rnm8NeKBYq6cE5du+2AAC
X-Received: by 2002:a05:620a:16ca:b0:6b5:b971:1aa6 with SMTP id a10-20020a05620a16ca00b006b5b9711aa6mr5223159qkn.144.1657805473436;
        Thu, 14 Jul 2022 06:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sjabRBa+rxyI0T+f44L65WTTYmZUNwMEYoOiHrIt+kDhoMDjYjmhAMJG1aeFZuLPRe6f+ygQ==
X-Received: by 2002:a05:620a:16ca:b0:6b5:b971:1aa6 with SMTP id a10-20020a05620a16ca00b006b5b9711aa6mr5223126qkn.144.1657805472980;
        Thu, 14 Jul 2022 06:31:12 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id z125-20020a37b083000000b006a758ce2ae1sm1291694qke.104.2022.07.14.06.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:31:12 -0700 (PDT)
Date:   Thu, 14 Jul 2022 09:31:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        dylanbhatch@google.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] proc: fix test for "vsyscall=xonly" boot option
Message-ID: <YtAanSSBrhsL7S9J@bfoster>
References: <Ys2Hi3Ps933B6IsE@localhost.localdomain>
 <Ys2KgeiEMboU8Ytu@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2KgeiEMboU8Ytu@localhost.localdomain>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 12, 2022 at 05:51:45PM +0300, Alexey Dobriyan wrote:
> Booting with vsyscall=xonly results in the following vsyscall VMA:
> 
> 	ffffffffff600000-ffffffffff601000 --xp ... [vsyscall]\n
> 
> Test does read from fixed vsyscall address to determine if kernel
> supports vsyscall page but it doesn't work because, well, vsyscall
> page is execute only.
> 
> Fix test by trying to execute from the first byte of the page which
> contains gettimeofday() stub. This should work because vsyscall
> entry points have stable addresses by design.
> 
> 	Alexey, avoiding parsing .config, /proc/config.gz and
> 	/proc/cmdline at all costs.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

Hi Alexey,

I had run into this failure when testing something unrelated, so thanks
for the fix. It passes in my test env. That said, some of code
duplication stood out to me when I took a closer look. Not a huge deal
for a selftest, but any thoughts on any of the following cleanups on top
of your diff..? It still passes my quick tests and cuts the patch in
half or so..

Brian

--- 8< ---

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index e5962f4794f5..d4dca92d60f3 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -212,32 +212,35 @@ static int make_exe(const uint8_t *payload, size_t len)
 #endif
 
 /*
- * 0: vsyscall VMA doesn't exist	vsyscall=none
- * 1: vsyscall VMA is r-xp		vsyscall=emulate
+ * vsyscall probe return codes:
+ *
+ * 0: vsyscall VMA is r-xp		vsyscall=emulate
+ * 1: vsyscall VMA doesn't exist	vsyscall=none
  * 2: vsyscall VMA is --xp		vsyscall=xonly
  */
-static int g_vsyscall;
+static volatile int g_vsyscall;
 static const char *str_vsyscall;
 
-static const char str_vsyscall_0[] = "";
-static const char str_vsyscall_1[] =
-"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
-static const char str_vsyscall_2[] =
-"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
+static const char *str_vsyscall_arr[] = {
+"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n",
+"",
+"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n"
+};
 
 #ifdef __x86_64__
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
 {
-	_exit(1);
+	_exit(g_vsyscall);
 }
 
 /*
  * vsyscall page can't be unmapped, probe it directly.
  */
-static void vsyscall(void)
+static bool vsyscall(void)
 {
 	pid_t pid;
 	int wstatus;
+	bool ret = false;
 
 	pid = fork();
 	if (pid < 0) {
@@ -256,72 +259,34 @@ static void vsyscall(void)
 		(void)sigaction(SIGSEGV, &act, NULL);
 
 		/* gettimeofday(NULL, NULL); */
+		g_vsyscall = 1;
 		asm volatile (
 			"call %P0"
 			:
 			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
 			: "rax", "rcx", "r11"
 		);
-		exit(0);
-	}
-	waitpid(pid, &wstatus, 0);
-	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		/* vsyscall page exists and is executable. */
-	} else {
-		/* vsyscall page doesn't exist. */
-		g_vsyscall = 0;
-		return;
-	}
-
-	pid = fork();
-	if (pid < 0) {
-		fprintf(stderr, "fork, errno %d\n", errno);
-		exit(1);
-	}
-	if (pid == 0) {
-		struct rlimit rlim = {0, 0};
-		(void)setrlimit(RLIMIT_CORE, &rlim);
-
-		/* Hide "segfault at ffffffffff600000" messages. */
-		struct sigaction act;
-		memset(&act, 0, sizeof(struct sigaction));
-		act.sa_flags = SA_SIGINFO;
-		act.sa_sigaction = sigaction_SIGSEGV;
-		(void)sigaction(SIGSEGV, &act, NULL);
 
+		g_vsyscall = 2;
 		*(volatile int *)0xffffffffff600000UL;
 		exit(0);
 	}
 	waitpid(pid, &wstatus, 0);
-	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
-		/* vsyscall page is readable and executable. */
-		g_vsyscall = 1;
-		return;
+	if (WIFEXITED(wstatus)) {
+		g_vsyscall = WEXITSTATUS(wstatus);
+		ret = g_vsyscall != 1;
 	}
-
-	/* vsyscall page is executable but unreadable. */
-	g_vsyscall = 2;
+	str_vsyscall = str_vsyscall_arr[g_vsyscall];
+	return ret;
 }
 
 int main(void)
 {
 	int pipefd[2];
 	int exec_fd;
+	bool have_vsyscall;
 
-	vsyscall();
-	switch (g_vsyscall) {
-	case 0:
-		str_vsyscall = str_vsyscall_0;
-		break;
-	case 1:
-		str_vsyscall = str_vsyscall_1;
-		break;
-	case 2:
-		str_vsyscall = str_vsyscall_2;
-		break;
-	default:
-		abort();
-	}
+	have_vsyscall = vsyscall();
 
 	atexit(ate);
 
@@ -388,7 +353,7 @@ int main(void)
 		rv = read(fd, buf, sizeof(buf));
 		assert(rv == len);
 		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
-		if (g_vsyscall > 0) {
+		if (have_vsyscall) {
 			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
 		}
 	}
@@ -435,7 +400,7 @@ int main(void)
 			assert(memmem(buf, rv, S[i], strlen(S[i])));
 		}
 
-		if (g_vsyscall > 0) {
+		if (have_vsyscall) {
 			assert(memmem(buf, rv, str_vsyscall, strlen(str_vsyscall)));
 		}
 	}

