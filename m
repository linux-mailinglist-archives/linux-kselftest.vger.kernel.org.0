Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C48596610
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiHPXeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHPXeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 19:34:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763D78BE9;
        Tue, 16 Aug 2022 16:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1EE9CE19CE;
        Tue, 16 Aug 2022 23:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD7C433C1;
        Tue, 16 Aug 2022 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660692835;
        bh=oHzxZ2EXfa2N1hFTn43a/QgE9SopWYv6Cd4+leuEYRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9qFEuFVeegSnvU0Kvq9CFkPHsYrA4P6hMPMTCHqQIESjRPM99synG9A/qIvETkFZ
         NBUNcZKy1/F8xj3Xr6MolYbPw8uG+KcydXV+VocYT81K0hX3nMnScO9KCJXEIIyv8D
         JW7QvMBjLbWeaZkMySOKikLB9yKX/8NvxcCnSNnpR+18VEnMJueaP9UThDocsa2MK8
         gkWZ8VYRxMnVlyb2OtqiCNSHf2543p3+2NVftTVLQAaZSG5FolNDNp+ebIhCf0kgTI
         PaDmI6o9wj5HV/BoKjwQlatbE9Qah7samXi9RtFjbdU/mQEWiIR4USMGvblwYjZPem
         fluOqV3owe94w==
Date:   Wed, 17 Aug 2022 02:33:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org, Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Message-ID: <YvwpX7pYOW3Jv+vJ@kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 16, 2022 at 09:26:40AM -0700, Reinette Chatre wrote:
> Hi Vijay,
> 
> Thank you very much for digging into this. A few comments below.
> 
> On 8/15/2022 4:39 PM, Jarkko Sakkinen wrote:
> > From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > 
> > Add a new test case which is same as augment_via_eaccept but adds a
> > larger number of EPC pages to stress test EAUG via EACCEPT.
> > 
> > Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > I removed Githubisms (hyphens), added missing subsystem tag, and
> > cleaned up the commit message a bit.
> >  tools/testing/selftests/sgx/load.c      |   5 +-
> >  tools/testing/selftests/sgx/main.c      | 120 +++++++++++++++++++++++-
> >  tools/testing/selftests/sgx/main.h      |   3 +-
> >  tools/testing/selftests/sgx/sigstruct.c |   2 +-
> >  4 files changed, 125 insertions(+), 5 deletions(-)
> > 
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
> 
> This seems to create the hardcoded 8GB larger enclave for all (SGX1 and SGX2) tests,
> not just the test introduced with this commit (and the only user of this extra space).
> Is this intended? This can be done without impacting all the other tests.

It's a valid point. I can adjust the patch.

> 
> >  	return true;
> > diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> > index 9820b3809c69..65e79682f75e 100644
> > --- a/tools/testing/selftests/sgx/main.c
> > +++ b/tools/testing/selftests/sgx/main.c
> > @@ -25,6 +25,8 @@ static const uint64_t MAGIC = 0x1122334455667788ULL;
> >  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> >  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
> >  
> > +static const unsigned long edmm_size = 8589934592; //8G
> > +
> 
> Could you please elaborate how this constant was chosen? I understand that this test helped
> to uncover a bug and it is useful to add to the kernel. When doing so this test will be
> run on systems with a variety of SGX memory sizes, could you please elaborate (and add a
> snippet) how 8GB is the right value for all systems?

It is the only constant I know for sure that some people
(Vijay and Haitao) have been able to reproduce the bug.

Unless someone can show that the same bug reproduces
with a smaller constant, changing it would make the
whole test irrelevant.

> 
> /on page to be added/on every page to be added/ ?
> 
> > + */
> > +#define TIMEOUT_LONG 900 /* seconds */
> > +TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_LONG)
> > +{
> > +	struct encl_op_get_from_addr get_addr_op;
> > +	struct encl_op_put_to_addr put_addr_op;
> > +	struct encl_op_eaccept eaccept_op;
> > +	size_t total_size = 0;
> > +	void *addr;
> > +	unsigned long i;
> 
> (reverse fir tree order)

I would just change this to "int i" instead.

> 
> > +
> > +	if (!sgx2_supported())
> > +		SKIP(return, "SGX2 not supported");
> > +
> > +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
> > +
> > +	memset(&self->run, 0, sizeof(self->run));
> > +	self->run.tcs = self->encl.encl_base;
> > +
> > +	for (i = 0; i < self->encl.nr_segments; i++) {
> > +		struct encl_segment *seg = &self->encl.segment_tbl[i];
> > +
> > +		total_size += seg->size;
> > +		TH_LOG("test enclave: total_size = %ld, seg->size = %ld", total_size, seg->size);
> > +	}
> > +
> > +	/*
> > +	 * Actual enclave size is expected to be larger than the loaded
> > +	 * test enclave since enclave size must be a power of 2 in bytes while
> > +	 * test_encl does not consume it all.
> > +	 */
> > +	EXPECT_LT(total_size + edmm_size, self->encl.encl_size);
> 
> Will this test ever fail?

With a *quick* look: no.

Vijay, what was the point of this check?

> > +
> > +	/*
> > +	 * mmap() a page at end of existing enclave to be used for dynamic
> > +	 * EPC page.
> 
> copy&paste line still refers to single page
> 
> > +	 *
> > +	 * Kernel will allow new mapping using any permissions if it
> > +	 * falls into the enclave's address range but not backed
> > +	 * by existing enclave pages.
> > +	 */
> > +	TH_LOG("mmaping pages at end of enclave...");
> > +	addr = mmap((void *)self->encl.encl_base + total_size, edmm_size,
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
> copy&paste from single page test referring to one page
> 
> > +	TH_LOG("Entering enclave to run EACCEPT for each page of %zd bytes may take a while ...",
> > +			edmm_size);
> > +	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
> > +	eaccept_op.ret = 0;
> > +	eaccept_op.header.type = ENCL_OP_EACCEPT;
> > +
> > +	for (i = 0; i < edmm_size; i += 4096) {
> > +		eaccept_op.epc_addr = (uint64_t)(addr + i);
> > +
> > +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> > +		if (self->run.exception_vector == 14 &&
> > +			self->run.exception_error_code == 4 &&
> > +			self->run.exception_addr == self->encl.encl_base) {
> > +			munmap(addr, edmm_size);
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
> > +	/*
> > +	 * New page should be accessible from within enclave - attempt to
> > +	 * write to it.
> > +	 */
> 
> This portion below was also copied from previous test and by only testing
> a write to the first page of the range the purpose is not clear. Could you
> please elaborate if the intention is to only test accessibility of the first
> page and why that is sufficient?

It is sufficient because the test reproduces the bug. It would
have to be rather elaborated why you would possibly want to do
more than that.

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
> > +	munmap(addr, edmm_size);
> > +}
> > +
> >  /*
> >   * SGX2 page type modification test in two phases:
> >   * Phase 1:
> > diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
> > index fc585be97e2f..fe5d39ac0e1e 100644
> > --- a/tools/testing/selftests/sgx/main.h
> > +++ b/tools/testing/selftests/sgx/main.h
> > @@ -35,7 +35,8 @@ extern unsigned char sign_key[];
> >  extern unsigned char sign_key_end[];
> >  
> >  void encl_delete(struct encl *ctx);
> > -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
> > +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> > +			   unsigned long edmm_size);
> >  bool encl_measure(struct encl *encl);
> >  bool encl_build(struct encl *encl);
> >  uint64_t encl_get_entry(struct encl *encl, const char *symbol);
> > diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> > index 50c5ab1aa6fa..6000cf0e4975 100644
> > --- a/tools/testing/selftests/sgx/sigstruct.c
> > +++ b/tools/testing/selftests/sgx/sigstruct.c
> > @@ -343,7 +343,7 @@ bool encl_measure(struct encl *encl)
> >  	if (!ctx)
> >  		goto err;
> >  
> > -	if (!mrenclave_ecreate(ctx, encl->src_size))
> > +	if (!mrenclave_ecreate(ctx, encl->encl_size))
> >  		goto err;
> >  
> >  	for (i = 0; i < encl->nr_segments; i++) {
> 
> 
> Looking at mrenclave_ecreate() the above snippet seems separate from this test and incomplete
> since it now obtains encl->encl_size but continues to compute it again internally. Should
> this be a separate fix?

I would remove this part completely but this also needs
comment from Vijay.

> Reinette


BR, Jarkko
