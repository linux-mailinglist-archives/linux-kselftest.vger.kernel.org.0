Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCE68FFA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 06:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBIFGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 00:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBIFGe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 00:06:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D12367C
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Feb 2023 21:06:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3044819wma.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Feb 2023 21:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6iowtRjEGrj4ff6antbO/9k/ZdfZ4OFavfw42sl3Sc0=;
        b=e8opfh+UNJ4D9veu22HdZdfKqbCoQtisLQIPU8XqdLXwMUWH2cOcqr9K+FT8N0BzMH
         i+f78FxDv9o3ptXGHr4I2/B69UOZKczRRX8W2WxnhT204gptB1en3QVjgDsSC51koufO
         k8owTCK/vgkoUseb07pDnxLjSiAOrI3Arb+EqcUL6UZP83XkcCGPs2Jcek9GepdQZesB
         GZJYbU/pDq5QgCtPy6tLQ7/Aey12AK+1b/VpiVzz4CvkZWemNM8mp7X7uSbqPazo8H7P
         PItVHZ8kMn5gZJxPRJQR3sTT+zqbltYJmf87JuNsmtbk8NLLrzeNHH49D35cOl3X0aW2
         xoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iowtRjEGrj4ff6antbO/9k/ZdfZ4OFavfw42sl3Sc0=;
        b=sCg+CT/zcjwN8tP6fI1CPpejvP0Ii062DGqNFggRd0zYOc0BhpDFQQR2bQQZI6jlTt
         FownzWbqB7V5QhpAqx1VJ84kwgl2M4TUH57gIyqe02f2UDDaEiO7gzlNQOsjSAEL6kHw
         3cgtL+WDz1STOyP2iYWXqM4qYA841OZ7Qx5q0LDfiddvUycQJEgWpyoc+Q2RhqSi+HRG
         hvQ8X+7Y9q0Mf/mL4yJ+ZL+1scRd8o8yQLZbeC/gHfotDHAAAWb57g/PnwfvrT1pwOVe
         Y5K3srUkCSV0077AgNzvIQoZe02H+Uctwr1slNUObYE0AiKgvOD1M7d0GLPTFFntWR4O
         CfUg==
X-Gm-Message-State: AO0yUKU4LTe841M6wm40QYf4xMfan2AaDt3tCygywkSnhLI1Y6vmtqHt
        Cg3LxPZbqatgMrzzWw7Ov2sAqP6diiBRnzXfBxiHvQ==
X-Google-Smtp-Source: AK7set8I5l3D5ZnUajff0zBFMlmYdjjUBPI+CXiSSYItTcOlnTAUfabzZu2OwOUOVww7ginlOKsegOaS4W++jfWFj7I=
X-Received: by 2002:a05:600c:1d05:b0:3df:4bc8:edfb with SMTP id
 l5-20020a05600c1d0500b003df4bc8edfbmr401149wms.168.1675919190888; Wed, 08 Feb
 2023 21:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20230131220355.1603527-1-rmoar@google.com> <20230131220355.1603527-4-rmoar@google.com>
In-Reply-To: <20230131220355.1603527-4-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Feb 2023 13:06:17 +0800
Message-ID: <CABVgOSngiZZ6HTAOTriB=TveYOPoZVChqyeNfaBsDzFCY+_A2A@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kunit: fix bug of extra newline characters in
 debugfs logs
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000f19e605f43d58aa"
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

--0000000000000f19e605f43d58aa
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Feb 2023 at 06:04, Rae Moar <rmoar@google.com> wrote:
>
> Fix bug of the extra newline characters in debugfs logs. When a
> line is added to debugfs with a newline character at the end,
> an extra line appears in the debugfs log. Remove these extra lines.
>
> Add kunit_log_newline_test to provide test coverage for this issue.
> (Also, move kunit_log_test above suite definition to remove the
> unnecessary declaration prior to the suite definition)
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

I've got some reservations about this patch.

Firstly, could we have an example of the problem in the commit
message, so we know what we're fixing?

Secondly, I _really_ don't like the way this just removes newlines
from log lines if there are too many. It feels like a hack, rather
than a proper fix.

I suspect the actual issue here is in the kunit_log macro in
include/kunit/test.h:
https://elixir.bootlin.com/linux/latest/source/include/kunit/test.h#L417

kunit_log_append((test_or_suite)->log, fmt "\n", ##__VA_ARGS__); \

The "\n" concatenated here is probably the issue. The printk statement
doesn't add a newline, but that's because printk implicitly does if
KERN_CONT is not added.

So maybe the correct fix here is to use:
printk(KERN_CONT lvl fmt "\n", ##__VA_ARGS__)

That'd add the newline, rather than get rid of it, but at least should
make the behaviour more similar between printk and the debugfs log.
Equally, you could use KERN_CONT and get rid of the "\n" in both
places, requiring it in log messages.

Thirdly, I don't really like the way the test is skipped if debugfs
isn't active. Could we skip it if test->log is not valid instead or
using a compile-time #ifdef?

I do like the move of kunit_log_test though. That definitely cleans things up!

Cheers,
-- David


>  lib/kunit/kunit-test.c | 36 ++++++++++++++++++++++++------------
>  lib/kunit/test.c       |  9 ++++++++-
>  2 files changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 4df0335d0d06..e9114a466f1e 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -443,18 +443,6 @@ static struct kunit_suite kunit_resource_test_suite = {
>         .test_cases = kunit_resource_test_cases,
>  };
>
> -static void kunit_log_test(struct kunit *test);
> -
> -static struct kunit_case kunit_log_test_cases[] = {
> -       KUNIT_CASE(kunit_log_test),
> -       {}
> -};
> -
> -static struct kunit_suite kunit_log_test_suite = {
> -       .name = "kunit-log-test",
> -       .test_cases = kunit_log_test_cases,
> -};
> -
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> @@ -481,6 +469,30 @@ static void kunit_log_test(struct kunit *test)
>  #endif
>  }
>
> +static void kunit_log_newline_test(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       kunit_info(test, "extra newline\n");
> +
> +       KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(test->log, "extra newline\n"),
> +               "Missing log line, full log:\n%s", test->log);
> +       KUNIT_EXPECT_NULL(test, strstr(test->log, "extra newline\n\n"));
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
> +static struct kunit_case kunit_log_test_cases[] = {
> +       KUNIT_CASE(kunit_log_test),
> +       KUNIT_CASE(kunit_log_newline_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite = {
> +       .name = "kunit-log-test",
> +       .test_cases = kunit_log_test_cases,
> +};
> +
>  static void kunit_status_set_failure_test(struct kunit *test)
>  {
>         struct kunit fake;
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 27763f0b420c..76d9c31943bf 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -117,6 +117,7 @@ void kunit_log_append(char *log, const char *fmt, ...)
>         char line[KUNIT_LOG_SIZE];
>         va_list args;
>         int len_left;
> +       int line_len;
>
>         if (!log)
>                 return;
> @@ -125,10 +126,16 @@ void kunit_log_append(char *log, const char *fmt, ...)
>         if (len_left <= 0)
>                 return;
>
> +       // Evaluate the length of the line with arguments
>         va_start(args, fmt);
> -       vsnprintf(line, sizeof(line), fmt, args);
> +       line_len = vsnprintf(line, sizeof(line), fmt, args);
>         va_end(args);
>
> +       // If line has two newline characters, do not print
> +       // second newline character
> +       if (fmt[strlen(fmt) - 2] == '\n')
> +               line[line_len - 1] = '\0';
> +
>         strncat(log, line, len_left);
>  }
>  EXPORT_SYMBOL_GPL(kunit_log_append);
> --
> 2.39.1.456.gfc5497dd1b-goog
>

--0000000000000f19e605f43d58aa
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBi
9wCjl0KW6i3C1zdcEffR4W1hnk7WXHkbH6Cx+ZCuZTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMDkwNTA2MzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAZMfV+K443kT1qXwWbmON
pcmKVbc8Vj+0DXdcM2BxpmQhOCu/dXayCN5OgR7YAwDAy4uGunUmu0S+aifNQRdB0eo0v6N4+j6Z
B06cMaq21uwuOWw01C9l9PtLg6tq0LrQbaMrumx8vnaHC7qVspAoBGQVoyNKsh17AGPaaycmc+Qp
uRtUj/Bz8gJOkk5vdRT6wo0XCqui+rptf/8/P7IYU1O/INb0PePLckJVH6mhJ2AxDPN54GIGfJLF
MJ/M1+Y2hw2l5Uod5dQ069eXmNyGFgbZbJNO+hAIYE7Flp5Bmpy1OU8PQus60znJXd5z2t0fHZ9/
ORlk7bqHl/7y70VdRA==
--0000000000000f19e605f43d58aa--
