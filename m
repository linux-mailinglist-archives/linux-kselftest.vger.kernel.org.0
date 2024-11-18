Return-Path: <linux-kselftest+bounces-22161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61F9D0787
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20812B2131B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD811C83;
	Mon, 18 Nov 2024 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAIYygd+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC9C2F2;
	Mon, 18 Nov 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892805; cv=none; b=b/B20KO0A9BFWUcSLWueZ9uTGuzgk01koz2iRzBLPNK/0uqiCJUf8JzjuQVtOfYCg6qN30Kfu9zQewdL/QamKuhx5PKgCFJNQZ3wjGSyYIbNy07jcf2d0HBMkVXmbeOd/Ke1RhA3sVsj4chpXmOjPX9S8X3fwnjtq8gm5l5qnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892805; c=relaxed/simple;
	bh=7m6ySIhLBBRzLq9/jBuW03io/LurkIwAx0Tvz70c4ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGCSc2zyMvQnUGq2JKUn0P8ZzCADC6MXe1w9SR/NYLAebj8yT7Z7N/UEGGA4zYtx70SXy1uI3uBB1lCurOoM7F1MC0EaTk5ggqoftmDLw5RPWFrHrm1yQB0gPvi+0XSUQchLxOe/0fWgrwJJ+GjZHuJQPK3kUSx6xp1XmFHzy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAIYygd+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2110a622d76so31564865ad.3;
        Sun, 17 Nov 2024 17:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731892803; x=1732497603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLZ4j+0JUQhKuRCNLddjQ5xW+03k8o1dg2/JeNfFHJU=;
        b=cAIYygd+KtRRVkw/vrnDxZOOyXuJzH2aVsHyw9m4x8eVgEQU7fiV8SygHMMaP8BYri
         cwa7aaQW4S/48O5tZtoTIqBpDKroE0qZEOZTIjsgKMC/dXvg6tLpwVhaJanhdOn65IpG
         WghMeGgd5rOiwldZgs6DDfgNJgXPYeDb8ROnkjwhnMowBBAA/htSHXC2q197HWdkqNc0
         RGnu2eU1eW2cezHcGcSSY11bKC3tava0abpYNLDXthpOVe+p218eHLLFNmSfHY7BPnai
         vodVqZDvRaacfA4HymNJWfzlN2e9Bl15uHsA7+I+cO9oCSpqniSFBvpXFF6MD10tzi5V
         KMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731892803; x=1732497603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLZ4j+0JUQhKuRCNLddjQ5xW+03k8o1dg2/JeNfFHJU=;
        b=I4XgvHT0Z0NT3JfCvbGCXLIKjzEddzBC31xgZZeb92vIqMKHjqJpTeg3FdhUdefu6Q
         Y5tcwgJXCtUL+Szlruwp+uM1cY9ACBZMD+kqJUFr4IuTKujXNG7KeL/hjefmRKuGPjgm
         cioosURtL+uBr9CXxpvsiBzjcYkU7OrWWWxfM58HQeApEoSttKymMg6uMHCJFtbCtxgi
         PsOOYXb27nh2YUuI/Hfh1vzlgYhRkO4jJdhdcvWczi3tFS2eDsQZonX+adhld9bwaQAA
         dj623lia8ro8MXjyrK3kOyZaoZ4zZsdli+DE8HU1s2IlFZhEu0DhW8cmHZZOA9ff2c4D
         K6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWawjwa1K5+coGrAIpoxne+RFZj7JEna6ogn2Ugx6B2eGBKsCYZO8Q94wxfuvtnkbY5obF0hklUA9cvSVVfpvOe@vger.kernel.org, AJvYcCXtFEXitfIbEECd3g4zGJ2CrymXaeG7akiKNtpPJq51lj2g6TNkvkKFaK4f82UEVHZhfitsHu2Lsbg8KZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/049fbhdqJzPV8MkJyc+YOwpw+YBJHbFP4u2oIr1xeRsDV5L5
	hzxfbW1Xxq6/65KdittlzXBQRARZRcsVH5tPphcEmUPDn61WkPRD
X-Google-Smtp-Source: AGHT+IGhiPGHhKmnXPU7h0WAB1XDX4Fg4zXTJHpboU0k/C710xRReeYMO/J3EgZ7Bi/CiHe6T3iK0w==
X-Received: by 2002:a17:902:ce92:b0:212:b2b:6f1d with SMTP id d9443c01a7336-2120b2b759dmr66546715ad.32.1731892803413;
        Sun, 17 Nov 2024 17:20:03 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211fe7244b0sm23679655ad.198.2024.11.17.17.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 17:20:02 -0800 (PST)
Date: Mon, 18 Nov 2024 01:19:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <ZzqWOysS6fdqjtpZ@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-3-liuhangbin@gmail.com>
 <20241113115612.1717575a@kernel.org>
 <ZzVZoe_N4_h4qWVP@fedora>
 <20241113184312.7a33a83d@kernel.org>
 <ZzWyk9QHb9qseMYO@fedora>
 <20241114071340.2b4929a4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114071340.2b4929a4@kernel.org>

On Thu, Nov 14, 2024 at 07:13:40AM -0800, Jakub Kicinski wrote:
> > I will modify the test with Sam's suggestions and see if it could pass.
> 
> The other option is that some other test doesn't clean up after itself,
> since we reuse VMs. We have a script in NIPA to map things:
> contest/cithreadmap
> 
> Looks like we run rtnetlink.sh after pmtu.sh, I wonder if pmtu.sh is to
> blame:
> 
> Thread3-VM0
> 	 4-pmtu-sh/
> 	 5-rtnetlink-sh/
> 	....

I can't see how the pmtu test affects the dummy interface test in
a single namespace... I may add some debug info in the next version.

Thanks
Hangbin

