Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950CF5AA310
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiIAWaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 18:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiIAW3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 18:29:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843872CDEB;
        Thu,  1 Sep 2022 15:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14AEBB82967;
        Thu,  1 Sep 2022 22:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409D2C433C1;
        Thu,  1 Sep 2022 22:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662070983;
        bh=w57zJjChMCAF0tiCRRkMgdO5xn4agumfjbmYJSkZIB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xl4wDJOO4pUO6SG9nTu5QZuqmYJb+F+A9EOr86gy/hpROglt1BkB64OgAS8GFxLj/
         MHh7emmj3U89uJ3uUIZ/+WO+7ztZSlKIvZeXomrdDww4HjKegcRhFgeF8HgFutSB5J
         9ekdknVe7ozu78vaI7DaGrvTGdTAcNjGRNjf032sexu6PgfoiKIhPDHHFEwwLguvs1
         mT8kkhLPuI1QeChJS0m2VGNVMGPEaSsm109oCtwe9GebIEGNGtszsd77QqPpdUXeL5
         LLZc+VaBdqLsqijaEQz3ljy7dXmp3wWOcngEh2mrc/hZXxlXFsCmOKIdQSiYp6+DPv
         87ojfTFOrwB1w==
Date:   Fri, 2 Sep 2022 01:22:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YxEwwzXOsCliznQJ@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
 <20220831173829.126661-5-jarkko@kernel.org>
 <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b76530-82a2-6ac1-32ea-696e653d767d@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 31, 2022 at 01:07:35PM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 8/31/2022 10:38 AM, Jarkko Sakkinen wrote:
> > From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > 
> > Add a new test case which is same as augment_via_eaccept but adds a
> > larger number of EPC pages to stress test EAUG via EACCEPT.
> > 
> > Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3:
> > - Addressed Reinette's feedback:
> >   https://lore.kernel.org/linux-sgx/bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com/
> > v2:
> > - Addressed Reinette's feedback:
> >   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
> > ---
> >  tools/testing/selftests/sgx/load.c |   5 +-
> >  tools/testing/selftests/sgx/main.c | 143 +++++++++++++++++++++++++----
> >  tools/testing/selftests/sgx/main.h |   3 +-
> 
> Is this test passing on your system? This version is missing the change to
> mrenclave_ecreate() that causes SGX_IOC_ENCLAVE_INIT to fail when I try it out.

I *did* get a pass in my test machine. Hmm... I'll check if
the kernel tree was out-of-sync, which could be the reason.

I do not compile kernel on that machine but have the kernel
tree for running selftests. So there is a possiblity for
a human error. Thanks for pointing this out.

> 
> >  3 files changed, 130 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> > index 94bdeac1cf04..47b2786d6a77 100644
> > --- a/tools/testing/selftests/sgx/load.c
> > +++ b/tools/testing/selftests/sgx/load.c
> > @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
> >  	return 0;
> >  }
> >  
> > -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> > +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> > +	       unsigned long edmm_size)
> >  {
> >  	const char device_path[] = "/dev/sgx_enclave";
> >  	struct encl_segment *seg;
> > @@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> >  
> >  	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
> >  
> > -	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
> > +	for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
> >  		encl->encl_size <<= 1;
> >  
> >  	return true;
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 9820b3809c69..c5aa9f323745 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -23,6 +23,10 @@
> >  
> >  static const uint64_t MAGIC = 0x1122334455667788ULL;
> >  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> > +/* Message-ID: <DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com> */
> > +static const uint64_t EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L;
> > +static const uint64_t TIMEOUT_LONG = 900; /* seconds */
> > +
> 
> Apologies if my feedback was vague - I actually think that the comments in V1 added
> valuable information, it was just the variation in formatting that was distracting.

IMHO message ID is pretty good reference. Can you
propose how would you redo it to minimize the number
of iterations in the series?

> Reinette

BR, Jarkko
