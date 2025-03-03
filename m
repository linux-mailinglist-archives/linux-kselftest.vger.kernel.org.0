Return-Path: <linux-kselftest+bounces-28051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58342A4C1D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1FF3AE423
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4A21018F;
	Mon,  3 Mar 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRtgcCPE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E078F32
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008243; cv=none; b=OgOh0Wdix9j+VoPc2oDCPzmVf83/XbSSnqNm/gPFCy0/Y7XtZYeDzv4HSVofwt75/uudRyzlTsx9Vh1Ibr5TvOfOEQxgzVpu8lrILrWWwuU06XSPutodxcEecS5siEp/1llAx+9+3cM+YpQ9YZtbhW1WYULhC47VJuGJkkCOBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008243; c=relaxed/simple;
	bh=IZ3D9lv5A0Jgf7RXlIN7/lGIafoJrbkLgYllyfrshF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyW+jNwaiM+yCZrGlNsjk56oODHtpYBq36Yf9bXqXFhiJDnVE/JXFA98b0McY/MXkRTIjaBq3zVXi03qdpyxyS+aDTJOyuormsHTaVPm5WvbaWj317pF0xONlWKb2PsFiIQ1NXBYVbQ9RUQqba/biEYUAfohMZG0rhOe1l/8Lzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRtgcCPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419E6C4CED6;
	Mon,  3 Mar 2025 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741008242;
	bh=IZ3D9lv5A0Jgf7RXlIN7/lGIafoJrbkLgYllyfrshF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRtgcCPE1gmlHlvzup38gZc+gf5jMajVbd+4qbU4svt0wH5ploEBusEBJJwhQjTdH
	 CDtSlYX70rc4GvCaW3RKQ72jSRiMKd0WDBvm8oBdN541xcnv5vAEEZKmvF5KCuzTIi
	 pZSX5yfrij4d0JDJjS1XRTkqx2F4FqY6nlK0CVYtBUxlgdpbYZPuYI2UyXVipaSPp4
	 zgRk3DOBKNGZL0RccdSFaZ6h3T6wTNeKxftm+faSnbcp/AWa1NhEnE52IuY1gQhoFl
	 x7JWR2/z3osPHHz6dH1IxZ9ef66NX+wGAtgLnakfZWYEa6ZNurelJWBMERAv8gPqp9
	 2zkqbuR/Dgm7Q==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] drm/tests: Drop drm_kunit_helper_acquire_ctx_alloc()
Date: Mon,  3 Mar 2025 14:23:58 +0100
Message-ID: <174100823623.41136.20409706387741750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220132537.2834168-1-mripard@kernel.org>
References: <20250220132537.2834168-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 14:25:37 +0100, Maxime Ripard wrote:
> lockdep complains when a lock is released in a separate thread the
> lock is taken in, and it turns out that kunit does run its actions in a
> separate thread than the test ran in.
> 
> This means that drm_kunit_helper_acquire_ctx_alloc() just cannot work as
> it's supposed to, so let's just get rid of it.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

