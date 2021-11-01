Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9944418FA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKAJxz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 05:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234552AbhKAJvD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 05:51:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A9761503;
        Mon,  1 Nov 2021 09:32:21 +0000 (UTC)
Date:   Mon, 1 Nov 2021 10:32:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/core: fix conflicting types compile error for
 close_range()
Message-ID: <20211101093218.2qxflsxch3slvp5y@wittgenstein>
References: <20211027192619.21813-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211027192619.21813-1-skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 27, 2021 at 01:26:19PM -0600, Shuah Khan wrote:
> close_range() test type conflicts with close_range() library call in
> x86_64-linux-gnu/bits/unistd_ext.h. Fix it by changing the name to
> core_close_range().
> 
> gcc -g -I../../../../usr/include/    close_range_test.c  -o ../tools/testing/selftests/core/close_range_test
> In file included from close_range_test.c:16:
> close_range_test.c:57:6: error: conflicting types for ‘close_range’; have ‘void(struct __test_metadata *)’
>    57 | TEST(close_range)
>       |      ^~~~~~~~~~~
> ../kselftest_harness.h:181:21: note: in definition of macro ‘__TEST_IMPL’
>   181 |         static void test_name(struct __test_metadata *_metadata); \
>       |                     ^~~~~~~~~
> close_range_test.c:57:1: note: in expansion of macro ‘TEST’
>    57 | TEST(close_range)
>       | ^~~~
> In file included from /usr/include/unistd.h:1204,
>                  from close_range_test.c:13:
> /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:56:12: note: previous declaration of ‘close_range’ with type ‘int(unsigned int,  unsigned int,  int)’
>    56 | extern int close_range (unsigned int __fd, unsigned int __max_fd,
>       |            ^~~~~~~~~~~
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---

Looks good. thank you!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
