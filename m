Return-Path: <linux-kselftest+bounces-36099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2DAEDCE3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E94C1896C5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712E28A40E;
	Mon, 30 Jun 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3mWbLF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A928A1F2
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286845; cv=none; b=nvbi1gAa0Vbrh0IKmlJYKVobkOSvicWzTe/YPS18PmRDKOn8siM+rMDgLaa8TgelZeHBtFqYz/gxni3ewbqMFHHvLdvPCysV8RsXSPXp9u6Y3SJ4EPVAWdNy3IL4UdtWNmguZZvjrq2bAQj647HFq3iRN1InVyj0A35MjxRSXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286845; c=relaxed/simple;
	bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQ4KDIuDVEiE8ZBYvD2ri50kXxYCnGn0R2GtJi6vjWlH6OypZMC//lO1uRBWwGuncCx6VmGnDm02VQKJNsqsR81+GRhIB0cbYZ6mfD3Q2Apk+Wodj1ABZhavqK8fW8+bS0vkaxqo/6uyFJ7iK4we6qLyVS7NsUg6ZpEkkaLKCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3mWbLF2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
	b=Y3mWbLF2/wVsNea7lbrpkUnWhxUUZXSHBZuBNT+9F0FJUVMojqoFUXWW7drRQ+zUUKbRSS
	/Pl17tTOebIid38Dh9bSbS351RKlqI+cSQ8ya2TfxtqY8CZ06RKzK3fEkQyPCXRjw6vHR3
	EmyMTe2vRW+qfDIBc5mpggawlHbBurk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-B0cn8beiOpKWVkQcgLSHuQ-1; Mon, 30 Jun 2025 08:33:59 -0400
X-MC-Unique: B0cn8beiOpKWVkQcgLSHuQ-1
X-Mimecast-MFC-AGG-ID: B0cn8beiOpKWVkQcgLSHuQ_1751286838
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0d05f1247so373590566b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 05:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286838; x=1751891638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr7o+AhIe8W/kujSZ0TmudTZC8WByMRIydCsP7iETVg=;
        b=Gq46Ty7JkE1hC7OlzmdfLSyCugpI8aKRBAYzktU0oKZ6U3fSoWKqGuqC49COiNZMwY
         XFTX4y/jWBdm726onU7xxIuWETrsfkamAyTwoi91xy0Ul85H+bCkJ8q7ekNH/jwfgAXe
         gAFoVxmqPzD5qIwGCeEuz8utH1a8/EoUH+4Rv3PDsSH2s6/BzcomTcwQd37COnLTJmJ0
         pIg6C2Up/CAg9b6Q7nF4qJpijeNMqW15wx22K7RiM2bI3goaBWwnE5parZO7MDwdGrPx
         /a5s1/eU1mhPJ1PN02f7cL09DrWR3voMmZ8VhGLOz86+V7Q15WSVM1CrAM9H2ijbRk+V
         /STw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y7Hgk1V+S6tiioFK6VW+iGGrBF8vlC6IEQwamFryXGEwhcJ1PNV27Qv5FKkPpPBi/zQMBMtkAWm+9ygsBhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcvVBNbqbcT4kaoBJx8k8JwuNnY37sR5bmGtmoZ+D1uyT23Mq
	aKPyh8XATzh60Gk6Ixh714u/c77p8rb4f4p92YrtL8sMOuEyZK76Ke4Kttvw9eV2isfmIY2WENE
	3dOvIDGVOknSlEDlRo+8z6NdxXgkh9wPTD0V0qnSqNSQWRV/lQbYp1BcrZbo48FsDJbhUZQ==
X-Gm-Gg: ASbGncs+igxq2rS1vo3+qiUxSp1PcITptqTPeDex4vrh7pb3H0dwVmRYv/0dMf8CFyF
	svsMdjQO9qySSeCqkraQRjSL1dMf9bGOIGzs5uLlq6GMeVlv7LN05gh+CcDy6fbOHKoMww2uHBf
	3vQOpdt00YmlQWWrrYStQK0mvjTd8lxn7oPz/iQzxr68ySNGxEPdadflwXvP306a3lzsnEKeH7H
	vpkxBoTw3f93V4vaHj/t74BL9zBEShWOwFRlMHp/zyu5cKjxvtYu9kC8XQ8bZpSNCtrkiF2qjD5
	5pv/oGqeu6RfkFQM1F8=
X-Received: by 2002:a17:907:96ab:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae34fef316dmr1364967966b.27.1751286837867;
        Mon, 30 Jun 2025 05:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuQ/3n2JvnKt441v28aLfjQg9cxjikB7S9KyuXgCMAmI7U/YvHsnBgQ7OKUwQQwaMZ+a9ETg==
X-Received: by 2002:a17:907:96ab:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae34fef316dmr1364963966b.27.1751286837372;
        Mon, 30 Jun 2025 05:33:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bd2dsm667503966b.113.2025.06.30.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:33:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E0FEE1B37D1D; Mon, 30 Jun 2025 14:33:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
 <20250627200501.1712389-2-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Jun 2025 14:33:55 +0200
Message-ID: <874ivxh0i4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


