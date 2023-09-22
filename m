Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3E7AAA2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjIVHZe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjIVHZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:25:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C92AE63
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:23:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053a7b36b0so51325e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695367393; x=1695972193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owO2G7+kHzi3Lu12CSVESua2coGOVBHM+2DJNBB5XPg=;
        b=0Q2o3ZJ0k9A+mpGhpkX8Qya/N1MaYNFjOuUPllcq8V7GoobZ7kZQhmZaYy5lJcnsn2
         gpvlbLMAoKkRfa0haxZB2PU7A9s4cJCiq6cEDb6/MIz2Li1nN9Q0eGRARUVL6uMg3m4R
         afEMb79GfBep9zdoujII6sKbb4lsDeACF/DKW0GSX7PnwS1bd1snYeSiwu0XSfZG/+DF
         kzgS+y31/aKJyVfzysUwhNpbl74+5cpRFhHJQQVukeBo9Mr03iDjYjc2OMOZhfEeSG0l
         1FPLU8M8/9UpsshDR5jkeGTXz6dbMCdWXTXpUgMoyjtX/8QIxPnGoyh91hrjIzeCYhyl
         x7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367393; x=1695972193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owO2G7+kHzi3Lu12CSVESua2coGOVBHM+2DJNBB5XPg=;
        b=Y4rPQHz+BYeaILeTjvpqJZ7XiznQS27n3GcQipkHUxXvn2tGKgYbL/+wWd0jRcvJfu
         ReyiysaRcNzKaMpYLZBA+Nn7oKHB1/j2jN373YXlP2NGybYj1c0NNRBMVY3IpY30Dy6v
         E2z5tWOyazOp0qkhUOGWf5CSV6LgZY2gpxWvLLy2oKcenmaP+pyYVSttauuqnFUsRlMB
         2xmugHAGKqaiw6noohOqbSU57Wik6Lm/tIjcJeLM6QNnh6cdqHxACbKWscC9frkFJZZ7
         9rGs8x5tDDnkSlP8Y0QH3UGDp1iUmM+96xl0VyX5qWK8CgeF/1yoEYkjajlOGpOsMsoz
         Oc5w==
X-Gm-Message-State: AOJu0YxeLkHVo4DNG0Jw/SoRwnQpqfiT5he2W3oabDTE2KyC0PB7yQDa
        c4W1ZrO5ncTR2xciARa1r3XulVhtgrYC7CgCutmC7Q==
X-Google-Smtp-Source: AGHT+IFz5zZGP/nGmJ+xRB+rNqOo286jPo4uJd4tx+TcIcPVPH2xOKdKGl6PWwguEl8KbtuxDzA/VcUtVBxW/0kPDJg=
X-Received: by 2002:a05:600c:319c:b0:405:320a:44f9 with SMTP id
 s28-20020a05600c319c00b00405320a44f9mr28714wmp.5.1695367393295; Fri, 22 Sep
 2023 00:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230921081810.3584078-1-make_ruc2021@163.com>
In-Reply-To: <20230921081810.3584078-1-make_ruc2021@163.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Sep 2023 15:22:58 +0800
Message-ID: <CABVgOS=suPzTKOnGvPKzpA4LnJGkXBjwD0_xEN-r80-o=pT3_w@mail.gmail.com>
Subject: Re: [PATCH] list: test: potential dereference of null pointer
To:     Ma Ke <make_ruc2021@163.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000044df3a0605ed7bf9"
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

--00000000000044df3a0605ed7bf9
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Sept 2023 at 16:18, Ma Ke <make_ruc2021@163.com> wrote:
>
> To avoid the failure of alloc, we could check the return value of
> kmalloc() and kzalloc().
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---

Fair enough, though I'd want the test to fail in this case (or, at the
very least, be skipped).

Could we use KUNIT_ASSERT_NOT_NULL() here?

Furthermore, there are a few bugs in the patch, see below.

Cheers,
-- David

>  lib/list-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 0cc27de9cec8..9f82cac3a822 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -27,9 +27,14 @@ static void list_test_list_init(struct kunit *test)
>         INIT_LIST_HEAD(&list2);
>
>         list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
> +       if (!list4)
> +               return;

Instead, let's use:
KUNIT_ASSERT_NOT_NULL(test, list4)

>         INIT_LIST_HEAD(list4);
>
>         list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
> +       if (!list5)

Shouldn't this be in {}s? We don't want to return unconditionally.

> +               kfree(list5);

We shouldn't free a NULL pointer. Should this be kfree(list4)?

Either way, maybe we should swap the allocations out for
kunit_kzalloc(), which will automatically free everything on test
exit.

> +               return;

Again, let's use KUNIT_ASSERT_NOT_NULL() here. Or at the very least,
call KUNIT_FAIL() to make sure we're noting the test has failed.

>         memset(list5, 0xFF, sizeof(*list5));
>         INIT_LIST_HEAD(list5);
>
> --
> 2.37.2
>

--00000000000044df3a0605ed7bf9
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBS
Woxabsr4542V9QQ2Fbwp/ssOezSIAji9abbM+Nb6gDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MjIwNzIzMTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbHes8ZzXKqAQJL6NIwn9
f9DQ5itTnmra+CtKZGP8nf+SiQpaueuaukbiDeMElKzXklHqTFcIZXZhz/uxN9aplJbEhV/1eOkU
eTIrTniQAvSGDUgn1C3ON0KTAaJgSnF86KpRRLl2zKqZlzltEg5zocVZL1GTWFE83ku7UkZsoIcj
yvD8WNBoWoZht6p7PWGEbokS9HvQKNjhHhV5fUWMfeFsqYRexATs0FsOue+ni0L3Lf7P8dOYYOsX
4fq1bs9db31polgjZi3ROHtnp9962gqNOsRqY4BIPo83IIH7nqbwRQ7Ch4c7yEsTermYp11jbgHt
lDOMXcsd8j59+nB6uw==
--00000000000044df3a0605ed7bf9--
