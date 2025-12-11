Return-Path: <linux-kselftest+bounces-47448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A329BCB6DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C2D3011740
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B243161A0;
	Thu, 11 Dec 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un2K1Q/a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTq6+lZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D63101A5
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476701; cv=none; b=oEPgiCqwKarBgbcKFyLaIYOxqwNIISvC0UpQ/NlQ8UIjixXaQKZMabicFWJPfOhHz6az7xHmbWn/QZ6MO5z27yEjU3o3Z5XoUhD+8X72i0d/hfYBpzqLZALqGI3Q+RNxkeImZf8i2stiFV3x4lVG5MabcFBWA0A2U3DY4O0zBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476701; c=relaxed/simple;
	bh=KI+8qZL8aV0efCR73pH0dhCbrItCpqY5HGweHERq0Jw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nRgEk2c+ko6iuaRVHFwD1BeHk9OXXwq5m8Bkpd1c0Bbk+8NVaO9840I2pbpU6sh14E64v8w7faEamcEMRTgTb+JhdImXCO+Y/fzeSaEufRez0/1+BA2/o1no2cwJE5aTJE/++nAIjnq3fNSMAUS9CA0RZ5m8lo8DkwdPSDUhp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Un2K1Q/a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTq6+lZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765476699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cy/rMqBjQbymJZZPm+KWkKxVQ55NMpIGDtN7g9mTntY=;
	b=Un2K1Q/apWi4ZjhRHSn88uVxMR2KuEiM7dWt7KsU24kmmsBU//8BfslrkHBzn+9Ska8RyS
	ZYq3ykuaIiZRfzJRIhHwJyzb/6LLcWgpyokiUeZ+ROEaXYz61ZlFnnXkRH4cC6vVaugTjI
	LyZ4mhfgDviwlFPwrF53Aqu9yNqEBcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-0T0W3Jf6Ms2xe7miMQjSUg-1; Thu, 11 Dec 2025 13:11:38 -0500
X-MC-Unique: 0T0W3Jf6Ms2xe7miMQjSUg-1
X-Mimecast-MFC-AGG-ID: 0T0W3Jf6Ms2xe7miMQjSUg_1765476697
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47777158a85so4661875e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765476697; x=1766081497; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy/rMqBjQbymJZZPm+KWkKxVQ55NMpIGDtN7g9mTntY=;
        b=oTq6+lZSRnuj6HNgrHinlS3NMx1eJCgycdnSTckAhBslgERXakugTpqwhHDFV2ps6v
         Ik5EYfuP/iuZnhHlmXDyc4fYcbsZoUMBCFJZ4cmr95WENRGBDyl0frzlXMP1Z+1eoRm9
         FwXOw5/4aBqfd5fYpuf0OFocPVinRDcK9o5VDZM9xqn4fMPNEUcWpXTaF49GobJ1nka2
         1cKTgHS+iMfbInQJrFmFiyLBmrPftYGSnA0YxAK7J/X0atLJfPOB9ZZMpztfnfo7bMYa
         soJzC4vInkRgmXwUeGdXCAhoQTdOstflNEvLjd6i8QqWHkta/Sq25PpWq43nCXZo8w6W
         Ak8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765476697; x=1766081497;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cy/rMqBjQbymJZZPm+KWkKxVQ55NMpIGDtN7g9mTntY=;
        b=JicQ6Um7uEs5H4MW7dD39mLY+Vxsm8zlCb0c4aELUsc2AlNPwJ9ZMTmFIkioCr4zDA
         G9lGG2bg9J2YMrAJYbcNBf9jspGlahupR9Iw7hdDCrWnTSqubkaVsZ1QzaTWnNwpthtM
         lGpKhuAwcYg/L5JGjloH6+VQZbdvSDuNC7EOSPZAkAtjHtDEsdR9CDzwfKOPy/mk681k
         olkNXyhIj941K5jDAZuiMFbvAYAB/lrTabm3OLjP0cIYMqyUvxVC0iacCcD1L/o4RWl+
         U4vM5R4Ssv/QKmA7Ox04qeHROdzPdncev4BvimZ2DigCZqonJ2fU1u9PpDr9TmhcSZul
         BV6g==
X-Forwarded-Encrypted: i=1; AJvYcCVvUkgZ+LexQzpqcNaIZ8qGlXMFP+7BnbcJeo0aPUVylYBIdGRWLPHFofWjDoXMNITGWU/2+H/3AQED1pd7K2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUdx89hKI2tj4CWfGI00ObK6+7ClUFLrfC0ZDOYhbuUSSofbT
	efixmrc4xuh8MbIpmUnqlhhMBbxIhuXRKl5ekIxz933e4sfGEDMoMaTajbpXmd7lrkoG82WJdQg
	cBJy6likIOMM3v4Tulgzndui0h04BQ0MwitZ65yBGj1hdD0yI5iCqqVITLNzAqbRtP3EtziMIFC
	MSog==
X-Gm-Gg: AY/fxX5ydAN4IvcmZpAxtNcIB7FpS8nEH11LuCrLAqAnw2xf2EhMyKLAlK3UAgfOfQy
	Wjdo5oCmuaMhM1kzRVr6kT9uHD09Mr3aJ/KcPE//4SH+jnAGm7eEu6bI2HcXn+k4YXDBzMaCY7Q
	J/7UOuHRmdpGGQTF3yFvrWmb6tJvWxOSS17yso0VXhDn80VrJzp3kVIX7WuJ1Tv1AHXw7GEz71s
	HcfCCCpnVRGNChcGR+ZaVYvghkMPhge36UwgRfLTqDzLniuU99bBjC9PhnlmUOkd6bMo2FuhZgX
	bxw7h5W3p9IbWV1U0yk/jJFDh9vOtpSH4YNuvQjFy55K/P5+7UjL1IwetK2kJ6NwCqCWQFxQgG4
	6CiHYuTor8oJRYca5V1PLNfRcGCj7JB03+UKXB4e/Ne/+ohFklxPZk5FUKpw=
X-Received: by 2002:a05:600c:4ec9:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47a837925eemr80416985e9.17.1765476696911;
        Thu, 11 Dec 2025 10:11:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd7LSwA1Tw7awTk8rks0aApbnTxXvhb3ATj5j7IUdQb8VwjwZ9WpbdyuRokbJS/svQ10s56w==
X-Received: by 2002:a05:600c:4ec9:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47a837925eemr80416675e9.17.1765476696564;
        Thu, 11 Dec 2025 10:11:36 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b750sm6862862f8f.42.2025.12.11.10.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 10:11:36 -0800 (PST)
Date: Thu, 11 Dec 2025 19:11:35 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Jiaqi Yan <jiaqiyan@google.com>
cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, 
    Shuah Khan <shuah@kernel.org>, kvmarm@lists.linux.dev, 
    linux-kselftest@vger.kernel.org
Subject: Re: sea_to_user sefltest failure
In-Reply-To: <CACw3F52i_Yr+8Gd1=H=EMi7NnVJ8WCgMkaG1dSe8FD7PvOsW8w@mail.gmail.com>
Message-ID: <c44b75bd-bf54-0aab-78a2-89f448cf126c@redhat.com>
References: <1478ac09-8134-5551-13b6-c7be096262af@redhat.com> <CACw3F52i_Yr+8Gd1=H=EMi7NnVJ8WCgMkaG1dSe8FD7PvOsW8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Dec 2025, Jiaqi Yan wrote:
> CONFIGs seem alright to me. Do you boot kernel with cmdline options like "default_hugepagesz=1G hugepagesz=1G hugepages=64", or dynamically set up
> huge pages via "echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages"?

Neither of these. When I do the test is skipped:
# echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
# ./arm64/sea_to_user
Random seed: 0x6b8b4567
# Mapped 0x40000 pages: gva=0x80000000 to gpa=0xff80000000
# Before EINJect: data=0xbaadcafe
# EINJ_GVA=0x81234bad, einj_gpa=0xff81234bad, einj_hva=0xffff41234bad, 
einj_hpa=0x80241234bad
ok 1 # SKIP EINJ module probably not loaded?sh: line 1: 
/sys/kernel/debug/apei/einj/error_type: No such file or directory
Bail out! Failed to write EINJ entry: No such file or directory (2)
# 1 skipped test(s) detected. Consider enabling relevant config options to 
improve coverage.
# Planned tests != run tests (0 != 1)
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0


