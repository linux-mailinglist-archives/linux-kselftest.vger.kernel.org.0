Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2A599708
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiHSIR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiHSIQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 04:16:58 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B3E0947
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 01:16:56 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id v128so3772717vsb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E7vInUdmlvrFCkUyEmTe4ZEEX0FvIIBOpwo7oLWSO2w=;
        b=Dx79meg3/bx5x08oSWGcD4GE2uAP0/9mILTeNX6iZOsHYTZEKYlTLfNDtNBU4SxUAX
         uw+WRU3eS3VsW6o2rnmktPCsqnyvBFUDzU7d+P3LGNzf/JhRpfXaW4cqSYjfrJLFFhG/
         PeH4aSBWeBqmmakbgJ4PYTBLgfc6ssMbGlTqnmMlS71XEQrpAXy5VcGtmWfVnEVZPapR
         XzUeYesiheNmDQam708vU8G5QUHR+KvmW0dDEIWB6z54x+fk7itqIVPj7lh+urWMUKxL
         Yb2cTvjvlKQfoeuMx9nsZ1QQy0ExOOqutD+JlWcOY3/gBLbOlf+G68onu0PbgUagfAFV
         XxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E7vInUdmlvrFCkUyEmTe4ZEEX0FvIIBOpwo7oLWSO2w=;
        b=IrDOcJcjtID8znlr3bh1377oIdMzRt9az5u9Svc7pWsm06OCLl0EH73nDXtDJaIcAs
         aQb0r5nDyrnZcKdX5MfPXfu9/80pYISXEH8h+dRSxS90DOggFR4wTJSMKqNAS17qRSYX
         QUWAHfE0eAg736ugmzQHvYny2Qhx7Bu8efIGg5+Aqc0P24qgpF5rWbQoEgCCvHO0L4hn
         TuYzjkAmVP2GJRagC4mFZn4SHjLlZ9O0+Bji0J5O3THSXKEvcHNoxYpAHStRdO+vBR7i
         MqkwhA4D0cyHdWd6ebYY3RySjE9qGuWpW1BAFI3QQFgdfU19xX8JcyFxzYcpEb7XXXsX
         IW3w==
X-Gm-Message-State: ACgBeo3rMrpYNx89N500L4ywicJMxtRhXWRUVeHub3+SC7qIyKDt1TtU
        JmnbUqL5rhz1CqRCmre3tp+ciRb0WiQXtUOY6QcwQw==
X-Google-Smtp-Source: AA6agR5w0WXgE74yhLOGIaPwSTS442Sw34gDIQQ7RnLk5mfeK0AfHtHKf585bmhIpgKJO2Qz46GaEPrcAuuheXpa8U0=
X-Received: by 2002:a05:6102:2146:b0:38f:f3d6:51da with SMTP id
 h6-20020a056102214600b0038ff3d651damr1820810vsg.38.1660897015447; Fri, 19 Aug
 2022 01:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com> <20220817164851.3574140-2-joefradley@google.com>
In-Reply-To: <20220817164851.3574140-2-joefradley@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 19 Aug 2022 16:16:43 +0800
Message-ID: <CABVgOSkFLNRDgo0=E9qxbi0rZziYEiPTpknEffFkzdv09wRk8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: add kunit.enable to enable/disable KUnit test
To:     Joe Fradley <joefradley@google.com>, Nico Pache <npache@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a22a2005e693b8ee"
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

--000000000000a22a2005e693b8ee
Content-Type: text/plain; charset="UTF-8"

+Nico Pache in case this could be useful with kernel/kunit packaging.

On Thu, Aug 18, 2022 at 12:49 AM 'Joe Fradley' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> This patch adds the kunit.enable module parameter that will need to be
> set to true in addition to KUNIT being enabled for KUnit tests to run.
> The default value is true giving backwards compatibility. However, for
> the production+testing use case the new config option
> KUNIT_ENABLE_DEFAULT_DISABLED can be enabled to default kunit.enable to
> false requiring the tester to opt-in by passing kunit.enable=1 to
> the kernel.
>
> Signed-off-by: Joe Fradley <joefradley@google.com>
> ---

Thanks for sending this out.

I'm generally in support of the idea, and the implementation is okay,
but there are a few small usability issues or bits of futureproofing
we could do.

On the first front, this doesn't integrate well with kunit_tool: if
built-in tests are disabled, it will print the test header and test
plan, but no results, which confuses the kunit_tool parser.
In addition, maybe it'd be nice to have kunit_tool automatically pass
kunit.enable=1 to any kernels it boots. Equally, a few minor
naming/description suggestions.

More details in comments below.

On the second topic, I think we need to work out exactly how we can
evolve this to make it as useful as possible upstream going forward.
In general, while there's nothing fundamentally wrong with having
tests disabled at runtime, it is going to be a very niche feature, as
for most users the correct solution here is to build a new kernel,
without KUnit.

My feeling is that the real distinction worth making here is that
tests can be compiled in and loaded (e.g., if tests are embedded in a
non-test module, like apparmor, or thunderbolt, or (soon) amdgpu), but
won't execute automatically. Now, at the moment there's no way to
manually trigger a test. so this distinction isn't yet important, but
we may want to add something down the line, such as the ability to
trigger a test via debugfs (this was proposed as part of the original
debugfs support packages), or the ability to change the value of this
'enable' flag at runtime, and then load a specific test.

Maybe that involves some further changes to the implementation (at its
most extreme, it could involve moving the checks out into the module
loader and the kernel_init_freeable() function, though I don't think
that's _necessary_), but for the most part, it probably just involves
describing and documenting this change as such.

Would something like that still serve Android's purposes? Or is it
critically important that the idea behind this is "if this is set to
false, there should be no way of running KUnit tests", and having a
manual way to trigger them down the line would defeat the point?

Cheers,
-- David

>  .../admin-guide/kernel-parameters.txt         |  6 ++++++
>  lib/kunit/Kconfig                             |  8 ++++++++
>  lib/kunit/test.c                              | 20 +++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda0..ab4c7d133c38 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2436,6 +2436,12 @@
>                         0: force disabled
>                         1: force enabled
>
> +       kunit.enable=   [KUNIT] Enable executing KUnit tests. Requires
> +                       CONFIG_KUNIT to be set to be fully enabled. The
> +                       default value can be overridden to disabled via
> +                       KUNIT_ENABLE_DEFAULT_DISABLED.
> +                       Default is 1 (enabled)
> +
>         kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>                         Default is 0 (don't ignore, but inject #GP)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 0b5dfb001bac..5d6db58dbe9b 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -59,4 +59,12 @@ config KUNIT_ALL_TESTS
>
>           If unsure, say N.
>
> +config KUNIT_ENABLE_DEFAULT_DISABLED
> +       bool "Require boot parameter to enable KUnit test execution"
> +       help
> +         Sets the default value of the kernel parameter kunit.enable to 0
> +         (disabled). This means to fully enable kunit, config KUNIT needs
> +         to be enabled along with `kunit.enable=1` passed to the kernel. This
> +         allows KUnit to be opt-in at boot time.
> +

Hmm... would it make more sense to have this be DEFAULT_ENABLED and
have the default value of the config option be y instead?
Personally, I think that'd avoid the double-negative, and so might be clearer.

>  endif # KUNIT
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index b73d5bb5c473..e6f98e16e8ae 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -54,6 +54,17 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
>  EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
>  #endif
>
> +/*
> + * Enable KUnit tests to run.
> + */
> +#ifdef CONFIG_KUNIT_ENABLE_DEFAULT_DISABLED
> +static bool enable_param;
> +#else
> +static bool enable_param = true;
> +#endif
> +module_param_named(enable, enable_param, bool, 0);
> +MODULE_PARM_DESC(enable, "Enable KUnit tests to run");

Maybe "Enable KUnit tests" is simpler than adding "to run", which
reads a bit awkwardly.

If we were to treat this variable as specifically enabling the "run
tests on boot" and/or "module load", then that could be worked into
the description, too.

> +
>  /*
>   * KUnit statistic mode:
>   * 0 - disabled
> @@ -590,6 +601,12 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>  {
>         unsigned int i;
>
> +       if (!enable_param && num_suites > 0) {
> +               pr_info("kunit: deactivated, cannot load %s\n",
> +                       suites != NULL && suites[0] != NULL ? suites[0]->name : "NULL");
> +               return -EPERM;
> +       }
> +

This mostly works, but has a few small issues:
- KUnit will still print the header and a test plan, so kunit_tool
will report a large number of "crashed" tests when no results are
forthcoming.
  It should be posible to add a similar check in kunit_run_all_tests()
to handle that case:
https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c#L246
  You can test this with:
./tools/testing/kunit/kunit.py run --kconfig_add
CONFIG_KUNIT_ENABLE_DEFAULT_DISABLED=y

- The message is not ideal: it only refers to the first suite in the
module (or built into the kernel). and "cannot load" is not really
applicable to built-in tests.
  Maybe the goal should be less to "not load test modules" but more to
"allow test modules to load, but don't run the tests in them".
  Thoughts?

- If we were to treat this as "tests load, but don't run
automatically", then we probably don't want this to be an EPERM...

>         for (i = 0; i < num_suites; i++) {
>                 kunit_init_suite(suites[i]);
>                 kunit_run_tests(suites[i]);
> @@ -607,6 +624,9 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
>  {
>         unsigned int i;
>
> +       if (!enable_param)
> +               return;
> +
>         for (i = 0; i < num_suites; i++)
>                 kunit_exit_suite(suites[i]);
>
> --
> 2.37.1.595.g718a3a8f04-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220817164851.3574140-2-joefradley%40google.com.

--000000000000a22a2005e693b8ee
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDz
xo1VAZWG+wAYf1wH1odk1wTPrkhUqDPIX96/qV2pIDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTkwODE2NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApeieXGvz5LrRXkpSHC3R
Txb6UrSaAHEpZ4vrRVeIZ8wqN0Qv/5+p2XgEhIuYcPg385HXLk/nkKWB5skT0rPut90tMQcZPxIw
Cz4BMjQ6ur2XAVrLZtyPnhEbMV9kYx5UFGdyfC8R7qi9KH51O9h6wNC/qG+xx91iFoSpRk74FHu+
B/5K+5d8zsJBeeGcUO2jxUjW3+AxcaomET6Ya8+NbOzW7v8Wpas6Lo+32/2F0q8QSKsmNvsa1chM
CS9h/VS5rkfIo/pHk1P6Pvr31pU7SMfPPZihZ+SYqpnN1H6ImEUVO0nQZJpj1cGy0CgW79nnDeTu
C15gnBvF5E2ss9EgBA==
--000000000000a22a2005e693b8ee--
