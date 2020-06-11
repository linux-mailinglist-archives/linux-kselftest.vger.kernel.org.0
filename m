Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398C31F68C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgFKNGz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 09:06:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgFKNGu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 09:06:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E5F1AECB;
        Thu, 11 Jun 2020 13:06:52 +0000 (UTC)
Date:   Thu, 11 Jun 2020 15:06:48 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/livepatch: Don't clear dmesg when running
 tests
In-Reply-To: <f08eb372-0282-7d07-180f-ff0d7220708b@redhat.com>
Message-ID: <alpine.LSU.2.21.2006111505480.32091@pobox.suse.cz>
References: <20200610172101.21910-1-joe.lawrence@redhat.com> <20200610172101.21910-2-joe.lawrence@redhat.com> <alpine.LSU.2.21.2006110930590.32091@pobox.suse.cz> <f08eb372-0282-7d07-180f-ff0d7220708b@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 11 Jun 2020, Joe Lawrence wrote:

> On 6/11/20 3:38 AM, Miroslav Benes wrote:
> > Hi,
> > 
> > On Wed, 10 Jun 2020, Joe Lawrence wrote:
> > 
> >> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh
> >> b/tools/testing/selftests/livepatch/test-callbacks.sh
> >> index 32b57ba07f4f..c3d949da5bb7 100755
> >> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> >> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> >> @@ -12,7 +12,7 @@ MOD_TARGET_BUSY=test_klp_callbacks_busy
> >>   setup_config
> >>   
> >>   
> >> -# TEST: target module before livepatch
> >> +start_test "target module before livepatch"
> >>   #
> >>   # Test a combination of loading a kernel module and a livepatch that
> >>   # patches a function in the first module.  Load the target module
> >> @@ -28,9 +28,6 @@ setup_config
> >>   #   unpatching transition starts.  klp_objects are reverted, post-patch
> >>   #   callbacks execute and the transition completes.
> >>   
> >> -echo -n "TEST: target module before livepatch ... "
> >> -dmesg -C
> >> -
> > 
> > A nit, but I think it would be better to place start_test here below the
> > comment. The same for other occurrences in test-callbacks.sh.
> > 
> 
> The idea was to remove the duplicate # TEST: comment and then the same echo -n
> "TEST: ..." entries.
> 
> Would it still look okay if we move start_test to below the comment and omit
> that # TEST ... part?  (This might be what you're suggesting, but I wanted to
> make sure.)

Yes, that is what I meant. I am sorry because it was not clear.

Thanks
Miroslav
