Return-Path: <linux-kselftest+bounces-24136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D6A07958
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 15:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393777A148B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F521A45C;
	Thu,  9 Jan 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0DMy7mN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860F217F5C;
	Thu,  9 Jan 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433381; cv=none; b=R/vwWrjSDnddlNpQRxLUOPukf+L4L2qUn/V2pq1POqa0uy+W0+gFy65gtiwopv2utEB0UZdVwsqG7h+3PXoepRiZo0McgwIWnkx1G7Ceqr8JRwyOZWPjgDMQL+6Sch5QceJla+bUuL2hhQ7Ohp4SNih6YPslXOCyzC1pau76DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433381; c=relaxed/simple;
	bh=msjFFpRNIoIz+b905oDvoFmaWYdAZMtswIZ6602H/P0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j1K/k33YR7MUps//tPQdJl04UzWOfsPLZN+hNEt48jOgOMIhsb0RGd3iHXSzDMol9dPi3ZwVddPpP6poCC6g4XStmC3eYJEE+YPiBaIjJogDED5WEPf9iRCz+NeGDJ2ZyT4gE8SwFgevm6blsnBUfmBeFi5SMcay8hI1feHbc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0DMy7mN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7ba0fa25f07so76119085a.2;
        Thu, 09 Jan 2025 06:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736433379; x=1737038179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNunDNoIF2mrY2oVc9mlVfBWrl6u/4dyH5yl1p2uXyM=;
        b=T0DMy7mNXZaWp2NIzgA7kdxs0X0CX/RqKF7VVrZwAZ2NqP1sfJvt67QyTcl11rExgp
         QFmVtqpvxkjL2q+dC0imfV3Mk69SReMERHwB19aOrwNS9bsGjMVTbOwX+UZ1OTT88nNA
         7S8yXc9u9RGLNugdCf8/UMZZGf2VUu/beGBKF4zud3zqYQJHxziwJi1pdyfj+YKtGN/3
         +kjolqqAttm81vtvcHL7U4TTlzD3Ud+kazxtm/uycpxqtNE/eXxmfnvPQjSeS9r1HxDx
         0hSnwrIG3B32o23C1jTTPmfes+t2NFReC1nBalfQeSlhcBV0+w8q7JYAhB8ckTZO6a9q
         lYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736433379; x=1737038179;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNunDNoIF2mrY2oVc9mlVfBWrl6u/4dyH5yl1p2uXyM=;
        b=h/KvEYimD7uhq3QkBuIwPmQ6yr/hybxa0Kr9RPsMffCaVX6On5TykBaKDDq5nVTCur
         1lUol2yjfcmx9xnwUwcdIBLhMou1beJmOnaYsWoXRj2qtUH8myIEC0a+Y9joVuLqzC4H
         ZqSLfbQjEOI89GLIzzbZvDBMpgAh4aZNzPBmKt3HJbKcPXOIMegQFBkthz0ouTSVN6J8
         1RdXATMExfZ9w5WT88SfqI3vsMWezlPLjcDlri4e9hpkd7BG7GTKAXqubPMiTZQbgYAi
         Gqou6zN4r87CqwQyreazAeEiu/fBHlM42hEa19+s2kXzqOTgFZeX55uJ9P+GGtJ7+JSf
         EvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5MNYdE5HUvlGU+haQchDZidbAfBZjZwUjNSdfn3f4JrVyMoaEVFc9fBPfqar5L0hqrakt5PpbIcK5@vger.kernel.org, AJvYcCVToJIz0W7fa16ZW4ezm9QRYpDhtkm5G07BikgkX6suucMFEOvlh+ESMjplPT4y1lcXZPQZwfPQYthyg4yX@vger.kernel.org, AJvYcCVs04AON25hkCJxhktv7gR1g+DwyL37k6ndMuKuedUOXTV0cSK01fzIpD3/klpclHddT9Q1afAgQ9+rGDRBEPis@vger.kernel.org, AJvYcCW9D+6MjmFqBfCXgljNeCm7UAVq/aZUqr9KvIGMhHHVxS60S4hDKWNXJL7wNhGp/MEUVpXLTJ0+@vger.kernel.org, AJvYcCXBGPfIc0xX3WbByN86kopjLjco79E5ILN4631Ev+bTGgybFDS4HT7QCs/YdCSsgslWB0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BokhRgND5/uUXgxaFXAu9/EdhwWuaeOgSu1pMyBSnCK9wkcj
	6LCpxIM1on8AzzZgmAHs1Afem+UIelQ9XhNgdxxyiRsytjVUxmmv
X-Gm-Gg: ASbGncv1Ue+VOVGWXdyyKyzOMQU1HWFcsndEHUY473lO1pRB9rDkIWxYXsfRumox/yr
	rYtzRRt2byOUXPzEavqKlZsQwopHqC+H+wH0vbFjYfCoZGWnema/GPGGDEegiR05Y8kJFeiEIiT
	pVBLJk8H7zbReFIVHRMNBwQ3zcOhFz6heEM/DcH3LYijGQyIaTfndJ4lKqbwN+xpkAUmrH4cKpY
	yqiKWIK41wWVOSFPccf54XLDt0kHgNq46avvCQJuZrs8Gld+2TOQHrr3e5EQ0u+18zbfA1QwQjN
	iSsUyITOLmwThqG0WPVfzunkcC9n
X-Google-Smtp-Source: AGHT+IFryBKl+CgzeHnlshqOHgd4HEgss/hRNR6TRDEv+l/RB0gB9QwsktP04rpoXg5ryVYIaPfcmg==
X-Received: by 2002:a05:620a:4142:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7bcd970d4b8mr1005540485a.18.1736433378983;
        Thu, 09 Jan 2025 06:36:18 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm71749885a.100.2025.01.09.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:36:18 -0800 (PST)
Date: Thu, 09 Jan 2025 09:36:18 -0500
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 5/6] selftest: tun: Add tests for virtio-net hashing
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
> The added tests confirm tun can perform RSS and hash reporting, and
> reject invalid configurations for them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tools/testing/selftests/net/Makefile |   2 +-
>  tools/testing/selftests/net/tun.c    | 558 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 551 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..92762ce3ebd4 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -121,6 +121,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>  $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>  $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>  $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>  
>  include bpf.mk
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 463dd98f2b80..9424d897e341 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -2,21 +2,37 @@
>  
>  #define _GNU_SOURCE
>  
> +#include <endian.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <linux/if.h>
> +#include <net/if.h>
> +#include <netinet/ip.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <linux/compiler.h>
> +#include <linux/icmp.h>
> +#include <linux/if_arp.h>
>  #include <linux/if_tun.h>
> +#include <linux/ipv6.h>
>  #include <linux/netlink.h>
>  #include <linux/rtnetlink.h>
> -#include <sys/ioctl.h>
> -#include <sys/socket.h>
> +#include <linux/sockios.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/virtio_net.h>

Are all these include changes strictly needed? Iff so, might as well
fix ordering to be alphabetical (lexicographic).
  

