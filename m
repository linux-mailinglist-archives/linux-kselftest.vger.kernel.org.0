Return-Path: <linux-kselftest+bounces-29899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892AA752BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 00:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A805A3AE3A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 23:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE531E1DF2;
	Fri, 28 Mar 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WfnjjzLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7D1DC997
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203053; cv=none; b=k8u7uTfbvYAG5YxYTaWNLTQtR6LN2IoRY8ww6YVp/JnivG1JIIsBZskbDNAljadbMyxvlWfkpwcf3Nz+3SZ1oOYEKGwN/q1Sxx0vh72ei0lXtMufn0Cor64YKp941+ZR/xGb/Yzm1vjsoHvzP2EPBZ3KXY5jZ/tnNPtZTCIFEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203053; c=relaxed/simple;
	bh=V/Yo9JaPudHdUaz/y8DF4V6JJBxzXUoyxnkqIpft2S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyqMrVXU0jeB/Pw1hejwqeVWm3ENX5GFZXZbi3vSDyfIpqD+qXv8X3eF/yTnuCxJUk4Fp+DzJoN+mkbBNNswYv2ITqb5gCiJP05/7LzxxZ/3t39uIQqtNcofgvt7FzvD2xxCLWRx4aQHqOxtXlTYwgyKoUL1/qXooUal+4SVBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WfnjjzLT; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so9514025ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743203051; x=1743807851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qhp4FjWVQrvvO+GlfbQLfHCrJZodz7/Fm5AMhUdc1FA=;
        b=WfnjjzLTVSPckitKrYLiczzZgEFBsTxx4C7wwIn1Bp1WKWEI1Csk+l6iJNhDSszU+t
         T9hW2S8YmuC3hQmQMBPI4UQ/5wuaM4ZK+2pSkuonPT0v5D1cgRcwsujB6DITEaLyw6X4
         BR16eBFgh8lkb9g2Ho0mNTXFDz6lrSWr5C5/97hxbCryjBZaTc/K/nMbCPSKZsc43GcA
         JShCOldn64+NXptX6QQ0XSmqM+jXYNG6e/JlhYPS0RIIiMJhb/E5xXLX5biv9OLpLoTN
         lBuhISS2/s/KgUBCDXUBQAm0ALgvptHApm9qYoaxQUwpnbUQYI/L4AXXYsL6Xa+p/Mvi
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743203051; x=1743807851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhp4FjWVQrvvO+GlfbQLfHCrJZodz7/Fm5AMhUdc1FA=;
        b=HEG+SMjqeEy/+VLc0DfOtGj/xwZ9Y7Ct9vAEVogbnHAaXMrnyB3Z1WgAzr4YqQb+Qx
         YeHVgIe9EzlJ/C0zEbhNIq+ayNGy+noLhS5EhpxxK0FxBQJg6aKtDiI/s/1GBOCz4fhn
         4MpeHtOzd1psH9+mIgM5Vc7Hue2ydHYFJzHjZmcA/Qe3qxoeXAMfNTmVeKKyA6l2zQ1q
         0u70f2PtseeS+p/Wv4JxjP7DzhXA+3jvkbgKcBCsr60zIW9pt4acw7g4E7Fwv9IjnFhL
         uykJ1rnGn9NQ1Rv7u+npiDL/0ap/op3cngFUfVjutqeXFyfEAWw+QoFr6lN2d9F5boDh
         47dw==
X-Forwarded-Encrypted: i=1; AJvYcCVI9h05Ewx+N7Vy0/+Bt3WWBV6ynWA/sVkV+AKMDntIvQdhjSzIE7MFpPFXiyU9YhzUdAZCOJq+U4St1d9biJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SGiCe8B/h/6zxvMK/k0i7ikVnTwEMD1XJjU6fuIVIsKTIF04
	08eY05ZYDMCcwM4I+Y2UtriGR1B8l6Al8VJWVz3cOTG9zFtIOwf1AvwgmCwMK2I=
X-Gm-Gg: ASbGncuZBh/jeS7U+PS8TeX3TF+Mp2qy9YgsL+D5UZMkfVpbVpEultxzOH+wa1YEJMy
	iHxQaYxFqtLEwr+c/OOWS492M5NAcgO9IXUQfcb7BBwb59c0zT4oaewGS6Ywqg4Ry7c6LCLmIN0
	4ZfasLMiQiYuSwfwklbRFzPL55SXaejp1L6I+fiI59A7zF5q3ip2Ky1+rPUOudMpeaQfvT8/PRZ
	9Sgw6VjS7KjppWsu4NOK5GIqdAemavgd1wSIDhPatZOsOVxaJD0C3C/w/13BGZukXJ4vJNnxiR9
	tAiGw3k2p7c+/tkuxFB1DgsTE9/gaZD+qX5m4DrUMw==
X-Google-Smtp-Source: AGHT+IHPLiyiUBHTmY8K8liSQ7EueqnYy34tBm9yuLIaqAlS1dx00t7wM4dbN8H3iyc2RlQhEdNkcw==
X-Received: by 2002:a05:6e02:3183:b0:3d5:e002:b8ac with SMTP id e9e14a558f8ab-3d5e0908e3emr14696755ab.9.1743203050568;
        Fri, 28 Mar 2025 16:04:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464717e3dsm651238173.3.2025.03.28.16.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 16:04:09 -0700 (PDT)
Message-ID: <9b65632d-5155-44d8-9dbe-5026a1cc471d@kernel.dk>
Date: Fri, 28 Mar 2025 17:04:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ublk: specify io_cmd_buf pointer type
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250328194230.2726862-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250328194230.2726862-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 1:42 PM, Caleb Sander Mateos wrote:
> io_cmd_buf points to an array of ublksrv_io_desc structs but its type is
> char *. Indexing the array requires an explicit multiplication and cast.
> The compiler also can't check the pointer types.
> 
> Change io_cmd_buf's type to struct ublksrv_io_desc * so it can be
> indexed directly and the compiler can type-check the code.
> 
> Make the same change to the ublk selftests.

Looks good to me, nice cleanup, more readable now.

-- 
Jens Axboe


