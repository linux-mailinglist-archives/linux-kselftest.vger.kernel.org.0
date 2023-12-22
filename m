Return-Path: <linux-kselftest+bounces-2360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3B81C7C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C837DB23CE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E3FBF2;
	Fri, 22 Dec 2023 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHn5cdJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B911722
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso7996a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703239373; x=1703844173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j7/Oi3tI525anaRrPaRV5DJJfJ5Kdh2Xgg3OcXG0oQ8=;
        b=cHn5cdJipnU4WJEdxq4Eg6Vzy0MhOQ+jRbzjd6gnaf436iPU3WFlT0/OG55JGEkQQh
         EK+94nzyKaPKGWba7ZvF9gWYDW6sGQfHHp1P5+DB4vTHjnk0udLyiqJ6XjQSUDKYe3yc
         hAf4GPxPWj9mBPY0wB4Ub8Wf5DeixrCgcHLTl6nhMj6TUHClP75nRoVX88FUVGyYCPA9
         wrja5c7o/t0qG+s1JES7WYUZA5RVVp/kquwAMkCyuS50oGu/roKAmhwUCtqV6nypGfMs
         bpE7u2WYpKg75X62ztkBspDN0ggNDa+Mvc3HXmLh9pD9Hk34FxLA70rxevSWUm2ymswq
         WLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239373; x=1703844173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7/Oi3tI525anaRrPaRV5DJJfJ5Kdh2Xgg3OcXG0oQ8=;
        b=nlYVDDvEnOXYBiX97nskzg4WiQWcFulYDClZf2tf/zxZU3efOuaYOITITwkGfOa+5t
         GYjr73IsHB4UqjnlQKECCKEORPGdThNEeiw2DYE+6kpe/ogmbEw5bBO/PjSZ6UPStfY2
         CbbqVgSmOqgjseYogYjz+uPkyr0/f3E66/M4Fl9sY441AsDO5WSAR8sHaDzIoqrIq/JW
         +JAwIHjhHCEywE6Qg2RPC+/arpt4OOxOAQiyv6ZCfm3k1dffyQJhJgj2BhAZ7tWH6EIs
         WkI4mgJY6iGiAyLl4aiZFkAvCDzNU593Nd8fbX6xCnZ//sOHJ+ehrlceETNlDYphKoLQ
         1+Pw==
X-Gm-Message-State: AOJu0YzEG6LDZuKnIAnc7OV07oWzeUFOZNiw5cWuq76fU0PFh03VVrdx
	RrMpJpc+ZX6jarXUOOwl/fsSo0KPrNrmhwHa+pJ05u11B6lR
X-Google-Smtp-Source: AGHT+IEXpB4bASwU+AeX83LWmVI+uoMd1meAzSMQNKte4KFKHAUrVk+lPdSnZxhsGZseAGm1RjPKsigIkYLsSriiU9E=
X-Received: by 2002:a50:c318:0:b0:551:9870:472 with SMTP id
 a24-20020a50c318000000b0055198700472mr71635edb.1.1703239373095; Fri, 22 Dec
 2023 02:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151952.415232-1-benjamin@sipsolutions.net> <20231220151952.415232-2-benjamin@sipsolutions.net>
In-Reply-To: <20231220151952.415232-2-benjamin@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Dec 2023 18:02:39 +0800
Message-ID: <CABVgOSkTCk4WRstLM+pKQeKRtPYPCOE_LCV9GfoRVdZLfW1Zaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add parameter generation macro using
 description from array
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d505ab060d1651c3"

--000000000000d505ab060d1651c3
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 23:20, <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> The existing KUNIT_ARRAY_PARAM macro requires a separate function to
> get the description. However, in a lot of cases the description can
> just be copied directly from the array. Add a second macro that
> avoids having to write a static function just for a single strscpy.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

I'm generally pretty happy with this, though note the checkpatch warning below.

There was some discussion at plumbers about expanding the
parameterised test APIs, so we may need to adjust the implementation
of this down the line, but I don't think that'll happen for a while,
so don't worry.

With the warnings fixed, this is:

Reviewed-by: David Gow <davidgow@google.com>

I'm okay with this going in via the wireless tree if that's easier;
certainly there are some conflicts with the later patches in this
series and the kunit one.

Cheers,
-- David

>  Documentation/dev-tools/kunit/usage.rst | 12 ++++--------
>  include/kunit/test.h                    | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index c27e1646ecd9..b959e5befcbe 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -566,13 +566,9 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 },
>         };
>
> -       // Need a helper function to generate a name for each test case.
> -       static void case_to_desc(const struct sha1_test_case *t, char *desc)
> -       {
> -               strcpy(desc, t->str);
> -       }
> -       // Creates `sha1_gen_params()` to iterate over `cases`.
> -       KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
> +       // Creates `sha1_gen_params()` to iterate over `cases` while using
> +       // the struct member `str` for the case description.
> +       KUNIT_ARRAY_PARAM_DESC(sha1, cases, str);
>
>         // Looks no different from a normal test.
>         static void sha1_test(struct kunit *test)
> @@ -588,7 +584,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
>         }
>
>         // Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
> -       // function declared by KUNIT_ARRAY_PARAM.
> +       // function declared by KUNIT_ARRAY_PARAM or KUNIT_ARRAY_PARAM_DESC.
>         static struct kunit_case sha1_test_cases[] = {
>                 KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
>                 {}
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..2dfa851e1f88 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1514,6 +1514,25 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * KUNIT_ARRAY_PARAM_DESC() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + * @desc_member: structure member from array element to use as description
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                       \
> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       {                                                                                       \
> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \

checkpatch is complaining here:
ERROR: need consistent spacing around '*' (ctx:WxV)
#71: FILE: include/kunit/test.h:1528:

+               typeof((array)[0]) *__next = prev ? ((typeof(__next))
prev) + 1 : (array);      \

> +               if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> +                       strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);              \
> +                       return __next;                                                          \
> +               }                                                                               \
> +               return NULL;                                                                    \
> +       }
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20231220151952.415232-2-benjamin%40sipsolutions.net.

--000000000000d505ab060d1651c3
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDW
4vYEd8v0042ei770NxzMataVgaFtO2oPKcGWWtAl/DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjIxMDAyNTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjADBL7oQOjKfwWKy0gPF
ZgiN7FfscrwdTSWTBGcv3wobTyYV26DoP9BfiS22ACUgz+vpAup1jEFKYF5k1plflk8WinmmVKNw
+0W4Xufa/SeaZyAPkiYb1RGC9IAvOTa6Z2t/phSXIck2yLhnGkoRuL8ApVB4dR3kIrInItuIPs0E
MRBLAWsmXpNHi1NS1y88IRY5m+pJ7m9ZkL27eYkuQ6Nl44WhZRv58wkbr2gm+1zi8Bq8eA3zvViU
LpCnB3QAsRMR8FDTQ+dECeu9MdFXjtmPKhvGJYGKjrYVGskeTFKwXtYvjyxR4+pTT+26J8FsXbPd
DFP0OYqlCeKrVTX0ZA==
--000000000000d505ab060d1651c3--

