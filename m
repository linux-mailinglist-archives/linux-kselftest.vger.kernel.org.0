Return-Path: <linux-kselftest+bounces-22762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A09E2BBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 20:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963A2B25410
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B71F8AC8;
	Tue,  3 Dec 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ahu4dCmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA01F8937
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243176; cv=none; b=mRixpmmjsaX21NEMh43FFOOG5D/kcH5SQurhhJcTN+tEAWxz6A9orUP1/oZIfBOAXsRNTda/jOcilUDph0fSF1ofo7mQmZEaTVKx9W9a1znNkKwjWbSumlZPxWVU+BSBtIRCE1G3gjLdP62LHUuv147ccwVSafQ3lVpjT6s7Tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243176; c=relaxed/simple;
	bh=iKSwEj1QUd4Z6seRbKb5DsDKmOf5JRe9IWTGuEMsE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6Io7pESfK5rSo9iu5O1o5CpERIbumPa3CjCPqKqN/d4+C/nDYuyA3ziT/W6KDzeHuUkicXo0wfX86N75iHbBoD/npfMSEj2DNn00JHDItkkV8s93p528QeDgetUSaEQ3yZbGyd5t4YW/DLKXLWwqbIm5sugq48uIdIKTYCBrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ahu4dCmj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215c54e5f24so7637915ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733243175; x=1733847975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=ahu4dCmjkZTiR4ojorbUJBdR+FTcaT24z/zcQ7esS0rdl8zGd/IKd7emi5GUZ5rm9M
         Pv7LMHSGqj26NLS6rJyR+u9tJDbvh6vuiD/SqCL0isUYFhtYY28Pt9AgzekZjIHX/Gf1
         rKfEV3EWt4jGXtaCwUTsl+ZPS8DnuJndnNynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243175; x=1733847975;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVMAhkmNKECc/EhK+RjBpCowxBMGNxsxV6VjcSeAbx0=;
        b=sSvnL4oxZK79f+pF3j2dF/Fh78wB0ZNMe3FtnKM9WkBD3O9gktWepS9i/x3wTk5KpT
         ntOOII5nrMlb+8Qa2OywL5Tmd4YUkyRA1iTWyr5QJhFH0Ckq1ZD8MYU7tm5HmYVTB6V6
         zTAqpJR/f1S/2uSxi6LjbGQdLhN9OKAz5Eg2wm31XeSNATeYVq4mQyqpZCVHfunzshMZ
         w8M32wLKr49gkPXvfxGEQvoNK2oDI9vad72y1nkhPHepItjzJXhgLoFJ6p3iZpe/vn5s
         7BCUOI6U5YkbEhymT4slS2uj8QTBmipmaBSgf8i2Z4lx9jz9DUkTcx/oXNiR5ebALORK
         Fv3g==
X-Forwarded-Encrypted: i=1; AJvYcCWiZOebVkjgrNeO1T8Gnlxm9zXdO0B0r/kdMr7o4MrUGcdr5vIaAx0XbVfJn3AdhyDMBWSDCGFI8v6FtwQKBfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dCw+xiaX/BHQ5qyLurQq9XGikAcs5XhRcBCFuoPefiknNYdu
	9CzElnocETB67fWJl5sBd7YD1hdGtpnnrVQQIalxHK6y2vZg34uxKpuW/S1OErU=
X-Gm-Gg: ASbGncuGwLyS2hyNDp0SbzjL5VHjW0hUTvWq13kTqpmZFAcpbXGGQxk+p5zhGkKpWdi
	/QHifVpt8MCQH9ErS3hX0m5iGSXA4ySZwSC+VMqUjNd3kOY3zorzJ0qvWTlID9UJOHvxj5A7GkD
	rFwvJHmQN3H2X/YgrPUXGEcs5m9f77GAfPrKLRgii8/Iz3fqL3pDBM1NOROtCFSjmMZWf3kgsDi
	CQNDZECrfgXE+Y+HXB7dGzcU0xw4ObcEWz3jc9RmIw3wC20HbDmZ6e+96pUCJR8Ndi+UGfdjQ09
	ZjyM2rJQx+8bNb/J
X-Google-Smtp-Source: AGHT+IHbJxCIE7dNvn0u2Dahnh6gAzNdniqSXv5Pmp3C2Lyxfg+sQF/aKgavRzPI6bN7e0mY9bjTHQ==
X-Received: by 2002:a17:902:f686:b0:215:931c:8fa2 with SMTP id d9443c01a7336-215bd104617mr41724185ad.33.1733243174771;
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f479asm96731665ad.41.2024.12.03.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:26:14 -0800 (PST)
Date: Tue, 3 Dec 2024 08:26:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mkarsten@uwaterloo.ca,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: cleanup busy_poller.c
Message-ID: <Z08xIyc7OcRoEE-C@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mkarsten@uwaterloo.ca, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241203012838.182522-1-jdamato@fastly.com>
 <Z06T0uZ6422arNue@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z06T0uZ6422arNue@mini-arch>

On Mon, Dec 02, 2024 at 09:14:58PM -0800, Stanislav Fomichev wrote:
> On 12/03, Joe Damato wrote:
> > Fix various integer type conversions by using strtoull and a temporary
> > variable which is bounds checked before being casted into the
> > appropriate cfg_* variable for use by the test program.
> > 
> > While here, free the strdup'd cfg string for overall hygenie.
> 
> Thank you for fixing this! I also saw them this morning after a net-next
> pull and was about to post... I also see the following (LLVM=1):
> 
> busy_poller.c:237:6: warning: variable 'napi_id' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>   237 |         if (napi_list->obj._present.id)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:243:38: note: uninitialized use occurs here
>   243 |         netdev_napi_set_req_set_id(set_req, napi_id);
>       |                                             ^~~~~~~
> busy_poller.c:237:2: note: remove the 'if' if its condition is always true
>   237 |         if (napi_list->obj._present.id)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   238 |                 napi_id = napi_list->obj.id;
>       |                                            ~
>   239 |         else
>       |         ~~~~
>   240 |                 error(1, 0, "napi ID not present?");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> busy_poller.c:226:18: note: initialize the variable 'napi_id' to silence this warning
>   226 |         uint32_t napi_id;
>       |                         ^
>       |                          = 0
> 1 warning generated.
> 
> Presumably the compiler can't connect that fact that (!preset.id) ->
> error. So maybe initialize napi_id to 0 to suppress it as well?

Thanks for the report! Can I ask what compiler and version you are
using so that I can test before reposting?

