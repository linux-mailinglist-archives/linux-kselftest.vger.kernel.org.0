Return-Path: <linux-kselftest+bounces-28574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E75A58ABE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 03:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DDC188E64D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 02:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42C1AD3E5;
	Mon, 10 Mar 2025 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K6W3bhF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1821A9B34
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741575516; cv=none; b=b/Lhyl1J7xOa0BfMrmi8T/CW4hfgQL2x7Baw1yfQYbzhqTmr4KTLaQHMA+JkdqMiXQf92UVnecwIhtTY3kQeSVTxk7WXPYVsCjiqJkth6dZ8o9AUg+eETMIBATJIaYkJWOQJzkZAl8bYKPQWUEu371GvaU2nvTkh2guUz9USWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741575516; c=relaxed/simple;
	bh=nmVkooIFGat98dvFp9KtDXC5nysIjJq3C0bRTzbcOUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaWfgQXNKl419uXx0pm2FTOEEvD0oq5xzy8UHyFf1OaIV87yVpdcaUhp+R/e1qK6QY3aGJKV+ImUJ/MC2fjH/0dSk1I1YlruBU4B+MyAeQr4rzCQBYDUtZqiegpzzVhUnB9Ew64rUa5XKFWMHsOtvmN3s/13cAfci1o3loGn48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K6W3bhF7; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so259784241.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741575512; x=1742180312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HogvBPaXcMPCDsEMJjuHAyCUC2UMmGXRVeXWcMXUFRM=;
        b=K6W3bhF7OtpfNUVmHP22s8hjFi7NxGysNUWiX7/zxOMcz7QbhXIvUGtsXs/W1xPNlS
         sqRbDmQBut2iUzlm6OGh2UO8cY3wR4UghqO5Javvdt/H3TdVsgFXXyHyT7tnDUPV9vcG
         V/sJmqmvYWHuzlposLs2NnQAEaFiTrE/y7KSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741575512; x=1742180312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HogvBPaXcMPCDsEMJjuHAyCUC2UMmGXRVeXWcMXUFRM=;
        b=eOss6PuEBC5Et0zK0azUDxIirWv4Pq8xW8aAasHOmR3XlNl3vUcKEsZpdbXh0dUYBd
         0F/t7V8mFEb6w71R3+37aCgaYFxOKYrQHddG6o361f3DuozPw91gzgkj5axmeMkGxbty
         vPOVnFOuszQZWZpEK+RrQm49R79065jyebUTRsX1BApf5wt6QT3OS8/Y+ijEOgpzKfqz
         dbKhTEK5W5Cv1WpHrjIzG4vx6UlLdnK8P1JcLRleRAMuipLuBU6K27xNXUvAe7saK4Eh
         72tNOZgzgrQhuO7SuWiKWj6aqgaYeXaYf5+ZrDoZmxFnwnA+uGB9DtPjgFq4Mmjv/WAY
         HVEg==
X-Forwarded-Encrypted: i=1; AJvYcCWie7/1JENfNbm+ECbmlTxY35IOiYv8Jsj0LWHXOIsXpbCk6Qd9LYeeRM/Dw5uX7zV/gHZyknlJejOKcN1VGeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDZhdzMEHGCCbxTZITsLYD9aFJYOR9I6SFm5Qw7jk8eBvDnfM
	8slIKTaLzJ87gydeF/TI85ntf1pJdCgLfRhOybJrIhE8XnQ360HH7fRCtDjM9zOvKm/aUwjp4In
	E7bawodbyf5ZWCDs9gZJCTE5OrKSE7KxgxrOi
X-Gm-Gg: ASbGncsG7pKVAPYWDNoptUEY2z+rqx2cqdTGZcZ/xHfkT/XkxgtPUU2mQmE1JRtKTob
	dTYExbhUCQpHIW/dlhnxAWZvYB63ms5MUpr9xe2Jf0QYypPecc9Q5ZChVYn6JxqBoOKun4ZGzxY
	fQQnIMflTMcgWPw3pcez7wyrj3zUjHKv7TliHXdQ==
X-Google-Smtp-Source: AGHT+IHcDncpRb29WpD+tTnJe/5kMQpQdukMmohQ1bA6rv5y+UK/rgrmzEmCdeF8YsunXE40U98LGiHZN0qVxhtcpK4=
X-Received: by 2002:a05:6102:3714:b0:4c1:924e:1a1d with SMTP id
 ada2fe7eead31-4c30a67f5ffmr4993343137.18.1741575512191; Sun, 09 Mar 2025
 19:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309134219.91670-1-ap420073@gmail.com> <20250309134219.91670-5-ap420073@gmail.com>
In-Reply-To: <20250309134219.91670-5-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 10 Mar 2025 08:28:19 +0530
X-Gm-Features: AQ5f1JqsWnnDUI17cZf_jQNFYSwfd1tnbIbj74s1QMrGbdxyRwM7As2AS9tSbQM
Message-ID: <CAOBf=msCQbVat8UZYkN2H_RR8ta1fYBjF3GF=X7ODjkoErsM7Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 4/8] eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, horms@kernel.org, shuah@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	almasrymina@google.com, asml.silence@gmail.com, willemb@google.com, 
	kaiyuanz@google.com, skhawaja@google.com, sdf@fomichev.me, gospo@broadcom.com, 
	dw@davidwei.uk, amritha.nambiar@intel.com, xuanzhuo@linux.alibaba.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c5e17a062ff4253a"

--000000000000c5e17a062ff4253a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 7:13=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> The bnxt_rx_pkt() updates ip_summed value at the end if checksum offload
> is enabled.
> When the XDP-MB program is attached and it returns XDP_PASS, the
> bnxt_xdp_build_skb() is called to update skb_shared_info.
> The main purpose of bnxt_xdp_build_skb() is to update skb_shared_info,
> but it updates ip_summed value too if checksum offload is enabled.
> This is actually duplicate work.
>
> When the bnxt_rx_pkt() updates ip_summed value, it checks if ip_summed
> is CHECKSUM_NONE or not.
> It means that ip_summed should be CHECKSUM_NONE at this moment.
> But ip_summed may already be updated to CHECKSUM_UNNECESSARY in the
> XDP-MB-PASS path.
> So the by skb_checksum_none_assert() WARNS about it.
>
> This is duplicate work and updating ip_summed in the
> bnxt_xdp_build_skb() is not needed.
>
> Splat looks like:
> WARNING: CPU: 3 PID: 5782 at ./include/linux/skbuff.h:5155 bnxt_rx_pkt+0x=
479b/0x7610 [bnxt_en]
> Modules linked in: bnxt_re bnxt_en rdma_ucm rdma_cm iw_cm ib_cm ib_uverbs=
 veth xt_nat xt_tcpudp xt_conntrack nft_chain_nat xt_MASQUERADE nf_]
> CPU: 3 UID: 0 PID: 5782 Comm: socat Tainted: G        W          6.14.0-r=
c4+ #27
> Tainted: [W]=3DWARN
> Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/=
2021
> RIP: 0010:bnxt_rx_pkt+0x479b/0x7610 [bnxt_en]
> Code: 54 24 0c 4c 89 f1 4c 89 ff c1 ea 1f ff d3 0f 1f 00 49 89 c6 48 85 c=
0 0f 84 4c e5 ff ff 48 89 c7 e8 ca 3d a0 c8 e9 8f f4 ff ff <0f> 0b f
> RSP: 0018:ffff88881ba09928 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 00000000c7590303 RCX: 0000000000000000
> RDX: 1ffff1104e7d1610 RSI: 0000000000000001 RDI: ffff8881c91300b8
> RBP: ffff88881ba09b28 R08: ffff888273e8b0d0 R09: ffff888273e8b070
> R10: ffff888273e8b010 R11: ffff888278b0f000 R12: ffff888273e8b080
> R13: ffff8881c9130e00 R14: ffff8881505d3800 R15: ffff888273e8b000
> FS:  00007f5a2e7be080(0000) GS:ffff88881ba00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff2e708ff8 CR3: 000000013e3b0000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  ? __warn+0xcd/0x2f0
>  ? bnxt_rx_pkt+0x479b/0x7610
>  ? report_bug+0x326/0x3c0
>  ? handle_bug+0x53/0xa0
>  ? exc_invalid_op+0x14/0x50
>  ? asm_exc_invalid_op+0x16/0x20
>  ? bnxt_rx_pkt+0x479b/0x7610
>  ? bnxt_rx_pkt+0x3e41/0x7610
>  ? __pfx_bnxt_rx_pkt+0x10/0x10
>  ? napi_complete_done+0x2cf/0x7d0
>  __bnxt_poll_work+0x4e8/0x1220
>  ? __pfx___bnxt_poll_work+0x10/0x10
>  ? __pfx_mark_lock.part.0+0x10/0x10
>  bnxt_poll_p5+0x36a/0xfa0
>  ? __pfx_bnxt_poll_p5+0x10/0x10
>  __napi_poll.constprop.0+0xa0/0x440
>  net_rx_action+0x899/0xd00
> ...
>
> Following ping.py patch adds xdp-mb-pass case. so ping.py is going
> to be able to reproduce this issue.
>
> Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from m=
ultibuffer xdp_buff")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v3:
>  - No changes.
>
> v2:
>  - Patch added.
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 ++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 11 ++---------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 +--
>  3 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 218109ee1c23..9afb2c5072b1 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2218,7 +2218,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt=
_cp_ring_info *cpr,
>                         if (!skb)
>                                 goto oom_next_rx;
>                 } else {
> -                       skb =3D bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr=
->page_pool, &xdp, rxcmp1);
> +                       skb =3D bnxt_xdp_build_skb(bp, skb, agg_bufs,
> +                                                rxr->page_pool, &xdp);
>                         if (!skb) {
>                                 /* we should be able to free the old skb =
here */
>                                 bnxt_xdp_buff_frags_free(rxr, &xdp);
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.c
> index e9b49cb5b735..299822cacca4 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -460,20 +460,13 @@ int bnxt_xdp(struct net_device *dev, struct netdev_=
bpf *xdp)
>
>  struct sk_buff *
>  bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
> -                  struct page_pool *pool, struct xdp_buff *xdp,
> -                  struct rx_cmp_ext *rxcmp1)
> +                  struct page_pool *pool, struct xdp_buff *xdp)
>  {
>         struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
>
>         if (!skb)
>                 return NULL;
> -       skb_checksum_none_assert(skb);
> -       if (RX_CMP_L4_CS_OK(rxcmp1)) {
> -               if (bp->dev->features & NETIF_F_RXCSUM) {
> -                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> -                       skb->csum_level =3D RX_CMP_ENCAP(rxcmp1);
> -               }
> -       }
> +
>         xdp_update_skb_shared_info(skb, num_frags,
>                                    sinfo->xdp_frags_size,
>                                    BNXT_RX_PAGE_SIZE * num_frags,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.h
> index 0122782400b8..220285e190fc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -33,6 +33,5 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info =
*rxr,
>                               struct xdp_buff *xdp);
>  struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
>                                    u8 num_frags, struct page_pool *pool,
> -                                  struct xdp_buff *xdp,
> -                                  struct rx_cmp_ext *rxcmp1);
> +                                  struct xdp_buff *xdp);
>  #endif
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000c5e17a062ff4253a
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
G7cwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIIJmtfzc1+5U2U1c/E1zUrKClN5p
scHTavsksOmhTbLbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDMxMDAyNTgzMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3
DQEBAQUABIIBAI4may3fleln/YwWb3ORkk2+01Zm7Y1t9IMUdgXzyiDSWnUzlehAI59YOskenf/p
MQcwPLZ6pSIO+P5CSMpuSeFWGq1UxFv2eAtbRp5ALQKgpD6SRyKlhFzNdzU8vF68lM/kdJ7actou
fv5BeH50RDAXDsscFSXQnpS5eNfBI+8YVZU8aF5uPIXye5blZHHiThbpFRGKixwY4Dc8EQXx9CuR
kwSV98U4qRoqYMHudMpp0FqmQ/bsrQ7kkA6W4dBlIbNY05WYX6RtA7rBaFQtEkpgoppgFGLELuva
sEL2++Fh8XyGdF3Cbtvg5RZCU0Wqvj5oIRTd9QRNAaHudM/aR3U=
--000000000000c5e17a062ff4253a--

