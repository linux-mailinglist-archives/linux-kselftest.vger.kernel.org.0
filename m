Return-Path: <linux-kselftest+bounces-29750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEEA7030F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEBA3A5702
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF59258CEF;
	Tue, 25 Mar 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ajWv4Ohw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67022580FA
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910988; cv=none; b=f/V/c1K/RGkf09JLJpzL/pr+wxfSp7qYCRJKkGyaDMkRmui6ca6Zmk9iJ7Yi6mrTSL7QLTnqPXqrhUHXBULaEALPJSYXsGv/TaixsRAT05JQxMXiDVBTKLBTQEiC12TI7xTA9Qmzo3uvmAx1Vc/7E6oPAD/QH6DweQ609QzvlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910988; c=relaxed/simple;
	bh=A1Q+B2gufMsfREQp5SIVWcC7720Z/T99tr9MbQkNLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH+BJs+8FEZiRRuc+tC8L5H7jrewu7fZiGWQ18iP17DwOwFDPXeHjFb2+P/CmLIfunmF1vc/hrtqw1hbctAMYMqff2N0N0rte5SibR4R+i7uBEiTuT9VfOLV6qYc6CCiw1mdx9KdVJy4p2YPdaJNvrwVBIJ0rReFY7jdQwuJaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ajWv4Ohw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913d129c1aso4057059f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742910985; x=1743515785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UenxoH6KmmrH5CC3OQgIopnnTp23ZO/0n/qWbM1/1zo=;
        b=ajWv4OhwFXIiyIBoxfRqNRV/2qs/SZUnb5D19ez7n8slAjmmQf3L57Wh8xjjywnKPe
         hJxu8GOT3IejCy5pYIqeFokINlrWCk0xex+XUUzEIl+uoLgTmy1NuKGDa554zFCsSvfH
         QPUjhFBtN//YwbfEdRxl1gyB+o7UHTBhe0M3lo8SEmqJpueBk21iQevFgueZueTOTP4k
         cbQDf4WK1eq9VShlE3WHwyDxecsbcI08j5dV/WmOVaCV/nuy0NeA1Sgj0mSzhkG4fH0T
         LZ/qO+FGFT5td1mm2dHhwxlGBiSKDIhroiaEyuVxOlwGY8JqsOSFc4gyr7ZtcNDnznGA
         cbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910985; x=1743515785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UenxoH6KmmrH5CC3OQgIopnnTp23ZO/0n/qWbM1/1zo=;
        b=Ho9W/jAdzNSujyx/vvzz8lIV0NFzT6/yHE8UB+3cbX238BA0KBrfIOK/9yEgUZ/dOa
         MXa1UaKjECo3eq417qZ1A5BTAqDZ0uSHzta4Vu/5cd3543+vJqB8ybyLBGJHibN/65Yy
         cPl4OzQtqY/Il+cFeeNGkjF2Q2lToZzE2pc7eIgzPUmxe31KHsXOND/CPn9Hnq2hKrvE
         NvgxtTl5yqc3duU+1jZ6mJ+mXzWEhEBbftip5nFyZrakQ4zvy0V/GKDUpkPG92d7ZmsY
         eKxPtH3u/VYtyFfvYDvpJ4lQPA+dgNIuWILPmBzqhvnzG+Cjhq2qa+97GKc7QnmQPPRP
         hYPg==
X-Forwarded-Encrypted: i=1; AJvYcCVa2dDEhBIguTYr+8Afgsr8zupRlnzi6n6sYZb7FxAWxf0lqD02NpEn9rKzrlafrakyp+iAKsQ2H1HYF2fE5IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73JDXDhqvWCB28N3xBdtHP46AaoxaHmInk3Sx75bhsXA/Km5w
	+YXnDz4oDLINDFGIfnIpp8jwNAcbzjeKmb0mDqomzAH99nSPgGWHXIbC1AHoB8M=
X-Gm-Gg: ASbGnctrExf1SDuENu9xbC3/7JsBKae7+rQ9aBDPx3Xf6N0W6sWXKQI6f/B3r7s3Ghg
	FC0L8aZ6e8Hcta47YBabGQph2ilePMX7DlNK0xpx7gLFt1Tz8cXnYTzR6INFaMKEQPbICpHNcUo
	B2/LKa2VP82sq1f+qhEixssQhn3ZXmtBKfNpOk59eLaB8dx90D06HY5Z79sLdOVBaQmGWNHIY1G
	QUWaCxPdbEw64LOd/2O73u2zYiFLLWIVBrABzkoAWe1CmBYglFIZ8uJ5WnXXAOuyfS0rtJmhKvK
	NMFISVn51bZ9EPat7umJ1LFD9/uFZbd2d07717/g2c5F
X-Google-Smtp-Source: AGHT+IGuP7hdX4oUt/uYmCs7eqmCWfVYFgG4WOsXpx3j+wCi9SZrdUfRY084MJJ+0RZbPCxY7u8W5w==
X-Received: by 2002:a05:6000:188e:b0:390:dec3:2780 with SMTP id ffacd0b85a97d-3997f93c60fmr13164520f8f.24.1742910985169;
        Tue, 25 Mar 2025 06:56:25 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efcb1sm14030721f8f.94.2025.03.25.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:56:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:56:23 +0100
From: Petr Mladek <pmladek@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z-K2B8WMVf36sLcX@pathway.suse.cz>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>

On Mon 2025-03-24 19:50:17, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

