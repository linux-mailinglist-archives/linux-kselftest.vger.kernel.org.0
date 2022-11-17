Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7D62E708
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiKQVfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 16:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiKQVfL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 16:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F964571
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 13:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668720785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDQssBDra2LgVmFEmn0r+1NHqlAxiYwGBKpxHeKgv/A=;
        b=BcOvuPxpztucI2n7pEHBxDN6tyIS0IUNoFaIkltXiq/AkVc8nI7XEkVAG68W3Sj/UUR/P1
        l7McSUroGiet/8pyAKBQb+5qtfWyL7qYzV5lYRSKUbRwop1Y4LHXYZUae9gMZYc11QPeqE
        eOgx9VXM4O+BeG/v/TmpKbV9bQHU52A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-V8ZD54CbP9at5GbUPo87Jg-1; Thu, 17 Nov 2022 16:33:03 -0500
X-MC-Unique: V8ZD54CbP9at5GbUPo87Jg-1
Received: by mail-qk1-f200.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso3764025qko.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 13:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDQssBDra2LgVmFEmn0r+1NHqlAxiYwGBKpxHeKgv/A=;
        b=UbReDX5nGMh1ponkV9ER1huI418nwwAicUAkqXMWa4z68nLEXnSeNuG0nAnXPmVd2s
         Nq15sfsFS7H7eg/VNt0xHyiQ6WiaGtuanAu0vl74vnI7FN1ngCDFUdV5SbReFZq+EvgA
         LiGGbRdONM/k0ziU75qrqWyhyWGOgJSrEw5xCedZQw1XrlUsHogHUU+up6QWTLui6JJP
         78CUHk2CJS/Ee2vef9FOJYQxuscGS4NTECBWBKe5wBxQJfbjvRxooEbrXaPdeMzqDNfA
         yOrhp77qknPcYUQ9WnRSc4IQg6hfyZSPxQX41YtYbvSzlxGLvbiYoq86SnwH2kxh1dh7
         iuLw==
X-Gm-Message-State: ANoB5pltBXOulq4+uVLbHZjibn51FMjCiZRf3dQtN4ECG0m4NmtuBjAR
        1ekGqSgonyGreQAZ1lj9zRTpr/WlYwh6yRNTaVYZvEHqbRxX4QqxKpqD0a7xLLZuqPDUBzzY2XG
        aApKfhCKZmPA8TlTHYF7HLf+I42Ef
X-Received: by 2002:a05:6214:1e2:b0:4b8:fbc8:594c with SMTP id c2-20020a05621401e200b004b8fbc8594cmr4180087qvu.61.1668720783479;
        Thu, 17 Nov 2022 13:33:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7GUQGzSuRb8meXTFVPjjz0QZ1OIpM/M/Y+skPofDCEJfsYqDG59yxNKsN4fDPGQ0ZyKA7lMw==
X-Received: by 2002:a05:6214:1e2:b0:4b8:fbc8:594c with SMTP id c2-20020a05621401e200b004b8fbc8594cmr4180070qvu.61.1668720783259;
        Thu, 17 Nov 2022 13:33:03 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm1184021qkb.46.2022.11.17.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:33:02 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:33:01 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH linux-next] selftests/vm: calculate variables in correct
 order
Message-ID: <Y3aojfUC2nSwbCzB@x1n>
References: <20221028132640.2791026-1-jsavitz@redhat.com>
 <20221108163124.a54f932f8f79f9c1d6e63903@linux-foundation.org>
 <CAL1p7m7Ar_DBbpLWuha8dPYKU3FjS6NyAROBa_PO6NKRgfuGxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+DsSjgx0E9gBsQRT"
Content-Disposition: inline
In-Reply-To: <CAL1p7m7Ar_DBbpLWuha8dPYKU3FjS6NyAROBa_PO6NKRgfuGxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--+DsSjgx0E9gBsQRT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Nov 16, 2022 at 08:09:11PM -0400, Joel Savitz wrote:
> However, I noticed that on the mm-everything branch, the hugepage-mmap test
> fails:
> 
> # ./run_vmtests.sh -t "hugetlb"
> running: ./hugepage-mmap
> -----------------------
> running ./hugepage-mmap
> -----------------------
> Open failed: No such file or directory
> [FAIL]
> ...
> 
> It appears this is due to commit 0796c7b8be84 ("selftests/vm: drop mnt
> point for hugetlb in run_vmtests.sh")
> as the test still replies on the ./huge mountpoint removed in that commit.
> The test passes before that patchset is applied.

Oops, sorry I totally overlooked this hard-coded test case using the
mntpoint.

Fix is simple though, which is attached.

-- 
Peter Xu

--+DsSjgx0E9gBsQRT
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-selftests-vm-use-memfd-for-hugepage-mmap-test.patch"

From 71da2480d4bac0fc598e4d1f05f71aba8b980bc4 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 Nov 2022 16:29:15 -0500
Subject: [PATCH] selftests/vm: use memfd for hugepage-mmap test
Content-type: text/plain

This test was overlooked with a hard-coded mntpoint path in test when we're
removing the hugetlb mntpoint in commit 0796c7b8be84.  Fix it up so the
test can keep running.

Reported-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/hugepage-mmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vm/hugepage-mmap.c b/tools/testing/selftests/vm/hugepage-mmap.c
index 93f9e7b81331..955ef87f382c 100644
--- a/tools/testing/selftests/vm/hugepage-mmap.c
+++ b/tools/testing/selftests/vm/hugepage-mmap.c
@@ -16,14 +16,13 @@
  * range.
  * Other architectures, such as ppc64, i386 or x86_64 are not so constrained.
  */
-
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 
-#define FILE_NAME "huge/hugepagefile"
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
 
@@ -67,16 +66,16 @@ int main(void)
 	void *addr;
 	int fd, ret;
 
-	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	fd = memfd_create("hugepage-mmap", MFD_HUGETLB);
 	if (fd < 0) {
-		perror("Open failed");
+		perror("memfd_create() failed");
 		exit(1);
 	}
 
 	addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, fd, 0);
 	if (addr == MAP_FAILED) {
 		perror("mmap");
-		unlink(FILE_NAME);
+		close(fd);
 		exit(1);
 	}
 
@@ -87,7 +86,6 @@ int main(void)
 
 	munmap(addr, LENGTH);
 	close(fd);
-	unlink(FILE_NAME);
 
 	return ret;
 }
-- 
2.37.3


--+DsSjgx0E9gBsQRT--

