Return-Path: <linux-kselftest+bounces-22533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5179D9807
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE207282049
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63201D4340;
	Tue, 26 Nov 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZ+nKnx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D61CBEA4
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626522; cv=none; b=N0tQIXrPjjt6EH2UZefDIWiNS6NZt//f/l+js+yuq2XcU1KSITEM8TngXOVtNS79eUYqeDEF1piAaFVSrd6klLuwsuiJYpBiBxoR3V0sRV1iqwLoZ8CTyN2dyOom9P5hOlA37xSED0yBP4FlUYU3H4WDiAy+9IRRP5k1Q1vP2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626522; c=relaxed/simple;
	bh=jQHJQQidNbNUcgbt21fubMe8SqP8NtfERFhpsdEmuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8pStt5ip0Q6feBqwa2vm0fKoOvxMXYpG99P/guD/CO057apX5m24DuCJfd6WL5gpFHT72mE+nm09Xghr7lN9OmlkFL+Ua9TmHl0TYkZ+D/oxIB8x17lWsoM2VJYX+0MvEL5peIgSqEt1q8AmllzLepimoQdgatU8qgwexxsi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gZ+nKnx+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso51635335e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 05:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732626519; x=1733231319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EU1FFuJWDKogHlWGs2wUOZ86NdWkE+VHCPjkTaTPb5o=;
        b=gZ+nKnx+1JrqlIN7NIpqKzAByijs131QXGQ7YJlRjpcGFusOakzqfOZbBdZTHfkMOh
         RdOtsX6SbnLvrYe3DLyJIT+NW9xqYb12/uX36fWYtvlpsWnL6faobVozkwcBwD3LYfVJ
         OuxciqndSn+LoepGzFfTGeEMtmVXAe2QXAyUYV2SMz+bDLAtcGu2b3MXlhOSWAEvENdw
         K/JJOwzVOnpbbejKBrUAucvNvk8+zinzYJWj3I0Stor1Z9vbqAqBsW/QoHt0AE2oIvl4
         tbDy1JbvROKjyfLO/bQGs8NJ2lOAMuk5mSZEh6m3mKKuKOZs0WzxWEH1/M7Zy+nQ2L5Z
         EjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732626519; x=1733231319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU1FFuJWDKogHlWGs2wUOZ86NdWkE+VHCPjkTaTPb5o=;
        b=rhwn/TdEUjVwJ7jrihk6XYBkrDhGATwO4dtQOXvC8AlKIQ+OSD3PtINhV/3E9YzDl/
         OaIRDyljQz7a3OcB50xWRtRqf/DzZFq4fgBmATEWoHT6A/WRDJxgZPpdvOaFNvRPNHWK
         7AjOwFS5i4K8JAVsYEyo+0zPmbQ/4aOZAcmk9+VluroNTx0RRDCg60QCeWZrT3SItNmy
         f0FycyMsrAmFXM4CDKjC1qaQX6A0cFD4KUS6zEScBxrG+tDrSur1+TfsoluPqjT1XeoZ
         djrqfF8OMvczWrLGSdZKb6MXAnleEEaSFroDWyBiqOo6o+5Wn7xMX/yCp36unNw5Qpnb
         HkWw==
X-Forwarded-Encrypted: i=1; AJvYcCWmnYhpiqFH3vJC8gRRlxJubn6DKlWDz3ztLaaavrAh8dHl/NNyjAZt+NOj2aScrbGwqJWE+M1qoEplg5w1tLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9klrQlh3prtCFxzzyMpV52QQHOhe4tb914SktvnDtZvWAf1H
	NcucAP8By/aCuc9VN4575ecjvu0uhHFjB+W1wVEEOEvjsfhOTJekxdsx+D3vbOk=
X-Gm-Gg: ASbGncs4+kw92YgSg0SYoug1z971svL588ijkTd6l/Dd73OstBR0oYhCKv8H6SG7GcN
	YIRScERdNpnOCphqXPx1pkH0Us8Pi7rSkFNHm8nvHOZsFuZbIJUxzvoj4ADXddj2cnK+BLMVk8O
	YLJnDkWzGjLXJigDCIZ5D1wQPImHHC2+H0W6IiaONJ2vs8bKDdNfr2m7541zxHjmHoGEiWth3MC
	kcCDKmf1PembIBhYOykKmnTb9U2jXqIcZOEmq5LMPx52ygxqIY=
X-Google-Smtp-Source: AGHT+IHIHEiY4LNIwECV9uQMLGLQvbtYi3+I3aK0yZuOUqtailKy9apEj3gRf0AYBQIaYBa4yUIKKA==
X-Received: by 2002:a5d:64c2:0:b0:382:2a2b:f81e with SMTP id ffacd0b85a97d-38260be4aa2mr12232395f8f.51.1732626519211;
        Tue, 26 Nov 2024 05:08:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb2683bsm13438746f8f.48.2024.11.26.05.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 05:08:38 -0800 (PST)
Date: Tue, 26 Nov 2024 14:08:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH livepatch/master v1 1/2] selftests/livepatch: Replace
 hardcoded path with variable in test-syscall.sh
Message-ID: <Z0XIVBrwRJMB594e@pathway.suse.cz>
References: <20241125112812.281018-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125112812.281018-1-dongtai.guo@linux.dev>

On Mon 2024-11-25 19:28:11, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Updated test-syscall.sh to replace the path 
> /sys/kernel/test_klp_syscall/npids with a variable $MOD_SYSCALL.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

This has already been fixed by the commit 59766286b6e54f8ad33
("selftests: livepatch: save and restore kprobe state").
The change reached the mainline last week during the merge window
for 6.13.

Best Regards,
Petr

