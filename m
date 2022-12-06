Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527226440EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 11:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiLFKGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 05:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiLFKGF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 05:06:05 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D524A30F44
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 01:56:41 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id 128so13637267vsz.12
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HyJbMMU+BEWB8hKKITnLlsp+lRvAuTcBpDDk883h0a0=;
        b=oprh8wCrAjUx4lgIcyhnQi3KVoH0jJFRX4AOJU3+Ssly+3vZUwV0wzomZpo3fUtrzY
         4Y6SUJ9Wb4TTCYq4HLjLJmqg047bivgXIP7lwLAuNBumO7/tALHoW8GtWly28xRpGwbT
         /tlScUxOzW6+LGgsy1QPCiUuWeM9uO33Vqbn4h4PyfF5/GiPUiB6byI0ZWrDYsRC0L5b
         4PAlRINQIFtKnXYF1MfaxgVvWtpAd9NVkZT/AqtKjCZs4EGxBLbt2lpfIq8cYEhnnpjJ
         RI6a2QRgxWtXfwPE+bg12fanfM4g0GZ0O9F08qR1WeyJgFCEgy5nQNTyb4Im2V4LHIiY
         sweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyJbMMU+BEWB8hKKITnLlsp+lRvAuTcBpDDk883h0a0=;
        b=xER/9H0VyUyivsCR+5gXD0xveU4tGt1x5TKrFzLfNJDb7NCu6ORbfnTTZ7REqPdNGa
         qQgI6OQetz6gbNy/rL9EiEzbfLudjnf6DFSAQUKRN/EdT/8woHF2Gh50+vqcyGbliQa2
         yvtH0WAXUX1UHroH8GnTXj88UJW8T0lAKxLALXnwkpzK9a8PhBPeH5Ws1QfcKG9wCiMu
         OvD9fJaFBMpdWetoBPkydPKk/6i+Sy7WfK0lSuJw31Y0YzflfXZxrJk68cUI9gcdgm98
         s+v3KBg/zooJ5PYYCzExTuHQ92HqyliRb5DNaA4jAWpVFIeyb/XaxzDL3suVfprGHL0/
         7yDg==
X-Gm-Message-State: ANoB5pkLXnoduDmG3UsJ8o30JyRviWdyzqYLbvnrDDWUYXye20wwS6AY
        nKh5vG4uFr74+NwoAUf+hK8wO6zGIKDoRTWxNeY+Hw==
X-Google-Smtp-Source: AA0mqf7OqMezE/OsO+OVSnWTuoLCf9DmNqudGkHr/jlCH14sGWXU/fZ1LmJMtjdZVk/orV/L4HBI05GrfI4ilK5vR4g=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr50175087vss.18.1670320592558; Tue, 06
 Dec 2022 01:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20221205215058.143688-1-rmoar@google.com> <20221205215058.143688-3-rmoar@google.com>
In-Reply-To: <20221205215058.143688-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 6 Dec 2022 17:56:21 +0800
Message-ID: <CABVgOS==x_JWAKz0ZH0YoW7WGgpKKikDboqN38M1w9scSFhPRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] apparmor: test: make static symbols visible during
 kunit testing
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        john.johansen@canonical.com, skhan@linuxfoundation.org,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a13c5905ef25d1d4"
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

--000000000000a13c5905ef25d1d4
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 5:51 AM Rae Moar <rmoar@google.com> wrote:
>
> Use macros, VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT, to allow
> static symbols to be conditionally set to be visible during KUnit
> testing. Remove the need to include testing file in the implementation
> file. Provide example of how static symbols can be dealt with in
> Testing. Also, allow policy_unpack_test to be built as a module.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks pretty good to me, so if John's okay with it, I'm happy for
us to take it via the kselftest/kunit tree.

Two minor suggestions:
- I'd ideally like the mention of namespacingt the symbols to go in
the commit message proper, if this gets another version. It's a pretty
significant part of the patch.
- Now that this is buildable as a module, it'd be nice to have a
namespaced module name. policy_unpack_test.ko doesn't reference
apparmor at all. Maybe apparmor_policy_unpack_test.ko.

(The naming guide here --
https://docs.kernel.org/dev-tools/kunit/style.html -- briefly touches
on this, but as apparmor predates it, and it the module name is only
briefly mentioned, it's pretty easy to overlook.)

With those changes (or frankly, just the second one), this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v1:
>  - Changed the namespace of exported symbols for the apparmor
>    policy_unpack_test by adding the aa_ prefix.
>
>  security/apparmor/Kconfig                 |   4 +-
>  security/apparmor/Makefile                |   2 +
>  security/apparmor/include/policy_unpack.h |  50 +++++
>  security/apparmor/policy_unpack.c         | 238 ++++++++++------------
>  security/apparmor/policy_unpack_test.c    |  69 ++++---
>  5 files changed, 195 insertions(+), 168 deletions(-)
>
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index cb3496e00d8a..f334e7cccf2d 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -106,8 +106,8 @@ config SECURITY_APPARMOR_PARANOID_LOAD
>           Disabling the check will speed up policy loads.
>
>  config SECURITY_APPARMOR_KUNIT_TEST
> -       bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
> -       depends on KUNIT=y && SECURITY_APPARMOR
> +       tristate "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
> +       depends on KUNIT && SECURITY_APPARMOR
>         default KUNIT_ALL_TESTS
>         help
>           This builds the AppArmor KUnit tests.
> diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
> index ff23fcfefe19..6a92428375eb 100644
> --- a/security/apparmor/Makefile
> +++ b/security/apparmor/Makefile
> @@ -8,6 +8,8 @@ apparmor-y := apparmorfs.o audit.o capability.o task.o ipc.o lib.o match.o \
>                resource.o secid.o file.o policy_ns.o label.o mount.o net.o
>  apparmor-$(CONFIG_SECURITY_APPARMOR_HASH) += crypto.o
>
> +obj-$(CONFIG_SECURITY_APPARMOR_KUNIT_TEST) += policy_unpack_test.o
> +
>  clean-files := capability_names.h rlim_names.h net_names.h
>
>  # Build a lower case string table of address family names
> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
> index eb5f7d7f132b..e89b701447bc 100644
> --- a/security/apparmor/include/policy_unpack.h
> +++ b/security/apparmor/include/policy_unpack.h
> @@ -48,6 +48,43 @@ enum {
>         AAFS_LOADDATA_NDENTS            /* count of entries */
>  };
>
> +/*
> + * The AppArmor interface treats data as a type byte followed by the
> + * actual data.  The interface has the notion of a named entry
> + * which has a name (AA_NAME typecode followed by name string) followed by
> + * the entries typecode and data.  Named types allow for optional
> + * elements and extensions to be added and tested for without breaking
> + * backwards compatibility.
> + */
> +
> +enum aa_code {
> +       AA_U8,
> +       AA_U16,
> +       AA_U32,
> +       AA_U64,
> +       AA_NAME,                /* same as string except it is items name */
> +       AA_STRING,
> +       AA_BLOB,
> +       AA_STRUCT,
> +       AA_STRUCTEND,
> +       AA_LIST,
> +       AA_LISTEND,
> +       AA_ARRAY,
> +       AA_ARRAYEND,
> +};
> +
> +/*
> + * aa_ext is the read of the buffer containing the serialized profile.  The
> + * data is copied into a kernel buffer in apparmorfs and then handed off to
> + * the unpack routines.
> + */
> +struct aa_ext {
> +       void *start;
> +       void *end;
> +       void *pos;              /* pointer to current position in the buffer */
> +       u32 version;
> +};
> +
>  /*
>   * struct aa_loaddata - buffer of policy raw_data set
>   *
> @@ -126,4 +163,17 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
>                 kref_put(&data->count, aa_loaddata_kref);
>  }
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +bool aa_inbounds(struct aa_ext *e, size_t size);
> +size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk);
> +bool aa_unpack_X(struct aa_ext *e, enum aa_code code);
> +bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
> +bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
> +bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
> +size_t aa_unpack_array(struct aa_ext *e, const char *name);
> +size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
> +int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
> +int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name);
> +#endif
> +
>  #endif /* __POLICY_INTERFACE_H */
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 55d31bac4f35..12e535fdfa8b 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -14,6 +14,7 @@
>   */
>
>  #include <asm/unaligned.h>
> +#include <kunit/visibility.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
>  #include <linux/zlib.h>
> @@ -37,43 +38,6 @@
>  #define v7     7
>  #define v8     8       /* full network masking */
>
> -/*
> - * The AppArmor interface treats data as a type byte followed by the
> - * actual data.  The interface has the notion of a named entry
> - * which has a name (AA_NAME typecode followed by name string) followed by
> - * the entries typecode and data.  Named types allow for optional
> - * elements and extensions to be added and tested for without breaking
> - * backwards compatibility.
> - */
> -
> -enum aa_code {
> -       AA_U8,
> -       AA_U16,
> -       AA_U32,
> -       AA_U64,
> -       AA_NAME,                /* same as string except it is items name */
> -       AA_STRING,
> -       AA_BLOB,
> -       AA_STRUCT,
> -       AA_STRUCTEND,
> -       AA_LIST,
> -       AA_LISTEND,
> -       AA_ARRAY,
> -       AA_ARRAYEND,
> -};
> -
> -/*
> - * aa_ext is the read of the buffer containing the serialized profile.  The
> - * data is copied into a kernel buffer in apparmorfs and then handed off to
> - * the unpack routines.
> - */
> -struct aa_ext {
> -       void *start;
> -       void *end;
> -       void *pos;              /* pointer to current position in the buffer */
> -       u32 version;
> -};
> -
>  /* audit callback for unpack fields */
>  static void audit_cb(struct audit_buffer *ab, void *va)
>  {
> @@ -199,10 +163,11 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
>  }
>
>  /* test if read will be in packed data bounds */
> -static bool inbounds(struct aa_ext *e, size_t size)
> +VISIBLE_IF_KUNIT bool aa_inbounds(struct aa_ext *e, size_t size)
>  {
>         return (size <= e->end - e->pos);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_inbounds);
>
>  static void *kvmemdup(const void *src, size_t len)
>  {
> @@ -214,22 +179,22 @@ static void *kvmemdup(const void *src, size_t len)
>  }
>
>  /**
> - * unpack_u16_chunk - test and do bounds checking for a u16 size based chunk
> + * aa_unpack_u16_chunk - test and do bounds checking for a u16 size based chunk
>   * @e: serialized data read head (NOT NULL)
>   * @chunk: start address for chunk of data (NOT NULL)
>   *
>   * Returns: the size of chunk found with the read head at the end of the chunk.
>   */
> -static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
> +VISIBLE_IF_KUNIT size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk)
>  {
>         size_t size = 0;
>         void *pos = e->pos;
>
> -       if (!inbounds(e, sizeof(u16)))
> +       if (!aa_inbounds(e, sizeof(u16)))
>                 goto fail;
>         size = le16_to_cpu(get_unaligned((__le16 *) e->pos));
>         e->pos += sizeof(__le16);
> -       if (!inbounds(e, size))
> +       if (!aa_inbounds(e, size))
>                 goto fail;
>         *chunk = e->pos;
>         e->pos += size;
> @@ -239,20 +204,22 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
>         e->pos = pos;
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_u16_chunk);
>
>  /* unpack control byte */
> -static bool unpack_X(struct aa_ext *e, enum aa_code code)
> +VISIBLE_IF_KUNIT bool aa_unpack_X(struct aa_ext *e, enum aa_code code)
>  {
> -       if (!inbounds(e, 1))
> +       if (!aa_inbounds(e, 1))
>                 return false;
>         if (*(u8 *) e->pos != code)
>                 return false;
>         e->pos++;
>         return true;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_X);
>
>  /**
> - * unpack_nameX - check is the next element is of type X with a name of @name
> + * aa_unpack_nameX - check is the next element is of type X with a name of @name
>   * @e: serialized data extent information  (NOT NULL)
>   * @code: type code
>   * @name: name to match to the serialized element.  (MAYBE NULL)
> @@ -267,7 +234,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
>   *
>   * Returns: false if either match fails, the read head does not move
>   */
> -static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
> +VISIBLE_IF_KUNIT bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>  {
>         /*
>          * May need to reset pos if name or type doesn't match
> @@ -277,9 +244,9 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>          * Check for presence of a tagname, and if present name size
>          * AA_NAME tag value is a u16.
>          */
> -       if (unpack_X(e, AA_NAME)) {
> +       if (aa_unpack_X(e, AA_NAME)) {
>                 char *tag = NULL;
> -               size_t size = unpack_u16_chunk(e, &tag);
> +               size_t size = aa_unpack_u16_chunk(e, &tag);
>                 /* if a name is specified it must match. otherwise skip tag */
>                 if (name && (!size || tag[size-1] != '\0' || strcmp(name, tag)))
>                         goto fail;
> @@ -289,20 +256,21 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>         }
>
>         /* now check if type code matches */
> -       if (unpack_X(e, code))
> +       if (aa_unpack_X(e, code))
>                 return true;
>
>  fail:
>         e->pos = pos;
>         return false;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_nameX);
>
>  static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_U8, name)) {
> -               if (!inbounds(e, sizeof(u8)))
> +       if (aa_unpack_nameX(e, AA_U8, name)) {
> +               if (!aa_inbounds(e, sizeof(u8)))
>                         goto fail;
>                 if (data)
>                         *data = *((u8 *)e->pos);
> @@ -315,12 +283,12 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
>         return false;
>  }
>
> -static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
> +VISIBLE_IF_KUNIT bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_U32, name)) {
> -               if (!inbounds(e, sizeof(u32)))
> +       if (aa_unpack_nameX(e, AA_U32, name)) {
> +               if (!aa_inbounds(e, sizeof(u32)))
>                         goto fail;
>                 if (data)
>                         *data = le32_to_cpu(get_unaligned((__le32 *) e->pos));
> @@ -332,13 +300,14 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>         e->pos = pos;
>         return false;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_u32);
>
> -static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
> +VISIBLE_IF_KUNIT bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_U64, name)) {
> -               if (!inbounds(e, sizeof(u64)))
> +       if (aa_unpack_nameX(e, AA_U64, name)) {
> +               if (!aa_inbounds(e, sizeof(u64)))
>                         goto fail;
>                 if (data)
>                         *data = le64_to_cpu(get_unaligned((__le64 *) e->pos));
> @@ -350,14 +319,15 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>         e->pos = pos;
>         return false;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_u64);
>
> -static size_t unpack_array(struct aa_ext *e, const char *name)
> +VISIBLE_IF_KUNIT size_t aa_unpack_array(struct aa_ext *e, const char *name)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_ARRAY, name)) {
> +       if (aa_unpack_nameX(e, AA_ARRAY, name)) {
>                 int size;
> -               if (!inbounds(e, sizeof(u16)))
> +               if (!aa_inbounds(e, sizeof(u16)))
>                         goto fail;
>                 size = (int)le16_to_cpu(get_unaligned((__le16 *) e->pos));
>                 e->pos += sizeof(u16);
> @@ -368,18 +338,19 @@ static size_t unpack_array(struct aa_ext *e, const char *name)
>         e->pos = pos;
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_array);
>
> -static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
> +VISIBLE_IF_KUNIT size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_BLOB, name)) {
> +       if (aa_unpack_nameX(e, AA_BLOB, name)) {
>                 u32 size;
> -               if (!inbounds(e, sizeof(u32)))
> +               if (!aa_inbounds(e, sizeof(u32)))
>                         goto fail;
>                 size = le32_to_cpu(get_unaligned((__le32 *) e->pos));
>                 e->pos += sizeof(u32);
> -               if (inbounds(e, (size_t) size)) {
> +               if (aa_inbounds(e, (size_t) size)) {
>                         *blob = e->pos;
>                         e->pos += size;
>                         return size;
> @@ -390,15 +361,16 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>         e->pos = pos;
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_blob);
>
> -static int unpack_str(struct aa_ext *e, const char **string, const char *name)
> +VISIBLE_IF_KUNIT int aa_unpack_str(struct aa_ext *e, const char **string, const char *name)
>  {
>         char *src_str;
>         size_t size = 0;
>         void *pos = e->pos;
>         *string = NULL;
> -       if (unpack_nameX(e, AA_STRING, name)) {
> -               size = unpack_u16_chunk(e, &src_str);
> +       if (aa_unpack_nameX(e, AA_STRING, name)) {
> +               size = aa_unpack_u16_chunk(e, &src_str);
>                 if (size) {
>                         /* strings are null terminated, length is size - 1 */
>                         if (src_str[size - 1] != 0)
> @@ -413,12 +385,13 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
>         e->pos = pos;
>         return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_str);
>
> -static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
> +VISIBLE_IF_KUNIT int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name)
>  {
>         const char *tmp;
>         void *pos = e->pos;
> -       int res = unpack_str(e, &tmp, name);
> +       int res = aa_unpack_str(e, &tmp, name);
>         *string = NULL;
>
>         if (!res)
> @@ -432,6 +405,7 @@ static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
>
>         return res;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(aa_unpack_strdup);
>
>
>  /**
> @@ -446,7 +420,7 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>         size_t size;
>         struct aa_dfa *dfa = NULL;
>
> -       size = unpack_blob(e, &blob, "aadfa");
> +       size = aa_unpack_blob(e, &blob, "aadfa");
>         if (size) {
>                 /*
>                  * The dfa is aligned with in the blob to 8 bytes
> @@ -482,10 +456,10 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>         void *saved_pos = e->pos;
>
>         /* exec table is optional */
> -       if (unpack_nameX(e, AA_STRUCT, "xtable")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "xtable")) {
>                 int i, size;
>
> -               size = unpack_array(e, NULL);
> +               size = aa_unpack_array(e, NULL);
>                 /* currently 4 exec bits and entries 0-3 are reserved iupcx */
>                 if (size > 16 - 4)
>                         goto fail;
> @@ -497,8 +471,8 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>                 profile->file.trans.size = size;
>                 for (i = 0; i < size; i++) {
>                         char *str;
> -                       int c, j, pos, size2 = unpack_strdup(e, &str, NULL);
> -                       /* unpack_strdup verifies that the last character is
> +                       int c, j, pos, size2 = aa_unpack_strdup(e, &str, NULL);
> +                       /* aa_unpack_strdup verifies that the last character is
>                          * null termination byte.
>                          */
>                         if (!size2)
> @@ -521,7 +495,7 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>                                         goto fail;
>                                 /* beginning with : requires an embedded \0,
>                                  * verify that exactly 1 internal \0 exists
> -                                * trailing \0 already verified by unpack_strdup
> +                                * trailing \0 already verified by aa_unpack_strdup
>                                  *
>                                  * convert \0 back to : for label_parse
>                                  */
> @@ -533,9 +507,9 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profile)
>                                 /* fail - all other cases with embedded \0 */
>                                 goto fail;
>                 }
> -               if (!unpack_nameX(e, AA_ARRAYEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>         return true;
> @@ -550,21 +524,21 @@ static bool unpack_xattrs(struct aa_ext *e, struct aa_profile *profile)
>  {
>         void *pos = e->pos;
>
> -       if (unpack_nameX(e, AA_STRUCT, "xattrs")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "xattrs")) {
>                 int i, size;
>
> -               size = unpack_array(e, NULL);
> +               size = aa_unpack_array(e, NULL);
>                 profile->xattr_count = size;
>                 profile->xattrs = kcalloc(size, sizeof(char *), GFP_KERNEL);
>                 if (!profile->xattrs)
>                         goto fail;
>                 for (i = 0; i < size; i++) {
> -                       if (!unpack_strdup(e, &profile->xattrs[i], NULL))
> +                       if (!aa_unpack_strdup(e, &profile->xattrs[i], NULL))
>                                 goto fail;
>                 }
> -               if (!unpack_nameX(e, AA_ARRAYEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>
> @@ -580,8 +554,8 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
>         void *pos = e->pos;
>         int i, size;
>
> -       if (unpack_nameX(e, AA_STRUCT, "secmark")) {
> -               size = unpack_array(e, NULL);
> +       if (aa_unpack_nameX(e, AA_STRUCT, "secmark")) {
> +               size = aa_unpack_array(e, NULL);
>
>                 profile->secmark = kcalloc(size, sizeof(struct aa_secmark),
>                                            GFP_KERNEL);
> @@ -595,12 +569,12 @@ static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
>                                 goto fail;
>                         if (!unpack_u8(e, &profile->secmark[i].deny, NULL))
>                                 goto fail;
> -                       if (!unpack_strdup(e, &profile->secmark[i].label, NULL))
> +                       if (!aa_unpack_strdup(e, &profile->secmark[i].label, NULL))
>                                 goto fail;
>                 }
> -               if (!unpack_nameX(e, AA_ARRAYEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>
> @@ -624,26 +598,26 @@ static bool unpack_rlimits(struct aa_ext *e, struct aa_profile *profile)
>         void *pos = e->pos;
>
>         /* rlimits are optional */
> -       if (unpack_nameX(e, AA_STRUCT, "rlimits")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "rlimits")) {
>                 int i, size;
>                 u32 tmp = 0;
> -               if (!unpack_u32(e, &tmp, NULL))
> +               if (!aa_unpack_u32(e, &tmp, NULL))
>                         goto fail;
>                 profile->rlimits.mask = tmp;
>
> -               size = unpack_array(e, NULL);
> +               size = aa_unpack_array(e, NULL);
>                 if (size > RLIM_NLIMITS)
>                         goto fail;
>                 for (i = 0; i < size; i++) {
>                         u64 tmp2 = 0;
>                         int a = aa_map_resource(i);
> -                       if (!unpack_u64(e, &tmp2, NULL))
> +                       if (!aa_unpack_u64(e, &tmp2, NULL))
>                                 goto fail;
>                         profile->rlimits.limits[a].rlim_max = tmp2;
>                 }
> -               if (!unpack_nameX(e, AA_ARRAYEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>         return true;
> @@ -691,9 +665,9 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>         *ns_name = NULL;
>
>         /* check that we have the right struct being passed */
> -       if (!unpack_nameX(e, AA_STRUCT, "profile"))
> +       if (!aa_unpack_nameX(e, AA_STRUCT, "profile"))
>                 goto fail;
> -       if (!unpack_str(e, &name, NULL))
> +       if (!aa_unpack_str(e, &name, NULL))
>                 goto fail;
>         if (*name == '\0')
>                 goto fail;
> @@ -713,10 +687,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 return ERR_PTR(-ENOMEM);
>
>         /* profile renaming is optional */
> -       (void) unpack_str(e, &profile->rename, "rename");
> +       (void) aa_unpack_str(e, &profile->rename, "rename");
>
>         /* attachment string is optional */
> -       (void) unpack_str(e, &profile->attach, "attach");
> +       (void) aa_unpack_str(e, &profile->attach, "attach");
>
>         /* xmatch is optional and may be NULL */
>         profile->xmatch = unpack_dfa(e);
> @@ -728,7 +702,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>         }
>         /* xmatch_len is not optional if xmatch is set */
>         if (profile->xmatch) {
> -               if (!unpack_u32(e, &tmp, NULL)) {
> +               if (!aa_unpack_u32(e, &tmp, NULL)) {
>                         info = "missing xmatch len";
>                         goto fail;
>                 }
> @@ -736,15 +710,15 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>         }
>
>         /* disconnected attachment string is optional */
> -       (void) unpack_str(e, &profile->disconnected, "disconnected");
> +       (void) aa_unpack_str(e, &profile->disconnected, "disconnected");
>
>         /* per profile debug flags (complain, audit) */
> -       if (!unpack_nameX(e, AA_STRUCT, "flags")) {
> +       if (!aa_unpack_nameX(e, AA_STRUCT, "flags")) {
>                 info = "profile missing flags";
>                 goto fail;
>         }
>         info = "failed to unpack profile flags";
> -       if (!unpack_u32(e, &tmp, NULL))
> +       if (!aa_unpack_u32(e, &tmp, NULL))
>                 goto fail;
>         if (tmp & PACKED_FLAG_HAT)
>                 profile->label.flags |= FLAG_HAT;
> @@ -752,7 +726,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 profile->label.flags |= FLAG_DEBUG1;
>         if (tmp & PACKED_FLAG_DEBUG2)
>                 profile->label.flags |= FLAG_DEBUG2;
> -       if (!unpack_u32(e, &tmp, NULL))
> +       if (!aa_unpack_u32(e, &tmp, NULL))
>                 goto fail;
>         if (tmp == PACKED_MODE_COMPLAIN || (e->version & FORCE_COMPLAIN_FLAG)) {
>                 profile->mode = APPARMOR_COMPLAIN;
> @@ -766,16 +740,16 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>         } else {
>                 goto fail;
>         }
> -       if (!unpack_u32(e, &tmp, NULL))
> +       if (!aa_unpack_u32(e, &tmp, NULL))
>                 goto fail;
>         if (tmp)
>                 profile->audit = AUDIT_ALL;
>
> -       if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +       if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                 goto fail;
>
>         /* path_flags is optional */
> -       if (unpack_u32(e, &profile->path_flags, "path_flags"))
> +       if (aa_unpack_u32(e, &profile->path_flags, "path_flags"))
>                 profile->path_flags |= profile->label.flags &
>                         PATH_MEDIATE_DELETED;
>         else
> @@ -783,38 +757,38 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 profile->path_flags = PATH_MEDIATE_DELETED;
>
>         info = "failed to unpack profile capabilities";
> -       if (!unpack_u32(e, &(profile->caps.allow.cap[0]), NULL))
> +       if (!aa_unpack_u32(e, &(profile->caps.allow.cap[0]), NULL))
>                 goto fail;
> -       if (!unpack_u32(e, &(profile->caps.audit.cap[0]), NULL))
> +       if (!aa_unpack_u32(e, &(profile->caps.audit.cap[0]), NULL))
>                 goto fail;
> -       if (!unpack_u32(e, &(profile->caps.quiet.cap[0]), NULL))
> +       if (!aa_unpack_u32(e, &(profile->caps.quiet.cap[0]), NULL))
>                 goto fail;
> -       if (!unpack_u32(e, &tmpcap.cap[0], NULL))
> +       if (!aa_unpack_u32(e, &tmpcap.cap[0], NULL))
>                 goto fail;
>
>         info = "failed to unpack upper profile capabilities";
> -       if (unpack_nameX(e, AA_STRUCT, "caps64")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "caps64")) {
>                 /* optional upper half of 64 bit caps */
> -               if (!unpack_u32(e, &(profile->caps.allow.cap[1]), NULL))
> +               if (!aa_unpack_u32(e, &(profile->caps.allow.cap[1]), NULL))
>                         goto fail;
> -               if (!unpack_u32(e, &(profile->caps.audit.cap[1]), NULL))
> +               if (!aa_unpack_u32(e, &(profile->caps.audit.cap[1]), NULL))
>                         goto fail;
> -               if (!unpack_u32(e, &(profile->caps.quiet.cap[1]), NULL))
> +               if (!aa_unpack_u32(e, &(profile->caps.quiet.cap[1]), NULL))
>                         goto fail;
> -               if (!unpack_u32(e, &(tmpcap.cap[1]), NULL))
> +               if (!aa_unpack_u32(e, &(tmpcap.cap[1]), NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>
>         info = "failed to unpack extended profile capabilities";
> -       if (unpack_nameX(e, AA_STRUCT, "capsx")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "capsx")) {
>                 /* optional extended caps mediation mask */
> -               if (!unpack_u32(e, &(profile->caps.extended.cap[0]), NULL))
> +               if (!aa_unpack_u32(e, &(profile->caps.extended.cap[0]), NULL))
>                         goto fail;
> -               if (!unpack_u32(e, &(profile->caps.extended.cap[1]), NULL))
> +               if (!aa_unpack_u32(e, &(profile->caps.extended.cap[1]), NULL))
>                         goto fail;
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         }
>
> @@ -833,7 +807,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 goto fail;
>         }
>
> -       if (unpack_nameX(e, AA_STRUCT, "policydb")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "policydb")) {
>                 /* generic policy dfa - optional and may be NULL */
>                 info = "failed to unpack policydb";
>                 profile->policy.dfa = unpack_dfa(e);
> @@ -845,7 +819,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                         error = -EPROTO;
>                         goto fail;
>                 }
> -               if (!unpack_u32(e, &profile->policy.start[0], "start"))
> +               if (!aa_unpack_u32(e, &profile->policy.start[0], "start"))
>                         /* default start state */
>                         profile->policy.start[0] = DFA_START;
>                 /* setup class index */
> @@ -855,7 +829,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                                             profile->policy.start[0],
>                                             i);
>                 }
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL))
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
>                         goto fail;
>         } else
>                 profile->policy.dfa = aa_get_dfa(nulldfa);
> @@ -868,7 +842,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 info = "failed to unpack profile file rules";
>                 goto fail;
>         } else if (profile->file.dfa) {
> -               if (!unpack_u32(e, &profile->file.start, "dfa_start"))
> +               if (!aa_unpack_u32(e, &profile->file.start, "dfa_start"))
>                         /* default start state */
>                         profile->file.start = DFA_START;
>         } else if (profile->policy.dfa &&
> @@ -883,7 +857,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                 goto fail;
>         }
>
> -       if (unpack_nameX(e, AA_STRUCT, "data")) {
> +       if (aa_unpack_nameX(e, AA_STRUCT, "data")) {
>                 info = "out of memory";
>                 profile->data = kzalloc(sizeof(*profile->data), GFP_KERNEL);
>                 if (!profile->data)
> @@ -901,7 +875,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                         goto fail;
>                 }
>
> -               while (unpack_strdup(e, &key, NULL)) {
> +               while (aa_unpack_strdup(e, &key, NULL)) {
>                         data = kzalloc(sizeof(*data), GFP_KERNEL);
>                         if (!data) {
>                                 kfree_sensitive(key);
> @@ -909,7 +883,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                         }
>
>                         data->key = key;
> -                       data->size = unpack_blob(e, &data->data, NULL);
> +                       data->size = aa_unpack_blob(e, &data->data, NULL);
>                         data->data = kvmemdup(data->data, data->size);
>                         if (data->size && !data->data) {
>                                 kfree_sensitive(data->key);
> @@ -921,13 +895,13 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
>                                                profile->data->p);
>                 }
>
> -               if (!unpack_nameX(e, AA_STRUCTEND, NULL)) {
> +               if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL)) {
>                         info = "failed to unpack end of key, value data table";
>                         goto fail;
>                 }
>         }
>
> -       if (!unpack_nameX(e, AA_STRUCTEND, NULL)) {
> +       if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL)) {
>                 info = "failed to unpack end of profile";
>                 goto fail;
>         }
> @@ -960,7 +934,7 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
>         *ns = NULL;
>
>         /* get the interface version */
> -       if (!unpack_u32(e, &e->version, "version")) {
> +       if (!aa_unpack_u32(e, &e->version, "version")) {
>                 if (required) {
>                         audit_iface(NULL, NULL, NULL, "invalid profile format",
>                                     e, error);
> @@ -979,7 +953,7 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
>         }
>
>         /* read the namespace if present */
> -       if (unpack_str(e, &name, "namespace")) {
> +       if (aa_unpack_str(e, &name, "namespace")) {
>                 if (*name == '\0') {
>                         audit_iface(NULL, NULL, NULL, "invalid namespace name",
>                                     e, error);
> @@ -1251,7 +1225,3 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>
>         return error;
>  }
> -
> -#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> -#include "policy_unpack_test.c"
> -#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 0a969b2e03db..f25cf2a023d5 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <kunit/test.h>
> +#include <kunit/visibility.h>
>
>  #include "include/policy.h"
>  #include "include/policy_unpack.h"
> @@ -43,6 +44,8 @@
>  #define TEST_ARRAY_BUF_OFFSET \
>         (TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
>
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +
>  struct policy_unpack_fixture {
>         struct aa_ext *e;
>         size_t e_size;
> @@ -125,16 +128,16 @@ static void policy_unpack_test_inbounds_when_inbounds(struct kunit *test)
>  {
>         struct policy_unpack_fixture *puf = test->priv;
>
> -       KUNIT_EXPECT_TRUE(test, inbounds(puf->e, 0));
> -       KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size / 2));
> -       KUNIT_EXPECT_TRUE(test, inbounds(puf->e, puf->e_size));
> +       KUNIT_EXPECT_TRUE(test, aa_inbounds(puf->e, 0));
> +       KUNIT_EXPECT_TRUE(test, aa_inbounds(puf->e, puf->e_size / 2));
> +       KUNIT_EXPECT_TRUE(test, aa_inbounds(puf->e, puf->e_size));
>  }
>
>  static void policy_unpack_test_inbounds_when_out_of_bounds(struct kunit *test)
>  {
>         struct policy_unpack_fixture *puf = test->priv;
>
> -       KUNIT_EXPECT_FALSE(test, inbounds(puf->e, puf->e_size + 1));
> +       KUNIT_EXPECT_FALSE(test, aa_inbounds(puf->e, puf->e_size + 1));
>  }
>
>  static void policy_unpack_test_unpack_array_with_null_name(struct kunit *test)
> @@ -144,7 +147,7 @@ static void policy_unpack_test_unpack_array_with_null_name(struct kunit *test)
>
>         puf->e->pos += TEST_ARRAY_BUF_OFFSET;
>
> -       array_size = unpack_array(puf->e, NULL);
> +       array_size = aa_unpack_array(puf->e, NULL);
>
>         KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -159,7 +162,7 @@ static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
>
>         puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
>
> -       array_size = unpack_array(puf->e, name);
> +       array_size = aa_unpack_array(puf->e, name);
>
>         KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -175,7 +178,7 @@ static void policy_unpack_test_unpack_array_out_of_bounds(struct kunit *test)
>         puf->e->pos += TEST_NAMED_ARRAY_BUF_OFFSET;
>         puf->e->end = puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
>
> -       array_size = unpack_array(puf->e, name);
> +       array_size = aa_unpack_array(puf->e, name);
>
>         KUNIT_EXPECT_EQ(test, array_size, 0);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -189,7 +192,7 @@ static void policy_unpack_test_unpack_blob_with_null_name(struct kunit *test)
>         size_t size;
>
>         puf->e->pos += TEST_BLOB_BUF_OFFSET;
> -       size = unpack_blob(puf->e, &blob, NULL);
> +       size = aa_unpack_blob(puf->e, &blob, NULL);
>
>         KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
>         KUNIT_EXPECT_TRUE(test,
> @@ -203,7 +206,7 @@ static void policy_unpack_test_unpack_blob_with_name(struct kunit *test)
>         size_t size;
>
>         puf->e->pos += TEST_NAMED_BLOB_BUF_OFFSET;
> -       size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
> +       size = aa_unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
>
>         KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);
>         KUNIT_EXPECT_TRUE(test,
> @@ -222,7 +225,7 @@ static void policy_unpack_test_unpack_blob_out_of_bounds(struct kunit *test)
>         puf->e->end = puf->e->start + TEST_BLOB_BUF_OFFSET
>                 + TEST_BLOB_DATA_SIZE - 1;
>
> -       size = unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
> +       size = aa_unpack_blob(puf->e, &blob, TEST_BLOB_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> @@ -235,7 +238,7 @@ static void policy_unpack_test_unpack_str_with_null_name(struct kunit *test)
>         size_t size;
>
>         puf->e->pos += TEST_STRING_BUF_OFFSET;
> -       size = unpack_str(puf->e, &string, NULL);
> +       size = aa_unpack_str(puf->e, &string, NULL);
>
>         KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
>         KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> @@ -247,7 +250,7 @@ static void policy_unpack_test_unpack_str_with_name(struct kunit *test)
>         const char *string = NULL;
>         size_t size;
>
> -       size = unpack_str(puf->e, &string, TEST_STRING_NAME);
> +       size = aa_unpack_str(puf->e, &string, TEST_STRING_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
>         KUNIT_EXPECT_STREQ(test, string, TEST_STRING_DATA);
> @@ -263,7 +266,7 @@ static void policy_unpack_test_unpack_str_out_of_bounds(struct kunit *test)
>         puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
>                 + strlen(TEST_STRING_DATA) - 1;
>
> -       size = unpack_str(puf->e, &string, TEST_STRING_NAME);
> +       size = aa_unpack_str(puf->e, &string, TEST_STRING_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
> @@ -276,7 +279,7 @@ static void policy_unpack_test_unpack_strdup_with_null_name(struct kunit *test)
>         size_t size;
>
>         puf->e->pos += TEST_STRING_BUF_OFFSET;
> -       size = unpack_strdup(puf->e, &string, NULL);
> +       size = aa_unpack_strdup(puf->e, &string, NULL);
>
>         KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
>         KUNIT_EXPECT_FALSE(test,
> @@ -291,7 +294,7 @@ static void policy_unpack_test_unpack_strdup_with_name(struct kunit *test)
>         char *string = NULL;
>         size_t size;
>
> -       size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
> +       size = aa_unpack_strdup(puf->e, &string, TEST_STRING_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, strlen(TEST_STRING_DATA) + 1);
>         KUNIT_EXPECT_FALSE(test,
> @@ -310,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
>         puf->e->end = puf->e->pos + TEST_STRING_BUF_OFFSET
>                 + strlen(TEST_STRING_DATA) - 1;
>
> -       size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
> +       size = aa_unpack_strdup(puf->e, &string, TEST_STRING_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_NULL(test, string);
> @@ -324,7 +327,7 @@ static void policy_unpack_test_unpack_nameX_with_null_name(struct kunit *test)
>
>         puf->e->pos += TEST_U32_BUF_OFFSET;
>
> -       success = unpack_nameX(puf->e, AA_U32, NULL);
> +       success = aa_unpack_nameX(puf->e, AA_U32, NULL);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -338,7 +341,7 @@ static void policy_unpack_test_unpack_nameX_with_wrong_code(struct kunit *test)
>
>         puf->e->pos += TEST_U32_BUF_OFFSET;
>
> -       success = unpack_nameX(puf->e, AA_BLOB, NULL);
> +       success = aa_unpack_nameX(puf->e, AA_BLOB, NULL);
>
>         KUNIT_EXPECT_FALSE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -353,7 +356,7 @@ static void policy_unpack_test_unpack_nameX_with_name(struct kunit *test)
>
>         puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
>
> -       success = unpack_nameX(puf->e, AA_U32, name);
> +       success = aa_unpack_nameX(puf->e, AA_U32, name);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -368,7 +371,7 @@ static void policy_unpack_test_unpack_nameX_with_wrong_name(struct kunit *test)
>
>         puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
>
> -       success = unpack_nameX(puf->e, AA_U32, name);
> +       success = aa_unpack_nameX(puf->e, AA_U32, name);
>
>         KUNIT_EXPECT_FALSE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -389,7 +392,7 @@ static void policy_unpack_test_unpack_u16_chunk_basic(struct kunit *test)
>          */
>         puf->e->end += TEST_U16_DATA;
>
> -       size = unpack_u16_chunk(puf->e, &chunk);
> +       size = aa_unpack_u16_chunk(puf->e, &chunk);
>
>         KUNIT_EXPECT_PTR_EQ(test, chunk,
>                             puf->e->start + TEST_U16_OFFSET + 2);
> @@ -406,7 +409,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
>
>         puf->e->pos = puf->e->end - 1;
>
> -       size = unpack_u16_chunk(puf->e, &chunk);
> +       size = aa_unpack_u16_chunk(puf->e, &chunk);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_NULL(test, chunk);
> @@ -428,7 +431,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
>          */
>         puf->e->end = puf->e->pos + TEST_U16_DATA - 1;
>
> -       size = unpack_u16_chunk(puf->e, &chunk);
> +       size = aa_unpack_u16_chunk(puf->e, &chunk);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_NULL(test, chunk);
> @@ -443,7 +446,7 @@ static void policy_unpack_test_unpack_u32_with_null_name(struct kunit *test)
>
>         puf->e->pos += TEST_U32_BUF_OFFSET;
>
> -       success = unpack_u32(puf->e, &data, NULL);
> +       success = aa_unpack_u32(puf->e, &data, NULL);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
> @@ -460,7 +463,7 @@ static void policy_unpack_test_unpack_u32_with_name(struct kunit *test)
>
>         puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
>
> -       success = unpack_u32(puf->e, &data, name);
> +       success = aa_unpack_u32(puf->e, &data, name);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_EQ(test, data, TEST_U32_DATA);
> @@ -478,7 +481,7 @@ static void policy_unpack_test_unpack_u32_out_of_bounds(struct kunit *test)
>         puf->e->pos += TEST_NAMED_U32_BUF_OFFSET;
>         puf->e->end = puf->e->start + TEST_U32_BUF_OFFSET + sizeof(u32);
>
> -       success = unpack_u32(puf->e, &data, name);
> +       success = aa_unpack_u32(puf->e, &data, name);
>
>         KUNIT_EXPECT_FALSE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -493,7 +496,7 @@ static void policy_unpack_test_unpack_u64_with_null_name(struct kunit *test)
>
>         puf->e->pos += TEST_U64_BUF_OFFSET;
>
> -       success = unpack_u64(puf->e, &data, NULL);
> +       success = aa_unpack_u64(puf->e, &data, NULL);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
> @@ -510,7 +513,7 @@ static void policy_unpack_test_unpack_u64_with_name(struct kunit *test)
>
>         puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
>
> -       success = unpack_u64(puf->e, &data, name);
> +       success = aa_unpack_u64(puf->e, &data, name);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_EQ(test, data, TEST_U64_DATA);
> @@ -528,7 +531,7 @@ static void policy_unpack_test_unpack_u64_out_of_bounds(struct kunit *test)
>         puf->e->pos += TEST_NAMED_U64_BUF_OFFSET;
>         puf->e->end = puf->e->start + TEST_U64_BUF_OFFSET + sizeof(u64);
>
> -       success = unpack_u64(puf->e, &data, name);
> +       success = aa_unpack_u64(puf->e, &data, name);
>
>         KUNIT_EXPECT_FALSE(test, success);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> @@ -538,7 +541,7 @@ static void policy_unpack_test_unpack_u64_out_of_bounds(struct kunit *test)
>  static void policy_unpack_test_unpack_X_code_match(struct kunit *test)
>  {
>         struct policy_unpack_fixture *puf = test->priv;
> -       bool success = unpack_X(puf->e, AA_NAME);
> +       bool success = aa_unpack_X(puf->e, AA_NAME);
>
>         KUNIT_EXPECT_TRUE(test, success);
>         KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start + 1);
> @@ -547,7 +550,7 @@ static void policy_unpack_test_unpack_X_code_match(struct kunit *test)
>  static void policy_unpack_test_unpack_X_code_mismatch(struct kunit *test)
>  {
>         struct policy_unpack_fixture *puf = test->priv;
> -       bool success = unpack_X(puf->e, AA_STRING);
> +       bool success = aa_unpack_X(puf->e, AA_STRING);
>
>         KUNIT_EXPECT_FALSE(test, success);
>         KUNIT_EXPECT_TRUE(test, puf->e->pos == puf->e->start);
> @@ -559,7 +562,7 @@ static void policy_unpack_test_unpack_X_out_of_bounds(struct kunit *test)
>         bool success;
>
>         puf->e->pos = puf->e->end;
> -       success = unpack_X(puf->e, AA_NAME);
> +       success = aa_unpack_X(puf->e, AA_NAME);
>
>         KUNIT_EXPECT_FALSE(test, success);
>  }
> @@ -605,3 +608,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
>  };
>
>  kunit_test_suite(apparmor_policy_unpack_test_module);
> +
> +MODULE_LICENSE("GPL");
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>

--000000000000a13c5905ef25d1d4
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGPil6q1qRMI4xctnaY
SpEwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjEwMjMw
ODQ3MTFaFw0yMzA0MjEwODQ3MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDOy5O2GPVtBg1bBqW4oCdA74F9u0dQ
yp4AdicypXD/HnquyuG5F25nYDqJtIueywO1V0kAbUCUNJS002MWjXx329Y1bv0p5GeXQ1isO49U
E86YZb+H0Gjz/kU2EUNllD7499UnJUx/36cMNRZ1BytreL0lLR0XNMJnPNzB6nCnWUf2X3sEZKOD
w+7PhYB7CjsyK8n3MrKkMG3uVxoatKMvdsX3DbllFE/ixNbGLfWTTCaPZYOblLYq7hNuvbb3yGSx
UWkinNXOLCsVGVLeGsQyMCfs8m4u3MBGfRHWc2svYunGHGheG8ErIVL2jl2Ly1nIJpPzZPui17Kd
4TY9v0THAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCNkhjo/
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCT
plR/KMcivNOgE73/9ZS7h4KNMKmS0eNHPRh7vQLUyjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDYwOTU2MzNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoPPQ11Ix3BANO/OW0Da4
bfN4545mwe4/C9LetWX7zodqeJCOa68BHfXmyhMV1n7Pk3FATlzZaaHUV/3KtfTpaU9BbHJRUBbM
13bDx/IeTz9d0FlWE+PGPFbOl515sxlYxCVMbV8Nsf0SsgZKP89wNGStBM8+b3Y0/Oie3wFEQ8wA
hdZHSdhwuGlEIIqdoo6/xn0OjTVH3o16MBcSuFvuXAyqzBVXvoWmJrbaKBp1BCJlic56P9Hg46Yb
Q9qCJcRQyR0i2Qul6ySJs/3hWS3AxLq/Kgrx6MDJpb0zvDZayqlIDFC3BMwljySVYNqbAz5E97UJ
UPX5COo4LEOX4AObfw==
--000000000000a13c5905ef25d1d4--
