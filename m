Return-Path: <linux-kselftest+bounces-37877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF301B0F476
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B732176954
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068A2E7F06;
	Wed, 23 Jul 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO9Ngr4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D4286D53;
	Wed, 23 Jul 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278571; cv=none; b=ndXpeWv0R3TDl7NQrIwtH1z2cdYViBTJZ31Hkyvi4L4u6FxyGyaPHpSGokqLT/FHHs4IdUs7RtL+RO0n79bNX4vmxVBlfE/IiLqN+Twhrts4ZffY8+Vrjsi2ynMjhmwCHE8F1ItEIGsxV3kWRZIbAvme3d9aXEZWQnqRSybwgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278571; c=relaxed/simple;
	bh=JoDy7FfTu5QQZxsmlGCHwMmuOCveJWFmXjgaMY+XgrA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hw9X9j0E0OckQ0qssa2KXaM8OLfNmxk+9FpaFAynNI1DWJrUaqvlDRzqyuV3d3QYwUBPCv416GE6WXm0NGxVfq9aYXJNqreI9ajqcJeUSLP6qwg7DsS4R5u1cSFl2UffsbwoGZKlvTcRh/RiLnU49QKjmX0sbEjQcojDTRiUJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO9Ngr4U; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso1135255276.1;
        Wed, 23 Jul 2025 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753278569; x=1753883369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuCl1xIHuMkalNyYAAcG7/35zrIQQKnvBH3pF153sRk=;
        b=nO9Ngr4UftlkMTxA4CI6l2+ULz31n2CxABH3raqLZjq0ATSb0WsJWFB9ptdyk1/oS7
         jSw1GGkF46UVCeBtKL9a7bt7dMI7xC3SRRMrwmt1GFWgFaATxrC4nNi3exNEgIuKYKPl
         RF1psQL/Vkg7w3G8XdkV619bsN+J4MHGjfPmuqu0kVQq7c19lMq8N+GElBm3u/VlVi4V
         m/g0+I8YtamzF7kyIGT+mos0ml2viR3HEOJ2FXjV5Nex5Rxxq17gs5yMyNHKUu72je7p
         FyHfwB+O76ajflHoGxnqKfUXo2gaHVGmxJ7OAR55aby4eIum5q+aqb/cf2qr0tm9vFGg
         eM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278569; x=1753883369;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FuCl1xIHuMkalNyYAAcG7/35zrIQQKnvBH3pF153sRk=;
        b=KgL56UTJZwNrZSHgLXn9smgbP4sb6q82TAzEzkagmqYGEKedFHhoZF4HSYaI97oW5z
         jNVR+k++KvNagIRsOILdE+8+mv6T1BZYpO0doBwRhwQaWPUnWlQ7N+QpeKzmyXTFg0Ug
         oOGBXYzSmtMdG+nSsG2ZJJsecwshFa++ibu3ZJ/Jl4XDOjqIMrJCW0p5LVT0CvKCurTl
         UZjRbonoAyWerkEpJAVyoLjHBS5AkDgk+IIqUFEqcfNrRvKPcVSkN0jRSwrMpt3N0kC2
         TwL8Wn0zogWFt30HR3k7U8/PuFuO7LdawfNmdFuYlerFJ42cVSXdDLw7CmW/UqA8or1B
         cZGg==
X-Forwarded-Encrypted: i=1; AJvYcCUmxDRMRXr2QOV2us8GmVvh0TkiTHWpf19W9363jMvOpa2sxgV3zXi9iHYn5BU5WdfitLCFqVIZcPsx7ashkJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTwwlmVDMK1DQWU0R8+vXF/QMXAk2jgD42aCvnp0Ji/L9cqFEd
	x+ajdzC0q/pD7vmb10M3VC3IFUynU7zLbkbw+jLITcmNB81y0Ng1q2Xp
X-Gm-Gg: ASbGnctMUGEa2DFTMv5N98XgX1GLVssO1f7lhK6fW4uNIOQiX7Uky3Tu+sAjSv7Fhf6
	8HK5jROstvWkIz/IY3/7EMBQA7VlQupbRhmg6/gmQ79EZOHdxY7Pv/QT/pyPnUaiaF0/l+kjjs0
	7jPpta328BXpPD4ZYuKHP/JC9OGRP0dqRmRII0UckKOySPd4AiQGnEvhkX4YiDHkUU5pME8JufD
	HvaA7PlDlVlfVcrn5oqMZteCbl8MnxOoqyof+UHXTzttIJm8alNxc/K5tYkmahVEucLKWWtwlpr
	Seg57vPB/h4MHm1U+0979HLv3YDC3zgAf2WUV1S6qB58+LIyJ0bng+FlpvqpWvLSOHxjB+MY0lb
	gYtXeBf03QP/3zS+NY2LWOMEav7zoOteLgZ1d7hONvBgBG/dBeEMCyDsNqHMobhnsskDgxQ==
X-Google-Smtp-Source: AGHT+IFikcDxVY8RMqjf/7PoRbRzfp4/Se0YkLnDQwL6itn0XK6hcI/45uzBuDfoJcI/azhpUIqiQw==
X-Received: by 2002:a05:6902:1141:b0:e8b:c3f4:d3 with SMTP id 3f1490d57ef6-e8db6dc7df7mr8212986276.11.1753278568509;
        Wed, 23 Jul 2025 06:49:28 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7ce0e246sm3949677276.28.2025.07.23.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:49:27 -0700 (PDT)
Date: Wed, 23 Jul 2025 09:49:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 gal@nvidia.com, 
 andrew@lunn.ch, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <6880e8674626d_334c6729439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250722014915.3365370-5-kuba@kernel.org>
References: <20250722014915.3365370-1-kuba@kernel.org>
 <20250722014915.3365370-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: add test for RSS on
 flow label
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
> Add a simple test for checking that RSS on flow label works,
> and that its rejected for IPv4 flows.
> 
>  # ./tools/testing/selftests/drivers/net/hw/rss_flow_label.py
>  TAP version 13
>  1..2
>  ok 1 rss_flow_label.test_rss_flow_label
>  ok 2 rss_flow_label.test_rss_flow_label_6only
>  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

RFS/RPS could mess with the SO_INCOMING_CPU reports if enabled.
Maybe check cfg.ifname rx-0 that they are disabled?

