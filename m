Return-Path: <linux-kselftest+bounces-38843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2052B24534
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 11:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5801BC1B06
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61F2F3C18;
	Wed, 13 Aug 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbxUF0cw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A12F290D
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076704; cv=none; b=JpNUSVlYZhYuyok17xNMmXm7eybmQC9qrzI0INWoe2Gq9DqttnVbk+mR/qDFSpp1cn64X2BmsiWiMWY8Ue6diUkAKmg3gczbo4su+yBivVC418muml88Gh/yqwQCKuaJdYcYgsz48sPD2rxL8w23PpSwPTzSDopSrFW2RKO12JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076704; c=relaxed/simple;
	bh=zes1SW+yFyJubWyPBtSZhZhh8vEllKtGcmiSVn7ndp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1FP717erWHvFlv4QUwN/2Fa677iouJGcA837QZcTqWLEoT/TQQorrHZiCgDxEUwlY0H07W3o9laD4/+YETLlCZpFLTTcxapy0DNHKQg9MkyK+sTLn2lZ/tXFU1dO+14Lkq/NCd5kY2LSpLI9pxWci0nb8bpdTh89gbhNKGZij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbxUF0cw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e7fb58425cso903453185a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755076701; x=1755681501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZEaz6QwBY3LNxwDW3YUPrGgBZmTkgIlNg/umvr34AM=;
        b=kbxUF0cwZrl15cTEjgoeoiyMj2jImC1Kz1AP1eidQ3a8y3uCqx3BfFf7fyxENzW30g
         oRNaovRXZRTy50vWE1U7X/QKSGekMlt2Fac007SEuEjMsAHSBWcC3QITZv4+nrps0Mez
         KdR+klzoKZeEQDK84V3zaJQjQZpmQArNRsqMUBDCxz2NotMX8t4GHYZvUlAhlXRAJW/Y
         b73+D921sLyapPw35hmHHsN4aCKrBB8K+xheZPVOp1lEWwcyn5Q+JHVq4pGNy9Udivma
         SUVAtAY7nHaJBifbe5oL29h54LxEpINXUT0z6AbTYFGlMlOy6j4gYzLf0DJTwQ+NHVpi
         T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755076701; x=1755681501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZEaz6QwBY3LNxwDW3YUPrGgBZmTkgIlNg/umvr34AM=;
        b=VzkFK8Zf1LxxWsgDxNNjxaOI+n8JvjNbgl8uhSJTo90ZuNOZM6MYzk3hu8FR8eVNku
         R2fPiUfmIMDujG1wje55Kba5jDPBdu8ukmMO3VcDbrxA9ggLOrUQ36UquM6vFE6dKpgQ
         hb/RlO1vWMmFcIqsVf94bErh7Q6B2xPkiGMpyz2gQWa5i7E60LBWRsxGwnzWh55LhTI2
         Ioi93UQLh0uOl7B8vP+8Abc0HQVhEwV96CD0MdC3bFrgllX1Xs3kaZ6YmaD16/B/JdXd
         oXqbcWILmF6m4FtDLl96ijoHPPmt2HOTwRon5Zq8JHbWcVWxnJFTLsKtyE9zppDaZvHr
         540Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaEftoEx0Pkgec7oAVFTLE2zDmsYGNdT09PJbC4VyAEfEpIxZ8OJGte28VcefqAKVZ+akrfvNpONVQ3X6rwb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjwd8pzpXz7geiBqiPhpzfj94Pne0FXy6BPyTuAYpV04TTx5V6
	C4sFAS3wGwqRhJ+sXlVIT12fGa9PnkY7odzAF3CxNT7Ql9G2tpQbpODibulPxXg5BtmFa0XJNZh
	xhloc2dse6szspX7LgtBPVQFOG+pqA8AjQhH/kuHA
X-Gm-Gg: ASbGnctcmKc5VdY3gOaNMtPVni4hG5gcn502qu9zlXuelINb94cgsxAtQMQLnnr5Tue
	kTAJHmMirZcTjdhHwve6/kmpIjtDITqYbMW+Ot7F/C7BJgl73Fd4MghyK2sJQqoFBhEhXNfOagL
	YPyl+On0vegpwAQJt+UTarq0By2f3G240FdDlL3wV2UGmJoQ+XxRq2iu/6NHHgvBUZn/fpzDust
	GbPz8BrCJGSdqZGw9c=
X-Google-Smtp-Source: AGHT+IF++s5SNEDibDSAGNFKLXNw1Pf5BQqIM9fRbsDGWYMBnY3KEfS50bhbythUQYrGyo2Ag/gmIET+1hEVsofduXw=
X-Received: by 2002:a05:6214:cc5:b0:707:4cbc:34b3 with SMTP id
 6a1803df08f44-709e881441dmr24998046d6.15.1755076701119; Wed, 13 Aug 2025
 02:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221739.2694336-1-marievic@google.com> <20250811221739.2694336-4-marievic@google.com>
In-Reply-To: <20250811221739.2694336-4-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Aug 2025 17:18:08 +0800
X-Gm-Features: Ac12FXzaMR1j11L8wnQS1UEb25dzBFxG3WALz2e2xtnIabkqPs2Go8hjAsSFCCw
Message-ID: <CABVgOSmqUEwM72qyUJP6FBZmK1XKuUdUk_4ZCjurbWaPwdruDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kunit: Pass parameterized test context to generate_params()
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005e7f70063c3ba3ee"

--0000000000005e7f70063c3ba3ee
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 06:17, Marie Zhussupova <marievic@google.com> wrote:
>
> To enable more complex parameterized testing scenarios,
> the generate_params() function needs additional context
> beyond just the previously generated parameter. This patch
> modifies the generate_params() function signature to
> include an extra `struct kunit *test` argument, giving
> test users access to the parameterized test context when
> generating parameters.
>
> The `struct kunit *test` argument was added as the first parameter
> to the function signature as it aligns with the convention
> of other KUnit functions that accept `struct kunit *test` first.
> This also mirrors the "this" or "self" reference found
> in object-oriented programming languages.
>
> This patch also modifies xe_pci_live_device_gen_param()
> in xe_pci.c and nthreads_gen_params() in kcsan_test.c
> to reflect this signature change.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

Looks great, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>
> Changes in v2:
>
> - generate_params signature changes in
>   xe_pci.c and kcsan_test.c were squashed
>   into a single patch to avoid in-between
>   breakages in the series.
> - The comments and the commit message were changed to
>   reflect the parameterized testing terminology. See
>   the patch series cover letter change log for the
>   definitions.
>
> ---
>  drivers/gpu/drm/xe/tests/xe_pci.c | 2 +-
>  include/kunit/test.h              | 9 ++++++---
>  kernel/kcsan/kcsan_test.c         | 2 +-
>  lib/kunit/test.c                  | 5 +++--
>  4 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/tests/xe_pci.c b/drivers/gpu/drm/xe/tests/xe_pci.c
> index 1d3e2e50c355..62c016e84227 100644
> --- a/drivers/gpu/drm/xe/tests/xe_pci.c
> +++ b/drivers/gpu/drm/xe/tests/xe_pci.c
> @@ -129,7 +129,7 @@ EXPORT_SYMBOL_IF_KUNIT(xe_pci_fake_device_init);
>   * Return: pointer to the next &struct xe_device ready to be used as a parameter
>   *         or NULL if there are no more Xe devices on the system.
>   */
> -const void *xe_pci_live_device_gen_param(const void *prev, char *desc)
> +const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc)
>  {
>         const struct xe_device *xe = prev;
>         struct device *dev = xe ? xe->drm.dev : NULL;
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d2e1b986b161..b527189d2d1c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -128,7 +128,8 @@ struct kunit_attributes {
>  struct kunit_case {
>         void (*run_case)(struct kunit *test);
>         const char *name;
> -       const void* (*generate_params)(const void *prev, char *desc);
> +       const void* (*generate_params)(struct kunit *test,
> +                                      const void *prev, char *desc);
>         struct kunit_attributes attr;
>         int (*param_init)(struct kunit *test);
>         void (*param_exit)(struct kunit *test);
> @@ -1691,7 +1692,8 @@ do {                                                                             \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
> -       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       static const void *name##_gen_params(struct kunit *test,                                \
> +                                            const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> @@ -1712,7 +1714,8 @@ do {                                                                             \
>   * Define function @name_gen_params which uses @array to generate parameters.
>   */
>  #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                       \
> -       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       static const void *name##_gen_params(struct kunit *test,                                \
> +                                            const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index c2871180edcc..fc76648525ac 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
>   * The thread counts are chosen to cover potentially interesting boundaries and
>   * corner cases (2 to 5), and then stress the system with larger counts.
>   */
> -static const void *nthreads_gen_params(const void *prev, char *desc)
> +static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
>  {
>         long nthreads = (long)prev;
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 49a5e6c30c86..01b20702a5a2 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -695,7 +695,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         /* TODO: Make generate_params try-catch */
> -                       curr_param = test_case->generate_params(NULL, param_desc);
> +                       curr_param = test_case->generate_params(&test, NULL, param_desc);
>                         test_case->status = KUNIT_SKIPPED;
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>                                   "KTAP version 1\n");
> @@ -726,7 +726,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 /* Get next param. */
>                                 param_desc[0] = '\0';
> -                               curr_param = test_case->generate_params(curr_param, param_desc);
> +                               curr_param = test_case->generate_params(&test, curr_param,
> +                                                                       param_desc);
>                         }
>                         /*
>                          * TODO: Put into a try catch. Since we don't need suite->exit
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>

--0000000000005e7f70063c3ba3ee
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
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgw7nxmuKnKaeR0kkJTUffnsCXS5JE
MAgGzlNpM9TFfx4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODEzMDkxODIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEADv+tDg/z7tnMjVXygi+J+uL9zSBr602XaDevtiAzwcrKWf4jNBwz9WCazBes8RUQ
9Q2h+LsfMF5oso2VSFMHuZ5ShNPpoR0457zN+zUVOA43r6vtuAEVbUEJIY58U1bFexmeezBwn/yT
KYWbJKDwFCvgRWmv3PhKeYgL9ewltUwgJBOovFSPSg9u3/E0oBjarCG3G7BCxeU/vV5gQImVQ2zt
BRWVzdfrKLK3jzpkYb+ETNzQ3dju/5BCqFnDibkeidwzwN5gwvl6+uCSoNrBmiRcpqI9ofi8RAAs
vpZjKhPpVMxSPcYNYJiv419Q6D7vMTZT7hr6CuHMpM98/CHmGA==
--0000000000005e7f70063c3ba3ee--

