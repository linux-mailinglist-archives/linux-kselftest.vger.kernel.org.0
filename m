Return-Path: <linux-kselftest+bounces-36115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5BAEE41C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402CF168768
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F012949E0;
	Mon, 30 Jun 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1qTAsAe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28C293B53
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299929; cv=none; b=KR8+OdXZmPaQ3hIjgMnqGmfaYPwS47u5ddYnBr9BJrkbhlGK8jBQjP38p4R6Uwvkza4I20YHM4liz/ANchK8RkQ8FjwupZratpRR1TWGVPw+3Fr6TkLnTcjvzNTTj5VkyVjFqYeaJa2fUjKNTjHluPv0PBnOSPnGtRSOAud8eXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299929; c=relaxed/simple;
	bh=PCJyNTLH7Jg8C1gYIlHHucvSuf2Gopz4c8HoJCfZMJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsYzkTUPsRZTTip6a2DCHOoGXpog/e5pYNYOWF2ejAxhMWCynvphz3izycz38AtEZX8Cs/a3PJJ+mBmh6a4kRI3X8FG9GQFZVID0iJrFdW4G/kXWw8lnDFlhlOI7QVCq7CCDFcKRihuTIZVvlmlFNrJ4wMJDkQx14M5e4JbUafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1qTAsAe; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237f270513bso322215ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751299928; x=1751904728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7BxjnsxuOM0CL9z4MQbMFwea7KaqP5DI3gVwQBqPDc=;
        b=O1qTAsAeGcfQtKA0B2TGbk/adgf9ZN99xffH50a0lgGjhO3ub4Duf9meIRWX+72xiT
         jCCqek78OwOnKEG0Utbur05sWT/iJ7vBOgq5NOFEjo/LPkA2x+WQPznkUwB7GJoBToM6
         kTjHJP9l15YNdVqJfDIAbA3xzrz9sujRAkcOLXc401jOzl8F6lEr1k3b0Cz4C08w2qTL
         YR+suRhUWjXB/NvHVTXOEqK/vQLF2OX0T+IkA0bCd7fwJnxmP/NYKLSm3whElzVVlSP1
         VngCdRpaZee4p/OuVwbaeopoKXh+mSyf8lbq+/3H8FnDtlfVsKzV2s8w8Kyh8Ut6YziO
         RNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751299928; x=1751904728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7BxjnsxuOM0CL9z4MQbMFwea7KaqP5DI3gVwQBqPDc=;
        b=MtBZQ6yI+LxCZ2Fly82XmyVNXVrhZTiKeoG25DQWxWWgPzxJsu81HEZ8qnecqoVxSm
         Zua7PX+Dt43D0Pq0UsZNTfY8rwS9L+jA0HVCtLsJgbVfcO7v1isFbNFL9z6VxxTXpWXF
         y3PGYM4uzY8usGKkby6vmMNXill464m2myNYlRoyyW+MWpZX37IzamB8YyowHhUM4t3p
         VDoTibU1Bu+uhskgQ/PdRvGnwyBiA/1fPyalVGpw4ksSkzCKCBr/oA/ec68/4X5sM3ZQ
         WCJszhqh54yDNAcWrvqviPF+pazTw/oWP91GoHrL/0KQoK6oOZm9qWks1nFnAa299knh
         EkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDj/WVmf69/Fkd7gjoi6WZp4xQwy2EcN6y6QBDtvHreNjU+boSiE18HQCctYJs8E8cJt4xmlZ2AvOcWmxJyzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqRbR2ibz1vyRN6WNWUQlLdNryJkWW+7VjAzviRN3HFnOYeFT
	/m+JbnuPSDqzg/UWJh0WP/hlFc1QUIhPK7WJA/HnmIKLf1ZqqD79ZcNohPvFrJPmxOkXzhRDVi1
	JPKtAiHoYKB5tfDnzkc9ZZ+c02UUIgoGMypQ4rGja
X-Gm-Gg: ASbGncstMahcV4Ntjc5F+CTTKYDlrBlCKZuj22dZJQFtvZ3oB6pmFsvdN+xGStsmF8o
	pSRrzZ7jFXwzsrTExvKYLY7lLGBnkj09J4U4CDPBL84JVp7MkuMIUiEyUXPvMPDe9mJXC1hcgKX
	brm/Flkyr4XSDMYp0BijfuiGNVyX3LxtOPYFdkVM6iJJ6b
X-Google-Smtp-Source: AGHT+IF8J0J76MOIb3DZGKGp4t47LLfeSRmXENjgq0heD66UgbUhctGKXAPxwJn9vBXMNX32PWRCS+R2LlHZQ5u+jBA=
X-Received: by 2002:a17:902:c40d:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23ae8d6e607mr5216235ad.0.1751299926903; Mon, 30 Jun 2025
 09:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630092818.1449599-1-ap420073@gmail.com>
In-Reply-To: <20250630092818.1449599-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 30 Jun 2025 09:11:53 -0700
X-Gm-Features: Ac12FXzO9s36LkozDrT_BcqjTROlBBiE_WqB--UMdgwaC2la8YC3Lyb0q4yomdE
Message-ID: <CAHS8izN9CWwwUk0tfDy1iGrfwYLTD9paiF622jP4z4mgD844uw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: devmem: configure HDS threshold
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, sdf@fomichev.me, 
	jdamato@fastly.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:28=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> change it automatically.
> Therefore, configure_hds_thresh() is added to handle this.
>
> The run_devmem_tests() now tests hds_thresh, but it skips test if the
> hds_thresh_max value is 0.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/te=
sting/selftests/drivers/net/hw/ncdevmem.c
> index cc9b40d9c5d5..d78b5e5697d7 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -349,6 +349,72 @@ static int configure_headersplit(bool on)
>         return ret;
>  }
>
> +static int configure_hds_thresh(int len)
> +{
> +       struct ethtool_rings_get_req *get_req;
> +       struct ethtool_rings_get_rsp *get_rsp;
> +       struct ethtool_rings_set_req *req;
> +       struct ynl_error yerr;
> +       struct ynl_sock *ys;
> +       int ret;
> +
> +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> +       if (!ys) {
> +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> +               return -1;
> +       }
> +
> +       req =3D ethtool_rings_set_req_alloc();
> +       ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> +       ethtool_rings_set_req_set_hds_thresh(req, len);
> +       ret =3D ethtool_rings_set(ys, req);
> +       if (ret < 0)
> +               fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> +       ethtool_rings_set_req_free(req);
> +
> +       if (ret =3D=3D 0) {
> +               get_req =3D ethtool_rings_get_req_alloc();
> +               ethtool_rings_get_req_set_header_dev_index(get_req, ifind=
ex);
> +               get_rsp =3D ethtool_rings_get(ys, get_req);
> +               ethtool_rings_get_req_free(get_req);
> +               if (get_rsp)
> +                       fprintf(stderr, "HDS threshold: %d\n",
> +                               get_rsp->hds_thresh);
> +               ethtool_rings_get_rsp_free(get_rsp);
> +       }
> +
> +       ynl_sock_destroy(ys);
> +
> +       return ret;
> +}
> +
> +static int get_hds_thresh_max(void)
> +{
> +       struct ethtool_rings_get_req *get_req;
> +       struct ethtool_rings_get_rsp *get_rsp;
> +       struct ynl_error yerr;
> +       unsigned int ret =3D 0;
> +       struct ynl_sock *ys;
> +
> +       ys =3D ynl_sock_create(&ynl_ethtool_family, &yerr);
> +       if (!ys) {
> +               fprintf(stderr, "YNL: %s\n", yerr.msg);
> +               return -1;
> +       }
> +
> +       get_req =3D ethtool_rings_get_req_alloc();
> +       ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
> +       get_rsp =3D ethtool_rings_get(ys, get_req);
> +       ethtool_rings_get_req_free(get_req);
> +       if (get_rsp)
> +               ret =3D get_rsp->hds_thresh_max;
> +       ethtool_rings_get_rsp_free(get_rsp);
> +
> +       ynl_sock_destroy(ys);
> +
> +       return ret;
> +}
> +
>  static int configure_rss(void)
>  {
>         return run_command("sudo ethtool -X %s equal %d >&2", ifname, sta=
rt_queue);
> @@ -565,6 +631,9 @@ static int do_server(struct memory_buffer *mem)
>         if (configure_headersplit(1))
>                 error(1, 0, "Failed to enable TCP header split\n");
>
> +       if (configure_hds_thresh(0))
> +               error(1, 0, "Failed to set HDS threshold\n");
> +

hds_thresh should probably be part of configuring headersplit.

But also, failing to set hds_thresh should not fail the test, to
maintain compatibility with drivers that don't support configuring
hds_thresh.

