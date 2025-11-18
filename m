Return-Path: <linux-kselftest+bounces-45825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB310C66F88
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BD2BA29349
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 02:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9903319864;
	Tue, 18 Nov 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmxqFwwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E82BE646
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431766; cv=none; b=RyIYsFxhkIXXwCaxE9qoq/cOlc9sjCkmsJ7IbHt6bFrkmOICDNYjVXxrVE1plKYPY2KswYisMIoEgIHd3HqbiDj3+C3D50hhLRjGpv+9W2c1V4SGXlxg/WJpe+c7ZytLzb4BbU8kUs6WCWeP0QqgrqlKy7MTdeqky5nI6smiaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431766; c=relaxed/simple;
	bh=hFh8IINo3mUa/2K398UVvXRC4w4QfBZgpD1aFDHyvkw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a4nyr+/TI/2Ly/hhMIy1O37ZZqCAFCzPUQ7v4FQ8v//hvIVrBi1O7Pp574SY2hG1sKaNv1CrlH6QJckOGrUHehYD7Y7rZj+bOv8ua9XKk1KyeFkgGnBWZ2j1m2RdBde82PfZ5xqKjh66NAeKyDRa43xrgpyPnJoK9+0Q37NXO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmxqFwwx; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640c857ce02so4690409d50.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Nov 2025 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431759; x=1764036559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThW0CBgJk5lLQ55qGD6pmrtIV6ecDbrMPNoiNkJoTnk=;
        b=QmxqFwwxQw5b9aFxWZleSTH1CqJKpGovyqqcoNes+5EVzx/X7AKE9wMMQjeb62VF7b
         d2mixOkywjwCDX2kCVpGMJiDVeem32H+5owUC7KpBxzAi8A0smFOL4Or6ErxExle2isi
         u7cNL9at/KPRBoQPCmGl36DAvp9OTss3X7WYiJx71fHSuoCL3YhACya9vzdJxQ1RZanZ
         wETX1f1iiKCBhMzepQklk6DSIHYwxS9Ct2CLKFZzKp9P9teukusU8oQiDJj/5ZAxkf3c
         pNTd6lPtUvra855MKP9iUFAwLT5nDskdrFNlugA5Tf8LJCCtH1m6wAdNE8JHmHJJOKkh
         NaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431759; x=1764036559;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThW0CBgJk5lLQ55qGD6pmrtIV6ecDbrMPNoiNkJoTnk=;
        b=wceWf1kINzALQd23UQyr+UkLjYm4yI0Fl059uY34u1X0zBbGNtEs8NIqZLrbESa4Di
         nSHaNyIFyLERJuWbiTuUEQvL7XIREQ/zSG9hicA13LZehAN1pfcAseEEB0CLL8AHuLdW
         uFCLlMHLF9JPUdvhDUqvNzuG9bOkRyH6++tq72yZbZyIPkQotWoOtQJ3270+4U3DLRi0
         jNQdcad+c6tV3ESup6CwvX8Sgr2cy9x+defAQ1mVYlOg+aWpWyODd9xCz7tkuNVITRr4
         bOlO7YvEkbPTEgrQi8lgPhwr3CaJECARae3C24PmVJX0Hv6onWK0btwHkbsJ7U4NAJQW
         yDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqWUgqHWarvkf1SvM5d5t7c0CaIeWdTpPqKV54+WRhAmA5RAuOPT/XBpi188X+CIO9Lu+WmZBrGUWouumvINw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAilCiO2l00u/LzhfYNUmslyrvBRmnJ3owwvqd4dmQH1vHYCbu
	AijJly9h0aY4r2pcjyarMixD+MaL1ebJo0LTlo2WR6AeyYsauCV4T2Bi
X-Gm-Gg: ASbGncvLtryN4pgR2j8ZEWINe6BjT4w5ZLVISIgMMdunqByUcVImxuZmM4nlrSoYyKW
	Dew/TntEH5GYC08lHWsMSkiwRuY0LrHjWI6xA3OW3ct3sTBxMHSoPS8ykPzUgpR9LrfDCuX/3z/
	9x+Lv7jjQWcV/zRDzWcS5sbVRmgwbC/BS5FPaPjxmwvKpnL65LkWkWXKWeG3Xnm7n+5lw1LLlGL
	07sVUqTbE5s7H1ldYOM/HV5+qoIEzazX/bCJq2bBOrYFjq+HOhKBr9VNRI+poTw1G/JWIFMZ9b3
	oAxHCjX7U8RtaRTfWZN+U2sIiKhVOWx2OWX1EW4eSf4CI8btcrN0Z5PhF7ChFcqfYVlOwXHT1kP
	UFeJ6GlvKUoa5MFxDHoCU2oiRaimsiZmGafDx/o0iUm+mvxLQO6HBQdsAJ9/RnJ1p3AHTrtid/l
	30vXkVF6df+7sUf5YEYBzGDmPku8QnjJa7K5pUI/Q7iZ5/FSvaGXHgvCbiMrvQ636CZw4=
X-Google-Smtp-Source: AGHT+IHfibol9fYGEa1/DESKLJigWrM8g4dH8AUVNSRxxkHSj0Q2TihB4TwZuCX+TUfEL8qqXX5qhw==
X-Received: by 2002:a53:c04c:0:20b0:63f:6cae:8587 with SMTP id 956f58d0204a3-641e7655a40mr9595392d50.37.1763431758912;
        Mon, 17 Nov 2025 18:09:18 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78822125317sm47628447b3.37.2025.11.17.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:09:18 -0800 (PST)
Date: Mon, 17 Nov 2025 21:09:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.3ab6e98979752@gmail.com>
In-Reply-To: <20251117205810.1617533-11-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
 <20251117205810.1617533-11-kuba@kernel.org>
Subject: Re: [PATCH net-next 10/12] selftests: drv-net: hw: convert the
 Toeplitz test to Python
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
> Rewrite the existing toeplitz.sh test in Python. The conversion
> is a lot less exact than the GRO one. We use Netlink APIs to
> get the device RSS and IRQ information. We expect that the device
> has neither RPS nor RFS configure, and set RPS up as part of

configure -> configured

> the test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

