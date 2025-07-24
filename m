Return-Path: <linux-kselftest+bounces-37944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE616B109F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ED41C256BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803CC254844;
	Thu, 24 Jul 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYjMU76V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A58834;
	Thu, 24 Jul 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359345; cv=none; b=qLEvSZ7miENlPxUrZPHtxj04E0qKWrHA9Qo0JW9PmTl864MZ5ZMBfG305iTGoFVLgaq4rSR6sROW9tkUPY8nOpidj2v1QyvqFtDaFzxNnFO4FN7mwP8fZ/pkEZQyw8bXU1aWBIn1voxqeHABK/U25uQfFSn2c7wmhD2UMTwRj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359345; c=relaxed/simple;
	bh=asfmr4rOQnvrw7yzut+6DJuDhK4w1DZ69L0O1PkbDFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0sUxtLyjg3Vy9hAgQ0GdQGI9XAYXV3ukBUYp8NWN0DTJVVcNEEOKzWPMty9I7OFV5CuGAblbEN8flQEOM6/VO5Vw4+P5gyYsoT89L14fybBtp3McUVpQrW3STb5DvrBgjpVPfdzovEgjhkM2cRSSzs+Zk1jq6nLC9DxA2jWgjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYjMU76V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167b30so8095185ad.1;
        Thu, 24 Jul 2025 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753359343; x=1753964143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHZQzmMWAwBPsuS3Psxa4083og+pE96ufIozoaGrWAo=;
        b=dYjMU76VyyPJAwQcIkzH9hrWplRznR+O4VVCfcmNpRDwZ6y/kneuoH9ifvQ7MK2bjY
         DdpJNoVLqW3iOsDPbp3vkZhNfZxM/e95pV9sELNTwMdPhUCq22jxE8hzWfgnwi3t4RMr
         8vH8czrXHhGNMokSstNmL3v+KKr5cCFWEHS9DMj2wkgUGPorpq1jhok6+Z0H9OuA9D6G
         6qrF//fSDcs57MTewU37jElvkXpDI7va93Z0V3L2hsJ7LXfw01jvFTmHQlQDGqhwPCGN
         yeRzN+ueT1ZDrBc15ha4ccNPvlVGIf+zZammRFJANHB9RLYMK0P6VS5AoYdCbzwqOGuV
         cHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359343; x=1753964143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHZQzmMWAwBPsuS3Psxa4083og+pE96ufIozoaGrWAo=;
        b=uYIIYYTNIOvVICfIcDjyH8ty1kp0/FHr+w5+fEi//uK/l6RW4NJ3Qsf+4yqnVk+CLW
         pu8o4LqLuRLb4zNE+sOMYoiLHgj+1eNTEZUW5z9StyjpUcMwgDZZLXGgBrn9zoWEQK3h
         lnG2TAc/30OG21x9Bd/4aVdv7YuD0Y6RtKEbqUNCyS8bH3UdWXHNt7gmdVDKfXDIH1gZ
         M8m2QqD9heIFoCIEZfdcEgDFqPYE4lAwKz8/iyFdMUumA8mCLfuHAj35zr9R24cUMphB
         /IwEb3RRSVhizWT3Mk2Hf/CUEn4OwCyEmxdcR7jpLKTaRBTzYwReZ3Nvn6uqwyALtdrv
         zlYA==
X-Forwarded-Encrypted: i=1; AJvYcCVB/MHALpXUpFeznPvWlDvlt4IRDBZUKIw90k2NR9x0SXLaPmuNwsgPKpgVsyx3aww2yC451gsFTIonJd8wrbUb@vger.kernel.org, AJvYcCWY3Y5pB6+ivtsJnyyOtDM2TdtYsElvCVnFscbOzGJ0P1IAhqg/azSOSgZbfBRGQQGcEOl25yn0PUyXyck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6yfiBOX2tf/TXdFmuMGWgvUbs8X0QwgaqIl5hGDKhaG2IPv0U
	HOGZezh+iQetqblIDxaaE78hdJXEQ+lvt4BkmtdqRPmSMxVNFncqIflc
X-Gm-Gg: ASbGncsH+7mmVy+SJ394HOuQYfHMAlHKEqAq/9vdVK/z3iXq41r7lseN9cLjzjS9QHl
	ytMa95fFLkSuKyccLa+hhhBcLB4uBVG67Se5xoRPk8TRx258TNZnJFSt9bvUFnb44Z7L+9jwz+Y
	qwCRbJrWKSWDP00FvCy+g4DjiOmx+t02aZ0GrKRjP+7yYRSRbUj6xoTrjpPdG989t7L7WDSLEdc
	rp7fCbOPMVg3B+/+7EQzUYKxnRftiWfPy79Xn0oINE+A+u5j7wOoeguVDMb6cpU+94pEvaBRAWV
	nhKy5udC0kEa+pBDkKaoDqS63ocfEfX87yAYwp/bDgW261GGdwsuj6/hV+oCKB78fqrjkGE4wiM
	1t3n5WaFp25UCPtCa27oP5IrQvtk=
X-Google-Smtp-Source: AGHT+IGCxsSCdGJq/UJPi8LRZwhEvL7R1RXDJmYIQXcKfr6IoRgEog1I3IfPKR0J9hC5TTE8Ru7/Wg==
X-Received: by 2002:a17:902:e541:b0:23d:da5b:f819 with SMTP id d9443c01a7336-23f9818c63bmr106981765ad.12.1753359343190;
        Thu, 24 Jul 2025 05:15:43 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f83asm14756085ad.41.2025.07.24.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:15:42 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:15:34 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: update ntt to true in passive mode
Message-ID: <aIIj5v8E_CpQaDVP@fedora>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
 <20250709090344.88242-2-liuhangbin@gmail.com>
 <765825.1752639589@famine>
 <aIC5HrE9js_YtSCB@fedora>
 <309184.1753351073@vermin>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309184.1753351073@vermin>

On Thu, Jul 24, 2025 at 11:57:53AM +0200, Jay Vosburgh wrote:
> 	FWIW, I usually reference the older standards 2008 or 2014, as
> the 2020 edition changes a lot of things and bonding isn't necessarily
> conformant to those changes (e.g., many of the state machines are
> different in large or small ways).  Technically, the bonding
> implementation was written to the pre-802.1AX standard when it was still
> part of 802.3 (hence the name 802.3ad), clause 43.
> 
> 	This particular bit (the EXPIRED state actions) is the same,
> but, for example, the transition test from EXPIRED to DEFAULTED is
> different in the 2014 vs 2020 editions, and we need to be careful not to
> implement the state machines piecemeal from different editions of the
> standard.

Thanks for this info. I will download 2014 version and recheck my
changes.

Cheers
Hangbin

