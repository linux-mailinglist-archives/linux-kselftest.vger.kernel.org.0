Return-Path: <linux-kselftest+bounces-25565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FD1A257A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419C8188358C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100C20126B;
	Mon,  3 Feb 2025 11:00:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613402A1CF;
	Mon,  3 Feb 2025 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580448; cv=none; b=u1tpYb94WUr6xLZdIemq3ZKm3ZnHWgKwyKTRq6BSl4B8oesoH5yiG3k9OwdG135V4gL4sBr8b15ZVE9Mwi1c3AOoeqMjPGV2tvjKkISKVHoydPNkZHUWyHQ7K/sp9yh8K3/Qvt1eiXbqgy6idZ4F9fbD2pSNF1jUWGfv/ziPDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580448; c=relaxed/simple;
	bh=RmBgRBXMjX74yrIGL98/IAnnRAeq6fYyIMWIK1KWRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls84VDTn8h0pATX8JwyGSvW5ng9HyAkjS19bth1BeXKXXsJ6yey8qPKgGrKsQP/8rCiHspAYySDXa27xUcT2TTjtx92pQ1tnF8qfFSDXVJLfqbohW8Jee6DVKJ30A507VlsHrrK/4GxuMfIw3pUSzB8qDHHzEXFR2UKVO+2363E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab70043cd05so607560366b.0;
        Mon, 03 Feb 2025 03:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738580444; x=1739185244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdjeNRG0qxmgOEy8hRguLgI2muoVRHpqj6bs+IISjqk=;
        b=E9Ec1SK5sJXlYe+V4UKymeUIM7xFXk/RF9PpypgPMXXAVV/1CI7GQTEirvTzifS7zO
         uzeTOiFYPHY4TXc9eDJTiyPo5vOgPCQukWS5l0dWPxig1xn576hOiYf8vVKUrJ/QtOFy
         POjzXh5qxgKOZ+7/dTqL9FNP3qWTjzFulLd8zOFbpsniENwZLSm46Tj4UghTrohdGHCd
         CnCr90vdUflsyjFwyuY8SpstyYyztkIcTy/dsUuGzEx1Rnvbv76TaY6sIJeS04fhMLFk
         qkDuMGlg7X6lweEbXFnD375HYFhZl+w28602a8xKNH/Nv9fQa1Qit63Tn8HSy88Z9DyA
         7lzw==
X-Forwarded-Encrypted: i=1; AJvYcCWD371lmSqSlATQm5RKKzKsw9jc1HFCipwr526Bwa1KWSgrMTwIDKj8XlrZez/LJjDtRGaxK0NONJ+KCWRpC1be@vger.kernel.org, AJvYcCX5DjJx122efyN3J1oiH134ml5htno9aYCnljHQByrP2MUde7aSG7vklD9ZxnvJyENxj7OuC98p@vger.kernel.org, AJvYcCXzp9Ei3E8HrzRldsvnOef+8LFXVOghhowreI2fX0MfodIY1JaRyTqsd+VkppzQzVSiL4AbGVMZMnXX0fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJN6iP7XKayzMOwr7d1rlam1HnKsb9sAKR6gx8PyYdSCN68L98
	s+4ZouO3OnaIBckoquQS0CfQclaF8EbamwdXJ1sRJZxEUgC1aos4TSo2Jg==
X-Gm-Gg: ASbGncuAEuygTf/IMYTABIB5hTqN4Xedbf7D8Wjo685EipBvq/WeUdpQcBmM0pgew/4
	xCs01yFVCL+yAnTz+OpX9EqhT45doKe+6nujfcp1m/yDiuZ+WHwGn9lWBreCzqoEkUYdh9ANNkn
	N+k1psmb4htGFFnjJKkXC3uoqgCPbJDM8vAOVLwoFOAGpZ3OMQO1M71JLPgQnwBRBPcOGefTT5V
	30zG/ylSkK44pBxzYQULEEJxskIvQXTP9v2E8iq8FXTvqSn2pHAWfYX+4OTowm3p5bSY356cUZB
	TcvqZps=
X-Google-Smtp-Source: AGHT+IH32u0asjJRwd4Z2w5Z3r7JtXTZHW1NsOXgWp/H/IYZ0MXVJW2OR/xMU9wV8Aig9/WDROm4hA==
X-Received: by 2002:a17:907:6d22:b0:aae:8841:2bba with SMTP id a640c23a62f3a-ab6cfceb427mr2299995066b.22.1738580442795;
        Mon, 03 Feb 2025 03:00:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a83e3sm733074766b.29.2025.02.03.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 03:00:42 -0800 (PST)
Date: Mon, 3 Feb 2025 03:00:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	matttbe@kernel.org
Subject: Re: [PATCH RFC net-next] netconsole: selftest: Add test for
 fragmented messages
Message-ID: <20250203-subtle-taipan-of-realization-1c3a3f@leitao>
References: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>
 <20250203104855.GC234677@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250203104855.GC234677@kernel.org>

Hello Simon,

On Mon, Feb 03, 2025 at 10:48:55AM +0000, Simon Horman wrote:
> On Fri, Jan 31, 2025 at 04:39:38AM -0800, Breno Leitao wrote:

> > +# Validate the message, which has two messages glued together.
> > +# unwrap them to make sure all the characters were transmitted.
> > +# File will look like the following:
> > +#   13,468,514729715,-,ncfrag=3D0/1135;MSG1=3DMSG2=3DMSG3=3DMSG4=3DMSG=
5=3DMSG6=3DMSG7=3DMSG8=3DMSG9=3DMSG10=3DMSG11=3DMSG12=3DMSG13=3DMSG14=3DMSG=
15=3DMSG16=3DMSG17=3DMSG18=3DMSG19=3DMSG20=3DMSG21=3DMSG22=3DMSG23=3DMSG24=
=3DMSG25=3DMSG26=3DMSG27=3DMSG28=3DMSG29=3DMSG30=3DMSG31=3DMSG32=3DMSG33=3D=
MSG34=3DMSG35=3DMSG36=3DMSG37=3DMSG38=3DMSG39=3DMSG40=3DMSG41=3DMSG42=3DMSG=
43=3DMSG44=3DMSG45=3DMSG46=3DMSG47=3DMSG48=3DMSG49=3DMSG50=3DMSG51=3DMSG52=
=3DMSG53=3DMSG54=3DMSG55=3DMSG56=3DMSG57=3DMSG58=3DMSG59=3DMSG60=3DMSG61=3D=
MSG62=3DMSG63=3DMSG64=3DMSG65=3DMSG66=3DMSG67=3DMSG68=3DMSG69=3DMSG70=3DMSG=
71=3DMSG72=3DMSG73=3DMSG74=3DMSG75=3DMSG76=3DMSG77=3DMSG78=3DMSG79=3DMSG80=
=3DMSG81=3DMSG82=3DMSG83=3DMSG84=3DMSG85=3DMSG86=3DMSG87=3DMSG88=3DMSG89=3D=
MSG90=3DMSG91=3DMSG92=3DMSG93=3DMSG94=3DMSG95=3DMSG96=3DMSG97=3DMSG98=3DMSG=
99=3DMSG100=3DMSG101=3DMSG102=3DMSG103=3DMSG104=3DMSG105=3DMSG106=3DMSG107=
=3DMSG108=3DMSG109=3DMSG110=3DMSG111=3DMSG112=3DMSG113=3DMSG114=3DMSG115=3D=
MSG116=3DMSG117=3DMSG118=3DMSG119=3DMSG120=3DMSG121=3DMSG122=3DMSG123=3DMSG=
124=3DMSG125=3DMSG126=3DMSG127=3DMSG128=3DMSG129=3DMSG130=3DMSG131=3DMSG132=
=3DMSG133=3DMSG134=3DMSG135=3DMSG136=3DMSG137=3DMSG138=3DMSG139=3DMSG140=3D=
MSG141=3DMSG142=3DMSG143=3DMSG144=3DMSG145=3DMSG146=3DMSG147=3DMSG148=3DMSG=
149=3DMSG150=3D: netcons_nzmJQ
> > +#    key=3D1-2-13,468,514729715,-,ncfrag=3D967/1135;3-4-5-6-7-8-9-10-1=
1-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27-28-29-30-31-32-33-34-35-3=
6-37-38-39-40-41-42-43-44-45-46-47-48-49-50-51-52-53-54-55-56-57-58-59-60-

> I appreciate there is a value in providing the literal data.
> But as the data is based mostly of arithmetic sequences
> perhaps it would be nicer to express this in a more succinct way.

First of all, thanks for the review.

Do you mean I should simplify this comment above, to avoid the literal
data, right?

> Regardless, this patch looks good to me.

Thanks, I was a bit surprised with the tests failing on our CI, but,
after some investigation, it doesn't seem to be caused by this change.

https://patchwork.kernel.org/project/netdevbpf/patch/20250131-netcons_frag_=
msgs-v1-1-0de83bf2a7e6@debian.org/

--breno

