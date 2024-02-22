Return-Path: <linux-kselftest+bounces-5298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239C85FE2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD90B28172
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CD153BCC;
	Thu, 22 Feb 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gRGphZ9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE184151CDD;
	Thu, 22 Feb 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619803; cv=none; b=dETay726pe1uq9kQQkPMbSp/INUlg+9ELqq0z5eOd4FUREYyUzB21tgU4LDtT2CAPlw5iANciLZAroI8XdN0quNFLA13Aq/8Arf7/coEtxzcTya5H8FtiosOYqPz17Rw1056gZ7sS7QpWd24lgpY0KoJWZykp/cG2gL9pgofXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619803; c=relaxed/simple;
	bh=1UjyE28xVYI4EPvfvdDQIEpLwLLL42qBXGYY3SOdliM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hll5StwC8Jr/9ZnorPhKJGx12+a0YW3ZkzE+8d1oI/ApJUsqaZSQtr6IVDOEZgpSkiQMgdb8eqXH95ksa7L3iL1wMSzPgnOryydXzDlh4ZDFFVLhd7oBjFqbUSu/VYj4EWhEIFiULlMW5mDlUVfd2xFJ7AApg+TbMVYfOqaQfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gRGphZ9G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708619800;
	bh=1UjyE28xVYI4EPvfvdDQIEpLwLLL42qBXGYY3SOdliM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRGphZ9Gv82qIuJeIVAWd7mhU5nCZUDNi28DE9l9qacer9gApCpoEM0wWyaGk9iTD
	 TBvcELjGR29JD2k4xVzgfZ4yd0puugYxdJTCwwTeaharrXxad6WR3zmN/6auz3wGyT
	 /hF6KT4XC19vI2BsdFPeZBJzcAIo/gLZVDcS2RtNraapGxB2sz8PC6stne1P05tQXC
	 keap0+aewbVcR4n/lvHfrnuECqst/AO2FE7E8lMs+9gSjz0zEPM71YocDsGYeUhN5o
	 Iu9gPhYSLSKI7DWUjdGDGA+FfzqElqRx/D0Z1s3LDy2+QZEuwXnadIsHD2SgnoPiFB
	 b1+ApZdT7k4sQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A232F3782082;
	Thu, 22 Feb 2024 16:36:38 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: kernel@valentinobst.de
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	sergio.collado@gmail.com,
	shuah@kernel.org,
	usama.anjum@collabora.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH v2] kselftest: Add basic test for probing the rust sample modules
Date: Thu, 22 Feb 2024 17:37:02 +0100
Message-Id: <20240222163702.499686-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240222155338.26836-1-kernel@valentinobst.de>
References: <20240222155338.26836-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2/22/24 16:53, Valentin Obst wrote:
> 
> Aren't those constants now defined in `ktap_helpers.sh` as well, i.e.,
> could those be removed here?
> 
>      - Best Valentin
> 

Definitely, I forgot to remove them. Thanks for the heads up!

I also noticed there's a ktap_finished function now available that
prints the results summary and handles the return code, so the test
script can be simplified further.

v3 includes these changes: https://lore.kernel.org/linux-kselftest/20240222162913.498197-1-laura.nao@collabora.com/T/#u

Best

Laura

