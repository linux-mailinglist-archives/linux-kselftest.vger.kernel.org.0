Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667CF127195
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLSXha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Dec 2019 18:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfLSXh3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Dec 2019 18:37:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB42D21655;
        Thu, 19 Dec 2019 23:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576798649;
        bh=TVRQG3kGxLcaflQgexfZOzjAw+ucRl9lCwZ7Ly95CtY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c/9erncIOl5W9NMWTGV+g2E3/pQsO8n6Z6XosU2vbFLwES50WxbczRWZKaz9BlTep
         Sl0cB+CPiHUJWUMzWBsvmw6U5n/ji8i1YUnRsNTj/PdWA8SB70FnC/tmPFkJXeaejn
         Mr4EmUlRr78pEmFT1jEMAvoRGIn81+GIP0jidRjU=
Subject: Re: [PATCH v6 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>, brendanhiggins@google.com
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sjpark@amazon.de,
        shuah <shuah@kernel.org>
References: <20191212022711.10062-1-sjpark@amazon.de>
From:   shuah <shuah@kernel.org>
Message-ID: <13f1203e-030d-699e-d12d-d9fea335ca36@kernel.org>
Date:   Thu, 19 Dec 2019 16:37:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/11/19 7:27 PM, SeongJae Park wrote:
> This patchset contains trivial fixes for the kunit documentations and
> the wrapper python scripts.
> 
> 
> Baseline
> --------
> 
> This patchset is based on 'kselftest/fixes' branch of
> linux-kselftest[1].  A complete tree is available at my repo:
> https://github.com/sjp38/linux/tree/kunit_fix/20191205_v6
> 
> 
> Version History
> ---------------
> 
> Changes from v5
> (https://lore.kernel.org/linux-kselftest/20191205093440.21824-1-sjpark@amazon.com):
>   - Rebased on kselftest/fixes
>   - Add 'Reviewed-by' and 'Tested-by' from Brendan Higgins
> 
> Changes from v4
> (https://lore.kernel.org/linux-doc/1575490683-13015-1-git-send-email-sj38.park@gmail.com/):
>   - Rebased on Heidi Fahim's patch[2]
>   - Fix failing kunit_tool_test test
>   - Add 'build_dir' option test in 'kunit_tool_test.py'
> 
> Changes from v3
> (https://lore.kernel.org/linux-kselftest/20191204192141.GA247851@google.com):
>   - Fix the 4th patch, "kunit: Place 'test.log' under the 'build_dir'" to
>     set default value of 'build_dir' as '' instead of NULL so that kunit
>     can run even though '--build_dir' option is not given.
> 
> Changes from v2
> (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com):
>   - Make 'build_dir' if not exists (missed from v3 by mistake)
> 
> Changes from v1
> (https://lore.kernel.org/linux-doc/1575242724-4937-1-git-send-email-sj38.park@gmail.com):
>   - Remove "docs/kunit/start: Skip wrapper run command" (A similar
>     approach is ongoing)
>   - Make 'build_dir' if not exists
> 
> SeongJae Park (6):
>    docs/kunit/start: Use in-tree 'kunit_defconfig'
>    kunit: Remove duplicated defconfig creation
>    kunit: Create default config in '--build_dir'
>    kunit: Place 'test.log' under the 'build_dir'
>    kunit: Rename 'kunitconfig' to '.kunitconfig'
>    kunit/kunit_tool_test: Test '--build_dir' option run
> 
>   Documentation/dev-tools/kunit/start.rst | 13 +++++--------
>   tools/testing/kunit/kunit.py            | 18 +++++++++++-------
>   tools/testing/kunit/kunit_kernel.py     | 10 +++++-----
>   tools/testing/kunit/kunit_tool_test.py  | 10 +++++++++-
>   4 files changed, 30 insertions(+), 21 deletions(-)
> 

Hi SeongJae Park,

Please make sure your From and Signed-off-by addresses match. I tried
applying these patches and I am seeing warnings.

WARNING: Missing Signed-off-by: line by nominal patch author 'SeongJae 
Park <sj38.park@gmail.com>'

thanks,
-- Shuah
