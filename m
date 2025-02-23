Return-Path: <linux-kselftest+bounces-27292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C64A40D31
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 08:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E67189B138
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 07:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD11FBEB5;
	Sun, 23 Feb 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClrkNPvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A153FB3B;
	Sun, 23 Feb 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740294020; cv=none; b=FbR/4w3lqH+Yv/fcb4Os7NHI79pjH0zTgh3dFP5aKyIg1VfZENuGUjwHCQ5E6WV3zYWWqXzqC2tbMRSWERkPRnIjQ23zuXz7Qq3iCbmiwF/hWt6pPndLkRICXzynwlLBG/8UOWK0N6ErJp2Se/6ZCqQGSIbTF6etnOWW1tRYJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740294020; c=relaxed/simple;
	bh=ib5TwWcaRw9LUXjvbripaiMLqsuKJwTrOTJaR27F0So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoURGiZjqnI9JE1P2pwy5az9xmOA9Ex8E73hLWupao0ac4jjwQCurZ/Jb3I+jq/UtAA7NFMQsYYSdeKOPA6H78vffhd5qTscLyv+DTSYYIWSSBrYAVbEuk00bbpq0EmD8C3/nbrXdnn5GG5FxqkPHuNju5Xgy5UODdiOjwGpRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClrkNPvV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0ba9825e9so218413085a.0;
        Sat, 22 Feb 2025 23:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740294016; x=1740898816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AsXxvvW3BkHd5vCQu8R0wvKfYc8SOGl6m/u1V38cEI=;
        b=ClrkNPvV0lLKTo28cvSRMLF35s0L3WuJAveGNhAz5VWTzPOLHatl6IWMAXeeMsyicq
         pk9KgeLg6RsMib53Ox05N8rDDt3yuoJHWs3wWGUS0rhKGT17gs3alTNaPcm39/gnKxZR
         zXZXqo8kycj8wuNyVEFyOp5t5LKqjQDGPak42TuWtvFP2341W3heoQZSqJtCf4Lxn14J
         Ter9Wfukoz8bqyA8/r7Shi82tLnB+vv9FbON1eVLkvTR/dGkjIvK6uhCfjd4MtIAmuSt
         SlvxGhOPwe1BZ0jpGd9rc0H2k0K5LXwVY2ORNSM2GSnAb2nrI2wYBx4SDQ6ePe+LlN7H
         pPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740294016; x=1740898816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AsXxvvW3BkHd5vCQu8R0wvKfYc8SOGl6m/u1V38cEI=;
        b=gbeC/0+DaKPiMK55gU4SBhwnwsnyUu95L1LrSsl0Ct3NQnKT0WgwC7kKW02fpFiZH8
         AtPuXxf7/Qxtuc1xX+XbsSOjDZdYcYq3dfxEalmFslCjs98YUCK6CLIc2SdDHui9vsuH
         2/jlToAS9J//SbNMqfQqDF+cN11yVDt83JpVHDgIbwRmbVbHM/kWP56Ypw+a3sEtyLuk
         J/u8l3/NE24IuEH/JDWCIQbvrmpSRrTOvdK8oOkk9w/PloTjUF8NdfoklyMJRnULCeB6
         CI7/GQlkYN13OO3+sDvt18y+4tN4GV2Lis8fuTzMkpuqpzAjC2oRh+DPLukKPkHJsv9d
         Xqiw==
X-Forwarded-Encrypted: i=1; AJvYcCVK7y5GIq+Zcoo1V8+qt0jBmblJ4PEORIyp6rOCg47pDpCWxW9INVCWjTCSUktLhkJp3g8SwmlzIYgrRL3Kl3zh@vger.kernel.org, AJvYcCVnZqjXmejpYzbtroEJUhmiIfjQn5u/kjCUQzX9wFQ50RucAHrlECbTtbTi8LasQPMg5DkdHx291m733kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03lUV5C0bbV4ECdwVx6xmUOp+xq9SH+fIlq6NglwzAin22LdS
	Et7XPKxuQjJJbWdeaQ7BHYhRMaMBly07o09wZiZ5slU1OJ58Xt5HqBMFf3rj
X-Gm-Gg: ASbGncty8XA1bSMO5ne4AhPvtus+J4kiYXOMdAXHdQQII19GLWdhr/uWGVohDJF4l3B
	/SZcOLr9jfYNine8AGnWFqU7nHejmuOGOwnKJAB8uWM1ss7ohSzAkSrKx0Pa0vausmlFqfZj2zm
	J3n9IYaDPUwqjRTN63WFXPVSdnbYEizAORhEZYnFgJVFqrE6Faatfd12i9KtVwvHfByp+m6zPAT
	3F40hWuOpNGl/2yo+M47b2dGhyULVzuf3wI0s0Pgppkoig9FsukvCVvgt61cm0bf9wngEMIU8XM
	iefC2X7FJiLs3GfD5lozPPY3RHuUidJ+WxeRYrDmI2RaL1z54HmxO7Ujkj6zYQQGiJ3Sb4e/c7Q
	cwdWE4+p8hTB3
X-Google-Smtp-Source: AGHT+IGI0f0oWVpNg7tVGkpoHA4BuZEzcJvgGOpydcBOqIapcgvSQZaqqHx7a34SYNJMw+t7zyS87w==
X-Received: by 2002:a05:620a:4083:b0:7b6:d5b2:e6d with SMTP id af79cd13be357-7c0cef539efmr1335787185a.35.1740294016626;
        Sat, 22 Feb 2025 23:00:16 -0800 (PST)
Received: from localhost (bras-base-toroon0648w-grc-10-142-198-73-227.dsl.bell.ca. [142.198.73.227])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c0b46649d3sm581990085a.32.2025.02.22.23.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 23:00:16 -0800 (PST)
Date: Sun, 23 Feb 2025 02:01:10 -0500
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] selftests/mount: Close 'fd' when write fails
Message-ID: <5lkv3sotpv6pvs63gds5crwkrvs5xjtdkjmjcnzrc3c6d5s2wg@gzzfvghkp2qm>
References: <20250222114709.50011-1-ritvikfoss@gmail.com>
 <20250222121249.50588-1-ritvikfoss@gmail.com>
 <zshes4xtyir7zrrybeqj2amrxyctwqnuvx2tqyktv4vsfstxqi@pvdq2rb5m47j>
 <Z7qiOE3EXo8BtdY8@ritvikos>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7qiOE3EXo8BtdY8@ritvikos>

On 25/02/23 09:51AM, Ritvik Gupta wrote:
> Yes, the kernel will handle the 'fd' cleanup automatically, but
> the existing implementation already closes it before exiting.
> However, in case where write fails, its unhandled.
> This patch addresses that gap :)
> 
> Nevertheless it's subjective indeed.
> Thanks for reviewing!
> 
> Regards
> Ritvik

The current implementation doesn't close the fd before calling
the die() function. It only closes fd before returning because
vmaybe_write_file() doesn't necessarily exit the process. It
only exits in failure cases, including failures when closing
the file itself. I think the close() failure path might have
caused some confusion.

Cheers,
Seyediman

