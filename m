Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722763853E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKYId2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 03:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYIdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 03:33:24 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430231357
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:33:23 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id x24so1318407uaf.4
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Nov 2022 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1xfDYPCqjhnOirhAgUNhzvQCH9Eq2waq7O3y2TwaHw=;
        b=p4j7XAvzmQVbf+IC2SC5cZMuKNJH4cuy/NLax99hOeLNeVeANPYEJxlrE7E3g2NnHS
         v3GiOMhjNDBLitClDrVZLrzAwe9rUklnjYCHESByewnnZk28/GghLN6obETtcHwoF/5U
         HuoXb0Fr814pjoVmP7Q7rb2qE8WROAg0FatUVC50KysbLT/HAprbnhhRrhNOGpt1TAcK
         AAalZ7qEHx+iDFtQHqEddX8KvzqtKRU8SBogNRrXKIDrjgUvP8lK0Q4r2+KTAFmCTAfs
         U6AaebWbdu3x+f0KiAZSPslO5UGfBm9+1EJhn/D8bt78IB/vuTe/M43hY8nxwUv7XIeC
         Si+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1xfDYPCqjhnOirhAgUNhzvQCH9Eq2waq7O3y2TwaHw=;
        b=sJ6W9dqN+v5kJ9zBdplZNZ7rLKKOoJ7OMgbZ6eBnMqadRT+USxHCIMfJZW0g/FzDCT
         xZCG3FoHkK+hnQnDa1qmh/bzOEDYfdHUAecIXiPI6mfOmXn4aelg+7NhTo6jbfdOjjRE
         ASZtd2nmzSKXjfpOfIKNDdaWpZ7DcXx0/E/4JD5qYExFJsxkaJG2yafxYl2HwfWUMnqc
         HqSuODrk8S0rvBH6HsgD4AvHxqndxsjpv4O1H5FrvoMgAFyOnLOhEsoZ0UoQckITbDV6
         PPS/z4a//pB1YIrTktKDEm+GCVjxqF2AUPsVJsuqs7JG7QT4qSNAOH6iwykMZESrSTfs
         i3Ig==
X-Gm-Message-State: ANoB5pnwSCmQGTqgLdri6Jeae7DwOW+sjFfGqyuNuneZng5WXHWNHrYN
        VxQUX3XWnFmUMA/trkXUfxOdiyd1/aw8DEXPn5bwcg==
X-Google-Smtp-Source: AA0mqf6wmh2+DIDulwYb7PQy32QEgIJ3iYVaTQ4wAK6I8iWQQZlxgcXCPLYzZGYTu7+Ao+Q0XPCK02SwGWl4aS8e5c8=
X-Received: by 2002:a05:6130:316:b0:418:b66a:6f26 with SMTP id
 ay22-20020a056130031600b00418b66a6f26mr11289425uab.21.1669365202876; Fri, 25
 Nov 2022 00:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com> <20221119081252.3864249-3-davidgow@google.com>
 <Y39Kz0hI3IOKoqrJ@hyeyoo>
In-Reply-To: <Y39Kz0hI3IOKoqrJ@hyeyoo>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Nov 2022 16:33:11 +0800
Message-ID: <CABVgOSmCdtnFatO+EU0T9fado1h7ZW0DAzO=Y2jPvt6mTmO57A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: slub: test: Use the kunit_get_current_test() function
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f039b705ee475f79"
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

--000000000000f039b705ee475f79
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 24, 2022 at 6:43 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Sat, Nov 19, 2022 at 04:12:52PM +0800, David Gow wrote:
> > Use the newly-added function kunit_get_current_test() instead of
> > accessing current->kunit_test directly. This function uses a static key
> > to return more quickly when KUnit is enabled, but no tests are actively
> > running. There should therefore be a negligible performance impact to
> > enabling the slub KUnit tests.
> >
> > Other than the performance improvement, this should be a no-op.
> >
> > Cc: Oliver Glitta <glittao@gmail.com>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: David Gow <davidgow@google.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> with small comment:
>

Thanks very much!

> > ---
> >
> > This is intended as an example use of the new function. Other users
> > (such as KASAN) will be updated separately, as there would otherwise be
> > conflicts.
> >
> > We'll take this whole series via the kselftest/kunit tree.
> >
> > Changes since v2:
> > https://lore.kernel.org/all/20221025071907.1251820-3-davidgow@google.com/
> > - Get rid of a redundant 'likely' (Thanks Vlastimil Babka)
> > - Use current->kunit_test directly when we already know a test is
> >   running. (Thanks Vlastimil Babka)
> > - Add Vlastimil's Acked-by.
> >
> > There was no v1 of this patch. v1 of the series can be found here:
> > https://lore.kernel.org/linux-kselftest/20221021072854.333010-1-davidgow@google.com/T/#u
> >
> > Cheers,
> > -- David
> >
> > ---
> >  lib/slub_kunit.c | 1 +
> >  mm/slub.c        | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> > index 7a0564d7cb7a..8fd19c8301ad 100644
> > --- a/lib/slub_kunit.c
> > +++ b/lib/slub_kunit.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <kunit/test.h>
> > +#include <kunit/test-bug.h>
>
> Is this #include needed in slub_kunit.c?
>

Yes: kunit_get_current_test() is defined in test-bug.h.

This header contains functions which are always available, even when
KUnit is not enabled.

(It's name isn't great: we may rename/refactor it down the line...)

Cheers,
-- David

--000000000000f039b705ee475f79
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD/
REs3LgjWnPyijJRNYhE0hnXx9xVprnQ+laPvvoEvNjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjUwODMzMjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQgQ0/kNimCRUd8gQda0L
9Rht9rpi9jPK58VEmWpy4zVD4gGAstmnBV0r4iET1TK9XzsJhlJ7X5hZSRfwRGIwYPCJ1JcJDyn9
i+57n4gti5WUUfpdH5tD8ToHFoajXXKhYbNI9eNXQTNlBRMN9PqH4pnvEdAVTF/5S1BGV36MpiYl
fZ5yxGlmPTkjLLbcminp4Q8Kc+F90706p1x9YSLxDPglmFLE6FT5d9zfTxRuMc+pKA26CxHbVMTV
HPEY9sHLmWb9h+eVa9rMejVKZhPWzzMRak5u+1YF32eueQW6Mhc389AMYnG+h0A1k+JDxs1cn+tw
P3XOMYM/o0XyVtXvjA==
--000000000000f039b705ee475f79--
