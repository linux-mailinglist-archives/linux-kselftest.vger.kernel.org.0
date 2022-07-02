Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC3563E8A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jul 2022 06:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiGBEph (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Jul 2022 00:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGBEpd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Jul 2022 00:45:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD9B2B250
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Jul 2022 21:45:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso4793241wma.2
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Jul 2022 21:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/cQHF+uqJiGHFhmYkPsuazFNDrycoxI7X+fh6O11aU=;
        b=UcLVg0pIoEbz4U8XKFtQKvxXpH3k/RCK4hcTCage+3Pd4gdHB8znRh5iGZ+6V2Vi09
         KxwwjF1otHmiFWl6bAAKK8OR1MrDQR5/kObGt6HsySbp/4nOSbRspIdcfR1J3nJimGpU
         Qx7mEvlU2QFq05/QGAxLlgeDloIr3xoswBu6YQvaAGr1IKRZpEiLG17Y1P7XDkBFAkt9
         VSdjxTwatuQP7kVicd4Bmwp4A1DQ1rXoNjhADImeDBtIw5Y7Ry5wZi81KIf/0Sx0hFHs
         zrVE0nPwtYqn0KdD5hwadNxW0TB/b04tJ7CLaQ8JjIwt4IeoTn3OAoAX3kxtW6sKEBrz
         gQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/cQHF+uqJiGHFhmYkPsuazFNDrycoxI7X+fh6O11aU=;
        b=LPz+EzfzKzqoYNVi+6ac8qK+3F47HP14dPqFkNe4gg2eXeUWwvgSP66WbxGxaYMNx/
         Gdsb5knRGrhO09GSIMk6AI7QY2/S1CK+e3baLLKenidJXE8xHjxYVLa98UD7/NtCXmZE
         1h7Zqs+PCUVqd8smxZ+QFiUJ8bZLq6crMuu6otzJor+T4TwMDX8lc9xrZ3NMvzXJfei1
         bypWG2DD3W/GQqud7RNl0JEY6fEYksHhsauPIc3j49ZkWzEYmybhRdU9QJTnlTrd2465
         SeDtB9tTOtDRQJUYevZ8YIr6Ljgi6huBuZZNPio5vXM5oPlRUvsjQcTa2x+bt22nRamn
         QaZg==
X-Gm-Message-State: AJIora9Tg0eQw/UWr7COsZ5ughSpl7sHbDSEo4RirMCyVgfp3seYFCN2
        xKu3XFOGpKl4mbSwuns6RaMVKzSLCkh8BWIMLsSFlA==
X-Google-Smtp-Source: AGRyM1s99vdnEyfE5yfELpKGwl12sCKs6XvDYNjyHsDu0rm9rfrsT/ScBNUsvx+1LZdHS9NHuMpBb0xM8qD1jOb3BdU=
X-Received: by 2002:a05:600c:4e8e:b0:3a0:4f43:beb6 with SMTP id
 f14-20020a05600c4e8e00b003a04f43beb6mr21738567wmq.176.1656737130660; Fri, 01
 Jul 2022 21:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com> <20220702040959.3232874-4-davidgow@google.com>
In-Reply-To: <20220702040959.3232874-4-davidgow@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Jul 2022 12:45:19 +0800
Message-ID: <CABVgOSmUrUuZm0eYkPF66mKEsj+CR4JFb9Km_e-0TbJYcK0fjQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftest: Taint kernel when test module loaded
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002c5e0505e2cb2c42"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000002c5e0505e2cb2c42
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 2, 2022 at 12:10 PM David Gow <davidgow@google.com> wrote:
>
> Make any kselftest test module (using the kselftest_module framework)
> taint the kernel with TAINT_TEST on module load.
>
> Also mark the module as a test module using MODULE_INFO(test, "Y") so
> that other tools can tell this is a test module. We can't rely solely
> on this, though, as these test modules are also often built-in.
>
> Finally, update the kselftest documentation to mention that the kernel
> should be tainted, and how to do so manually (as below).
>
> Note that several selftests use kernel modules which are not based on
> the kselftest_module framework, and so will not automatically taint the
> kernel.
>
> This can be done in two ways:
> - Moving the module to the tools/testing directory. All modules under
>   this directory will taint the kernel.
> - Adding the 'test' module property with:
>   MODULE_INFO(test, "Y")
>
> Similarly, selftests which do not load modules into the kernel generally
> should not taint the kernel (or possibly should only do so on failure),
> as it's assumed that testing from user-space should be safe. Regardless,
> they can write to /proc/sys/kernel/tainted if required.
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Whoops: forgot the changelogs. Only patches 2 and 4 had changes. For this patch:

Changes since v4:
https://lore.kernel.org/lkml/20220513083212.3537869-3-davidgow@google.com/
- Actually use the new TAINT_TEST name, instead of TAINT_KUNIT
(Thanks, kernel-test-robot)
- Document how to use this (or MODULE_INFO()) to taint the kernel.
(Thanks, Luis)
- Also add MODULE_INFO(test, "Y") to embed the fact that this is a
test module into the .ko
  - Nothing depends on it now, but it should allow us to tell this is
a test module without executing it in the future.

No changes since v3:
https://lore.kernel.org/lkml/20220513083212.3537869-3-davidgow@google.com/

--0000000000002c5e0505e2cb2c42
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAj
8FPvsmeLLBv2qSHpiRXmw4mLERHgLmxI7cRDFFD3hzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDIwNDQ1MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATrBfiy4X0qroElcl+tjW
Xj48Xr6tvUo8UKbUQjUlfBqSmDLvQO1DR3M9T3JSxlwEmdreBHDdX5Jn9u+yKs16iT91wQXgq/75
FI6v6JZgIqnkDyIQUoxLI2jW+vLoyevVVOrPCD3mqWa6FRNbvsvqDnVubFlYSm7+DrLl/f/7fsu/
21SvsRXbEb5XU5EM+uheJmEBF1WppMaMHVPWxAPhS9VSX4DrmJBHGunA42gt1NS+TKgCIlON2Maf
o2ZTmIprhMFRqfSB0ofeRhTWNuOoMHREIQ1OGwRKuTMz6AKG9t1wNCQFcCmQ6foW2nA7jPBhJ7Hy
JHe3sZgL+mVTypcIoQ==
--0000000000002c5e0505e2cb2c42--
