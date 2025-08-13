Return-Path: <linux-kselftest+bounces-38840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58448B2452F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BE17B947
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE002F1FF3;
	Wed, 13 Aug 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6sipWL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16062F1FE5
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076695; cv=none; b=op5S+HXOfZR83bbNbCcnXNw8FGH85w72bAlIJzmpvBExGEPsXUrzTJyocBt9WbnAKLGs5mbUpbvGJBRxtzEpy66HHr+xhlOHgrf2jP+v1DQJR1yVOpG3lWLCEz/v28iRzybr9KHMDhUIfvtFmAjEnZVhI3pTHuQaURl1KYcId7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076695; c=relaxed/simple;
	bh=bf29RaN1sLcBJtKsUn+j+4xquaNLmq4bsngE/7ny71I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeiDYUl7RNNJcUYaqRUHbACItT0wlwf9um3ZBYgk/EORVQXZSlGI9ZPIJ1LY0VmeC28gYOrf5poiY1yhzDoQMoYq0K2ijryi5YFKOHUfTtLpB2RlPjcgvvD4mwyK3xbs2GXv+UYw1d2hnPaVITQ4YR0utS/0OwpsozjuLzJLGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6sipWL8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70739d1f07bso75395726d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755076693; x=1755681493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2zmCC0/1BV9Fy7firf4011OKhhrr4okq/CL9KUJtU00=;
        b=l6sipWL8EBHLRBjw5mj6Qr1ET0yhOTQQVe9/vXBW8Q6vd+bpNg8wnVRz27iE4pvDnq
         yHG8Kmj1G2K3odkrBKIMQg1HcbEtGIURbaoX1GjGLj+D7q2SRRW2ZrK8x93Xbv2g6dB2
         nzK/TpWt4W7NMyeEu3OM2rwECm5yBllKT2HxpF4NOf986NZZkAOC0wMS2Bqt4Rolnotk
         UfJso1j0vPZ7fY41PsoCmww4zHUnBe8pzDswKAx4grxM8XITTBVtL1RogrDuQsosOKqF
         R7OFLvp61SQ5LiLCE58Ht0kZe/NmbUb/oQTGPKldwzEXYl+61mrgmXI+j4//IXwNIIBW
         HN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076693; x=1755681493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zmCC0/1BV9Fy7firf4011OKhhrr4okq/CL9KUJtU00=;
        b=qKUeAlq4LkpQZ63yMN5LpL5UAK72CWf9B5bSqgE7DLpbu50euUGVlcopPMW5GCHNvY
         2C1nnIoIN20wgsWRfce6GUnbVZeyihIsCwT8tvF5wD26V1vLd1DPMlJXdVIWFu6tY18W
         QyGvbCb+c29Hy3mNvs0InTIoGu3snSUMjmhpBJuVbHLm84v9SSC3y8SIT/6x15TkSueX
         gvtOQODIaoKLa/CFOnB6wXjfIku7cEvxdhr0nzpvr05WFu2CF7RhJxiqY9jM5b9H5Ktp
         HaN86GGzyHKW2rGQtzEqVTlwKsn27ivuX6eRBmRuTpxIl6xz3p6ArrH0wRJHQlvArR0Y
         bUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu6jrZrJJLp+d8Aa39rDCUfS0Y7Gi1ud3vpZ0dTibpic1oskTubM8nyb2cWOLI45Yacb8VfA/j6y8p+YhBePM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+xco2L56zxRo33WDA3gS5tMkSU33LYyrQz0nYxfRVrrAquIS
	ub23lgR/B/kPLinTcUXB/EZ8TB6Axpg6RvDosDboTmxjHMDy7GJ2+0qXtqUjg5U829WNi+N5Q7g
	qI/kD5onA9dbtz0CuwJ4BYfmYmOzcpRfmoryy7LUV
X-Gm-Gg: ASbGncudFobpz7A5xwusDdoIUqCAAVk4tsAfFcG5vF13twoMbZluGvxp777N5+9ypQ9
	rKCx7X3rmMVq9k9EOTe+qCKDiROiBOT/NKZ5f5jj64iVIlHFkGMWG71VoE8kvgk0UovgsNJTca3
	AQOFvpAq0O1mssbt2EzBGb7g99H80dNEVBequ3wZisPQikmrShC40ntxuBO7mPNJI2d5/NIVmfl
	ISmOdoJ
X-Google-Smtp-Source: AGHT+IFOMy3ux4q9zsdCAAzncFNBNiviY9kNizY9qtQPZOH9h8kysTF7L/nqs7k6PSKjW9FAAMH3DSCDs7x64fD0I5Y=
X-Received: by 2002:a05:6214:300c:b0:707:5fbf:26ce with SMTP id
 6a1803df08f44-709e891b1a9mr26541896d6.31.1755076692462; Wed, 13 Aug 2025
 02:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-6-marievic@google.com>
In-Reply-To: <20250811221739.2694336-6-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Aug 2025 17:17:59 +0800
X-Gm-Features: Ac12FXyllklPPmM0S93BAFzCWiarUFJEfRESVl9pmPvzj0UDOJlCFkkkyxvdre4
Message-ID: <CABVgOSkhix4foDmVmLPDNZz8VZ1tJMGHKNeazYgJpgRdbxiVOw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kunit: Add example parameterized test with shared
 resource management using the Resource API
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dae179063c3ba291"

--000000000000dae179063c3ba291
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 06:18, Marie Zhussupova <marievic@google.com> wrote:
>
> Add example_params_test_with_init() to illustrate how to manage
> shared resources across a parameterized KUnit test. This example
> showcases the use of the new param_init() function and its registration
> to a test using the KUNIT_CASE_PARAM_WITH_INIT() macro.
>
> Additionally, the test demonstrates how to directly pass a parameter array
> to the parameterized test context via kunit_register_params_array()
> and leveraging the Resource API for shared resource management.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

This looks fine to me. One note below about one of the comments.

Otherwise,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes in v2:
>
> - kunit_array_gen_params() is now explicitly passed to
>   KUNIT_CASE_PARAM_WITH_INIT() to be consistent with
>   a parameterized test being defined by the existence
>   of the generate_params() function.
> - The comments were edited to be more concise.
> - The patch header was changed to reflect that this example
>   test's intent is more aligned with showcasing using the
>   Resource API for shared resource management.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
>
> ---
>
>  lib/kunit/kunit-example-test.c | 118 +++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 3056d6bc705d..f2819ee58965 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -277,6 +277,122 @@ static void example_slow_test(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, 1 + 1, 2);
>  }
>
> +/*
> + * This custom function allocates memory and sets the information we want
> + * stored in the kunit_resource->data field.
> + */
> +static int example_resource_init(struct kunit_resource *res, void *context)
> +{
> +       int *info = kmalloc(sizeof(*info), GFP_KERNEL);
> +
> +       if (!info)
> +               return -ENOMEM;
> +       *info = *(int *)context;
> +       res->data = info;
> +       return 0;
> +}
> +
> +/*
> + * This function deallocates memory for the kunit_resource->data field.
> + */
> +static void example_resource_free(struct kunit_resource *res)
> +{
> +       kfree(res->data);
> +}
> +
> +/*
> + * This match function is invoked by kunit_find_resource() to locate
> + * a test resource based on certain criteria.
> + */
> +static bool example_resource_alloc_match(struct kunit *test,
> +                                        struct kunit_resource *res,
> +                                        void *match_data)
> +{
> +       return res->data && res->free == example_resource_free;
> +}
> +
> +/*
> + * This is an example of a function that provides a description for each of the
> + * parameters in a parameterized test.
> + */
> +static void example_param_array_get_desc(struct kunit *test, const void *p, char *desc)
> +{
> +       const struct example_param *param = p;
> +
> +       snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +                "example check if %d is less than or equal to 3", param->value);
> +}
> +
> +/*
> + * This function gets passed in the parameterized test context i.e. the
> + * struct kunit belonging to the parameterized test. You can use this function
> + * to add resources you want shared across the whole parameterized test or
> + * for additional setup.
> + */
> +static int example_param_init(struct kunit *test)
> +{
> +       int ctx = 3; /* Data to be stored. */
> +       size_t arr_size = ARRAY_SIZE(example_params_array);
> +
> +       /*
> +        * This allocates a struct kunit_resource, sets its data field to
> +        * ctx, and adds it to the struct kunit's resources list. Note that
> +        * this is parameterized test managed. So, it doesn't need to have
> +        * a custom exit function to deallocation as it will get cleaned up at
> +        * the end of the parameterized test.
> +        */
> +       void *data = kunit_alloc_resource(test, example_resource_init, example_resource_free,
> +                                         GFP_KERNEL, &ctx);
> +
> +       if (!data)
> +               return -ENOMEM;
> +       /*
> +        * Pass the parameter array information to the parameterized test context
> +        * struct kunit. Note that you will need to provide kunit_array_gen_params()
> +        * as the generator function to KUNIT_CASE_PARAM_WITH_INIT() when registering
> +        * a parameter array this route.
> +        *
> +        * Alternatively, since this is a static array we can also use
> +        * KUNIT_CASE_PARAM_ARRAY(,DESC) to create  a `*_gen_params()` function
> +        * and pass that to  KUNIT_CASE_PARAM_WITH_INIT() instead of registering
> +        * the parameter array here.

Maybe we should note that KUNIT_CASE_PARAM_ARRAY{,_DESC}() doesn't let
us set an init function, so would be less useful here.


> +        */
> +       kunit_register_params_array(test, example_params_array, arr_size,
> +                                   example_param_array_get_desc);
> +       return 0;
> +}
> +
> +/*
> + * This is an example of a test that uses shared resources available in the
> + * parameterized test context.
> + */
> +static void example_params_test_with_init(struct kunit *test)
> +{
> +       int threshold;
> +       struct kunit_resource *res;
> +       const struct example_param *param = test->param_value;
> +
> +       /* By design, param pointer will not be NULL. */
> +       KUNIT_ASSERT_NOT_NULL(test, param);
> +
> +       /*
> +        * Here we pass test->parent to search for shared resources in the
> +        * parameterized test context.
> +        */
> +       res = kunit_find_resource(test->parent, example_resource_alloc_match, NULL);
> +
> +       KUNIT_ASSERT_NOT_NULL(test, res);
> +
> +       /* Since kunit_resource->data is a void pointer we need to typecast it. */
> +       threshold = *((int *)res->data);
> +
> +       /* Assert that the parameter is less than or equal to a certain threshold. */
> +       KUNIT_ASSERT_LE(test, param->value, threshold);
> +
> +       /* This decreases the reference count after calling kunit_find_resource(). */
> +       kunit_put_resource(res);
> +}
> +
>  /*
>   * Here we make a list of all the test cases we want to add to the test suite
>   * below.
> @@ -296,6 +412,8 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>         KUNIT_CASE(example_priv_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> +       KUNIT_CASE_PARAM_WITH_INIT(example_params_test_with_init, kunit_array_gen_params,
> +                                  example_param_init, NULL),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

--000000000000dae179063c3ba291
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgGR54inI8OfkZTsmC/cV0bXyowzKf
DmidwSv/ZQGGmIkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODEzMDkxODEzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAgvcVduQTkpKtEkVCPbfGi15AU0gcTXiiMtuKVPEuqbigyfvwn+EkFxvsoMZ3bC1E
G3N0nVMJuFrM/SPYkYYfrNTM1Dsv6YvhNH2HRNVeF54yoUk/7Gi5VE47y/Fy6PKdlfeG/0sI29ce
odKLMNskJhumc1V98+s/SEtjiJL+nHUSeLJlerOJCxDkzOpOe8F3ij9EzPpr1MSQ/v+6mmocHRZm
+QGvLYUp4sZlwAHETt+8Klqn8il+m766ct2gtLri/zvzRGa+wam9ePKue35tm/lv5FQiEv1v3Bi3
WtC+IAZfIr73XkbzLNg0jeRj253qg1q1OZ07DkdmHxl1J9pFuQ==
--000000000000dae179063c3ba291--

