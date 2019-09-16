Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40564B3F35
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfIPQsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390140AbfIPQsj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:48:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659D2214D9;
        Mon, 16 Sep 2019 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568652518;
        bh=9IgIL3nTOl+AnAnycBph4EY1UvcF4YxY8jH5un/5EXI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VodzYAg+UfPWq3WKHJnIejPR+sXO1G3gL05enYHwjXQdmy157ZCKabefl3UKdQ+pj
         08IHFY3fe3j/9u/A4KTLjoPITPjFJRQuBt8lHDKCcK2jMZRCdj/op5ySrIs4D7Bk4s
         toGVj5lFUB8wGCmy0tJguhSo7eXw1sM1kqg5lqRA=
Subject: Re: [PATCH 6/6] selftests: add clone3 to TARGETS
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <af8501d68f99c38232f9c462877ff562011c8bb5.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8bbd08bf-3500-40c7-ca15-06d0c84b596f@kernel.org>
Date:   Mon, 16 Sep 2019 10:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af8501d68f99c38232f9c462877ff562011c8bb5.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> * tools/testing/selftests/Makefile (TARGETS): Add clone3.

Again. No filenames in the commit log. Please add more detail.


"Adding clone3() tests to kselftest default run and details
on what this tests"

This will be helpful to users.

> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 25b43a8c..05163e4 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -4,6 +4,7 @@ TARGETS += bpf
>   TARGETS += breakpoints
>   TARGETS += capabilities
>   TARGETS += cgroup
> +TARGETS += clone3
>   TARGETS += cpufreq
>   TARGETS += cpu-hotplug
>   TARGETS += drivers/dma-buf
> 

Please make sure the test doesn't hang and all the use-cases listed
in the kselftest.rst are supported.

make kselftest
make -C tools/testing/selftests
O= and KBUILD_OUTPUT cases as well as running make directly
in the clode3 dir.

Please include test output and usage instructions if any to this
commit log as this is the patch that enables it in the default run.

thanks,
-- Shuah
