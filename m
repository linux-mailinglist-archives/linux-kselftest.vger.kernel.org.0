Return-Path: <linux-kselftest+bounces-19464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67000998E16
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B21283738
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41719C559;
	Thu, 10 Oct 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbnRhmje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE738F9C;
	Thu, 10 Oct 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580278; cv=none; b=b9QBuQL7woTDh36eJN2tklLtz9cj+H58Z6tquLGv4eEj66+jNDTLS31Bbn7w1H7Piw89NxYyPe1pJoi7fHvsJ3juWeETJGOwAep+h3N3wJfLIn7T50KKkaxdVJIGZGWJJsyH3NfGhgh7c7s0TqPntsU9pNVfRbWbocQLMRThGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580278; c=relaxed/simple;
	bh=8fEtXadOHBRvHkdpXei7gLNnPqq0rK0haWuSXFsWkAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwzUdwuj/V987xTMZr4MTAbo+2LebHgPGmxAEFnnMo/YxVx+YW43TgzmUD30gM2D45dRqVUWR73iAUEVmrZMy8Ys4mkE0Ncq9JKQweTyPzfOoVb8vOiVI15Csyqithd3X3cbGC76FTzAeqAa/w7M7qOPXkEiAnWMEjkNMEyo76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbnRhmje; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so1588084a12.1;
        Thu, 10 Oct 2024 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728580275; x=1729185075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTBObgng5fDja2DGdr7TNcsQ0xUC1/ypeIDleBZZD/8=;
        b=HbnRhmje3DN2fgG3FgFwetO639szILwXk4kTvklePscu+5NIwKIGXSTAnJ/vWED/Ig
         9YigVMl5GUvCVAUp9rZvQwTUlEOVMU4zlZsajfmeZnj13a4khtuztXcYiWGXf00orquW
         SwilQRRMKfQzbY3WD0dCRtkMsy0XtEQuEoqnW+IAk81hff0c2kPMpTJwO3o3Pt6VtPEl
         PjXH0sFgN6QVtSrgrpsJRTuFcSaWaTg46OWxNijgwEYDEiklr03hPBHJwOZyi5Dwg1lZ
         alcI8FvvCkXaB/SCBujwWmVMAmNMljMbmaVdH6Y41hIYOVWfxizm5n7SoTcHU3zMHlr9
         Ck4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580275; x=1729185075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTBObgng5fDja2DGdr7TNcsQ0xUC1/ypeIDleBZZD/8=;
        b=iJO20ky/4h4z36PYR44FXd14KXAXXTgmobgI2k94x7YnDzNbQyhijdYm3PrhW6Oqxj
         9H+FBNgeJBelYdeVHVLN4KgLmhDvlpmZl1TPrPzGBblmS92sJWaduc6lctwMUrrOWZHz
         6s86k1++J8tAkdVI5woDRT+p6MkpkYFXHs2m2W6qJu6YVMZVdRujvnGvxFDUzAvOX3ci
         wATtUs+YM+LZSr2EQo9ZKlHC/oUx52Zi/vhWo0Fajy0P6CWzrMx8OtM37BJ3soZWfGhc
         bd9LcUDC0KwjuXi+ZLw2pSP8333t78dKGnNXzyk6UJ2emyxGXhGFf3KeqnIgw+DI54L+
         Er9g==
X-Forwarded-Encrypted: i=1; AJvYcCUhs2uL66I3zem6Tb3Gra3j61i8rXmAdRoTqsgLEeFS58XfltV2p9Nu7kS8/NzgTGHfkxBNJ9L+@vger.kernel.org, AJvYcCVQykzYRwmHoTAYWKo9T0v6g4l2RGUjpeZgfVQtlNtkhYQP5MH9PE9l3vRx8EkJ6Vgw5BUEFZZ3N1Knzo9W/07a@vger.kernel.org, AJvYcCVx8kWv7alOADbw8zNR+uFkBRKtfHMdMZNe6P/QamSOpVIM99izzv+cy/3uvPl96KByYky0hWrF6xEkG2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWLvTkvhGTfYOzJm4u+w8Bvjy2KZHd9CNb/ZjgxirYWtsCrRd
	ghyS1hS6Hit00jFm6CnsF6cwaCV27dG3z6LummzX5Y4d4/8vZRf6
X-Google-Smtp-Source: AGHT+IHeA8Mkgr2bkktWiIZzys5lXcpPMy714NYIlzPycTzg8/XHBh8KDPfUc7rrUr4BrzWoe3en/w==
X-Received: by 2002:a17:907:728f:b0:a99:5f65:fd9a with SMTP id a640c23a62f3a-a99a13b0aefmr310447566b.21.1728580274725;
        Thu, 10 Oct 2024 10:11:14 -0700 (PDT)
Received: from localhost (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2593sm112731666b.215.2024.10.10.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:11:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 19:11:12 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	shuah@kernel.org, petrm@nvidia.com, dw@davidwei.uk, martin.lau@kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] selftests: drivers: net: fix name not defined
Message-ID: <u7j2kzlhhf4yvluijqckc57xey6ymglrszte66t6bmacce73gh@cmojzmkphrdi>
References: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
 <20241009193256.2dd476c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009193256.2dd476c5@kernel.org>

On 24/10/09 07:32, Jakub Kicinski wrote:
> On Wed,  9 Oct 2024 00:01:33 +0200 Alessandro Zanni wrote:
> > This fix solves this error, when calling kselftest with targets "drivers/net":
> > 
> > File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
> >   if e.errno == errno.ENOSPC:
> > NameError: name 'errno' is not defined
> > 
> > The module errno makes available standard error system symbols.
> 
> Can you say more about how you hit this error?
> 
> If it's just based on static analysis please mention that in the commit
> message, and also mention that the problem doesn't happen in practice.
> This will avoid the patch being backported unnecessarily.

I didn't use static analysis tool. I've run the test manually.
I got the error from executing:
make --silent kselftest TARGETS="drivers/net"

Thanks for pointing out, I'll prepare a v2 patch with the command used.

> We run all the tests in our CI, and the problem is not hit. But I agree
> with you that the import is theoretically missing.

When I ran the test, the function ctrl_write() raised an OSError. So, 
in my case, it was also a practical error.

> -- 
> pw-bot: cr

