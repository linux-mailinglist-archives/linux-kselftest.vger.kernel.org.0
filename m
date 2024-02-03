Return-Path: <linux-kselftest+bounces-4070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545CD8480C0
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 05:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3DD28B223
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 04:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9107B18637;
	Sat,  3 Feb 2024 04:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOmC2Efc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA08F9D7
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Feb 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933434; cv=none; b=Qi18XgEuXqjuarM7HMf0JZPm3A4bpJFiNsGASWf6X8T0t1NqOGclyRorBkuomLJHR56TSniYJsnxG4ItdUdf0FBRqxXXVukEN47us7tEesymuUf5YX8ShaIW1kUBLQhhWR0l6849DrXe551L+rqMvRxDuUL1G8XyYQiO29eeWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933434; c=relaxed/simple;
	bh=d5CjbtPQ8VfUcPDpfRj/cgKZEAsQHvK8DOreEsPZBTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZFjYzMZtCeexzzsslIp+jLd2EJc14iX8iayTtZo+2/nqvpsxa/E/S4FGO/MKWzLkpebHZ3ecHpmM6CO4xjFa94dhMqlVGb3QgmSqXX+KGQT67zyfVqqS7QfDjK/ZX1POtdWM3Kal8K7SKOo+Rv6UNYZZndVQ3lMiEPj4p5Q9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOmC2Efc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso3180a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 20:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706933430; x=1707538230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw9cmO7yhdCfljr5IxNeXN409pIZg3FwxP5CB28+rgg=;
        b=TOmC2EfcbrtfBRDUAlKXUS9fibX1QhGAttpthLNA4dCFw0X9bI7cqMxbGDEGhR1FNk
         SiJTClFCQ/jQlIDivocCpwcVvLOy75SsXl6KCc44yYud0Rw7OLB618uMrcTs81gf4aKt
         pX7aLJSlQB0+02P7spOba99mZzZ6X5RpD8LvntqqMIpuZHC3/T1kVjk2ZPYf0RBqhsm2
         0cklCQcsxQVwV31nWPZdBlUFXMRasQvstX9uekl384eQJN/vw7BKrGvhOamddQ5X2gHK
         sFVm3GUPbK68lhsTOsSxhCEqEl+nCqElSpRuZSpGnHit10hdk9+ASPeqf+KHR4E6XyeG
         V2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706933430; x=1707538230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw9cmO7yhdCfljr5IxNeXN409pIZg3FwxP5CB28+rgg=;
        b=Zx4IWOVUGBThKKm7Q4WGrnziIAnzcwbOGV3G5X9jC2R9ptOLEL2jA3RcjGhP7jZzNL
         vaNjbJ9sXqO0gCNe+eZK0WsNVwG9N4gUn1p+MSr7nCH5qynjXZP3KMEn3+sXIllRJ5h/
         S7ygPf5Qwn602O7CM1/Os86Z+dsqSdF/ee3a0wRP8t0xSzEYiTbjf980OboedSSM0TrJ
         wV5E0b7Z0WFujS5BDl5iT9bhiY7qCHcjLJVI7tFzj9sZfOXvkWzrClfbjlZrFW3UgHvg
         578xqPuVwTATIRKGgTpopUtVDDMoWPSpsmHJcTUeqB1To6WDIPpQGnNK1le1jOJ1wFaw
         9+/A==
X-Gm-Message-State: AOJu0YwRE8kTGTNuzDn7w8g3X/9e0D7bJTmNBiIlAn2duvP8krU9mm10
	LBd/O++ON46iJRmPyIx4MTXAKe9ByHfRdGwiL5IoUUaJ4p3rloU9uiRESj5ypKqwE7Pz56sD87E
	+gZHAVDDSEugbPGaBrXq+hCBffa1brEi+T97T
X-Google-Smtp-Source: AGHT+IG5lHPH49Ul4a7Msn5xJyxeIzakvenV7mNOmK2iTsRmvusCSk+vNETjzCfLqnIO58J7ejlduAElZZDzykkqdTc=
X-Received: by 2002:a50:9996:0:b0:55f:e704:85ce with SMTP id
 m22-20020a509996000000b0055fe70485cemr48388edb.3.1706933430442; Fri, 02 Feb
 2024 20:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org>
In-Reply-To: <20240202195909.3458162-8-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Sat, 3 Feb 2024 12:10:17 +0800
Message-ID: <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, 
	Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cd1a2e06107268db"

--000000000000cd1a2e06107268db
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
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

This looks pretty good to me test-wise, though it still fails on m68k.
(Everything else I tried it on works, though I've definitely not tried
_every_ architecture.)

aarch64: PASSED
i386: PASSED
x86_64: PASSED
x86_64 KASAN: PASSED
powerpc64: PASSED
UML: PASSED
UML LLVM: PASSED
m68k: FAILED
> $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmlinux -append 'kunit.enable=1 console=hvc0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -machine virt
> [11:55:05] ===================== dtb (2 subtests) =====================
> [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at drivers/of/of_test.c:18
> [11:55:05] Expected np is not null, but is
> [11:55:05] [FAILED] dtb_root_node_found_by_path
> [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at drivers/of/of_test.c:28
> [11:55:05] Expected of_root is not null, but is
> [11:55:05] [FAILED] dtb_root_node_populates_of_root
> [11:55:05]     # module: of_test
> [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> [11:55:05] ======================= [FAILED] dtb =======================


My only other question is about the test names: the mix of 'of' and
'dtb' can be a bit confusing. As is, we have:
kconfig name: OF_KUNIT_TEST
module name: of_test
suite name: dtb
test names: all start with dtb_

Given KUnit only really deals with the suite/test names directly, it's
not trivial to see that 'dtb.dtb_*' is controlled by OF_KUNIT_TEST and
in of_test if built as a module. (This is getting a bit easier now
that we have the 'module' attribute in the output, but still.)

Would 'of_dtb' work as a suite name if it's important to keep both
'of' and 'dtb'?

In general, though, this test looks good to me. Particularly if m68k
can be fixed.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/of/.kunitconfig |  3 +++
>  drivers/of/Kconfig      |  9 ++++++++
>  drivers/of/Makefile     |  2 ++
>  drivers/of/of_test.c    | 48 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
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
> index 17733285b415..53d1b5dd89e8 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -37,6 +37,15 @@ config OF_UNITTEST
>
>           If unsure, say N here. This option is not safe to enable.
>
> +config OF_KUNIT_TEST
> +       tristate "Devicetree KUnit Test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option builds KUnit unit tests for device tree infrastructure.
> +
> +         If unsure, say N here, but this option is safe to enable.
> +
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
> index 000000000000..71a767b42b43
> --- /dev/null
> +++ b/drivers/of/of_test.c
> @@ -0,0 +1,48 @@
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
> + * Test that the root node "/" can be found by path.
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
> + * Test that the 'of_root' global variable is always populated when DT code is
> + * enabled.
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
> + * Test suite to confirm a DTB is loaded.
> + */
> +static struct kunit_suite dtb_suite = {
> +       .name = "dtb",
> +       .test_cases = dtb_test_cases,
> +};
> +
> +kunit_test_suites(
> +       &dtb_suite,
> +);
> +MODULE_LICENSE("GPL");
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240202195909.3458162-8-sboyd%40kernel.org.

--000000000000cd1a2e06107268db
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
hvcNAQkEMSIEIKLjezo2IKSo5FfYtp1eRxpiN5V5i3G0d8t3y9vBvKLwMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIwMzA0MTAzMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQARpAOB
Mv548MzSDNmJQF0ICR6huDtIxOQ88M/tS4pn7mNjhw9h58kxbRFfnMaNPbzFEG2XtH0mmudcBVEe
m7/cSSqkPlP6moi+Hd5MibjTPhNcoqw7s33g+1Fe+JfF6tFbMXxRYXMby/svxPHL8bfuad7UgKJS
Uoef00mfw06s3WGVmpFqqeep51ZLJQ6KS4HN+SKCCneUN+JRdjQq71Zc8JpWvJGa3OFUSMO2B5Sr
u4v7Fb296fdiPzbajB++zkDzol54YDvcdJRBd6zS5CyQHqp4mWUWRXJ6Hdys+xy1qLy4vckr/VY8
AMCb3km9hOiEQXDh1NDV0qz+5/0f1q0h
--000000000000cd1a2e06107268db--

