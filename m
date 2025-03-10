Return-Path: <linux-kselftest+bounces-28575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874AA58AC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770E6188ACDE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 02:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191551AF0BB;
	Mon, 10 Mar 2025 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BKmnPMpr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215817C225
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575575; cv=none; b=JMA8PV5bKa3i0ydMFTbvkNdwMjOyr14r89SuBzCTY1kS3nzaG3E6OD+HbhJG4QWKOKxb+I2dCUoQul6GDrLuOZTtVAmGMJtOdSHF3NCXRV/g2QYxUYHTYAsiqM34mUsN7eMOIfVWdIUyJ/BtseodULI/JmUZRVW7JBlARObYjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575575; c=relaxed/simple;
	bh=GGAnavEESbNZNnygVSkZ7RA/0CvlH+UlUgSmhE81YhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGAySdbTizcv9y1dpvssK2KVknz8L7WA2sIztVlStFXUUrt7gMJ2j56XJGL3cIq27SejAdlUga5RCLWzxlkXfNyi9dA8JRJAj5pgBHsJUhyvIOP2JhqrBilyYmA6cD67WnTWklW4WepuGTLyov0iiwjLFpVw/WWtU0Aaqn80VX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BKmnPMpr; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5240764f7c1so225093e0c.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 19:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741575572; x=1742180372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D0JPzViyFWzEo+pxNiRnulPp2VDfHpDHa5qxoNb2jCM=;
        b=BKmnPMprUnCGvQvYPE3jvgexMH9woPUYKcBDZSfEhwIHLgJ4uEGVn6zv4TkSZgBriL
         dlaHpjBI9IrI+S3LSOYpdV0Ep42s4sypeXLsKRttRt60K3fEdE19tblfZUxIFfNfvsVs
         zkiHbinbJEMXsrhznVJkm89ai7wgJOibz3yq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741575572; x=1742180372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0JPzViyFWzEo+pxNiRnulPp2VDfHpDHa5qxoNb2jCM=;
        b=TxIGA3ZY431w7ZCH7rpdkH4ILpqmU3z2yvSturPcXb9xMkqjCXeLrhUd8f6dh5tYbd
         wFWdhhWXOS5zr8GDuXBkt+ZNWHoeUDLp83qvdmwtuwqU171N6aBitAfVboFr9b5FOyrh
         WQ29rDLlSnmHr3vVgeG04GF0w8I52U0nkKz/sPztey4zTUxrlsAzPBfFayAPewztBIPq
         g8mVVaJrM3bj7OeQlTeF6UDdfn12oPm731nt/waqeNJ/9xlo7ihYwKli6gnrDJGWdtFu
         /oTKyJEFJX/EnIA1qseIf1L3A+Ax4JVWlr6jwm6SxADUsXf0+BwYdD7Hm1hDn9HvrTM3
         nZug==
X-Forwarded-Encrypted: i=1; AJvYcCU7SBO/DTBfrf97cDKr5VXV3YmHiq42ay1nv62RJS4gphvcTkWBpNZeCSpN1dtTxoksN5sDQBzu/8VDYphtOtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SOGM0uCtGFeeTZZV4W8ormhctKcFaq+zK7Pd6Zc3cJlHQi7v
	/nKzyjiFskVxF0bypDU0nLFKlHVBSnKD/qxMtIFId8Ljvi2QBw3b/hvnYX3T+0I6w66Qn+wJItn
	YSWT3d8GKUxmoznoIv4cLa3VWdUBSUKIf6SV1
X-Gm-Gg: ASbGncs1zEexFXZuhbxq/tmc8XP5uN4vwpi8IUw9lJ6c5BxV4K6Vk/1+Px9xkr1U7Gb
	RFRPdf1ZsgwRLuTchJQc96dIoOwh7oM928hZLFu/GpHjNxrPlUeaRFRrU1wmjjJtLXqDQkWNpkd
	2puczy4+pvA3F3ZfGAwAOSlhJQKy8=
X-Google-Smtp-Source: AGHT+IExnNzJsw2GMHFOYyty+oivf/aZ1NlnglpPRbiLmYoVlcKD7qt6vkgWwb+w5FpCzl/IX2hhmylTBtU3djsMDp0=
X-Received: by 2002:a67:e710:0:b0:4bd:22d5:fbd7 with SMTP id
 ada2fe7eead31-4c30a5aa5d5mr7994853137.11.1741575572156; Sun, 09 Mar 2025
 19:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-6-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-6-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 10 Mar 2025 08:29:20 +0530
X-Gm-Features: AQ5f1JqjVf-shUj4xVRf3iwBzONNuy49CHEhdfAYn_eDpCGwzEfuIPG-t-SFEfA
Message-ID: <CAOBf=ms6=2RaeKB4RZ6aneaH12OaoJSTY=R7_cvQvMecA5iudw@mail.gmail.com>
Subject: Re: [PATCH v3 net 5/8] eth: bnxt: fix kernel panic in the
 bnxt_get_queue_stats{rx | tx}
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	almasrymina@google.com, asml.silence@gmail.com, willemb@google.com, 
	kaiyuanz@google.com, skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	dw@davidwei.uk, amritha.nambiar@intel.com, xuanzhuo@linux.alibaba.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000058b076062ff42990"

--00000000000058b076062ff42990
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 7:13=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> When qstats-get operation is executed, callbacks of netdev_stats_ops
> are called. The bnxt_get_queue_stats{rx | tx} collect per-queue stats
> from sw_stats in the rings.
> But {rx | tx | cp}_ring are allocated when the interface is up.
> So, these rings are not allocated when the interface is down.
>
> The qstats-get is allowed even if the interface is down. However,
> the bnxt_get_queue_stats{rx | tx}() accesses cp_ring and tx_ring
> without null check.
> So, it needs to avoid accessing rings if the interface is down.
>
> Reproducer:
>  ip link set $interface down
>  ./cli.py --spec netdev.yaml --dump qstats-get
> OR
>  ip link set $interface down
>  python ./stats.py
>
> Splat looks like:
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 1680fa067 P4D 1680fa067 PUD 16be3b067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 0 UID: 0 PID: 1495 Comm: python3 Not tainted 6.14.0-rc4+ #32 5cd0f9=
99d5a15c574ac72b3e4b907341
>  Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01=
/2021
>  RIP: 0010:bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en]
>  Code: c6 87 b5 18 00 00 02 eb a2 66 90 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 0f 1f 44 01
>  RSP: 0018:ffffabef43cdb7e0 EFLAGS: 00010282
>  RAX: 0000000000000000 RBX: ffffffffc04c8710 RCX: 0000000000000000
>  RDX: ffffabef43cdb858 RSI: 0000000000000000 RDI: ffff8d504e850000
>  RBP: ffff8d506c9f9c00 R08: 0000000000000004 R09: ffff8d506bcd901c
>  R10: 0000000000000015 R11: ffff8d506bcd9000 R12: 0000000000000000
>  R13: ffffabef43cdb8c0 R14: ffff8d504e850000 R15: 0000000000000000
>  FS:  00007f2c5462b080(0000) GS:ffff8d575f600000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 0000000167fd0000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x70
>   ? page_fault_oops+0x15a/0x460
>   ? sched_balance_find_src_group+0x58d/0xd10
>   ? exc_page_fault+0x6e/0x180
>   ? asm_exc_page_fault+0x22/0x30
>   ? bnxt_get_queue_stats_rx+0xf/0x70 [bnxt_en cdd546fd48563c280cfd30e9647=
efa420db07bf1]
>   netdev_nl_stats_by_netdev+0x2b1/0x4e0
>   ? xas_load+0x9/0xb0
>   ? xas_find+0x183/0x1d0
>   ? xa_find+0x8b/0xe0
>   netdev_nl_qstats_get_dumpit+0xbf/0x1e0
>   genl_dumpit+0x31/0x90
>   netlink_dump+0x1a8/0x360
>
> Fixes: af7b3b4adda5 ("eth: bnxt: support per-queue statistics")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v3:
>  - Patch added.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 9afb2c5072b1..bee12d9b57ab 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15384,6 +15384,9 @@ static void bnxt_get_queue_stats_rx(struct net_de=
vice *dev, int i,
>         struct bnxt_cp_ring_info *cpr;
>         u64 *sw;
>
> +       if (!bp->bnapi)
> +               return;
> +
>         cpr =3D &bp->bnapi[i]->cp_ring;
>         sw =3D cpr->stats.sw_stats;
>
> @@ -15407,6 +15410,9 @@ static void bnxt_get_queue_stats_tx(struct net_de=
vice *dev, int i,
>         struct bnxt_napi *bnapi;
>         u64 *sw;
>
> +       if (!bp->tx_ring)
> +               return;
> +
>         bnapi =3D bp->tx_ring[bp->tx_ring_map[i]].bnapi;
>         sw =3D bnapi->cp_ring.stats.sw_stats;
>
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--00000000000058b076062ff42990
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
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIN99OftkFrfzeZ/Fvp5G56vbKrEm
YSJP2E3p8jdmMaN+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDMxMDAyNTkzMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAA6v0z/qYSKemBR5tZmAdQh3aQPvAe11Fr2q6A7xT6QmJD6cuj+sla15m6mllBW4
YwK99bNu7uMnSvxRz2tPv29kLmy3/RR/B7E+rvxdfz/X+OfCYHL4Vxn5kZPRieRays0sr4ELqhA2
FXKBl3klcDF5n2pWfI1E2idl0ob2jx9BuwbnwpxniNhUgdbHUW7KIB4iXAsC8tWqZjjAgKemE+CO
+KKQnvPHbNj2lDgTJfOxjH0zxbxkUWmW5XZYCWk40gqMrRATbA9+gXCZ+QOFwSVFWphdOOhQnp6H
gJJDOfOZJspcPVM2NHaYcFW6kJz2zv8Z5IGWYcpVMXmfPtGwq00=
--00000000000058b076062ff42990--

