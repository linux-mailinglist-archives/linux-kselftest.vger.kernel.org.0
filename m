Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C476F26B0EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIOWV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 18:21:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgIOQ0Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 12:26:25 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kIDlp-0008Gy-Hv; Tue, 15 Sep 2020 16:25:29 +0000
Date:   Tue, 15 Sep 2020 18:25:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 14/15] selftests/clone3: Avoid OS-defined clone_args
Message-ID: <20200915162528.x7admy45pdqsoke4@wittgenstein>
References: <20200912110820.597135-1-keescook@chromium.org>
 <20200912110820.597135-15-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200912110820.597135-15-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 12, 2020 at 04:08:19AM -0700, Kees Cook wrote:
> As the UAPI headers start to appear in distros, we need to avoid
> outdated versions of struct clone_args to be able to test modern
> features. Additionally pull in the syscall numbers correctly.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Hm, with this patch applied I'm getting:

gcc -g -I../../../../usr/include/    clone3_set_tid.c /home/brauner/src/git/linux/linux/tools/testing/selftests/kselftest_harness.h /home/brauner/src/git/linux/linux/tools/testing/selftests/kselftest.h -lcap -o /home/brauner/src/git/linux/linux/tools/testing/selftests/clone3/clone3_set_tid
In file included from clone3_set_tid.c:24:
clone3_selftests.h:37:8: error: redefinition of ‘struct clone_args’
   37 | struct clone_args {
      |        ^~~~~~~~~~
In file included from clone3_set_tid.c:12:
/usr/include/linux/sched.h:92:8: note: originally defined here
   92 | struct clone_args {
      |        ^~~~~~~~~~
make: *** [../lib.mk:140: /home/brauner/src/git/linux/linux/tools/testing/selftests/clone3/clone3_set_tid] Error 1

One trick to avoid this could be:

#ifndef CLONE_ARGS_SIZE_VER0
#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
#endif

#ifndef CLONE_ARGS_SIZE_VER1
#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
#endif

#ifndef CLONE_ARGS_SIZE_VER2
#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
#endif

struct __clone_args {
	__aligned_u64 flags;
	__aligned_u64 pidfd;
	__aligned_u64 child_tid;
	__aligned_u64 parent_tid;
	__aligned_u64 exit_signal;
	__aligned_u64 stack;
	__aligned_u64 stack_size;
	__aligned_u64 tls;
	__aligned_u64 set_tid;
	__aligned_u64 set_tid_size;
	__aligned_u64 cgroup;
};

static pid_t sys_clone3(struct __clone_args *args, size_t size)
{
	return syscall(__NR_clone3, args, size);
}

Christian
