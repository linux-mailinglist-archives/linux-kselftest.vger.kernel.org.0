Return-Path: <linux-kselftest+bounces-38628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F8B1F5CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 20:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BB33AB870
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894C1F09B6;
	Sat,  9 Aug 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAt5XAKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D2288CC;
	Sat,  9 Aug 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754764331; cv=none; b=fNLeFNcHZnMkxwfgP6Gs+S1QX9hrbEvfCZA4TkYDDZXyxt3u9luZGIngR06iylndI5fu5gnpsUk0jZ7kPBYm96/LDAC9Vf2eb4WCd4+TzIvuKfytLrBYOyzoXSdoS7eTIwlJ0Jr5eXAF80/Q92OSXIBZWz7NXcrIro82Une9Tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754764331; c=relaxed/simple;
	bh=skl41PDPVmrAXNWrGw4QZDlPxbtwj6rcz6iytdfNCm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVr2YT50qlPU6oyVUDNqAY1Dk0mrFT7qXUM3FMiAcgtHrOPbArlRfCzph/Pg3iIOGIFmpHIs3QpYI3zRjtV4IPhoxNCl31aaWjrpTRHEh2ZDGQTG2DaAK0AR/2E6cImRfpqV1zGoAKKyPSCY6BJmKd0UzwhJeKOILDkz0VrPoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAt5XAKj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af9180a11bcso647161266b.0;
        Sat, 09 Aug 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754764328; x=1755369128; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s/fBeEFb/0n5Z77cYt+rcfLlCaa7g5SQq4WcqQ9I+g=;
        b=SAt5XAKjOQ/55r9JM1UOD/kR5yy0UBXksArkFESCcnQ/ehoPIlPBRgc0cIg8jPk18j
         pNOCatMxlDMay1riYegunBPND/G//nD9tl0yt3VeCxFCybibgMCBX2+iX3YDTer5yDja
         uYjD5r7tAlzAYmFalqJtYYacQqzARl/6HVDvUG86HWuuZ/Fy2Ywa9MqZLr2W/1nF/8ot
         w0sqLb+WTOSl1ydFms0EZtRSYF4FZu1D8DCdmKVmtK54cUaT33AFvCOotPddq7bB3Km6
         aGYdNfCOLD3f/Z8fvLy/YkFHxZW7a7sVbiAZIf/ZfPWf/HsjNpMLFo0vikpkADpWqLDZ
         Hglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754764328; x=1755369128;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9s/fBeEFb/0n5Z77cYt+rcfLlCaa7g5SQq4WcqQ9I+g=;
        b=kJYfaeqEbGuk+qtSYvyLW4ojNjk4kvyFef0TtXsgnXqcoJEKUo7IVV3P66IGt+ZA91
         HKpiSQuYpa9aYDo/HADFcIIhQ2QpA/RGsNsvFTx3aKTXg2K4bTPLxyYKMxXpOi6GGzOW
         45hXWJxJCwzUAoyvZPiJbZLvyndkRwcdUCaM5vJQeAUofiBvVUjxnQVhjuXp4aUz/HoO
         yCDR7D/TscpbqGcBg3/TF0pipE32It86NYdPmpL514CpjZcuXU67tYsblYvjTjB/gkFy
         pGIKeoAo7v5H99A6CL4CfzNPVi4nYGQRNNxG1NxqD/l68CWQ4maYx4EYPXVgYxelh10B
         wrxw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Kf1Gjjzm8nH0APziH38TQ2dCnZb1iwfTrHpUNMWAatAY4pzWg6FIgUszK/41C3b/TsQZkxjZOSSks4fVO66/@vger.kernel.org, AJvYcCXzk1fRD4K8JJxf6Cr/iqxJthfqvBLYmScUUocczWxBIsUYPxMr0PtH3oASllE+OzXmxBSunFJiGr5XzRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsB/iRQSCiV9VnkSh1gu4v0Kn3MWBC+YeQXxmeNLHgXPSxyckZ
	tmH7cUIWmYLgZzKa1lu/WehQAGhkjXn9AhohLJpheopQHiVo25/P9EcQ
X-Gm-Gg: ASbGncuVvnSF19mdOzWw/B3fjZCKyVz5crv3Qt1xnQQjC2ElBKGA+7la51CB5u3OT8b
	QbIONdyiiBjKjT+f2vUTgYCYDxv71PMxWQ04Madjqs06z4YU5pCWY+dInl9MQKXIhkRCzLIscUd
	m57zzMV/pTCGMvL43b2/DRLYFMQNGh8Y35yOx9UWEyMxPyNLn28z6Nc22EJBenzuhLY9UW9S1e4
	C2M9TXBwcfA3cAVTScY8qV3L4YMJv9dSV+bA/yIPSg21EO1WXdoqt0i3CDxDhrbscdX2kVi7y/L
	iCWM5ZbQzsenuRNZi8IOQ1D20aR/EUm4RpCiBRaMBEM90WPA6sgrmHpJuohhs1UGNMt8XSS5gZr
	8VyAplLxvqxetEA/BAkMoOw==
X-Google-Smtp-Source: AGHT+IHbu6+/jA8LdZVqHL1WWQcHp/s9Y+pab9NC8J94dNGk70WHYDDncBcYtCWmCpOWWCCNlU7Qbg==
X-Received: by 2002:a17:907:7213:b0:af9:9e50:470 with SMTP id a640c23a62f3a-af9c705a837mr672476866b.28.1754764328248;
        Sat, 09 Aug 2025 11:32:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99148eab9sm752111466b.77.2025.08.09.11.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Aug 2025 11:32:07 -0700 (PDT)
Date: Sat, 9 Aug 2025 18:32:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ritesh.list@gmail.com
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
Message-ID: <20250809183207.yx3eetkmr7bd3356@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
 <20fb853c-7d79-4d26-9c8a-f6ce9367d424@linux.ibm.com>
 <20250805170353.6vlbyg6qn5hv4yzz@master>
 <e9079694-1e30-46b6-97e7-b79be01c65a6@linux.ibm.com>
 <20250806145432.nygrslkiyvzulujn@master>
 <111d2351-3fb7-4011-af07-78b40874d956@linux.ibm.com>
 <20250808025804.b7cv47gcq2yscka7@master>
 <c237c703-3ed6-4d7d-aaff-bd6291f9220f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c237c703-3ed6-4d7d-aaff-bd6291f9220f@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Aug 08, 2025 at 07:55:37PM +0530, Donet Tom wrote:
[...]
>> Thanks for the detailed analysis.
>> 
>> So the key is child has no ksm_rmap_item which will not clear ksm_merging_page
>> on ksm_unmerge().
>> 
>> > So, only processes that performed KSM merging will have their counters
>> > updated during ksm_unmerge(). The child process, having not initiated any
>> > merging, retains the inherited counter value without any update.
>> > 
>> > So from a testing point of view, I think it is better to reset the
>> > counters as part of the cleanup code to ensure that the next tests do
>> > not get incorrect values.
>> > 
>> Hmm... I agree from the test point of view based on current situation.
>> 
>> While maybe this is also a check point for later version.
>
>Are you okay to proceed with the current patch in this series?
>

Sure.


-- 
Wei Yang
Help you, Help me

