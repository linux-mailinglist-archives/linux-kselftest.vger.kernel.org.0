Return-Path: <linux-kselftest+bounces-42903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B182BC65CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0826034D20B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15B2C028C;
	Wed,  8 Oct 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHHaSAan"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0519755B
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949637; cv=none; b=WwQwk7GcOI/bjE6fBDIawALK5DDG6NICRFe4BZWUKwZDDrr58iQkf9z5j/PEsqhdHMJ2O33lpzpWOp1ZuPsn28Jz4i4DOnqLpXIvYRZxMzuxqnG7FSldFWbc8xtdq0Kl6dMgzE3++OTpAcoP1AxZcEZ0urLa5jWXauXBQ50GFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949637; c=relaxed/simple;
	bh=WxAKfTixsn+BqAVr3MpIjhaqLr3uVQKt3BNwOE4a/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlrOxXlMCC1wwsWfQ7kVjFHz6ja5fwriH2YtJMh1RhEVRRyGcPPkI+QsmEibP61+/84TGlFmBmizH77isE3biP7fxhdeNY79ZlnniSczs72xtWd9tuN17MQSLFBMXA+J23f2tOC/XUa4Om+bKiS08v96QkqiI7Bfz6XDziMNwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHHaSAan; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b554bb615dcso69467a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Oct 2025 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759949635; x=1760554435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=FHHaSAanN7jKymPuhj3A95reTXCxeHFYFoaF+EsVghXBjZS1rbVrtQblmfbFmNujII
         /OT1XRYqBvxZrnG4irp83wVJrB0E5blcOK+YY8y4ZbTENxjiNOS/rZC+Pc6muK5igrnE
         3ovByNQbVexIgJqer9/iNVfPKJpIlbOuCIijRFOjnGkl9/jQ1LbUzSrk1OUDudyYdHHJ
         siAM9Kwd5PAq1+VEsbOfznAGSrnnm8k16jAkoeeeF8QPZmml86zMRnQefUUZ9CWIu70c
         u66XRitQSZ2QtxTIGw9HXSTPytExVS4MXatmDVetUsiv1/WHcA1ST74n+3wy+f+XOozL
         /MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949635; x=1760554435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spsxrT/6ofM3m1hLC9sTXRVhnYqgt2GIu66M9po4jj8=;
        b=U6AOzTggdyyJMMW2aEsz8c/WeLPKPLCWRJYIYIimsl6f1XTCK2udNfBtmBMtKGgFno
         B7KqNI7BQeQ7NHudTw/V3ScDbn5MG7f2tSL+jiTgF8uwYgAsAcM8KeYuoCHqycp+Isjg
         v4dXraY5+d0wb5mSASJfkyteXCaSAfBI45cqSnS4NgQrgQnBgKc9B+d/tk16z4MJBxJJ
         ksTpku4AZt3DUXkNM52UD1WD7WhB89OHXt8WOoFl/r1icKHtoD7k68c4wRbx0JyVZEj+
         32hG3T9S12P6QSZWbJek1kbm0GQ05Cip/zXHIAZt9e0hfXypAgSPomaB78F03rbub1MO
         uERg==
X-Forwarded-Encrypted: i=1; AJvYcCUxMjTbRoMpgx1f936auiA2BGOHeVX3bLOG8JjynvRMP9I3BeebjqGGxZm//DrScdVrBGCNLBf5jIVZ1j2CMlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6f1uT6x4GZ7a7ZMxDX3k1HShL+LFB+bXiDyUM7aYIiIZ8o/f
	+nmh+EcCIxD19xUtRfU8RNFVtr7+bRmV0ASZG4RcXNlPtumRUPAO/0E=
X-Gm-Gg: ASbGnct3uUCg8oSFwcm7SuWw6eXGcjnUXt9itvKGrz4RtloDJOCF3WwxQfWf65SuEXA
	VfKPNrMIOY1J1oLXpjlMlR8WnH4u39Ol6Sh+ntxf7X09CsFtTLDUMDEwug0wYkYhBZ7NGQVpQt3
	NCFrUIUADHUlpMrGi7faVHylawubuEA07TZK6PzdSjZSeauGFh/BR6p+bXaSbr3CSOHayuX2E4l
	KKRGtKpRJRQ1kmUvo6nZmhebPwGaNEsS/F3FnFmZm0MyL7K/0v/t2U/MkhkIZxTc/d+Cy7vvsAt
	51+/YimtBlqdQu3/RJ2yOODtE1FJpkkrFDjPaQb4aDHmoczklRI+GatM47rkHswnqrwy1K7lG9t
	x2Cb5v4LExH+XBoaTehcB6ailD/WVBxfLySm1m0Xzu69d65E4PbpXndu0xcu08fGZrV0AH70sqW
	sjnw1N/hGg8F4ied0fU58hWuTBHa7E04HISG6Ljb5gCQdhmLhYJGFViU2WSc0N5uEuY6YWtDN3q
	zBgOsM1JWhKdm9570o/fNC6MeXpXjFyZ4goJHNH
X-Google-Smtp-Source: AGHT+IFsu3BRMvR5OSTmCabfJ1KT16oy9gz+NE3KsW+Be2SzvD8UD2NK+R2Uskc4xVQWQI8YNuuIvQ==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr58419015ad.57.1759949634609;
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034dea083sm4734965ad.24.2025.10.08.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:53:54 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:53:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	willemb@google.com, daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests: drv-net: update remaining Python init
 files
Message-ID: <aOazQf0BBEJh5O8o@mini-arch>
References: <20251008162503.1403966-1-sdf@fomichev.me>
 <20251008183245.GS3060232@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008183245.GS3060232@horms.kernel.org>

On 10/08, Simon Horman wrote:
> On Wed, Oct 08, 2025 at 09:25:03AM -0700, Stanislav Fomichev wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > Convert remaining __init__ files similar to what we did in
> > commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi Stan,
> 
> Sorry to be the bearer of such news.
> But your SoB line needs to go here as you posted the patch.
> 
> -- 
> pw-bot: changes-requested

Oops :-( No worries, will repost tomorrow!

