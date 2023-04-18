Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F56E59E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 08:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDRGyY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 02:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjDRGyG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 02:54:06 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4705B8D
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 23:53:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-552ae3e2cbeso73621197b3.13
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681800826; x=1684392826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rq1ncqxd3eL5QfbrlxfcHt4jNgMyA3+6TQ6CS8EUxdU=;
        b=cYTHmAPFryxXggFc9OuPAJ2tY8YsR+evYUTdESBvW1tjw77TiXh/mTK7P0vqVS0IZU
         auBMGuBwMAdfi/JEARDLqI16qQCZSZU+4CKdOOf6kzbfPyQcNwA0d1qgP5aNlAehmc3z
         VnBbh1rw9ukmo3w2U0oEaoxoFNeOnqtJPoPjqJFDBg8h0eVZsDEhvb8i7McT/mSkmtZo
         d+zG2eP56Vg2GoTG1HXsAKVRCoDu5nGZCZb8qX65Iwgsvrkv/2FIL+O90nDitImz1Q2M
         uvCoDxoP5iQG1pjo6+edR9EaLRJyX+mWKWMFHYvUYI8mfdC/oxTLozOEfs8srdpPKlnd
         VUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681800826; x=1684392826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq1ncqxd3eL5QfbrlxfcHt4jNgMyA3+6TQ6CS8EUxdU=;
        b=f5mJPxb8l43n0ZjLLm3RAyo7kBRb2ncmPJCCPsd2+LWWN3r2xJpxuLiFipmhiFZAcI
         wJY4+bDIbjjPzUhJOpX4rhFcdO+FFrFvhcZPxj5e04P0I7z9Qzc9saRb6fn55onAo6ko
         K55Oc4GumAbWb+4dZV7Cvxw1MgTtd3jBZQ1/d8Fb8HsCTszTeVsyg3FbBVl5Q+OF3G43
         w4aoyCAQahS3KLCnpQv2N7KKU0xrwgIarh308qgp8OxRou/ATiyIanMCgGfoCQ854+YX
         A0uhCqyDaaicLwLmWOsPsorMo9NzYL2adKBzgZF/7hOstfjsX/IWU4Z0xGUiNIjW/6+o
         Om5g==
X-Gm-Message-State: AAQBX9e/qObGb9Va8IBmTKxtifuyYmFkUnR/9zBCekuRY5D7gJpxN2NP
        B6IzyXkcTJCJBaRnkytz2uWhnHGybbsE4PCQy1ZBRw==
X-Google-Smtp-Source: AKy350YWxYJxzXD8Xi+3tsqQfqByAEKPac8FlonZV1AGUyxrUOwnG6uknHDp7HEkceo5N6TO3OeioTaiYaAcVkR0+aw=
X-Received: by 2002:a81:4307:0:b0:545:f7cc:f30 with SMTP id
 q7-20020a814307000000b00545f7cc0f30mr11093586ywa.0.1681800826504; Mon, 17 Apr
 2023 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230415091401.681395-1-davidgow@google.com> <4560d22e3d0a9beb71ef10202d8bcb77b5148eae.camel@sipsolutions.net>
In-Reply-To: <4560d22e3d0a9beb71ef10202d8bcb77b5148eae.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Apr 2023 14:53:28 +0800
Message-ID: <CABVgOSmGa-4M6w7MJ5MP8222FMuZJike1uDauporBsu5QUDb9w@mail.gmail.com>
Subject: Re: [PATCH] kunit: Set the current KUnit context when cleaning up
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000de841105f996c4a6"
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

--000000000000de841105f996c4a6
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Apr 2023 at 18:43, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> Hi,
>
> On Sat, 2023-04-15 at 17:14 +0800, David Gow wrote:
> > KUnit tests run in a kthread, with the current->kunit_test pointer set
> > to the test's context. This allows the kunit_get_current_test() and
> > kunit_fail_current_test() macros to work. Normally, this pointer is
> > still valid during test shutdown (i.e., the suite->exit function, and
> > any resource cleanup). However, if the test has exited early (e.g., due
> > to a failed assertion), the cleanup is done in the parent KUnit thread,
> > which does not have an active context.
>
> My only question here is whether assertions (not expectations) are OK
> within the exit/cleanup handler. That said, it wouldn't be clear
> whether we should try to continue cleaning up after every failure, so
> probably it is reasonable to not do that.

Excellent point.
In general:
- It's okay to use expectations within exit and cleanup functions.
- It's not okay for assertions to fail within an exit / cleanup handler.
- It's not okay to access anything which was allocated on the stack
from within a test in exit / cleanup handlers.
- It's okay to access and free resources from within cleanup / exit
handlers, though it's not permitted to create new resources from
cleanup handlers (exit is okay).

I do think we need to document this better, at the very least.

What I think we'll end up doing is implementing a different system:
- The test (and, if successful, cleanup) runs in a kthread.
- If it aborts (e.g., due to an assertion), cleanup runs in another kthread.
- If this second kthread aborts early, no further cleanup is run.

This would protect the KUnit executor thread from misbehaving cleanup
functions, and if an assertion happens in a cleanup function, we'll
leak things (which is bad), but not dereference a bunch of invalid
pointers (which is worse).

I've got this mostly working here, and will send it out as a
replacement to this patch (that second kthread will have
current->kunit_test set, rendering this change redundant).

>
> But, I did see that at least the clock tests currently use assertions
> inside the init function. And, in those tests, if the context
> allocation fails the exit handler will dereference the NULL pointer.

Hmm... which clock test is that? Regardless, it sounds like a bug in the test.

I think that ultimately, the right solution for dealing with the
context pointer issue is to use resources (or, when available,
kunit_add_action()), which nicely enforces the ordering as well. In
the meantime, though, I guess it just needs wrapping in a lot of "if
(ctx)" or similar...

> So, nothing for this patch, but maybe it would make sense to mark tests
> as failed (or print a warning) if they use assertions inside init, exit
> or cleanup handlers?
>

I think we'll still want to support assertions in init functions
(albeit possibly with some documentation pointing out any pitfalls).
If actions or resources are used, it's not a problem.

Also, a lot of these issues also apply to kunit_skip(), which is used
_heavily_ in init functions.

Warnings for assertions in exit or cleanup make sense. I _could_ see a
reason to allow assertions if we wanted to have, e.g., helpers which
asserted that their inputs were valid -- it'd be a bit rough to deny
their use if the inputs are known to be okay -- but I'm not aware of
any such case in practice yet, so I suspect it's still worth failing
tests (and seeing if anyone complains).

Cheers,
-- David

--000000000000de841105f996c4a6
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAv
V7xGoxqxZhuil0Y7MEtfWK8SbjH3Ms0NaH2MIoAE+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA0MTgwNjUzNDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoc8pDN9O77XryCjpqUNk
oNe6iiQItHk6vw+mP5bFJfgWnuGyQtWK04XiR4yaE+1JdoLu4w1lyedjbqXOMDSDSD1E4iqj3wyi
k9gdYLFBsYTztuOOo3cXqsKSgG3zoG1MNNLmVGQlSWI9Fqg79V3J4LMG/ydV59fdu4J/ZaeWnmYT
tQY9ziHgeIn7BINp1fM8kK5l+0dJCUDE9hl0ljb3IOninwWKm2Wmqz9pvFMAB8hADbgQ7Ap9xUvj
MMsY0oHlaY2Oj5ST9R5Mlt9Ni5swjs0GoN8uTe3lJ0jr1M7/2JSOzwr/vVtl9TKF8QNXQ445b7iq
9Elep2ohP1UVIqS6kw==
--000000000000de841105f996c4a6--
