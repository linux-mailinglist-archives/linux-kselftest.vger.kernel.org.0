Return-Path: <linux-kselftest+bounces-4024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555F8474CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EBEB2B6C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B191487D2;
	Fri,  2 Feb 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBfPYG7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE93148303
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891524; cv=none; b=kCWZaafWc2P/BQmALRZmGc0jDUg+fVnPD1FDULXZWboWsy4PQFrySOyoVumKg/uPl3I8hwxic/fxl56eUSOTdq9YY+Gd0EZMcaz4H9yv9IpxqXA4Xw7bDLakVyYrSTOMzMzaSDbMW8cCoqHLUD+xWJVipII6IC/rmkwNS8ivt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891524; c=relaxed/simple;
	bh=QEHVtBtYsd55R9RuILVvmivUJRNTtFOvk7jH9GLlnOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RVIp73xyLFas0rdtabj9qMygKTtsljm5UOGEEseOd2gcyFC/H83FDO1DA7qacFFPGa8JsuqOiiUzZYukJVbBGo6ykxe4D5IOwkgQeRREB2Dwke/sjVAOV+rO5Gr0K4piiVCR0cj8mfRPf8djrFQF5+ZelubPAJRbFfANL5+fCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBfPYG7t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nOjbiIVu3VXXq2bSm338LV5wOe2/P4URDlY21RU6tZE=;
	b=MBfPYG7t30gNRaPiAlOwtKl6sPzd26vs28obIVwM2pAyfDsSejO1Nyqovpsyk1s+sMv1Tc
	J887yhJtOsaoaSkvv1cVN/A7INl9B3HYZgoLFNs1kOLF3QsCowTHliF/3Y2nfFm/X3/YIP
	qE5OKwHQqbpklaB3peh3h4JTvmEkv9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rIj4wlkJOseX1drlrpvoaw-1; Fri, 02 Feb 2024 11:32:00 -0500
X-MC-Unique: rIj4wlkJOseX1drlrpvoaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40fb45c865dso4411625e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 08:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891519; x=1707496319;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOjbiIVu3VXXq2bSm338LV5wOe2/P4URDlY21RU6tZE=;
        b=dtp+1Ke2Gq1gN1kEeKIM8lsHhCl3edo6NCqNius7tpZXpJL85e8f+ApxmXEDhWwHLs
         dgIGMkLnCOPpJLmtduTYcuLFoiZT3FGRjt9lIvV1TE7W508F1n/0MPBCTWUsGzrf83km
         ujIjDyypIjZK0ZKMl7522kuaDrFXsrEXGufTevdoI9ENGQRj/6Dhclax5FRAHaAkPfyU
         Y6ZML4ElTQ5EVmFkszrHsv9t5mSoScxiAopAZsEnQsHP6iV4nQQNLI2yT7IR1l8xzQ1G
         RgPgAt6tzFCf6J0AmTcdP0u88GNoRKqPjGEHqxpUCRaZCUHhf5PmD6e3E3v/f98vdcmw
         HjZw==
X-Gm-Message-State: AOJu0Ywzzp2hiXEmsijS/lfrcKAfEe5u5BJrei7x1VWX6HlDO/RI2EPT
	L3LY0bZGJKM1cXfNeLyGo+F7K77Tjml0aVySHNzdyEEvOfJhSIzIBZARpDbwwJTpamPabxUgkw7
	hobigcxnCL3shy8rwg2NeD3m4u32PUjVCwHz++FVFFgiu5b2mzZuF0+cEEvDKnm5IQA==
X-Received: by 2002:a05:600c:1d9d:b0:40f:c654:9b51 with SMTP id p29-20020a05600c1d9d00b0040fc6549b51mr1740048wms.2.1706891519359;
        Fri, 02 Feb 2024 08:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7k1FS337ZaparwwQ1bk5/Q3KF2ywmA8DSGn8dM7t24lFjykzDLK59q/5gsXx7zcIln1dMaQ==
X-Received: by 2002:a05:600c:1d9d:b0:40f:c654:9b51 with SMTP id p29-20020a05600c1d9d00b0040fc6549b51mr1740034wms.2.1706891519026;
        Fri, 02 Feb 2024 08:31:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtGLhgkA37Br5RcS+XtH5NGBB4bJE4Jee1mFk+MOzYlsIJ6XNGddDaujti5N8sGby1ckb8dFR6QL0gniVr71uwzJOy35Y0pFwVx7WSNwEFASkuCnt6Wtf63TkqOOgdjDm5/lZ9+fwOzmfgQWVvj2dYSQjrpp85KfORlM1IybCM028FZ4JpkDolk5ex2hKToDLB4/73knZmimsrtzbU
Received: from gerbillo.redhat.com (146-241-97-95.dyn.eolo.it. [146.241.97.95])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b0040fa661ee82sm355993wms.44.2024.02.02.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:31:58 -0800 (PST)
Message-ID: <16a57b383ab1b83b91441a9fc54bdefb8bf72b88.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: let big_tcp test cope with slow env
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Xin Long
 <lucien.xin@gmail.com>,  linux-kselftest@vger.kernel.org
Date: Fri, 02 Feb 2024 17:31:52 +0100
In-Reply-To: <CANn89iJ8b-vXhH0Rc5isVTaxgSQ871mud+ttQnLOLtuCu14UXg@mail.gmail.com>
References: 
	<f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
	 <CANn89iJ8b-vXhH0Rc5isVTaxgSQ871mud+ttQnLOLtuCu14UXg@mail.gmail.com>
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

On Fri, 2024-02-02 at 17:13 +0100, Eric Dumazet wrote:
> On Fri, Feb 2, 2024 at 5:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > In very slow environments, most big TCP cases including
> > segmentation and reassembly of big TCP packets have a good
> > chance to fail: by default the TCP client uses write size
> > well below 64K. If the host is low enough autocorking is
> > unable to build real big TCP packets.
> >=20
> > Address the issue using much larger write operations.
> >=20
> > Note that is hard to observe the issue without an extremely
> > slow and/or overloaded environment; reduce the TCP transfer
> > time to allow for much easier/faster reproducibility.
> >=20
> > Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  tools/testing/selftests/net/big_tcp.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/sel=
ftests/net/big_tcp.sh
> > index cde9a91c4797..2db9d15cd45f 100755
> > --- a/tools/testing/selftests/net/big_tcp.sh
> > +++ b/tools/testing/selftests/net/big_tcp.sh
> > @@ -122,7 +122,9 @@ do_netperf() {
> >         local netns=3D$1
> >=20
> >         [ "$NF" =3D "6" ] && serip=3D$SERVER_IP6
> > -       ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/=
dev/null
> > +
> > +       # use large write to be sure to generate big tcp packets
> > +       ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip --=
 -m 262144 2>&1 >/dev/null
> >  }
>=20
> Interesting.
>=20
> I think we set tcp_wmem[1] to 262144 in our hosts. I think netperf
> default depends on tcp_wmem[1]

I haven't dug into the netperf source, but the above would be
consistent with what I observe: in my VM I see 16Kb writes and
tcp_wmem[1] is 16K.

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

Paolo


