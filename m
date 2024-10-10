Return-Path: <linux-kselftest+bounces-19474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2D99923E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF6EB26720
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF11CEADB;
	Thu, 10 Oct 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXYRDCBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8A19ABA3;
	Thu, 10 Oct 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587514; cv=none; b=FhhMiRY+5M1c/86yc2ZmgcUEaI0ExhfWUXj8HWoFY6u50mBbHV1nins5DgBWNF9C2FsUQJfJ6G2WUzwlJ8bXp5gYKJf6aTnTQDTTPb2W2lJkMIHLJF5Bs0m8LK1ZhFg/v1qzOOEfNoCmEKlrwCkBussqTXcFMu02YpJc+RfDc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587514; c=relaxed/simple;
	bh=mavLUvPe/Z33R+r7s6f0yQ/Y1XkbhHeqDb+k+2j+8Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtqAt0SYtK07kKtT3Wg7zMIU8cf8lnCFdju2LKnn6DZjd3WP4sYWOGtFTqj9mwfxc1+gcGHH+LZFLu/otEoR9DFiAfmJLqmaHHXmW8hbR63zVu/+65AUqhR9uQ9Dti9JnNX5DPdoEd3CgmkXyYCrxb99RCtpHau4qwgsovp+QPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXYRDCBC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb2f4b282cso2034371fa.2;
        Thu, 10 Oct 2024 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728587511; x=1729192311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dV4Y8wvjEvYr9420WvUI+5b6+iJt6Y/8cuJ/hdjAW7A=;
        b=NXYRDCBCFVNvH9SGiRDWscuNIGuN55vGXbNQJshIdwXt4kp/frb+9zrcLO0SmKX3//
         8iy9eTQldmZlXmOBVITPscI0e39RqwaIU1sIKElyLU8TSo8OC4sWq/AcQ2AdVsFINWzG
         fsv3wq4pzPBeNEUjuCwgsIuwm4sLF4H+T/IuryCL/C1+bnx19vNrV7Fey39LRuyvcEaN
         jppGWaIRqA/TnYkr4pjc9erdFFE03594iceVjnRUJrAtqv3yN4DnXdNYDeBrw7jEneuF
         RezfeF5oAjc1jhqs23M8QQX0LT5wFAmaFDmk/VjM0rJmS0yNUylgRBfLu5iKdtwhxbNM
         88KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587511; x=1729192311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV4Y8wvjEvYr9420WvUI+5b6+iJt6Y/8cuJ/hdjAW7A=;
        b=ejmTffBtxHSzRCCJHeTNEINassP3UV/k/oqz/Xo+wo7SA6rmTH71jhHScHXqpKykn8
         cN2JlYWN9OZM7xakLG1tj+xO9WN8gceLXuxUpRQtSnLyvplyJGV0w2z86kgsvrWkKHf+
         pUhJOVZtu9XTUziAqHauvKLHBoIL6DNH+DjHn62G4SaQBjp9+9amUDf1E8I7rrO8EEer
         SgTdMqI8nAYabw4S5Is+0gMC8kcNCyRBKImc8quchnLASALnlbpK5JGYXDFIrmf5X3Te
         Kx9gPMc7EkTx2lfQ02yueuxCaGr4b4S88c5Xgtbuawt2e8W4XQdKoCCDMm/hT9FAKicI
         e43Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1hYf5cTzBJfsYNPT2c6A8L3Iox8O1f3GD+jPrALCVOxD1MCP4IWDbDh+WfKCEmOiaXZpT+dJBg0E4ZQ==@vger.kernel.org, AJvYcCWBjw2cAPNqldK9P/HL+GfY9GdIhAaeCTZNXKreoC+UY/8uagTrnSvDkJVXl3OyOBmO30+qVZFeGDF8THreuruX@vger.kernel.org, AJvYcCWknM1lJTSuY87lubECfkWK9RDW6YgylCLEzEwQmR12QujM8fOeNxCZxjBI4P8TQkWHPOY/7N0D@vger.kernel.org, AJvYcCXvhHgC+AHEJFT3AkMHMUK60qRYXqI0OzbnsitDHQq4hTaXV1j3v7u8RXUJRStEyPCib3qtMLXMVXBMiT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMujcfjfddXQi4aPMZzSaFbpsK0ejXX2pHOFg4NHcUwtu4/ca
	jBybSZnv3kjy8G7CoVO3usIT/xVlSd+5OfvLPC22T7k0JPR1+GSZ
X-Google-Smtp-Source: AGHT+IEuKfVs3iRf0Hz2+U1nsMKSApblmz+h7J4ac6CBD50ItYNEHj2D6C3yPD9lZXHenfR0Ve6hZQ==
X-Received: by 2002:a05:6512:2342:b0:539:8d46:4746 with SMTP id 2adb3069b0e04-539c4980d63mr4709005e87.60.1728587510361;
        Thu, 10 Oct 2024 12:11:50 -0700 (PDT)
Received: from localhost (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ede92bsm127899866b.28.2024.10.10.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:11:49 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:11:48 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Subject: Re: [PATCH] selftests: net: rds: fix module not found
Message-ID: <wldy6xafdjem7nni2bnaq7gvozkwqpdtsmed5aopdcedsegmzd@faw3xb76qqgd>
References: <20241008082259.243476-1-alessandro.zanni87@gmail.com>
 <20241009194031.269a1251@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009194031.269a1251@kernel.org>

On 24/10/09 07:40, Jakub Kicinski wrote:
> On Tue,  8 Oct 2024 10:22:53 +0200 Alessandro Zanni wrote:
> > This fix solves this error, when calling kselftest with targets "net/rds":
> > 
> > selftests: net/rds: test.py
> > Traceback (most recent call last):
> >   File "tools/testing/selftests/net/rds/./test.py", line 17, in <module>
> >     from lib.py import ip
> > ModuleNotFoundError: No module named 'lib'
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/net/rds/test.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
> > index e6bb109bcead..112a8059c030 100755
> > --- a/tools/testing/selftests/net/rds/test.py
> > +++ b/tools/testing/selftests/net/rds/test.py
> > @@ -14,8 +14,9 @@ import sys
> >  import atexit
> >  from pwd import getpwuid
> >  from os import stat
> > -from lib.py import ip
> >  
> > +sys.path.append("..")
> > +from lib.py.utils import ip
> >  
> >  libc = ctypes.cdll.LoadLibrary('libc.so.6')
> >  setns = libc.setns
> 
> Does this work regardless of where we try to run the script from?
> In other cross-imports we try to build the path based on __file__,
> see: tools/testing/selftests/drivers/net/lib/py/__init__.py

Yes, it works regardeless where we run the script from but I agree
with you to keep the same style used in other files.
Thanks for pointing out.

> Would be good to keep consistency.

Definitely. I'm sending a v2 patch with this in mind.

> -- 
> pw-bot: cr

