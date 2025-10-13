Return-Path: <linux-kselftest+bounces-42994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFBBD3843
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 145E24F2AF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E01E32CF;
	Mon, 13 Oct 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XaYIeMNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824C17F4F6
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365702; cv=none; b=MqzrI5hwkzrlE0igIJfksaDMGWk6REYG3gMseYpAK9u/00GAZ8s2bOdZ0S87uq0F7Iz/U0z/KqQahxvVjUNAGSKVE0jel+ZtWly9tw972vkH8VKqeuA/3vwLaXxf70gINnpRkX0ws+PV4UDwnUi7sLmT7kdVznHqblmhvQwE1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365702; c=relaxed/simple;
	bh=qSDOgIegj5/7OLJprxaVbbB0TVpZscq3uNLHReohDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhUvEf2sPrI9shD2aTCu9U9i++p8GrwurgE1GnoHkAeAhsKyDnHHKREURuKxc6dMNlOjwqHVvpjvrvhemWFGi8ak6isVcrzXtc921aBp6Q14m9L1ejr38fNC4OabAuYyHWjYub/xaCbPWbxfq4Y8JDuWRAwhhJOSGKuNnNcTS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XaYIeMNG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2531086f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760365699; x=1760970499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Wf2L6pRYl1VWb9gXubP9G4VQhPo6XTkf/wwxr/MaM=;
        b=XaYIeMNGWaUgtVrfEHK9RXbqupkAyK6JPiln4+2GcmePr48TF0fHvRzCWLj3/zv31Z
         PRLsfJbO2EnTlSd+UD0HoeN2IIZti1anOjPCG/a0hk2K16r0uqj5AFUyRJlVIxeQwoeY
         hiAzVVSfdd08/3zoTYploLsWVggZUJCUmF7H19BA+HVLe+zDR2R8VHD7COhw73DqPlUs
         Rypi7om5ai5boUK9AgHFspy5l9461mUrmn4FAShnBsAaKGmBl/T7cYZVoj6nXiHcFM+Z
         NdSYLr7bFkx1sGczW9vJ1v4je0leAkEL8jwH/qoF4cqq8bebXqFF/ZXmyf5cDBQ3RSpF
         Apiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760365699; x=1760970499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Wf2L6pRYl1VWb9gXubP9G4VQhPo6XTkf/wwxr/MaM=;
        b=o7/NiaOH5HA+YW8GroNvHuNCsbBWZG7B7lJjC7Ct8gLlgIF11qEOEjqwYPeS/YTncY
         atOoBN6/p68l9bbJcm4c6SpwlSz0F+AQJtRnT16eNU7ZQkL3NiHdZNXxbpr2fDZoi5Qd
         GXDaXQva51ieUNJp9yaIAtYepJbM13omMN5xyscNQ1Gc/Rzmo8AbShrugECOftudTb3H
         tFEqMNHXmA9oWz4vcLDeMa48HXAX7E/I/1wpo1kYfwMWieD6PlAt4tPBIv/G92BqBAjE
         4gAWultHAuidIZRQp4GEMnfQb2qIDcCfNdeKQCbDZmyGq0FoRN+n+/7hEuAVnlYPPZSN
         0/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqhDRYacjiJ67x7DnIUjcoUSho+ZCNvmtw0HFqM/CMnnjIzKZvzmU4Xf9eAp4QLlMvUK7Zlk1jKeCehW/55cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlycNx9EIde/bnJoWQQrMT4f6cyFjcNX8Fn9VhoMu+wImZDlz
	iaQTYTxdl08KkTGMgSm50BRvNwq7WYLiGjEURbElXaou/PRjXr8vncst9jPyABRxEpY=
X-Gm-Gg: ASbGncuvGaDJhy7rUXtQdFkwYAnzoRDp5LsjO0uHT74mYpNxtEZPfmFaXKbABsNG0vI
	RFIJMqMA/GepRx5y4cP7i1TbxE3iRkRp6cwh6s6YqpWb/ZwcoQv8G1LU2bfjjkiPjF67qPtJBzj
	ANsfzNup9Kj/OZW8g3DcmUnEvPXBp8/qROoY0hOPNkKZgRM7NCw2V/syKTgunHdZdR5n+Q6NaoS
	na8elCCEbLz0r4fbdbfTcIf+tA3NAmwDI/teyPBZ31z0LbK+I5+VH/tUY630WIDOqkRjqhomqeG
	sPOAlWDsxz0xTRwyBhbZAnfyK3R7Uu40JhSKSJitt+ZtKYNJXDI7tPLGiGz1Hg01/kvvYD5eZD9
	I7Jw+4ld9KPp1SyuJENqYKrzPdJw5/2h/6TJ/0jDXt/o3QJUBbM2g7EA=
X-Google-Smtp-Source: AGHT+IGNKekYnqITqrySsaLWx5aXn7KMrPP6CFyNtZxLh4rMKjgJfx5OlzNfjh75l7Ry68CnQOurFw==
X-Received: by 2002:a05:6000:2586:b0:425:73ef:b034 with SMTP id ffacd0b85a97d-4266e8f7f4cmr14241752f8f.36.1760365699040;
        Mon, 13 Oct 2025 07:28:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm188616535e9.0.2025.10.13.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:28:18 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:28:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: use canonical ftrace path
Message-ID: <aO0MgOhfrMAoPchy@pathway.suse.cz>
References: <20251010120727.20631-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010120727.20631-1-wangfushuai@baidu.com>

On Fri 2025-10-10 20:07:27, Fushuai Wang wrote:
> Since v4.1 kernel, a new interface for ftrace called "tracefs" was
> introduced, which is usually mounted in /sys/kernel/tracing. Therefore,
> tracing files can now be accessed via either the legacy path
> /sys/kernel/debug/tracing or the newer path /sys/kernel/tracing.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

