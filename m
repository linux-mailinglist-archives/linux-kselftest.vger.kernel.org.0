Return-Path: <linux-kselftest+bounces-29220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F144FA6513E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CFD16C0F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F023ED5F;
	Mon, 17 Mar 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="YjD0FjxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB41459F7
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218412; cv=none; b=LYHv0qt3Vt7BlJ9H/7btitcePbCI8UqTVLn3bk0ceac8NnbaE25IDST7JhOz+ikus6eoJluRg0vKSZJF73M+9PHUh2HFI74VHol6OpUY8YGOhaAPF/pteATKfcDx5RsYVKYnne4ELai0GbEEktLbMgsenDwq46Ekuj+m5a/S2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218412; c=relaxed/simple;
	bh=0FfSVCwWFYs03W9C6UYAiRgXVZq0hT3xfZFMsdgITK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3FP7mbt3GBmXr+pl3VvE2DgXb7i6w8oRQvsPEIsxbuc1Sxd9dr4vcAivLttC0WHn9VDjWXhY6lr7VA4Xk0kIiztUFdu119bXQKHw5ro2JFhVucBOak+PEUzGSfl1MNfVyJWe/1VdFAYRKYvvi2/TL3IDI0VrOSw2g8LpyFEuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=YjD0FjxP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fb0f619dso69395895ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742218409; x=1742823209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEfXjYWxniGhm4SvOUYnmezX7yQMhTQIadMZnGdIOxY=;
        b=YjD0FjxP/RN4CDHKyuG/eTr5xwOkGAVZhoEBF+DJfR9PYfi5l/IxjYgRwZYzGYtbIb
         QavP0XORbihWPbV9+ByBvNIU6TO+ry8tkwYKlmcZyCP0S6Y8tuqpOVtMlFiLCzggI0Yx
         8Xz5ujW4GAGwzN+4me0e8peuqBotq35uSzSt9P0Pt3TmeY92RjwUIk3Yh6hCR9K6nDd4
         F4oOiu+aaNjigGQ6isv6LbIcxYiUt9KjoNQ8Uy+B6kaJDsq3XUf0cu7eyyjNYxZCI1hz
         6kO+zEphEf0gmBGQoQjGhsmkPHd/KWis7ccOfSgU+b2nBHpZL4xRLNZrxz2r3QY4q3RA
         r4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218409; x=1742823209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEfXjYWxniGhm4SvOUYnmezX7yQMhTQIadMZnGdIOxY=;
        b=gsPdF+yIIJuFBTDTbkg/WSJ5uz1oV1MPXVfDElwkAxZ14E+FhaB8JwgG3Y+bML9z63
         wMhDHcY0/ENWCMvQZ0TUi6sz2RKqa7FcYnMsVwYVqw2EB91KZIJ5r3yzXbcwmui+vi+i
         145Th60ZlGXaLTn0+FMbTrsOWgUcurWeZDjIilI/a1BE8LDQhQCoSWv7ysF9AumRaWls
         LBf6JarHta5FsoM/Ygf57iPUeFDDg+V2dZIum5K/VxVkDIE3HycOsfU380/fwLXwa/N0
         /AoEpG/fJOMkAEY3H6kQmnTpYWfk7Bs+SKW/YC5nZWdjPeYhOZ++ZwolSdX5FEovqlZ/
         KYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrVFgK7bOGx/yLnXcaPviAjOmeHtJcNMg5v8BpXDnHaGNnRtKcXBIDAXwK6tx0aAY2cCqqfC3NQI8ArG1nJFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1a5QHInKwQkObIBlwDTr0YWOB5yx6oNb7G4UiR7DNriB02hm
	KLqInEI1LOjO29ba3aOk0K7VwbcjsZYE19rLXuvDk9OBWy04uuF65oQ0lJrl1nI=
X-Gm-Gg: ASbGnct9i38u4/05zmwZYOmEYzXdQLvT2guLQTApLJU5Cw7uvNXfrVCfVaGR/i8st/t
	nAiQbV94cCuS01+05wjy6WdJgSpWw6iBqwOgX/IIsdszzunbQ0cXlKzJTM+hIolKt0uPvtzolAi
	XH52oTU4iBUo63R5BFJNrhDPv+W20prdtD/EVcxJdQksln7vIh7xnTc6mmwNie6vwoaoNnhsTIc
	FAPX99oTrmKiFGQnnCoYY2EX0daFAPuhLPACqRuSUomPIK3x5F9eRHxbJ9kBkMkv+UuW6iFRpZu
	gSrcb9+fOxrJghaNI8WENY68nLZY/DMJnSM8eUXFOTUniNgzpHUeZEgBaBeyOz2Hn3saXRwKmlA
	QsNfTlI1HPMBU+Ky9Xx+TbA==
X-Google-Smtp-Source: AGHT+IEmHbDYwAg4QRu3FCwOs605OWoP1Ex4sUzPy3ceNmpxuehNv0T9Y/bmDYd3OaHPBAiQ+SqmxA==
X-Received: by 2002:a17:903:251:b0:224:24d3:60f4 with SMTP id d9443c01a7336-225e0a58081mr142708615ad.15.1742218409506;
        Mon, 17 Mar 2025 06:33:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e17fsm7732985b3a.104.2025.03.17.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:33:29 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:33:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20250317063326.42e3e550@hermes.local>
In-Reply-To: <20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 16:39:17 +0100
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int get_packets(uint32_t *val, const char *arg)
> +{
> +	unsigned long res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtoul(arg, &ptr, 10);
> +	if (!ptr || ptr == arg ||
> +	    (strcmp(ptr, "p") && strcmp(ptr, "pkt") && strcmp(ptr, "pkts") &&
> +	     strcmp(ptr, "packet") && strcmp(ptr, "packets")))
> +		return -1;

No shortcuts please.
We ran into this with matches() and arg conflicts already.

