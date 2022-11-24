Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E73637191
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 05:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXEtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 23:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKXEtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 23:49:46 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5B6DFD3;
        Wed, 23 Nov 2022 20:49:43 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.159.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C67CF3F1D8;
        Thu, 24 Nov 2022 04:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669265375;
        bh=ALmN89AFAGENuUaIVsJUuFwpftGPMuxhogH15T4hTrw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IfzCUU3HJ1ouuNjUosR8jPOOyZ8Im8PunJ0elkUlOTZRzjy/VvSy2fgFbEl9qwlPp
         4brBAQhcebi7wP9kUvJrvkU3byhTcOBhQnA5E7VTd6T3EyeNk3k5GJ6976KbnDKT1c
         YzRXaf6L6cbfzk+hs5MqJ6765mAstC9g8wxWmvIoWasGq4fT28R5w3CTF+rhlEVH4w
         E9QfproyNMuSGT0AS7vXeU/H9ZpS8ioPDt0K+DpfpdLHYw3LI7PNCi30XDZdbjhtCy
         +tsFvwh1UBH+14gM7Cbq7KcmkR0SvJwtJvopFE1Ju6r0OHXecOztoETmYeX2mILBGn
         KQEsVzJ0NkF+Q==
Message-ID: <d5dec6d1-471c-ca23-bd08-75b499556158@canonical.com>
Date:   Wed, 23 Nov 2022 20:49:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/2] apparmor: test: make static symbols visible during
 kunit testing
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
References: <20221102175959.2921063-1-rmoar@google.com>
 <20221102175959.2921063-3-rmoar@google.com>
 <3fbf707a-fc9e-18c6-dc40-ec266bd524e5@canonical.com>
 <CABVgOSkTojOjNv05aiD9tV7Vw12QOTtw9H9qCPFjjm_COdKb8w@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CABVgOSkTojOjNv05aiD9tV7Vw12QOTtw9H9qCPFjjm_COdKb8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/23/22 01:19, David Gow wrote:
> On Tue, Nov 22, 2022 at 2:20 PM John Johansen
> <john.johansen@canonical.com> wrote:
>>
>> On 11/2/22 10:59, Rae Moar wrote:
>>> Use macros, VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT, to allow
>>> static symbols to be conditionally set to be visible during KUnit
>>> testing. Remove the need to include testing file in the implementation
>>> file. Provide example of how static symbols can be dealt with in
>>> testing.
>>>
>>> Signed-off-by: Rae Moar <rmoar@google.com>
>>> ---
>>>    security/apparmor/Kconfig                 |  4 +-
>>>    security/apparmor/Makefile                |  2 +
>>>    security/apparmor/include/policy_unpack.h | 50 ++++++++++++++++
>>>    security/apparmor/policy_unpack.c         | 72 +++++++----------------
>>>    security/apparmor/policy_unpack_test.c    |  5 ++
>>>    5 files changed, 80 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
>>> index cb3496e00d8a..f334e7cccf2d 100644
>>> --- a/security/apparmor/Kconfig
>>> +++ b/security/apparmor/Kconfig
>>> @@ -106,8 +106,8 @@ config SECURITY_APPARMOR_PARANOID_LOAD
>>>          Disabling the check will speed up policy loads.
>>>
>>>    config SECURITY_APPARMOR_KUNIT_TEST
>>> -     bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
>>> -     depends on KUNIT=y && SECURITY_APPARMOR
>>> +     tristate "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
>>> +     depends on KUNIT && SECURITY_APPARMOR
>>>        default KUNIT_ALL_TESTS
>>>        help
>>>          This builds the AppArmor KUnit tests.
>>> diff --git a/security/apparmor/Makefile b/security/apparmor/Makefile
>>> index ff23fcfefe19..6a92428375eb 100644
>>> --- a/security/apparmor/Makefile
>>> +++ b/security/apparmor/Makefile
>>> @@ -8,6 +8,8 @@ apparmor-y := apparmorfs.o audit.o capability.o task.o ipc.o lib.o match.o \
>>>                  resource.o secid.o file.o policy_ns.o label.o mount.o net.o
>>>    apparmor-$(CONFIG_SECURITY_APPARMOR_HASH) += crypto.o
>>>
>>> +obj-$(CONFIG_SECURITY_APPARMOR_KUNIT_TEST) += policy_unpack_test.o
>>> +
>>>    clean-files := capability_names.h rlim_names.h net_names.h
>>>
>>>    # Build a lower case string table of address family names
>>> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
>>> index eb5f7d7f132b..a963687bcc9b 100644
>>> --- a/security/apparmor/include/policy_unpack.h
>>> +++ b/security/apparmor/include/policy_unpack.h
>>> @@ -48,6 +48,43 @@ enum {
>>>        AAFS_LOADDATA_NDENTS            /* count of entries */
>>>    };
>>>
>>> +/*
>>> + * The AppArmor interface treats data as a type byte followed by the
>>> + * actual data.  The interface has the notion of a named entry
>>> + * which has a name (AA_NAME typecode followed by name string) followed by
>>> + * the entries typecode and data.  Named types allow for optional
>>> + * elements and extensions to be added and tested for without breaking
>>> + * backwards compatibility.
>>> + */
>>> +
>>> +enum aa_code {
>>> +     AA_U8,
>>> +     AA_U16,
>>> +     AA_U32,
>>> +     AA_U64,
>>> +     AA_NAME,                /* same as string except it is items name */
>>> +     AA_STRING,
>>> +     AA_BLOB,
>>> +     AA_STRUCT,
>>> +     AA_STRUCTEND,
>>> +     AA_LIST,
>>> +     AA_LISTEND,
>>> +     AA_ARRAY,
>>> +     AA_ARRAYEND,
>>> +};
>>> +
>>> +/*
>>> + * aa_ext is the read of the buffer containing the serialized profile.  The
>>> + * data is copied into a kernel buffer in apparmorfs and then handed off to
>>> + * the unpack routines.
>>> + */
>>> +struct aa_ext {
>>> +     void *start;
>>> +     void *end;
>>> +     void *pos;              /* pointer to current position in the buffer */
>>> +     u32 version;
>>> +};
>>> +
>>
>> hrmmm, I prefer these symbols to be only available to the unpack code but can
>> live with them being more widely available.
>>
>>>    /*
>>>     * struct aa_loaddata - buffer of policy raw_data set
>>>     *
>>> @@ -126,4 +163,17 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
>>>                kref_put(&data->count, aa_loaddata_kref);
>>>    }
>>>
>>> +#if IS_ENABLED(CONFIG_KUNIT)
>>> +bool inbounds(struct aa_ext *e, size_t size);
>>> +size_t unpack_u16_chunk(struct aa_ext *e, char **chunk);
>>> +bool unpack_X(struct aa_ext *e, enum aa_code code);
>>> +bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
>>> +bool unpack_u32(struct aa_ext *e, u32 *data, const char *name);
>>> +bool unpack_u64(struct aa_ext *e, u64 *data, const char *name);
>>> +size_t unpack_array(struct aa_ext *e, const char *name);
>>> +size_t unpack_blob(struct aa_ext *e, char **blob, const char *name);
>>> +int unpack_str(struct aa_ext *e, const char **string, const char *name);
>>> +int unpack_strdup(struct aa_ext *e, char **string, const char *name);
>>
>> So this is a problem. If this symbols are going to be visible outside of the
>> unpack code they need to be prefixed with aa_ to help avoid collisions with
>> other kernel code.
>>
> 
> Hmm... I agree we need some sort of way of restricting access to these symbols.
> 
> As-is, they're _exported_ to a different symbol namespace, so it

if by exported you mean static. This particular set of symbols is not
exported in a header and each function is static. They are accessible
to the kunit tests because of some what gross

#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
#include "policy_unpack_test.c"
#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */

at the end of the file. And of course this means these tests can't be
built as a module

> shouldn't be a problem during linking when built as a module, nor if
> KUnit is disabled (due to the preprocessor step).
> 
right

> One option is to put these in a separate header (that only the test
> and policy-unpack code include), but even that doesn't solve the
> linking problem when built-in.
> 
a separate header might be as a pseudo documentation step but the
reality is that I can't see anyone else including the existing header
so its not really required.

> So I guess namespacing is the only option which solves all of these
> problems. (It'd be nice if the symbol namespacing system worked for
> built-ins as well as modules...)
> 
yeah

>>> +#endif
>>> +
>>>    #endif /* __POLICY_INTERFACE_H */
>>> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
>>> index 55d31bac4f35..c23aa70349aa 100644
>>> --- a/security/apparmor/policy_unpack.c
>>> +++ b/security/apparmor/policy_unpack.c
>>> @@ -14,6 +14,7 @@
>>>     */
>>>
>>>    #include <asm/unaligned.h>
>>> +#include <kunit/visibility.h>
>>>    #include <linux/ctype.h>
>>>    #include <linux/errno.h>
>>>    #include <linux/zlib.h>
>>> @@ -37,43 +38,6 @@
>>>    #define v7  7
>>>    #define v8  8       /* full network masking */
>>>
>>> -/*
>>> - * The AppArmor interface treats data as a type byte followed by the
>>> - * actual data.  The interface has the notion of a named entry
>>> - * which has a name (AA_NAME typecode followed by name string) followed by
>>> - * the entries typecode and data.  Named types allow for optional
>>> - * elements and extensions to be added and tested for without breaking
>>> - * backwards compatibility.
>>> - */
>>> -
>>> -enum aa_code {
>>> -     AA_U8,
>>> -     AA_U16,
>>> -     AA_U32,
>>> -     AA_U64,
>>> -     AA_NAME,                /* same as string except it is items name */
>>> -     AA_STRING,
>>> -     AA_BLOB,
>>> -     AA_STRUCT,
>>> -     AA_STRUCTEND,
>>> -     AA_LIST,
>>> -     AA_LISTEND,
>>> -     AA_ARRAY,
>>> -     AA_ARRAYEND,
>>> -};
>>> -
>>> -/*
>>> - * aa_ext is the read of the buffer containing the serialized profile.  The
>>> - * data is copied into a kernel buffer in apparmorfs and then handed off to
>>> - * the unpack routines.
>>> - */
>>> -struct aa_ext {
>>> -     void *start;
>>> -     void *end;
>>> -     void *pos;              /* pointer to current position in the buffer */
>>> -     u32 version;
>>> -};
>>> -
>>>    /* audit callback for unpack fields */
>>>    static void audit_cb(struct audit_buffer *ab, void *va)
>>>    {
>>> @@ -199,10 +163,11 @@ struct aa_loaddata *aa_loaddata_alloc(size_t size)
>>>    }
>>>
>>>    /* test if read will be in packed data bounds */
>>> -static bool inbounds(struct aa_ext *e, size_t size)
>>> +VISIBLE_IF_KUNIT bool inbounds(struct aa_ext *e, size_t size)
>>>    {
>>>        return (size <= e->end - e->pos);
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(inbounds);
>>>
>>>    static void *kvmemdup(const void *src, size_t len)
>>>    {
>>> @@ -220,7 +185,7 @@ static void *kvmemdup(const void *src, size_t len)
>>>     *
>>>     * Returns: the size of chunk found with the read head at the end of the chunk.
>>>     */
>>> -static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
>>> +VISIBLE_IF_KUNIT size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
>>>    {
>>>        size_t size = 0;
>>>        void *pos = e->pos;
>>> @@ -239,9 +204,10 @@ static size_t unpack_u16_chunk(struct aa_ext *e, char **chunk)
>>>        e->pos = pos;
>>>        return 0;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_u16_chunk);
>>>
>>>    /* unpack control byte */
>>> -static bool unpack_X(struct aa_ext *e, enum aa_code code)
>>> +VISIBLE_IF_KUNIT bool unpack_X(struct aa_ext *e, enum aa_code code)
>>>    {
>>>        if (!inbounds(e, 1))
>>>                return false;
>>> @@ -250,6 +216,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
>>>        e->pos++;
>>>        return true;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_X);
>>>
>>>    /**
>>>     * unpack_nameX - check is the next element is of type X with a name of @name
>>> @@ -267,7 +234,7 @@ static bool unpack_X(struct aa_ext *e, enum aa_code code)
>>>     *
>>>     * Returns: false if either match fails, the read head does not move
>>>     */
>>> -static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>>> +VISIBLE_IF_KUNIT bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>>>    {
>>>        /*
>>>         * May need to reset pos if name or type doesn't match
>>> @@ -296,6 +263,7 @@ static bool unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name)
>>>        e->pos = pos;
>>>        return false;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_nameX);
>>>
>>>    static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
>>>    {
>>> @@ -315,7 +283,7 @@ static bool unpack_u8(struct aa_ext *e, u8 *data, const char *name)
>>>        return false;
>>>    }
>>>
>>> -static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>>> +VISIBLE_IF_KUNIT bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>>>    {
>>>        void *pos = e->pos;
>>>
>>> @@ -332,8 +300,9 @@ static bool unpack_u32(struct aa_ext *e, u32 *data, const char *name)
>>>        e->pos = pos;
>>>        return false;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_u32);
>>>
>>> -static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>>> +VISIBLE_IF_KUNIT bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>>>    {
>>>        void *pos = e->pos;
>>>
>>> @@ -350,8 +319,9 @@ static bool unpack_u64(struct aa_ext *e, u64 *data, const char *name)
>>>        e->pos = pos;
>>>        return false;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_u64);
>>>
>>> -static size_t unpack_array(struct aa_ext *e, const char *name)
>>> +VISIBLE_IF_KUNIT size_t unpack_array(struct aa_ext *e, const char *name)
>>>    {
>>>        void *pos = e->pos;
>>>
>>> @@ -368,8 +338,9 @@ static size_t unpack_array(struct aa_ext *e, const char *name)
>>>        e->pos = pos;
>>>        return 0;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_array);
>>>
>>> -static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>>> +VISIBLE_IF_KUNIT size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>>>    {
>>>        void *pos = e->pos;
>>>
>>> @@ -390,8 +361,9 @@ static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
>>>        e->pos = pos;
>>>        return 0;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_blob);
>>>
>>> -static int unpack_str(struct aa_ext *e, const char **string, const char *name)
>>> +VISIBLE_IF_KUNIT int unpack_str(struct aa_ext *e, const char **string, const char *name)
>>>    {
>>>        char *src_str;
>>>        size_t size = 0;
>>> @@ -413,8 +385,9 @@ static int unpack_str(struct aa_ext *e, const char **string, const char *name)
>>>        e->pos = pos;
>>>        return 0;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_str);
>>>
>>> -static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
>>> +VISIBLE_IF_KUNIT int unpack_strdup(struct aa_ext *e, char **string, const char *name)
>>>    {
>>>        const char *tmp;
>>>        void *pos = e->pos;
>>> @@ -432,6 +405,7 @@ static int unpack_strdup(struct aa_ext *e, char **string, const char *name)
>>>
>>>        return res;
>>>    }
>>> +EXPORT_SYMBOL_IF_KUNIT(unpack_strdup);
>>>
>> Again if the symbols are going to be exported they need the aa_ prefix
>>
>> But I am not sure this is worth doing, exporting a lot of symbols just so the
>> test code can be built as a module doesn't seem worth it to me.
>>
> 
> Again, agreed that we need to namespace these for the non-module case
> (the symbol namespacing should be okay otherwise).
> 
> One of the reasons behind doing this is that there are a few KUnit
> users who can only run tests which are built as modules. In
> particular, Android and (IIRC) Red Hat are both configuring all of
> their kernels with KUnit built as a module, and distributing the KUnit
> and KUnit test modules in a different package.
> 
ah, okay

> If we kept things the way there are, then it'd not be possible to
> unconditionally _build_ the apparmor tests, but only load and run them
> on demand (due to the way they're built into the apparmor module,
> they'd always run when it loads). This is a no-go for Android/Red Hat,
> so they won't ship or run the apparmor tests. (There are some other
> tests with the same problem, notably amdgpu, but apparmor seemed a
> nice first trial-user, as it were, having a small but non-trivial
> number of symbols to export.)
> 
> Thoughts?
> 
I'm not opposed to exporting them. It has a cost and I wanted there to
be a real need before doing it. Since that need has been explained, my
only requirement is to make sure they are properly namespaced.

>>>
>>>    /**
>>> @@ -1251,7 +1225,3 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>>>
>>>        return error;
>>>    }
>>> -
>>> -#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
>>> -#include "policy_unpack_test.c"
>>> -#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
>>> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
>>> index 0a969b2e03db..3474fe2cd922 100644
>>> --- a/security/apparmor/policy_unpack_test.c
>>> +++ b/security/apparmor/policy_unpack_test.c
>>> @@ -4,6 +4,7 @@
>>>     */
>>>
>>>    #include <kunit/test.h>
>>> +#include <kunit/visibility.h>
>>>
>>>    #include "include/policy.h"
>>>    #include "include/policy_unpack.h"
>>> @@ -43,6 +44,8 @@
>>>    #define TEST_ARRAY_BUF_OFFSET \
>>>        (TEST_NAMED_ARRAY_BUF_OFFSET + 3 + strlen(TEST_ARRAY_NAME) + 1)
>>>
>>> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>>> +
>>>    struct policy_unpack_fixture {
>>>        struct aa_ext *e;
>>>        size_t e_size;
>>> @@ -605,3 +608,5 @@ static struct kunit_suite apparmor_policy_unpack_test_module = {
>>>    };
>>>
>>>    kunit_test_suite(apparmor_policy_unpack_test_module);
>>> +
>>> +MODULE_LICENSE("GPL");
>>

