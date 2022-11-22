Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69963335D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 03:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiKVCdo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 21:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiKVCdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 21:33:38 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F5DC6201
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 18:33:35 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id p4so13150848vsa.11
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 18:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rtkq668h4ftwbMxTrB4kyp/qT6Jx6sbbfiXnxcO9+lc=;
        b=qyB0MfWr2sENR/2PoUdnOVZ5vG3xhBpOSMuW1qE2+9vYL385Z+078XHoZX6eXH6bYj
         saslb3GQN1NeFmp4USI/iNuMBTrc0TZbr3WpG6ffFWQNjebfvz4N6qqDOLhu73PP/GWO
         7bdzlXqPq6rPJ1cHOrCxpB1Y57rEpVJnLTF3PxP2L/5YMApok8bKqOghyk2DVosPcph3
         dCHdlaOZrSlesDDdXAqYUCE8+U/JOFmRub8oMj7gSnTAWDwDhfcypeuuRf3rWh0mpTv1
         7RR5D/uFfeZwjVwDp8WOwHfCijurUIWXV/DyX41kRYUGSvsaweXl4HN6OrMlJrysd7NX
         7cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rtkq668h4ftwbMxTrB4kyp/qT6Jx6sbbfiXnxcO9+lc=;
        b=FCWKbYTl2Z2uNevIhQHq1f0lJOG+8ZRnZduZNwrCepcGKSkKROkBOokRHQnFEJ0B4G
         uLmKnwj5d1BeOt1Wmg3SXZV0QtcGpdGmQupnJLQL2LnRPg/qkrjxHbX3kO8VIb29VwER
         VcR7nGydp+sp+nn0fkop3f7UR1p0R4Hb+tXWcWioPbH6MlMfHupAPlTn8c8NNNZ5DS5r
         3d97KUuKY1rBBDUfFX7yU398KmWAdIFK+0JskzeDYvHfq1EJP+Xrn+DhY+2hl9rFEcXK
         e8FhH0/BBRdLns1SgdViKAr54rEqBAuf8HmqtfntR0baEzON5ol6PBfNPlt37ioXZ8tx
         +4sQ==
X-Gm-Message-State: ANoB5plr0XY8IVJr9DQKRr5WqjfJwX940oLABpOlwafqNizu6qvjohwg
        dQeGIOhVi2NRfNKSK3JBn7je5Fu7j/5sSypEVtZwqQ==
X-Google-Smtp-Source: AA0mqf5MAfaioZ0EUm0FlE61WLe8ddd8Nf8Kf1FmOcF5K55NOLUo823Awh7r2j31j8xuEXeBuAlOs3MY49XALduv9Tw=
X-Received: by 2002:a05:6102:2259:b0:3aa:2412:8f8 with SMTP id
 e25-20020a056102225900b003aa241208f8mr2088335vsb.35.1669084414281; Mon, 21
 Nov 2022 18:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <CAGS_qxqyyH-v4wMJyD1phPP2YA5_6L98C-t4cJtt_SYsSvR3Ag@mail.gmail.com>
In-Reply-To: <CAGS_qxqyyH-v4wMJyD1phPP2YA5_6L98C-t4cJtt_SYsSvR3Ag@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Nov 2022 10:33:22 +0800
Message-ID: <CABVgOSnx8s0wL1xYEpwV0+FhyQUhbOVGWWuwpO9rfknSmbhroA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a1fcf805ee05ff3a"
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

--000000000000a1fcf805ee05ff3a
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 22, 2022 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Sat, Nov 19, 2022 at 12:13 AM David Gow <davidgow@google.com> wrote:
> >
> > KUnit does a few expensive things when enabled. This hasn't been a
> > problem because KUnit was only enabled on test kernels, but with a few
> > people enabling (but not _using_) KUnit on production systems, we need a
> > runtime way of handling this.
> >
> > Provide a 'kunit_running' static key (defaulting to false), which allows
> > us to hide any KUnit code behind a static branch. This should reduce the
> > performance impact (on other code) of having KUnit enabled to a single
> > NOP when no tests are running.
> >
> > Note that, while it looks unintuitive, tests always run entirely within
> > __kunit_test_suites_init(), so it's safe to decrement the static key at
> > the end of this function, rather than in __kunit_test_suites_exit(),
> > which is only there to clean up results in debugfs.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> I didn't know anything about the static key support in the kernel
> before this patch.
> But from what I read and saw of other uses, this looks good to me.
>
> One small question/nit about how we declare the key below.
>
> <snip>
>
> > +/* Static key: true if any KUnit tests are currently running */
> > +extern struct static_key_false kunit_running;
>
> Is there any documented preference between this and
>   DECLARE_STATIC_KEY_FALSE(kunit_running);
> ?
>
> I see 89 instances of this macro and 45 of `extern struct static_key_false`.
> So I'd vote for the macro since it seems like the newer approach and
> more common.
>

Yeah, there was no particular reason I put 'extern struct
static_key_false'. I'll change it to DECLARE_STATIC_KEY_FALSE in v3.

Cheers,
-- David

--000000000000a1fcf805ee05ff3a
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC+
V/umKzg1H9w5g8klSbNB6AdIDLatxCbtpmOmEgN7WTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjIwMjMzMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkp1coe0aJQSC5h/usKny
1U6iuC+Z2NLK82j+DjWEQ+yIfX2QgtVhP6dr8BAFxMqDKYsw22HnrHy463KDq1o1Lwr4gllvo4GS
2j8YQ/zaTkm7n44bmWhVI/nC8zyXxLj8xe4aSnuuNLIww3Q4W6LAqQsD70NpzGUwwPQePTSKWNSl
K/hIgXvjoEmRojhCSHaCjQW8I+zPNJlbIXdJ3tfg9s3jpqqpJqulBk3LoHgoJ1Wo36K18SliXUxY
78NdiqVbtjr5KoEOiY9W9uiDSnIq/miknyP/Sx1wpSxZI3aIKRQbFTNWe/iZfGZ4GTnlWLw4gin5
9vkQfritR17Oic2vwQ==
--000000000000a1fcf805ee05ff3a--
