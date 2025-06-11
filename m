Return-Path: <linux-kselftest+bounces-34661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F77AD4DFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE63188769B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A87236442;
	Wed, 11 Jun 2025 08:09:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB82356B3;
	Wed, 11 Jun 2025 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629344; cv=none; b=lISXHNtI/Ftbwbwl4ZZ6e7telmBWf4SaaKIkuCd09v9XlyMTyyAi04vFU0Hvuho5d4Ei6RDmEySPk/fXprv1xXg1gmLJTtHz3H3B7D192wxNocurYOjGLAaIHwOoAC2ezaoM36UawmOImkVXHApWBJ65k6oqPxad2o94fPWPCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629344; c=relaxed/simple;
	bh=bb/gYoBGqnnv8Qs7r02fycV4dkWTGnthEecbIoM/PwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgsLcgSA7M/DYPeGA/isRNd/n04m6mASkrNkN+IFbIFVVd6t3M4sQKQfIVlBKx5wSTDoikKF6GBZPAnzpQ3QKXQ/QIE+Prh+oJJuA2jMywab1B5RkDuYCXB0cXTMzczgJBb5Pz7L+DFfrIy1v7ZtMMG4nWrFAmXaRxiMDhKPLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1135165866b.1;
        Wed, 11 Jun 2025 01:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629341; x=1750234141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGRU+Kv08xe5NBWzNvaRaFDet3u9/sA86Kboke4WJ9A=;
        b=kHS9Tn5+qJl99lehQqT16FVawKmtjMAY5bA3SIdSISW3hO87UQApHy6qAhU08EXKhd
         JFFk0cVdHhJ8/ekRcOXoCRtuPggdze42W2/JFDE+MlnlqBc5S+dLIDpvfgaEdHtDPNNx
         YIa2rWjAUaKe1c/K/wyKTeQ9qeWRLSHJbUYJBNNPeM2zYEpM2LopDjg5dqsQN8hGqIj5
         dUycMoWe1ELeAyjyCwpUZ/HcieeUn/C6l4hXuPEZ+FtiP7x8xUq11e9VY3vk8Cunv8nX
         ynmDi0iBMIKONY/5Ime6n19p5hSGPcd5hAwPmHjufy/ZOMNK7RO3ZK5uCea68INt+9Uw
         Zumw==
X-Forwarded-Encrypted: i=1; AJvYcCUBmg9H1DlrD3/tJVVAXow+Ipz0fPupTIwW1BU7dI11KuAQ6YI59GTEuEd89fWMQDRji9W+13W2BWNHjYUZb0a4@vger.kernel.org, AJvYcCVf/YqmSEOKDFgKRX9bhWi+Fk672fi+L9aYUm7YCgiJQ7jVwrtwiNujDTGjn7CkbXSmElT5RU/cX8T47K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6SY2geJoSFfNwkt6e50JDi3egI7rZEzJl6QQ5NEjJrViWMoh
	ukv2WNc0T9dzmmaTYSfY3mOoqGUBshc1DKuAARnlilMGoKqig93f0v8v
X-Gm-Gg: ASbGncsqkDHTTiakaRAu4WUZnD4l/JYyvLKy2ei8/ehzG8+a+qB0k6lxP9cn/cGT+ic
	eYJ7Q2KToHz4szMmzCdAQgZsaxP6v9lxsGpkIcDA0PT1ALRTegP3KDKw3X+qm0B9NrRyLsBGNmS
	oy3s6uGM5nh6NwexP1UuvvtHJnK2FpfIZkubjR1tFcwRteCW+Fw6e3W3Khr3DgaeDpaQNC6CMBO
	61/z7J+WVfjHs4IvghFybbZTzGQ8bMhJOIB1uICB3ma5MOwswkpb5YS0cc9UoGQzwFT4pfDEyWD
	4FYQp5M0vid88BQHA1eplEsp160kCsl+AIq7sgm4XkTtL4LeZYIiXksmJK1ZzX+g
X-Google-Smtp-Source: AGHT+IGbQu5qlFUouSqkJhPj8jhxnrJC0Olr7Zwa5gMMOkWdUeanOk7UUb5kvt1BxjCg3bkg0oosmw==
X-Received: by 2002:a17:907:9449:b0:ad2:2fa8:c0a7 with SMTP id a640c23a62f3a-ade8c76b521mr172874366b.21.1749629341249;
        Wed, 11 Jun 2025 01:09:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc1c5besm845927466b.87.2025.06.11.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:09:00 -0700 (PDT)
Date: Wed, 11 Jun 2025 01:08:58 -0700
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 0/7] netpoll: Untangle netconsole and netpoll
Message-ID: <aEk5mv69Ha7xyvPV@gmail.com>
References: <20250610-rework-v1-0-7cfde283f246@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-rework-v1-0-7cfde283f246@debian.org>

On Tue, Jun 10, 2025 at 08:18:12AM -0700, Breno Leitao wrote:
>  drivers/net/netconsole.c                           | 137 ++++++++++++++++++++-
>  include/linux/netpoll.h                            |  10 +-
>  net/core/netpoll.c                                 | 136 +-------------------
>  tools/testing/selftests/drivers/net/Makefile       |   1 +
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  39 +++++-
>  .../selftests/drivers/net/netcons_cmdline.sh       |  52 ++++++++
>  6 files changed, 228 insertions(+), 147 deletions(-)

I've just found that this current patchset didn't apply to
net-next, thus, the NIPA tests didn't run. I will send a v2 soon. I do
not plan to change anything, other than rebasing it.

--breno

