Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D85A73E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiHaC2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaC2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 22:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B2C85F92;
        Tue, 30 Aug 2022 19:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A8A6184B;
        Wed, 31 Aug 2022 02:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92C7C433D6;
        Wed, 31 Aug 2022 02:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661912893;
        bh=pboAraFSmHTLt2pDZ2a1Km1/XvARb4Eezv8898dBitc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsMUZq2B8rkCYljL3Ns/Ewx97+MHM0LLqLE13ptS6ooUAworRmVNhghkhFVZpTYxy
         Zd9Spq9u1ElXQnSIOkNOfv6Q4c20dpXVhqp6K/6P5ocndAxnsxa7DWG3NKv33gHJLJ
         OAHMjfkeSgKcSOSf7BfpyTuvDSD6+wreqI/CsCg6WfuTqavqxCbhLG8l7iFAss8fca
         58HLg2M2qPbxu3X0xjQvr1sxIbJNUanNzeekivYTihQDUoUI1i/RD+skIkUqcilGjk
         Gy4CqOdQjIpuF8bvQf2AUDjzecYrpV0E0MZyFb7TkAhQasznirZahIXd7g/0XtJeOx
         VvmjVQ3Z87grA==
Date:   Wed, 31 Aug 2022 05:28:08 +0300
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
Subject: Re: [PATCH 4/6] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <Yw7HOIfnaO0IcDiX@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-5-jarkko@kernel.org>
 <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5285dd-d6dd-8a46-fca9-728db5e2f369@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 03:55:47PM -0700, Reinette Chatre wrote:
> Hi Vijay and Jarkko,
> 
> On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > 
> > Add a new test case which is same as augment_via_eaccept but adds a
> > larger number of EPC pages to stress test EAUG via EACCEPT.
> > 
> > Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Addressed Reinette's feedback:
> >   https://lore.kernel.org/linux-sgx/24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com/
> > ---
> >  tools/testing/selftests/sgx/load.c      |   5 +-
> >  tools/testing/selftests/sgx/main.c      | 141 +++++++++++++++++++++---
> >  tools/testing/selftests/sgx/main.h      |   3 +-
> >  tools/testing/selftests/sgx/sigstruct.c |   2 +-
> >  4 files changed, 129 insertions(+), 22 deletions(-)
> 
> There seems to be at least three patches merged into one here:
> 1) Update SGX selftests to create enclaves with provided size dedicated
>    to EDMM (this change causes a lot of noise and distracts from the test
>    addition).
> 2) The mrenclave_ecreate() fix (which is still incomplete).
> 3) The actual test addition.

I would agree on this on a kernel patch but not for kselftest patch. It
does not really give useful value here. This adds a test and that is a
good enough granularity in my opinion, unless some major architecture
work is required as precursory. It is not the case here.

> > diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> > index 94bdeac1cf04..7de1b15c90b1 100644
> > --- a/tools/testing/selftests/sgx/load.c
> > +++ b/tools/testing/selftests/sgx/load.c
> > @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
> >  	return 0;
> >  }
> >  
> > -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> > +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> > +			   unsigned long edmm_size)
> >  {
> 
> checkpatch.pl informs about alignment issues above and also a few other places.

Weird. I did run checkpatch through these. Will revisit.

> 
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
> > index 9820b3809c69..867e98502120 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -21,8 +21,15 @@
> >  #include "../kselftest_harness.h"
> >  #include "main.h"
> >  
> > +/*
> > + * The size was chosen based on a bug report:
> > + * https://lore.kernel.org/linux-sgx/DM8PR11MB55912A7F47A84EC9913A6352F6999@DM8PR11MB5591.namprd11.prod.outlook.com/
> > + */
> > +static const unsigned long EDMM_SIZE_LONG = 8L * 1024L * 1024L * 1024L; // 8 GB
> > +static const unsigned long TIMEOUT_LONG = 900; /* seconds */
> 
> It is interesting that in this small snippet there are three different
> comment styles (multi-line comment preceding code, tail comment using /**/,
> and tail comment using //) :)

Oops. Will fix.

> 
> >  static const uint64_t MAGIC = 0x1122334455667788ULL;
> >  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> > +
> 
> Addition of empty line here.

Will remove.

> 
> >  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
> >  
> >  /*
> > @@ -173,7 +180,8 @@ FIXTURE(enclave) {
> >  };
> >  
> >  static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
> > -			    struct __test_metadata *_metadata)
> > +			    struct __test_metadata *_metadata,
> > +			    unsigned long edmm_size)
> >  {
> >  	Elf64_Sym *sgx_enter_enclave_sym = NULL;
> >  	struct vdso_symtab symtab;
> > @@ -183,7 +191,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
> >  	unsigned int i;
> >  	void *addr;
> >  
> > -	if (!encl_load("test_encl.elf", encl, heap_size)) {
> > +	if (!encl_load("test_encl.elf", encl, heap_size, edmm_size)) {
> >  		encl_delete(encl);
> >  		TH_LOG("Failed to load the test enclave.");
> >  		return false;
> > @@ -284,7 +292,7 @@ TEST_F(enclave, unclobbered_vdso)
> >  	struct encl_op_get_from_buf get_op;
> >  	struct encl_op_put_to_buf put_op;
> >  
> > -	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
> > +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata, 0));
> >  
> >  	memset(&self->run, 0, sizeof(self->run));
> >  	self->run.tcs = self->encl.encl_base;
> > @@ -357,7 +365,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
> >  
> >  	total_mem = get_total_epc_mem();
> >  	ASSERT_NE(total_mem, 0);
> > -	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
> > +	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata, 0));
> >  
> 
> The support for EDMM size and all the call site changes could be moved to a separate
> patch to make the changes easier to parse.
> 
> 
> ...
> 
> > @@ -1210,6 +1218,103 @@ TEST_F(enclave, augment_via_eaccept)
> >  	munmap(addr, PAGE_SIZE);
> >  }
> >  
> > +/*
> > + * Test for the addition of large number of pages to an initialized enclave via
> > + * a pre-emptive run of EACCEPT on every page to be added.
> > + */
> > +TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_LONG)
> > +{
> > +	struct encl_op_get_from_addr get_addr_op;
> > +	struct encl_op_put_to_addr put_addr_op;
> > +	struct encl_op_eaccept eaccept_op;
> > +	size_t total_size = 0;
> > +	unsigned long i;
> > +	void *addr;
> > +
> > +	if (!sgx2_supported())
> > +		SKIP(return, "SGX2 not supported");
> > +
> > +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata,
> > +				    EDMM_SIZE_LONG));
> > +
> > +	memset(&self->run, 0, sizeof(self->run));
> > +	self->run.tcs = self->encl.encl_base;
> > +
> > +	for (i = 0; i < self->encl.nr_segments; i++) {
> > +		struct encl_segment *seg = &self->encl.segment_tbl[i];
> > +
> > +		total_size += seg->size;
> > +	}
> > +
> > +	/*
> > +	 * mmap() every page at end of existing enclave to be used for
> > +	 * EDMM.
> > +	 */
> > +	addr = mmap((void *)self->encl.encl_base + total_size, EDMM_SIZE_LONG,
> > +			PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
> > +			self->encl.fd, 0);
> > +	EXPECT_NE(addr, MAP_FAILED);
> > +
> > +	self->run.exception_vector = 0;
> > +	self->run.exception_error_code = 0;
> > +	self->run.exception_addr = 0;
> > +
> > +	/*
> > +	 * Run EACCEPT on new page to trigger the #PF->EAUG->EACCEPT(again
> > +	 * without a #PF). All should be transparent to userspace.
> > +	 */
> 
> s/on new page/on every page/ ?

+1

> 
> > +	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
> > +	eaccept_op.ret = 0;
> > +	eaccept_op.header.type = ENCL_OP_EACCEPT;
> > +
> > +	for (i = 0; i < EDMM_SIZE_LONG; i += 4096) {
> > +		eaccept_op.epc_addr = (uint64_t)(addr + i);
> > +
> > +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> > +		if (self->run.exception_vector == 14 &&
> > +			self->run.exception_error_code == 4 &&
> > +			self->run.exception_addr == self->encl.encl_base) {
> > +			munmap(addr, EDMM_SIZE_LONG);
> > +			SKIP(return, "Kernel does not support adding pages to initialized enclave");
> > +		}
> > +
> > +		EXPECT_EQ(self->run.exception_vector, 0);
> > +		EXPECT_EQ(self->run.exception_error_code, 0);
> > +		EXPECT_EQ(self->run.exception_addr, 0);
> > +		ASSERT_EQ(eaccept_op.ret, 0);
> > +		ASSERT_EQ(self->run.function, EEXIT);
> > +	}
> > +
> 
> I see that you removed all comments here after the discussion about what
> comment would be appropriate. This may be ok but it does seem awkward that
> there are two parts to this section and the second part still has a comment
> while the first does not. How about the comment I provided in
> https://lore.kernel.org/linux-sgx/69a5e350-ded9-30c9-dc41-d08c01dd05dc@intel.com/ :
> 
> /*
>  * Pool of pages were successfully added to enclave. Perform sanity
>  * check on first page of the pool only to ensure data can be written
>  * to and read from a dynamically added enclave page.
>  */

+1

> 
> > +	put_addr_op.value = MAGIC;
> > +	put_addr_op.addr = (unsigned long)addr;
> > +	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
> > +
> > +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> > +
> > +	EXPECT_EEXIT(&self->run);
> > +	EXPECT_EQ(self->run.exception_vector, 0);
> > +	EXPECT_EQ(self->run.exception_error_code, 0);
> > +	EXPECT_EQ(self->run.exception_addr, 0);
> > +
> > +	/*
> > +	 * Read memory from newly added page that was just written to,
> > +	 * confirming that data previously written (MAGIC) is present.
> > +	 */
> > +	get_addr_op.value = 0;
> > +	get_addr_op.addr = (unsigned long)addr;
> > +	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
> > +
> > +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> > +
> > +	EXPECT_EQ(get_addr_op.value, MAGIC);
> > +	EXPECT_EEXIT(&self->run);
> > +	EXPECT_EQ(self->run.exception_vector, 0);
> > +	EXPECT_EQ(self->run.exception_error_code, 0);
> > +	EXPECT_EQ(self->run.exception_addr, 0);
> > +
> > +	munmap(addr, EDMM_SIZE_LONG);
> > +}
> > +
> >  /*
> >   * SGX2 page type modification test in two phases:
> >   * Phase 1:
> 
> ...
> 
> > diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> > index a07896a46364..decd767434d5 100644
> > --- a/tools/testing/selftests/sgx/sigstruct.c
> > +++ b/tools/testing/selftests/sgx/sigstruct.c
> > @@ -349,7 +349,7 @@ bool encl_measure(struct encl *encl)
> >  	if (!ctx)
> >  		goto err;
> >  
> > -	if (!mrenclave_ecreate(ctx, encl->src_size))
> > +	if (!mrenclave_ecreate(ctx, encl->encl_size))
> >  		goto err;
> >  
> >  	for (i = 0; i < encl->nr_segments; i++) {
> 
> As I mentioned in feedback to previous version, even though
> encl_size is now provided, this misses that mrenclave_ecreate()
> continues to recompute it within.
> 
> Reinette
> 

I simply forgot this one, sorry. Will fix.

BR, Jarkko
