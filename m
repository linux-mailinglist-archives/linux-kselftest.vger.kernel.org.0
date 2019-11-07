Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1112F296D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 09:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfKGIm1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 03:42:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46760 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbfKGIm1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 699D2B279;
        Thu,  7 Nov 2019 08:42:25 +0000 (UTC)
Date:   Thu, 7 Nov 2019 09:42:24 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
In-Reply-To: <20191106222801.7541-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1911070939040.7917@pobox.suse.cz>
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 Nov 2019, Joe Lawrence wrote:

> The livepatch selftests compare expected dmesg output to verify kernel
> behavior.  They currently filter out "tainting kernel with
> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> modules.
> 
> Further filter the log to also drop "loading out-of-tree module taints
> kernel" messages in case the klp_test modules have been build without
> the in-tree module flag.

That is true, but "tainting kernel with TAINT_LIVEPATCH" should be printed 
out even in this case. check_modinfo_livepatch() is called for all modules 
and relies on MODINFO(livepatch, Y).

So either the bug is elsewhere or I need one more cup of tea.

Miroslav
 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
> 
> Note: I stumbled across this in a testing scenario and thought it might
> be generally useful to extend this admittedly fragile mechanism.  Since
> there are no related livepatch-core changes, this can go through Shuah's
> kselftest tree if she prefers.  -- Joe
> 
>  tools/testing/selftests/livepatch/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 79b0affd21fb..57975c323542 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -221,7 +221,7 @@ function check_result {
>  	local expect="$*"
>  	local result
>  
> -	result=$(dmesg | grep -v 'tainting' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
> +	result=$(dmesg | grep -ve '\<taints\>' -ve '\<tainting\>' | grep -e 'livepatch:' -e 'test_klp' | sed 's/^\[[ 0-9.]*\] //')
>  
>  	if [[ "$expect" == "$result" ]] ; then
>  		echo "ok"
> -- 
> 2.21.0
> 

