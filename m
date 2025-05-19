Return-Path: <linux-kselftest+bounces-33329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207BABC25E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2133F1732FC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2692857CA;
	Mon, 19 May 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4ZrvHpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5028540E;
	Mon, 19 May 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668324; cv=none; b=Sgc0DBubafxBInSVFCU91HjIrkPRfLEbOqtWgPI+OttHUH3jprJm/HEptfv/6Rd7ufwxIbjMzluuum5C482+kgN7srHicxx8KVwnyhmG6ZqwIUl9FIJh/F0G9fkzQZRR+Y+Trk+Nzxa1Y/DfKIhw1e+eZ/eyqibFGKQcJ7/LqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668324; c=relaxed/simple;
	bh=WxTmxGlQrrguSoMwDfctC0NDsUBzH83Lrk3yMUKKBt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN+Ot96cxcCJOeWIVTkxkGnAbnU5GZGRkGCEaQSov+wdRfY4+KProRXGVNaPkm6GXB1jtUlErulvhXBIUUmDgw8fI5TAH0PwQQelZ0NYX/F/VHLipUXWEw085tcg3nfC3AmwU0lPlQoXL5UP+09LSdkFhjOYUynh+c1+JoB8ECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4ZrvHpz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22fcf9cf3c2so37302815ad.0;
        Mon, 19 May 2025 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747668322; x=1748273122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxTmxGlQrrguSoMwDfctC0NDsUBzH83Lrk3yMUKKBt0=;
        b=C4ZrvHpzFC8Wf74Fl1mug86eDGHYRvlzBI4OoYfVQtBsRrIk5D9IrIkTtc2wlym2RU
         VI7xgs0ezUkqDcJqdzzhMA56uqXk+tSZ6+ckzlrwk9twsQWoxIrBcwPtWEkdFmYPqGZW
         HV/K+cUuo+Ov/yi+0H9R7wblWFDLZ2blJ4x7N3yU3ZYRB/aQRIPvBhiEYNoI9BIAqyR+
         aLJnZbxprWPZpym4s+S3sM4hxNmwmaQNQ13rK8ltM9Lpm7H0NSOCK3/htDhYcca6MCVd
         mH52pKABLqrW1QYrqA+SXWiQuoM/nknKM1t9VoNIOh4F2SYhTXv9bJhuNfJYk1ZJzaMe
         p3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668322; x=1748273122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxTmxGlQrrguSoMwDfctC0NDsUBzH83Lrk3yMUKKBt0=;
        b=xNvS96EOc5hzoCP8MoG711/v+PvdRSml06SI9qluoCRKkxnaDxZ84dvb3JQbhrM+Lp
         nKGrRmn4OB4OCh6Xt/mtaT+46IX+BjTcmpfl99e95pV/ULp65SedgolWJWeSvS/EU8lG
         BeNAQMYv4zqqrOEapUyAzrSowjWrp8523nuRhrj+D/7dj33JsPtAD3vT30wPNCw+k0UR
         kcDgbnyoipal0NcoFKpaclODs0zNizuHyoHbfGp7rScac4Y31uNlNMGZdUzbYaE/qMGX
         PQ14s4F1RPvRzeQSGiTdudchnYIe57dS4Irugc3dICtozIRDaYSYk1c0HLHq8yQ80ox+
         fVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGcON29B1Xrjfj/5se2rRegKI/xaHWyO/1/14Q17kXDURjfljfkvlc0VcYK4kZZ4407QnalBR3riQRBa4=@vger.kernel.org, AJvYcCV5ROOK5qszCqt4Y6/G5aDPNj+YKPKZm+MokQO5yXg4boWG8AAVwMNySUn3THf+8cyNAd95pocQg2oTG3Rxraqq@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSTmJvXa2v5GbN4ao0Sf45G5pPvQR6qpCVDPAnUf4xLcD0l4/
	ytx+YG7M/H1/giiYzF+0O/UQ5wAacjaAGYjeaLcA5vf7K/1J7Ac/k4Y=
X-Gm-Gg: ASbGncv4bJRvI1DopMU34Jc2PRm/yq3vft8M/ZqiaTLMBA6jGUnKxkU3sQr/khN1D+M
	01Mf9q7dbq+rdF9XGoTWUiXdSlPlFN6eIT7pMLZGf7idakF6EkcNcvXdpAhr80xd9HSUWOeAsLc
	enN4voQEI53rpQ3iZic13Ny3kdsnE/NfPC+6EINNzA/BvFl74Pv8/BIYxdJAa3uVqIkVAdpBQ67
	gtEUKyekeTzFyEyM5SX2bSjY6nXdmJqaB2ez8m/qmyz5QnKhQ5TUCtSiZMS5iU40UWPlEazfiHW
	//GvtsTizkAP9v3schJHghB+zl1c7ihF6189dL/tDkiVkQe702jpuyx00X4Tc5RKFhLkXaNVtoJ
	5F/4LtxYx+v5m1r/ftpHy+1Q=
X-Google-Smtp-Source: AGHT+IHLWG5Gp6m02I3QhciVry41Kgg1dKPKkjp1fv3rQ0gNRmq6/G1TiOAb1/czY65bEK3uo1b8ZA==
X-Received: by 2002:a17:902:cf12:b0:224:2717:7993 with SMTP id d9443c01a7336-231d454dcaamr193778135ad.45.1747668322082;
        Mon, 19 May 2025 08:25:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e978b8sm61053245ad.129.2025.05.19.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:25:21 -0700 (PDT)
Date: Mon, 19 May 2025 08:25:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 4/9] net: devmem: ksft: remove ksft_disruptive
Message-ID: <aCtNYJo01UfMOLfr@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-5-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> As far as I can tell the ksft_disruptive here is unnecessary. These
> tests are largerly independent, and when one test fails, it's nice to
> know the results from all the other test cases.

We currently don't do anything special for disruptive tests. I'm assuming
anything that changes nic configuration is disruptive and was thinking of
an option to run all disruptive tests at the end of the run. But so far we
haven't had any problem with mixing disruptive and non-disruptive tests,
so it's all moot. I'd prefer to keep everything as is for now (or remove
this whole disruptive category).

