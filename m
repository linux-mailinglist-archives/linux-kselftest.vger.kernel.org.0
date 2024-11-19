Return-Path: <linux-kselftest+bounces-22237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45CC9D20FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 08:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E90BB20D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D415382E;
	Tue, 19 Nov 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzjTV4Y3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE536E2BE;
	Tue, 19 Nov 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002749; cv=none; b=Hc3PAtEUhcOSrL9ZSD6xqrzdw/jeB4rCZbgQWiFr0KWqkkyQd+C2X7TlR62DGTvMhAifv/c+Sxz4WCSSs7CA1OMsvHqZ/bgTBhM0OsGLvVhEtA84rBFlpXyxUrnODR+cJtThUppm5a9DSDOr5LQj1MwnrbH/C9UqDyRYBhl8IF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002749; c=relaxed/simple;
	bh=hwptYTgMG5tDU6V2fCbCJgkQNyFXiQC9or8bsMFqUy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzrN8qhu/b3HbB1POZ52gqUto4zzPMxHWCUsJOuvRE031rBLmmrOxXX2oilGIu2gLMG0P0lS1iaW98U57ubaCe8bFVdJF3YTB5knjdY9oQbQU1KruM8floqGcsNBDT0eFeKy6cf5fqvLcdP+c77n+T0SxEueFVPdDdFwXIkVSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzjTV4Y3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so2407592a12.2;
        Mon, 18 Nov 2024 23:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732002747; x=1732607547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd86GZ2fveLPPd4ttRXZWtCr+q7J30ecHFoCwfm8jf4=;
        b=kzjTV4Y3AqWQU7RpXdoEaCEpbJEpRtQGHqb8H6Tjgy2vtdsPDBGr1T5KtepOaxwJKm
         6BFJnemtBMUvrmbRTYE3AFhudsOwiOYTjmQL208mQA218Gz+LIeLNTX/SAlUll8VLzDU
         kkPIVR28p6Tlc/hLDHpk/n9FNR4Ehm4yB4Faj6LKvvUwpQs/duf2IEyFmyNrlyQiwnzz
         Mnz04S79GYivbt0Pp3AD/S7BzopnVWqqdUU9HisztjETJGVZqCwbLZKTNCv2xsE8D1qz
         rgH9QQ7dEC7UrqPPTbO4SVveewlx2IDIEYJl7BYKUdG/zkcfwII5+vXDbfWHCYgFUcxq
         FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732002747; x=1732607547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd86GZ2fveLPPd4ttRXZWtCr+q7J30ecHFoCwfm8jf4=;
        b=qON9CnYxwJ92C69EhdsscKPjoZZaH+oAbsUb1ny7yRB2e9a9FfFpeniRsRH2V1o2+V
         eBff+l2PU9uIqp/+HhnXYZBsFV7KPJvZ9auKEB6pyerzUGY8V7tB7zOnK0/BEDS8b5OW
         SsbfN/7gfoEEsy8Mmgi8EwjmiIx5T8YlB5Wy8s70M60YQcd0b36fPkOuA1y+J0NKL1AN
         blJ1MoWnZP6TngA8/QMTS5JeAe3iCSbOFzFtUrszTX9YSV5D1maG3d4sQG9dfp4JuX01
         naQNBMALuo1YEoZ5L3DKwjfkCrmIsz907NNpMduQ02Yiu1mtjqNnPdQMVfVuKf8wnf99
         1spQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwV8z4gFxSW/biAQ9Pqyvw4/VJjfhRHZDNo9UAAEp93/QEMCZf2d4x8j0WNY6POzO+iXFVCcUsIZZzYAE=@vger.kernel.org, AJvYcCW1ppCDYBVwAA8qx2TfFT4BtRjbDIRyeXwSOIeOz+DyKKKcKmyOWR2YfXkFHuYZqdKie1K+2H3IqFMAvzTWF17g@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLSk5e6vTK8nImLOmwTOLvcWPXXQyuqNcr8a5EFSebBgZSfVW
	AGm2RSJzy6hYPOcI6FA4Q3/lbuEby5lkj4t+7AQyVjc9M3gWqvD4
X-Google-Smtp-Source: AGHT+IH/92I34HVVWcJoFVa8wx5+bGWSWpKh4TOw9GTftkgqSBbM0PX9wFOTVsChM1vJ/y7EfKoSCQ==
X-Received: by 2002:a05:6a21:6d9f:b0:1dc:78f1:af37 with SMTP id adf61e73a8af0-1dc90b4829emr21850291637.21.1732002746986;
        Mon, 18 Nov 2024 23:52:26 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247712086asm7467466b3a.46.2024.11.18.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:52:26 -0800 (PST)
Date: Tue, 19 Nov 2024 07:52:18 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Xiao Ma <xiaom@google.com>, Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH net 1/2] net/ipv6: delete temporary address if mngtmpaddr
 is removed or un-mngtmpaddr
Message-ID: <ZzxDsps3EhGcMamy@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-2-liuhangbin@gmail.com>
 <CAH5Ym4jjVFofG5J7QW=EsD00siDXtNWKt4ZDNbbUmP+Y4Jb-DQ@mail.gmail.com>
 <ZzWo5fJcraaDDLm_@fedora>
 <CAH5Ym4hcguhXvJvVuANns7Q9VTOWR-SxHSdD55rR5BWhWeg2Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4hcguhXvJvVuANns7Q9VTOWR-SxHSdD55rR5BWhWeg2Ow@mail.gmail.com>

On Fri, Nov 15, 2024 at 12:46:27PM -0800, Sam Edwards wrote:
> Hi Hangbin,
> 
> It took me a while to grasp but the problem seems to be a confusion
> about what it means to set a temporary's lifetimes to 0/0:
> 1) "The mngtmpaddrs has gone away; this temporary is slated for
> deletion by addrconf_verify_rtnl()"
> 2) "This temporary address itself shall no longer be used, regenerate
> it immediately."
> 
> The existing behavior makes sense for the #2 case, but not for the #1
> case. It seems sensible to me to keep the #2 behavior as-is, because
> userspace might be setting a 0/0 lifetime to forcibly rotate the
> temporary.
> 
> So it sounds like (at least) one of three fixes is in order:
> a) Make ipv6_create_tempaddr() verify that the `ifp` is (still)
> alive+mngtmpaddrs, returning with an error code if not.
> b) Look at the 3 callsites for ipv6_create_tempaddr() and add the
> above verifications before calling.
> c) Add a function that calls ipv6_del_addr(temp) for every temporary
> with a specified ifpub, and use it instead of manage_tempaddrs(..., 0,
> 0, false, ...) when deleting/unflagging a mngtmpaddrs.
> 
> Personally I like option C the best. What are your thoughts?

Hi Sam,

Thanks for the comments. I have no preference. Let me try option C
and update the test case first.

Hangbin

