Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13321F62BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgFKHiG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 03:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:45136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHiG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 03:38:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50FE3B203;
        Thu, 11 Jun 2020 07:38:08 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:38:04 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running
 tests
In-Reply-To: <20200610172101.21910-2-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2006110930590.32091@pobox.suse.cz>
References: <20200610172101.21910-1-joe.lawrence@redhat.com> <20200610172101.21910-2-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Wed, 10 Jun 2020, Joe Lawrence wrote:

> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> index 32b57ba07f4f..c3d949da5bb7 100755
> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -12,7 +12,7 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
>  setup_config
>  
>  
> -# TEST: target module before livepatch
> +start_test "target module before livepatch"
>  #
>  # Test a combination of loading a kernel module and a livepatch that
>  # patches a function in the first module.  Load the target module
> @@ -28,9 +28,6 @@ setup_config
>  #   unpatching transition starts.  klp_objects are reverted, post-patch
>  #   callbacks execute and the transition completes.
>  
> -echo -n "TEST: target module before livepatch ... "
> -dmesg -C
> -

A nit, but I think it would be better to place start_test here below the 
comment. The same for other occurrences in test-callbacks.sh.

[...]

> diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
> index a08212708115..bf8db1613961 100755
> --- a/tools/testing/selftests/livepatch/test-state.sh
> +++ b/tools/testing/selftests/livepatch/test-state.sh
> @@ -10,10 +10,7 @@ MOD_LIVEPATCH3=test_klp_state3
>  
>  setup_config
>  
> -# TEST: Loading and removing a module that modifies the system state
> -
> -echo -n "TEST: system state modification ... "
> -dmesg -C
> +start_test "Loading and removing a module that modifies the system state"

start_test should get the message from the original echo command and not 
the comment above, I think...

>  load_lp $MOD_LIVEPATCH
>  disable_lp $MOD_LIVEPATCH
> @@ -41,10 +38,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
>  % rmmod $MOD_LIVEPATCH"
>  
>  
> -# TEST: Take over system state change by a cumulative patch
> -
> -echo -n "TEST: taking over system state modification ... "
> -dmesg -C
> +start_test "Take over system state change by a cumulative patch"
>  
>  load_lp $MOD_LIVEPATCH
>  load_lp $MOD_LIVEPATCH2
> @@ -85,10 +79,7 @@ livepatch: '$MOD_LIVEPATCH2': unpatching complete
>  % rmmod $MOD_LIVEPATCH2"
>  
>  
> -# TEST: Take over system state change by a cumulative patch
> -
> -echo -n "TEST: compatible cumulative livepatches ... "
> -dmesg -C
> +start_test "Take over system state change by a cumulative patch"

...because now we have two "Take over system state change by a cumulative 
patch" tests in the log.

Miroslav
