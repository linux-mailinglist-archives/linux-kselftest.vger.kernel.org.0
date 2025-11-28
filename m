Return-Path: <linux-kselftest+bounces-46679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F87C906C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 896D84E05F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAF1FBEA8;
	Fri, 28 Nov 2025 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdrjLKo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB41E9919
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289586; cv=none; b=ez0KUn52BgdFj5zPFz850cFYnM9BTsBkhGCG1mXyvxBLOcDxvyXOM6eHKIs9ZcBg1WN5nfLTsNNwun7apO7RScbGwhWYAcu2gIo7NA8oD7A/NvDzwRqyNxACvkOy0NVr91WjIRUw0+0k2EzySACq7i5eut+jF0q0kYjTd19+0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289586; c=relaxed/simple;
	bh=fnj8ZS4XAR8c6IuvAYy03m9ZxUyL06KUQCeYMBL3bHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4mmHXVCtLaxolXsEVj0sf4QpQCm7uZX2zoGB8S4jGlUHeYYmPo07AehJ4SaUXhxoNuQGoNxE+L5qd+vUK6NXhboGWcCD24Ybj01NBvAv/E8B4Nb68MuukJyH4DyydcyTzehzGUDYMJsC6/QGa74UmabJK3ESk+h4fgmbTT3Ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdrjLKo4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555b384acso15293665ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 16:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764289584; x=1764894384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzjAS/DAbgVRPhP5YZ+gkb8gp8TYm3Y4OihcIvNbSOY=;
        b=HdrjLKo4NIFyb7JvTOJlKDb/GvuYI8yRYcrAQq2k3wmlKZmOcHIT38yb9JaYKWzH5p
         iQgJBZPtfB/rG6d6yp8aO6C7XG2+vHmtDI518r9D3jxW/H+RiIxsCWb7FwH7IPZvtBbO
         /p8psiycjGhaZISnre3eSgxFQ+9fqGWf1N9WoXlzJuTJec4MMrNEpNQzpzFaVajTxk3V
         B3v/yLaqiGQqm2+wIlvj3f4hynVZ+bfNvXUfqJNv2sNm4awNaJauT04hrlfWQc6YCZzx
         mx0Gj5mvyMzosc2FvXd6m48ML3Qzdr1LtKm3Gd1VJRRgkn32bBIeGP6jP6pxMlfYOz7c
         RoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764289584; x=1764894384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzjAS/DAbgVRPhP5YZ+gkb8gp8TYm3Y4OihcIvNbSOY=;
        b=FC36VZuaK+TTDE+W8mrWTWYBcdPmE9G+Yv/YUBe6QB1arRa75Y7oSlKX7uiEJumYoc
         W0gRdjFQWHjK1GA/ED7FVfP4v4wt4yuEaPwdbn8z7/RBKbcfx4S46WOeSzT3w91ADf1a
         KiEfjQTvxVTMs2j+Ty5KSgsi65xTrRXWRovNZdb5hYcErp3JjYmHMda/znQyOq2ulZQD
         /GjFuR+9FAs6JxMIBCPFXwxhs2FVmuJ5FiGAIsfprCQKmOEdUpZ+gPZRq+QUyw+o+2OV
         /OBCjNMMUWppVTbKfqQxX9LUSJmbXIvejetKZ7r/jhr/Lnr767s8zMCmJGPaG1Qe5pww
         6+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV0MoqkaVa4MmvvWfPwMMMCJgxZ8OWl+hAnnj3Afst35CsvkR6q3gSkeCakE4SdF/kv+xN3AkrrDIbdkgDOC1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXsULPpebq0/lnRORTvDwj/NtjBrtwOoPI0RnEUMhkD93R7xi
	PyY6hczshbCD7hr63NLxgjuT3dW26rMDvAOl45UC3XYlH1r3z7ZE2dFu
X-Gm-Gg: ASbGnct44SogF1Pou/qjOBimE7jr54ZC8Wa1IYIM15gQwAV/R2VWy6I/yjc8AiyTYx2
	b1rLgKLHQqMtfuRXx7Ils2sULKB+nHvb+0u6f0uZRC7npz2RQGq04QgZGdDrf7mcak9haisMpAi
	x/MlUiB42UtLVr5wllR+SaBcQeFsadZQ2fyaTbM9K2i9bg4bk8dgG5Ot1SXW9nB5BcLdMZi6hQ5
	bT88jMVGjMEgjisfWOZUvEJBal5C4wNtxVos7lucu0yAWUrR+Lf0OyjnBe2PoP8QQ+gN5zlr8Iq
	QMvvjYW6bqDNyl0d2upATMJF4zy/Pgyf25m7HM70RqDL6Aeu2dZ/YRGDCr4SQiqQtgMtEfc4cLc
	A0jv3iFgEIYRCE4y5OzzCrrDxENqJISO16a+5NHMh1pR4Eo2OcGcQcOnbx7PM1JRk7McBmFJLcl
	2F5l+MP93Vh7wTYzs=
X-Google-Smtp-Source: AGHT+IEahetEHgsrchTrvYUPCtqVOgoruLamh0gS6BfLUQCuek2B1vmE7RW7ZvYDAf5SVfIj66bpcw==
X-Received: by 2002:a17:902:ef08:b0:298:60d5:d272 with SMTP id d9443c01a7336-29b6c3e42c8mr278852045ad.17.1764289584019;
        Thu, 27 Nov 2025 16:26:24 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm27882635ad.97.2025.11.27.16.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:26:23 -0800 (PST)
Date: Fri, 28 Nov 2025 00:26:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net 2/3] bonding: restructure ad_churn_machine
Message-ID: <aSjsJxaB5LmHYM3d@fedora>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
 <20251124043310.34073-3-liuhangbin@gmail.com>
 <75349e9f-3851-48de-9f7e-757f65d67f56@redhat.com>
 <aShbAp7RZo8sfq2C@fedora>
 <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7238d8-bf0d-43f3-8474-7798e8b18090@redhat.com>

On Thu, Nov 27, 2025 at 04:29:47PM +0100, Paolo Abeni wrote:
> >> Please avoid white-space changes only, or if you are going to target
> >> net-next, move them to a pre-req patch.
> > 
> > OK, what's pre-req patch?
> 
> I mean: a separate patch, earlier in the series, to keep cosmetic and
> functional changes separated and more easily reviewable.

Sure

> >>> +		if (actor_synced) {
> >>> +			port->sm_vars &= ~AD_PORT_ACTOR_CHURN;
> >>>  			port->sm_churn_actor_state = AD_NO_CHURN;
> >>> -		} else {
> >>> -			port->churn_actor_count++;
> >>> -			port->sm_churn_actor_state = AD_CHURN;
> >>> +			actor_churned = false;
> >>>  		}
> >>
> >> I think this part is not described by the state diagram above?!?
> > 
> > This part is about path (3), port in monitor or churn, and actor is in sync.
> > Then move to state no_churn.
> > 
> > Do you mean port->sm_vars &= ~AD_PORT_ACTOR_CHURN is not described?
> > Hmm, maybe we don't need this after re-organise.
> 
> I mean the state change in the else part, I can't map them in the state
> machine diagram.

The "else" line is removed

Thanks
Hangbin

