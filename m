Return-Path: <linux-kselftest+bounces-34027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB4AC8606
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 03:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4736D4A4022
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1278F59;
	Fri, 30 May 2025 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YbSgN/vP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54379D2
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748568829; cv=none; b=XUK1sLW10O7e3OvrouAw8+khFG51A421aksMfovn9u1+PQHi7mCz1/1+hYRuDPckVsO7680NdLIwY7kzpieK9gWfdOg1VQLAWEu2XeYiudKDAk5IfukIUkgJKd3mN4uk7fce0yVHIc7mmwfuhveOlvN7KpcGe3AMxI+3Zz5s4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748568829; c=relaxed/simple;
	bh=FMpA4RSm8ne9pEdJlb8jlNv3zSaTEZX72+fA8B7cDZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlz1JLMIwB6OtmfF90OjJY8DxmqKEjH5VSxgRt2ZOcXNfEnm4iakYmZsYBz7TvyM8nERE5Es5pBAXRfMKX1jaPtGxXV9qByoZ53RgBmWgNKMfBWliomAgPkIYyJ4tgpHqC3Hz7lXZlO8SCjwYmbWNxOwvNIyUvQY9D4JLNR849I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YbSgN/vP; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85d9a87660fso136573439f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 18:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748568825; x=1749173625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63YhklUO+WBFbPxAfzObLOK/MHzwz+yybl5BUcMH4q8=;
        b=YbSgN/vPPvKka3jZDEtkJbCQ12e2jYrQWs/2EK66K2iJP+Nn0NhGcB26/qtczjyEU+
         zVnpx6fvF/iZQpO8iS/H9PjRUmBnhqvgr8vY7BeefCExk+DBLF9Zn3yD7RLZeivwk+Le
         yaBf38ej3UTVI+BTm6kBgOgAPhjvi6q0oQkAacXnUPGLCAkTCxqH2UIZ6XGsRaIUvRDm
         mdj7gIEN9gNCkwYYtsKAds0f9OeWSmulKVnCiGNxNsH4qXQauOFiZV280WL5nxwz2AEx
         Urx5MDweS2sse7RviXZ1ys+FE701EuE5DEHO9lbc/zl399ss22DrPBhxarYy4LCTHnc9
         hvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748568825; x=1749173625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63YhklUO+WBFbPxAfzObLOK/MHzwz+yybl5BUcMH4q8=;
        b=ZqcyXJbi1l77swNUZtnRqAyfUKHtU8heg1RJZCiUFRZwMCRdMQS3jonF/y6LipHaTR
         r/giwKTPNFGVSuGpD0pvd8SECf9B5iIcaWsqgZJOD9HzqitoUvUcorZOF43YXKmthAuy
         t/NqikAua+9Yyy0cuy0c7Jx5LfypVTT3kTRobD5BHwY4O9xS0tMKfYcYgSdqkyO1J0uf
         4tMfwKB0IwSybZx0NkXU+bsYlAKvmQIsX8kw02AMS4OxugAQsKHJQ1jSp1o77IqcusAU
         IwUuLj/5HowhOMria/985OQUWrZeXwCEKvq0SYk7E/yXl4wBmVbKd4oxiHiQvgSidrE6
         Ia5g==
X-Forwarded-Encrypted: i=1; AJvYcCUG+z2rDv22KqlqkffvfbXCkyLZyHKMyAgxRRWOkRc9DNRlUWYJ5AallqSpKncR4T0t9VlX59yjmQ29cmDuNmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziY8fu/3J5AI9ery2+jWXraeSFlo1uTGuj5/Gj0x2vyi+wczXG
	VFYn12AIi0Y8eIFuWA/P1VJGSB5IcaBi+4sCQ0aYTSkRnEaeARxmAPfuiCDOGDjPkzo=
X-Gm-Gg: ASbGnctN84buafjqQbO3ZUpeaXpgiuUFx+QJBLM0kd46PM347DzmNgo7fFTEbW7Gw8c
	xcvywVFjlDq+78K54WcxlOFU127SSi59M/hi9jiQup1kMgEnSBqDayQGoVX+DvnANduIGTj0HhN
	HVeZPbt5Kf2EqPWfsIVKpVRzbVgxC8cslZJqQf0hOyk9i/nPgyfnIYF+k2bCi1dN0zhbs07Wgrx
	UG6zUdIYLfyKe6Ix93tSr26wiOcpI1gSPw+SzogxLwgVbWlZtUBaJUf1IQTePMXJRlk7XXZ0mFE
	LpWGvVpZv0bDFU9O7e2PfWpMgc1EyW2d5Og1SYL8DsRBIN0OnuelCD4uDRA=
X-Google-Smtp-Source: AGHT+IEFewJDcfGiFulGvASHgCG+gQHnrzGVAH4ehGl9q9BWmJdWLOEPyauL/ILbXyseIIfHsaD5lA==
X-Received: by 2002:a05:6602:5dd:b0:86d:5b3:15d7 with SMTP id ca18e2360f4ac-86d05b316a6mr11323139f.0.1748568825576;
        Thu, 29 May 2025 18:33:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e28fa3sm255381173.45.2025.05.29.18.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 18:33:44 -0700 (PDT)
Message-ID: <d3882634-1071-4219-86fd-c9c72ded91b9@kernel.dk>
Date: Thu, 29 May 2025 19:33:43 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] ublk: have a per-io daemon instead of a per-queue
 daemon
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
 <20250529-ublk_task_per_io-v8-1-e9d3b119336a@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250529-ublk_task_per_io-v8-1-e9d3b119336a@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

