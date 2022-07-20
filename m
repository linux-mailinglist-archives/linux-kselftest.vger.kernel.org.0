Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFB57B3CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiGTJ0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGTJ0Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 05:26:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A852E5C
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 02:26:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d8so5304786wrp.6
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Jul 2022 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1RT70dVRWCdzYdRHqqEZlWtY1V9zI+ixKXFVkFFnB0=;
        b=KT2VcTFc2j4N95HkPoMbyWJIFPBzD8UqKVqiLcLot3v+KPDRpgZGmtoboHX0xbmCRd
         KcTArKuJQJ/8rChv4faRzV1AwehO+O/xFJjzkm0CLCpevE8q8K1Ioj6wAiLR0BQkfLdM
         IyKeGiX9AGlAeTrrI6p8u95GSqROod5egFsT9PQat9CrrytI/YKDT+wVUcr9xioZDj5/
         TkarHcaAmxWhULrIYGudKOlkHrnsIreTd46oFTiVumT0P4y58vYlNmCdQuyPxRqTUNZY
         p2xoai+/52ouk1iiOt/fGADo/Q90d0C2/XKKzXKMEeBS/lp1jNATONrbxr/RinrxQUK6
         MfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1RT70dVRWCdzYdRHqqEZlWtY1V9zI+ixKXFVkFFnB0=;
        b=R+ZYri/vE/YANsAv4M5lkuGVqTum/QAgoXMdKRt7mIYt8qxIzpbz0Ezd2/ATgdli4n
         YSzxth5WETFeod9fjoei5X5b50IIczmu436McaTUiG8jMIXKwZ9vkdqVsKIFHaSszyaY
         nks8OBXZPoQG1dTZPZxEoAg1hn3ioHpNvh4YOei1yExK1FUC3dFGWvadOh0ccBfl75+Q
         0kMKa4SNZA1gjBy9um5+46Mc3LTkL4VnaA/NvFHxewJVdFCbZB+BHsG6q5KKVpHl9KSD
         O9rNETE3VrcRHkltOZQax5/HLtAjWJBRLhelU6w6sNEA5nqlZld0XzqiXKqkaTcYj+6G
         tE0g==
X-Gm-Message-State: AJIora/qSNUY7XdpmWhC2hN4TKPVBUWYe4CL+WcDkb2Q98Ng4ZmUUCUt
        XVLtvcmwfhXGxOsdOEatz7fbju3RnuZChIYbZG2491PXrNlARQ==
X-Google-Smtp-Source: AGRyM1vPUTNYZtrbOlmCgU5sTGfrMq58qQzXIAIOaEzSmiLik6FnswjHhwybz1D8taJr0kvYmoBocRRvMBVhd8uPth4=
X-Received: by 2002:a5d:4708:0:b0:21e:4eda:5cda with SMTP id
 y8-20020a5d4708000000b0021e4eda5cdamr301867wrq.337.1658309173441; Wed, 20 Jul
 2022 02:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com> <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
 <Ytbw1T6uspICqj5B@bombadil.infradead.org>
In-Reply-To: <Ytbw1T6uspICqj5B@bombadil.infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 20 Jul 2022 17:26:02 +0800
Message-ID: <CABVgOSkpT2kqVec2F7BsTF5tyABO43bseETC2Dz238zN+sTfQw@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003a328e05e4393150"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000003a328e05e4393150
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 20, 2022 at 1:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 13, 2022 at 08:24:32AM -0700, Daniel Latypov wrote:
> > On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
> > >
> > > The new KUnit module handling has KUnit test suites listed in a
> > > .kunit_test_suites section of each module. This should be loaded when
> > > the module is, but at the moment this only happens if KUnit is built-in.
> > >
> > > Also load this when KUnit is enabled as a module: it'll not be usable
> > > unless KUnit is loaded, but such modules are likely to depend on KUnit
> > > anyway, so it's unlikely to ever be loaded needlessly.
> >
> > This seems reasonable to me.
> >
> > Question: what happens in this case?
> > 1. insmod <test-module>
> > 2. insmod kunit
> > 3. rmmod <test-module>
> >
> > I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
> > for <test-module>, I think?
> > But we never called __kunit_test_suites_init().
> > My fear is what breaks as a result of this precondition break.

I don't think this should be possible: any module with KUnit tests
will depend on the 'kunit' module (or, at least, kunit symbols), so
shouldn't load without kunit already present.

If modprobe is used, kunit will automatically be loaded. If insmod is
used directly, loading the first module should error out with
something like:
[   82.393629] list_test: loading test module taints kernel.
[   82.409607] list_test: Unknown symbol kunit_binary_ptr_assert_format (err -2)
[   82.409657] list_test: Unknown symbol kunit_do_failed_assertion (err -2)
[   82.409799] list_test: Unknown symbol kunit_binary_assert_format (err -2)
[   82.409820] list_test: Unknown symbol kunit_unary_assert_format (err -2)
insmod: ERROR: could not insert module
/lib/modules/5.19.0-rc1-15284-g9ec67db0c271/kernel/lib/list-test.ko:
Unknown symbol in module

Maybe you could get into some trouble by force-removing modules at
various points, but you're in undefined behaviour generally at that
point, so I don't think there's much point going out-of-our-way to try
to support that.

> >
> > E.g. In the case that CONFIG_KUNIT_DEBUGFS is enabled, this includes a
> > call to kunit_debugfs_destroy_suite() with no previous call to
> > kunit_debugfs_create_suite().
> > That will include a call to debugfs_remove_recursive(suite->debugfs),
> > where suite->debugfs is an uninitialized pointer.
> >
> > Maybe we can treat it as "undefined behavior" for now and proceed with
> > this patch.
> >
> > In terms of long-term fixes, perhaps insmod kunit could trigger it to
> > 1. run all built-in tests (IIUC, it doesn't right now)
> > 2. run all the tests of currently loaded modules
> > 3. track which modules already ran so if you rmmod + insmod kunit
> > again, it won't rerun tests?
>
> Let's please address these considerations.
>

Again, I think the module and Kconfig dependencies should prevent
these situations from ever arising. It shouldn't be possible to have
any built-in tests if kunit is not itself built-in, so case (1) can't
occur. Equally, it shouldn't be possible to load any test modules
before the kunit module is loaded, so (2) can't occur. And rmmod kunit
will give an error if there are any test modules loaded: "rmmod:
ERROR: Module kunit is in use by: list_test", so (3) can't occur.

The only similar situation to (3) I can think of is where both the
test modules and kunit are rmmod-ed and reloaded. I think we'd want to
re-run the tests in that case, so tracking which modules already ran
would be counterproductive.

In short, I _think_ what we're doing now should be correct, and the
cases above are all prevented by module dependencies. But do let me
know if I'm missing something...

Cheers,
-- David

--0000000000003a328e05e4393150
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDi
lHOHniqfhL0SWmohcV+5LiuONdCSzCpOpCAEz4azOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MjAwOTI2MTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABdV3+caJ97XIyT5tGUCk
ltvPscFweSroK7m3nXXUzR/OQM27SLhw86k8a4pWTeEsb74hdMKcvxScvELf75trIy9ZrsNmg36p
VWtivqDolTF0nJpFVhUyqIgurv0EnRmRS9iI9UBzPOhKlwYVZqXBDvY4SUhQ7DYwu3KM9U/o6Z0T
o3nDL1Jl2s/bCrXod60x6tC4wlShB3cafyzRoHRAuogx9CpCQCcJ+JoQ8H4N/QfF91IqRdNY5322
bbsdyR+hBo/MvgoMHYIlpMk4jeuAw9yuD7ketEBuISXb8798LqfErBBVujiYwf/kw+pSyakvwBOE
YZExTaaglCRKkYJz2A==
--0000000000003a328e05e4393150--
