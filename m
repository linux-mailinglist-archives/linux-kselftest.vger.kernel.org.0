Return-Path: <linux-kselftest+bounces-24131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19CA0780D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCD1606D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B338218E9A;
	Thu,  9 Jan 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZZ2I2P6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD01FFC4E;
	Thu,  9 Jan 2025 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430397; cv=none; b=RPM+WL3th5/ufj215eWJUwpuAmwHJQgKxIjxMwNA+/u4shpvpJHz/N4FKXfDB87uIWxD752SLCug7HgGNL1ngvyROsROmMcVs1YUN2Id9Bryfmpdi6YWBA1BYfigvmZWa5wUbN4WucxYVOAbvfNRjk6njMtt9dBG+FGGMxkkgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430397; c=relaxed/simple;
	bh=JWND2bHlwFHqnWFA2cA6tDBVVODeVDShgKzt9IWtlac=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g4Um7lOZq1v2KY5XdbJ758mpF2gIffJWnBxoUtGd88m9TMG2eOJgQResYJb0UhnH1XSPK4cjtTtEzWLvlfDT5SpM8XvtRre6tWS0UDtHfqFE2JtnfCrabLSCi11xufXtrKv6V4Dr5ZtgU3gvdkirp4rL2ed70S5EacIEoSYbd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZZ2I2P6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b700c13edaso47412685a.3;
        Thu, 09 Jan 2025 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736430394; x=1737035194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8ngqEeCWslFnwkv4pv69GyH61S/m9Qjg59kl9p0QvM=;
        b=ZZZ2I2P6siiNu15Ank6E5mUBC5RQWZfmBKDB20/rLy2y88T9OLlZogZelL0gs8ZEQb
         x5WEXVOJRZsKJJF46OQ4MlfEhOyvk0ISGeW39QINwiF6p7RGCeXed23gSFt1PP+2i7qP
         y9jv3U9KLwdfv8VCg87Kbq2Wrh0pzhOOMXSomkXba7gl0xf0qNIXNgTYhrKJYEcf8//K
         3ceFnjsYe5XDYBIIvDvykOZjWRZPnhQQV05bPuhgWzpeqa7gn+NZpuoMHTFdSJUzD8va
         qpBRf17MPbIAKqhnfP3v004RYU8WvZ8Xat+RC0kecPSOMqkPObh13wbcCWDHfGrAGPhT
         00yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736430394; x=1737035194;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8ngqEeCWslFnwkv4pv69GyH61S/m9Qjg59kl9p0QvM=;
        b=UHWkfV80rYZ0Zlo5s8bapUCr2/oQdsrmAOL3Ra+YAjIDrZ0N32Q9XzuTqMrXWEEbKA
         r/wi6/W8ZE0vTQco6kzWMeyLzKRnrUeYWDlY0AeT5W5ljMlJ1dp7WMlrmfQAqgpofW7T
         CnWRYOeutxVorjq+F5/OOaQjvD5wxL5yzTUiU1bX+/BJKq/t3t0Gnua2W1KRL4PUlqEb
         KlLXB/2Sy+TCpw1cC9cMpcrkd85MWAdblu/nJL2rDc8Bu+UkrEg1VedoUBtjLQr/GoO9
         +8pFDVFMvzG0EiEMXhghsX/PyOBmiIi1XmbPhZh2cSlHX6n5rFvRpLBl46eq/8dJrwMK
         xXNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24n01upoX5ecwI++gzM5gPDAXwAm7jlbn7ZtsrmGM3GBZpCNgwDpdE3b21S4urK9kFVdrLZRg@vger.kernel.org, AJvYcCUx41TDdkUZk2nlWSUozeXDrK3SxT4PIl0ycJJYqCiNxC2iORvARkNLUs/pVSyHEZkFvFA=@vger.kernel.org, AJvYcCV3Tk24eEkCHn1+MNgBEkfdJcAw+79GEu7berDI6bHU7v1tc7k/GFUWS/SW5+88APyKUamWz1vG5wVW@vger.kernel.org, AJvYcCXaBE93mwn2VmmssW5oJNIB/2n6+o5alqIH+LwvUYvntrCdfeL+wOwbOKwMdoj2h5hy++TWZMozEb6xbUcJpH7E@vger.kernel.org, AJvYcCXcm4FIc7FH8uwhImqUP8EYbttZsP06m8qInd/k1v/uDCn2qOqdhL9CZ1ZrCUY/eF0SiuJhl0gRfI5JdhcB@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeBBKUpW43vjflZnB+4L4wTgZdj0b2dn4e1MUUJqzUwcnVU1Q
	yjwzO1RwrhU0grt3xSdWM1LGJAXmjK7F311P7vtifMEVyUAFUbfU
X-Gm-Gg: ASbGncsEy/OzT+m1ESbw3NA65ARyxdaIv2o7Fmiodu7urrP4qCIb1z9jPBvRY+NDooH
	7kS9iedmx0FwNNO9+TZgIJBFbq+ExvGZgDbQsdJrvxNWFG+uHpNLUeCDm0MgD45zdeeItRVySeT
	3LqWkoAjK2jD8G+6MSCp5EM+siRPoCFlT5q6ckaeS1H0rhr5UtRzCXHiTSJ+Nwrb0YFmP9dXql0
	pfp2zqiPCC7MDkBVwH1EvNbffleuUkEzOdhEbLahrSjtylq5E7ghMWFw7M8GThF7u5W/fZyYKDF
	l2TksFnwMW5w+/glz6XuDauZq+sg
X-Google-Smtp-Source: AGHT+IEoo0DgH2YrU+DTme0xfEmNzK4L/V4paiii7CUCTVSordb/Xkqsduik2RsPGbTD3CGaIVGcpg==
X-Received: by 2002:a05:620a:2485:b0:7b8:61df:f5de with SMTP id af79cd13be357-7bcd9762c4bmr970386685a.45.1736430394183;
        Thu, 09 Jan 2025 05:46:34 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd7debcc33sm124773836d6.123.2025.01.09.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:46:33 -0800 (PST)
Date: Thu, 09 Jan 2025 08:46:33 -0500
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
Message-ID: <677fd3393b354_362bc129476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
Subject: Re: [PATCH v2 0/3] tun: Unify vnet implementation and fill full vnet
 header
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
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (3):
>       tun: Unify vnet implementation
>       tun: Pad virtio header with zero
>       tun: Set num_buffers for virtio 1.0

Patches should explicitly to net or net-next.

In this case if the undefined data would be a bug, that would target
net. It sounds as if this is only relevant with the upcoming hash
changes, so then it too can target net-next. If needed at all.

The first patch is clearly net-next material.

I would prefer to work on that independent from the rest. I'm in
favor of deduplicating logic across tun/tap/pf_packet. Have taken a
stab, but haven't gotten to a concrete series. This indeed a valid
deduplication effort.

We have to make sure that the code is identical between tun and tap,
or where it isn't (due to one of the two having received a change to
such code, but the other not) explicitly note that in the commit
message. As then it is a behavioral change.

Anyway, let's send the undefined data, hash and dedup changes
independently. And preferably one after the other, rather than
having concurrent conversations across threads.

