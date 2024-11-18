Return-Path: <linux-kselftest+bounces-22171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A299D0DCA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 11:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB5B2822D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B7192B74;
	Mon, 18 Nov 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+F2JxXO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF83D551;
	Mon, 18 Nov 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924544; cv=none; b=DVAdD4uUZJ6p7TQxbo6nhj4s9+SpB88R5cfEkcrP/SUXTQnv5w0AMy5I0qAKXu6qIlmhdV7tE1uhfe95RbTpA8CJcr2X7kskz0Eb3No+1HdEOOcZxuSPt2mpUYlM9rwv7xEWlyvkHo2ye/Kyls/uAFQiNmNeTkGb9tK/5+L98GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924544; c=relaxed/simple;
	bh=uOa3gBdo4b6Q4eMJGRlTULLTC7vcRFD/paGu9QaEraI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3nnfYem/2KxnDtTiHXMMgehBS2nUjA+1hNUBFXv6d8L/WIB8QMoHdeQ1DnHwsddRmSeer5uRhFrYUhrHr0nqHsproB+H5rTr+kTnOga0eQe2CmFo/GLgvpznXNzCW3AxFBgWqF0cf7rhyFwx8clu7Uqzgmf5Lgx60/friVTMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+F2JxXO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f8095a200eso2751308a12.1;
        Mon, 18 Nov 2024 02:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731924543; x=1732529343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Goi/04yT5xIN7OeRKBKYdqRHma0hsyOKgiMd+irV+s=;
        b=d+F2JxXOVzzW2dipq/Ore0dUIzfhMaYwnJ2E6okGJjay3n4JcMwdT2aJStev7XH0H1
         Lt+/EZmxqB+opdiMxY5ow1C+uKdg6sLfR6Nuw+IjLou4cOpmJEsn5eN4jeo9M5UiWbA0
         2QeianR8HXPbnKXw8deJ54CumAg5weh2gGsXW3z+T5NlW4rclzcHLZRrtPlgfdjH7d94
         FIGXxGPWCEtVvDhnvhZP23mIQpCszgQ6yDbNrX7qMRQ/V7EPrSxJ77LrcfXR32rOwYPK
         K85rJZEii7AQcewioZvAERQC4h1lxXlx75/mTr4ZcMz4MAVxuJjfCPDTAlrRav2ywys1
         iE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924543; x=1732529343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Goi/04yT5xIN7OeRKBKYdqRHma0hsyOKgiMd+irV+s=;
        b=whZrgpgY9iiLEHUcMz60hxs39ZH5mN33YJ9kQfa2R4Cj2w4kvsO6xRWqGUf3zoRIdN
         llR+CbrwShXVCYgyZH3sxY2o05SSUxBYHPa/6XTzHz3iXN7wXNNRTmYl8TDXBb5w9ZE6
         XUBu4RYosrDED1sHbJbYgvJJq/JW+Al9KOdZNArUiMka/380MR8DXWRvKk+kVdDzOaBI
         b42gca/AdHxz4Vubu38hgGVnVFZsIIkccaWD2Ok5KxvNYXrbkIuxDkya3uji5tAQgtJ5
         PEWhl61PDR1jVPxv6ivJ7Woq3QlcZ3G3megNEMgFDx7PPcpHzRfGkInsTYuyBcWO5LGv
         ioBg==
X-Forwarded-Encrypted: i=1; AJvYcCUFYmznzBMLtSsqTff9g+WYNMMhpfLU28Lo0r/bcb/y39mPBzAdfXpilXFcaJLQNpEscDDSbEhDz7xI+TxyNn+T@vger.kernel.org, AJvYcCVqZurtBIYRb7Ss1XK6iy348ZSv3CEw0MD6HhU6N0RP8fFc6OS4cye9uOynXHnahh2YqZcIRm/1r3htUXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDI/8rx2YtbAu6flQwJ90gaXLZQdNcaSpC7MQxu0pDRTO5uKMj
	SUD3V/1OKhvH/a+DftDLBDjJoB8SNyiapM5SgpOJW6MCPxZ94+IpiwZdMPS3VYY=
X-Google-Smtp-Source: AGHT+IGUsm9S0hEZ6xp7ESqNA2ThEEcxKekQUPQciNMBgUVwcC33mAfegzLfpusuFWYQvVKGptTr9A==
X-Received: by 2002:a05:6a21:3282:b0:1d4:f7e9:172a with SMTP id adf61e73a8af0-1dc8069161bmr27734319637.23.1731924542658;
        Mon, 18 Nov 2024 02:09:02 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dc658csm5605511a12.69.2024.11.18.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:09:01 -0800 (PST)
Date: Mon, 18 Nov 2024 10:08:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] selftests: wireguards: use nft by default
Message-ID: <ZzsSN49rftIlBhtf@fedora>
References: <20241111041902.25814-1-liuhangbin@gmail.com>
 <ZzpNXM17NX3nVzMl@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzpNXM17NX3nVzMl@zx2c4.com>

On Sun, Nov 17, 2024 at 09:09:00PM +0100, Jason A. Donenfeld wrote:
> On Mon, Nov 11, 2024 at 04:19:02AM +0000, Hangbin Liu wrote:
> > Use nft by default if it's supported, as nft is the replacement for iptables,
> > which is used by default in some releases. Additionally, iptables is dropped
> > in some releases.
>  
> Rather than having this optionality, I'd rather just do everything in
> one way or the other. So if you're adamant that we need to use nft, just
> convert the whole thing. And then subsequently, make sure that the qemu
> test harness supports it. That should probably be a series.

Thanks, I will do an update for the qemu test.

Hangbin

