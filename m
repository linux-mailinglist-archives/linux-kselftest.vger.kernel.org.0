Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7371C40
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfGWPyH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 11:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbfGWPyH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 11:54:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D62B206B8;
        Tue, 23 Jul 2019 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563897246;
        bh=b6VnbTtD9IPzYVY1gRe1ylhiT1DaFR8zYW6Mgy/1M5g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HZW3ipDkg/rCQkwYFSg/p8M7yS4JETGblrZ2mLlYY9+sRerNyPgapoTonQy8e0rOX
         ir/FEfIPI9XZ/QYNERNBFpabjTf4vObUkfU0eDN25EAeVMuw6qF+9h9yX4+y9CeBal
         EXjukEEejkNYMqMhI58CORLgs8F40MxS7GK5Z1PU=
Subject: Re: [PATCH v3] selftests/livepatch: add test skip handling
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>
References: <20190722140544.29867-1-joe.lawrence@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e450e2ec-b683-f712-c8d5-ef1c2e2dee7c@kernel.org>
Date:   Tue, 23 Jul 2019 09:53:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722140544.29867-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Joe,

On 7/22/19 8:05 AM, Joe Lawrence wrote:
> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
> 
> v3: tweak modprobe error message: check kernel config and run as root,
> so output now looks like [shuah] :
> 

Couple of small tweaks to user visible message below.

>    % make run_tests
>    TAP version 13
>    1..3
>    # selftests: livepatch: test-livepatch.sh
>    # TEST: basic function patching ... SKIP: unable load module test_klp_livepatch, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root
>    not ok 1 selftests: livepatch: test-livepatch.sh # SKIP

unable to

>    # selftests: livepatch: test-callbacks.sh
>    # TEST: target module before livepatch ... SKIP: unable load module test_klp_callbacks_mod, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root

unable to

>    not ok 2 selftests: livepatch: test-callbacks.sh # SKIP
>    # selftests: livepatch: test-shadow-vars.sh
>    # TEST: basic shadow variable API ... SKIP: unable load module test_klp_shadow_vars, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root
> 

unable to

thanks for taking care of this.

-- Shuah
