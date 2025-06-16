Return-Path: <linux-kselftest+bounces-35082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D52AADB427
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F5E188C5DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DB20CCE4;
	Mon, 16 Jun 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT44MBDU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AD8208994;
	Mon, 16 Jun 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084790; cv=none; b=MuKmE14jqzVCKDI1Xlqg0Cbx0J3EtesdqYSv9BV9yB452cFXXVV30LxwxYMiW4ScvVEmPj5g+d3Yu8oXgPXCKLNYtW20/qScgQCc9eijt94i1qt6X7AQblRsReSkOm4/RV/ZFdBIWKUBE+mHY84BmhdoePrfhJgsorAM4gn9mgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084790; c=relaxed/simple;
	bh=KOPENwIVb19LoAtVyZS+Al0TEn5BM5TRgXuv9tmcfaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsgabPzIibCCpspdoG+COg90nVYbCXdezRDRJyrHgs4DAPkhkWvXHdCC96Kfk/eG+HeRPQQYlHjmBTC2J4p8dT4+MuUJeK/9sX+Kn3CL69B7TgyEkdSb2pr9/k+yn7c1DH8L9Eadq3Nv5vR+2yZwn2+1L/0MbWqxE2lnNDyd5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT44MBDU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5426410a12.2;
        Mon, 16 Jun 2025 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084789; x=1750689589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPbroSu8CG5R70vyLYRD7e9AmIXXtiRxa68yYHMHnnY=;
        b=GT44MBDU68gDVp2NORrXwP79GbgrQzE4diGFEAhWktAdSkVGenS++wtgBXXcMsS16A
         qRhDDU40ykc+yC3d9/RQpFtq3rrjXEqi7NrbUUBYIr+KcEg4hEbY1cX61eYospCfKQZW
         IrY8zfH03pP8wTyhGH4Mpra2Y/QCTd+szmIZWGH5zsWaKldC981MT5ewd2qCmFKCHVVI
         4ged9iL+LeLrTmXAFWpSA1zLyLriuna5iHBOx/UbvourZpxIVB9U4A5jCn4VAZlBEh7Z
         NsNcY4Kjuqly64NhglymeYmUJrgjbVgr21M9o0n9vSuTtsS2OLLJm0vycfFA/4ztFZB3
         520Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084789; x=1750689589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPbroSu8CG5R70vyLYRD7e9AmIXXtiRxa68yYHMHnnY=;
        b=s2HktxEZUZA/pkp/mZUnnBiPjlwhg0+8UmwesaE2qpUrjHQBpcRi0Bo8dnbbrZPhtG
         rHLPHbIuT+Slw5clozVr0xeaOgrjSIPTGnWLyys2b/lJHaCQtH1f7vEcDi2aopMANhoY
         LinfNCfuyLL25EMaqXupOipXFLc+siejvwiACAlNpyLg/cPEC+zhddbqOBJ6uI7QJuv4
         2GnFS+L3SOMwHK3NGPYnPHtPaAuWszMIlRmHs1nZ/R0zJxbH8StQOosK9Kb0swZHcC7V
         f3KbDEyF+BKYZqQ7WOPOAynl0rGbdHS5R17uA37XfT5MVXuTCXYzEQg3z76uMIg5jasA
         0ROA==
X-Forwarded-Encrypted: i=1; AJvYcCV/hV+8H9z1qiyXTgS9VeWeyO12GLjM+dVK1socg0c1eZFXtLA4QKxubiyhsx/E+TcsS7jJLNGkO+JmUoI=@vger.kernel.org, AJvYcCWEWCW64Q8q/KNhAOXbBUCxQWIcISRDi7aaWSBADMQWGt8BanvC4bubxOk5AbjtxyDgFnj7XG0n/EvjOlBalg7h@vger.kernel.org
X-Gm-Message-State: AOJu0YyruCJuXKTpiRsEN3PFz6Gzc0npE04gVivC9oKVx1U53+SeMIgY
	Te3qRJ16KbSLePPwH6T8a+yWzEvl/oQgClpzXDYyxbkK0yWFTAuFhuI=
X-Gm-Gg: ASbGnculH4MBx0pMFbEs/+p9CN1Q+3FhdPuJkbQGWSlHv2jgC7Hdhqgmx7+OC4P9jyC
	cAAunOSCbAV1jgC7SssRCTRBPIz/MFyZ+jlN8hQn8XHhLcor2iHMccC/Dz9x7C6a+dGxKUEbtFu
	EAKRfTfMDy+GDnXKS0oS4lGbgyBAFr+mvsS3h9d1SCL7tial72RAETujE7NSTUr5Q7OJjznHoLT
	3gT5w+zhLu2yHJafoGhnNh2Z7hBdNXkarF4xX3TfPZ1G67JX7LO0J7EDVruUEs1Yybcn5Gckk3/
	LD0+99sBBHXvIHL5CBydGQ38WR5mdpfdPbJw+olpC3gaI8vGDqREHJPrcmtcInBK/ts4GxuWhSr
	/Rznd/XR+euOju5tvUrlqzNGw7u+mA31oVg==
X-Google-Smtp-Source: AGHT+IHh5T9eh3/X1yuF67gc+S2u45L50Mi5AWrm3N5u7RWhqvRjC/ODmjTOs11AsWmQFqzbiOWd5Q==
X-Received: by 2002:a05:6a21:4d8c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21fbd55112fmr13978289637.20.1750084788606;
        Mon, 16 Jun 2025 07:39:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe168045fsm5921442a12.35.2025.06.16.07.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:39:48 -0700 (PDT)
Date: Mon, 16 Jun 2025 07:39:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 2/3] selftests: devmem: remove unused variable
Message-ID: <aFAssytEf5mbgdmg@mini-arch>
References: <20250615203511.591438-1-almasrymina@google.com>
 <20250615203511.591438-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615203511.591438-2-almasrymina@google.com>

On 06/15, Mina Almasry wrote:
> Trivial fix to unused variable.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

