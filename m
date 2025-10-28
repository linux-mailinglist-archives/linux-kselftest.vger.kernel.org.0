Return-Path: <linux-kselftest+bounces-44206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57912C16448
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898533BE8D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525C34B1B7;
	Tue, 28 Oct 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mev9YXuM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D83C1F
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673329; cv=none; b=tkIw76FPaqdrWkhrNuwYRLKK2Pv4upfKPMOds5bGcQIZOk7/WqE+BHsNqVgoiUT0wSqUcHal8dzYFBqGKf0f6UHF5dJ13rwODqUk8iralp0GrSl8EyvFbP1CJX5ur6iW/4Q55G/NqQHGcEXWeMybZUKJZ5pPzdIJZBBkaLxmcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673329; c=relaxed/simple;
	bh=Im6VzXUuwdDDmZDQbOVnf4aGedh78bR8cSlODEcvMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLpRte6dPkdR9RU1z3he4gQQVA7GCjI9n33D5esOFo1GhDIvl2irWF1IYlpllX+cGQc/9XUumh1n8kpE2dN5sdROi1dV+6shrALmrcKMnS6MeGmncy7Nf1iD9hb+GCdzDjTf5zdb1re5tIEZec0iVIee1FpnJIjAfHhVvg7AA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mev9YXuM; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so3677744b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673326; x=1762278126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=mev9YXuMu+qGoKD5lO6M3V82corZbeb3NZfCrDXaH1LDRt4woQP5QwrwwbJkiMJfCq
         1twF+S2v6rhmhlOlGUwYLeGnaEM2/BgKcd3SNbx4fldJXXGfeRm3D2+pT7ZQkpVCQ1j5
         5oYGP1mEviDdX2A/lX6Al9kcOZFJriJIOIpG2hNpSuq0J/+TznBAG48X+99zpOPP4Nch
         4qTwLOqDvGsYmwmuLLlTNpLrg7hOyCh4ix1Xb6MojWH+dzoW2g3tZtbdmSKYBl2OoJsG
         yzjYTY+X9uvCpszPm5kUECSy29R0ARE52nN0Yy/IAbi2ho8QoP5bR5F49wrYMmZBoXJP
         6Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673326; x=1762278126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=TlUHqxiFbM1hYs0fBAsfocw60xJeu7kxF4IX/66QtpLZ57lqwfBGplyDDWmZAy6keI
         wIPtEHaCOFCA4tH9BoeYCuhxOC6i88yID9vz/2oGT36FKMUmaELCX+Rm0lAl4g67Ss54
         6q9LkegzCnYJNPgPudtaW7nM/2ThqQ4Z90PI0DI10GzBYRuCg/4w4a8U4qdutP8h+oUP
         3jzrBslvBcLVnRn6CkgUIL54Yv4hGqhbQCWy7RIWK9lhE58cVuBve+62FQa77rk2jFfr
         hAf0HENHm6dpXR5hIJ19HLqaUGIW7AP0hgbVSLOml9f56b40Wcv3y4IvUyp6LubzMTSI
         22tA==
X-Forwarded-Encrypted: i=1; AJvYcCXNddELJ3maekk+E6sw3eF/6FCEpj+Y5abH7DLfpC3pWUzo4qI30CmSmvRACdmWqxI8vtJdJ1NEc0rN5kpaZOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqclbzK5bMjh6WoWqoLu65EdoFkK6IPlIH5Wmq6Mj422INZjP/
	u5RR+I7SopSf0l4Z7p5BPjRTqj1r6GGgDLMORTo2UlSsaNXQZ5PAtdfN
X-Gm-Gg: ASbGncvAeykaI/GHJwq1/u6nwPc+jvu1K8jSY3mlM4f4HCAt2IqesFv9j7C+OJAnRwF
	3bQt67qNxwsUUs+b6CxqwEt24dWQ/wO44LWM45ArbRSqitoa1mN4W0uVTQCPkOuV9vCGKQEqAtx
	jRpt52A7KAtcbdtijibxV/j965y8WtrR/T22Suru/mx+n21GQ0O4MHOaZNMFh3mSQXEluzIqmpK
	nxzpkydGCfojJEg9NA7ZceWtsNkLXvaWZhbUIOokCMlzYZl+mAiV8BWV4R3dbpi5kV3nAe/p+fc
	3uVCTF46u0LyDM3c/zAVPkFkjEfJdm976LSuRxOtwOh+dmC4wA7G7jmKY+CeGTsa0LPef/b0I6t
	CbJvo42V6GGWVyvhlYTWedIeOlwN8aARmdwp8HC/hmkNOAA6AxETNxiATFVbVX6iz725lqOGvvE
	Tk7R5Z4ROi1JyLL0VFqrQ=
X-Google-Smtp-Source: AGHT+IHY648HfWpg/1mCsYtX8S4x0CTFltDo3CpRCwoMSOqHKLBzLVsRp/I93hYx56RK6MNiNgUYAA==
X-Received: by 2002:a05:6a20:2588:b0:341:84ee:7596 with SMTP id adf61e73a8af0-344d228adf8mr5688460637.16.1761673326191;
        Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm11197981a12.6.2025.10.28.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:11:56 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v2] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQEAZLv8V0asoe4r@fedora>
References: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>

Hi, 
Forgot to include changelog section in v2. 

Changelog:
v2: 
- formatting fixes compared to v1

v1: https://lore.kernel.org/linux-kselftest/20251026174649.276515-1-ankitkhushwaha.linux@gmail.com/

Thanks
--
Ankit

