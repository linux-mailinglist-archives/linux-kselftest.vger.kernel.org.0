Return-Path: <linux-kselftest+bounces-29222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A5A65180
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E7316681E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD323E344;
	Mon, 17 Mar 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="l+N8vsSJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7921E098
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218858; cv=none; b=G9Koln9V6wAxZ8mh8HBtF3zPVWuJIjbjIatLOEzH1pFt2OJ5I0MBZYrlm5HnPqizcQVT+/ldU92HamXi6pupZt3byuGPhVv/IFB0BisR1Z3k6Q4DqUVEzGs8J7g0vhZq00eN0dZ94ET6SizD0QnUQhGAnIPHOpbYzOvJ/gHIb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218858; c=relaxed/simple;
	bh=kLSXiwVSzmLJ0MkmFRsFE7u2Alq297XRhanMJ1TeTeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ1UMQTVATK5pvZ6EULqa7FlQhu2mSaX++xI8cWIsgrXQWChWdQIO1f9ik4s5P0rVu/s3XU+78OpYXkjVQKl9zG/+8DrDP096uZCYqrTvMjmIf/K26y/XQTA2AXi2HdJFT+me1VKjAvYi8y2pfHjGAoKPljQ7CgZTBqWyAAyYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=l+N8vsSJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso944698a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742218856; x=1742823656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnsqm3xmIvcxIgATEk9k0TzoObowoxe3J0tHhRinQ2M=;
        b=l+N8vsSJZ81ZyPCBFJnasj+AZl7OsIaShD4vGQXCwbsDyedWJWx8fz5xjaBQ5s7j/P
         dw/i8awHhWoUIME0ifbvVKFvICS8PLO/Mx+oW1/NttWQjQ+7sGztMtqah99IBLGiDrwz
         I7f/CX+TocbHaJxHWBEdBvXn2TCFi9Y/hhPOI55fZjlKlKxk3V/iUIp9jB3k23aUrjk5
         aizezf7fOEkjCC0xKnrknkpEfcTqeYqGmlkdbcYxZe1ysQs9ZFu3E53T3UPPfmOti7Bz
         iny0hqNEE7yAHSQWTL6RymZyQOlvfZhQ82+OiNrXVjPEiZ3IDh4j3hW1jBZ/fKe+Oh0u
         w4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218856; x=1742823656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnsqm3xmIvcxIgATEk9k0TzoObowoxe3J0tHhRinQ2M=;
        b=TSlCV2LeemqdpjwyLRtRWULpELt3uwwI8I/IfDFDHFekWsWUDxexIvdFmTyUXUQ9AM
         x5jBkGRhYRdo+AqGwj3MVkkdi3u+AmAUnrLPkuT5wA7r/SK+PJHsG7jbtR/O5wAIwmeY
         D+LFmBo68Zx7XPTrhhYN1cx8+jYpuy7dJumYu9QJ++HnRJLXcTj2VZ6oVWXGR4QTqS3B
         V8uSjA0JswQ9+wOPd3WTo5ZKMqZUYvBeslzN3NLQI33mO15NC3vRbyrVq3VYHOhObto4
         XW7fFQNnZxgiIToCyDFlqi7MTJQRBtrAMwVAu92hhy038aMO8uvtyBeHgte3DzbbXkUl
         K6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW9qEkgHpbKETdvXecGg+PZ9j0CB8ddOPRdl1uYr4KDKSHSc/nhdHif7LkYHThIliselJdohPqxkxGsmFoz0dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMpcAeslslhabF/01ichn4MKfJ3NEkvkdM+83mLdyoWaRTBVd
	Hcy+0AHEs/OuV85I6MYphhrOr6dMbCrozOp5B08K/vMzTCNLnxkZchka1IUwj0I=
X-Gm-Gg: ASbGnctGKX/Ug0LPMUrnlkKgLdJO+5BTmIHmXfJ1gLgUYUuyFFWSEWn3Uu++1/0g07g
	JRH2RhQ3qiauzfm/KAQUbCGzu0N5l+0VBviF29BhFjVooSWUeagxQXNGrGDL3HuQiPei2+dIVn5
	ZbyOIMqzPnY4FS1cNwLp3LiJhhGBC9GtNphFCdL9FlEcaUl46qihQAb0XyftgJAKWwMeoOJRVnx
	UoameYmOdjhJOYCxV4ubmnZiga6bsj0vAN/TYp9PL3lGgiwsL51PrhDHvJLQJcJ8hjTzDwxuQ6J
	n3kH2Bq8p+hA8z5knEYYKptwCfOy/wYY+SWPNB/y2BtQYklZnInNRZu4+i0TkbQI4oZTtwQD90n
	PY2VW+zWWrjconMPiH9/nzw==
X-Google-Smtp-Source: AGHT+IHcEtIj1ndlsH7GWBKxayrN3xYjDtV9idgB1vOjqL1ZjkCnhtkv9qTlL5li/uvQAhd8+4xc/A==
X-Received: by 2002:a05:6a21:789a:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-1f5c127a618mr18056794637.20.1742218856070;
        Mon, 17 Mar 2025 06:40:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea9724esm7183138a12.74.2025.03.17.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:40:55 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:40:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20250317064053.4fe8425b@hermes.local>
In-Reply-To: <20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 16:39:17 +0100
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int try_get_percentage(int *val, const char *arg, int base)
> +{
> +	long res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtol(arg, &ptr, base);
> +	if (!ptr || ptr == arg || (*ptr && strcmp(ptr, "%")))
> +		return -1;
> +	if (res == ULONG_MAX && errno == ERANGE)
> +		return -1;
> +	if (res < 0 || res > 100)
> +		return -1;
> +
> +	*val = res;
> +	return 0;
> +}
> +

I wonder if dualpi2 and netem could share some code on handling
scaled percentage values.

