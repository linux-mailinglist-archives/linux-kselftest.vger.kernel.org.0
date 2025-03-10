Return-Path: <linux-kselftest+bounces-28660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2483A59E1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D10316FE4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CE235BEE;
	Mon, 10 Mar 2025 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnH5bdnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149A231A3F
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627607; cv=none; b=eRtsdGBN8ULVQiSjE8yi4MwP6lpwDPu5Ki1RYfOqfO+Jy6+10OZmLkiaNMXPaI7WTMl1Xc80lmFRWA7l9NttA5yl3reirzaMqp9DcrCLZHuu52SmmK8NlF45qJQ0yu31Wb4I3//1LE2VR9dkw80i97BCyDaMIzJIVmbqtIW+9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627607; c=relaxed/simple;
	bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1mw+3vn9QWpPD747MJhIkH9Ska4AoEM1Qdac3TLaWZD/LW1E/pxW6xk84qxMnpm5lHwXiyK9iGaHfZ38rqv1zAIc/wj2aXSLOa0q1RRNshI/0lwhszqSoTFzG7o8HEaYkQ9RbPM8Q6K3n07puXWen1HPCjSoKan77LyClRIVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnH5bdnO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so6815883a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741627604; x=1742232404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
        b=PnH5bdnOL/idqUVRhs/h+yWF63ULjbsaXh0q+tz3x1o1/cJJkABCp4yq+XDQahkeLL
         N++MQiVa3gUX6Rcc/L38RyZDM3oe5E41q5VKllE7x8Wxs8/eEZVQG9hCtLNftL3jza4M
         YLuAq/3EZ/AvvOFXQfuW3XELFDWMlrP/tuCxsZiirLyzgeyjoAjfOsBXCxsA5Zl3gKpk
         hZrR1shXSIEPL5cQMvgUe23uXg2l9fXCTiuvkkd5IqGS7geP2HKlqEowxe6Gskb6nqBN
         GkgX635uPz3R1vXZBNIpmxbn4GuZ9WNiO76VnB0qrd/+hnHXXQH7U5rBR7TV95lElpRo
         4usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741627604; x=1742232404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec4E/QJuP431GXmsZlvrj2L4OEgsl7A8yGGvRFhwKHo=;
        b=TseWlexRO3d1fQ/tiycgh1oKLQjR01idgIOdCgBVnSGkiiOx44qj4XSAMP7azjA9PG
         OGL2/EpInRW1Ig072hlRt7wrO2ssL5WWuvQriHiviSkM9dulaUGnlkfRS3125lWfvkTO
         9GeZoGOvS8JttaK7gslB0sDnSRuBk3dHEfr6Rms6WjFy02IpHN9tGUXiwLGz0HhM+IeB
         ogHr4p+Ge1JvcrhboxIIPzJKr1DsOMaFV7jYOwCVpB+LKIv+Y2dZlmY4gsuXtmKNEaVE
         CrIQReg1qtt+XQYY6Ji0k8eLohl7G+RTCH92x9k3PIxZHTRSckYuGsvysBFk18yymD7a
         Eqjg==
X-Forwarded-Encrypted: i=1; AJvYcCXhMnM3kHjmbhnDXsDvt9SPzQLutEq+8wDFh7ykoa44qANMA4i/RuEl5ibjj7T9Ss8QQKLRMVsF5Hht9lzzZ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVa83xKDwyAQrRkNwoJ75m7+xabLOEfFnpNRb6s9mQRvMLhBic
	TeITlusxQpcj0gYXecW/2RUgUQprI0OY90owoh4QuTlfm4lWyqi/1XPM6XhM
X-Gm-Gg: ASbGncvXMd8IF00YIB5uUfUHrvYRcDMVaYYyoi6VQwxzBkwaRf4uU3y2pV+l2pdxymv
	UunXj/3HiDt9PemN22DGw+26SfnlucgERreiv6AagILuoi8NuU+NdBYqIECGJ3p16My/x+TZgnr
	u+oNmHqQi0TKtdhAx4MsS0yobhW/wsTfvZP/+OfZeka1KPXhWq6WjJhYUbbe++kNaKwozrmAYt5
	Xi2a2YSh9r2a5yyAD15na4U6rz4fy2/lIC/+qEvKPp32gMu029E18mvUFbwI2InE88rrr7l6+ti
	zoPsfy92QbbTkO4/z+IiZRVF+x0H9KE9VeiSZsMGK2GjPwDn9rjf4tnMgeol8sClZmGAOMCkwT4
	DpLtWtSrH2w==
X-Google-Smtp-Source: AGHT+IEziMDJVDiQvtqgzEc+KLO4eMrbIFTCpQOcF3ArJZUKi7gj38VxTkGoyYwHCvmhQOF349IBAw==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c4a1 with SMTP id 98e67ed59e1d1-2ff7cf128acmr23054358a91.24.1741627603670;
        Mon, 10 Mar 2025 10:26:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e52:7:4eb:6cd2:52ef:6beb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff72593715sm7627806a91.44.2025.03.10.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:26:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:26:37 -0700
From: Kevin Krakauer <krakauer@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemb@google.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: bump GRO timeout for
 gro/setup_veth
Message-ID: <Z88gzcGu5_WX3je0@google.com>
References: <20250310110821.385621-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310110821.385621-1-kuba@kernel.org>

On Mon, Mar 10, 2025 at 12:08:21PM +0100, Jakub Kicinski wrote:
> Commit 51bef03e1a71 ("selftests/net: deflake GRO tests") recently
> switched to NAPI suspension, and lowered the timeout from 1ms to 100us.
> This started causing flakes in netdev-run CI. Let's bump it to 200us.
> In a quick test of a debug kernel I see failures with 100us, with 200us
> in 5 runs I see 2 completely clean runs and 3 with a single retry
> (GRO test will retry up to 5 times).

Thanks for finding and fixing this. And now I know there's CI that can
be checked!

Reviewed-by: Kevin Krakauer <krakauer@google.com>

