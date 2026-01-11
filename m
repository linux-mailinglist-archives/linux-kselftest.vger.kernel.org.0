Return-Path: <linux-kselftest+bounces-48683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF554D0F7E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A8D301585E
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3933F8AC;
	Sun, 11 Jan 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDDfIGN7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA055500963
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151305; cv=none; b=EChrGkUn2ZBv+rA9XvfcKMSq69x+4DkSWRmfxuQiP7aHnxBysAq5FuaQz3Lv+etSxpsICPfyOYtNrTfSOvHn2Ai42b/iSlYhQE4MA9acacb0S1KPSLbeEkw3iLgSpjbEpOdPSAftLpyhlVGIXh1ynIYRRj9mnY8gpV+qegApMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151305; c=relaxed/simple;
	bh=ChxTuCZvDUxRj0pzYcOTPUDgcdgsScGVGKXoOlnMjuY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iiHMxIufPYozpjEhpOFjxLdEU4cXrjE3tqPkz2dY7urpWWLTbh0H2TPlfH68IQXQ8IiGIxq9d+NO3GPR38Ioa4lW5hf+w2GyHETXd3czbrKDtLo0KcNbU1nDD31V4u+gZJrgLYKFcNgKrX+1THbw6zEuQ+0nnb+/y/aAVqVyOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDDfIGN7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927261a3acso12198597b3.0
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151303; x=1768756103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuts8d4YIvfPpo7zSeg7lhaXQ3RjFfA2fgISxiZby1g=;
        b=TDDfIGN7dSxuh+3jF880+wno6s32TFMab3UZvpQmNQNEVOi4P0Kf7YxPkKUVz4+1wY
         /z6lWiPZ6r9U0uUx+P96zIZs1N6yUMe/VsfQ0iiuhm9VCLafEbAk3rv6/c9GprmiPN7a
         Vh0RvU0vV30O2qhDImyOHlJesC+uibX7Tfud0WhN+PDOCZapxBR2USWkBZE/sjkb6Zoq
         VsiW66ih4RizXghNWX7N2Iq0SxP6pxNTchQZgflM9bDdfcdgc7NGe+xgNlkpryG92ziG
         3evxlEuM9ZD4NXf5a8201k+mBODQabevCks/gN1HdR3BREe7i+BxOJbQdUVnkpMeFYV7
         0RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151303; x=1768756103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuts8d4YIvfPpo7zSeg7lhaXQ3RjFfA2fgISxiZby1g=;
        b=aAZoGjSQQW5fRIYJCQljFQdgtR/nH9wWJxSazjWJzN2e2/zNGDJoDmaSQqejjeUMOm
         AnkglJn4qfdG5O+iT9frowKrSE0I3jnmexTtUVOJ6zwcXRNKLUsEX8QAkotMMb2fkbcW
         gDJO3znNdARjX8X1c06+MsoBR1y6XPh5HyCM3AuopmOyDlNhLdm5Aaj0iMgKO91T6TPi
         6zTH0gzXHR3ncFSxn/nZGSvA5BS7pFvxZKKYmsL6cxn97uS9EF+pYxnnIFUh30Mxgyf+
         jxB+ObLpYSr5P/9tr9kIoo65Vx+AmyaZn8rxDA9ZeXvp6coGPfOqhbbn4mYfTAbg6CEj
         wwxA==
X-Forwarded-Encrypted: i=1; AJvYcCWE3RjiOV1XdY/sdK4QONEr1VBKIGKn2Q/3+La4WyA5H6YS4lX9ogB6jXVUo8aKg3ARCqZlz9HdcP+ocDVlkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5ixAY9lWJIIi3a1w+U9h/ls1/m2CvgCl9Oke4rp4XTQ5o8kL
	FJHXWH8a62+PxZ0m1PDQaFnBAp2IufmEqmj2+n2cp0X8zXssw+tDbef4
X-Gm-Gg: AY/fxX7rHh62/TtPDGUScS5fhpNgS5tK+YXah6eNEJGjSp2yyQSBlokishpXB8Njk7L
	ZtOUVhfEn8QIdGeqIVTvrzDtFp3eycCMX7uUeHZpb75ZZB4C4GuFXXkWMWejHkMv6Y1UUTciKEs
	8YY/d9+nIl1mFML5oTkR9YRRf047SDiZWHxsEpKBCNnxbTcMOtLtiDlSHoT4DcAzjh7eOouDGQc
	y7/OSdygAGMysLPBzrXd6QaFGw2+G5XKTu5DWMSLivXqrO0jKCbODN0XMLHUeELdOj/v8Zt55qt
	j+2sSRI5Rs9WbsV7Bitu++Nwsab1Bkh4n28WR5jcCgHou2aVdG0KHkwU2YRjeteOM17LEtP+sSO
	3OD30girTXOSAZN4562fJPy7vzWv0aBJGBUU6w/44tH+G/2OjSq8X74vMbfXjF5twHzYcEAJL6L
	2V0lDX4sZ1HO4a0ZZU61TesexaXrHhHiix3kmSMEGIDCy+XDbZiC87D0X+kQw=
X-Google-Smtp-Source: AGHT+IFzgnRfZVCjNlKbdGDWXfdLVr2VOWnc0qOcIUwEtVh4gfYVIqHsPgT7BiosX6Pa71Jang7nUQ==
X-Received: by 2002:a05:690e:1243:b0:63f:9979:2f9e with SMTP id 956f58d0204a3-64716b35d5dmr13846068d50.17.1768151302743;
        Sun, 11 Jan 2026 09:08:22 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6f09besm61725107b3.56.2026.01.11.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:08:22 -0800 (PST)
Date: Sun, 11 Jan 2026 12:08:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.28340b94dbd01@gmail.com>
In-Reply-To: <20260110005121.3561437-6-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-6-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 5/6] selftests: drv-net: gro: run the test
 against HW GRO and LRO
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
> Run the test against HW GRO and LRO. NICs I have pass the base cases.
> Interestingly all are happy to build GROs larger than 64k.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

