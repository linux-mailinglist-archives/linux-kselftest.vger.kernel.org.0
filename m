Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A369CF53
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Feb 2023 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBTO02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Feb 2023 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjBTO02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Feb 2023 09:26:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A91A655
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 06:26:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b14-20020a17090a8c8e00b002349579949aso1492495pjo.5
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Feb 2023 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dEs1Ok/fdDnJQra/pJxHBiryaB5u/skacMp/2EbjBWg=;
        b=fsjSUFuygnYImrXb1V2TzZBBZaGU/r3W+AzUd3ilLDervbS5KUSqRt03BvAKqBiMXV
         kztWOFZce3NCXwkL6mtZ5DhSGLy2LFuIOYd+Xladst6ylQA3CKXWLSnjmtzvFgoCvkdz
         MHTATMj1ArrPSFVJK3sWPOTMARHmn+l0+ojPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEs1Ok/fdDnJQra/pJxHBiryaB5u/skacMp/2EbjBWg=;
        b=GUOHSD8OVh662qKxtSe8/SjKbF5w1FYz2VisTtx26ut0eb2640zzjn3dlFnM+7JZxa
         53+cBWczCfYtWjBC0gQvGrQOZeIa/+wdvfNL+iyux/571BPuGzcel3T4DN5QN8FldBC+
         UqQ2vBuuPf8R5aHNxA5Vkjv1spwOiZGSU/58xjdmryhaXcZa1nynN0SqmjxlVJNu0t7o
         u+wfMBBGuvQOyX5Km4NSw7L57577w6VIymVA5YatNKIkUwpOyuc+NOkVxjYHTT3a4bd/
         ZhJ35BHkU8sbJ8txV2ur1g2123dhxpFzQ4Uo78pTwDRZYzf80Mzvhihjn7SmXy0q54Ze
         DDDw==
X-Gm-Message-State: AO0yUKXxfclBh7htCF35NzvsUKHd30oBag9iuokGvf+ZMTiBPnuMM/1Q
        +PfNJUsl2gF/kftz5U3025aX/gcd/+Gn6iQTW1Ra831txSLEMaqj
X-Google-Smtp-Source: AK7set8aMfnSn47K8ajnf6fVrPZLkYZ/ivMLaikeIGniTbb8KLaVMgHZ2pk5/0w75bOiD5Q7T8GjNPYKYzQDt4PA+sw=
X-Received: by 2002:a17:90b:2e4f:b0:233:c8d6:671e with SMTP id
 sm15-20020a17090b2e4f00b00233c8d6671emr391145pjb.146.1676903186195; Mon, 20
 Feb 2023 06:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20230220132336.198597-1-jiri@resnulli.us>
In-Reply-To: <20230220132336.198597-1-jiri@resnulli.us>
From:   Pavan Chebbi <pavan.chebbi@broadcom.com>
Date:   Mon, 20 Feb 2023 19:56:14 +0530
Message-ID: <CALs4sv3KEk9vEeC88iEMXsGqv99caOJk8bj1Dx519yUFvMfSsw@mail.gmail.com>
Subject: Re: [patch net] sefltests: netdevsim: wait for devlink instance after
 netns removal
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        amirtz@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c33e8d05f522727a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000c33e8d05f522727a
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 20, 2023 at 6:54 PM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> When devlink instance is put into network namespace and that network
> namespace gets deleted, devlink instance is moved back into init_ns.
> This is done as a part of cleanup_net() routine. Since cleanup_net()
> is called asynchronously from workqueue, there is no guarantee that
> the devlink instance move is done after "ip netns del" returns.
>
> So fix this race by making sure that the devlink instance is present
> before any other operation.
>
> Reported-by: Amir Tzin <amirtz@nvidia.com>
> Fixes: b74c37fd35a2 ("selftests: netdevsim: add tests for devlink reload with resources")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  .../selftests/drivers/net/netdevsim/devlink.sh | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> index a08c02abde12..7f7d20f22207 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> @@ -17,6 +17,18 @@ SYSFS_NET_DIR=/sys/bus/netdevsim/devices/$DEV_NAME/net/
>  DEBUGFS_DIR=/sys/kernel/debug/netdevsim/$DEV_NAME/
>  DL_HANDLE=netdevsim/$DEV_NAME
>
> +wait_for_devlink()
> +{
> +       "$@" | grep -q $DL_HANDLE
> +}
> +
> +devlink_wait()
> +{
> +       local timeout=$1
> +
> +       busywait "$timeout" wait_for_devlink devlink dev
> +}
> +
>  fw_flash_test()
>  {
>         RET=0
> @@ -256,6 +268,9 @@ netns_reload_test()
>         ip netns del testns2
>         ip netns del testns1
>
> +       # Wait until netns async cleanup is done.
> +       devlink_wait 2000
> +
>         log_test "netns reload test"
>  }
>
> @@ -348,6 +363,9 @@ resource_test()
>         ip netns del testns2
>         ip netns del testns1
>
> +       # Wait until netns async cleanup is done.
> +       devlink_wait 2000
> +
>         log_test "resource test"
>  }
>
> --
> 2.39.0
>

Looks good to me.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000c33e8d05f522727a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBpOvVB67jSroY50pko3vx2Gtknth37G
9buallvqi5BrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDIy
MDE0MjYyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBsFXhQ9vy3wrXnS6XED1tBAnAFPD+HUHNS7TNl7vYlgWmk5vul
J1jwdGsq4Vv6nz6/H0VC8bM+YwtR206Nz2VIRrn/2VXcpQVFNCS/H2JyzqtuARMMeTYyZeaB6EHI
RzNaQmH0oaHkhU773ZCYE1CzWIX4qClGicS1LisKzPdYA6QuMAYRJuF7Kz3c5jRyPjrwYkOa+yxQ
SFL7inmhKGfRSdlknyzk6kBxzZluVV6otkqqRrPInH/eX7J6XR9WpY4nfBRPnQzaCa4dV4o8t3jS
/2ok8AMeDEGkqYDjNHVwlD+vNpFg2Y6VBld3GS3VGGvCpKoAgOHF2JLnB7KaD0Ep
--000000000000c33e8d05f522727a--
