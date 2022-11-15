Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF96292A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 08:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiKOHpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 02:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiKOHpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 02:45:49 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517051CFFF
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 23:45:48 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id k67so13899861vsk.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Nov 2022 23:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i6xlvU5HxbhtaKVd4RKdmdCFKQuMcprP9+a+oBVV6xE=;
        b=niCHPhGpg5nKI9Dxeps8dw08XYsYFDeyEjGo3Ff3Mc9UjFjM6zwZXg78jrRzvu0zzw
         03Q8Vb+IR1ZwOM0goP2WchucyMd0RE10D/iDE2YvUcv6gL+FM8c0RneuVkaCq+KDtzmP
         QC+GG+XxLqlSckyrN6r7mUE3dGMvbOh4swXJ/LqTzrF35FJgCVyn3KIeER9iIZnsVCKP
         WograqlNk4i7zzvKhNGEIXRD78aN5hA/LN6bFj64+8FxMIGzPRPkib1ONkiIXhklShLW
         BJtotbKH076sEIeFc1kuniz73cKLegy13QjGA0CrioYm8AaqrUmIlZl0EjroguquFZIE
         xYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xlvU5HxbhtaKVd4RKdmdCFKQuMcprP9+a+oBVV6xE=;
        b=Rl5sIWfQX4BgV9vD6W9CrNFHKm8SN1J6RHqC5X6gd4xjxcH3ZZok7JMRfQI/gknPAj
         o3jlq3kTRV15AnCzkk2yE2lDmBSs/JAIKXPd2/6FGZ/sLDm5FkrSupNd4mfBcP5djuPS
         LGVYHooFY3Yc0dPvBYB5EQ5eeZhniys4/rYfRauiIrDppGCyxJojTQD96k8K4RGJcIXG
         TkpEhObEa9fcAqe+zOTUiAzsApdJQ14Cx4KPu3AIzi3OFw6F0CmiCnlPsYGLQpa8Gp6/
         kFKMxapb2bxsNWNi++mXHuDQw6bF+JkRyjUX4NppjqH8wzKMZzBmTooZlYjEzlL1P9/P
         l6WA==
X-Gm-Message-State: ANoB5pmtcLg2+wtFILemB4oea7RLRhJ8rTO6XPLXT2N43n9s5LzMyGR/
        D7H4zTlxkJj1TGAuFlvCZJTeRRhjEzac/wGgX56euw==
X-Google-Smtp-Source: AA0mqf7PeKluhJAomvFVsLKMa909CV8f+gD47cZDKckRtBI8IX06Q1KpQya8T2U05sMxOVNvoFnkar/MfgMNPVGyHLI=
X-Received: by 2002:a05:6102:cca:b0:3af:2b1c:9908 with SMTP id
 g10-20020a0561020cca00b003af2b1c9908mr5889007vst.18.1668498347347; Mon, 14
 Nov 2022 23:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com> <20221109003618.3784591-2-dlatypov@google.com>
 <CAO2JNKUTiVM8YPgy0nz7W1GJtSVURhc1YkMgUWgs-rShNY0Zaw@mail.gmail.com> <CAGS_qxqPUHWyJ4nNQRdm79sMwHwysHV=99WXzMsY=g_WzSjZaw@mail.gmail.com>
In-Reply-To: <CAGS_qxqPUHWyJ4nNQRdm79sMwHwysHV=99WXzMsY=g_WzSjZaw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 15 Nov 2022 15:45:36 +0800
Message-ID: <CABVgOSkJGoyMrv-=Zd+8sveH0+04G4twmae+p+TJWdpB6SJ+FQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: KUnit: reword description of assertions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000051f7d305ed7d8ba9"
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

--00000000000051f7d305ed7d8ba9
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 11, 2022 at 12:04 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Nov 9, 2022 at 9:07 PM Sadiya Kazi <sadiyakazi@google.com> wrote:
> >
> > On Wed, Nov 9, 2022 at 6:06 AM 'Daniel Latypov' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > The existing wording implies that kunit_kmalloc_array() is "the method
> > > under test". We're actually testing the sort() function in that example.
> > > This is because the example was changed in commit 953574390634
> > > ("Documentation: KUnit: Rework writing page to focus on writing tests"),
> > > but the wording was not.
> > >
> > > Also add a `note` telling people they can use the KUNIT_ASSERT_EQ()
> > > macros from any function. Some users might be coming from a framework
> > > like gUnit where that'll compile but silently do the wrong thing.
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > Thank you, Daniel. This looks fine to me except for a small typo in
> > this line "to abort
> > the test if we there's an allocation error". Also, I have reworded
> > that paragraph a bit
> > as below. Please feel free to ignore, if you do not agree:
> >
> > In this example, to test the ``sort()`` function, we must be able to
> > allocate an array.
> > If there is an allocation error, the test is terminated using the function
> > ``KUNIT ASSERT NOT ERR OR NULL()``.
>
> Thanks for catching that.
>
> Hmm, I slightly prefer the current structure since I like having the
> <thing> being described near the start of the sentence as opposed to
> the very end.
> I'll wait a bit before sending a v3 to give time for anyone else to
> chime in, if they want.
>
> Snipping the email to the block in question:
>
> > > +In this example, we need to be able to allocate an array to test the ``sort()``
> > > +function. So we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()`` to abort the test if
> > > +we there's an allocation error.

+1 for the patch from me (modulo the "we" typo Sadiya mentioned).

I otherwise also prefer Daniel's original here (though I'd possibly
merge it into one sentence, personally).
Maybe:
"In this example, as we need to be able to allocate an array in order
to test the sort function, we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()``
to abort the test if there's an allocation error."
or
"In this example, we need to allocate an array to test the sort
function. We therefore use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()``, which
will automatically abort the test if there's an allocation error."

But any of the above wordings are fine for me.

The note about ASSERT() working in any function is useful, though
there are definitely some "gotcha"s caused by killing the kthread
we'll need to resolve. (If there are any dangling references to things
on the stack, for example.) Still, not an issue for this bit of
documentation.

Reviewed-by: David Gow <davidgow@google.com>

(Once the "we" typo is fixed.)

Cheers,
-- David

--00000000000051f7d305ed7d8ba9
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBk
v650JQpZ6kM1j3A7JkLBCIbW8/t25s26tSpoc1VqGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTUwNzQ1NDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAi7RUgQvVE4XXRhg+Tr+a
djxk3G/xivj98RQZTZuazmbbIMQKL6VJ+dfHH5+70x6fkeEBj/lphjSmhx7s8HY4qqvQOXcFh0TC
xLd43v0HrvbvZ02ZTD1wuFUUDhy0YCcsUlnZ71nAcouefjEVEOruLDiji4JZoXoG/giRtnpAYNxe
E9y5J7fYHMugGtFG5JdsOY90qzIAv95dsCs+RpK7shy57v2n4Sp59o2RXxoeiKqY8BZyOKsi5Hij
gWw3I5IPV+vEL/0aBPYc3LRjhhCdhe7HPyBAA1iwWnS/u8E1GPzgnEaa8iUy50GsrlblAABPT7dr
5N9BihHV7v0xweGoBw==
--00000000000051f7d305ed7d8ba9--
