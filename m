Return-Path: <linux-kselftest+bounces-36106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DECAEE0C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB707A2028
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61331286D5D;
	Mon, 30 Jun 2025 14:33:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281DEADC;
	Mon, 30 Jun 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293986; cv=none; b=K9YRLJBdgpRpYmD1zRQdS+8x8QpqeHgjslzFADNhGga5QKgz79hDM8+vk4G9K4t8NVW7asHH2Z9ijFUmn+ZJunANWon0yb2mIACtktb702Kp1QPO4nIhbDNp88kSu2PELiWgjU9RE0mp98wL2SW95F2IDUaN8UJSW94GhyG897I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293986; c=relaxed/simple;
	bh=qjTt84KBfEtBg95rqhCzltj23WXxyrqGZt9ItTvbZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu6CyhK3TwteqFhkduqjuT8hEGiEAih7YNt+XpdrHpd8016oK4VdlJi29jFLLHYcIA6cRncB4fv5EABnMedZMZJL3szhYb5wsSAfVzaN0txGfYNAvh0no7zAkC+TeRJWz6/49jbGgpRShkcyCg1ftIMemfB7swNuReTxGtWqaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3781940a12.2;
        Mon, 30 Jun 2025 07:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293983; x=1751898783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSg20GDoGMGjYNXdLie7adRbEtdaFM3ql2cFF4814Fk=;
        b=PoConTs4oyShUdUdbsiuExVpX6EHqS94CLUT4itzIFDIX+sM6+ze7Exbp3KJZonagn
         3/Y7MaJ2ezILtfj6+sI6P4+txQwW6OeFR9s3LgcF6m7sspzdY3P5HUI6A1m49spakcJE
         mDOiL4vNT9J2NT5eTyXTzDddkAAVRQvKhYxjMDTfDPVm6N/DyB1G3yEIc8T9mm2Shweh
         WrggjV5coheRvC9GsZoEkPnVKA3V+j8txjeWBt6ixZCE56XbeZkwG7JdgFnlg84EJc6s
         3tpAhRKPhqTWEIuUbmvC2bxG2RfwDBBtQ3L3MIBySOZWiBpgN0AHXTzxwFY6uU9Nk+fX
         pjwg==
X-Forwarded-Encrypted: i=1; AJvYcCUd/UA35kFZG2QTPKgh0oZmkE/FkxBiwxRw2qLFPLxY7cqwc3sdUSCahkJSG9Kye6vp7WWg/rqO@vger.kernel.org, AJvYcCV3ZYcvwSJ5ScoIL9mHPROK+tEK4xyvh5RAmJG9xkSNGl8xL93czLlQEuXJOhD64/t3UgpRqUd4SyFe/W4y@vger.kernel.org, AJvYcCVmCipOcm9Hwl9F8uPGFZ1vSPU/Vpj0SrcSZUaxFxXHZlIDY1oHMy4J79cXMYtifwhXo3bdiEbTtRFr3AS5zoke@vger.kernel.org, AJvYcCXkLq56VEi9VLlaFFtlCx00HrPTLTQ4aDR1x5qsEoxonkZPAIs2hPyMYvd7lNHdmteDS7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLsnVFs08Y0hK0s1IEejBbTNto1p8wDxMOjpsgO4rG/X8U8r6
	k/YhPVCHl1iv7Ymw8ykyd+1f5yvhyFaxVN7dRhLZrSC4SJDgr3ixqHAt
X-Gm-Gg: ASbGnctF/W3YgBHmJNaZu3IXDPmk8fz3cyolO9OkdvTsVWmGJjg0DdMIIAiqCfVJ4zC
	djmD9hb3ddJrrp2WCwJj9ixHno40s9K5JFpOV+QCpejfthlAO6viIzEfzf1esTQDRI3mZ1EtBzQ
	+A6rEpaCmB9HurSGiFvMMfJOEsDilKqxo2naD1kdCZhVVvLY4lk1le2Su7zXJJreKmNWhQisROT
	lXKd6ayjW1/jeAGBAnwZe9dZ+NCydL/r+6eWiaWlmJQP+QirvhIwVvxUYNlHvkVNSevyG4sIZ2S
	92qcSalOrbikWCUpSMak+Og2U4Nn9Pn6/hWkap+rN3Bk4++uedP3
X-Google-Smtp-Source: AGHT+IG5SjwBNYpgtsZ2GrAPYTJ3w1Wwt/wPQJnP1CIFTpzXnOVWiVVkg3kGL9lQcuyRxx5C/zHEOg==
X-Received: by 2002:a17:906:1446:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-ae3500e3d11mr1083912566b.37.1751293982547;
        Mon, 30 Jun 2025 07:33:02 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35aad8275sm651946666b.23.2025.06.30.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:33:02 -0700 (PDT)
Date: Mon, 30 Jun 2025 07:32:59 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <aGKgG+uE+UXEIIbf@gmail.com>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
 <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
 <686002d028f_a131d29458@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686002d028f_a131d29458@willemb.c.googlers.com.notmuch>

Hello Willem,

On Sat, Jun 28, 2025 at 10:57:20AM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > +NETCONSOLE_CONFIGFS_PATH: str = "/sys/kernel/config/netconsole"
> > +NETCONS_REMOTE_PORT: int = 6666
> > +NETCONS_LOCAL_PORT: int = 1514
> > +# Max number of netcons messages to send. Each iteration will setup
> > +# netconsole and send 10 messages
> > +ITERATIONS: int = 20
> > +# MAPS contains the information coming from bpftrace
> > +# it will have only one key: @hits, which tells the number of times
> > +# netpoll_poll_dev() was called
> 
> nit: no longer has ampersand prefix

Good catch. I will update.

> > +def ethtool_read_rx_tx_queue(interface_name: str) -> tuple[int, int]:
> > +    """
> > +    Read the number of RX and TX queues using ethtool. This will be used
> > +    to restore it after the test
> > +    """
> > +    rx_queue = 0
> > +    tx_queue = 0
> > +
> > +    try:
> > +        ethtool_result = ethtool(f"-g {interface_name}").stdout
> > +        for line in ethtool_result.splitlines():
> > +            if line.startswith("RX:"):
> > +                rx_queue = int(line.split()[1])
> > +            if line.startswith("TX:"):
> > +                tx_queue = int(line.split()[1])
> 
> Does this work on devices that use combined?

Not sure. This is suppossed to work mostly on netdevsim (for now).

Since I am not familiar with combined TX/RX, I've looked at ethtool
code, and it seems RX and TX wil always be printed?

This is what I found when `-g` is passed to ethtool.

	static int dump_ring(const struct ethtool_ringparam *ering)
	{
		fprintf(stdout,
			"Pre-set maximums:\n"
			"RX:            %u\n"
			"RX Mini:       %u\n"
			"RX Jumbo:      %u\n"
			"TX:            %u\n",
			ering->rx_max_pending,
			ering->rx_mini_max_pending,
			ering->rx_jumbo_max_pending,
			ering->tx_max_pending);

		fprintf(stdout,
			"Current hardware settings:\n"
			"RX:            %u\n"
			"RX Mini:       %u\n"
			"RX Jumbo:      %u\n"
			"TX:            %u\n",
			ering->rx_pending,
			ering->rx_mini_pending,
			ering->rx_jumbo_pending,
			ering->tx_pending);

		fprintf(stdout, "\n");
		return 0;
	}


Thanks for the review,
--breno

