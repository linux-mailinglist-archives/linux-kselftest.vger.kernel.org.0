Return-Path: <linux-kselftest+bounces-33643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B7AC21F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CC81796AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6DB22B8B5;
	Fri, 23 May 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCOYsocP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23C8183CC3;
	Fri, 23 May 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747999322; cv=none; b=t0DRsrJMn54X24a+t9OcPxONr2d0ie+d++yaVjf+MlidHL4G2HV898Ikah+1/JNlnEZJdy2SrpG4JWrmwoItA2ZLjX4QC/qpE9o/ETm6Dftgp3N/Y6u+N+lVR+zUSlfUqNOJe/IhUjwO4SpW8lffioWQX/Mg3UkU8ldZigwrnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747999322; c=relaxed/simple;
	bh=HRZY8nGDspugFFGgZZlyb9DuiWk70PoXTEbTARV8PPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEm6RjCkNuDzdebQUOq013X3nO8TlBPtH1BtX65D6XrUcT77r6vpaa5korO6DQ5A8oS/IW3DejFEliAICX/QYQZ5uCJKDxySwhoOVmJLrLUYx1Ls44gbrzjpjlgCU/EC0h45Ulj/oNyYmV3jKG2Mwj0Y0IhUMSE7GjJO6eQGi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCOYsocP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30ea8e2bbaaso5692122a91.2;
        Fri, 23 May 2025 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747999320; x=1748604120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPHyaSHkvCyCPTXv6u+eDabhPxYYP6Plc2ufQ4SwqUQ=;
        b=iCOYsocPjFh7xHJKZV4xrG95oOZVC5ab5RBxKKNV4dhUBv2VzzELEWeChfQN7CZ7pw
         gJoIUwetf1CQwT6VvIRQHlk/JlHLp5/yFFZffNTTzPE+7GJkSHVLWYSsWOEH/ctHBpUB
         yqASwGXc1F1GAv3cz/KpgQfRmo/n96B0cJpgStcRPLuCyRT4XIrFVdzc+5ABCt1GGI0a
         0/z877xiwdHgPxnYuhoJHHw54zWiR6zehOEbFt1DREwihUDY5u0kS1ARn4jHYWx5bRND
         rbfb3Z5kXO290tosiqyEhF581OD2kyg0Pq1HhA8FS4SGgJr4slRwWQDWmxrCbel+0P2V
         0Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747999320; x=1748604120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPHyaSHkvCyCPTXv6u+eDabhPxYYP6Plc2ufQ4SwqUQ=;
        b=ERNg7p4LDBvZFYGwrN2FB8iSZI/Rg0UZALS6BZAHIh/wY4ENMsRjQf7rdUXhvyzzEL
         BIuMcdBdqhSJ/r26TxcWlXdV9niWAkP7EP/HL1jG2JrofEfuWVuNx2SW/rLKTPRG0z9g
         I1cCx7vi+LIBidu3D6QGdai5ThxfvBqkHJzr/9jKktDLhALd314w8KwuvjNx7EAKR8EJ
         Kv2LDxtiPlNsPu2gaclQjdXWVyS7xw6Z3yKe140SXwY0fg4zKNGHMIRm0KQNyGinS1Ys
         Gu9QMmPwZneS5m2CrBvokobPVTC2QiagQsURtt2O36ivv4ovdsIgRlQap5FtuIZV9EXZ
         AU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8yiM05M2sDqskqxGxLm3K2/9N7RraJFGN9MH4elN0HDyG35+nvSLFYT4l60ZCeIisX9kpXaCcnhsfR1hh+mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqC5HAbullGRXmIf6EqABuyF3yx5ePSGPeezHJEWs+BxdkPAoZ
	gU9emicKJB9U84xvNDMbLHZ72ed3B9o++GSSPsJTGXUUXBQUgZXQ1AEg
X-Gm-Gg: ASbGncu6LQ4/oYIAaZzxUGaGX6xbTkus05FZif3f69xIXWSOquRuoYaywptxk/oDfPa
	NmDCvAZpHQtLIwnlVnPBKv2wl4MgvYVpuEpsaVBnbEBvegL+rCE5WukxcILE26X+OIhDGA6PSmF
	QjohmYzJpCG7ZT7EuCCbOhEEMH05jjy+4LannXpemc3te4Avc4cIKimuiu/hQwzmSlmg/qZIdM/
	IdMZUyC1y062hwX1f2LkrekHOXN6P44JqmV6UYKrnxJDRsTVbanWL3ABCEwKx7LV3HX90aDxJdW
	rIt7XERoDWnwPP3qnoIb1/eNl9Xvqsqp3uWqMMANKAwB1tvmRdQcbaLMy70WxwN17aw=
X-Google-Smtp-Source: AGHT+IFtwdCBSuO+HZMryb8qVIPtiyuYMxUouiREvqVTSIMkYRjCXn7ITim/JrYUwPnsayMfqr4aqw==
X-Received: by 2002:a17:90b:1dc9:b0:30a:3e8e:492c with SMTP id 98e67ed59e1d1-30e7d5be2ccmr36427873a91.32.1747999320086;
        Fri, 23 May 2025 04:22:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2da7sm7127825a91.9.2025.05.23.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 04:21:59 -0700 (PDT)
Date: Fri, 23 May 2025 11:21:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: move wait_local_port_listen to
 lib.sh
Message-ID: <aDBaUJJegs6v1tQT@fedora>
References: <20250523034433.1373-1-liuhangbin@gmail.com>
 <c8455e63-4c25-4610-bfbf-f6547b3ac834@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8455e63-4c25-4610-bfbf-f6547b3ac834@kernel.org>

On Fri, May 23, 2025 at 12:56:01PM +0200, Matthieu Baerts wrote:
> >  delete mode 100644 tools/testing/selftests/net/net_helper.sh
> 
> The changes in MPTCP and others look good to me, except that I think you
> forgot to modify files in tools/testing/selftests/drivers/net as well:

Ah, thank your for this reminder. I missed this directory. Will fix it in next
version.

Regards
Hangbin

