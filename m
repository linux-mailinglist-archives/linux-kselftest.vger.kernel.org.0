Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDF572A8FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 06:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjFJEQO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 00:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjFJEQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 00:16:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE530F8
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 21:16:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso12975e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686370569; x=1688962569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oprXkvbBQedAlNM6Op3YLZMMFAjfHZ6DH1DVxsLXUKE=;
        b=rqohDBWMTtsDiBGBTWWgo3yv2+GMQxGP50unqobDJiuepKfiKe0ZMav5d/tz8iU8uT
         hoiNDtIJORSpkcfRtMqOaPBPUrMr1hlHocjosoYsEx+blvjWaTFECFSzZ85rWkAmBh5Q
         iOmVrV6xzO7LlZ2lRfmR3P1qCXT+RfKIAimWOpAZzWOYiPpKYJJje6DApyYhjgPUm0Is
         k8xq52+KjN1SDG3ib6+5PmD3IG58BnsLfMzT+TQi0K60uH+KXCQjJRl4h9AcZkDwfmar
         L56713u7vz64eWdXj0zmEEJJcykyBOj9beOvDy94AOVmwF/Yxgl7FkW0AhZsc4GGVRRd
         bPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686370569; x=1688962569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oprXkvbBQedAlNM6Op3YLZMMFAjfHZ6DH1DVxsLXUKE=;
        b=IpuWl2F0lSBqDLFquSyuG6LlGK1AggdLW1qhC2asi8qdcS19Oiz2H51JvznvfAS6hO
         H3zj4UgWuGpsH/BlJ/6g8VR3Swv+JWj4yTMkis1NViDbPP/+rDar4nZgCDlf05sxpsTb
         XdWIChZZ46doausGkPx4nFje9QnB0PKDXq3nsb0n8PCgbsClqm9znftlLjzSb1HSp0Aq
         rKIEkw1aBrEpdsA7FbAWGtVnk0nWNz5MXfd1q9pcw6l0XJDBA+hkmrWEbKB1mbqHO5u+
         nJNIZ55ynXK4r5KEMwxz7QJII2j5LoWTQTkLC65YaxeXFy2td4luYdUXEbSNnve0O77+
         +Zkg==
X-Gm-Message-State: AC+VfDzDCS0nM1gj6u9heKo3o+9FJbw8o03ag8sx2PNbPO8Q9njED70H
        s0f8KQRI7NwVoPU8pYIithoLPdsLrcir3U5HtWaVzw==
X-Google-Smtp-Source: ACHHUZ7k1RHbRgub6JjSGy+nbAZjjpWXOTHS9XziC6d9sYv0to3xvECy6ULY35EvOMaToWiHaj1RioMbc4OhhPiVfFs=
X-Received: by 2002:a05:600c:19cf:b0:3f7:ba55:d038 with SMTP id
 u15-20020a05600c19cf00b003f7ba55d038mr52355wmq.6.1686370568882; Fri, 09 Jun
 2023 21:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <CABVgOSmUxDoWHWOaJYmayCE8FnfS5bUoAJoosO44x=gwKdtLng@mail.gmail.com>
 <20230609190936.30045-1-sj@kernel.org>
In-Reply-To: <20230609190936.30045-1-sj@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 10 Jun 2023 12:15:55 +0800
Message-ID: <CABVgOS=wR0J9X1VaU4eOOb_VZRLV0nmj860B1pyq97EvCnbe2Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
To:     SeongJae Park <sj@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, johannes@sipsolutions.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000be2b4a05fdbebe2f"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000be2b4a05fdbebe2f
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Jun 2023 at 03:09, SeongJae Park <sj@kernel.org> wrote:
>
> Hi David and Brendan,
>
> On Tue, 2 May 2023 08:04:20 +0800 David Gow <davidgow@google.com> wrote:
>
> > [-- Attachment #1: Type: text/plain, Size: 1473 bytes --]
> >
> > On Tue, 2 May 2023 at 02:16, 'Daniel Latypov' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > Writing `subprocess.Popen[str]` requires python 3.9+.
> > > kunit.py has an assertion that the python version is 3.7+, so we should
> > > try to stay backwards compatible.
> > >
> > > This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> > > pre-existing `mypy --strict` errors and update run_checks.py"), since
> > > mypy complains like so
> > > > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
> > >
> > > Note: `mypy --strict --python-version 3.7` does not work.
> > >
> > > We could annotate each file with comments like
> > >   `# mypy: disable-error-code="type-arg"
> > > but then we might still get nudged to break back-compat in other files.
> > >
> > > This patch adds a `mypy.ini` file since it seems like the only way to
> > > disable specific error codes for all our files.
> > >
> > > Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> > > but I think being explicit is better, particularly since most kernel
> > > devs won't be familiar with how mypy works.
> > >
> > > Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> > > Reported-by: SeongJae Park <sj@kernel.org>
> > > Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > Thanks for jumping on this.
> >
> > Looks good to me!
> >
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Looks like this patch is still not merged in the mainline.  May I ask the ETA,
> or any concern if you have?
>
>

We've got this queued for 6.5 in the kselftest/kunit tree[1], so it
should land during the merge window. But I'll look into getting it
applied as a fix for 6.4, beforehand.

-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=e30f65c4b3d671115bf2a9d9ef142285387f2aff

--000000000000be2b4a05fdbebe2f
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCb
dH22xlugJzquFrzDYZq5dgwMUtUYchyo6BAJ4qrjhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA2MTAwNDE2MDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgg4cNEWOyLXf1mvMLyQu
s1jy2A3nyzVRrSs/6o9krNLkBeVISP4uen0KEH6ahL3NsWRks1Qm6CSKlVHXcDOQgSRx5UG42Wpq
BnqX5vLqoJ5thB2ezgl9LGWqq7PD2PMtUSLWTyfEhbCE2uhZ5VoJq90tZTVwpo5BqoThmzoFDaUG
OJCrF3LqTcplojL/SBb5+7VJ5vbRWMgIlmUQxfDKksxYmnnlIVkbwhnmPsEl+gOSSu0KyIISh2NY
aHsixXEQVmejYCSiB3qCYTDlseqCvWMnySm4QF2xvcJ+9/mDVUSi67pnipbvThDdDVAQ1Q+WjbF0
r2L4n4TBdObZZT0xmw==
--000000000000be2b4a05fdbebe2f--
