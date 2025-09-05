Return-Path: <linux-kselftest+bounces-40864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA10B464AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 22:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC871BC6F5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3BF2C21D1;
	Fri,  5 Sep 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej+tH2z6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD73315D4B;
	Fri,  5 Sep 2025 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104852; cv=none; b=dG2Ya3Q5scV5bXlR4jeOg/0AeogwEMXo1Ci4riu4rzEoFbPbKuDo8ezXLAw/Th3BP5QBrSaruHWRSbgiy70wz8gIxLjEW12eFeW1r/kR4ac8FDLGsC8bMDs3lRq6OJ21TT651v1M8W2fz1Ue9lFzgoPkHIne8cWU85+orjHUgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104852; c=relaxed/simple;
	bh=46aE4qvoQE6Z83yCczsg5spy2hxcpmHlH+TxjWmU6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fok80BVfh0MOI03zMdZFRvg4dztdksF5+ZokzmX25Nxsz6mS1Dy49vl3XsbtIC8UywwuIHRsaQOiSQ/JrrHlWPz3ylBgLNCePaafstJ1hF8ZRdJEgN+hKaFvp4Upi8bAaP/7M+cRCNviXqRiedipt/4JdrrpkypzAze4ANz4LYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej+tH2z6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2201744b3a.1;
        Fri, 05 Sep 2025 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757104850; x=1757709650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4dybhAB94uVGLT+SK77ZVWfrTZeC5D8+KSMK6uK5O8=;
        b=ej+tH2z64004Ewa5j2RTs9gk9z+G3PTg7LtK3jy+4T0XP32oiPYDIdo2KK24kc1jJF
         zT7Gxaw7QfAGLQOFebAyivkiyQv2FTABSu2KxZp+ldquZCf2MmlmKOybdyueo00zyJpk
         yevdgyay2uPT08Iv5ma4bHdVPqaJJbrK4fKW/v0CvbvitHGCEn1OuKcivTSvs1KO/eru
         5e/8LLFdftsyS7vro2mLIzOHTdy2Ed2tb8h3RHfZ1O4ePwBK7rwwrwtAG8NkINfeHnWG
         EnIVPDhC/1jwiMPnAsDjmTxmo0sArGMW4nGhs3lsCR1kiysxYj6tEWCiEMdRDX4SReG7
         Y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104850; x=1757709650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4dybhAB94uVGLT+SK77ZVWfrTZeC5D8+KSMK6uK5O8=;
        b=VHIWjhC9/ZqSiABc2isQdHDaPCQdwuVfZu+rKp/1vdGOEUgY/w8I/mXwkJMsrwxRar
         Sdj3x4R94lr3xDTYqf0CKKyjJvGls0IxycR9ug8bvtiF7Yh15N4X4SAmC5JU7dVKDSaM
         z/u0rA2T3nQpL3iPl9ydbB1+Na0w0IIfk36OOEBrzswO2ZzQgFmNT7jNnbaHZ2qGYNSu
         6AuD62bw5ZJXYuop3SAoLQATlQmK3Cwpm7SSYJPAPpNbwEUU+msZIUasDkq8VbjEC/BL
         j6GXIl9RTeNseIfldxewCrzDDs5+N8OTfN1c4BB1vC6OZ8YOXGxyWlHDjJO1Hihbffja
         WBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6FacKR4unS2sdmVJwbR+CA9RJKDkLADNXYFOd6hzdxS59C+8NP9WaohLeA6yDJA/FfNFnrHAtPRmPLXo=@vger.kernel.org, AJvYcCUeUBpK9ZAkjmapo08X/mASjc88ISyfmt3JWinjYal1v2cGByv0W+dx9ZqR6TJxlioH1ljJSKgS@vger.kernel.org, AJvYcCX6qRgd5B0V6FmR0nHKD2b5q7WFb8B2wVnVFv0xTdhVyqQmF4wJj26Lg9TTaWCGXLY5aHBP2rZpeuO9Ljl1iAfq@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXivTsSKh9oN1erJGhsYetsasq3D9GFh7WujVu6kd/n3GmW4Q
	BWjBqqO4pMR+iGAuKpbOcPd2UQOjw5KzGD0bFyZgxW/2TuW7q/v5sEc=
X-Gm-Gg: ASbGncud50q6p50iP/4mZ/zqMSkUERuHkR+WjucPfKrbL47eno6mrNKbGM/LUHdOzji
	IlUEPJoUw4SKl46wOZR632vr0lRG5j729ON0Z6uPBgSbm5ec5TMeJQozW37RzksfntcpOI2LFPV
	30vyczY5wBzEL3mCnE10n8LqOblDguuLKIj4XnFtV/yCIMKrb/Jngqt2c8s+xcN+0jvx/rcXvmF
	MMM3goEDyie+JZaVFAZp/morl3F2EHoAlRQ5h0WLlb3xI5ur+vyzfyOd1Ns/FafZ+xeMhaq89i2
	ubGEQHGTUOA5S++Cad4TiliNllbND8VJJ+H60j89tU2mp7ZoYSiNiTzC9wM8+CLZ3HCB//nUdYi
	RBk3jrWMT9LtOJqacAwftXc2IUOMY2X2IEMq+Jdxo0XMCPrFQfW8Il/rJv8ZF3vuM8Ai6XcfnVq
	yD59FPrukRSlHufFtTcpSld3Vxto5IPrm4DVPt2PGABeblanbR5QA7n5/riTO1pnLJO9/LuBbo3
	DJ8
X-Google-Smtp-Source: AGHT+IFRzv+4ydZZnncslvEzyICnYZSVO3rE8cmuGQNHsCiD54O2JKAH/2OE1yB2dZPYoTn+HlSzNQ==
X-Received: by 2002:a17:902:e843:b0:24b:1692:e0bf with SMTP id d9443c01a7336-25173118d74mr175525ad.31.1757104849696;
        Fri, 05 Sep 2025 13:40:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c92eb0898sm76934695ad.77.2025.09.05.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:40:49 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:40:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	joe@dama.to, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: ncdevmem: don't retry EFAULT
Message-ID: <aLtK0OIocbEIsNhI@mini-arch>
References: <20250904182710.1586473-1-sdf@fomichev.me>
 <CAHS8izOSq+mYmP58eNqC5WFTvXxh+s8gRSrTv6YQdq6jn41pMw@mail.gmail.com>
 <aLsAP-UgtINNwIMJ@mini-arch>
 <CAHS8izNR8OSZA-F8d9s4GeRSJsnJKwW1nVc+wv01h8yo=V=6fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNR8OSZA-F8d9s4GeRSJsnJKwW1nVc+wv01h8yo=V=6fQ@mail.gmail.com>

On 09/05, Mina Almasry wrote:
> On Fri, Sep 5, 2025 at 8:22 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 09/04, Mina Almasry wrote:
> > > On Thu, Sep 4, 2025 at 11:27 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > devmem test fails on NIPA. Most likely we get skb(s) with readable
> > > > frags (why?)
> > >
> > > I would expect if we get readable frags that the frags land in the
> > > host buffer we provide ncdevmem and we actually hit this error:
> > >
> > > ```
> > >   1                 if (!is_devmem) {
> > >   0                         pr_err("flow steering error");
> > >   1                         goto err_close_client;
> > >   2                 }
> > > ```
> > >
> > > which as it says, should be root caused in a flow steering error. I
> > > don't know what would cause an EFAULT off the top of my head.
> >
> > Yea, I don't understand what happens :-( I'm thinking of doing the
> > following as well:
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 40b774b4f587..0c18a8c7965f 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2820,7 +2820,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
> >                                                          used);
> >                                 if (err <= 0) {
> >                                         if (!copied)
> > -                                               copied = -EFAULT;
> > +                                               copied = err;
> >
> >                                         break;
> >                                 }
> >
> > Should give us more info for the devmem case... LMK if you don't like
> > it. If I don't hear from you in a couple of days, I'll send it out..
> 
> Hmm, the other code paths overwrite the error to EFAULT; I don't know
> if that's significant in some way. But seems fine to me, I don't see
> why not do this, other than maybe potentional confusion with recvmsg
> returning an error not documented here:
> 
> https://linux.die.net/man/2/recvmsg
> 
> But that seems a minor point.

SG! Exporting new errnos seems to be ok because we are dealing with a
new devmem mode? I think the bug we have on the fbnic is that we don't
properly set skb->unreadable, so it's completely unrelated to this,
but still feels like it might help with future debugging..

