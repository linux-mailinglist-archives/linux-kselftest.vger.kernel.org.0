Return-Path: <linux-kselftest+bounces-47968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57123CDEDDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 18:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005B430056F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Dec 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD0246798;
	Fri, 26 Dec 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Nqo4D4t2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24A1917F0
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766771565; cv=none; b=O7Fb89g+vE76arKTmEgvp0Yk1FO3GiFxTb61cXdgIZoJx5kWUoFS6i01wKeAcORcUyNAZtXFBywQsGIKoJ7v9yTTWjaG7D9SoE1X3/wNzxeS/Hok+yMvZSZY59n/5BEcbt6gJVlm1fDBcJjJr/Cap2b/X1ay1SqX4ep6+QJcuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766771565; c=relaxed/simple;
	bh=J7yAO4lFXm6K+rXFTcP/uAXwqHL11KjIbvKMYMwMxn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxXXz3zfSSOZ7PlrpePqrmDJYeJbDFZCzo9BRWQKlTQL9nCfyZUX1m7j7mcJ3bjt6BMJ0KIg09AqIGdHZDcAFd3l5xU3wOAKVQoZzu7LvV0fwhGtzyJ6PI5uFNi/abTY2tq50WpdDPgFvOm0n5AmD3xGUc/Yt+hrlcYAJs2lhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Nqo4D4t2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso7994167a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Dec 2025 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766771562; x=1767376362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mdj5zNgj5bjD1gSpn1iNNZ/jecnQOp8FiE5wDqLIxEs=;
        b=Nqo4D4t2yPCHn6Ymqa9/uNooc/I5WP44c15HUjIhUiArl1LXIxQvr1BoFlxD7o9kp7
         xNOrBdffhEoQW42JqAWVX3p+9qOqeTMF4rrRFu81WbojhGKl1aSUH0zX/LG1IRcNWaNw
         D4i7kSyxCIYwhKCLb34gJbQ3n4naglihjj/t/hozWY+/V96NoDccE2RdaG8jNpqucfbP
         zwgHl1WbhU3eA+pMiZuJxaSwzh2Q/6q+VRspM3Omrf2OZiTCM1aPqOIzItn3GBZdAbpF
         kbfshu6sHWi2iMj15HfByTrFd3B2KfghIl4VEP04YFMIAowj6AUHLuGtzDjRuYieTO/6
         LoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766771562; x=1767376362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mdj5zNgj5bjD1gSpn1iNNZ/jecnQOp8FiE5wDqLIxEs=;
        b=KYGDWwwvUS7uXNdLJ6Bav/lVw4JQGMsVHi6GYLv8VhcpsMQBSdmlZIPTl9BDqWoUoO
         pb/HlUxIGd3YlU5UPcyMB2Wt9neDdtuRK+cqTMOKmdnUOZnu9fv8k+mwiSDpPUys4zbo
         7L3wTTgqGuuWWiDugObRJ6sTm6Bllc2MXLBotnK/Y1gtQ9R5LoXf07owqpogqRqDXuNe
         kKbRJXIpWQp22WxSAwZne5h9c0x2TgaBDpgEhkjTLAU//Pht47ZgZXiXu1opiRx53yXC
         sYEoAtX3dfPRUaxFzNQiEhmtjIRopE8lJK36FCMzxDD8yUw9fgg8M1moPloQrhPTkMdO
         Gl3w==
X-Forwarded-Encrypted: i=1; AJvYcCUpr0T/N6+5DRQY+gXieF6Rx2RmtqAkeP+ouAf7Bz0BfYxntupwMA75Xg/oPUYiAd2taK59siDF69fLx2NyfjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5HXNM+4VF3uL6RlENg2dr64cb8HuwFr6Lo3rd4Pr7ug7RmfZ
	DEqSz97NGZkha3nZXBGHkMCqqjv82E0dubw5izBrP4BgOAjsv9dxu7086+ndCnjnSMQ=
X-Gm-Gg: AY/fxX6Bf1WI50RqJLaJ/sYK8LMZLUisQ44kkrYZ03seKnvY/XtAvwXvqP47tqtmvuS
	EKC6dFz3F1+gvgzfitjmWEe9AiAjK7KQTQs4VRKd7msz41FyG/spN+T2K7Y/8u3hyNePROtMtjN
	8QbnKFyZLnpXzdwVOcTF/yngWuvTmNRsAIdXO4+2/L8PM1BDSpmPaSXmoI+HZ3yloW0dDGniCqx
	wFVOMFMDg5YKeJaKpGanKwBbCUjVoPgusoJjIWdXI/+4L2ASjlFSpqsFeDBm7ht4nqGG5++lGDM
	R74VkNfJe2OqxvFncTdP9Bkopmultrrb+ZM/omdC1PEPpye9UvRkX6kfZ4ki8rwHr7aXEusrl3l
	+1iNFFZler9dqYpi56se9Msoy74Yz7kB+wCX/Sxmy14t/pvu8EX7u415GFQV4PKiU9SE6MYo+5s
	kT3+4xBKmXjFOzCYDkNG48LeHWOCM7kbD3D7necSsbgMmmpfPlrq/V
X-Google-Smtp-Source: AGHT+IH/n4TYPHu4FypFJ2XvHhAplETATqLQQDyjaZRds0v5zrYYx+SkSlb3Kb/t1PUX6M4JlkgoWA==
X-Received: by 2002:a05:6402:35c8:b0:64d:2889:cf50 with SMTP id 4fb4d7f45d1cf-64d2889d1e4mr16238859a12.23.1766771562389;
        Fri, 26 Dec 2025 09:52:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64de4798077sm9279546a12.7.2025.12.26.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 09:52:42 -0800 (PST)
Date: Fri, 26 Dec 2025 09:52:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitry Skorodumov <dskr99@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Dmitry
 Skorodumov <skorodumov.dmitry@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net 2/2] selftests: net: simple selftest for ipvtap
Message-ID: <20251226095235.219f3017@phoenix.local>
In-Reply-To: <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
	<20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Dec 2025 21:55:34 +0300
Dmitry Skorodumov <dskr99@gmail.com> wrote:

> +test_ip_set() {
> +	RET=0
> +
> +	modprobe -q tap
> +	modprobe -q ipvlan
> +	modprobe -q ipvtap
> +

Did you know that kernel will auto load the module when device is created
so in most cases modprobe is not needed.

