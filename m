Return-Path: <linux-kselftest+bounces-27293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496DBA40D59
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 09:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D06189D3E5
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089C1FCD0C;
	Sun, 23 Feb 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIi2CuPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC42AF0E;
	Sun, 23 Feb 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740298501; cv=none; b=NKutqkvu4rhotpm3PI9Z/0ElIzzFK3fqrdiuJsULCKtkgyxIXKqm/r6kmfGmyT+f3ShTmmU6kQYs5XY4AygA7Cob/OofJFYeI9vMCvtzZqR/wanouH+Puj/jEdfE/Hh+MrBojuyOeVyO0orNEK85YuqIdJ66OFAHdaZguURYWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740298501; c=relaxed/simple;
	bh=cbzfrMEqZxRJLVM2oPP1TsaGDdKebLpKxeWTajkeyG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKRpHYP1e+e/JWgBaJYX4MH7+IXUYGl+BXAxuZZSHNcFo0NEKOJ55TOP1yKVZu3xaNqtfAaSPF1dWi4+yBsX9Q/i+BA/RkS4+DKSy2AGWaRSii8QgiZUYfJTMHYFwGuOBOSxIRf4445LZFTYDD/HMnGl2FVNCTLoL7UggHggzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIi2CuPY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c8f38febso71961005ad.2;
        Sun, 23 Feb 2025 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740298499; x=1740903299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKARCf7mqqryQEHenFr1LDZd8C0PV+DchvWZwfM2sCM=;
        b=QIi2CuPYjDE+nxDxgowk9Eg9E7u4zv+C2wKUrYaK+6gnauIV0vVu5LlWQFda94w03Y
         JWZ7j/uF3OBGt0uGC+fCnOHW0wqxIeNdm1U7jV4r17QQkiFcUPQA782z3N0rdXcKkViz
         r2KsANyC2KEKxG1wxBeS7LiEeBifBC8IDeU3ypn7WkbbMuQxgUULRUJrZ90wXwJh79PT
         79IElARBT1PnM8OgZ5TKegD0tgZiKpRLbfdkslJIN8PaFoBXyBgJ7HmkZ0tbvpTBCajn
         fY/v7ama/XMVBlqGEDjP+Qk6oLNVW7LTKKGeToSdnM598yOe2DJZkr/WpA0nUBlkUBXP
         gZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740298499; x=1740903299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKARCf7mqqryQEHenFr1LDZd8C0PV+DchvWZwfM2sCM=;
        b=j6yOfbSxpf/EUFmaz86rtfsbBuVrF9QrwQCklXms5eCzLQ4eH34oQWXBBrFnIAN12n
         dS6gu30Mt/I6erbeapjIltxkb7oFyCi7jFqzm5qpiTXSrtjT6ZjTai/l48g3uiaQ4klI
         DJUIyNj94dRNjSzw98eCo0xLjm6wVj5dUEcLCMPgNgXwVMlSQNISLbx50pyMfpOxGrD8
         2WxyfF7GbJPSmo8OcGPCpW3Zq6PINlS2dHRIjYoEPB9QP0Cj4kBrucrzrudbGOx0BCbj
         mc6B4NAsJRYC5GSAoFyhkTaDiX49G2G+LqZV8KUbbkdvDU/f7Dk3L6vDH8p53C9LAI90
         2WDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8iAcLRTWzNssgLcky8X9Pmto7slivKcxdR56WrbYSuX+FHFXSJg8rI2UlBGgi+hV+85J/KkFSaAMXCjMkA4Ek@vger.kernel.org, AJvYcCVwBfhgAFk4xOLI2Bqc2DXc2LgOxYvQ31OUpvV9mVgvxTBtZeMOXBqI/vx3PzUNhpwCxqeBn53qckQtZsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNX14Fj1ysT+tRQ1lco4KnUblpKbWxFUOXiu4NBgDU1DBddvRp
	orykHkSPG3V8SVBGO71Wo2xBuQPk7ZVxTx0jeTBvUdm2IYXPKh6/
X-Gm-Gg: ASbGncvkxmYuIdVWl+p89XEK+Jw+6+JZsMD/q7RkPzAsqz8fC0VyQn8rjcK3kYfniYJ
	Mx5UTfDDwjaVFwDJXJUspcOMZuXBDnRnt1P1yd085I4xI7gVc/PtBej9aCp9oMZYIxJ7mY39cCE
	bHqO1Y38ObQos7wmCOcSZSmR51QQc+qxH2p28A8ONV2jTSxbwh0oHxXTU7nXm9I8sJbYYHeTbyk
	UmlDGiNfT5o+ZDbEiRaaMGVrHAIuF5AxkIVotCtaZP5Gg4N3CboncWqwPScYbR6EEpH/O9MWnip
	q9APxHHrrQsY6kSkgWN2EboAIIZjvogFFmYUHkx3onw8/hJf
X-Google-Smtp-Source: AGHT+IGWqsGVBXu6QfQcNok6lJbLQAhcp3fm2r7bxkGvjKrRVRv/3YPfBgx0XgSn1Yg3T5NKwLcEqw==
X-Received: by 2002:a05:6a00:228d:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-73426c8d24fmr14045326b3a.4.1740298499449;
        Sun, 23 Feb 2025 00:14:59 -0800 (PST)
Received: from ritvikos.localdomain ([2405:201:5501:4115:b161:5a88:9ecd:1b07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326b5ef448sm14536311b3a.173.2025.02.23.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 00:14:58 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id E9693ED9140; Sun, 23 Feb 2025 13:44:53 +0530 (IST)
Date: Sun, 23 Feb 2025 13:44:53 +0530
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests/mount: Close 'fd' when write fails
Message-ID: <Z7rY_eAnaXfnDjtj@ritvikos>
References: <20250222114709.50011-1-ritvikfoss@gmail.com>
 <20250222121249.50588-1-ritvikfoss@gmail.com>
 <zshes4xtyir7zrrybeqj2amrxyctwqnuvx2tqyktv4vsfstxqi@pvdq2rb5m47j>
 <Z7qiOE3EXo8BtdY8@ritvikos>
 <5lkv3sotpv6pvs63gds5crwkrvs5xjtdkjmjcnzrc3c6d5s2wg@gzzfvghkp2qm>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5lkv3sotpv6pvs63gds5crwkrvs5xjtdkjmjcnzrc3c6d5s2wg@gzzfvghkp2qm>

> Yes, the kernel will handle the 'fd' cleanup automatically, but
> the existing implementation already closes it before exiting.
                                                       ^^^^^^^
Whoops! I meant 'returning' there.
Wording issue on my part :P

We're referring to the same thing!
Thanks for detailed response :)

Regards
Ritvik

