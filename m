Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332E77F99E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352241AbjHQOsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352287AbjHQOs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 10:48:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BA23AA2;
        Thu, 17 Aug 2023 07:48:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2A61515;
        Thu, 17 Aug 2023 07:48:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3903F793;
        Thu, 17 Aug 2023 07:47:56 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:47:54 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: cachestat: test for cachestat
 availability
Message-ID: <20230817154754.278218ae@donnerap.manchester.arm.com>
In-Reply-To: <59c0fcd1-a1f2-de37-c94d-76687934acd5@linuxfoundation.org>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
        <20230815155612.2535947-4-andre.przywara@arm.com>
        <59c0fcd1-a1f2-de37-c94d-76687934acd5@linuxfoundation.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Aug 2023 11:11:49 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

Hi,

> On 8/15/23 09:56, Andre Przywara wrote:
> > As cachestat is a new syscall, it won't be available on older kernels,
> > for instance those running on a build machine. In this case, a run
> > reports all tests as "not ok" at the moment.
> > 
> > Test for the cachestat syscall availability first, before doing further
> > tests, and bail out early with a TAP SKIP comment.
> > 
> > This also uses the opportunity to add the proper TAP headers, and add
> > one check for the syscall error handling (illegal file descriptor).
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >   .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> > index a5a4ac8dcb76c..77620e7ecf562 100644
> > --- a/tools/testing/selftests/cachestat/test_cachestat.c
> > +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> > @@ -15,6 +15,8 @@
> >   
> >   #include "../kselftest.h"
> >   
> > +#define NR_TESTS	8
> > +
> >   static const char * const dev_files[] = {
> >   	"/dev/zero", "/dev/null", "/dev/urandom",
> >   	"/proc/version", "/proc"
> > @@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
> >   
> >   int main(void)
> >   {
> > -	int ret = 0;
> > +	int ret;
> > +
> > +	ksft_print_header();
> > +
> > +	ret = syscall(__NR_cachestat, -1, NULL, NULL, 0);
> > +	if (ret == -1 && errno == ENOSYS) {
> > +		printf("1..0 # Skipped: cachestat syscall not available\n");
> > +		return KSFT_SKIP;  
> What happens when other errors besides ENOSYS? The test shouldn't
> continue.

-1 is an illegal file descriptor, and this is checked below (still using
the same ret and errno), but reported using the normal framework.
This check above is done early, before we even announce the plan, so that
we can skip *all* of the tests, since they don't make any sense when the
syscall is not available at all.

Does that make sense?

Cheers,
Andre

> 
> > +	}
> > +
> > +	ksft_set_plan(NR_TESTS);
> > +
> > +	if (ret == -1 && errno == EBADF) {
> > +		ksft_test_result_pass("bad file descriptor recognized\n");
> > +		ret = 0;
> > +	} else {
> > +		ksft_test_result_fail("bad file descriptor ignored\n");
> > +		ret = 1;
> > +	}
> >   
> >   	for (int i = 0; i < 5; i++) {
> >   		const char *dev_filename = dev_files[i];  
> 
> thanks,
> -- Shuah

