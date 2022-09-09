Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449535B2D34
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 06:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIIEBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIIEBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 00:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7837D074A;
        Thu,  8 Sep 2022 21:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A80161E35;
        Fri,  9 Sep 2022 04:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16162C433C1;
        Fri,  9 Sep 2022 04:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662696103;
        bh=9PLi232bcOnEaVbw2xQNicyLAvrsStubFpd3g24HjS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKjmeoR2dbaaPj+sb57Jx3PPxOKZQnISq6tuHl3KURjplc474Wsl+FG1myLQNQq7k
         vn+heCFNH8b+vdX1bDyNTmOZoG5Q2kzAxb8+kjed/itQsRlOg5iJE10lanYcUjyqkb
         RMtXLmRMhhz3BWiUmEJQMe/mCAK7mYZnjk4BjrxbzSuXlCDyhTnd5/AF8bGcFewTI3
         kNhgzS/EOHbxrAzMUnhPkxFCaFUmzWtDJqgjMF8kfpYEC4LSHh7fgDvqgjIsJ38cvm
         gpCbQ+FqkQTsgzcmPaFmWnD7aEZMLRtiYwMADhEpdeoldiF33ZuM1rFE1OpGy9oiHm
         gA5QrYY6nRKdg==
Date:   Fri, 9 Sep 2022 07:01:36 +0300
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
Message-ID: <Yxq6oAcGkg33tkb8@kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-2-jarkko@kernel.org>
 <fe0e7a0c-da41-5918-6ef4-8906598998a6@intel.com>
 <Yxp4iIKjOQflQC2i@kernel.org>
 <d2cccc58-b6b2-4153-0c1b-8d5b39ca0862@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2cccc58-b6b2-4153-0c1b-8d5b39ca0862@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022 at 05:06:58PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 9/8/2022 4:19 PM, Jarkko Sakkinen wrote:
> > On Thu, Sep 08, 2022 at 03:43:06PM -0700, Reinette Chatre wrote:
> >> Hi Jarkko and Haitao,
> >>
> >> On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> >>> From: Haitao Huang <haitao.huang@linux.intel.com>
> >>>
> >>> For EMODT and EREMOVE ioctl()'s with a large range, kernel
> >>> may not finish in one shot and return EAGAIN error code
> >>> and count of bytes of EPC pages on that operations are
> >>> finished successfully.
> >>>
> >>> Change the unclobbered_vdso_oversubscribed_remove test
> >>> to rerun the ioctl()'s in a loop, updating offset and length
> >>> using the byte count returned in each iteration.
> >>>
> >>> Fixes: 6507cce561b4 ("selftests/sgx: Page removal stress test")
> >>
> >> Should this patch be moved to the "critical fixes for v6.0" series?
> > 
> > I think not because it does not risk stability of the
> > kernel itself. It's "nice to have" but not mandatory.
> 
> ok, thank you for considering it.
> 
> ...
> 
> >>> @@ -453,16 +454,30 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
> >>>  	modt_ioc.offset = heap->offset;
> >>>  	modt_ioc.length = heap->size;
> >>>  	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
> >>> -
> >>> +	count = 0;
> >>>  	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
> >>>  	       heap->size);
> >>> -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> >>> -	errno_save = ret == -1 ? errno : 0;
> >>> +	do {
> >>> +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> >>> +
> >>> +		errno_save = ret == -1 ? errno : 0;
> >>> +		if (errno_save != EAGAIN)
> >>> +			break;
> >>> +
> >>> +		EXPECT_EQ(modt_ioc.result, 0);
> >>
> >> If this check triggers then there is something seriously wrong and in that case
> >> it may also be that this loop may be unable to terminate or the error condition would
> >> keep appearing until the loop terminates (which may be many iterations). Considering
> >> the severity and risk I do think that ASSERT_EQ() would be more appropriate,
> >> similar to how ASSERT_EQ() is used in patch 5/5.
> >>
> >> Apart from that I think that this looks good.
> >>
> >> Thank you very much for adding this.
> >>
> >> Reinette
> > 
> > Hmm... I could along the lines:
> > 
> > /*
> >  * Get time since Epoch is milliseconds.
> >  */
> > unsigned long get_time(void)
> > {
> >     struct timeval start;
> > 
> >     gettimeofday(&start, NULL);
> > 
> >     return (unsigneg long)start.tv_sec * 1000L + (unsigned long)start.tv_usec / 1000L;
> > }
> > 
> > and
> > 
> > #define IOCTL_RETRY_TIMEOUT 100
> > 
> > In the test function:
> > 
> >         unsigned long start_time;
> > 
> >         /* ... */
> > 
> >         start_time = get_time();
> >         do {
> >                 EXPECT_LT(get_time() - start_time(), IOCTL_RETRY_TIMEOUT);
> > 
> >                 /* ... */
> >         }
> > 
> >         /* ... */
> > 
> > What do you think?
> 
> I do think that your proposal can be considered for an additional check in this
> test but the way I understand it it does not address my feedback.
> 
> In this patch the flow is:
> 
> 	do {
> 		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
> 
> 		errno_save = ret == -1 ? errno : 0;
> 		if (errno_save != EAGAIN)
> 			break;
> 
> 		EXPECT_EQ(modt_ioc.result, 0);
> 		...
> 	} while ...
> 
> 
> If this EXPECT_EQ() check fails then it means that errno_save is EAGAIN
> and modt_ioc.result != 0. This should never happen because in the kernel
> (sgx_enclave_modify_types()) the only time modt_ioc.result can be set is
> when the ioctl() returns EFAULT.
> 
> In my opinion this check should be changed to:
> 		ASSERT_EQ(modt_ioc.result, 0);

Right, I missed this. It should be definitely ASSERT_EQ(().

BR, Jarkko
