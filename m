Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805C81317CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2020 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgAFSy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jan 2020 13:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgAFSy6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jan 2020 13:54:58 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995EF2070E;
        Mon,  6 Jan 2020 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578336897;
        bh=yVdtCtKT4wuNUclV+dp7A5m3+vWo+hXaOhVzb4vGJZs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pCkeZrlJvzfB8bumYbfPweUD3s/YmyupadzGUiQCATziose1uTbTNx0S8N+8uhBj3
         szoeKcBntLiyh7PM7NaZ4//cvaXZZckNRWoHTO3LmLgTXEAuQ9wqlpbn9dew6Kfo7e
         CYqIQ5U9wQCa5qSsiNt+uP9wnmMOESfiGsdJpOvs=
Subject: Re: [PATCH v6 linux-kselftest-test 0/6] kunit: support building
 core/tests as modules
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b03a80a8-c887-7d85-4ca5-92446ee28054@kernel.org>
Date:   Mon, 6 Jan 2020 11:54:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alan,

On 12/4/19 8:27 AM, Alan Maguire wrote:
> The current kunit execution model is to provide base kunit functionality
> and tests built-in to the kernel.  The aim of this series is to allow
> building kunit itself and tests as modules.  This in turn allows a
> simple form of selective execution; load the module you wish to test.
> In doing so, kunit itself (if also built as a module) will be loaded as
> an implicit dependency.
> 
> Because this requires a core API modification - if a module delivers
> multiple suites, they must be declared with the kunit_test_suites()
> macro - we're proposing this patch set as a candidate to be applied to the
> test tree before too many kunit consumers appear.  We attempt to deal
> with existing consumers in patch 3.
> 
> Changes since v5:
>   - fixed fs/ext4/Makefile to remove unneeded conditional compilation
>     (Iurii, patch 3)
>   - added Reviewed-by, Acked-by to patches 3, 4, 5 and 6
> 

Are you planning to send v7 to address the kbuild issue? I can pull
them in for 5.6

thanks,
-- Shuah
