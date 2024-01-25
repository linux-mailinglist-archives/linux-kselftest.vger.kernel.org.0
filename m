Return-Path: <linux-kselftest+bounces-3583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B083C847
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3271F22BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00C6E2D3;
	Thu, 25 Jan 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQh9hhVr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC087CF13
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200851; cv=none; b=H79K5YuQhvppeUBCO5zQ4gx+FHk09lCKbIQN5bZt33qpMe3ykLBBeWZ7FEOVR1Fh8lUnNMmvgOEw4ki3ZcxZLe9ZJbbEvxEuRZY1XlQnf9ElYfUGHDrjsYOgtf/BfpJoP2JBUg/97Y15WPmkxHKA5wtxbkwHuxMda8WJlkXSud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200851; c=relaxed/simple;
	bh=O0W7pO1QHGmvl4eOGKao4AsXE/QJTJavOppMaeBzfoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=do/kfNU1rB3s1CFCsahlv9a+7rC8Oh1u72CWVB1IyygN2G9jjYimjUjhjZG7zdotsCGiZaU7isgHYL2JR/CQni4Dvgo94D04h2R9Dyl6rApYXD/HgN0C6m+Ny/SGU6FRH8bsvpFTJk9iDN9NAXCNZ+SrGuKowu/vTkYuxIxoREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQh9hhVr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706200847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ZJC9fSsX7Z9bz1ya4lAJC0kXlHYdZclBj9kIZ708co=;
	b=RQh9hhVra6KYxhwY0G5K5/2mLvcfKbvieHBhOBwlTFGvkpR3PBh0+vieKHqTAYK2Pixy/Q
	d55wHrfOcPM8DOmNr748KtG3H5f0uD0z4QEQOsjSHwulEoNCTT7l+U1ZEGXbQ7oNrv88ur
	VOOEf7KuxndKBfmi5pRAqdPgF7reOjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-VkH1liFaNayvNLuuhc0ARA-1; Thu, 25 Jan 2024 11:40:45 -0500
X-MC-Unique: VkH1liFaNayvNLuuhc0ARA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e61c89728so18350675e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 08:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200844; x=1706805644;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZJC9fSsX7Z9bz1ya4lAJC0kXlHYdZclBj9kIZ708co=;
        b=F7ErxhrR8QAZBDz2Pa19NDcWD+92SP/CjSawc+3eM7ly//MvRYk+vX1sgYIfqkXlSv
         0pjcq/vDYG7n6SEUP/ZM8CvFK/sS2vw2iRKktNrK3OJpI4REf1Sr+9/+xZbCKDDtkTh7
         F5icdUxcQNeZV1rwgEyIvmdLmFe9lc40ZynhCHboojeiU2qtO7P9fosqfR7lSfWUtIVI
         8O2h6SlXUD+aD7rUHyOXY4CrrjLDnBR405jo3CYJwqPvBMBtPhWbC4Ck9Dr82HuiVdGa
         DvYOZ6z5Qm5obHjlotgQEnuCl/uJfM//dcyLiyvUtyZ1wYzwGy50Rp86nNh3nieGD+3U
         n3hg==
X-Gm-Message-State: AOJu0YzdnjTsF3Bty/OvtCZJY+SWCNcc6DiUXSUpxVFQIi0kz6v49G/P
	LehT2WIiEFUDL6X7YvHCGuUQMoXeaKHhbJKwe/PpTzU0TTqlk1RCKO6AIvG0JORxTdZrJBZhqzv
	SexBMjb4T8lgD6GvbSj7LE8Mc0VeSHPpl5C67ia+wYFPMs0204hoxC6DmkSvbAnkF6Q==
X-Received: by 2002:a05:600c:1ca0:b0:40e:c217:7cb with SMTP id k32-20020a05600c1ca000b0040ec21707cbmr3427wms.4.1706200844515;
        Thu, 25 Jan 2024 08:40:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9tqTmYtVQowX5zZVPD5P/lEFMCgv8Xk4wJwMNPtj+4Zxo7vT8pC9xV/prll1hJiv5GJubaQ==
X-Received: by 2002:a05:600c:1ca0:b0:40e:c217:7cb with SMTP id k32-20020a05600c1ca000b0040ec21707cbmr3398wms.4.1706200844075;
        Thu, 25 Jan 2024 08:40:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id fm25-20020a05600c0c1900b0040e3bdff98asm3218399wmb.23.2024.01.25.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:40:43 -0800 (PST)
Message-ID: <a50e07e46036947c873df09b6a48bc8b74547689.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej
 enczykowski <maze@google.com>,  Lina Wang <lina.wang@mediatek.com>,
 linux-kselftest@vger.kernel.org
Date: Thu, 25 Jan 2024 17:40:42 +0100
In-Reply-To: <CANn89iK_i+7RzgeaGQPUieU3c0ME27QeJU9UH9j-ii2TeBoEAA@mail.gmail.com>
References: 
	<7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
	 <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
	 <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
	 <CANn89iK_i+7RzgeaGQPUieU3c0ME27QeJU9UH9j-ii2TeBoEAA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 15:10 +0100, Eric Dumazet wrote:
> On Thu, Jan 25, 2024 at 12:38=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Thu, 2024-01-25 at 09:48 +0100, Eric Dumazet wrote:
> > > On Thu, Jan 25, 2024 at 9:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >=20
> > > > the udpgro_fraglist self-test uses the BPF classifiers, but the
> > > > current net self-test configuration does not include it, causing
> > > > CI failures:
> > > >=20
> > > >  # selftests: net: udpgro_frglist.sh
> > > >  # ipv6
> > > >  # tcp - over veth touching data
> > > >  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
> > > >  # Error: TC classifier not found.
> > > >  # We have an error talking to the kernel
> > > >  # Error: TC classifier not found.
> > > >  # We have an error talking to the kernel
> > > >=20
> > > > Add the missing knob.
> > > >=20
> > > > Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf sel=
f-tests")
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > >=20
> > > FYI, while looking at the gro test, I found that using strace was
> > > making it failing as well.
> >=20
> > It looks like the gro.sh (large) tests send the to-be-aggregate
> > segments individually and relay on the gro flush timeout being large
> > enough to fit all the relevant write operations. I suspect/hope
> > something alike:
> >=20
> > ---
> > diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/=
selftests/net/setup_veth.sh
> > index a9a1759e035c..1f78a87f6f37 100644
> > --- a/tools/testing/selftests/net/setup_veth.sh
> > +++ b/tools/testing/selftests/net/setup_veth.sh
> > @@ -11,7 +11,7 @@ setup_veth_ns() {
> >         local -r ns_mac=3D"$4"
> >=20
> >         [[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name=
}"
> > -       echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
> > +       echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
> >         ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
> >         ip -netns "${ns_name}" link set dev "${ns_dev}" up
> > ---
> > should solve the sporadic issues.
>=20
> I think you are right.
>=20
> I tried multiple values, and found 600,000 was not enough in some cases.
>=20
> With 1,000,000, I was able to run the test (with the strace overhead)
> 100 times without a single failure.

Thank you for testing!

Do you prefer I'll send the formal patch or do you prefer otherwise?=20

Cheers,

Paolo


