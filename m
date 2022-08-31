Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C55A73EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 04:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiHaCb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 22:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiHaCb6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 22:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6059DF9C;
        Tue, 30 Aug 2022 19:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD490B81DBA;
        Wed, 31 Aug 2022 02:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FE5C433D6;
        Wed, 31 Aug 2022 02:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661913113;
        bh=YaGllH6Vrt8RzpcLwPYGdZi54cRKHV4FFpbP2e46XhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+Qz4EtrIpeymjHAKzb/gxXAMqjo9npbaxu4jn8DuF7pS3kywaacq+MGn8ohIlvYy
         NCMAdDP9mXKIrKHVTxpK+AreSO1HNAdunKizSn+FE1DIiwu6M40sQIJCbmtsiCVPkq
         tw2M1eJqLlRfAe+akaRmogCYF67HuBvGwzpJZ9o6Y4rWZYJEX0I73GBPG3rI2Ppw7L
         KHTtjdWiR+DbgJUkkdRQX0Ly/Gy/IzQU5Ipy1gElo5e4oseMmRfhLQ7dx7EeIka6Ep
         TLvge+1MgGR/zEI75i5bIkNDRiFzCl1relgjeOL+C3xuO4aG4j9OMFVDTlxoOe3w2W
         mM8oMgx+5aWXw==
Date:   Wed, 31 Aug 2022 05:31:49 +0300
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
Subject: Re: [PATCH 5/6] selftests/sgx: retry the ioctls returned with EAGAIN
Message-ID: <Yw7IFcnjbfm3Xgqk@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-6-jarkko@kernel.org>
 <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d19be91-3aef-5cbe-6063-3ff3dbd5572b@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 03:56:29PM -0700, Reinette Chatre wrote:
> Hi Haitao and Jarkko,
> 
> 
> selftests/sgx: Retry the ioctl()s returned with EAGAIN
> 
> 
> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > From: Haitao Huang <haitao.huang@linux.intel.com>
> > 
> > For EMODT and EREMOVE ioctls with a large range, kernel
> 
> ioctl()s?

Ioctl is common enough to be considered as noun and is
widely phrased like that in commit messages. I don't
see any added clarity.

> 
> > may not finish in one shot and return EAGAIN error code
> > and count of bytes of EPC pages on that operations are
> > finished successfully.
> > 
> > Change the unclobbered_vdso_oversubscribed_remove test
> > to rerun the ioctls in a loop, updating offset and length
> 
> ioctl()s?
> 
> > using the byte count returned in each iteration.
> > 
> 
> This is a valuable addition, thank you very much.
> 
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  tools/testing/selftests/sgx/main.c | 39 +++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 867e98502120..3268d8b01b0b 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -399,7 +399,7 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
> >  	unsigned long total_mem;
> >  	int ret, errno_save;
> >  	unsigned long addr;
> > -	unsigned long i;
> > +	unsigned long i, count;
> 
> Reverse fir tree?

+1

> 
> >  
> >  	/*
> >  	 * Create enclave with additional heap that is as big as all
> > @@ -461,16 +461,27 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
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
> > +		errno_save = ret == -1 ? errno : 0;
> > +		if (errno_save == EAGAIN) {
> > +			count += modt_ioc.count;
> > +			modt_ioc.offset += modt_ioc.count;
> > +			modt_ioc.length -= modt_ioc.count;
> > +			modt_ioc.result = 0;
> 
> As part of the test I think it would be helpful to know if there was a result code
> in here. What do you think of failing the test if it is not zero?

I would not mind doing that.

> 
> > +			modt_ioc.count = 0;
> > +		} else
> > +			break;
> 
> Watch out for unbalanced braces (also later in patch). This causes
> checkpatch.pl noise.

Again. I did run checkpatch to all of these. Will revisit.

> 
> > +	} while (modt_ioc.length != 0);
> >  
> >  	EXPECT_EQ(ret, 0);
> >  	EXPECT_EQ(errno_save, 0);
> >  	EXPECT_EQ(modt_ioc.result, 0);
> > -	EXPECT_EQ(modt_ioc.count, heap->size);
> > +	count += modt_ioc.count;
> > +	EXPECT_EQ(count, heap->size);
> >  
> >  	/* EACCEPT all removed pages. */
> >  	addr = self->encl.encl_base + heap->offset;
> > @@ -498,15 +509,25 @@ TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
> >  
> >  	remove_ioc.offset = heap->offset;
> >  	remove_ioc.length = heap->size;
> > -
> > +	count = 0;
> >  	TH_LOG("Removing %zd bytes from enclave may take a while ...",
> >  	       heap->size);
> > -	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
> > -	errno_save = ret == -1 ? errno : 0;
> > +	do {
> > +		ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
> > +		errno_save = ret == -1 ? errno : 0;
> > +		if (errno_save == EAGAIN) {
> > +			count += remove_ioc.count;
> > +			remove_ioc.offset += remove_ioc.count;
> > +			remove_ioc.length -= remove_ioc.count;
> > +			remove_ioc.count = 0;
> > +		} else
> > +			break;
> > +	} while (remove_ioc.length != 0);
> >  
> >  	EXPECT_EQ(ret, 0);
> >  	EXPECT_EQ(errno_save, 0);
> > -	EXPECT_EQ(remove_ioc.count, heap->size);
> > +	count += remove_ioc.count;
> > +	EXPECT_EQ(count, heap->size);
> >  }
> >  
> >  TEST_F(enclave, clobbered_vdso)
> 
> Reinette


BR, Jarkko
