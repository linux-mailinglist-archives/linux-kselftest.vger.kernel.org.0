Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAC121B6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLPVB2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:01:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbfLPVB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576530086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2YGUzKWfrJlypL5f6IAP/q6Ohy4nUi/MZaE1v/sIbk=;
        b=SpEfYV/xOTN6evotg1IYegCzRBRWcvYOF/+yWjw8XOkhYyATs+AAh2GCxW3GnHGjn/08n9
        u+wKqDNPW4tC9VHO541aJPTBSp7WBp5Ki9QZMyBoAxPiKfsD3HaHo6PKwhs54BsuLvc0yM
        vHNHP1lLI1Z6m3+B7DrjSAPUAwGJTPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-7Pu4BB3xNt-Oq5fmzXLGmw-1; Mon, 16 Dec 2019 16:01:23 -0500
X-MC-Unique: 7Pu4BB3xNt-Oq5fmzXLGmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7611B801E70;
        Mon, 16 Dec 2019 21:01:21 +0000 (UTC)
Received: from redhat.com (dhcp-17-119.bos.redhat.com [10.18.17.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7479861351;
        Mon, 16 Dec 2019 21:01:20 +0000 (UTC)
Date:   Mon, 16 Dec 2019 16:01:18 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        pmladek@suse.com, shuah@kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: livepatch: Fix it to do root uid check and
 skip
Message-ID: <20191216210118.GA28841@redhat.com>
References: <20191216191840.15188-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216191840.15188-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 12:18:40PM -0700, Shuah Khan wrote:
> livepatch test configures the system and debug environment to run
> tests. Some of these actions fail without root access and test
> dumps several permission denied messages before it exits.
> 
> Fix test-state.sh to call setup_config instead of set_dynamic_debug
> as suggested by Petr Mladek <pmladek@suse.com>
> 
> Fix it to check root uid and exit with skip code instead.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/selftests/livepatch/functions.sh  | 15 ++++++++++++++-
>  tools/testing/selftests/livepatch/test-state.sh |  3 +--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 31eb09e38729..a6e3d5517a6f 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -7,6 +7,9 @@
>  MAX_RETRIES=600
>  RETRY_INTERVAL=".1"	# seconds
>  
> +# Kselftest framework requirement - SKIP code is 4
> +ksft_skip=4
> +
>  # log(msg) - write message to kernel log
>  #	msg - insightful words
>  function log() {
> @@ -18,7 +21,16 @@ function log() {
>  function skip() {
>  	log "SKIP: $1"
>  	echo "SKIP: $1" >&2
> -	exit 4
> +	exit $ksft_skip
> +}
> +
> +# root test
> +function is_root() {
> +	uid=$(id -u)
> +	if [ $uid -ne 0 ]; then
> +		echo "skip all tests: must be run as root" >&2
> +		exit $ksft_skip
> +	fi
>  }
>  
>  # die(msg) - game over, man
> @@ -62,6 +74,7 @@ function set_ftrace_enabled() {
>  #		 for verbose livepatching output and turn on
>  #		 the ftrace_enabled sysctl.
>  function setup_config() {
> +	is_root
>  	push_config
>  	set_dynamic_debug
>  	set_ftrace_enabled 1
> diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
> index dc2908c22c26..a08212708115 100755
> --- a/tools/testing/selftests/livepatch/test-state.sh
> +++ b/tools/testing/selftests/livepatch/test-state.sh
> @@ -8,8 +8,7 @@ MOD_LIVEPATCH=test_klp_state
>  MOD_LIVEPATCH2=test_klp_state2
>  MOD_LIVEPATCH3=test_klp_state3
>  
> -set_dynamic_debug
> -
> +setup_config
>  
>  # TEST: Loading and removing a module that modifies the system state
>  
> -- 
> 2.20.1
> 

Thanks for fixing these, Shuah.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

