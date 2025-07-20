Return-Path: <linux-kselftest+bounces-37711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A45B0B79C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5A21897483
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5152206B7;
	Sun, 20 Jul 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzhPoVlE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EB16419;
	Sun, 20 Jul 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753035723; cv=none; b=q7oRAiNpXKEL+knI3tMIZWMqy/qZ8d0fllG486rVO0G58rrJuaHS5RsQabhfmU4cGbH8l0Zwirg5wwb3ekDjIFVydq7ZO2cmlzRnA30zTHPlXcmOFTtM3dNKfAWliNIofvZTJdlAM3hNevwyNsvHT5JOe2RjK7M6Z9xLfhowQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753035723; c=relaxed/simple;
	bh=ltmmTux2NilVGFzUFT13M4dUh2xC9hu/9GSfoDzCZeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDr2QlTE861mrpdkcqpP3P72cwb0qAbW1bVxgo98ew2YpyTKhdSyG519XkH5ZCGF/8Hc6AdpdeikB2SkKUwQDCYSImMIkXTsO5f+62kqfW0W+5B5PDLqQx3haCQq6L3fkWFVF/EpQvfW8jzVG5e6umUKKqh7xv/nQ6EYxCwk/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzhPoVlE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87c04c907eeso162515539f.0;
        Sun, 20 Jul 2025 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753035721; x=1753640521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPYpBPG9Qb1AtXh+0ItStgqrppMKXfwOcPuWkilEesA=;
        b=HzhPoVlE7s0pGUh3HkbJ8xI2EHfI1h0RP++JKKPwa+KWxta2a/0USbJWDD9jmR646T
         U8GT/kjibASorY5J/Q2kvqTFqmvOMAslE14oenWGYmBsrU08LA1YGlBXyY+6VpCrXgNp
         m6Vh86msSRc4V6cdIqly7AZnezUn2n+R1ZiB6/TeI7BC3e3Fzi6h4w57OqeAp1fKrvIT
         hWSvmcNszQqavufP5rebraS12JnJBjJER0NVZKE0Rjhq56WS1kIrnJwHkP/Zgurj3mSx
         VUYJrSKT5I0DMReASYhJ0DJxahblPxZiB/m8FMP51wbx0MDb7w2V3xkh+JiISwn1Lhj/
         jzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753035721; x=1753640521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPYpBPG9Qb1AtXh+0ItStgqrppMKXfwOcPuWkilEesA=;
        b=vPFjEOZhA65uV71mfZHSSWmxuydQxbzEpngndDJKW8YcUogflO2Lvlno1NpALLjipm
         LzfcC9IORWp4Lm0iCu6KAXspJHxqmHwH0ourQK8eO4Zyyn1VLSEOUJa95fZiBZ6xh5rc
         1RIiTrBkkq4QiTQgvLli89gjicQB8g0YO3KV2FGOtKjO/2++xpmnqGRJbllTsm27fn4T
         4Ji7pp3KJFxut9+LghvRz5FLXsqyacUwJG3QNefSi/QSu1r4mEolMdwgik/49kHQxvBG
         uGJ1HqaJdJMqe9wt2lNpytXreOP3qbqewHf5Oz8yDNmF6Ec5ZauhBHZ+pXzJ/2ktgPKI
         pnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUqq1Z/3xmAlzUMBT+oYTc7GS/LlgXKqiCflzxZdK9ODZWPzCxiXFvA63bId5aUtqXaGSn31H2bwM9qyZw=@vger.kernel.org, AJvYcCXlgZ9ZZ9MWoGrHtiTXVOL8a87H/3zOWwwvkvBEFzcx1SG5XFxYmaXCMNRc+3SkmYSPSGjCze94JICLyzu58zKe@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxLavbo9Yr+PPHrWngOGVT6C6g5jskH5I6nnzpqLDMDM1V9Vm
	WNNmsTJNJNma5mpQpk1ueRCGuR6/+xI+w8WrQ6V8H4elxwDp4CkUJakO
X-Gm-Gg: ASbGncvbJA5Cuiz1KJwpKF33ARF7cLjRouTUnGA7cLPeSbfvaDO/rI5eOrvi1EfAaVa
	LDBUa6RnW0jmZlhNqvT8Rdc8HRmrW+mfg73vHPre54y9c/a3SswwaMlBTmA9+Xr7pnw4jswYh7b
	MIqTMk5KJEKfoUedsqczgUhJeGO+Z/5NM4tAYgFw2v+ogS3S7GPDqnV5DMRNxHORbEUNq/Rbizd
	9g2O+x3DhDhXmDJvC0KgBNOoHe1ZrN3QlcYMa8+38YiA2ronAFxlfl/M+fm5MhIfJkOTBKPP+VI
	hE4zCN24nXlmJFedldKaa+TOpNN3O5oTqYXNHipjWozr7hzpDckpRCMyptJwWKnW49QGkdDXedC
	qh8vMgEnlYkzl6tJTP6iLPz4=
X-Google-Smtp-Source: AGHT+IFJ7FuxrZW3SRuCNiWZXW68IyTRjwhtFxBNgTGeNBIS1dC95giMClSGddvXe8EzMHgEMN7k/A==
X-Received: by 2002:a05:6602:4802:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-879c28846dfmr2342066239f.4.1753035721327;
        Sun, 20 Jul 2025 11:22:01 -0700 (PDT)
Received: from harshPC ([2601:280:5001:e810:5a5f:50dc:a4e2:586a])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c801ff8sm1406342173.55.2025.07.20.11.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:22:00 -0700 (PDT)
Date: Sun, 20 Jul 2025 23:51:59 +0530
From: Harshal Wadhwa <embedkari167@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: firmware: Add details in error logging
Message-ID: <aH0zxwC8eJ2GhcXu@harshPC>
References: <20250714212650.17935-1-embedkari167@gmail.com>
 <934dae5f-88af-41a3-9a0e-3aa5311b8f11@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <934dae5f-88af-41a3-9a0e-3aa5311b8f11@linuxfoundation.org>

On Mon, Jul 14, 2025 at 03:39:47PM -0600, Shuah Khan wrote:
> On 7/14/25 15:26, Harshal wrote:
> > Specify details in logs of failed cases
> 
> How about changing the above to:
> 
> Improve error messages adding details on failuires
Will change this in next patch

> >   	fd = open(sys_path, O_WRONLY);
> >   	if (fd < 0)
> > -		die("open failed: %s\n",
> > +		die("open of sys_path failed: %s\n",
> 
> Why not just use sys_path as a input parameter to die()?
Sure, that's great. Is there a way to test these changes ?

> > @@ -129,8 +129,8 @@ int main(int argc, char **argv)
> >   		die("error: failed to build full fw_path\n");
> >   	setup_fw(fw_path);
> > -
> 
> Why did you remove this line?
> 
Will remove this change.
> >   	setvbuf(stdout, NULL, _IONBF, 0);
> > +
> 
> Why is this line added
This too.

Thanks,
Harshal

