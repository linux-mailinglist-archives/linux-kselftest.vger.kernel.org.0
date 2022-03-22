Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49E4E37D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 05:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiCVEMS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiCVEMQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 00:12:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5946B0A
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 21:10:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so661840wms.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Mar 2022 21:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGc7GP90xUaut81Qlr7JtesYmzQSYdr8P7nPLZfvzX8=;
        b=cxzRih6KfFD1Lnh5nNkFwK0dlB5tAN9bzqdgOQBajoer8+DAmwiFv86BWEbBNDj/Sj
         olPcBWUTQWs8w6wilct2/vYj1iWZxeMzu7GCpO+Ls5fURhzMY9FXcilkBCpUx2GTxuIk
         TknJSgiomGqj/bW0uXx7+9FYYCYa8tl0CCKlyEcu9+/R0I4eCnUtyUArg8QZLiF+/h3k
         4oNK9w1nmag9/O4M+7zopTZeSMOw2OYx+X2vtngfJs/2sxcw1uyiQFjoZ3RnyJAaHF3l
         qpiwd5ehn35HBL4KnDFjX0x8XFhIaJuQW1Z5SnZd4ZJnn5pF7Q4vWYcWpt5FcAIu4Cmo
         oHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGc7GP90xUaut81Qlr7JtesYmzQSYdr8P7nPLZfvzX8=;
        b=OYPo6MGjh3CklIM95u3G6oUfPw13VY1pbdWzpx+IweWXUX0UWDeSbKIr3tPJAhoJN1
         MMeCpgBo9sCvEAOZd5lR8dY45Tcb6PI9Ltv8CA0YIlkruY7ZhsTsBpcdIuWjRJV8sYpg
         SDg0Pq0qf+2/l9iWFF0QcgPRhSJBuazfFMitsSvflLVWlo59IcDg1Y+OaCth1OG5pt/b
         sfIYXdporBhIiJpvzUB344AUJWPgiunR4jOsSTrd4Ksu4zY1qOZ9mVn6NXJcAPi8yEjZ
         IEad3q3y4Po0tn0fIHSMUW3ReJAfT/GXNauiJnKbGZqTFCHNW8/2Ffufj5S4w4yn5qpm
         xC8Q==
X-Gm-Message-State: AOAM532sD4UtLKBDZX9vNrP8EIlSBxRH7H8wa9QfJdAVlC2/3XSohmM2
        9orgf+yOSwwatQXlpQ1aFzgMl6TJkOCognJMqvgyJg==
X-Google-Smtp-Source: ABdhPJzYKzIMfHRYYMLMkDHMUe/IqrQoW3vgcFNbGtwvm0O3tLejBY2XOdVu8cR2PAdw0dqRFkib7uNhHl5VGvDIElI=
X-Received: by 2002:a1c:f20a:0:b0:38c:74ad:14eb with SMTP id
 s10-20020a1cf20a000000b0038c74ad14ebmr1913185wmc.44.1647922248071; Mon, 21
 Mar 2022 21:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220319055600.3471875-1-davidgow@google.com> <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
In-Reply-To: <CAGS_qxpqcc8O2HpmF3qB-uzXZrDNg9=h3nE_f7si=aOxXkRA+Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Mar 2022 12:10:37 +0800
Message-ID: <CABVgOS=sKWiDLN=GgyXQGOdmRn6t35mEA_0C7GrZyEApjVg1Pw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Rework kunit_resource allocation policy
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003de87f05dac6cc04"
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

--0000000000003de87f05dac6cc04
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 22, 2022 at 9:57 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Sat, Mar 19, 2022 at 12:56 AM David Gow <davidgow@google.com> wrote:
> >
> > KUnit's test-managed resources can be created in two ways:
> > - Using the kunit_add_resource() family of functions, which accept a
> >   struct kunit_resource pointer, typically allocated statically or on
> >   the stack during the test.
> > - Using the kunit_alloc_resource() family of functions, which allocate a
> >   struct kunit_resource using kzalloc() behind the scenes.
> >
> > Both of these families of functions accept a 'free' function to be
> > called when the resource is finally disposed of.
> >
> > At present, KUnit will kfree() the resource if this 'free' function is
> > specified, and will not if it is NULL. However, this can lead
> > kunit_alloc_resource() to leak memory (if no 'free' function is passed
> > in), or kunit_add_resource() to incorrectly kfree() memory which was
> > allocated by some other means (on the stack, as part of a larger
> > allocation, etc), if a 'free' function is provided.
>
> Trying it with this:
>
> static void noop_free_resource(struct kunit_resource *) {}
>
> struct kunit_resource global_res;
>
> static void example_simple_test(struct kunit *test)
> {
>         kunit_add_resource(test, NULL, noop_free_resource, &global_res, test);
> }
>
> Running then with
> $ run_kunit --kunitconfig=lib/kunit --arch=x86_64
> --build_dir=kunit_x86/ --kconfig_add=CONFIG_KASAN=y
>
> Before:
> BUG: KASAN: double-free or invalid-free in kunit_cleanup+0x51/0xb0
>
> After:
> Passes
>

Phew! :-)
I'm glad it works.

> >
> > Instead, always kfree() if the resource was allocated with
> > kunit_alloc_resource(), and never kfree() if it was passed into
> > kunit_add_resource() by the user. (If the user of kunit_add_resource()
> > wishes the resource be kfree()ed, they can call kfree() on the resource
> > from within the 'free' function.
> >
> > This is implemented by adding a 'should_free' member to
>
> nit: would `should_kfree` be a bit better?
> `should_free` almost sounds like "should we invoke res->free" (as
> nonsensical as that might be)
>

I think I had it as should_kfree at some point. I agree it's a little
clearer. I'll rename it back.

The other option I considered was to have a "flags" member, of which
SHOULD_KFREE could be one. Though I eventually decided to leave that
until we needed another flag.

> > struct kunit_resource and setting it appropriately. To facilitate this,
> > the various resource add/alloc functions have been refactored somewhat,
> > making them all call a __kunit_add_resource() helper after setting the
> > 'should_free' member appropriately. In the process, all other functions
> > have been made static inline functions.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Tested-by: Daniel Latypov <dlatypov@google.com>
>
>
> > ---
> >  include/kunit/test.h | 135 +++++++++++++++++++++++++++++++++++--------
> >  lib/kunit/test.c     |  65 +++------------------
> >  2 files changed, 120 insertions(+), 80 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 00b9ff7783ab..5a3aacbadda2 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -36,11 +36,14 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
> >   * struct kunit_resource - represents a *test managed resource*
> >   * @data: for the user to store arbitrary data.
> >   * @name: optional name
> > - * @free: a user supplied function to free the resource. Populated by
> > - * kunit_resource_alloc().
> > + * @free: a user supplied function to free the resource.
> >   *
> >   * Represents a *test managed resource*, a resource which will automatically be
> > - * cleaned up at the end of a test case.
> > + * cleaned up at the end of a test case. This cleanup is performed by the 'free'
> > + * function. The resource itself is allocated with kmalloc() and freed with
> > + * kfree() if created with kunit_alloc_{,and_get_}resource(), otherwise it must
> > + * be freed by the user, typically with the 'free' function, or automatically if
> > + * it's allocated on the stack.
>
> I'm not a fan of this complexity, but I'm not sure if we have a way
> around it, esp. w/ stack-allocated data.
>
The other option is to make all resources allocated with
kunit_alloc_resource() require a non-NULL 'free' function which calls
kfree() itself. This is much simpler on the KUnit side, but does put
some of that burden on the user (and may prevent a free() function
from being shared between allocated and non-allocated resources).

> Perhaps this would be a bit easier to read if we tweaked it a bit like:
> "freed with kfree() if allocated by KUnit (via kunit_alloc..."
>
> Maybe we can drop the "or automatically, if it's allocated on the
> stack" as well.

Yeah: I'm not 100% happy with that wording. I wanted to make it clear
that there are cases where no automatic freeing is needed, but I agree
it's really just making things more confusing.
>
> A bigger way to simplify: perhaps we should get rid of
> kunit_alloc_and_get_resource() first?
> It's only used in KUnit's tests for itself.
> They could instead use kunit_alloc_resource() +
> kunit_find_resource(test, kunit_resource_instance_match, data).
> We could even define the helper with the same name in kunit-test.c
> (the only place it's used).
>
> Alternatively, we could make it an internal helper and define
> kunit_alloc_resource() as
>
> void *kunit_alloc_resource(...)
> {
>    struct kunit_resource *res = _kunit_alloc_and_get_resource(...)
>    if (res) return res->data;
>    return NULL;
> }
>
> ?
>

I was thinking about this a bit this morning, and I think we should do
the opposite: get rid of kunit_alloc_resource() and leave only
kunit_alloc_and_get_resource().
Then, split the resource system basically in two:
- The system for managing "findable" resources, whose main purpose is
for cases like the KASAN integration and the stub stuff where main
goal is tying some named bit of data to a test, and reference counting
it so it can safely be retrieved and used throughout the kernel if
need be.
- The simpler "free this on test exit" system, which could be as
simple as a kunit_defer(func, context) function built on top of the
former. This wouldn't need detailed tracking of reference counts, etc,

(tl;dr: I think that kunit_alloc_resource() is broken, refcount-wise,
if we're trying to implement the first kind of system, but useful for
the second, and this is quite confusing. So kunit_alloc_resource()
probably shouldn't be used alongside kunit_find_resource(), as there
could be a potential race condition. Now, this shouldn't happen in
practice, as most tests are single threaded and none are doing fancy
things with kunit_remove_resource(), but
kunit_alloc_and_get_resource() should be safer, as you're not playing
with a resource you don't have a reference to according to the
refcount.)

That's a more complicated refactor and redesign of the resources
system, though, so I'd rather fix this first.

Cheers,
-- David

--0000000000003de87f05dac6cc04
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCC
ka/aO7cUBBHmlYugZL22dGOy2dN5UWW8ArrGdS7DPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMjIwNDEwNDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANMTA4YgcTHtNyANaE/x7
mu8YldhWvQw0IPmxRcVgjrfUVMyJXvC7zsSt64hDy7qeOo8TH5+jyMNHCs0B/y8IU5F9VX+m7KeB
FhSUtARM0IGLTByEIsdPJ/SKU7eugsV0ndbRQZWO15x0YIwFOoIrSaoMrNjBHLMqO0LFU6sJCTpE
9v1mfirHid+UkR+6L91vV+I7bTys+yPaUxbVAMXUupqtTnawfuyr7wII0TUej7+bzgopuouvMb63
/y0zaHvzHDovrRWUoA2gfef4U+ZxpaCO+73ZMbAmKYeRWl6fPxFe+od36dqQuB67vgL691fo8+4a
+77XvLp+6DjBMM0paA==
--0000000000003de87f05dac6cc04--
