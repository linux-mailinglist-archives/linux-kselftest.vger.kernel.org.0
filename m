Return-Path: <linux-kselftest+bounces-42637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60891BAD199
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095AD188E283
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2141EB5E3;
	Tue, 30 Sep 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHUio128"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3681DE8BB
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240054; cv=none; b=ZbsgzDjMVHvJb6tE0h4UCkGtcksu1Nse3p/EvVmzItEz6IajaP/rqMuZupAiIVZS2Ld+Sn5KDjmsVcH+WRGBm2aXtrkIEBAAY0XEemBix/58Afx4bNqswwn7R4/TVLfLOPNWWxC4bLRuOiOYW28F+vBawc7VswjnylVDuBcW+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240054; c=relaxed/simple;
	bh=djWJ3WSoFOE7AAiVgSgO9kaO15CNySawak1vG1iZbXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRhMuKAX1BdXF8LrdBBALppNiHLMcF/7NeVEvwPTqqk+YLrZ6Dc6dlCq7rtO3Khy8T3vtOz3qBP2JRmAdmf6vLCrIhMWWATo9vIjgar4KLKD++WNYwEbPn9QTf2MN0L6k2ECltsLUFbaJv07aaMyeqo1dLyjNTumnsboZ734+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHUio128; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26c209802c0so62831515ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759240053; x=1759844853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jMdofcUVGSrS6vDNWwFHz9+M//WqgG/7b80iTTRoas=;
        b=SHUio128k4MsO7mMYdmR73ahK2lbAeQy2BHje44Q+2yqb1I/TCEh82WJd3R6ZpnSRI
         AO+D+Lc9O6OnedZuLnAyn4+QSHtkDz/8nyJgEGrVN7VLqMM21cVqJGbqDIeYX0No9upA
         XhjIyL7INFwK3qE0sAXP3EfIA0fopYJ1WrXzY6g7NByGb8DI6wVxIxBGpcY+l3bPtG0a
         HAP7aj9XtA1C9X3ThZ/cNWoyhUeSoQiRNEoXAjqpfnyDuacJucsyTSRkyMFurxpcjFub
         OaYjifuHBLI/Fh66m91isRKkp6VSc+XpQexOBRjVMHOe0yFP4TizK2uJXaI/vhd9RA0L
         iPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240053; x=1759844853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jMdofcUVGSrS6vDNWwFHz9+M//WqgG/7b80iTTRoas=;
        b=obZ4gq9fMHwAg7seEkcvM7LmQzUwvIfb1xg58JdimpktdjecBVf7TSqQv38r/OB+yj
         +mqievzFhTrOl32qZ9CtRHM1Fb01c2z4PHqBgDRWZfIh1tunY99n0OXNHL7FevjrhcdP
         YtYJLT9Ip03bJUmyVNeXwdZ/UcQ761SE8GPG3r2raxn5SY7BzxDhwM7RaC1n+5/3VDuS
         8ZSQ3AyfPc4LSwIaOoGUfIafkz9HVCL6UVxhVLwM/iuVdXnfrZNJHXJCKQbSLuHO8Cl5
         XXVGmGNNwU7nYJGTx97/dBHL/txu43srd/cQ+/N2EwUWkXLLyKYbwiwR6OXCRPWL/FUu
         nNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGZ0CxMJygCkuf5Q8Pcaarn6A7YVzq/J+XfXOIz3BksuhKY9klN5RqX1a95bxU+r29v5ixufPtF1s35DiWhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWcAwDd+SWrxan4vvB/yGQCqJonUm/pget0O22NXpWeTHGc/j
	qskei+ZZ+omdn4NuRm8gNrmtMt1caEWaApJtpKfrgvQJRU4wE233VYu/
X-Gm-Gg: ASbGnctlEbPUV5Mv5id3zptf++7Ai+1TSF0ddwqCqb4tBcmV1Fikh9heZXfnOYrmqS8
	J3HlHVaGQnNqsp+qO1rr0zgym0epxf08MLIKXIjuOzDtg5Ql5ryhl+XoT3OyOHlpEXmNxAJftYG
	TxlOyXX8Yl4dnmUcfgY3sGu2sV6nQZgYVuAe/95A4sNwUnLb+rQvfDY+soEPf6vEdwhBvfZ+PbB
	HC+QurIYw1ayWcFrIxE4HMxd9SD4DvmU6D4iUL7Pik8vEVx1TBfofoagBc+pg48k7albZ5tyfxg
	JZgvFUh8DlZLqBPEI1FNCIzy74kw4LgIKW41pXdAgOodeeUXeFU/eZoH0ugOYDw0A++pHrdTEAP
	Ji+uBmW5AbBQCgppZkO7oYmlTzSUadEQNIol1KpuOi0WhbUYKTb16lc0IIJ4q
X-Google-Smtp-Source: AGHT+IESYq35TAQFLeBWF4OxglXdXWfZV95e+sPc0Kl6L4WvW4KjgdJME1j4/hRI2m+l8euIgk7tPg==
X-Received: by 2002:a17:902:f650:b0:24e:81d2:cfda with SMTP id d9443c01a7336-27ed4946b7bmr211097935ad.0.1759240052489;
        Tue, 30 Sep 2025 06:47:32 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-281fd60835bsm99535715ad.19.2025.09.30.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:47:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 19:17:29 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Message-ID: <nebdn6xrcevewtcv6hbumf5tdh4p4patujhdojc7hn2yppwil6@jqbfz7q2ljth>
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
 <aNucABvb0PvBtCxr@horms.kernel.org>
 <aNuci8Y9ZO9pd0Ua@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuci8Y9ZO9pd0Ua@horms.kernel.org>

On Tue, Sep 30, 2025 at 10:02:03AM +0100, Simon Horman wrote:

> On Tue, Sep 30, 2025 at 09:59:44AM +0100, Simon Horman wrote:
> > On Mon, Sep 29, 2025 at 10:01:38PM +0530, Gopi Krishna Menon wrote:
> > > Add the tcp_port_share test binary to .gitignore to avoid
> > > accidentally staging the build artifact.
> > > 
> > > Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
> > > a socket")
> > 
> > I'm not entirely sure this qualifies for a fixes tag.
> > It is user-visible. It's probably annoying.
> > But I'm not sure it's a bug.

Hi Simon, thanks for the review. I also feel that Fixes tag is not
required for this change. I added it based on this earlier
commit(7ae495a537d1):
https://lore.kernel.org/all/20250307031356.368350-1-willemdebruijn.kernel@gmail.com
but other commits similar in nature dont have the fixes tag, therefore I
will remove it in v2. 

> 
> Also, FTR, fixes tag's shouldn't be line wrapped.
> 
> > > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> > > ---
> > >  tools/testing/selftests/net/.gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > I notice that tools/testing/selftests/kexec/test_kexec_jump
> > is in a similar state. Do you plan to send a patch to address
> > that too?
> > 
> > ..

This has been already addressed and will be in 6.18-rc1 I believe:
https://lore.kernel.org/all/faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org/

> 
> Please note that net-next is now closed.
> 
> So if you do respin, please wait for it to re-open once v6.18-rc1 has been
> released. About two weeks from now.
Noted, I will send a v2 for this patch when net-next will be reopened.

