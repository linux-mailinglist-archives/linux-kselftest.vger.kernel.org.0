Return-Path: <linux-kselftest+bounces-38216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F72B18DCB
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4D91AA4474
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7A245012;
	Sat,  2 Aug 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPIZUf6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA6243387
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127917; cv=none; b=EhNQfHU2shfM9dtcGXa0cPaLeJRNBxA2ard2tOHBItIqOhshS4U6AaZWYxQqCOewpAxWFDkkhMXI9JQ3lardXsG4q5k5HyUyxI3YQp2RI/RwOLGSzhaJxn1B07KCLUe2/Ym/N8jI3bBWLBYqPH/kTYLmyo+Oi/lkBTooOWSB8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127917; c=relaxed/simple;
	bh=+XgriFeHQfud6eT3bVFNH19Mr9a7zFnp247TEk/2Nso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBOkBFCpbBawtYvY8YNqpeJrYWHTbeqUZglhhQD6/6LzM8UgUve87Q+MLgs/9s3hjERr8daNq638KGRyeN/xY6wy0I8U9YsHgW9UUpyBSwadDHenCkgE7t3KpEe7aJOpAXIrhB5Od9iA0t5scQO8fOYvSZcaqetfJYKy/T9zA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPIZUf6p; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-707453b031fso26897726d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Aug 2025 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754127913; x=1754732713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ6x/PeToUg2DwiR+/TKFg5ZFUs87FpVhhgmaL4bhuQ=;
        b=gPIZUf6pteru+Bz4vEMUf894mcNErBL1UtmSePcISgsf+7EGaRjdTUsm2E2mY9PjFT
         VcJHd/9Cg/NewNFi8OBJa39h1tIK7etP8qR/O1xwhGr99O5SE13ObOPIqovlhVyF3wHy
         FnnVgC9mVOe7/rIkB0T/322/r2k+io9Azu8tT3+bLRJ8vs2Stvwvr0f6qgqpkpwQUqkJ
         sYRWoeVHem8tqBw8qiAEowFK6MIF2u+0QqzFnmUfUdRkcoHgEvmpgChBqFp4TaJUvhki
         cVavLtVTlLYmTYqSpF3yZ6ZiKFiYA2dmsnHCDo6aiKdci1wNSJCmEXJIylBtJK4imJja
         etzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127913; x=1754732713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ6x/PeToUg2DwiR+/TKFg5ZFUs87FpVhhgmaL4bhuQ=;
        b=sG/xVu77QfNAeKxVbdMIsmW6OoI4UcUso3PsAfpTHdEaNZkSd9nic6USFqK08n+3Xu
         xgefQ+ZQeiunwZJTLCRvg0huYelX8SIyMbF29+WkR4uozyjKRapcqLdG8tejCLHgIZRr
         E1GBotaBbZSgQo93P3yJ670seqTcaaOdsyu5ZyoMiZba5ah+HpasdtOdHO6dc6F4gKAl
         7BOtAfHwBYz9hG/4ZahGKrvJAAmG7pO5wzj3IXv/RV+W/w8Joir2SfixA846X/Q/RemL
         1QPg5iJG8LSVPyJ0vE+++8iUM0QWUX45zdj9uR/ovcoE67Eo/fhyFaE74Xq5Z+n26EPJ
         GYew==
X-Forwarded-Encrypted: i=1; AJvYcCXJQtBF/37okyM2iXm7Elb5eFGHK8G819l68sAi3PD0MH9tigVSCZFkBllViKj7w1PnVhuGNBwv3kd7DXoyt1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdFZrY12YsyKX03LsSYthGF7S/91f4zXG6IbRq2I6mr4mh8cB
	zJS2Dx/KtT+yj7kwJqU94W6dPg2d5wBLelLMbA7/gn9FK285i27Q+UtL/qhNAZjcJ2895Et6Ne3
	xDgFf2Oh3K2Ag4JNYpyGO1GRfGsQNQOwDpcgMcsmv
X-Gm-Gg: ASbGncuF/uDH1RCMMIH/kxZ2b7V1uJ5x9wtBx1wd4AiSOeUi/+sW9NAFLjCZJsO9YBK
	FvoFQvZ2tcLGMggkcCJaCTSqToqKFCWM2Mdrqq4N528FzTDRUOs1y0Rvxth3hKldCDGNmy4YNoK
	xU3rM9fYDAuBGMRlJqmlr6iAnHNzkYfi0+OyNeunvd2Jp2cxIr8XUDJP+mYnHmxzLATX2+3QMay
	EbhAMfNIr7/XXXV8b4=
X-Google-Smtp-Source: AGHT+IF2uds2IAFsdWF7BW8K2SN3U9Tmr+SqQEwzZRU/l++g8rXiddtVQRgAhLsQro5d1LMezSI0nXIS01x1M2EP/KQ=
X-Received: by 2002:ad4:4eea:0:b0:707:44d4:2967 with SMTP id
 6a1803df08f44-7093686c9d1mr41816676d6.39.1754127912466; Sat, 02 Aug 2025
 02:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-7-marievic@google.com>
In-Reply-To: <20250729193647.3410634-7-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 2 Aug 2025 17:44:59 +0800
X-Gm-Features: Ac12FXzSJj7NxJ2JuofTLA2Kv5nFGiIFLzMiN1xlMjQ-cBpbbaKclP-h6Jg3HYQ
Message-ID: <CABVgOSnzRZ7jsyjTtAed9Bix-1oWzvwGXZbYoRDVWtJFTHjcLw@mail.gmail.com>
Subject: Re: [PATCH 6/9] kunit: Enable direct registration of parameter arrays
 to a KUnit test
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000027c029063b5ebb28"

--00000000000027c029063b5ebb28
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrote:
>
> KUnit parameterized tests currently support two
> primary methods for getting parameters:
> 1.  Defining custom logic within a `generate_params`
>     function.
> 2.  Using the KUNIT_ARRAY_PARAM and KUNIT_ARRAY_PARAM_DESC
>     macros with pre-defined static arrays.
>
> These methods present limitations when dealing with
> dynamically generated parameter arrays, or in scenarios
> where populating parameters sequentially via
> `generate_params` is inefficient or overly complex.
>
> This patch addresses these limitations by adding a new
> `params_data` field to `struct kunit`, of the type
> `kunit_params`. The struct `kunit_params` is designed to
> store the parameter array itself, along with essential metadata
> including the parameter count, parameter size, and a
> `get_description` function for providing custom descriptions
> for individual parameters.
>
> The `params_data` field can be populated by calling the new
> `kunit_register_params_array` macro from within a
> `param_init` function. By attaching the parameter array
> directly to the parent kunit test instance, these parameters
> can be iterated over in kunit_run_tests() behind the scenes.
>
> This modification provides greater flexibility to the
> KUnit framework, allowing testers to easily register and
> utilize both dynamic and static parameter arrays.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

A few thoughts:
- Refactoring out the parameter data into struct kunit_params makes
sense, particularly given the new features.
- We now have 3 APIs to handle parameters (all of which use a
generator function behind the scenes): a static array (which uses a
macro to invent a custom generator function), a dynamic array (which
uses kunit_get_next_param_and_desc as a -- possibly implied --
generator function), and a user-provided generator function. I don't
think that's a problem, but maybe these can be brought slightly closer
together in implementation?
- Should users pass NULL or kunit_get_next_param_and_desc as the
gen_params function if they're using a dynamic array? We seem to
support both here, but it's unsure which is preferred. My gut feeling
is that we should either totally pick one or the other: if we say NULL
implies kunit_get_next_param_and_desc, we should just set
kunit_params.generate_params to NULL, and only check when we call it;
if we suggest people use kunit_get_next_param_and_desc, we should not
support NULL at all (it goes back to implying a non-parameterised
test). My gut preference is for the latter, though it's not without
downsides.

More comments below.

Cheers,
-- David

>  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++----
>  lib/kunit/test.c     | 26 ++++++++++++++++++++-
>  2 files changed, 75 insertions(+), 5 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 4ba65dc35710..9143f0e22323 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -245,7 +245,8 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  #define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)          \
>                 { .run_case = test_name, .name = #test_name,                    \
> -                 .generate_params = gen_params,                                \
> +                 .generate_params = (gen_params)                               \
> +                  ?: kunit_get_next_param_and_desc,                            \

A part of me wonders whether we need this, or should just tell people
to pass kunit_get_next_param_and_desc manually, rather than NULL.

(If so, _maybe_ it'd make sense to rename it to something more
obvious, like kunit_get_array_param?)

>                   .param_init = init, .param_exit = exit,                       \
>                   .module_name = KBUILD_MODNAME}
>
> @@ -294,6 +295,21 @@ struct kunit_suite_set {
>         struct kunit_suite * const *end;
>  };
>
> +/* Stores the pointer to the parameter array and its metadata. */
> +struct kunit_params {
> +       /*
> +        * Reference to the parameter array for the parameterized tests. This
> +        * is NULL if a parameter array wasn't directly passed to the
> +        * parent kunit struct via the kunit_register_params_array macro.
> +        */

Would it make sense to update KUNIT_ARRAY_PARAM(,_DESC) to use this member?

I'd imagine we could get rid of the custom generated function for
KUNIT_ARRAY_PARAM, though we'd
still need it for the _DESC variant.

(Unless you want to go overboard, add a new offset_of_description
member, and make it possible to pass a description field even with
dynamic arrays. Though I don't know of anyone who actually needs
that.)

The existing "generated function" method is still correct (and maybe
slightly faster, though if this is a serious bottleneck, I'll eat my
hat), so I don't know that this change is necessary. Maybe worth
trying, or looking at for a follow-up.

> +       const void *params;
> +       /* Reference to a function that gets the description of a parameter. */
> +       void (*get_description)(const void *param, char *desc);
> +
> +       int num_params;
> +       size_t elem_size;
> +};
> +
>  /**
>   * struct kunit - represents a running instance of a test.
>   *
> @@ -302,12 +318,14 @@ struct kunit_suite_set {
>   * @parent: for user to store data that they want to shared across
>   *         parameterized tests. Typically, the data is provided in
>   *         the param_init function (see &struct kunit_case).
> + * @params_data: for users to directly store the parameter array.
>   *
>   * Used to store information about the current context under which the test
>   * is running. Most of this data is private and should only be accessed
> - * indirectly via public functions; the two exceptions are @priv and @parent
> - * which can be used by the test writer to store arbitrary data or data that is
> - * available to all parameter test executions, respectively.
> + * indirectly via public functions. There are three exceptions to this: @priv,
> + * @parent, and @params_data. These members can be used by the test writer to
> + * store arbitrary data, data available to all parameter test executions, and
> + * the parameter array, respectively.
>   */
>  struct kunit {
>         void *priv;
> @@ -316,6 +334,8 @@ struct kunit {
>          * during parameterized testing.
>          */
>         struct kunit *parent;
> +       /* Stores the params array and all data related to it. */
> +       struct kunit_params params_data;
>
>         /* private: internal use only. */
>         const char *name; /* Read only after initialization! */
> @@ -386,6 +406,8 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
>  struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_set,
>                 struct kunit_suite_set suite_set);
>
> +const void *kunit_get_next_param_and_desc(struct kunit *test, const void *prev, char *desc);
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  int kunit_run_all_tests(void);
>  #else
> @@ -1735,6 +1757,30 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * kunit_register_params_array() - Register parameters for a KUnit test.
> + * @test: The KUnit test structure to which parameters will be added.
> + * @params_arr: An array of test parameters.
> + * @param_cnt: Number of parameters.
> + * @get_desc: A pointer to a function that generates a string description for
> + * a given parameter element.
> + *
> + * This macro initializes the @test's parameter array data, storing information
> + * including the parameter array, its count, the element size, and the parameter
> + * description function within `test->params_data`. KUnit's built-in
> + * `kunit_get_next_param_and_desc` function will automatically read this
> + * data when a custom `generate_params` function isn't provided.
> + */
> +#define kunit_register_params_array(test, params_arr, param_cnt, get_desc)                     \
> +       do {                                                                                    \
> +               struct kunit *_test = (test);                                           \
> +               const typeof((params_arr)[0]) * _params_ptr = &(params_arr)[0];                 \
> +               _test->params_data.params = _params_ptr;                                        \
> +               _test->params_data.num_params = (param_cnt);                                    \
> +               _test->params_data.elem_size = sizeof(*_params_ptr);                            \
> +               _test->params_data.get_description = (get_desc);                                \
> +       } while (0)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f50ef82179c4..2f4b7087db3f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -337,6 +337,13 @@ void __kunit_do_failed_assertion(struct kunit *test,
>  }
>  EXPORT_SYMBOL_GPL(__kunit_do_failed_assertion);
>
> +static void __kunit_init_params(struct kunit *test)
> +{
> +       test->params_data.params = NULL;
> +       test->params_data.num_params = 0;
> +       test->params_data.elem_size = 0;
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, struct string_stream *log)
>  {
>         spin_lock_init(&test->lock);
> @@ -347,6 +354,7 @@ void kunit_init_test(struct kunit *test, const char *name, struct string_stream
>                 string_stream_clear(log);
>         test->status = KUNIT_SUCCESS;
>         test->status_comment[0] = '\0';
> +       __kunit_init_params(test);
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>
> @@ -641,6 +649,22 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
>         total->total += add.total;
>  }
>
> +const void *kunit_get_next_param_and_desc(struct kunit *test, const void *prev, char *desc)

As Rae points out, this needs to be exported if we want this to work in modules.

(Unless you want to go all of the way down the "generate_params ==
NULL implies a parameter array" route, in which case we could get away
with it.)

> +{
> +       struct kunit_params *params_arr = &test->params_data;
> +       const void *param;
> +
> +       if (test->param_index < params_arr->num_params) {
> +               param = (char *)params_arr->params
> +                       + test->param_index * params_arr->elem_size;
> +
> +               if (params_arr->get_description)
> +                       params_arr->get_description(param, desc);
> +               return param;
> +       }
> +       return NULL;
> +}
> +
>  static void __kunit_init_parent_test(struct kunit_case *test_case, struct kunit *test)
>  {
>         if (test_case->param_init) {
> @@ -687,7 +711,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Test marked as skip */
>                         test.status = KUNIT_SKIPPED;
>                         kunit_update_stats(&param_stats, test.status);
> -               } else if (!test_case->generate_params) {
> +               } else if (!test_case->generate_params && !test.params_data.params) {

As above, this really depends on if we want generate_params == NULL to
imply that we're using a parameter array, or if it should imply that
we're a non-parameterised test.


>                         /* Non-parameterised test. */
>                         test_case->status = KUNIT_SKIPPED;
>                         kunit_run_case_catch_errors(suite, test_case, &test);
> --
> 2.50.1.552.g942d659e1b-goog
>

--00000000000027c029063b5ebb28
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg0BHwJcpInLd6KyUrBrOLxYa07HV7
AowKU55EA0MYHzowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODAyMDk0NTEzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEATX4OzTg2QuJ5BsyakgR2MpaiEjumEup3AjmOgy7ON1QbWYyB/IsblNKvMaVvX2Un
BxjVkutEFZZ5V3Mq979MDH5/oO/I7x9gmqFVsHlj9O6RGOMTy4n89JPSqFy7ZoT9fvMcSlMi4nL7
Jzc1MtQPM7hcQn9mL947jjlGUxt3gvZh8w1ikpdcJDRnH0BsPUOug4FvcRkwl7aO7u5PlZIRMEMp
O1KNG3R6eCzif7zU71prBaHs3WR8eP0GxUXfxV6TwJMIHGBmT+yOmoevJ/NkuRRKmqTSlVCfgsXU
CciCc4emvmc8FTniTJm3p62CJfxhAWR9WeTi3AgXSYcxww0gqQ==
--00000000000027c029063b5ebb28--

