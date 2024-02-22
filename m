Return-Path: <linux-kselftest+bounces-5293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D085FC2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670911F230E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18214E2F5;
	Thu, 22 Feb 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H5McJwIj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C614E2EE;
	Thu, 22 Feb 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615223; cv=none; b=oOnWFCZ4tVTfoaO9JslGigjo8zYhdaZOCvhAAYOwSxgtY0MVY7MY6MLXcI0Yq522olm6E6ObRx9T5nbH7WDWp8cA18t2JOvlL+6NjhjRK4ZIExcBm0QTrR8C0xaBxiMeEbiYwy64QK3nU6xNjL2w7Cniz2z4s7TJkr3/hQRHCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615223; c=relaxed/simple;
	bh=X4Kj1vv286TquLVBULUsax02QjwWsQNi30yxsqIhQPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwCT8dC/y9Q73RCkviiJoO/7gKAqw5AgDSRV9rblVnvxboo96gqtKogmLilOXpEs7k9813eQV9odGZCgdF94h78HiA6JyMgkv72aTNicB8Ze9gBnWX+64yBtJXiUuOIeuCuaUiSISRvhn7ctaqkZTaasYPAfq0ZPbwB+g5Y31ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H5McJwIj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708615220;
	bh=X4Kj1vv286TquLVBULUsax02QjwWsQNi30yxsqIhQPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5McJwIjQnw3RcESyyMoyn9fr/QM1vfu9zakr568hU0QNItYGi2vYzB4N8+kvXNuo
	 R4AJUJiAdXxVjzxQNqKzKxYG6bYvCvfSaZCdqtDx8hmvZh2ODpjXQU2De9XT7w8FiT
	 +NTG4YVw/trTw1jnCzIWzsBd+xtd4ZszSWratz7fD/059GM16LCPO0sDzLHbLd0sMl
	 FlcFFnPIPssY/1cfGZNT2LBSvqQCZMzJLtKNR4tw0tXB71DFo65qoiO0FhyKB5N3YE
	 Ne208DI6SBfB1uwP8gK2bersm9+KrntwoZU0NRJCH54XX0ICVPBi3xmZA6HrJ9CCXT
	 +BG0cs3h7DxiA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEE3637820D5;
	Thu, 22 Feb 2024 15:20:18 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	davidgow@google.com,
	gary@garyguo.net,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	shuah@kernel.org,
	wedsonaf@gmail.com
Subject: Re: [PATCH] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 22 Feb 2024 16:20:34 +0100
Message-Id: <20240222152034.462805-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240102142514.174562-1-laura.nao@collabora.com>
References: <20240102142514.174562-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 1/2/24 15:25, Laura Nao wrote:
> I agree factoring out the helpers might be a better solution. I sent a
> patch to move the ktap_helpers.sh file to the kselftest common
> directory, so that kselftests written in bash can make use of the helper
> functions more easily:
> 
> https://lore.kernel.org/linux-kselftest/20240102141528.169947-1-laura.nao@collabora.com/T/#u
> 
> If that patch is merged first, I'll rework this one and send a v2 with
> the proper adjustments.
> 

v2 sent: https://lore.kernel.org/linux-kselftest/20240222151009.461264-1-laura.nao@collabora.com/T/#u

Best,

Laura

