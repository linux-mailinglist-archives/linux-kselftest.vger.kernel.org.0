Return-Path: <linux-kselftest+bounces-21659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A449C1848
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EA2B225F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970A1D5CF9;
	Fri,  8 Nov 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGVYzKZ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4971D2239;
	Fri,  8 Nov 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055573; cv=none; b=B4kFH50ljdDmdiRRMkBxgaM89UKKA0Q1mCHCCSn/xMM74mjbmFeV3r9qMqmUFhUqgFQOdw92b0cHZugwaAuDuEXkXM4DALUewYfBnXtCOCe1xFFF9Pe8oDhxLt4qFFdp9aRg9X+3hcbeMjKnCoLcBvGWNc35BP1aZY2xOHSbdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055573; c=relaxed/simple;
	bh=3YzZNl2Yft5zhNJiVn+O2Cxpjbv4+QOcHH/a9sEX7dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNc4PuemW28hk9G2OZunlFW+MR/+nMurxr0gFBnJfBGFAO/c66EzrLPkmBaJlN+8q2mq+ENswnd8Ei0MD3VPjUEzhCZTcLKF6fizZI2SYN5tJoZuvr56zZwbK5JkrnddllGyyeh+O/Xk8VdNVLobf4pZQP5Yd/xzhe8IT7MtncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGVYzKZ/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2974655e87.1;
        Fri, 08 Nov 2024 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731055569; x=1731660369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YzZNl2Yft5zhNJiVn+O2Cxpjbv4+QOcHH/a9sEX7dY=;
        b=WGVYzKZ/lg89Oi2WYsud2LaeGYbyuO8+pBOq1tvnqnxLUr3Yq3kYahSBSMdqKPPdAy
         YvIThChdUrZgWOPJ1qFbGXzJoRWwLScQ3SobFPRD5Uksu6RTNtzYh+Yf9/XJhx5Zqufq
         Rmi7yJhpwrVdLleJYiowSEolozcD5QoqM2WCDAq0iffrf6YyTwZ9tUi9JJZIbTKarQ8m
         biz5TEfvkf7Ix/DQwqpAbvPDu/g/8lP6Y8AAPyrBbKHvYDtu4IJaMn8nNndiE/rxZxxL
         skoivqr6/SONVDXUxd52q55YxiJrfATVZmF4Ezp6eHbN5HPABaFSSBMyDSHRS5eSi3de
         k4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055569; x=1731660369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzZNl2Yft5zhNJiVn+O2Cxpjbv4+QOcHH/a9sEX7dY=;
        b=pF5+u5QsW4vfXbycjLrk5TCs0ZkwjWjlLoQfRUHlV3PqwJNTKPx3PC8IPE0rhFcIdZ
         QM22sIY29xlPmio8TAfIvccop/9ssn9ni7rPER/Oth2lRtS9QZqy1qXPNW3ynLmxVHSz
         s7JH4awi2SR2Efy+f+fwV0OihbvBz0T1Dk2HNArgohgJhKUAkEE/DUTfbogQyfK0LPjo
         y40I6z25o01N2cxAFC5fJBnnCGlCUQVWKPYcZvILT8AADf4KaN2QdhOUHNzrpnEQSb1t
         iJb0QQ9vzdnT9h6ynQbODfmRLTkRm5eUCB4gNeJgnnwL2LzbkMi2T24NFKmslVGa89xR
         kFZg==
X-Forwarded-Encrypted: i=1; AJvYcCXVk+Q4CJYPX590m9Ju7X5In1k8RhZgJTzAlx6JDtwU7cJdnkOn3PIm5PI0RPE6mt+TayqsoMAt@vger.kernel.org, AJvYcCXY3fobQUUwi+oVYlLD4tfgEyIyRU1vOhdjjZQkTwS/izY2UqXmcWZVtcOGIua9WB7corjXPWUtsgy8YvzS6GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXyLLppuQzjI4hd1m7NfRZjNqLttPzL0b0z4dWfu9UYDAb+6u
	0UjNeAo/WHHbzatSt87kUYr+fkMtB3gAntVzFfrRncf3Icn29fOre2dimxtv3+Ci5uZiPq5UHHB
	sS8fEQkT9uHSAogvnnrU52ID/00pic1dJdSc=
X-Google-Smtp-Source: AGHT+IGXwwX8LIC6sJPKuccOsOiezGZvGqyEhLUfO8Qx0SvcLmNa+H054POH2TlnIN50J2X2evmXa0CMl8NAr6WugM0=
X-Received: by 2002:ac2:4c4d:0:b0:536:55ef:69e8 with SMTP id
 2adb3069b0e04-53d861a2bc2mr1004685e87.0.1731055569260; Fri, 08 Nov 2024
 00:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-8-shaw.leon@gmail.com>
 <20241107080420.6a5a5243@kernel.org> <CAD4GDZwOzLQd+FYd0AHr5AUcANWkf731Jgu6aeyix8EjRGXRag@mail.gmail.com>
In-Reply-To: <CAD4GDZwOzLQd+FYd0AHr5AUcANWkf731Jgu6aeyix8EjRGXRag@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 8 Nov 2024 16:45:32 +0800
Message-ID: <CABAhCOSvo4OemcevEnNmk3Jny_YEoCb3s9GPC6o217oj-t5FnQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for async notification
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:16=E2=80=AFAM Donald Hunter <donald.hunter@gmail.c=
om> wrote:
>
> It's then a question of whether we need the repeat logic in poll_ntf()
> because it's always possible to use check_ntf() in your own repeat
> logic. Either way, I'd prefer not to call the parameter "max_retries"
> because semantically I don't think we are retrying - it is a count of
> how many times to repeat the poll. Thoughts? Should it be a "duration"
> parameter?

Yes, a "duration" is better. The meaning of "retry" or "count" is not clear=
.
The original check_ntf() is good enough for the test case in this
series. Could you make the change, or do you prefer me to submit
another patch?

