Return-Path: <linux-kselftest+bounces-23383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DA9F1CFE
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 07:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC46416928F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 06:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54147E782;
	Sat, 14 Dec 2024 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvO9T7e7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3A19BA6;
	Sat, 14 Dec 2024 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734157085; cv=none; b=L3655UUxhMUW03V8l32QQMrzOtRNRdx4BmfYYaXA0jrh3SwRS5Cu2uVeVrwp917lnzuI4dNv4Evylqi7oylLvJfEvabDbindXJM20v1D8wagnfliYSaKA0zl4r8Np1st1M1C1OgUOME1Ygsd3kOjZ2sFcKL7DuNbg5XAY8fRRB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734157085; c=relaxed/simple;
	bh=fHcDC9/3fjxqA23UY0rgQz3K5BSqWz9mQZQLiNiCkOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzyXvOqeetaXLLzI7sYpF+dDEbgNkIcurbxWXHqHSGbbMQelZUJH4CvbfPFFRyKSSSyKyFOM/qX2i/9wtmq6uRRn+IF+3ge5aTfCofgHuBD7apmLrA9xpbj2e6Z/qGt8alHqLHccw7ZZ3aDV6M1qDSuJiNMYGVaJoZDz+ez2xqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvO9T7e7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728eedfca37so2642105b3a.2;
        Fri, 13 Dec 2024 22:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734157083; x=1734761883; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fHcDC9/3fjxqA23UY0rgQz3K5BSqWz9mQZQLiNiCkOI=;
        b=mvO9T7e7xp7YEDWKl8o+JDvmsOBMs2sifaSfY8+pyy2u8O+TFX7psnHfmDHaggErXg
         Z972CUa3oWq8QHDrFwBZe8Jpz+iiyT1Ioz6kf042dBUnDV0RSnvKZtaucn+8s9H37FBb
         RL0YioNko4lXKfz2g21lQFFP20dc4GH8fYfO4mkoQn5zEoOcCYuE7VgQXVadI2U3yclf
         IO+xK43SOChPIZipMbPai9prd6vUxhLmLgV9Yj5VuRfWWRslQ4tsvru2AXzlPG4yda9G
         kNw5lIDz2lm3ot4VliwyFiJrptt4Do2OPerx9pmQXnPQTWlD4cMREWAEO6gvvi7Oi8WZ
         +VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734157083; x=1734761883;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHcDC9/3fjxqA23UY0rgQz3K5BSqWz9mQZQLiNiCkOI=;
        b=XX6bHmzFtv21gak4HA627e4P9nPIm64outPThj7ZSGUGcW+y6UWqYZafJeAX96QeAV
         G/2MMFcRikPoDYTQcixxf2gcnX5ppghfi1yuJOT+Dv3iGWLhWxMO5/H9qY36rbo7pAuS
         pvpkcp1F4e4TliWuS+gbKZZt9oTIiqPUA+w/1cLnNNFt9Z2neiYDrJvHA9+VK6m54V84
         2ZZTrmVR466P3eyUD3/vwRGKfVyV3BLNBHaqEm6o+Yyc8iG0c1Qgt6rc5cBV2zcsY3bb
         f6hH6Tz8kmNv95yUPpNGvk8H8kVYEYZLHVK4wuKwVM6L2HsAe3chbrStRjDLayIuAqYa
         rvrg==
X-Forwarded-Encrypted: i=1; AJvYcCU+uKbmowzSiHdlYcPszIDesUvIOV/BAiF0GoCPlGsJFkYRNWlMLGvCHP04mcSnndg00IeHd2LZ12l2h0fq@vger.kernel.org, AJvYcCUfqzsRcF9yYbXAg6deMM5HfzxEVuZR6mxN8Ad4mN+nIGRVAvzxt+DwPlDlqJRH9XYSU+uv73aZ@vger.kernel.org, AJvYcCV6e/vNHZNYfoeglu309z8Mz01Pr0cbNiUVThmb0kJgjYK20mQ7WD9ayYm2vT1Mokgx/N4=@vger.kernel.org, AJvYcCVEKT7HFSCfvh7QMlMPtWPpXEzGJeWycgcuibs8CDngbYbJMGvMJ642hkWaBNLcD39bcIB50koYJZVsVYhcwb8c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0tmEsV2Xw4UCEOuhVZci5l9DRA6j/1c6cCz8FSTW35RFEttc
	80OSDOz/M2hfnHP8vTGkzaxEQ6oozF/gP4Y2qLrFKRTkIoYphnYu
X-Gm-Gg: ASbGnctEg73KFzL+KHKK/jkw9yO1MmjHb5ngPEE3arhtomLrWliyGV9dCF36dWqBx7S
	vhnozK02F0+OAjs+yaXVPe9eycbp2fawuvczLDvVwhgYj565MIN4XRn+NKfnIghm6R+YGZVzcCN
	mD9zY/+aBP2dcy3Z/xH5pGOJErSWzL/uZxKq54kcOt6Di8xVaoK+xU+VubpX6SrHfCkSes8zvCG
	D/IIUso8oUnk52jF3YA7ulVrS9FHowRhKOfReafQvIPyvyLkUFVEQ==
X-Google-Smtp-Source: AGHT+IGWJW1+Pwpvx67EW8U4m0L0clqnU493+l3wbL2x0EMI3Oje+f6Aw9Q0/lrCQB/2hhJyEiBupA==
X-Received: by 2002:a05:6a21:6da3:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1e1dfdee4d9mr7575951637.30.1734157082400;
        Fri, 13 Dec 2024 22:18:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bce8d9sm763149b3a.200.2024.12.13.22.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 22:18:01 -0800 (PST)
Message-ID: <00d01559793cb22a323ff8e800e1ed6e79163e57.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] bpf: selftests: verifier: Add nullness
 elision tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net
Cc: mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Fri, 13 Dec 2024 22:17:56 -0800
In-Reply-To: <c97b9ffd2042790ae6eb55ba01eae94282014006.1734045451.git.dxu@dxuuu.xyz>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
	 <c97b9ffd2042790ae6eb55ba01eae94282014006.1734045451.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 16:22 -0700, Daniel Xu wrote:
> Test that nullness elision works for common use cases. For example, we
> want to check that both full and subreg stack slots are recognized. As
> well as when there's both const and non-const values of R2 leading up to
> a lookup. And obviously some bound checks.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Daniel,

since there would be a respin of this patch-set,
maybe consider using plain C for some of the tests?

[...]


