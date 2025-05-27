Return-Path: <linux-kselftest+bounces-33876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B0AC5235
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF184A1FCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4727D766;
	Tue, 27 May 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMoXAyof"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341027D763;
	Tue, 27 May 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360076; cv=none; b=gjl/uH+Fw3P/YLBFYTIvQhY/n+1Okhr57KNhFMfD/386nZqw9aT7n6cC3UrL8fNzvcMsDcpxoyh5nTau+0DM4qkXNMa7MXh4GurFZV/RZv4gLpc1oJyzedJcv9Bao30nG0IVWKl2cgr0+s6FlBXwDPRTL64YhcJWcrLGKxRsRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360076; c=relaxed/simple;
	bh=+FUReaQ6bulPRRYUDaeLHKvfukdfTsb4R2qDn2e84kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttn1RVEfAxYaafbWXnmMuFD2EIMU7NcM4ut/Y8upiYz4lT2DzyrArugP44tXcSco1tQ3/PyIOlaYurOv4wkNg41cwxINHo50NrS6ABFG0Zie8i2Fi/DCgCBH1+rHf6ZBGgQ4LdVN07anPPybPhCNakiGHaFhFjYfDEZsQj1O7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMoXAyof; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c27df0daso2565721b3a.1;
        Tue, 27 May 2025 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748360074; x=1748964874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLti13yILFkR7Iz8PUUwE4cYFMeXOujnaUgscAuRKdc=;
        b=JMoXAyofBzWMW+S9gmjN+sP3OwV/3FIQMcu73X3fsFGZdyxuECeW7J2BJBZweV2vv9
         61Aqb9qOI2ZU+av7ZNr8lXhBDDeogOdu+wc9UurgqQRk86zrFJUlopvFm3X8uSDyFpe4
         z2G0ehUhKNMq/tTNr01lBoT1w59bx/rRlrF4mkqgY3z4V3LzFBLaDpPdiq8IM5U3lSZ3
         3Xf4pxYSHQByQ7aPh8yHQYevASHm9FDyz+tCJRm9/KrEoCLXwAeJ+JccQB1FukUyWgYs
         S1Bk0YsVgkwXEHJ5QnndxddfIsxqenxUkAgL+PYlkt27gzlgf9VhtntzG4Fag1hMU1lc
         nlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360074; x=1748964874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLti13yILFkR7Iz8PUUwE4cYFMeXOujnaUgscAuRKdc=;
        b=BGYbAgmWEcT7pfOitA9qwtQ+ApUGH4lHZRrleY1vmuKAn73fpssb7X5Deh1XekJJN/
         xZv1eYSpfus0Zm7HJvUxnDVy18utlRujOgz5gBbBdN0XcyMgIb9q7S/hzJpKxDPcY0uQ
         lg5fGE2V15WBjgRAG6d3XBVkfP+5oAD7kVf7FTPuVdfqzTG4qd94OCkWIeMuaECh2ge5
         aXmTc30dCsPld8damKaH06EJDbK7PNgO0ghkE+ydSKGCOS6Yb1Jxprn/jj73tnYnaK6K
         dglZtB1rezs3IOW4Ll0xBTPXLCJmt4XBdyLtWzyYu9pipyJ2Gz3HIqeHgfVuAUU3edhW
         eSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7zV0ir0kphXMyqXNp4geH9o9SF0Sp2gJDmSiB4XqXcPfnwhWfQMGTTBQfDLtral9utf6MysG4L2izbUU=@vger.kernel.org, AJvYcCXwz72DGPihvjiCC3oSj1c89loC+9xMArv7GHTqpIUqkgnOfUC3G8hSGPZPXqSYEfGj598VfP3igUSPhD/mJ/Oy@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfU8YHjwrHG73ZVSHaLWU1nplitQU3qKu615QAtbZ2e9KPwEU
	xLcFY8BRbQ4mzzWOA1xJmfJbCjsGdVD73GA7Pi82hVNzjBpjr7wD7CMc9v8d
X-Gm-Gg: ASbGnctJ4fcM1MimrQFpRKcnA11X5RYvoti7RL4UMLhN8CPTyWHoo/qNtQjBE8Q9Lgp
	qbzqXwF1JrBW/acGeoEgbqaLHB0xxdHFfeAxCVFXumH1B4QUXd8mVn7ZSz9YTAyHyv/LpYWEoMS
	dBSLjmZ6LJREvnwZD+Hl82txARTwKXSNpuYLwLxstFxWHNpjYXWqS34012Zk8Vfvwx9AtPz3X34
	LyGqyiunM5px8tKFrFweJmQNpYQxqTKZGucgtdTk2mMhN99RCSrK4lsQ9r6NYv3+WihIvbI5Iq6
	ldxdqaxKOLrQ0/WMTMnCsOu2Whb3LFNXJzRzijbaU6UOuv/Un5/X6CgALqtMq4JXtlbmdxCi7Re
	iNxKRMMcZyHFG3bUpAbOhkuo=
X-Google-Smtp-Source: AGHT+IEjEEpLbJT0KtUOVtuXy9gSwFRZf9mKrp4oMqdWYGHCaMQb4N6e3e5eip0NwpR0CyOV0Ej8Yw==
X-Received: by 2002:a05:6a00:1384:b0:740:91e4:8107 with SMTP id d2e1a72fcca58-745fda2a06emr21000221b3a.0.1748360074547;
        Tue, 27 May 2025 08:34:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7461b8b1328sm2948502b3a.77.2025.05.27.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:34:34 -0700 (PDT)
Date: Tue, 27 May 2025 08:34:33 -0700
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
Subject: Re: [PATCH net-next v2 1/8] net: devmem: move list_add to
 net_devmem_bind_dmabuf.
Message-ID: <aDXbiVropGMSToC5@mini-arch>
References: <20250523230524.1107879-1-almasrymina@google.com>
 <20250523230524.1107879-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523230524.1107879-2-almasrymina@google.com>

On 05/23, Mina Almasry wrote:
> It's annoying for the list_add to be outside net_devmem_bind_dmabuf, but
> the list_del is in net_devmem_unbind_dmabuf. Make it consistent by
> having both the list_add/del be inside the net_devmem_[un]bind_dmabuf.
> 
> Cc: ap420073@gmail.com
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Taehee Yoo <ap420073@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

