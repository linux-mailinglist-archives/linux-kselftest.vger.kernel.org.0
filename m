Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584F66F3B2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEBAEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 May 2023 20:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBAEg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 May 2023 20:04:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0171723
        for <linux-kselftest@vger.kernel.org>; Mon,  1 May 2023 17:04:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3ef31924c64so6981cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 01 May 2023 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682985872; x=1685577872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpfLfHFESnnB439IODfm45I+jW3GyTZwUQ68Tu7KDi4=;
        b=0vYr5pZvStpjpMBu6/vI9hMGxp8ZYVZcJcmuX7hfT2pEo29bVO8YTe2ijQHz5ikoDQ
         ErVTa4uQXdRoANiz7hr4m2ZaWJnEg9QgFKEkJDD1AbD3FbdRV91YfredKD247UJtDT65
         tjJi9b0FclCJI+hgJblUtD89+WWrihN2idxDjKchiGXhUQY+NBdzFTVgIo4uGGkKlw+I
         mZIZxhPQ1H9rkRUgJYN3M0t5e6E6rhv+eVJutOGzMu5j8OX8XVOn4X5H1wHT0xTuSwN0
         Kwu4Q4wzPLBoTIPsmN8GOwtSSPE8tG7znP/oYOc4OC1Th3QrFw9etDsKQbARmViEZpSw
         1ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682985872; x=1685577872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpfLfHFESnnB439IODfm45I+jW3GyTZwUQ68Tu7KDi4=;
        b=EmxwhauwThjyWuD3clAu30b2bqf6wvmwFmNB6GdFWzyDNV1cEVmjykuBoMHpvko9jI
         8OvbQGJQKYEO0m3cPeuxonEhIMXjtzIbXw0Mr43kWtc0eVGrRjChegC5ehlV4rCfgyXc
         euLguLFCfGux/s6DXcfoaa+eqSPR4x7U5H5zBystTP5aLiPVFSBk7O1zaatnGOlzaSUa
         BnP+wD/uk0KW9vceFAHyu6JOKZgCx5P7FT5YXCS5YqTtOVDm0mCJWUDu3/yMnnXAh68G
         DQ3YVDovX+x/BB11cPg+pbM6exnr1NKH/2is0EvVTLxi7GT8EasEf0N0SL/gFcyPIUc6
         9idQ==
X-Gm-Message-State: AC+VfDxFEbvsMP83FXY+fblA/+UyjAgk2MZHUC0yLW2jLYPfdWex0NTt
        p5XzzwVRAWsCsJROaIYBb+QqZ2oWARW+zWPnaz+gmw==
X-Google-Smtp-Source: ACHHUZ6lV25txwlGog0+T2tYUycMIWmfKxxZwuBGiOweb2gcRc/tplOPiR9F3tGQkZytt0y8rSXxVAj8xRt9/VP5D9A=
X-Received: by 2002:a05:622a:198d:b0:3e0:c2dd:fd29 with SMTP id
 u13-20020a05622a198d00b003e0c2ddfd29mr171857qtc.4.1682985871808; Mon, 01 May
 2023 17:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230501181610.2617032-1-dlatypov@google.com>
In-Reply-To: <20230501181610.2617032-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 2 May 2023 08:04:20 +0800
Message-ID: <CABVgOSmUxDoWHWOaJYmayCE8FnfS5bUoAJoosO44x=gwKdtLng@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: undo type subscripts for subprocess.Popen
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        johannes@sipsolutions.net, SeongJae Park <sj@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000013299305faaaaff2"
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

--00000000000013299305faaaaff2
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 May 2023 at 02:16, 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Writing `subprocess.Popen[str]` requires python 3.9+.
> kunit.py has an assertion that the python version is 3.7+, so we should
> try to stay backwards compatible.
>
> This conflicts a bit with commit 1da2e6220e11 ("kunit: tool: fix
> pre-existing `mypy --strict` errors and update run_checks.py"), since
> mypy complains like so
> > kunit_kernel.py:95: error: Missing type parameters for generic type "Popen"  [type-arg]
>
> Note: `mypy --strict --python-version 3.7` does not work.
>
> We could annotate each file with comments like
>   `# mypy: disable-error-code="type-arg"
> but then we might still get nudged to break back-compat in other files.
>
> This patch adds a `mypy.ini` file since it seems like the only way to
> disable specific error codes for all our files.
>
> Note: run_checks.py doesn't need to specify `--config_file mypy.ini`,
> but I think being explicit is better, particularly since most kernel
> devs won't be familiar with how mypy works.
>
> Fixes: 695e26030858 ("kunit: tool: add subscripts for type annotations where appropriate")
> Reported-by: SeongJae Park <sj@kernel.org>
> Link: https://lore.kernel.org/linux-kselftest/20230501171520.138753-1-sj@kernel.org
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks for jumping on this.

Looks good to me!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--00000000000013299305faaaaff2
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDX
mQUJGaIzSqMUcTPBgB9F4fVCcsHK2pHUhQK4G3aXiTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA1MDIwMDA0MzJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAM+YtsTnrPOlAtGUJ5Chp
bv6C69yC5xSXEd7BImoTgcDrjVKUA3Ocf7siDs40OWB0DKZxs2NKCM/ZopYgjOg0Mo4bs26ZSLw9
pu1C06Qw/JBhshbJTzl5lFxzf1V4xlCUHj99OHHJn9iLFU8OnOKNYsvthlcDxa0psTHTy24qCgF4
BFfUsKX81PK2cnM2BhEUfrnrtwbZqrZcLetve57lEgyc/a2pYWvprAHS6BHjargAIrOvdSNNlTr5
/l5Z2PR85zQzM7oxu4la3wVMAuGd3ADDsqQOUQp1KPy798wl5MyXC49LOD5VJ6dXtiQ9TXtQGcqo
4cvq3S8mm3vb4xl48w==
--00000000000013299305faaaaff2--
