Return-Path: <linux-kselftest+bounces-25861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DCA29B9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88AD167FE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF8214A7C;
	Wed,  5 Feb 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpy14qga"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB80214809;
	Wed,  5 Feb 2025 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789619; cv=none; b=RBdPXn2eHwf05V2HtHSTCygVpGz93xpEIXIY8mlbkN6BdIMVfU2WBR2lJIem1zF9h8+QrpZGj6XHHA9QIu1ZfIwPdy1hj7YU0QokJVhabYlO62TPuD5wy5xZ9wWoAhqbRVeurQ8vS0Z2raJYkUG5Qgz80rlXcr0hksl2r6GmDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789619; c=relaxed/simple;
	bh=ROIwAIDYmaJQqhLYCi+LKXx1tCg3tkrGe92qJKALfGY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HVgCEKdHHMm6rGGyfKImwEqXJTdJXEZgPqxZ9jP+bWjIx9mInn/jd6FfLp4uDMQjfOyUMfYPvRN21ixAJyHLbJyZfulAxibyiiLqVZFq3UyuljwVwRlb+Dw0om5Q3MIDDFkAFArAu4Qadc+cXeOn7UrHJ/Vol0DfhzXTu902ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpy14qga; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-866f414ccedso94215241.1;
        Wed, 05 Feb 2025 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789617; x=1739394417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=321Yzdb9C7R/V5A/ZTrGrsUuNiJo9jCyp/WhHvYvkN8=;
        b=Jpy14qgaDV7qRHhQDLomF658Ap5AZS/r6TPS58+mwlf8fyNJeH+Z5eQ82tt++Rn0Vy
         6VpTrkx3ccMB7qP0TG8sbDAd6dV879yqRilYmtR+dA9eLY6BKPLdeNAo85Z1VZ3Av+HJ
         HuwXOQHSlJw0YB09YE2Q5uMEGXqyJHPu/92FrFARcUl49EYHgDqw4zU1rMs5FP+9ZKL5
         LRw8Dm3wtlrmEmxf+5qN5z76/GkvGLqrSn1ouMmJONLzJtISIUlQMtsxh5Q8+kCVf+Im
         GvBvfy0kMAMKjX9WUZKEPttLPyWx/dqM1NTT/pM1EOD4NJA+XPczeZo3Gq5hDNIb3u9E
         OPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789617; x=1739394417;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=321Yzdb9C7R/V5A/ZTrGrsUuNiJo9jCyp/WhHvYvkN8=;
        b=vVkSGaSaU/0j22Mi5bw/Zj6LLR+BLSRdh80gkzhg2/BJGrDCxoi1T+K4DC0lNjVetO
         CZo4IoX08l16b/rI+KgcnGOAZhuwMJkW1BiAX8ICzSnNdjSSZ/vXAUmMKHQ9WJC+fXHc
         3d7s6o1/reGTIgSUYCGAgfu5uMIVtt/zAgltOCiIasTdEb8MrBc+rufiUmhA9R+jaFuL
         vn7S1cOB0mNpYCD6Kmhx0lhV7FuBg1hnIBSK7a55yBO+ehoEhruxlZy6w15dxwxbArOP
         Erzl4jqxZzJx9nM4wl8+UscPpSZtpTbUWkF4kkembX+muhwxC8XRNLIKuf+YNHAQqihg
         sFCg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhBeQWz5otW0D2nvs8OGmJam0y1Am23rrwET8vXuVTadTgUWPFUdPSt6XrOxBHNzt276oxJq/aDYoxA2vF5d8@vger.kernel.org, AJvYcCVhTuEEQARKy0XpLy2Pofo/EtT5RshZ4cXnCMYw3njcTDPqefx2NPD+wTsgxUtEi7QGIQhaRuxy@vger.kernel.org, AJvYcCVq9agcVp1DPF1mAbmhqPm9K6lL37NnaDD/86BFNVFSK1i59m5ZQQlGZvc+lEXD+J+ih/A=@vger.kernel.org, AJvYcCVuCc6kRhU9H75XLjiJnTRsDJORSNk22/a0kA9cEos4vZVzMy8+NrG6C25angVvY7JhKcwCLr90m3aI@vger.kernel.org, AJvYcCWf1xU4pH9SvILCLkxs2N52UWXkkUd818nL9xt7dl4jPkude0rbSXUv7T2i9kLZrhGkPbF4vzumdgKzMO64@vger.kernel.org
X-Gm-Message-State: AOJu0YwARW3viAcBKZIVboRWyryoPRq/ivlzt0szjoZvDsiAOdhCP7+s
	9Nn8KthB63brU1Vni4Wjzqjm1hhicWu/rdh65BfXqc3PN+RQOwud
X-Gm-Gg: ASbGncuxd8h9x05WbFs6nMoGDUOKqVlnqeQDqMKnV69Z8gWTEVXwpQdDrLrMx9KW6mc
	7abgpgFyZp12QrbxrmCFJog6/FUVACRe9tGk00PKdmUoomtbVP58nJ9c6szoUbeJNRkFK7+A/+S
	iXE7+5cnZA6sXOGoJLvO+gEaIX8h496mGB8yqnJeUwpiXlUYOBI7d23+NAX4k7Z5foUzhorcCWn
	GBewvDwbC6AFPoNdYmK0+jytylrzdPdOHctqSw7hiFk6ERi/DLqZzVT9hpL9/a3R6S69Lj4RELZ
	gvOZdybgMfFjdWDCGgz2Jo2Y0daVmXhAu7kq1WR74yGbfPPGRePyVeJCDnuKRS0=
X-Google-Smtp-Source: AGHT+IGjmsT1CX6GHvVc7jQLN8frmEsrqlIM1ufKny6kJV9XpmTxVc/Kie419ULGnj052Qaq3kcQhw==
X-Received: by 2002:a05:6102:5e86:b0:4b2:cc94:1d6a with SMTP id ada2fe7eead31-4ba47abaa0cmr3554439137.19.1738789617063;
        Wed, 05 Feb 2025 13:06:57 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baa8e4cfsm2451368137.11.2025.02.05.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:06:56 -0800 (PST)
Date: Wed, 05 Feb 2025 16:06:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
Message-ID: <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
> future changes easier.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/tun.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>  	return tfile->napi_frags_enabled;
>  }
>  
> -#ifdef CONFIG_TUN_VNET_CROSS_LE
>  static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
>  {
> -	return tun->flags & TUN_VNET_BE ? false :
> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> +		 (tun->flags & TUN_VNET_BE)) &&
>  		virtio_legacy_is_little_endian();

Since I have other comments to the series:

Can we make this a bit simpler to the reader, by splitting the test:

    if (IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && tun->flags & TUN_VNET_BE)
            return false;

    return virtio_legacy_is_little_endian();


