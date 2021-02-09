Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16095314EE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBIMaw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 07:30:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhBIMav (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 07:30:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26F8DADE1;
        Tue,  9 Feb 2021 12:30:08 +0000 (UTC)
Subject: Re: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210209071034.3268897-1-davidgow@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <91207d64-e50f-872d-10db-55153da41aec@suse.cz>
Date:   Tue, 9 Feb 2021 13:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209071034.3268897-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/9/21 8:10 AM, David Gow wrote:
> kunit_tool maintains a list of config options which are broken under
> UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
> build used to run all tests with the --alltests option.
> 
> Something in UML allyesconfig is causing segfaults when page poisining
> is enabled (and is poisoning with a non-zero value). Previously, this
> didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
> option, which worked around the problem by zeroing memory. This option
> has since been removed, and memory is now poisoned with 0xAA, which
> triggers segfaults in many different codepaths, preventing UML from
> booting.
> 
> Note that we have to disable both CONFIG_PAGE_POISONING and
> CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
> architectures (such as UML) which don't implement __kernel_map_pages().
> 
> Ideally, we'd fix this properly by tracking down the real root cause,
> but since this is breaking KUnit's --alltests feature, it's worth
> disabling there in the meantime so the kernel can boot to the point
> where tests can actually run.

Agree on both arguments :)

> Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

...

> Disabling PAGE_POISONING fixes this. The issue can't be repoduced with
> just PAGE_POISONING, there's clearly something (or several things) also
> enabled by allyesconfig which contribute. Ideally, we'd track these down
> and fix this at its root cause, but in the meantime it'd be nice to
> disable PAGE_POISONING so we can at least get the kernel to boot. One
> way would be to add a 'depends on !UML' or similar, but since
> PAGE_POISONING does seem to work in the non-allyesconfig case, adding it
> to our list of broken configs seemed the better choice.
> 
> Thoughts?

Agreed that it's better to use kunit-specific config file instead of introducing
such workaround dependencies in Kconfig proper.

> (Note that to reproduce this, you'll want to run
> ./tools/testing/kunit/kunit.py run --alltests --raw_output
> It also depends on a couple of other fixes which are not upstream yet:
> https://www.spinics.net/lists/linux-rtc/msg08294.html
> https://lore.kernel.org/linux-i3c/20210127040636.1535722-1-davidgow@google.com/
> 
> Cheers,
> -- David
> 
>  tools/testing/kunit/configs/broken_on_uml.config | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
> index a7f0603d33f6..690870043ac0 100644
> --- a/tools/testing/kunit/configs/broken_on_uml.config
> +++ b/tools/testing/kunit/configs/broken_on_uml.config
> @@ -40,3 +40,5 @@
>  # CONFIG_RESET_BRCMSTB_RESCAL is not set
>  # CONFIG_RESET_INTEL_GW is not set
>  # CONFIG_ADI_AXI_ADC is not set
> +# CONFIG_DEBUG_PAGEALLOC is not set
> +# CONFIG_PAGE_POISONING is not set
> 

