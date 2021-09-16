Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55540DDE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhIPPXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhIPPXA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:23:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8372560EE9;
        Thu, 16 Sep 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805700;
        bh=Bkxhrw1NoKl7qQD8wcmrV0nbEEiWsEj6Tk4Ey4NyGSY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dBCGVFBDO0w4gbXvYA3EHHvEDvJ9CBROJ+0ZBSsEZLv+EEo+8Ff/6SHG/9umZr3i7
         M36sbfsC3giIhJrE+LMXI1MSGhu6d0+IC9HHEDuQLdBVZW8fQPzGnvrW4NrcuReV41
         e6UpFtBAyPHNZX8TENE79uan9VtbullZ3oap2k0mkSXWtOCTE7EtTtx8nFDDe6eEh2
         YP2Ro3Nzz3R4CMJH/p2BMI9YgZb5SptK3KeD0/N6ggvLJ+SEy8cDLqWVVL9o1w2MdH
         acB/1lPsK4rUZzoT47MLHQ6cpnxQVRWyl85eI5s7MeltLgXC07n5cqaadt1JTqWdj9
         LXlix++uQ6Z/w==
Message-ID: <d04d83a679f026ae2aa28535bdc826b8cf95e887.camel@kernel.org>
Subject: Re: [PATCH 12/14] selftests/sgx: Add page permission and exception
 test
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 18:21:37 +0300
In-Reply-To: <a6e69ea22a2694d252302af283ee3e3f023d3577.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <a6e69ea22a2694d252302af283ee3e3f023d3577.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:31 -0700, Reinette Chatre wrote:
> The Enclave Page Cache Map (EPCM) is a secure structure used by the
> processor to track the contents of the enclave page cache. The EPCM
> contains permissions with which enclave pages can be accessed. SGX
> support allows EPCM and PTE page permissions to differ - as long as
> the PTE permissions do not exceed the EPCM permissions.
>=20
> Add a test to ensure that (1) PTE permissions can be changed as long as
> they do not exceed EPCM permissions, and (2) even if EPCM permissions
> allow a page to be written to, if the PTE permissions do not then a #PF
> should be generated when attempting to write to a (from PTE perspective)
> read-only page.
>=20
> This introduces the first test of SGX exception handling. In this test
> the issue that caused the exception (PTE page permissions) can be fixed
> from outside the enclave and after doing so it is possible to re-enter
> enclave at original entrypoint with ERESUME.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/sgx/defines.h   |  14 +++
>  tools/testing/selftests/sgx/main.c      | 134 ++++++++++++++++++++++++
>  tools/testing/selftests/sgx/test_encl.c |  21 ++++
>  3 files changed, 169 insertions(+)
>=20
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> index 9ea0c7882dfb..0bbda6f0c7d3 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -21,6 +21,8 @@
>  enum encl_op_type {
>  	ENCL_OP_PUT_TO_BUFFER,
>  	ENCL_OP_GET_FROM_BUFFER,
> +	ENCL_OP_PUT_TO_ADDRESS,
> +	ENCL_OP_GET_FROM_ADDRESS,
>  	ENCL_OP_MAX,
>  };
> =20
> @@ -38,4 +40,16 @@ struct encl_op_get_from_buf {
>  	uint64_t value;
>  };
> =20
> +struct encl_op_put_to_addr {
> +	struct encl_op_header header;
> +	uint64_t value;
> +	uint64_t addr;
> +};
> +
> +struct encl_op_get_from_addr {
> +	struct encl_op_header header;
> +	uint64_t value;
> +	uint64_t addr;
> +};
> +
>  #endif /* DEFINES_H */
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index 3eb9b89ece5f..308cf09ab02a 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -21,6 +21,7 @@
>  #include "main.h"
> =20
>  static const uint64_t MAGIC =3D 0x1122334455667788ULL;
> +static const uint64_t MAGIC2 =3D 0x8877665544332211ULL;
>  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
> =20
>  struct vdso_symtab {
> @@ -107,6 +108,25 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab=
 *symtab, const char *name)
>  	return NULL;
>  }
> =20
> +/*
> + * Return the offset in the enclave where the data segment can be found.
> + * The first RW segment loaded is the TCS, skip that to get info on the
> + * data segment.
> + */
> +static off_t encl_get_data_offset(struct encl *encl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < encl->nr_segments; i++) {
> +		struct encl_segment *seg =3D &encl->segment_tbl[i];
> +
> +		if (i !=3D 0 && seg->prot =3D=3D (PROT_READ | PROT_WRITE))
> +			return seg->offset;

So, why not

	for (i =3D 1; i < encl->nr_segments; i++)

?

> +	}
> +
> +	return -1;
> +}
> +
>  FIXTURE(enclave) {
>  	struct encl encl;
>  	struct sgx_enclave_run run;
> @@ -373,4 +393,118 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
>  	EXPECT_EQ(self->run.user_data, 0);
>  }
> =20
> +/*
> + * Second page of .data segment is used to test changing PTE permissions=
.
> + * This spans the local encl_buffer within the test enclave.
> + *
> + * 1) Start with a sanity check: a value is written to the target page w=
ithin
> + *    the enclave and read back to ensure target page can be written to.
> + * 2) Change PTE permissions (RW -> RO) of target page within enclave.
> + * 3) Repeat (1) - this time expecting a regular #PF communicated via th=
e
> + *    vDSO.
> + * 4) Change PTE permissions of target page within enclave back to be RW=
.
> + * 5) Repeat (1) by resuming enclave, now expected to be possible to wri=
te to
> + *    and read from target page within enclave.
> + */
> +TEST_F(enclave, pte_permissions)
> +{
> +	struct encl_op_get_from_addr get_addr_op;
> +	struct encl_op_put_to_addr put_addr_op;
> +	unsigned long data_start;
> +	int ret;
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs =3D self->encl.encl_base;
> +
> +	data_start =3D self->encl.encl_base +
> +		     encl_get_data_offset(&self->encl) +
> +		     PAGE_SIZE;
> +
> +	/*
> +	 * Sanity check to ensure it is possible to write to page that will
> +	 * have its permissions manipulated.
> +	 */
> +
> +	/* Write MAGIC to page */
> +	put_addr_op.value =3D MAGIC;
> +	put_addr_op.addr =3D data_start;
> +	put_addr_op.header.type =3D ENCL_OP_PUT_TO_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Read memory that was just written to, confirming that it is the
> +	 * value previously written (MAGIC).
> +	 */
> +	get_addr_op.value =3D 0;
> +	get_addr_op.addr =3D data_start;
> +	get_addr_op.header.type =3D ENCL_OP_GET_FROM_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/* Change PTE permissions of target page within the enclave */
> +	ret =3D mprotect((void *)data_start, PAGE_SIZE, PROT_READ);
> +	if (ret)
> +		perror("mprotect");
> +
> +	/*
> +	 * PTE permissions of target page changed to read-only, EPCM
> +	 * permissions unchanged (EPCM permissions are RW), attempt to
> +	 * write to the page, expecting a regular #PF.
> +	 */
> +
> +	put_addr_op.value =3D MAGIC2;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(self->run.exception_vector, 14);
> +	EXPECT_EQ(self->run.exception_error_code, 0x7);
> +	EXPECT_EQ(self->run.exception_addr, data_start);
> +
> +	self->run.exception_vector =3D 0;
> +	self->run.exception_error_code =3D 0;
> +	self->run.exception_addr =3D 0;
> +
> +	/*
> +	 * Change PTE permissions back to enable enclave to write to the
> +	 * target page and resume enclave - do not expect any exceptions this
> +	 * time.
> +	 */
> +	ret =3D mprotect((void *)data_start, PAGE_SIZE, PROT_READ | PROT_WRITE)=
;
> +	if (ret)
> +		perror("mprotect");
> +
> +	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0,
> +					 0, ERESUME, 0, 0, &self->run),
> +		 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	get_addr_op.value =3D 0;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC2);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +}
> +
>  TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index 4e8da738173f..5d86e3e6456a 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -4,6 +4,11 @@
>  #include <stddef.h>
>  #include "defines.h"
> =20
> +/*
> + * Data buffer spanning two pages that will be placed first in .data
> + * segment. Even if not used internally the second page is needed by
> + * external test manipulating page permissions.
> + */
>  static uint8_t encl_buffer[8192] =3D { 1 };
> =20
>  static void *memcpy(void *dest, const void *src, size_t n)
> @@ -30,11 +35,27 @@ static void do_encl_op_get_from_buf(void *op)
>  	memcpy(&op2->value, &encl_buffer[0], 8);
>  }
> =20
> +static void do_encl_op_put_to_addr(void *_op)
> +{
> +	struct encl_op_put_to_addr *op =3D _op;
> +
> +	memcpy((void *)op->addr, &op->value, 8);
> +}
> +
> +static void do_encl_op_get_from_addr(void *_op)
> +{
> +	struct encl_op_get_from_addr *op =3D _op;
> +
> +	memcpy(&op->value, (void *)op->addr, 8);
> +}
> +
>  void encl_body(void *rdi,  void *rsi)
>  {
>  	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
>  		do_encl_op_put_to_buf,
>  		do_encl_op_get_from_buf,
> +		do_encl_op_put_to_addr,
> +		do_encl_op_get_from_addr,
>  	};
> =20
>  	struct encl_op_header *op =3D (struct encl_op_header *)rdi;

/Jarkko

