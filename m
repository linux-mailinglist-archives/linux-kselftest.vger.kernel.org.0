Return-Path: <linux-kselftest+bounces-42553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E630BA746E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CB63A3E59
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Sep 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107D22F77B;
	Sun, 28 Sep 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N16VP0Pg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FC134AB
	for <linux-kselftest@vger.kernel.org>; Sun, 28 Sep 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075220; cv=none; b=MGW1g1rhKywWQFmP1f46XJvWSjiMF++2xR+MFDIB3IR9712hp6iHy9Rv1Kam+yDI+bQm3CguHziOyTZcno1wUUMCI/JXKFe9zp6zVAA0bsf2g799lX8KndIjUgqA6Mf9k35BwV46eKWABvXtwQFljYZdmb3xAUu0KAw+23nGhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075220; c=relaxed/simple;
	bh=qS/T0bA5Nab7JjhSU/T0oHF4h9/VtZyfnVkiF2bOXak=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nbo7h4/4q5g1fN8N7oS5X7eUStiL6Ynj1bSYKdg+PbVr72xHdWpRTlYRiONh9rMagNBvYJqs7yMFgXLfogr64V6Bsd1z31uYoJVuQU3a61SVohjiizjX0zF6jsqHVpX4rPxCu+oBBuP9LzbWecVmncOM+V5kSlRqwpbEFYwj5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N16VP0Pg; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-923f46f6c59so455419241.0
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Sep 2025 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759075217; x=1759680017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQij3aadeY0LAW28lv4eYbkkFZan9y9iCIkzV96eR0E=;
        b=N16VP0PgjuSntLiIcRJVugJiBjkYaU92I8ppxc40S86eFz/6EFb30t+djUm3kyPm6X
         acEv2YH8SiBxb84L+1AmP1O4xEptEFSghnzcfx1fxD8/9VOi3CJMnJ37aR6KTmbz8/U1
         KnCeVpU4VoJazGfeD2bcfeiayHhKw7BTxOmwGqa5iksBEGq2GSu/2kaG9b0bfZY50X/s
         Ra+3hGQHNguWsT0Gq4OFGjcI87RtHCa9xbcmCvA8sNSmpAFL7ePhEcy19kF3Cv6N4q/z
         hVlIw8SYGG3ufZdB88uLWjTySM59xng10gwfEVZ1Q8M96XeNXHq+/jSekEcLGCY9TfWf
         L7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075217; x=1759680017;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AQij3aadeY0LAW28lv4eYbkkFZan9y9iCIkzV96eR0E=;
        b=pWdyIRXLMfM0oxw93i+0sJ7hm45jiucHFcAuBnLz2jDWMVDnX7Y2RYryf71QT9BEL+
         nZ/T8lTYqmKxQh0EWK6U/2jsUcJr1XKbmLNImXTJZgu0g9yihaYihte3rUSjZYqLFYA8
         MyfTuQ5hoXvDFsmshp98mAfCD8ohg9uogBMjvwDuKR8JBpxyU87WdVYT8UOysrwy3crZ
         ynEbVfW5BRwC0SKeXJ2VVkzY1Ks7OuNUrgnBX0VFfjkTQPpu0HsblH0Tnyihsk6FzgSv
         r5BgTInHx1JttIFL/bkakEhzGl0lqF4XNaPeEZ0f1ow4pVQ2JV3am2X3PN7KNUfKlmlY
         ucnw==
X-Forwarded-Encrypted: i=1; AJvYcCUYKdD8rdglJRCXsaGAh9SopjYyDby3qx6HsEag+NWjX+0UPHQD6G5vD4hbhr67aMPrH+Ca5ADLPJtpuppjs7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhck3T7gturqYA1WYax/TpMG2xrna+wOxJ/v78AV6+h8N70sN
	1Iue8JUA9sS3JFelGKl4YAZgWGGvoRkHk0QBas7hh3ABOstoPVCv8dBw
X-Gm-Gg: ASbGnctcGVJ/3qgtXprwxVeD9YCGkdJsxX82t8HIIn/5Xuw9wgI3Gvifc46KKw6rjXG
	u4dg1gwFnCugF4EKo7/LSJMF0EspBBycPVdrNs/hzjP0OGANCxSWAn/vuztPhiKRUV6hcIA4aLj
	KOertzza6+4DabzYEFUZcIv2q9QF4S30WuPyG8XGP18Z92lj3NkS+VY3pJ6BA6Eg6vN8iBIK27Y
	xkna/VvXYKpyiF9SCnDdPD/UTM9aj26PPx4t8aVAp1oR1jHQnj6Dhi2vd/CEIBQh/EfbX3H1F61
	LTF5JYrXrOkJJnNdn1ltulQbg+Cw0CLOHX6F7QHHrgAl6QXY6H3YRM+Gg+mGmoxqWDF88Xh/uWu
	APWjBvLtzmCKAc8WKcLNhEmrM2Fs9yqzexnUKBQE7Ytdm3QO2NN+smaBve9axgI5VizF0vMBd1q
	nmrzeBXIMZD8VkfWw=
X-Google-Smtp-Source: AGHT+IF1U+3kTmlbysfzmndYvyQ7HgwEMnwNp44lzddu4VE3gWj4a/8VkEfWQHbq0trE/hmDz9Vw1g==
X-Received: by 2002:a05:6102:41ab:b0:596:9fd8:9268 with SMTP id ada2fe7eead31-5bae22fa7e0mr2488741137.8.1759075217265;
        Sun, 28 Sep 2025 09:00:17 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54beddbc629sm1831374e0c.24.2025.09.28.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 09:00:16 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:00:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 shuah@kernel.org, 
 daniel.zahka@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2e2661b9a8ae9@gmail.com>
In-Reply-To: <20250927225420.1443468-1-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 0/8] psp: add a kselftest suite and netdevsim
 implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a basic test suite for drivers that support PSP. Also, add a PSP
> implementation in the netdevsim driver.
> 
> The netdevsim implementation does encapsulation and decapsulation of
> PSP packets, but no crypto.
> 
> The tests cover the basic usage of the uapi, and demonstrate key
> exchange and connection setup. The tests and netdevsim support IPv4
> and IPv6. Here is an example run on a system with a CX7 NIC.
> 
>     TAP version 13
>     1..28
>     ok 1 psp.data_basic_send_v0_ip4
>     ok 2 psp.data_basic_send_v0_ip6
>     ok 3 psp.data_basic_send_v1_ip4
>     ok 4 psp.data_basic_send_v1_ip6
>     ok 5 psp.data_basic_send_v2_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
>     ok 6 psp.data_basic_send_v2_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-128')
>     ok 7 psp.data_basic_send_v3_ip4 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
>     ok 8 psp.data_basic_send_v3_ip6 # SKIP ('PSP version not supported', 'hdr0-aes-gmac-256')
>     ok 9 psp.data_mss_adjust_ip4
>     ok 10 psp.data_mss_adjust_ip6
>     ok 11 psp.dev_list_devices
>     ok 12 psp.dev_get_device
>     ok 13 psp.dev_get_device_bad
>     ok 14 psp.dev_rotate
>     ok 15 psp.dev_rotate_spi
>     ok 16 psp.assoc_basic
>     ok 17 psp.assoc_bad_dev
>     ok 18 psp.assoc_sk_only_conn
>     ok 19 psp.assoc_sk_only_mismatch
>     ok 20 psp.assoc_sk_only_mismatch_tx
>     ok 21 psp.assoc_sk_only_unconn
>     ok 22 psp.assoc_version_mismatch
>     ok 23 psp.assoc_twice
>     ok 24 psp.data_send_bad_key
>     ok 25 psp.data_send_disconnect
>     ok 26 psp.data_stale_key
>     ok 27 psp.removal_device_rx # XFAIL Test only works on netdevsim
>     ok 28 psp.removal_device_bi # XFAIL Test only works on netdevsim
>     # Totals: pass:22 fail:0 xfail:2 xpass:0 skip:4 error:0
>     # 
>     # Responder logs (0):
>     # STDERR:
>     #  Set PSP enable on device 1 to 0x3
>     #  Set PSP enable on device 1 to 0x0
> 
> v3:
>  - fix netdevsim bugs
>  - rework the skipping
>  - use errno
>  - remove duplicated condition
> v2: https://lore.kernel.org/20250925211647.3450332-1-daniel.zahka@gmail.com
>   - fix pylint warnings
>   - insert CONFIG_INET_PSP in alphebetical order
>   - use branch to skip all tests
>   - fix compilation error when CONFIG_INET_PSP is not set
> v1: https://lore.kernel.org/20250924194959.2845473-1-daniel.zahka@gmail.com
> 
> Jakub Kicinski (8):
>   netdevsim: a basic test PSP implementation
>   selftests: drv-net: base device access API test
>   selftests: drv-net: add PSP responder
>   selftests: drv-net: psp: add basic data transfer and key rotation
>     tests
>   selftests: drv-net: psp: add association tests
>   selftests: drv-net: psp: add connection breaking tests
>   selftests: drv-net: psp: add test for auto-adjusting TCP MSS
>   selftests: drv-net: psp: add tests for destroying devices
> 
>  drivers/net/netdevsim/Makefile                |   4 +
>  tools/testing/selftests/drivers/net/Makefile  |  10 +
>  drivers/net/netdevsim/netdevsim.h             |  27 +
>  drivers/net/netdevsim/netdev.c                |  43 +-
>  drivers/net/netdevsim/psp.c                   | 225 +++++++
>  net/core/skbuff.c                             |   1 +
>  .../selftests/drivers/net/psp_responder.c     | 483 ++++++++++++++
>  .../testing/selftests/drivers/net/.gitignore  |   1 +
>  tools/testing/selftests/drivers/net/config    |   1 +
>  .../drivers/net/hw/lib/py/__init__.py         |   4 +-
>  .../selftests/drivers/net/lib/py/__init__.py  |   4 +-
>  .../selftests/drivers/net/lib/py/env.py       |   4 +
>  tools/testing/selftests/drivers/net/psp.py    | 627 ++++++++++++++++++
>  .../testing/selftests/net/lib/py/__init__.py  |   2 +-
>  tools/testing/selftests/net/lib/py/ksft.py    |  10 +
>  tools/testing/selftests/net/lib/py/ynl.py     |   5 +
>  16 files changed, 1440 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/net/netdevsim/psp.c
>  create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c
>  create mode 100755 tools/testing/selftests/drivers/net/psp.py

Reviewed-by: Willem de Bruijn <willemb@google.com>

Great both for coverage and as an example device implementation,
thanks.

I'll leave a few minor comments inline, but nothing that really needs
a respin and/or cannot be a minor fixup later.

