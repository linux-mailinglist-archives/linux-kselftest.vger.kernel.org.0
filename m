Return-Path: <linux-kselftest+bounces-23539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D79F71C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B10167290
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428AB762D0;
	Thu, 19 Dec 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rff/IFqt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982A44C7C
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571756; cv=none; b=ukRpp4DunPoiV/2Fff/pH5inBIYy6rsohyVG3k4wVRzdSo9N9fXwZX4KJZr7gwnYY15OKJptHXOfTZXsKscuiCT7PiikB5tVKL7cXZbokLtuUm1jvGxfVRh4nYOTuVd+o5pe3FLETfFAWqX89H+aB8qZMx33U6ATAZuIzU+cFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571756; c=relaxed/simple;
	bh=ERB/InqNrOwq09Op/Lx2uBq1k/yU0va4/fl+tLa/WCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+oAhFbcHbnxtPVTjoLNdxxU1d83t35VPv7QYmev0fUfNcHSE/7pD4vwPeBA/+URc2kJP1XG4N/NXR+UMvD/xS6HUsbHzt5SSXvJpjZWNWR4IKv7BEvJoxwm/WNa3iRv77B4biM5Qy4VKtmG/WPpcAFIn0/4ihAXmJj3r/1pERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rff/IFqt; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2397f348-9d7f-4ea4-bf95-ed1452fa2156@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734571740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERB/InqNrOwq09Op/Lx2uBq1k/yU0va4/fl+tLa/WCI=;
	b=rff/IFqtZnRgpx/XATu9tsuV9CDaJ39WIn+PvEMsGkOjlmqbz9qmVxBlJ4lwe2IlIudjaF
	E8mpLFtGYwaNnkksnuaF9mo45eB0ZZyvvxUXQLX5qeu7NOgv5gfRhqoeGUES7hkeO7A8Sa
	3/NdUznyhtCGktMzouIbuj3Fsl/iSDo=
Date: Wed, 18 Dec 2024 17:28:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix compilation error in
 get_uprobe_offset()
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241218175724.578884-1-jmarchan@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241218175724.578884-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 12/18/24 9:57 AM, Jerome Marchand wrote:
> In get_uprobe_offset(), the call to procmap_query() use the constant
> PROCMAP_QUERY_VMA_EXECUTABLE, even if PROCMAP_QUERY is not defined.
>
> Define PROCMAP_QUERY_VMA_EXECUTABLE when PROCMAP_QUERY isn't.
>
> Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


