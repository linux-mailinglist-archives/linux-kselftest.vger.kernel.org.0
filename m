Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9386CBF97
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC1MrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1MrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 08:47:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4DAF16
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 05:46:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so12066243wra.9
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680007606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/vSxnkKPfRpZpd3/oxHdCUPaO+ve3U0H4l0bFnm5Vw=;
        b=nTiRCiFE4dQdKH4VO2ecHxog1z7g6eV4B6f21ATgdKkjvRHVKDPyLEGHXsuLdwcWf0
         eHLDNls+PuLXVSEOHBZdAdZnqdDt0ujNYTbOeQpYIJKg8jwTb4DD1VMRf33GuaywVB1V
         Mk9C6iKfq8DtoC+MO8CDifzFb/bt+j/T4Qxd8s455QbOU49hHqR/WB96UUhMuhjUnPeR
         PhKvuE8zk80cUYW7bLZIXLUxd7OLLAPk3G5lJdw54G/mjA6P9m/qbtw3B7ruFpZ3VLGt
         LKuBRDY20BO7K/eozdo1J6sMSAHF3G6ScnbZ5sy9W+amJcdtzP7SjE+CfDxoHgaNnst/
         ZaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/vSxnkKPfRpZpd3/oxHdCUPaO+ve3U0H4l0bFnm5Vw=;
        b=v90I4h5aDZSZ2VKw1sYIanuCg+sGG25guxkpYiXX8UGU+ITB1dtbTuEOzZ8eFQIgxA
         z3NhzdBMLel6kfbWzhp1FKT/xErOlNKzuLju/eWgluWL2Y2EI2jIIWXQ/DEtCBKhJrJr
         /TJZ0ERYSCzO4294EdgZ5QSrLzqnc44aXr7w7fAIvpY/tMxMHIxk2xpKGm95Q8VuX16Q
         lqG1L/oiurwOmRjqWRVC8lqu67yVcnqpoS8l/nVUK7KI0tG0PKsKRcQvX3XwM1IXP0CY
         xCSx0QwiItFpOrP8uqWxk22yxl7UjqAQkFvH4r4hYm5TRSXY3axayOrGHiXYu2scp3HS
         tnzg==
X-Gm-Message-State: AAQBX9d8HpgvtOOMdXN+AZBQ8QPeyMlCGbZdjPKuZNiYFlWemLoLKSY2
        ytZ2B/kzmsX30kVbodrEtbm+PSyDvjjwTkFcbtObvQ==
X-Google-Smtp-Source: AKy350avVt4v1mM5DGuvZHInb9MzJdeS6cuTVWEznQLbCuLIpJ9IBfaEyoKTgigWxsmwQSezNM2I2CpDcvqp/iaGTQM=
X-Received: by 2002:a5d:4349:0:b0:2df:ebbe:7d46 with SMTP id
 u9-20020a5d4349000000b002dfebbe7d46mr1388755wrr.2.1680007605785; Tue, 28 Mar
 2023 05:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <0bfe4ca4863c22208d09d9b437cc563ed50877a1.camel@sipsolutions.net>
In-Reply-To: <0bfe4ca4863c22208d09d9b437cc563ed50877a1.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Tue, 28 Mar 2023 20:46:34 +0800
Message-ID: <CABVgOSmtyYDTNO+fREYpsO+BLeGYmajVPjrqqrxq+88HfPFsjQ@mail.gmail.com>
Subject: Re: new kunit infrastructure
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000095a70105f7f54001"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000095a70105f7f54001
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Mar 2023 at 18:35, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi all,
>
> Is there an established process for new kunit infrastructure?

Hi Johannes,

"established process" is probably overselling it, but we're more than
happy to accept improvements and additions to KUnit.

>
> For example, we have this macro that makes KUNIT_ARRAY_PARAM easier by
> letting you just declare an array of test cases:
>
> /* Similar to KUNIT_ARRAY_PARAM, but avoiding an extra function */
> #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                        \
>         static const void *name##_gen_params(const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
>                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
>                         strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);              \
>                         return __next;                                                          \
>                 }                                                                               \
>                 return NULL;                                                                    \
>         }
>

Very neat! I'm more than happy to see this added.

>
> Also, since we're working on wifi and thus networking, we want e.g. SKBs
> to be resource-managed, and added some helper macros/functions for using
> kunit_alloc_resource() with SKBs, that will be used at least in cfg80211
> and mac80211 soon, so it would seem appropriate to have
> include/kunit/skb.h (and a corresponding C file somewhere) with these
> helpers.
>

We're definitely in favour of adding these sorts of helpers. Thus far,
these have mostly lived alongside the tests or subsystem being tested,
but if they're widely useful then they can sit alongside the KUnit
code.

My personal feeling is that it's better to have these sorts of
subsystem-specific helpers be written and maintained as part of the
subsystems (like the tests themselves), largely because that's where
the subsystem expertise lies, but we're definitely happy to review any
such patches to make sure they fit into the KUnit infrastructure well.
(And, of course, if something spans several subsystems, then lib/kunit
may be the best place to keep it.)

>
> Is all of this just a case of "nobody needed it so far", or is there no
> expectation to add such infrastructure more generally?
>

Yeah, it's a combination of "no-one has needed it yet", "no-one
working on KUnit understands it well enough", and "we haven't had the
time yet". We are a bit hesitant to add these features without having
tests that use them, too: often things will be coded by hand for one
or two tests, and only then refactored out into a common helper.

There are a few other similar helpers being worked on at the moment,
mostly around providing test-managed "struct device"s, so this is
definitely an active field of development.

Thanks,
-- David

--00000000000095a70105f7f54001
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAH
dZlOcWl5n9pxxbju9GLI5Vfw3hXJgsSzhy00kHPXHzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjgxMjQ2NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATh4tN1K2zASnovNTjd4g
lbcW47biBy3aCeJ0RFt53NlrWnZmIgwRYUOjv08LjFTELZi2lRd6OuqIpIFWXqtblN2JaRYzUsaU
nHFBFkmkvlipZ5Klu0SMV78upqO4uuCNnqP+1G8SPEOn5jWCYEU6aU1VFdF/JyeE92s6xpfFbDzz
As2pPEX1SAiChCuRrSPEOIA+c4A4mH/xig9zrlkJ8DnCccS6lQfXKdlFqES3Muw+/3GvNGWLelat
wmqjdv/VcuKOUTCsBJZWUIQsMfzpRWdJ4oihdTOcXccQzyT5BvGXv3PfXjbvJWslT5V9vs+jp4YK
n17hYNaHYuCL3I6V+w==
--00000000000095a70105f7f54001--
