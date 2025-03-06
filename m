Return-Path: <linux-kselftest+bounces-28379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFDFA54425
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB416CDAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8661DDC1A;
	Thu,  6 Mar 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JxQgSkZX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671A1C84B8
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248350; cv=none; b=N3DofF52rUUGSC3aydcksWUTKv8lwwr17zpYH8OMk3b8X63EKmc5IElTFNelfM+As0QyRDlSO+kYCsrroJUHDibM0gBmwSRLaA82edOOf7+k9k3fU1jFF+Uh2gf674oDy9eyE2qEcCCMxShaColes5gjB97GEF3Fj9cEK3ZZOuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248350; c=relaxed/simple;
	bh=ZoBCZfvsy/oXqlzf0JdtsHEosg7xJTRiBwu+Kr4Iw2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFd1nuFgA+4l68ZA5yI/4KbFZbKA2wpOAbZrj5LH2RPSMgmE/4HmJXRNQ3Ql9n+hMt9O8ikJPbsF7PtJk2jseQSYZOuB3IQDt//HDZn+EkE/hQogDpthl1H2yuPaohBCRV7gMSKmRBbA8kuEszYK09AT7XlNOzt5bObAnfEuFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JxQgSkZX; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523b8881d31so138289e0c.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 00:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741248348; x=1741853148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9soGUBVwDBtv+LFzTFOau+k/fIBpmK6DSEqj8GedVs=;
        b=JxQgSkZXZZ3jVJTSEdlft0AeC+17l85h4gl2LWv0im4/of44UBnHOmFLkq8rk/2duV
         Dht61877FlF0Za3kXgpylcWzyHuA1kCVAE7fuSuuuLwacgl8qo6iMWE+8mY+57uFL6LM
         aICq7MUB4nM2mXomRidyZ+tPuvYh4XdbAFv0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741248348; x=1741853148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9soGUBVwDBtv+LFzTFOau+k/fIBpmK6DSEqj8GedVs=;
        b=orqeR2kd5YDq4y6WDUhmzUnre3oHliLt4i+NVjq9wDVBApgAHjshkYbiMSRCPVU7eS
         CTUT+2JKxd/wwV0wcihX4fVTpzkvcfYmPAQSVfMng9LJRLwM/Yqers288BI2BSfF1G8t
         q4+QGaSOP0pxS6CeTPlX6P9mnLLdyAK393L4v+8R2YV9F1UZWQAbEW5VWZnPioyqRXBc
         n7UY+RqsjbmA6CqF53hHCRR0CWRE3AqsjeZS8CcgK6sKiMcoFGvy8BiED1hrWUb/Loj/
         u1BqLlxDeg0TwD78e83YLsNCpbBjetkMMQOXwvhrCRjBkiUN3tL9v/3XM9otOpGYFHjP
         Dn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuJv/x6GD50yndRLmN1Xc53z1vSBnKy1icQYTKpouDb7idcAWoQpFD7pCfCcza4Rp8w29UYkSW1po2LUK8gj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJgKjhrZti5BwKXzhLm/8Ph8N8TvVQvDrhjq4ZF6kXnHq95guJ
	1ZLc3QGATKX0jYBhXo0fYAY1RjhbAeAJCPURescfkxH6uLnrWyd27NgIq27eEe0KIt5qeqR1YcI
	8PK8f2BJvrMV+QokLkMRRmrES99SMP1Z1f5+p
X-Gm-Gg: ASbGncuII+K6A/91b81E++StDHIDmhPZaYb44lewHsYz50YXcUG09AIcDZT96ger9/d
	egJ/86g8CqemEbnVN25MAgGH5Kq2n6fo2CdGi9IiHoNjpDe7DU8bkXZ5Wrg5aQqAvnQEYMTXEco
	p5YUdfohS+J/lJ9JY1Zgu0V7h5Lq8=
X-Google-Smtp-Source: AGHT+IFgvy2y31AWFchFIc697gBXoh7MFAeZNWqg2+aRw4qkid04h8SsEOktJvxo8A38YPWS7fZos6pV15yhZf2Csic=
X-Received: by 2002:a05:6102:5492:b0:4c1:8c9e:6507 with SMTP id
 ada2fe7eead31-4c2e281555amr3590861137.15.1741248347774; Thu, 06 Mar 2025
 00:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306072422.3303386-1-ap420073@gmail.com> <20250306072422.3303386-4-ap420073@gmail.com>
In-Reply-To: <20250306072422.3303386-4-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 6 Mar 2025 13:35:35 +0530
X-Gm-Features: AQ5f1Jp2ACsUpN8odBMOJ9ZrNvrhjD8QMfYXSOuonjDGPGdO9e1BHh8sIl23VrU
Message-ID: <CAOBf=msu_ysgsMPN0n6NQ6wzitFqX9kHqatcJAXtqFeQEgY0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 3/6] eth: bnxt: do not use BNXT_VNIC_NTUPLE
 unconditionally in queue restart logic
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	almasrymina@google.com, asml.silence@gmail.com, willemb@google.com, 
	kaiyuanz@google.com, skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	dw@davidwei.uk
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000041de3e062fa7f974"

--00000000000041de3e062fa7f974
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:54=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> When a queue is restarted, it sets MRU to 0 for stopping packet flow.
> MRU variable is a member of vnic_info[], the first vnic_info is default
> and the second is ntuple.
> Only when ntuple is enabled(ethtool -K eth0 ntuple on), vnic_info for
> ntuple is allocated in init logic.
> The bp->nr_vnics indicates how many vnic_info are allocated.
> However bnxt_queue_{start | stop}() accesses vnic_info[BNXT_VNIC_NTUPLE]
> regardless of ntuple state.
>
> Fixes: b9d2956e869c ("bnxt_en: stop packet flow during bnxt_queue_stop/st=
art")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v2:
>  - No changes.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index d09986308582..c9d37fea5d32 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15635,7 +15635,7 @@ static int bnxt_queue_start(struct net_device *de=
v, void *qmem, int idx)
>         cpr =3D &rxr->bnapi->cp_ring;
>         cpr->sw_stats->rx.rx_resets++;
>
> -       for (i =3D 0; i <=3D BNXT_VNIC_NTUPLE; i++) {
> +       for (i =3D 0; i <=3D bp->nr_vnics; i++) {
>                 vnic =3D &bp->vnic_info[i];
>
>                 rc =3D bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
> @@ -15663,7 +15663,7 @@ static int bnxt_queue_stop(struct net_device *dev=
, void *qmem, int idx)
>         struct bnxt_vnic_info *vnic;
>         int i;
>
> -       for (i =3D 0; i <=3D BNXT_VNIC_NTUPLE; i++) {
> +       for (i =3D 0; i <=3D bp->nr_vnics; i++) {
>                 vnic =3D &bp->vnic_info[i];
>                 vnic->mru =3D 0;
>                 bnxt_hwrm_vnic_update(bp, vnic,
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--00000000000041de3e062fa7f974
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJg
MIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEII3TWrszYPKLQEFJVhUpAxS3nZ0N
MlB+zYy7kUOQOWtCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDMwNjA4MDU0OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAGTmV1bSHv+6kGBU8VZKDUN7S4YePFivYVU+Up+nrCIwpzhj6rlZn3XbgqWd5lsa
h7BViyo0WkkKJNOi9YVwSk41wkEW7ZBdoUHjunADZ+yRzC1vLjvaMx2xHXWRqLrmNU5KtaO+Uxmp
dG/uvidS8rOu2Go7FHIs47eisJNFtOTxPAkUUnWdkEufLvoNOY0vwblCqtukXkT2lo5j2V7RQwDd
326kF/mWdyDAnSeN5bdSqZ5wk2X8JDvHV/DiBNOBLgfJgpn9ZTXWjHROxEKb8PUbAiMZuZbf4J2e
PY0SbLzsu94uFZY0b5E9ZBOt9ejCo+GDWexacczXOi5GxODQDgs=
--00000000000041de3e062fa7f974--

