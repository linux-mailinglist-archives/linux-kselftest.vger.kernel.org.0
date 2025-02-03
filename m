Return-Path: <linux-kselftest+bounces-25574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0426A25FB1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3083AB1AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7020ADF3;
	Mon,  3 Feb 2025 16:17:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010720A5F8;
	Mon,  3 Feb 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599422; cv=none; b=GOaTzcdxGSX+XY8aEgp2EFTrAz7Z1shZTElLaaNCe6peaO8hcQaNuKGV961NpSm+YWJuHjVzbP7BmT61A7k2xzk+3Pa4+Tzw1D1AOO4pkv4j3vSxRb3XDN79YyxL222qmLwGS9WCRqgEeJMEazVZkNt5hsGXh3lX3eg8+GoPIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599422; c=relaxed/simple;
	bh=jxjelwvPjiUA4OYhpwTP0FYhdsgEVNrUK4RPi9l0bVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhzn2hkAQgV2B7sjwogZQ3pflTJirUdJcZ4BI/iF3XtapeJC/DA9BgPE53mq2eQp2vhKSC5uVO93DZf7mCV7qtLikW++XkO/x5lHEV5cTlH4Xshkxmsl/cxZ88Gh8nD3XkMR3WLXmfmJ+jZbMyDqAsA7cI+P8o7aLVWl2ZWvURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436341f575fso54360985e9.1;
        Mon, 03 Feb 2025 08:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599419; x=1739204219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZbGWYzER5oGGDsl6rRvJjIrk8ABgaY5TBdtD/K7ewE=;
        b=ZL69jea5tYY2bMLl5+sgy0DN1I0z+fne7YGMoYk3nDtJs+liGS4JO8aMPZwyF0hVFl
         DVYOO6amexnVPr90McPpIMO4bOMfvHZcS5VreiwHvYOb6a01NZ7vBFNKoANfGxcw4flr
         1aiOUichc4GnFPNhW5QH554O54PzbVu4+MzEn39HNttxQBtF61OhZ84AeO+vgJa5RpHE
         ljk1R3bkQmd0vy4LdyaH02H3YcWNctJQ8JNvhobgs/S7Axl2KEgteWdJaBjVpDnd7H8G
         xHyDKhuk0qd7A558zxUsTh9WHI0x2USHipzUqYbkRtJ3N8AFfjXk1CsqfJawVgxTFZ21
         rh4w==
X-Forwarded-Encrypted: i=1; AJvYcCWODPV6pxtI3bYbU2+gdNXyqUZc23NglacmTonjbz/cbE0etlNb6OspuLoLmAHDcmvE9YbOMsSu@vger.kernel.org, AJvYcCWsGSzgMtXRXmskzka6UmBlfOnGy4PbBw4MNCWJ0h1Q5uUWASO+S2THPjdR7woIEDE9gU8qltVqRlaezhdvikql@vger.kernel.org, AJvYcCWuTwOQAKstOx3qpJpgl22vJJbQ6F7EHRmp7T8blinwiFSI/+XKJPUvBM1ShCsLeuqiB5I82sKrIT5WPVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuVuH8Z8DaHXmnAL8pdpMT7xjjCRgzzZ5OE7AO1b+s6pC4isZ
	G1T8SWxrUgo4Dh/Wr69u+SvhR1mMS1ObeEQCIWdVSPSzyTMyDBWb
X-Gm-Gg: ASbGnctFbwL/77eFOIaHCpnvh0M9VPX/iQZKGXwEiu7f8UdCQe12gOgiDwyAUHqnFRG
	ZsLUnK7Ltu6Ey+Kj+z7S5ExDnUo7hqmRvWv8gYv3++VIL5NA+IUZKXIw6pAyVZaMQgsbtBERnJ5
	qsgI4bELuuFYScNMw6vcKH+Qqvk4bVfn+NBFoEzLIUAuSKG5GPbfmuQM0A69DO6qLvQZ+3WaJyt
	Twi72P5UE+vdWFHpohDY9ETDS/Q5a23selKA5IjU+DJzt6sDwcO38fLV19DosU23AJt/e/+qlqr
	HzkJyg==
X-Google-Smtp-Source: AGHT+IFAvSlU8duVrbgOBKC/uY6hgIs4x44adI8VQAnuG7Ddzmb6JSKAHW1fH8gnSEInrJkniym+wQ==
X-Received: by 2002:a5d:5f56:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38c51e957b9mr21715356f8f.36.1738599418936;
        Mon, 03 Feb 2025 08:16:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f1db3sm777589966b.83.2025.02.03.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:16:58 -0800 (PST)
Date: Mon, 3 Feb 2025 08:16:56 -0800
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
Message-ID: <20250203-rugged-goose-of-leadership-edbbbf@leitao>
References: <20250131-netcons_frag_msgs-v1-1-0de83bf2a7e6@debian.org>
 <20250203104855.GC234677@kernel.org>
 <20250203-subtle-taipan-of-realization-1c3a3f@leitao>
 <20250203142102.GH234677@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250203142102.GH234677@kernel.org>

On Mon, Feb 03, 2025 at 02:21:02PM +0000, Simon Horman wrote:
> On Mon, Feb 03, 2025 at 03:00:37AM -0800, Breno Leitao wrote:
> > Hello Simon,
> >=20
> > On Mon, Feb 03, 2025 at 10:48:55AM +0000, Simon Horman wrote:
> > > On Fri, Jan 31, 2025 at 04:39:38AM -0800, Breno Leitao wrote:
> >=20
> > > > +# Validate the message, which has two messages glued together.
> > > > +# unwrap them to make sure all the characters were transmitted.
> > > > +# File will look like the following:
> > > > +#   13,468,514729715,-,ncfrag=3D0/1135;MSG1=3DMSG2=3DMSG3=3DMSG4=
=3DMSG5=3DMSG6=3DMSG7=3DMSG8=3DMSG9=3DMSG10=3DMSG11=3DMSG12=3DMSG13=3DMSG14=
=3DMSG15=3DMSG16=3DMSG17=3DMSG18=3DMSG19=3DMSG20=3DMSG21=3DMSG22=3DMSG23=3D=
MSG24=3DMSG25=3DMSG26=3DMSG27=3DMSG28=3DMSG29=3DMSG30=3DMSG31=3DMSG32=3DMSG=
33=3DMSG34=3DMSG35=3DMSG36=3DMSG37=3DMSG38=3DMSG39=3DMSG40=3DMSG41=3DMSG42=
=3DMSG43=3DMSG44=3DMSG45=3DMSG46=3DMSG47=3DMSG48=3DMSG49=3DMSG50=3DMSG51=3D=
MSG52=3DMSG53=3DMSG54=3DMSG55=3DMSG56=3DMSG57=3DMSG58=3DMSG59=3DMSG60=3DMSG=
61=3DMSG62=3DMSG63=3DMSG64=3DMSG65=3DMSG66=3DMSG67=3DMSG68=3DMSG69=3DMSG70=
=3DMSG71=3DMSG72=3DMSG73=3DMSG74=3DMSG75=3DMSG76=3DMSG77=3DMSG78=3DMSG79=3D=
MSG80=3DMSG81=3DMSG82=3DMSG83=3DMSG84=3DMSG85=3DMSG86=3DMSG87=3DMSG88=3DMSG=
89=3DMSG90=3DMSG91=3DMSG92=3DMSG93=3DMSG94=3DMSG95=3DMSG96=3DMSG97=3DMSG98=
=3DMSG99=3DMSG100=3DMSG101=3DMSG102=3DMSG103=3DMSG104=3DMSG105=3DMSG106=3DM=
SG107=3DMSG108=3DMSG109=3DMSG110=3DMSG111=3DMSG112=3DMSG113=3DMSG114=3DMSG1=
15=3DMSG116=3DMSG117=3DMSG118=3DMSG119=3DMSG120=3DMSG121=3DMSG122=3DMSG123=
=3DMSG124=3DMSG125=3DMSG126=3DMSG127=3DMSG128=3DMSG129=3DMSG130=3DMSG131=3D=
MSG132=3DMSG133=3DMSG134=3DMSG135=3DMSG136=3DMSG137=3DMSG138=3DMSG139=3DMSG=
140=3DMSG141=3DMSG142=3DMSG143=3DMSG144=3DMSG145=3DMSG146=3DMSG147=3DMSG148=
=3DMSG149=3DMSG150=3D: netcons_nzmJQ
> > > > +#    key=3D1-2-13,468,514729715,-,ncfrag=3D967/1135;3-4-5-6-7-8-9-=
10-11-12-13-14-15-16-17-18-19-20-21-22-23-24-25-26-27-28-29-30-31-32-33-34-=
35-36-37-38-39-40-41-42-43-44-45-46-47-48-49-50-51-52-53-54-55-56-57-58-59-=
60-
> >=20
> > > I appreciate there is a value in providing the literal data.
> > > But as the data is based mostly of arithmetic sequences
> > > perhaps it would be nicer to express this in a more succinct way.
> >=20
> > First of all, thanks for the review.
> >=20
> > Do you mean I should simplify this comment above, to avoid the literal
> > data, right?
>=20
> Thanks Breno,
>=20
> Yes, that is what I meant.

Thanks. I will update it, then.

--breno

