Return-Path: <linux-kselftest+bounces-46416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21920C83567
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B4D3AD8EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD2275861;
	Tue, 25 Nov 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnohj4AH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B01D9663
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045200; cv=none; b=jQVIR01oeHvlSWBj29a/RmzaQ+g0cNOK+xtPNv3Ce5rijZALf0sk8C6IdS5ZM70rS70SP0sIEG+WGWuEtZeVMsiqMSYw5Wd8ll+QJTwfSYSgZIkYJSnwk8mI6Y1kUgqMRcJRbIIiB8Kb/jYObEKwVSEHFn8+2nNZ8ASAP/BFF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045200; c=relaxed/simple;
	bh=0tfEFF31HO0p5AVtPB2m9wDnsam1+lKDH7iW1ZAWsmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoWutSbKsqyVWIsElOFnAJX3KT5DfHAFTKKcDv3zrK/cBWQS8nBrFNdI5lVY7nAHcYmh+ABU/78H11POwKO6g1b/k9Y2NAjC7Qq35RjjeTSBQlmoh8J4gcEQvQpzzDgKU4r8jC6mP7ny7gCuR7NVfGaqyVWrqIGvBWnMUT85vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnohj4AH; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2953e415b27so60387505ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764045198; x=1764649998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+zjcbL0tDzyXVFIG46xwFstTpucFPpn3y7+gA5A08g=;
        b=Mnohj4AHeZlOByBRoTEWRze1h3kZj5lPfowL/d2fWSZuigOeAnYZOEZdv6tOQNBNAh
         2h8YUva70VTdfsDTrRbV9hRJJXTsGxVZxUZ2MspcO4IF3CcSYP720sJAYrDgSrECDUFH
         v/Ojh3uxCU6vrVx4Y3XhlV7y95hSBtILYUQeBIhbT8u3KE1ol+7iq1XdrjFS+2tyZBcL
         k92m2DQnaYlYKN1sad1uRWi0N8rOTZtU/G5Po4EaFC3s3zLIUkOzs6/lB0+a2grzX5CH
         rWPJLGg1bb30eI8MqsQI5J5FTUOIUE/S+qy3oFBD22v4yuf9sW631XR3vz2z2qoToX91
         dadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764045198; x=1764649998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+zjcbL0tDzyXVFIG46xwFstTpucFPpn3y7+gA5A08g=;
        b=oMVY5dlxN6wFaZIPZyNDnMhSxMGh2xxpIGgYhw4dO16cWoP0VczLXDlvTlFNmp7OK2
         o9xaw6FJPgGAs0+ff7OMdQhyx7xZC+m+QCphkDgPNMURaIi3E1rvdIchwKdVsSF32pCO
         PRhNy0YH0M5y3XE0nTy1reSgmTp1S2FYCa5e1wqnnNyNgdCNCSn56xRnZsxtjjQVguQK
         4HWRi/pJNpopmg8/TBn6gkZ5O1pHLYke0zDhBTG/C3CxfTLziiYgW8m1ZtpG/TWrz+qL
         lpMxX7okdg97ER0HTAsm0Hi6BMN6p3OtGKieDCQ2ezYz9uN7L5CwfBgYe/j6UmANMSTb
         tmBw==
X-Forwarded-Encrypted: i=1; AJvYcCW8jLpXFQUrDskAw1ShiNfIFWFhAByhT3P/TcLu3EtMSZwsysrB7DRS+3o0xX43Jy++cbPOrlHrYvuWMOX8OYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLul1zSgDfS3WsU7aOwqxGNwZPJD1CDD9ygtLAp2H99mT5Ayq6
	vgSATXcJgdp6sQFoVsH3q3ETqp5riLgPMwJqiZCbLOhDntJZDM+gJMsB
X-Gm-Gg: ASbGncuEspm+nve8VcMfdXJMyYBhfj8oJSc+0d85qoUky9B5Qtx09oTTBwozJjQkrBi
	BXxe+HaPbSeKLgFpoclZzDozcI8AODLTTK+CzFMwckeW21+lue3Bv3iePM365Eb/K7O4ofsx2sr
	OnECo8fZc3GD47ISeFBvl4zph4fuYKugTvIEpZiPNtZ3SHbmbhwI4r2QgJ6l1Waw4VlKXCZbPsc
	zwT7LEzYAjFamyuBAeRjY1uJrhIKlQOnuq4+HAoobrfPA/hNpm+2VwRUhDm3dri4fztN8Ez+aEl
	HaLmZjPkSZAbFzyI3IhFexLsEtNiFZ+t19pjGTk7x5cQlPNLKwUH2gHqWVx9rPefYPrkw+M22wA
	M/L2ZvSvBkn5N3RjXS+LsEFjoN33S8CZ0FbOnXbsGS3njLBpNm0DuS9RxAVVlK9r6FyuYxp9SXR
	iPI3sCBoBet6GSA8F6JVmZ+xqHIsWaBw==
X-Google-Smtp-Source: AGHT+IG5wQiSA6DoLuqSdaHSi1FyIN7DulB2JAUjgDcIX0e3566wQM/LBnN9t0ZmEp/7FjsrZS6E7Q==
X-Received: by 2002:a17:902:ebca:b0:295:9e4e:4092 with SMTP id d9443c01a7336-29bab1daa12mr16030285ad.56.1764045197941;
        Mon, 24 Nov 2025 20:33:17 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a6b22sm149678695ad.86.2025.11.24.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 20:33:17 -0800 (PST)
Date: Tue, 25 Nov 2025 10:03:10 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Message-ID: <aSUxhmqXmIPSdbHm@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1e69bae6de428@gmail.com>

On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> This does not reproduce for me.
> 
> Can you share the full clang command that V=1 outputs, as well as the
> output oof clang --version.

Hi Willem,
I have added clang output in 
https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18

Thanks,
Ankit

