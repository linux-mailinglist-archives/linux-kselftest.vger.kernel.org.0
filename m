Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3641CF10BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 09:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfKFIFl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Nov 2019 03:05:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46345 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfKFIFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Nov 2019 03:05:41 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iSGJp-0002gY-0g; Wed, 06 Nov 2019 08:05:33 +0000
Subject: Re: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        mcgrof@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
References: <20191106004329.16991-1-brendanhiggins@google.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <68930b26-b103-ab42-fcf4-b85451b97ce5@canonical.com>
Date:   Wed, 6 Nov 2019 00:05:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106004329.16991-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/19 4:43 PM, Brendan Higgins wrote:
> From: Mike Salvatore <mike.salvatore@canonical.com>
> 
> Add KUnit tests to test AppArmor unpacking of userspace policies.
> AppArmor uses a serialized binary format for loading policies. To find
> policy format documentation see
> Documentation/admin-guide/LSM/apparmor.rst.
> 
> In order to write the tests against the policy unpacking code, some
> static functions needed to be exposed for testing purposes. One of the
> goals of this patch is to establish a pattern for which testing these
> kinds of functions should be done in the future.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>

LGTM

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  security/apparmor/Kconfig              |  16 +
>  security/apparmor/policy_unpack.c      |   4 +
>  security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
>  3 files changed, 627 insertions(+)
>  create mode 100644 security/apparmor/policy_unpack_test.c
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index d8b1a360a6368..78a33ccac2574 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
>  	  Set the default value of the apparmor.debug kernel parameter.
>  	  When enabled, various debug messages will be logged to
>  	  the kernel message buffer.
> +
> +config SECURITY_APPARMOR_KUNIT_TEST
> +	bool "Build KUnit tests for policy_unpack.c"
> +	depends on KUNIT && SECURITY_APPARMOR
> +	help
> +	  This builds the AppArmor KUnit tests.
> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 8cfc9493eefc7..37c1dd3178fc0 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>  
>  	return error;
>  }
> +
> +#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> +#include "policy_unpack_test.c"
> +#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> new file mode 100644
> index 0000000000000..533137f45361c
> --- /dev/null
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for AppArmor's policy unpack.
> + */
> +
> +#include <kunit/test.h>
> +
> +#include "include/policy.h"
> +#include "include/policy_unpack.h"
> +
> +#define TEST_STRING_NAME "TEST_STRING"
> +#define TEST_STRING_DATA "testing"
> +#define TEST_STRING_BUF_OFFSET \
> +	(3 + strlen(TEST_STRING_NAME) + 1)
> +
> +#define TEST_U32_NAME "U32_TEST"
> +#define TEST_U32_DATA ((u32)0x01020304)
> +#define TEST_NAMED_U32_BUF_OFFSET \
> +	(TEST_STRING_BUF_OFFSET + 3 + strlen(TEST_STRING_DATA) + 1)
> +#define TEST_U32_BUF_OFFSET \
> +	(TEST_NAMED_U32_BUF_OFFSET + 3 + strlen(TEST_U32_NAME) + 1)
> +
> +#define TEST_U16_OFFSET (TEST_U32_BUF_OFFSET + 3)
> +#define TEST_U16_DATA ((u16)(TEST_U32_DATA >> 16))
> +
> +#define TEST_U64_NAME "U64_TEST"
> +#define TEST_U64_DATA ((u64)0x0102030405060708)
> +#define TEST_NAMED_U64_BUF_OFFSET (TEST_U32_BUF_OFFSET + sizeof(u32) + 1)
> +#define TEST_U64_BUF_OFFSET \
> +	(TEST_NAMED_U64_BUF_OFFSET + 3 + strlen(TEST_U64_NAME) + 1)
> +
> +#define TEST_BLOB_NAME "BLOB_TEST"
> +#define TEST_BLOB_DATA "\xde\xad\x00\xbe\xef"
> +#define TEST_BLOB_DATA_SIZE (ARRAY_SIZE(TEST_BLOB_DATA))
> +#define TEST_NAMED_BLOB_BUF_OFFSET (TEST_U64_BUF_OFFSET + sizeof(u64) + 1)
> +#define TEST_BLOB_BUF_OFFSET \
> +	(TEST_NAMED_BLOB_BUF_OFFSET + 3 + strlen(TEST_BLOB_NAME) + 1)
> +
> +#define TEST_ARRAY_NAME "ARRAY_TEST"
> +#define TEST_ARRAY_SIZE 16
> +#define TEST_NAMED_ARRAY_BUF_OFFSET \
> +	(TEST_BLOB_BUF_OFFSET + 5 + TEST_BLOB_DATA_SIZE)
> +#define TEST_ARRAY_BUF_OFFSET \
> +	(TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
> +
> +struct policy_unpack_fixture {
> +	struct aa_ext *e;
> +	size_t e_size;
> +};
> +
> +struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
> +				   struct kunit *test, size_t buf_size)
> +{
> +	char *buf;
> +	struct aa_ext *e;
> +
> +	buf = kunit_kzalloc(test, buf_size, GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, buf);
> +
> +	e = kunit_kmalloc(test, sizeof(*e), GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, e);
> +
> +	e->start = buf;
> +	e->end = e->start + buf_size;
> +	e->pos = e->start;
> +
> +	*buf = AA_NAME;
> +	*(buf + 1) = strlen(TEST_STRING_NAME) + 1;
> +	strcpy(buf + 3, TEST_STRING_NAME);
> +
> +	buf = e->start + TEST_STRING_BUF_OFFSET;
> +	*buf = AA_STRING;
> +	*(buf + 1) = strlen(TEST_STRING_DATA) + 1;
> +	strcpy(buf + 3, TEST_STRING_DATA);
> +
> +	buf = e->start + TEST_NAMED_U32_BUF_OFFSET;
> +	*buf = AA_NAME;
> +	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
> +	strcpy(buf + 3, TEST_U32_NAME);
> +	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
> +	*((u32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = TEST_U32_DATA;
> +
> +	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
> +	*buf = AA_NAME;
> +	*(buf + 1) = strlen(TEST_U64_NAME) + 1;
> +	strcpy(buf + 3, TEST_U64_NAME);
> +	*(buf + 3 + strlen(TEST_U64_NAME) + 1) = AA_U64;
> +	*((u64 *)(buf + 3 + strlen(TEST_U64_NAME) + 2)) = TEST_U64_DATA;
> +
> +	buf = e->start + TEST_NAMED_BLOB_BUF_OFFSET;
> +	*buf = AA_NAME;
> +	*(buf + 1) = strlen(TEST_BLOB_NAME) + 1;
> +	strcpy(buf + 3, TEST_BLOB_NAME);
> +	*(buf + 3 + strlen(TEST_BLOB_NAME) + 1) = AA_BLOB;
> +	*(buf + 3 + strlen(TEST_BLOB_NAME) + 2) = TEST_BLOB_DATA_SIZE;
> +	memcpy(buf + 3 + strlen(TEST_BLOB_NAME) + 6,
> +		TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE);
> +
> +	buf = e->start + TEST_NAMED_ARRAY_BUF_OFFSET;
> +	*buf = AA_NAME;
> +	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
> +	strcpy(buf + 3, TEST_ARRAY_NAME);
> +	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
> +	*((u16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = TEST_ARRAY_SIZE;
> +
> +	return e;
> +}
> +
> +static int policy_unpack_test_init(struct kunit *test)
> +{
> +	size_t e_size = TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1;
> +	struct policy_unpack_fixture *puf;
> +
> +	puf = kunit_kmalloc(test, sizeof(*puf), GFP_USER);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, puf);
> +
> +	puf->e_size = e_size;
> +	puf->e = build_aa_ext_struct(puf, test, e_size);
> +
> +	test->priv = puf;
> +	return 0;
> +}
> +
> +static void policy_unpack_test_inbounds_when_inbounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +
> +	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, 0));
> +	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size / 2));
> +	KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size));
> +}
> +
> +static void policy_unpack_test_inbounds_when_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +
> +	KUNIT_EXPECT_FALSE(test, inbounds(puf->e, puf->e_size + 1));
> +}
> +
> +static void policy_unpack_test_unpack_array_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	u16 array_size;
> +
> +	puf->e->pos += TEST_ARRAY_BUF_OFFSET;
> +
> +	array_size = unpack_array(puf->e, NULL);
> +
> +	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_ARRAY_NAME;
> +	u16 array_size;
> +
> +	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
> +
> +	array_size = unpack_array(puf->e, name);
> +
> +	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_ARRAY_NAME;
> +	u16 array_size;
> +
> +	puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
> +	puf->e->end = puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
> +
> +	array_size = unpack_array(puf->e, name);
> +
> +	KUNIT_EXPECT_EQ(test, array_size, (u16)0);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_blob_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *blob = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_BLOB_BUF_OFFSET;
> +	size = unpack_blob(puf->e, &blob, NULL);
> +
> +	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> +	KUNIT_EXPECT_TRUE(test,
> +		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> +}
> +
> +static void policy_unpack_test_unpack_blob_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *blob = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
> +	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
> +
> +	KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> +	KUNIT_EXPECT_TRUE(test,
> +		memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
> +}
> +
> +static void policy_unpack_test_unpack_blob_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *blob = NULL;
> +	void *start;
> +	int size;
> +
> +	puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
> +	start = puf->e->pos;
> +	puf->e->end = puf->e->start + TEST_BLOB_BUF_OFFSET
> +		+ TEST_BLOB_DATA_SIZE - 1;
> +
> +	size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
> +
> +	KUNIT_EXPECT_EQ(test, size, 0);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> +}
> +
> +static void policy_unpack_test_unpack_str_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char *string = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_STRING_BUF_OFFSET;
> +	size = unpack_str(puf->e, &string, NULL);
> +
> +	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
> +	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +}
> +
> +static void policy_unpack_test_unpack_str_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char *string = NULL;
> +	size_t size;
> +
> +	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
> +
> +	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
> +	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +}
> +
> +static void policy_unpack_test_unpack_str_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char *string = NULL;
> +	void *start = puf->e->pos;
> +	int size;
> +
> +	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
> +		+ strlen(TEST_STRING_DATA) - 1;
> +
> +	size = unpack_str(puf->e, &string, TEST_STRING_NAME);
> +
> +	KUNIT_EXPECT_EQ(test, size, 0);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> +}
> +
> +static void policy_unpack_test_unpack_strdup_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *string = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_STRING_BUF_OFFSET;
> +	size = unpack_strdup(puf->e, &string, NULL);
> +
> +	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
> +	KUNIT_EXPECT_FALSE(test,
> +			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
> +			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
> +	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +}
> +
> +static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *string = NULL;
> +	size_t size;
> +
> +	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
> +
> +	KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
> +	KUNIT_EXPECT_FALSE(test,
> +			   ((uintptr_t)puf->e->start <= (uintptr_t)string)
> +			   && ((uintptr_t)string <= (uintptr_t)puf->e->end));
> +	KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> +}
> +
> +static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	void *start = puf->e->pos;
> +	char *string = NULL;
> +	int size;
> +
> +	puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
> +		+ strlen(TEST_STRING_DATA) - 1;
> +
> +	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
> +
> +	KUNIT_EXPECT_EQ(test, size, 0);
> +	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> +}
> +
> +static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success;
> +
> +	puf->e->pos += TEST_U32_BUF_OFFSET;
> +
> +	success = unpack_nameX(puf->e, AA_U32, NULL);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
> +}
> +
> +static void policy_unpack_test_unpack_nameX_with_wrong_code(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success;
> +
> +	puf->e->pos += TEST_U32_BUF_OFFSET;
> +
> +	success = unpack_nameX(puf->e, AA_BLOB, NULL);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			    puf->e->start + TEST_U32_BUF_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_nameX_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_U32_NAME;
> +	bool success;
> +
> +	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
> +
> +	success = unpack_nameX(puf->e, AA_U32, name);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			    puf->e->start + TEST_U32_BUF_OFFSET + 1);
> +}
> +
> +static void policy_unpack_test_unpack_nameX_with_wrong_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	static const char name[] = "12345678";
> +	bool success;
> +
> +	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
> +
> +	success = unpack_nameX(puf->e, AA_U32, name);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			    puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *chunk = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_U16_OFFSET;
> +	/*
> +	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
> +	 * the end of the allocated memory. Doing anything other than comparing
> +	 * memory addresses is dangerous.
> +	 */
> +	puf->e->end += TEST_U16_DATA;
> +
> +	size = unpack_u16_chunk(puf->e, &chunk);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, (void *)chunk,
> +			    puf->e->start + TEST_U16_OFFSET + 2);
> +	KUNIT_EXPECT_EQ(test, size, (size_t)TEST_U16_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, (void *)(chunk + TEST_U16_DATA));
> +}
> +
> +static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
> +		struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *chunk = NULL;
> +	size_t size;
> +
> +	puf->e->pos = puf->e->end - 1;
> +
> +	size = unpack_u16_chunk(puf->e, &chunk);
> +
> +	KUNIT_EXPECT_EQ(test, size, (size_t)0);
> +	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
> +}
> +
> +static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
> +		struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	char *chunk = NULL;
> +	size_t size;
> +
> +	puf->e->pos += TEST_U16_OFFSET;
> +	/*
> +	 * WARNING: For unit testing purposes, we're pushing puf->e->end past
> +	 * the end of the allocated memory. Doing anything other than comparing
> +	 * memory addresses is dangerous.
> +	 */
> +	puf->e->end = puf->e->pos + TEST_U16_DATA - 1;
> +
> +	size = unpack_u16_chunk(puf->e, &chunk);
> +
> +	KUNIT_EXPECT_EQ(test, size, (size_t)0);
> +	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_u32_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success;
> +	u32 data;
> +
> +	puf->e->pos += TEST_U32_BUF_OFFSET;
> +
> +	success = unpack_u32(puf->e, &data, NULL);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_u32_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_U32_NAME;
> +	bool success;
> +	u32 data;
> +
> +	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
> +
> +	success = unpack_u32(puf->e, &data, name);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_u32_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_U32_NAME;
> +	bool success;
> +	u32 data;
> +
> +	puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
> +	puf->e->end = puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32);
> +
> +	success = unpack_u32(puf->e, &data, name);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_NAMED_U32_BUF_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_u64_with_null_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success;
> +	u64 data;
> +
> +	puf->e->pos += TEST_U64_BUF_OFFSET;
> +
> +	success = unpack_u64(puf->e, &data, NULL);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_u64_with_name(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_U64_NAME;
> +	bool success;
> +	u64 data;
> +
> +	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
> +
> +	success = unpack_u64(puf->e, &data, name);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64) + 1);
> +}
> +
> +static void policy_unpack_test_unpack_u64_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	const char name[] = TEST_U64_NAME;
> +	bool success;
> +	u64 data;
> +
> +	puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
> +	puf->e->end = puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64);
> +
> +	success = unpack_u64(puf->e, &data, name);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> +			puf->e->start + TEST_NAMED_U64_BUF_OFFSET);
> +}
> +
> +static void policy_unpack_test_unpack_X_code_match(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success = unpack_X(puf->e, AA_NAME);
> +
> +	KUNIT_EXPECT_TRUE(test, success);
> +	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start + 1);
> +}
> +
> +static void policy_unpack_test_unpack_X_code_mismatch(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success = unpack_X(puf->e, AA_STRING);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +	KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start);
> +}
> +
> +static void policy_unpack_test_unpack_X_out_of_bounds(struct kunit *test)
> +{
> +	struct policy_unpack_fixture *puf = test->priv;
> +	bool success;
> +
> +	puf->e->pos = puf->e->end;
> +	success = unpack_X(puf->e, AA_NAME);
> +
> +	KUNIT_EXPECT_FALSE(test, success);
> +}
> +
> +static struct kunit_case apparmor_policy_unpack_test_cases[] = {
> +	KUNIT_CASE(policy_unpack_test_inbounds_when_inbounds),
> +	KUNIT_CASE(policy_unpack_test_inbounds_when_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_array_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_array_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_array_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_blob_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_blob_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_blob_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_code),
> +	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_nameX_with_wrong_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_str_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_str_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_str_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_strdup_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_strdup_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_basic),
> +	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_1),
> +	KUNIT_CASE(policy_unpack_test_unpack_u16_chunk_out_of_bounds_2),
> +	KUNIT_CASE(policy_unpack_test_unpack_u32_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_u32_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_u32_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_u64_with_null_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_u64_with_name),
> +	KUNIT_CASE(policy_unpack_test_unpack_u64_out_of_bounds),
> +	KUNIT_CASE(policy_unpack_test_unpack_X_code_match),
> +	KUNIT_CASE(policy_unpack_test_unpack_X_code_mismatch),
> +	KUNIT_CASE(policy_unpack_test_unpack_X_out_of_bounds),
> +	{},
> +};
> +
> +static struct kunit_suite apparmor_policy_unpack_test_module = {
> +	.name = "apparmor_policy_unpack",
> +	.init = policy_unpack_test_init,
> +	.test_cases = apparmor_policy_unpack_test_cases,
> +};
> +
> +kunit_test_suite(apparmor_policy_unpack_test_module);
> 

