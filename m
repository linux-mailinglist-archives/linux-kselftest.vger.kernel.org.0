Return-Path: <linux-kselftest+bounces-18125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BBB97C590
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 10:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E709A284929
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BE7198A27;
	Thu, 19 Sep 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZPwgmMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D081191F94
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733429; cv=none; b=oqRX+Baa5sdTtHCJJ6jIwWE6HVznvI1w3iO0Rjq/tTv7cL7fKTaKPQ0ddRbTJvNSpQE4BhFz/Fz0uiIvDFgir5opHylF6MSakn1dVlLmRFIzjkmVEhYsMUuKgA2jzQJq8M3yVey7iPwR45seaNjf6QAdSIHXQc5vBum1Vf7u/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733429; c=relaxed/simple;
	bh=IMr2sDS7aX2NzKbeHBTrELWlyEAyJZIdbUt1cIwyPF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeXZQMgT8OLhYnNy6+ynYex1buyn3T3d42BeKvd0OH7lulp3HoRtbZQ8q7Zi3wRGfhuMPzFymuxEdFoK1qKGQlWcBNFOZwuDBdSIYh9Ce0qtnH1QKOnooCTMoDPmHJ6xhJV2g+qdq8Bb/PhQwXAA8JHHI84eLU8YEmu8xFxrGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZPwgmMD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726733426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
	b=cZPwgmMDBBrua0inyGjOCt1maSquCTV28OQ9vJyXKXT7fyXqeDdgSYsj/MRNxYTS4YhpvA
	aJhff2zlG9HmYG1hAAB0aEcJoMmj9qNjOcsUfs0xDD7u/5yXe+/6fjTIrCz92mGz593LtG
	3bDba00MxSozS9D5JMJx42lWFAOezFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-cnerrq5QMECqBxHYm0Zb4w-1; Thu, 19 Sep 2024 04:10:25 -0400
X-MC-Unique: cnerrq5QMECqBxHYm0Zb4w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso3861965e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 01:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733424; x=1727338224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOfIv+eOnxovUFA0Wsmzc627m/UT75AgIdbcTXT1OWo=;
        b=BTQ6QrtAymOFxRI4Lh3AAF+wmBdBy0B5nsa3asFHazYWd12rwp/SVLp5BhUQJeFTMJ
         ivs3rNwAJ5r6AuRgfe7PaCKkIQnttDoImR/wFxgzwMksLDLMfvrVDJKVp+LqeQhTJOsn
         KJeD4fXfmiu9m6A2SuXJcDnWHSqYnIPIuoxsoquFXXt7AJoBfzdG93k/ojpwWT5GOlcG
         mVrWECvFzw4NDJg700fPOTtCbej9IExEMkLv36h4G5cm08OsObBy0kxbVNbCHIlGNulg
         24+G1KG0pnMFbx4jwfUCgzqTvHFLyZlj21u1TqrkB2687QBO7ziPL39hdrIwfc8gqcYn
         fiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFPuKLTSCbNqxC9IiqveRjMNDL9fOEUhxQ/pH23fH9sOBuV1sgzYQl6EiodgnNbKwiuA6zuSTLsMqFiSzXZGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AcODzg3eXeZ6etPNoz98sgqL0VNpROEzbaGDeM4yn4zWxN/T
	RbFPp2XUIYAM3lJ73hDSXBWkUzdrpyFRk4a8m+VUwUNdCqRDtuBS70Kt/dDDgKzWFqahiaUsLEs
	FIeCDAwHymJo604p8XbQhcXEuReCB5DrH972+fsWljAjsKC6c85kURJRWEORmYPeokg==
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203453065e9.28.1726733424212;
        Thu, 19 Sep 2024 01:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGT0SwgVzRIkY/MUx4n23L9SMHSHNhM8DLpk/EIjcBzZveCWuxQ4pMW0o7cv6mXWtvyMK74A==
X-Received: by 2002:a05:600c:4f82:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-42cdb586defmr203452865e9.28.1726733423826;
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75408abasm15477015e9.6.2024.09.19.01.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:10:23 -0700 (PDT)
Message-ID: <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Date: Thu, 19 Sep 2024 10:10:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 V4] selftests: net: improve missing modules error
 message
To: David Hunter <david.hunter.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240914160007.62418-1-david.hunter.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/14/24 18:00, David Hunter wrote:
> The error message describing the required modules is inaccurate.
> Currently, only  "SKIP: Need act_mirred module" is printed when any of
> the modules are missing. As a result, users might only include that
> module; however, three modules are required.
> 
> Fix the error message to show any/all modules needed for the script file
> to properly execute.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


