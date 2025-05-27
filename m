Return-Path: <linux-kselftest+bounces-33872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A4AC5220
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945E94A1364
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9B27A442;
	Tue, 27 May 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZerS3wiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3262673A8;
	Tue, 27 May 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359993; cv=none; b=g1RUD5S1YGS6SOG/TPVFfWsbBddMtHQpsGkqj2XsRW35Q2+gzCJN1ObHoznPycObblwbLhaFAJCsSrw0NaeQcbV88AG4RPD/Hd3w4vkfjxhK+cEjMKgR1h66fbFKX22q927xC82dzmrepJjfH/fBeCZDapaIYHCcg6cOnnRo/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359993; c=relaxed/simple;
	bh=LqvuRTatmdOotVQ3IadCqICqvMjNC0FeKdqJdQ5vvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9kEpVdB5gF3QZ5S2qBvIBEcjrxsjNnG1Gu5DxVKYCl5qgdQNMWfaqQHCQtSsCswhAATSXhqXHtYHjASlNpezp19eRKlJK/UGwM469vBDj9pKxzPhRftRVdW9Egoz/Fr4BceoduwRbVMKQUXLOFzQg0VPI8FatKo2vnK6VgArxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZerS3wiu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so24274975ad.2;
        Tue, 27 May 2025 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748359992; x=1748964792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdHLVxHJaBp4f0t7ilYksHGbK6PzhkE+jk2SnZmLiWM=;
        b=ZerS3wiuid6PUlF7K/HlYoXi+cXLNsE2H1J7WEu9X9nUw5aCPANIP25FpsLx2fJvey
         CnL8QFMy1iKcRilCiAcs3oo5uRQFivXLfcf9qDlw1A+N2qzwxjb8D9fz5uSYoMjI8z8t
         UF36zgScN5WcfTqVnZbPJehg64JNSmbNhQ7cTzEiwtWDuhtlE7jWxvFXUGICtzW7uHZ5
         JjnvUjcXAe7E3+pL9Gf/ylVgCJJuxaEh5xYLSH5yY1H72oah7194aL1L2+4yiVsfXzrG
         Nxi6PZLCTpuuDz3l9Nv+8JfbV+iPL1qS8mKFPIgEG71D4j3PmjE03g/vvrAfc+o0wWcb
         CDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359992; x=1748964792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdHLVxHJaBp4f0t7ilYksHGbK6PzhkE+jk2SnZmLiWM=;
        b=CPWKqqlTMV724CBfzJFVP47xqGU9xKdZqVDikoFfC9ifvgiABx50HvNriyS3F1VwJV
         NuZ0GsCUSIVBiSXWrqCUmy3BwilK5ZgxqbxZXZE2+cT6NC5zhPoQ17PPEvy6styRpw5K
         dXu5PdB6y+xX3YFqWf3EC4j9mqTFq9LU6zUF+JKG+MgwA+Q2B472rBW7ZCepV9ApG92h
         fdGb5OsT5iirfswjUYZltg/eafV0fRtV6w34DuNbezZaRZvZT3n4tWZnIidY45bS+dMQ
         jQrkP1zonM67neykR6P1eyfW2JDd9wwH6AnrryvnzKo6z1oh5VSZY0f1KACuEytA3l/H
         IR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHHg2vI5xMfYzgUW1fy2+WSMCrYta/ke1e/A2KhkU0M6G3H8GPPP/BZOJACvmyt0GVUMAwnFLxq+AmCd8=@vger.kernel.org, AJvYcCVrqNuCT8OUpaGGKMUzW5bekc6KxVS24f0MSakETjs4rXV/V6NAD6ON2AKWT+NsfEaB+jN2hgiodvOLDvtbTrSM@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkOd/NsqzlBggL3CuNnc0DpOtTiFIyTlEjB11mqcNAZIP2axA
	c3UKI4o8qkHHeRVeGlGtudQdE4xY+sya3ZRpzp783PDkoEFYZTTa6QY=
X-Gm-Gg: ASbGncuo7ad8X3rznIIr1RsIYV4oQ/nxnuHTY+q0Mx/0ummbmonloTMLgwES+Rit0K0
	zEo51oEJI57AJYzjDeVQy7WGQ8dbtSml5LBnURD1r3Qojk9Xk/iSTGcrzmeMD1vNlNMpcbPThFg
	46MYvpXGz2SJgANDuaADPnS8HjbeYv6lQ9SdJCV8RCa5eRmmJjE+1QvjF9k47lxjlRPxyFu/RM4
	z1/hYHvbo7wzSh4yU0LF7rQzmSrT9esv4DuKNQ0ljor3St1IL97SN7AgVAMm/PQiHWkjMfxcvv5
	Xguxiibl15kgWmcQQf5CAxYsoy8lqdZJX1R+0wnT61e9K+iymYfSPcNhnwGznHoRm0JKjCFZp2+
	jDEcgn7z7/+nd
X-Google-Smtp-Source: AGHT+IFtpDIudftdgacWSN7MnJ1DzF5B/+oRHun532pPzI4muPVvIOF+miAGoZF1kzjfM9JfDPvelg==
X-Received: by 2002:a17:903:19e3:b0:21f:61a9:be7d with SMTP id d9443c01a7336-23414fce680mr206720265ad.49.1748359991651;
        Tue, 27 May 2025 08:33:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23426cd57fdsm54940345ad.205.2025.05.27.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:33:11 -0700 (PDT)
Date: Tue, 27 May 2025 08:33:10 -0700
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
Subject: Re: [PATCH net-next v2 6/8] net: devmem: ksft: add 5 tuple FS support
Message-ID: <aDXbNuCPNKRYYVRk@mini-arch>
References: <20250523230524.1107879-1-almasrymina@google.com>
 <20250523230524.1107879-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523230524.1107879-7-almasrymina@google.com>

On 05/23, Mina Almasry wrote:
> ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
> FS support, but the ksft is currently 3-tuple only. Support drivers that
> have 5-tuple FS supported by adding a ksft arg.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

