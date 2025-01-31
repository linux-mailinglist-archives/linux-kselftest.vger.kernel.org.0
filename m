Return-Path: <linux-kselftest+bounces-25487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C1A23E26
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 14:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CEB188A15B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A51C3C0F;
	Fri, 31 Jan 2025 13:12:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926A1B87D0;
	Fri, 31 Jan 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329121; cv=none; b=IKkEoT05UWYkfSKoAjuvuwinkQYuVwAS5AqSnNvlkSV2zTiOsz/25ac8or2Vpz6EOEJuIBlEcafqySr5ym/wls53uCJqj2/4cpmq+huKN1eBR/RSErFNz4zqF+bymxLp/9FaywnRSOtJc3jtin7S7f9qL4ISvhuTncoUe23Bw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329121; c=relaxed/simple;
	bh=xgo8PliiTUsBZHIM+9deV9cbjLW5yzO0IUD4f4VXMZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdeXgWmSQedA2GsS97XedLaJae9UDHBSbyi6SZSoyt1DT0ixN2bJL9WTas18Q9Ym8FEHgwCa971tTRcQhSCWvNIHWvF1fMhqMP76ajUoNaIyXAKZpdWVcPeKrDFAqQetJ4dp4JLlK29Rlq7VmOX673ZnVyLqppmG8pJcaQM54FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab651f1dd36so388801366b.0;
        Fri, 31 Jan 2025 05:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738329118; x=1738933918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a3Lglc6G9+kWxrhuoSHDLCbGQc4HDAJpuK5OBARqFI=;
        b=F3BysSV1e5Y5z7vxUnZuWTlv9m3Z9H0ni/Wn6DXblNFwm2SKJx0kP8IF8W/D2GOjZN
         LgyszgVWDTyFOmRLq0erF89nNRZYmeQ0krRzH0PRKpMgy8A1Ei795R8ZoE5GpAfGjhnX
         G7Rr3+I1DRbSx0IkNIm52OJ5/QYa/UqBXjFsNL5slOa3eruzDjlQSOiuWQy8429Euqkh
         Y23MEJqRWdjJJl8ykJruD38N44ViPf5bA2fEOPx5Y5bUBsTAK0AkzW62kXg/lCQ3g97P
         jpDTRyqNdSklggGzguIFq4S+arCfOJvOZfPiLzyMAuX3CsK+wibPXSzCcDIF8dZPuzGi
         ge/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNWTpEFAQgfqRTjP/PW9jFFijIc/eJfspG90bKKPOJZkh7i9XLRb5Uyep/9ufHzIepUEKtVK1f@vger.kernel.org, AJvYcCUn35YwLAN+373x/cLz5eepWyvKR8RDHUjWzx4X8PlBGfQXTyR3KnH3lgvV2Kjxc7JhMuwmDHZ2+RdsMx5zk4pC@vger.kernel.org, AJvYcCX8zFBlZH/dJ/9y+rv/ZpV9vO9rVVQ8aUD862G44q5VjD9IxMZ4Zwqvy/tod19A8YVjoqXTdNxQCQRDGvQe@vger.kernel.org, AJvYcCXcCa1hSdwkm1u186MAprKPLFm2V0OQGi80iwb1CW2TJHB3323u7TwY15hllhkuD6HyOWKO0dpBef0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOR4EJK2edkfgvPL4iyfoW3FbHqDiIWYqfMurJ0l1yUh+/YUpL
	r3nntCld/Oeen4PsnbLVPwoG7X7uEmaQiFB+xxw2MmVFcTLDu2P+
X-Gm-Gg: ASbGncuVacFttu/Xi9Qc20pGfErBY+3BobN4Ct50GVRcjtgXaNNAQFN14M8pVg9u+L6
	21492Q3EsCkuunRn6tlukQ+4UycpiqOsoZsHn9E/o9t/eyLWtvJkFJ6CJ7/FyfCKTdiFIQZw4sK
	H1ptSaP22ng8hoHUTfL2GUNEQ4DQRAIkQyHvCC+n2n1hOvBmimRI6Xu+xt1K3V2IAriM2D/sLwi
	SWCvWM012KwXtkVvUJ/A0W7zV+y2MZumcxVW79O1CVdOcCvLKk/iNaihPDujv/JYmBLX9DSDZkN
	1+Jeww==
X-Google-Smtp-Source: AGHT+IE7NkGUn2eaFUsNhIHou71Z8vK19KiczHWR1s+D15ErLXPyOdYS+OHPOvcCD1KAV+imm/5xvQ==
X-Received: by 2002:a17:907:7f13:b0:aa6:7c8e:8087 with SMTP id a640c23a62f3a-ab6cfc87b15mr1160656066b.12.1738329118020;
        Fri, 31 Jan 2025 05:11:58 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm2891330a12.45.2025.01.31.05.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:11:56 -0800 (PST)
Date: Fri, 31 Jan 2025 05:11:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Message-ID: <20250131-stalwart-lively-caracal-4e2063@leitao>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-1-12a0d286ba1d@debian.org>
 <20250128161128.GB277827@kernel.org>
 <20250130103544.GE113107@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130103544.GE113107@kernel.org>

Hello Simon,

On Thu, Jan 30, 2025 at 10:35:44AM +0000, Simon Horman wrote:
> On Tue, Jan 28, 2025 at 04:11:28PM +0000, Simon Horman wrote:
> > On Fri, Jan 24, 2025 at 07:16:40AM -0800, Breno Leitao wrote:
> > > Move the static buffers from send_msg_no_fragmentation() and
> > > send_msg_fragmented() into the netconsole_target structure. This
> > > simplifies the code by:
> > > - Eliminating redundant static buffers
> > > - Centralizing buffer management in the target structure
> > > - Reducing memory usage by 1KB (one buffer instead of two)
> > > 
> > > The buffer in netconsole_target is protected by target_list_lock,
> > > maintaining the same synchronization semantics as the original code.
> > > 
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/net/netconsole.c | 29 +++++++++++++++--------------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > > index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..1a78704681184673f5c1ba8ae665e46751384293 100644
> > > --- a/drivers/net/netconsole.c
> > > +++ b/drivers/net/netconsole.c
> > > @@ -137,6 +137,8 @@ struct netconsole_target {
> > >  	bool			extended;
> > >  	bool			release;
> > >  	struct netpoll		np;
> > > +	/* protected by target_list_lock */
> > > +	char			buf[MAX_PRINT_CHUNK];
> > 
> > nit: buf should also be added to the Kernel doc for this structure.
> > 
> > ...
> 
> Hi Breno,
> 
> With that fixed feel free to add:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks again for the review.

I will update according to your suggestion, and send the new version
after the merge window is opened.

--breno

