Return-Path: <linux-kselftest+bounces-25862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A4A29BA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633E31682CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50523214A74;
	Wed,  5 Feb 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIo1bYdE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECD1DAC81;
	Wed,  5 Feb 2025 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789969; cv=none; b=ZzJH0mBKZx4zrromEw+KoGp9gxP/mnGUJaJtkWFAxWUHZESlTj0uOU/wrBLCzxfCzlzSGt/WsUVyORstS3n9Of1hti3/3sjBlPWEUeMnMvrFCv7UYukY2U/N6WSdyO+oXemVU0HnmjA6NBreimU9T+0FugFYPigRu9+gUkfsWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789969; c=relaxed/simple;
	bh=J5XE7MnQtbhTshwOYeuFwneZoCl0STqhgZhQmIg9y3U=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LPxIPeftwfHQkARl+M4/XVQauPkWm3jFHolaxxytt2eiacaqkl0uW2pJizu9+mFOPXNuZfuXPphtDSeBRq1NmROM6emnh6H/4qsq098Ew+mOk0y6UCy6A5MtgU3nFjCr8H1gdUMZdaoEH4XAdFciUZPfXn4jyBkdxdS9+CvyuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIo1bYdE; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso53540137.3;
        Wed, 05 Feb 2025 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789966; x=1739394766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xi9j7LZlV2SUJAQTXwi7YERrm0ctW3irKCQf/6lFSM=;
        b=FIo1bYdEb+Todk07dcaynDZdCqcLyQqRTm+P+FZNO2E8hB08nV23bS+x7CSx7fwzQ2
         roBZ4W4fOdhqzbKHE6tKLKEDLG8W//etdwOKBFCP95brcbsqq7URK0M2KFJwz4cjlyHL
         G4yzVf7j+FQdw/fH6VSeB2HGdryJZP49gq+AEkCKfdSitP8e/Ml+QW1VwJLsi94eAfFh
         gBLdW3LbygyvfnnKkzSTkE8Uuf3Y1jfWpwc7xZqigv+iLE6N0+jshI7mlxVYP5dh4JyI
         7yJrGeQMKhcxclFl33lu+s8GwEyTY+cwTTycIRvvtYeLfuqd1WOq6mpP44on6s4cd/Sv
         XzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789966; x=1739394766;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xi9j7LZlV2SUJAQTXwi7YERrm0ctW3irKCQf/6lFSM=;
        b=UtWqtan20lEGsRXeWvxEchMbGuu7KuiSszfORLj58um+zEySwG37cvYzuxy+/APwop
         YFlZE4OWIMPDlhRdQzkCT/+X2patmOgHnI2BF4scJa+edFtpI0SbIyW98gUVU3cuwyKe
         Q40rsQH9mn+ybecOEmRqA4sb5PwEefOH5OLG6/etlvP86JyoTCUe/o8OLiN1npQRd/k4
         9H0T4sg3BKhZqIpUVZONTW7Bwoav6MlrhEL95bz5tIqINEHzFfIGLfZlFM+8Vu6HTTmM
         KECz9dGHwIqmfkHwfzQLjhjRD7JKFh6W9OnZgCi6p4UGQVUB3fep8hmh7Je/XaUhcxJV
         C/bg==
X-Forwarded-Encrypted: i=1; AJvYcCUuhAEY2ZdhHn5ryXvY9CDTZIWo7GS8umBmfqbP+h++XXojesmcH4ry8lSbS1zLY5Gaeyw++OhWk+2Vq0ZEdh62@vger.kernel.org, AJvYcCUxMCkxvxjPNxfWWVnZGrGp2dnSZpu657IQX9lRduUNR/flahSo9hsMEu9YGRHlbT6WuL7ezQ7ACBvquO+V@vger.kernel.org, AJvYcCVj7kZ4lKROb9A6+OCcEZgEgAZlZG2sP8Av7RrmoBgV21eLwoaS/BDxpeWoQB1H+Celznk=@vger.kernel.org, AJvYcCWMklOraqU4rWkrnhcTnCsS6Qp5rKYyHWeWEUUmKFzm5UTX0q1HSVVAarMNE+R9t/1t5ejaRceY@vger.kernel.org, AJvYcCXv+LthjjIYf9FL+JPDpRDFN4FR3uNTWML7hg65Mq/U2UxTpOHxNSu3hzCzh2XqqDL1lmtp0i3bScIS@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMcLqC/d6+xGZGeSXd9MxBkH72ibkSQ4fqD4kXYsSOTAPiMGP
	aBGGMjKCmc6OA9HZn3poHYPSFxpjiAusaMhh1PfJLtqHxilWUNAZ
X-Gm-Gg: ASbGnctHR/kAiash5cBCQDM+a4Af27E6wjojzNf0r5G9FSqGa0baxP5hmAxlWUzkgLT
	K3I8NizNn4qGN/gK82d322jzauY/mJqYOVHmPuutTDqmBV2tSHgDeMjGkWyv4QrAQxiZHmIY0es
	CcZmDWdLWzxCxskKzihT7oQKXaEw+1lZoXhl7RHAZnNOn+FzfSNwfkBe00HzJBSRLemzS180Vjd
	XDbKPExoKIFQxlFE0QG6miA0ra5pRD1zlcEaU8fKaZ02jDmw5psZhwAIRRV7FxtB4YKmusfgUCx
	zE1BuqQ/hMvmedcbICjh4lJ6SZ2ChqMPndR7H5tsGFev3pnXl/w+Ep46dwoB75g=
X-Google-Smtp-Source: AGHT+IHVJriiE4RgD/TB98OD7KhhWkj9HMgkHe3bJLqoRArq4OYT9AU5jj7A1Z5rXze4Tk/0637oNA==
X-Received: by 2002:a05:6102:1609:b0:4b6:697c:6b89 with SMTP id ada2fe7eead31-4ba46dab167mr2854007137.5.1738789966444;
        Wed, 05 Feb 2025 13:12:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941f13b0sm2547855241.30.2025.02.05.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:12:45 -0800 (PST)
Date: Wed, 05 Feb 2025 16:12:45 -0500
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
Message-ID: <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 5/7] tun: Extract the vnet handling code
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
> The vnet handling code will be reused by tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   2 +-
>  drivers/net/tun.c      | 179 +----------------------------------------------
>  drivers/net/tun_vnet.h | 184 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+), 178 deletions(-)

> -static inline bool tun_legacy_is_little_endian(unsigned int flags)
> -{
> -	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> -		 (flags & TUN_VNET_BE)) &&
> -		virtio_legacy_is_little_endian();
> -}

> +static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
> +{
> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> +		 (flags & TUN_VNET_BE)) &&
> +		virtio_legacy_is_little_endian();
> +}

In general LGTM. But why did you rename functions while moving them?
Please add an explanation in the commit message for any non obvious
changes like that.

