Return-Path: <linux-kselftest+bounces-29482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB01A6A098
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 08:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D97AEC04
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 07:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA81F4CB8;
	Thu, 20 Mar 2025 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1lAK67G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B31E3769;
	Thu, 20 Mar 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456466; cv=none; b=m2MUr1xshysFlle4cpT61ggrDuQ1JaUGyPj/0aGVZhhj+cAuAYM6O5Tr3yFDo6Y+bjzAxFr6cD4H5xxrA6FW45rXsNzZOEgEtAnzLRNN9jwqwiwA+ujiYaAuUgOZM/do6VFdwc95ZzvwaYDXkqEqLN9NtZQO16V/sTQSxZYyw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456466; c=relaxed/simple;
	bh=4sXeiqOIXgRkPqJvfQ595TU3AC9+kIhH7Vxw4P7Zfvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX7KNn0wONRtOGkNFn403xLFs2ahdG750TtQX7r0ngQWOUGeT8v0U/F8LrCwkL0jjkQWmCDHahrsfCsHUCKjFOPjFJm5eYyGrbFYuiupWZ5sbo648yz1sQAlXdLXAonJOc8EL4enE1eHBs2dnk4zwmFBWthMeLXYIrUMUBuaVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1lAK67G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2241053582dso8498275ad.1;
        Thu, 20 Mar 2025 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742456464; x=1743061264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+9rATyUbEgbSLtbUz3EQuHc/4v8uBGhvmxcbw9HTp0=;
        b=V1lAK67GLhO5Cc0s/AuYQwjUGy6jq3PH463TwhvlHQ4RseSMXzpZXphof5KUGwsLo3
         ABLBBw1drKrTQZk1OyHNFVjJxPd43DsQ+xPpv55M62MxnSXf51+lqq+jktIOlKCDIHxQ
         rPgp+3ipSZz44mfEsygM5rc5+knBXWOAhp32ptr/JKFQSKf4vnRCpIyhf6cL8eTPOsmT
         KLcBxfa7kPDtY1q9RguvEqXxurgDlqL+ycImga7gUdHBN9LwoW7O+CD1nvSkczVhSD6W
         O3icatngjJ4wqqakF0FzY6oSYKtHW66zbEbx/vEAs7/4UBSe6buYPdozfCBoK+CGRMSP
         qvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456464; x=1743061264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+9rATyUbEgbSLtbUz3EQuHc/4v8uBGhvmxcbw9HTp0=;
        b=B4FbfVX8reW64mac7JUsnB3ofCBhvtZLhAMee7eeSrON7QNUawnc1oKWj73oDUMbfD
         FwOUDzECeGhX6xip5s9nCJBmjF/g4aJMxRvwi1Y8nArrj8/YvjmDj17zxLeWbg5hYm8U
         A8rJFqedaZT2efDrSpU9Wk9qdkNUGutFPZUXB9VwmxFdS5ws9UySQw6M6/UvSk5udB9x
         dM8NT/G5VAskue01VKPoVsPklCCSOUkurEbKm322YvUsxRoRBWC2d5rT20FFqZlM70i4
         FrEEvjj4T/sgBtUG712UGQEvKUfsITbq9exaUjfGeE6bPKzK8jRIQ2tu6wP14nj5mkOW
         EVjg==
X-Forwarded-Encrypted: i=1; AJvYcCUVTSaunyd2Ul5aoOVu5Uq1wkgXX37jm0N9wIx13KH04rWmB2VudGTUHhS3W+8Yvo1Dx4T+f4eFIIwZH+U4@vger.kernel.org, AJvYcCVhYsmF4ATnzEWhTRnV/9AhsfZvQ7o2UVT4PoN/MkBO0Wgb+b6llw72NwlUTkcLpIkuxmPTqXkc8P+AblxDSFck@vger.kernel.org, AJvYcCVqV8Tk6ap6L/xJ19Ba0+p6+gxYHojBh/65CapSRxq/sQ4xBsODoOa4/CGTWXKyp3Gu26A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTDvEo3b1yQL6DxvlX3EP8FDqAzeI4buQn/DXXBi4aFuYNEjk
	37iqmxO8y94Prt+YnQz8HDxpV/5HavnBqvMp4yLsDhXMDtypOOiR
X-Gm-Gg: ASbGncvNMyFuvN7f+NR6SpyqQOr0ipd9ox5SUtBLPjm3uWkyr9jdqeRYcYh4qpIuY/v
	Kogs7RacltjovyMa0pDyZz/ZIR00i8V89EBY4x4r8ylMCq9VCqo7phXNRzmel8FCyj5st+ptOqP
	RqgNl8yxqn1k8xZuhe6nFf4ARXCYqHj6DlV8t6wvlkQwp4iMYQyp0bWU85wwrwUfyVqUkezI4RH
	dDhKPoSW24pflBTHtiJEI6996m4SCJGvYquuGAy6Irors9JjcIzA8Z4iNKVcZRsnwyj1aE4x/Wa
	yPpJObM0UD7irPZ7rwMik8wzR82K2dzQlY9x/rEPsh4/KI5oQ0waHAYiiaHxeeErIw==
X-Google-Smtp-Source: AGHT+IFEvvOq/4NLQ23MHF6FNa/FiH21cHYco1EVNW+1BRuvD/pJTZLz+96cxRxci0zjnwX0L+gRcQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1f3:47d6:aa05 with SMTP id adf61e73a8af0-1fbe87272d0mr11208399637.0.1742456463841;
        Thu, 20 Mar 2025 00:41:03 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9fe51asm12244697a12.36.2025.03.20.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:41:03 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:40:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>, wireguard@lists.zx2c4.com,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 RESEND net-next 0/2] selftests: wireguards: use
 nftables for testing
Message-ID: <Z9vGiL1KkO5x8I-j@fedora>
References: <20250106081043.2073169-1-liuhangbin@gmail.com>
 <Z9lJ6PXHeL7tfhUf@fedora>
 <Z9rso2MXYBFGnJYl@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rso2MXYBFGnJYl@zx2c4.com>

On Wed, Mar 19, 2025 at 05:11:15PM +0100, Jason A. Donenfeld wrote:
> On Tue, Mar 18, 2025 at 10:24:40AM +0000, Hangbin Liu wrote:
> > I saw the patch status[1] is still "Awaiting Upstream".
> > Is there anything I need to do?
> 
> I'm looking at it now, but the subject line of your series says,
> "selftests: wireguards: " which is really not the same as all the other
> patches that touch these files.

Oh, I will fix the name in next patch.

Hangbin

