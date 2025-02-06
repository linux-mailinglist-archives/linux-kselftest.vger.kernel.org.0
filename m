Return-Path: <linux-kselftest+bounces-25901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0AA2A6B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C57A401D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DFF22DFAA;
	Thu,  6 Feb 2025 11:00:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A9227B97;
	Thu,  6 Feb 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839654; cv=none; b=QEMsUfbGwGshRRNztHlKgqdXHsN2hY3Rrs4sQZ68s09AZujjEfUTEdJN6jvTbKt25J4/JOrReF/iacpNyMZ/Tc6qlgPD5R6VNAyVmbUMLCoD/hFoP4g9efjKKkop+AGdpK8XZovdgzqZyAfZUyphKmNG8mHI+zM0OuQjiBrU/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839654; c=relaxed/simple;
	bh=lgguq41ag7NZ8RJD+fKNnzSkF4NX3+Q9xeQx3U6XfrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI3eE1ewIokYPHK8H2m2nOF2qOXlWMEfCFdvTLyUZK0woE5idi8TF3l2cdmvEZswrFTztJTgWDRs3h5E1sGu2ILu6/llsS8GhX7AW+uC9W2NDLWe5MKbv/Oz/0x2mKriA9NZjFLrCkoiK1OaYr1fzsoJ4v17vSRI0274uM5LQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so147459666b.3;
        Thu, 06 Feb 2025 03:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839651; x=1739444451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwKJXVHXHe+Pd1Jk6Ye1Al5WM2L8urqsmCy7YofkgtQ=;
        b=M2WEIiCk9Qk/G7QM1rSz95wrkgtqJYQqd1qjILvft629+Z9ai8/MxUquUNgO+thZOq
         3goXwNUZR77JFsP0A5zG/kD+78CaLJdlb9z5CeIEga1C116IdnexuvKUW/aYJtydGdXx
         lI5YyE7kfz3PjQpaTjSE8nGWy33REPDdHZBCFO0XdHWl2aPH9YkfTq3nuhG5D3ZZT7CB
         eDp88QYkPn1mm/DW+ySNijbHT+y0eXamcHjEaSA1SLGYOs0UzncWbiSUmFXHNPjQ0w+r
         rWpOMYcIJSIm3iUUxaBuT/3OyWvuZmuZ7R8oyZJtPW78bTTW6Y189vsg94McBdrKdgad
         yudw==
X-Forwarded-Encrypted: i=1; AJvYcCUOCBdPcox0+OP4r0y8ip3qVlOqnyDP/17pyLwFKmaP4R+7Shqd2w3tdAIRuw/s1H1UOZbUGvlO7aLzxQyz@vger.kernel.org, AJvYcCVkakrS7RiGiYzjvbzNAJRwWLrYDtMqRLMw51Xy3HWj9NTyQqFQbQBw7Jsqq+DOu/hTsPeITD6N@vger.kernel.org, AJvYcCVpBWcL2MNdGBSNg1ndhpvXf1QqS5W/ncEB+QJE6pR8HAakhlx1iJkI0x6QvMRgJMUpaUkbCd8SiU917oYz+Jjt@vger.kernel.org, AJvYcCW7AP/a66GnQyepP/uFVzReFMR5xPleKaAWFIKvJKwF+zRN6BqpL6cfhyBwv5bgiY7ybxsJUZpykgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6rxJvuVYpFF+bMX5Gf/P/i+WVx/paK/+6P1nj0YV60sM185F
	2Ur5f95WHRz42OG1obpm03xa0QFp+KPjQjXXN2n6c4+C8KRSzl2N
X-Gm-Gg: ASbGncvZvngY6R/wEXPBGLlCpKqkkETpoB5uGlQ+rtPXLaFupTA5Y2eiRYbH5ZB1WTH
	2bXueTTxwGB1rNQU7GSmUkzBd4D+Q4uqGQXK7GyzXB11ubqelxJDa0C8TjyusCevqsSZg6RcWUR
	zR8sUuwrbRZY29+DNbzqWiKhFF7mVyG8ADcmsd3QwbXVt44eKjADk5KXtXr2hBogmZCuJleNpMR
	qfG0ZUuo//cjHPoA8APwg0vDzG8JJ79l4N/ydd0OZ3GLc9XGZjHQsn1BDwyxZVNZ0OlJxyZXBud
	9f1WhA==
X-Google-Smtp-Source: AGHT+IF07cShoiJEg2MNO6wHX118GUCYrDdki/b++DDfI3QCu+una1KNnGQWdeAerFAwn129vhYMNA==
X-Received: by 2002:a17:907:7285:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-ab75e36429emr563241966b.47.1738839650440;
        Thu, 06 Feb 2025 03:00:50 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77333943asm81887566b.141.2025.02.06.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:00:49 -0800 (PST)
Date: Thu, 6 Feb 2025 03:00:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v4 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Message-ID: <20250206-rough-hissing-armadillo-fb5dfa@leitao>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
 <20250204-netcon_cpu-v4-1-9480266ef556@debian.org>
 <20250205133455.GD554665@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205133455.GD554665@kernel.org>

Hello Simon,

On Wed, Feb 05, 2025 at 01:34:55PM +0000, Simon Horman wrote:
> On Tue, Feb 04, 2025 at 03:35:09AM -0800, Breno Leitao wrote:
> > Move the static buffers from send_msg_no_fragmentation() and
> > send_msg_fragmented() into the netconsole_target structure. This
> > simplifies the code by:
> > - Eliminating redundant static buffers
> > - Centralizing buffer management in the target structure
> > - Reducing memory usage by 1KB (one buffer instead of two)
> > 
> > The buffer in netconsole_target is protected by target_list_lock,
> > maintaining the same synchronization semantics as the original code.
> > 
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hi Breno,
> 
> Unfortunately this series did not apply to net-next cleanly,
> which trips up the Netdev CI. Could you rebase and repost?

Right, I was expecting it since I rebased it on top of the
netcons_frag_msgs selftest[1]. I've commented it in the cover page, but,
clearly it was not the best decision, since we missed the Netdev CI. So,
next time I will send it against pristine 'netnext/main' even if there
are oher conflicting patches being discussed.

[1] https://lore.kernel.org/all/20250203-netcons_frag_msgs-v1-1-5bc6bedf2ac0@debian.org/

> Also, one minor nit below.

I will update and send a new version.

Thanks for the review,
--breno

