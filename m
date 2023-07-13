Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1254C7517CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 07:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjGMFBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 01:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjGMFBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 01:01:18 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405E2106
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 22:01:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbd200d354so26665e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689224475; x=1691816475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ6rbCmOVvkU7gwPXYG+W6PR8anjrOyYapYT1bAbQZY=;
        b=jtn1FTOcHIVC5/hph6bu05oakBwSLJzkQQrJz4ZubqDCvIYiqlmfFBtSqnejkcohb1
         g9zMlNUeB3xBrVss316HyIMGpJ2TU4fgCWRyvq9134BiZtR5JMk1o6VbEkteaf19PrAM
         PwMkKjvzeLuYVmsZee0IUeAQl50sVJyuSzDYu+C6odW4CSbyCEfIE08R/bq5u/xP6TM9
         oyf7MA1dA7O19MmsvZEmESe18obVebPTVZuppt4NOYYpo4YQMf877z7MWcelmoFGmv83
         OOuedmiOPlblQD6qFxqdjHon3TK/MWLAsjILwB8WVMehVTEhjO5aiWLYJsEEjr4aARo0
         fbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689224475; x=1691816475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ6rbCmOVvkU7gwPXYG+W6PR8anjrOyYapYT1bAbQZY=;
        b=EJFNU1QLsdxdu7bp9NPbUdls5eIYARXgyc9XpV8Eiw0aF1GN4RZSZsg+RmjmAlkjEB
         s/pxCw7nTfaS51NMC+qMjvWjgQDQTk17L1/dpyfctDdHMIk0NZQO9NgurO+w8/gnOkJK
         KkS/8JXBRyhwCp4BMeNbo2tYlIacK28bSDzAyMvn+zFBoEdIAbJBUeAOaY9oyen8N2lr
         JKlqrl0rcNDdCUPzVsXVjpGWxwNkDsVVr+j7+5UINfl3El/dp9PdXhpKTSrSA/EIXElV
         hJFtSv+Ea/nJK2EbHQwaWDAzbJbmGAbR8a8Ok+7XOw5Gjv+uhSX8+wmoixpQMRzVRV2s
         11hQ==
X-Gm-Message-State: ABy/qLbcGIaMuDH6NIC3lDWQx2qlgxbSaOKQMGHDthmR7dHWULgL0sq/
        K5I3X5JrHIqjWTYkYhHgT165HfceLsP8hung6F+wOw==
X-Google-Smtp-Source: APBJJlHl0BMyAUvIbgVetiZ27JuP9li47AMi8iMY0P+VHB5dfvLG0LDMol2YeN5V0n7MUZKCAgjxUAA8EfKYoay7ytk=
X-Received: by 2002:a05:600c:2196:b0:3f7:e4d8:2569 with SMTP id
 e22-20020a05600c219600b003f7e4d82569mr166165wme.5.1689224475065; Wed, 12 Jul
 2023 22:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230704083206.693155-2-davidgow@google.com> <519844640ae6483c8059a6440c620e01@AcuMS.aculab.com>
In-Reply-To: <519844640ae6483c8059a6440c620e01@AcuMS.aculab.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 13 Jul 2023 13:01:02 +0800
Message-ID: <CABVgOSmrx=AJgPCb-if1KOBD9EBhSV8MSv3yg+otBC4aS+LD-w@mail.gmail.com>
Subject: Re: [PATCH] x86: checksum: Fix unaligned checksums on < i686
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cf17940600573820"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000cf17940600573820
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jul 2023 at 23:01, David Laight <David.Laight@aculab.com> wrote:
>
> From: David Gow
> > Sent: 04 July 2023 09:32
> >
> > The checksum_32 code was originally written to only handle 2-byte
> > aligned buffers, but was later extended to support arbitrary alignment.
> > However, the non-PPro variant doesn't apply the carry before jumping to
> > the 2- or 4-byte aligned versions, which clear CF.
> ....
> > I also tested it on a real 486DX2, with the same results.
>
> Which cpu does anyone really care about?
>
> The unrolled 'adcl' loop is horrid on intel cpu between
> (about) 'core' and 'haswell' because each u-op can only
> have two inputs and adc needs 3 - so is 2 u-ops.
> First fixed by summing to alternate registers.
>
> On anything modern (well I've not checked some Atom based
> servers) misaligned accesses are pretty near zero cost.
> So it really isn't worth the tests that align data.
>
> (I suspect it all got better a long time ago except
> for transfers that cross cache-line boundaries, with
> adc taking two cycles even that might be free.)
>

I agree that the implementation here is suitably ancient far from
optimal, but think the alignment issue in this patch is a separate
correctness issue. (Even if it's one which is unlikely to result in
real-world problems at present.)

There's probably a valid argument around whether or not the
checksumming code should be alignment-agnostic, or whether a 2- or 4-
byte alignment is something callers have to guarantee, but since some
effort had gone into making these work with unaligned data, I think
it's sensible to make sure those cases actually work, and so for the
KUnit test to verify that all these different alignments all give
correct results.

If it seems worth cleaning up / optimising the code more significantly
(maybe some of the people who really care have TCP header checksum
offload anyway), that seems like a separate task to me. Personally,
while I care quite a bit that 32-bit x86 is still working (even on
ancient CPUs), I don't really have the time to spend optimising it.
(Worst-case, if maintaining it gets too rough, we could possibly fall
back to the C implementations, though I haven't benchmarked them.)

-- David

--000000000000cf17940600573820
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBp
WsI1hnWwgUz/xZB47BwTZK01JyPANanxrxegB/pTfzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTMwNTAxMTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANouLkbmUaYgAT2nmcZf2
aQF9zmV4eRony04mu1Cfo+W0HSJ5GmJWoV+2nKKS1NppAwOBLevd7Vz44CaQzSOrrA8DWJ3slNV+
m1o8iD7kdO5UvBHMHDCzvU9eKgnBOpjkRCl9dlwXOStyobCYyLD2OReLPDAdk27M9eXTVPlMw3aV
5u/lntpu7TrvNR+xeS0jGCQe51wkbC+ft5QsnrQVSVWHM/xmjAkPbqGiQ9AYJK7UMrZ5HZTXxo4Q
v36TKHOLiXOUj7Rh0cjgK2KxgmUV2OvQsqXpcUQZjYA9OIBk02XNRGNLTpt1snE+3sfy4day/XBD
YUFDC4ZsZ82AmDZbhA==
--000000000000cf17940600573820--
