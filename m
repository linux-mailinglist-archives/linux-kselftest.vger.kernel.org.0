Return-Path: <linux-kselftest+bounces-3058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE382E904
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 06:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F41F23B6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F610A05;
	Tue, 16 Jan 2024 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2e3Lm4kw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B111188
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jan 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso20775a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 21:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705381405; x=1705986205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8z4wNXPMjXDXpFDffX0gXVj2Xv7Raa79rf9RtvGfsdA=;
        b=2e3Lm4kwFYvdcP88sPzaGOOcDIdu8YSfSRlM4LvJl3viHzXWf9tFP3D5MCDMtz07w5
         oJV957mK3qTlmDmYG+ZmO013tPZkW/WE6hRfc9FNfh+WmEpcj9ktRRobSUQe+zHOJXj1
         Fa1br4ekoQzi4I5QD9sIUd8EHoQlhFl7CXVI2bG95DpTm2rGyeEiweh1Yw6bNxn4xhNx
         wtB3h9mamnpTSMQXwOOuJ5U5LqAGv8kHDACW5D8aSuZUZDWCAdKSoxEvFvqeFfEBs/zW
         N6w0aqY8efm0gvoIj0FMFLuYkB9nlmSGsDBTgqftWf1t0NTaW0oV68YtwcEANICxHmsC
         GUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705381405; x=1705986205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z4wNXPMjXDXpFDffX0gXVj2Xv7Raa79rf9RtvGfsdA=;
        b=BFwh7SYjwQfqYubSjhLEjtZfBwtQ9Cc0QlhqbV8gRWJzLjiZ4Zx8Lf0E+OjJs3i9WR
         MeN8PzbZEaXvITDmLltbNS4RyXWMHw+EfDVcpeVIXZKWYPZcCaBBB3K/FX7dQM53zZHI
         MJRVIJM/BxtriLPFMOcB2sd/vP24BhTL4pTdluHNkhYT0+TBZTK8V208aP2Uk+OLatcg
         EFGHeNGWr3G9KfasFZhDR26gB0oDHDLUg+Mmpji/vCMMtTZnUeGZjzbcc3sSflOxINfr
         8XjGksppuvmswK0ZJV0Hp43mIdpfSOgJK7Jq6kCG2l2U/ZC9S7bcWZCywakW+9xn4iRB
         pHZg==
X-Gm-Message-State: AOJu0YwCJmTlZL8ILrj9BvLRVcmGrihOmxWSNZDJBk+Awb/ICuG50zPJ
	oqcNGpK0+RXSqx7O+H45cugu4NIE4K8L7l/SdnHjo1bOYpoq
X-Google-Smtp-Source: AGHT+IFq7VbLb5Vx+XX8Et3HFDm04nnkzR+kMJiJlapv3AECv/E9KKeEcbQL5955erPk2myGTtrN/KbsbMZBTJNjkAQ=
X-Received: by 2002:a05:6402:278e:b0:558:7f0f:aa70 with SMTP id
 b14-20020a056402278e00b005587f0faa70mr322200ede.5.1705381404947; Mon, 15 Jan
 2024 21:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-7-sboyd@kernel.org>
In-Reply-To: <20240112200750.4062441-7-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 16 Jan 2024 13:03:12 +0800
Message-ID: <CABVgOSkymMzaOFtJ-6OuVaB4i4zoVafPMqssA=GHByMJ9VTsKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000def2dd060f090c1c"

--000000000000def2dd060f090c1c
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 04:07, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> root node, and that the of_have_populated_dt() API works properly.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

I won't pretend to be a devicetree expert, but this looks good to me
from a KUnit point of view, and passes comfortably here.

checkpatch seems to have one complaint about the kconfig help text.
Personally, I think the brief description is fine.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/of/.kunitconfig |  3 ++
>  drivers/of/Kconfig      |  9 ++++
>  drivers/of/Makefile     |  2 +
>  drivers/of/of_test.c    | 98 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 112 insertions(+)
>  create mode 100644 drivers/of/.kunitconfig
>  create mode 100644 drivers/of/of_test.c
>
> diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
> new file mode 100644
> index 000000000000..5a8fee11978c
> --- /dev/null
> +++ b/drivers/of/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_OF=y
> +CONFIG_OF_KUNIT_TEST=y
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 9628e48baa15..a527ba8451d9 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -37,6 +37,15 @@ config OF_UNITTEST
>
>           If unsure, say N here. This option is not safe to enable.
>
> +config OF_KUNIT_TEST
> +       tristate "Devicetree KUnit DTB Test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option builds KUnit unit tests for device tree infrastructure.
> +
> +         If unsure, say N here, but this option is safe to enable.
> +

FYI:
WARNING: please write a help paragraph that fully describes the config symbol
#111: FILE: drivers/of/Kconfig:40:

>  config OF_ALL_DTBS
>         bool "Build all Device Tree Blobs"
>         depends on COMPILE_TEST
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index df305348d1cb..251d33532148 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -19,4 +19,6 @@ obj-y += kexec.o
>  endif
>  endif
>
> +obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
> +
>  obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
> new file mode 100644
> index 000000000000..7609ad3081b9
> --- /dev/null
> +++ b/drivers/of/of_test.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for OF APIs
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <kunit/test.h>
> +
> +/*
> + * Test that the root node "/" exists.
> + */
> +static void dtb_root_node_found_by_path(struct kunit *test)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_node_by_path("/");
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
> +       of_node_put(np);
> +}
> +
> +/*
> + * Test that the of_root global variable is always populated when DT
> + * code is enabled.
> + */
> +static void dtb_root_node_populates_of_root(struct kunit *test)
> +{
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_root);
> +}
> +
> +static struct kunit_case dtb_test_cases[] = {
> +       KUNIT_CASE(dtb_root_node_found_by_path),
> +       KUNIT_CASE(dtb_root_node_populates_of_root),
> +       {}
> +};
> +
> +/*
> + * Test suite to confirm a live DTB is loaded.
> + */
> +static struct kunit_suite dtb_suite = {
> +       .name = "dtb",
> +       .test_cases = dtb_test_cases,
> +};
> +
> +/*
> + * Test that calling of_have_populated_dt() returns false when
> + * the OF_EMPTY_ROOT flag isn't set.
> + */
> +static void of_have_populated_dt_false_when_flag_set(struct kunit *test)
> +{
> +       bool was_set;
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
> +
> +       was_set = of_node_test_and_set_flag(of_root, OF_EMPTY_ROOT);
> +       KUNIT_EXPECT_FALSE(test, of_have_populated_dt());
> +
> +       if (!was_set)
> +               of_node_clear_flag(of_root, OF_EMPTY_ROOT);
> +}
> +
> +/*
> + * Test that calling of_have_populated_dt() returns false when
> + * the OF_EMPTY_ROOT flag isn't set.
> + */
> +static void of_have_populated_dt_true_when_flag_clear(struct kunit *test)
> +{
> +       bool was_set;
> +
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, of_root);
> +
> +       was_set = of_node_check_flag(of_root, OF_EMPTY_ROOT);
> +       of_node_set_flag(of_root, OF_EMPTY_ROOT);
> +       KUNIT_EXPECT_FALSE(test, of_have_populated_dt());
> +
> +       if (was_set)
> +               of_node_set_flag(of_root, OF_EMPTY_ROOT);
> +}
> +
> +static struct kunit_case of_have_populated_dt_test_cases[] = {
> +       KUNIT_CASE(of_have_populated_dt_false_when_flag_set),
> +       KUNIT_CASE(of_have_populated_dt_true_when_flag_clear),
> +       {}
> +};
> +
> +/*
> + * Test suite to confirm behavior of of_have_populated_dt().
> + */
> +static struct kunit_suite of_have_populated_dt_suite = {
> +       .name = "of_have_populated_dt",
> +       .test_cases = of_have_populated_dt_test_cases,
> +};
> +
> +kunit_test_suites(
> +       &dtb_suite,
> +       &of_have_populated_dt_suite,
> +);
> +MODULE_LICENSE("GPL");
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--000000000000def2dd060f090c1c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIF5Vy+zqzLJitGDzEQRfVFjMHVpx+ZUPxyQRM1FeGTkwMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDExNjA1MDMyNVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCVaUCH
XfmYMeODo5JZpU50v99amHLDvgIqPC7RgcmIqGA7mlLr2Ca1MLtJ6HOuvgGPdB17l+eB4FgokitW
Q02/TebwvxvpIJxwkfJqpZ0bz+ZjD3kG93gzknNqub7uR8KbmO4kM8KcTVkFL3/SyuBPT+70cklA
4Xnw7n7PO/eUzs9dkMq0rPeB/Ies6gziPCeWU343wHwAB65SVP8LKNmavsKY0mH7oqsB1IGmLkWh
p9h6Yk8AaFyfcnBLCBGyflSg3MGwGpHQ9t0MlymEPaxjC0hjXfC+5uj4hq7x2DQiSQtoNZWklK5A
fFiy552KwIP90P3NIuPw5nLK5atUzJfl
--000000000000def2dd060f090c1c--

