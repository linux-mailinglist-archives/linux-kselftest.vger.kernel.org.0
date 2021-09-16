Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C740DDD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhIPPVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhIPPVc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:21:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 604816113E;
        Thu, 16 Sep 2021 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631805611;
        bh=wieNoaMiIyhTPZ5GewIfqNyaQLhHyvQHRLsSrL+8AnQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uCcVjZNDIUrPpFfP9rn1N+CTLMCbjKiNNKefOak94KoJP/LJXc02UwFpuJKMO2ZR0
         ifd9usPCMpEnHz3vU2rUK98WDUuExmJ1z3Pd0vD33Uqre2G+txbw+YaR7syRpFSzzk
         GKMtVXuLcts6vtPf9i9KdQk5s1nIQ7fD9jTvEqorMWHIilbeSuwITq4bJ/MnLxH6gR
         OR1XFEyk3RM5txvrbIb1aMovJWjsSf8jmKbk7/vaypRn3sda8NzCyj3MYW3HiH9/Nb
         6MyWnYzKfYzLG8morIOwrCrFTQ/UaFeIQsp3l0hLWXJAhYkhPB6tqzznc8BfLpp6ri
         rlYRjjCxWR39w==
Message-ID: <5896058a1eb841946d2e9aa6c5c67f4da6e432c8.camel@kernel.org>
Subject: Re: [PATCH 11/14] selftests/sgx: Rename test properties in
 preparation for more enclave tests
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 18:20:09 +0300
In-Reply-To: <9a1d5d79c624fa7bb0dc89387fc7b3ab49d36dd0.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <9a1d5d79c624fa7bb0dc89387fc7b3ab49d36dd0.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:31 -0700, Reinette Chatre wrote:
> SGX selftests prepares a data structure outside of the enclave with
> the type of and data for the operation that needs to be run within
> the enclave. At this time only two complementary operations are supported
> by the enclave: copying a value from outside the enclave into a default
> buffer within the enclave and reading a value from the enclave's default
> buffer into a variable accessible outside the enclave.
>=20
> In preparation for more operations supported by the enclave the names of =
the
> current enclave operations are changed to more accurately reflect the
> operations and more easily distinguish it from future operations:
>=20
> * The enums ENCL_OP_PUT and ENCL_OP_GET are renamed to ENCL_OP_PUT_TO_BUF=
FER
>   and ENCL_OP_GET_FROM_BUFFER respectively.
> * The structs encl_op_put and encl_op_get are renamed to encl_op_put_to_b=
uf
>   and encl_op_get_from_buf respectively.
> * The enclave functions do_encl_op_put and do_encl_op_get are renamed to
>   do_encl_op_put_to_buf and do_encl_op_get_from_buf respectively.
>=20
> No functional changes.
>=20
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  tools/testing/selftests/sgx/defines.h   |  8 +++----
>  tools/testing/selftests/sgx/main.c      | 32 ++++++++++++-------------
>  tools/testing/selftests/sgx/test_encl.c | 12 +++++-----
>  3 files changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> index 6ff95a766287..9ea0c7882dfb 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -19,8 +19,8 @@
>  #include "../../../../arch/x86/include/uapi/asm/sgx.h"
> =20
>  enum encl_op_type {
> -	ENCL_OP_PUT,
> -	ENCL_OP_GET,
> +	ENCL_OP_PUT_TO_BUFFER,
> +	ENCL_OP_GET_FROM_BUFFER,
>  	ENCL_OP_MAX,
>  };
> =20
> @@ -28,12 +28,12 @@ struct encl_op_header {
>  	uint64_t type;
>  };
> =20
> -struct encl_op_put {
> +struct encl_op_put_to_buf {
>  	struct encl_op_header header;
>  	uint64_t value;
>  };
> =20
> -struct encl_op_get {
> +struct encl_op_get_from_buf {
>  	struct encl_op_header header;
>  	uint64_t value;
>  };
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> index a107fc576094..3eb9b89ece5f 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -220,15 +220,15 @@ FIXTURE_TEARDOWN(enclave)
> =20
>  TEST_F(enclave, unclobbered_vdso)
>  {
> -	struct encl_op_put put_op;
> -	struct encl_op_get get_op;
> +	struct encl_op_get_from_buf get_op;
> +	struct encl_op_put_to_buf put_op;
> =20
>  	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> =20
>  	memset(&self->run, 0, sizeof(self->run));
>  	self->run.tcs =3D self->encl.encl_base;
> =20
> -	put_op.header.type =3D ENCL_OP_PUT;
> +	put_op.header.type =3D ENCL_OP_PUT_TO_BUFFER;
>  	put_op.value =3D MAGIC;
> =20
>  	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
> @@ -236,7 +236,7 @@ TEST_F(enclave, unclobbered_vdso)
>  	EXPECT_EEXIT(&self->run);
>  	EXPECT_EQ(self->run.user_data, 0);
> =20
> -	get_op.header.type =3D ENCL_OP_GET;
> +	get_op.header.type =3D ENCL_OP_GET_FROM_BUFFER;
>  	get_op.value =3D 0;
> =20
>  	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
> @@ -277,9 +277,9 @@ static bool sysfs_get_ulong(const char *path, unsigne=
d long *value)
> =20
>  TEST_F(enclave, unclobbered_vdso_oversubscribed)
>  {
> +	struct encl_op_get_from_buf get_op;
> +	struct encl_op_put_to_buf put_op;
>  	unsigned long total_mem;
> -	struct encl_op_put put_op;
> -	struct encl_op_get get_op;
> =20
>  	ASSERT_TRUE(sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem));
>  	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
> @@ -287,7 +287,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
>  	memset(&self->run, 0, sizeof(self->run));
>  	self->run.tcs =3D self->encl.encl_base;
> =20
> -	put_op.header.type =3D ENCL_OP_PUT;
> +	put_op.header.type =3D ENCL_OP_PUT_TO_BUFFER;
>  	put_op.value =3D MAGIC;
> =20
>  	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
> @@ -295,7 +295,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
>  	EXPECT_EEXIT(&self->run);
>  	EXPECT_EQ(self->run.user_data, 0);
> =20
> -	get_op.header.type =3D ENCL_OP_GET;
> +	get_op.header.type =3D ENCL_OP_GET_FROM_BUFFER;
>  	get_op.value =3D 0;
> =20
>  	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
> @@ -308,15 +308,15 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
> =20
>  TEST_F(enclave, clobbered_vdso)
>  {
> -	struct encl_op_put put_op;
> -	struct encl_op_get get_op;
> +	struct encl_op_get_from_buf get_op;
> +	struct encl_op_put_to_buf put_op;
> =20
>  	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> =20
>  	memset(&self->run, 0, sizeof(self->run));
>  	self->run.tcs =3D self->encl.encl_base;
> =20
> -	put_op.header.type =3D ENCL_OP_PUT;
> +	put_op.header.type =3D ENCL_OP_PUT_TO_BUFFER;
>  	put_op.value =3D MAGIC;
> =20
>  	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
> @@ -324,7 +324,7 @@ TEST_F(enclave, clobbered_vdso)
>  	EXPECT_EEXIT(&self->run);
>  	EXPECT_EQ(self->run.user_data, 0);
> =20
> -	get_op.header.type =3D ENCL_OP_GET;
> +	get_op.header.type =3D ENCL_OP_GET_FROM_BUFFER;
>  	get_op.value =3D 0;
> =20
>  	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
> @@ -344,8 +344,8 @@ static int test_handler(long rdi, long rsi, long rdx,=
 long ursp, long r8, long r
> =20
>  TEST_F(enclave, clobbered_vdso_and_user_function)
>  {
> -	struct encl_op_put put_op;
> -	struct encl_op_get get_op;
> +	struct encl_op_get_from_buf get_op;
> +	struct encl_op_put_to_buf put_op;
> =20
>  	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metad=
ata));
> =20
> @@ -355,7 +355,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
>  	self->run.user_handler =3D (__u64)test_handler;
>  	self->run.user_data =3D 0xdeadbeef;
> =20
> -	put_op.header.type =3D ENCL_OP_PUT;
> +	put_op.header.type =3D ENCL_OP_PUT_TO_BUFFER;
>  	put_op.value =3D MAGIC;
> =20
>  	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
> @@ -363,7 +363,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
>  	EXPECT_EEXIT(&self->run);
>  	EXPECT_EQ(self->run.user_data, 0);
> =20
> -	get_op.header.type =3D ENCL_OP_GET;
> +	get_op.header.type =3D ENCL_OP_GET_FROM_BUFFER;
>  	get_op.value =3D 0;
> =20
>  	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index f11eb8315704..4e8da738173f 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -16,16 +16,16 @@ static void *memcpy(void *dest, const void *src, size=
_t n)
>  	return dest;
>  }
> =20
> -static void do_encl_op_put(void *op)
> +static void do_encl_op_put_to_buf(void *op)
>  {
> -	struct encl_op_put *op2 =3D op;
> +	struct encl_op_put_to_buf *op2 =3D op;
> =20
>  	memcpy(&encl_buffer[0], &op2->value, 8);
>  }
> =20
> -static void do_encl_op_get(void *op)
> +static void do_encl_op_get_from_buf(void *op)
>  {
> -	struct encl_op_get *op2 =3D op;
> +	struct encl_op_get_from_buf *op2 =3D op;
> =20
>  	memcpy(&op2->value, &encl_buffer[0], 8);
>  }
> @@ -33,8 +33,8 @@ static void do_encl_op_get(void *op)
>  void encl_body(void *rdi,  void *rsi)
>  {
>  	const void (*encl_op_array[ENCL_OP_MAX])(void *) =3D {
> -		do_encl_op_put,
> -		do_encl_op_get,
> +		do_encl_op_put_to_buf,
> +		do_encl_op_get_from_buf,
>  	};
> =20
>  	struct encl_op_header *op =3D (struct encl_op_header *)rdi;


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

