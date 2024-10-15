Return-Path: <linux-kselftest+bounces-19691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00B99DABE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8250A28282E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634C1171C;
	Tue, 15 Oct 2024 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzypH+8+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F6749C;
	Tue, 15 Oct 2024 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952772; cv=none; b=DTiIpy0n9YkkOaVeGmT+x4dwFd+GZdRqbtQMMXPNKYnzsJbcDUx8WRe2jmA0iJSkMSNtwgwQdMa5+D17fMftvixR9bRDocvlU7ZFPmiUjE5GYa1TD76wvIK5s58iCY7ULDCJhl7NjtLdd8E0eRXNhww9yItYcrTROKFD6HZlaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952772; c=relaxed/simple;
	bh=mUjPVFo9yxUaSxxMFdyezZJIh/LuIk4bsHdYDUsfN28=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dJWwxps+lnwZpl889G+FRJmAvzmseBjgdrRJXbaSLrS2ekTXCVSeEdzzoIKGtfE85CB7ChdkHIZr+U3pSe/OisIXnGi7fK+Gvr3Ym+aiyDtvnhHZPyuT9g+XvvHBw/NliLDqpJ1ot9sL2Gy7JjgyQ9AMFAp2+VOg7rP85RiFpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzypH+8+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4603ce01023so39870361cf.1;
        Mon, 14 Oct 2024 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728952769; x=1729557569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FkuTv5V8CWRT6N/92nxujamXnbPIxYtwZBVXf8+5q4=;
        b=XzypH+8+sXmqnVpMOY20sNcbOao4BALIycfAyjQK2mD8awvVf58LtZA+MKBS67iCLQ
         NpaK10mQ+NvBGEDmFZtPJzOyGtcfu0zfzmu+zepOR/2PkORrlE2x/+Rxk5h+wAXD6jTl
         6n6DkQbL3xamQ1/sLMKZTzUNlGiLqeD9xpojh4IGW4X7RlnAHAXgNQYPjnpY2u9tUFdW
         24Zs3a9MQ6nvQ2qxGabvrY2ak8TbeCBqe3wfTqaaOaOQbiJC39ukpVQx4mbCZyjuY3PI
         H1AHQwY4Ozzh2lqmA/vyrsNnY+JYzfy7sI5cTSUCDzCERlMbOpX+lN3d0Bqe9S0xnAxc
         PNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952769; x=1729557569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5FkuTv5V8CWRT6N/92nxujamXnbPIxYtwZBVXf8+5q4=;
        b=Wf3cgsVvhrIxY70f8015nuSQFF/a7RPAXQx//x4ZkxQHOVb4gmY2l4VPUu8y9MbC3Y
         dFFF/y9gwFnxIMf3q9SeZxfsw3AcB6+eZG0iy7q0M7pZr+qPis8kYlwhifYBQmksnROr
         p5qz732WZ8zOWDVr2+B5U2FZP817udH4s/837Osz1v4cbLoeL6gyUv7bAMrTI6FkqiSm
         kBYLUMCD7ENEcNjDnejaYE+7qG22lNBlU5SB7ZR5T2aP/ainL5FJP8KKx+zNpogJQ8uE
         0IGqRB/N95E4f1Zc/B02Pc9pL50GQPTJqEOsTbDZ7GJ/MOGfTu/ncGrGMaIyvB8IFVCP
         E4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0k1aX8Qo4B0i0iGPM6mwHuBaFa79+v+5etGN2DIApZdUNTGPBBo+dNzv2vzWz7M1PfoEI/rNWbVUtv+A=@vger.kernel.org, AJvYcCXq/pqVVhSrGrGSXzSqWDMEzaPPWrxmqbE+sxQ2jZr5YrVsgG4FQWdVQoP9gY3BxVlno8CxREdQKYd1SN302E6G@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+UjX4roc6ntk4Twokgjyur6e2nX24bWXPogj3Y1WWyZcIyGA
	iA1o64WF3kZAzpcKxA3pkxtUNs8Evz+vTnxKnee1IYFzmUBIE+LXFx4sXg==
X-Google-Smtp-Source: AGHT+IGl5NzmK8TSzFeFCxuVYBn5CGWeeEJ8SCdyOjxuBIC/X/n6rXwQm5NS5icHsqjEHE68w0ZeYQ==
X-Received: by 2002:a05:622a:4e8a:b0:460:62a1:6bf7 with SMTP id d75a77b69052e-46062a16d5cmr99673631cf.1.1728952769321;
        Mon, 14 Oct 2024 17:39:29 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607ad3a085sm1106681cf.0.2024.10.14.17.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:39:28 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:39:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <670db9c0745cd_2e17422948e@willemb.c.googlers.com.notmuch>
In-Reply-To: <7612fa90f613100e2b64c563cab3d7fdf36010db.1728802323.git.gur.stavi@huawei.com>
References: <cover.1728802323.git.gur.stavi@huawei.com>
 <7612fa90f613100e2b64c563cab3d7fdf36010db.1728802323.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 3/3] selftests: net/psock_fanout: unbound
 socket fanout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> Add a test that validates that an unbound packet socket cannot create/join
> a fanout group.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

