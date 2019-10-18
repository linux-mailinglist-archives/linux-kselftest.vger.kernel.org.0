Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D98DBAF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 02:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438058AbfJRAnQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 20:43:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395553AbfJRAnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 20:43:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so2709505pfh.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vw51OWV5uEctqlYFZeiB4shaNCVmHrKQDBTlux6xZb4=;
        b=MPo+8pEpiqArvLlZb/eY09xP2HW1iYkjfZsgz7F+PgUamaZ91rQab9bzO7D2Mu5REv
         J3XuUEUIBv49m/yOKjvLBrj2KNyC6UJ5hAOgXUA2FUY2DrVgCI8LtoHkiFH4toU8mzDV
         rZk8HqtTyNKntZZtNHLucUEMNZ/9eT/aBZ2psnSaQSBppZHbPWOvl49S7A/a43BkHqWb
         LmEY6w+2OCu0ZM90fCdYXLhK4K5pGDG5+TkNF1B1mzop2lG9j8DBoRPXhx69DFPNcN/Y
         uc3hHWT5ZQW3DkyfVHD/ZhID4bMHpL3+Mp/8oiDv+vpHmZC822UBi9u0KC2AkxB3OMox
         omfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vw51OWV5uEctqlYFZeiB4shaNCVmHrKQDBTlux6xZb4=;
        b=N2z06lDbYuCU8u8SBN6aJ69U+5UvnX6fgZ3kZ5W0Fdb5uRSPjeUdj3Y6c3IbVF91cz
         lNOrvjUD/CWnMv1fKJWJqydk3vMN45Et/3uiFlGNe3UYBSlctMX/DrHZyhmjqb44GKLb
         IcaWSLabindSCY1imZtJOqaH93SPa/JZmnvqlhSt3ZwWBOJ1g9uZzFQKIGyRK2W2qk4x
         9LaXEVt33ZxnT14d/huTYBTi8tU3A/CX65ShYv6lOUu1xI894bzYctXo1K/F9JyaFcbd
         NULzoEwuKXKGWLRmloDywJRL0mXSeQTILUtxcvsPFK0/KyT+chvjSYOMU72dcmDl49A/
         clzA==
X-Gm-Message-State: APjAAAUSPzs7z5DWUlpyoFAlZ6DQjRUge9NdQ4apCI11LAoQxqFI7TNe
        5aG2Ck1l8HeFZ8R67e0YFu2q9Q==
X-Google-Smtp-Source: APXvYqxd9rsgKcALFaQ9iEqXV6FwV1s+8qWzGOTJlEWe1kpEFEVF16RsqDQ1srhqv2PiBcWEsfTb3Q==
X-Received: by 2002:a63:3c3:: with SMTP id 186mr6957620pgd.285.1571359392807;
        Thu, 17 Oct 2019 17:43:12 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id d22sm4342663pfq.168.2019.10.17.17.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:43:12 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:43:07 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, mcgrof@kernel.org,
        tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191018004307.GA95597@google.com>
References: <20191018001816.94460-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018001816.94460-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
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
> ---
> Sorry in advanced for emailing so many people. I suspect that there are
> quite a few people who will be interested in this discussion - not so
> much because of the AppArmor test itself - but because I think this
> patch offers a good place to discuss how we should/will need to handle
> code visibility for the purpose of writing tests.
> 
> I fully expect there to be a great deal of discussion on this patch
> especially on the topic of visibility and how to expose symbols for
> testing. Based on conversations I had before sending this patch out, I
> expect to see a number of different suggestions on how to test symbols
> that are not normally exposed.
> ---
>  security/apparmor/Kconfig                 |  17 +
>  security/apparmor/Makefile                |   1 +
>  security/apparmor/include/policy_unpack.h |  53 ++
>  security/apparmor/policy_unpack.c         |  61 +--
>  security/apparmor/policy_unpack_test.c    | 607 ++++++++++++++++++++++
>  5 files changed, 687 insertions(+), 52 deletions(-)
>  create mode 100644 security/apparmor/policy_unpack_test.c
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index d8b1a360a636..632fbb873389 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -66,3 +66,20 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
>  	  Set the default value of the apparmor.debug kernel parameter.
>  	  When enabled, various debug messages will be logged to
>  	  the kernel message buffer.
> +
> +config SECURITY_APPARMOR_TEST
> +	bool "Build KUnit tests for policy_unpack.c"
> +	default n
> +	depends on KUNIT && SECURITY_APPARMOR

Ted, here is an example where doing select on direct dependencies is
tricky because SECURITY_APPARMOR has a number of indirect dependencies.

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
> diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
> index ff23fcfefe19..7ac1fc2dc045 100644
> --- a/security/apparmor/Makefile
> +++ b/security/apparmor/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for AppArmor Linux Security Module
>  #
>  obj-$(CONFIG_SECURITY_APPARMOR) += apparmor.o
> +obj-$(CONFIG_SECURITY_APPARMOR_TEST) += policy_unpack_test.o
>  
>  apparmor-y := apparmorfs.o audit.o capability.o task.o ipc.o lib.o match.o \
>                path.o domain.o policy.o policy_unpack.o procattr.o lsm.o \
> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
> index 46aefae918f5..dc272bafee2b 100644
> --- a/security/apparmor/include/policy_unpack.h
> +++ b/security/apparmor/include/policy_unpack.h
> @@ -16,6 +16,59 @@
>  #include <linux/dcache.h>
>  #include <linux/workqueue.h>
>  
> +/*
> + * The AppArmor interface treats data as a type byte followed by the
> + * actual data.  The interface has the notion of a a named entry
> + * which has a name (AA_NAME typecode followed by name string) followed by
> + * the entries typecode and data.  Named types allow for optional
> + * elements and extensions to be added and tested for without breaking
> + * backwards compatibility.
> + */
> +
> +enum aa_code {
> +	AA_U8,
> +	AA_U16,
> +	AA_U32,
> +	AA_U64,
> +	AA_NAME,		/* same as string except it is items name */
> +	AA_STRING,
> +	AA_BLOB,
> +	AA_STRUCT,
> +	AA_STRUCTEND,
> +	AA_LIST,
> +	AA_LISTEND,
> +	AA_ARRAY,
> +	AA_ARRAYEND,
> +};
> +
> +/*
> + * aa_ext is the read of the buffer containing the serialized profile.  The
> + * data is copied into a kernel buffer in apparmorfs and then handed off to
> + * the unpack routines.
> + */
> +struct aa_ext {
> +	void *start;
> +	void *end;
> +	void *pos;		/* pointer to current position in the buffer */
> +	u32 version;
> +};
> +
> +/* test if read will be in packed data bounds */
> +static inline bool inbounds(struct aa_ext *e, size_t size)
> +{
> +	return (size <= e->end - e->pos);
> +}
> +
> +size_t unpack_u16_chunk(struct aa_ext *e, char **chunk);
> +bool unpack_X(struct aa_ext *e, enum aa_code code);
> +bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
> +bool unpack_u32(struct aa_ext *e, u32 *data, const char *name);
> +bool unpack_u64(struct aa_ext *e, u64 *data, const char *name);
> +size_t unpack_array(struct aa_ext *e, const char *name);
> +size_t unpack_blob(struct aa_ext *e, char **blob, const char *name);
> +int unpack_str(struct aa_ext *e, const char **string, const char *name);
> +int unpack_strdup(struct aa_ext *e, char **string, const char *name);
> +
>  struct aa_load_ent {
>  	struct list_head list;
>  	struct aa_profile *new;
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 8cfc9493eefc..7811e9b7a154 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -36,43 +36,6 @@
>  #define v7	7
>  #define v8	8	/* full network masking */
>  
> -/*
> - * The AppArmor interface treats data as a type byte followed by the
> - * actual data.  The interface has the notion of a a named entry
> - * which has a name (AA_NAME typecode followed by name string) followed by
> - * the entries typecode and data.  Named types allow for optional
> - * elements and extensions to be added and tested for without breaking
> - * backwards compatibility.
> - */
> -
> -enum aa_code {
> -	AA_U8,
> -	AA_U16,
> -	AA_U32,
> -	AA_U64,
> -	AA_NAME,		/* same as string except it is items name */
> -	AA_STRING,
> -	AA_BLOB,
> -	AA_STRUCT,
> -	AA_STRUCTEND,
> -	AA_LIST,
> -	AA_LISTEND,
> -	AA_ARRAY,
> -	AA_ARRAYEND,
> -};
> -
> -/*
> - * aa_ext is the read of the buffer containing the serialized profile.  The
> - * data is copied into a kernel buffer in apparmorfs and then handed off to
> - * the unpack routines.
> - */
> -struct aa_ext {
> -	void *start;
> -	void *end;
> -	void *pos;		/* pointer to current position in the buffer */
> -	u32 version;
> -};
> -
>  /* audit callback for unpack fields */
>  static void audit_cb(struct audit_buffer *ab, void *va)
>  {
> @@ -194,12 +157,6 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
>  	return d;
>  }
>  
> -/* test if read will be in packed data bounds */
> -static bool inbounds(struct aa_ext *e, size_t size)
> -{
> -	return (size <= e->end - e->pos);
> -}
> -
>  static void *kvmemdup(const void *src, size_t len)
>  {
>  	void *p = kvmalloc(len, GFP_KERNEL);
> @@ -216,7 +173,7 @@ static void *kvmemdup(const void *src, size_t len)
>   *
>   * Returns: the size of chunk found with the read head at the end of the chunk.
>   */
> -static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
> +size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)

Here and below are a number of parsing functions that we would like to
test.

I know that if we decide to just make them not-static, as I have done,
we will also want to properly namespace them. Nevertheless, I didn't
bother doing that yet since I suspect people may not actually want to
make them non-static.

In Mike's original version of this test[1], he just put the test in the
policy_unpack.c file thereby sidestepping the visibility issue entirely.
However, I am not a huge fan of mixing code and tests.

Another alternative, is just testing through the aa_unpack()[2] function
which is already visible; this has the advantage of not changing the
code under test and follows the principle of only testing public
interfaces, but has the downside that tests become more complicated as
each one has to produce a complete policy object.

I added Alan to this discussion because he has an idea for a function
called kunit_find_symbol()[3] which allows symbols to be looked up by name
so that they can be used.

Another possibility is to make a macro that makes the symbol only
visible when building with CONFIG_KUNIT enabled. It might look something
like this:

#if IS_ENABLED(CONFIG_KUNIT)
/**
 * __visible_for_testing - Makes a static function visible when testing.
 *
 * A macro that replaces the `static` specifier on functions and global
 * variables that is static when compiled normally and visible when compiled for
 * tests.
 */
#define __visible_for_testing
#else
#define __visible_for_testing static
#endif

and would be used like this:

Instead of

static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
{...}

we would have

__visible_for_testing size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
{...}

in this case we would still probably want to properly namespace the
symbol to avoid the possibility of collisions when testing.

There were some other ideas that were mentioned; however, I will leave
it to those people to present their ideas.

>  {
>  	size_t size = 0;
>  	void *pos = e->pos;
> @@ -237,7 +194,7 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
>  }
>  
>  /* unpack control byte */
> -static bool unpack_X(struct aa_ext *e, enum aa_code code)
> +bool unpack_X(struct aa_ext *e, enum aa_code code)
>  {
>  	if (!inbounds(e, 1))
>  		return 0;
> @@ -263,7 +220,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
>   *
>   * Returns: 0 if either match fails, the read head does not move
>   */
> -static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
> +bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>  {
>  	/*
>  	 * May need to reset pos if name or type doesn't match
> @@ -311,7 +268,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
>  	return 0;
>  }
>  
> -static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
> +bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>  {
>  	void *pos = e->pos;
>  
> @@ -329,7 +286,7 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>  	return 0;
>  }
>  
> -static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
> +bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>  {
>  	void *pos = e->pos;
>  
> @@ -347,7 +304,7 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>  	return 0;
>  }
>  
> -static size_t unpack_array(struct aa_ext *e, const char *name)
> +size_t unpack_array(struct aa_ext *e, const char *name)
>  {
>  	void *pos = e->pos;
>  
> @@ -365,7 +322,7 @@ static size_t unpack_array(struct aa_ext *e, const char *name)
>  	return 0;
>  }
>  
> -static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
> +size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>  {
>  	void *pos = e->pos;
>  
> @@ -387,7 +344,7 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>  	return 0;
>  }
>  
> -static int unpack_str(struct aa_ext *e, const char **string, const char *name)
> +int unpack_str(struct aa_ext *e, const char **string, const char *name)
>  {
>  	char *src_str;
>  	size_t size = 0;
> @@ -410,7 +367,7 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
>  	return 0;
>  }
>  
> -static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
> +int unpack_strdup(struct aa_ext *e, char **string, const char *name)
>  {
>  	const char *tmp;
>  	void *pos = e->pos;
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> new file mode 100644
> index 000000000000..3907f7d642e6
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
> +	KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
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
> +	KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
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
> -- 
> 2.23.0.866.gb869b98d4c-goog

[1] https://gitlab.com/apparmor/apparmor-kernel/blob/apparmor-kunit/security/apparmor/policy_unpack.c#L1066
[2] https://kunit-review.googlesource.com/c/linux/+/2809/3/security/apparmor/policy_unpack.c#b1054
[3] https://lore.kernel.org/linux-kselftest/alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com/
