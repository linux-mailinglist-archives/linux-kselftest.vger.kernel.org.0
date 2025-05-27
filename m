Return-Path: <linux-kselftest+bounces-33839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC1AC4ABA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA1417CA07
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144FE24BBEE;
	Tue, 27 May 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="cDkza7l3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4FF50F
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335934; cv=none; b=BumiJ0RiFQxKx31OY5rh4dq/uMz4OqlDnUfU1tQyBm2d+oTUSJNo0eUDzCxsdtf6keX6q9SqL4sXYb44pPr7D0I0M/ICa39Zp/itXq72RRm48Q8UEGXQdOaMto4LfMBoXl6UDuAF2IZ7utimYXO/b91NY70GMtWaRKsW5Ba+UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335934; c=relaxed/simple;
	bh=4mSKtba4yH/6S4y+/PV83qun/HcTtQ/B2r4C5DqnP1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUGTARwvYGPJ+a4SgJe2ZdRMUk/kzBypcRTYHEA5s+xw6KZccR9JaSED9FJgCDvfqv6UlT1Ouas3s6l1Elyk8v/YXn0fDCLrD0BzRxCxl6c5M5nOqpQPACnKBGN2JD165V+yBT1FSsw8QEBTqCAImM/7UviAMiXjk3qBZ68b148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=cDkza7l3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a363d15c64so2181313f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1748335929; x=1748940729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mSKtba4yH/6S4y+/PV83qun/HcTtQ/B2r4C5DqnP1o=;
        b=cDkza7l33Py6g4Coa2OrK61vrK0m+2jYKt1UnZ9oNEnaw70b2T0PyuoRqMoPpOsfHQ
         0HLEW55OpncZBOY8nqxRR9u2PLQF2iuOB/ICte8vxXtBv7QWiRmoaOtervY6R6jA9QR0
         m5AwMmlBwgfX6d5rJyEHr7K11HIbms2csz9WYeW27NliVCbL5uIfxn8fQkN599gEioxV
         asvGpGGsJaUtE6n0Us0vLVkDEQDp/Y1x7lJGuMuICrQe8KHqPpRAIl4iNgR9R8g8kLlx
         iLXXcI63cMjm6iMU49sF8Z8q0V9SRaob4Z1bKTWs7tqY24KkYc5kIakw4RD/xv5FsS6f
         /h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335929; x=1748940729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mSKtba4yH/6S4y+/PV83qun/HcTtQ/B2r4C5DqnP1o=;
        b=KyNT74CX9VwdCf84lEPzQa6XYidVTBdATyQq/QrO62dyNl97P3sHBYF0z5GAlGLcJS
         7JgwRrDF1VJOuNvLf4mLQ8nX7zJAGtnXbdR4hoPEnbTLJIAFIuEYvjtjuYeCdD54cpLF
         f6QgczpypPKLVAGt7l3bO5xRj6tr8z3G0YACAhKEAnznS68mdj6IqNVmCE7kCtB2GhV4
         zh1b0o6vDjZa32AfXzuy/yKwEqsaqY1Ym0cXf4XhWmjjsqKkoihWjE4aK8jW3PxfsGiI
         1TR+5D/4U/ZI5qt6+vetmdG7xQna7MdyEsG9s15QmCaguW0jVpjcvqg0arnqMFV9uQH8
         Zt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdUosFmXkmmfOGDzZi1jfo0d1G5bHCbSU4NuwXhcRF06FMgO6moLphN5BHvzr0uks7eyhbcYbKzl/vfanDwEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4y66aDKqFq/voXNFnnIZUG8TpIQ/Toefny8HS7CzNlHV097l
	Tvxp6Uj6OGVHIgytxR4gb4JLOY9CGI9ngOUVz7X9UgrINLgnEUG0liz0H/YVcXTmTrodcgffjfN
	gERRxPYE=
X-Gm-Gg: ASbGncvDARk5SLq8qLxCUUCyGGQLAfecWi4Aq59V2ErjmzUp/JwIbo4HslRfQpzBpNh
	PPw5U2GswGTewoyMUzLIVpAQkbeeCSDWqPvHG1l0i8KszYu8E1jaSLmBlK/qTJYhOW2j5fTOFgn
	qAF0d0eor8yT3AjUO4UW49Rhgnr/7putToGdkvgpfzm4mN3R2GKUGbNPH3VR9s+LI3YskYmEyqA
	vune3V5ysPe9BI5aw09LpkDzdyQJqf0PPk0PIQYroxnmccj31hvF/hAkLMjMUOtKsehK+B8aEIb
	kqVgMO6toQsAhTMcodSrTQtwYXImPpdB3VjR6ZQjyAGuosTxbrOZrCjRwAGrCl+kZDE+qia5iR9
	R056I0lyS6IBO0oNfmWwQ2BsRCmQ=
X-Google-Smtp-Source: AGHT+IFfujMszzRhLDZ4PQR9OlTYbQFnFLu3AYpbNNyivRDUe3CYGLHt0XR6JINggLt7Mrt+OkN0Mg==
X-Received: by 2002:a5d:64ea:0:b0:3a3:7753:20ff with SMTP id ffacd0b85a97d-3a4cb45f1f4mr10543773f8f.35.1748335928526;
        Tue, 27 May 2025 01:52:08 -0700 (PDT)
Received: from [192.168.3.93] (178-116-3-140.access.telenet.be. [178.116.3.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4dc7e69c8sm4196245f8f.95.2025.05.27.01.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:52:08 -0700 (PDT)
Message-ID: <db649de3-f070-414a-8201-3a5406a4eaf7@hammernet.be>
Date: Tue, 27 May 2025 10:52:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: fix "memebers" typo in
 filesystems/mount-notify
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel-mentees@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250513144816.72566-1-hendrik.hamerlinck@hammernet.be>
 <7e386efb-8f7b-4bc0-9ccf-784ddbdcce78@linuxfoundation.org>
Content-Language: en-US
From: Hendrik Hammernet <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <7e386efb-8f7b-4bc0-9ccf-784ddbdcce78@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/22/25 23:34, Shuah Khan wrote:
> Change the shortlog to indicate test clearly. Check a few logs
> for this file for examples. Here is how the correct format looks
> like:
>
> selftests: filesystems: fix "memebers" typo in mount-notify
>
> SZend v2 with this correction.
>
> thanks,
> -- Shuah

Thank you for the feedback. I have sent a v2 version of the patch a couple of days ago titled:
`[PATCH v2] selftests: filesystems: fix "memebers" typo in mount-notify`.

I did send it as a separate mail thread, which was probably a mistake.
In the mailing list history I've noticed new versions being sent both as new threads and in the same thread.
I also could not find a clear answer in the documentation. What is the correct way to do it?

Kind regards,
Hendrik


