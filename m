Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F922B6EFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgKQTm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 14:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgKQTm3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 14:42:29 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B622463D;
        Tue, 17 Nov 2020 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605642147;
        bh=WfH7BFVzUSEZv+f6jZxK9ydp1lynvYQ2oovxy7EJVXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vmvo0oLI2+zUSZRhwq0NiGDjYhcKWJZyY+Ph8A1MJPfxjbJH0Zol91ECmkxg91DyH
         NXWk7uQXJtd/v1xuxdNQ/GI5Ed040w/C7hrjjZBRrgfQy+sNkrZpD48Pz8cg82N6po
         cl4QXLIN7mw/CndOK2P3ZytLUp2cBUGrSWYQ5kVI=
Date:   Tue, 17 Nov 2020 21:42:17 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 20/24] selftests/x86: Add a selftest for SGX
Message-ID: <20201117194217.GG10393@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-21-jarkko@kernel.org>
 <e58ee564-597a-336e-53dc-7c4d172d51f5@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58ee564-597a-336e-53dc-7c4d172d51f5@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 16, 2020 at 11:19:12AM -0700, Shuah Khan wrote:
> On 11/12/20 3:01 PM, Jarkko Sakkinen wrote:
> > Add a selftest for SGX. It is a trivial test where a simple enclave copies
> > one 64-bit word of memory between two memory locations, but ensures that
> > all SGX hardware and software infrastructure is functioning.
> > 
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-kselftest@vger.kernel.org
> > Acked-by: Jethro Beekman <jethro@fortanix.com> # v40
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > Changes from v40:
> > * Remove $(OUTPUT)/test_encl.elf from TEST_CUSTOM_PROGS, as otherwise
> >    run_tests tries to execute it. Add it as a build dependency.
> > * Use the correct device path, /dev/sgx_enclave, instead of
> >    /dev/sgx/enclave.
> > * Return kselftest framework expected return codes.
> > 
> >   tools/testing/selftests/Makefile              |   1 +
> >   tools/testing/selftests/sgx/.gitignore        |   2 +
> >   tools/testing/selftests/sgx/Makefile          |  53 +++
> >   tools/testing/selftests/sgx/call.S            |  44 ++
> >   tools/testing/selftests/sgx/defines.h         |  21 +
> >   tools/testing/selftests/sgx/load.c            | 277 +++++++++++++
> >   tools/testing/selftests/sgx/main.c            | 246 +++++++++++
> >   tools/testing/selftests/sgx/main.h            |  38 ++
> >   tools/testing/selftests/sgx/sigstruct.c       | 391 ++++++++++++++++++
> >   tools/testing/selftests/sgx/test_encl.c       |  20 +
> >   tools/testing/selftests/sgx/test_encl.lds     |  40 ++
> >   .../selftests/sgx/test_encl_bootstrap.S       |  89 ++++
> >   12 files changed, 1222 insertions(+)
> >   create mode 100644 tools/testing/selftests/sgx/.gitignore
> >   create mode 100644 tools/testing/selftests/sgx/Makefile
> >   create mode 100644 tools/testing/selftests/sgx/call.S
> >   create mode 100644 tools/testing/selftests/sgx/defines.h
> >   create mode 100644 tools/testing/selftests/sgx/load.c
> >   create mode 100644 tools/testing/selftests/sgx/main.c
> >   create mode 100644 tools/testing/selftests/sgx/main.h
> >   create mode 100644 tools/testing/selftests/sgx/sigstruct.c
> >   create mode 100644 tools/testing/selftests/sgx/test_encl.c
> >   create mode 100644 tools/testing/selftests/sgx/test_encl.lds
> >   create mode 100644 tools/testing/selftests/sgx/test_encl_bootstrap.S
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index d9c283503159..aa06e3ea0250 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -68,6 +68,7 @@ TARGETS += user
> >   TARGETS += vm
> >   TARGETS += x86
> >   TARGETS += zram
> > +TARGETS += sgx
> >   #Please keep the TARGETS list alphabetically sorted
> 
> Please keep the list sorted alphabetically as stated
> in the comment above.
> 
> 
> > +}
> > +
> > +int main(int argc, char *argv[], char *envp[])
> > +{
> > +	struct sgx_enclave_run run;
> > +	struct vdso_symtab symtab;
> > +	Elf64_Sym *eenter_sym;
> > +	uint64_t result = 0;
> > +	struct encl encl;
> > +	unsigned int i;
> > +	void *addr;
> > +	int ret;
> > +
> > +	memset(&run, 0, sizeof(run));
> > +
> > +	if (!encl_load("test_encl.elf", &encl)) {
> > +		encl_delete(&encl);
> > +		ksft_exit_skip("cannot load enclaves\n");
> > +	}
> > +
> > +	if (!encl_measure(&encl))
> > +		goto err;
> > +
> > +	if (!encl_build(&encl))
> > +		goto err;
> > +
> > +	/*
> > +	 * An enclave consumer only must do this.
> > +	 */
> > +	for (i = 0; i < encl.nr_segments; i++) {
> > +		struct encl_segment *seg = &encl.segment_tbl[i];
> > +
> > +		addr = mmap((void *)encl.encl_base + seg->offset, seg->size,
> > +			    seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0);
> > +		if (addr == MAP_FAILED) {
> > +			fprintf(stderr, "mmap() failed, errno=%d.\n", errno);
> > +			exit(1);
> 
> This should be KSFT_FAIL.
> 
> thanks,
> -- Shuah

Thanks.

/Jarkko
