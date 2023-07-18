Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB27757756
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGRJDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjGRJDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 05:03:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670810E2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 02:03:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so48425e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689671020; x=1692263020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUwjY3iWWr45qqu5hLPI//mmH6nVemLSx5OexUNW3fg=;
        b=gV2ECSFKPQ3TdPxBRMRpUJclYnveAvkJ3gI4aYyxCBF/qg8juRaZ7wGOl1po/xoHVv
         T+x68rwqPM8TLg62l8+L6Xq5Bm7ByUggQk28jaho0mUOxG6hl+TzUDLYhj3RSqmtdzWA
         BmPcrBnOpRZJqfx8TyaNpqSm9KqNPiAQUs1BxDgsRMybYEA+TpIJNwo35VCqLffbPoAS
         EuxvNFYxUayM3NQ8/NVDJTJibBFcIdwNqQ9CRTc+aJxsFquXuCFpVRionjcr3oF75R+2
         l25Jz2VK7S+K0hzuRa9Z+0znBk83Dqfv2+rogShL73tpF1lMx2TKCUH5O/MXdjAMF9VJ
         giTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671020; x=1692263020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUwjY3iWWr45qqu5hLPI//mmH6nVemLSx5OexUNW3fg=;
        b=HVGiHPCD0Jeq6llUBlCoUdK4qMG/6L/ULniKsiKAJFOk+X3FEE6I2FiD+y7a0Lp7y6
         nHSsVUHl35uS2FiwYPMm47NhZrkaRj3MUSGJtfRaev4zqNBZChz4d2xPNiH71Yq5gFGi
         LFCHwlDk1h+mSHrI3cEOgoXfdYwZd3zZzXRih6pK7OjTpyTV0zDrxOMnIBx8yoFtmgi0
         5KXRWWhI5wqglDIpXlJ/KFIbRCd+X97PqmhDcrGjHI1lGBvkfzOt07oK6fIGrTveU0Ca
         TnFNiu9Vtt94mqWkP9oqGKjBmuCebUe7Od2iEgJ8kOr7yGqGr1U/dltBsfLM0sZTXgRS
         D0hQ==
X-Gm-Message-State: ABy/qLYy/RTKyCMPjJ/5QP6FSj2dK8DQ4uvFhRqh5PqEi15Hpp7X/ysW
        Yii0ldiqaZDXfBJbZdnEFIy1txg/7ZJMJ26dfGzB8g==
X-Google-Smtp-Source: APBJJlEhIN82ETjhMNVU+3kG/yISm0CnrlIrrSeNDSYNi9ZIblw2P1wBfFAI7v4HuaNP1DrIaioPeWtFsqgKXdej4Qc=
X-Received: by 2002:a05:600c:358d:b0:3f1:73b8:b5fe with SMTP id
 p13-20020a05600c358d00b003f173b8b5femr56294wmq.3.1689671020609; Tue, 18 Jul
 2023 02:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org> <20230718-asoc-topology-kunit-enable-v2-1-0ee11e662b92@kernel.org>
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-1-0ee11e662b92@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 17:03:27 +0800
Message-ID: <CABVgOS=pfVkNFT5E0ERgEpCeCoaYi4dmCBjG2H3=w1Eddgh7_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] driver core: Provide stubs for !IOMEM builds
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fe246f0600bf30a8"
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

--000000000000fe246f0600bf30a8
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jul 2023 at 08:29, Mark Brown <broonie@kernel.org> wrote:
>
> The various _ioremap_resource functions are not built when
> CONFIG_HAS_IOMEM is disabled but no stubs are provided. Given how
> widespread IOMEM usage is in drivers and how rare !IOMEM configurations
> are in practical use let's just provide some stubs so users will build
> without having to add explicit dependencies on HAS_IOMEM.
>
> The most likely use case is builds with UML for KUnit testing.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

This is really nice, thanks: we've definitely wasted^W spent a lot of
time adding the appropriate IOMEM dependencies when trying to setup
KUnit configs, so I'm looking forward to not worrying about that
again.

We have considered implementing fake versions of these specifically
aimed at testing, and are looking into the PCI-over-virtio
implementation in UML's LOGIC_IOMEM feature, which allows redirecting
IOMEM accesses to something more test-friendly.

Neither of those conflict with this as a fallback, though, and I'm all for it.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/linux/device.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index bbaeabd04b0d..6731d7dc1a2a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -349,6 +349,7 @@ unsigned long devm_get_free_pages(struct device *dev,
>                                   gfp_t gfp_mask, unsigned int order);
>  void devm_free_pages(struct device *dev, unsigned long addr);
>
> +#ifdef CONFIG_HAS_IOMEM
>  void __iomem *devm_ioremap_resource(struct device *dev,
>                                     const struct resource *res);
>  void __iomem *devm_ioremap_resource_wc(struct device *dev,
> @@ -357,6 +358,31 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
>  void __iomem *devm_of_iomap(struct device *dev,
>                             struct device_node *node, int index,
>                             resource_size_t *size);
> +#else
> +
> +static inline
> +void __iomem *devm_ioremap_resource(struct device *dev,
> +                                   const struct resource *res)
> +{
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static inline
> +void __iomem *devm_ioremap_resource_wc(struct device *dev,
> +                                      const struct resource *res)
> +{
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static inline
> +void __iomem *devm_of_iomap(struct device *dev,
> +                           struct device_node *node, int index,
> +                           resource_size_t *size)
> +{
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +#endif
>
>  /* allows to add/remove a custom action to devres stack */
>  void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
>
> --
> 2.39.2
>

--000000000000fe246f0600bf30a8
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBu
vqDJUxTytrhJE2bob91KhgkIv/9swMczMBWhkF+rdzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwOTAzNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAekEp47TivOGaMtuI6rfL
P5wj5Xf0f6E5iAM/I7TkUsZyeWTXZTpHz9Z9F9mJ2VZi+iyS4ornFx8dXd0jigYMpmnafeH3vVNz
UNZfsbiZQXjAVySm2Ptz/kUQElI3eup8TOQorg3q4PKgM7TThToAncyiL58nWP5E7gAKsJ6zN6Rp
i7/fgsHmNqOfYZZ/f/tkUQHsF/DoVYwITbzmEO1dOne/kpKrAndLlbMCiQbtz+v5usZGU6CNrxl4
eraVauB4RrInENubyHnAi+VsFq93RM4ro6ROuP+32J/kFFvvKfjgvhxYasL2LwcpCTJ+dIhIjtoQ
pPzWphHaFgpH2/t2KA==
--000000000000fe246f0600bf30a8--
