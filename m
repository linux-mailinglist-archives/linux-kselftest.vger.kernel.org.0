Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C6DE9FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJUKqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 06:46:04 -0400
Received: from [217.140.110.172] ([217.140.110.172]:48804 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJUKqE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 06:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 150EBEBD;
        Mon, 21 Oct 2019 03:45:29 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749B03F718;
        Mon, 21 Oct 2019 03:45:28 -0700 (PDT)
Subject: Re: [PATCH] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        Prabhakar Kushwaha <pkushwaha@marvell.com>
References: <20191020122452.3345-1-prabhakar.pkin@gmail.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <09db8f9d-98b9-e3ae-9eea-ae45e94d3053@arm.com>
Date:   Mon, 21 Oct 2019 11:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020122452.3345-1-prabhakar.pkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 20/10/2019 13:24, Prabhakar Kushwaha wrote:
> As per commit 131b30c94fbc ("kselftest: exclude failed TARGETS from
> runlist") failed targets were excluded from the runlist. But value
> $$INSTALL_PATH is always NULL. It should be $INSTALL_PATH instead
> $$INSTALL_PATH.
> 
> So, fix Makefile to use $INSTALL_PATH. 
> 

I was a bit puzzled at first since I never saw the NULLified value while testing
the original patch. Looking at it closely today, I realized that I used to test it
like:

$ rm -rf $HOME/KSFT_TEST && make -C tools/testing/selftests/ INSTALL_PATH=$HOME/KSFT_TEST install

which in fact causes INSTALL_PATH to be exported down to the subshell in the recipe, so that even
referring it as $$INSTALL_PATH from the recipe line make it work fine.

Instead, using the default Makefile provided value (unexported) by invoking like:

$ rm -rf $HOME/KSFT_TEST && make -C tools/testing/selftests/ install

exposes the error you mentioned, being INSTALL_PATH not accessible form the subshell and so NULL.
Moreover it's anyway certainly better to refer with $(INSTALL_PATH) being it a strict Makefile var.
So it's fine for me, thanks to have spotted this.

Reviewed-by: cristian.marussi@arm.com


Cristian


> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
> CC: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  tools/testing/selftests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 4cdbae6f4e61..612f6757015d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -213,7 +213,7 @@ ifdef INSTALL_PATH
>  	@# included in the generated runlist.
>  	for TARGET in $(TARGETS); do \
>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> +		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
>  		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
>  		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
>  		echo -n "run_many" >> $(ALL_SCRIPT); \
> 

