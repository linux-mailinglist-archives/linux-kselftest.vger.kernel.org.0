Return-Path: <linux-kselftest+bounces-28070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A45A4C571
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04A53AA80A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06A213E6D;
	Mon,  3 Mar 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgHKPYMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73323F36F;
	Mon,  3 Mar 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016455; cv=none; b=rrm5EGFMQlb7B8/I4lpygHVIrYWKpk6a41wWn0VqXey1e3KrpaDulYotV2quhDmkQhMCNcqMdgjn3MkGcw+A67StGNBNq292rVxYGqn+dI4Zz3IR8pDZQ3Bq4qT7QmnMf8EitVGiM23/b6AfX9JDjAMGVFwFS/+u/teD4SaiS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016455; c=relaxed/simple;
	bh=aNQYiMschoGtBM/9O+6W8Myzz//LAxEpyJ4NbIPEuIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZLJ/yb3NG6ec0DyLvei/G2Lqg72xt49zySgtzw8m0I0Ebqcba9KmZMRiLJIUfh0KaOpmAbtOm3nC7bUrnn0hto+/3qCO4D9TYfskCXynrINonP1OXJ3v3u28/u8NiJtJp0VcQQH8vD7fCTmnDtvhbEJN/64DQaWr25mmfJ/fN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgHKPYMs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22185cddbffso94458845ad.1;
        Mon, 03 Mar 2025 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016454; x=1741621254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xFNtZsA/A5Sfs2ppF2Uj+G+FRjsSZJHWdQ9ows+Eib0=;
        b=LgHKPYMsJ8DTCmuiGIw78/ZnElyXdDN6P1tbYQFxC5rqD8obGHS+WQ1Xc9t9f8MaJm
         xJjb9xA7zOVlsI3T4PqAgWcMI3mLwcgT0vGnkOfWUBXOHcLyDX3bQ8ZFVnZJw5AKuHnE
         f8ykDzTZLdCbSggxI+tBB+2xX9K+u5oHRx0eOXAUh+aSyzGv8vRNYfCKagn+U8G+md9/
         djuubM0d4dhPAkoz0M9BLuv4Dz1z7f6Yv1HdKudyc0XkxLJG3UpenDJqR26BRHlq3pnQ
         IqPaivvQfNgYDGV/xjB6YEbmLsGRJGU5bcqa3DY8Jg/S2U+V7V+L1s1ylEYWsJFWHyVu
         d8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016454; x=1741621254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFNtZsA/A5Sfs2ppF2Uj+G+FRjsSZJHWdQ9ows+Eib0=;
        b=GrsHi9HI2WGbpLae3ncozlpKq3YQENWB4Q6Zl95clBRfOjV023TJq6wzAG8fh3Ns8Q
         2+lsM+GW7pP849qkMszgLotBnM8lGQWw+AT7t0KXvZIKNSC6Dp3lWYquboE/R8ZZeG+w
         37iFRmHL7omBBKhOeZ5pceof8PM3n7I6Deu7Hxgke/3m+V7dQfuyIAIPwfIRvPnODw4S
         k6F47cRjWYGOHqIu4mSPyQd6sXeLZ+Hz4Tlx3TtTvV6JiYQlHldeBgGtJN9PmZ+pgLw4
         vct5laxgR5f50Ns9rzrYwjtu859vez/SaXnL40h8qygqPXkmIsInkz5N5CMF8j5Ofri3
         shWw==
X-Forwarded-Encrypted: i=1; AJvYcCVR4yLSWBRyEbd0sDmDJkeTVn2aocu8gmBoGhZ04RAIjzfoJmW0MPxeFA25pyfQKqByHe072ZbdZ6csTqYR4bk=@vger.kernel.org, AJvYcCW6kUeHI5y/ndzxE+FIIiFHtSnuUXh3cfAkgOwL6B1c6iot5g5ghjJA9uOD1a7RdQfmLg0UINWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+JttrAL9p8OOHljITbk0da6/s6rtdd0vJeNeFjgMe8hSl8HY
	r08qu0mTaEu/1vvDjOVoaOW3yNRYL+eedhcu19z9tCxFwvKXw0Q=
X-Gm-Gg: ASbGncsmnKbQNmeymPHV678TtqHJG/NEzADwj2VK/R8njZIT7MBq5nZWvCpAhLmm+Hb
	EhIVxX8cZYcWE4IB5ViXrnl9xpOTXLEnXewvGg08D7zoapwmLPtX33+F1+UrLcK0kXp65qqsU/1
	tc4aOuP1io4NViRan5Uu8s3EMPsZvQ83XhrHzEkdjRK2uN2gAqhdAMZ1bRfsxc1fJ8AVAn32OVq
	oQ/JyFQoYUP6MSX9SjqUFMZ9E8wqkFnLim8tZyKp/54kXVAW6gc2Diz5WG83xEyGq+zJ3gIhnBp
	VlVn2tj2tbXPmRVYl6xgd579gbVevJD7qhQsOJ9Yu89H
X-Google-Smtp-Source: AGHT+IFDygpE+KaVPjzwTYJGKVVZ/niqpcShHipD+VpsKv4PGU2+rVpIfrhHDVOYCXaHk2JomP3Jjw==
X-Received: by 2002:a05:6a20:7283:b0:1ee:c598:7a87 with SMTP id adf61e73a8af0-1f2e392a9a4mr26403922637.14.1741016453657;
        Mon, 03 Mar 2025 07:40:53 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7dee12cfsm8367240a12.76.2025.03.03.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:40:53 -0800 (PST)
Date: Mon, 3 Mar 2025 07:40:52 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: use the dummy bpf from
 net/lib
Message-ID: <Z8XNhGnjDnWGGypS@mini-arch>
References: <20250228212956.25399-1-kuba@kernel.org>
 <20250228212956.25399-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228212956.25399-2-kuba@kernel.org>

On 02/28, Jakub Kicinski wrote:
> Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
> the ioctl path") added an sample XDP_PASS prog in net/lib, so
> that we can reuse it in various sub-directories. Delete the old
> sample and use the one from the lib in existing tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

