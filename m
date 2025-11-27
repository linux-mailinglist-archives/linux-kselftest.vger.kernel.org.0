Return-Path: <linux-kselftest+bounces-46678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C4C9052D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 00:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DEA3AAA43
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 23:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07F3191C3;
	Thu, 27 Nov 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQO2ZFUL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAF27E049
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284833; cv=none; b=pP07lZFLJm3PfwENhsQd9ug4mz8JCF53k01Bk+NCh6yMKc2m0KG31dVfzRV1FOlQCM3IHZDXMB0UG8BmwCxbiM0HYr+xJgjEMMIEKJgdlBKnKdSHkRqbCVyzF6Icz8OZzPo4mX8jiuvYAW9Z8k69ieVBCP+xhe7WSk4ijfJyHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284833; c=relaxed/simple;
	bh=8x486c86cae2O35/f5tnP2l33NWNcPikATHHtWHs6s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RabIvTCqLk/8DUD6gColy8uaTZXgBhllgTdSUdfhg+EjMWUKpCVqJqJDTF51E/1iyjcnzdjIlR7F4Eu6XgWXOxSxkTnSab27rPot1WmtMejVXBIEiZBgXm1M6qzcXVKvQVKlTXiHWHGc2BRtXTBQUFDzZU+S6XRQ5WBWYJybRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQO2ZFUL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1483351b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764284831; x=1764889631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKnH/O6aeuLabuK/xaqPRLLII/aVcAqLAoEUH3ot3QU=;
        b=GQO2ZFULbZSVFf9DcUa10z22lmjdC0mh82Ld/Sg95XKv0ZyNEQXwodW/NWHwRivhdd
         EeXysRHIOO8ju/EOQ0SgBKTNurvSfNZ/SPY8+M3sB+Mz56dgAl30RA2xOzT3vnRk+vXn
         dyMlSNL9w717ltvm8p30sMPBLdIj/+PRL3koaJseWBCG56dJf1t7DE0FUhbgn3fl+9Kf
         FIwXveKuw8roziKt7KikshS8bSUTP5ugDQEezHmfOzykUHoak+iwuJNhBknghaJ+TOj5
         uQFn/QKLQs80VcGnB9TaR9+tRnlvDqQRGw7jSD5aBB8IQUUHl2ZrOyjtoDBHFSWQsjlL
         R5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764284831; x=1764889631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKnH/O6aeuLabuK/xaqPRLLII/aVcAqLAoEUH3ot3QU=;
        b=Tp3j+TXIW1qlsn6ERpnXYKODyg/bowb7Zz8CZVaDw5UALSOf84cSdOK3/15DDm3olC
         9BGpOBxz1zMCjcyh3y/Etf9rpNWc9CXfdt2MWK8CzAikm+LJPM7YsLreZ3krBEHm6ART
         sIDRhsLDZwA0prQCCbCMxpNFzIcILO+3iNxW2J4PFzI4kQW4wOrVBMSNDzhGg5sgdG9O
         lBN4PCXjyXNM9jpOsOjiWgBoNgzKAz7pe+YGokMjY3sNaKFnPTp6VubVDUP3qxHVjHXx
         x/VioVVb4kkosbowruqFMhxfpV6qHEN4pDoXh/fH/xkkyRHnlX+4nyEvX0pfWokHMhi6
         RJWg==
X-Forwarded-Encrypted: i=1; AJvYcCWU5G2AhS1r4Vz2ZEwndU01fLCY3tw4qcnMHvlwOMR8h73eUY7Jzj54fyi2rWG/0PdSxHu5ixCJrXd+Y7srt3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBNREFA9z0ucqioqhGtBppdwnZPG3C2T5dmyaK2dcr8Lnljk3
	37JyEgBUziSfQesbDBenrf6t7wvyUYi6jYQatW5Zf0KdsWNHSoStLqCR
X-Gm-Gg: ASbGncvu/pKuk67kBuEYtFcp5ciML47l2M76NrU6pfbWGK70YnKkd58YzPMUvgQ8T54
	RKSPGvxstPfAt9ieTzzRmSUa1V6o3IRo52y3NL+trz6mkv2biT9NMW1BEZdb9ov9Z1wjCAeToZ0
	SoiyYrMtZAM7XEHfBmsEordFLC/OSxIIOmcHWzBP5sXe1PdDmBTCjjPWQfb9TgB4LRu46tF2C+a
	YhKGVlzP7oHrY6tau3nx6gPrkBeuuvyc7MXkTIvTLt9ih4hLlzr/HRM+5raFRQGJvByhotQxg6l
	mi1CJu9Q5QrJ5HBC7bF/M7eFng12NUmQoYCx3sDlPILfavNJx18N1xZMwTvkZIucTK/sJexBAnL
	lziBM+ilSMadib0e5MW2xS+kxSebyr6uS2l9nH2WFnHszMHVx+WycxXgiYbR2ehy2+sUVV2wS/i
	HccNCJfe/t0+SQDxbfiTuX
X-Google-Smtp-Source: AGHT+IG6MZgRCqL3UfX6DVxG1TmGMoJ5MDpYjWvx0pC2uBQPQIC2ocWSFSAf02GnYqHCF1kMNktFsA==
X-Received: by 2002:a05:7022:6729:b0:11b:9386:8263 with SMTP id a92af1059eb24-11c9d872430mr18306094c88.48.1764284831144;
        Thu, 27 Nov 2025 15:07:11 -0800 (PST)
Received: from archlinux ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm11559761c88.6.2025.11.27.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 15:07:10 -0800 (PST)
Date: Thu, 27 Nov 2025 23:07:02 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/5] netconsole: support automatic target
 recovery
Message-ID: <v44skio47zulg6jok5wq7w2ylw4abk7dxtjarlgnuz7hukvbts@7clzpd7cqc5u>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
 <20251126173646.696537af@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126173646.696537af@kernel.org>

Hi Jakub!

On Wed, Nov 26, 2025 at 05:36:46PM -0800, Jakub Kicinski wrote:
> Netpoll does not seem to handle DOWN events, so I'm guessing your
> primary use case is that the device had a HW fault and netdev was
> recreated after device reset?

Correct, this is the intended use case for this series. Handling cases where
the device was unregistered and then brought back up.

> Should we not be listening for the REGISTER event then? On boot
> we force UP the device if we find it, theoretically there may
> be a case where user space is not configured to UP the device,
> and then we'd never resume the target?

This is indeed a limitation on the current implementation. Based on
your feedback, I'm working on a new version of this series handling REGISTER
instead of UP and ensuring we force UP the device.
This will make it consistent with the boot behavior you described.

Based on my tests, I can't force the device UP while handling the REGISTER event.
I believe this is due to dev_open attempting to lock the device which is already held.
For this reason, I'm resorting to defering this to a workqueue, similar to my approach 
on v1 [1] (but correctly handling target_list lock).

Let me know if this approach makes sense or if I'm missing something.

Thanks for the review!

[1] https://lore.kernel.org/all/20250909-netcons-retrigger-v1-4-3aea904926cf@gmail.com
-- 
Andre Carvalho

