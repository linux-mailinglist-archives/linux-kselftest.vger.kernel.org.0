Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D95B2A11
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 01:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIHXTr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHXTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 19:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255D22298;
        Thu,  8 Sep 2022 16:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA9E61E2C;
        Thu,  8 Sep 2022 23:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F44C433C1;
        Thu,  8 Sep 2022 23:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662679183;
        bh=iOyyWbAaz1hh5SNuHyuGAi6HyRZtoAMjl33qrdVB8kY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCev5ieZ7COM056f56yk/NxR7hauUKJYz4b3Ci3rbhk/jRE8V6Jw8pC4lYio8iVc0
         3FI41qWJQIcojQ6rAiYdFrNf/515IGYeTLD8D7kASVLTSQz+kE7aLvKcSSPzabUXZo
         PkVolO1I+hOsAyNo+BrHTZcemvWQapeQrISaVnwGZMMdAUufxyf/6pkx7oI6jgHhXo
         maZwzIaVUETjmvjPt1ks84Ax0QuA4WNl9O/SNHR2VZmQCK/seM31upXfHw7F5AUMpi
         QajG2XVQsqFkLceKgLrSwwyKo0Zc0DiHIPfUderNTU9oX9fNHaSJ+aIpkXsPyY7OhJ
         jnPgTzfq0OqeA==
Date:   Fri, 9 Sep 2022 02:19:36 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] selftests/sgx: Retry the ioctl()'s returned with
 EAGAIN
Message-ID: <Yxp4iIKjOQflQC2i@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
 <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022 at 03:43:06PM -0700, Reinette Chatre wrote:
> Hi Jarkko and Haitao,
> 
> On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> > From: Haitao Huang <haitao.huang@linux.intel.com>
> > 
> > For EMODT and EREMOVE ioctl()'s with a large range, kernel
> > may not finish in one shot and return EAGAIN error code
> > and count of bytes of EPC pages on that operations are
> > finished successfully.
> > 
> > Change the unclobbered_vdso_oversubscribed_remove test
> > to rerun the ioctl()'s in a loop, updating offset and length
> > using the byte count returned in each iteration.
> > 
> > Fixes: 6507cce561b4 ("selftests/sgx: Page removal stress test")
> 
> Should this patch be moved to the "critical fixes for v6.0" series?

I think not because it does not risk stability of the
kernel itself. It's "nice to have" but not mandatory.

> 
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3:
> > * Added a fixes tag. The bug is in v6.0 patches.
> > * Added my tested-by (the bug reproduced in my NUC often).
> > v2:
> > * Changed branching in EAGAIN condition so that else branch
> >   is not required.
> > * Addressed Reinette's feedback:
> > ---
> >  tools/testing/selftests/sgx/main.c | 42 ++++++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 9820b3809c69..59cca806eda1 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -390,6 +390,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
> >  	struct encl_segment *heap;
> >  	unsigned long total_mem;
> >  	int ret, errno_save;
> > +	unsigned long count;
> >  	unsigned long addr;
> >  	unsigned long i;
> >  
> > @@ -453,16 +454,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
> >  	modt_ioc.offset = heap->offset;
> >  	modt_ioc.length = heap->size;
> >  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
> > -
> > +	count = 0;
> >  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
> >  	       heap->size);
> > -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> > -	errno_save = ret == -1 ? errno : 0;
> > +	do {
> > +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> > +
> > +		errno_save = ret == -1 ? errno : 0;
> > +		if (errno_save != EAGAIN)
> > +			break;
> > +
> > +		EXPECT_EQ(modt_ioc.result, 0);
> 
> If this check triggers then there is something seriously wrong and in that case
> it may also be that this loop may be unable to terminate or the error condition would
> keep appearing until the loop terminates (which may be many iterations). Considering
> the severity and risk I do think that ASSERT_EQ() would be more appropriate,
> similar to how ASSERT_EQ() is used in patch 5/5.
> 
> Apart from that I think that this looks good.
> 
> Thank you very much for adding this.
> 
> Reinette

Hmm... I could along the lines:

/*
 * Get time since Epoch is milliseconds.
 */
unsigned long get_time(void)
{
    struct timeval start;

    gettimeofday(&start, NULL);

    return (unsigneg long)start.tv_sec * 1000L + (unsigned long)start.tv_usec / 1000L;
}

and

#define IOCTL_RETRY_TIMEOUT 100

In the test function:

        unsigned long start_time;

        /* ... */

        start_time = get_time();
        do {
                EXPECT_LT(get_time() - start_time(), IOCTL_RETRY_TIMEOUT);

                /* ... */
        }

        /* ... */

What do you think?

BR, Jarkko
