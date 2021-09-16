Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33FE40DDEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhIPPZZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhIPPZZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:25:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D4BA60EE9;
        Thu, 16 Sep 2021 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805844;
        bh=2nrkydlaMYejuedrwA9DOFv1JBObJhlmPDYP3yHSowo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JMLt13gXCHusPmZgqgOrvGWXzteJ6RVvB7t7v8A+pnDUVFo26+QptPS62RB/3SNPT
         OgYthOxEROPGivXDCttO1WsmIG2hY4y7hq8GZBGykQDPkoEOLZPJWYO1qNlcbBKT7u
         8ypJf59iB6LZ3eHK6k+9BRcbQV7M+2P0eho9LAdzl3ldQKcpQYAS/3EAEOmntSSwja
         fsy/PPJQ3mDY7FPKBYSuCuKhSZHy5ZX+mFydE1yc0l2uZB36mvlcCFD8mYSOK9MRNC
         4lAgomUEcIZN3CFGxYDLoEDClV72Ha3rqi85riQUgYiNuQEw/IOHzTqhBoUifbZq6a
         pi5Fe7WF4qT5w==
Message-ID: <534b1bbc0a76b8832c3d89ff62663085545ad7aa.camel@kernel.org>
Subject: Re: [PATCH 14/14] selftests/sgx: Add test for multiple TCS entry
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 18:24:02 +0300
In-Reply-To: <b908c7d2f210f11fc50abeb84a2dc22566941ffd.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <b908c7d2f210f11fc50abeb84a2dc22566941ffd.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:31 -0700, Reinette Chatre wrote:
> Each thread executing in an enclave is associated with a Thread Control
> Structure (TCS). The SGX test enclave contains two hardcoded TCS, thus
> supporting two threads in the enclave.
>=20
> Add a test to ensure it is possible to enter enclave at both entrypoints.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/sgx/defines.h   |  1 +
>  tools/testing/selftests/sgx/main.c      | 32 +++++++++++++++++++++++++
>  tools/testing/selftests/sgx/test_encl.c |  6 +++++
>  3 files changed, 39 insertions(+)
>=20
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> index 0bbda6f0c7d3..02d775789ea7 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -23,6 +23,7 @@ enum encl_op_type {
>  	ENCL_OP_GET_FROM_BUFFER,
>  	ENCL_OP_PUT_TO_ADDRESS,
>  	ENCL_OP_GET_FROM_ADDRESS,
> +	ENCL_OP_NOP,
>  	ENCL_OP_MAX,
>  };
> =20
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index 308cf09ab02a..0a2552ad9ec8 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -393,6 +393,38 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
>  	EXPECT_EQ(self->run.user_data, 0);
>  }
> =20
> +/*
> + * Sanity check that it is possible to enter either of the two hardcoded=
 TCS
> + */
> +TEST_F(enclave, tcs_entry)
> +{
> +	struct encl_op_header op;
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs =3D self->encl.encl_base;
> +
> +	op.type =3D ENCL_OP_NOP;
> +
> +	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/* Move to the next TCS. */
> +	self->run.tcs =3D self->encl.encl_base + PAGE_SIZE;
> +
> +	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +}
> +
>  /*
>   * Second page of .data segment is used to test changing PTE permissions=
.
>   * This spans the local encl_buffer within the test enclave.
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index 5d86e3e6456a..4fca01cfd898 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -49,6 +49,11 @@ static void do_encl_op_get_from_addr(void *_op)
>  	memcpy(&op->value, (void *)op->addr, 8);
>  }
> =20
> +static void do_encl_op_nop(void *_op)
> +{
> +
> +}
> +
>  void encl_body(void *rdi,  void *rsi)
>  {
>  	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> @@ -56,6 +61,7 @@ void encl_body(void *rdi,  void *rsi)
>  		do_encl_op_get_from_buf,
>  		do_encl_op_put_to_addr,
>  		do_encl_op_get_from_addr,
> +		do_encl_op_nop,
>  	};
> =20
>  	struct encl_op_header *op =3D (struct encl_op_header *)rdi;


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

