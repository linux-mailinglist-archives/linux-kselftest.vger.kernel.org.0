Return-Path: <linux-kselftest+bounces-42603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E839BAA8B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 21:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7143B45DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2224A076;
	Mon, 29 Sep 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZFi9gtB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA84245014
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175909; cv=none; b=KcbDtgZ3iIIx32wt/pCV/hPh61VfNWGHL5esYeqlcwWCpTflkgtS9+vEsKorzzaQgLL4y5DWlbrRHxOXVkyCgtYbnST3zKF0yQtu+m4cYdwmX8khpv6RwneazLpG0hgmZnolfjR5BvzLHgHYMegmOTxcF5FMjI2I3QFxaetw1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175909; c=relaxed/simple;
	bh=WdicRI0lW+PGtCiPXv9obrCJTn+wZ6NS3dwNm1Ifvr0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kadqrCsa6F+DHwCxuDC5TqSnXZIbjgE57F4zhskRir2efDz6k6N3UUMIRqogw/ZdoJBcpGBs4WMSsqqtuJBsEC3A9sTBRCDW+iGq1La5rEE8bxMj3TqLRaEqjI25rHHvIgTYay8GfpObfnZm6i/4II7OciX0uUjVGlIB3P/+AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZFi9gtB; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-923f46f6c59so1202304241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759175907; x=1759780707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE68KxQv0TltB4c9BEbfsALxojS1THywA4eEOPwE7iA=;
        b=GZFi9gtB8dpw5jsyDAHMEtUUKIJDk+wHqc+9Gv95QL9FzUXVmWtzROjg8/haJ5VSnh
         dXWMKyTmwnqkB1V0kSLG5Ij699fIKraeiGz0JgZn/PrlgMxj40PcXZFZGJp8XjibB0cb
         EC6lc/thsgeihj7yU74eup1ro3b32JqH4wO1NHrhfht4sljxA0r/XiKtukW4VQADkjIx
         ahjAaJW38NLX2ihtfhOi5XyN6vZpa1oj6pw+RX2g9vju9gbnH1S3MJOWQgPtiengl76u
         V+AyvKplQEgBTAZtbzlt333Cb/Nno8GQes3e/kN2Acc2B44jidaBIwXSp7OgeQv7A4GF
         rn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175907; x=1759780707;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nE68KxQv0TltB4c9BEbfsALxojS1THywA4eEOPwE7iA=;
        b=gTUupGCeG49u1eHdZMSM8l0EafsUWqHa1bLW9vB+iUzqao9EYIu7UIl4HCOJaGmuNF
         guWQ7tBSr1Dma1Y9R+yk9jO6SFLqgOKtpPo678r7eKxeiaei9sQiieITqBJCgCDrJsbx
         iFmakXBot/bViXWxzb+YNpDn4e6Hqk/R31T6PzstOcmgyHrfHsMAT6E/g/aa2GxL0fDt
         uQanZtvd8INhjCBwpZbn3fmL2K9HI4WFYTdwgdDrpuwz9p5aZ52H0e3vP8u8pkwTmADO
         Mpiom7CVCUZuDzeRdv1PWjeBFjAxmQ9cm85R0Gxhq9qfgsP8oDSc28Yg8GWTpDUdMPTC
         RNwg==
X-Forwarded-Encrypted: i=1; AJvYcCU7nh4nZlKmzAUliKSHqr460oqYLuVsUWVeuPp+/uRQQdsls5SHjEYsEW0J3c6gZxy7BI8pmtxIRl1/CG0p9OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQQ0qhLimNjRcoZV0c8ToQ2Ia0OwMh6BdvYzRwH4dJgGvgtv0
	fP2sgJFO61AplMaF9JO5trG2MNA9peMs36ddIgzcapIGWhAMZ2b0P3/puerAsQ==
X-Gm-Gg: ASbGncsJxR2x8JyR7ddMyhE9z/wT6f50C8ijuwpgseyof5dahBWnD4GxrRZMqu0gkZB
	qXxzAOgyP6Jtptjc8havq85pUB3Gar+fSab+Z3TUUV1KJW7gzfRtdsWTfU3O62e6jqbdMcpVML4
	vwPLzXbrWKQN5PGv9YTnkMMt4iZvxhkJ+ddORwpiF6tR/+uD5LyJv/IhYZvHv6zS77TZgLyHYiJ
	S69DkZMSXKJIa/hWLi1/wJmVdMjYqOX4jwCHXSu2UFeZNbNlLTX0L7AkmFQUAcorcrNuuBigqep
	flbON0nxKhj5uzUpYLpGevcAIy8/5iuohb5kbm2uf1PWSaCDXTFxJ7RzKU4hXxZoPafdyUHOn/4
	zCpKlouM3HNwROwaJj4cfTZTLxEv9sJo8QP37PN9C8NqgxK/KyL6966QHfmB03VRjiEck/A==
X-Google-Smtp-Source: AGHT+IHhZBo942KumGmltmwbYn1aDAUL688YBYTItkGrRHlDRWctRRm60Zi4UInSzQ+S3HEZ3OJAIQ==
X-Received: by 2002:a05:6102:6212:10b0:59b:f140:ebb2 with SMTP id ada2fe7eead31-5ced07a5fc0mr888040137.7.1759175906974;
        Mon, 29 Sep 2025 12:58:26 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-916d98d73d6sm2580672241.15.2025.09.29.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 12:58:26 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:58:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 shuah@kernel.org, 
 daniel.zahka@gmail.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.211020478b1@gmail.com>
In-Reply-To: <20250929120437.3eb28d75@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
 <willemdebruijn.kernel.2e2661b9a8ae9@gmail.com>
 <20250929120437.3eb28d75@kernel.org>
Subject: Re: [PATCH net-next v3 0/8] psp: add a kselftest suite and netdevsim
 implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 28 Sep 2025 12:00:15 -0400 Willem de Bruijn wrote:
> > I'll leave a few minor comments inline, but nothing that really needs
> > a respin and/or cannot be a minor fixup later.
> 
> I'd obviously prefer to have the tests merged in the same release 
> as the code.

Agreed. My intent was to convey support for that.
The few notes are not critical, not meant to derail.

> And there's no time to respin since net-next closed. 
> I'll defer to Paolo's impartial judgment :)



