Return-Path: <linux-kselftest+bounces-4240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8A84CCF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307711C21F39
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB37E76A;
	Wed,  7 Feb 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuDIIfcZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07F7E587
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316565; cv=none; b=kMSpa6USE1nXwPEf6I/kZXlP/yrQrdmDmOH9SoEx/J+BM0qePYEqoOvcLSOalMJ9s0064taDJf5HOFexSuQuKSRU3gbhy6ldckFOflPSMkdF6YZEVRO57N2dd4H7+BiVthBLpKL0rnBRTPpF5lpB1ClKG/2+yJOaX3FyedFcecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316565; c=relaxed/simple;
	bh=YWgt1QDSKBj/H36nJgibQK6gcwRgAlnS/cBZWGVGIfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEUlMYb3VYKkg47xP7hgjqXU0p833Bho+1D5LmhLYkDWiWqwFet0sO1ZGHvmKXxdaSpbwjp+x2N5juA1fgNxZLCqY1ME1pnCmsVRaozZEqmupz0seZD0OT7vBNNcHWBJ4NO/mgjd3dknBMG+ebZKEPqn7J9CHAuPEYwO95HvMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuDIIfcZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707316562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MjPCctJJqXLBO9JeqaiHAXf2n9f9VVRk/qSjOUbLxmQ=;
	b=UuDIIfcZiOWJB4lzRpKpXVNU7mmaBBOBR/qTbTzn84xConlL55rvFTUVllHMPH2CJNfYgY
	Nx7wMxNkJvYDJruw9A7IeqpXQNAfO8xJ250YJb3wwLzAU6KqxdG6r+6uWeFyRMDF4YOh1J
	PFl/HwSNuhcLlbYZWkbO6JZaVCmvbC8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-yHmxQ7e5PUaSC6Og8_Aueg-1; Wed, 07 Feb 2024 09:36:01 -0500
X-MC-Unique: yHmxQ7e5PUaSC6Og8_Aueg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b1795bea4so119862f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 06:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316560; x=1707921360;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjPCctJJqXLBO9JeqaiHAXf2n9f9VVRk/qSjOUbLxmQ=;
        b=qRUvEceSQCZRWsEjbVujExRbZ22SZZca0oSufq+7jH1W4XhsvdATmsPpfFXHQRvssK
         vjZtYa3+hKkqglgQKt5O2Nwhv3Xw1IyabEIgvT6QoRsPipXIOaYYtD+TyvqYLFewK3b7
         Dfv0h30cNStuhqjRIuL+KiJ7vhTlk08I276iAkTCAD6StH45z5VytbS3Sn/wirGk4ayZ
         nYSw5cje8tJ0Z/e34a1UAtqd7W0aJ+c6p8OaWf8ZqgSwcaGo2sDIWsnj/F1a3ktUO8H9
         hv/PSLM+9s40MTlv8VFsSazlqxU/Q9PtEJ0bl3t/wGyIQc1pQTqHd1ZlRvbaV/eX+L4l
         V0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXq+hGPLp40AIV0ck7+LTPSDM9Dcq0B0dh7qHPyOt3KH4MiEV10j4vxsNwyW/+4VNZeLPl3SSmiFHCt3cdr1ym4yVa9XgR/BLBnWgddhHZu
X-Gm-Message-State: AOJu0Yx2VsJ0Va61ycJlT76z/IqJW7G6nxENKAZ1Ajfj1b4MRVlQV0YU
	e7VoI1pHd4FOqAe+xdfV6W1xm5TWPDgg6MJnGxb5eAYtOgarK6M4uFt8f0XFhVeE1lNcmwnaqab
	8/FyAefsTiSCxTvIHG8do5+APXvzJWkOTNPwY7ZMfaJ2tLrSBqLPuCN9hjnXNhRKDiA==
X-Received: by 2002:a05:6000:12c3:b0:337:c50c:27df with SMTP id l3-20020a05600012c300b00337c50c27dfmr4055087wrx.4.1707316559809;
        Wed, 07 Feb 2024 06:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFLQDhvPw9hBSZLwZyKgOLgQdsO3Gwefv8ulGi7agSYJIcwrRXzgkxT1nilQl0hn2sCNPIow==
X-Received: by 2002:a05:6000:12c3:b0:337:c50c:27df with SMTP id l3-20020a05600012c300b00337c50c27dfmr4055063wrx.4.1707316559372;
        Wed, 07 Feb 2024 06:35:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJEYHNB3JBlrwu2XoroX8IMg4uG3QIpRMrZ+msyq/XkPf7IKDQGkp5QGQoPlFgY9LhKIB65QLDDTwLitsreJs8TyGQtvD9zJFcKEAR8j4FIUlX6Jpo6iqWa9qA69v2nc3qqeR3FoerZlrZxzMxpXoxqLP/+W9hB19J41j9sgECnJKmKpUhTm3JD4Dcxz3biWIG+Q0lOU34cLDEjPGUBXuxFxUD9IuT/nxga13h8kkarysYgIoQ941l8Wgr5A6lyW8c6lqUBRj2uic=
Received: from gerbillo.redhat.com (146-241-106-180.dyn.eolo.it. [146.241.106.180])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1649565wrw.38.2024.02.07.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:35:58 -0800 (PST)
Message-ID: <794b684b8d7b0cecb59c403bd14877426facc5f4.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: cope with slow env in gro.sh test
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Coco Li
 <lixiaoyan@google.com>,  linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Date: Wed, 07 Feb 2024 15:35:57 +0100
In-Reply-To: <be5e4878-18a7-4de9-b03e-55298a84ab0f@kernel.org>
References: 
	<117a20b1b09addb804b27167fafe1a47bfb2b18e.1707233152.git.pabeni@redhat.com>
	 <be5e4878-18a7-4de9-b03e-55298a84ab0f@kernel.org>
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

On Wed, 2024-02-07 at 12:16 +0100, Matthieu Baerts wrote:
> Hi Paolo,
>=20
> On 06/02/2024 16:27, Paolo Abeni wrote:
> > The gro self-tests sends the packets to be aggregated with
> > multiple write operations.
> >=20
> > When running is slow environment, it's hard to guarantee that
> > the GRO engine will wait for the last packet in an intended
> > train.
> >=20
> > The above causes almost deterministic failures in our CI for
> > the 'large' test-case.
> >=20
> > Address the issue explicitly ignoring failures for such case
> > in slow environments (KSFT_MACHINE_SLOW=3D=3Dtrue).
>=20
> To what value is KSFT_MACHINE_SLOW set in the CI?

AFAIK, the CI initialize KSFT_MACHINE_SLOW (to true) only on slow env.

> Is it set to a different value if the machine is not slow? e.g.
>=20
>   KSFT_MACHINE_SLOW =3D=3D false
>=20
> (please see below)
>=20
> > Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note that the fixes tag is there mainly to justify targeting the net
> > tree, and this is aiming at net to hopefully make the test more stable
> > ASAP for both trees.
> >=20
> > I experimented with a largish refactory replacing the multiple writes
> > with a single GSO packet, but exhausted by time budget before reaching
> > any good result.
> > ---
> >  tools/testing/selftests/net/gro.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftes=
ts/net/gro.sh
> > index 19352f106c1d..114b5281a3f5 100755
> > --- a/tools/testing/selftests/net/gro.sh
> > +++ b/tools/testing/selftests/net/gro.sh
> > @@ -31,6 +31,10 @@ run_test() {
> >        1>>log.txt
> >      wait "${server_pid}"
> >      exit_code=3D$?
> > +    if [ ${test} =3D=3D "large" -a -n "${KSFT_MACHINE_SLOW}" ]; then
>=20
> Maybe best to avoid using:
>=20
>   -n "${KSFT_MACHINE_SLOW}"
>=20
> Otherwise, we have the same behaviour if KSFT_MACHINE_SLOW is set to
> 1/yes/true or 0/no/false.

For consistency, I followed the logic already in place in commit
c41dfb0dfbec ("selftests/net: ignore timing errors in so_txtime if
KSFT_MACHINE_SLOW").

> But maybe it is fine like that, and what is just missing is adding
> somewhere how KSFT_MACHINE_SLOW is supposed to be set/used? :)
>=20
>=20
> Not linked to that, but a small detail about the new line, just in case
> you need to send a v2: it looks like it is better to avoid using '-a':
>=20
>   https://www.shellcheck.net/wiki/SC2166

Thank for the pointer, I was not aware of that.=20

I guess a v2 dropping '-a' would be better.

Thanks,

Paolo


