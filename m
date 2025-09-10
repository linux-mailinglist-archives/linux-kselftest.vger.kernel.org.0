Return-Path: <linux-kselftest+bounces-41088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A3B50AB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8174C461ED8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2576422FE0A;
	Wed, 10 Sep 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqX6BVGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5422A4F6
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469841; cv=none; b=MbWIbyg18kqCOZQocoeYZKKUBiAij0IUaJFn60kYdd1kgi1FDH7UpshLZZVEL5G0Ht7NovaWaDovA1g6/jE7CIameq07HlsTPKiZftmMuhAI9bbjxb5PdKqZLn1AsKSXZRijmK9EFOn7ZlpbAmoX1dFnj2PmRFEZUPialU35sSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469841; c=relaxed/simple;
	bh=A8UZSafwblk0pzJBfHJ9Pb1lVpHVArTIzyweR+KHg28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHFpJX5Bu+fxPKSc3RekroRBdD1YkzzzxE8GfF1U4pzDDFgDWmkUdWyrABXnFLSdptZZe7Be2cDhT9A35CnlyybTs2b6L+ttFNl7s0DxmaY/m5MTVQZQm4YhdCKLV9h8lRWj68kQQuTO1KpXM1awd3732TXuhI/Gpt1oFB3xOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqX6BVGg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25634c5ebdeso30873005ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757469839; x=1758074639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDPCc/01NbX/qdqx8tLh6Cy8tAJ4bABYrvs+o+VqOMg=;
        b=fqX6BVGgVM7YHsGY8g+DzkgOZll2wm44F2ce2rJt9NysWy+u9YixOktSlvd9soimM+
         kDCyOwsNCwzeCjgfJ29XrXlc7EF7wRspZ1PbBY/sv0W6ZYjrnkK5t3Tbldcy0VXcZfDD
         4ILNuW9vmbRo+v9S0MUSBml4CPUxaQA2zaUorUIdOy6w8NVsSbH9zmXS1uy2wdaZFQAR
         794LBxaNr32EYeBVppDEktKoiCLYKs6guy1SJ6hgg2sU9rkFzTxUm+gr6fzCEGHsJShs
         vBhuVOZAZxJuo1+lNdliIte85cI8l50QSd3tg0m9I84A7jZgUAEE6VyrxMF1i4ymSDEb
         u1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757469839; x=1758074639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDPCc/01NbX/qdqx8tLh6Cy8tAJ4bABYrvs+o+VqOMg=;
        b=vCfud6ydF4LYL+bj5v5QiDQKInOKntF5fd5Jim8SORTFV2WmhCI8dvfsJbsM+GeZjQ
         ety2rOZtwWyfl8o/j/RK1mJU3tPkAC69xyKrGGVZ60RpttyuK65wuTW62nk4hmIQIkcx
         IiURHSaLcVI/CsATN1HKgGcd9IoJMh/gwT9TB5WQw/QfuobVcd0AyVnfwgepNSZNss75
         Pn7J3UDwNpnH2clgt1nS3n8j8CP22Zf2O7+HEa9RzVxxbIBx1ld142p+ZWmyVitcMGzU
         yWy8hjUPq8TEJdLgHg8khOuKtP0lpRuCNeBd3ZLEsNxqsrsFFTwrqpi4hGWDExn82W8P
         +M4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXifgfMML6lsIDiZ86gA0aSNx61mj6U+LryDR/fbJAGHTfIWppdRfdpLBJ9z34GzwUEew6OQJrAWaKfkEsS22U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis+GONb6OmYV9RTyxY5uCX0+8qqsKsjvsCAZJPHzXlZHm6Xgn
	/TaOGlKG6LtW4Jq9dBdfQtHDy0X5btjf6iBeAlNFj7Y3sZPJrghGWsbv
X-Gm-Gg: ASbGnctzTw2IqMI/U4Rw3fta+LvpxwUnXbBGzP35coM9b92E5DOSXSZD4VL3Z+H5sT0
	QPC6TU1AeN1gY8F06ax7BUJKs59embuE1C6JlBlyGV8zw4MP1mNT2fEvynpjfuesw6StbOJRY1q
	yueiZOd6j7iXthlesTm4hE1fdHTttIldsb1oAeYi0LNz4sANeX6YPppfpZUPxZS3RqDD6ae+SmK
	ql6XZv8h7cTAfXExx964qNwdYfBYMuJX20vOp8akMtAxK2akMXQ8yN5+1RVtDeFXBTNJ3WGGdfH
	F3YeVll8aV3+CFFNCCQAWkU8bfrtREl3WDqR8e/WEbqVNzkecujSVKt2JpiDjNrdH6qE5Dh5DVq
	QLJDSVtcgSjGH5pcm8E/NjZbirrY=
X-Google-Smtp-Source: AGHT+IGvbsXBjLY4Fbf28Eq5y/fsJDH8VznrHYs+kMCnJL3AHDVfp47p+D4IJrxlwh0Ob35gaOgXUw==
X-Received: by 2002:a17:903:380f:b0:24b:164d:4e61 with SMTP id d9443c01a7336-2516d531c06mr166441815ad.13.1757469838967;
        Tue, 09 Sep 2025 19:03:58 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a344a03sm10440465ad.70.2025.09.09.19.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:03:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:03:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 2/2] selftests: bonding: add vlan over bond testing
Message-ID: <aMDciKMGjr-_sW6E@fedora>
References: <20250908062802.392300-1-liuhangbin@gmail.com>
 <20250908062802.392300-2-liuhangbin@gmail.com>
 <20250909164600.04aa44c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909164600.04aa44c7@kernel.org>

On Tue, Sep 09, 2025 at 04:46:00PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 06:28:02 +0000 Hangbin Liu wrote:
> > Add a vlan over bond testing to make sure arp/ns target works.
> > Also change all the configs to mudules.
> 
> Why are you switching everything to module?
> The series needs to go to net, we should avoid unnecessary cleanups.
> And I think changing the config is unrelated to the selftest so it
> should be a standalone patch in the first place?

On my local testing, there will be a lot default interfaces if all modules
build in. This could make the test environment more clean.
But it's just my preference. As you said, we can do it with a stand alone
patch. I will re-post and drop the config update.

Thanks
hangbin

