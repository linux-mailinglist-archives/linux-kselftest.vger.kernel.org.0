Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC31F62C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgFKHjR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 03:39:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHjR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 03:39:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE510B2F0;
        Thu, 11 Jun 2020 07:39:19 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:39:15 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
In-Reply-To: <20200610172101.21910-4-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
References: <20200610172101.21910-1-joe.lawrence@redhat.com> <20200610172101.21910-4-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 10 Jun 2020, Joe Lawrence wrote:

> The livepatch selftests currently filter out "tainting kernel with
> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> modules.
> 
> Further filter the log to drop "loading out-of-tree module taints
> kernel" in the rare case the klp_test modules have been built
> out-of-tree.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  tools/testing/selftests/livepatch/functions.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 83560c3df2ee..f5d4ef12f1cb 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -260,7 +260,8 @@ function check_result {
>  	local result
>  
>  	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
> -		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
> +		 grep -e '^livepatch:' -e 'test_klp' | \
> +		 grep -ve '\<taints\>' -ve '\<tainting\>')

or make it just 'grep -v 'taint' ? It does not matter much though.

Miroslav
