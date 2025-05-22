Return-Path: <linux-kselftest+bounces-33531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7620AAC1703
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4C71C037E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF129A9EF;
	Thu, 22 May 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gE1CE75C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37A29A32B
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954274; cv=none; b=mGEUDWiYPeCPZ8NPNHAOjd1v9jVE5G6Ag1AVNedv/34GDbnUIFWPYQji7mCDcAsJwrxD6eNOZkdUmgI3BVq7TZY3fF2+zrG7TGqwOjDbYz3UsAa355mvAUo2/oBu5DByKcP5u3ed8eGRdY7+HSrzqz07HYaXQNbTKPDiML54iDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954274; c=relaxed/simple;
	bh=XJ27/xwWLz/W8KH2VMTPmg1fVqnXe1xQPj7iei/d3S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwp0TRapwqyHs4fZD/HaKB9E8Xb31bHGzQZLnfOPxscbbGIcGi6VXkxnUYnw2+CPpfwsjpKdZdv5PnBxy/VR4YtQmgiqFCpkclQOMsu3MNvV5fMgNllSqeGJRI2oOf6vZStM02OFMWU37p9hgpYGZ5DYmK9D0ShjWXoJ35IPTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gE1CE75C; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c873231e7bso4744032fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747954271; x=1748559071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqOqsD9enrwocZN2XCXrFciGa3ZPBF1bqsvBC9V48ds=;
        b=gE1CE75CcxONMlk5kg5jVtsNefbYKUGLDITmGAX3cRrNlgu7QCbiyGSmE5NQMIpdus
         OPhFOWumImWGyzoahCjUNOc9GKkYOHhCs+Fz0M1wFRx7XQP3xN3pZtHN/Mn8ZZXZ3MQy
         Wb2dMWLehrB+dA7cYKykr+2FA3lDv0IAuaPeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747954271; x=1748559071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqOqsD9enrwocZN2XCXrFciGa3ZPBF1bqsvBC9V48ds=;
        b=mGlzv9q7uABlBAdPZ4WvDKrxtaAe4c6fnUQj8YQCY0ZkKnNyoWuDNGqVRozQkrwEq/
         TuURtw3+mwahRx0w4bO0XSwiqc9+ZGMd4J8eKsubZxTh1nPkqoea3fAuvm6l/sfeM0Nx
         T919MAQTVPAtrvSlFqgi79nT6vSl5kSP7DSB4WoM5B88ULBZKB8fblPXVJcTtevPytzb
         fSi8KljTDMwxcd1OaqySOloHpVI/ySNv3kwe/Rx3syydXpPxbdVvsIsoJ5hHmYYyeEKy
         f/8PyiJ4Q8lRfPu7bCVgcX68SF9TV7yDFET3x8qtHCZelDbOgTzPl3upPOOmsJQ+bAcf
         QaXA==
X-Gm-Message-State: AOJu0YwtQFEDVFys6KUMLHZ9oG+eSF8QXxxAphfpfHHwGEYwVPsBdLU2
	w/Ks6+PbWpdAbcNe+hEl/4BE5qyF8WwqSlMAc6qSYBNtkKaxgAf9uPKjXmTtDROg9j6GvpdVR1+
	8tXvJ
X-Gm-Gg: ASbGnctPkNKatlocEtQWfIXxYLZzOvZ7OdCkhgSBOSLEe0t7j+UAEpzXww+84TfsRJ6
	QikMYDwz0b+RRQjXyzm0kwx4S9soHveT89W7G0fKwFhrmxv5GVFj/a31YCPFZor8mssIUP3nUA/
	mDX6xwr4yDaPHnj/IPXNFW+Gvr95DDVa5wqF8ezxMorgmFqX7x1rPtpHF0LnesffXz7yxlDPoOf
	5hJD5XsVbpEz6pv3MZimNhJhPxPMXq2t1K0O+IDbwh3ej47xkjDxiKYmEHYjJwt9uJv2TjfFZ2D
	T4tsAhttvIjFN7NUMo2YioY/ormsn2IAgA+GfwvAgCSZ2q05PcogCiZ8ZtNnUQ==
X-Google-Smtp-Source: AGHT+IFzOV554lWXzcF1YV5aYeLFpUIO3UBsBYGo8BFzCMTUpdmhgcxpCdf+r6HZsu3QdP1/3Sm1pg==
X-Received: by 2002:a05:6e02:2164:b0:3db:6fb2:4b95 with SMTP id e9e14a558f8ab-3db857a6f7fmr318356595ab.18.1747954260746;
        Thu, 22 May 2025 15:51:00 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843f72e0sm36708835ab.35.2025.05.22.15.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:51:00 -0700 (PDT)
Message-ID: <4f0d5c19-8358-4e5b-a8f0-3adcee34ffd4@linuxfoundation.org>
Date: Thu, 22 May 2025 16:50:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fix spelling and grammar mistakes
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>,
 shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250517015912.131187-1-praveen.balakrishnan@magd.ox.ac.uk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250517015912.131187-1-praveen.balakrishnan@magd.ox.ac.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 19:59, Praveen Balakrishnan wrote:
> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
> 
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
> 
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>

This patch is missing net maintainers. RUn get_maintainers.pl for
complete list recipients for this patch.

thanks,
-- Shuah

