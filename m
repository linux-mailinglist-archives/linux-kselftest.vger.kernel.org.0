Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10576A94C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfGPNNC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 09:13:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfGPNNC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 09:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3318DAFCC;
        Tue, 16 Jul 2019 13:13:01 +0000 (UTC)
Date:   Tue, 16 Jul 2019 15:13:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: add test skip handling
Message-ID: <20190716131300.a6y4klluz2xgmtdh@pathway.suse.cz>
References: <20190714142829.29458-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714142829.29458-1-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 2019-07-14 10:28:29, Joe Lawrence wrote:
> Before running a livpeatch self-test, first verify that we've built and
> installed the livepatch self-test kernel modules by running a 'modprobe
> --dry-run'.  This should catch a few environment issues, including
> !CONFIG_LIVEPATCH and !CONFIG_TEST_LIVEPATCH.  In these cases, exit
> gracefully with test-skip status rather than test-fail status.
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 30195449c63c..92d6cfb49365 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -13,6 +13,14 @@ function log() {
>  	echo "$1" > /dev/kmsg
>  }
>  
> +# skip(msg) - testing can't proceed
> +#	msg - explanation
> +function skip() {
> +	log "SKIP: $1"
> +	echo "SKIP: $1" >&2
> +	exit 4
> +}
> +
>  # die(msg) - game over, man
>  #	msg - dying words
>  function die() {
> @@ -43,6 +51,16 @@ function loop_until() {
>  	done
>  }
>  
> +function assert_mod() {
> +	local mod="$1"
> +
> +	if ! modprobe --dry-run "$mod" &>/dev/null ; then

JFYI, I do not have strong opinion but the long option and redirection
looks fine to me.

> +		skip "Failed modprobe --dry-run of module: $mod"
> +	fi
> +
> +	return 1

return 0 or nothing?

> +}
> +
>  function is_livepatch_mod() {
>  	local mod="$1"
>  
> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> index e97a9dcb73c7..87a407cee7fd 100755
> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -9,6 +9,11 @@ MOD_LIVEPATCH2=test_klp_callbacks_demo2
>  MOD_TARGET=test_klp_callbacks_mod
>  MOD_TARGET_BUSY=test_klp_callbacks_busy
>  
> +assert_mod $MOD_LIVEPATCH
> +assert_mod $MOD_LIVEPATCH2
> +assert_mod $MOD_TARGET
> +assert_mod $MOD_TARGET_BUSY

I agree that moving this into __load_mod() is less error prone.

Best Regards,
Petr
