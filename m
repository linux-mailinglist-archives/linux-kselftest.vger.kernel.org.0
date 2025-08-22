Return-Path: <linux-kselftest+bounces-39766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B5B3250D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68186876D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE32C0276;
	Fri, 22 Aug 2025 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBbBsm9I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0217BA3;
	Fri, 22 Aug 2025 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901602; cv=none; b=Zp3SbhBO0Tfw6J8TSvhSJHfaHXlUSMbnaNSB8ulSaLfPsQd7l4QDgQKXt1+rwuR8kmUW91Uu9TeI6zRYCr79Iirhr8tQxI4QJWjLPFY7acCKiD4qMrUJKIq+8SRrSKg/i8m3Q/pUqXlf/5Pc3uwaUt6LA9OkCrACJTZ2Th+oczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901602; c=relaxed/simple;
	bh=AY0OcZYpZF/OpwezmBbKlwqpFzE9MaKPO47CHaUzh7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdHorOvDFUntxk5TCA6f68jaBKUvc9LYrDHXWxV7UhGD5+XF1tOrNoPNSdKr4H3b3ii61qnxFi0eLkttafvgKPRUeTq26j7UjLOLRAfFoaumCbLLrtv0SzMHcFv0gWzyOc5L0KmtHKc3iUtJi3EfVwxhUadQ9KzMW8Zu6LkUgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBbBsm9I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-246181827e9so18324285ad.3;
        Fri, 22 Aug 2025 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755901598; x=1756506398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klmJYZUfx02uLfFJtTrBEU4Wg2ydDBmHURNvQ97ZUPQ=;
        b=eBbBsm9IDkOPut5sUfFCnxRcqMdGxE/sG6CV/9mP+3nbr5Apxt+Dmt6Mi7PvQet5/L
         eDqi7rKZPk6XtD9VgpGbQSsVkkqJQfOF2jDhSeH8U3XpgYVDajIDKHRI9R5RbqpnpDTu
         BWz8dVwdUBlsc5VkTdm3KuvKBl0eB7xsyGwxTKxdpBf4IyG1cjt+C0Rtz71a1K1cE9l4
         5grT8SihRJO1ghTl3D2q0vVwAkT4pxAnHYVYaJI4SSDbRFWK4t0RhqyzuHD7ydejXl4a
         OavXPjN85wlJ4CXB0Wq5cOg4OMAmQKCQylU6yBf2PMCO9RjllYmCNl49OG0uIJe6+7O4
         xdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901598; x=1756506398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klmJYZUfx02uLfFJtTrBEU4Wg2ydDBmHURNvQ97ZUPQ=;
        b=Eyx2njaXakFPSPqU50eEzo4vc1wxmRUIzAq+0TIPuf0wiQL9aarfgPutoYMOpxw/Kq
         4LZqgh+yQW0TyhgZIWqf/uoCjlqFgbf0+bZzgL4qcRRupFirhXLwKMMnAVr2aSepwX38
         mvL4vySLMOIXC44cbtAtSEUZ6rVTUj2vi4PXnV8xqC5NSnDXEHRP2akXZwXoY8sgoTCa
         I3lI3K5eZ0wfIEETRKidI8xq+elU2DZaUm1RZxiNVPB2yoNH6JCeBcgCfXXL7wX6i9Bj
         GZZvwt6fkROtVWVXNfeocG4BtUhErCnP12FpvQ2yGAq3xU/xXeU5W+5IYdo2Iw0Xpwjm
         yl2A==
X-Forwarded-Encrypted: i=1; AJvYcCVOjm6QOMJozXEBb23P/0WN/7hC+91VmC+Q0ptPACLj7Xa45Yq6zx9qLHzXf6UyEevpNwMVGmY9@vger.kernel.org, AJvYcCWkoZ+OgjIKI9uIJiCPB4t4g4RicBJZnubFkFguHe4uzItQ1x8HBmynNkPG50CBHpjUm2Qj35SW5xqR9EGUMvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQPwP7egeJsgyJ5pFgLYCLe2xdjC1AyLk+OKTSc7tN9aDspgI
	jNkpUjQ2GCmG+OB8YhGXo7z98M52820lvWE5vTA277fHz70oBN3LArA=
X-Gm-Gg: ASbGnctkql5mNMuMAAdRAlxYEsmrwUdYivzNiYcRLiy+WCPFEIMzcipHjP2ofat+o6j
	qPVJDwjkWbm8WKJW08mYGg1sE3uWYljKOpTgS1lBLxeszRLelA+e1TQYknTHOm3mcTvRg0rr4rl
	HlKlL5up4E5slfmWSol5KVXjGbuCc3HOn+gczIFx7+qLXxQHMDKx9A/DhOFBzi2pn19eqWkJrnk
	bUnJ3bY3B8AGWHV6D8vhRqkdYq55Ffyodv3iSvTos95Q8JvjjBI0Wpk4wSkJuR4wHF8mc+4ZbGw
	6LgaushAdPJxDsqSd6r+Z5kC34H7TLAPNX1FxHIcwRd0HYwv0q6dab3UqLqJVfASDMJ4VZSVUsj
	60omP+qE+mQJ6LZyqDi000IK06hN6290MGND4LvanHiA83r/AKo/yLNrsQVCmf+/Xaum1lgbat2
	WnYg/JXOdQNsZ8qpgfxcNg/xXWoIZRaKyrn4sECw15gNHE0sNzEcsRzg7uldqGpocjzu6NP48n5
	Kw337gWy72wSZk=
X-Google-Smtp-Source: AGHT+IGbzDwlG9eb1xInNAqHjOffZbpYp66v/80cAz/8yAyf1edv39WK5JeaxfWLst2UoDDmOiHbWw==
X-Received: by 2002:a17:903:1ca:b0:235:779:edfa with SMTP id d9443c01a7336-2462ef219dfmr49758185ad.32.1755901597948;
        Fri, 22 Aug 2025 15:26:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-246687a59b1sm6083705ad.42.2025.08.22.15.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 15:26:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:26:37 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, sdf@fomichev.me, joe@dama.to,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: ncdevmem: configure and
 restore HDS threshold
Message-ID: <aKjunRT-rmsd8tLH@mini-arch>
References: <20250822200052.1675613-1-kuba@kernel.org>
 <20250822200052.1675613-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822200052.1675613-5-kuba@kernel.org>

On 08/22, Jakub Kicinski wrote:
> Improve HDS handling. Make sure we set threshold to 0.
> Restore the previous settings before exiting.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 96 +++++++++++++++++--
>  1 file changed, 87 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> index 580b4459a840..aa2904d1a3e1 100644
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> @@ -419,6 +419,60 @@ static const char *tcp_data_split_str(int val)
>  	}
>  }
>  
> +static struct ethtool_rings_get_rsp *get_ring_config(void)
> +{
> +	struct ethtool_rings_get_req *get_req;
> +	struct ethtool_rings_get_rsp *get_rsp;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +
> +	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
> +	if (!ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return NULL;
> +	}
> +
> +	get_req = ethtool_rings_get_req_alloc();
> +	ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
> +	get_rsp = ethtool_rings_get(ys, get_req);
> +	ethtool_rings_get_req_free(get_req);
> +
> +	ynl_sock_destroy(ys);
> +
> +	return get_rsp;
> +}
> +
> +static void restore_ring_config(const struct ethtool_rings_get_rsp *config)
> +{
> +	struct ethtool_rings_set_req *req;
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +	int ret;
> +
> +	if (!config)
> +		return;
> +
> +	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
> +	if (!ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return;
> +	}
> +
> +	req = ethtool_rings_set_req_alloc();
> +	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> +	ethtool_rings_set_req_set_tcp_data_split(req,
> +						ETHTOOL_TCP_DATA_SPLIT_UNKNOWN);
> +	if (config->_present.hds_thresh)
> +		ethtool_rings_set_req_set_hds_thresh(req, config->hds_thresh);
> +
> +	ret = ethtool_rings_set(ys, req);
> +	if (ret < 0)
> +		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
> +	ethtool_rings_set_req_free(req);
> +
> +	ynl_sock_destroy(ys);
> +}
> +
>  static int configure_headersplit(bool on)
>  {
>  	struct ethtool_rings_get_req *get_req;
> @@ -436,8 +490,14 @@ static int configure_headersplit(bool on)
>  
>  	req = ethtool_rings_set_req_alloc();
>  	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
> -	/* 0 - off, 1 - auto, 2 - on */
> -	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
> +	if (on) {
> +		ethtool_rings_set_req_set_tcp_data_split(req,
> +						ETHTOOL_TCP_DATA_SPLIT_ENABLED);
> +		ethtool_rings_set_req_set_hds_thresh(req, 0);

From talking to Taehee awhile ago it seemed like unconditionally
setting 0 will fail on the devices that don't support it.
Is it not the case anymore with ethnl_set_rings_validate?

