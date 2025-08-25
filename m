Return-Path: <linux-kselftest+bounces-39884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6930B34B29
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B075E0EB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDADD2857E2;
	Mon, 25 Aug 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1MUILUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533E26B08F;
	Mon, 25 Aug 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151634; cv=none; b=TWY/wIhsaQgLvjfyz28woWwcQj+p3Cbes4AKWyigmpWMmMmOKlEhosQuokZth/w3pq/QLIyjADR73FNI7/HmyEAEQVqEsuD5bSzSAuaxyGGpOo8MzqZqhx2GJbEwxD6XsLxHQ1WjeDBi+5zhB+a+ML83KDIb1fcrbrRDGkyU1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151634; c=relaxed/simple;
	bh=NFA7T6E2D+ticV0hy1ji8ocCcpyd6tM6cHuF1n7cAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deKVBO1ePMsiQo/7xqP7qnfOywv+U0w916/LH4yzofQSDJ5ZaCiBq1qX7alsKwLVYS+97dIZawHc4+Gigb32lYfqjdNU9lsVp/c1Ih79Q4VRravooUjUz0amRvDSmNmURjdDgtz+owTAHQ2zUPC/3K+O2vfB9g8F2kO9WEXdi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1MUILUy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49d3b48d8aso1449350a12.2;
        Mon, 25 Aug 2025 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756151633; x=1756756433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hl9kZJKv4ffu+RygV2Q+H6lskTAnwQWsxyZgiyO5ZW0=;
        b=C1MUILUyfi1GRYo3FYrmLTBcCkqkzeMJo25Khp6L8xApbRIXlNLzbE+WSXOs0+sZPQ
         PqkqFUcMuJp2hnPu126Z7RZ0DJgZgMlKL9nyd6rEW8fhZfDtSVCkpmmZiS0/Y/PZERzY
         +U/mgzsjr2awifAg/b0LBID4929e27DWi7JwD4sZD4wW3rDnvxTmhrBw4k8UdS3QaeYx
         LM8Pj1QasrIv+xM5wMbOR4rontQYtsKuMqcO9YenekbSKGdlB6Kd72mx+2ode0ZBt/Ab
         3iocVoODH5B4JSIk1rembTrcSLCOi7+5ZdL8vTnjbjriK0Aw+OVkJ3f7JPRRqRHnfh5z
         ZUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151633; x=1756756433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl9kZJKv4ffu+RygV2Q+H6lskTAnwQWsxyZgiyO5ZW0=;
        b=tW4y0WxwGC4QcPXa2FQlLFhZ0vBt0ajyYqYIuuP+RskTD/8K33Y2301kQif5a5dU9E
         TTQyv5zHV0QIxzbfrhGKgLMb7RxYuf1d7YWvAwVJ280Rwr1E0sVR52dpSzgoPwMW41mj
         6kkxf4xFT2lyhOcE/OwnEUMU6UhKwJJuqg4duWU6TKuEl/MCVy8FL5b/ddE1sihR+uVV
         SOOuIjeJV3Q4xfPlguUzqh9ATLvs+5Yyn/7ptLuVGgUhk/pkrYGAf1sWMprJD12o867v
         fi6dLfC43doxIVVhU01lwWGAD/NVn0iEjIL68NQYz+y0Nbx7kvtUbB/J2sNZyAGPhy2P
         oyyA==
X-Forwarded-Encrypted: i=1; AJvYcCUgCgaA+V6NnehzxfmD+zPQRbEZmLmQ+9vVxmUPqIQr3k5aCNRr3O6SnGXlzCGqYnvpolDuhzIIsAzqepBPwcQ=@vger.kernel.org, AJvYcCWP4wdBu712UNJ/3ADE8LXLyUIcLHIfrBSzI1KD+zJkZZTLJViI57kdU1BrV0fa8ZLf1CqFptIx@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtZl7rj7J1ZtrH+rq5oVbUm0NzMZv0BHes1frGJsSy4AwfY2W
	QEKse62B7AxdjG3RKNC2dC0gOZHkS19dVGRhH4TT2rFumlU2hUrohltGkC95
X-Gm-Gg: ASbGncs6EzqrGlS1roDNqMM7EvN5/mo31/TV0KG4M94ZhdXDWBMU/S5mnk/2EIoFEWd
	P8rz9C8TOELmmz/0YLH9kzHxXpDRXeAa5eEkaFZKpynVfAXrlUV5vhQb1vzVBeZN6eJK+blFpC6
	HdAcI+SIK8fzC752CTnbPQi+svT32pPsFBA0+qyO/+aPMC5BiIoSOxaOL1RchKDMZHz7QFCfoMe
	uw4zvqlvwgdmZloI2jhe5ULlOHqIwRdo1yTYtRCRVJijHsPzWsluoSnmEqAqHPYAUcUheDZk60H
	nUJRsQnxGabq+tfeupXsSFFuzgE9ZuJz6bUT1e7OGKkBZ7ixgTAj9EP6fobl0t1RsIHVonVbaz8
	7uIKg+Oq6vKd3e/Ffsymigd2jCDV+GtjmksNY1gTP4mVRFVRwKZ/GLu7R6DG6bzYSXqxXgcbV0s
	BwxvDDBbNh3aHJa7EXSJUcWLv5CGkUbzTESnkgNRaSmP8LEXINDmxBsJT7iFqbFMuWBKj/likTM
	Hsp
X-Google-Smtp-Source: AGHT+IHK82roIY59YUCbSBq2l8vOrNoGx/Kx2ZHX/RsUakO7PtSOMtQtZG1eTYk6xBeeaPjJ3AbqEA==
X-Received: by 2002:a17:902:d504:b0:246:dadc:c576 with SMTP id d9443c01a7336-246dadcc9c1mr61575545ad.58.1756151632625;
        Mon, 25 Aug 2025 12:53:52 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466889f13esm76173445ad.148.2025.08.25.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:53:52 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:53:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, almasrymina@google.com, sdf@fomichev.me,
	joe@dama.to, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] selftests: drv-net: ncdevmem: restore
 original HDS setting before exiting
Message-ID: <aKy_T9y5kdRBxWPL@mini-arch>
References: <20250825180447.2252977-1-kuba@kernel.org>
 <20250825180447.2252977-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825180447.2252977-5-kuba@kernel.org>

On 08/25, Jakub Kicinski wrote:
> Restore HDS settings if we modified them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - move the threshold setting out
>  - use explict setting if setting to UKNOWN doesn't result in matching
>    the state we saw before the test

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

