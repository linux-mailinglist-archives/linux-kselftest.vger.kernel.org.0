Return-Path: <linux-kselftest+bounces-35243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13845ADDFE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 02:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFAB7AC481
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487C29A5;
	Wed, 18 Jun 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDXcXbr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E47B672
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750205129; cv=none; b=WAFnKhK6D258SRWCWurKICoYljdfRpE4tk7mYHZhCrv3F8sjq458VDOesBeWHBP7ZKVaZ2XjEZNZKQxNYDA5ZAAln25bplaZsoMCZF7feUF5ESd+X8Wab87RCaMLBwO0gLbskQN3uPiWt7sp8ROEFXsdc0tfEWAHFuwv/6cE2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750205129; c=relaxed/simple;
	bh=QFkuGXmAHd79uVD8tQGgyFz4MdqAX5pBdq1VhESVJtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbobLreWUn9O4iQRBBXH+U06hvxBO7gPFUogSMYTG4InajYk4EqFV8ZCrnslOqH6PtoED5rC3zcM7sRHIoyKCfqdkEB2SSyVKhnfdUEuSHA+5EEengtvegwqeGzOiM1eB3B5hQUlPUycGWIwvXB56kRjfJqN2l6dRV9k9Aq5iHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDXcXbr6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adf3b33f968so39152166b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750205126; x=1750809926; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUmja4IBWpEUoP/ms+lF3KXBhPpfo13ZgpKu8dYL8sE=;
        b=hDXcXbr6yqf2YjbBJdZqOJjDoj5Dvmw2rwNcAX9QtXR75vo4HRUj4dzWGOuoLkKZPQ
         V2EDCiH1717Ibgmtyx9QZzZYuSTFmi2QX7z3AalnpT8R/7eXCgo5MuK7988yaUPZ/rhF
         /v5qvBmM2g9I8O92eB70msWMx0zdUwQC4xJIyl7PNOidlsQnQUOKOy5k+qI/F0BtxmL5
         Fql0pSX4rL26wbujPi/2zJLNqQfFvGTCO75wZDN5nG5HIf4BkjUJcqOBSMj1sD2WDYuz
         4GPhgiv/NGYpmtoGxJU/NtHmuIeWON84SbIDyDmujjr8twBozCFKAAwqMGUHQvi4O0I+
         bhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750205126; x=1750809926;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUmja4IBWpEUoP/ms+lF3KXBhPpfo13ZgpKu8dYL8sE=;
        b=bflmd+NugVyebRFJDT+5/siALKmqVxF3ImRSwRcKFF8tCFYV6w5XBvqTlP6rBVnH8O
         6MjXEuT4/SchNQ9vy5mvYEEOk4OwXdLVX/hLVoQ58r2GYpFOr1HXEKGSqdFo1rqCgQ5a
         tlhy14dRkr3NB97ppjJEPGXIWHQzN7KSzx37PsXuVpWVuatF7lGUoWpYP+4zXBSru01J
         IcMVW988fRVTscGd3c8wbcp0Or9gkH1udR7PYABqKcg2OMS1PaV7A+TN9oxwnftJNoiF
         sc0I5TP5TwTHKgmq9s5TpmHi2BtTJf+ND8aDGbX30+5Q9varfzzlIFEmD48e4IvuKJWU
         FE1A==
X-Forwarded-Encrypted: i=1; AJvYcCXAg00/NjXaiBcE4KhOZsaI9nanht02unjWVCLWhABferObwXYWqbbSmXE1gWHiD1NysOZC8mkU4v6aIKz5Bkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRDPIvU6e+pI++TjbuxZcxbxrVELG3p9dlfflTN47c9WT0ly/
	Veun1zMmgrYLjSniGrQmGpHb4RD0FnKRz+eo0f/XqWsACqCRZzK9leqw
X-Gm-Gg: ASbGncuukgH1CBXjEY1DKJdHv5QKenB84KTiUiTr+IbeHU8BF9V68jThjmbNAgRQ5Q+
	HKjgZpd521nRsls6b0G21d6Zo2lzAF4KkPbJ3pcZIrF2QiNlJDUvEgh+KsQ/HRzu254Bvt5G89i
	k1Yn1ejHiIhWewQmRUhNOF6gpbb0/Ny2V8B6K4O4B3mOZW7ZSkO5kTOFftFt9CXQJMqSp7mlCFU
	FRx03Kf6YXTlHNWW24W4Aa3mQM1yRPRdO8DZ0DuRlmJr6L9jex+qWRFgoiMANiz2qgF9J50RjeW
	KbnDueS+JggUOkuVv/5euLWLu4ZLduy6gkqxXVZeoWzG+rmelaYi6LfE9zsFFg==
X-Google-Smtp-Source: AGHT+IGRvlEJ8gwgE3YqMK2k+611l9Dji7AQexWXXyj8k/Kt0SrLDsTCRL3qhKEh9IXyvV3/B/pppA==
X-Received: by 2002:a17:907:7216:b0:ad5:9ff3:c6ce with SMTP id a640c23a62f3a-ae01f4a67f7mr44520466b.4.1750205126000;
        Tue, 17 Jun 2025 17:05:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0140196a5sm82791066b.184.2025.06.17.17.05.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jun 2025 17:05:25 -0700 (PDT)
Date: Wed, 18 Jun 2025 00:05:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250618000525.ny3leomh6wtvoq6b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
 <f5b58230-c5cf-4c4c-afdb-752f3fc5d233@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b58230-c5cf-4c4c-afdb-752f3fc5d233@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 16, 2025 at 05:45:42PM +0500, Muhammad Usama Anjum wrote:
>On 6/16/25 5:23 PM, Wei Yang wrote:
>> Each fixture could support variant. Add fixture with variant to verify
>> the behavior, so we can validate for further change.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>

Hi, Muhammad

Since I may change the code in v2, I think I should drop your RB.

But will cc you. Hope you would take a look later. Thanks

-- 
Wei Yang
Help you, Help me

