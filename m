Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAB49E825
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiA0QzX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 11:55:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbiA0QzP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 11:55:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id F0AA71F45773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643302511;
        bh=IR+hQ8nqc1s+bwqn1CYzGcqjYCZ5s+1Hg5YXxfgNCQU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=odNleAWbEY6jGmxSQn9iWLi2MUGZyGk724Fafc4iDxJKp+kM6B2kom4xY+VaWrFjK
         4qb41sQh+pkg9w9aFlznhFLsG/jJE6CJPHWaHuYuLsRb4bpLRjtcdTbkYzJuo2WNND
         8zNX9Nh1xCS+f+hvM9PPjL8VKKyFna4x3iPV16Etfk0w+9ugpOGtsazFYNKIJsli6G
         aqFohSNsW++R6wPYGtcUrt636TUtOTdeROPbRE0vVNuwUA5QUzRcXAHERYBkXgIyZJ
         OjZwbEwN87EBmapx5Cx6+kH7rrOBLw/Lh4G50yERR45GDAwfI/Dbwql6cUV1g4oOmb
         TwXJS6d+XkkJA==
Message-ID: <329a935a-1c12-c5f8-1467-e6a6e98c9c24@collabora.com>
Date:   Thu, 27 Jan 2022 21:55:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Remove pipe from TEST_GEN_FILES
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
References: <20220127163346.653546-1-usama.anjum@collabora.com>
 <202201270844.660E5394C@keescook>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202201270844.660E5394C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 1/27/22 9:45 PM, Kees Cook wrote:
> On Thu, Jan 27, 2022 at 09:33:45PM +0500, Muhammad Usama Anjum wrote:
>> pipe named FIFO special file is being created in execveat.c to perform
>> some tests. Makefile doesn't need to do anything with the pipe. When it
>> isn't found, Makefile generates the following build error:
>>
>> make: *** No rule to make target '/linux_mainline/tools/testing/selftests/exec/pipe', needed by 'all'.  Stop.
> 
> Ah, good catch. However, I think this should be moved to EXTRA_CLEAN instead of
> only removed from TEST_GEN_FILES. (i.e. "pipe" is created by
> tools/testing/selftests/exec/execveat.c and should be removed.
Hi,

Thank you. tools/testing/selftests/exec/execveat.c creates pipe file and
removes it after performing the test on it. I've looked at the code path
between creation and deletion of this file. It'll always be removed
automatically. So we shouldn't add it to EXTRA_CLEAN.

Thanks,
Usama
