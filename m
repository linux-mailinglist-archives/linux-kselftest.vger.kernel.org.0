Return-Path: <linux-kselftest+bounces-48522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A0D03934
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 979723018961
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497A50096B;
	Thu,  8 Jan 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXEK5ckV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AF50095B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883673; cv=none; b=i8axC4JIdS+4Tj8HnvDz78jgqOuEY0QuqngoUQ9sJdTz1QJXKegsgCDH6Lal+2DRxX3kwK7XiC6XgXuVlpMIAe6RKImLO4wIzQRmHfl9qcBvmc91vuFQVLHrK9LHZvuNOqYZDZ8LtgrCARsE8Vhv8Yhu8cqeTe+/OCfivt9ZiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883673; c=relaxed/simple;
	bh=czn6i+5JRS41ZvY2QucunbgAj9XQZu9cLO8YLR+TrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRQPX+cv2rKnJZdJ3wJ2yV6jZCtCWbWcT+S0gbhJ/clOZH24FzjEmOwpNVqtfyibwNJOhnDjKandqoHbPKKjdpE7QEIUR6OqOPC1ZpdGM9r/Qa1MXqsbTtTHt+Kv5pPMUprYYmSqPIdy7JM6B2uuLhEqb4p2xWANfNxI9277DYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXEK5ckV; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-450b2715b6cso1961175b6e.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767883671; x=1768488471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6hSm35yZUt3EV6dxEBlPd5kbmwwUA3xW1x0DKsS8Lk=;
        b=cXEK5ckV88Gmtn2fuGYnFHgI4rju9IhBqucCjjNBANC1DImQQwASBzq+fGsjy8jQgY
         OIv4zSryJP9L3UBjJrWkJKkoultuunzWunsmWucZAxLwc+8qMyi6hAEcmiDstMnC+OyP
         ZHRkzfk90B/Rm9Fssyd7hgH+iIe9Zh+6Ov84V7sDpSxNoVZAUTZh+n61OJwS5jhVsyXi
         23s98rHhPcCvTLlMIn/jX190iXeq0OwmDnm1j50oj26Njx00SKGxFF4/xdQuU9pRaDRc
         4pD/wIF3h6V8Lhpuf4hvuDV3NygsrxMoKhVSveYsPYDXv5rJHLZeuIGGzxSnLxaq+s+u
         cYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883671; x=1768488471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6hSm35yZUt3EV6dxEBlPd5kbmwwUA3xW1x0DKsS8Lk=;
        b=MpfBkmlV0zxmii6qQN3i1XEu/FFR5LErq/ok84qyMx6oWEB6K4+7tDIBwT68F16CyW
         PWFbQhGw2MWo8A//mrMhPqY1HsjEh293RP8x9zSLNDHRPPL+jb6mTcqK/yIR7kNeWynJ
         lL+XhhrY63n8g8Ek7IVZHiyxKMmqa7My1BH4z/Pc6vHExA9Fq7pZMUtg8fXdG1ufuASn
         V9JqD9gHUbRFSIEnjoKlra0Fnyuf6XZ0l0RQDIbgEISTvDw+B71zvFkYoIGx5rv4a6va
         VN6ha1QUF5y8zrwQz47a2Ag4l6QV0TkX7g3rpVHJXcAedinj/LRvOIi+3sNon5wwJ4hy
         5Hug==
X-Forwarded-Encrypted: i=1; AJvYcCWMblm0OobE0N4bBffJ3qEbcCkbmE0SF2PYvfMu7sTvymbn1DePPn96VP4iRqBxiEN+SZQQNYGr0gMI48xAAPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3oyOKBLZjrIubZRQyCR420bLKEMN5Lwv2oTSESXqc0jyNjRe
	DKgLI5gegU1WC2yb4kGNNDDRjWv7e4ivH+hPip+UFK1deA5IYy5liPk32AX/JA==
X-Gm-Gg: AY/fxX7TqiSRd1Qkcp02CRVBiD9TgDP44GcBmXVGLAen2U/vRWMJAYeRb7MTQ8ocECv
	IU4+pvXLtWvndYrefuGfsNZ69CrB1jQn1EGRhiY0ELsSdqwmZVtRnjVxchQsUJIwqPVaFHj60km
	T1yc+CDiwpQdWl3Kt+EARDDam/2XKRL9RrZenany+z6DqNouxr27Cyp9f7Om0+iF98TFXMXCaj9
	pdkxpUd6LL4Y7vXTLZ7R0wIquEmzjQM3jmb4PUYkjUwBQGzKcSTFoCad/r1Suw971Q8kk7gUrgh
	1tXHkfrmK2+CztpzlMvT3sYUKpv0UVkfvOCEA6icvtyFW6LOnMCE3xjdv/hiJJoe8y9/dnCjqOT
	QKFpqyphzTXD1efc0qyOhxYqjbLPpd0yfESEBYggdeupYRNyuYy6ydNmPOfm7DwQohVFQk9Y426
	jG8Ee8PQPBS6BNz/e4LZZqQag=
X-Google-Smtp-Source: AGHT+IG+5O2qxyQaHRKvy3VAjXHEnNlXj0xPAB0paZX1ShUHEyvTsyzL0eLPaW2CmcyBGY5q5wG26Q==
X-Received: by 2002:a17:90b:3e83:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-34f68b68daamr6764560a91.16.1767877852585;
        Thu, 08 Jan 2026 05:10:52 -0800 (PST)
Received: from google.com ([2402:7500:577:2fcc:284d:ee3:93c1:605b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7c4118sm7952968a91.7.2026.01.08.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:10:52 -0800 (PST)
Date: Thu, 8 Jan 2026 21:10:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kir Chou <note351@hotmail.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davidgow@google.com" <davidgow@google.com>,
	"brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
	"kirchou@google.com" <kirchou@google.com>
Subject: Re: [PATCH v3] lib/glob: convert selftest to KUnit
Message-ID: <aV-s0jvOILSFkKhs@google.com>
References: <20260107051903.35039-1-note351@hotmail.com>
 <aV9wjyL-q1fxXjxq@google.com>
 <TYZPR06MB691697F84E3DF898044028D3E885A@TYZPR06MB6916.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR06MB691697F84E3DF898044028D3E885A@TYZPR06MB6916.apcprd06.prod.outlook.com>

Hi Kir,

On Thu, Jan 08, 2026 at 12:11:21PM +0000, Kir Chou wrote:
> Thanks Kuan-Wei! I addressed all your feedback in v4.
> 
> https://lore.kernel.org/lkml/20260108120753.27339-1-note351@hotmail.com/T/#u
>

For future reference, please avoid top-posting.
Also, please ensure your emails are plain text only, without html or
base64 encoding.

Regards,
Kuan-Wei


