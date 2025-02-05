Return-Path: <linux-kselftest+bounces-25863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07EA29BAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39B21887E07
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823D214A7F;
	Wed,  5 Feb 2025 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKHCgNx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA0211A11;
	Wed,  5 Feb 2025 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789981; cv=none; b=lgJ2CRthiymaOpSNpw1EiixKsL8f3Ix8hK3yVDm+G0AVAR3M4r5Zs3tvdHwVUPlsH1jD9NCEW7u7GJ1/YxhoVzJus41RrJgPs+VEvup4IGKuIE+4vPgaPzu4UuB2xHYd+YCyTPJWeEqROJ8flOMX2tvgQ/I42+hUr/c9q+GGmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789981; c=relaxed/simple;
	bh=JFEi2wLeGZOf8BHQEKqWbZM9NCkw6C1VmawHgv9xFhs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=n/ppie2MFFB1m5yULi0uXL1oGHPvSaXGwtDx/LP/8or/H6fgJYVvVNaUjPVnnGmMSchDT8MmfuXtJjHxVQTUfzPncogFYx+O9guHkKoyv1NGaGWBPV3Tn6ciShJEj4LadViWw0v3Vx1Ld7J2c8xnX6r/Mus+Pr9UljZktRehrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKHCgNx3; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8622c3be2f4so42291241.1;
        Wed, 05 Feb 2025 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789978; x=1739394778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=mKHCgNx3dXUroUdCLbcgnaJmtVYDv/iluu8e2rfrBpJcgsizd4Iaikj7f1EEV7YKRS
         itt2vyQlGzsrOGSJYK7QEs2vlpgWZgem0qEM4jgSZgBFzwMjAEiBsVBXcPZLAbJAWkP0
         CtCNN/hIt0dHJCGXoOZapv41wIIR9zvL+Fm6Gjdx7V0MAX9tylV24R/ZGFUzxtD7jsEK
         8s01aQIsZ9OMHfgNIYUuGSNtUYjVL6zNCIHVEqfp4sqQgQDsJ/n5Mn5CdACxTmSlWesu
         F8SXJ5WQixp1S0MwxAEIxNx6sZ3M2TyWYtKZZQWGYgEal782aALVzLqOKJWlVXp9ceQf
         sRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789978; x=1739394778;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPbdVpBxzYO8pUJQAAuO4Xb4212ZYcCAfsm5wTEeKs=;
        b=W9uxfKz+32z33hXGk/p47Y9Wsi8W+Ca21AGpIJDxe9jN0qVD2BgEYfHy8BFgOAytuG
         rM9UheIKFgB42cHANaK84ED0ZWlEqy0b9Wi+gD1xgF/vL2g9QukCY2vMSTHNgP1e8pGo
         C1m54FbvdWu60kFYdh2M6dQR4lu/ACvyIoQ2myoXHHUaLkEDvCxtf8qRVwVFnNH23k5N
         9cpuM7V0nI3YXMaCpMG8tvzYvrTer0I8Z6a3TLmD1C5Msgq3Ph+ok2NX0tjTxrU62Qj4
         iwu1KRMroXs5ymmXKEncHto8nMICY7H8cQt85EIIOPsBkkFLuZ+GP6XL9lVIkbDMeZ4v
         wn1w==
X-Forwarded-Encrypted: i=1; AJvYcCU5bit7FLHKlYLLuT+tMcoFrWUx/Wt8idZBzTPlvi/h8ke9Asc6SPdvIAg++laHvKrF17i6dIA6mkEt@vger.kernel.org, AJvYcCURU7f5Urd8FNFcO+KAhCg3ZpGBOS7Rz94vrIEHWbVKQOxuJmrYanMT37Vp+JAjcCdewuQ=@vger.kernel.org, AJvYcCW0p2aBPm1DCg+7WlUQp97N37FdhRcUlZkYGzF4dERhYfF6i6meJHGSVtdXx1NZHYsqg1HOzM5bbdG2Ov6X@vger.kernel.org, AJvYcCWdKwXrLfmxaRa38oPPi237dc4di4K9MtwG6bi7SplG3P3JuhflmWTyX3q7nehT6xFh7KhvGops@vger.kernel.org, AJvYcCX+wu1ATCXvhTM5dzS8nJnQDZKP3Bmd721ZsEizHpDeMKzRlJJ89j4RSwCHw4eUJLBCmkLdiFGObDxbDxrPXePu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt85+rH0YpV4g1TAvnM8SZNaCZgbsJunqTgrqxWIm7dh/a3GWV
	ISWer+0Aib0PvRFrxw63mzrCiVp52qs60MYTqCzj+ztTg+rylG7v
X-Gm-Gg: ASbGnctvN/PBsrtpHMgyzUZVUf95fZacE7aWEl1itXBKSTxIuTxUsbYc6avN0Jh8dey
	r4fODB1ydFHn62byVyPX+JTHcm1/rV7ZSHTt3qnb67DuhW2BXs9eEiKmTRhN7kdBRcZWlNX9Iwl
	ofboZLSeqiaFmY+uVprq1yrOioZ87WxkERd3GImKje8wR9HEuWww4iXOO7G36YxhvbN8hoE5z7i
	kvWzpKANV48zX7tt+uYGUqg1tBPQRwGLxbQD5YCfTt2kIhFecFZmIJ+LrKyLLukWKieBgKp5HKO
	XYWlb1fxOuB1DDzOdK9CulNF4h4YI2RqLZp97cWxrlPd3UQhKmD+5vz+QSda5lk=
X-Google-Smtp-Source: AGHT+IE/LhqpvYWyeg5YI138zii1Tf41J5g6QM100haEEOrAXQ0Rs3YYuJinwr+QJROJhcSFnZ0nWg==
X-Received: by 2002:a05:6102:d94:b0:4b1:8b53:2987 with SMTP id ada2fe7eead31-4ba46fb5a4emr3251472137.1.1738789978520;
        Wed, 05 Feb 2025 13:12:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1d947d7sm1928864e0c.48.2025.02.05.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:12:57 -0800 (PST)
Date: Wed, 05 Feb 2025 16:12:57 -0500
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
Message-ID: <67a3d4595ad82_170d39294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
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
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

