Return-Path: <linux-kselftest+bounces-9185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002268B86C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 10:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8056E284C69
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544E4EB38;
	Wed,  1 May 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhWP+ezp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF734DA04
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550907; cv=none; b=L+xfs2EwPw0V1Wbr02IDNy1veZbcZCrQD7ARr0yjStfPUjcZJn7BwoCJioXF7DZxonfl9CX6vmjwAUVgipb9vNCKEqHg9CQmpM5PJLh7do0ABFUF5r5AeAukmlPWWfKqfpT7EFbcF+kzAmmpIj/pikMWCsFB6+y2+p2AomWG3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550907; c=relaxed/simple;
	bh=kdTEdZhBGpR6R956btKwPrX5XpSP042g1fN6G/dcNHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3R65PxOMq8d94NMxgIdMrEbA5Q4bHf164qO2QNjJ5RzsDjsTNXOd837s9I/PjMYlducN3eHof8X5xfcvts5ts7GzJ7kYEWL1btGsFR9zZYVjF5KgGYRxbyyaSrKnLfVegpKpSfvRKnGn2anRrHG6VbymMu/2oMUsjbEScVhKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhWP+ezp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43989e6ca42so187191cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714550903; x=1715155703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYc2QYpMBeh0s7JyV0icMbpQ6M0/S5GZhziFyB/tQcQ=;
        b=ZhWP+ezpI633+AlH/Zr1R6A/gywYKsHHWB8Lq/mszfmrKw7TIGDJGyA2eOjcL1cNoT
         FS2I/S2C1wc0ADj8sXFAIb+Z0UpPy/RbN3LLif5yozgQ0ieBchebJotUYOj+To4O4Ttp
         ToN/SKUF8/jzmQOEsZR5tlblJj80ur0EDVJwjvj23jL/yes2LluIEuEBL9vB4xB6f8Zh
         Ws4EoP4szYz6B2sAWB9zAamxUVPysHVkA9U+MWH60wCCT0C4kfGc3pfVVSI0LARE203e
         RMfJzGQT+8yqjlQBN+qlS2Y5ODdeouVqMeP3r9ggBSzFTFRNaC9ywMHeqezv8BDqEC1+
         oiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714550903; x=1715155703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYc2QYpMBeh0s7JyV0icMbpQ6M0/S5GZhziFyB/tQcQ=;
        b=pepJ2wcDiQP0Hcf1+OjwHLJgKU2+QzrLmjwb3rQhruoAANcrUecGxvuFmu3dYUt/FE
         pkl99cA7gM3OTHHVJxK+4Wnkn251uGwXDn3hrzBSKvzk55Oxlmd9zj9CJ4QkvlM11fKQ
         Gf7P8p5FiCK/5GQyXPPMSGX1pvk/B1UbQlfM0SZE83K6W6LNkjj3lkAyRWPlEiHrDa/E
         zn5hD+17ME49cpjd8NNlSdpjbeS+36FD7J5WZCHq4AYM5oH2AJjMbxgn0N7J72ilBZmG
         t9Zxzm9cDPsJdcdr8PMjXGq5lLwhL5FRpIIyfSwsSCTR/TZyxSGvLc5Awv5N9wANmSnb
         eTHw==
X-Forwarded-Encrypted: i=1; AJvYcCWe0X78eNhD3meRJsFC/0ml7hOsC5Z2W/veXTGM6WcS4/GsD/jZXyj7RZ8QW4AsV4rZYQdCi+7+KHIPU0IcQQOQ9LNg4AG6KbEPQ4/Acp0u
X-Gm-Message-State: AOJu0YxvoJuKDdIzEMhu7WLnSTSuM5EVZaX0lugvVU16KA+Xgfv24rwd
	hixudNfjrsH20hZcgDsx23Bg23u9QbY0CibXFm0S569fvYIh5GlRvQdgR/qOI8VCEu1c5ktwy/V
	OxQzfAU3A7LY3yJct07XnGg+HJNUCBxB33YdK
X-Google-Smtp-Source: AGHT+IFiINPh/pP6LprotN6w/s9YJNbbitC9Jw4wClFiGPlvs5yiKfaRZ7Ar5V1Tg4hR0wAbLNOpBluEHG/yAW9HY64=
X-Received: by 2002:ac8:5d02:0:b0:43a:b186:634d with SMTP id
 f2-20020ac85d02000000b0043ab186634dmr197663qtx.10.1714550902641; Wed, 01 May
 2024 01:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422232404.213174-1-sboyd@kernel.org>
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Wed, 1 May 2024 16:08:11 +0800
Message-ID: <CABVgOSmgUJp3FijpYGCphi1OzRUNvmYQmPDdL6mN59YnbkR2iQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008776c506175ffd22"

--0000000000008776c506175ffd22
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 07:24, Stephen Boyd <sboyd@kernel.org> wrote:
>
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading device tree overlays onto the live DTB
> along with probing platform drivers to bind to device nodes in the
> overlays. With this series, we're able to exercise some of the code in
> the common clk framework that uses devicetree lookups to find parents
> and the fixed rate clk code that scans device tree directly and creates
> clks. Please review.
>
> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they all build
> upon each other. Or the DT part can be merged through the DT tree to
> reduce the dependencies.
>
> Changes from v3 (https://lore.kernel.org/r/20230327222159.3509818-1-sboyd@kernel.org):
>  * No longer depend on Frank's series[1] because it was merged upstream[2]
>  * Use kunit_add_action_or_reset() to shorten code
>  * Skip tests properly when CONFIG_OF_OVERLAY isn't set
>
> Changes from v2 (https://lore.kernel.org/r/20230315183729.2376178-1-sboyd@kernel.org):
>  * Overlays don't depend on __symbols__ node
>  * Depend on Frank's always create root node if CONFIG_OF series[1]
>  * Added kernel-doc to KUnit API doc
>  * Fixed some kernel-doc on functions
>  * More test cases for fixed rate clk
>
> Changes from v1 (https://lore.kernel.org/r/20230302013822.1808711-1-sboyd@kernel.org):
>  * Don't depend on UML, use unittest data approach to attach nodes
>  * Introduce overlay loading API for KUnit
>  * Move platform_device KUnit code to drivers/base/test
>  * Use #define macros for constants shared between unit tests and
>    overlays
>  * Settle on "test" as a vendor prefix
>  * Make KUnit wrappers have "_kunit" postfix
>
> [1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com
> [2] https://lore.kernel.org/r/20240308195737.GA1174908-robh@kernel.org
>

Thanks very much. I'm about halfway through reviewing these, and I
like them a lot so far.

Most of my thoughts are just naming ideas. I fear some of them may be
the reverse of previous suggestions, as we've since landed the KUnit
device wrappers in include/kunit/device.h, which we decided would live
as part of KUnit, not as part of the device infrastructure. I don't
enormously mind if we make the opposite decision for these, though it
does seem a bit inconsistent if we do 'devices' differently from
'platform_devices'. Thoughts?

The other thing I've noted so far is that the
of_apply_kunit_platform_device and of_overlay_apply_kunit_cleanup
tests fail (and BUG() with a NULL pointer) on powerpc:
> [15:18:51]     # of_overlay_apply_kunit_platform_device: EXPECTATION FAILED at drivers/of/overlay_test.c:47
> [15:18:51]     Expected pdev is not null, but is
> [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
<...>
> [15:18:51]     # of_overlay_apply_kunit_platform_device: try faulted: last line seen lib/kunit/resource.c:99
> [15:18:51]     # of_overlay_apply_kunit_platform_device: internal error occurred preventing test case from running: -4
> [15:18:51] [FAILED] of_overlay_apply_kunit_platform_device

> [15:18:51] BUG: Kernel NULL pointer dereference at 0x0000004c
> [15:18:51] note: kunit_try_catch[698] exited with irqs disabled
> [15:18:51]     # of_overlay_apply_kunit_cleanup: try faulted: last line seen drivers/of/overlay_test.c:77
> [15:18:51]     # of_overlay_apply_kunit_cleanup: internal error occurred preventing test case from running: -4
> [15:18:51] [FAILED] of_overlay_apply_kunit_cleanup

I've not had a chance to dig into it any further, yet, but it appears
to work on all of the other architectures I tried.

Otherwise, I think this would be fine to take via either the clk or DT
and clk trees: there are no conflicts with the current KUnit changes
for 6.10. At worst, we might hit some conflicts in the documentation,
but there's nothing scheduled yet.

Cheers,
-- David

> Stephen Boyd (10):
>   of: Add test managed wrappers for of_overlay_apply()/of_node_put()
>   dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
>   dt-bindings: test: Add KUnit empty node binding
>   of: Add a KUnit test for overlays and test managed APIs
>   platform: Add test managed platform_device/driver APIs
>   dt-bindings: kunit: Add fixed rate clk consumer test
>   clk: Add test managed clk provider/consumer APIs
>   clk: Add KUnit tests for clk fixed rate basic type
>   dt-bindings: clk: Add KUnit clk_parent_data test
>   clk: Add KUnit tests for clks registered with struct clk_parent_data
>
>  Documentation/dev-tools/kunit/api/clk.rst     |  10 +
>  Documentation/dev-tools/kunit/api/index.rst   |  21 +
>  Documentation/dev-tools/kunit/api/of.rst      |  13 +
>  .../dev-tools/kunit/api/platformdevice.rst    |  10 +
>  .../bindings/clock/test,clk-parent-data.yaml  |  47 ++
>  .../bindings/test/test,clk-fixed-rate.yaml    |  35 ++
>  .../devicetree/bindings/test/test,empty.yaml  |  30 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/base/test/Makefile                    |   3 +
>  drivers/base/test/platform_kunit-test.c       | 140 ++++++
>  drivers/base/test/platform_kunit.c            | 174 +++++++
>  drivers/clk/.kunitconfig                      |   2 +
>  drivers/clk/Kconfig                           |   9 +
>  drivers/clk/Makefile                          |   9 +-
>  drivers/clk/clk-fixed-rate_test.c             | 377 +++++++++++++++
>  drivers/clk/clk-fixed-rate_test.h             |   8 +
>  drivers/clk/clk_kunit.c                       | 198 ++++++++
>  drivers/clk/clk_parent_data_test.h            |  10 +
>  drivers/clk/clk_test.c                        | 451 +++++++++++++++++-
>  drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
>  drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
>  drivers/of/.kunitconfig                       |   1 +
>  drivers/of/Kconfig                            |  10 +
>  drivers/of/Makefile                           |   2 +
>  drivers/of/kunit_overlay_test.dtso            |   9 +
>  drivers/of/of_kunit.c                         |  99 ++++
>  drivers/of/overlay_test.c                     | 115 +++++
>  include/kunit/clk.h                           |  28 ++
>  include/kunit/of.h                            |  94 ++++
>  include/kunit/platform_device.h               |  15 +
>  30 files changed, 1967 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
>  create mode 100644 Documentation/dev-tools/kunit/api/of.rst
>  create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
>  create mode 100644 Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
>  create mode 100644 Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
>  create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml
>  create mode 100644 drivers/base/test/platform_kunit-test.c
>  create mode 100644 drivers/base/test/platform_kunit.c
>  create mode 100644 drivers/clk/clk-fixed-rate_test.c
>  create mode 100644 drivers/clk/clk-fixed-rate_test.h
>  create mode 100644 drivers/clk/clk_kunit.c
>  create mode 100644 drivers/clk/clk_parent_data_test.h
>  create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
>  create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
>  create mode 100644 drivers/of/kunit_overlay_test.dtso
>  create mode 100644 drivers/of/of_kunit.c
>  create mode 100644 drivers/of/overlay_test.c
>  create mode 100644 include/kunit/clk.h
>  create mode 100644 include/kunit/of.h
>  create mode 100644 include/kunit/platform_device.h
>
>
> base-commit: 4cece764965020c22cff7665b18a012006359095
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>

--0000000000008776c506175ffd22
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
hvcNAQkEMSIEIDLIZUOSGseHFPa4KOa5nTFl9McUHsPER0iHzhbSDkZeMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwMTA4MDgyM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAbJSBr
80vU9swNMdH+wZzsFJ9+wyNYgyl8JWyTxiF3nnndMnz8BD8ZdMqSZVltOmF4gSTZ3A9VfiQsgXuZ
DAP1kHbNCwDFtZkzxA6BkiG0tFBcnI3E4SzQ3k4PNvqlVoeXCxFbBynxo9BaZD/565qd0cS2x47M
G+VMG+8utmxaCStTLcrvcmXyV3qM92jNKDaPQSQhc369PEY4nU87CuoMRhPn0yWNdPMXHLaMRacW
yYc5cUycAiDF2iA4sPktFOKO90/v3IvVe2d08Xj/NjeOmfCLEoZLXIXi3VbYsT0DV7GozdgRye0A
1dr9GllgBnDt7IdN4sOgNQF6q/yqlPwr
--0000000000008776c506175ffd22--

