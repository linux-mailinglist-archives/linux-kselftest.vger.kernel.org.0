Return-Path: <linux-kselftest+bounces-48682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1695D0F7E0
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B110C30092A8
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091433D6E1;
	Sun, 11 Jan 2026 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm+3H9Nh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C934199EAD
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151290; cv=none; b=O2lNQhrdDOoNGlC7TjUyiuAfUBJvstyY1kakq4iTzBYBR7Mk3GhROviHR+9UD1g6KJ+ZzBe2cWVh/6SuXInWoV88QrX6aOX9qd2El6KKGQqn0RGtmRCWFLaKrjVF9epZF0TlMTJvtZWxswBFNy3W8KFmya28O4Z30Fq14KxcpnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151290; c=relaxed/simple;
	bh=vfB7wwQOv6IVE0ly9jv3QpWGznBV/7h+jvxKooUUs3g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RujR5a9CFaNiZlM8mywXQvftTeswrdKwcWMiY8UNXBvHwN6Bon3wRyrNMgDdluNtRE6ZGXUdrtP2yx1+gxt9VlwberxyA+u3N8IINQg0W5O58clmb9Jq5o6lqas3MHBNsBgB29G8eEjCt8EdbmpckvEhEh8XE578HBL3cSi46mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm+3H9Nh; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-646b8d2431dso4831511d50.2
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Jan 2026 09:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151288; x=1768756088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14CUfSTshsPYBnbMn2scYI68w2LgxYFZBM4RNYY08ec=;
        b=lm+3H9NhgRLrRqFi5x2oKa7VCrv8kdWmT5c5UU9MeehHnWU4sXcY9sqPT/lGcxh5xq
         P6TsX7yxohHArEtaS0TvGGvor3F0NtVZMvikgz+o+NLbkj+yVfhC68jD50ahR5B0VaSE
         NkevdvQKvRmL8WojBgNBktGahCKlXXVBVtFXRyxMwoi03pKQKHgt/IrK7AZTFnYafcJK
         zxRvm3eOUetSNgQ1v7i+P3j9pcIvI7jmSNxM0zcxRfx0dfvynx+b9gDkYDts4tv1haQp
         YdjaTxdTDcGbwuLvF5PqZTJp8r/uMO3kVg0CrRKqR0DFhjqwpNZTUmZWIW72KLODXA+e
         SYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151288; x=1768756088;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14CUfSTshsPYBnbMn2scYI68w2LgxYFZBM4RNYY08ec=;
        b=Xe89eP7zwAwZDGTuzGKhilqDbfE/89+wnn/XfV3IYBDnpgaPtwdgRgCG1T3xtFApmL
         LES85eIhgdhLick382B4Z8tSfj92Y1ye5PJjM6HgWSLPGHIWuFyXh5g2SzihW0UcoEJP
         YNJyyPu2MSL97/LwEOQsxzA7yaR201MOKv5L5wNZrQCy2IkkfXeBkVHOig767W4mJGKw
         l6zevwUWBs6Eka1XAIR4za6rGeifHfQ0nzxfU51Uogir8yUNgPNxdJxhl0TTZbbXkuZG
         VLcoGSk+WeX8zsRymhPmjG2+dq4ms9OOYyuABuefvlBS6fire7VR7rIhJNKPX5wzHCuv
         nNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDe0rLIHmYckabgxSlKWXR+Cfjz5bp9a/uZ9upNMP2WWRDPU3+uFzjibv6W3r3ZerruDsJcmXUJZKcjuvRFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RO7x2JMNB/b89GCD/eAGd9na1VzKNI/Dp3cXtONzsNP/2rCv
	KsLaY+BlIzaf/h0S+rQYM9UwfpV7fPOHRnum3YoUvAVghZH3dxjb/Fgg
X-Gm-Gg: AY/fxX5XiLT6QnlOoSrgaQcX1aH6n/vfzSDeR16KdD/yPeJgO4PjtG9EwBfSICcrx6E
	n/CZGgLV579L1a2tEwKfpZYMlqfycaVMAbyBYxjel1WfRrUFiBM9GVh2CyS8j11zYe9H2KJIy8A
	AXhi4YeNdhyPMMfYt+S14zHg++Zt3xABch8nEz39zbNBLVjXbiN3xSZnidckMVzWtbWiHF5oNy+
	dAdhlLcss64R/0MB/JPJVA9osyxXE0NToMPh2dTqGp++h6Z3wh/cdvAQL5SlvYizyob4qOPMVY1
	IBmdvx1hMUU7Ll/xmmpNSY8yvfPmVFVkDthE7OpkXwbXjhHrKklTX1mU0tuB02S9LE0xqvVdHWe
	n5OKuJw032PoEKpyWyD0wZvgqIVp0cNiYbNjU4wpnN5YlUM/w0fbaWzmEtlOo1omhsvs/fvzUv3
	TRoIfpLn3DVkjujsm3Q/0GZBqbjp6YRWDnKuxY57cSUsNlbRXO1AlOhW8aIqI=
X-Google-Smtp-Source: AGHT+IGv5P2YMNezQssDg4306hlzj+3yVIXMSWoalTwJ8MWNhRun/Bs/YEi8ZMBC8Tv2gECQCDzvHA==
X-Received: by 2002:a05:690e:4004:b0:643:1a5f:aaec with SMTP id 956f58d0204a3-64716c5fd63mr12458018d50.47.1768151288211;
        Sun, 11 Jan 2026 09:08:08 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d80d2c2sm7093598d50.8.2026.01.11.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:08:06 -0800 (PST)
Date: Sun, 11 Jan 2026 12:08:06 -0500
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
Message-ID: <willemdebruijn.kernel.fb5103cf5a5d@gmail.com>
In-Reply-To: <20260110005121.3561437-5-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 4/6] selftests: drv-net: gro: improve feature
 config
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
> We'll need to do a lot more feature handling to test HW-GRO and LRO.
> Clean up the feature handling for SW GRO a bit to let the next commit
> focus on the new test cases, only.
> 
> Make sure HW GRO-like features are not enabled for the SW tests.
> Be more careful about changing features as "nothing changed"
> situations may result in non-zero error code from ethtool.
> 
> Don't disable TSO on the local interface (receiver) when running over
> netdevsim, we just want GSO to break up the segments on the sender.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

With the s/tso/tcp-segmentation-offload change

Reviewed-by: Willem de Bruijn <willemb@google.com>

