Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B0BE5C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 21:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392351AbfIYTgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 15:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392365AbfIYTgp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 15:36:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096CF21D7A;
        Wed, 25 Sep 2019 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569440204;
        bh=5Gm1h33RuHVX6DX/tp8dYOGoNk7nNRxZvLsX8xAjiEs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g/W0J48ReDDn0f5ap0TBcejsFoEq5uE4KOq9RcgbdS6bW5GjlIhhr4cl3ILlNEhKA
         Mv4aWCMhOSxQHTwoneDcE4pm7/7W3F5e1J5jGCINyLsxfbpYBLD9L9yE9+yQfdpmHT
         QP19hWhnnLIcHBynngLmRdgaY8//nOKvd1oG+ubY=
Subject: Re: [PATCH 2/2] kselftest: exclude failed TARGETS from runlist
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dave.martin@arm.com, shuah <shuah@kernel.org>
References: <20190925132421.23572-1-cristian.marussi@arm.com>
 <20190925132421.23572-2-cristian.marussi@arm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ca1c013b-4f8f-fe63-a6d1-008d961416e3@kernel.org>
Date:   Wed, 25 Sep 2019 13:36:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925132421.23572-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/19 7:24 AM, Cristian Marussi wrote:
> A TARGET which failed to be built/installed should not be included in the
> runlist generated inside the run_kselftest.sh script.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> As an example, here BPF failed to compile but was included in the runlist
> and attempted to run anyway:
> 
> ...
> ./KSFT_LAST_2/run_kselftest.sh: 37: cd: can't cd to bpf
> TAP version 13
> 1..49
> \# selftests: KSFT_LAST_2: test_verifier
> \# Warning: file test_verifier is missing!
> not ok 1 selftests: KSFT_LAST_2: test_verifier
> \# selftests: KSFT_LAST_2: test_tag
> \# Warning: file test_tag is missing!
> ---
>   tools/testing/selftests/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 103936faa46d..e11ace11b07c 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -202,8 +202,12 @@ ifdef INSTALL_PATH
>   	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
>   	echo "fi" >> $(ALL_SCRIPT)
>   
> +	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
> +	@# they could be the result of a build failure and should NOT be
> +	@# included in the generated runlist.
>   	for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> +		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
>   		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
>   		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
>   		echo -n "run_many" >> $(ALL_SCRIPT); \
> 

This is great. Thanks for the patch.

-- Shuah
