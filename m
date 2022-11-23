Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802DF635573
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiKWJUI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbiKWJTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 04:19:55 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3923EA5
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 01:19:52 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id v28so1791628vkn.10
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Nov 2022 01:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/E6D2KLoPQkHC/d15ElrH5jwxYMn0dFSPdCSLnCG0A=;
        b=eg+wKPxJPAEDSjA3kN1r+z6G29U5r3WM/JYrR8l4kBJeOKeVxZy2YWz9B9aswSa0kw
         Ep/ol0RMThR6HBtkRk4X9zRPKAJ1p6ZSsrnkIWwsk2RdJP9Z1YFkISid8ibKO7lcZ8+I
         1p6fHK+tqqfkAbFVpImUj7m3YM6sEI9E3gmKzF/s488x8xD+ikibntsx1VcP30vrURRx
         gJBym6hhuecss5RlwqtC1wK5qJQqjufNyqJDR6DX4Pgcu5LhTkhd9DHFAUM6pSd1L4vf
         qzXk+H+Fi+m6b8s7bZ01rX3+LNsQ8SBBH5DhJRJjukNfZAr8nlf0ab1lcnmm6u2MbW1g
         RT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/E6D2KLoPQkHC/d15ElrH5jwxYMn0dFSPdCSLnCG0A=;
        b=QMU3v5nxYSuhGVZIQRRhpY8mdirixDcsGrF+KXPMhOii1g+f9mpJDHPCjCob0hTpqg
         8WHHUDI5lJe+dJ25iXKM6QMkLZ///jCsItUWKIrq1Q+x4t/e23n3YwZl/LxRPab/yuq5
         3MKlv/GqndE8pVBBOdzBTdH9w9JLJ9V6Wt9jPl6Di8pnYXuCDMlKoYxQYMj3gpWa8UMD
         bmJS8JInEvulgLdmtpC17FSrJVFDPFlYV6nEvVPYUOxaLucZvBDudGTGHVnTMMcTMIm0
         nCsmgd4ooaZYEcrBvIBSR6wmiZw4r3mQLQIINX83zMCf5JGv/twDNINtFbQrhsws41Jc
         irpA==
X-Gm-Message-State: ANoB5pmOY/HGIxZskHIUYucepOaWcCC2tmzfPMSf/VVsyuId2laPG042
        8fqhrZmEvCVW8cYoztcrLlV2MPUXfubbcqKws+dgWQ==
X-Google-Smtp-Source: AA0mqf4v/lSMiv+VQztYC9J+tX9N6wZCVRlbMlFcKO6bjp7g359goNsX4etvwTpQ+NOGWYgQen99CKRTsw8PjqoqSQE=
X-Received: by 2002:a1f:b693:0:b0:3bc:7ad1:1e2e with SMTP id
 g141-20020a1fb693000000b003bc7ad11e2emr5362652vkf.7.1669195191160; Wed, 23
 Nov 2022 01:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20221102175959.2921063-1-rmoar@google.com> <20221102175959.2921063-3-rmoar@google.com>
 <3fbf707a-fc9e-18c6-dc40-ec266bd524e5@canonical.com>
In-Reply-To: <3fbf707a-fc9e-18c6-dc40-ec266bd524e5@canonical.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 23 Nov 2022 17:19:38 +0800
Message-ID: <CABVgOSkTojOjNv05aiD9tV7Vw12QOTtw9H9qCPFjjm_COdKb8w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] apparmor: test: make static symbols visible during
 kunit testing
To:     John Johansen <john.johansen@canonical.com>
Cc:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000075ac9a05ee1fcad3"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000075ac9a05ee1fcad3
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 22, 2022 at 2:20 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 11/2/22 10:59, Rae Moar wrote:
> > Use macros, VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT, to allow
> > static symbols to be conditionally set to be visible during KUnit
> > testing. Remove the need to include testing file in the implementation
> > file. Provide example of how static symbols can be dealt with in
> > testing.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >   security/apparmor/Kconfig                 |  4 +-
> >   security/apparmor/Makefile                |  2 +
> >   security/apparmor/include/policy_unpack.h | 50 ++++++++++++++++
> >   security/apparmor/policy_unpack.c         | 72 +++++++----------------
> >   security/apparmor/policy_unpack_test.c    |  5 ++
> >   5 files changed, 80 insertions(+), 53 deletions(-)
> >
> > diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> > index cb3496e00d8a..f334e7cccf2d 100644
> > --- a/security/apparmor/Kconfig
> > +++ b/security/apparmor/Kconfig
> > @@ -106,8 +106,8 @@ config SECURITY_APPARMOR_PARANOID_LOAD
> >         Disabling the check will speed up policy loads.
> >
> >   config SECURITY_APPARMOR_KUNIT_TEST
> > -     bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
> > -     depends on KUNIT=y && SECURITY_APPARMOR
> > +     tristate "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
> > +     depends on KUNIT && SECURITY_APPARMOR
> >       default KUNIT_ALL_TESTS
> >       help
> >         This builds the AppArmor KUnit tests.
> > diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
> > index ff23fcfefe19..6a92428375eb 100644
> > --- a/security/apparmor/Makefile
> > +++ b/security/apparmor/Makefile
> > @@ -8,6 +8,8 @@ apparmor-y := apparmorfs.o audit.o capability.o task.o ipc.o lib.o match.o \
> >                 resource.o secid.o file.o policy_ns.o label.o mount.o net.o
> >   apparmor-$(CONFIG_SECURITY_APPARMOR_HASH) += crypto.o
> >
> > +obj-$(CONFIG_SECURITY_APPARMOR_KUNIT_TEST) += policy_unpack_test.o
> > +
> >   clean-files := capability_names.h rlim_names.h net_names.h
> >
> >   # Build a lower case string table of address family names
> > diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
> > index eb5f7d7f132b..a963687bcc9b 100644
> > --- a/security/apparmor/include/policy_unpack.h
> > +++ b/security/apparmor/include/policy_unpack.h
> > @@ -48,6 +48,43 @@ enum {
> >       AAFS_LOADDATA_NDENTS            /* count of entries */
> >   };
> >
> > +/*
> > + * The AppArmor interface treats data as a type byte followed by the
> > + * actual data.  The interface has the notion of a named entry
> > + * which has a name (AA_NAME typecode followed by name string) followed by
> > + * the entries typecode and data.  Named types allow for optional
> > + * elements and extensions to be added and tested for without breaking
> > + * backwards compatibility.
> > + */
> > +
> > +enum aa_code {
> > +     AA_U8,
> > +     AA_U16,
> > +     AA_U32,
> > +     AA_U64,
> > +     AA_NAME,                /* same as string except it is items name */
> > +     AA_STRING,
> > +     AA_BLOB,
> > +     AA_STRUCT,
> > +     AA_STRUCTEND,
> > +     AA_LIST,
> > +     AA_LISTEND,
> > +     AA_ARRAY,
> > +     AA_ARRAYEND,
> > +};
> > +
> > +/*
> > + * aa_ext is the read of the buffer containing the serialized profile.  The
> > + * data is copied into a kernel buffer in apparmorfs and then handed off to
> > + * the unpack routines.
> > + */
> > +struct aa_ext {
> > +     void *start;
> > +     void *end;
> > +     void *pos;              /* pointer to current position in the buffer */
> > +     u32 version;
> > +};
> > +
>
> hrmmm, I prefer these symbols to be only available to the unpack code but can
> live with them being more widely available.
>
> >   /*
> >    * struct aa_loaddata - buffer of policy raw_data set
> >    *
> > @@ -126,4 +163,17 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
> >               kref_put(&data->count, aa_loaddata_kref);
> >   }
> >
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +bool inbounds(struct aa_ext *e, size_t size);
> > +size_t unpack_u16_chunk(struct aa_ext *e, char **chunk);
> > +bool unpack_X(struct aa_ext *e, enum aa_code code);
> > +bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
> > +bool unpack_u32(struct aa_ext *e, u32 *data, const char *name);
> > +bool unpack_u64(struct aa_ext *e, u64 *data, const char *name);
> > +size_t unpack_array(struct aa_ext *e, const char *name);
> > +size_t unpack_blob(struct aa_ext *e, char **blob, const char *name);
> > +int unpack_str(struct aa_ext *e, const char **string, const char *name);
> > +int unpack_strdup(struct aa_ext *e, char **string, const char *name);
>
> So this is a problem. If this symbols are going to be visible outside of the
> unpack code they need to be prefixed with aa_ to help avoid collisions with
> other kernel code.
>

Hmm... I agree we need some sort of way of restricting access to these symbols.

As-is, they're _exported_ to a different symbol namespace, so it
shouldn't be a problem during linking when built as a module, nor if
KUnit is disabled (due to the preprocessor step).

One option is to put these in a separate header (that only the test
and policy-unpack code include), but even that doesn't solve the
linking problem when built-in.

So I guess namespacing is the only option which solves all of these
problems. (It'd be nice if the symbol namespacing system worked for
built-ins as well as modules...)

> > +#endif
> > +
> >   #endif /* __POLICY_INTERFACE_H */
> > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> > index 55d31bac4f35..c23aa70349aa 100644
> > --- a/security/apparmor/policy_unpack.c
> > +++ b/security/apparmor/policy_unpack.c
> > @@ -14,6 +14,7 @@
> >    */
> >
> >   #include <asm/unaligned.h>
> > +#include <kunit/visibility.h>
> >   #include <linux/ctype.h>
> >   #include <linux/errno.h>
> >   #include <linux/zlib.h>
> > @@ -37,43 +38,6 @@
> >   #define v7  7
> >   #define v8  8       /* full network masking */
> >
> > -/*
> > - * The AppArmor interface treats data as a type byte followed by the
> > - * actual data.  The interface has the notion of a named entry
> > - * which has a name (AA_NAME typecode followed by name string) followed by
> > - * the entries typecode and data.  Named types allow for optional
> > - * elements and extensions to be added and tested for without breaking
> > - * backwards compatibility.
> > - */
> > -
> > -enum aa_code {
> > -     AA_U8,
> > -     AA_U16,
> > -     AA_U32,
> > -     AA_U64,
> > -     AA_NAME,                /* same as string except it is items name */
> > -     AA_STRING,
> > -     AA_BLOB,
> > -     AA_STRUCT,
> > -     AA_STRUCTEND,
> > -     AA_LIST,
> > -     AA_LISTEND,
> > -     AA_ARRAY,
> > -     AA_ARRAYEND,
> > -};
> > -
> > -/*
> > - * aa_ext is the read of the buffer containing the serialized profile.  The
> > - * data is copied into a kernel buffer in apparmorfs and then handed off to
> > - * the unpack routines.
> > - */
> > -struct aa_ext {
> > -     void *start;
> > -     void *end;
> > -     void *pos;              /* pointer to current position in the buffer */
> > -     u32 version;
> > -};
> > -
> >   /* audit callback for unpack fields */
> >   static void audit_cb(struct audit_buffer *ab, void *va)
> >   {
> > @@ -199,10 +163,11 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
> >   }
> >
> >   /* test if read will be in packed data bounds */
> > -static bool inbounds(struct aa_ext *e, size_t size)
> > +VISIBLE_IF_KUNIT bool inbounds(struct aa_ext *e, size_t size)
> >   {
> >       return (size <= e->end - e->pos);
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(inbounds);
> >
> >   static void *kvmemdup(const void *src, size_t len)
> >   {
> > @@ -220,7 +185,7 @@ static void *kvmemdup(const void *src, size_t len)
> >    *
> >    * Returns: the size of chunk found with the read head at the end of the chunk.
> >    */
> > -static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
> > +VISIBLE_IF_KUNIT size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
> >   {
> >       size_t size = 0;
> >       void *pos = e->pos;
> > @@ -239,9 +204,10 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
> >       e->pos = pos;
> >       return 0;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_u16_chunk);
> >
> >   /* unpack control byte */
> > -static bool unpack_X(struct aa_ext *e, enum aa_code code)
> > +VISIBLE_IF_KUNIT bool unpack_X(struct aa_ext *e, enum aa_code code)
> >   {
> >       if (!inbounds(e, 1))
> >               return false;
> > @@ -250,6 +216,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
> >       e->pos++;
> >       return true;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_X);
> >
> >   /**
> >    * unpack_nameX - check is the next element is of type X with a name of @name
> > @@ -267,7 +234,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
> >    *
> >    * Returns: false if either match fails, the read head does not move
> >    */
> > -static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
> > +VISIBLE_IF_KUNIT bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
> >   {
> >       /*
> >        * May need to reset pos if name or type doesn't match
> > @@ -296,6 +263,7 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
> >       e->pos = pos;
> >       return false;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_nameX);
> >
> >   static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
> >   {
> > @@ -315,7 +283,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
> >       return false;
> >   }
> >
> > -static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
> > +VISIBLE_IF_KUNIT bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
> >   {
> >       void *pos = e->pos;
> >
> > @@ -332,8 +300,9 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
> >       e->pos = pos;
> >       return false;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_u32);
> >
> > -static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
> > +VISIBLE_IF_KUNIT bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
> >   {
> >       void *pos = e->pos;
> >
> > @@ -350,8 +319,9 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
> >       e->pos = pos;
> >       return false;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_u64);
> >
> > -static size_t unpack_array(struct aa_ext *e, const char *name)
> > +VISIBLE_IF_KUNIT size_t unpack_array(struct aa_ext *e, const char *name)
> >   {
> >       void *pos = e->pos;
> >
> > @@ -368,8 +338,9 @@ static size_t unpack_array(struct aa_ext *e, const char *name)
> >       e->pos = pos;
> >       return 0;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_array);
> >
> > -static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
> > +VISIBLE_IF_KUNIT size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
> >   {
> >       void *pos = e->pos;
> >
> > @@ -390,8 +361,9 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
> >       e->pos = pos;
> >       return 0;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_blob);
> >
> > -static int unpack_str(struct aa_ext *e, const char **string, const char *name)
> > +VISIBLE_IF_KUNIT int unpack_str(struct aa_ext *e, const char **string, const char *name)
> >   {
> >       char *src_str;
> >       size_t size = 0;
> > @@ -413,8 +385,9 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
> >       e->pos = pos;
> >       return 0;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_str);
> >
> > -static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
> > +VISIBLE_IF_KUNIT int unpack_strdup(struct aa_ext *e, char **string, const char *name)
> >   {
> >       const char *tmp;
> >       void *pos = e->pos;
> > @@ -432,6 +405,7 @@ static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
> >
> >       return res;
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(unpack_strdup);
> >
> Again if the symbols are going to be exported they need the aa_ prefix
>
> But I am not sure this is worth doing, exporting a lot of symbols just so the
> test code can be built as a module doesn't seem worth it to me.
>

Again, agreed that we need to namespace these for the non-module case
(the symbol namespacing should be okay otherwise).

One of the reasons behind doing this is that there are a few KUnit
users who can only run tests which are built as modules. In
particular, Android and (IIRC) Red Hat are both configuring all of
their kernels with KUnit built as a module, and distributing the KUnit
and KUnit test modules in a different package.

If we kept things the way there are, then it'd not be possible to
unconditionally _build_ the apparmor tests, but only load and run them
on demand (due to the way they're built into the apparmor module,
they'd always run when it loads). This is a no-go for Android/Red Hat,
so they won't ship or run the apparmor tests. (There are some other
tests with the same problem, notably amdgpu, but apparmor seemed a
nice first trial-user, as it were, having a small but non-trivial
number of symbols to export.)

Thoughts?

> >
> >   /**
> > @@ -1251,7 +1225,3 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
> >
> >       return error;
> >   }
> > -
> > -#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> > -#include "policy_unpack_test.c"
> > -#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> > diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> > index 0a969b2e03db..3474fe2cd922 100644
> > --- a/security/apparmor/policy_unpack_test.c
> > +++ b/security/apparmor/policy_unpack_test.c
> > @@ -4,6 +4,7 @@
> >    */
> >
> >   #include <kunit/test.h>
> > +#include <kunit/visibility.h>
> >
> >   #include "include/policy.h"
> >   #include "include/policy_unpack.h"
> > @@ -43,6 +44,8 @@
> >   #define TEST_ARRAY_BUF_OFFSET \
> >       (TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
> >
> > +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> > +
> >   struct policy_unpack_fixture {
> >       struct aa_ext *e;
> >       size_t e_size;
> > @@ -605,3 +608,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
> >   };
> >
> >   kunit_test_suite(apparmor_policy_unpack_test_module);
> > +
> > +MODULE_LICENSE("GPL");
>

--00000000000075ac9a05ee1fcad3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBi
l4ksp8TC7LbVv/S5djzWaUn5PFW5aCW17cQ+I5JbJjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjMwOTE5NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAa8vx4zmsQ5g5fxB78NPq
sjlSmHKnYlR/7PMSkV6s8z4WvGV4UMAr6s0Wn+3JAuw2RZVSPLpkEClFSpekow4adDjLiFqfHS3D
6YD5szwnE6Uy2lziqFQaWjvcKhUCWYwZ2fhv9a6H2d2SX7jcmO6jcrV8MX8Kdu8xZkos/gPMAVOQ
Abjbt2e3SeQ0qcEhoHysGkJ+aC1juRXsYACciZljnO3IyQrcHJdPMMZuka4UeSUonoSSsCaoxyP5
n6RF3XpFL+psgOKKNjAWIrGeci+W1oxt8pskXhY1WpyljV+OjLyH9fc3wvnfAOvbc+wHlS2KrMjm
KgqzZSmT8xsMECmXZw==
--00000000000075ac9a05ee1fcad3--
