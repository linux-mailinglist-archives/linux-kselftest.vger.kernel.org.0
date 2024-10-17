Return-Path: <linux-kselftest+bounces-20038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC89A2D89
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C185B2197D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976321D167;
	Thu, 17 Oct 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2U0/woA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792A21BB06;
	Thu, 17 Oct 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192457; cv=none; b=fJlS2F8CxMLEpxoscbgqrjhXMFS2Gn81A5zvZhdFijQ4cStSf0dKwO01uKTRqGPeaymaYdDlJ2MxE4gb0dhDZ2wv7Ash+APOcSMb1VMjG4AGVfcVfm9WBDXriSB1RyEwkNF4zixOzKiejBIRn6Gjlu6HbGS2lVvtNGj1vVMRwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192457; c=relaxed/simple;
	bh=Koq6Qpu1UBXdJvH7+fvWs0ioA8ye9tyyCNjDy7B3Ah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZM0ctbPVpA6feZiBvhTAR06byDd6TyCTGHEVAYytCn9eJ0BNGk0hz0jmHw78ZqJY4jkNvxQHZCaSwyUtHx+/vFfrMdpg4IdrU+/zhaQL2L4+6yzbIOldotN+0tRmF/0gFOo1u1/44W7qGeqUeSwVejVzg3FQxgoWTSfmDMhKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2U0/woA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4305413aec9so13845545e9.2;
        Thu, 17 Oct 2024 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729192454; x=1729797254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRchpYD2y5fPxBSlIYESO5pAsIBC81GMZW6SoYg2m2w=;
        b=L2U0/woAAP4/au72QpWIXzmw4R3ofUp3GO3Z63YkxSQBgAkUxWf6ePnS8HcUWDwWEu
         vfoGrEVcwBDEujRU8473Zs+H89dXUD0VtPvZRpFnXKDvcTLZQg81j4d/PcSZWyk4qnPf
         9Xd5I7kZbINm/dcuTeZlG82eIlFCGzgqfdCMP+MqsTJQ+yu7u+fFjGaqn7WM8n0r8sKQ
         vhl7MnTzcWzGzlXmfjFxi3T7PdB36p6OK+Kat0f+TXGzxGWe4oMjrW6ldrFGQd3CAvYw
         CI5pbIdG57IJiQTz2udVo961G60e/IdjeOH4bTin+JwI6w/SXAtbVsB4j1dMzah6y9n1
         X7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192454; x=1729797254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRchpYD2y5fPxBSlIYESO5pAsIBC81GMZW6SoYg2m2w=;
        b=HGN2ZfDonVYnhKQYr59Pn68lQM8yc3yASXUbcLaNZofKVg0wvMNpb/EdueLyWDbonI
         MjItNocTMHYQecTU81i59iGPwA0MGN227mDDqsCys3sE4h+b3GFkFEssVcQapa2192yM
         8wuriWWvNqlKZFQYg1Pf21qgzztsE9yHaZRQv6qr5wx80hP6yIDcrcWJw7jEr4/5m4lc
         GwHv7bBsH7X+aQfngZ/KWQlRO1IToMsWyRmGLCTBEh1TTTsHqbBW75o+oISoSq5CQ3PZ
         lUzl6FeI4hNoSrE4nZRgoo7FYLESaSgsyKRYI0rzKDJMEIUSywDjSrU7dI/0s90GJ9Ll
         33hA==
X-Forwarded-Encrypted: i=1; AJvYcCVhQZ6zAUGrQ2hbFRht+vtxluWo7kNfRwAbkAUVs3FHsljsezzqgZoYS+FHD51mE6S50CJvWRzGRICZCK5a@vger.kernel.org, AJvYcCX91QQtSLPj1h7sBSWCY4YnFmrRxtGZ7pusmhm/o1hE9dhwVq4k9cjOlYL8TNY2WMWtQT7Y4O2XysY4/gZQ0k8=@vger.kernel.org, AJvYcCXTIp0FacZe3vGSawlhcvt4bXvWOqkgfg4cX3lQjBXOPBJVsmFj2h+aFjPxg4u+Vr5pRAgF8qaHeDFAavcn5jYw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Q+zwxhorEJWwydmeNaXpr13tWrIQzPmRdtNoQ4mtUJy/hyc3
	gbHpcNqa9i2csykgy3s6dIDEw7Fr5WH+IbGCK0ivBsVja5/53NgH
X-Google-Smtp-Source: AGHT+IELI/vhZ++02PVwYoLIIBS5XpsZPQhiAGp5oouGXvEhqky8ICI624eJZTe0MWdlvdoKMFWK0A==
X-Received: by 2002:a05:600c:5110:b0:431:59ab:15cf with SMTP id 5b1f17b1804b1-43159ab1711mr25678705e9.19.1729192454113;
        Thu, 17 Oct 2024 12:14:14 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:a118:25f3:b27f:9f34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160d3f3acsm1670155e9.0.2024.10.17.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:14:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:14:11 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, keescook@chromium.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, corbet@lwn.net, Liam.Howlett@oracle.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, sroettger@google.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, gregkh@linuxfoundation.org, 
	deraadt@openbsd.org, surenb@google.com, merimus@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] munmap sealed memory cause memory to split (bug)
Message-ID: <zcizwa4wasrq5si6nsjvougg2lt2dklaujpshdmghwg7oejhlj@zxzqhyff4vba>
References: <20241017022627.3112811-1-jeffxu@chromium.org>
 <3a1bbbdf-1281-4f44-857d-58cba583e3da@lucifer.local>
 <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkU2yX_Pbr6=6uEiQnro88O5Mhq3NLwOsy=A=Qa5xeC6Yw@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:20:20AM -0700, Jeff Xu wrote:
> On Thu, Oct 17, 2024 at 1:18 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > NACK. Greg's bot got to it but...
> >
> > As per Greg's bot, no signed-off-by line.
> >
> Sorry for confusion, I wasn't meant to send this as a PATCH, but
> reporting the issue.
> The diff was just sent as reference to repro the bug, and I forgot to
> remove PATCH from the title. I apologize for the confusion.
> 

Can you explain what the issue is? I don't get it.

-- 
Pedro

