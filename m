Return-Path: <linux-kselftest+bounces-27371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5172A42A63
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 18:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F62B166C67
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D67264A89;
	Mon, 24 Feb 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRxdA9Qm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36F263F4C;
	Mon, 24 Feb 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419659; cv=none; b=GYDiw8SP3uC98TM38DwyhSB/L+86lRCTajp79CZFVLDu/kW0dqYnsQ0x33QJg/BpElp5ure3h6I0sMDt5fzUuP0W4Tfam/bgQSXZj3l+rNHeRcIzIHh7yDR8K1CxOrn+JBWdyu4dnR49XTivj2Yb6fsPz4I5+2N81cb8BlqznPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419659; c=relaxed/simple;
	bh=XnnclfgnjJGNnAA52fTfntiaxNx9k5+h16ZPEYb+gJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnkrsjpBMJuMMw1b0ObZ5gaqXG8e8QOHI7QjkpRB5J0QlwgIc2Y5+jHFKeO2IYQyspbK/BFo0vNbzhLa1hQjyswKRjzDxNGkx044bIZLAMdmk/0Al9GCSqCaUYyQ8S7T91cXtIgkhkJz2CV5LFk8mMdqeIcu4OQqImo+EyZbBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRxdA9Qm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ca204d04so76249705ad.0;
        Mon, 24 Feb 2025 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419657; x=1741024457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49hFWAS6BPi17cq0UX9zIx62B0WnB3kN7+csrm3gvss=;
        b=QRxdA9QmLXriQ978u1EiPntVJye3dlz3vsW1rUeVem0xCR66nt0R7Tn2VCl8PukbyC
         l1fcTf/IHJfUVHW45cOoiI166SSIcBFnMwDuaBHuaJsbrvrchjSgWZj4n9aInLUqGIY4
         TgavKTO2j938hLTSTEzupqWMHoE2YWVm4h8SNcZUWCfwim+3x33NSX2QGTSuTevIVifq
         /RTXOPhYottEemC3sc4IbMW9aEswHo+kla1Dij/6ZsUk6kJ7gKYskEDZEvBHd6nTaEXq
         wc7/AwbZS5NOv8uAZCfsdgxXFXESmErX+HPrB/5WU7njZ+4MNgTlXs5jCmf4KJB3p3B6
         rPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419657; x=1741024457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49hFWAS6BPi17cq0UX9zIx62B0WnB3kN7+csrm3gvss=;
        b=CcppDVcrK7DKLR8CfPwxTVDdrxhv8wZDiXWwWntxDdo99sOH8bwaad9YuOxqpkmCDW
         dMvictKtoHi0OlIaYs3Xk58T+aCl9sX5ORor+jhgU9cteeUt4Mu3HU1519Ih3YHMLmc5
         OgroHrJ3sdgnlyNFHlQEto9I1v862N32xb+nZvNArnWRe7STdcTB1Rh+n+a9L5tQ0a0h
         8CUD3bFXAYNwGtcm4s6tYSYVowLm+JPb8EHp18ax68G3kspMlv470DH78m3c4auwDn3j
         K8T/RvoFQ4azG9ghV/L6EYFLnV5YOt3KMFvOCQ4Cx7kTWia6+zlLYYTh9dUOqKqsqp3e
         Qprg==
X-Forwarded-Encrypted: i=1; AJvYcCUC2hyB2FQCprkTEMqETGLZjia6Q9AcMivneFWo26T7C4HIQdXBQ1jfO7cIsxAj13Iiu02Koonu3faW4eCz@vger.kernel.org, AJvYcCWj38ePJkVc+U7JOWIgRJUNbr7FhJ2lvu0cX1Y6pnQcIojwGEd1YZ+/TivKX724c/Qycaz6g5A46CnMX1K0GD1i@vger.kernel.org, AJvYcCWsmCU4+RO/PUddcFlejuePQnVBLoEghA4jbSEW1vNWihydLbv2tbjs5H0t4cH8y49XHXvYHCUIgA2I@vger.kernel.org, AJvYcCXDaoR6un+a6kIVh36rRnaQBbBxMURQmPdNNojuuS1WTTrgPRB2wePi3ltYPhqoiLIs7d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5NTJK8sJF5kvTYLoAs0tdqxFAdXSQGp0uDRliNl1TB5owNfi
	d65PRcBGMAMl7BPl3yVlEFOmhchkxHD+5kt+nuVys3r8bCGORvmqrstyb4s=
X-Gm-Gg: ASbGnctq/CuqI+xhHZrzGFb6g2koIGEVCf98EckgyHEUmssLIXRB5btwzHXXGYmXfhP
	hjkYUo2fTYI54snGvQExfiBDbUOYOGwC7wZG8dScTuS0tqvNif8y1ocE1SbZJnvrSymAV0HmwyH
	HQMQV6TEJj1N7Ej2vpfCvd5uceNf42wVfy5czHm7mN5lOchahtCOFvhE7ToD5OeZpr6iPMkTrHe
	3J/nFTGkrlbTL5D09fFH/KFjqebSo7vNRTRcd1zQD3KQV82/Okyxg0r3gPhydCyWIdSih6ac4cF
	U00nO7qqQCbOH2PLRuxgnB1wJQ==
X-Google-Smtp-Source: AGHT+IEo+qn0GrfRoEoT6iMqO7/d+JhNhLZkzb0haVeC/Qk31b9/5jQycW3R+yfCTVCSg4EuX/UngA==
X-Received: by 2002:a17:903:2343:b0:220:fb23:48df with SMTP id d9443c01a7336-2219ffa759bmr230045575ad.36.1740419656914;
        Mon, 24 Feb 2025 09:54:16 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732581df0bbsm18607889b3a.156.2025.02.24.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:54:16 -0800 (PST)
Date: Mon, 24 Feb 2025 09:54:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7yyR9oRhHXv9a9z@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-10-almasrymina@google.com>
 <Z7ypMjORvm99q6L0@mini-arch>
 <CAHS8izM9xMqWnJB5Cm=DMMBV1BuUemFjKSv9So8V_xQ8ToTRqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM9xMqWnJB5Cm=DMMBV1BuUemFjKSv9So8V_xQ8ToTRqA@mail.gmail.com>

On 02/24, Mina Almasry wrote:
> On Mon, Feb 24, 2025 at 9:15 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/22, Mina Almasry wrote:
> > > Add support for devmem TX in ncdevmem.
> > >
> > > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > > which included the TX path, and work by Stan to include the netlink API
> > > and refactored on top of his generic memory_provider support.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > We need exit_wait=True for check_rx as well, but I'll send this change
> > separately.
> 
> Yes, I discovered the same thing, and I have that change locally along
> with some other fix ups I'm readying up for review in a separate
> series.

Perfect, then I'll wait for you to address it separately!

